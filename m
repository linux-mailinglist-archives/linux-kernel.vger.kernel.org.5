Return-Path: <linux-kernel+bounces-65055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBB854734
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C47B2719D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DA1643A;
	Wed, 14 Feb 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b="P7uy1aO3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A810A3C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906898; cv=none; b=lzrWbfQ9VDbTqQvZ6Fc5Liu6QjVFwur/SAuCB/0yp2z1HAYeOWTmWGZg8S8u7lTxF579Hjjt7BNLY8hDE+S7YapGAAUJ+CCIDKg1EY3zvTHi+11mCb1oovv28caotMLZZ/ZkQPRlY4f/1ZEqWPZO71MF8Lyr2KBdHARUmPmtp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906898; c=relaxed/simple;
	bh=wbjPOlP8cdqurBcP+Z0XkFrHb9mtDoRebK8Q/r9vXPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5yek6BjQjuzGMuAV3Ga9d8WeroN4uJM2AALkuyvg+mv7JXH3T4zPNA4Max2p8b45EEaplZ7z+CRJ5KsyU4cQ8zJN4dQW5tkdexZe9xkHKG15w/eb3IeyVLVCVab6qfswPA7hLYSRDSRLJrT/z7+hMYsMUDft3TcUu7ENKGZOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie; spf=pass smtp.mailfrom=conchuod.ie; dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b=P7uy1aO3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conchuod.ie
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ce55ab993so439669f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google; t=1707906894; x=1708511694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXOXdlKbQ7b8gP1IjielEHY25ZzqNlF3NYnAzC4w8e0=;
        b=P7uy1aO30lT++dDhT9U4L55OYAIlB9jV8ym0OfgLDDqE5E0fNTv70hT+lxfKxxJ3P1
         Os+r0qtPLJt1pFXZSlTW+/pIfc+TO/GQeMxybprhZFkZ5eWiOwEFuBfUJssexRfUwIcs
         kaFAcdEPsztNquhZ9L7gwLIhfAROZmMyQsl6bCGe1CPcP8YaWnvSTdPfHar28Bzuwn7M
         B8M3gRVNefQT6NbO0lk9K4zQORJ6/uRJxjrx9TUg71qDiMEZyjkFbFkm++y0ZOGIhVd6
         gr1StJMytzDGItyqAGpWF2AhcWEtt31vp3k7UZuVXCwnBCdiFfOYUpGBNBP07Fk6SEZ/
         goyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707906894; x=1708511694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOXdlKbQ7b8gP1IjielEHY25ZzqNlF3NYnAzC4w8e0=;
        b=uIWKw9stSTDNGy4Mij6+TjYlo08jxP/gNB5b+nl1fMWzxJY5obIj7aaqXWLedq8FMs
         AKD6KThfjFf2VSncZri+JsFOpLr8aUwTlUIz0qANFIorHYkzSvgEFOT5ySwdrMSdVFQ0
         wO82/ELogdXNvY/j5g1QiEemiXcvs4BCsqif3/0yaMuOq6I3oemBKs3yp/tv75vhSUeS
         tKUP42mgzlVBDA47kfyLhTFB1g0PHquQDaHL1s7rDrF3WNFaHvYLY8mcs7txCzNPzGv5
         u+bDwwuYcccoFqEGpNDn4DGJ5i6g0B9E1mxz1Kaqq9slups6K/MJ4HRN2UMp2LwZC+zJ
         n5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWnADqGdk9oHATSvnQyD1AciMNDgQiySznHEgmMZ3fmgnErxgY97D2xaTctVf5GojGuHTNQyQCKF0TFSMs7B8R6pMv6XEvE6E0+49oZ
X-Gm-Message-State: AOJu0YxRjWMxVYp5UIc68HrLKldVH73/VlpHtIPEh8+TJvOfdwTviL+/
	+qIK0uZhuXu6ZS2jfaIKnhQyyFkURy+EJoquTVxG6qi48D2ZH5blB9VY0caO3lSgrKEiQe4Cbia
	P
X-Google-Smtp-Source: AGHT+IFEPDAfEvDMu8J4XJ0lQXp8hFlITdGR9tguh8nJGFpjGxYLL/K/WaEm+SnPqS0/z0r/zmKOew==
X-Received: by 2002:a5d:50d1:0:b0:33b:433d:e1d7 with SMTP id f17-20020a5d50d1000000b0033b433de1d7mr1515184wrt.1.1707906894167;
        Wed, 14 Feb 2024 02:34:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV74FnXZgGq7FLgYrggZY2ycn0bi0uPib5wlWD/R5foh16pmW1mMSUZ8MKgolPvYKxbwkB5Tb2ORQTJzTyV6tnIc7dMp8C5IgUco11J/NRLki8V5qTDkoQzUYbjkZ1A8XE/NDvqGTXJn1Gmb+9TCsy6xwZsfB6E+eOZaCgLf4p92JA+RaN6XglKaS7iO/FjueR2FKEQMp+V+FUUO/dThdc=
Received: from [192.168.2.9] ([109.77.20.129])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056000080900b0033b75d0993esm10923171wrb.74.2024.02.14.02.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:34:53 -0800 (PST)
Message-ID: <4cd7cee5-7943-42eb-bd26-c0e782f29a48@conchuod.ie>
Date: Wed, 14 Feb 2024 10:34:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: use KERN_INFO in do_trap
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>, Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org
References: <mvmh6ic1y75.fsf@suse.de>
 <20240214-exclusion-pluck-fcb6352a8393@spud> <mvmttmbz781.fsf@suse.de>
From: Conor Dooley <mail@conchuod.ie>
In-Reply-To: <mvmttmbz781.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 10:10, Andreas Schwab wrote:
> On Feb 14 2024, Conor Dooley wrote:
> 
>> On Tue, Feb 13, 2024 at 10:59:58AM +0100, Andreas Schwab wrote:
>>> Print the instruction dump with info instead of emergency level like the
>>> rest of the output when printing the information for an unhandled signal.
>>
>> I'm not entirely sure that this is true, __show_regs() prints with
>> KERN_DEFAULT, but this certainly is more consistent than it was before.
> 
> The first line is printed with pr_info.

Yah, that's what I meant with "more consistent" :)

> Perhaps __show_regs should gain
> a level argument.

I wouldn't be averse. There's 3 users, of which one is show_regs().
I think we could easily add an argument that sets the printk level
to match the other outputs from the non show_regs() callers. I
suppose show_regs() could retain the KERN_DEFAULT behaviour unless
you've got a better idea.



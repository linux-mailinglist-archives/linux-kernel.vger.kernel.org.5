Return-Path: <linux-kernel+bounces-148768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F88A8724
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF632B2717D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE69146A88;
	Wed, 17 Apr 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iya0By3K"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4F13959C;
	Wed, 17 Apr 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366771; cv=none; b=lanSa5Tb4QifFOrTCp5y0OEkD8RazuNL4dJh6lWiGB1nc3SF1o/cThF961XZI9zFi00bO+m07c6JjjVMJy21RSH5uE3K5C+QSex+zbHhx4kLf3SgyByXhIKhICmQ/B2TlmOIxBNKE6L6/hgoR0JINp8XDLBVJ3428VjgGEQMHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366771; c=relaxed/simple;
	bh=SbS9sbvUTV9VYHCOQgg59EfOF3qI1Jv3FdNGo46zwRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD//omjM9wHONeIOAFBRxTqDanNcxpTepkW7Zh4rRwrgPa5nbl6whHbzRQGEKVsgXgoyEFt1+gZNTlMJ0wZUq/mtQ6a88eJ7taFy+h/gUKNIIx/xtIzK1z1XMaHLmcYVBIRhRjYFu1lRo5vzLrR63s5kfcDSywB2+Z7G3cdbJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iya0By3K; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f00cd23bbso15377885a.3;
        Wed, 17 Apr 2024 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713366769; x=1713971569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/Kqg25OD7el4VbnET2f/iEY4sym/XMc8MT/TsAp6ro=;
        b=Iya0By3KJnFwOCE+Qd3wqGOZicyzPVjH39i+LzX9C7Q/ggqAhyZ8VhgHyZ/hANtkQ4
         9O+s8jpjAptQA/otJNCrx3YLKmpn5osJUNBhvGGMh3BpMBYbYMynaqUBZ4bhy2kWYTb6
         BhVt/WEIMXV8nUq/W5yL3ayw/8WJFSNXCfIm4YQRzEDvHzFmzfgXyO+dUi3z0TUoEyzm
         CVllldA1C2Glbz35w/mqDj7LdxgZJAtM/XKOUB4WTcKk1a7zUCOpt5VppCehIiIGAqCC
         hAOPJMNvbtrnKu6AugrXJc1sF/dwNEasOjuFEGk2AB/B8C9S+P2YQGJ+QD4x325T0WFl
         /+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366769; x=1713971569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/Kqg25OD7el4VbnET2f/iEY4sym/XMc8MT/TsAp6ro=;
        b=jFy644Acr/nHdFKsPkrKR7itdtKIEjFNitlxDzCKktNt48k66X0W4y8PNcHKsJR2p5
         U6jUbz/2njsk10GzabPNe85ykILVLD0Ry0sclUzR49hi1jv4RZZB7PxSw3Y1xvGDDGtF
         Cnf6Vp4Vs/e3MOdIqkJ5xax8BcsFlDQAswEMbYJQ6vxskWShjaFqhrJok9VggW3opsvK
         yMgg5g3qgpq1PzIwyfbK9ZFm99nfViAr5JgRNA5JOuW5M0fsLPd23SiuDJzqF8gZrXFi
         IDb9Gt75eLeC5JbzvenSbJK0Qfi/UO9FSCQfH+2CemRZCe51F7ZtaEX/67DfbnugmUFq
         8YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1KOfyo5i1aKjjBc/8MJd7DOzAbhS17/alavndWy+fnKC+uGkKlkS+xug+Sk8gMRRTHCdaZO7h5T7U/ApUXHZ9NBeK3QIQpUX9HnIUkiy8OqxnUw28qqpjWRmWI4vdu4f7IHKt44GCwX2qmhlg
X-Gm-Message-State: AOJu0Yz7LSr09WsMa5bi5Ope+iEn7w+vDkJ6sWkzgQ9MmonfzZGU9Occ
	evRXT3oqZscEgihPsXlst3WsN+N62Xt+Eyb5sX4eKRgkhnwZrzBhDcHMrA==
X-Google-Smtp-Source: AGHT+IGgXCPX4SFSX0LoPWrYdzcEVAKN1ayBc3HBTx/9RXK9xl8obu1EohtRCQkoPreDBhZGQsQyDQ==
X-Received: by 2002:a05:622a:58f:b0:436:7545:50f3 with SMTP id c15-20020a05622a058f00b00436754550f3mr18868247qtb.2.1713366768865;
        Wed, 17 Apr 2024 08:12:48 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id d19-20020ac86693000000b00434f6c1458bsm8142169qtp.17.2024.04.17.08.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 08:12:48 -0700 (PDT)
Message-ID: <9f6d22cb-2170-4b80-912a-cfee18381b43@gmail.com>
Date: Wed, 17 Apr 2024 16:12:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] string: Implement KUnit test for str*cmp functions
To: Andy Shevchenko <andy@kernel.org>
Cc: keescook@chromium.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
 <Zh_cgnMOFHuP-lKu@smile.fi.intel.com>
 <10085ec8-0109-444c-bce4-d0b0ef1a4164@gmail.com>
 <Zh_ibi_Y6xogktg-@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Zh_ibi_Y6xogktg-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 15:53, Andy Shevchenko wrote:
>> There are already 2 other KUnit tests in `lib/` covering different groups of
>> string functions separately (lib/strscpy_kunit.c, lib/strcat_kunit.c), so
>> this patch just follows this pattern. I believe it makes sense: the tests
>> are separated to cover one specific group of string functions with a similar
>> purpose
> 
> We have handful of the string functions, are you going to have a file per
> function? Isn't it way too many?
> 
> P.S>
> Having those does not prove it's a correct approach. I would rather expect
> somebody to incorporate those into string_kunit.c.
> 

Makes sense. Also, probably having all of them in `string_kunit.c` would 
fit better into the KUnit test style guidelines.

I'll merge this strcmp test into `string_kunit.c` in V2 of this patch, 
thank you for the review.

-- 
Kind regards,
Ivan Orlov



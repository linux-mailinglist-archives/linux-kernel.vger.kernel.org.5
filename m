Return-Path: <linux-kernel+bounces-62175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F706851CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E857FB243CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270C3D998;
	Mon, 12 Feb 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/9hmkyI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AE3FB2E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762409; cv=none; b=rZPhMNcVzD4UHFZDQ5x1icqFL5lKunChs5hVq39l++Tn+oUWkBCDWFCnvtx8LMlrn0NQj0P6X1KCaFTKC6kDagH1l/NInfApJABB7XVm1c+hmqhbS+C/6lcweq+4dM7nNL3SztertsiPd9GW305bO5CAvbYXLjD6r2kHxB8KoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762409; c=relaxed/simple;
	bh=Pry+G7WSAZZaRL4coVL0+gsr6B0HPSoXJPy1RuH9m9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3XjfcjTlaps3U2mbshGt0Iq5ZwKajUIBA7d9pMll575/KNXTEOW/ML5bp8XYRDJLjKrO2iT+EU7ZLuxl3R5uBoTMbiOpVabRXMYCbV5iH6zQ2UMSL2qm7t2x2bIYME1x6IKyw78X1wAkF0x/Ckb/hvkV6hLueQaI2e0xEAa/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/9hmkyI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8aadc624dso25608435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707762407; x=1708367207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fWakcISGbUojOGcrNAN739uoQIinJaHwicVnHyikNI8=;
        b=i/9hmkyI6d2ElL92vnYpLyXKwA3m2/QNx1O4waaG/c7IGvkeP9sGeuCSjrEOWatccQ
         DvvDQeoXQmZKg6bcET9Fko6gb1/4M/3MPkLrUCXr49GCDJ64Ux/EY8UPu699HUFdXDzs
         v3rwE3Km2K7UOW7N+W6ZfzGW7cKiJhecu2oPHrul87nLaDsL5RI6xROwNz5wFvOijTJ9
         qEt2WbTOtPMDijfRFf9aWl+EUkNPHcu2MwnMfdBoU61ABKLQnNidv5+a5gjGdZ75/jfx
         mqi2XmutSxYAh9TLJ1iv6qOx2GbMF7DDVjDzxjYjg3tSHYUgvhvJwaiuK0/rsMYIuasY
         1Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762407; x=1708367207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWakcISGbUojOGcrNAN739uoQIinJaHwicVnHyikNI8=;
        b=Y6BAY+ugbQ9HXCL/oSD7Q8ia1gN3HdVIJhT8/qd81fcDwaKmiW9rG9qUtWr0OGWYfV
         BncyK9hllXWVhvBUrPgjKfFPTF0WfAK+bbc7VKY1mR23kCsccJW20XcZ7CY3Zd9tmH7v
         vKCigJOcUHkPQ61qJWcZtkR3jpRdRmHiL48MyN6D4kYZ23LNOvHS9cCWY4PjbKpSPeZh
         AUUTY/Chn8preTxd3bdJY6EqLmsy1EGpvA6jgXsF3EYA9/84yWxizFs8J/tNim/joSB5
         7UbP2H4/uvAhRl7CsBWMszQVuxNwTFjkWo9b5v+alORfl49Oc3h4MudfwikGieI9JHUf
         6Rew==
X-Gm-Message-State: AOJu0YzzACqeci7cniLpr5PkPEXq3p6qUkGLbSO/et9jOJr0pGDKyz9r
	N2r/LSrtwx6wIsE66/gC1EWOQBlV+7N7v7xKlSj+6/vI26/IAMfF
X-Google-Smtp-Source: AGHT+IGitFw1qH4Sr5khK0PRo7R34TS2nIfGdDW8+jVwJCdjEtr2bqbfja2NLLBTk0mD2V4ct5sLQg==
X-Received: by 2002:a17:902:f552:b0:1db:28b6:cb3b with SMTP id h18-20020a170902f55200b001db28b6cb3bmr1272639plf.6.1707762406780;
        Mon, 12 Feb 2024 10:26:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGZ14RTMtbXhUBCfnPCij1oE21n6EERFwYOfwurw9C15OUMzb5p8zj5tMRgP6ewNxdkAdCYMlDFXRl4inFHsT7peKhX67pgscujmUT8vzSX+hhPTguBtsHFZFcR07U1PkjM/D/NbJAXzVkGhxA3qeNAwbsDmiERvXYuSunoZ+msaKP/XvY/bNNuENdJq+VXR7I8Zlp
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001d94a461d2dsm656079plb.73.2024.02.12.10.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:26:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1302af8c-f1b7-4015-8655-c7fdaff63d69@roeck-us.net>
Date: Mon, 12 Feb 2024 10:26:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Laight
 <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
 <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net> <Zcpe2ZthpFf1BVGg@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zcpe2ZthpFf1BVGg@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 10:09, Charlie Jenkins wrote:
[ ... ]

>> Almost. Turns out the csum parameter of csum_ipv6_magic() needs to be in
>> network byte order, and the length parameter needs to be in host byte order.
>> So instead of
>> 	data.len = data_ptr->len;
>> 	data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
>> it needs to be something like
>> 	data.len = ntohl(data_ptr->len);
>> 	data.csum = data_ptr->csum;
>>
>> Also, as you mentioned, either the returned checksum or the expected
>> checksum needs to be converted for the comparison because one is in
>> network byte order and the other in host byte order.
>>
>> Address conversions are indeed not needed.
>>
>> Thanks,
>> Guenter
> 
> Aww that makes sense thank you. I was reversing everything except len
> and the solution was to only reverse len... Thank you for figuring that
> out for me.
> 
> I will send out another version with your change. Should I add a
> signed-off-by with your tag for this patch?
> 

No need. I'll send you a Tested-by: tag on the final version (if it works ;-).

Thanks,
Guenter



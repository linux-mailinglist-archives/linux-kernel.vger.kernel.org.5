Return-Path: <linux-kernel+bounces-103787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E29D87C47D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149E71F22A33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171C76402;
	Thu, 14 Mar 2024 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRgui8I6"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96069763E4;
	Thu, 14 Mar 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449745; cv=none; b=sx7WhWnN2jbnNjPd8nP30KJiHntrmua8ecf+CuRw4xCMraez/OQWpUP1B7W+3kz2TsbxVijl1B5LnlUmsMjAnLxDkhiEq0VW5XOoQEboMoJNp6IiNKi4TuydJk8+fFeX8EO0gFfq/f1+6R4Vq0FFINZ5DLU08238B1IyGRvvRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449745; c=relaxed/simple;
	bh=leChC4iqFlmyncIv6yWpcv6stLeDV7HVt5FAasiYsFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1fp4ZPwszCFUmvEhPo2ZV+0VDeOKk9uIg3Y6yyp9PyOI1zZ7ddQaNDNfHoiKCHqQCCr5xONFgGqoJIF0M6JqYe5smh1GsAhsr3CQF25ID/74E3XcICisz/JXo08N9ZDLQ0wTjzRZUug1i4QpR8K+WSo6ayaHRMx2eTDh3Z4SJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRgui8I6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7882b1e87c4so64386685a.1;
        Thu, 14 Mar 2024 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710449742; x=1711054542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2hH7wI/Wv6rH6juPrsLHkKZoPg9INZ+wf6T9UE0WHA=;
        b=ZRgui8I6dR6j2bfjgE3Shf5fT/jzg+MWvZNK6aIL8VPGoQVROP317ooU8F1bAa4jGI
         m1gEhIzf+K+k+7Sq/pbkeZ6vu78QWHGqZqb1pa22f+BQws9fPv8z5DA1Lfvb2hbO9wcu
         TyPA1SfGxDeMcYlP0Kqeaxl7uIB1j8tDWA+cvWpUwXeLrJHi7nvfhl4qs2KWJdjZYQz4
         udImYoiytluAd2fyCd2z30Y7oFFzFvYqZd8jv4/sC1ayxjdo/Qsmi4Ar0rVRsV+fn0Ow
         c745jVkDxMEifxVqQdw8b/4h0CsTgqQMALs4XVFV/9iOEDHmju+ZpFDgZgPgBRyoWE7e
         I5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449742; x=1711054542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2hH7wI/Wv6rH6juPrsLHkKZoPg9INZ+wf6T9UE0WHA=;
        b=fBKiu0vxhUYfCmTk/lgvdfY9cPUjYC0oiKFTSwV16BJo6wmpOjy2G2oIoJprk32z8t
         KiCHaYskthWkwedBpv7vxsy62A42s64hhcr/fKV6PRTCYPFHPJ/26xsGQSYderJ0YQCd
         1q2KWDtScRkA4NqzKLFWj58AB2vQhzUY4yt8m43imR5RyL7VbNgCeksrhVXKcTgeirCa
         /LOh1ty5ewiPGfPCMH+AOIjG7f1sUdUSztCWS0r5uZ5Qdv9g0vRyVVoESoj2dDaGK6xs
         2qHTPv2vCmlj/vlpoCLt0Qk4vIieDad2De1/ykWXffgAe2nCbAQbj9Y1+UpKGp87yReY
         iYdA==
X-Forwarded-Encrypted: i=1; AJvYcCVIqi9S5oEoijvrE95pko0Z+O+XS/xOClDJ/lMeAP9VD2zv6vin0pYcW3+T0xIrLd+IiIJmAJcIWYES90ZEGssXM0B5wg8bh3omV8tBgePTtL0JSzSboXjt9VC40oDsrFsFIl5c
X-Gm-Message-State: AOJu0YwLlV5nNcctxvmxQOvSLhDlIwwc2SwoG3U5wfwfN25Sm+ItQKy7
	3FnO5A9NJzNXZC9zaVuRqQTp3WAIkSNsnrASX05zBdCtZPazwFn7
X-Google-Smtp-Source: AGHT+IGkuTis3za+16XYKofdYTyfSTtqNl74hEP8lV9cKMUYzSCNzFUD8Ck/0Vkgt8usBV22cx8rBg==
X-Received: by 2002:a05:620a:3b8b:b0:788:2357:6050 with SMTP id ye11-20020a05620a3b8b00b0078823576050mr2105253qkn.73.1710449742465;
        Thu, 14 Mar 2024 13:55:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05620a414200b007883c9be0a9sm1247537qko.80.2024.03.14.13.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 13:55:41 -0700 (PDT)
Message-ID: <b556d988-c3e2-45a2-82c4-b5ad243d474c@gmail.com>
Date: Thu, 14 Mar 2024 13:55:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163707.615000-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 09:36, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.21
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



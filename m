Return-Path: <linux-kernel+bounces-36156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF27839C82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D17286236
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008E53E10;
	Tue, 23 Jan 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRvL/T77"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761351024;
	Tue, 23 Jan 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050227; cv=none; b=CrrM7XqXWqCFvhXJR2U+fT2uRG3/Ou/zjXjZlZOy6O8KZ9e7bmyZBK/Dr5WU8KUciYOjSzMRSsSPHjVOtZvDVdkxWj3zDP+WA7gMrBynvhBTL4RAvJph7mTDzqO6L9bUlMBUDQQ6Omb00eXrNXt6A9chERH4r2qBidt8ib6xc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050227; c=relaxed/simple;
	bh=zA8h2hgvGIm7xCc7pkw2uK7so5TYfseQahtnnzFpgFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X58hGNVOFYdcHob8YCZ3NyII0ncZcH4rjAuiChyoRfbVFdgaSUjBOwlIZ3wbX8/K+4Fsb5Le8wSKF7eLYcSkSfSLbo14NFY0jgEfJ8upjYBskyHw2KqpFyMzqUB6vjxWpVYMwpsJY83+wjdbwL2sn+jV2D/uypNM2i/0nVV/PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRvL/T77; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429f53f0b0bso31901891cf.2;
        Tue, 23 Jan 2024 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706050225; x=1706655025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70lzYBb2kXF1e/6clrMDT/m2Y9gDx8gUW5Ok8l0+bHs=;
        b=BRvL/T77FjH3FvYeTT6FO+s7x+mDbaqr6XKqCr1vQhowmgUMy76osWt9YabuPdUOpZ
         FvM3zp5FaI5i0GqbxKCT7p/kuIVzmNcUAScdaNjNwuIPIYq/BrPQmvisju6An7xknjJk
         xh9/HGK6AnEqn3IDUHZ9BPmcR7VrW7tmfYbITxEmVhPdTEClr+7Ghscs8ratpdLfv/E0
         vXTDMdBf6Tt67akNYntVN/7IUJEw9w867NtclVq4k63XbZxYWeyhFt3t9WrBHfQXbNmp
         RxdBD0ffKS9utpV+KQBfx+XWhJF3re1O80qYg2NkTcOaVsZljmLJpbGemfxZqOrDnjDh
         EVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706050225; x=1706655025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70lzYBb2kXF1e/6clrMDT/m2Y9gDx8gUW5Ok8l0+bHs=;
        b=PCtank9mtRYlsJhP7256YKK38agSHW8wPzKcKajYVGMlH3kduRnvM/2Rr1PlhXl6h/
         Iv4D00hJeYCfmGJ8jJ0guvxXjoGIAQclFjjrbX6V5UhSbqSButSNTnpfonS+9AeWCAF3
         NwlQOsKBWW2Y5u6E1nSny955jGlOo+UwFyqcJFF7jn5QZLEW4tJZFa7C0Q2VhONmBaEn
         IFR3MT4f3QvUc00u/YA/5kjoT94ThHF4ooqbGL22P+DVP6Pvu4p2nTq1mWNDKAtYvsE3
         zhSb+hMFoSwA8hbiLwyxoFxvCEAwXLKOxGIQgZz7s1AT7z7r9qfU71djOHWb9ieM8UZ9
         VoNA==
X-Gm-Message-State: AOJu0YzkXIoknq/WGI1FmajuJseknJmldBVVG8NaW6U6+CbDREgiaqVA
	oLBWz3THpzByhM9EYS37IalnQBb9UZxdHDb4lrOu52+BjhG2iccl
X-Google-Smtp-Source: AGHT+IHsqpQPGlTs+KXEhp1WVTBfD8OW9Rc1aNAYsdwz/JyF964LUi/EdJcqSpaYwrgcNJ/UU8e1nw==
X-Received: by 2002:ac8:7e8d:0:b0:429:bfca:bed0 with SMTP id w13-20020ac87e8d000000b00429bfcabed0mr1489145qtj.137.1706050224679;
        Tue, 23 Jan 2024 14:50:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bp44-20020a05622a1bac00b004299f09e3aesm3863091qtb.51.2024.01.23.14.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:50:24 -0800 (PST)
Message-ID: <840d1ee4-6ee2-4fb3-a604-cf25ab83d9fe@gmail.com>
Date: Tue, 23 Jan 2024 14:50:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174510.372863442@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



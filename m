Return-Path: <linux-kernel+bounces-83905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32666869FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0241C23CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD751C3F;
	Tue, 27 Feb 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGGEWki7"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121551031;
	Tue, 27 Feb 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061241; cv=none; b=LwRPAAwXM4Y30sm1aHyIq2pnRiFZI1m5/1Q5ie29PHF4dWl8D/nxNq8WhPawHcac0Eox5hQD4xZK4I6jQdGYTuk5ysuJlXSOLKQ0lQFY0nsP2xf/EIVRHOIfb9Y+SBVdcHRwbKMtLgfq2ZagkegYFj8Mm22qxLtbnHOKYDuTRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061241; c=relaxed/simple;
	bh=7QK+qRGhKALwTIL1s8MwpXOMEdAMUmkicv3LmVkCxfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1tSyGrriu6pYHD+NxbRK4SyAZmzLpAoY+bqoSxXwy8I/MxxbauU9qCYMvrx6PgWMUnMsCxxZ/mFnP3lE9x+Uy2JZzTr0EdeB3ZUef2V7Mk1DaBX3xLhlakiYCL/yh1pEMveZn+UCcSi0hilhZjk2UGYp6gXMtpdsePk9beYaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGGEWki7; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21eea6aab5eso3250180fac.0;
        Tue, 27 Feb 2024 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061239; x=1709666039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jkcY+3vqHfqa2M3gpdilByY3cOfOEet9u7bgowP6xs=;
        b=fGGEWki7k3CHw0pfgFmxfbN6KiTJo9/wMXGv2EAcn4WvZjM9uPsv+uQTWE9gAefRjU
         UCd9keLebagt9rOtZn7pHbzUdpBGyCKkE66nk16E2tbH1hL0s1tIEU70lLzSOoeNmfHR
         vkT6l3SxvJCX4N6ds3/632efWyRBHWElWbf+35/azY1lBObFul4WWV2F8x/tuQozQvP8
         hukeM2v57QOTzTr0I3AR0IJlboiHxC6VdVxB+V3k8gPxMkRM50dFxWjGU5NSw6RUNm6s
         zFRmkk4HvGFnONfa6scC2ruBLXhMP1LEtZTMyDahxVJE0asBK7WRaRS8zmhXEhnc0pap
         CiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061239; x=1709666039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jkcY+3vqHfqa2M3gpdilByY3cOfOEet9u7bgowP6xs=;
        b=XoiY3chgpAhpGe++OHSX75WadfHVtkM04WblonRS0FKzMFIa8GXVcVfTr40bTlewls
         OUXA483sYPxEbFCoCkpryxX95BJoF/5OT6cMGO6tSORlMwQnqMgXgCQmZ2WO5IIo/qJA
         l6l6v7n/hFob9Of+tirWd3kCzIG/Ux4oddtY9IQmlQ93vo0ThG7MeRUntvleMXywCPmb
         s2ButV0531GYsvjVkrKzJKhLMFNE6Df09ZFivLgJxkTyf1H9x4jzziDguSxhE3GMsGB6
         CplhQAfTpWy86yLNeaNGb8QEFnhyX4cyz7opADxbNMqtMHrdaPdK8s0EgjL1a0yqRIsu
         eugw==
X-Forwarded-Encrypted: i=1; AJvYcCX8WOif8ZHAQ1IxU19KcWK9YRt+Lf+n5nTbKADtZML7/7w04/TKFD3B30EEw5fVHH7BScwjDAgNr9MUYg56fBYizKt72seP30YTE9dfvxoGdOt2OyDTLspmgCTMwdYseVIrxvQk
X-Gm-Message-State: AOJu0YzGLYxLmUTpy+jB3Ksy2yfdGOdYNV7TyG9ypziK/9a8PZ8v7MzF
	oNiwP6l+PHNI1LOqATpQXkMecr8a2GjZNtUPat+nawvuS7Q7rFqj
X-Google-Smtp-Source: AGHT+IHOKJCEZ46w94XMxDehR4BP6w61b1FZhIF6WatH1NeU8F8IaplbBjBnSt6osYY4USyHbckfzA==
X-Received: by 2002:a05:6870:2248:b0:21e:bc5a:963a with SMTP id j8-20020a056870224800b0021ebc5a963amr13926749oaf.34.1709061238624;
        Tue, 27 Feb 2024 11:13:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g26-20020a05620a219a00b00785d893a692sm3851374qka.27.2024.02.27.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:13:57 -0800 (PST)
Message-ID: <896ede4b-8dbf-45b6-b5d8-7be364feec51@gmail.com>
Date: Tue, 27 Feb 2024 11:13:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131615.098467438@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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



Return-Path: <linux-kernel+bounces-30525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C12831FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744231C21A44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D42E635;
	Thu, 18 Jan 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf5BUayt"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465D29438;
	Thu, 18 Jan 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607470; cv=none; b=Gifnecaj33Z+NOoL6XwvN0fvYjPPELcP1qMFEupD0QhxDWcmLSDgRDC4vDOtIM6CMXd2mjmCjn8nNBFcprA1FHgp0OEqMpUkqr6ZuA0o6c1AHf/t0qcKR8aBsWrU4NAq6Aa9OwtX0rlny7DCqePI/f3tcaIz686lPobjY2WIFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607470; c=relaxed/simple;
	bh=zpB1vJKPFUrLosU/KAweJYdV+HjG58GHXZeRiTmNml8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMBNYuevx1uIjfknaxC4c0oOHWM1/2gvc02Q83xGkmGPiksirZbmNbsJUIE8HvOpga71RyaCFAXCm3/uuaT75iR7WkLpVnyN65oBKsEJD93i6tKxlZpfqV5QMbp++b5oPr+fryRS4IG9kCWoT+Q6ho6OItJrCbcTp1XJZ4SgqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf5BUayt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429af318342so356601cf.0;
        Thu, 18 Jan 2024 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607468; x=1706212268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTvQsNfYLosp4zMJSEtUdKK37sRRAVysKUE3QZOulFY=;
        b=Vf5BUaytpNyv8X8NJdmPAk1jwzR4pztTa9b0LqE9F5Buw6maMiNZN/V4ID4cKsbOqH
         H1xio/zgF6AXByxnraeRhxLKibx1J/vBQpcyARnKZ2UHj6tQOk+zU/5Qy75udcAQhJBd
         L7n4S8eyG2ppsnyqobF+MxAlDQzTcd9wsT87ik0imLO6lTVaUbu4/l6jGEAA99BcXSxy
         6ndPr8bMM70Sm5PG8WCCLXge1Ht8oRkHI46vmSXf1VAdV17+QcTZiMNuhND9aCXHC9iV
         dk0diyTIBdnax/8wOYZu/u9JVPQ8/dS4JOtcvgI1E56q7q7xvKKL2zNQHoh0mcNThF2Z
         lxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607468; x=1706212268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTvQsNfYLosp4zMJSEtUdKK37sRRAVysKUE3QZOulFY=;
        b=AbjfA4K7tHz7+sD96OjbQCyG+U9CPjkRgR7L5IXmxzidp+n7KKcnyYnauvzPN+H1O+
         g8RVPF4paLx/JT91GukC3/lxVnAZGqYS3icRQChbicFo+6doXZViYU+ls5Y0onpwYt4J
         f0p1mRqrLyz5xk4lJ1+/7shunXEgphpyfj2mDLnYeungSqfLzUE+dXl9iN6Wg46o+3SL
         h6mej64w2ijhefOCoIuT7DejiJARRHPqFF5w58rb0FAHBnwQvLTzHQUYzJWae8XSeLFo
         h+lGA7fZ+ah3iGeXy1Lv1zS1WN3o+Gf64+aFmBObsDfxxNwYNcsk4t8wCoshKC0ubkJh
         16Ag==
X-Gm-Message-State: AOJu0YwwS0Z4nkepRtBM10g7LR5yDtEd4NvA5tB0mupeGxgmI2uBwkkS
	DFpesGFoMTk4j/7BvaDGWkMpWBV1YoM3Ttc3S4ULrodg21IGkpq2
X-Google-Smtp-Source: AGHT+IFuzwMJ2IKpO0vPscGpujBJTJMHffiNlful/2XZ3SiEHAezwmJr9V7vyeM/KC94kkWc9UiFVQ==
X-Received: by 2002:a05:622a:2d4:b0:42a:212d:4a30 with SMTP id a20-20020a05622a02d400b0042a212d4a30mr494962qtx.29.1705607467542;
        Thu, 18 Jan 2024 11:51:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c25-20020ac853d9000000b004283695a39bsm6944302qtq.94.2024.01.18.11.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:51:07 -0800 (PST)
Message-ID: <4c0fd569-3381-421a-82de-4c85b8a4cb59@gmail.com>
Date: Thu, 18 Jan 2024 11:51:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240118104301.249503558@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 02:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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



Return-Path: <linux-kernel+bounces-103806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3C87C4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82772B21AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A15768E1;
	Thu, 14 Mar 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbs1eu+x"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503F76418;
	Thu, 14 Mar 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451473; cv=none; b=jCsU76QyOoot83+2oLnIBQGwALWpBFinf4OlelMNUlAUAU7kVaw3ncH5oh4t/y0wa03H/wt9d1vyRiapKzm3s8g4123aolTH4LvivPeBGFWh2dq5kBBqZr3fuYzQqzk1OA2KXo08KG+pjyrDC03vWaTvGIpT0yDhdCFxLkqCO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451473; c=relaxed/simple;
	bh=dwB38dplwUxCRCm7IafC4eZ1Q3Wg9uEMDnbK94hoOVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiRtrgIz9s7Ai6YsdEKHa8RPTWnKvRmXO4fUc64aF/5C/AWb2SxDZego/XvlbJrGvOwcxDdLCUAWJJbxYvK4g+rTz+H2OBb4QxLbCJir0l3zxSF5o7wP3JXeOMEREOemS3F2b+DjtR8xFNR1XT+1ETZ0GDh96Wb5giAucmiK3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbs1eu+x; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1a069bd16so811076eaf.3;
        Thu, 14 Mar 2024 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710451470; x=1711056270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZtgcaMNCtnWLrfLQaOYRa0Fh8j2LRyYpaxFZxAYkLI=;
        b=Wbs1eu+xpMi8+6kPrllRvL9DsNuY09HewrCaZ1NUCo4HILpXhbdPFWwefLRFQmeTHp
         +9hcsy+SRxWh8hao2Nc1UDtyIRqbQu6k/tR2C1cAtq6dFcATogGO2dXYoQNVSbQId51X
         a0yvBiultq5m1DHo8Y73A4ABhn0/98hhd8cahF0OSbU3Vwbx1iLurkoIxkZv9JjdmB84
         QzueGrv5Otf0wzmbMXqf/CvX/YTzdxIJov/xVIw88cKa1ykng9JpgU1LKGRuxjBaNDw6
         cFBTLDxuyaIv1htRGadjHzHqh/Th51C/D863LrOI+PdRUcmFjfiz48uVBvi7IedfBajS
         ZuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710451470; x=1711056270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZtgcaMNCtnWLrfLQaOYRa0Fh8j2LRyYpaxFZxAYkLI=;
        b=uiwIMS+diOdhcJ8USjVVrVC8RNPulY2eH7WpDjyGGkEM+/9I4anwFdVh2PylXsmmJG
         JhoEyvRsRSjHAIgwswi4vS4a1DcMtHnXkJrLQ3ivjCByJCOPuUQ0SREwmd8qdmazuII2
         yHtf3iDtOHijyS6C5W9vicAv7rZ0yjJh8Tgda6+ORSRFvcYPZK+KzXmz1jAXr8yoSMGI
         9e2v1wHMY89VhO6U9Ry5d9sZgZxe5sBJzao2tvY8sq0cQ3xWRiqS2iRlcMxQjAqPL0Wm
         e+jgW2CH+DPbG84tLt+1k2I4iYP+Vs/sF9SHRCASpj9wkZKFdxKs6HBG+9RTLk8dW1YT
         V7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnSooqe1TLknk4xxB189u30dDa602mhMkiqoY1e0K64l60n2mfQMl3t4xCxu/E5SAtqk/aNclnyfQ7rqAaOu0BlPMSXrpe3di9tV9d7cXydEzOr3UQ6/d6ITgB2bvUY6gL3UTf
X-Gm-Message-State: AOJu0YycWEHsITXglQgt7T+N5YAmb20Nps6+GrVG+Cb3+xS7SFMGr1wp
	i5kRfbuiTALAb0ibngUHqFo4LcC81t0GHCmutBaGrZjshW90TfOI
X-Google-Smtp-Source: AGHT+IFoqAscHn9FMD9TcaRRLCqfoNRzlmOR4wLmWqF1wmTGaboNbiydEjcSf2E7bAJGv/1Gw/zdDQ==
X-Received: by 2002:a05:6358:1282:b0:17b:f109:c7f5 with SMTP id e2-20020a056358128200b0017bf109c7f5mr3695415rwi.23.1710451469947;
        Thu, 14 Mar 2024 14:24:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z2-20020a631902000000b005d8b2f04eb7sm1144466pgl.62.2024.03.14.14.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 14:24:29 -0700 (PDT)
Message-ID: <c3150fe5-0eb6-453b-86e4-3078dbb1e750@gmail.com>
Date: Thu, 14 Mar 2024 14:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163019.613705-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 3/13/24 09:30, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:28:11 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.

Could you and Greg make sure you share the same CC list? I am usually 
copied by Greg on stable release candidates, but a whole lot people are 
not. This makes it easy to miss those.

Thanks! With that:

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



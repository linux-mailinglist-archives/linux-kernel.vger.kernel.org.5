Return-Path: <linux-kernel+bounces-132092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFA898F86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E9428ADD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308B1350CF;
	Thu,  4 Apr 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlLJLCs9"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803613540B;
	Thu,  4 Apr 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261962; cv=none; b=hw8GAMOQfuyjcPwfSuV9Wdtjk9r6ZSDlRnEpSTiZL4tAIJdovu5t+dXrOVcv28bzkDP+NWXc8+LOFKAhguAAkk0dQegN7aDHAJ7HdObWoZq7JkXG/gN/FSUvIYZ2JsMcYTjNIc3+eJzfZY0L1/LIEt1YNXoG/7ZrNq2dHAxcf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261962; c=relaxed/simple;
	bh=w0J4zbPe6JElF9mSTVzlFkygGNgh6g/7Byt7NDMak0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neHVnU+I5ybzuxG+9ATW4z99/rXlRebJ3gwZ5FGzngDduVWmOe3SdiSXDT5Yf02BgM02CEAJ4O34mftzp7Sjb7M4ZYABit7j+PQgdawO+U5tZ6IISo5HQAMdVpYQM0u7yd/ohOrgXB3IAAhKomemEw/5kZbYbhC+6c/9dYstokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlLJLCs9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a26803f1aso85510085a.3;
        Thu, 04 Apr 2024 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712261959; x=1712866759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zt4DKHBY+VHDIhqqlQCWnE/AGPM6SuI6iCdlV3YdRD0=;
        b=DlLJLCs9jvWn7qaOZkmyUmPsnb6JBNHx21WtmF2ec8f3yL7SzoNBW2xgWTVCr3j0sQ
         KYxDyPQNBiPkNxHeatukMgoYUdwy06Wsl2AY5Yh2c8uOxLjlhw2QJWtzw3pfMf381ZUI
         uRV6BEuy+aAEYKyifsEN3kNSnoNsfOJbUKhbCWmMW5yyB16rdv4CsrbO+uOrIO63oiKw
         roOYYoWgQx8IxyHE+9z6z2KVrstRfAG4JLLofY8IzgaDx5n7iFnOgaKr0847GuDqueLA
         I7ZGxZpq5SI8v4DTPcqN4CwYD0HUtsrRtxg/wAnwmMt0j/vkvbTNmIUmXLVQu54cGx09
         1aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261959; x=1712866759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt4DKHBY+VHDIhqqlQCWnE/AGPM6SuI6iCdlV3YdRD0=;
        b=dFmIS/E5Wncc+lM84BwfEgJmGQinLMP0IyDnZng9ik/WkcRxgG3fP0wm/8g9vPPQTE
         Rl1WsB3eorc96hOkeGs07c4WZilWCMaiql0EO0QvPAMxXD1FppD5SXypsgTMdeddW+s1
         AQHfFFeKbveL4ACO8aI42uhU8zWwSMPVhmd5aF7K2ZxDxhRuJVeByDTWh+7X+r3vUBW+
         XiDZGUL9HCJ3cMjsRG5hRyzPcFt4tjS+hkoc0EOT0U4QgRUalm35ffJN24OTKXj8gtHS
         fXbnJsmgBeVG0ju+pSfBof4SMLAh2d33PUL5DHLodXbN/GCyRo/4oFLUi08P2MKasvHD
         BgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24Le0mmMwuks1hxLg0n1rFrrhFiJDqBCPQRzmg6UdedEC2l44wf/cdTjUxkriWP2E2b5jraWwSLpSl9Ls2a2zFmKzdHfDhzeLkVCymUHvy2Fek4DBFGUGoE04ZbwZEAXQJzyy
X-Gm-Message-State: AOJu0YyPok79Xfp1+xc/Bq6X8k7ct2eOdYIuQxYxoTjaSrRMJGQw2NOl
	G9+vMLb0up5yT1rNTk+m/YHmrEE0D2YqhwHTDq8+yIRaO2ANvclj
X-Google-Smtp-Source: AGHT+IHBHhv+pwO97xTouPmxltde0KQLvJ12DR+Cx/wmhXsuBOJCWB0WUtvNrCMHWomdYZQTKO8j4g==
X-Received: by 2002:a05:620a:5685:b0:78a:462d:1bda with SMTP id wg5-20020a05620a568500b0078a462d1bdamr3904328qkn.66.1712261959179;
        Thu, 04 Apr 2024 13:19:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s9-20020a05620a030900b00789fb5397d4sm51934qkm.100.2024.04.04.13.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:19:18 -0700 (PDT)
Message-ID: <003e00da-ac9c-4c98-800d-fcb5383a9e7d@gmail.com>
Date: Thu, 4 Apr 2024 13:19:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240403175125.754099419@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 10:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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



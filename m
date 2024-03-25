Return-Path: <linux-kernel+bounces-118198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4788B5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289811F64156
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5084D30;
	Mon, 25 Mar 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkJJCxeI"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11B339BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410987; cv=none; b=gTTsGu/JhPZ0FosX+ySU6S2dY9pEXxNb1YF+t/4yTMwMXvmCK9FlgKoZx3z5vexpU9U4mOI62HCnyRNgI1bC+SX8VqpUfd4O0+zK+jNxrcT14it7s2WvTeZGoSYzrFRg1YNbDM0dms0StSPCTLoRjDHTX9+kuabhsj5e5mzrMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410987; c=relaxed/simple;
	bh=6pXwMIuffqaQ5I4eK1GdGHXvrXPitbmlZRN9vaksf2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVTIWiGeKhW0sERwL/DnwsEryi4BXsTVsc/BvlvDGoHedP4sMBQQXF7v1BQYF6LJdUtzzI6Qksp3byn9n8M7q7XfsL1KD7mqOowujRg4sT5SHviitqzly++g/GL4MmMr2JQwWYi2i5Ib5WTXKxe3PZT+27AclnFM4n4X4TTt0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkJJCxeI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4859178f1so2662232eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711410985; x=1712015785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKSbDmcQakq8o4ZhpWu6TmQIoc3lyqYnDAzDVmwv7q4=;
        b=xkJJCxeIzMINoZvMHWyLNJ7IfLweFU+RuWmrdnGN8AftAjN5wjVzHhGdrUD1qe2dCM
         GiShnGHX2qf2TWBRq93A6sjLXSXYCEMWwfneRnJUvB1VDIqt887kye8DJ3Ga9uXQwIbn
         kP6EJljsg+mFhdkcaRWt6Yeef+PugFkPxGAgRVLM4NKZuMam3uDMjZDYF+fU+rpFfE9y
         leSYR9zcUWJKDDficYL4y8DdjOCIPBNEoWUtQ1U0Y0/iYxqLk2n/nh/60kvtgKioyj7s
         cEatGgKyDBfPec/FKT33GV1FfgQWPlMaL/7J8ahaCUdpzhl5lCcIjuzmycqXi61S68c4
         p9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410985; x=1712015785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKSbDmcQakq8o4ZhpWu6TmQIoc3lyqYnDAzDVmwv7q4=;
        b=KXdRW6FTF/gj97g8yNzT81A9sSi99VHmtuk4B1HwigD8rdZg4LNUVE5V77njKNpGC8
         DbxIOaUbxii6SlR9tLWyOu7Txng2njQRogwZLE76zQqyXOakbzFfA9W6t/ZLMltrop9I
         WSipk59UhuVuTYLqT8V1coxZVgUAPLYAFD/MYcuMU5DNslshJ/Ny2Wdns1MoUfvo0K8g
         FJWv0QW+gT/Oo5RV+lqZYcJQPdSeYJJVLNClyCv00tbKD23PcHIcvAMrBcNEk1/jyp8a
         qsqIyj8CeCYmG8Hb1R6PVMyBYfOcVyGfy426FjGRDgDKeXq4MPNu472qSBGCYJUyGtwf
         H9PA==
X-Forwarded-Encrypted: i=1; AJvYcCV6qrcu4tK0tu4+Flj3JNqV+OC5dSZvUye1p7AcxtErFuFcjAtGL6zFhnnMMiW64nvP3nm/CUcZxB2O9ZHch02zSU3Yu61MpY0tmqC6
X-Gm-Message-State: AOJu0YzqpG/tt7E9Mc2Cuq9o+uQuamlmB9UZPzpcr1qwgJc4jD/pEZkS
	OucM6lvkPRPVKM4qdssPsOM7SFVzFcFirtTI/65SvjdiUztRY0gzHiRHwixRKp8=
X-Google-Smtp-Source: AGHT+IFgSX4AWOMVnLRfk+cXudEZIwp4T5WKCSqKT//AOnoks76ZyALxI9kZ8iwnNp5yT1pcu87qMg==
X-Received: by 2002:a05:6870:b6a5:b0:222:4309:e276 with SMTP id cy37-20020a056870b6a500b002224309e276mr1537582oab.50.1711410984858;
        Mon, 25 Mar 2024 16:56:24 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id ho8-20020a056870498800b0022a66146d73sm11252oab.15.2024.03.25.16.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 16:56:24 -0700 (PDT)
Message-ID: <83814bca-1e33-4914-b00d-4b84ff1a1a23@linaro.org>
Date: Mon, 25 Mar 2024 17:56:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 abelova@astralinux.ru
References: <20240325115854.1764898-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:58 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha


As with 5.4, we see a new warning on Arm (32- and 64-bits):

-----8<-----
   /builds/linux/drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
   /builds/linux/drivers/cpufreq/brcmstb-avs-cpufreq.c:462:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     struct private_data *priv = policy->driver_data;
     ^~~~~~
----->8-----

Bisection pointed to:

   commit 2b373882d724311d7a5dadf225ed296f20abc8f9
   Author: Anastasia Belova <abelova@astralinux.ru>
   Date:   Wed Jan 17 10:12:20 2024 +0300

       cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
       
       [ Upstream commit f661017e6d326ee187db24194cabb013d81bc2a6 ]

Reproducer:

   tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8 --kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



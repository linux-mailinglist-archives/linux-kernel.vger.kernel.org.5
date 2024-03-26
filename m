Return-Path: <linux-kernel+bounces-119308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3788C6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13351C63984
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CDE13C9CE;
	Tue, 26 Mar 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrKDxUkf"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C113C9A9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466861; cv=none; b=Oc/NVCNFiBkuDvB60zHX7VoQhgDMVi76fnxIGP5Vn0WhN3AN9L93RM7ie//8yFYNCOaU4gJeWWo/RopKMBKqCJCkvefHsUChoXIKibcA+RQMMc6DxGZMm2ffhS1CO7CeZJ6hWm1kSURfPPxAE+b/uAQIViVXPXF5zw0FO222wUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466861; c=relaxed/simple;
	bh=YkNsaWX2HTUQq5kOihY1X0/mzkBWN0ikvGkfabNwlk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSvyPE2pC5K5DQSpLhxTDjWI0T83UmHjPNaSS1xZvfsPl7g9qapI57jDRGvTBcsaLyYYn6OYdZJiAosISSJ/pXGvfblVYkrEujdBhj7dM5Ycd3on8wqDDBlUia2JTSBkaNCm1eudjfIxeYpNxSHEc0qWDLIwZ+ohzKYfodJm3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrKDxUkf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3d70191c7so657267b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711466859; x=1712071659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KCoF05qOGvpLyJx0EzRCDdY9uRWyKEulxXUNrQvqig=;
        b=UrKDxUkfXY8mcimw0XtLNnPa/d8nW1PV7r9KN2MlBqttbjVtjYhNZ7a2a3m3DcOFeO
         xv/AV+NIM/g8v606uODXX9JD9Blu3vER7cgiUNSouA0KGCm4x/sIltwyVELLaACPo66w
         nFN5ldMT5B4o9bAxJP78iIHvDOkCUYk1JcbxMvD3Zlm1E/WR9VOQYAUPelwDrj8lGcHc
         FQSzXncd/2icmB/HyHFGS18/8mqkFf+rryeLM5zSJ5Ond+ZjsfNn0xSrqslIxbK5rL17
         2+acdTulR9ukWgYuafzRtVp8ZYIJYPE5bmantaJ9L1PKkxemV1Kh9d/2aVocVNZwwIPI
         vXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466859; x=1712071659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KCoF05qOGvpLyJx0EzRCDdY9uRWyKEulxXUNrQvqig=;
        b=totAC+HEQtN+RgQZfd9gtueSzDU8PeEPBYOqQt8xtMXFxfHebrkelpuERyTp1UMfO7
         M6b4qYBJFsq5Ypr7R8CSc3V1ECt9bN2nMkhWHzGLdP6gwBks2S27Z5wiXC7g733yplXo
         nK1BzmfXSd2vryLXMTluxznOEYttmR3ibQoP9M7qvlww1Hw/6Pm5TBI0eh7DC8j/8JFi
         A92WoZEEBrpooOmtzGCJ6HSy7kkDW78S1woptEG/ORO3aDQnWTuApewlIP1L3nrIv6Du
         TlL2PodHCjFUrUuVN897X4XaCEmfXJrpV8dc3cI7gXYVPi+0SjuUVxZZLttmWR5YDEon
         UO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy1biIZ8Jms3ypYziqe4UYQnbLNOT+HiZOK/gCwgRUQ/eGGT3LKz92H+D6zwkuhFkBbSoxrNH1+DWLU1zkGQL/GnHF9d2qDffU+zbq
X-Gm-Message-State: AOJu0Yxxv76jVfNc1QlSs2E4DQoN278MvdXwJFz5J0J2pcNn/38s2zF9
	jSqOIv9oRV4USVBlqIUrCLx8Oe9K5CHq3RLTrPpiUTfHvLd4d8qfzRKuwJrhOso=
X-Google-Smtp-Source: AGHT+IHCzN7eJO+5hXvWc55JPs/oPukABxTnS097+/tb36OwFitfostX+2P9Eu9V3oTVzEPHVe8jpg==
X-Received: by 2002:a05:6808:19a7:b0:3c3:a000:50e3 with SMTP id bj39-20020a05680819a700b003c3a00050e3mr3672752oib.37.1711466858871;
        Tue, 26 Mar 2024 08:27:38 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id es21-20020a056808279500b003c3865ae05dsm1519261oib.4.2024.03.26.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:27:38 -0700 (PDT)
Message-ID: <289f01fa-a323-4021-8a1d-a12b474d055b@linaro.org>
Date: Tue, 26 Mar 2024 09:27:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 sam@ravnborg.org
References: <20240325120018.1768449-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 6:00 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

There is a build regression on SPARC with allmodconfig, with GCC 8 and GCC 11. These are the first error messages:

-----8<-----
   /builds/linux/arch/sparc/kernel/traps_64.c:253:6: error: no previous prototype for 'is_no_fault_exception' [-Werror=missing-prototypes]
     253 | bool is_no_fault_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/sparc/kernel/traps_64.c:2035:6: error: no previous prototype for 'do_mcd_err' [-Werror=missing-prototypes]
    2035 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
         |      ^~~~~~~~~~
   /builds/linux/arch/sparc/kernel/traps_64.c:2153:6: error: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Werror=missing-prototypes]
    2153 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
----->8-----

More information (complete logs, binaries, kernel config, etc.) here:

   https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2eDAKInwlwcpYzt67s8SukhrZEZ

Reproducer:

   tuxmake --runtime podman --target-arch sparc --toolchain gcc-11 --kconfig allmodconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org



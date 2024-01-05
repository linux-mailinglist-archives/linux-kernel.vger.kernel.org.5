Return-Path: <linux-kernel+bounces-18091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138D8258C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09411F23B35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811631A71;
	Fri,  5 Jan 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9Yusyvr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8F32189
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204301f2934so946436fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704474107; x=1705078907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWpUupEW5Q6RT9phGeKrpsB0tLP4TW7REusBhk8x/xs=;
        b=W9YusyvrHfBfPli5+6kkTDzsj/CeGCsGXNXCgv0JsW4b4PW2h9P4V2O44slMr+ms1j
         /IYLau6QcLnuQfzHIvgftU27fIWQypQq7vbh5v9QdvwWusk9qaqMH4w1s7eqkfjO9l9d
         NmEpXTUgBdefibR2HgwWWH0GdebcI4Ua6mJUxLgUerXLtjqMktUavLj/+wtoukgnOUh/
         xKfPyz/ezybMN+2uhmDue4CPpdFjY0LC8tMPvopmiA02lKvcy2KZREKZ3amWJAM3u/H2
         fcE/zsICbQ1xRWx5Ir0yROiqrl4Ci9IMT+PtP74eSFrFNiGrLFqSNqbXfc1u0xNAJ+5H
         5ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704474107; x=1705078907;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWpUupEW5Q6RT9phGeKrpsB0tLP4TW7REusBhk8x/xs=;
        b=LADDv7hAHd/X8y8FMRG7C6BMhx7IWxc1+mKqMHDZsoD48dyCWksJJM85wDW6RefsKC
         8Sf9ywMpP5hNVD7CBVfe+lf8I9rznB/JKwVHGkXtdGewrpvwf9BsPVunHcVzhC1xFEgs
         cMhd4lyH+NU0x0Mq8n+ryuj7GIqqNYXyro/vNf406AwlRB0dCmtDX1EuYyWMfCuLZX27
         3KsRAYfIu9anXWEVajgjCKQ3yZEYtg6mWbs6xFUI6tFwsnopRoapbri83Itilzj1+gAt
         9UeGorFvEYhU/MxUmHehMiqLc6BqDTLzRUeYxWMi6F6aNOzsePz4TVmcm4yD9RxtphfN
         BRUA==
X-Gm-Message-State: AOJu0Yw94oiz7tPKQQWJhLq5lS4gVI2UD4qPbN1SUzca1Bq22/stSovy
	eQyEwcHW1thyi4r+/Lcuw5ckF8RXnCLB2g==
X-Google-Smtp-Source: AGHT+IHFjPFjozpPkp8XiDZL8O4QrvW5wcFZTqYcm8kddMKxrUmThPf24tJE0e4H12Y00WQfZXLPqQ==
X-Received: by 2002:a05:6871:740d:b0:1fb:75b:2fb1 with SMTP id nw13-20020a056871740d00b001fb075b2fb1mr2467219oac.72.1704474107478;
        Fri, 05 Jan 2024 09:01:47 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id ux10-20020a056870af0a00b0020443f5e50csm541383oab.5.2024.01.05.09.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 09:01:47 -0800 (PST)
Message-ID: <92d8ecc9-7b51-4d54-9942-efc5beb156cf@linaro.org>
Date: Fri, 5 Jan 2024 11:01:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/47] 5.4.266-rc1 review
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, jpanis@baylibre.com
References: <20240105143815.541462991@linuxfoundation.org>
 <77569e45-ab73-4049-b90e-cd60cbb872ef@linaro.org>
In-Reply-To: <77569e45-ab73-4049-b90e-cd60cbb872ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 05/01/24 10:04 a. m., Daniel Díaz wrote:
> Hello!
> 
> On 05/01/24 8:38 a. m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.4.266 release.
>> There are 47 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Quick note that there are Arm32 failures:
> 
> -----8<-----
>    /builds/linux/drivers/bus/ti-sysc.c: In function 'sysc_reset':
>    /builds/linux/drivers/bus/ti-sysc.c:1847:4: error: implicit declaration of function 'fsleep'; did you mean 'ssleep'? [-Werror=implicit-function-declaration]
>     1847 |    fsleep(ddata->cfg.srst_udelay);
>          |    ^~~~~~
>          |    ssleep
>    cc1: some warnings being treated as errors
>    make[3]: *** [/builds/linux/scripts/Makefile.build:262: drivers/bus/ti-sysc.o] Error 1
> ----->8-----

Bisection points to:

   commit bed75624164c501b39531927d07a4fadc5738847
   Author: Julien Panis <jpanis@baylibre.com>
   Date:   Mon Aug 21 16:24:18 2023 +0200

       bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
       
       [ Upstream commit d929b2b7464f95ec01e47f560b1e687482ba8929 ]

Reverting (swapping back the content of that commit, as it wasn't a clean revert) did make the build pass.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org



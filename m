Return-Path: <linux-kernel+bounces-5754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEC818F19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3BBB25788
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271A3A1B2;
	Tue, 19 Dec 2023 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFqOwj5l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683C38DEC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c236624edso53291135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703008758; x=1703613558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KN7dzTE7sSokESzZZ6AOq/Kgugkj07akzvWGzTORhac=;
        b=nFqOwj5l3cFPKESlbm+xd/SYDuNj56ogOZT1EtlY5WVzpCJSoaL+7nsNgqgwc0HltD
         xUsviHSz7trXK6yGbmt8r4atJCmkccaduh8Px9HyYVJD6sWF+wFyRmI+/wrNrWh7QsmX
         Uv9w0oH1k7J2MLhFk54HSAHbTaEZbolomz4X+3sszHeRlyT4KkjupIMOAVpNdKsliMn0
         Ub5bWJmWl7/tHBAc7QSIZRXaYEJ60Krf/BKhV39nm/haaGLi6Ei9iywzNBQ+UUr4GEd5
         niJv+b541bbhIkNw/ErnQbV98z7eykmorMITc413mNoxHNIYEeuJRnY+ATI5AIcGNWkZ
         feTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008758; x=1703613558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KN7dzTE7sSokESzZZ6AOq/Kgugkj07akzvWGzTORhac=;
        b=rJ+0kieGPCnz3ojCtm6QxwLmo2qYSLeehnWip7Jln2pBX2fiEqV+w/nl9e1jiIO+cM
         rHTSh971hRfb385rlrEaEYELhBS3sDSgh7oAdKonmfaxbAJ5dDKVhbgv3PRe+7iqRTHH
         +aioR07hj5d4LBrzYmQ56jCyxy0cBTP6e9dqHNjlQFUaxMSitCdkj9gz1HbyrRVZMR/H
         Ih1EmAL+zaHq1re5SBXjYRR5vrc8YdBE9ZHJW85mNqd3MWgl2dpoc+QOx8mPJpcxL/vJ
         lsXgWngUxfIKJMZGLfnjJWyHzf5XZSK09KHiM2PO/+senXmQXf7LYWh08FEUte7WtyOz
         CoEw==
X-Gm-Message-State: AOJu0YwExrCFtpVXIKfggNAxSRti/scsIJ8xnk0XdpM+0MnF+mseO77y
	+J5uYrjr/03Fk8boJFXnD2HCcuhOn0E3hfIlvxo=
X-Google-Smtp-Source: AGHT+IEA1aPy4orFu8hYgiu7e0qrZnpoMLWlg4sYRg2lwRj2CDvRyJ7ChpR667R59lHN2eq1dGEpbQ==
X-Received: by 2002:a05:600c:221a:b0:40b:5e1e:b3af with SMTP id z26-20020a05600c221a00b0040b5e1eb3afmr9988601wml.45.1703008758440;
        Tue, 19 Dec 2023 09:59:18 -0800 (PST)
Received: from [192.168.10.46] ([37.170.14.102])
        by smtp.googlemail.com with ESMTPSA id m39-20020a05600c3b2700b0040d23cea7bcsm1320165wms.1.2023.12.19.09.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:59:18 -0800 (PST)
Message-ID: <c2a170ea-39e8-49bf-9aeb-60eb20a22454@linaro.org>
Date: Tue, 19 Dec 2023 18:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the thermal tree
Content-Language: en-US
To: Fabio Estevam <festevam@denx.de>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Zhang Rui <rui.zhang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231219103457.4e034e9a@canb.auug.org.au>
 <68012fb93e0057f62c03a5d9b01237c4@denx.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <68012fb93e0057f62c03a5d9b01237c4@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/12/2023 03:10, Fabio Estevam wrote:
> Hi Stephen,
> 
> On 18/12/2023 20:34, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the thermal tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> ERROR: modpost: "__hw_protection_shutdown"
>> [drivers/platform/chrome/cros_ec_lpcs.ko] undefined!
>>
>> Caused by commit
>>
>>   726edaad90f6 ("thermal/core: Prepare for introduction of thermal 
>> reboot")
> 
> Thanks for reporting.
> 
> Daniel,
> 
> Could you please squash the following fix to the commit above?
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 07eb6537ed8b..f814568525f1 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -1002,6 +1002,7 @@ void __hw_protection_shutdown(const char *reason, 
> int ms_until_forced, bool shut
>          if (shutdown)
>                  orderly_poweroff(true);
>   }
> +EXPORT_SYMBOL_GPL(__hw_protection_shutdown);

Yeah, I've done it


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



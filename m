Return-Path: <linux-kernel+bounces-3346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2A816B48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5135A1C208F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE972156C0;
	Mon, 18 Dec 2023 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QB6NdU8T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7D154BF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso34124245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895918; x=1703500718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLl2rDUpG+iQLKdOKP/+lJ31HAD9auBdzVKx/VKEBIc=;
        b=QB6NdU8T6mpK/qXjn+63+tKsI15FXwNd+6VHYWmvjpwpyNiCwMs/jriO7uiKNmppE5
         kyepoeXHxS1RPdWVha0Jvtry4ziJBrxgAQXbwaIidQxyDQO5z1MuvH57c0bDJgiTi4sQ
         FTQ1K/nwWQYbPpXfjXlIi2K8AdEmilJGO9Pbz2GJ7qENnmVx64Qg1rHemUDT0QYv4iM4
         p6BciyM1/WIEoFWOXT5Z/CfPBj6w7iyhLEAyYOZkzSH61B5JMkt824mDHJPQj5wNv/Wj
         mQe9vsj3u91w8ANIJ8wyKwPbTBLLHCh9ztMsILWOcHJja6XtRqNyh0L61MSYPWXxYtDr
         7qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895918; x=1703500718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLl2rDUpG+iQLKdOKP/+lJ31HAD9auBdzVKx/VKEBIc=;
        b=tAA4xW5svRh5du5AZF8POQji5qSbzmeZXBLPlLoT9bJz+k14xRJuIaI4ZfN6grCuFS
         5u2/TMDnesXRyzQ0yVeid4pAsQX9uDRKN3vWR7gxofQke1QiHBu2D47VNehCyHXhHQac
         3Xp5vd3snv1VST9qO2p4g0NCfZ8+9u85ArHQq2pGby7bpFg1sslhi62omde0Axfzaryt
         N/LPoAqnU+Iu4iVRqRgLJOUCdKsmRyggVztOzspBnuGTiDJTuPH3Go/UffcjF779gglt
         hT/8iiSvHwaG6Bgc+q7+t4g81sKKHzo0E3HRWIJqejHt4+OIbFzFhXBhmLURBm/7Bhhy
         4PtA==
X-Gm-Message-State: AOJu0YzpxKbbhL6k3q3KHrqyhu/LpLJYV5JQ4EbUMECLmIf6EXE1w5B+
	FQzphvQSe4FubIN2FkLdO9EzrA==
X-Google-Smtp-Source: AGHT+IEjM/30KLu2fANPOHpnJIQg/jvtSat45eIY4TrmWBYutnXrWofdeG6xjzJL0PIP6IFfb+qLAA==
X-Received: by 2002:a7b:c455:0:b0:40c:2871:9727 with SMTP id l21-20020a7bc455000000b0040c28719727mr8354943wmi.150.1702895917730;
        Mon, 18 Dec 2023 02:38:37 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l12-20020a05600c4f0c00b0040b4b2a15ebsm41299237wmq.28.2023.12.18.02.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:38:37 -0800 (PST)
Message-ID: <681bfda0-ccc2-4af0-b77e-31c92cf7ada3@linaro.org>
Date: Mon, 18 Dec 2023 10:38:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the nvmem tree
Content-Language: en-US
To: Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231218161238.59ce255d@canb.auug.org.au>
 <2023121838-factual-unvalued-3e01@gregkh>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023121838-factual-unvalued-3e01@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/2023 10:26, Greg KH wrote:
> On Mon, Dec 18, 2023 at 04:12:38PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> The following commits are also in Linus Torvalds' tree as different
>> commits (but the same patches):
>>
>>    82c6ba6a7d96 ("nvmem: brcm_nvram: store a copy of NVRAM content")
>>    a9d68bd9fc7a ("nvmem: stm32: add support for STM32MP25 BSEC to control OTP data")
>>    5bc8339a8af8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem")
>>    6deccfa25e3d ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
>>    e15e05ed845a ("nvmem: core: Expose cells through sysfs")
>>    38ebc72019b9 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
>>    fc334e722496 ("nvmem: core: Rework layouts to become regular devices")
>>    d5827449f96c ("nvmem: Move and rename ->fixup_cell_info()")
>>    52be3c1543c4 ("nvmem: Simplify the ->add_cells() hook")
>>    26378491d343 ("nvmem: Create a header for internal sharing")
>>    c016e72f9346 ("nvmem: Move of_nvmem_layout_get_container() in another header")
>>    0e7ceb1551ee ("of: device: Export of_device_make_bus_id()")
>>
>> These are commits
>>
>>    1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
>>    f0ac5b230396 ("nvmem: stm32: add support for STM32MP25 BSEC to control OTP data")
>>    a729c0f57dc8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem")
>>    a2a8aefecbd0 ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
>>    0331c611949f ("nvmem: core: Expose cells through sysfs")
>>    192048e5a5b6 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
>>    fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
>>    1172460e7167 ("nvmem: Move and rename ->fixup_cell_info()")
>>    1b7c298a4ecb ("nvmem: Simplify the ->add_cells() hook")
>>    ec9c08a1cb8d ("nvmem: Create a header for internal sharing")
>>    4a1a40233b4a ("nvmem: Move of_nvmem_layout_get_container() in another header")
>>    7f38b70042fc ("of: device: Export of_device_make_bus_id()")
>>
>> in the char-misc tree.
> 
> That's because the nvmem maintainer sent these to me for inclusion, odd.

Am happy to send a PR next time if it helps.

thanks,
srini
> 
> greg k-h


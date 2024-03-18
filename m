Return-Path: <linux-kernel+bounces-106704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94187F22F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0081C2040E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4A59143;
	Mon, 18 Mar 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDPMC3NM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBE535B9;
	Mon, 18 Mar 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797495; cv=none; b=cy0tlUwP9EQuLJY0wSX3koSJ//KCc/1VeD4YgCSkexNAb3UThFbHcy4vt0pycJjfQhWvwaXusyRO2aRzrZQFnDab/HHjJMg4J6tEmf4z/PRntoUFWT3xjhiWpXFg1XVpteBDYze1Zq4vhtvrSwYemLA48sqOOwGhG4mWDXj5ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797495; c=relaxed/simple;
	bh=1JyeMjUA8d7HJk9QHCRuaBu/MXSCSJLIkySvL+Q/ysE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CENLmpw9HP6erjGLKDeKY+tatir6Fk39veYp72yawJpOyIhU6CPMS9C6+uVc/I9F5fSWCW7VCmAQwPzW+sv5OfGxpUAh1GvEsqszVyjgmaum1Mz7AJ8iECO7y/89btsDCgG8SUyJL48XBQXd+kEZXQ1w4ojjDLaHk4AEKERwrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDPMC3NM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e01c38f98cso9001005ad.3;
        Mon, 18 Mar 2024 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710797493; x=1711402293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k17Ymy3BBRZPLRNinHJQ9XlD/PfAWI/tIIOZeywRuEA=;
        b=QDPMC3NM52233P5aWWFl/ERLtgsT/YUJ4Yf4LGz1XqHXCWWk/kn34wRG4RHFpxurx2
         NWfRzCnHBOP+pysFZYmj0vQdUUp6EteWk9YIrw4hkRu1ObO8OFU/9VVXm0OiLuUTY9jH
         f8JWq2EE/bEZCAuVfctuSyiJUCmbIwbt2nfVRbP9lFnuMoMEjyABxSNLFAhyMsijfonL
         kV8BcXouvFtY46ptC6j5VdSSQKhc4bGuMX8LQu9ueAzdxdcS1vsAc7Y5OODooSpm2PoT
         4wBl2nHQMdR3YNct9qM0/K73eA0eU3G0g32Tn/Ff9ubPhHoxdPmrSQUqRxy9W0xcrpHE
         HLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797493; x=1711402293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k17Ymy3BBRZPLRNinHJQ9XlD/PfAWI/tIIOZeywRuEA=;
        b=pwd6KdDTw6Xt8rdu6YYPwjQvRbVvlLDDfwjnWy8FQHCmEehQCLhEhnTD0FUHbb02uF
         mgusRe9B43+1BLT6clPSQMZPCLggNd2njeBCQXJJQqLifEWktf8sQZIoc8aeCuxYPjIL
         Y+6GZVDsuvGS9iFs2OSHeNWxWR1NImLZQRFYiY98oF1UZMMlOnOxCPC3AfU68QQXCyzV
         hDGaIWvQ+A3hIAdZ00G7YzlOGTnKOaEBbzTsyDddmFBylCw9RT/ykpRCWH/c7Mc3QvqO
         oVFr8bsdBQMt7wKVmxHi0riVTee8lZ3zmHxGGei/odkAn1zZNR+JUdusMmZWFbl741/u
         nTrw==
X-Forwarded-Encrypted: i=1; AJvYcCV1T8xfLfwbSldRAc+vqqVZnBbPBG9WCLzzscaN+MI6auShB+SYNWNlmjrWQqUX25t8Q2zFVH6IXJIw3pzqlpzSIBomA2dZQFtMAiOEHW9w/qCo5xH5mahxxrmxrbICPHcsyCdRtrUCtg==
X-Gm-Message-State: AOJu0Yxwl1ULdfCRY8QdOMltoVrWwZPTHtzZzYlskaEwaOylBH9ZaD6Y
	KnWGzWBugj3oo/wZx9Zu/APamhTAgn3B6GHEl9sYXDQty5mMbFjU
X-Google-Smtp-Source: AGHT+IHTLXkYmY+nSEyY6Djr0op+GQPqJETexDxcp4Gg+f4xBxlO+kYhX1FURHPRuG3PFfmg1JdetQ==
X-Received: by 2002:a17:903:22cd:b0:1dd:a7a7:4bc1 with SMTP id y13-20020a17090322cd00b001dda7a74bc1mr16058795plg.5.1710797492685;
        Mon, 18 Mar 2024 14:31:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001c407fac227sm9778228plh.41.2024.03.18.14.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:31:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net>
Date: Mon, 18 Mar 2024 14:31:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lizhi Hou <lizhi.hou@xilinx.com>, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com>
 <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
 <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 12:26, Rob Herring wrote:
> +Stephen
> 
> On Mon, Mar 18, 2024 at 12:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>> firmware, we end up without a root node. In order to apply overlays and
>>> create subnodes of the root node, we need one. Create this root node
>>> by unflattening an empty builtin dtb.
>>>
>>> If firmware provides a flattened device tree (FDT) then the FDT is
>>> unflattened via setup_arch().  Otherwise setup_of(), which is called
>>> immediately after setup_arch(), will create the default root node
>>> if it does not exist.
>>>
>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>>
>> This patch results in a crash on nios2.
> 
> This patch was never applied. I assume you meant a later version of it
> that did get applied.
> 
>>
>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running ...R failed (crashed)
> 
> Booting with DT?
> 
>> ------------
>> qemu log:
>> earlycon: uart8250 at MMIO32 0x18001600 (options '')
>> printk: legacy bootconsole [uart8250] enabled
>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40
>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40 ]---
> 
> nios2 looks utterly broken to me. This change should be a nop unless
> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
> address) to be 0 depending on kconfig options, but that would have
> skipped copying and unflattening which would then panic in
> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> early_init_dt_alloc_memory_arch() calls should fail when copying the
> DT. So I don't see how nios2 booting with DT ever worked.
> 

For nios2, in early_init_devtree():

void __init early_init_devtree(void *params)
{
         __be32 *dtb = (u32 *)__dtb_start;
	...
         if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
                 params = (void *)__dtb_start;

That worked fine until this patch. Starting with this patch, __dtb_start
always points to a valid empty devicetree blob, which overrides the
devicetree blob passed to early_init_devtree(). This causes the problem.

Guenter



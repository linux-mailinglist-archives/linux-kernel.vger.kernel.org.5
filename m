Return-Path: <linux-kernel+bounces-7510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0481A912
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364CE1F23A76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0894A99E;
	Wed, 20 Dec 2023 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmEnXEDe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EA4A991
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703111071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKEtXpxWEXqHmaRgecKZIuBlMS5GtRi+T6U7J2E0TGg=;
	b=VmEnXEDe8ZcoG+Crpo7cMgLn8B7w91FE7pCsLlGPcZKXCGGum942vZNwaklw7g710uaL72
	NY+xDRgnk4cd5JGEL9E8aLvpeesB1qMU9Ixex82+JSRvq1iQquEESwWhWG4dPL+Y6Yr0O1
	I2QgaHwmd40s4Bb4MRZmds7eHanQI98=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-70WIa9sQOFmnd-DWyJWm0g-1; Wed, 20 Dec 2023 17:24:30 -0500
X-MC-Unique: 70WIa9sQOFmnd-DWyJWm0g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7810a048407so201827585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111070; x=1703715870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKEtXpxWEXqHmaRgecKZIuBlMS5GtRi+T6U7J2E0TGg=;
        b=rE2kyuTXp1sbz1bNchQTzytK5Z/5wMjuq9QOR58L60w8HnDC8CHZoab4erDMOXBFYT
         /Gd858IOkLn92xe7CC8JrfIND9XoNhSxrrKROrbeTafd/eGz7k0WB2Gc6rYYbVRPXqXR
         TdGy1WYaI6/zBam/Njb1ezNSJkEmJhB3QwucDAt6/uJ6Fbqhj4Jqnjr7NYn/q8cBwTVj
         TAjp0Y3C5HrC6XXbPShUtI7taLubtb446IY0lVR9+YnemHtArSvv7wARfXb4jT7+tyHn
         mFfZ3ZW1Ir8No1KAaK8/9yQ9z9arHuut1+3YjnJ2GuIxwcJY2aGqvsfly4pFaZqQWEAc
         nQoA==
X-Gm-Message-State: AOJu0Yx1wpGDMpXP6kqdUkeBj2v+jkyz0tSE8P8DO/55KTHmRqDjdEl9
	/ToiDmeIO1n+GjU3TI/xwCPpkJpbTaCmdYn/1jGqbtAWb5g3xR6dlImDGAuz83YevQkt5xevOXi
	REIwFU6tQHUfURuHL4EufbKdV8IO6vZw=
X-Received: by 2002:a05:6214:2aab:b0:670:b327:c86f with SMTP id js11-20020a0562142aab00b00670b327c86fmr5466610qvb.17.1703111069824;
        Wed, 20 Dec 2023 14:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHvKbv91Er501QGBIFGysk8lYHmXBqXksDERzophlrCPxs1OI71lQrPG+NnYo3frJbkHcN5Q==
X-Received: by 2002:a05:6214:2aab:b0:670:b327:c86f with SMTP id js11-20020a0562142aab00b00670b327c86fmr5466595qvb.17.1703111069521;
        Wed, 20 Dec 2023 14:24:29 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id l16-20020ad44d10000000b0067f7b6318b9sm208938qvl.10.2023.12.20.14.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 14:24:26 -0800 (PST)
Message-ID: <a0925c7e-001b-4b8d-9da1-6b271e2f8434@redhat.com>
Date: Wed, 20 Dec 2023 23:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
 <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
 <2023121927-desolate-choice-a2fe@gregkh>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023121927-desolate-choice-a2fe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/12/23 19:11, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 06:17:20PM +0100, Marco Pagani wrote:
>>
>> On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
>>>>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
>>>>>> This patch tentatively set the owner field of fpga_manager_ops to
>>>>>> THIS_MODULE for existing fpga manager low-level control modules.
>>>>>>
>>>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>>>> ---
>>>>>>  drivers/fpga/altera-cvp.c             | 1 +
>>>>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>>>>>>  drivers/fpga/altera-ps-spi.c          | 1 +
>>>>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>>>>>>  drivers/fpga/ice40-spi.c              | 1 +
>>>>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
>>>>>>  drivers/fpga/machxo2-spi.c            | 1 +
>>>>>>  drivers/fpga/microchip-spi.c          | 1 +
>>>>>>  drivers/fpga/socfpga-a10.c            | 1 +
>>>>>>  drivers/fpga/socfpga.c                | 1 +
>>>>>>  drivers/fpga/stratix10-soc.c          | 1 +
>>>>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>>>>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
>>>>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
>>>>>>  drivers/fpga/versal-fpga.c            | 1 +
>>>>>>  drivers/fpga/xilinx-spi.c             | 1 +
>>>>>>  drivers/fpga/zynq-fpga.c              | 1 +
>>>>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
>>>>>>  18 files changed, 18 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>>>> index 4ffb9da537d8..aeb913547dd8 100644
>>>>>> --- a/drivers/fpga/altera-cvp.c
>>>>>> +++ b/drivers/fpga/altera-cvp.c
>>>>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>>>>>  	.write_init	= altera_cvp_write_init,
>>>>>>  	.write		= altera_cvp_write,
>>>>>>  	.write_complete	= altera_cvp_write_complete,
>>>>>> +	.owner		= THIS_MODULE,
>>>>>
>>>>> Note, this is not how to do this, force the compiler to set this for you
>>>>> automatically, otherwise everyone will always forget to do it.  Look at
>>>>> how functions like usb_register_driver() works.
>>>>>
>>>>> Also, are you _sure_ that you need a module owner in this structure?  I
>>>>> still don't know why...
>>>>>
>>>>
>>>> Do you mean moving the module owner field to the manager context and setting
>>>> it during registration with a helper macro?
>>>
>>> I mean set it during registration with a helper macro.
>>>
>>>> Something like:
>>>>
>>>> struct fpga_manager {
>>>> 	...
>>>> 	struct module *owner;
>>>> };
>>>>
>>>> #define fpga_mgr_register(parent, ...) \
>>>> 	__fpga_mgr_register(parent,..., THIS_MODULE)
>>>>
>>>> struct fpga_manager *
>>>> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
>>>> {
>>>> 	...
>>>> 	mgr->owner = owner;
>>>> }
>>>
>>> Yes.
>>>
>>> But again, is a module owner even needed?  I don't think you all have
>>> proven that yet...
>>
>> Programming an FPGA involves a potentially lengthy sequence of interactions
>> with the reconfiguration engine. The manager conceptually organizes these
>> interactions as a sequence of ops. Low-level modules implement these ops/steps
>> for a specific device. If we don't protect the low-level module, someone might
>> unload it right when we are in the middle of a low-level op programming the
>> FPGA. As far as I know, the kernel would crash in that case.
> 
> The only way an unload of a module can happen is if a user explicitly
> asks for it to be unloaded.  So they get what they ask for, right?
>

Right, the user should get what he asked for, including hanging the
hardware. My only concern is that the kernel should not crash.

> How do you "know" it is active?  And why doesn't the normal
> "driver/device" bindings prevent unloading from being a problem?  When
> you unload a module, you stop all ops on the driver, and then unregister
> it, which causes any future ones to fail.
> 
> Or am I missing something here?
>
 
I think the problem is that the ops are not directly tied to the driver
of the manager's parent device. It is not even required to have a driver
to register a manager. The only way to know if the fpga manager is
active (i.e., someone is running one op) is by poking manager->state.

One possibility that comes into my mind, excluding a major reworking,
is waiting in fpga_mgr_unregister() until the manager reaches a steady
state (no ops are running) before unregistering the device. However, it
feels questionable because if one of the ops hangs, the module removal
will also hang.

Thanks,
Marco



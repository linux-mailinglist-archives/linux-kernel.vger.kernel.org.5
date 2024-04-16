Return-Path: <linux-kernel+bounces-147725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4328A7838
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CBEB22B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7413A24E;
	Tue, 16 Apr 2024 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnDAMIjU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941896EB4C;
	Tue, 16 Apr 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308372; cv=none; b=WudDmqcr9veoKs8kUmu0pxe9lZ8CFWENc9Vhq/mXG+WetCfKTqeaGDoYERpp9ckA+omP/hogAdMvNek7b/sFj8p3C06hDdGtRIVnoRjnrScV55JWmfwBOgmS4n7Gv3bJYy5fRd86K3CMqzAA7if8FE1a2HXeW0XlOzsMF726LsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308372; c=relaxed/simple;
	bh=NV/UguGow9ASlmVYIj3yQaT47Si6+C8YOXFO1DIJSdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/9g5PMQWowIp5OP7qsOBliIjB2gIUoD3gNUE1HLcKGVLdyCUsjqV2790uOZfuYSWMcJg3+T6iABLWZPnKzFPfb9jW2uEK7Uz59c2YmwQfHTpBt7JHKJBMLKDiOS13suqtlqOUGWXuNUDJJUVTgGy/5tnNtJwZcX+VtRVZd8Ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnDAMIjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25208C113CE;
	Tue, 16 Apr 2024 22:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713308371;
	bh=NV/UguGow9ASlmVYIj3yQaT47Si6+C8YOXFO1DIJSdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rnDAMIjU8kWJTlYRTRhSgT5P8oNwjVDdsFyG7Yd13zClgiJ35bF77159960jslMe4
	 NM53o4VVBlbeUEFpZTGWWRKq4yWZRNR0HBb7JhTsWDfTfWHByRXfiD/yFR6K/yqgKv
	 HGQgV0VVjVIjQehl0tIL/ZGoy3sStmPfaJl+pPdV9+OkixSRlGKR8QZwRF927m70xx
	 o4FGUC/olipHXL8XY5GS64EX6XQiuPl/SmwJMV6YOsezwI4gLV3iZKAnYFRuLzI/sq
	 A1r01N3qbTfoyf4hVgv/c7CfsiMC9N8rFe3eTCzQKvkq9iR7oiAfkXtMiIJcDyNmWb
	 185BR8MffMfCA==
Message-ID: <898497f0-d279-4d01-be8d-aad4048df95d@kernel.org>
Date: Wed, 17 Apr 2024 08:59:27 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
To: Gustav Ekelund <gustaek@axis.com>,
 Gustav Ekelund <gustav.ekelund@axis.com>, cassel@kernel.org, hare@suse.de,
 martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
 <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/16 0:49, Gustav Ekelund wrote:
> On 4/13/24 02:29, Damien Le Moal wrote:
>> On 4/12/24 22:48, Gustav Ekelund wrote:
>>> Expose a new sysfs attribute to userspace that gives root the ability to
>>> lower the link speed in a scsi_device at runtime. The handle enables
>>> programs to, based on external circumstances that may be unbeknownst to
>>> the kernel, determine if a link should slow down to perhaps achieve a
>>> stabler signal. External circumstances could include the mission time
>>> of the connected hardware or observations to temperature trends.
>>
>> may, perhaps, could... This does not sound very deterministic. Do you have an
>> actual practical use case where this patch is useful and solve a real problem ?
>>
>> Strictly speaking, if you are seeing link stability issues due to temperature or
>> other environmental factors (humidity, altitude), then either you are operating
>> your hardware (board and/or HDD) outside of their environmental specifications,
>> or you have some serious hardware issues (which can be a simple as a bad SATA
>> cable or an inappropriate power supply). In both cases, I do not think that this
>> patch will be of any help.
>>
>> Furthermore, libata already lowers a link speed automatically at runtime if it
>> sees too many NCQ errors. Isn't that enough ? And we also have the horkage flags
>> to force a maximum link speed for a device/adapter, which can also be specified
>> as a libata module argument (libata.force).
>>
>>> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
>>> first lower the link speed one step with sata_down_spd_limit and then
>>> finish off with sata_link_hardreset.
>>
>> We already have "/sys/class/ata_link/*/hw_sata_spd_limit", which is read-only
>> for now. So if you can really justify this manual link speed tuning for an
>> actual use case (not a hypothetical one), then the way to go would be to make
>> that attribute RW and implement its store() method to lower the link speed at
>> runtime.
>>
>> And by the way, looking at what that attribute says, I always get:
>> <unknown>
>>
>> So it looks like there is an issue with it that went unnoticed (because no one
>> is using it...). This needs some fixing.
>>
> Hello Damien and Niklas,
> 
> Thank you for the feedback.
> 
> I have a hotplug system, where the links behave differently depending
> on the disk model connected. For some models the kernel emits a lot of
> bus errors, but mostly not enough errors for it to automatically lower
> the link speed, except during high workloads. I have not observed any
> data-loss regarding the errors, but the excessive logging becomes a problem.

Hot-plugging should not be an issue in itself. When hot-plugged, the port
scanning process should detect the maximum link speed supported by your device
and use that speed for probing the device itself (IDENTIFY etc). If you see bus
errors, then you are either having hardware issues (e.g. a bad cable or power
supply) or some issues with your AHCI controller that may need patching.

Can you send examples of the errors you are seeing ? That needs to be
investigated first before going the (drastic) route of allowing to manually
lower link speed at run-time.

> 
> So I want to adapt the link, depending on the connected model, in a
> running system because I know that some particular models in this case
> will operate better in SATA2 in this system.
> 
> Can I use the libata.force module to make changes to a particular link
> in runtime?

Nope, libata.force is a module parameter so you can specify it as a kernel boot
parameter, or if you compile libata as a module when loading (modprobe) libata.
At run time, you need to rmmod+modprobe again libata, and so the ahci driver as
well (because of dependencies).

As I mentioned, if a run-time knob really is necessary (it should not be), using
the ata_link hw_sata_spd_limit would be a better approach. But again, that
really should not be necessary at all.

> 
> Best regards
> Gustav
> 

-- 
Damien Le Moal
Western Digital Research



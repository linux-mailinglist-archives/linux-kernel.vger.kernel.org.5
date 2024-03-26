Return-Path: <linux-kernel+bounces-118740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A982A88BEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA01C3C60D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1E5C904;
	Tue, 26 Mar 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGAJerI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB15524D0;
	Tue, 26 Mar 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447539; cv=none; b=M8ZmPQ4dsGVZNAIbOwhRXpGkpktbZALAqYi9njMOblpBCJiIAHHesh1aKh4cmNyDRi6X3Q53SF6JNWMXiDwbW4AbYM9+/OClML+Qw5/s8curAw2DPY1AZhXZzr+q7984xHfTi8cg63Z9JgGBsNwb0WK0YfJ6Ap+CwDhqfJq2W84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447539; c=relaxed/simple;
	bh=/oYS92t78LsjtBRAu2wTfiubNqaf7k6aYu+wQ42Dlp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shSWrES5wknKDdDgr2bQYsVlPMLODEh7+rtLxehFQKT4A1cWD0bkGpznIuRKyJ9sRx0pmX6R9iOeW0OkvvtQPgY+sTWYLUY/IpwRID2+bhDE5PvML7RQ2MVNh4JZhpZLJ4zfa0fE9fhDgcMUlvjX0xvX2jAlEAw5JenM1jOU2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THGAJerI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A7EC433C7;
	Tue, 26 Mar 2024 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447539;
	bh=/oYS92t78LsjtBRAu2wTfiubNqaf7k6aYu+wQ42Dlp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THGAJerIDhr2e97aM7xHDFFhNVDgNVOoQLzkMlbvDQCGhE9sPoFrZyfuy2H8MgTjf
	 CqEPlNGfwATXIjPnyLcKVRQrWYg7KCiINzEDJFoyXmJOqDeCnPHeVHo6wnbgLaA8MK
	 +gHIYG5ksqjqFJHqk9OPDk8c7cmJhZmBnajWXyXy8cKcTobUfcB4BZJ+4mPcoYMnx4
	 LAHodiEmwCXkkZp/85dinuNAVfn/15TYoh8cvU9hkanDem5AJM+UZZy2mMnTk5n+ci
	 Vik1eBJpRwdcio63M1j85HfKFctIqcgZWl0zoc8uqMt9EJlnGA7EJJL+GxazermINO
	 yo67UtsjKZTIw==
Message-ID: <6ce6edde-67f0-4452-aee2-602af3d71ecd@kernel.org>
Date: Tue, 26 Mar 2024 19:05:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Igor Pylypiv <ipylypiv@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-3-ipylypiv@google.com>
 <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/24 18:53, Geert Uytterhoeven wrote:
> Hi Igor,
> 
> On Thu, Mar 7, 2024 at 10:55 PM Igor Pylypiv <ipylypiv@google.com> wrote:
>> Libata sysfs attributes cannot be used for libsas managed SATA devices
>> because the ata_port location is different for libsas.
>>
>> Defined sysfs attributes (visible for SATA devices only):
>> - /sys/block/sda/device/ncq_prio_enable
>> - /sys/block/sda/device/ncq_prio_supported
>>
>> The newly defined attributes will pass the correct ata_port to libata
>> helper functions.
>>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Jason Yan <yanaijie@huawei.com>
>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> 
> Thanks for your patch, which is now commit b4d3ddd2df7531e3 ("scsi:
> libsas: Define NCQ Priority sysfs attributes for SATA devices")
> in scsi-mkp/for-next
> 
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
> 
>> +
>> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
>> +
> 
> [...]
> 
>> +
>> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
>> +           sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
>> +
> 
> When both CONFIG_SCSI_SAS_ATA and CONFIG_SATA_HOST are enabled:
> 
> aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:(.data+0x110):
> multiple definition of `dev_attr_ncq_prio_supported';
> drivers/scsi/libsas/sas_ata.o:(.data+0x260): first defined here
> aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:(.data+0xd8): multiple
> definition of `dev_attr_ncq_prio_enable';
> drivers/scsi/libsas/sas_ata.o:(.data+0x228): first defined here
> 
> Making both new DEVICE_ATTR() declarations static doesn't work,
> as <linux/libata.h> contains a forward declaration for the existing global
> dev_attr_ncq_prio_supported in libata:
> 
> In file included from include/linux/async.h:14,
>                  from drivers/scsi/libsas/sas_ata.c:12:
> include/linux/device.h:156:33: error: static declaration of
> ‘dev_attr_ncq_prio_supported’ follows non-static declaration
>   156 |         struct device_attribute dev_attr_##_name =
> __ATTR(_name, _mode, _show, _store)
>       |                                 ^~~~~~~~~
> drivers/scsi/libsas/sas_ata.c:984:8: note: in expansion of macro ‘DEVICE_ATTR’
>   984 | static DEVICE_ATTR(ncq_prio_supported, S_IRUGO,
> sas_ncq_prio_supported_show,
>       |        ^~~~~~~~~~~
> In file included from include/scsi/sas_ata.h:13,
>                  from drivers/scsi/libsas/sas_ata.c:15:
> include/linux/libata.h:508:32: note: previous declaration of
> ‘dev_attr_ncq_prio_supported’ with type ‘struct device_attribute’
>   508 | extern struct device_attribute dev_attr_ncq_prio_supported;
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/async.h:14,
>                  from drivers/scsi/libsas/sas_ata.c:12:
> include/linux/device.h:156:33: error: static declaration of
> ‘dev_attr_ncq_prio_enable’ follows non-static declaration
>   156 |         struct device_attribute dev_attr_##_name =
> __ATTR(_name, _mode, _show, _store)
>       |                                 ^~~~~~~~~
> drivers/scsi/libsas/sas_ata.c:1023:8: note: in expansion of macro ‘DEVICE_ATTR’
>  1023 | static DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
>       |        ^~~~~~~~~~~
> In file included from include/scsi/sas_ata.h:13,
>                  from drivers/scsi/libsas/sas_ata.c:15:
> include/linux/libata.h:509:32: note: previous declaration of
> ‘dev_attr_ncq_prio_enable’ with type ‘struct device_attribute’
>   509 | extern struct device_attribute dev_attr_ncq_prio_enable;
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Perhaps the new attributes can be renamed?
> Alternatively, the DEVICE_ATTR() can be open-coded, so the actual
> device_attribute structures are named differently.

I think we need to do that because I do not want the attribute name to change in
sysfs as that creates hell for the user to control a feature that is identical
beside the different transport (which the user should not care about).
I will send something asap.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Damien Le Moal
Western Digital Research



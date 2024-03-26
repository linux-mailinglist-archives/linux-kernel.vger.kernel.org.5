Return-Path: <linux-kernel+bounces-118745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D388BECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AFCB22827
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C625CDD9;
	Tue, 26 Mar 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ooJuTx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31670CCC;
	Tue, 26 Mar 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447622; cv=none; b=bgC40Q18K6ycYfa1BMDBJPmjjgUzC9AHb65gS+0HD7kF5td/lzM4iWMUcpJI/yhR/uPZi0cSWcUkGBQmqYEtcUD5t2hNzUiiuHDuMnd9RBaciZAPJeh+iw3YsKPTgStC7gHq1d05ou6FGkCsAZdtdzgaAooVnGdstNwhNE96f+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447622; c=relaxed/simple;
	bh=U4EdSS4ABUOTzZjhVULdw5aeTTxo/JKgfI7ODcfDDtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmMY19+pTgKPqqc6flfobbCXyI06vHpWa5/2g+nkQ79R6UjrxHeV4Dc5TZPyBLEX7l6Pk3NM7ZInUwHlL2NFJV5nVwMgvxHcwiGYSY2SqmPi9xmQxKpSM3CfLe2e2utfmtyETjLayCZvLE+57LB+aNEh1+kLVCl657zjAGGPGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ooJuTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81130C433C7;
	Tue, 26 Mar 2024 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447621;
	bh=U4EdSS4ABUOTzZjhVULdw5aeTTxo/JKgfI7ODcfDDtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r7ooJuTxZN+PNiPnccb67g34KjJFZGCbDEgFec7vlUu1ajdengm+9RmR5ora7u1Bv
	 jbfwicklE0lImv+7AHkT8Ep/VdsKhRmeMG6UxrolnJ/ZzqEFl7pNfUgvwonKbip4hX
	 r+/Yg367izpOMHHu3oKVpwsGFPu0chGtDgmxAVKs6sKAqMYx2dJagTcKGVYHwXhHhZ
	 wml/UNgn2xqfhxKlSbephOrUcJLtFgoqjvZk8BSEuDYtEkpx8L8cCrnExrP/1wb9Lk
	 ODqAwMdItZqnS/Pzh8wYphLB67vqAqvbENX/0iLnGHLNYv8ydBq+ejsL+ZWZy2j2K+
	 kY2BYUifmV2gQ==
Message-ID: <66ad274d-9890-411d-9fba-90fed2eb33f5@kernel.org>
Date: Tue, 26 Mar 2024 19:06:59 +0900
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

I have both enabled in my config and I do not see any issue. What is special
with these on ARM ?

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
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Damien Le Moal
Western Digital Research



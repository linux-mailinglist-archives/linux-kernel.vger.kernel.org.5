Return-Path: <linux-kernel+bounces-118925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7288C148
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862431F3C27F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29986F060;
	Tue, 26 Mar 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SygXXOfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5B6A8DE;
	Tue, 26 Mar 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453963; cv=none; b=iwi4UWVrdpFLnKkuKXQTBXUQgvenW0DnqRXqYLfPA1vaZMNAGBQBGmXgb5zaNvTRba3RMsm5VJZHnfphzI1eb4s/t2tl6VTS6MEf4Eqhz2RqmGBDlx4IKiXTye/duyHOvzzTVbgHF/U8cEO0jEuKAmWbvNSxjrwP3Q7/ySiX/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453963; c=relaxed/simple;
	bh=nYG+dP/QZk70U+XbmJJl1dpLEwmh2Q+q6qQlE/n2W4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs8g466YBWaEwqvoV26AV67cVBwom1DhmWprLyweAafO20yQ5Ff3IwzlRlJExy5Nn8NP9Rfh8dTI/ZGLDofCaK7NmyKSTFnSpDTnwqgSrtshkEhiXH2hVS6sWUlu0DMRCKIKqPcYVmWoeBFaOj67M+KSC/GlyeCZzGZjTH4gpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SygXXOfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CBEC433C7;
	Tue, 26 Mar 2024 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453962;
	bh=nYG+dP/QZk70U+XbmJJl1dpLEwmh2Q+q6qQlE/n2W4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SygXXOfkbDpSe7BF50lIgn3oe3ELQH9a+hI8VaUA+HqWMf8X90Zmn+0l+r75nDzRh
	 +YGIheyFwuJPFoaykgrje2oVqYpt/eDlBeE6NPa622Uyhpu5pJ0cwoVFR7nS3wVd4v
	 jaB0b1wzZhD5wx+cBV4C0jZjaKf2UjTviMJkgbVMgCVE70h58n+iwJ1fOsDtN32Rt1
	 x0origrtdobdFQyPRrV8iwFhGWU6DA2GoJ1Uey8qZTtExHwo1NNuTTHpocoPKmheQo
	 9nYoSUT8iudonnZHacmjrTCuH9rWBtiGFMZQDj9HSp9Igd+NyBp8PmaHrRV0YDTQKF
	 OXuLo3czSohUA==
Message-ID: <f05fa557-786c-46cf-a662-9f5b8dac8c8c@kernel.org>
Date: Tue, 26 Mar 2024 20:52:39 +0900
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-3-ipylypiv@google.com>
 <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com>
 <66ad274d-9890-411d-9fba-90fed2eb33f5@kernel.org>
 <CAMuHMdXA3dD=+oVgZ5cLdWdNHp+VdRCH0+L_kAPRQ0eaANAE+A@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdXA3dD=+oVgZ5cLdWdNHp+VdRCH0+L_kAPRQ0eaANAE+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/24 19:16, Geert Uytterhoeven wrote:
> Hi Damien,
> 
> On Tue, Mar 26, 2024 at 11:07 AM Damien Le Moal <dlemoal@kernel.org> wrote:
>> On 3/26/24 18:53, Geert Uytterhoeven wrote:
>>> On Thu, Mar 7, 2024 at 10:55 PM Igor Pylypiv <ipylypiv@google.com> wrote:
>>>> Libata sysfs attributes cannot be used for libsas managed SATA devices
>>>> because the ata_port location is different for libsas.
>>>>
>>>> Defined sysfs attributes (visible for SATA devices only):
>>>> - /sys/block/sda/device/ncq_prio_enable
>>>> - /sys/block/sda/device/ncq_prio_supported
>>>>
>>>> The newly defined attributes will pass the correct ata_port to libata
>>>> helper functions.
>>>>
>>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>>> Reviewed-by: Jason Yan <yanaijie@huawei.com>
>>>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>>>
>>> Thanks for your patch, which is now commit b4d3ddd2df7531e3 ("scsi:
>>> libsas: Define NCQ Priority sysfs attributes for SATA devices")
>>> in scsi-mkp/for-next
>>>
>>>> --- a/drivers/scsi/libsas/sas_ata.c
>>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>>
>>>> +
>>>> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
>>>> +
>>>
>>> [...]
>>>
>>>> +
>>>> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
>>>> +           sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
>>>> +
>>>
>>> When both CONFIG_SCSI_SAS_ATA and CONFIG_SATA_HOST are enabled:
>>
>> I have both enabled in my config and I do not see any issue. What is special
>> with these on ARM ?
> 
> Modular or built-in?
> I have them built-in, and it fails on arm64 (with renesas_defconfig,
> which is not upstream).
> It also fails with shmobile_defconfig on arm32, after manually adding
> CONFIG_SCSI_SAS_LIBSAS=y and CONFIG_SCSI_SAS_ATA=y.

Hmm... That must be it. I did a modular build.
Will check that again and send a fix. Thanks.


-- 
Damien Le Moal
Western Digital Research



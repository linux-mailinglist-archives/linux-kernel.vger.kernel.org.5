Return-Path: <linux-kernel+bounces-91409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D587111F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CB8283CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84707D07C;
	Mon,  4 Mar 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq4wSOOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BC1E4A2;
	Mon,  4 Mar 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595477; cv=none; b=YM0dwI5zBI9yHSFGby7IUfPvNNJP/dKyLGJUrIV69Y+OXim3Fo3GYCeUc4JJAu3YlIROzGTdPyv+SZijDiFavsZOAnPCqDxyglJEdf7ZKtVcRAzLEu21zuEwQjjA9VhzAhJtRB4/5xb1EuLSW0RlzqO2zJ1MkgL9ZD6rGMgW83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595477; c=relaxed/simple;
	bh=rIorM/h/3cCcoMG9xBOuBOOed/zsrwBaA2MJyxxSyPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6/DVvIJm0omH59KKumAjNihRs3pnXw1tAAzx5vuxBdtKQLEcBSgXQbxPFko6K/zU99x+29/laVCLnyE0uozOK/IRWVSZVYFjcC36Rwev9s7R/lVId1kdP/RRSOKmRdld4ddzLh3VBt6mP8FJ/f+iMm+PYO/PA4x4Iau0jTJxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq4wSOOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A7DC433C7;
	Mon,  4 Mar 2024 23:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595476;
	bh=rIorM/h/3cCcoMG9xBOuBOOed/zsrwBaA2MJyxxSyPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rq4wSOOwj1HP5xzLdNOTkAhtJKvgYbw5GwbemIqbWS+Wbys88A84z3gv0fxpw3u1x
	 j6DMisnkB/UTn9je3sNf9CjVcZO/NH3reHkmc53gTjyL1Vj3cpIrvI0/g23sfqpAeo
	 /wNq53ZypJXu3b6iHH7/hxnx0VHV3AKsyjjNlESO+g8w+jYwRU01jz3ncWu0UiaENx
	 AqEYTEx5LKqzj5SAEkdFgNf/NJWqXfs73wDW2XtkWA8Fdc7mR+WLuRqGR+AsGVbTlA
	 xMU41AWomodQ+hlxHACYDuRgXxHulXB4LgNbS+319Gk+0dMz5TcoRrHrosrNEfj+iG
	 sAgqUzIR/bfZg==
Message-ID: <50427a28-1038-48ac-b3a3-6255267f9831@kernel.org>
Date: Tue, 5 Mar 2024 08:37:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304220815.1766285-1-ipylypiv@google.com>
 <20240304220815.1766285-3-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 07:08, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/sda/device/ncq_prio_enable
> - /sys/block/sda/device/ncq_prio_supported
> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
>  include/scsi/sas_ata.h        |  6 +++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 12e2653846e3..4ecdfa2a12c3 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>  			       force_phy_id, &tmf_task);
>  }
>  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> +
> +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool supported;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON(!dev_is_sata(ddev)))

WARN_ON_ONCE() please. Same comment for all the occurences of this check.

With that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-kernel+bounces-90216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5186FC14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5DB1F22CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7147199C7;
	Mon,  4 Mar 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Kwl55zxb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F818EB4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541801; cv=none; b=uJuCHzgbE4eNGWwL8OJW5gflAz/p0ZRJRGVyb6zl4u19jQcVrK4wFXc2JkOVz2ny+9kbYX+3Z757NRVJ/sV2LDe+vAxSiIvQFrV36txwuxAp5KojX3uCsJPCPPtoI8tOwM+1s9ycz8MU9f7jGBTWgFy7nQH6rW17CHk8/lKsWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541801; c=relaxed/simple;
	bh=pCnufLy/HtQxFmJvCJIBchOyotPLyFf9InIAEZFtzyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljcMZ4SQ+LTgTUph6z1dH3DqncW7MuMpABBU3liQ00y/KG1/wSROnb58rMCjILkCxu6ZWt8ONqOCcyzUi50ivrlLmm4uwOf6zsod5conv82xJP4gIAKiLSDLtfTEsQHUhhUvdo0MG+H+BbhifWS1C7/COGbaQU/Qdg87070u7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Kwl55zxb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5747549a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709541796; x=1710146596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5Tdy8e2M2LwA/AfaCGwdWZIPI/u425rq1VFhpOUNQA=;
        b=Kwl55zxbriz3widw4ypAfXgsfjohHhIcVTW9s8csoN6s68Tf+plwyiKeHzpxnEa7jb
         LCSGRAiiEWRj0O2lxFE9YQjKtO+zo8gOQsvqFEEw2AuBYMMQbnuk+mJ9xlYoJgqL6nCX
         RkzVhvILqUZJyynV9XoSbRLF/+wo8ho1AruF+ODajQCxvcflz3nNzILZhjBdmnhKvbVa
         JyJpYHhmIt7AsybYrt81ACoDUftq4/cTxAHwwF4qEc9kvm/b+eMHl+ZsE6EgWk5vZu8a
         z1JJpjrR0tCKAy/komjO4jAY4vk4jB2oYcu5CWmd1iT/XRtXMdbKEPGh8SAyYcjxxM6L
         RNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709541796; x=1710146596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5Tdy8e2M2LwA/AfaCGwdWZIPI/u425rq1VFhpOUNQA=;
        b=BBMMlLvBPaWNpSj0ja3OEvyL+Y0yVph3B27/k8ROPx4zJoztdznrIIUWNSzdkByK3m
         meDu6s+swzKSnl4Oe8chF6ecpnsXJrI62eaWTKaFHlm96PXF8pVPna+9699ZF+ofxtMq
         Nz0ZS+siy+jUcmLF2nTm9mJkDeCWaxIoH2jJOCPgDv83OKHqFLxYUzX/0QXFhVwp7mLk
         ZfOW2QW6bW6O2fraoUZs0TVbSqdIgsCOS7vpks8mBlVghUwjAnuyIoqzKN8Lreqz+qlu
         fbEbskiZdjpKFrmAQcr7hPQHMXNJY2N71FkP3chSBcJ4MXkuRkVjnXMDl0JAZxesjtHj
         FKyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNinJBU9scK/xFmTkemRMP89MPDXXJkBq59CU9I11byCMPed+cEWDBzWvyeD+RA7uZkxobev5/0j+AGNcsgqvRFTz7A4Boa68D0dvk
X-Gm-Message-State: AOJu0YybHAV69o3dZNVZkoxMkbelP3hqelpEI1W2JQQvoF+ZjKyHbkJK
	WWTJvVEDE7MBqVTbC0KC3YVDV6mfbgabBULvUMRIOsn6bwEeKMeCFq/Q4LpSbla6tOXZP7TDcmm
	oaRXVNHeaYD3rfe3bVfzOIjmLJKN0YyBjgEM+Hw==
X-Google-Smtp-Source: AGHT+IFh3iQrNw66aCjZWvQhrTZ7/Vd8fhUefXxPExNqJlkSHixSsXeU4cwRVs5xuqmPK6lnUcEq9LU+l+TqakQxmJs=
X-Received: by 2002:aa7:d04c:0:b0:567:2870:1f1c with SMTP id
 n12-20020aa7d04c000000b0056728701f1cmr2747833edo.19.1709541796556; Mon, 04
 Mar 2024 00:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com> <20240302201636.1228331-4-ipylypiv@google.com>
In-Reply-To: <20240302201636.1228331-4-ipylypiv@google.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 4 Mar 2024 09:43:05 +0100
Message-ID: <CAMGffEkP4yCX8ngoApbStNdeBL6DbAcwa+U9O8q5gF8+WyCEPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 9:16=E2=80=AFPM Igor Pylypiv <ipylypiv@google.com> w=
rote:
>
> The added sysfs attributes group enables the configuration of NCQ Priorit=
y
> feature for HBAs that rely on libsas to manage SATA devices.
>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>  drivers/scsi/pm8001/pm8001_init.c | 1 +
>  drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm800=
1_ctl.c
> index 5c26a13ffbd2..9ffe1a868d0f 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] =
=3D {
>         &pm8001_host_attr_group,
>         NULL
>  };
> +
> +const struct attribute_group *pm8001_sdev_groups[] =3D {
> +       &sas_ata_sdev_attr_group,
> +       NULL
> +};
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index ed6b7d954dda..e6b1108f6117 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht =3D=
 {
>         .compat_ioctl           =3D sas_ioctl,
>  #endif
>         .shost_groups           =3D pm8001_host_groups,
> +       .sdev_groups            =3D pm8001_sdev_groups,
>         .track_queue_depth      =3D 1,
>         .cmd_per_lun            =3D 32,
>         .map_queues             =3D pm8001_map_queues,
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm800=
1_sas.h
> index 3ccb7371902f..ced6721380a8 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm800=
1_ha);
>  void pm8001_free_dev(struct pm8001_device *pm8001_dev);
>  /* ctl shared API */
>  extern const struct attribute_group *pm8001_host_groups[];
> +extern const struct attribute_group *pm8001_sdev_groups[];
>
>  #define PM8001_INVALID_TAG     ((u32)-1)
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>


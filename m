Return-Path: <linux-kernel+bounces-118723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FD88BE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CBC1C3BD02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB96BFD4;
	Tue, 26 Mar 2024 09:53:49 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470D5D734;
	Tue, 26 Mar 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446828; cv=none; b=FjOJXXm+wY962Om0cFxxgbKUCNL73Q4wmAAgGszNlZabGAID+SEPNGCrg/2LG89QkqGAhRvSPfPRChI+JL9DcbVwhWk+HrEqy8o5w6tXT58UVsTJNZ4lSwGWjrmZOrmZaDP1teYK36zh5/m1gLgjiRJ+ODX0SzR5Cxt8wWAGFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446828; c=relaxed/simple;
	bh=SPMt9sPXUWG+6brPuvlSRI7/wEP/OhYVJDICeA+oquE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feu5yccASxWlatjrBBMP91KtWV4zWQUEqm4ggpiL79PA89/8AykRvCzd87ryi71nAfDURNznqGEUJxC9BiJO84fsvq4/YdIXZvImIfcdT9kz5UgBAlZb7O7aq4ZNLVhmmNYokNfcQGypTUG4hsp8v3b/lEgpqJp1k6UV+eP2unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0579a931so57290647b3.0;
        Tue, 26 Mar 2024 02:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711446824; x=1712051624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYG112uU2LU/aG30QDJAbplxe7xFJ5VktIX6iywVcNY=;
        b=OaJ9i5d4+/yhpKJxiUI+1CVIe8EVysvZlX4si8HivJ/22Cn3iEAukB+FanfclgxdUy
         65wlaEiuqImZsettx3SG5ZLcF83cgPesgfzZKj6TxuWfD4ribzU/W/MExq2kDsgDrJWu
         96xmYMATU168mC8mr4ElVF9WZEKdfvNd0a6iKJextJFeG3CoK4VP2XwXQtLhkINx7/TL
         oBPQ7YP0wsp96mTN05wGxGrU1sXMtlmUvMdkZDm6g/A3CsqLh9A6ccTKkxoDZm2DV+GJ
         D8tUq3o3PtTd660bQbJwrHf2jgGDbKb2wWxrMm83tTe0nQA/QP4hr6A8IF9ZI+3v+y/z
         8dPg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/VPXzv0lvE4uzKjzB4ahynq5fUQKjpUJbjtLnMKQsUgeYZrp3R/pW/shp34a+1SMah17SlAiCXIwAyyjjhmsjwm18JWk39CUB44AqhZqm4DQZRfOdA7lgxZBUE1l6fiXP1RCntKWCViWu8+IyCgRgSN2EVzTKC8VYzuw2da/Ia1/Rw==
X-Gm-Message-State: AOJu0Yz285jHuqiF0/UqtHVCZrUZHpXG2KcsHV+gTwrOT01vgHErGIyj
	af6FuvekgnvP2RjAtMtPoBYyReOPO7QDbndgGUTzzOwgx0uIzp46RLwDCUMBYbw=
X-Google-Smtp-Source: AGHT+IEgarFDIiVFFBTPp/+8EOjmJfMZ6VCYGpbs0Go20VbeJYn5rKF+ceXxXuvWF5eppaaGfW60zw==
X-Received: by 2002:a0d:d48a:0:b0:60a:16b8:1042 with SMTP id w132-20020a0dd48a000000b0060a16b81042mr7799749ywd.16.1711446824182;
        Tue, 26 Mar 2024 02:53:44 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id gw8-20020a05690c460800b006111be0eaefsm1373172ywb.50.2024.03.26.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 02:53:43 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc71031680so4666294276.2;
        Tue, 26 Mar 2024 02:53:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdWtW7UiRuQmAjofQ2dvRCDB1zudD21aZ96hG0sThIuCq9L3LrTku/LUsPx+xvi8IOBRU1Fa/AYk+Bi1blucA6Td4+TC9U2EOnbGpMKfUiL0Y74kmW+1KV1nAUifg3z5+blm3T+vR40WpiwI35JXFdjoUH1BHPWNxTrmz//DQs9V80iQ==
X-Received: by 2002:a25:db08:0:b0:dcd:5c7:8466 with SMTP id
 g8-20020a25db08000000b00dcd05c78466mr7990390ybf.44.1711446823406; Tue, 26 Mar
 2024 02:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com> <20240307214418.3812290-3-ipylypiv@google.com>
In-Reply-To: <20240307214418.3812290-3-ipylypiv@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Mar 2024 10:53:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com>
Message-ID: <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
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

Hi Igor,

On Thu, Mar 7, 2024 at 10:55=E2=80=AFPM Igor Pylypiv <ipylypiv@google.com> =
wrote:
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
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Thanks for your patch, which is now commit b4d3ddd2df7531e3 ("scsi:
libsas: Define NCQ Priority sysfs attributes for SATA devices")
in scsi-mkp/for-next

> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c

> +
> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NU=
LL);
> +

[...]

> +
> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> +           sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> +

When both CONFIG_SCSI_SAS_ATA and CONFIG_SATA_HOST are enabled:

aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:(.data+0x110):
multiple definition of `dev_attr_ncq_prio_supported';
drivers/scsi/libsas/sas_ata.o:(.data+0x260): first defined here
aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:(.data+0xd8): multiple
definition of `dev_attr_ncq_prio_enable';
drivers/scsi/libsas/sas_ata.o:(.data+0x228): first defined here

Making both new DEVICE_ATTR() declarations static doesn't work,
as <linux/libata.h> contains a forward declaration for the existing global
dev_attr_ncq_prio_supported in libata:

In file included from include/linux/async.h:14,
                 from drivers/scsi/libsas/sas_ata.c:12:
include/linux/device.h:156:33: error: static declaration of
=E2=80=98dev_attr_ncq_prio_supported=E2=80=99 follows non-static declaratio=
n
  156 |         struct device_attribute dev_attr_##_name =3D
__ATTR(_name, _mode, _show, _store)
      |                                 ^~~~~~~~~
drivers/scsi/libsas/sas_ata.c:984:8: note: in expansion of macro =E2=80=98D=
EVICE_ATTR=E2=80=99
  984 | static DEVICE_ATTR(ncq_prio_supported, S_IRUGO,
sas_ncq_prio_supported_show,
      |        ^~~~~~~~~~~
In file included from include/scsi/sas_ata.h:13,
                 from drivers/scsi/libsas/sas_ata.c:15:
include/linux/libata.h:508:32: note: previous declaration of
=E2=80=98dev_attr_ncq_prio_supported=E2=80=99 with type =E2=80=98struct dev=
ice_attribute=E2=80=99
  508 | extern struct device_attribute dev_attr_ncq_prio_supported;
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/async.h:14,
                 from drivers/scsi/libsas/sas_ata.c:12:
include/linux/device.h:156:33: error: static declaration of
=E2=80=98dev_attr_ncq_prio_enable=E2=80=99 follows non-static declaration
  156 |         struct device_attribute dev_attr_##_name =3D
__ATTR(_name, _mode, _show, _store)
      |                                 ^~~~~~~~~
drivers/scsi/libsas/sas_ata.c:1023:8: note: in expansion of macro =E2=80=98=
DEVICE_ATTR=E2=80=99
 1023 | static DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
      |        ^~~~~~~~~~~
In file included from include/scsi/sas_ata.h:13,
                 from drivers/scsi/libsas/sas_ata.c:15:
include/linux/libata.h:509:32: note: previous declaration of
=E2=80=98dev_attr_ncq_prio_enable=E2=80=99 with type =E2=80=98struct device=
_attribute=E2=80=99
  509 | extern struct device_attribute dev_attr_ncq_prio_enable;
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~

Perhaps the new attributes can be renamed?
Alternatively, the DEVICE_ATTR() can be open-coded, so the actual
device_attribute structures are named differently.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


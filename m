Return-Path: <linux-kernel+bounces-118769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D738188BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0F1F63AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10DB6BB39;
	Tue, 26 Mar 2024 10:16:17 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C35CDD9;
	Tue, 26 Mar 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448177; cv=none; b=pGfcNRk2t8NYf+tE2HPD5FIRu+b25QgTdZ9nyVEDXk00Dv/eeN3GmiZe3/FWcWrqeBZwz3iolP/b+FcLLX0w54ElG8DpWG6M8HTo1MD491FatRjx2lOSJCSaaiPN/iLa/lfkGf55WNCMZzS6wuP9zjrg1E4de6pA4X/FJ1ESfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448177; c=relaxed/simple;
	bh=NhGQTmGKSxv33TVHtEGQ4NQt1AfCFjbVawHdu4n5ipA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYq0rYTk+xurYHVW07cnUvN/AmA4vfkj0kHClbKbNG9kfNMXROI8DD9QxJzcSRad1xDKPJXp50ysBp7LWdvnAxgyYXye00yyrHX1YaCdPRe27hX8k9kwKWjcXRiDxikxqJqJDtWGz+IMIpGT12xhwukYAIYdi7pVTFT5NQEHtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-611248b4805so37000427b3.0;
        Tue, 26 Mar 2024 03:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448173; x=1712052973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVHG0Rtzv117KVflCUzfWxkqshDT44uXGdbPYbWV2xU=;
        b=uTzlyZRO685W8yT6yHh13129bfx1UsyT9jiUYrqgdIJ5FkVtXaB2H5+f3gplHU1erQ
         +D6mUj9OVr2lYcs15vc4zTYZfR3mysAWjH3B/NEDngcVJhdvZPMWIXO1vjrT5duANR1O
         0wI90a7JnpFfLYKALYTX8Wwuo38so81xHCLQ920RhgxQBmkqYx5WTSTPFuIzjy/jEXO+
         VkK0d6+xmpbF8ZDXmmyk/Df4EMjrKQfi+vZXBpNflxSHWnv3AdU9lTNLsktbxeGmuGFk
         wW5FbloDR5EcePv2b6MVbm2ELN5M9R9/z4CInO6jEHOEyVwj2F/FFZhK7Qqgu/LifHq2
         waEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyt2cp75HgiCCspnIH5uKDysh5mNQr4Gab0bjabkzLw/upi8JbBcRtyuGuVKFGgLO2jTc8jjGI1030v+J3Gy5glGa3tAaltNwitz+iuu1FwYlTt5Ni6KYEJbzUlWKaxd4MBd7E/++I8N1V+Oo0LAbQD/GXyxU5i7GqOhqt/H/RXNBZ1A==
X-Gm-Message-State: AOJu0Yyr3LXrjP0rJt4bIStZnkzqqFRu6rmAE6q99JrwRXHZntSXlRy9
	IDtkDGLtNIpTKwJmXxiyGCskX+0rE/RK5DwFLLLAgLbEVV4nDeaYETo+4Y85UuI=
X-Google-Smtp-Source: AGHT+IEZkV+EXitMUSg/u22YMdyhOSDnQvZVvWFotaGefLKKcClYoT+Uv43ScbsOigQFp5fxlUqIRQ==
X-Received: by 2002:a81:4f02:0:b0:608:597b:bca with SMTP id d2-20020a814f02000000b00608597b0bcamr612705ywb.36.1711448173554;
        Tue, 26 Mar 2024 03:16:13 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id n7-20020a81eb07000000b00610e03c9fe8sm1352566ywm.103.2024.03.26.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 03:16:12 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso5142017276.0;
        Tue, 26 Mar 2024 03:16:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmJ5qwS8P8cym4ZzMdEgCJm+2LMc/rHlkC7ygkTGzK2/xY52nrPwnDV2nV/llQMAenraJavP05DjxCRv38o4+VlDk79ocs9C9oQMGWB7FtB4Lrkiw9jlYqgu5KP0WL2aCf7zW9wnG/VG+6LmKbZlpoqrat46q9rkUnD0pzxnN1daQHNA==
X-Received: by 2002:a25:b314:0:b0:dda:a608:54bf with SMTP id
 l20-20020a25b314000000b00ddaa60854bfmr565254ybj.56.1711448172632; Tue, 26 Mar
 2024 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com> <20240307214418.3812290-3-ipylypiv@google.com>
 <CAMuHMdWxVbT=f+kZ58urwGhYD9RfBnu7u8oLAyrx_riU8OGt0w@mail.gmail.com> <66ad274d-9890-411d-9fba-90fed2eb33f5@kernel.org>
In-Reply-To: <66ad274d-9890-411d-9fba-90fed2eb33f5@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Mar 2024 11:16:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA3dD=+oVgZ5cLdWdNHp+VdRCH0+L_kAPRQ0eaANAE+A@mail.gmail.com>
Message-ID: <CAMuHMdXA3dD=+oVgZ5cLdWdNHp+VdRCH0+L_kAPRQ0eaANAE+A@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien,

On Tue, Mar 26, 2024 at 11:07=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
> On 3/26/24 18:53, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2024 at 10:55=E2=80=AFPM Igor Pylypiv <ipylypiv@google.c=
om> wrote:
> >> Libata sysfs attributes cannot be used for libsas managed SATA devices
> >> because the ata_port location is different for libsas.
> >>
> >> Defined sysfs attributes (visible for SATA devices only):
> >> - /sys/block/sda/device/ncq_prio_enable
> >> - /sys/block/sda/device/ncq_prio_supported
> >>
> >> The newly defined attributes will pass the correct ata_port to libata
> >> helper functions.
> >>
> >> Reviewed-by: John Garry <john.g.garry@oracle.com>
> >> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> >> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> >> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> >
> > Thanks for your patch, which is now commit b4d3ddd2df7531e3 ("scsi:
> > libsas: Define NCQ Priority sysfs attributes for SATA devices")
> > in scsi-mkp/for-next
> >
> >> --- a/drivers/scsi/libsas/sas_ata.c
> >> +++ b/drivers/scsi/libsas/sas_ata.c
> >
> >> +
> >> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show,=
 NULL);
> >> +
> >
> > [...]
> >
> >> +
> >> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> >> +           sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> >> +
> >
> > When both CONFIG_SCSI_SAS_ATA and CONFIG_SATA_HOST are enabled:
>
> I have both enabled in my config and I do not see any issue. What is spec=
ial
> with these on ARM ?

Modular or built-in?
I have them built-in, and it fails on arm64 (with renesas_defconfig,
which is not upstream).
It also fails with shmobile_defconfig on arm32, after manually adding
CONFIG_SCSI_SAS_LIBSAS=3Dy and CONFIG_SCSI_SAS_ATA=3Dy.

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


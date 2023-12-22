Return-Path: <linux-kernel+bounces-9301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4381C3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440072835E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081F8F6A;
	Fri, 22 Dec 2023 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tJ5bP7eY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E448F40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87CB43F116
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703217458;
	bh=JGpihFWsF9iixc5XqhLyXNHyhGttLbiIhZTaqynK7Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tJ5bP7eYoQ117VtVyndEbn8GukW3B0j/y2LaJRvkUlfYZT8NKvDgqd8KrS6usd44e
	 dzNLfrcxnzgCNKkKupXxMgsAoMHedS3BMQpZo1nN1fRXYeHnMHLK/KERe+mp8nzg8N
	 vpgHxmmHWq76PvFVj1rhftGn438AWRNWRmrJrSee/hbJrFd88MIjmP7vZqrA3nlhyM
	 t88AOpvrm1F95gRapReGoH3G1nVeHWalIUYtKkaa5TztIwgiF1S5n1QfRj1k0XX4mQ
	 ckXCuGg3zOfl/ah8qwUX5ByQjzkoOwbf9kpYnAv/E3XQULV/0rkKn85dbJ1VvYj8A1
	 DsnF1fzJLvbfA==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9dff5942fso1554856b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217457; x=1703822257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGpihFWsF9iixc5XqhLyXNHyhGttLbiIhZTaqynK7Zw=;
        b=wsHHI4OWV+uAGAJiCJk3PGYv9Fi0tmQJlx7B9ZnTyF8kAvkCH/3/0C7LTG2bElHfjr
         bfS6l39BXudvp/vrLnIA+78Tjs4704/SkgmkZgP8xxCPHfZ1LKtiNH3RhO3DzdebDStW
         xL3Yeb1TcaL9lsVVBdDQK+XJdcmkEBRqv/7DkcwqE7kfDKdX5L1hi3joe+F3ymzQ8XyO
         biSegin/8DikK63/0ZqCgoaE+JGtdQc/0FS3kHmZyOt9BnLbMBKh4Gv7qheKeRUp3Kwf
         5M3uLT/DNo2rpORzD+GJINFYLCLHmEh8Ayw6CZl4r64PpfTKn6POchRmwifdh9ZlLgHE
         GH8g==
X-Gm-Message-State: AOJu0YxGHHfPkuaOpxQD6GhV7w2Vt6uGMdYrRRTO+jpQae4w6MAWg4kJ
	H5ov59KhNgCHt0eP4ts9kBDKYEqbQ/hWy8bD1xaCtuoU6l1QGFTBqt79PFYcrCFmBPWlEaApVWq
	qSn1eOKo9/ZIzxoxfCC4f5NRqx4h0ETIAVSOdUVd2JVPMr1UUdP/9uo5gkIXVpDEMLqWqsC5G
X-Received: by 2002:a05:6808:1247:b0:3ba:e56:4778 with SMTP id o7-20020a056808124700b003ba0e564778mr909479oiv.100.1703217457530;
        Thu, 21 Dec 2023 19:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWuCwzJrUmfBFQeYMoS63SIHRgDlDtFwy9F+dhAUieflfH7adkv2VUijsgb6W9cxjNlcjKYZmq0wdezwp6XHg=
X-Received: by 2002:a05:6808:1247:b0:3ba:e56:4778 with SMTP id
 o7-20020a056808124700b003ba0e564778mr909473oiv.100.1703217457234; Thu, 21 Dec
 2023 19:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051350.392350-1-kai.heng.feng@canonical.com> <5a81eda0-5044-4088-9aba-cf725e6fca9a@roeck-us.net>
In-Reply-To: <5a81eda0-5044-4088-9aba-cf725e6fca9a@roeck-us.net>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 22 Dec 2023 11:57:25 +0800
Message-ID: <CAAd53p4NNX9c5pUJgv12V=s_1YJxM3=G+OCYTgcRPqSJVbdi8w@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell systems
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Dec 21, 2023 at 7:49=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Dec 20, 2023 at 01:13:50PM +0800, Kai-Heng Feng wrote:
> > The following error can be observed at boot:
> > [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62=
c5) [IPMI] (20230628/evregion-130)
> > [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (2023062=
8/exfldio-261)
> >
> > [    3.717936] No Local Variables are initialized for Method [_GHL]
> >
> > [    3.717938] No Arguments are initialized for method [_GHL]
> >
> > [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previo=
us error (AE_NOT_EXIST) (20230628/psparse-529)
> > [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previo=
us error (AE_NOT_EXIST) (20230628/psparse-529)
> > [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> >
> > On Dell systems several methods of acpi_power_meter access variables in
> > IPMI region [0], so request module 'ipmi_si' which will load 'acpi_ipmi=
'
> > and install the region handler accordingly.
> >
> > [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-=
v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-mes=
sages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/hwmon/acpi_power_meter.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_powe=
r_meter.c
> > index 703666b95bf4..b9db53166bc9 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -882,6 +882,8 @@ static int acpi_power_meter_add(struct acpi_device =
*device)
> >       strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
> >       strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> >       device->driver_data =3D resource;
> > +     if (dmi_match(DMI_SYS_VENDOR, "Dell Inc."))
> > +             request_module("ipmi_si");
> >
>
> This looks like a terrible hack to me. Is there precedent of similar hack=
s
> elsewhere showing that this is the "way to go" ?

Yes it's ugly.

The error happens in the ACPI ASL code, so it's not possible to know
if any method of apci_power_meter requires IPMI region.
I really can't think of any better solution for it.

Kai-Heng

>
> Guenter
>
> >       res =3D read_capabilities(resource);
> >       if (res)
> > --
> > 2.34.1
> >


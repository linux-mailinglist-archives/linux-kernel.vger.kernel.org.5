Return-Path: <linux-kernel+bounces-7493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180CD81A8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685D3B22059
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026C44B159;
	Wed, 20 Dec 2023 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CnC0/rBg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D224A98A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F0C023F16B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703110377;
	bh=ztD/RtxtcUR049JPC70sEXT6G1p0fRBcP6k1VF14xA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CnC0/rBgOJpyqdOiKtFGkwWonyv1HvXWmiE4fW1fSVhrB4jaY471QXHzaH0/TnRw/
	 yEvSEZp5PW4wzsS+NUf8kvuUI/XNgU830WDzD6QOyp5NLMIRTLQiYYJM7GPuP5k/li
	 tz/a6+yAIQnLpdvia8LTi9NhcRzKUIdPAGYcIouyH/6o9H9sTQQk4xZqZ564ISDQGG
	 GZIKbtnApUWFR+Ar414Xv4SAqwjKehTjai2LWH7WVtlOGy8I7gWKZLCs+YESKU4jqm
	 4Dj4dSLGR5Ufp48Yr0xYNlHT+Vyrb6WPYwwdqGVhEvfpMZ8Pp9fVQUvllnXwA6sX0V
	 OaNwMkml3CZFA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c641d55e27so84399a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110376; x=1703715176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztD/RtxtcUR049JPC70sEXT6G1p0fRBcP6k1VF14xA0=;
        b=dsPWr4h17/LITI136d+2djbbtHnVm0Sca31ruH66xEY5DlDn7B/+/2FKgkC+pkmo1f
         Jx7A/s5FpiChH6MK46nglBm6N2LGkm2i5Bx1zpUwcEl45pRKWGXCvoq/h+xDH7juP45O
         jVqSZ0T1yfQEMQL6ieiMT8RpYBsWZBTusQcbEMHfnTvMNCoIXS591hJGuypRrM0E4E6T
         3GtBADrQAj2zAxSz45c9Qb+LjHlDUgNwcfjUAKAC3EYpRPAJO1/YVgzl+8aShAo7egq3
         RbIkG0w4ERHQqFcTZqvaYyRYO8abYB6pjzOPy1+SyWGEXoEq/X2UBJYcOvw+W3WWA6BD
         uhWA==
X-Gm-Message-State: AOJu0YyZezbthLAPAxotPgiJlZqgDbRwseIsYE7uBIq1gSgWn0WSSdmL
	LJgVkuCQPc21hdBo2C9ifQmaOvMESFCyuwISiYzarQIUrn4N14HoJ0h/csHB4Q7CiQYpItbY+Ul
	3skMcguN6KEoTRQgTtoJt4Qw3fJijuDy7L+d58t/zW8eooUXoKoujX72Qi005J9pj
X-Received: by 2002:a17:90a:e38c:b0:28b:ee58:6af9 with SMTP id b12-20020a17090ae38c00b0028bee586af9mr89945pjz.45.1703110376313;
        Wed, 20 Dec 2023 14:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwEkSypqppxNa6DzbllkKPFL0WNHCiPNexIbWvv6ZYq0p0TeVf2IZN0vR33CJkyQadJGqioZXGZv/CcW4QuWs=
X-Received: by 2002:a17:90a:e38c:b0:28b:ee58:6af9 with SMTP id
 b12-20020a17090ae38c00b0028bee586af9mr89931pjz.45.1703110375913; Wed, 20 Dec
 2023 14:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051350.392350-1-kai.heng.feng@canonical.com> <d8e455b9-0a27-4361-8f92-9f1cb1fff537@gmx.de>
In-Reply-To: <d8e455b9-0a27-4361-8f92-9f1cb1fff537@gmx.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Dec 2023 06:12:43 +0800
Message-ID: <CAAd53p62bJcuHAZMnYuKqoi_YV+W0zOuyQTCvjcKMBoVP68QBA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell systems
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Armin,

On Wed, Dec 20, 2023 at 11:09=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 20.12.23 um 06:13 schrieb Kai-Heng Feng:
>
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
>
> Hi,
>
> this driver should be loaded automatically if an ACPI IPMI device is pres=
ent.
> Can you share the output of "acpidump"?

Yes it's loaded automatically, but it's loaded after acpi_power_meter,
so the patch only make sure ipmi_si and ipmi_acpi are loaded before
this module.

Kai-Heng

>
> Armin Wolf
>
> > [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-=
v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-mes=
sages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/hwmon/acpi_power_meter.c | 2 ++
> >   1 file changed, 2 insertions(+)
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
> >       res =3D read_capabilities(resource);
> >       if (res)


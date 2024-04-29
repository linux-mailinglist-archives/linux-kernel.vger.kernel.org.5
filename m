Return-Path: <linux-kernel+bounces-162652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A28B5E97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865922836A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF3839FF;
	Mon, 29 Apr 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/yelYC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66F839EB;
	Mon, 29 Apr 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406790; cv=none; b=FBw5+XGaYhrzRG3s3nFq4nfxhPzLaShXMcsHUQS32DfZIP/+m0kggFw963XId+nvxY3gGuN/ZUCkgALlqmY3u4R1DZ0RLMz4/NxsX25qFRgHjuGVktd/KY75ZbjcQXEXOTivKJx3QlEAefSRQb13h/7XLri/5kL6ZpAYnvDQ9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406790; c=relaxed/simple;
	bh=afERztb9pVx17pXtbd9iQT9EUE2xeuhnB2fps9eTU2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saUXrxLnuqAl56pHCTyebcxO5zwPoopYRHTwbsC80jgOCF/ibI2oZm2yTJ0r5rnC3I89SVxraorbsnFbmUlLImdMdkAIogjkxKu9pCbsK7yvpypVHafvZoibBAk5uTvy18P9Lx5wkzsxdCINBHR+zyvQVH+h2It7DD3cxUxVWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/yelYC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39557C4AF14;
	Mon, 29 Apr 2024 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406790;
	bh=afERztb9pVx17pXtbd9iQT9EUE2xeuhnB2fps9eTU2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A/yelYC3XQWHy2t462WvCtZugMJLgKpzXy9mNaFTqXtCTN38WaZJY+s+D1hNbr3DR
	 W87uOgUVp1h2JuRBjRspQ4TRUQgVA1qlVZV90Mipt3fsFA7sAebneGw1R/BuKfN0Zu
	 2oDesbX775ljUihmmaC9+1HRd+Gz+5bQ8ypJxRtMajNM9HgclDh4il8FquIrirJ+ST
	 9aY9S8LjYNFuE6fmQ/epgbkfJp6+P3d/ioBTPkcxPdrEDuxWHOXH4yjTWE/RMQUDUF
	 URj77m7f59ZyhPeeAYZ1IRLculf0Ya3VtidaPSKQTogOBOYDdyuDlaokQkeIyVqfuY
	 79R+4A3n9kv1g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5af609de0d2so452074eaf.2;
        Mon, 29 Apr 2024 09:06:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHZSpEmAd+BDZX4XI3aK41ZT9hcXoHeLkaR+/AblOzukJBS/q4yLgdz6/ss4ciBrdCbYffT5JzOy9SN3MNfnrVVvILUpNPyIaD8cAn4/fiYkxzmJmrvIOcmhCyb1Nhqvq4T1saJzKeyA==
X-Gm-Message-State: AOJu0YxXiuKa9Cv2ZGvesiyxkjp+AmaIT4w4v7zmC8MFxbGL1AmfMwf/
	o7Q11P10apsrU2js4glZbKg6C5SrV+JMbBvijQRcOG8phzCJ3ahuVdbBIXSHoEnF5BvKOpmvWgw
	CEEluGtOa99hAtJn+2oxC1TNyNxs=
X-Google-Smtp-Source: AGHT+IHyLxx0VBY2oJjwiSL4wBe2DRBpBa9uTPPMyX+rXpIuBc+hT9rzo9R5LOk970vfWB5Ip/O//eSUit0kTDrunuc=
X-Received: by 2002:a4a:be9a:0:b0:5ac:6fc1:c2cb with SMTP id
 o26-20020a4abe9a000000b005ac6fc1c2cbmr12303338oop.0.1714406789435; Mon, 29
 Apr 2024 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2741433.mvXUDI8C0e@kreacher> <278b47946efd7f67229e26335c419570871427cc.camel@intel.com>
In-Reply-To: <278b47946efd7f67229e26335c419570871427cc.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Apr 2024 18:06:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j46222cPihhkCo2Znum7f4A12sBve27Yeevv2LPdstPg@mail.gmail.com>
Message-ID: <CAJZ5v0j46222cPihhkCo2Znum7f4A12sBve27Yeevv2LPdstPg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 6:17=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Fri, 2024-04-26 at 18:56 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The return value of _STA with the "present" bit unset and the
> > "enabled"
> > bit set is clearly invalid as per the ACPI specification, Section
> > 6.3.7
> > "_STA (Device Status)", so make the ACPI device enumeration code
> > disregard devices with such _STA return values.
> >
> > Also, because this implies that status.enabled will only be set if
> > status.present is set too, acpi_device_is_enabled() can be modified
> > to simply return the value of the former.
> >
> > Link:
> > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device=
-status
> > Link:
> > https://lore.kernel.org/linux-acpi/88179311a503493099028c12ca37d430@hua=
wei.com/
> > Suggested-by: Salil Mehta <salil.mehta@huawei.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/bus.c  |   11 +++++++++++
> >  drivers/acpi/scan.c |    2 +-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/acpi/bus.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/bus.c
> > +++ linux-pm/drivers/acpi/bus.c
> > @@ -112,6 +112,17 @@ int acpi_bus_get_status(struct acpi_devi
> >         if (ACPI_FAILURE(status))
> >                 return -ENODEV;
> >
> > +       if (!device->status.present && device->status.enabled) {
> > +               pr_info(FW_BUG "Device [%s] status [%08x]: not
> > present and enabled\n",
> > +                       device->pnp.bus_id, (u32)sta);
> > +               device->status.enabled =3D 0;
> > +               /*
> > +                * The status is clearly invalid, so clear the
> > enabled bit as
> > +                * well to avoid attempting to use the device.
> > +                */
>
> seems that this comment is for the line above?

No, I meant "functional" and wrote "enabled".  Not sure why really.

> > +               device->status.functional =3D 0;
> > +       }
> > +
> >         acpi_set_device_status(device, sta);
> >
> >         if (device->status.functional && !device->status.present) {
> > Index: linux-pm/drivers/acpi/scan.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -1962,7 +1962,7 @@ bool acpi_device_is_present(const struct
> >
> >  bool acpi_device_is_enabled(const struct acpi_device *adev)
> >  {
> > -       return adev->status.present && adev->status.enabled;
> > +       return adev->status.enabled;
> >  }
> >
> >  static bool acpi_scan_handler_matching(struct acpi_scan_handler
> > *handler,
> >
> >
> >
> >
>


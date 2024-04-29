Return-Path: <linux-kernel+bounces-162655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE68B5E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC2C1C2124C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D984D1D;
	Mon, 29 Apr 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz0OvXaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8C74400;
	Mon, 29 Apr 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406868; cv=none; b=RlN4rWOfexMqZI+AMDG5Jr+X+Oh/Jurbz98e3y5rnqObvH1GxpCz91AUBrcD9R62Ujbl3NntU3syS+6+y+mK0MqK3fBf6HG7uYF5q3tNCNnWqsdQpSg123PRtNHAE6lkDhlQkUyHLMGk4X5Q0Qg3JoMkvftu5Xiz0XfKu1a9Vrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406868; c=relaxed/simple;
	bh=vOPo2tC/GsMIJkgdLxRfFzKWoQbXSFV0p9q7pK6+vak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwKrXyjELRAsitkmGrLfC5AzuxJL9vkLjhI6HqPUTR0q0T2UST8wr5i2tmx2Xj2namhvFH22gc4+KkQQxa06eB4xX+bBIpYjTYbgu3PcKP7tbMziO2eWRXMXPjuH151wAf6FTDNpEy1NETLOptGMABO3CaOy/xRhtQctlnsz09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz0OvXaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2901C113CD;
	Mon, 29 Apr 2024 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406867;
	bh=vOPo2tC/GsMIJkgdLxRfFzKWoQbXSFV0p9q7pK6+vak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sz0OvXajBFXicFUN1iTUq/mwMrPDUuCFy/fKhcOIcu+0VbIbR8+NaMgMVHx/cqB3b
	 Fzy17+JNPthru0hHHnfq8Ne18JtwluqXvcSoIxv9xx9QELaBgt2MZILaigf3de60OP
	 f/JjOYysjyOmqrixKf027vbfO9v+2v3mEDFi5/yW7niHugLeNr6CMumldJlVAJsjSc
	 mVphjrYRUo3cobtEJyYY3W5mKKVMxckoGm1CAsDhCPmn1grzyavB/JP6hDT/4r15B+
	 oIr3mogEVLwjav8vC8zmEQRJGPzRhhrlWI2vUCgx2HUAyzynOngk5pRcWogU2t0mYv
	 F01w85ZjZVxhg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ac4470de3bso1038973eaf.0;
        Mon, 29 Apr 2024 09:07:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb0lCxCmhCbq0rcJwqkoNPVhmf8q2ZYI0PN2FKFs6DynFFxP5BHDOW4aMOzMpiBEwJBsBzOFQtBvnet0zAkiB7N4+eFqm7vSqVahfgDU0mLInaGVJvbWHCImQjC4aS81f6wPJowTmyBw==
X-Gm-Message-State: AOJu0YxdVCEEv30gbxvzsWPYIuCjCTENj08U60vMtFbvtSaTnXg6TKLO
	PEvvyTIFNEkDVKohrdvuv6CLlLOairkvwktjBSx5mxlNCrb7sNU+r/YBj7PpDJOZezDK66qtZvS
	PcIUOy2fnjkVVLVL+Cvi+wDOkNsU=
X-Google-Smtp-Source: AGHT+IHW456tHmSqaf8NxSs7TvyRn24r6Yb+BtrQOK1YLVaMdYC5m/wDrj3//nvgc1U3ilLMdhHsd1+l1osGk4YphS4=
X-Received: by 2002:a4a:a882:0:b0:5aa:241a:7f4b with SMTP id
 q2-20020a4aa882000000b005aa241a7f4bmr12612134oom.1.1714406867234; Mon, 29 Apr
 2024 09:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2741433.mvXUDI8C0e@kreacher> <20240429092942.00004c96@Huawei.com>
In-Reply-To: <20240429092942.00004c96@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Apr 2024 18:07:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h60B=u7qDw1GOU0r=-apE76jCKLLayo8OBd+KYvWqYhA@mail.gmail.com>
Message-ID: <CAJZ5v0h60B=u7qDw1GOU0r=-apE76jCKLLayo8OBd+KYvWqYhA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:29=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 26 Apr 2024 18:56:21 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The return value of _STA with the "present" bit unset and the "enabled"
> > bit set is clearly invalid as per the ACPI specification, Section 6.3.7
> > "_STA (Device Status)", so make the ACPI device enumeration code
> > disregard devices with such _STA return values.
> >
> > Also, because this implies that status.enabled will only be set if
> > status.present is set too, acpi_device_is_enabled() can be modified
> > to simply return the value of the former.
> >
> > Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-=
device-status
> > Link: https://lore.kernel.org/linux-acpi/88179311a503493099028c12ca37d4=
30@huawei.com/
> > Suggested-by: Salil Mehta <salil.mehta@huawei.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Seems a sensible tidying up.  Hopefully nothing was relying on
> this looser behavior.  One trivial thing inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

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
> >       if (ACPI_FAILURE(status))
> >               return -ENODEV;
> >
> > +     if (!device->status.present && device->status.enabled) {
> > +             pr_info(FW_BUG "Device [%s] status [%08x]: not present an=
d enabled\n",
> > +                     device->pnp.bus_id, (u32)sta);
> > +             device->status.enabled =3D 0;
> > +             /*
> > +              * The status is clearly invalid, so clear the enabled bi=
t as
> > +              * well to avoid attempting to use the device.
> > +              */
>
> Comment seems to be in a slightly odd place.  Perhaps one line earlier ma=
kes
> more sense?  Or was the intent to mention functional here?

Rui has noticed this already.

I thought "functional" and wrote "enabled".  Oh well, I'll send a v2.

> > +             device->status.functional =3D 0;
> > +     }
> > +
> >       acpi_set_device_status(device, sta);
> >
> >       if (device->status.functional && !device->status.present) {
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
> > -     return adev->status.present && adev->status.enabled;
> > +     return adev->status.enabled;
> >  }
> >
> >  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handl=
er,
> >
> >
> >
>
>


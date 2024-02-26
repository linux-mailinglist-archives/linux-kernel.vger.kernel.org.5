Return-Path: <linux-kernel+bounces-81819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F001867A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884491F26464
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFB12BE84;
	Mon, 26 Feb 2024 15:38:05 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3B1E51D;
	Mon, 26 Feb 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961885; cv=none; b=XMHJaczwpdfjr7jK2wSqjKXAuoaAj0eIq3tBdSqJHxJAok8D4Itkjq5ZTpWpCjP/kuPdJBKYaDD66Z0gXmxw7rbbcXDyODvZ3m9vwjNZ0af7KXZvJq0e+nCb4HULJ6w6Ti/+9bNNZgebpicY/W3IZHX9sY8tXPN1yDkU733m01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961885; c=relaxed/simple;
	bh=x/l9Hdq8Up8A8J22fcEOt+L6TcEkGTO0C+l2vJkuX9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI0bF52frQNdbL8Wy4qOAGQEMme7G51Yhf54ChkKdB0C1sqT2r/y9KtGrDOy93RlpvaK6uysQsJnK+aDSHd18ePzoririXsUBHcng34BSm9H1XA2SJtELSO8cURywSPoeAXLpeqDBOSO8xaBx1pimKnY/7ELERLuYrPzHMhYj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e45f7c63f4so297385a34.1;
        Mon, 26 Feb 2024 07:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961882; x=1709566682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rht5mdp0Unm5ac83yufMkSEYG/yulI8r8YVcvuPo9ak=;
        b=NLgaM/9Ys5Fysy8+Y9urDhAEUFSvr+W+SXlE5+/jnz0BVn/XIf6VUpISnLQjs7OV5O
         cMSEZCIuWErk1yPPx4nuOeOAIM7Lwvs24OqLcnALCp+iDqtN1J+7wktF9YsU+775rDf/
         P6eo5rYizBjYS4OiUnSSBUmr0GBYfWu8npMQd+Zy8eKeQUsYVIw0gQ8Y5Z1PfPUH1btL
         iusoWBZNTE7mfWEP7MxcMbXDk2F7xO1W3tkA3wlnzRMRP1e0TkR6ASMQl4u/qa5hXQtt
         gOj1McNZyYeVGcrYB3BPo2sxUGHOluP80/XTUKqrrUJwVWVr1dEcSW7wfaESJu5zkbbu
         IjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWU1Uii+D8c3WuBo5oFdkkF2UF04hf/cWx8qAGvQss4ENwJg/0FyP6EJy+uKRLKplX8xn17PXvy58Wjh25y/9O48xmSpwmh+TnzqyaJbeo6wNjOL61UJ8bMMLYh21r7mqm91FRjSZz7HQ==
X-Gm-Message-State: AOJu0YwJo878O1HZsR/9HVwgQxt0W4sUAFxtEW+jUkKwxd+/GQXXLc9F
	MnKrSdfu0jz3wy+RcL3ils1H/sDOJVVnLx2om+ewfNdkVXi4vIYk+Q6xkG62W2CajE2rnyrcK/e
	FtdDSd2PREt+bber9V9HVWvaLWQni3olufq4=
X-Google-Smtp-Source: AGHT+IGv1bLZpsrS5tytcayR2qoWneBSEa/iQRUWg1MhkqXkB3DzmjrNfRxHYNbRIoG1pg4OO4+cAK9I1X47w82piAA=
X-Received: by 2002:a05:6820:2b15:b0:5a0:396d:2489 with SMTP id
 dt21-20020a0568202b1500b005a0396d2489mr6987622oob.1.1708961882412; Mon, 26
 Feb 2024 07:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4562925.LvFx2qVVIh@kreacher> <2939512.e9J7NaK4W3@kreacher> <20240222182834.00000b02@Huawei.com>
In-Reply-To: <20240222182834.00000b02@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2024 16:37:50 +0100
Message-ID: <CAJZ5v0id7ktjAne4wyEWox_xqjH9K=Kzbs3+Bcn1qHBctnincw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ACPI: scan: Rework Device Check and Bus Check
 notification handling
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:28=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 21 Feb 2024 21:02:33 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The underlying problem is the handling of the enabled bit in device
> > status (bit 1 of _STA return value) which is required by the ACPI
> > specification to be observed in addition to the present bit (bit 0
> > of _STA return value) [1], but Linux does not observe it.
> >
> > Since Linux has not looked at that bit for a long time, it is generally
> > risky to start obseving it in all device enumeration cases, especially
> > at the system initialization time, but it can be observed when the
> > kernel receives a Bus Check or Device Check notification indicating a
> > change in device configuration.  In those cases, seeing the enabled bit
> > clear may be regarded as an indication that the device at hand should
> > not be used any more.
>
> Hi Rafael,
>
> I rebased the vCPU HP series Russell was working to go on top of this
> and give me a basis to check the flows through your new conditions.
> It may have it's own issues, but at least it makes use of some of these
> bits and related checks.
>
> For now the only key thing is make sure we don't check enabled()
> in the hot remove path (until after _EJ0).  That happens correctly
> because acpi_device_trim() is called and that doesn't have check_status
> set.  The naming however doesn't make it obvious that path elides the
> check, so I wonder if that call in acpi_scan_hotremove()
> should be replaced with acpi_bus_trim_one(, NULL);

Well, that's how acpi_bus_trim() is supposed to work: Detach
everything under the target device (and including that device itself)
unconditionally.

I would prefer to rename acpi_bus_trim_one() to something closer
reflecting its purpose.

> >
> > For this reason, rework the handling of Device Check and Bus Check
> > notifications in the ACPI core device enumeration code in the
> > following way:
> >
> >  1. Make acpi_bus_trim_one() check device status if its second argument
> >     is not NULL, in which case it will only detach scan handlers or ACP=
I
> >     drivers from devices whose _STA returns the enabled bit clear.
> >
> >  2. Make acpi_scan_device_check() and acpi_scan_bus_check() invoke
> >     acpi_bus_trim_one() with a non-NULL second argument unconditionally=
,
> >     so scan handlers and ACPI drivers are detached from the target
> >     device and its ancestors if their _STA returns the enabled bit
> >     clear.
> >
> >  3. Make acpi_scan_device_check() skip the bus rescan if _STA for the
> >     target device return the enabled bit clear, which is allowed by the
> >     ACPI specification in the Device Check case. [2]
> >
> > In addition to the above:
> >
> >  4. Make sure that the bus rescan that needs to be triggered in the cas=
e
> >     when a new device has appeared is carried out in the same way in
> >     both the Device Check and Bus Check cases.
> >
> >  5. In the Device Check case, start the bus rescan mentioned above from
> >     the target device's parent, as per the specification. [2]
>
> This feels like an 'and' kind of a patch. Can we split it up so refactors
> are done first and the _STA check stuff in a follow up patch?

Sure, that will produce more readable patches.

> End result is good, just could possibly be easier to review in two hops.

Sure.

> >
> > Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-=
device-status # [1]
> > Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Mode=
l.html#device-object-notification-values # [2]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Diff had a field day here and generated an somewhat unreadable patch.

Well, agreed.

> A few other comments inline, but superficial stuff. The handling looks
> correct to me.
>
> > ---
> >  drivers/acpi/internal.h |    1
> >  drivers/acpi/scan.c     |  109 +++++++++++++++++++++++++++------------=
---------
> >  2 files changed, 64 insertions(+), 46 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -244,11 +244,27 @@ static int acpi_scan_try_to_offline(stru
> >       return 0;
> >  }
> >
> > -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> > +static int acpi_bus_trim_one(struct acpi_device *adev, void *check_sta=
tus)
>
> Bool as pointer is a bit hard to read particularly as you use (void *)tru=
e
> for true, but not (void *)false for false.
>
> However it's not too bad.  My current version of the vCPU patches needs
> to pass more data in here anyway (as there a few things we need to
> not do on eject, that don't correspond to !check_status)
> so I have this as a struct anyway after a rebase.

The reason for using void * here is that this function is called
recursively via acpi_dev_for_each_child_reverse() which requires a
pointer as the second arg.

I guess I could define a wrapper around it for this, but that would be
more code without any functional difference.

> >  {
> >       struct acpi_scan_handler *handler =3D adev->handler;
> >
> > -     acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> > +     acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, check_st=
atus);
> > +
> > +     if (check_status) {
> > +             acpi_bus_get_status(adev);
> > +             /*
> > +              * Skip devices that are still there and take the enabled
> > +              * flag into account.
> > +              */
> > +             if (acpi_device_is_enabled(adev))
> > +                     return 0;
> > +
> > +             /* Skip device that have not been enumerated. */
> > +             if (!acpi_device_enumerated(adev)) {
> > +                     dev_dbg(&adev->dev, "Still not enumerated\n");
> > +                     return 0;
> > +             }
> > +     }
> >
> >       adev->flags.match_driver =3D false;
> >       if (handler) {
> > @@ -315,71 +331,67 @@ static int acpi_scan_hot_remove(struct a
> >       return 0;
> >  }
> >
> > -static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
> > +static void acpi_scan_check_gone(struct acpi_device *adev)
>
> The name of this had me initially a little confused.  Maybe
> acpi_bus_trim_if_gone()
>
> Or maybe just drop this wrapper entirely as it doesn't save much
> and naming it clearly is hard.

I'll try to make it somewhat better.

>
> >  {
> > -     if (!acpi_device_enumerated(adev)) {
> > -             dev_warn(&adev->dev, "Still not enumerated\n");
> > -             return -EALREADY;
> > -     }
> > -     acpi_bus_trim(adev);
> > -     return 0;
> > +     acpi_bus_trim_one(adev, (void *)true);
> >  }
>
>
> >  static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 ty=
pe)
> >  {
> >       switch (type) {
> >       case ACPI_NOTIFY_BUS_CHECK:
> > -             return acpi_scan_bus_check(adev, NULL);
> > +             return acpi_scan_bus_check(adev);
> >       case ACPI_NOTIFY_DEVICE_CHECK:
> >               return acpi_scan_device_check(adev);
> >       case ACPI_NOTIFY_EJECT_REQUEST:
> > @@ -1945,6 +1957,11 @@ bool acpi_device_is_present(const struct
> >       return adev->status.present || adev->status.functional;
> >  }
> >
> > +bool acpi_device_is_enabled(const struct acpi_device *adev)
> > +{
> > +     return acpi_device_is_present(adev) && adev->status.enabled;
>
> This resolves as (present or functional) && enabled.
>
> By my reading you are not allowed functional && enabled, but not present.
> Line one of the description says.
>
> "If bit [0] is cleared, then bit 1 must also be cleared (in other words, =
a device that is not present cannot be enabled)."
>
> I don't much care about that though (I think we discussed this
> in Russel's earlier series)

Functional and enabled, but not present would go against the spec.  I
guess the kernel could protect itself against this, but then whatever
it chooses to do has not been defined anyway.

The spec doesn't actually say what the OSPM is supposed to do when it
sees that combination of bits.  I'm inclined to clarify it to say "if
bit [0] is cleared, bit [1] has no defined meaning and it should be
ignored by the OSPM".  To be consistent with this interpretation,
acpi_device_is_enabled() should return "(present and enabled) or
functional".

I'll change it along these lines.


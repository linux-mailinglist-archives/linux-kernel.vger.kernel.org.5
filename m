Return-Path: <linux-kernel+bounces-42760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9D840654
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955E2289C61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6663410;
	Mon, 29 Jan 2024 13:09:08 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B562811;
	Mon, 29 Jan 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533748; cv=none; b=jRm0fxGRRF4XQ7z3YSMuBxHQZJiHWEwlpcZR9cp4YC0a5JfEe9N8htOAjqQ7Wob7WafRTofTiuEo7tbr33vpxmtXtB/bkyH0hJ4xqn8iCe17kPVT1Jf7Rcb0LN2deyuIoEUkpjSG8STrzFoNrZsD6Q5MxPyUvNjrGwxd0ASdhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533748; c=relaxed/simple;
	bh=yK4wbTh6bSn8rEOdKLCmSlmXPF4BosuPXm/2A11MVIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY7cwfCbX6f7PER3g3ejgCjZySpNCYXLFcJrZhWCkTt9kIkYNCve0xI7NmJS9sLQ9A/RwqJJHH2sspDewlsCiKQjGd7lcl7uVOjtzGoeTyoPv9pD5O7whEKgVhsdcQCqPkImZxL2xrH9YquJOvI4ZIeji/f9bmuHobERlJF0H0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a1e21b0ebso485565eaf.1;
        Mon, 29 Jan 2024 05:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533745; x=1707138545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alp1p5dJCXivYUGQq6SDVyX8wUiyy4r59lRTBCpk25M=;
        b=HokCb5wudEfysGNFZD+OS/BU8q5hEA92S4JiwXEf5HYiznOf1aVc7CuwKmlAWg+N5i
         n5m0uzw65BC5uRRh32NjPgNw4fql/45Vn/Sl8J3+bAYEUFc2O45OaEm2vN+BnSQtZfVZ
         VoKNPQhldlHnPC15wwhDWQsPkM8xFg/RIO4xNMWH+wZAfFmqrCdlEWrEloFK00hINiHB
         Ik2dSCBtWsQJu6PBWhmAnroyPgL62kR7L4FNgd9cODjiuNlGRlP2goTklG7kG2AYxkb+
         lnju09BwF9sg1KXW8AiccrwNyJqKqZx1w3nsEphefiBwW3322KhEWss/agUhpmS7VQg9
         JPnQ==
X-Gm-Message-State: AOJu0Yxe/ElB9GvdCxe8HcqRKajc9Ugn5V1GemNP8MNJUcrDImqnQBns
	CkdTjjX5XKa3NJmUfPcKo6p/C8rQpWFXN/41BXTnKHN3bQUBCBrk+QdE3Wqc6skLS/fpWIzsBnX
	IQmdeTZIKnaaDXQN2cgcj0+vzKuM=
X-Google-Smtp-Source: AGHT+IGUY1MFJq9OVpn1j1X5jEB0eyAgrp9nbcTMdm4vBDmTQU74VD/K5DcqNQSkWlz9oGvGHGomZ+k7PC/EPirNmF8=
X-Received: by 2002:a4a:bd8c:0:b0:59a:bfb:f556 with SMTP id
 k12-20020a4abd8c000000b0059a0bfbf556mr6520776oop.0.1706533745637; Mon, 29 Jan
 2024 05:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124190732.4795-1-W_Armin@gmx.de> <9ccc3b9d-d71a-451c-80f5-3da62108d983@redhat.com>
In-Reply-To: <9ccc3b9d-d71a-451c-80f5-3da62108d983@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 14:08:54 +0100
Message-ID: <CAJZ5v0j1qvJYXqo96eMmtD4JnGh4Mu2ESdri5cGAqL-4bK0geA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: Initialize ACPI device class
To: Hans de Goede <hdegoede@redhat.com>
Cc: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:51=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 1/24/24 20:07, Armin Wolf wrote:
> > When an ACPI netlink event is received by acpid, the ACPI device
> > class is passed as its first argument. But since the class string
> > is not initialized, an empty string is being passed:
> >
> >       netlink:  PNP0C14:01 000000d0 00000000
> >
> > Fix this by initializing the ACPI device class during probe.
> >
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> > Note: This patch is based on commit 3f399b5d7189 ("platform/x86: wmi: U=
se ACPI device name in netlink event")
> > ---
> >  drivers/platform/x86/wmi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > index 7ef1e82dc61c..b92425c30a50 100644
> > --- a/drivers/platform/x86/wmi.c
> > +++ b/drivers/platform/x86/wmi.c
> > @@ -32,6 +32,8 @@
> >  #include <linux/wmi.h>
> >  #include <linux/fs.h>
> >
> > +#define ACPI_WMI_DEVICE_CLASS        "wmi"
> > +
> >  MODULE_AUTHOR("Carlos Corbacho");
> >  MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
> >  MODULE_LICENSE("GPL");
> > @@ -1202,7 +1204,7 @@ static int wmi_notify_device(struct device *dev, =
void *data)
> >               wblock->handler(*event, wblock->handler_data);
> >       }
> >
> > -     acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_c=
lass,
> > +     acpi_bus_generate_netlink_event(acpi_device_class(wblock->acpi_de=
vice),
> >                                       acpi_dev_name(wblock->acpi_device=
), *event, 0);
> >
> >       return -EBUSY;
> > @@ -1267,6 +1269,8 @@ static int acpi_wmi_probe(struct platform_device =
*device)
> >               return -ENODEV;
> >       }
> >
> > +     strscpy(acpi_device_class(acpi_device), ACPI_WMI_DEVICE_CLASS, si=
zeof(acpi_device_class));
> > +
>
> Hmm, I'm not sure if you are supposed to do this when you are not an
> acpi_driver's add() function.

You aren't.

> Rafael, do you have any comments on this ?

I'm not quite sure why this is done here.


Return-Path: <linux-kernel+bounces-81849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60608867AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7C1C28806
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1412BF3C;
	Mon, 26 Feb 2024 15:54:41 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27721292ED;
	Mon, 26 Feb 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962881; cv=none; b=RITeDFitdbeRbz3ZHYVMMp0UBCd6SwQHB/QsO/4rmzq8fKxMxe0lOT4+EJq8W5/5nouRa8YISeullplT1Z5kGj9G+DtpUF9yk7nu8Go3j8v4GRliRc76hts5OZaLhLBvOeJoQqMXlttccnjc0wk3PWgMKqFr5e7bRQFpmZ6Sk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962881; c=relaxed/simple;
	bh=GIXw4CMiWjn027axPINZjhYRbMIP/5BA//VYtZABjv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+dSD1fz6csBBOEUnJErrCs5cDBjh9WMO2BFyGgIC+jBPGEuQDrTynbsqcUPTwZFiUwLKHItxkom90gJIGpuHEVzRBmTj/peYbSSZ7PbZ1cGxVa+1QRIkn7pxpmd8Mk1lQ/1IcFjX4t8REhzVhGt51/7K4jrOwDrGCegkl49PEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21fbe64ef0cso172921fac.1;
        Mon, 26 Feb 2024 07:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962879; x=1709567679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hG+R8NZ6weR+cw6Mtpt9mJbOI6Ku9oH9aEPOnZNcL4=;
        b=GDi9peFSdfaxXypWsHXYi1JlyTy7fJ0vafzaF9xRBRj/iJcp3wd0cn7OV0fnwzr61q
         QHxIGPSP3ZTIyrkbAcjoE39O9Icwd6yEaGc/bkdggkYyHp4ONt4wefMFBsvV4y6k7v39
         F59OaAIZQlmcMq4umg3OGJ9t8hnmXSTwYZKhr/qOBuLQzKrNDt5etOpibg/QpicQbSD1
         Quw2N81b+1dg7HjHAOoEHcSE/ku8b5UzwkSOWefx7uTA/Xz746SfqsSYguo8KcN1NNkV
         hevzsSuEOZadPQNmPYbXlqUDFb/t36VQG3MQzO9dYrp9kFvZvYugAQ6QjOzz5GJYi5/p
         6uCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhrzbqCVBcPx8l0UZsRhzEWbgQ4QP0y10P1vD6er63mWbkshf2rHSF+IaR1Lm58ibj97AVGsUQHBb1C2syJ7L4kA67MDZF+geuwjufgAyYFdNRsWJWxOfz1HGrTIrtmkniCozvyqOvVQ==
X-Gm-Message-State: AOJu0Yz2SKHPsiqDsCABVgfwIzhsfcr2va2F6NkjmCzpCbLg9Yzfrfnv
	r5Yld6tycuANGy8+dbrE7ZOq6eznagDQELemWM5qrii4yAOrbDnqcdlHwSTnKAeNpH5G/YY49PN
	qI9Dq6AX76Eod/WiaqAMj3yX9dyAJDDUZHwk=
X-Google-Smtp-Source: AGHT+IGYj3I+pBHztUYABBs8ofR2SML4EWvnehN8WclVuckleTZbje1PaIZCZP9V36/pwzXDffMk5oDBgMXjDRenn3g=
X-Received: by 2002:a05:6820:2c8e:b0:5a0:4d78:975d with SMTP id
 dx14-20020a0568202c8e00b005a04d78975dmr6637712oob.1.1708962878870; Mon, 26
 Feb 2024 07:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4562925.LvFx2qVVIh@kreacher> <2939512.e9J7NaK4W3@kreacher>
 <20240222182834.00000b02@Huawei.com> <CAJZ5v0id7ktjAne4wyEWox_xqjH9K=Kzbs3+Bcn1qHBctnincw@mail.gmail.com>
In-Reply-To: <CAJZ5v0id7ktjAne4wyEWox_xqjH9K=Kzbs3+Bcn1qHBctnincw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2024 16:54:27 +0100
Message-ID: <CAJZ5v0jjD=KN0pOuWZZ8DT5yHdu03KgOSHYe3wB7h2vafNa44w@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ACPI: scan: Rework Device Check and Bus Check
 notification handling
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Feb 22, 2024 at 7:28=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 21 Feb 2024 21:02:33 +0100
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

[...]

> > > +bool acpi_device_is_enabled(const struct acpi_device *adev)
> > > +{
> > > +     return acpi_device_is_present(adev) && adev->status.enabled;
> >
> > This resolves as (present or functional) && enabled.
> >
> > By my reading you are not allowed functional && enabled, but not presen=
t.
> > Line one of the description says.
> >
> > "If bit [0] is cleared, then bit 1 must also be cleared (in other words=
, a device that is not present cannot be enabled)."
> >
> > I don't much care about that though (I think we discussed this
> > in Russel's earlier series)
>
> Functional and enabled, but not present would go against the spec.  I
> guess the kernel could protect itself against this, but then whatever
> it chooses to do has not been defined anyway.
>
> The spec doesn't actually say what the OSPM is supposed to do when it
> sees that combination of bits.  I'm inclined to clarify it to say "if
> bit [0] is cleared, bit [1] has no defined meaning and it should be
> ignored by the OSPM".  To be consistent with this interpretation,
> acpi_device_is_enabled() should return "(present and enabled) or
> functional".
>
> I'll change it along these lines.

Actually, I don't think that the "functional" bit has any bearing on
this.  It only means that the OSPM should continue the enumeration
below the device regardless of the present bit value.

In the acpi_processor_add() case it is clearly irrelevant.

acpi_scan_bus_check() needs to walk the entire subtree below the
target device anyway.

As for acpi_scan_device_check(), IMO it's better to make it walk the
subtree below the device if it is present, but not enabled, for
backwards compatibility.


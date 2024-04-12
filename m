Return-Path: <linux-kernel+bounces-142764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA28A2FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0611F2349D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E848594A;
	Fri, 12 Apr 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JbvBF3Bj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5284FA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929865; cv=none; b=ZtOk0QUa+jmtfxW6oB3YJE2BSewqUvELXBOZn8CxLSX90ex093Xj3PUmUzw8L9Ani6KYvbrGSr1Gh6Al1u3mUA5IRrD1XoiUHIeMa/lDI62vnDiIG5cz75EbKsQlej9jiUFbNaNJqgzDwf0swQUPmCz43zdkHx0gROHH2B8fO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929865; c=relaxed/simple;
	bh=m1z4lnBjEM8XYSqF+Cb45YhG/mvQJnOYj/iIHznJC5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaKU2YCPFOOjt0K7kAyHfrNa+0CuDlkQgr5JuULBCUfBmVZPisJ/wWHEI4N+gqrrN6oKYokWCFu+5bLRdD8HMWwOYhQXFhFRohkILIORxGvK7nDpJbMENhuB3WXSzyPqE78BFzOLbrnpfxIhBC/OsjlAvBSqGLA823yvhxMobrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JbvBF3Bj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d09bd434so1165156e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712929862; x=1713534662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6ftp8YirSnx3Hs03pwZ0/loDPXIVialAS8QDpJUQK4=;
        b=JbvBF3BjfJ9PHhtedgW5ImNNgmNTOLFGM+NkhdhiAFDxbHGQACUW4OpaFE9z+rfzfR
         mZRrPVBj5zFPnztBehac4uMCjq8AmlnsBmQ679LAqs4qDUb35i7AAMXQTvEoTe6eoLKz
         USOuouYtvGjOGbjtvLba6i0ERJpw67A77TFTuDg4t/jCPPP2TDRIMWDlVG8Mbw4TMUJn
         Dgk/r1aOCrcjSXS30eJAJbD1QkePn1ZZvic+0h7vSqq3AZLkALSX5sEigoa+lClp8916
         GG77PzxRumsOSCTe0/MwsFoDQBqqM2GC+g0A/iDnXq7NqcYvOxRsrN8Hyi+hw1dTym2C
         iBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929862; x=1713534662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6ftp8YirSnx3Hs03pwZ0/loDPXIVialAS8QDpJUQK4=;
        b=D177oBn7Jqrkg5BTYyiSOTBAy5YxSTXvYbtsy/lH9gM7FEwm3SC+vER7X5qopY4TXm
         Z6iLcJivLoYWC5gYh6DyuE6jZIlyBntnNfTLsCXLgqIKDZX8IqZ7B+a3VwpcwDSalgnM
         57zaCjkkAPBnYIpCtU6/hVNB+YBHm0w9YDIQ4uHsWbZeha5Ka17meT1xaBsnqb7jBKBC
         HmU6o6j1Fmu3xYq24ZgNhpkYQG4DsJ6kqRphJCap34OEkfgWaq47l3Z0f2OMgHKphmDK
         mxksZBh3WRBcESWZauZHouQcasXTMxNfwHY/ESnJan9yq15wvmoIJsM6CZfDpRQN7BHu
         Q3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVEJQZURRglua8zPOiiFTkhLCyv11AAcFWhzXQosWw99NN97Gv1cM2hZoh+0mXa4f3SurOYVUgAGp5JPX79C4u+R7V4gOnKihWuyEnl
X-Gm-Message-State: AOJu0YxMk1nMyKqNFtx8adux7Ipr9WZ1IDew+/iqpSxN4J7v4KTp6xv4
	daIljU0LZbBR/n/PrYVK39t3/obWWs8xyDuAiJmf4vf26ExvlROvS5Yj9geBGIWjkvXxZlavf/B
	dDayd4CEdrWgWNkR9kS/FNu+Jg8dCYAiMeIwjJw==
X-Google-Smtp-Source: AGHT+IELmLzLoKV3AEX3BhZ0JXDV3totmY1DGPSToJQHF3khM/6jn4A/6uLdV7l7OmdjjJbUTX107xSW5Eh+Bfovt4c=
X-Received: by 2002:a05:651c:620:b0:2d9:f68a:d82c with SMTP id
 k32-20020a05651c062000b002d9f68ad82cmr1547619lje.41.1712929861426; Fri, 12
 Apr 2024 06:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412112931.285507-1-apatel@ventanamicro.com> <CAL_JsqJBpN2qNgiKs_nL+JxM7qaaQkd4Gk06UNefp3gB1HQ7_w@mail.gmail.com>
In-Reply-To: <CAL_JsqJBpN2qNgiKs_nL+JxM7qaaQkd4Gk06UNefp3gB1HQ7_w@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 12 Apr 2024 19:20:49 +0530
Message-ID: <CAK9=C2UMP3hAmn4-QruO90E1ZKY_nMP-yt5T6hife-9hC5H92A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add fw_devlink support for interrupt-map property
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 6:07=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Apr 12, 2024 at 6:29=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > Some of the PCI controllers (such as generic PCI host controller)
> > use "interrupt-map" DT property to describe the mapping between
> > PCI endpoints and PCI interrupt pins.
>
> I would go as far as saying that's the only case as that's the only
> case where the interrupts are not described in DT.

Sure, I will update the text.

>
> > Currently, there is no fw_devlink created based on "interrupt-map"
> > DT property so interrupt controller is not guaranteed to be probed
> > before PCI host controller. This mainly affects RISC-V platforms
> > where both PCI host controller and interrupt controllers are probed
> > as regular platform devices.
>
> That's *every* system with PCI really.

Okay, I will re-word.

>
> > This creates fw_devlink between consumers (PCI host controller) and
> > supplier (interrupt controller) based on "interrupt-map" DT property.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/of/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index a6358ee99b74..ccbbb651a89a 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1311,6 +1311,58 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args=
np;
> >  }
> >
> > +static struct device_node *parse_interrupt_map(struct device_node *np,
> > +                                              const char *prop_name, i=
nt index)
> > +{
> > +       struct device_node *tn, *ipar, *supnp =3D NULL;
> > +       u32 addrcells, intcells, cells;
> > +       const __be32 *imap, *imap_end;
> > +       int i, imaplen;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_IRQ))
> > +               return NULL;
> > +
> > +       if (strcmp(prop_name, "interrupt-map"))
> > +               return NULL;
> > +
> > +       ipar =3D of_node_get(np);
> > +       do {
> > +               if (!of_property_read_u32(ipar, "#interrupt-cells", &in=
tcells))
> > +                       break;
> > +               tn =3D ipar;
> > +               ipar =3D of_irq_find_parent(ipar);
> > +               of_node_put(tn);
> > +       } while (ipar);
> > +       if (!ipar)
> > +               return NULL;
> > +       addrcells =3D of_bus_n_addr_cells(ipar);
> > +       of_node_put(ipar);
> > +
> > +       imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > +       if (!imap || imaplen <=3D (addrcells + intcells))
> > +               return NULL;
> > +       imap_end =3D imap + imaplen;
> > +
> > +       for (i =3D 0; i <=3D index && imap < imap_end; i++) {
> > +               if (supnp)
> > +                       of_node_put(supnp);
> > +
> > +               imap +=3D addrcells;
> > +               imap +=3D intcells;
> > +
> > +               supnp =3D of_find_node_by_phandle(be32_to_cpu(imap[0]))=
;
> > +               if (!supnp)
> > +                       return NULL;
> > +               imap +=3D 1;
> > +
> > +               if (of_property_read_u32(supnp, "#interrupt-cells", &ce=
lls))
> > +                       return NULL;
> > +               imap +=3D cells;
>
> This is wrong. Technically, you can have #address-cells too.
>
> The bigger problem I have is this creates 2 sets of 'interrupt-map'
> parsing code. Your version skips a lot of things like whether the
> interrupt controller is available and there's the list of
> 'interrupt-map' abusers to think about.
>

In my first attempt, I was trying to keep it simple but I guess I
over-simplified it.

I have an alternate approach to use of_irq_parse_raw() over
here (similar to of_irq_parse_pci() in drivers/pci/of.c). Are you
okay with this approach ?

Regards,
Anup


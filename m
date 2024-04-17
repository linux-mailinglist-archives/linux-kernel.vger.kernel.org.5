Return-Path: <linux-kernel+bounces-147994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF108A7C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA711C211E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E54657B0;
	Wed, 17 Apr 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pdHxun0G"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F369535D1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335677; cv=none; b=N1ogYifbb55JS45NfirC2eruQdf/9uXPChfepZsdctMTCdVbtpRA01aFT+6nTxrTkMzEq9Jtux1aBLC9dIjhtrX7HZ1Q+PTp2Zf5NjTRqLn9RjYzt0prb0ej0dMcjyjRRz9ONghvc7DfCygVBPDgK/cVO6oCjofuXuyIb2/KQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335677; c=relaxed/simple;
	bh=GxlMnKFxDHm6BKouuZF++ZDuw+J4sqaiENNxZ5h/kY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPWcIt/H1m+vb3L0LcjsG6j1aXhBQ38xe9Dd+8SgL5Q9lH2oAULDqjzz2hK+rEmZIgpRXIzB0sczPe+FMv+X168NdILeViEOav+iDOYg4QEmj5DqgkcIbUU3JgbcSG4/ujdthmej1qVvepfMHiV9z6R8mwKcfO2WdanQPNKlVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pdHxun0G; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d6e23253so5793121e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713335673; x=1713940473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X0jqgr7Qs0LvDOxxOvNJdmszxXp/NxTce1ZQe6WIVg=;
        b=pdHxun0GqD3+e6JXkjXw0unUiVTwSBydbxWiCphuHPEn67gzU6U+fw3dRn6119mEoJ
         NdQRmbfhwDdS06bMcstKYt4mldBaY7ZvZopqfpPiuGDbfW7sl2WTKGKqQrcrq8mh+2MA
         uH/3xumnLjjMxl2EBBWtR9DFF8zMe7qfFSy8tEvJUh0SvK4UlazNGxqcQ63k8O02qoig
         IDoyLUW1cWi72VeKKRiICoCSv/pS/5JhFstmqB7w5eNDZzXO6Pro+eMiTYVwbbTI8XLi
         /hohwdlz23K1/KParsigyNZcpRwt2cHFwFGlNx5A+n3WH7YbS/gtivgNYMqHwH+8oAI6
         O6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335673; x=1713940473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X0jqgr7Qs0LvDOxxOvNJdmszxXp/NxTce1ZQe6WIVg=;
        b=aWBECLCKWwWUiT9SoOS7hw8T01HtLl8KHTTYV6Y4Ipv2HIiRI7zx8do+MKCdrk+AwV
         iEBkHZGZXurN7XV0gHPb6RYHWCmqYKp62pZOuK0DW+7Mm8oFGLEbtqB00EPng9z9GczK
         z2JRYPkPwDIf4Bd3vzvfyT+UL9aXn+CUBKEsSW3yQqU85ihbSBJIbruUNyGczWBvKpao
         vyFjgV0wZuqica51QmZpDszvQCTkiq/mpGMFO81is4JeWeDIYaSQ44s72g33Vd4z7NOA
         /tc6/byiQfOc/ShQeIlzDtCV/98wroPB+1bKI54+qiRklTkoYGqQMRSUXl+ybCABeubH
         7oGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrrum2xfsM8LTK5rUpnX8bzH0xntYzbokAU86LRxQvof+sGs8AU9jLWTb60dM9qmaMoFjIV7Rb6G/DFjK7S7juOwI2fCvTWbtCRy89
X-Gm-Message-State: AOJu0Yy0/9XiP2qPE4nz9z78Adg2XteI/BmFjZizX/uKstad/n/qRiyq
	7zcJB9GJsPCr2AUdbYEm0G4/D0pFhLzDqxTXSHKHoK0jWBNSBXSxqNGfLE+PKCMi2w4OQRiZgYi
	X2CqJINgyjhHFzQG4/u155Ej2+XTPjJRdOnhiNw==
X-Google-Smtp-Source: AGHT+IFXhzUTZ1cSjL2EAEeIKsVwob3jWS7E3nZRN1q1zCR6DzxT7RqsTlAaXxF7WxowaPLP0UuGKv6yNyoMzXpgNYE=
X-Received: by 2002:ac2:51a7:0:b0:518:bb6e:7985 with SMTP id
 f7-20020ac251a7000000b00518bb6e7985mr8053670lfk.51.1713335673304; Tue, 16 Apr
 2024 23:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413091942.316054-1-apatel@ventanamicro.com>
 <20240416141049.GA2148267-robh@kernel.org> <CAGETcx_Ni3MjwVHDOdre1nSqQP07=gaUtCDj31ndKcMFtm+xjg@mail.gmail.com>
In-Reply-To: <CAGETcx_Ni3MjwVHDOdre1nSqQP07=gaUtCDj31ndKcMFtm+xjg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 17 Apr 2024 12:04:20 +0530
Message-ID: <CAK9=C2WUe-JWk4QLxHNc_gSCqjBCxrVfcPcYP9-_QFoGk-vF5Q@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: Add fw_devlink support for interrupt-map property
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:34=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 7:11=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Sat, Apr 13, 2024 at 02:49:42PM +0530, Anup Patel wrote:
> > > Some of the PCI controllers (such as generic PCI host controller)
> > > use "interrupt-map" DT property to describe the mapping between
> > > PCI endpoints and PCI interrupt pins. This the only case where
> > > the interrupts are not described in DT.
> > >
> > > Currently, there is no fw_devlink created based on "interrupt-map"
> > > DT property
>
> parse_interrupts() calls of_irq_parse_one() that in turn calls
> of_irq_parse_one() that does the "interrupts-map" handling. In fact
> of_irq_parse_pci() also calls of_irq_parse_one() if the PCI device has
> a DT node. So I don't think any new functionality needs to be added.
> If I'm not mistaken we just need parse_interrupts to not ignore
> interrupts-map? A one line change?
>
> Why do we need all of this code you wrote below?

The of_irq_parse_one() calls of_irq_parse_raw() only if the DT
node has "interrupts" or "interrupts-extended" DT property. This
means for most PCI host controller DT nodes, the of_irq_parse_one()
will not return any interrupts.

Here's an example PCI host DT node from the RISC-V world
(but this also applies to other architectures):

pci@30000000 {
    compatible =3D "pci-host-ecam-generic";
     device_type =3D "pci";
     #address-cells =3D <0x03>;
     #size-cells =3D <0x02>;
     #interrupt-cells =3D <0x01>;
     interrupt-map-mask =3D <0x0 0x00 0x00 0x07>;
     interrupt-map =3D <0x00 0x00 0x00 0x01 &aplic_slevel 28 0x04>,
                              <0x00 0x00 0x00 0x02 &aplic_slevel 29 0x04>,
                              <0x00 0x00 0x00 0x03 &aplic_slevel 30 0x04>,
                              <0x00 0x00 0x00 0x04 &aplic_slevel 31 0x04>;
     reg =3D <0x0 0x30000000 0x0 0x10000000>;
     ranges =3D <0x01000000 0x0 0x0 0x0 0x1fff0000 0x00000000 0x10000>,
                    <0x02000000 0x0 0x40000000 0x0 0x40000000 0x0 0x4000000=
0>,
                     <0x03000000 0x100 0x0 0x100 0x0 0x4 0x0>;
     interrupt-parent =3D <&aplic_slevel>;
     msi-parent =3D <&imsic_slevel>;
     bus-range =3D <0x00 0xff>;
     linux,pci-domain =3D <0x00>;
};

In the above example, the "interrupt-map" DT property maps a set
of PCIe endpoints to APLIC interrupt sources but this only applies
if the corresponding PCIe endpoints are actually present. Also,
which entry of "interrupt-map" DT property is used for a PCIe
endpoint also depends on the PCI requester ID (bus-device-func)
assigned to the PCIe endpoint.

Regards,
Anup

>
> -Saravana
>
> > >  so interrupt controller is not guaranteed to be probed
> > > before PCI host controller. This affects every platform where both
> > > PCI host controller and interrupt controllers are probed as regular
> > > platform devices.
> > >
> > > This creates fw_devlink between consumers (PCI host controller) and
> > > supplier (interrupt controller) based on "interrupt-map" DT property.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > > Changes since v1:
> > > - Updated commit description based on Rob's suggestion
> > > - Use of_irq_parse_raw() for parsing interrupt-map DT property
> > > ---
> > >  drivers/of/property.c | 58 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 58 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index a6358ee99b74..67be66384dac 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1311,6 +1311,63 @@ static struct device_node *parse_interrupts(st=
ruct device_node *np,
> > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args=
np;
> > >  }
> > >
> > > +static struct device_node *parse_interrupt_map(struct device_node *n=
p,
> > > +                                            const char *prop_name, i=
nt index)
> > > +{
> > > +     const __be32 *imap, *imap_end, *addr;
> > > +     struct of_phandle_args sup_args;
> > > +     struct device_node *tn, *ipar;
> > > +     u32 addrcells, intcells;
> > > +     int i, j, imaplen;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_OF_IRQ))
> > > +             return NULL;
> > > +
> > > +     if (strcmp(prop_name, "interrupt-map"))
> > > +             return NULL;
> > > +
> > > +     ipar =3D of_node_get(np);
> > > +     do {
> > > +             if (!of_property_read_u32(ipar, "#interrupt-cells", &in=
tcells))
> > > +                     break;
> > > +             tn =3D ipar;
> > > +             ipar =3D of_irq_find_parent(ipar);
> > > +             of_node_put(tn);
> > > +     } while (ipar);
> >
> > No need for this loop. We've only gotten here if 'interrupt-map' is
> > present in the node and '#interrupt-cells' is required if
> > 'interrupt-map' is present.
> >
> > > +     if (!ipar)
> > > +             return NULL;
> > > +     addrcells =3D of_bus_n_addr_cells(ipar);
> > > +     of_node_put(ipar);
> > > +
> > > +     imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > > +     if (!imap || imaplen <=3D (addrcells + intcells))
> > > +             return NULL;
> > > +     imap_end =3D imap + imaplen;
> > > +
> > > +     sup_args.np =3D NULL;
> > > +     for (i =3D 0; i <=3D index && imap < imap_end; i++) {
> > > +             if (sup_args.np) {
> > > +                     of_node_put(sup_args.np);
> > > +                     sup_args.np =3D NULL;
> > > +             }
> > > +
> > > +             addr =3D imap;
> > > +             imap +=3D addrcells;
> > > +
> > > +             sup_args.np =3D np;
> > > +             sup_args.args_count =3D intcells;
> > > +             for (j =3D 0; j < intcells; j++)
> > > +                     sup_args.args[j] =3D be32_to_cpu(imap[j]);
> > > +             imap +=3D intcells;
> > > +
> > > +             if (of_irq_parse_raw(addr, &sup_args))
> > > +                     return NULL;
> > > +             imap +=3D sup_args.args_count + 1;
> > > +     }
> >
> > Doesn't this leak a ref on the last time the function is invoked? For
> > example, if we have 2 entries and index is 2. We'll get index=3D1, but
> > then exit because imap=3D=3Dimap_end. We need a put on index=3D=3D1 nod=
e.
> >
> > Look at my next branch where I've converted things to use __free()
> > cleanups. I don't see it helping here as-is, but maybe when it is
> > correct.
> >
> > Rob


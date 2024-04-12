Return-Path: <linux-kernel+bounces-142663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EE8A2E83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9C2879F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF85B694;
	Fri, 12 Apr 2024 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfSqe5yw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195555C3B;
	Fri, 12 Apr 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925475; cv=none; b=LUPiIOeY7L9qRgfO7s7TsEeiLh2H2YbXiyn82Bxb2O8QeBa4W12KYXpjwIevm3UqbkCOJo4E1tMjYkAI/6vRf4U+MsaHXZHj4ufgFIm6b9kBOi4hqEPaGCwW2Dk9qLmn/U3ez5DboH5d7p2CgW40zzzOak9T18FD0x3NGitveOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925475; c=relaxed/simple;
	bh=C0wVk5cOtI3tAGSa3X+/7Lo5QFB431pX7oYKu/xlIg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAiWXCV2WX4kx2Plhe0IT/v2gXFoQopRenJHUE+0H6zTVVvARzMNrCAR//1I6Uhr9VVEHhDUqJY4p/R/ai9xSNyu8sMsgz0OxmrUqjXpW2Ks0ruFa31QV3yIBdzKsXreXgKe0AfQuRtNiSkIIQ6/KFkubjfXeqFczIuFg4MB6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfSqe5yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F4AC4AF07;
	Fri, 12 Apr 2024 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712925474;
	bh=C0wVk5cOtI3tAGSa3X+/7Lo5QFB431pX7oYKu/xlIg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NfSqe5ywT9N1aTLIrHBScsTlGElesoeZ2B4h01aGvwgLuo7e/GXmSnp1YdGBOzxhd
	 ncO601AARHmgdyKTS+w8dEW6WOOBT7aJs6xA3/gETK2O2rAyZrlDcJELUgumpVNSoC
	 PM2SG7Pq8qzdHTYAJ65ho3rM5lI/pLVhePj6Z5PEdVA8G25LV4l/+hbMvZXuT759cS
	 PvAvpIKJIThrUf9EobZoeRgutQGI9grhb8jukktuID3mc4HHqXuhpL8m5NqDL45T2V
	 tY3Tm0lmPYNVIAmJRmHIU90aUWm7YdO7prErJLpWO7OK3Pp+3WiL+/W/eAeD/1DS8o
	 6t8QvDFFuyMvQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d727074eso1086136e87.0;
        Fri, 12 Apr 2024 05:37:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfB0OvGKgA+ZFGgMsjpFb/HKHfDks5u3ORAy0JRsjDF9QRG4hPTMi37bXHbRfRxO4UR5zRU94zvMdarimb2PBtIPu+U/lTEvFInknRNt+1GHmDv+MAqTwzFPZILgpnhqVg5QgihxXhCA==
X-Gm-Message-State: AOJu0Yw9RTqJOe/P6ple9waY5axGDkggJU9ILQ+KAgP4PfDWs7JgaGa+
	nDlVmosJIPMf+hE1c1aKGgS/BRRF5DovBYcQdrR+MngOTnnMa7gaNc5jbbr+bmDVY8yna1GajPd
	7UEgotaKSpjvgykhXZmfWp8utyg==
X-Google-Smtp-Source: AGHT+IEPdekwyhDzkGjzMModGVmVX+iai4Ht/W6b6ZsLvIi1Pt2LX57dciG3IUlZb1DPGcgZeVS0Urn1rk9Ty5lLfV0=
X-Received: by 2002:ac2:4248:0:b0:516:cc2d:f6a1 with SMTP id
 m8-20020ac24248000000b00516cc2df6a1mr1489141lfl.51.1712925473235; Fri, 12 Apr
 2024 05:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412112931.285507-1-apatel@ventanamicro.com>
In-Reply-To: <20240412112931.285507-1-apatel@ventanamicro.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Apr 2024 07:37:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBpN2qNgiKs_nL+JxM7qaaQkd4Gk06UNefp3gB1HQ7_w@mail.gmail.com>
Message-ID: <CAL_JsqJBpN2qNgiKs_nL+JxM7qaaQkd4Gk06UNefp3gB1HQ7_w@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add fw_devlink support for interrupt-map property
To: Anup Patel <apatel@ventanamicro.com>
Cc: Saravana Kannan <saravanak@google.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 6:29=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> Some of the PCI controllers (such as generic PCI host controller)
> use "interrupt-map" DT property to describe the mapping between
> PCI endpoints and PCI interrupt pins.

I would go as far as saying that's the only case as that's the only
case where the interrupts are not described in DT.

> Currently, there is no fw_devlink created based on "interrupt-map"
> DT property so interrupt controller is not guaranteed to be probed
> before PCI host controller. This mainly affects RISC-V platforms
> where both PCI host controller and interrupt controllers are probed
> as regular platform devices.

That's *every* system with PCI really.

> This creates fw_devlink between consumers (PCI host controller) and
> supplier (interrupt controller) based on "interrupt-map" DT property.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..ccbbb651a89a 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1311,6 +1311,58 @@ static struct device_node *parse_interrupts(struct=
 device_node *np,
>         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
>  }
>
> +static struct device_node *parse_interrupt_map(struct device_node *np,
> +                                              const char *prop_name, int=
 index)
> +{
> +       struct device_node *tn, *ipar, *supnp =3D NULL;
> +       u32 addrcells, intcells, cells;
> +       const __be32 *imap, *imap_end;
> +       int i, imaplen;
> +
> +       if (!IS_ENABLED(CONFIG_OF_IRQ))
> +               return NULL;
> +
> +       if (strcmp(prop_name, "interrupt-map"))
> +               return NULL;
> +
> +       ipar =3D of_node_get(np);
> +       do {
> +               if (!of_property_read_u32(ipar, "#interrupt-cells", &intc=
ells))
> +                       break;
> +               tn =3D ipar;
> +               ipar =3D of_irq_find_parent(ipar);
> +               of_node_put(tn);
> +       } while (ipar);
> +       if (!ipar)
> +               return NULL;
> +       addrcells =3D of_bus_n_addr_cells(ipar);
> +       of_node_put(ipar);
> +
> +       imap =3D of_get_property(np, "interrupt-map", &imaplen);
> +       if (!imap || imaplen <=3D (addrcells + intcells))
> +               return NULL;
> +       imap_end =3D imap + imaplen;
> +
> +       for (i =3D 0; i <=3D index && imap < imap_end; i++) {
> +               if (supnp)
> +                       of_node_put(supnp);
> +
> +               imap +=3D addrcells;
> +               imap +=3D intcells;
> +
> +               supnp =3D of_find_node_by_phandle(be32_to_cpu(imap[0]));
> +               if (!supnp)
> +                       return NULL;
> +               imap +=3D 1;
> +
> +               if (of_property_read_u32(supnp, "#interrupt-cells", &cell=
s))
> +                       return NULL;
> +               imap +=3D cells;

This is wrong. Technically, you can have #address-cells too.

The bigger problem I have is this creates 2 sets of 'interrupt-map'
parsing code. Your version skips a lot of things like whether the
interrupt controller is available and there's the list of
'interrupt-map' abusers to think about.

Rob


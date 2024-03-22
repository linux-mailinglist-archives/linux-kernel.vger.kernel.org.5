Return-Path: <linux-kernel+bounces-111548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BBF886D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3F1B25AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141315787F;
	Fri, 22 Mar 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcw51FBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F156B84;
	Fri, 22 Mar 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114450; cv=none; b=sxnvm7zyr22y9Pd9YRsi+U+Xsg0OigEGNePDNDhnboUcH9FFwfnUB6AGCpTpMs3xrW6lq3qIxOX6pTp9cfay0l97UQXzGFX+UboL4d5vwr8T/HfaWUMG9OL0TtEJlqhYexZg9hOlhxOWgr9D5Qusa8qmRqX+mF2tH/fFYg+fUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114450; c=relaxed/simple;
	bh=vqSz7Q6uZia3/pyYjzyPdjE/9V2o05Oh9GvKTR0PR1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7XL3S7AsKGmw5feyfw0NJQnGmMR4DKG8Pe6H4pAzXMewG0mceEL5g7aczHk031i8o2fRNf/5POB292TWfsL06in9o6hx6pyL2TgG1nbBGhaIJ1/XUq9mlWP/E/9ne0Eb/aJVo3XhEdK2YBnpSt2UGoSCXmujRlFNQt36wyw+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcw51FBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFEC433C7;
	Fri, 22 Mar 2024 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711114449;
	bh=vqSz7Q6uZia3/pyYjzyPdjE/9V2o05Oh9GvKTR0PR1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xcw51FBehISIXVEnv0OcGYFXujqAGZkyMhkUze71fZuQdwyey1/ySKwwm7ClWXb/j
	 UxU7Wd5Al9fPyq0UX8o5Bi5FJ+YSk8kPSCR7Q8o1QqGDeOGNj51UVbckYUNGDsVlw4
	 17e/k2+6LZCkLBY8xDTUY+nGtzBH5GtTEnfwy/GyR+vYbxtsPd9Q9bZ+v4lpyQNjOP
	 KCtIzn2zrJU8OyRdOqjjyqdUgtJKLcuo6zFLXA6PWpKlfGPsnO90XhiwJRVSiuvAI5
	 Hwv3kOKXW200WdYIf49CW0W//AxAtSZmqgV9Xg6a7B46KOzJmhSRNddRfkX+7ogRon
	 fGV9BWkDklskA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so2569031e87.2;
        Fri, 22 Mar 2024 06:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuFiAmRVPIVO1vvVuPGSCSS0TGt0p+BqQ1pg6iUNLw5FRyqXjQ+IQCPFgpZyRBy0KL7AOefwlyPN40FKhf2wSSl74rFt+pWuWs5Dv6dlnmPys/5BncwqX0IaeE0pjVRDIsC4tBEsWOCQ==
X-Gm-Message-State: AOJu0YzaP2JSzt4gApLgT+3WzvhkywUkToVKvYCkC6yX8VP48CHytFFb
	pBiwOrZEKJZ8evG/8P25VnNW8XkepM2bIG4yUl6TEmpltK3Q2zY2w7kPQxd6DFjlyVoINJmRLrJ
	dojBjIxVDrLVuR+3P0UPKEOI+0A==
X-Google-Smtp-Source: AGHT+IGShtSOhncddmHXYu9diKT22KEOwQgt20rkfL2262Q/pnHoO9lS86y1FmpTwfkItWZX52S5tQ/eHohd0+9pvZI=
X-Received: by 2002:a05:6512:32a5:b0:513:22f0:c3af with SMTP id
 q5-20020a05651232a500b0051322f0c3afmr1841331lfe.4.1711114447356; Fri, 22 Mar
 2024 06:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321025105.53210-1-sudanl@amazon.com> <20240321025105.53210-5-sudanl@amazon.com>
In-Reply-To: <20240321025105.53210-5-sudanl@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 22 Mar 2024 08:33:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com>
Message-ID: <CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
To: Sudan Landge <sudanl@amazon.com>
Cc: tytso@mit.edu, Jason@zx2c4.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com, 
	thomas.lendacky@amd.com, dan.j.williams@intel.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, dwmw@amazon.co.uk, 
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:51=E2=80=AFPM Sudan Landge <sudanl@amazon.com> wr=
ote:
>
> - Extend the vmgenid platform driver to support devicetree bindings.
>   With this support, hypervisors can send vmgenid notifications to
>   the virtual machine without the need to enable ACPI. The bindings
>   are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml
>
> - Use proper FLAGS to compile with and without ACPI and/or devicetree.
>
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  drivers/virt/Kconfig   |   2 +-
>  drivers/virt/vmgenid.c | 106 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 101 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 40129b6f0eca..4f33ee2f0372 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -16,7 +16,7 @@ if VIRT_DRIVERS
>  config VMGENID
>         tristate "Virtual Machine Generation ID driver"
>         default y
> -       depends on ACPI
> +       depends on (ACPI || OF)

One of those is pretty much always enabled, so it can probably be dropped.

>         help
>           Say Y here to use the hypervisor-provided Virtual Machine Gener=
ation ID
>           to reseed the RNG when the VM is cloned. This is highly recomme=
nded if
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index d5394c706bd9..ec378c37a2a2 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights R=
eserved.
>   *
> - * The "Virtual Machine Generation ID" is exposed via ACPI and changes w=
hen a
> + * The "Virtual Machine Generation ID" is exposed via ACPI or DT and cha=
nges when a
>   * virtual machine forks or is cloned. This driver exists for shepherdin=
g that
>   * information to random.c.
>   */
> @@ -13,14 +13,27 @@
>  #include <linux/random.h>
>  #include <acpi/actypes.h>
>  #include <linux/platform_device.h>
> -
> +#ifdef CONFIG_OF

You don't need nor want ifdefs around includes.

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

Doubtful you need this header.

> +#include <linux/of_irq.h>
> +#endif
> +
> +#ifdef CONFIG_ACPI

Probably don't need this.

>  ACPI_MODULE_NAME("vmgenid");
> +#endif
>
>  enum { VMGENID_SIZE =3D 16 };
>
>  struct vmgenid_state {
>         u8 *next_id;
>         u8 this_id[VMGENID_SIZE];
> +#ifdef CONFIG_OF

Really worth saving 1 int on ACPI systems?

> +       unsigned int irq;
> +#endif
>  };
>
>  static void vmgenid_notify(struct device *device)
> @@ -37,10 +50,24 @@ static void vmgenid_notify(struct device *device)
>         kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
>  }
>
> +#ifdef CONFIG_ACPI

Avoid ifdefs. Use "IS_ENABLED(CONFIG_ACPI)" instead if you must.

>  static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *de=
v)
>  {
> +       (void)handle;
> +       (void)event;

I don't think these are ever needed.

>         vmgenid_notify(dev);
>  }
> +#endif
> +
> +#ifdef CONFIG_OF
> +static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
> +{
> +       (void)irq;
> +       vmgenid_notify(dev);
> +
> +       return IRQ_HANDLED;
> +}
> +#endif
>
>  static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>  {
> @@ -55,6 +82,7 @@ static int setup_vmgenid_state(struct vmgenid_state *st=
ate, u8 *next_id)
>
>  static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *st=
ate)
>  {
> +#ifdef CONFIG_ACPI
>         struct acpi_device *device =3D ACPI_COMPANION(dev);
>         struct acpi_buffer parsed =3D { ACPI_ALLOCATE_BUFFER };
>         union acpi_object *obj;
> @@ -96,6 +124,54 @@ static int vmgenid_add_acpi(struct device *dev, struc=
t vmgenid_state *state)
>  out:
>         ACPI_FREE(parsed.pointer);
>         return ret;
> +#else
> +       (void)dev;
> +       (void)state;
> +       return -EINVAL;
> +#endif
> +}
> +
> +static int vmgenid_add_of(struct device *dev, struct vmgenid_state *stat=
e)
> +{
> +#ifdef CONFIG_OF
> +       struct resource res;
> +       int ret =3D 0;
> +
> +       if (of_address_to_resource(dev->of_node, 0, &res)) {

No, use the platform_ APIs which work for both ACPI and DT.

> +               dev_err(dev, "Failed to get resources from device tree");
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (!__request_mem_region(res.start, resource_size(&res),

There's a single API to do this and ioremap. Use it.

> +                                 "vmgenid", IORESOURCE_EXCLUSIVE)) {
> +               dev_err(dev, "Failed to request mem region");
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D setup_vmgenid_state(state, (u8 *)of_iomap(dev->of_node, 0=
));
> +       if (ret)
> +               goto out;
> +
> +       state->irq =3D irq_of_parse_and_map(dev->of_node, 0);

platform_get_irq()

> +       dev->driver_data =3D state;
> +
> +       if (request_irq(state->irq, vmgenid_of_irq_handler,
> +                       IRQF_SHARED, "vmgenid", dev) < 0) {
> +               dev_err(dev, "request_irq failed");
> +               dev->driver_data =3D NULL;
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +out:
> +       return ret;
> +#else
> +       (void)dev;
> +       (void)state;
> +       return -EINVAL;
> +#endif
>  }
>
>  static int vmgenid_add(struct platform_device *pdev)
> @@ -108,7 +184,10 @@ static int vmgenid_add(struct platform_device *pdev)
>         if (!state)
>                 return -ENOMEM;
>
> -       ret =3D vmgenid_add_acpi(dev, state);
> +       if (dev->of_node)
> +               ret =3D vmgenid_add_of(dev, state);
> +       else
> +               ret =3D vmgenid_add_acpi(dev, state);
>
>         if (ret)
>                 devm_kfree(dev, state);
> @@ -116,18 +195,33 @@ static int vmgenid_add(struct platform_device *pdev=
)
>         return ret;
>  }
>
> -static const struct acpi_device_id vmgenid_ids[] =3D {
> +#ifdef CONFIG_OF
> +static const struct of_device_id vmgenid_of_ids[] =3D {
> +       { .compatible =3D "linux,vmgenctr", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id vmgenid_acpi_ids[] =3D {
>         { "VMGENCTR", 0 },
>         { "VM_GEN_COUNTER", 0 },
>         { }
>  };
> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
> +#endif
>
>  static struct platform_driver vmgenid_plaform_driver =3D {
>         .probe      =3D vmgenid_add,
>         .driver     =3D {
>                 .name   =3D "vmgenid",
> -               .acpi_match_table =3D ACPI_PTR(vmgenid_ids),
> +#ifdef CONFIG_ACPI
> +               .acpi_match_table =3D ACPI_PTR(vmgenid_acpi_ids),

Pretty sure you don't need the ifdef AND ACPI_PTR.

> +#endif
> +#ifdef CONFIG_OF
> +               .of_match_table =3D vmgenid_of_ids,
> +#endif
>                 .owner =3D THIS_MODULE,
>         },
>  };
> --
> 2.40.1
>
>


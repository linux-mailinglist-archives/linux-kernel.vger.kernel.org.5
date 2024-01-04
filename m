Return-Path: <linux-kernel+bounces-17034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB67824767
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D15AB24F92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F5286BF;
	Thu,  4 Jan 2024 17:25:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E8286AD;
	Thu,  4 Jan 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59614694ca2so107204eaf.1;
        Thu, 04 Jan 2024 09:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389121; x=1704993921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SneCguYreyjGXQzF3i7sYG1yhzrxbO3Wd59E1ARonos=;
        b=Yit4CHdsF5X64/0+vZ1OOcRwY88dhx7daB0xKr+IvWOfD2vonQtd4bNb3OF2EtmHgu
         WyoM7enu4OW9iaCUt+/cY+ag4adJyXG9/GG5Z3bKBsSTnl7a6Im6NltKIcq4CvY7rYjK
         Te28rEDd00NwWW1frvm1Xyul/gXG8zaalnYGnVnXI+/jHJaJkEzcK7f+w+GcFt70JJOu
         z2USa9qn329YdgcIy4Qb01LWxfGnAum0gZzDrD4ne77r8x5Lieut0g1I/WeUd0mbqRMw
         uvvqr04pXwi30+H6xZbYNNiUD4Kh8rCBJocTwEXusrk3G7w4rfBTRxIOUcHqQHgcDXs1
         myYQ==
X-Gm-Message-State: AOJu0Yx3AUXKxZ9vRID4UWLDXPo0dnSNzKB6jpT+dc12O0rB2FyG8wqv
	Ry09SiXprEWcPA53hVigx6Dvh3Al0n/V9oC6zqI=
X-Google-Smtp-Source: AGHT+IHlcucd5Gv3cttSuF/+EFuM7u5wlHZiD9dzffo0exNiak1gL9YSVhAbedzFTr8fLCXfvgdLYm5XKtqVXg0WhlA=
X-Received: by 2002:a4a:da09:0:b0:596:2965:be22 with SMTP id
 e9-20020a4ada09000000b005962965be22mr1405077oou.1.1704389121350; Thu, 04 Jan
 2024 09:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240104024819.848979-1-kai.heng.feng@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 18:25:10 +0100
Message-ID: <CAJZ5v0g0M4B-01AT6+WBASkSyfqVAYSJUS4oE+rw=obXFT1WcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:48=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> The function of acpi_power_meter module on Dell system requires IPMI
> handler is installed and SMI is selected.
>
> So add a helper to let acpi_power_meter know when IPMI handler and SMI
> are ready.

The changelog is a bit terse.

It could describe the problem at hand in more detail, for example.

Also it wouldn't hurt to provide a Link: tag pointing to a place where
some extra details could be found.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - New patch.
>
>  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
>  include/acpi/acpi_bus.h  |  5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 0555f68c2dfd..54862cab7171 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
>  #define IPMI_TIMEOUT                   (5000)
>  #define ACPI_IPMI_MAX_MSG_LENGTH       64
>
> +static struct completion smi_selected;
> +
>  struct acpi_ipmi_device {
>         /* the device list attached to driver_data.ipmi_devices */
>         struct list_head head;
> @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct devi=
ce *dev)
>                 if (temp->handle =3D=3D handle)
>                         goto err_lock;
>         }
> -       if (!driver_data.selected_smi)
> +       if (!driver_data.selected_smi) {
>                 driver_data.selected_smi =3D ipmi_device;
> +               complete(&smi_selected);

It looks like the new completion is at least related to driver_data,
so should it be a member of the latter?

> +       }
>         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>         mutex_unlock(&driver_data.ipmi_lock);
>
> @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical=
_address address,
>         return status;
>  }
>
> +int acpi_wait_for_acpi_ipmi(void)
> +{
> +       long ret;
> +
> +       ret =3D wait_for_completion_interruptible_timeout(&smi_selected, =
2 * HZ);

Why does it wait for 2 ticks and not 3 or 5?

Also it would be nice to have a symbol defined for this timeout value.

> +
> +       return ret > 0 ? 0 : -ETIMEDOUT;

if (ret <=3D 0)
        return -ETIMEDOUT;

return 0;

pretty please.

> +}
> +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> +
>  static int __init acpi_ipmi_init(void)
>  {
>         int result;
>         acpi_status status;

Empty line here, please.

> +       init_completion(&smi_selected);

Does it really make sense to initialize it when ACPI is disabled?

>
>         if (acpi_disabled)
>                 return 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1216d72c650f..afa6e4d4bf46 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_de=
vice *adev)
>  {
>         acpi_dev_put(adev);
>  }
> +
> +int acpi_wait_for_acpi_ipmi(void);
> +
>  #else  /* CONFIG_ACPI */
>
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>
> +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> +
>  #endif                         /* CONFIG_ACPI */
>
>  #endif /*__ACPI_BUS_H__*/
> --


Return-Path: <linux-kernel+bounces-164940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F68B8545
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9261C22071
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601543ADF;
	Wed,  1 May 2024 05:19:02 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C213CF65
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540741; cv=none; b=DnLbGL6Vn8gmguXyj3uudrE1bui+l1sUJhwo4zihRekfbc2ltbv034mnB156zHh5xKoWBeo/HZ9qURhiEDWN12dodVR58NRPlT8a3YuDWvI96XFR3C6SNvKXORVs+Mi8YWywPvFQQuaDeDOqFK9ySebCpuP3yZdehMtwnr4slWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540741; c=relaxed/simple;
	bh=JgICzKVbJRnODiyB5g1upUhOIHo9/RiVH5oOIbufmro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atgS/kV06in/HQxfDvXPwYpzj1aorefe91EiLvfrRI79xgGVBft0VCYjZL3xs/2Ows2UkkEzcrbs7DXFoFC56XIfvbbwoL0Pq46pQq6RlICaSVWVWLAwrPvNGF5Ekk4h3QPmXn43S7po51G/2Fj/kWMIYFZWCB/VHWPoEefPxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a58a36008ceso758312866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714540736; x=1715145536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9A42FpUeKl1h0kZk+VbwTD7dQutb/e2LYnEIBUFaLI=;
        b=pUznVeCNoF0cv15E4HJBOPeXS/77hk/bABqDi/I9HmzguT1RrXAXbvdkZg2NDylbxM
         b4poxbPu/HGUHKK0z/p/qQ8Qr6HceAqnkNYmSO8SI0yb8t1wGwvzTV+xr8dIiBO/TrBy
         UgVkklovrO8ad157HR3YmEoGdpWv41D9GQDiEFMtofqOa1jVqhrtMEC/wDErXoAQAQrx
         +T1FHJzEsOHTqrFH8rCg/SvJ31MmqmBIrW2nU6/wU2wkplLCY4VzemdCOpwvD7b3p0PW
         AnVD9hlduAcWxHy6ey3VZLhJSdGGX/sFzU7unwq4wCnwsx8Lhcgn2ATK1pi1vsjw/h+H
         wvOQ==
X-Gm-Message-State: AOJu0Yw+fV6hiaOpg4lLk9fNViCL83/Lba2JTcB5ZoSOYAJ1/PT1Pjzv
	kxIoFKGiL/k/zGK6E66fzXxLK9e+WgRjvPJqvMKi408MUYKrcfuyPnvpmCWJ
X-Google-Smtp-Source: AGHT+IFzaK9mcFuVaWaC0boWe0a91E2XEDq1jPxRhulu7a73nLdOjZg8QUITbKQjRdztfOtRymFgmw==
X-Received: by 2002:a17:906:b884:b0:a58:868d:b6c8 with SMTP id hb4-20020a170906b88400b00a58868db6c8mr1096504ejb.45.1714540735507;
        Tue, 30 Apr 2024 22:18:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id u3-20020a170906b10300b00a52552a8605sm15823721ejy.159.2024.04.30.22.18.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 22:18:55 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58a36008ceso758310166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:18:55 -0700 (PDT)
X-Received: by 2002:a17:906:3757:b0:a58:d7d8:2f4d with SMTP id
 e23-20020a170906375700b00a58d7d82f4dmr1237941ejc.61.1714540734910; Tue, 30
 Apr 2024 22:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713974291.git.thomas.lendacky@amd.com> <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
In-Reply-To: <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Tue, 30 Apr 2024 22:18:43 -0700
X-Gmail-Original-Message-ID: <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com>
Message-ID: <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:00=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> The TSM attestation report support provides multiple configfs attribute
> types (both for standard and binary attributes) to allow for additional
> attributes to be displayed for SNP as compared to TDX. With the ability
> to hide attributes via configfs, consoldate the multiple attribute groups
> into a single standard attribute group and a single binary attribute
> group. Modify the TDX support to hide the attributes that were previously
> "hidden" as a result of registering the selective attribute groups.
>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
>  drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
>  include/linux/tsm.h                     | 41 ++++++++++---
>  4 files changed, 102 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/=
sev-guest/sev-guest.c
> index 2abb51bd034f..ec3d894cfe31 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -23,6 +23,7 @@
>  #include <linux/sockptr.h>
>  #include <linux/cleanup.h>
>  #include <linux/uuid.h>
> +#include <linux/configfs.h>
>  #include <uapi/linux/sev-guest.h>
>  #include <uapi/linux/psp-sev.h>
>
> @@ -975,7 +976,7 @@ static int __init sev_guest_probe(struct platform_dev=
ice *pdev)
>         /* Set the privlevel_floor attribute based on the vmpck_id */
>         sev_tsm_ops.privlevel_floor =3D vmpck_id;
>
> -       ret =3D tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_typ=
e);
> +       ret =3D tsm_register(&sev_tsm_ops, snp_dev);
>         if (ret)
>                 goto e_free_cert_data;
>
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index 1253bf76b570..964af57f345c 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/tsm.h>
>  #include <linux/sizes.h>
> +#include <linux/configfs.h>
>
>  #include <uapi/linux/tdx-guest.h>
>
> @@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report *report,=
 void *data)
>         return ret;
>  }
>
> +static bool tdx_report_attr_visible(struct config_item *item,
> +                                   struct configfs_attribute *attr, int =
n)
> +{
> +       switch (n) {
> +       case TSM_REPORT_GENERATION:
> +       case TSM_REPORT_PROVIDER:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool tdx_report_bin_attr_visible(struct config_item *item,
> +                                       struct configfs_bin_attribute *at=
tr, int n)
> +{
> +       switch (n) {
> +       case TSM_REPORT_INBLOB:
> +       case TSM_REPORT_OUTBLOB:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -281,6 +306,8 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>  static const struct tsm_ops tdx_tsm_ops =3D {
>         .name =3D KBUILD_MODNAME,
>         .report_new =3D tdx_report_new,
> +       .report_attr_visible =3D tdx_report_attr_visible,
> +       .report_bin_attr_visible =3D tdx_report_bin_attr_visible,
>  };
>
>  static int __init tdx_guest_init(void)
> @@ -301,7 +328,7 @@ static int __init tdx_guest_init(void)
>                 goto free_misc;
>         }
>
> -       ret =3D tsm_register(&tdx_tsm_ops, NULL, NULL);
> +       ret =3D tsm_register(&tdx_tsm_ops, NULL);
>         if (ret)
>                 goto free_quote;
>
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index d1c2db83a8ca..dedb4f582630 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -14,7 +14,6 @@
>
>  static struct tsm_provider {
>         const struct tsm_ops *ops;
> -       const struct config_item_type *type;
>         void *data;
>  } provider;
>  static DECLARE_RWSEM(tsm_rwsem);
> @@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct confi=
g_item *cfg, void *buf,
>  }
>  CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
>
> -#define TSM_DEFAULT_ATTRS() \
> -       &tsm_report_attr_generation, \
> -       &tsm_report_attr_provider
> -
>  static struct configfs_attribute *tsm_report_attrs[] =3D {
> -       TSM_DEFAULT_ATTRS(),
> +       [TSM_REPORT_GENERATION] =3D &tsm_report_attr_generation,
> +       [TSM_REPORT_PROVIDER] =3D &tsm_report_attr_provider,
> +       [TSM_REPORT_PRIVLEVEL] =3D &tsm_report_attr_privlevel,
> +       [TSM_REPORT_PRIVLEVEL_FLOOR] =3D &tsm_report_attr_privlevel_floor=
,
>         NULL,
>  };
>
> -static struct configfs_attribute *tsm_report_extra_attrs[] =3D {
> -       TSM_DEFAULT_ATTRS(),
> -       &tsm_report_attr_privlevel,
> -       &tsm_report_attr_privlevel_floor,
> -       NULL,
> -};
> -
> -#define TSM_DEFAULT_BIN_ATTRS() \
> -       &tsm_report_attr_inblob, \
> -       &tsm_report_attr_outblob
> -
>  static struct configfs_bin_attribute *tsm_report_bin_attrs[] =3D {
> -       TSM_DEFAULT_BIN_ATTRS(),
> -       NULL,
> -};
> -
> -static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] =3D {
> -       TSM_DEFAULT_BIN_ATTRS(),
> -       &tsm_report_attr_auxblob,
> +       [TSM_REPORT_INBLOB] =3D &tsm_report_attr_inblob,
> +       [TSM_REPORT_OUTBLOB] =3D &tsm_report_attr_outblob,
> +       [TSM_REPORT_AUXBLOB] =3D &tsm_report_attr_auxblob,
>         NULL,
>  };
>
> @@ -297,21 +280,12 @@ static struct configfs_item_operations tsm_report_i=
tem_ops =3D {
>         .release =3D tsm_report_item_release,
>  };
>
> -const struct config_item_type tsm_report_default_type =3D {
> +static const struct config_item_type tsm_report_type =3D {
>         .ct_owner =3D THIS_MODULE,
>         .ct_bin_attrs =3D tsm_report_bin_attrs,
>         .ct_attrs =3D tsm_report_attrs,
>         .ct_item_ops =3D &tsm_report_item_ops,
>  };
> -EXPORT_SYMBOL_GPL(tsm_report_default_type);
> -
> -const struct config_item_type tsm_report_extra_type =3D {
> -       .ct_owner =3D THIS_MODULE,
> -       .ct_bin_attrs =3D tsm_report_bin_extra_attrs,
> -       .ct_attrs =3D tsm_report_extra_attrs,
> -       .ct_item_ops =3D &tsm_report_item_ops,
> -};
> -EXPORT_SYMBOL_GPL(tsm_report_extra_type);
>
>  static struct config_item *tsm_report_make_item(struct config_group *gro=
up,
>                                                 const char *name)
> @@ -326,12 +300,40 @@ static struct config_item *tsm_report_make_item(str=
uct config_group *group,
>         if (!state)
>                 return ERR_PTR(-ENOMEM);
>
> -       config_item_init_type_name(&state->cfg, name, provider.type);
> +       config_item_init_type_name(&state->cfg, name, &tsm_report_type);
>         return &state->cfg;
>  }
>
> +static bool tsm_report_is_visible(struct config_item *item,
> +                                 struct configfs_attribute *attr, int n)
> +{
> +       guard(rwsem_read)(&tsm_rwsem);
> +       if (!provider.ops)
> +               return false;
> +
> +       if (!provider.ops->report_attr_visible)
> +               return true;
> +
> +       return provider.ops->report_attr_visible(item, attr, n);
> +}
> +
> +static bool tsm_report_is_bin_visible(struct config_item *item,
> +                                     struct configfs_bin_attribute *attr=
, int n)
> +{
> +       guard(rwsem_read)(&tsm_rwsem);
> +       if (!provider.ops)
> +               return false;
> +
> +       if (!provider.ops->report_bin_attr_visible)
> +               return true;
> +
> +       return provider.ops->report_bin_attr_visible(item, attr, n);
> +}
> +
>  static struct configfs_group_operations tsm_report_group_ops =3D {
>         .make_item =3D tsm_report_make_item,
> +       .is_visible =3D tsm_report_is_visible,
> +       .is_bin_visible =3D tsm_report_is_bin_visible,
>  };
>
>  static const struct config_item_type tsm_reports_type =3D {
> @@ -353,16 +355,10 @@ static struct configfs_subsystem tsm_configfs =3D {
>         .su_mutex =3D __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>  };
>
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -                const struct config_item_type *type)
> +int tsm_register(const struct tsm_ops *ops, void *priv)
>  {
>         const struct tsm_ops *conflict;
>
> -       if (!type)
> -               type =3D &tsm_report_default_type;
> -       if (!(type =3D=3D &tsm_report_default_type || type =3D=3D &tsm_re=
port_extra_type))
> -               return -EINVAL;
> -
>         guard(rwsem_write)(&tsm_rwsem);
>         conflict =3D provider.ops;
>         if (conflict) {
> @@ -372,7 +368,6 @@ int tsm_register(const struct tsm_ops *ops, void *pri=
v,
>
>         provider.ops =3D ops;
>         provider.data =3D priv;
> -       provider.type =3D type;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
> @@ -384,7 +379,6 @@ int tsm_unregister(const struct tsm_ops *ops)
>                 return -EBUSY;
>         provider.ops =3D NULL;
>         provider.data =3D NULL;
> -       provider.type =3D NULL;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 50c5769657d8..fa19291a9854 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -4,6 +4,7 @@
>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> +#include <linux/configfs.h>
>
>  #define TSM_INBLOB_MAX 64
>  #define TSM_OUTBLOB_MAX SZ_32K
> @@ -42,12 +43,40 @@ struct tsm_report {
>         u8 *auxblob;
>  };
>
> +/**
> + * enum tsm_attr_index - index used to reference report attributes
> + * @TSM_REPORT_GENERATION: index of the report generation number attribu=
te
> + * @TSM_REPORT_PROVIDER: index of the provider name attribute
> + * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
> + * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg le=
vel attribute

/s/privleg/privlege

> + */
> +enum tsm_attr_index {
> +       TSM_REPORT_GENERATION,

Do we need an index for the generation attribute ? Since it is a core
function, we can allow it by default.

> +       TSM_REPORT_PROVIDER,

Same as above.

> +       TSM_REPORT_PRIVLEVEL,
> +       TSM_REPORT_PRIVLEVEL_FLOOR,
> +};
> +
> +/**
> + * enum tsm_bin_attr_index - index used to reference binary report attri=
butes
> + * @TSM_REPORT_INBLOB: index of the binary report input attribute
> + * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
> + * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
> + */
> +enum tsm_bin_attr_index {
> +       TSM_REPORT_INBLOB,
> +       TSM_REPORT_OUTBLOB,
> +       TSM_REPORT_AUXBLOB,
> +};

Why differentiate between bin attr and regular attr? Why not use the same e=
num?

> +
>  /**
>   * struct tsm_ops - attributes and operations for tsm instances
>   * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/prov=
ider
>   * @privlevel_floor: convey base privlevel for nested scenarios
>   * @report_new: Populate @report with the report blob and auxblob
>   * (optional), return 0 on successful population, or -errno otherwise
> + * @report_attr_visible: show or hide a report attribute entry
> + * @report_bin_attr_visible: show or hide a report binary attribute entr=
y
>   *
>   * Implementation specific ops, only one is expected to be registered at
>   * a time i.e. only one of "sev-guest", "tdx-guest", etc.
> @@ -56,14 +85,12 @@ struct tsm_ops {
>         const char *name;
>         unsigned int privlevel_floor;
>         int (*report_new)(struct tsm_report *report, void *data);
> +       bool (*report_attr_visible)(struct config_item *item,
> +                                   struct configfs_attribute *attr, int =
n);
> +       bool (*report_bin_attr_visible)(struct config_item *item,
> +                                       struct configfs_bin_attribute *at=
tr, int n);

I think we can use a single callback . We don't really gain anything
with bin attr differentiation.

>  };
>
> -extern const struct config_item_type tsm_report_default_type;
> -
> -/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
> -extern const struct config_item_type tsm_report_extra_type;
> -
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -                const struct config_item_type *type);
> +int tsm_register(const struct tsm_ops *ops, void *priv);
>  int tsm_unregister(const struct tsm_ops *ops);
>  #endif /* __TSM_H */
> --
> 2.43.2
>


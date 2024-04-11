Return-Path: <linux-kernel+bounces-141497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0D8A1F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE29C1F2BAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47712E5D;
	Thu, 11 Apr 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnPIB2B4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2ED79DD;
	Thu, 11 Apr 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862012; cv=none; b=HColfIMGoMRxMWvI2Kz9p9z84csMKMQ6MK0oSDmWnJepKcVOI5ChV1M9tPHz9+/64Eabkptj0X97vZWbotLScdHcrhWEImIMbfEDXh0QQfzL/fFzvXuushrV8eaOAjSj1lp6UAN8krVwHR1w23T26SL5uTo4XNGTu1lHnFJb7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862012; c=relaxed/simple;
	bh=VKfhK/Nu9CBQbE792fSyKR0w1VxB4n2qqFit4dVdnSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMWk6IewlBssaBQO56KNTjsRA4pvXGPDF36vZrhwrSlD0gRlpHNbPwKHXiM/N5U9MYbuCUeebDPYEv5glTZBwWLFIgZn7iJRVbg2mdilWCvnvhdzdMRJ5JeXPjvIuWCBe7QN6QGGqi/cWbOD1eizw7yNor9MZTNQlD/WLBoEueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnPIB2B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1624C072AA;
	Thu, 11 Apr 2024 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862012;
	bh=VKfhK/Nu9CBQbE792fSyKR0w1VxB4n2qqFit4dVdnSw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=SnPIB2B4FZFNNUm79Y7SkIAsCRWfADaYq4iA5xsVlonanYXrPysZCnCH+iNgBkSmd
	 Fn6jHp3Ii88UFOWAcA4KQLHLZzMdGMTyzQRnH+mahZ+OcpFC8jq72A2FVzftWryPPZ
	 dh+Hc6v9R+5JexkvBcnaH/MW8AIDI5n12VgCLldAmAhg/7NKKpGdJMurwnlQEK7sz/
	 XJOWDh8E5/bcuQMXBdRLiMVBdOt7AkfpmakxzA40nVVYjTIxs3snqxsPlPUD2bSCYI
	 hSfl6YoKwLk0nF3FVf0S6F9GDRkASQyQzI3cNjP1pcJTI9hcdYzLJFcvZO14J/4Cf4
	 ulawu8+919TOQ==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-345b857d7adso45314f8f.1;
        Thu, 11 Apr 2024 12:00:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVmFItVJX5ETqSSR/eWLSYoC1hXyXN5XyXLetXvXcwwn2a4OGrmW5doiJQNWDVAPDNI8VlgYW0tOSbGj8MW842toWQwD+QRhGI0hFbdK03Ef5bbxkRbr4om3VY2bAHnCorac/NAepULiE4ZvH31hIOOWruIRaDJHB/AhAMaqLYg9SQgRcQskM=
X-Gm-Message-State: AOJu0Yyp9cztL9dsYbcFDvyvLDYZqiRoCtlb3it6IdM40U+GHUWQH+sD
	mJkQlgeXfVxOMld0Q3afxK6AJMeIfITbFHtMDcuOioP+WqJTrFtUupo7O6o7PDiLewPYbQ9xHSH
	t4CDbVW/QuBJBYMo49ldkXs1WCQ==
X-Google-Smtp-Source: AGHT+IHouGQwbcl3OeZl/zdPg0dJBMMXgtf/0DZo/pxvXCSBPViYdLQLhJer0V+3fXtB/ZpDJwd4Jgxh638hmWwQ4cA=
X-Received: by 2002:a2e:81c6:0:b0:2d6:a5cf:367c with SMTP id
 s6-20020a2e81c6000000b002d6a5cf367cmr392152ljg.38.1712861989582; Thu, 11 Apr
 2024 11:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328211543.191876-1-quic_obabatun@quicinc.com> <20240328211543.191876-4-quic_obabatun@quicinc.com>
In-Reply-To: <20240328211543.191876-4-quic_obabatun@quicinc.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 13:59:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+RQaKTqB6hnsCJ_d0zM6FkrMXQ0NF0r1P22q95_ZDM4A@mail.gmail.com>
Message-ID: <CAL_Jsq+RQaKTqB6hnsCJ_d0zM6FkrMXQ0NF0r1P22q95_ZDM4A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] of: reserved_mem: Use the unflatten_devicetree
 APIs to scan reserved mem. nodes
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com, 
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org, 
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, mpe@ellerman.id.au, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	chris@zankel.net, jcmvbkbc@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:16=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The unflatten_devicetree APIs have been setup and are available to be
> used by the time the fdt_init_reserved_mem() function is called.
> Since the unflatten_devicetree APIs are a more efficient way of scanning
> through the DT nodes, switch to using these APIs to facilitate the rest
> of the reserved memory processing.

Please use get_maintainers.pl. Specifically, you missed maintainers
for kernel/dma/.

>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c    | 77 +++++++++++++++++++++------------
>  include/linux/of_reserved_mem.h |  2 +-
>  kernel/dma/coherent.c           |  8 ++--
>  kernel/dma/contiguous.c         |  8 ++--
>  kernel/dma/swiotlb.c            | 10 ++---
>  5 files changed, 64 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 0aba366eba59..68d1f4cca4bb 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -99,7 +99,7 @@ static void __init alloc_reserved_mem_array(void)
>  /*
>   * fdt_reserved_mem_save_node() - save fdt node for second pass initiali=
zation
>   */
> -static void __init fdt_reserved_mem_save_node(unsigned long node, const =
char *uname,
> +static void __init fdt_reserved_mem_save_node(struct device_node *node, =
const char *uname,
>                                               phys_addr_t base, phys_addr=
_t size)
>  {
>         struct reserved_mem *rmem =3D &reserved_mem[reserved_mem_count];
> @@ -109,7 +109,7 @@ static void __init fdt_reserved_mem_save_node(unsigne=
d long node, const char *un
>                 return;
>         }
>
> -       rmem->fdt_node =3D node;
> +       rmem->dev_node =3D node;
>         rmem->name =3D uname;
>         rmem->base =3D base;
>         rmem->size =3D size;
> @@ -178,11 +178,11 @@ static int __init __reserved_mem_reserve_reg(unsign=
ed long node,
>  }
>
>  /*
> - * __reserved_mem_check_root() - check if #size-cells, #address-cells pr=
ovided
> + * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cell=
s provided
>   * in /reserved-memory matches the values supported by the current imple=
mentation,
>   * also check if ranges property has been provided
>   */
> -static int __init __reserved_mem_check_root(unsigned long node)
> +static int __init __fdt_reserved_mem_check_root(unsigned long node)
>  {
>         const __be32 *prop;
>
> @@ -200,6 +200,29 @@ static int __init __reserved_mem_check_root(unsigned=
 long node)
>         return 0;
>  }
>
> +/*
> + * __dt_reserved_mem_check_root() - check if #size-cells, #address-cells=
 provided
> + * in /reserved-memory matches the values supported by the current imple=
mentation,
> + * also check if ranges property has been provided
> + */
> +static int __init __dt_reserved_mem_check_root(struct device_node *node)

The normal prefix is 'of', not 'dt'. Weird, right?, but it dates back
to OpenFirmware.

> +{
> +       const __be32 *prop;
> +
> +       prop =3D of_get_property(node, "#size-cells", NULL);

Throughout, use the appropriate typed function. Here for example,
of_property_read_u32().

> +       if (!prop || be32_to_cpup(prop) !=3D dt_root_size_cells)
> +               return -EINVAL;
> +
> +       prop =3D of_get_property(node, "#address-cells", NULL);
> +       if (!prop || be32_to_cpup(prop) !=3D dt_root_addr_cells)
> +               return -EINVAL;
> +
> +       prop =3D of_get_property(node, "ranges", NULL);

Or for presence, just of_property_present().

> +       if (!prop)
> +               return -EINVAL;
> +       return 0;
> +}
> +
>  /**
>   * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
>   * reserved memory regions.
> @@ -213,33 +236,38 @@ static int __init __reserved_mem_check_root(unsigne=
d long node)
>  static void __init fdt_scan_reserved_mem_reg_nodes(void)
>  {
>         int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeof(=
__be32);
> -       const void *fdt =3D initial_boot_params;
> +       struct device_node *node, *child;
>         phys_addr_t base, size;
>         const __be32 *prop;
> -       int node, child;
>         int len;
>
> -       node =3D fdt_path_offset(fdt, "/reserved-memory");
> -       if (node < 0) {
> +       node =3D of_find_node_by_path("/reserved-memory");
> +       if (!node) {
>                 pr_info("Reserved memory: No reserved-memory node in the =
DT\n");
>                 return;
>         }
>
> -       if (__reserved_mem_check_root(node)) {
> +       if (__dt_reserved_mem_check_root(node)) {
>                 pr_err("Reserved memory: unsupported node format, ignorin=
g\n");
>                 return;
>         }
>
> -       fdt_for_each_subnode(child, fdt, node) {
> +       for_each_child_of_node(node, child) {
>                 const char *uname;
> +               struct reserved_mem *rmem;
>
> -               prop =3D of_get_flat_dt_prop(child, "reg", &len);
> -               if (!prop)
> +               if (!of_device_is_available(child))
>                         continue;
> -               if (!of_fdt_device_is_available(fdt, child))
> +
> +               prop =3D of_get_property(child, "reg", &len);

We have specific unflattened functions for reading 'reg'. Note that
you should use the 'translated' ones even though we have a check to
disallow any real translation. That restriction should be fixed at
some point.

> +               if (!prop) {
> +                       rmem =3D of_reserved_mem_lookup(child);
> +                       if (rmem)
> +                               rmem->dev_node =3D child;
>                         continue;
> +               }
>
> -               uname =3D fdt_get_name(fdt, child, NULL);
> +               uname =3D of_node_full_name(child);
>                 if (len && len % t_len !=3D 0) {
>                         pr_err("Reserved memory: invalid reg property in =
'%s', skipping node.\n",
>                                uname);
> @@ -269,7 +297,7 @@ int __init fdt_scan_reserved_mem(void)
>         if (node < 0)
>                 return -ENODEV;
>
> -       if (__reserved_mem_check_root(node) !=3D 0) {
> +       if (__fdt_reserved_mem_check_root(node) !=3D 0) {
>                 pr_err("Reserved memory: unsupported node format, ignorin=
g\n");
>                 return -EINVAL;
>         }
> @@ -447,7 +475,7 @@ static int __init __reserved_mem_alloc_size(unsigned =
long node, const char *unam
>                        uname, (unsigned long)(size / SZ_1M));
>                 return -ENOMEM;
>         }
> -       fdt_reserved_mem_save_node(node, uname, base, size);
> +       fdt_reserved_mem_save_node(NULL, uname, base, size);
>         return 0;
>  }
>
> @@ -467,7 +495,7 @@ static int __init __reserved_mem_init_node(struct res=
erved_mem *rmem)
>                 reservedmem_of_init_fn initfn =3D i->data;
>                 const char *compat =3D i->compatible;
>
> -               if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
> +               if (!of_device_is_compatible(rmem->dev_node, compat))
>                         continue;
>
>                 ret =3D initfn(rmem);
> @@ -500,11 +528,6 @@ static int __init __rmem_cmp(const void *a, const vo=
id *b)
>         if (ra->size > rb->size)
>                 return 1;
>
> -       if (ra->fdt_node < rb->fdt_node)
> -               return -1;
> -       if (ra->fdt_node > rb->fdt_node)
> -               return 1;
> -
>         return 0;
>  }
>
> @@ -551,16 +574,16 @@ void __init fdt_init_reserved_mem(void)
>
>         for (i =3D 0; i < reserved_mem_count; i++) {
>                 struct reserved_mem *rmem =3D &reserved_mem[i];
> -               unsigned long node =3D rmem->fdt_node;
> +               struct device_node *node =3D rmem->dev_node;
>                 int len;
>                 const __be32 *prop;
>                 int err =3D 0;
>                 bool nomap;
>
> -               nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D =
NULL;
> -               prop =3D of_get_flat_dt_prop(node, "phandle", &len);
> +               nomap =3D of_get_property(node, "no-map", NULL) !=3D NULL=
;
> +               prop =3D of_get_property(node, "phandle", &len);

We store the phandle in struct device_node, so reading and storing it
here shouldn't be needed I think.

>                 if (!prop)
> -                       prop =3D of_get_flat_dt_prop(node, "linux,phandle=
", &len);
> +                       prop =3D of_get_property(node, "linux,phandle", &=
len);
>                 if (prop)
>                         rmem->phandle =3D of_read_number(prop, len/4);
>
> @@ -574,7 +597,7 @@ void __init fdt_init_reserved_mem(void)
>                 } else {
>                         phys_addr_t end =3D rmem->base + rmem->size - 1;
>                         bool reusable =3D
> -                               (of_get_flat_dt_prop(node, "reusable", NU=
LL)) !=3D NULL;
> +                               (of_get_property(node, "reusable", NULL))=
 !=3D NULL;
>
>                         pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
>                                 &rmem->base, &end, (unsigned long)(rmem->=
size / SZ_1K),
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_=
mem.h
> index 4de2a24cadc9..b6107a18d170 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -10,7 +10,7 @@ struct reserved_mem_ops;
>
>  struct reserved_mem {
>         const char                      *name;
> -       unsigned long                   fdt_node;
> +       struct device_node              *dev_node;
>         unsigned long                   phandle;
>         const struct reserved_mem_ops   *ops;
>         phys_addr_t                     base;
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index ff5683a57f77..0db0aae83102 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -362,20 +362,20 @@ static const struct reserved_mem_ops rmem_dma_ops =
=3D {
>
>  static int __init rmem_dma_setup(struct reserved_mem *rmem)
>  {
> -       unsigned long node =3D rmem->fdt_node;
> +       struct device_node *node =3D rmem->dev_node;
>
> -       if (of_get_flat_dt_prop(node, "reusable", NULL))
> +       if (of_get_property(node, "reusable", NULL))
>                 return -EINVAL;
>
>  #ifdef CONFIG_ARM
> -       if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
> +       if (!of_get_property(node, "no-map", NULL)) {

While you are here, convert this to IS_ENABLED():

if (IS_ENABLED(CONFIG_ARM) && !of_property_read_bool(node)) {
  ...
}


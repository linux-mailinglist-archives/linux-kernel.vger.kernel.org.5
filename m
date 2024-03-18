Return-Path: <linux-kernel+bounces-106233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330C87EB24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59949281490
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469D4D9F7;
	Mon, 18 Mar 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOkiQrf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B734BA88;
	Mon, 18 Mar 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772560; cv=none; b=HNiBFNip1DorEAh4HzQXNvifZ11aj54pxgp+WPEmFTXdCdCgDfGZHSBg+PvuNOL6pg+jvqHUtwGE83vDgVSJ4hbdYUBI8xuOGPQmESfQQuIHIJGi4UaPlQTsBiCtmCJVnpUkqJTko253e+QFfzJyl1oDgRAbnhjt8qpEWpZa0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772560; c=relaxed/simple;
	bh=oF9hLtwcsohnJiVEt8qqezdlceMx+de4h4QErM786wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqRDPY906wz8rzA4W8fxr0r1XrAMRIaqRzfVJ3YobHy8/3icZgIPYCo4le8/G60qdV7geej0oBS7Nq1stZGQcQalt3BWCHBhQaHLpko3xYgc5qT6yK4609oLupH9g9LzWa404g4ddPg1vjCJ/32KwcrjigfGp/19+qK/phnIJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOkiQrf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624F6C433C7;
	Mon, 18 Mar 2024 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710772560;
	bh=oF9hLtwcsohnJiVEt8qqezdlceMx+de4h4QErM786wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mOkiQrf6ckxM246JsUIVXnV4Sp0SCq9WAyn+Dw0G/ZwyZf0zOR0IlTpcRsebf/4x3
	 dOLN72P8OL4m+on0c1ke5Q+a0xaI5tLjAY7sgMGRe43nmr14NChh7nwuTJyiwvnpWh
	 whZE4DRUs/qYrwevdAlNvinchqGPiJT+3TWzw1ZR7IrHSSeVLxsK7W71a/XAauuulN
	 v286IzKvtcQo+ZVumRa0E6Mr9m+xC6HEoV10+UgOTHt7sr0LfawXt3yMJzxkiyeLh7
	 872sdhCpFSDeThxRsvNDqAT95IK5THY39UW1MuC60b7e76pKPvLH8it0XdP3P9Bal0
	 DxSntxn3yvXPA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46c2f29325so119701566b.1;
        Mon, 18 Mar 2024 07:36:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf40djurcUxmVpqGC5nYd/zjvCz1mNjR+2HdUF6Tp9GvTBw0BoTPPOZnoBJBtm6TjRT/9d3LZ0W8+3A6HM+Ejt/0N1hKKJ+g2RTu3c34f99Fu8343zrD+8Y6GtQCOQB1dMIU7S2YmK6A==
X-Gm-Message-State: AOJu0Yxjm3jAYLzyf1B+9Os3e4uVIO5PNrlPXva/43KEI4CZBS8e21A0
	QNGLNy6onsZBmDaGZwdy2Byb+/2BRxNNFt0ozwp6QHCLmJHcO7gj+B6Yq48brywOOj3DpRwN3a9
	J57+DjlRYK3JXT4zOgyaQQTQcvMc=
X-Google-Smtp-Source: AGHT+IEBTTvH10h/VYyV02a8Bi0evXno56eJEI4rAmibDHfPHssRjQJjiujkuPmEXEKCk6ISDzQGbDJgvDbzgh2H28Q=
X-Received: by 2002:a17:906:b0b:b0:a46:c139:bc30 with SMTP id
 u11-20020a1709060b0b00b00a46c139bc30mr1733843ejg.43.1710772558870; Mon, 18
 Mar 2024 07:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316082141.26139-1-zhangtianyang@loongson.cn>
In-Reply-To: <20240316082141.26139-1-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 18 Mar 2024 22:35:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cFw=JPhsvAYzMSECNvWuYK04HAA2_SLhVNTyZzQ8khA@mail.gmail.com>
Message-ID: <CAAhV-H4cFw=JPhsvAYzMSECNvWuYK04HAA2_SLhVNTyZzQ8khA@mail.gmail.com>
Subject: Re: [PATCH V2] irqchip/loongson-pch-pic: Update interrupt
 registration policy
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: jiaxun.yang@flygoat.com, tglx@linutronix.de, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Baoqi Zhang <zhangbaoqi@loongson.cn>, 
	Biao Dong <dongbiao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tianyang,

On Sat, Mar 16, 2024 at 4:22=E2=80=AFPM Tianyang Zhang
<zhangtianyang@loongson.cn> wrote:
>
> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>
> This patch remove the fixed mapping between the 7A interrupt source
> and the HT interrupt vector, and replaced it with a dynamically
> allocated approach.
Use LS7A instead of 7A here.

>
> We introduce a mapping table in struct pch_pic, where each interrupt
> source will allocate an index as a 'hwirq' from the table in the order
> of application and set table value as interrupt source number. This hwirq
> will be configured as its vector in the HT interrupt controller. For an
> interrupt source, the validity period of the obtained hwirq will last unt=
il
> the system reset
Missing a . at the end.

>
> This will be more conducive to fully utilizing existing vectors to
> support more devices
>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-pch-pic.c | 77 ++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq=
-loongson-pch-pic.c
> index 63db8e2172e0..f17187641154 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -33,7 +33,7 @@
>  #define PIC_COUNT              (PIC_COUNT_PER_REG * PIC_REG_COUNT)
>  #define PIC_REG_IDX(irq_id)    ((irq_id) / PIC_COUNT_PER_REG)
>  #define PIC_REG_BIT(irq_id)    ((irq_id) % PIC_COUNT_PER_REG)
> -
> +#define PIC_UNDEF_VECTOR       255
Keep a new line after the macro, please.

Huacai

>  static int nr_pics;
>
>  struct pch_pic {
> @@ -46,12 +46,19 @@ struct pch_pic {
>         u32                     saved_vec_en[PIC_REG_COUNT];
>         u32                     saved_vec_pol[PIC_REG_COUNT];
>         u32                     saved_vec_edge[PIC_REG_COUNT];
> +       u8                      table[PIC_COUNT];
> +       int                     inuse;
>  };
>
>  static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
>
>  struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>
> +static inline u8 hwirq_to_bit(struct pch_pic *priv, int hirq)
> +{
> +       return priv->table[hirq];
> +}
> +
>  static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
>  {
>         u32 reg;
> @@ -80,45 +87,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
>  {
>         struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
>
> -       pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
> +       pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
>         irq_chip_mask_parent(d);
>  }
>
>  static void pch_pic_unmask_irq(struct irq_data *d)
>  {
>         struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
> +       int bit =3D hwirq_to_bit(priv, d->hwirq);
>
> -       writel(BIT(PIC_REG_BIT(d->hwirq)),
> -                       priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) =
* 4);
> +       writel(BIT(PIC_REG_BIT(bit)),
> +                       priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
>
>         irq_chip_unmask_parent(d);
> -       pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
> +       pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
>  }
>
>  static int pch_pic_set_type(struct irq_data *d, unsigned int type)
>  {
>         struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
> +       int bit =3D hwirq_to_bit(priv, d->hwirq);
>         int ret =3D 0;
>
>         switch (type) {
>         case IRQ_TYPE_EDGE_RISING:
> -               pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
> -               pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
> +               pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
> +               pch_pic_bitclr(priv, PCH_PIC_POL, bit);
>                 irq_set_handler_locked(d, handle_edge_irq);
>                 break;
>         case IRQ_TYPE_EDGE_FALLING:
> -               pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
> -               pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
> +               pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
> +               pch_pic_bitset(priv, PCH_PIC_POL, bit);
>                 irq_set_handler_locked(d, handle_edge_irq);
>                 break;
>         case IRQ_TYPE_LEVEL_HIGH:
> -               pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
> -               pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
> +               pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
> +               pch_pic_bitclr(priv, PCH_PIC_POL, bit);
>                 irq_set_handler_locked(d, handle_level_irq);
>                 break;
>         case IRQ_TYPE_LEVEL_LOW:
> -               pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
> -               pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
> +               pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
> +               pch_pic_bitset(priv, PCH_PIC_POL, bit);
>                 irq_set_handler_locked(d, handle_level_irq);
>                 break;
>         default:
> @@ -133,11 +142,12 @@ static void pch_pic_ack_irq(struct irq_data *d)
>  {
>         unsigned int reg;
>         struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
> +       int bit =3D hwirq_to_bit(priv, d->hwirq);
>
> -       reg =3D readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) *=
 4);
> -       if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
> -               writel(BIT(PIC_REG_BIT(d->hwirq)),
> -                       priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) =
* 4);
> +       reg =3D readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(bit) * 4);
> +       if (reg & BIT(PIC_REG_BIT(bit))) {
> +               writel(BIT(PIC_REG_BIT(bit)),
> +                       priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
>         }
>         irq_chip_ack_parent(d);
>  }
> @@ -159,6 +169,8 @@ static int pch_pic_domain_translate(struct irq_domain=
 *d,
>  {
>         struct pch_pic *priv =3D d->host_data;
>         struct device_node *of_node =3D to_of_node(fwspec->fwnode);
> +       unsigned long flags;
> +       int i;
>
>         if (of_node) {
>                 if (fwspec->param_count < 2)
> @@ -171,6 +183,27 @@ static int pch_pic_domain_translate(struct irq_domai=
n *d,
>                         return -EINVAL;
>
>                 *hwirq =3D fwspec->param[0] - priv->gsi_base;
> +
> +               raw_spin_lock_irqsave(&priv->pic_lock, flags);
> +               /* Check pic-table to confirm if the hwirq has been assig=
ned */
> +               for (i =3D 0; i < priv->inuse; i++) {
> +                       if (priv->table[i] =3D=3D *hwirq) {
> +                               *hwirq =3D i;
> +                               break;
> +                       }
> +               }
> +               if (i =3D=3D priv->inuse) {
> +                       /* Assign a new hwirq in pic-table */
> +                       if (priv->inuse >=3D PIC_COUNT) {
> +                               pr_err("pch-pic domain has no free vector=
s\n");
> +                               raw_spin_unlock_irqrestore(&priv->pic_loc=
k, flags);
> +                               return -EINVAL;
> +                       }
> +                       priv->table[priv->inuse] =3D *hwirq;
> +                       *hwirq =3D priv->inuse++;
> +               }
> +               raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
> +
>                 if (fwspec->param_count > 1)
>                         *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>                 else
> @@ -194,6 +227,9 @@ static int pch_pic_alloc(struct irq_domain *domain, u=
nsigned int virq,
>         if (err)
>                 return err;
>
> +       /* Write vector ID */
> +       writeb(priv->ht_vec_base + hwirq, priv->base + PCH_INT_HTVEC(hwir=
q_to_bit(priv, hwirq)));
> +
>         parent_fwspec.fwnode =3D domain->parent->fwnode;
>         parent_fwspec.param_count =3D 1;
>         parent_fwspec.param[0] =3D hwirq + priv->ht_vec_base;
> @@ -222,7 +258,7 @@ static void pch_pic_reset(struct pch_pic *priv)
>
>         for (i =3D 0; i < PIC_COUNT; i++) {
>                 /* Write vector ID */
> -               writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(=
i));
> +               writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(=
hwirq_to_bit(priv, i)));
>                 /* Hardcode route to HT0 Lo */
>                 writeb(1, priv->base + PCH_INT_ROUTE(i));
>         }
> @@ -284,6 +320,7 @@ static int pch_pic_init(phys_addr_t addr, unsigned lo=
ng size, int vec_base,
>                         u32 gsi_base)
>  {
>         struct pch_pic *priv;
> +       int i;
>
>         priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -294,6 +331,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned l=
ong size, int vec_base,
>         if (!priv->base)
>                 goto free_priv;
>
> +       priv->inuse =3D 0;
> +       for (i =3D 0; i < PIC_COUNT; i++)
> +               priv->table[i] =3D PIC_UNDEF_VECTOR;
> +
>         priv->ht_vec_base =3D vec_base;
>         priv->vec_count =3D ((readq(priv->base) >> 48) & 0xff) + 1;
>         priv->gsi_base =3D gsi_base;
> --
> 2.20.1
>
>


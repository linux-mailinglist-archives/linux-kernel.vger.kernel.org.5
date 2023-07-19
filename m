Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CF75A1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGSW0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGSW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:26:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2826BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40540a8a3bbso59571cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805537; x=1690410337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSSA1lN7n0KjTsg7oA72TG3EKvc6npW9RST/+V7gA5w=;
        b=LJjIuORo74r6AjqcGXyZ+9OMOdZWWUtRe+mycw+xl1CutWmM9d7KO0p6ZSO9pplE8Q
         wyXRDrsnDRqxZkZnnYmfH2t/huF/g/bMS1elj2dLHGY46pfBK1cqFffEpp5Rp8Vn+akJ
         7ikye3sFRzJwUe5R8s+kvuXZLtgiYsQFSPFGjplgy+rdQtrItfsyiuZsguHd35BRpVdU
         Ld+LV6gJN+HED/FMuusQrnHsrdfXfyaM4I3qwLNeZJNWuUwtRLPQrrAYm4yejtWMpJBj
         jrDD2/4msJOx/UFJLS9s7C8oKM6zlCPF5wSRED5d65WNpEaXMx/D76pVseyqjBUgJuNS
         eqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805537; x=1690410337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSSA1lN7n0KjTsg7oA72TG3EKvc6npW9RST/+V7gA5w=;
        b=KHGnpbvfqeaFbFFhQiIZ/KY2XZOYxdPgpyCWiefhyOXZIulOQUX8yY0kLcEHfCidTI
         s5osDvcX5Q1ltUCs5NaafjymkD75i3JUKG8y+YE8ZQjK2HT5HbyfOdfqksneP9SXdDQa
         8ppWG0LLHtwuCWNiM55BO0FdZUXiqs3z6U1Bd+zCuf7K6arokg4dXixQtX+xfe+CCMzU
         BdVEvhVbIC7MyYQdeNIcoMgNmeFQ5IEbRUP8b58KbLtG9NbrSDeZCYX2gycykj4Gu96J
         H1HIbqSy2XEBTiJbH731zQJzfnCpQcacWeb103rhTmnvRZAz3OUhmoCeAsdrH9LIuZ86
         KMlg==
X-Gm-Message-State: ABy/qLZrhfBVeJqsT+rkY49+gGfYXcSCWCIlSNy1CK2aESmam8DdGmQN
        IaXRwzgwFRceVmSLb6jtVqFrI24VRa/gQlK2vnzbWA==
X-Google-Smtp-Source: APBJJlEwzjIsuWCIUPIJLiT0PXKD5KoIKHegCghCmNQYU/5mCiPeokHdSgbQU1HUsC+nd1R9ML5FmJIJjdAvN8pxiVU=
X-Received: by 2002:ac8:4e53:0:b0:3f6:97b4:1a4d with SMTP id
 e19-20020ac84e53000000b003f697b41a4dmr40544qtw.23.1689805537020; Wed, 19 Jul
 2023 15:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com> <20230719113542.2293295-3-apatel@ventanamicro.com>
In-Reply-To: <20230719113542.2293295-3-apatel@ventanamicro.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Jul 2023 15:25:01 -0700
Message-ID: <CAGETcx9xHSFSX1bOA8H04gXVN_Lh0HgvoC3xKesCzCEdW1dGMw@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] of: property: Add fw_devlink support for msi-parent
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 4:36=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index ddc75cd50825..e4096b79a872 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1325,6 +1325,37 @@ static struct device_node *parse_interrupts(struct=
 device_node *np,
>         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
>  }
>
> +static struct device_node *parse_msi_parent(struct device_node *np,
> +                                           const char *prop_name, int in=
dex)
> +{
> +       struct of_phandle_args sup_args;
> +       struct device_node *msi_np;
> +
> +       if (!IS_ENABLED(CONFIG_OF_IRQ))
> +               return NULL;
> +
> +       if (strcmp(prop_name, "msi-parent"))
> +               return NULL;
> +
> +       msi_np =3D of_parse_phandle(np, prop_name, 0);
> +       if (msi_np) {
> +               if (!of_property_read_bool(msi_np, "#msi-cells")) {
> +                       if (index) {
> +                               of_node_put(msi_np);
> +                               return NULL;
> +                       }
> +                       return msi_np;
> +               }
> +               of_node_put(msi_np);
> +       }
> +
> +       if (of_parse_phandle_with_args(np, prop_name, "#msi-cells", index=
,
> +                                      &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}
> +

I'm amazed by the different ways you choose to waste people's time.
Did you even scroll up to see how the other properties are handled?

Why can't this be handled using DEFINE_SIMPLE_PROP macro?

-Saravana

>  static const struct supplier_bindings of_supplier_bindings[] =3D {
>         { .parse_prop =3D parse_clocks, },
>         { .parse_prop =3D parse_interconnects, },
> @@ -1359,6 +1390,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_regulators, },
>         { .parse_prop =3D parse_gpio, },
>         { .parse_prop =3D parse_gpios, },
> +       { .parse_prop =3D parse_msi_parent, },
>         {}
>  };
>
> --
> 2.34.1
>

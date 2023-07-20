Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2875A56B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGTFVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTFVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:21:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08B1718
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:21:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso151025a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689830494; x=1690435294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SQgXWoGajTcWFTKGi9R9oxzeRnmHyz4yfoIz0S9pgc=;
        b=GySb7kH9Hq0ZehD/nmdWGqyZdN04jqMetcva5FsNZHXdU4/070YeT2JxOAFca6mx41
         uMbWGIf+kDFAE/bmbT5DTOE/0+CbhjNbeuX+Fy5FCucTxnGobC1dHKvLxIhmmhJ/glPz
         B1VYucoUWAlPAlUKStl99GrCz63r6lQLXXhFaETgAJI7INj3vrSDVJqahUTlNJoWLLxS
         1FiENqA8Lcrr21jsd2OvUa0wuobC0j0C7cCa+3T6YLDwpDZgZTrH3Qy9bFMA8Gel/QnQ
         P5OfqGAirpQuTkR4/EF3tNkNYy0YSTdmxfJ0M6n+Id1QRliu4RA3ZJGCSWb2iBej4DpG
         PpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689830494; x=1690435294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SQgXWoGajTcWFTKGi9R9oxzeRnmHyz4yfoIz0S9pgc=;
        b=EJdcKQkmfmTHm+ITHcBNiSS4WMwjhc958eydhkArsZwyCsWJq7bqsU84Rs8NVDE7Cb
         iMTbX0Q21GXc12DtQfsbZLof/tFSwrpKzfbksi1akyLSgOiviRkjrqV5CCOZbwyIN/ME
         Sk22B35vuaPrxaFk/B8DySAwgMd2Wie2tlRP1C1LmM6vq2zjHi9OWOwc2XEGKPJJSvte
         ji1+EgzVe+WHVXZQAfd9rtqYl4EXUJMi9ld4DxrfROaGiKuwk2Do1ecbwHqXRxY8IdM9
         1ZQ67t4Qc8EFB+EbYNu5lunXhQS3HP7N9AOXNLr2L5gZpXRXI0DNbFxRSHw5JjK8TafW
         kPNQ==
X-Gm-Message-State: ABy/qLbivWmdjgzA5BhqonFNuohvfpWTKRD/eHi+aq65wlJSOkZgkIje
        8z0WklE/ZTv5JY9TOLSjs89KiSmbgKipIH5ZJAltlw==
X-Google-Smtp-Source: APBJJlGf6CZynpBr6gdOp1scWXRhKuZ7KBAu5pHHukIFDVk7dldWRf2mAYhgpBTeIr8+LZjjszi5vmm//lP6e2vf08Q=
X-Received: by 2002:a17:90a:c17:b0:262:c974:6057 with SMTP id
 23-20020a17090a0c1700b00262c9746057mr15079847pjs.32.1689830494221; Wed, 19
 Jul 2023 22:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
 <20230719113542.2293295-3-apatel@ventanamicro.com> <CAGETcx9xHSFSX1bOA8H04gXVN_Lh0HgvoC3xKesCzCEdW1dGMw@mail.gmail.com>
In-Reply-To: <CAGETcx9xHSFSX1bOA8H04gXVN_Lh0HgvoC3xKesCzCEdW1dGMw@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 20 Jul 2023 10:51:22 +0530
Message-ID: <CAK9=C2W+3pOWL36ZPme1LpHz5PEBVdKWv+kR7DYKmRyw1AymMA@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] of: property: Add fw_devlink support for msi-parent
To:     Saravana Kannan <saravanak@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:55=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Wed, Jul 19, 2023 at 4:36=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > This allows fw_devlink to create device links between consumers of
> > a MSI and the supplier of the MSI.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index ddc75cd50825..e4096b79a872 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1325,6 +1325,37 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args=
.np;
> >  }
> >
> > +static struct device_node *parse_msi_parent(struct device_node *np,
> > +                                           const char *prop_name, int =
index)
> > +{
> > +       struct of_phandle_args sup_args;
> > +       struct device_node *msi_np;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_IRQ))
> > +               return NULL;
> > +
> > +       if (strcmp(prop_name, "msi-parent"))
> > +               return NULL;
> > +
> > +       msi_np =3D of_parse_phandle(np, prop_name, 0);
> > +       if (msi_np) {
> > +               if (!of_property_read_bool(msi_np, "#msi-cells")) {
> > +                       if (index) {
> > +                               of_node_put(msi_np);
> > +                               return NULL;
> > +                       }
> > +                       return msi_np;
> > +               }
> > +               of_node_put(msi_np);
> > +       }
> > +
> > +       if (of_parse_phandle_with_args(np, prop_name, "#msi-cells", ind=
ex,
> > +                                      &sup_args))
> > +               return NULL;
> > +
> > +       return sup_args.np;
> > +}
> > +
>
> I'm amazed by the different ways you choose to waste people's time.
> Did you even scroll up to see how the other properties are handled?
>
> Why can't this be handled using DEFINE_SIMPLE_PROP macro?

DEFINE_SIMPLE_PROP() is not suitable for msi-parent because we
have a special case where for a single MSI parent the "#msi-cells"
property won't be present in the supplier DT node.

The of_msi_get_domain() function also handles this special case
separately.

Regards,
Anup


>
> -Saravana
>
> >  static const struct supplier_bindings of_supplier_bindings[] =3D {
> >         { .parse_prop =3D parse_clocks, },
> >         { .parse_prop =3D parse_interconnects, },
> > @@ -1359,6 +1390,7 @@ static const struct supplier_bindings of_supplier=
_bindings[] =3D {
> >         { .parse_prop =3D parse_regulators, },
> >         { .parse_prop =3D parse_gpio, },
> >         { .parse_prop =3D parse_gpios, },
> > +       { .parse_prop =3D parse_msi_parent, },
> >         {}
> >  };
> >
> > --
> > 2.34.1
> >

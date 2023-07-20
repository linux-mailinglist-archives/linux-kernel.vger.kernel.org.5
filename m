Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473C75AD92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGTLzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGTLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:55:37 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2426B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:55:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34574eb05f4so3655625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689854116; x=1690458916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2nsfpAZOzKSfsD7kBlpnXhljpFm6V4jZ1IFt269Dzc=;
        b=kLVhvzoRiwP4KdAf8uilvLNrZhhEeWA+9WEjhqTvEMRibj4INzYHEavZysqKaNPicF
         SRMFcUJoBwewq2wnONrv2bD8dtVPw6mv3yqCGuTdxszlxFa1cAmYoK4kHsUnWBotR6f/
         tXXdXgyVHtZl9unXI+dXIvRftUHiw81I/9Cfisf8/8uHLlvuQ5hXUJP5DtQpoh1S0MPD
         02rC1yelAvNVT7tlf5NxxrEd8iHkgnomBB+3Z7geb+7UIXUoLT8NtWmfmIislmBhn3DF
         goXM0jaLYk+7GfEvTrX/dP1Nwh2HHdmXPFFstDbRsmtiLwgCALkcA86hj2J0dDZsf48v
         Onow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854116; x=1690458916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2nsfpAZOzKSfsD7kBlpnXhljpFm6V4jZ1IFt269Dzc=;
        b=JV21ri5ODKDJHfz3MGEmrJit3udnhbuLSbsFPtwO+SHaNj+fkHy8UQKQ03n4cUjjQg
         DAW0e6o4qY/4e0Kd1yVWgrGKG6NcyijbcReg5xQu456yTuTTBQlLoMbeCsmE8QTD279H
         7z3bfaC5EyDcUfBQmyae/513CtpsuM4LGMAjouhKUQmlYKxqkMH9cSXniY2wxESQSGRz
         tFF/fDbp/h8wfguLunMjkCYhdYCfuzAFk4zqeScZPvEpssLRVZrgZwoZEAIpg2vVQZb4
         lZ4vBOxlxEzRR3kr756uPxwlmFKoVB05mpgOjd8DXOGzdK2v8Kr9BO1ypjX/yo9+2PYy
         wy1Q==
X-Gm-Message-State: ABy/qLbo40/Zk08NPIOLYcVIbMdiw+l+P0rT10ABIzNzzVg31lUrXaZ1
        grIIpqh2aqC/dw7/tZz4IkYbWeyGl6oDtCqCmjSA8g==
X-Google-Smtp-Source: APBJJlGuhvDEwX4zHCaoLq/vlPx/v2JTXQRrMKCcSuSSpMPMike0ZYN5c7gHKmoZ7va9hMESrNSbxdOsjufjpaBkyv4=
X-Received: by 2002:a92:d3c6:0:b0:348:90eb:883b with SMTP id
 c6-20020a92d3c6000000b0034890eb883bmr1604226ilh.13.1689854115872; Thu, 20 Jul
 2023 04:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
 <20230719113542.2293295-3-apatel@ventanamicro.com> <20230719223758.GA892809-robh@kernel.org>
In-Reply-To: <20230719223758.GA892809-robh@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 20 Jul 2023 17:25:03 +0530
Message-ID: <CAK9=C2Ui3H8jOXZbSd_CCmtxVLWR=-JrTDK8kDbrLhJ4uUi+9g@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] of: property: Add fw_devlink support for msi-parent
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
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

On Thu, Jul 20, 2023 at 4:08=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jul 19, 2023 at 05:05:30PM +0530, Anup Patel wrote:
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
> >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
> >  }
> >
> > +static struct device_node *parse_msi_parent(struct device_node *np,
> > +                                         const char *prop_name, int in=
dex)
> > +{
> > +     struct of_phandle_args sup_args;
> > +     struct device_node *msi_np;
> > +
> > +     if (!IS_ENABLED(CONFIG_OF_IRQ))
> > +             return NULL;
>
> Why do we need this? Sparc is not going to have MSI properties to begin
> with. I guess it saves a little bit of code. Though Sparc doesn't need
> any of this file. Or maybe there's a better kconfig symbol to use here
> if MSIs are not supported?

I can't think of a better kconfig symbol over here but since Sparc does
not have MSI properties, I think following is better:

if (IS_ENABLED(CONFIG_SPARC))
    return NULL;

Any other suggestions ?

Regards,
Anup

>
> > +
> > +     if (strcmp(prop_name, "msi-parent"))
> > +             return NULL;
> > +
> > +     msi_np =3D of_parse_phandle(np, prop_name, 0);
> > +     if (msi_np) {
> > +             if (!of_property_read_bool(msi_np, "#msi-cells")) {
> > +                     if (index) {
> > +                             of_node_put(msi_np);
> > +                             return NULL;
> > +                     }
> > +                     return msi_np;
> > +             }
> > +             of_node_put(msi_np);
> > +     }
> > +
> > +     if (of_parse_phandle_with_args(np, prop_name, "#msi-cells", index=
,
> > +                                    &sup_args))
> > +             return NULL;
> > +
> > +     return sup_args.np;
> > +}
> > +
> >  static const struct supplier_bindings of_supplier_bindings[] =3D {
> >       { .parse_prop =3D parse_clocks, },
> >       { .parse_prop =3D parse_interconnects, },
> > @@ -1359,6 +1390,7 @@ static const struct supplier_bindings of_supplier=
_bindings[] =3D {
> >       { .parse_prop =3D parse_regulators, },
> >       { .parse_prop =3D parse_gpio, },
> >       { .parse_prop =3D parse_gpios, },
> > +     { .parse_prop =3D parse_msi_parent, },
> >       {}
> >  };
> >
> > --
> > 2.34.1
> >

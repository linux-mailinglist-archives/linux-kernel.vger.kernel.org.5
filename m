Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA94779CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHLCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjHLCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:49:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FC30E7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:49:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1944918a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691808583; x=1692413383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c6qMk3QtStqzHw364YKIXNMdy6an3kMtp3SLYCoxfM=;
        b=MalmpBtQxt01xsOkZTkhma+joekPlJlFUMeP0v88Y01jMPncp41rCduqz09ABypXGd
         5uGluXGgUaUgMLjiRQB3qEXc6jJ/a99+MdGEJWemD7JI0KypNbkrew/1cKdoni0cnIPi
         N1idOfSREzDnKP3pjEt1sALYZ6Kj6plNjJHT+cu+SrbqOlh2UBRqqNiy3kPBt3ABXEfX
         /8NpDswGuVUWyL7lj6cQEmiH+uzYm7s80mzicVNgcIEEawkwWAscOD73Id2BLStAteh0
         aGAwQEzVicSv9t79gYu1s672xaFiszlxS0H2fY7E7RQI4EbwQPuAUrg3gIr7WSLDdrd7
         c0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691808583; x=1692413383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c6qMk3QtStqzHw364YKIXNMdy6an3kMtp3SLYCoxfM=;
        b=c3Wg46YD8v++mUcYu31iuoRsseK39SvTB95oa6kqTMuPt1uRmDBCcQhtLaQZgMwDL/
         nrfChK13CYKdamjqgQEsxGLiBw0uuHAoOO46BGsV/ai2YRIx9NEt4+ZjfD/EpCDVANKE
         TD633xYpIIkG4HcfBnYww3idZRc016pei3dxjfUkdCkj6fK8cE6HXR14E/AzO+DwJUxw
         CTLVVcRkYOSoI93jUdeR/QAUmQFs+dqZ3ZwRF8KWIFc0owMyEs6PFqnwJ6kQwaCeUtAQ
         A55BDvSRZeljyUrbJnOanndCXvjAhsOpwRYjKw3dtcuCWnbaj2jTc0Ev5hj2qY/CCHwA
         SEKg==
X-Gm-Message-State: AOJu0Yzz2JzhmFl/myqVW/J11v9lzwYfhG/xsxy/C+RYsAMMGMxNIUw2
        BQ08l/2TacXIz/lT3T+dGuwfgBTSLpblQbW1vjhM7w==
X-Google-Smtp-Source: AGHT+IHku0ag6hrlvpEOpcPSNotrIsIoiIKBhILHsXBMpJJx+KIim1B3QMQhruyHQhr+ZmxJBtxD6KCrXp+upjFH6QM=
X-Received: by 2002:a17:90a:3ee4:b0:262:ee7d:2d20 with SMTP id
 k91-20020a17090a3ee400b00262ee7d2d20mr3093988pjc.12.1691808582631; Fri, 11
 Aug 2023 19:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-3-apatel@ventanamicro.com> <20230811193924.GA3997669-robh@kernel.org>
In-Reply-To: <20230811193924.GA3997669-robh@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 12 Aug 2023 08:19:30 +0530
Message-ID: <CAK9=C2Wncgu2U_EqP0xKNQ7aau947zhE+-hy5pguV=LP=ANikA@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] of: property: Add fw_devlink support for msi-parent
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 1:09=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Aug 02, 2023 at 08:30:05PM +0530, Anup Patel wrote:
> > This allows fw_devlink to create device links between consumers of
> > a MSI and the supplier of the MSI.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index ddc75cd50825..bc20535deed7 100644
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
> > +     if (IS_ENABLED(CONFIG_SPARC))
> > +             return NULL;
> > +
> > +     if (strcmp(prop_name, "msi-parent"))
> > +             return NULL;
> > +
> > +     msi_np =3D of_parse_phandle(np, prop_name, 0);
> > +     if (msi_np) {
> > +             if (!of_property_read_bool(msi_np, "#msi-cells")) {
>
> Use of_property_present() to check presence.
>
> However, this check is wrong. #msi-cells is optional and assumed to be 0
> if not present. There's another flavor of of_parse_phandle_with_args()
> that allows specifying a default cell count, so I think you can get rid
> of all this checking.

Okay, I will update in the next revision.

Thanks,
Anup

>
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

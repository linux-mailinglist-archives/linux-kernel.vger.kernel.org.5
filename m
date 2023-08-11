Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B836779914
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjHKVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjHKVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:00:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FA1E77
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:00:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso31541cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691787622; x=1692392422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg6w6uZ0dRKMCs1yFFd5Ty/4oQw+/NVdYykf8kUdf9o=;
        b=lcFGBAp4zn3di2vpGU1cgvo1jIdiaYUPpUtRabRS6fAqG33cQc+OSKddzuDhJknceO
         1x4podGW3ZZWsIHPvms81tYknU/ZJ1D8dF0r4HxKkS72+YQrRJ1vo155il/PjQdXjirK
         09IbEEgNu+3T1yH9jt2XBFJiYVkkwKM5fNqR8jXd8c1wupsaHSXvBLoSeTVdghAeELlv
         s+0uxE2TblBkaS36uOpUoavh/CuJ94NIpevTYdqD5d1AKYnxHNr5yKQqv1x4YbHc0wj1
         NMyA9OsGvtKYxEfvet3ZJxRUmrYZ47+w6c2vBdJjsiZm5bVg1Hs+kIP5OCjbtmSM97wo
         JRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787622; x=1692392422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg6w6uZ0dRKMCs1yFFd5Ty/4oQw+/NVdYykf8kUdf9o=;
        b=Z08KNT0CLfmEdI979Ixym05qpZoFGtNK4Jip8oCQfOpUapYiOQttfwEcSXeSBNFl8n
         G12pSLydzN2Ek1lS0DuvSjd8HWNyakd8XkTZ9ME/yc9KbdLnkiuE/QYU6+bwvh9sF/JA
         Ccr7eCXJkubXLQSsBnzjDqECMEVn7e+yrYWak7/A4swBjs9rcXD0pu6b+JXKmSrJBYm8
         hO4AxpNTo6om61nz+8AKliaOWBWjxWTSaZ9IGoyHpMRXg5e3vnrX5Vj9P3tdUBEySpU7
         ztnM2ZxOvGyxz97jhCF/sUx7mNxmbFdZr8hxXOz8ZBEqdRBsmDYIxPboSOiGzDf6OteX
         /mBQ==
X-Gm-Message-State: AOJu0Yz6Ty+9DVHmrotOOoOtzrF3I3SC1eUFJDuGzRdTEoNZNJTQ27sg
        xTl9U1G8ADcLc4HGsNoByEbW+qaRfaXa9UAtH7mPgFXUgc5gWj2+wOAE1Q==
X-Google-Smtp-Source: AGHT+IHHZ3nhL46CLGUvs4mMOWOUKG4JET9jKQEC1PVcb3KGxv0PigYsrkFmwn0CutRN32ifouOk/EgcVCoTLp5h/D0=
X-Received: by 2002:a05:622a:10d:b0:3f4:f0fd:fe7e with SMTP id
 u13-20020a05622a010d00b003f4f0fdfe7emr273205qtw.3.1691787622264; Fri, 11 Aug
 2023 14:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-3-apatel@ventanamicro.com> <20230811193924.GA3997669-robh@kernel.org>
In-Reply-To: <20230811193924.GA3997669-robh@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 11 Aug 2023 13:59:46 -0700
Message-ID: <CAGETcx8d-VfOewKAMX6aksx9e-_eaWOtU=7i3R624-B-aStBQA@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] of: property: Add fw_devlink support for msi-parent
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
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

Rob,

The existing DEFINE_SIMPLE_PROP() already does this btw. See commit
ff24fed10ba41. Anup just ignores review comments.

Anup,

Saw your reply here:
https://lore.kernel.org/lkml/CAK9=3DC2W+3pOWL36ZPme1LpHz5PEBVdKWv+kR7DYKmRy=
w1AymMA@mail.gmail.com/

Did you even try the macro? Why are you so hell bent on wasting our
time by ignoring code review comments and sending the same useless
patch?

-Saravana

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

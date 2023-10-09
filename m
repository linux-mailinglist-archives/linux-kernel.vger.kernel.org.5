Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D277BE488
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376695AbjJIPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376389AbjJIPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:20:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF499AC;
        Mon,  9 Oct 2023 08:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D80C433C8;
        Mon,  9 Oct 2023 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696864808;
        bh=k2wdi0ESEum3igcBtOoGCjgKrezpemSI40erWk6cIzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AlHAPL6jF9NPAb57BQxVTIELguJpsgfrqf3KbFnNC75Eqi7yAw+sq1csLectcBDRZ
         y1VB7Gg4KV+UEqPhrVVsaKiVepR45jBGlYCIg3nOzkSOa133yPX+v8S1ikKl3WOtFF
         9vMub9rUUNBUpLiVUcCsnTTRuqHEu+mZ3YjdOIbnmiqd1okqI9pk+ouWFOW/1d6oyv
         evrsPiJ6J5aWKHiW+6n7z7HZ9FgsmZqSGey6TXaNTaNOMRZw9z2lX5FaF066snC7U5
         5xZMJkUSkl9r5yXpNAQEy45L4QhmueHCkME5qVOuwsOTkW8EGaMRq4ZETRLqzy/8m7
         h1lhdDiqtsFbw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50325ce89e9so5965264e87.0;
        Mon, 09 Oct 2023 08:20:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2LEOnrl8kvkk1kXF82HSeMMqrsnKRpHZiYlTNRa3Aygh1PMZK
        KOg5fXR+20rG8X73mZWWviDcBMX2HTrQyS6QFw==
X-Google-Smtp-Source: AGHT+IFhlRFkTSB1BlkRgOYj134G67vvHXWjGTLvieJrhuGL/TZhVMzCUGFF32Os17cylGdm1CbeC8c1YnKiuN1CMFE=
X-Received: by 2002:a05:6512:10d5:b0:503:3890:ca3a with SMTP id
 k21-20020a05651210d500b005033890ca3amr15342746lfg.66.1696864806461; Mon, 09
 Oct 2023 08:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231006214433.339688-1-robh@kernel.org> <ZSQREEr0WBk15fFJ@x1-carbon>
In-Reply-To: <ZSQREEr0WBk15fFJ@x1-carbon>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Oct 2023 10:19:54 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Q0iR19OfyUhCvA24w+PzVNzG2qMhcH56qkADBa83Omg@mail.gmail.com>
Message-ID: <CAL_Jsq+Q0iR19OfyUhCvA24w+PzVNzG2qMhcH56qkADBa83Omg@mail.gmail.com>
Subject: Re: [PATCH] ata: xgene: Use of_device_get_match_data()
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:41=E2=80=AFAM Niklas Cassel <Niklas.Cassel@wdc.com=
> wrote:
>
> On Fri, Oct 06, 2023 at 04:44:33PM -0500, Rob Herring wrote:
> > Use preferred of_device_get_match_data() instead of of_match_device() t=
o
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Perhaps device_get_match_data() could be used here and all the ACPI
> > specific code dropped, but not sure if all the ACPI code is really
> > necessary.
> > ---
> >  drivers/ata/ahci_xgene.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> > index ccef5e63bdf9..81a1d838c0fc 100644
> > --- a/drivers/ata/ahci_xgene.c
> > +++ b/drivers/ata/ahci_xgene.c
> > @@ -13,9 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/ahci_platform.h>
> > -#include <linux/of_address.h>
> > -#include <linux/of_device.h>
> > -#include <linux/of_irq.h>
> > +#include <linux/of.h>
> >  #include <linux/phy/phy.h>
> >  #include "ahci.h"
> >
> > @@ -735,7 +733,6 @@ static int xgene_ahci_probe(struct platform_device =
*pdev)
> >       struct ahci_host_priv *hpriv;
> >       struct xgene_ahci_context *ctx;
> >       struct resource *res;
> > -     const struct of_device_id *of_devid;
> >       enum xgene_ahci_version version =3D XGENE_AHCI_V1;
> >       const struct ata_port_info *ppi[] =3D { &xgene_ahci_v1_port_info,
> >                                             &xgene_ahci_v2_port_info };
> > @@ -778,10 +775,8 @@ static int xgene_ahci_probe(struct platform_device=
 *pdev)
> >               ctx->csr_mux =3D csr;
> >       }
> >
> > -     of_devid =3D of_match_device(xgene_ahci_of_match, dev);
> > -     if (of_devid) {
> > -             if (of_devid->data)
> > -                     version =3D (unsigned long) of_devid->data;
> > +     if (dev->of_node) {
> > +             version =3D (enum xgene_ahci_version)of_device_get_match_=
data(dev);
> >       }
>
> Nit: braces can be removed.
>
> >  #ifdef CONFIG_ACPI
> >       else {

Coding style says otherwise when the 'else' has braces.

Rob

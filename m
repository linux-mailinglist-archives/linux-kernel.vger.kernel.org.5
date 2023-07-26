Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1A764049
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGZUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGZUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9C30DD;
        Wed, 26 Jul 2023 13:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5833B61CAD;
        Wed, 26 Jul 2023 20:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6400C433C8;
        Wed, 26 Jul 2023 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690402179;
        bh=ByihIIIrHPEgn7QBviz+5vCufrDNcl/yU4L5yAeVcho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bsIrc1vdjx8vHm65t/6585qT7Ch4/HzM2hNl2MlDFay/0rRdj3AXFPNdPQPRmtgIt
         vkVF8QzU+wlXddT2KDPhsXddQF0rnuF7B/vN8zwDTjr30r3kdPsFzNiQSl6ZlbFHKX
         c2Cbhy4rbUvrgLDBV/YCdaAAW/6dAWr+rYAoDt8jouPqEk+/1GySiAOUMBQ2y/eL9o
         mCVlZEwqn9+gQNf7TfqykloCVS1qX7CqFMuJf3P522GvItjInNuSd/3y2gyNvq2rx5
         MNkzyHkoI/2a0v/5uk6tfhMUKGJ/oEOU9z2/I/NRcFjUusjTXI7JC/5/huZw7Gzgkl
         C90jQKGAD75ew==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso13817621fa.1;
        Wed, 26 Jul 2023 13:09:39 -0700 (PDT)
X-Gm-Message-State: ABy/qLb0/OVlto75IeWAd/mlgYYBiaSETS5efSpO3NNv9qnp5u+Kydck
        KQo6tTsvcmYSe+tzlBKdTmP+sXSDPK+jSO1xLg==
X-Google-Smtp-Source: APBJJlEVoog0/4ge/YrLwTnu8bPhGFXj/nmL6U0D5RCzZSvpoJTVKOcH9N1dPnIvobmivRpzZI+r3KqKo0qcVTA47HY=
X-Received: by 2002:a2e:9846:0:b0:2b8:3a1e:eebd with SMTP id
 e6-20020a2e9846000000b002b83a1eeebdmr17905ljj.21.1690402177670; Wed, 26 Jul
 2023 13:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174028.4040093-1-robh@kernel.org> <CAMuHMdXdqo-OFKtHdVNu77-cuS67Cvb6NV98eYK+gtba7ir5jA@mail.gmail.com>
In-Reply-To: <CAMuHMdXdqo-OFKtHdVNu77-cuS67Cvb6NV98eYK+gtba7ir5jA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jul 2023 14:09:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VvQ-eZBN1ifH3TwROoAL2ZpSpaQrzHOfxnMkvwqgJ=w@mail.gmail.com>
Message-ID: <CAL_Jsq+VvQ-eZBN1ifH3TwROoAL2ZpSpaQrzHOfxnMkvwqgJ=w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Explicitly include correct DT includes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:15=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Jul 14, 2023 at 7:44=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch, which is now commit 657c45b303f87d77 ("MIPS:
> Explicitly include correct DT includes") in next-20230726.
>
> > --- a/arch/mips/lantiq/xway/gptu.c
> > +++ b/arch/mips/lantiq/xway/gptu.c
> > @@ -8,8 +8,8 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/ioport.h>
> >  #include <linux/init.h>
> > -#include <linux/of_platform.h>
> > -#include <linux/of_irq.h>
>
> Based on https://lore.kernel.org/all/202307270140.uClzsYnD-lkp@intel.com,
> I guess you need to keep of_irq.h for of_irq_to_resource_table()?

Ugg, yes. Posting a fix momentarily.

Too many config combinations to test on some arches...


Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57B7FEC51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjK3JzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 04:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjK3JzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:55:00 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90710E2;
        Thu, 30 Nov 2023 01:55:06 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9beb865a40so664163276.1;
        Thu, 30 Nov 2023 01:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338105; x=1701942905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kl3Cyom3VKHlW1GdXvF57049dn4ixhhiJNdSH5QXH4=;
        b=ThV1zXVjgeL2o6qm/ngXJMTKvjPsXQRDbig3iCmK90rdA7SWVKTPHPIoeqjz+lnmhh
         LVqgiBMlRJx/yf3glxVYxhTEFSLNW3ocKs56hanJW5SYwu3VXNv+xhSj/wKOq3s/XBMw
         wRSzlVb19rGENx2nL6rJNEkXlvHWl4IT3/OtVrKP3nqQnO+nF6LhNdChr5toz+gf4yZc
         /PslSlDz9jktsW2zoAmzHuOi7lA1p+UZKza4+00H+//bS6F1fIJiJKyDozFeNEtjuSHn
         S9szfSdcAOe4JuLAfAWrDG6qENbbjyQaoc6fkJOsWK697OrZRVSrtmv+Jz4bao8YvmGa
         lkLA==
X-Gm-Message-State: AOJu0YycV+K2bQzfXSRn99gHL8gZURUQcqBRGYNjb8+6vz7Il4WZgUC+
        H9fO7zcq0zYhX3+n/9rVxCEn5ls/T874Vg==
X-Google-Smtp-Source: AGHT+IGad/xbG4AWM4LSIJNFYbwM6pNaT28G+jf3I/a25gC6jZTk3p0GLY2L+0DYJY9VobqtnG1vCQ==
X-Received: by 2002:a0d:d146:0:b0:5cb:c143:cd90 with SMTP id t67-20020a0dd146000000b005cbc143cd90mr22789105ywd.35.1701338104996;
        Thu, 30 Nov 2023 01:55:04 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id z2-20020a816502000000b00597e912e67esm257647ywb.131.2023.11.30.01.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:55:03 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5d34d85e610so4119657b3.3;
        Thu, 30 Nov 2023 01:55:03 -0800 (PST)
X-Received: by 2002:a81:92d7:0:b0:5ca:e49:c98b with SMTP id
 j206-20020a8192d7000000b005ca0e49c98bmr23203204ywg.8.1701338103524; Thu, 30
 Nov 2023 01:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8t3sGn83vpgjECf5dw=bbz2yPXpnn+v2Dx2q3yJRPsKgA@mail.gmail.com>
 <CAMuHMdXMRj4quvO87LbLHCCLr14EK2AXsvr_muTDrBrA8+BMjg@mail.gmail.com> <CA+V-a8tjy2Ttp_TbZT63PC_UY12J8FLcziCtef-D-jgw_CmKaA@mail.gmail.com>
In-Reply-To: <CA+V-a8tjy2Ttp_TbZT63PC_UY12J8FLcziCtef-D-jgw_CmKaA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Nov 2023 10:54:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcUXY+J36X6iG_jtT1mQhXFbEdF57oOT4DFZAridp2_A@mail.gmail.com>
Message-ID: <CAMuHMdVcUXY+J36X6iG_jtT1mQhXFbEdF57oOT4DFZAridp2_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add missing port pins for RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Nov 30, 2023 at 9:48 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Nov 29, 2023 at 3:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Nov 29, 2023 at 3:44 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Tue, Oct 17, 2023 at 11:47 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > This patch series intends to incorporate the absent port pins P19 to P28,
> > > > which are exclusively available on the RZ/Five SoC.
> > > >
> > > > Cheers,
> > > > Prabhakar
> > > >
> > > > RFC -> v2:
> > > > * Fixed review comments pointed by Geert & Biju
> > > >
> > > > RFC: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahadev-lad.rj@bp.renesas.com/T/
> > > >
> > > > Lad Prabhakar (3):
> > > >   pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
> > > >     macro
> > > >   pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
> > > >   riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
> > > >
> > > >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
> > > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 263 ++++++++++++++++++--
> > > >  2 files changed, 242 insertions(+), 25 deletions(-)
> > > >
> > > Gentle ping.
> >
> > As the kernel test robot reported a build issue for PATCH 1/3, I had
> > removed this series from my review queue.
> Strange patchwork status didnt mention it as "rejected".

Actually I do not use patchwork that much...

> > Do you still want me to review v2, or do you want to send a v3 first?
> >
> No worries, I'll send a v3 and we can go from there.

OK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4A7FEB21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjK3Isu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Isr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:48:47 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D2B9;
        Thu, 30 Nov 2023 00:48:53 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b28dc2797dso208165e0c.0;
        Thu, 30 Nov 2023 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701334132; x=1701938932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF7XvGuHSm4q9cnkGKHl6GS7PieI8sIUSAiGVDbmtsI=;
        b=SBOME/JVUNT3jAOV01LT0KvdIWnnsS+BvX9s+y0Xf57m+yJA/SHHuX39V5iowCONpl
         vJvbZyHNikj6+E82SR5B53iGf4l2LojCDFiyUH99vB6DAbgkWKDVc9Rv3YbD7pYHY66w
         koR5aCcTpemvD+8jCNdOLbuEBHYupm1mc8cwre4kyj1ksVZvu9sBn/7g7ILCYzzxrSdk
         GbkiIzTK8O/8Ee0kPXdCTJEj7IHSnaD0+TOMkjwbt2UDcFWHcoTfuW1V7W0VzDYMv8lK
         pVpVv3kHDldimcchjhZ4A35I9X9T3Nb56bRsi1KhyBV72a6D+hrYYVr2ybA1LjVcWJHQ
         +UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701334132; x=1701938932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF7XvGuHSm4q9cnkGKHl6GS7PieI8sIUSAiGVDbmtsI=;
        b=HsLxultQJFs2oewRspJ6UeNG5xGHH6GVgRviFRDtv7aGrk8OFlyUDn6hRU6b1lSsXL
         xCsOb+bCj42qISU5U07Pxl12dLypjXrKXKAMQ9Qqtl6jer21yDASIX6swDHpMNGHgQyu
         O7SEud5J1FS+him/QvbPupa5gqM8cchnCqIX8Vz3fqXUD1D8gFg4JzJ6G4SA8Q1RVt0U
         ctNaqmTmsxF3ZV/KoxQGhLagZ61QA9MzO0vojH8y/uihi3AqEIKQyT0iWZppV5QnbEDx
         2jH+aWsMjXR6I+jZxeWLK5FoMy5bQRlyO/TOTROWxoeSVfS8MH7PKhDPwr+8XJ2kZUup
         VO6g==
X-Gm-Message-State: AOJu0Yz+yT3riG3+zh5hYm+Uk/knzbL3xlCTm2BwLlUEFsFyuWqJilHK
        RXoxocJobLB+RvfEopbNocEwFZ8HgNZCyiE9IV0=
X-Google-Smtp-Source: AGHT+IENbhoxvWJXvzBWw3lpE7WMLLrRbOa+oWZ/Vdtiq/Pa8Et2KtxYJnJpx4cNfg1W2UKBvV/KXrZi8TIXFysK/FA=
X-Received: by 2002:ac5:c245:0:b0:4b2:83ab:7ebd with SMTP id
 n5-20020ac5c245000000b004b283ab7ebdmr4968715vkk.11.1701334132657; Thu, 30 Nov
 2023 00:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8t3sGn83vpgjECf5dw=bbz2yPXpnn+v2Dx2q3yJRPsKgA@mail.gmail.com> <CAMuHMdXMRj4quvO87LbLHCCLr14EK2AXsvr_muTDrBrA8+BMjg@mail.gmail.com>
In-Reply-To: <CAMuHMdXMRj4quvO87LbLHCCLr14EK2AXsvr_muTDrBrA8+BMjg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Nov 2023 08:48:26 +0000
Message-ID: <CA+V-a8tjy2Ttp_TbZT63PC_UY12J8FLcziCtef-D-jgw_CmKaA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add missing port pins for RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Nov 29, 2023 at 3:32=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Nov 29, 2023 at 3:44=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Oct 17, 2023 at 11:47=E2=80=AFAM Prabhakar <prabhakar.csengg@gm=
ail.com> wrote:
> > > This patch series intends to incorporate the absent port pins P19 to =
P28,
> > > which are exclusively available on the RZ/Five SoC.
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > RFC -> v2:
> > > * Fixed review comments pointed by Geert & Biju
> > >
> > > RFC: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.ma=
hadev-lad.rj@bp.renesas.com/T/
> > >
> > > Lad Prabhakar (3):
> > >   pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
> > >     macro
> > >   pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P=
28
> > >   riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
> > >
> > >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
> > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 263 ++++++++++++++++++=
--
> > >  2 files changed, 242 insertions(+), 25 deletions(-)
> > >
> > Gentle ping.
>
> As the kernel test robot reported a build issue for PATCH 1/3, I had
> removed this series from my review queue.
Strange patchwork status didnt mention it as "rejected".

> Do you still want me to review v2, or do you want to send a v3 first?
>
No worries, I'll send a v3 and we can go from there.

Cheers,
Prabhakar

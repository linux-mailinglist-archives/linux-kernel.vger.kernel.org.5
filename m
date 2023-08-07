Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF361772707
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjHGOGn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjHGOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:06:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55CE81FD8;
        Mon,  7 Aug 2023 07:06:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B83D1FB;
        Mon,  7 Aug 2023 06:57:58 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441163F64C;
        Mon,  7 Aug 2023 06:57:12 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:57:09 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     martin.botka1@gmail.com, Martin Botka <martin@biqu3d.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add BigTreeTech CB1 SoM & Boards
Message-ID: <20230807145709.59156e51@donnerap.manchester.arm.com>
In-Reply-To: <3242042.aeNJFYEL58@jernej-laptop>
References: <5EB3DB1D7F80A40F+20230805083636.788048-1-martin@biqu3d.com>
        <3242042.aeNJFYEL58@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Aug 2023 13:54:21 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne sobota, 05. avgust 2023 ob 10:36:03 CEST je Martin Botka napisal(a):
> > Hello,
> > This series adds a vendor prefix for BigTreeTech and adds BigTreeTech CB1,
> > Manta board and BigTreeTech Pi.
> > 
> > CB1 is just an SoM thats based on AllWinner H616.
> > BigTreeTech Manta boards are expander boards for CB1 and BigTreeTech Pi
> > is an CB1 in Rpi style with few additional things like IR receiver and fan
> > port on GPIO.
> > 
> > This work started before I was hired by BigTreeTech and thus majority of the
> > patches are from SoMainline email and few are from my work email.
> > 
> > This series depends on commit https://lkml.org/lkml/2023/8/2/801
> > "dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips".  
> 
> What's the status of above patch?
> 
> I won't merge this series until it's accepted and merged.

So Conor ACKed it, and I think the only questions left were whether this
should be extended to all PMICs (not now, as I argued[1]), and that the
actual AXP MFD driver "implementing" the binding is not fit for that, with
a fix now here [2].

So is there any chance that there would be a second PR with the CB1 and
MangoPi DTs, still?

Cheers,
Andre

[1]
https://lore.kernel.org/lkml/20230807144229.5710738d@donnerap.manchester.arm.com/
[2]
https://lore.kernel.org/lkml/20230807133930.94309-1-andre.przywara@arm.com/

> Best regards,
> Jernej
> 
> > 
> > Cheers,
> > Martin
> > 
> > Martin Botka (4):
> >   dt-bindings: vendor-prefixes: Add BigTreeTech
> >   dt-bindings: arm: sunxi: Add BigTreeTech boards
> >   arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
> >   arm64: dts: allwinner: h616: Add BigTreeTech Pi support
> > 
> >  .../devicetree/bindings/arm/sunxi.yaml        |  11 ++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  arch/arm64/boot/dts/allwinner/Makefile        |   2 +
> >  .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
> >  .../sun50i-h616-bigtreetech-cb1.dtsi          | 140 ++++++++++++++++++
> >  .../allwinner/sun50i-h616-bigtreetech-pi.dts  |  70 +++++++++
> >  6 files changed, 260 insertions(+)
> >  create mode 100644
> > arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts create
> > mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> > create mode 100644
> > arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts  
> 
> 
> 
> 
> 


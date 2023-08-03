Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF576ED26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjHCOta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHCOt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:49:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77139173F;
        Thu,  3 Aug 2023 07:49:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA9B113E;
        Thu,  3 Aug 2023 07:50:10 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01A83F5A1;
        Thu,  3 Aug 2023 07:49:23 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:49:21 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Botka <martin@biqu3d.com>,
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
        Jernej Skrabec <jernej.skrabec@gmail.com>,
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
Subject: Re: [PATCH v1 6/6] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
Message-ID: <20230803154921.0d42fc66@donnerap.manchester.arm.com>
In-Reply-To: <17dec3fb-1bce-77ff-9917-7f565049954d@linaro.org>
References: <20230802220309.163804-1-martin@biqu3d.com>
        <DFE9B2F1349F69AE+20230802220309.163804-7-martin@biqu3d.com>
        <17dec3fb-1bce-77ff-9917-7f565049954d@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 16:30:06 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 03/08/2023 00:02, Martin Botka wrote:
> > The BigTreeTech Pi is an H616 based board based on CB1.
> > Just in Rpi format board.
> > 
> > It features the same internals as BTT CB1 but adds:
> >     - Fan port
> >     - IR receiver
> >     - 24V DC power supply via terminal plugs
> >     - USB to CAN module connector (The actual USB to CAN happens on the external module)
> > 
> > List of currently working things is the same as BTT CB1.
> > 
> > Signed-off-by: Martin Botka <martin@biqu3d.com>
> > ---
> >  .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > new file mode 100644
> > index 000000000000..05f39b3606ba
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616-bigtreetech-cb1.dtsi"  
> 
> If this is using CB1 DTSI, does it mean it uses CB1 SoM? If so, I think
> this should be reflected in the compatibles.
> 
> It's a bit confusing because in previous patch you call it "CB1 board"
> but then with name "Manta"... So what is CB1?

That's indeed a bit confusing, but from what I got from the BTT webpage:
"CB1" is the SoM. M8P (and its M4P/M5P siblings) are carrier boards with
extra hardware for 3D printer support, taking the CB1 SoM.
The "Bigtreetech BTT Pi" is embedding the same hardware as the SoM, but
without actually using the SoM, directly on a PCB, so similar to what we
have with the Pine64 SoPine and the Pine64 LTS board. It doesn't come with
the extra goodies of the more 3D printer related boards.

I *think* the "BIGTREETECH PI4B Adapter" is a normal dev board using the
actual SoM, but with an otherwise identical(?) functionality software wise
- so it can run with the same DTB. I wonder if we should have a separate
.dts for this, though, since I believe it's not really identical in every
aspect - starting with the USB ports, for instance.

But for this board and patch here I think it's fine to include the
cb1.dtsi, but not using the CB1 name in the compatibles list.

Cheers,
Andre

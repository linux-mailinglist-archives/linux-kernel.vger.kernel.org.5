Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12C77A4EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHMEXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 00:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHMEXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 00:23:44 -0400
Received: from out-81.mta1.migadu.com (out-81.mta1.migadu.com [IPv6:2001:41d0:203:375::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A61709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 21:23:45 -0700 (PDT)
Date:   Sun, 13 Aug 2023 14:23:23 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691900622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6J4O4LcgB0OvYhD9lsAZN0hjV+jYfip4h50cDdtwXM=;
        b=rVBhQaLLGPc/hJvDQWXmWex9rEukDK7PwJImulIVytTKqLck/I3R6y9nlyEyvADT9RWl6X
        +VxaxBClb+sTt5ZPIP0lKXHybhiZaZrez04tQyrqu8zeSSayPCxU82o80rG7MfikOgLW8k
        BuvyNjZYuR/TNHeBx6ER2XBiQb7rgab5aU2wz35zbz7b9ALUJW9fqf6I51foFfFBkjAXcX
        CiIONMTYk7ZycnK+dmm/Ex0GC4VnP1MyUbdtu38lnvuY+/lpQV7acfjg1THU3Z2jstbUYg
        SYXdL44Fym4wk1gzUBET2HWn4pGvLnkhIoh7c6RzFLlQ/Oj7ozQHOgrWAEiKqw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
Message-ID: <ZNhau0j_tV3EXGxl@titan>
References: <20230807191952.2019208-1-contact@jookia.org>
 <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 12:17:27PM +0800, Chen-Yu Tsai wrote:
> > Signed-off-by: John Watts <contact@jookia.org>
> > ---
> > Changes in v3:
> > - Set default pinctrl for can controller
> > - Moved can nodes to proper location
> > - Moved can pins to proper location
> >
> >  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > index d59b4acf183a..24f2e70d5886 100644
> > --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > @@ -52,6 +52,18 @@ pio: pinctrl@2000000 {
> >                         #gpio-cells = <3>;
> >                         #interrupt-cells = <3>;
> >
> > +                       /omit-if-no-ref/
> 
> Just FYI this likely ends up doing nothing if you also have them
> referenced through a default pinctrl setting. They end up always
> referenced and always included. For the D1 series it looks like no
> peripheral has default pinctrl setting given.
>
> We can still keep it though. It would help when future chip variants
> specify different pinmuxes.

Oops, thanks for pointing that out. I'll try to avoid that mistake in future.

> The compatible string should be the first property. In other sunxi SoC dtsi
> files, we put the pinctrl just before the "status" property if it's present
> to specify a default pin muxing.

Oh that makes sense.

> 
> I can fix it up while applying.

Please do!

> ChenYu

Thanks,

John.

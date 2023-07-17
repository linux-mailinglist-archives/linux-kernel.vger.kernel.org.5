Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4917558BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQAJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E61A5;
        Sun, 16 Jul 2023 17:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FAD60EC9;
        Mon, 17 Jul 2023 00:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD044C433C8;
        Mon, 17 Jul 2023 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689552595;
        bh=Z9dg4ellLpkQabLVyn6gLd88300q6gBXA05WHBUVT6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9zdy6C74PMKc/L9e61POBhoywdbASXG1Tiekjkz6fuSIzjTM4sPEDRTB9LYDxhNF
         Er9MCPB5DKSiW+9VbY/xk0PBKMmfT+YstwJ8xjCzx+cLrMjfv+vyrnXKG8U51af676
         HiBgheAezNfZbeGEPic7oFS41tD3tJqcukXAU/hnobeyT60oiruFcyMrLGtEmaTdE7
         b50WPT/4JR1V+vLHKBNBepjWUKJH4fJC2J6lniAZyq0AOdrjxYv/jZHUFAbLbKuqVL
         YnODtxfh8aUH8xawuZGb2A0xGWYZiheqSkn5EmFNoIJ5X++GRMJZzAsgI2C5rgeL0O
         BwnbB1yfnFmyw==
Date:   Mon, 17 Jul 2023 08:09:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: add cpu-supply node
 for cpufreq
Message-ID: <20230717000945.GC9559@dragon>
References: <20230606153238.1448463-1-tharvey@gateworks.com>
 <CAJ+vNU0t0ErCcu2W-nFzgjXSwM4Oq3KCK1BQBRe3c_=vj6ZK-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU0t0ErCcu2W-nFzgjXSwM4Oq3KCK1BQBRe3c_=vj6ZK-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:13:49AM -0700, Tim Harvey wrote:
> On Tue, Jun 6, 2023 at 8:32 AM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Add regulator config for cpu-supply in order to support cpufreq.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../dts/freescale/imx8mm-venice-gw7901.dts     | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > index df3b2c93d2d5..d022b5807a24 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > @@ -242,6 +242,22 @@ reg_wifi: regulator-wifi {
> >         };
> >  };
> >
> > +&A53_0 {
> > +       cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_1 {
> > +       cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_2 {
> > +       cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_3 {
> > +       cpu-supply = <&buck2>;
> > +};
> > +
> >  &ddrc {
> >         operating-points-v2 = <&ddrc_opp_table>;
> >
> > @@ -511,7 +527,7 @@ BUCK1 {
> >                         };
> >
> >                         /* vdd_arm: 0.805-1.0V (typ=0.9V) */
> > -                       BUCK2 {
> > +                       buck2: BUCK2 {
> >                                 regulator-name = "buck2";
> >                                 regulator-min-microvolt = <700000>;
> >                                 regulator-max-microvolt = <1300000>;
> > --
> > 2.25.1
> >
> 
> Hi Shawn,
> 
> I noticed this and several other of my pending patches delegated to
> you got marked as 'archived' and no longer appear as new in my
> patchwork queue [1]. I wanted to make sure they are still in your
> queue or see if I need to resubmit them. I'm not sure what the process
> is that you follow and if they got archived by you or something else.
> Please let me know if I need to do anything:

I do not use patchwork, so it doesn't reflect any status on my side.

Shawn

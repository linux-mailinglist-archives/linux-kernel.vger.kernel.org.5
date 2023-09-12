Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE52379D048
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjILLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjILLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:42:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442481736
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:42:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qg1mM-0003cE-Fx; Tue, 12 Sep 2023 13:42:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1qg1mK-005lcX-UI; Tue, 12 Sep 2023 13:42:00 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qg1mK-005cn4-LK; Tue, 12 Sep 2023 13:42:00 +0200
Date:   Tue, 12 Sep 2023 13:42:00 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        LnxRevLi <LnxRevLi@nxp.com>, linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Message-ID: <20230912114200.y626dyefwynbeytv@pengutronix.de>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <20230912113056.iyckw2j4sbg2brwr@pengutronix.de>
 <2d5f1ca5-0d09-399e-aa41-e43fcf444b8b@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5f1ca5-0d09-399e-aa41-e43fcf444b8b@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-12, Iuliana Prodan wrote:
> On 9/12/2023 2:30 PM, Marco Felsch wrote:
> > Hi Iuliana,
> > 
> > On 23-09-12, Iuliana Prodan (OSS) wrote:
> > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > 
> > > Add the reserve-memory nodes used by DSP when the rpmsg
> > > feature is enabled.
> > > These can be later used in a dsp node, like:
> > > dsp: dsp@3b6e8000 {
> > > 	compatible = "fsl,imx8mp-dsp";
> > > 	reg = <0x3b6e8000 0x88000>;
> > > 	mbox-names = "tx0", "rx0", "rxdb0";
> > > 	mboxes = <&mu2 2 0>, <&mu2 2 1>,
> > > 		<&mu2 3 0>, <&mu2 3 1>;
> > > 	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> > > 		<&dsp_vdev0vring1>, <&dsp_reserved>;
> > > 	status = "okay";
> > > };
> > > 
> > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > ---
> > >   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index cc406bb338fe..eedc1921af62 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -210,6 +210,18 @@
> > >   		dsp_reserved: dsp@92400000 {
> > >   			reg = <0 0x92400000 0 0x2000000>;
> > >   			no-map;
> > This seems broken.
> 
> 
> You're right.
> Already answered to this here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2558691.html

Sorry, saw it to late..

Regards,
  Marco

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239AC76838E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 05:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjG3DBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 23:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3DBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 23:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F11BFC;
        Sat, 29 Jul 2023 20:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0AB7609FB;
        Sun, 30 Jul 2023 03:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1431C433C8;
        Sun, 30 Jul 2023 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690686097;
        bh=y7zjaCepfGyihTSLnmL3Mq/+VnrmlfJ9HetaB/1wc7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jG5bpSBNCPLIgGdMWSxGiLs9Ljnse0247UXOqDnZGYCHLBRKlVmoZ/tRAegRaj+Ha
         1glSnLOij0P61SBlkGS1RstMtxUFquLiQdJijqyXtjneGbQpBdhye1lv4K7un7O2Lq
         cMJykJowSpTfbNmsVv5FObn1RdU9fhDHOQgVxEKROjtIame73urzDIIENsJi4xgZqK
         t3OhMiY+/2fZVT3l+t9bzgdhzsegYZS5F0vxCouc34phie8zxPpY4o7t780kv7cVLJ
         YK6TgOzdHpaSkFG1zH3bLMff3QpzTzwu9mWLtLuEmr7hQVUvhsd9L8piqaCKku11NR
         lPuRtWYQ2fpkw==
Date:   Sun, 30 Jul 2023 11:01:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Josua Mayer <josua@solid-run.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: freescale: Add support for LX2162 SoM
 & Clearfog Board
Message-ID: <20230730030123.GS151430@dragon>
References: <20230619090026.22713-1-josua@solid-run.com>
 <20230619090026.22713-5-josua@solid-run.com>
 <20230718024607.GY9559@dragon>
 <1ab424ee-21a8-9ca4-e792-3222e68e1098@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab424ee-21a8-9ca4-e792-3222e68e1098@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 12:37:38PM +0200, Josua Mayer wrote:
> Hi Shawn,
> 
> Thank you for reviewing.
> 
> Note I have added a general question inline below.
> 
> Am 18.07.23 um 04:46 schrieb Shawn Guo:
> > On Mon, Jun 19, 2023 at 12:00:26PM +0300, Josua Mayer wrote:
> > > Add support for the SolidRun LX2162A System on Module (SoM), and the
> > > Clearfog evaluation board.
> 
> > > +&dpmac11 {
> > > +	status = "okay";
> > We generally end property list with 'status'.
> Okay, I will change the order for v4.
> > 
> > Shawn
> > 
> > > +	phys = <&serdes_2 0>;
> > > +	phy-handle = <&ethernet_phy2>;
> > > +	phy-connection-type = "sgmii";
> > > +};
> > > +
> > > +&emdio1 {
> > > +	/*
> > > +	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
> > > +	 * It competes for WRIOP MAC17, and no connector has been wired.
> > > +	 */
> > > +	/delete-node/ ethernet-phy@1;
> Perhaps somebody can help here on what is best practice:
> As outlined in the comment the SoM includes an ethernet phy at address 1,
> which is not used at all by the Clearfog carrier.
> 
> What is the best practice for unused but available components?

If you are saying the connector is not wired on Clearfog, it might make
more sense to give it a disabled status in clearfog dts, IMO.

Shawn

> 
> The phy can still communicate on mdio - just it will never receive rgmii
> signals from ether cpu or carrier.
> I am leaning towards just keeping it with status okay, if only for the
> prospect that a smart driver might put it in a power-saving mode.
> 
> > > +
> > > +	ethernet_phy0: ethernet-phy@8 {
> > > +		compatible = "ethernet-phy-ieee802.3-c45";
> > > +		reg = <8>;
> > > +		max-speed = <1000>;
> > > +	};
> > > +

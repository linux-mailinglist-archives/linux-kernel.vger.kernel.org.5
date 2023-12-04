Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A5803D34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjLDSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjLDSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:36:42 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73ADFF;
        Mon,  4 Dec 2023 10:36:45 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 10075207C9;
        Mon,  4 Dec 2023 19:36:42 +0100 (CET)
Date:   Mon, 4 Dec 2023 19:36:40 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: add verdin am62 mallow board
Message-ID: <ZW4cONRWiRoOiaVd@francesco-nb.int.toradex.com>
References: <20231201145551.23337-1-francesco@dolcini.it>
 <20231201145551.23337-4-francesco@dolcini.it>
 <20231204181336.scm2fgfyyzpr2u7t@dimmer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204181336.scm2fgfyyzpr2u7t@dimmer>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishanth,

On Mon, Dec 04, 2023 at 12:13:36PM -0600, Nishanth Menon wrote:
> On 15:55-20231201, Francesco Dolcini wrote:
> > From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> [...]
> 
> > +
> > +	tpm@1 {
> > +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> 
> arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> 
> We should either drop this node OR introduce bindings and later
> introduce this series.
> 
> Yes, I know there are other places where the compatible is already used
> arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
> arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts1G
> etc.. But, unfortunately, I'd rather see the binding
> Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
> transition over to yaml prior to picking things up. (NOTE: the same
> rules apply to TI devs as well..)

I disagree (and I also know that in the end is your call to take patches
or not and I will just accept your decision whatever it is).

What you are asking here is to not use any binding that was not already
converted from txt to yaml, I do not think it is fair to force this
decision just for TI DT files.

I'd like also to add that a conversion to yaml of this binding is in the
work [1] and this DT is compliant with it.

What's DT maintainers opinion on this matter? Rob recently provided
feedback on TPM bindings txt to yaml conversion so it should be fresh on
his mind.

Francesco

[1] https://lore.kernel.org/all/cover.1701093036.git.lukas@wunner.de/

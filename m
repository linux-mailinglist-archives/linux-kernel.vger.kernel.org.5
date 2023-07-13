Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA3752AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGMS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGMS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:58:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C9E65;
        Thu, 13 Jul 2023 11:58:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIwZ9f098821;
        Thu, 13 Jul 2023 13:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274715;
        bh=6vvV5dSGBunU8apHatsM0+KaLcetuHWj5Zl/cBwlNKo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HuzzHD+pKEajI/6tgnfW/cPbY4wb5WswlTKMETgS/7Shca2EDQsSQuUAyD+USbdVo
         /7txeCLNYn0IIpcnXQ/+5NUrcmUsS+TgiqUwYx9G0+Ewte920G8oiWiPTQ3NL9BnDg
         eOANI9oNmDs/R7u8en1qScgwlayzao72BUMLUNfU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIwZfr001324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:58:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:58:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:58:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIwZBS011984;
        Thu, 13 Jul 2023 13:58:35 -0500
Date:   Thu, 13 Jul 2023 13:58:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Jayesh Choudhary <j-choudhary@ti.com>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
Message-ID: <20230713185835.ek5jskqyengvba56@ascertain>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-4-j-choudhary@ti.com>
 <20230712141828.lnpo4mhd5dv34rlz@census>
 <18310450-05f3-172c-e4bc-fda114f333a4@ti.com>
 <20230713182107.ashuygyg4x4j77s5@backboard>
 <af071a46-2e8e-a107-b0d8-d0bb2f845486@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af071a46-2e8e-a107-b0d8-d0bb2f845486@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:31-20230713, Andrew Davis wrote:
> On 7/13/23 1:21 PM, Nishanth Menon wrote:
> > On 21:01-20230713, Jayesh Choudhary wrote:
> > > 
> > > 
> > > On 12/07/23 19:48, Nishanth Menon wrote:
> > > > On 15:47-20230710, Jayesh Choudhary wrote:
> > > > > From: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > 
> > > > > J784S4 SoC has 4 Serdes instances along with their respective WIZ
> > > > > instances. Add device-tree nodes for them and disable them by default.
> > > > > 
> > > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > [j-choudhary@ti.com: fix serdes_wiz clock order]
> > > > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > > > ---
> > > > NAK. This patch introduces the following dtbs_check warning.
> > > > arch/arm64/boot/dts/ti/k3-am69-sk.dtb: serdes-refclk: 'clock-frequency' is a required property
> > > > 
> > > 
> > > Sorry for this. This property was added in the final board file.
> > > I will fix it in the next revision.
> > > I will add '0' as clock-property in the main file similar to j721e[1]
> > > which will be overridden in the board file with required value to get
> > > rid of this warning.
> > 
> > That would follow what renesas (r8a774a1.dtsi) and imx
> > (imx8dxl-ss-conn.dtsi) seem to be doing as well. Just make sure to add
> > documentation to the property to indicate expectation. Unless someone
> > has objections to this approach.
> > 
> 
> Would it work better to disable these nodes, only enabling them in the
> board files when a real clock-frequency can be provided?
> 
> My initial reaction would be to move the whole external reference clock
> node to the board file since that is where it is provided, but seems
> that would cause more churn in serdes_wiz* nodes than we would want..

I would prefer that as well, but I have'nt gone around looking for
similar examples on other SoCs (Jayesh, can you check?). One other
approach (alipine and few other places) has been for the bootloader to
update the property set in dtb as 0, which is not needed in this case
to the best of what I see.. just hoping we use a technique that most
board folks are familiar with across SoCs.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C927DE33D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjKAPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKAPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:24:35 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8225DA;
        Wed,  1 Nov 2023 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=s3Mg6e1OPGx3dxFtQuDRrNKu3fgsZsQBHayTyRSUnQ4=; b=gWvuR00aVgmtpfQjxMMmU/uwv9
        u3PRhFp5LosHmHa8qhix41WMIzZ20eLCdTj/oZ08tjCCEN+HxWaDlWB91C5Ti4FxUa1RnanWN9zbT
        RhTdN4cMtkbCb9g5fK2gp9P8N2NLEmX5DRQ/pq4jT4ThBjTayl/Nz4WbvpzLUgmB3qwI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55522 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qyD4q-0006yK-7O; Wed, 01 Nov 2023 11:24:20 -0400
Date:   Wed, 1 Nov 2023 11:24:15 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <20231101112415.b9e8a2a5b5a37ee06bd2abc3@hugovil.com>
In-Reply-To: <20231101-nebulizer-lasso-a901cd564dd1@spud>
References: <20231101144303.2653464-1-hugo@hugovil.com>
        <20231101-nebulizer-lasso-a901cd564dd1@spud>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] arm64: dts: imx8mn-rve-gateway: add support for RVE
 gateway board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 15:16:50 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Nov 01, 2023 at 10:43:02AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The RVE gateway board is based on a Variscite VAR-SOM-NANO,
> > with a NXP MX8MN nano CPU.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../devicetree/bindings/arm/fsl.yaml          |   1 +
> >  MAINTAINERS                                   |   7 +
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../boot/dts/freescale/imx8mn-rve-gateway.dts | 296 ++++++++++++++++++
> >  4 files changed, 305 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 9450b2c8a678..a1028fe8ed02 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1007,6 +1007,7 @@ properties:
> >                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
> >                - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
> >                - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
> > +              - rve,rve-gateway           # i.MX8MN RVE Gateway Board
> >            - const: fsl,imx8mn
> 
> Changes to dt-bindings should be in their own patch. Did checkpatch not
> whinge about this?

Hi,
yes it did and I very well saw it.

However, before sending my patches, I checked the log history to
see how patches for new boards were handled, and saw that new
boards (some) integrated all these changes together.

I will submit a new serie with all changes separated.

Hugo.

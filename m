Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2534806AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377191AbjLFJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbjLFJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:31:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F96A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:31:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E184C433C9;
        Wed,  6 Dec 2023 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701855074;
        bh=IqMFN3NBD8fJEXGdzcsWRBm0VvjMfikWoLBOrHQyNEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/dbmKyHcbZUVGXY26w0XNpnZCrNhqu8i6kiDo3uOwXsDv5n7bGUhOuBMtG636xsg
         JrvedZW3YS1XepPThc0ds5laMa4pywatIJlnEQtbOgPtWtZCwr+c69dR0xEw0AVzrV
         F2MxX56GNK2fZ9wqA3kJPcFa8Z5YcNNzK1/DV8SqAlUzzQbRI+X0gxf8g9crYKUhUb
         x8tV6SLWiAiky4+kZ3u4y6T8x6p7UgM0aOwnlHKySyYacpQIUV84okkEqRCErTZJuE
         1BPACPL8x2+m3PFBQW4E4IuGRUTs6sFVFi/CuxftGs8sTAVtULGR/MnK4DAUBRAsmm
         XKlaGY6EAZHzg==
Date:   Wed, 6 Dec 2023 17:31:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        alexander.stein@ew.tq-group.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <20231206093106.GE270430@dragon>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
 <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
 <20231127022140.GJ87953@dragon>
 <20231127-cherisher-falsify-8193656e8872@wendy>
 <ZXAKp1WS97cAI5X2@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAKp1WS97cAI5X2@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:46:15AM -0500, Frank Li wrote:
> On Mon, Nov 27, 2023 at 09:35:39AM +0000, Conor Dooley wrote:
> > On Mon, Nov 27, 2023 at 10:21:40AM +0800, Shawn Guo wrote:
> > > On Thu, Nov 09, 2023 at 10:51:13AM -0500, Frank Li wrote:
> > > > On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> > > > > Add I3C1 and I3C2.
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > 
> > > > @Guo Shawn:
> > > > 
> > > > Driver part already merged. 
> > > > 
> > > > Please pick up dts part
> > > 
> > > Rob had a comment [1] about SoC specific compatible.  That's not what we
> > > want?
> > > 
> > > Shawn
> > > 
> > > [1] https://lkml.iu.edu/hypermail/linux/kernel/2310.2/03035.html
> > 
> > Yeah, Rob's request here looks valid to me. Should just be a bindings
> > change Frank & fall back to the "silvaco,i3c-master-v1" compatible.
> > 
> > Cheers,
> > Conor.
> 
> @shawn:
> 	rob agree on "silvaco,i3c-master-v1" compatible.

Hmm, not sure I have seen that.  Here is what I saw from Rob:

"
The real problem here is not whether we have "v1" or not, but you need
an SoC specific compatible. Unless there's a public spec where we can
know exactly how many resets, clocks, interrupts, etc.
"

Shawn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052147F5D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjKWK4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjKWK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:56:38 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4321B2;
        Thu, 23 Nov 2023 02:56:44 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 058661F8DC;
        Thu, 23 Nov 2023 11:56:43 +0100 (CET)
Date:   Thu, 23 Nov 2023 11:56:39 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: imx8-apalis: set wifi regulator to
 always-on
Message-ID: <ZV8v5zd8G6f7BdN9@francesco-nb.int.toradex.com>
References: <20231123104812.13906-1-francesco@dolcini.it>
 <CAOMZO5A53XFbRBp6QXWoDVBr=J347_riO1wWgPLxczT3JcuwQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5A53XFbRBp6QXWoDVBr=J347_riO1wWgPLxczT3JcuwQA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio,

On Thu, Nov 23, 2023 at 07:52:27AM -0300, Fabio Estevam wrote:
> On Thu, Nov 23, 2023 at 7:48 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > Make sure that the wifi regulator is always on. The wifi driver itself
> > puts the wifi module into suspend mode. If we cut the power the driver
> > will crash when resuming from suspend.
> >
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> I think this one deserves a Fixes tag.

Fixes: ad0de4ceb706 ("arm64: dts: freescale: add initial apalis imx8 aka quadmax module support")

Shawn, I assume you could just pick the Fixes tag without me sending a
v2, if you disagree just speak-up.

Francesco


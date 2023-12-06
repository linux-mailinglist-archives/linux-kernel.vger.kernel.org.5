Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E128064BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376601AbjLFBsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376614AbjLFBsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:48:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3138D68
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:48:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA9DC433C8;
        Wed,  6 Dec 2023 01:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701827288;
        bh=aveWPcmiMSYTLWtxgppugRwbwEVebRAdbAJo1waV97c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7cfRXrYgDXLXiBhlMsGo0raQgTfNSb7goYEvNKSi2Qz0hAujY2zZj4C6Grw5zcQs
         /T3p7ZJuv/mctwQcxxl7ZH4nxql51YFsfgo4Yo6gFqRRHO+pYTr4jk2I78DArC1Xpx
         jAPHbNi0jq4eQP3iL7wrzi0mEF0jwQWgroRynZ6ZS519FolU/pSHX+CBiFBtmv2Zf2
         ZhBSqe//RjwKnD9ro4YlMTdYAqsyK4Sw7Gbz+ro0iOzK2VMA8PHPOTvv0i4QB6ocaG
         XBqrbzOEi054OzGfF3273iNBuO8qa8bijj/1q0qVr/7QwizUQ+VKo8Dugjhxpmi57p
         gwkG1LjwwFVIg==
Date:   Wed, 6 Dec 2023 09:48:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Fabio Estevam <festevam@gmail.com>,
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
Message-ID: <20231206014802.GC236001@dragon>
References: <20231123104812.13906-1-francesco@dolcini.it>
 <CAOMZO5A53XFbRBp6QXWoDVBr=J347_riO1wWgPLxczT3JcuwQA@mail.gmail.com>
 <ZV8v5zd8G6f7BdN9@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV8v5zd8G6f7BdN9@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:56:39AM +0100, Francesco Dolcini wrote:
> Hello Fabio,
> 
> On Thu, Nov 23, 2023 at 07:52:27AM -0300, Fabio Estevam wrote:
> > On Thu, Nov 23, 2023 at 7:48 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> > >
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >
> > > Make sure that the wifi regulator is always on. The wifi driver itself
> > > puts the wifi module into suspend mode. If we cut the power the driver
> > > will crash when resuming from suspend.
> > >
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > I think this one deserves a Fixes tag.
> 
> Fixes: ad0de4ceb706 ("arm64: dts: freescale: add initial apalis imx8 aka quadmax module support")
> 
> Shawn, I assume you could just pick the Fixes tag without me sending a
> v2, if you disagree just speak-up.

Applied with the Fixes tag, thanks!

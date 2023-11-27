Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074EF7F97C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjK0C6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjK0C6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:58:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCE10F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:58:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEE0C433C8;
        Mon, 27 Nov 2023 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053925;
        bh=j5H0LJTRMh4V8/+YTldNkjS/yA/dz7Y3mH3VwumbeII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkzWP87UwhoIL6f71RKfDXsUX8Lu94QCLST2fM6y9GzsfStlvkYCOC9Db0RigOKrZ
         ywJji3c3njK/cI6N/lFOXFq91/TX8xdA9Q4x+2abUQtPTnaYMcR3AH4+PcNfASl2JB
         RbmGP6t5RYfZudKCXxztbReBgWsVzsUekDyPYVBPDVuF6B3anS0o7P5GIeS21Gk92j
         mABVM3xKwr0FcTzbloX2cBGwLojosFTkruonWm0A/LvdxlnwyTfX/e4ZVQFC8d6Opi
         XbQzkPl6U14OHVVrgDti7QNC9ll0UfAKn/ibXiBYjIn+YAY5IZiOIIwRBbn6iVaZB9
         iLIN9PY2kqCQQ==
Date:   Mon, 27 Nov 2023 10:58:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexander.stein@ew.tq-group.com, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mp: Add NPU Node
Message-ID: <20231127025839.GU87953@dragon>
References: <20231022161911.10792-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022161911.10792-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 11:19:10AM -0500, Adam Ford wrote:
> The NPU is based on the Vivante GC8000 and its power-domain
> is controlled my pgc_mlmix.  Since the power-domain uses
> some of these clocks, setup the clock parent and rates
> inside the power-domain, and add the NPU node.
> 
> The data sheet states the CLK_ML_AHB should be 300MHz for
> nominal, but 800MHz clock will divide down to 266 instead.
> Boards which operate in over-drive mode should update the
> clocks on their boards accordingly.  When the driver loads,
> the NPU numerates as:
> 
>  etnaviv-gpu 38500000.npu: model: GC8000, revision: 8002
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!

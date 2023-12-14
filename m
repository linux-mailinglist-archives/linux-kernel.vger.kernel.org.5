Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5D81252D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjLNCWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjLNCWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:22:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61BE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:22:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B072EC433C8;
        Thu, 14 Dec 2023 02:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702520576;
        bh=2dqkUnZ1w5W8BpfqSy59Jzx5XEg6Jju97Zl3wCZcXxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5fmfBnw3u/yd+Ht1gxWaPfmtx7C66PTdnKAGR7naXR5IEZxeYgrrXTKVl1aiUWOQ
         xt3IdmQuT1bKJ2SbgL9kZirfAVXPudFp7hZrw+G/sRIlZGS+eb+VOksqB6PSXHYfKD
         oCMWWfSVvyHSa2JAQ9Cg2jurO5i2jyj+GWpdwKb+5dUyMC6jiNzmBpPL+Z1EmrJ04g
         uTi/v6qoBZoMgSzBBxJRyLd6B0O1K/MQQ7TuXbNvt1U8V/fwBXfOcQ2JncXow9v6EL
         l1G9WpF7bWXFUTM4VIGDJvgIdo+XLKeYMaFx6S95Rj/NBE8KFS+Ghs/OQyue0kFJ6S
         HiQirgm9xLPzA==
Date:   Thu, 14 Dec 2023 10:22:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm: Reduce GPU to nominal speed
Message-ID: <20231214022250.GY270430@dragon>
References: <20231128200219.226038-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128200219.226038-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:02:16PM -0600, Adam Ford wrote:
> When the GPU nodes were added, the GPU_PLL_OUT was configured
> for 1000MHz, but this requires the SoC to run in overdrive mode
> which requires an elevated voltage operating point.
> 
> Since this may run some boards out of spec, the default clock
> should be set to 800MHz for nominal operating mode. Boards
> that run at the higher voltage can update their clocks
> accordingly.
> 
> Fixes: 4523be8e46be ("arm64: dts: imx8mm: Add GPU nodes for 2D and 3D core")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all, thanks!

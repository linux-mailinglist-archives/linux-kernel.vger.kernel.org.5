Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA68063CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376379AbjLFA7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjLFA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:59:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B20C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:59:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C71AC433C7;
        Wed,  6 Dec 2023 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701824366;
        bh=sJAJI8bs6y4uGRz8tW7x8dYOVhPHhLeH+OCzid/IUzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNewgHzBJnDCvpC+jtfb4lKdWvkx9OE2AmvX3md0amsfQwYoEudt+24LOxR3NyNHn
         WwLb3i1C6e6QGUpAWb0brWrq7jKuC6cruFYCNqm8p1xPNJVwhmJdkh+1joI1AGzwbk
         ty4s/Y+uEl8RMy2epDLPyN7nhVQhWP9nSrRX8nF8ydrO0rvIfvuyrmT/fKTnfVIQBY
         iWbM59ELGpBZ7jOXVAJRngxLxBMU9KryumykvK9MgS9qnAxqf9ysDdK7smT2DjKgff
         qs8i+AEpzb6LYpLxqXBlpx30aELPv+cG8UibLJlYjco7Wp6K02LDVhRlpXzRr2Ob0V
         SV9dRaeEnvz7A==
Date:   Wed, 6 Dec 2023 08:59:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: Re: [PATCH] arm64: dts: imx93: correct mediamix power
Message-ID: <20231206005921.GM236001@dragon>
References: <20231113100229.3885321-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113100229.3885321-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 06:02:29PM +0800, Liu Ying wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> "nic_media" clock should be enabled when power on/off mediamix, otherwise
> power on/off will fail. Because "media_axi_root" clock is the parent of
> "nic_media" clock, so replace "media_axi_clock" clock with "nic_media"
> clock in mediamix node.
> 
> Link: https://github.com/nxp-imx/linux-imx/commit/ce18e6d0071ae9df5486af8613708ebe920484be
> Fixes: f2d03ba997cb ("arm64: dts: imx93: reorder device nodes")
> Fixes: e85d3458a804 ("arm64: dts: imx93: add src node")
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!

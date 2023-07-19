Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25FE758E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGSHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGSHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F4E60
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B2861275
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D0FC433C7;
        Wed, 19 Jul 2023 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689750035;
        bh=aroVN9ylhT+jGcY56bKaxxXfO8XoQj1uPdqUTCGAqtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDHtuu2WKS2ADWsGTrCfkLBUA9vfUIoZ341lLPeFi7sGMOxPV588R4A82BMoyXDVq
         n4BvyBO3fxP4/zlNgY5JJkwY+fHqUxzC9OLX71/c1Se+7zyrwxbtuj4gP8DPcWUtOg
         a75xbe1+0aOiJoLgI0CMwtwQm+Z+iu5A627GCcZ3Z5PxZO6DdQA68Gq6UEvB9uJWo4
         wyn7rEd6UWNWMPdmOZ0QbrWxNjneheXn4AqCl7EZSkOX803zFzvfNHd9s4neEXftF2
         U0VHoHFenxeqzL09DsJcCIzHmjgNc2OQSwoYHDxmYo3Ibj/XgHojXDiLWEO/yuyN93
         BBSas6JqlBlVQ==
Date:   Wed, 19 Jul 2023 15:00:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/7] firmware: imx: scu-pd: misc update
Message-ID: <20230719070022.GH151430@dragon>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ulf

On Fri, Jul 14, 2023 at 05:09:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patchset is to upstream NXP downstream scu-pd driver patches.
> patch 1,2 is to support more PDs
> patch 3 is to not power off console when no console suspend
> patch 4 is to suppress bind
> patch 5 is to make genpd align with HW state
> patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
> patch 7 is to change init level to avoid uneccessary defer probe
> 
> Dong Aisheng (2):
>   firmware: imx: scu-pd: do not power off console if no_console_suspend
>   firmware: imx: scu-pd: change init level to subsys_initcall
> 
> Peng Fan (5):
>   firmware: imx: scu-pd: enlarge PD range
>   firmware: imx: scu-pd: add more PDs
>   firmware: imx: scu-pd: Suppress bind attrs
>   firmware: imx: scu-pd: initialize is_off according to HW state
>   firmware: imx: scu-pd: add multi states support
> 
>  drivers/firmware/imx/scu-pd.c | 193 ++++++++++++++++++++++++++++++++--
>  1 file changed, 182 insertions(+), 11 deletions(-)

We have genpd subsystem [1] coming.  Should we consider to move this
scu-pd driver there too?

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/20230714092301.28690-1-ulf.hansson@linaro.org/T/

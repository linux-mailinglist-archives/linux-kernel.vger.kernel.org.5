Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAA75748A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGRGn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjGRGnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08EE70;
        Mon, 17 Jul 2023 23:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A26926147F;
        Tue, 18 Jul 2023 06:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8CC433C9;
        Tue, 18 Jul 2023 06:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689662628;
        bh=9K1oNze9pt6AtdqjgxNnclXiPcumaT+jibKxRxXWzoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJhUh32gvfcTMRXBulIgQBSF0mljPh5MMR8mNAba2IpM3/E3qX2CIKUEe0AO2TRwa
         wj84j2vC+CGk/8oUJ4XmpteVVRfrdrRaNr9MvJCSrCQQLoeSclfGw3zOupqiNetBiM
         0CaoJ96dMzgXqynFuher99MB/Kecbp4aDPjPhlFtHuBPwVuSRXMd1RigIQXvk2au9R
         H0DBiKP6gQr9Fj29q7bqRikcTCQKFSyCWgGy7G5L1o4iEV0ZsDlU9afYHNOhYzWRVS
         sHd8CqLcPIdI3/QwBUoKT39PW4cxULysomSHEDnlgKBX95vRdDYjPJ128VJk9NwxSM
         /i8krr3J1JWTg==
Date:   Tue, 18 Jul 2023 14:43:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm,primecell-periphid at
 etm nodes
Message-ID: <20230718064332.GM9559@dragon>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705205954.4159781-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:59:53PM -0400, Frank Li wrote:
> The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
> leads to a crash when calling amba_read_periphid().  After corrected reg
> size, amba_read_periphid() retrieve the correct periphid.
> arm,primecell-periphid were removed from the etm nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!

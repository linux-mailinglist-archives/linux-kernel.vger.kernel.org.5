Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5566D758E14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGSGqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGSGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36C1FCD;
        Tue, 18 Jul 2023 23:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3970A61150;
        Wed, 19 Jul 2023 06:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E02C433C7;
        Wed, 19 Jul 2023 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689749186;
        bh=l4O/JGjx+glMM+49cBtJIbHsNzJW5C3GTSW4DlNzLN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCCsg4/WhNDDIX2LC2TVBcNZXYJe6jWVsRwghIHQqwr/y+YBCT3l753/bgLOwUKEd
         2GvKYMDaPgr8Rv4mkxrIWHKYVhMsHrXDilHoTjM0UP7dOJhAiaXRNU9h6pTR/Fvjme
         5mGb8Y3ZyP7wPwccmCIq8Uz94LSRU7H7LjR6UIoVLWDQnQ99lIInIy10wcahaioGtt
         TaDZnhSP0tb1ObrCeBvSuJTy0YOBDlHZPL+chQXvHuLaP3iNcqTDmgNw+RH1CYiSPu
         +uzfnwg5ch8PuHLNj9B/xEi8TeQe2FKgGsmw4SAiXo+bzfEi5Q+PbIuJxTJF5KtlbU
         RWV9lc79EdTaQ==
Date:   Wed, 19 Jul 2023 14:46:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: Explicitly include correct DT includes
Message-ID: <20230719064609.GF151430@dragon>
References: <20230714175134.4067445-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714175134.4067445-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:51:33AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!

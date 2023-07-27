Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAA7653B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjG0MYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjG0MXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE335AD;
        Thu, 27 Jul 2023 05:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC1B61E65;
        Thu, 27 Jul 2023 12:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E578C433C9;
        Thu, 27 Jul 2023 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460586;
        bh=RY/e8xBfCt//GjUHvzWss+4Dt9ss+FsUcym4Dt+dFXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXxxKpJ/MCkYdBdsV56K63jQh1TAR5lGGGyi3gWHHeAOquDRYOBlltWasLMX2232z
         jjGRJKHmzf6h6+9fcK8QTmGOrUXsjhdqmdAp7dGaNfjlUzDHbRtnudKAOyTEgq9pIJ
         LCp+G6qNXPPqNJPFVkbpQ4QARJbng9SkYH+DQcoFLmLpicMCA+QJNS8t14Gdq3pBjm
         l5vCrDCFY5JgLFRUs3bbCWUKVGSTfBUWf1XaZsQ42YsHsgSXBJj/7RlqlnNHo+C8cQ
         HHajxhS4RbKfyzsMvJThGrtiUpdGYzwTA39pkoe8/a0g/9/QmW8Ke+k/VbujPLeiST
         jxjaXv+IyiyYA==
From:   Will Deacon <will@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li <Frank.li@nxp.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: Explicitly include correct DT includes
Date:   Thu, 27 Jul 2023 13:22:35 +0100
Message-Id: <169045934424.3249306.10595971010404706881.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230714174832.4061752-1-robh@kernel.org>
References: <20230714174832.4061752-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 11:48:31 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Explicitly include correct DT includes
      https://git.kernel.org/will/c/918dc87b746e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

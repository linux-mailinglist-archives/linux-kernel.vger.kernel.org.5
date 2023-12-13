Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F62811B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjLMRoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLMRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:44:21 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F3112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:44:24 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rDTH9-0001l6-L8; Wed, 13 Dec 2023 18:44:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     mripard@kernel.org, airlied@gmail.com,
        Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
        maarten.lankhorst@linux.intel.com, neil.armstrong@linaro.org,
        sam@ravnborg.org, quentin.schulz@theobroma-systems.com,
        daniel@ffwll.ch, quic_jesszhan@quicinc.com, tzimmermann@suse.de
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, victor.liu@nxp.com
Subject: Re: [PATCH] drm/panel: ltk050h3146w: Set burst mode for ltk050h3148w
Date:   Wed, 13 Dec 2023 18:44:01 +0100
Message-Id: <170248942758.833086.13775590933211922845.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213145045.41020-1-farouk.bouabid@theobroma-systems.com>
References: <20231213145045.41020-1-farouk.bouabid@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 15:50:45 +0100, Farouk Bouabid wrote:
> The ltk050h3148w variant expects the horizontal component lane byte clock
> cycle(lbcc) to be calculated using lane_mbps (burst mode) instead of the
> pixel clock.
> Using the pixel clock rate by default for this calculation was introduced
> in commit ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use pixel clock
> rate to calculate lbcc") and starting from commit 93e82bb4de01
> ("drm/bridge: synopsys: dw-mipi-dsi: Fix hcomponent lbcc for burst mode")
> only panels that support burst mode can keep using the lane_mbps. So add
> MIPI_DSI_MODE_VIDEO_BURST as part of the mode_flags for the dsi host.
> 
> [...]

Applied, thanks!

[1/1] drm/panel: ltk050h3146w: Set burst mode for ltk050h3148w
      commit: 6c9dbee84cd005bed5f9d07b3a2797ae6414b435

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

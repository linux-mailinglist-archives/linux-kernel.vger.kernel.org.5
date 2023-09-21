Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F477A9961
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjIUSOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIUSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:13:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130988613C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2B1C4E766;
        Thu, 21 Sep 2023 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306555;
        bh=VLihWTTWDyRcN1oKbSXsMzwTgw3e5f2Nt4JgNqgjmHc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SuLiY+Tf7wIE6HHdVRCxC/G1lDF/gX0c75BgE/AgAsn5nX2ZKPM3+Z++XNKC0svQJ
         HfQbsEaMJh+rA+a0YH4xaqhnT4kOef4nrv9ecIYbjV+CSIDgJFM8q32cIE3Mbhtiev
         f7dSWqUSt5OMbhSWI5Qae26S0NKOij9BSt1wBncwhEOVT3aA8hiWtoi7PrI/fVPcBF
         cJowBwpV6q+fia1qTvE+4vML1ae0iosmzIw0YzMB9KxyO/z2rNAaZGBKQMMkRKEX14
         bbqPeBFnkK0n8n3GPrVtOYfDpo3kEioTgoddzPejSuiASIRvVansYwxQXue70uQcOr
         QbqdeBZ2sIQOw==
From:   Vinod Koul <vkoul@kernel.org>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Robert Foss <rfoss@kernel.org>,
        Sandor Yu <Sandor.yu@nxp.com>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com
In-Reply-To: <cover.1686729444.git.Sandor.yu@nxp.com>
References: <cover.1686729444.git.Sandor.yu@nxp.com>
Subject: Re: [PATCH v6 0/8] Initial support for Cadence MHDP8501(HDMI/DP)
 for i.MX8MQ
Message-Id: <169530654998.106263.143064512083801166.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 09:38:10 +0800, Sandor Yu wrote:
> The patch set initial support for Cadence MHDP8501(HDMI/DP) DRM bridge
> drivers and Cadence HDP-TX PHY(HDMI/DP) drivers for Freescale i.MX8MQ.
> 
> The patch set compose of DRM bridge drivers and PHY drivers.
> 
> Both of them need the followed two patches to pass build.
>   drm: bridge: Cadence: convert mailbox functions to macro functions
>   phy: Add HDMI configuration options
> 
> [...]

Applied, thanks!

[1/8] drm: bridge: Cadence: convert mailbox functions to macro functions
      (no commit info)
[2/8] dt-bindings: display: bridge: Add Cadence MHDP8501 HDMI and DP
      (no commit info)
[3/8] drm: bridge: Cadence: Add MHDP8501 DP driver
      (no commit info)
[4/8] phy: Add HDMI configuration options
      commit: 7f90516edb5cbfa4108b92bb83cbc8ef35a4cccd
[5/8] drm: bridge: Cadence: Add MHDP8501 HDMI driver
      (no commit info)
[6/8] dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
      (no commit info)
[7/8] phy: freescale: Add DisplayPort PHY driver for i.MX8MQ
      commit: a2717f1d7c64660679441c407b96103abb7c4a8c
[8/8] phy: freescale: Add HDMI PHY driver for i.MX8MQ
      commit: 8e36091a94d2d28e8dccb9bfda081b2e42e951ae

Best regards,
-- 
~Vinod



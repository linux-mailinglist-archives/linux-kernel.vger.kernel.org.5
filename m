Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF157C67F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377602AbjJLICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjJLICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:02:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849A91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70425C433C9;
        Thu, 12 Oct 2023 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097752;
        bh=qqONej15ynQ2QHwBiVTAIWHFW22Tu2elU5+f6fXSlTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJc8q/oLY+IayLrbuR+PG/zLT1nV0UM7484+qcdeimXs/FgWOoUyL8hBdWdW9pahi
         G1acmCax4YSLGemMAkF0qLa8K6UA7o93jfOqScNk4tPbUi2/TnIXxi/Sy+w2Gb2wtm
         lbeY7CBmxVNVJq8iUHtxmUhBRKSAlcnTL7pJSsUqAPo7rlKN3qYpit5OezWvXh156C
         N0v57LgCVG8oft5E9O7et5sGz35BHgJF5uIYWfdMCMQoRnA3JniFa0O5xTxoPrs8w1
         tqvFws2AQLdxmrKA5aTAi+E4X1ibISXWcn7IvGZlFAsSLX2s7D6nJrnfi7l7OZzdVz
         W4H4Cb3KvM5xQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qqqeq-0001Cq-30;
        Thu, 12 Oct 2023 10:03:00 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] arm64: defconfig: enable Qualcomm sc8280xp sound drivers
Date:   Thu, 12 Oct 2023 10:01:56 +0200
Message-ID: <20231012080157.4616-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012080157.4616-1-johan+linaro@kernel.org>
References: <20231012080157.4616-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm sc8280xp machine driver and the wsa833x speaker
codec driver that are needed for sound on machines like the Lenovo
ThinkPad X13s.

Note that the wcd938x headphone codec driver is currently implicitly
enabled as it is selected by the sc7280 machine driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7e6c49d42104..6e67e75161e5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -909,6 +909,7 @@ CONFIG_SND_SOC_APQ8016_SBC=m
 CONFIG_SND_SOC_MSM8996=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
+CONFIG_SND_SOC_SC8280XP=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_ROCKCHIP=m
@@ -966,6 +967,7 @@ CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
+CONFIG_SND_SOC_WSA883X=m
 CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
-- 
2.41.0


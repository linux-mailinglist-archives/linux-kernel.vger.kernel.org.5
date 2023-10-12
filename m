Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5947C6897
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378206AbjJLICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347100AbjJLICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:02:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36CA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723B6C433CA;
        Thu, 12 Oct 2023 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097752;
        bh=sWHBuQlQpz4HyYLMtkhjX4nl0M9W0yzo/zYnEVJhgTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFT/N/fEhOSO4ThGpqB1dOACSwjCRwau4r9e7AMUAnJ7NeKLPGLbvmX5JpAgs7eIP
         jAnmI0HYlrt1efukLaTyY1BHUKqF5XgOTWy/0uiTpvsAb7HnWPDof5lHSmhiZv+anc
         9fIWQmVNQXFbEWd5gLlm/gHuzeKZplqcqWRctqmSJB2U6FVkXahOvPuUvs7Cyc3s2z
         2KH2iwN2q/u/MvaOkryXDkOvHR7fmCk+vAUuyWI5xyH+LTj3WqctfTrl5kpgvD67i+
         ns7HGt8OpmzgmaA83xvA2zWww5rTefmi6Lbn2apRncfCGSBRZlPwKDM5vHSbr0p9YV
         TZFMtvvEHff8Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qqqer-0001Cs-02;
        Thu, 12 Oct 2023 10:03:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: defconfig: enable Qualcomm UEFI Secure App driver
Date:   Thu, 12 Oct 2023 10:01:57 +0200
Message-ID: <20231012080157.4616-3-johan+linaro@kernel.org>
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

Enable the Qualcomm QSEECOM interface driver and the UEFI Secure
Application client driver which are needed to access EFI variables on
machines like the Lenovo ThinkPad X13s.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e67e75161e5..fff99bdd3270 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -252,6 +252,8 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
+CONFIG_QCOM_QSEECOM=y
+CONFIG_QCOM_QSEECOM_UEFISECAPP=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
-- 
2.41.0


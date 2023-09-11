Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADF79B44E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbjIKVnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbjIKKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:42:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA3E6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:42:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 527E46606F5E;
        Mon, 11 Sep 2023 11:42:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694428927;
        bh=uOfKmnGqS1mdLmWpPUw+MA783YWewPk/pzRvEU2KZgw=;
        h=From:To:Cc:Subject:Date:From;
        b=aCG3wBPhRkqT6IY1WGsg6Gz1Uz0s4qR5o1gnSdwN+UQ2nnImc2gdhCjavnBRWfEyS
         WfEMwBSm3vw/o/ihz78mi/QYOOiT8e5Mbflp9BMNk40y+qIMZayPfKqZqB0QhL12Fi
         4GjdQb6kbda3VFxdI2lebCBDMN4967z6EhdPpofi+ikZjmNF9DF6SXMWoLZfJDBNPs
         FFs/RLizTKYuQrMw3ri/EYGZ49xcjJsZN32ikmz6ijAffLlDWS6VorSDccR1w9N5gI
         fa9rYtBxVAicWhJVm2ciAqp9vzqvX6zUzgp8rwG1k7wVD9cc5+8o26CxofGPtcuWOs
         L7pi6614WvGWQ==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     angelogioacchino.delregno@collabora.com, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, krzysztof.kozlowski@linaro.org,
        geert+renesas@glider.be, arnd@arndb.de, konrad.dybcio@linaro.org,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: defconfig: Enable DA9211 regulator
Date:   Mon, 11 Sep 2023 16:11:39 +0530
Message-Id: <20230911104139.617448-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek mt8173 board fails to boot with DA9211 regulator disabled.
Enabling CONFIG_REGULATOR_DA9211=y in drm-ci fixes the issue.

So enable it in the defconfig since kernel-ci also requires it.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789f4868..8359899d291f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -729,6 +729,7 @@ CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD718XX=y
 CONFIG_REGULATOR_BD9571MWV=y
 CONFIG_REGULATOR_CROS_EC=y
+CONFIG_REGULATOR_DA9211=m
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
-- 
2.40.1


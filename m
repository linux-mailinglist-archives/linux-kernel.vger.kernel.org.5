Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4E7BA679
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjJEQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjJEQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD3E22CA9;
        Thu,  5 Oct 2023 03:49:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C1B0660731E;
        Thu,  5 Oct 2023 11:49:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696502955;
        bh=pa8pKITzfzlfDMGcUark3OZKCpHGd4WoAakJB9sAdzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qx2lQFIjxuULN86K3QtKjTJ2XoqaqR3+5/cXYj+Gnb2yTs/WaFb9YcK+nKFLok2QJ
         auj0FigSKVrUwTDrjBSsw9JBggXvdj2/U5m93EmhmqaL1w+t2ov8yzG1S3AXFYdEqL
         qXjPpLiM7sageXKQFnlOUQ0UV6V62fwgdn52yvG+qxqt9NC9GMdUer9QA9JCIlmra8
         j2JAxfPPwDec7tFMRktP+3EmmOF+oF2/+I164jdbZWWYjPphKPzfOA+F7SLAeVGHCk
         1B7Fg+zEnL4+8jqNDwJdczkdypTK1KOoHGwOvAPYkVGcSmOsUsVWMTirmaHSHcUibE
         tEe7PmTiAQd1g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 1/2] media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
Date:   Thu,  5 Oct 2023 12:49:04 +0200
Message-ID: <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
References: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDP3 RDMA needs to communicate with the SCP remote processor: allow
specifying a phandle to a SCP core.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

v2: I've dropped Conor and Chen-Yu's Reviewed-by tags because I have changed
    the description (so, the patch actually changed a bit).

 .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 7032c7e15039..59dcea797b71 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -45,6 +45,14 @@ properties:
       include/dt-bindings/gce/<chip>-gce.h of each chips.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  mediatek,scp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the System Control Processor (SCP) used for initializing
+      and stopping the MDP3, for sending frame data locations to the MDP3's
+      VPU and to install Inter-Processor Interrupt handlers to control
+      processing states.
+
   power-domains:
     maxItems: 1
 
-- 
2.42.0


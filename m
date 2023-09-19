Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481EA7A5EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjISKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjISJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:59:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7A116;
        Tue, 19 Sep 2023 02:59:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F1056607079;
        Tue, 19 Sep 2023 10:59:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695117584;
        bh=diaOf6EmUGm6l+mxt6/O1nJ6UjZ2yPHfhRpfvuoUEnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mC4nCTkI8xE1emA5TZ+ruqLSdx6SsDSZr/hQPbMf+x8/LojiaCNdOZAE/lJtkbGiS
         CNUHOzPfB2+drbHy5k2qndZVUq/8y07M3DbtEL3thwEVA6pVILz7Gv9qk4d8uMibqc
         P9R4xgpHISMt0jYQwNcn21lsyBuc5QmMTK5uOdUPOJF7wvN9TYV/Fh387v3WBNXhr1
         IuhiQoYvqpaq4KLeJ6ezOOOIiQeHMhpZyFWOgx8rsMeFuGpfWFuHHB6xt7ub4fkM/o
         mmyNVEf97IhPEOPC1xJyfmRCBtxBCPPegaiSC2Fp70rJ87l82J6/hyHedHpXhEWWG6
         SfSeuGQc0x5EA==
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
Subject: [PATCH 1/2] media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
Date:   Tue, 19 Sep 2023 11:59:37 +0200
Message-ID: <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
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

The MDP3 RDMA needs to communicate with the SCP remote processor: allow
specifying a phandle to a SCP core.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index d639a1461143..0e5ce2e77e99 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -46,6 +46,11 @@ properties:
       include/dt-bindings/gce/<chip>-gce.h of each chips.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  mediatek,scp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the System Control Processor (SCP) node
+
   power-domains:
     oneOf:
       - items:
@@ -98,6 +103,7 @@ examples:
         mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
         mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
                               <CMDQ_EVENT_MDP_RDMA0_EOF>;
+        mediatek,scp = <&scp>;
         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
         clocks = <&mmsys CLK_MM_MDP_RDMA0>,
                  <&mmsys CLK_MM_MDP_RSZ1>;
-- 
2.42.0


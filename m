Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155C57AE0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIYVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:25:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E1103;
        Mon, 25 Sep 2023 14:24:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF48C433C8;
        Mon, 25 Sep 2023 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677098;
        bh=lG0yL+eeYGuTlpkLttZs74ATqRMRX0Pu1q2jQdiN/BM=;
        h=From:To:Cc:Subject:Date:From;
        b=Tm61ldPqTCtxDXjiWNw+TTkbyOgJdeNdv0E/dtI4RAOOeskTn1xbn+aHJqLtBYelB
         VvV4eDnlAnedgpP6dl+EsQIeoyoUGx0e2fIXc7jUINHvwao24+B14CaMdOffTjcAmH
         cS0KnQhpKI7ljPBwjbLCZJGrO4C73bzAiEDYpDbfkjDbt4tAWSeXze3/8lzVNFwOvA
         6iYQkEQ3sYJeRm/T5m36AjbRcyD/JolsgUdmON0wE/ckV26gqcaznnIDtdV8jhmfql
         aVh6ffpaeRG1/DPOHE/L1Uy5svEKD6P4O0+yqxfFDFpH7ZG7Nv97dUWwiNCYzR90xx
         6NzwToDKkDk0Q==
Received: (nullmailer pid 1972777 invoked by uid 1000);
        Mon, 25 Sep 2023 21:24:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: msm: Add missing unevaluatedProperties on child node schemas
Date:   Mon, 25 Sep 2023 16:24:24 -0500
Message-Id: <20230925212434.1972368-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index f12558960cd8..dbe398f84ffb 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -114,6 +114,7 @@ properties:
 
       port@1:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: Output endpoint of the controller
         properties:
           endpoint:
-- 
2.40.1


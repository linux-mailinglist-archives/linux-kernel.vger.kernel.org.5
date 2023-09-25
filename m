Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7517AE0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjIYV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjIYV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:27:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADEA11F;
        Mon, 25 Sep 2023 14:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28BDC433C8;
        Mon, 25 Sep 2023 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677245;
        bh=ttt9MxqlXu8nD2JgUN9u6TOQN+41IkV1ecAtDT3N474=;
        h=From:To:Cc:Subject:Date:From;
        b=kYnloxV/57uAVpHewX8XeuFQPLiTF2QIJwR0cP+ubSh+Jx6ve4QYl+vRxwIp1BshC
         nvlL3Jqc63g61QjTGgGm/6AfydVlM+FMEagcyDPX04Km1rjPfNX9f11AfahfOAyJCu
         Sf4EtAb5DSS0GSkbtBII0jf3EfkACJf2tv7vhTRZU2XbVdbTclfy8HDeSGCdGhAJr7
         j4JJP1n2KZtDHbuH5oBJWz+wrl6Y7tN/U0HuyXP5S001xOEvMYkaw/fFPUTcLHaPDd
         nvM/48XZgpcbSmqU6KpQPj5JkTS1JSpjAKN2XpeHTQSP9RU8RA7ZNfKmD+S8Utl/76
         K+u3kLdH8dn1A==
Received: (nullmailer pid 1976042 invoked by uid 1000);
        Mon, 25 Sep 2023 21:27:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] dt-bindings: pinctrl: Add missing additionalProperties on child node schemas
Date:   Mon, 25 Sep 2023 16:27:10 -0500
Message-Id: <20230925212713.1975800-1-robh@kernel.org>
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
 .../devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml         | 3 ++-
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml     | 1 +
 .../devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml     | 1 +
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml          | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
index 2aedb7e7bc8b..5ece3b9d676b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
@@ -43,7 +43,8 @@ patternProperties:
   "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-mdm9607-tlmm-state"
-      - patternProperties:
+      - additionalProperties: false
+        patternProperties:
           ".*":
             $ref: "#/$defs/qcom-mdm9607-tlmm-state"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 145c5442f268..4782f96feb7e 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -73,6 +73,7 @@ properties:
 additionalProperties:
   anyOf:
     - type: object
+      additionalProperties: false
       allOf:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
index cb81a17bd0b1..5fa5d31f8866 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
@@ -53,6 +53,7 @@ properties:
 additionalProperties:
   anyOf:
     - type: object
+      additionalProperties: false
       allOf:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 10c335efe619..20e806dce1ec 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -115,6 +115,8 @@ additionalProperties:
   type: object
   additionalProperties:
     type: object
+    additionalProperties: false
+
     properties:
       rockchip,pins:
         $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.40.1


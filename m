Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EE7A30C0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbjIPN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjIPN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:57:39 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A5CD3;
        Sat, 16 Sep 2023 06:57:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 436D2422F4;
        Sat, 16 Sep 2023 18:57:27 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694872648; bh=Hwbk08EbuJzZAKTZeydqUanedquYaWJTWIWgdQZEFtw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=2txm7mI02y/RJhGgzM6xS/LaKSPLKRhd/PEGilK6x4esvIZ23YZbch7n2z575Ezfi
         1dVnidT8j0EuyJ2iOyb7vofBrhamDIYo6WGfNCNl9HyWscmzcaU8HjxwS04KSakLqA
         eqYd6LQr5vIpTiQTr0d4kKtZXIgJX1rJVQeRX6BmMVhcmDGKr2g/i8J0nGqWAdoqOO
         T+8hdxrXuXw/4JjsMGskZy6+kxDFdi/JiXThjrBlzTBlUi0xLxbE9toL6UcRS5Toc+
         MEy1GY3i3a+iConRtUPCgHw4fI+WvbQL7j+T+bsbIHsSxdUz4wv1XOtqbVQwL5IV3B
         YdI2NS9ofNmXQ==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Sat, 16 Sep 2023 18:57:04 +0500
Subject: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms
 and lbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-pm8916-dtsi-bms-lbc-v1-1-7db0b42f9fb1@trvn.ru>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
In-Reply-To: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=Hwbk08EbuJzZAKTZeydqUanedquYaWJTWIWgdQZEFtw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlBbQ7e8+Hvzq4Nkvs6uN3P4pql/snrZQ5JQEpu
 CI3wF15O7OJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQW0OwAKCRBDHOzuKBm/
 dT7XD/wL1JbQ/j6/FNvwOVYFREahF9rxYLtKr5P811RbmmH2bw/cYOsj5ONmGkUrEe7eC3xGLKF
 wH04MTlqD8J85P10QWB3PgvUcxMUP5k30XBqESMVEsFhPP6Mmv3IqY02oI8AkU1X6UgiAGOB10L
 encrcpP2PlK+Myg2ug68LsJ//LYEvMwmvLOL77sj1A3a/zsecwRG90ZSP2QPjBvjpvgFKeaCvdA
 nUy8hE77u3xuFM8O5up9A4kInQ8qe9qF5mIevgiCTCnwSsdCgnquerkyaTwqgVRnqcV2LE3/qw+
 SeOp0piEwAJw/jetRBqEzxvLmL4QkaMYJP5MFdGsSq80umlouw3a+n1Q5m2j/obzenqmq+PAF9Z
 q3eSHNUwWsdLk3CqIbdybDbfr6SSju4fjqkuvu09HmsARuEh1JdLdSVJoj+vDGrs3OWPsdfVs9U
 0FM7ZkCI84AhWQDzKwuGNgg4kDY9SNUHYrC+4E5ZQZtXuIdktJTerUA3XHrIwDsl8h53Qk5jmiN
 TRJ/ZlutteFbbT+8jgyuIhOeB/OtnRdzNZnUpp6+QYOHUlr06JW1QnZiZSBpNk53GNKetyNW/so
 T+AdqQq8m0TT8mqipyJuzmElyDmMqoLPXB9dhXjNHvt7849GCtl54YdpGsdB2lKHH/ofUl0+fbo
 JGYgAtWQBCYWB0Q==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8916 (and probably some other similar pmics) have hardware blocks for
battery monitoring and charging. Add patterns for respecive nodes so the
dt for those blocks can be validated properly.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Schemas for those devices were added in [1].

[1] https://lore.kernel.org/r/20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 9f03436b1cdc..8bcd76748faa 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -133,9 +133,15 @@ patternProperties:
     type: object
     $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
 
+  "^battery@[0-9a-f]+$":
+    type: object
+    oneOf:
+      - $ref: /schemas/power/supply/qcom,pm8916-bms-vm.yaml#
+
   "^charger@[0-9a-f]+$":
     type: object
     oneOf:
+      - $ref: /schemas/power/supply/qcom,pm8916-lbc.yaml#
       - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
       - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
       - $ref: /schemas/power/supply/qcom,pmi8998-charger.yaml#

-- 
2.41.0


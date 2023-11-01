Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFE7DDF4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjKAKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjKAKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:23:53 -0400
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE59E8;
        Wed,  1 Nov 2023 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1698834192; bh=LulnQVU2LGroW0Qu5VgPRqq9wD46yJr/35l8o6hbSh4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=aaMOPazMbCrS/2CWeb5BRZEj4btnQEQT/aCDiGoCNPUD71KmP5zwPbqPK0RH/9nNQ
         z/hELE95uvZ97uiU2gSCYtqXT3Qhlvz2I9XxDGxM9rvYeIgpUCDD9pIVg/uiFrAJbX
         IZFmbFlOx/ViYJe/GSXJA3eWkjOMAtCnrBaBCcbs=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Wed,  1 Nov 2023 11:23:11 +0100 (CET)
X-EA-Auth: BVb0ILTlpz9169UulICTfvd2SidbhkX2Cm3cPMSGy9Y7QlUsIMoiJhzNJqkxUSTlHnlgvycagn6A0zErM0fjp940yupvJJMO0P6GZ/HaA/Q=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 2/3] media: dt-bindings: ak7375: Add ak7345 support
Date:   Wed,  1 Nov 2023 11:22:56 +0100
Message-ID: <20231101102257.1232179-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101102257.1232179-1-vincent.knecht@mailoo.org>
References: <20231101102257.1232179-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AK7345 bindings.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
index 22a810fc7222..fe312cc6a873 100644
--- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -15,7 +15,9 @@ description:
 
 properties:
   compatible:
-    const: asahi-kasei,ak7375
+    enum:
+      - asahi-kasei,ak7345
+      - asahi-kasei,ak7375
 
   reg:
     maxItems: 1
-- 
2.41.0




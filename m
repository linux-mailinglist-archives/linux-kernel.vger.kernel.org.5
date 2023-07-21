Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE98E75C4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUKer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjGUKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:34:41 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3A171B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:34:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B182824002D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1689935659; bh=5JyKFsQ3m9P01NmFD5cVB++r4nIwJ3PYJrEqIYXI+oQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=eFskrmPWSAyVMaSCGxMmForiq7RD7ol3t7IKKDPtV9F9xV2kJZscoq+hRswJp5K3R
         k6+dxp2nvdfZvw7m7+/oOxQ4dzYUJbt6ITbfMuhOuKGb8FXCBifjXvVHimTTnDv0Jw
         GGFu5b0yYODUqPzOdP7zvxBcUcx2Ujh3xCCHX9Ap1liEE3xC0eNFZdSX27YouSlf1c
         XGjlLvzLcPxT/XCfpXn4OIaGxRJQX5T7/XPORqxFK32XOyHttrDCwa33FGIQOrm4sK
         dPkVcC6FggAfRwdP99r/PyK+Dh59HpB+b//gYSRiYdGSByVEn5HSTxuIbVZXk+4Q0X
         fyh82KDDvF5ew==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4R6mBd5v4tz6ty5;
        Fri, 21 Jul 2023 12:34:17 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     kernel@puri.sm, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix property
Date:   Fri, 21 Jul 2023 10:34:10 +0000
Message-Id: <20230721103410.575555-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mount-matrix optional property to the binding since it's supported
and very useful when using the chip on a board.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index b39f5217d8ff..443dce326c5e 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -93,6 +93,9 @@ properties:
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
 
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
+
 required:
   - compatible
   - reg
@@ -114,6 +117,9 @@ examples:
             reg = <0x6b>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+            mount-matrix =  "1",  "0",  "0",
+                            "0",  "1",  "0",
+                            "0",  "0", "-1";
         };
     };
 ...
-- 
2.30.2


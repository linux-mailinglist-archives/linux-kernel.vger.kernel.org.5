Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739A97C7034
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbjJLOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjJLOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:21:31 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA9BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:21:29 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B37C6240027
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1697120486; bh=GgTVt7+YXxEkX26Y1BkpKSXRpt+TceAR7c5yku7geAM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=PWm8z4TOzOq6BZyN48AUVR+Z7U9KVwuXzTL7o7oSXYFF5BCRt4ALLypA9edzwp23k
         DSGddCP9l6/+vw9NWGjddFcAXu2ZrT5SFoTE+e9/QJigC3jhMTjnzVMRZnSz8P1VHd
         7D7UGv7O3x7wPjvULbCVPJVBpE2G8F01UGnT7bB16Gzc5DIyoEu1TmcKdUcjfcj9fE
         MTZ7jmt6rr2c0SI2uPvWpuHyJjppLmuRTe4ysKn9m735Wuz5QNRsOirZbexHc9ULyc
         y/e0xugwemsK5eUAocuqnhGfkijg6/2ZbK+9SDdswyGhwxVPpCvSNHHhl00pWvg6gL
         6/zlaEbuOJgmA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S5sJP1W0hz9rxd;
        Thu, 12 Oct 2023 16:21:25 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     kernel@puri.sm, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix property
Date:   Thu, 12 Oct 2023 14:20:41 +0000
Message-Id: <20231012142041.253332-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mount-matrix optional property to the binding since it's supported
and very useful when using the chip on a board.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

revision history
----------------
v2: (thanks Jonathan)
* remove the addition to the example to avoid unrelated discussions :)

v1:
https://lore.kernel.org/linux-devicetree/20230721103410.575555-1-martink@posteo.de/


 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index ee8724ad33ab..28b667a9cb76 100644
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
-- 
2.39.2


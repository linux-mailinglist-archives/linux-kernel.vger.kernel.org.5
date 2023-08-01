Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798076C126
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHAXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHAXlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:41:17 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323541BC7;
        Tue,  1 Aug 2023 16:41:15 -0700 (PDT)
Received: from fabio-Precision-3551.. (unknown [IPv6:2804:14c:485:4b61:339d:323b:fee1:9781])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8AD8E86A85;
        Wed,  2 Aug 2023 01:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690933273;
        bh=aAxy+2OlqhqEU7/xtB+LZTZH+dUWBKspW8LuBWbLpTo=;
        h=From:To:Cc:Subject:Date:From;
        b=H0bcz34wVeC3QfiTNy75iLv06lfTQ/NwL/c+cqy/ZzrDq67L96lILcvFD6md6vf+l
         Ayd+p5+YUjauYcjU0gxEG9MIfh9423j4l3W/v2nGuvbO6Ap+THQgWuZXjRcJTGf4HR
         97CvB2csM/OiEur7LlpLOxIb1N+g7/an1j7BGlzCEkaYPlRBDAFmEBdE2y5yVFkJol
         oU3WjHaJtOP98moRa6gy3K1x61KQixxzGZmf+TMyLZbWVkJRbhia2ixHH+6iQfY0eR
         yk1HtONEf1Ohk/rlEwQuiAv05BpVTNg2gl6AA9l8uAp203D+zT1GNvDLxydooQ9h4A
         StDFwWFuMXg4Q==
From:   Fabio Estevam <festevam@denx.de>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] dt-bindings: trivial-devices: Remove the OV5642 entry
Date:   Tue,  1 Aug 2023 20:40:46 -0300
Message-Id: <20230801234047.136099-1-festevam@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in the description text:

"This is a list of trivial I2C and SPI devices that have simple device tree
bindings, consisting only of a compatible field, an address and possibly an
interrupt line."

A camera device does not fall into this category as it needs other
properties such as regulators, reset and powerdown GPIOs, clocks,
media endpoint.

Remove the OV5642 entry.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None.

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 40bc475ee7e1..ab1423a4aa7f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -313,8 +313,6 @@ properties:
           - nuvoton,w83773g
             # OKI ML86V7667 video decoder
           - oki,ml86v7667
-            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
-          - ovti,ov5642
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
-- 
2.34.1


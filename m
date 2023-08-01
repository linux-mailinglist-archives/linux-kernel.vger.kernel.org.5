Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93976BA2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjHARAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjHARAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:00:51 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EE10FA;
        Tue,  1 Aug 2023 10:00:50 -0700 (PDT)
Received: from fabio-Precision-3551.. (unknown [IPv6:2804:14c:485:4b61:7ec2:b247:1636:c87a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6246E86A92;
        Tue,  1 Aug 2023 19:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690909248;
        bh=aXEFQjxCgLWUDVbVYYJ8MF7PdHlma86ifvLEvAhinEE=;
        h=From:To:Cc:Subject:Date:From;
        b=w9jfvLTVpIebtm/Grk/ejMv+fJ2w8uuF7maImnFq/lermk6s5Zsj9XmGjEuUyYHXs
         dUrkOB9tSYNtF1VJ8boUGF45pnGF1FjilC1dTm+8aE0y5JjJD3fkxdEke1c1hEQTn/
         VDTC8MIGvsnBm3s1bXchMvz+BxL0sRuc/NznsUnR7yxRlNAkE+3aSewOrF3Qz/PUzX
         JYi7ZHQ1D3Ss+eNcu+nS4mubk6ng7NSOGr/jRYf6aFODJEvvGLSHPmVg4yHu2HzEgb
         0oCuwtp6MYwMjfX0tXAmp/aKjxbGRTv54Uwxi2/2uqlZQrnBYBrTZJ7liLwHs7cFhi
         A0PnKE36mquJQ==
From:   Fabio Estevam <festevam@denx.de>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
Date:   Tue,  1 Aug 2023 14:00:15 -0300
Message-Id: <20230801170015.40965-1-festevam@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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


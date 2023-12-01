Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6D801259
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379108AbjLASOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:14:33 -0500
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F5F9;
        Fri,  1 Dec 2023 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1701454445; bh=66Wxc8oBzIfIpIL64ix8lAT/45XRAd7lEKzgQU4F6ns=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=YYuY5Df9ro3GQCMYQnTidpOqX/jxNc+xTKpHlonbxjgDNJIx7OaW5VtF6XW5Adgrd
         2bjl8S5T4Ruv7CX0ISfJDVK1h+a8chyZSBl23UCD5TtwU3b0JQOzkWmyM23XyGExNb
         CqMOuiOl6JzSBTaBpycSlbUG36Wjj8L33xkXrN+M=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Fri,  1 Dec 2023 19:14:05 +0100 (CET)
X-EA-Auth: n5s91a8huocHReaPogKTmuy+cMqxvoEKUxxcrW3YBBVPcZ0xU9Fy/MUNkEjicxBFv3ibysTPbAnbuEIqKIdDfo6iVQY91FjXy9E1pb+sHAQ=
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
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/3] media: dt-bindings: ak7375: Add ak7345 support
Date:   Fri,  1 Dec 2023 19:13:49 +0100
Message-ID: <20231201181350.26454-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201181350.26454-1-vincent.knecht@mailoo.org>
References: <20231201181350.26454-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AK7345 bindings.
Compared to AK7375, it has only 9 bits position values (instead of 12),
20 ms power-up delay (instead of 10), and no known standby register setting.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2 : changed commit message with details about AK7345 vs. AK7375
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
2.43.0




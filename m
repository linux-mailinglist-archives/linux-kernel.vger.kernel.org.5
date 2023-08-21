Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED79783274
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHUUJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHUUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:09:57 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAFE3;
        Mon, 21 Aug 2023 13:09:54 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 94F4284860;
        Mon, 21 Aug 2023 22:09:41 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 21 Aug 2023 22:09:30 +0200
Subject: [PATCH RESEND] arm: marvell: Fix maxium->maxim typo for brownstone
 dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230821-brownstone-typo-fix-v1-1-277983372d3a@skole.hr>
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=BzBGNFzIsGV0WTqakdf4OEopghd/zw0ZcjsFp1vPeY0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk48SAci9T+n3Rf3wv+KFDqe29/VQOqlkKk5Xcz
 756S1O5KtiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZOPEgAAKCRCaEZ6wQi2W
 4exTD/0eClCh8iq9ReStiLxy64RsyuRtuZVzavcgmY6k0zvTVwa0wQXgudU8lSnJG7+E42gbnNf
 4TkuzfS0k5MEVGb90YeLRzHFysJ1PgWpC0b10CBeZNhllOJR63yHe86ZaZU8zy1kttakqUV7oN3
 W7Srgh7o0iuP2bS7Y5wfAL827fSEQmP4cs6B8WQpaoU/Mj5lDEPy1ShyINOke7s+2zpw8/ZxTPA
 P1QG7nJhGrYnfnnC29Aq8XKPRcRrK+maANTw0WEPD0xT7m7gk0mdHWzWJR1ob8sd46VCtj6nSQh
 flo/ngdysrdoDREkzwWwJNwVaAuVs3dGu1w+C01OyBiHBU0RdnCywj78lWWvn4zXcUik9E18H6s
 uvd6ecEkbY3s7wcleUw1h4ToUHPCfYqHObjeB9cf/5NfVo+DcZ8923KjuvwNRjiItaz4gihXKT6
 NuQUZHcD5W5QwKfn7Neh6sGYdEvDOazr8iGOb/vizqVBcxUMQmBSWZEaWwZrJELkjpTDjDKhM2o
 j/8TMq+vlNKSdATcmkAMkNoF8uC8w+xHCSgptsLlwzwMakA8RZkk+xuz+Ewwc6HYWjlcsrmFJvh
 Z/Oz0A+BRNJNi3F64z9w/G1AMCZxlIlzG568ohWUvYoqv+GN0Eh7wkawSXY5+6tcie0FScDnDIW
 GxE68EI33Jt+q/w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obvious spelling error in the PMIC compatible in the MMP2
Brownstone DTS file.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230804-brownstone-typo-fix-f5b16c47d865

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



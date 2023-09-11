Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F679C2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjILC23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjILC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15774092;
        Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF727C4167D;
        Mon, 11 Sep 2023 21:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468866;
        bh=P+vOPf+wwuHvorbjJWXCniSp0x7QhyhIsdAc2cl5EMM=;
        h=From:To:Cc:Subject:Date:From;
        b=AGPd8y5jXohbk26C+fb1d2JLNarvGgMdoJbeo6FXx6LE9NxON2g6L34E60D3KVAe1
         kKoOnS2ow3HOzXMbLbI9k4Kjgh+N8ZIjcHXClFP5F8fjB18DHtYLghYiWnABpmXF4C
         is7y2mtbKO4S7OBvjuFnxtWiHgnibLYzpu7OtbAdHYbC9QlVzCnOacBt3CfB2AhMdO
         PvKBC1u/ztWTC3ASaxU8QRMavYfdbE0uYHcT44SVbT8AE6kz1tuf67a9w9HbC0S0+1
         bRdOU+47BcibMKfTNbkEXt4dLR8le9ZYA53qVGZrBWoiVrymcF7Ds6n11UY8zRP6ey
         7E0wXO8Y8tXMA==
Received: (nullmailer pid 2202875 invoked by uid 1000);
        Mon, 11 Sep 2023 21:47:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: Apply overlays to base dtbs
Date:   Mon, 11 Sep 2023 16:46:15 -0500
Message-Id: <20230911214623.2201324-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT overlays in tree need to be applied to a base DTB to validate they
apply, to run schema checks on them, and to catch any errors at compile
time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Looks like some of these apply to multiple base DTs. I've only added them
to 1 base.
---
 arch/arm64/boot/dts/renesas/Makefile | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 7114cbbd8713..5b23bdb71804 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -56,7 +56,8 @@ dtb-$(CONFIG_ARCH_R8A77980) += r8a77980a-condor-i.dtb
 
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
 
-dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
+r8a77995-draak-panel-aa104xd12-dtbs := r8a77995-draak.dtb draak-ebisu-panel-aa104xd12.dtbo
+dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb r8a77995-draak-panel-aa104xd12.dtb
 
 dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
 
@@ -64,6 +65,8 @@ dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider.dtb
 
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk.dtb
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtbo
+r8a779g0-white-hawk-ard-audio-da7212-dtbs := r8a779g0-white-hawk.dtb r8a779g0-white-hawk-ard-audio-da7212.dtbo
+dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtb
 
 dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-ulcb.dtb
@@ -73,18 +76,28 @@ dtb-$(CONFIG_ARCH_R8A77961) += r8a779m3-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77961) += r8a779m3-ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A77961) += r8a779m3-ulcb-kf.dtb
 
-dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb
+r8a779m5-salvator-xs-panel-aa104xd12-dtbs := r8a779m5-salvator-xs.dtb salvator-panel-aa104xd12.dtbo
+dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb r8a779m5-salvator-xs-panel-aa104xd12.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043u11-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043-smarc-pmod.dtbo
+r9a07g043u11-smarc-pmod-dtbs := r9a07g043u11-smarc.dtb r9a07g043-smarc-pmod.dtbo
+dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043u11-smarc-pmod.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc-cru-csi-ov5645.dtbo
+r9a07g044c2-smarc-cru-csi-ov5645-dtbs := r9a07g044c2-smarc.dtb r9a07g044c2-smarc-cru-csi-ov5645.dtbo
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc-cru-csi-ov5645.dtb
+
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtbo
+r9a07g044l2-smarc-cru-csi-ov5645-dtbs := r9a07g044l2-smarc.dtb r9a07g044l2-smarc-cru-csi-ov5645.dtbo
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtbo
+r9a07g054l2-smarc-cru-csi-ov5645-dtbs := r9a07g054l2-smarc.dtb r9a07g054l2-smarc-cru-csi-ov5645.dtbo
+dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
-- 
2.40.1


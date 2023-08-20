Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5660781EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHTPkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHTPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:40:08 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C54483;
        Sun, 20 Aug 2023 08:40:01 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id E43BE1006A2;
        Sun, 20 Aug 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1692545513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09XlR83YFSi4NRf25+3bw/2BaTp3RGKRQHRUPxLTGrw=;
        b=aA34mCShWIjt/OJuI9kgsex39Pl5HOVtnaKoyii24yUdlkhPuvy543fX8VSs2nOerU6Iul
        QhfpBiF9D2hAAv1PjGbh1yjgCBj/To+Qndxs9B3zcDQpE+5G8Hq6xFZVkMOmIj9F4UHqj7
        stwlfqHakLX6UpIlErcQ2uBz/ofh6+0=
Received: from frank-G5.. (fttx-pool-80.245.78.65.bambit.de [80.245.78.65])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 51506401CF;
        Sun, 20 Aug 2023 15:31:53 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/3] arm64: dts: mt7986: change thermal trips on BPI-R3
Date:   Sun, 20 Aug 2023 17:31:35 +0200
Message-Id: <20230820153135.42588-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820153135.42588-1-linux@fw-web.de>
References: <20230820153135.42588-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 58ee28ff-36e2-45c9-af2e-5d6e67be8ab5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Apply new naming after mt7986 thermal trips were changed.

Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index f9702284607a..b876e501216b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -152,16 +152,16 @@ cpu-active-high {
 			trip = <&cpu_trip_active_high>;
 		};
 
-		cpu-active-low {
+		cpu-active-med {
 			/* active: set fan to cooling level 1 */
 			cooling-device = <&fan 1 1>;
-			trip = <&cpu_trip_active_low>;
+			trip = <&cpu_trip_active_med>;
 		};
 
-		cpu-passive {
-			/* passive: set fan to cooling level 0 */
+		cpu-active-low {
+			/* active: set fan to cooling level 0 */
 			cooling-device = <&fan 0 0>;
-			trip = <&cpu_trip_passive>;
+			trip = <&cpu_trip_active_low>;
 		};
 	};
 };
-- 
2.34.1


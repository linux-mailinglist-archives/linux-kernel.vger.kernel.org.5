Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B87FC857
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbjK1Vfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjK1Vff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:35:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C111FC1;
        Tue, 28 Nov 2023 13:35:40 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46F4966072E7;
        Tue, 28 Nov 2023 21:35:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701207339;
        bh=EA3Sl4Au7lUnYnJzLlX/RZSBt2UJuslBcjVt/8x9WDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEp9XUnKUM1gGQiTwlQAQadMFC5KorC0k2m7ZfpvRuKXIZ07rRz9NOa+BSfXuzwWo
         dAZRIl+kVb1ppR4xQ5mxpA7Y82IQrZifXQ8ck/IbTLcJtForp8yK6Mdy813vPNNZ7p
         pHrTvt9eIxz9FzsKcdzOiTIIk7l+J9U1E00fPA2Q5AE9TzjHQnqAIYBBlNZH0t/w7X
         4Yr8K7FafTiijBf1eghAs7Z6NmqBRN2BP5/dwnplRLE0rYF/t2izUkiSWIyc74a1j/
         GJTQk9M4FUQ+bPFOJP/+YPxAStPAcYx5CbAjXwgBuM+3RT5d5XyLLFUq96sUOfSl7x
         ZJIQIlK/A8fMQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 7AC3C9676CFE; Tue, 28 Nov 2023 22:35:37 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        kernel@collabora.com, stable@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: armada-3720-turris-mox: set irq type for RTC
Date:   Tue, 28 Nov 2023 22:35:06 +0100
Message-ID: <20231128213536.3764212-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128213536.3764212-1-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc on the mox shares its interrupt line with the moxtet bus. Set
the interrupt type to be consistent between both devices. This ensures
correct setup of the interrupt line regardless of probing order.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Cc: stable@vger.kernel.org # v6.2+
Fixes: 21aad8ba615e ("arm64: dts: armada-3720-turris-mox: Add missing interrupt for RTC")

---

(no changes since v1)

 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 9eab2bb22134..805ef2d79b40 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -130,7 +130,7 @@ rtc@6f {
 		compatible = "microchip,mcp7940x";
 		reg = <0x6f>;
 		interrupt-parent = <&gpiosb>;
-		interrupts = <5 0>; /* GPIO2_5 */
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>; /* GPIO2_5 */
 	};
 };
 
-- 
2.43.0


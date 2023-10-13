Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66D7C8FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjJMWB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjJMWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:01:23 -0400
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 15:01:20 PDT
Received: from hera.iit.uni-miskolc.hu (hera.iit.uni-miskolc.hu [193.6.5.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DDB7;
        Fri, 13 Oct 2023 15:01:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 473FE13E;
        Fri, 13 Oct 2023 23:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        iit.uni-miskolc.hu; h=content-transfer-encoding:content-type
        :content-type:mime-version:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=hera; t=1697233932; x=
        1699048333; bh=E6GGdU8NqUAeueW/49LZQZKoh1Ml+Xu2MiTlxVU/v5s=; b=t
        ITqHzmN8urDujkz/Yn1T8x+zlXEkpXj9dGIKGPA/Yu8AU/NeGQd2JDcEclISodCV
        81N6dqvbfxYIQhdx0DIHcB+SYqFxXbZl7z703SFbLS884E7M5cOelQVYMWo+wWod
        oxPdDEEyXH6XBN08Kbke7Y0yKuyEovq7MTwpIAOWIYK+QZJ1raGjgsgk8zt+zYZ8
        NhYy1kSCLKxxSbCSWR+siFEhPIksfyVwCI4HXKK7fSv6lbyGRx4dmahtR6MtKqjM
        MdtA70pqIWmfjsZpe6y88QEoIjNsT+mZ8jq7kzQf1xUfOKk+zFzpsiN+cE7tPvuu
        cJAK78n4EZGZ7e0lPhz9Q==
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KuN4sTeSYG-T; Fri, 13 Oct 2023 23:52:12 +0200 (CEST)
Received: from liberty.hitronhub.home (unknown [IPv6:2a02:8109:a181:1400::3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 2E9F313C;
        Fri, 13 Oct 2023 23:52:11 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>
Subject: [RESEND] arm64: dts: rockchip: Enable UART6 on rock-5b
Date:   Fri, 13 Oct 2023 23:51:53 +0200
Message-ID: <20231013215208.81345-1-szucst@iit.uni-miskolc.hu>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable UART lines on Radxa ROCK 5 Model B M.2 Key E.

Signed-off-by: Tamás Szűcs <szucst@iit.uni-miskolc.hu>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 392ac783c3ad..ea1e3d09ea62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -377,6 +377,12 @@ &sdio {
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
+	status = "okay";
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.42.0


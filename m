Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419027798B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjHKUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:46:13 -0400
X-Greylist: delayed 2078 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 13:46:11 PDT
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B32706;
        Fri, 11 Aug 2023 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uqx6rDb8lMrAoJhRENG6RTKx5+D5I6ScWaggeCDeSQA=; b=o1m9ZC1XiE7aZ9IizgMJJlCLJx
        YsgqpnbKq+aODX69GmvhCq1GDXjHu5b+raVOUwG7ee38mYiGadquBPk+dI1PntkGMftMIraw+zxdg
        i7Q1lNrxQpiei8Pfy8uZl7AwCQydaVs+9UBFD7NIf1mjn2uVrIWWErLN3RxR883d/ypB24BlgDGUO
        9gkkxcixFc1bxWmsLAD7NIL9TRtk2DmtIHaXkE5tG2HdvXT4QUzxbJFtXljjSVuZtkkKNODg2IHzA
        dfx4+Fr3BdD0Le40fO7Gq+gY7Y0M6mGihFVcTD/4afYvxLhY44POyWCD/54E0ez4dOUBeXSh5a68H
        oSYhRFbQ==;
Received: from [192.168.0.1] (helo=librem14.Hitronhub.home)
        by uvw.ixypsilon.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <stefan.nagy@ixypsilon.net>)
        id 1qUYTn-0000uL-GC; Fri, 11 Aug 2023 22:11:27 +0200
From:   Stefan Nagy <stefan.nagy@ixypsilon.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable internal SPI flash for ROCK Pi 4A/B/C
Date:   Fri, 11 Aug 2023 22:11:18 +0200
Message-Id: <20230811201118.15066-1-stefan.nagy@ixypsilon.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROCK Pi 4A, ROCK Pi 4B and ROCK Pi 4C boards contain a nor-flash chip
connected to spi1. Enable spi1 and add the device node.

This patch has been tested on ROCK Pi 4A.

Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
index 89f2af5e1..4ea4bec95 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -11,3 +11,13 @@ / {
 	model = "Radxa ROCK Pi 4A";
 	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
 };
+
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index 080654592..84b9d8b3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -30,6 +30,16 @@ brcmf: wifi@1 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index 4053ba726..39917f987 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -42,6 +42,16 @@ &sound {
 	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
 };
 
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 
-- 
2.30.2


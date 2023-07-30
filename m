Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE2768739
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjG3S4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjG3S4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:56:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBA10F4;
        Sun, 30 Jul 2023 11:56:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuIPV124841;
        Sun, 30 Jul 2023 13:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690743378;
        bh=QIhD7sfTz8wkc0F5WKpsPx6OL2wDF4T4HH6zMbWh9IM=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=gXHbdvD7bpRovl9UQUOV/CTtwSKKqjy8GDm0egUJDLOoa+CmoIb+8ILFpA6hUzDHH
         yf1oCe0cGDHdEXwVaLD6bO3l8D4rojfFDYmxZyImkQIVLMH931gpjCch/JmcjbSahK
         vSQEQVvBnL0ttje1rrrrvt90rStX3PI5e5qyx8AQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36UIuIPW062757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 13:56:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 13:56:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 13:56:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuHnp000723;
        Sun, 30 Jul 2023 13:56:18 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Mon, 31 Jul 2023 00:25:58 +0530
Subject: [PATCH 5/5] arm64: defconfig: enable MCRC module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v1-5-dc8798a24c47@ti.com>
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690743369; l=1038;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=B/LYMZyNFUhmrn+0NIyBgEnkmpVKRdPppDNTxGti9FY=;
 b=nd4TJ9Aa/rHKor2pA8acRFQp/tZj1y4RrTygD0I52I+xYjhW+Mg8zY79UfYQCHL1v+088LkZF
 XT4YuDkj/yTArbElttir8e59Mp6/bcBmSt1tg5x5ELPwlOYvk/U6fjd
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 devices include MCRC engine for crc64 calculation.
Enable module to be built for K3 devices.

Also enable algif_hash module, which is needed to access MCRC module
from userspace.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6cbf6eb59378..6006983b313e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1505,6 +1505,7 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_GHASH_ARM64_CE=y
@@ -1528,6 +1529,7 @@ CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CRYPTO_DEV_HISI_HPRE=m
 CONFIG_CRYPTO_DEV_HISI_TRNG=m
 CONFIG_CRYPTO_DEV_SA2UL=m
+CONFIG_CRYPTO_DEV_TI_MCRC64=m
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333D67FDB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbjK2Pbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjK2PbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E8D6F;
        Wed, 29 Nov 2023 07:31:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 340CDE000A;
        Wed, 29 Nov 2023 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6Se7MgTLDlVPsmnv481wC76UKLsZL7lpNqEMlGZzy0=;
        b=IAr/fyUww18EgY4GKsHZMYeVTdK+cveCDjQkTAmKmYQJpAQ7V63VUI9w7uU7LnDdhJ++6s
        dswp7Ew+Zg2jg5CZ6Spu6PDvXR+wXPIizzILSrhOIIRTH348R5T8oNbB0qw9s1hJRTqFdV
        2Fy+7NThE7UTzrSf0si2wpYZf8E9T0LpEFGHklB76X5DCOqK1OrBEAMdRHaIW5bIgqCctX
        oWBJ5zufnZ+o9VcXTxrrzf5pGoqf2q7bRqpUHmsMx/5lsiRj2JVK0yEGnZy+kq8fjMv+Pg
        i45A8YVchsERATCQniJ8Nm2udPMXvwziQDnejef9/H38zCbu3qbps28oEgypgA==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Wed, 29 Nov 2023 16:31:21 +0100
Subject: [PATCH 5/5] arm64: dts: ti: k3-j7200: add reserved memory regions
 for lpm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-j7200-tisci-s2r-v1-5-c1d5964ed574@bootlin.com>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
In-Reply-To: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two memory regions are reserved for suspend to ram on j7200.
One is dedicated to TF-A, it uses this region to save its context during
suspend.
The second region is for R5 SPL, which uses it for its stacks and to store
some firmware images.
These regions are reserved from the linux point of view to avoid any
memory corruption.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 5a300d4c8ba0..dc8c9c3e8443 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -79,6 +79,16 @@ rtos_ipc_memory_region: ipc-memories@a4000000 {
 			alignment = <0x1000>;
 			no-map;
 		};
+
+		lpm_r5_spl_ctx_ddr: lpm-memory@a5000000 {
+			reg = <0x00 0xa5000000 0x00 0x1000000>;
+			no-map;
+		};
+
+		lpm_bl31_ctx_ddr: lpm-memory@a6000000 {
+			reg = <0x00 0xa6000000 0x00 0x20000>;
+			no-map;
+		};
 	};
 };
 

-- 
2.39.2


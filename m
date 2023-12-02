Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14B801D8D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjLBPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLBPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DB1125
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 07:46:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7352BC433C9;
        Sat,  2 Dec 2023 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701531983;
        bh=Oh3T5Mw/d1ShgN3QuPdpYAcWUqUHtc0/ANZQUJzPc18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLiU/mcfZNFrp0cP5llA155Zvk4sGKsx4jDJAFeHEEaiprDRkEiqqQgDehbKsAI38
         ftZQMuo6bU/DAV+KjIz0iZaGFodSttkM7+1KWrfOTGdyC91RoT9ek3VTbz5jFO2fK+
         NC0Py2cFHr3GI6f+hhBgk5Gzo0jxjq/oUaRUsZ70b29OeixT4bLjgG9g6rRZTNoSx/
         UJmGSeFcVnuFjqvQaetwH3+e018QBBUaaehn/vNQlAFZIvm2q9r8ip6cjxHmosMhif
         zqjOyZAHxVQhqVUV30oJOUzWO2Zvc9MIpdjNY+BVovIzvMX4jBcqhqGH0Bl5sv06Cl
         qRJ7JE9i4Hn/g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
Date:   Sat,  2 Dec 2023 23:33:51 +0800
Message-Id: <20231202153353.635-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231202153353.635-1-jszhang@kernel.org>
References: <20231202153353.635-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'cpus' label so that we can reference it in board dts files.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index e68cafe7545f..e6959f2d4f1e 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -13,7 +13,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..5a6ff90685e5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -15,7 +15,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.42.0


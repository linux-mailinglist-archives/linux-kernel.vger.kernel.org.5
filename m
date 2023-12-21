Return-Path: <linux-kernel+bounces-8124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D481B268
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73C6B220D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5A4D5A8;
	Thu, 21 Dec 2023 09:29:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8447A48
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BL9SatE042681;
	Thu, 21 Dec 2023 17:28:36 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SwlLy6mLsz2PvZGt;
	Thu, 21 Dec 2023 17:22:18 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Dec
 2023 17:28:34 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/3] arm64: dts: sprd: Add clock reference for pll2 on UMS512
Date: Thu, 21 Dec 2023 17:28:23 +0800
Message-ID: <20231221092824.1169453-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231221092824.1169453-1-chunyan.zhang@unisoc.com>
References: <20231221092824.1169453-1-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BL9SatE042681

Fix below dtbs_check warning:

'clocks' is a dependency of 'clock-names'

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 012b3a4bbe7c..7a39a9bdf219 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -291,6 +291,7 @@ anlg_phy_gc_regs: syscon@323e0000 {
 			pll2: clock-controller@0 {
 				compatible = "sprd,ums512-gc-pll";
 				reg = <0x0 0x100>;
+				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
 			};
-- 
2.41.0



Return-Path: <linux-kernel+bounces-88748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C932F86E613
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6FEB250CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E139AE7;
	Fri,  1 Mar 2024 16:43:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063938F9A;
	Fri,  1 Mar 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311388; cv=none; b=L08Woi80DyWAlKJPZTm8zToMWsLFjkmlx+T2+abElzjeaKSBKdg/oMjzOWyROmZP944ybDq7d/TOmfCmzZ6c74YjPj3FMFCIp4Z4J6CYPR3niverLcBlOQO9Hlxuu3M7zpbcusVKD2EO/yRmzZo2FqWEellbk1GEUfNGJVJqFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311388; c=relaxed/simple;
	bh=8S6CSNAxwTPK4IcapElvuohR181ft6Zdjea6RK1tp48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+zRptEHZxLYyNOgDXI/mmf5QBwN+1nt94TCXGX3YMioC5CO4RABQoSH7stCGpG2W+gZ2xDvXaGiihJD1d4yZlUOb1LJfiLyq6JeWuG6Oj8zCBd2fouhtIpflD3LvNm4iDEimUWmPpOPc6uaouE4MIQgghxwWuVb4iY0x3XJD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A252D1FB;
	Fri,  1 Mar 2024 08:43:44 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.69.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB833F73F;
	Fri,  1 Mar 2024 08:43:02 -0800 (PST)
From: abdellatif.elkhlifi@arm.com
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew.Reed@arm.com,
	Adam.Johnston@arm.com,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: Add corstone1000 external system device node
Date: Fri,  1 Mar 2024 16:42:26 +0000
Message-Id: <20240301164227.339208-3-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

add device tree node for the external system core in Corstone-1000

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 arch/arm64/boot/dts/arm/corstone1000.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
index 6ad7829f9e28..67df642363e9 100644
--- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
+++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright (c) 2022, Arm Limited. All rights reserved.
+ * Copyright 2022, 2024, Arm Limited and/or its affiliates <open-source-office@arm.com>
  * Copyright (c) 2022, Linaro Limited. All rights reserved.
  *
  */
@@ -157,5 +157,13 @@ mhu_seh1: mailbox@1b830000 {
 			secure-status = "okay";     /* secure-world-only */
 			status = "disabled";
 		};
+
+		extsys0: remoteproc@1a010310 {
+			compatible = "arm,corstone1000-extsys";
+			reg = <0x1a010310 0x4>,
+				<0x1a010314 0X4>;
+			reg-names = "reset-control", "reset-status";
+			firmware-name = "es_flashfw.elf";
+		};
 	};
 };
-- 
2.25.1



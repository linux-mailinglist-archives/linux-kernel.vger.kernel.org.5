Return-Path: <linux-kernel+bounces-28195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9982FB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B781F26A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8A1657F3;
	Tue, 16 Jan 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcwJSV88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9051657DF;
	Tue, 16 Jan 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435423; cv=none; b=fAjozXlj103Kxc+QxLe0bp0ypdKkPMGqBBXd+VIbEB2PHV1XKcK32x4jbKbYC6TDTRH/MkyCPQ2mvKbfq4hmSDPeinMrYyXlff+34HLkKM0K8AViqkQJwGzgz1gHlseJO4nL0uzMX0DjBlhvykufQFqHJX2OL80XbHSDkZZjmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435423; c=relaxed/simple;
	bh=3tSf8vVGuiOTFnLIyyqFLqfP4vJAjg3AUHMphHvh3aM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=o4qO6fNCH4XL8/GaSp1YOt99idUmJYP5YiVzWu5jKAAvWdAVbuyqr/FVxi7Svuy5O+18Pn7bbIl9JbW7LxT2MTupXriveOr4bU8dgYgiQ4TxY1xb4jw+Sjypwim70vIhKOXgFYxtUUNmFgS2+VmTt61BBmK0SMw8TenU6+q9Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcwJSV88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE77C43394;
	Tue, 16 Jan 2024 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435422;
	bh=3tSf8vVGuiOTFnLIyyqFLqfP4vJAjg3AUHMphHvh3aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcwJSV88WFmtgUCYYILqztz7huWVo8CX/xUW8WLpMV+qLZHjrWKMxzjVPc5BcvyuF
	 Pt2vWJTQfJD/syyZxwMPRATOg7Bts3uygP4gp7bFl4BqUy/5Yby3RLr0AfOxQoM1b2
	 Zet5lp/NX7TZdGLQCpWo0G+QlvIUfjvnFM7h+zYGwFs+LrCeOOEw2mLBQ60oXHQcCl
	 QhDlZ0oVfS/+QtuuTFotwnpxdhGCvBh92VfDzqz8yXK/458TFDtAh8cmBbUvtxuiqA
	 Wdb9lp1DWyknC+1li4y5ftf8WUHVGUwn8cxgfxcL8TB6eD8wq9bejBfiYevFmMvklU
	 HLXot90+7xu/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 15/31] ARM: dts: imx25/27-eukrea: Fix RTC node name
Date: Tue, 16 Jan 2024 15:02:24 -0500
Message-ID: <20240116200310.259340-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 68c711b882c262e36895547cddea2c2d56ce611d ]

Node names should be generic. Use 'rtc' as node name to fix
the following dt-schema warning:

imx25-eukrea-mbimxsd25-baseboard.dtb: pcf8563@51: $nodename:0: 'pcf8563@51' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/rtc/nxp,pcf8563.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi | 2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index 0703f62d10d1..93a6e4e680b4 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -27,7 +27,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 74110bbcd9d4..4b83e2918b55 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -33,7 +33,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
-- 
2.43.0



Return-Path: <linux-kernel+bounces-126711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CB893BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D0C282144
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D843ACA;
	Mon,  1 Apr 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn7CUPqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEF44374;
	Mon,  1 Apr 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980568; cv=none; b=spakuRqnTHauVRTzFGzb9kW7ZwakttC83/6v6CWvua+mKK6wf4834htL6QxVTGzS7yji2WATOzx1ztXD1w/pPxaxzTjNy9cTD6MTcd8aFHNMnLTTJOa/ZzIR8W6Mdtvw/8g0DAoLaYnJWhWvChiGXjqYE6zt7myl/CBdd9NucS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980568; c=relaxed/simple;
	bh=nZNPDR2GsOWo4mSD92p9rWVIqT2GOPAdk9nHrui/qjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvOIl9L8dIMK/eSetk5pyjkSzsEuoktLGbuw8RQYUeAk4flo4EFiM8cWQXeb8ERfdKIvu6uwtA0Ms7+ZkR0VaYZfnlCSFqY+mjk4FAgAQ16nksrgMSMYvOlSyqSrsha+I/kD7Y8vhDwAUl1dcS+SH/7HGflozOnm9Fh+GavC588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn7CUPqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D6CC43390;
	Mon,  1 Apr 2024 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980568;
	bh=nZNPDR2GsOWo4mSD92p9rWVIqT2GOPAdk9nHrui/qjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn7CUPqDra0tT/LCKV3PW0X+cSN1uC727MXv9kuynLXW3bNSrbRNx41Zbgc2pvWcm
	 anjHKjoODs+iALfMh9b4vQtTAtbFeQLJd2sGINj+Zr+GO7RkhmVpiDuH6XM4sCBHzv
	 yQvkTk5Vs0GF/2qB0w8pqKrrBapR/9/6xzuVP8RAHAkuinwdlDEV3aFgFTANbL7eAH
	 K2ukek5ST5fMeda3FfsilIX0wU37ZLidUKPnaGDwBejgL0RBwmg4qsJ5PxEFbjbrwx
	 G5OsRAcjUejtwEPUbnwC+A55UR3QAuuHtF39Q0cUDsolNeiuGKd581kL3AbNloebQa
	 8wNW3i+2aazkg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: realtek: rtc16xx: add missing unit address to soc node
Date: Mon,  1 Apr 2024 16:09:12 +0200
Message-Id: <20240401140912.97157-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401140912.97157-1-krzk@kernel.org>
References: <20240401140912.97157-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"soc" node has "ranges" property thus add matching unit address to fix
dtc W=1 warnings:

  rtd16xx.dtsi:130.6-198.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index 34802cc62983..c10c7eaf1b03 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -127,7 +127,7 @@ osc27M: osc {
 		#clock-cells = <0>;
 	};
 
-	soc {
+	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-128578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22079895CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B551C2252D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFE15CD41;
	Tue,  2 Apr 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXkybDaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72615DBB9;
	Tue,  2 Apr 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086335; cv=none; b=htoUfk3rHNIAgGLnhiBG9IAS2aqKQ/XQ1xEMmySFqfaqYnat3M7MBO4TJfp/sSWO3wrrCrcvctYdg6lSSpl3wKls5OGK5WSw3VmD6MMZ47vITZocYjjqhfJq5UIldpXUZroTSwKTUonw8uV59HmZqft6HtJ626YtAXVpr39czuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086335; c=relaxed/simple;
	bh=ZerKBCgEqQ/zz18xCgYPrJMT695qwy8CRMgr9VORsgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+Bu1d3lNI9FL3s60gzizLS355fGpz7yiVQ0V7ARWEnJ0Adb4C+GM1qHidbiIA+1FP7TrIF8kaYS09AO2+ME/+II6j6PePkSGK/BszlttJbpjC1b0dlyauHUgEEe3o+IyUiiVqpsE8cbx8Ndia3Aq9lukX/lLsOA4hOJQvWpog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXkybDaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29EC433C7;
	Tue,  2 Apr 2024 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086335;
	bh=ZerKBCgEqQ/zz18xCgYPrJMT695qwy8CRMgr9VORsgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXkybDaWkODRW2mCiLbMt7wx/srXsW6Z8w+iYBEqDMkPov9ksexpOnMJIuBSvhya3
	 M7nWtO7OUOqpcboUexnlizj/oZhIgpT0YE1Ei0ssMR90tYNsTS+sH+usvGW7rdOJQ4
	 1TqkGh/yB8+d9Q/YA1+BK8rMkDLiz59D7vHVeAtcdev1wF7reHUY7f4RzrhVKnYr2P
	 nj2pbA7Ex7cEjexlwB32vouG9dtUY8OWYCR1L4yZUy+P9ykX1tALeXvG7cvoIm+mO9
	 5AmgezHCRXHx3OAXAZhYWOnHGZk7GsdyzrDzedZN8HTRXqxKUJppJ6IVRahvUBdEMK
	 Fa1O6if3OqHOw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 7/9] arm64: dts: hisilicon: hi6220-hikey: add missing port@0 reg
Date: Tue,  2 Apr 2024 21:31:46 +0200
Message-Id: <20240402193148.62323-7-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adv7533 ports should have "reg" propeties, as reported by dtc W=1
warnings:

  hi6220-hikey.dts:516.11-520.6: Warning (unit_address_vs_reg): /soc/i2c@f7102000/adv7533@39/ports/port@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f0672ec65b26..a2aa17e4dfdf 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -514,6 +514,7 @@ ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			port@0 {
+				reg = <0>;
 				adv7533_in: endpoint {
 					remote-endpoint = <&dsi_out0>;
 				};
-- 
2.34.1



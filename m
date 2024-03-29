Return-Path: <linux-kernel+bounces-124816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9B891CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6D1F25E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55C19F51D;
	Fri, 29 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/+f7Ujo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5219F50B;
	Fri, 29 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716224; cv=none; b=nblGnvNwa7V3G3aqLQTXKGzs4USnVie71d7nUA+HayCuUmr9tuxYixjfrUbbBXK2X2dXpbbnr8DSJ8anPOAniZ7ql3VJyt6YNAYJ4gFfIqGbrSex4D0ANB7uZVit/siB1gK7GcPxl8hwWXvhPKQk2yB5/AjABHv4Aj4SVx+c+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716224; c=relaxed/simple;
	bh=8Xk6KwQXUDokZ4yzdMMwyzN4nfhkCHsts3dsOIhFRG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKL8M+NjfKQakpIF3CHRReQgoZmRblPuzMUsNikVLuffY5HM390PP6dkM4naeQVCLXjw/U7/VzbohdkS6y91tLEZ3IQ3jWWrj4f1q5MAUQ8sN/0mVfyHZ1cHm6+LPzln2/na2BV70P6Pk+L0OMZUBG1cW236bCjBYl9xQc/Sl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/+f7Ujo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D71C433A6;
	Fri, 29 Mar 2024 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716224;
	bh=8Xk6KwQXUDokZ4yzdMMwyzN4nfhkCHsts3dsOIhFRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/+f7UjomvRlcS4MABanPoVQjhcl2QC9TIC5LtVGc7VQhIOA+shbxOHjcpDfdKEo2
	 QRLI+bM2n0BNAV06Cyt4chdsKAsojZ1hHZgxmXcWeyzdgeueXGcUt+7KNY+j9quoPz
	 a+F0YkfOyjDgXtdTYU8+atDzGkuV3LiuhrCq1XmZcIHI1NQj6BCmI3tFnraCKWOJPX
	 k0BhQV1L+SnT5vfPWljduzjDFJOkNH8fSucfarxYkhSFphcs0QqswBqRWqTzRPl0j/
	 lQ9N19g9cVOjxYTY1/E9vYIq+VbPV02oXrH/c1ZSRNbYBhg/rxea++mqcgOHRwBuXj
	 C0E9K1rDeWd9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/75] arm64: dts: qcom: sda660-ifc6560: enable USB 3.0 PHY
Date: Fri, 29 Mar 2024 08:41:48 -0400
Message-ID: <20240329124330.3089520-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 319a12e7c399df4316f54f6cc83cd6cdffb4ec4a ]

The Inforce IFC6560 board actually has USB SS lines routed to the USB-C
connector. Enable USB 3.0 PHY and SS mode for the USB3 host.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240116-sdm660-usb3-support-v1-4-2fbd683aea77@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 21fae799c816a..702ab49bbc594 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -454,16 +454,15 @@ &usb2_dwc3 {
 };
 
 &usb3 {
-	qcom,select-utmi-as-pipe-clk;
-
 	status = "okay";
 };
 
 &usb3_dwc3 {
-	maximum-speed = "high-speed";
-	phys = <&qusb2phy0>;
-	phy-names = "usb2-phy";
-
 	dr_mode = "peripheral";
 	extcon = <&extcon_usb>;
 };
+
+&usb3_qmpphy {
+	vdda-phy-supply = <&vreg_l1b_0p925>;
+	status = "okay";
+};
-- 
2.43.0



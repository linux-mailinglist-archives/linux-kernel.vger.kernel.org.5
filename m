Return-Path: <linux-kernel+bounces-124721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70046891BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864841C26B01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791316F83F;
	Fri, 29 Mar 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7peRLZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC7146A76;
	Fri, 29 Mar 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716010; cv=none; b=SzrdFdlc9j+esdD9hGXToHyEvU+bQfMH3G9ogkKxfK9f+BCK0Nhh5B6J+GQlIhLjbwQuFy2xf9n6IBZR398Y5FCYuqwrj4/QUAOOpuHTpBnfyvvi85vjAfN3k8QuHWOht9LNW31WyqZJziZHkGOUht5X/oEgxS1TIZBgpV74oa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716010; c=relaxed/simple;
	bh=8Xk6KwQXUDokZ4yzdMMwyzN4nfhkCHsts3dsOIhFRG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQlivrLna7tYuqvwItXkf4f7LOJk/3uDUOZ7heWYJ47YUes2Yba/bWdi/Jw52FmmzZsJr3rH3wK+dZXdj1PRNTPagCjpt49y3YsAwMf4nd4TAIqPh8r1GhMx0RThlv6U4RyaSPPJGAYP8dqgTMooA9fpNPQklkJocVkETqkcqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7peRLZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C08C433F1;
	Fri, 29 Mar 2024 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716009;
	bh=8Xk6KwQXUDokZ4yzdMMwyzN4nfhkCHsts3dsOIhFRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7peRLZGbxJZeIP/hszKu5I6btwGLXdL9C3hnHU17aeZ5fC9gokR4867LBfWYNXVX
	 KD0BxJzWB+pJePOAYnacLwrCjUG9l7RKr/qfRKA2rWb3S2I30AhwFSS/5Yne5s2nww
	 mvOr6HkohHUnZ/6S7sVarNHNzmd872H8+v6+Wfwax8GnMSookaXlA4ZvQW9j7zCbdw
	 glyJW3SJRFR9PHYvLadpdJU2rdJxVLB6MBWIqe82B2Tcn3RS/pAG0liu4mLXwVFXGX
	 H3yjXW0YzSNIePEUCZiz9KH+dwOLKb5Z1/OcxP7C7NDIEoFbzFoUtIy/otBA1gShZ4
	 zmPW6VBRGRmwA==
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
Subject: [PATCH AUTOSEL 6.8 12/98] arm64: dts: qcom: sda660-ifc6560: enable USB 3.0 PHY
Date: Fri, 29 Mar 2024 08:36:43 -0400
Message-ID: <20240329123919.3087149-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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



Return-Path: <linux-kernel+bounces-28224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8F82FBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC561C27095
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2C16BDD8;
	Tue, 16 Jan 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKB3dBJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328516BDC4;
	Tue, 16 Jan 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435497; cv=none; b=TrcPYNiDYmyHCqQnkax44WskMS+rDBGfXbq/KE3sj8uKY1DtHH9M3f6TXerR7ik6L9gIJE/hTKFJoCCSwVvfPOFnbE8NGuQW9z+rw4qiclyB705YmMXlmOmeJUYtDWb48n2d7n/A2IRnutoVdyv+bYGRBdOEzEsw5mAmjIzbKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435497; c=relaxed/simple;
	bh=DjyPR4dgAdUITZFwt4FfywHkzuGab7dl6ru28ZYyiKs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=cdGiGmv9Qw6hVIG3eI7e6gEA8V3Xur50JLW/OYcQXqeEJJU1sLD0zhr8M8ds7lQzcD5x3ZM8Emo118LV8+TtdofmO++BuoulsttnbT9yY8N7r+jZxSTUp3uGBA2/V4E6ZKCWOY226cfGE/hFeNbeLIC0Tw7QoxYUYjiLnis5f6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKB3dBJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C954EC433C7;
	Tue, 16 Jan 2024 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435496;
	bh=DjyPR4dgAdUITZFwt4FfywHkzuGab7dl6ru28ZYyiKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKB3dBJD8/HgOx28xaSdZITVxPJEsVC6OIf/oG5+HaaM/wJ+BiTfj5zHJRotxTT0b
	 5Mxc5EUSkbpdlz2LzKKmGanN1C9G31Q3MfAmgr3qdeZ2laS7lGMNBKxy2y4qQL8wTx
	 5Ty7SoP47XZ/1IxDfZY96p/89QP+Gv5pC4LkidKhb7sripRkfjHhvWvTav/7b3U78u
	 UP2JbR/hYPBQ6nyyhZzPTfzTgv70vkEPw7h5SEk5IG3XPZFQR0bKi56j0gYUpGMrAT
	 xKEt2B7nK2DGOwylsaYVfpuS1n02FSes4MnKGZWiLqWOSy+kRLQCZtEMCI+26NX5q9
	 9+Q8TlJpPhU/g==
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
Subject: [PATCH AUTOSEL 4.19 13/22] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 15:04:07 -0500
Message-ID: <20240116200432.260016-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 39e75b997bdc..ecfb07c8e185 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: iram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0



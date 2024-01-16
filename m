Return-Path: <linux-kernel+bounces-28115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDC82FA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D996E1C25F72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1730154455;
	Tue, 16 Jan 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+972P8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBF154442;
	Tue, 16 Jan 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435176; cv=none; b=UnnaInDiuTego6gzE8r96fwIwfI2OpkHZIj5a9XrLE0sEd8T1ygCVqEVXhTkw/hUv+XibDSZE467QXyP0YqiSUeTWUcPfDaPSex7DE69ZhrJcYJnCcWJoU7GLx5xnNjYP0YW0+2IpsoqPK0C47hA2d+9Rasq8ddoQfK1ia1KdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435176; c=relaxed/simple;
	bh=M37YDnIacKyukv3DGUFltdTTixADU1QVYSnAgBJSkRY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=FQlAJ8jPXkcNL9R/fKnw3ioXCFcdHRVRSmLESl/PJeORqYrztP9OyCjZOzHKFpl83bUiQmaWZGUYbOkCUS6GI1lpm+14ZZ7E96zLf8ZsuJSEO/qKsuNsAYwCpwkJBI1ifFBrD9VSdMTr9h3SZK2C87/U6qyWQaLXnNw98Et1vH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+972P8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8C5C433C7;
	Tue, 16 Jan 2024 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435175;
	bh=M37YDnIacKyukv3DGUFltdTTixADU1QVYSnAgBJSkRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+972P8JJYhNaQmKhbJEAJYgf4mHFOb9a8HbQGVafPB9PdJLcXd1zmnsLvLus5z5y
	 L+CdRqeU4sKGvG3hCJp+dxb7RVrej+mJq2mzA1kokexFzDHOpsfisLHl01l9JjLSKJ
	 8KPP/fbw7+jFjvgMpdKSTwbO2ibDm3VoBGhm256jxSliCZdgiWRj2roqjXG87gy7fx
	 k1PdnZiNLdqzComp7IYHKYrSVMznAH94iHCt1vn2dMxSz4/xMAUlf89ueHkNs/iMbg
	 DWEq/qhk1iQZlD0mycEsJFgEX9M+XXPgQ51Xm4lixpKcIGllbJmh/KL1ejpRQyjRzl
	 BwDkOZyfagTzw==
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
Subject: [PATCH AUTOSEL 5.15 28/47] ARM: dts: imx25: Fix the iim compatible string
Date: Tue, 16 Jan 2024 14:57:31 -0500
Message-ID: <20240116195834.257313-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit f0b929f58719fc57a4926ab4fc972f185453d6a5 ]

Per imx-iim.yaml, the compatible string should only contain a single
entry.

Use it as "fsl,imx25-iim" to fix the following dt-schema warning:

imx25-karo-tx25.dtb: efuse@53ff0000: compatible: ['fsl,imx25-iim', 'fsl,imx27-iim'] is too long
	from schema $id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bd8ea2ec2457..5eb79a9ffe04 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -543,7 +543,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-28163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF582FB02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B41F27328
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62322657DA;
	Tue, 16 Jan 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0XjUw5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C78657C9;
	Tue, 16 Jan 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435318; cv=none; b=Fs8dp6p+st+mshTcCEo3v1xikJ90Ndjlo1qNosgTkKY3Zjmo10lGKF1B5gKjne2iWjU2RrZgwd4vvAZPHuD23t3yhGtR5ffc9Ef1VxHxKIrud/GiuyIRUbRWqbxOSMvC6z0tsX1qGsjisl1QeDVhOPSvNgqCCa203dvGZ6UwnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435318; c=relaxed/simple;
	bh=NG+Su3RKYRTKaczlnbgTDf5XSrB7y//c1cAxksNaT+A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=StAuhQRZ055Q53ScGq7O651qquhLhO+kVu59DWxBlfRuHEDIYraRsg/Tv/gZ0AJSehP3SRDk1gYhaivk46TkAUmYcDesFT177UAos5KuFs9w6KdOSw9m8bZoR502PnJMV7oeuRmtZ+v3wU1p4i3UgIEoq60WoUiL10/0FsyiV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0XjUw5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21815C433A6;
	Tue, 16 Jan 2024 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435318;
	bh=NG+Su3RKYRTKaczlnbgTDf5XSrB7y//c1cAxksNaT+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0XjUw5jGBOkY54EaC++tlEQpVfO4tMauKDSK/nAFf84lI2jyRielASe7U1vb8rFt
	 0R3PTyRMkA3Tnp1u/BeB7QK63KTr74fzLHi07MXhi61B3im8JoHc6aX5PAV15h38lh
	 XHT+spS8OahCy0Hsr0AbSBQNd/QLxv1Wj5MOpAW49JsONv5R5ib028YZ0Ql12+ioYn
	 je0nGQR5x8FTTs5tX3wVn+X5yvfCMVrmAal/iqzfjNzJoDs73vnaAboJCdoJJC2Qnz
	 NHgheZJ/IL+gLGKB5TwqVoCoqqEEC4lt35UANNeLqDcxwIH5oVQGzQ2bs+wrY0mHqE
	 Bt4eWnNp7tkmg==
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
Subject: [PATCH AUTOSEL 5.10 27/44] ARM: dts: imx25: Fix the iim compatible string
Date: Tue, 16 Jan 2024 14:59:56 -0500
Message-ID: <20240116200044.258335-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index d24b1da18766..99886ba36724 100644
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



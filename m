Return-Path: <linux-kernel+bounces-28052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6182F999
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AFEB2908B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31444604BE;
	Tue, 16 Jan 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADu/nBQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431C604A8;
	Tue, 16 Jan 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434987; cv=none; b=dUURexax5KNdrLm7U1MaP3J0M10rHvoegM3OxGsxa62pd1bTYuyozFhlOQSx0JytXsY7oANUVARp2NuGhCXuf5teiAVgFXJg50nWewWufy7cTAGZ4kDnwO6NREXw36ieN/mQHMSW6EoYgcwCzY3H/gVtM7plOqsqQnG+EQ6wzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434987; c=relaxed/simple;
	bh=MshDTtgaXJOWpHjiNMQNnza460rG7eEOXkbPTJbPx2w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=KKZCelzeWBQltHqBXmqwscP/gdKlaCyCP7MbfdKzsbM1kdrbWHd0cVoA6chFqQT1UoVDPX+hxh1bhNDODsVC+I5EbsgRzOaboCgvkBYTUpfY2+yx5eD6N6KfdYuLH903ezLZAk3BA77vGxnpN+iS9zIrd8k/0WSe0sXStQn2Ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADu/nBQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33316C43330;
	Tue, 16 Jan 2024 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434987;
	bh=MshDTtgaXJOWpHjiNMQNnza460rG7eEOXkbPTJbPx2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADu/nBQGIRVBkW3ZXRETq5wI3jpCyj5Et/TVL1znRdOI3/hU8+2f+fMIKN3kvYdl6
	 UEGKoqUxdkpr7ytFyJj92en88UIijeVR4qIesje5JpPV6dZGO3+CErcutfDvMV7eTB
	 OY4djJ+SD1grf78H/KqJvCbnhMSrSvsi/wbMtutCF0hb0rAl9UgM1xRj1o17+bVi6/
	 PRwQ3zndVRWohJ3Kg0pDlI9qkvUjQspKR+pTciY76Nr0D4wflu5fKtJJLR12U+X12e
	 T7BC9rltE5No0tfI5pONedDCvhKfcy+C6Uk11HWkgVgTZHAuxCZiYg+U715yaR5GAF
	 Iw9UnjqRp5L9A==
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
Subject: [PATCH AUTOSEL 6.1 34/68] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 14:53:33 -0500
Message-ID: <20240116195511.255854-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index e140307be2e7..eb6daf22486e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
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



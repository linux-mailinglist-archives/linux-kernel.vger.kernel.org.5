Return-Path: <linux-kernel+bounces-113003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B48880B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2456D1C210F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37162130AC4;
	Sun, 24 Mar 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvZ9gcRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67412FF89;
	Sun, 24 Mar 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319814; cv=none; b=DW94EZSdFe8WV5f/KDxwbUWxeuA2sDpFBAecXgtAt3KrpmxpEC9GxCeYkTsCeAPp6lqoVaU00PNYufWOpHzRaYTB09e/HHMd5YOLISnkRZn7p8EbMh9cqH4o8iDiz7aw0gjftqzj5eM/4UxdKgkDgfRh+IQR1i/jpSDbO0iSel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319814; c=relaxed/simple;
	bh=DiYoUl9hVkKIa+xG9L0jGwjfOCAQrQdPAAxKOqq5xnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN/A1eWM4fWHu+zDqenHFZA7NWiHgWNs9ruVwlE5ptPk0RHAAe23mnhnmf/FC6adHKtAx9wQ7N7PI8TNdzEjAhcpk7E4k3YtCq3jFNqD5Qcoy64/erVOeUVf9NXUZMqpNcVJ64vbBoq2DePwdjg+B+LK6PmTDr9MIoZYRiDY3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvZ9gcRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E107C43390;
	Sun, 24 Mar 2024 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319814;
	bh=DiYoUl9hVkKIa+xG9L0jGwjfOCAQrQdPAAxKOqq5xnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvZ9gcRgt8xBggvmgyTggPkbpCzNPmW7tEpi5K4w0bPO4prAKUyoWGzBaNQ9WDKc6
	 RFOI/Mo0ajMvGcjalAP5urSzawhDxifORdkjA3ldYq1++0VS1Fl+Xj5VPeQrvi+NHZ
	 f8/VA1trgweF3Z2uqsVe9Mi+hrHgBUltjwwWmD3v1HcnmQi5UE1LM+wxwzqeokZq81
	 ShYAqnsysmlpcdsGORl9SqWlSjbgmgZREJ9Fy3IV6ESbec9fm8UevQiis2aaADnvhc
	 Hz1GHUJ8l0ur6D4slckDHIRB3ExQywJ9rHUsFbP8LvfcgaS3HBsorf3HFhSY+sjSow
	 GAJi5euzGVEVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 116/715] arm64: dts: imx8qm: Align edma3 power-domains resources indentation
Date: Sun, 24 Mar 2024 18:24:55 -0400
Message-ID: <20240324223455.1342824-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 7edee2b297e5a4f805e5b945c0c0e6f4f8f719b5 ]

<&pd IMX_SC_R_DMA_1_CH*> is now properly aligned with the previous line
for improved code readability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 5136ea6b109d ("arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 69cb8676732ea..453fabfd17b81 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -98,13 +98,13 @@ &edma2 {
 
 &edma3 {
 	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
-		     <&pd IMX_SC_R_DMA_1_CH1>,
-		     <&pd IMX_SC_R_DMA_1_CH2>,
-		     <&pd IMX_SC_R_DMA_1_CH3>,
-		     <&pd IMX_SC_R_DMA_1_CH4>,
-		     <&pd IMX_SC_R_DMA_1_CH5>,
-		     <&pd IMX_SC_R_DMA_1_CH6>,
-		     <&pd IMX_SC_R_DMA_1_CH7>;
+			<&pd IMX_SC_R_DMA_1_CH1>,
+			<&pd IMX_SC_R_DMA_1_CH2>,
+			<&pd IMX_SC_R_DMA_1_CH3>,
+			<&pd IMX_SC_R_DMA_1_CH4>,
+			<&pd IMX_SC_R_DMA_1_CH5>,
+			<&pd IMX_SC_R_DMA_1_CH6>,
+			<&pd IMX_SC_R_DMA_1_CH7>;
 };
 
 &flexcan1 {
-- 
2.43.0



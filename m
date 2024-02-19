Return-Path: <linux-kernel+bounces-71872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAEE85AC15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26672283D87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB152F96;
	Mon, 19 Feb 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFyQI/ZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDB50A75;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371253; cv=none; b=kAq5HdPr8Drj0kDlAJhDPIbo/bG9M0GhyCm8jtpivQ2H6KcfnZOO5FUEUmnUDnuC2PyILwpvBKOXrqA70eDcfeAYk+xnQ/jd7slJ50sbUr79ZCV0WGjg69hNNiBvsNfrckJYGHkuJ46sVF6QE3Bxih4KQGVT8eww0pRd/EnIT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371253; c=relaxed/simple;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZ6/pMT/+qL3VpUuTxIVQRIIpCgAM6MNl2ZgYVJ3cOkGVhbTVmTLOhkVA3yNlJKsGG64ZyW55RWCYxpZi/iO4ni8RGr3o7OI2UWrQAfPwHW4qkLnbnOr9TyOXf46IDmMsAaHSFfP/6+PeMH5HmbqZ2M5Vebi7zFZFE1POiEQrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFyQI/ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70F9C43390;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371252;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IFyQI/ZKDt8Q2YaHwyi0gf3pcJWj8K/gIjEfnPE9zbjGVqe9K/ixCDcgKYOixfin8
	 T5I6vZQX4gbw7bXNq/Sg06/xZjHRawzNRmtt+qfWpyMSPQVs1A40POMrCcSav4yRfZ
	 YBB5N7+gaLz/f17Do0QUuypKgGFLulSR6NadkJssc6os0PKqgKE5U+Mp10g4w0x9Bq
	 P4KgTzqhavFDzp4uqvM2HjakZhVis6cYq9RQ8zkD9jTWnWTfJ4Rz4gXhXb+p6Tn9hJ
	 QQLaruyiYZFnkt5K37wc54K4aRtzzF7mcesG15nTi0btO9X2vEwfLqIV1ETuCfjh0B
	 cjB0z3HEGFTqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0CBC48BC3;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:34:13 +0800
Subject: [PATCH v5 2/5] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-b4-mmc-hi3798mv200-v5-2-f506c55f8e43@outlook.com>
References: <20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com>
In-Reply-To: <20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708371252; l=722;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MzqKbWX8E5l9h/hzBiWtMINHXtoCtQN0jkOqsqOv7OM=;
 b=Bkbs/tWN2onE0fLGjRMLTNg7wCp7OAIkTmcySRNxFXCkM1RZnu8uWY43nY65UTKj4IVAywetk
 0wUdrpDDF0RAChUwOFV37GTB4YGs0be3LZbYdpmbC94BQlXJSNR24uu
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The alias is not used and should be removed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index e9470c50a348..61923a518369 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -201,4 +201,3 @@ module_platform_driver(dw_mci_hi3798cv200_driver);
 
 MODULE_DESCRIPTION("HiSilicon Hi3798CV200 Specific DW-MSHC Driver Extension");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:dwmmc_hi3798cv200");

-- 
2.43.0



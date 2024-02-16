Return-Path: <linux-kernel+bounces-68459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FA857A74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D386A28504F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275E537E4;
	Fri, 16 Feb 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGUGMlAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651B50A98;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079897; cv=none; b=jx65EGRjAqeEUmw9+yBYpwOjnzOIYaGB01Jvr3SUM5hvb2GNXoYaYJZsUPa3/WtU3oyAfADVDdPqpA8QrJDUAM1UimzyrmY/d1XO9KeEj3RZeVGK/oZTzt3NxBfmqXDuPsKvoMqvQJ55TU8VRZR9blXKCFDKDgfBjqqMkXlCi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079897; c=relaxed/simple;
	bh=251ik0E4UMYsyQZjqLcLSBwBl/7/YEYssrk8/HM+5OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzDWeg7r4T8nyiFjSeQLCRnLBJ85Tf/V2qpKLcS4rEZGumcUcXAe4eDWSYo2Dny9qO57a7+ZhIejErMpJ42/RnZqPjzOL1ozZjCSHnzv1ApblhlJ+QXFYLsuFCPoLoyajSyRF10HWi3RdwE2qOHRpxvibjbTFOfaqsPEt1AzvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGUGMlAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09296C433F1;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079897;
	bh=251ik0E4UMYsyQZjqLcLSBwBl/7/YEYssrk8/HM+5OQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dGUGMlAB5PGo0aOa6NuDEswFo0ZA9OVXi9SwvMo0dAEvX9A1/M0wg/ikSU9EBJNaa
	 bryVH1TbNDLNWaSPKgkcrjMO81/SsBaJH8JajXELDPrLan5GZjS0Wx4I244B4JyjXu
	 cvUpxsY71r3MsVE3hld/4OUNBEaYU4jR9oEzZrT/x3u0YQ6urIjGEPd+CvPWqulax9
	 w1pulDXy7MTjklfYc0ArFNU4HAlaVFSgoD/YmQSz68OPmBPjdVl6IdJ5Mv+YSpZcEa
	 lgBH2l23fPYX3glUUnMjCi1tY1lmrNiWv2m59iZC2MREFoSjznAyl1TDy8AqB9xl5D
	 UdOB8NiQpOdrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2025C48BEC;
	Fri, 16 Feb 2024 10:38:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:37:59 +0800
Subject: [PATCH v2 1/4] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-b4-mmc-hi3798mv200-v2-1-010d63e6a1d5@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708079892; l=655;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=0u4f62e9siRMTmdM+MOND3wWH1hfTQP0NQvb4G8fUgo=;
 b=+6iXLTHBrNd+nA5LYvIbiXF33bCXCt5rizsi7MWM/hbGq+iaroklHJFv7Se2PrjyGOZtU2C5j
 U+5CxoU0tU2D46BP0bxN8r/RwcH833GTvtgdjE+6xtAZgnsR8dnZTxZ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The alias is not used and should be removed.

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



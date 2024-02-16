Return-Path: <linux-kernel+bounces-69338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EC858792
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87701F273BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACF146003;
	Fri, 16 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7wSmqHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7B28E2B;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117351; cv=none; b=f0X90drFMuAgfIOkEk4lFIJzMYnwBhJ6/TVCljKAXmcxQqXGQ1HwTX4GPe9k6yePry4wlf5D2AbieBCU8XVzHf7Dg82AsBofqopawZh2KRlW7iscQECORShllfj6bPrGUgt6F67PJP/LQ490CDJMKOcSY7xUINeiVTEVbAGu6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117351; c=relaxed/simple;
	bh=251ik0E4UMYsyQZjqLcLSBwBl/7/YEYssrk8/HM+5OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi75Y3ZpIJh79m35PlJd+C/YmdOnuDkZX1Rsc0CK5pZ0d08fJTTIP1YDyrY41z1x1imeVjsCZeT0NVRQ4OND/NbBae9FZpDFu3wswdCjTlA0KVP8m7OFq066RLytW4qwe//TAnhSqgDoZAAxoem6sTeLMOm813mETauko4VsyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7wSmqHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D439C433F1;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708117350;
	bh=251ik0E4UMYsyQZjqLcLSBwBl/7/YEYssrk8/HM+5OQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C7wSmqHnsv5IiDjdq+TE8zlsl0DMgdYVyhwAdVbzEiXEhm7E3Gbuo3OADK+dFsgW1
	 hGCX5+ATbdiOggs6U3t42N8BhrfnoL4i9yfMnr1yjNlPdV0rHPY5vFA0etJu9SKzyo
	 BOLQbNRDuARVJXwNXA2PBGL55wIUmK7VzRkx/4co6mR4cRD/L52FvN4K1xdbz41VEY
	 IGzQtiJgBSrbfHmGMlO1sYdPlVIkawvWWON2HrE4wwKJVN7AdCgAF0ZspWgi0HQAWZ
	 dvabrZFXuqPUaGkaq9H77aEQP6LilHG44M+UDrVHm3r23SDngS+h/JuUfDY7QISTr3
	 D9ubQWOMHsZsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EDC48BF5;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 05:02:29 +0800
Subject: [PATCH v3 1/4] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v3-1-f15464176947@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708117349; l=655;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=0u4f62e9siRMTmdM+MOND3wWH1hfTQP0NQvb4G8fUgo=;
 b=3xlUuW1Y11g1UK4Yaj2znDnXt85TDhRWfDC2//ie6OgQBYKxmsIOKHyffOlhpwNaX6L9k8ysz
 8XNqrnxU/X0Ct8z0LvQOoKf3p5/uEj3DT7dR5ynMjrmxOhDqDtEmjYo
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



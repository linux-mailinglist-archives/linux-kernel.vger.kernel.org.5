Return-Path: <linux-kernel+bounces-69855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A4858F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C73F1F21C20
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F567AE74;
	Sat, 17 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6XWPE/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E03DBBB;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174881; cv=none; b=B1b3SQNIlSMV6bdJw8V+4g56+sr5cwdos8goFIYSe5VQWXkz580JGA3g7pPzDNKZRqe2BHazJEafjJuPq5qWqwD/hq4DCc2s7NBAmUZOmRisSV2kaRO/JYfe2umXcBU6UGcGyqbV1YtzE+OC9MkT+O8KFwB4fMPiEp8pkEp3eA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174881; c=relaxed/simple;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2+ucRSNiKfWPeT9V5czKtzBBcp70yyRjfjBvVQ74Mk2BVVUa/2+vZlcqBbdLJQF2kTDp6w08v4qZ9LC8ZI79cdk6XvIgpG602Sy1wt7hLJPRSR67DrsqhtT/QXFHqFDVvbggE8yWNGXMmJhg0fzAVRghM6ytlumRmeKtLCdh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6XWPE/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92F19C433C7;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174881;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M6XWPE/CJ/2hlwW69ATq3fqpxb7P56tKpuB2LexT0HGjqxTiy5/bfK27l5GMbAbcA
	 rUgEyNm2L4IIrJqwcPKxP3FSb1pLxzP3K+wQGovS5EuHMXX9l5VQUTLA7zRhf4ADhg
	 I5ENZaOetAG0hF4i/mkJR57ToYqfyNuIkQ5AKi5OlyvcSjlkty2pZKhrb9bxhb9G0o
	 ARev8ZEOSs7hcd/933PjS6taTneizlfsdMf3SAGp22SR7S7uwwcsQF7C196hJ1O2Hp
	 n4HHenkD12SKmkaOuxMe7axQuuIpIM+7ccj62XfWqlhhIqqaasE51ngUY4SW2Px0EY
	 4LdVb8LCe2chw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC8C5475B;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 21:00:54 +0800
Subject: [PATCH v4 1/4] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v4-1-0fdd9bd48532@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174876; l=722;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MzqKbWX8E5l9h/hzBiWtMINHXtoCtQN0jkOqsqOv7OM=;
 b=p0Ru/9B0Gk5E2CLKrQbhOKHda9ywTxh0drWAf+iaFC5vAIAFNgoKlj+svGoazn/8OR2LKjXQm
 tbUpbM/Cn74D3Pkr29ca8stVMRbgFhJxfLx6P32i2mmrRFadbIBH/ob
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



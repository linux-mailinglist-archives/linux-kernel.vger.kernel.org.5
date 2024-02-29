Return-Path: <linux-kernel+bounces-86003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF686BE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46BA286CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B437162;
	Thu, 29 Feb 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUmhUaQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436602DF84;
	Thu, 29 Feb 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170617; cv=none; b=rkvDGQW4HrCgHt0SThQkF+yDxIupIp4tl5oC8EHfS3xktfhb2R3J8MYVn0yVwOCwt6Z8ieI2s51Q5ORlq6mX2NLGSX7bvg6vLQhgpXxtWcrnr2S11l9SvCnkQ6q2Eq6U5wL9bJ2iWmFuDdI4UEw6WWcDFRfhHXH1qf7C90Wd7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170617; c=relaxed/simple;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sP0BTS0WrWFTZpFD/zPC6ycj7k0Ee/3xWhXOv3EO8cbTdqgBjJDKO9pbIxtlhLrpZjYw9+J1K1UnO6m+kkH6yiW5yG6ZkLIaxj5Aa9abSL1VqSENqNuW9umE5Tn7a1sH0q8yoXVHClfvI1cBcjbCpICCpLJ9toudGqGj9bLnH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUmhUaQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D24D6C43390;
	Thu, 29 Feb 2024 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709170616;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UUmhUaQfq55AGLpv+pmciTyvj4SE3/oa+31gtdWBqBJuoF2ddFPP+ItTYjJr+omNh
	 IgIvpRonlYide4NK6GFMkiiYc9SISREq5VEroclHdz5iOyf4eEHe9GLy10dZxDOyIC
	 6L6J/021RdDXUws4QItM4X32mvIvfR+hOKsAqrYimNkFcQkyOXyimrBvu0Ooyly3YN
	 dh/hjpfECEETD60aG6WAO7wJKUSM+2g8oRaRbX2OnOh8Zg4QY7iG5Y9dayeWGpROhU
	 pZMm9N5s8zSjD01meMYF8+CvqmSUrkJvxHqvY6z0yjJXZYzP0sDykh297dAJhIbTnv
	 di09uFNKfgczA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0306C54E49;
	Thu, 29 Feb 2024 01:36:56 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 29 Feb 2024 09:36:20 +0800
Subject: [PATCH v7 2/5] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-b4-mmc-hi3798mv200-v7-2-10c03f316285@outlook.com>
References: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
In-Reply-To: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709170614; l=722;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=MzqKbWX8E5l9h/hzBiWtMINHXtoCtQN0jkOqsqOv7OM=;
 b=SxfZfOc0gJcYYcQ09exMI74bU1nye/xnBgGjeWBOLcMuJp0C+xXEqczfgNXZIDq2V6CUgrSat
 293VS1CDZXTAh27axDKfunQjA9OYkHyK1hcmtoVz3tQnk+8jjXryu9I
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
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



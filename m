Return-Path: <linux-kernel+bounces-74713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC285D828
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D491F22A46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE31769D34;
	Wed, 21 Feb 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfbdt/tz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC952F8E;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519547; cv=none; b=DxTDbK4estL5ItCYFBOwx9gbfDSz/zp8w4DMBRhI3HEm37aUOmXsQfIxpoVJbmdo1/yc21UiZLYqzwAUYvNKvXKRym3WYAQFyLpxKcb+W2h+2PNzwDaQ+QbEwub1iPA1t/Q+dmsJmFGGl2ScfG5oPZdngY8LBQDmRRDBLyBjLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519547; c=relaxed/simple;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u77i3HdBlHjhRMYMT0BDDy93CCIdOj3AjsYF4BXe2GoKrfMRwQDN4HRFOaK7SK6WBlQQUUooX5/ZvROpjn/o4KbhM7QnDOIPUAWl0ExwiOi+Sni8w2g1OXhvLjlLoLw69juVFF9PF6Mem8Kf5ViXYCX08Fujb5+YYabwwBrufuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfbdt/tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A688DC43394;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519546;
	bh=uiy23fzx9AJKJeZCc+CpWKPnHutJKS8U/tiBSjzkWs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mfbdt/tzKycr73ZDAk7GADyV0VOth8+8m2uJuA/FWjrY8NWMxeL+k935y8/94xl/L
	 UzOFwT2yPLro34Zht05MDR34hSmnhXRbgpcWAKYiR3d7xqOCXCvQpgq2VQepHj5T6f
	 Zld4xNyhZ9qvWR4IP79yKwx6nTcgAOHW0zg5piIVVPprwgdHFPSsl85eP5VGufMxrH
	 Prm9nDLYqEsFNfUkUP295KwIiWxXTruPpEXNsdw6cjw0zaqU+PdkfCtz7/l/K7eIJA
	 RwvwaWOgEB0E1TqQiqqmJBbYGLHw9sMjv6gP/8Y6PIyY92H1tRcasdZtxurivifSID
	 GilK9MR2xPS9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B6C48BC3;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 20:45:04 +0800
Subject: [PATCH v6 2/5] mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-b4-mmc-hi3798mv200-v6-2-bc41bf6a9769@outlook.com>
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708519512; l=722;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MzqKbWX8E5l9h/hzBiWtMINHXtoCtQN0jkOqsqOv7OM=;
 b=2Hrl+eLmAWmN7TCgsrVHwExtTo6VrvpDNenLFev/0tw/H338tnvC1eUX+jbpCNdr+nprr8WXq
 HlUAHWGYwrMD9OxFqjIbDP3scqJvug/u9CuEfP39mxQlJbkj+p4Kers
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



Return-Path: <linux-kernel+bounces-121745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC488ED32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CB61F32C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD81514C0;
	Wed, 27 Mar 2024 17:47:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8214EC68;
	Wed, 27 Mar 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561649; cv=none; b=RgOh0/Hy5liAC+3YcIPudOjU2k1yiND8gmPtrlbI+WsR3elYK26eu+3DEyUih6iMwKDTZ/m8I3sGp/eKRWwG2ja4VsVhdaxYkhWTb8z8G/eLWlBMySWjJHQLgP6Ucyos/AORjS0AvngJ9pF/VWX2SWCHdCgtkTIGsGVuLvR9DbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561649; c=relaxed/simple;
	bh=pqPEuasCKK/94yF+k3EIpOiK0SjDzTClgT9YwkUVQJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rl6Gb6JMvjonMtHAdkFESwdpz7JmuWw33cgs2JyrKXZNcNOmddn8sn2C0EHOp8qEkSOdGCO+88LRsCq14/3/sJJeTQNmCfQOf3ISQR8adNSOm0eKAnSKg38VK0qwczOvxP6eAnFqM9Zsa/p7TW8KPlZ33jG18N7/ZZ+v3/r4a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E957C43390;
	Wed, 27 Mar 2024 17:47:27 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] staging: pi433: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:47:24 +0100
Message-Id: <20240327174724.519607-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/staging/pi433/pi433_if.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b6c4917d515e..c6498f518e91 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1366,7 +1366,6 @@ MODULE_DEVICE_TABLE(of, pi433_dt_ids);
 static struct spi_driver pi433_spi_driver = {
 	.driver = {
 		.name =		"pi433",
-		.owner =	THIS_MODULE,
 		.of_match_table = of_match_ptr(pi433_dt_ids),
 	},
 	.probe =	pi433_probe,
-- 
2.34.1



Return-Path: <linux-kernel+bounces-26119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E9682DB91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299F283056
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0717732;
	Mon, 15 Jan 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhAQmqlS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406B17596;
	Mon, 15 Jan 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28bd9ca247so1049458766b.1;
        Mon, 15 Jan 2024 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705329790; x=1705934590; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3unoLz8qq5gzyLWgjX+DKaq8Yqof9OjzZksC+6350U=;
        b=PhAQmqlSEaNhq82wZ4DoACN+ByC9PpZg2CJoB8CqF29+pHUZT6VAGKcIjYeKNi1exY
         xR7VgsdzmhuU9YMeIU3yC7Q7o3Mox/K/e5cMmViLBTRd09Xxmvc1OxVOEqOLZvtsJEVj
         K6mfJBKzevfbeWuXjbg/7WaU1MBS8o3j1sFRs9Zs+yDEMaSNYyLo/bnX1fwDF1l1K6qR
         MN6b31gpeIl1tB0AiEFgwb3hRJFbXGgMUIkFt1XG6fa2LMb0U8JIqSf3HZ1d6FRjJ0vN
         xMqoMAEEvfjC0zGIevXFTh6qyLDu3qd6VynHnMW3bRKoCDaPxrt5HZV6Dne9ss9Uri1B
         jFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705329790; x=1705934590;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3unoLz8qq5gzyLWgjX+DKaq8Yqof9OjzZksC+6350U=;
        b=azlaXdXOQvKuVTYG4zXSHti61sR8oZ2LPGYx4HDEOXpZwlAJwbwvkVw1vm80VS2M7R
         yZWXu7R7PO16SQHwVcGZGTX+mPh4sEqrN6RirRUgFfvc4Qvg8oe19jib/NtyOrUB1VqP
         +YwK8Wsu/tU/zwUoMP+0ENjw11ZgOLnNdU5nvf34SZXfuLOT4a1bquh3nr35My1dfgvy
         GAuIogKwxJqd872oFn2f8AAouIr01HMRsIIygg9IStaRjB7skAkhAfmly0OmWhYldRW2
         MdEzwgouMYhChVvAx0ZJqNM59JLgd2tZEvLAdg10wrmN3mONzPyWJs00hPplXouW5cs7
         XJ2A==
X-Gm-Message-State: AOJu0YxWzZCL04oyZNwAlYiOg6XqfM95Lru6cxDbTf9aL/EkiC4flbRU
	Pfvr9DtQs+RSiQcjdWx3wIw=
X-Google-Smtp-Source: AGHT+IESbfZkbhBP4aXLa6lup3Yu+AK6r90FuUDsmJEoatAKesIlHCTEasijVWlVlTz7Z0z8YaK7gg==
X-Received: by 2002:a17:906:fe05:b0:a28:d103:dffb with SMTP id wy5-20020a170906fe0500b00a28d103dffbmr3228911ejb.78.1705329790244;
        Mon, 15 Jan 2024 06:43:10 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d1f6:7ceb:4655:5666])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906584600b00a2aef1e0731sm5339019ejs.77.2024.01.15.06.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:43:09 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm64: drop the no-effect select ARM_SMC_MBOX in config ARCH_STM32
Date: Mon, 15 Jan 2024 15:43:07 +0100
Message-Id: <20240115144307.27409-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 9e4e24414cc6 ("arm64: introduce STM32 family on Armv8 architecture")
adds the config ARCH_STM32, which selects the non-existing config
ARM_SMC_MBOX. The config ARM_SMC_MBOX was once proposed on the mailing list
(see Link), but it was never merged.

It seems though that this STM32 architecture works fine without this
driver---otherwise, the users and contributor would have already noticed
this by now.

Drop this no-effect select ARM_SMC_MBOX in config ARCH_STM32.

Link: https://lore.kernel.org/lkml/1575281525-1549-1-git-send-email-peng.fan@nxp.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..50ace066d57b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -302,7 +302,6 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
-	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
 	help
-- 
2.17.1



Return-Path: <linux-kernel+bounces-34019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5378371F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF19E28A8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD460270;
	Mon, 22 Jan 2024 18:47:13 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740AE57312;
	Mon, 22 Jan 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949232; cv=none; b=C+MG3iGP9cwIj2gNQXxLFJJFS/AJmMqs53GIjdnAridxRe9zKJVwZ0OTpAFn6GYxF7yCdTZHUMqDZvO44OZMFO5hemcNmvBvfG8tI9Fm+BMDjYB7/ynnxzdSyhGvGiCjbwKu25L+9eD7HAdvsWyziTWsoCI56PwQCLWB36PG8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949232; c=relaxed/simple;
	bh=uh8t6LUvifH8vyCsv0JdPgUlMgY9ophz5h/l7o9N6Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeJK7sVRTh+gKiK+W5ERdorvq9sc6rjf+V2I5gJ7P7hC/A0p15BGsaweb+r+qDIay1gIw3+quQb0M9U+3ofw3V8IJbAegSIbJoM2dVfiY/Je7QIv6OfPQ8Lkxm6TRn6+9JynN+XUMCKnza7zHOaTV5jRzWn2t77bsv7uEEpdlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2d04888d3dso366791066b.2;
        Mon, 22 Jan 2024 10:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949230; x=1706554030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AgXqAxt6b/HLf7UsuchGiNA/0l/ev1PlS/qyb2yk9M=;
        b=pTpy/+LUigmmI1pz008scizMMbBKhAq+Pu4dlUg2VPGe5MltHAFSZG0i1Q/alcjdQw
         dkXHii68dDbYac5JKBKFbV0GcYhez2I1YD7SucOjAwjMdDvq4fuubZ9zbrdpqnMkpxTr
         cvVK8SNsJzDd4iVIdWgVjHMFOTPkM6yV35OOmhsRo6k42UqHym28W7B9Bwcoi8fL2DMD
         lkciljRZNRZuQtqFiDNJfUyTatKih1RAWqYDVEQP0E8qZ2vmNPX+R4f/WHINg2rTgi+M
         +5JsRUmWj8S+CFaK1Cu988AX7D5PD8yMslmRPMADf4B66G6DP22iDk773aj2MCkJ6xcc
         h6Gw==
X-Gm-Message-State: AOJu0YykSEmsAnx3gy8M3N2jXEKzjBbaFYWd8ulHT1uYzCG844qBWMhk
	+vnA1Ktc6QWA0MDIzdNVIgmhqPfNXN2OzQAiCoNPCi7PDTSDRcYA
X-Google-Smtp-Source: AGHT+IH3gTSGI3SxAP9i1h8YcrB3qhE5DHJO+EwUl9v/RrhOAk2VBTus+0Y/q/rD13UKqbRQYhRg1g==
X-Received: by 2002:a17:907:8e08:b0:a2f:e26d:ceb2 with SMTP id th8-20020a1709078e0800b00a2fe26dceb2mr1691230ejc.135.1705949229792;
        Mon, 22 Jan 2024 10:47:09 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a2e9f198cffsm7241654ejc.72.2024.01.22.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:47:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 20/22] net: fill in MODULE_DESCRIPTION()s for dwmac-socfpga
Date: Mon, 22 Jan 2024 10:45:41 -0800
Message-Id: <20240122184543.2501493-21-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the STMicro DWMAC for Altera SOCs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ba2ce776bd4d..68f85e4605cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -585,4 +585,5 @@ static struct platform_driver socfpga_dwmac_driver = {
 };
 module_platform_driver(socfpga_dwmac_driver);
 
+MODULE_DESCRIPTION("Altera SOC DWMAC Specific Glue layer");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3



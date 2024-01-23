Return-Path: <linux-kernel+bounces-35961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDAF839952
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF6DB2CDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08012BF0E;
	Tue, 23 Jan 2024 19:04:20 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDC12BE9C;
	Tue, 23 Jan 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036659; cv=none; b=BUWSlaOS9Wjx/+J5oNj5a23CjCv76wvAQoJky1OXPo1o6k8ysL1pBxugcfR6MERgxEMl0HizEfK4rIi7yNhBM4fy3cnVOl+fYjooNiTx2Kep6xjZCf7yjSKOwxFkTu5Rl11ps0e2/S9Qzb/+SPeJ6CUG/guze9Cdv48U4w7GnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036659; c=relaxed/simple;
	bh=+f0GABE2vYwLftBWVjTV99H9hCN+aUA+VFW1jTa4YvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=th1TYi5iO5/NTAHnzBK/5csfr/k/LoQ5FfmLg7xBtA8r4E+I1cUdOlAJ8rZIVWW72J0bZKNXHmKKu7PdrffVSa/VlT4LY+ozziq0gSss8PZ/Ch0akI4Z+X4lwvv73Ul0ddTfEw2/zUh0ux7t6jKk4xsgLLNlG8hr6HSh/DHhvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf108d8dbeso12349981fa.3;
        Tue, 23 Jan 2024 11:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036656; x=1706641456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyI7NPsyPL2bVyAR9zv80ihx/UAk8uVQYMV9FnhPAlg=;
        b=Vf+SJdQlGHeIaawTm2Z/7FFMiupjxaaekT/Z1x4udbeTUeiqYZlpxQphL9bHZVDfo/
         XB1Opmdm8ypmyoF/hdQe4YJDbJdPsmAeIDccfCKCU+uuRbfnJp6PZOusPSw/0PDdjmN4
         TCI3agMa4TG72PHTFf2xMHIszvjMrBEsS/17X+iAEvzQIb+OiKN/CObm7iThifg0f6jQ
         K81mF+Fm2gAemCkjekyklS3HnbfHFhfm9dByoLV4Uq6tU9Yn93LJ7YrnMcnCPdfNXZWI
         1QtO74NZ3TiY8Qoa5vbgqBOlbHyjDef+8uOvm/GA9yJ91zdkCTCSYc1nBDKNM5bEKBUe
         BdLA==
X-Gm-Message-State: AOJu0YyzUf1fkuj3c9RiMwblf8ibqYf0bw4bWcEA5pyGPRAyOHFTjK6S
	pZueouF5M5hGdYQ1ZtjeutYqluqc634bkW7Q3fNIUhh6nct0mrlgnZAz+rdEgji3bQ==
X-Google-Smtp-Source: AGHT+IEkgdQobjvwohe4u/L8jed7+G1Vf2dRP8pMSwDmBzqw0v/GwGpeu3lo4enqPrNhgbaC7t3U9A==
X-Received: by 2002:a05:651c:2d9:b0:2cf:81d:3abf with SMTP id f25-20020a05651c02d900b002cf081d3abfmr135820ljo.50.1706036656201;
        Tue, 23 Jan 2024 11:04:16 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id em2-20020a056402364200b0055c97f940fcsm419528edb.81.2024.01.23.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 06/10] net: fill in MODULE_DESCRIPTION()s for enetc
Date: Tue, 23 Jan 2024 11:03:27 -0800
Message-Id: <20240123190332.677489-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the NXP ENETC Ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index cffbf27c4656..bfdbdab443ae 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3216,4 +3216,5 @@ void enetc_pci_remove(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(enetc_pci_remove);
 
+MODULE_DESCRIPTION("NXP ENETC Ethernet driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.3



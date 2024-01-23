Return-Path: <linux-kernel+bounces-35963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE0839936
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE32982BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD412C53E;
	Tue, 23 Jan 2024 19:04:24 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7B12C536;
	Tue, 23 Jan 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036664; cv=none; b=CVhnUbrb5vBmff8ppUTxNvq+ck9J+4kyMaOIXjs1sUYeFu7x8wuzmbs4gZvos+EsWSAiqmRmLou5P19leoz8fqTHU5LHZq6l/JjMC88Sp4G3JvGiLxwpMlUGj4gJaXNg6hSt1zAYDtoCRBnxA4fbfAwUowVfIiq6AvhDcgfEV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036664; c=relaxed/simple;
	bh=6kGze13WylCLA856z5adMpns/n4JZrIa0Cl5K3i+HqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3xxJ+yDrbmJc48wNLNB+dg2oKoPiGbK8MR7bBkElfhQcDBTO6PIgfYq182YHKQGsEBNZOYlfjw5SNGXQDT8i9aJaX6v8wKoIVUT/aH/tz2Ezkx3NhhmCBV+V61ltG5P9HfxoNi8RrX7DxmJZNTfaVkIyT9CxIFId/sAzAYRmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eb95bd2c6so13392525e9.0;
        Tue, 23 Jan 2024 11:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036661; x=1706641461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bCNqD04536JT2N5bRAOPIsKMP7RhSKgGO6zO5cLVI8=;
        b=v/mWqbmltBXkE1JGtoQnaIcI7B3UL6SdMRfPhzJBw7cNHyNAOHQawmMjkMpEG5TH3M
         z+MI1CY+aZQu7qHcqvu0NFb9yeibnTbldyJ2o7IJ8W12grjgFwgsiKonx6qaezRKcD5t
         Y/mURg0HLoWYvGJRXZM4+AndVkoncdPYEbiyO5e/gZoUPsChKToydzWKR59I1yli/GR6
         EKJkwIu+n5uoyt2KoXmQqeDZwg3+ZobiEuNGv7F62eHmclcYWPSAiz6v40OZpUwofZpS
         3M6k3/Z0enYQ+L3/tEOk58bi6TBqUllQE2T6tgeHSwPXHoSZqBUp4ypsncbsCdJsUzML
         9KFA==
X-Gm-Message-State: AOJu0Yxd0DIwG9DXOvi5nBpr6ldZqqU6B2XARwteV6KxVClUak2wbcLU
	GVuCgBwqp+DJDUo/kRVQrQbN8gUoeh7LHqcIOInDTEvcRifpxdDi
X-Google-Smtp-Source: AGHT+IHHpSpAqTFSEKye1QA7LiNnAugghLXBmSGTvNIBTtyiC4wDDkvch3Z8KER4Bxa885oGuqM71g==
X-Received: by 2002:a05:600c:470b:b0:40e:bf78:7b07 with SMTP id v11-20020a05600c470b00b0040ebf787b07mr399394wmo.140.1706036661292;
        Tue, 23 Jan 2024 11:04:21 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906090200b00a2a04c9226asm14599244ejd.194.2024.01.23.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Alex Elder <elder@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH net v2 08/10] net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
Date: Tue, 23 Jan 2024 11:03:29 -0800
Message-Id: <20240123190332.677489-9-leitao@debian.org>
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
Add descriptions to the Freescale PQ MDIO driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 70dd982a5edc..026f7270a54d 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -531,4 +531,5 @@ static struct platform_driver fsl_pq_mdio_driver = {
 
 module_platform_driver(fsl_pq_mdio_driver);
 
+MODULE_DESCRIPTION("Freescale PQ MDIO helpers");
 MODULE_LICENSE("GPL");
-- 
2.39.3



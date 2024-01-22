Return-Path: <linux-kernel+bounces-34009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853198371DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81D91C29D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749A5F54F;
	Mon, 22 Jan 2024 18:46:34 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA35EE60;
	Mon, 22 Jan 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949193; cv=none; b=Pd1B7lPZipXgdDf/hwRmkZ2K/qnqPowW9PJZ9J7Thh3swacJv+DWRA0g8UM9kh0pOlGcygafs9OaOmFndLPV78dE+AD1PBbREe+vfLKelqzaq0FJ/DpIY7fJZu7rrG2l8CAuXnbqdD/aOIINjBcdNNeNGbhAoB5sLOmfIJceSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949193; c=relaxed/simple;
	bh=6kGze13WylCLA856z5adMpns/n4JZrIa0Cl5K3i+HqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJpH/oa28fd8H5scj0ylVXUBs/Tu83PIV5BTMgVmohA3PS3j8j/VNn0lsZPkdE39z8ZtJwAmMpeUDtNwIFt9vGfzPl6gSGbP+/Ykw0XRcmYJfclHA54xDdluHRtWd8bIbdKyIZ1WV4KhtTHQyKevmTxruCdNnqO/cSvotKN7eZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a309222cc62so73219366b.3;
        Mon, 22 Jan 2024 10:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949190; x=1706553990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bCNqD04536JT2N5bRAOPIsKMP7RhSKgGO6zO5cLVI8=;
        b=txPKMcFBxtPmQi6gouzopKtjSXd+8XGaL3Im/nRsgQHpiuH9y8APC+1nSEE0mxZvbK
         x7ePeZQRiw6303wc3my+ezcqJNTXl/MLpU0/DIjaSzwlejC2AjTwPXZylLKpfzIIy47z
         MlmJvZJ9RQODsxnzzHl9uOs18vAxNlXI3egpvcp693DlKHpjnAfdVNbwEWC14Uf6MZ/y
         tK8xWyCPdrQ7Auj/8YW9kE+18pjnYnwv52gx5lrjoD7dsyTxm94MedTZM9mhzl7SuE7s
         LwIPn50Dk8jFxcMMZ9R3N1ukp2wRKwWVG2p7vwtv86STVUuHQypoMvDDUOSCTJ6twDkS
         GbhA==
X-Gm-Message-State: AOJu0YxZ6htfQ1A2hXCmSXLCt5xIr83/1ANoQE+6fjCTVrUJcIRt/235
	sebAMhSy9ol7tV7X7ezR3czNtSyaqLkiu0bz0ScUXVJS+67FSSQT
X-Google-Smtp-Source: AGHT+IHlCobGqfekyRnJURehigVGIivkYDPEAR8rebgrYJ9kYOpZGz1QO2VcnVQ2NCbfKmOs83Plkg==
X-Received: by 2002:a17:906:bf4c:b0:a2e:3a1a:e436 with SMTP id ps12-20020a170906bf4c00b00a2e3a1ae436mr2756362ejb.64.1705949190530;
        Mon, 22 Jan 2024 10:46:30 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id ce2-20020a170906b24200b00a26a0145c5esm13565934ejb.116.2024.01.22.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:30 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 10/22] net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
Date: Mon, 22 Jan 2024 10:45:31 -0800
Message-Id: <20240122184543.2501493-11-leitao@debian.org>
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



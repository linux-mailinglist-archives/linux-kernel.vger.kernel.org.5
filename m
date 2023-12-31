Return-Path: <linux-kernel+bounces-13704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CE820B66
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464061C21379
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBF4698;
	Sun, 31 Dec 2023 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no09Tun9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602963A4;
	Sun, 31 Dec 2023 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55644a67e3fso89877a12.2;
        Sun, 31 Dec 2023 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704025254; x=1704630054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyEBlc5ZSs1I+XcM4fg18hFXs7fYBFAo20uTCN54lOQ=;
        b=no09Tun9Tkgo8pfv03rE/nqqRsEt8KYxW64/RfLIZ+XC/CKZ8daU2y3FnbtSesdWk4
         XjxUhCYihm0zmzhrpeIoR8dY+vfylOFFzR2TfBm0kF1YZ3W+N3tMNbhWq2IJl1wYMEcF
         itMMWoHEye9o1RWj2pu6drCZQZ3Z1ijCnpSrAyqUvsjJvEG9RXQ6D86eOi4o/wqO4Bsk
         ptU6G3SleXCdPXHooUFMzKlpcFMixhVxGmXVYWimN7Fp83WZ87Sgb9tRvIByr7qJfRRK
         Cp8YPTycRWG7IdTnASOW+nhfr3tXG3OeaWKB9OJoTSyQoaL9H8ynDev76+fRg1Cjc4wh
         HRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704025254; x=1704630054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyEBlc5ZSs1I+XcM4fg18hFXs7fYBFAo20uTCN54lOQ=;
        b=wbOLT78w1kOJq0tVY4T6woQpcSuddMOatGKjxkOb7jqVX1CtccCuYJpu1r8F6todLG
         j4K3Sieh6cuIOAk8vq1aV6h5KlSJfU2NaEuC8eG/GbIzStoS4exQAAYe+0Qz5QNPBQi/
         X8QkRqA6jIx8zHP1PvkwgX5rUjsN4p2MmjlQRt7wjCgQQW5Pcx/4R9p988LXXH4qMoBd
         X2TxGhGlXKzAFJ1TjgSZjP85WRvd3bJz6W3wPCLr1Nhmswwjw2ho55C7RFxz+AP/mGAT
         94qdrETvzXropIaz1ZrYhhaDCQxuRLgWRoIeiHMM8AZVvjwDG5cYMc36MAVGzwXWtm45
         V/kA==
X-Gm-Message-State: AOJu0YzFghmGVpiCTmC5KeeBA5eXLt1GWMYZbQ8fkcTFl5Q+QeEMbjlr
	p09JL5cDnVHldmZp69inso8YsOwdZMEGQQ==
X-Google-Smtp-Source: AGHT+IGTRdnO5P/1q9UtcvGDV1MKuRQC7nmSu5QQtVH0zQWAEm5mzxmWH8NoF9St5kLyyHGjhZGVrg==
X-Received: by 2002:a50:f60d:0:b0:555:dc5f:101d with SMTP id c13-20020a50f60d000000b00555dc5f101dmr1102831edn.8.1704025254464;
        Sun, 31 Dec 2023 04:20:54 -0800 (PST)
Received: from mwserver.home (83.22.156.127.ipv4.supernova.orange.pl. [83.22.156.127])
        by smtp.gmail.com with ESMTPSA id n6-20020a05640204c600b00555ec66a440sm2201856edw.59.2023.12.31.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 04:20:54 -0800 (PST)
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>
Subject: [net-next: PATCH] net: mvpp2: initialize port fwnode pointer
Date: Sun, 31 Dec 2023 12:20:19 +0000
Message-Id: <20231231122019.123344-1-marcin.s.wojtas@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the port's device structure also with its fwnode pointer
with a recommended device_set_node() helper routine.

Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1ca273f17d29..820b1fabe297 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6877,7 +6877,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->min_mtu = ETH_MIN_MTU;
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
-	dev->dev.of_node = port_node;
+	device_set_node(&dev->dev, port_fwnode);
 
 	port->pcs_gmac.ops = &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_gmac.neg_mode = true;
-- 
2.34.1



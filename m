Return-Path: <linux-kernel+bounces-34013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CC8372A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBDB273F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015185FBAA;
	Mon, 22 Jan 2024 18:46:43 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3D5F865;
	Mon, 22 Jan 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949202; cv=none; b=nuH4Xq1/Akwq/aEVQyzqFwxiJp95SPWGEGw0ztYu5T3B23KEm8kGkQnhvWG9fUoIOrCNWr5hr0iXCs1cgQRUjOM3gzYPQb33w8Dh7B4S3BBVva2ozUgRAE8Yu5gdfmeZKTbV7J2wooienHG8pn6Fe7jHH3ajoZa7YIoau4RxwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949202; c=relaxed/simple;
	bh=/9CI9wHEmLDbDgASvMUuE/wkTxNfHcgdv2s8qv+Zexo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwFvXg2FTFGD0QtnbDHyGzUAt0OlRIy9x9Ry8C2wQak4EMNo8fTta8HENlL3WP2x484vu2H+d/4ILEAwlZx2IynEa/bwwshyLMMGOE40fNjQiQb2PW+kGtL+3SjVweORe3+nTfO+0SFehyhZom3RfFTxAFAeTmUy5OCbyKWQhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so382882466b.3;
        Mon, 22 Jan 2024 10:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949199; x=1706553999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7/QwiUk6t1FhgO6sq3hoaOGKbEaDobPYywLQZ/4t04=;
        b=U1WlOJx455/EwXa5F/PA2S9CPTVkuW8358d5EvoEk1AiUBnkZNMiQCYodkDcXql2PN
         oq3/xMga1FCrfQuHW0rLB6ZjLCdXEfpxrU6JekYVymIYs4roAdIZw4ceEd+rw2O2sISi
         Q6AZxVfQkmYkQAS3cN9HHWlVHffCxlBVY/67p6h46HNl+0m9+RSzw7AEd+ca2eE8VF/Q
         2rZ9wSQL2oeySCvCWftSkpfmT8R6F/w9TxCTL462IHn64jLMu9K/aOQQ3PtrDpKJbwbv
         lVsdxh0ID7Ttw7MEBnBh1+5n7M9QoQ8b0BMzUMnfGD7VgPPF+lHLHzEASUCImGboAmBZ
         6aDA==
X-Gm-Message-State: AOJu0YwX8A3G7HvD4aoGorL2TXhxoH4q5NVtc2TqYwuqpYUdb8cp8+MJ
	+UBBUrSrV7envlNkbXGbPGI/BplTGwxn1A8xEBYyc7k+uCiPh0tL
X-Google-Smtp-Source: AGHT+IEIluyI6h6wFsHURXFIRPHt6QxMuVHwpKq5pV39a+Pq9Ka+4vBo/RUtHe7Up3c8ao1ELiLl+g==
X-Received: by 2002:a17:907:c789:b0:a30:6015:9c70 with SMTP id tz9-20020a170907c78900b00a3060159c70mr888625ejc.129.1705949199325;
        Mon, 22 Jan 2024 10:46:39 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906130400b00a26f1e3093asm13616364ejb.49.2024.01.22.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:OCELOT ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 14/22] net: fill in MODULE_DESCRIPTION()s for ocelot
Date: Mon, 22 Jan 2024 10:45:35 -0800
Message-Id: <20240122184543.2501493-15-leitao@debian.org>
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
Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mscc/ocelot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 56ccbd4c37fe..12999d9be3af 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
 }
 EXPORT_SYMBOL(ocelot_deinit_port);
 
+MODULE_DESCRIPTION("Ocelot SoCs (VSC7514) helpers");
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.3



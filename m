Return-Path: <linux-kernel+bounces-34005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F378372A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9CB28170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883055D8F6;
	Mon, 22 Jan 2024 18:46:23 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E175D742;
	Mon, 22 Jan 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949183; cv=none; b=TcVYXte4qXC+2BzRiA/8UmP0/Wakh80qcYlh8XioixsnxI7BAPxrq7HPr8I+z8DFzcl6s1vARQSc1F+IZbdbCveJLxzStWdHzMljQNd6OM31vcV17ZGmQ5bImXok2Kqy9kOUqPRLyk7gCM+a9S9CRpiKHLYrhmRUuTpuzY2wG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949183; c=relaxed/simple;
	bh=mUSXXGPgY8FzkMOOClPqzHH3thRlJ2ker48ophTtyRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chnZSLiYbjoaV2/F7RGvL+mH9CXev98jxfLOC/hkA9zy8mouG3fY5Hl1dsyYTnBz98uFKtl4kpEvVZmSTSqwbhlLjUyIdLx8cVb5uUfvqZcr/0obexD/GTBrzdpfo1ggG8t5qFdBVqXlemTeKx/4lMWJPOrBV824O4mmENqCqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso1605664a12.1;
        Mon, 22 Jan 2024 10:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949180; x=1706553980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXBd7/4njBbq+wgt8CKjNpRhE1ABIHxgKJAmYauI2kE=;
        b=Dz3ueYYTQEme/4jg6MafrxkVNRsDDi+lrp846NV0nlZYxw4tQHftO9uvM0jp2FGYFP
         qH70nv/Pp/KwKDn23k7DGE3xDCcu14EzkQJouwqOgtXv3OreT5chvrZtEid/qIC1Zl32
         S+FjAUSYqqan8SHzUO0ww1Q/tCFuObABgvHK3NI1CjQ192Yzl5f5djrCeAVVPw0xFm++
         v/K9UVtPOVIjkSzdo80XNXksIiHInG2OSV51c21bmXxsGUAJTiCG6NfKArvEqGYIl/T5
         rHWNjfLyxneWC1ojNr6A6I5+PZagmgd/c4EVfcOQkeK7Mo1h+XE9lslVYCBt2PoRDcd0
         hGJA==
X-Gm-Message-State: AOJu0YwKnt2wSrqXocZTXtQSe/9CxIr/VwTVibKpHf3hye16pA5PrS3V
	EYh+W0R+1zUfld7rDohszIT3iJ/Lhiyk4Sk8gDHGMiJWfPqmoOdom4hONllMsz98LQ==
X-Google-Smtp-Source: AGHT+IGgLG2F2rncpfZUuRuOG4QDdT1LawaPbpSmB5QVps6sAPMgif0c3ETZ3ioZeqb5jZKpbOgjYg==
X-Received: by 2002:a17:906:dfe7:b0:a2b:a618:7db3 with SMTP id lc7-20020a170906dfe700b00a2ba6187db3mr2038313ejc.72.1705949179885;
        Mon, 22 Jan 2024 10:46:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id ps10-20020a170906bf4a00b00a27a32e6502sm1312130ejb.117.2024.01.22.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:CIRRUS LOGIC EP93XX ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 06/22] net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
Date: Mon, 22 Jan 2024 10:45:27 -0800
Message-Id: <20240122184543.2501493-7-leitao@debian.org>
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
Add descriptions to the Cirrus EP93xx ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 1c2a540db13d..1f495cfd7959 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -868,5 +868,6 @@ static struct platform_driver ep93xx_eth_driver = {
 
 module_platform_driver(ep93xx_eth_driver);
 
+MODULE_DESCRIPTION("Cirrus EP93xx Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ep93xx-eth");
-- 
2.39.3



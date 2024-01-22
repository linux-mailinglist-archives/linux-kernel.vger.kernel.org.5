Return-Path: <linux-kernel+bounces-34006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40418371D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552A41F33778
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3065DF01;
	Mon, 22 Jan 2024 18:46:27 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C35D912;
	Mon, 22 Jan 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949186; cv=none; b=Udbf4sw6GCvZN4ez9bHZAURUmsuPVpYYGkMzdCextlVn7xwsXwcuRECk3il8MOtXO1xi0DgvKVp0xxs1rZN+GXsv7EibnlTX3SDapEX+CQLgJBr1QiPeK8zn/hWa7g7Yt7Ngnl6Oe7OUkTyO8bEn+b9SbLJBn/KqcyLVXV0pW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949186; c=relaxed/simple;
	bh=VbHbxI9NkmA+9Mqpk8tzUxd70Y/xsuQkZk8/7FGLYSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SP2ds3FZuA6T+LKQK4C/gnGHWoK45UGl7W9En3qq8snUSLYEGJoMK9xHk7ZPFiaN2BYaXN9XFvPvAS42pX424N+kQox6MKmAIxT5/BbTgqA+uAd68Y0Ezl4VXgjUBYfO/dqfz4EMLMbPdqz1eDc+ZEBJ3pc0BlxPGQXu78UvpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso3886255a12.0;
        Mon, 22 Jan 2024 10:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949183; x=1706553983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/0M5osMFLAULLGk8LcjCC1Gs2/yU+XJAZrxPG+vQCQ=;
        b=BjJ1H1RTMjOptzfPTcBIP2gFFYhxDugqEMZ2htzlH7wzSpd3RaaWUS2mlnIm3FxSUo
         1HGhiCnOJO0AmvTABm3iWGHISZM2DvBG7kL31YRbbprO65b/P1p2clfWRAgOZsbNw12b
         URyQGIEcBheUaITKq60PIR0AzArmGSRLh6qyM120mMZR05OgclADWIY4DPevoybbT9N1
         /D/i9Na1tlhyYEsiqlZud8/Tb773MxAA368feEiFuJsVL93Xj+Qv/ts5gerNOIn4mRri
         NsorClObwTHzS2Zo/FO7SPf8DqtVaFUKQiSbddQF5dGV7ZF0vS45k+g8yLHjSyTFkTlN
         g34g==
X-Gm-Message-State: AOJu0YyfxkcAk5hg6o6mFpuqH2m0QNRbyG6tlyy+bn3dqtRfTb1qVgVj
	SAUEuKeLkawPcQjM4qs4nJK7DecW4fzFeEgA7oYmKnhpD8IBx9B+HzX4l3qRQgM+Qg==
X-Google-Smtp-Source: AGHT+IEJGESHTQrw0i0sc12iHg9b0ZR8v7qWjj4Cu74CAz6lVYNCKva17nx7Jk2cFASP19b777Lc7g==
X-Received: by 2002:a17:906:b17:b0:a30:4cc6:fc22 with SMTP id u23-20020a1709060b1700b00a304cc6fc22mr1148868ejg.2.1705949183504;
        Mon, 22 Jan 2024 10:46:23 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ti8-20020a170907c20800b00a2da4738882sm10140301ejc.131.2024.01.22.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Wei Fang <wei.fang@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 07/22] net: fill in MODULE_DESCRIPTION()s for nps_enet
Date: Mon, 22 Jan 2024 10:45:28 -0800
Message-Id: <20240122184543.2501493-8-leitao@debian.org>
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
Add descriptions to the EZchip NPS ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/ezchip/nps_enet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 07c2b701b5fa..9ebe751c1df0 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -661,4 +661,5 @@ static struct platform_driver nps_enet_driver = {
 module_platform_driver(nps_enet_driver);
 
 MODULE_AUTHOR("EZchip Semiconductor");
+MODULE_DESCRIPTION("EZchip NPS Ethernet driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3



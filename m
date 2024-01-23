Return-Path: <linux-kernel+bounces-35960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9F839930
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEDFB2C999
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F612BEA3;
	Tue, 23 Jan 2024 19:04:18 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBA86ACD;
	Tue, 23 Jan 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036658; cv=none; b=gmh/ob9IS+8wlCaSLG9ZCMikfVrgokY6fk0OJhaKpvquzg+tIG5B2FTuF0xNnB3K8rnjl55jKRAqZI40quK4EGJ05RTBrhWoX0+Xe3pQMTgUHP3KFoEcMbE1jDtdMm6aAU3fyAlTMotVNk7zsYKjADvYjFhaAS4unOrT+ZkYxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036658; c=relaxed/simple;
	bh=VbHbxI9NkmA+9Mqpk8tzUxd70Y/xsuQkZk8/7FGLYSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HceUCLWX/nmpM/ie3MdByz/efZT9Un+08J82HRQFlMkJQrHXOubwCvUj9pJZcvTJjn73CYr6UC9c+ORNoNq2s3IJANziefBlA0Xu01TXHNTU7jXvZW1zAez25T+1Tu7B4boqAp+F7B1wcTKX9FwDDeYYzgRBZSmmHsDynwPVQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so497063166b.0;
        Tue, 23 Jan 2024 11:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036655; x=1706641455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/0M5osMFLAULLGk8LcjCC1Gs2/yU+XJAZrxPG+vQCQ=;
        b=O8esaI/n56/GyVY315nw6Fcj+Z6KwXW40yhSoB+t6KpmQtD3+X7C14mBHUKtMaCzE0
         BONwCf66mF5nBOw2+VngHUYPf/oFRR7C8MQkGYf6RbceaHPQCxP8JqoizYPxUmyfiZhH
         yZozP73iwzNflsqie+3a1sHJmGUc07EC98SXKMMXeHI0FY7xeg8YbN7j2Mq+ISrqGEZb
         MP1chqJS7CGh7ra82ShIoaNaRyHZKM+5WaHAVE+NQaBmkFMSvRYmPTijTm++RMqMuGTK
         wT2WzdvsusU3JHb/9+VHRSv+LkNEfkR7rr7jWL1iEhpBKle9vC2D5lkKCXh+eX4Hk5Gx
         SVFA==
X-Gm-Message-State: AOJu0Yx9PjQ2vqwWSCo09QbKVs+cR7C98qkvv1Fjufgx4JaeXu7aMJf9
	34bE5G+/tAYD8HFuGTUJHiZXG4+Pe5R8Fu3gl9nXw25zMc76dP6a
X-Google-Smtp-Source: AGHT+IHM8TWHfr6yJ2InsDqfP19fzPjvCNrZVf8D5WLoX8RQybHuMywoL0/vXIGedEvl8d9NhUxxbg==
X-Received: by 2002:a17:907:c709:b0:a31:953:5869 with SMTP id ty9-20020a170907c70900b00a3109535869mr58886ejc.53.1706036654559;
        Tue, 23 Jan 2024 11:04:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id t10-20020a170906178a00b00a28ba0c3821sm14600766eje.101.2024.01.23.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH net v2 05/10] net: fill in MODULE_DESCRIPTION()s for nps_enet
Date: Tue, 23 Jan 2024 11:03:26 -0800
Message-Id: <20240123190332.677489-6-leitao@debian.org>
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



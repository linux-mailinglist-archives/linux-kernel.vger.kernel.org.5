Return-Path: <linux-kernel+bounces-34008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4208372A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13CDB28CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9655EE8A;
	Mon, 22 Jan 2024 18:46:30 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98B5EE60;
	Mon, 22 Jan 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949190; cv=none; b=kEhTHARXd3fAVa6HivfQKvbzJM+jq/bP0f+K2VRM7QbeyL9/Y0P1ApzVoDcXy82uPCR7iloiqG0c4bJ+ea3heczIG/V3mg/D4KVvX9WEHxZiuR/69E5PrVwYap8dcCn36izhyP9mKyK5sSwkUivmFe7NrHsrcfkpb3fPgyQxL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949190; c=relaxed/simple;
	bh=jgE/JgtP5k2GZgFLX74apgh7U2QJa6KvrEqibHCKJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmSUNtJYIEkJkLFVzBosJTlL5BjBj359B/rlNJiVCIbnebOWf7v8JScZAIsC5FN8XkhfmGTli4SqZWI1Kf+o0Vv3HgOo7/dZFbHqClPWqObekzsJTSg56qCWh6qk1fb0VB/5VczCZOlf15AhK6xkiozvbX/jYWuFID9m2BmyOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3082d450adso103732466b.1;
        Mon, 22 Jan 2024 10:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949187; x=1706553987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tfPttcJyhs+49y5iOcvG0Je/QnYl9UimA/550wkw0E=;
        b=DJL0kJM6Zgw//2fTkLgr3qmmHddhIuloB+rLYujpSr3t3sJjfliAxwwum07UN0Kt1I
         pbBMsKwlvm5gmPFGP9U9bb8FnMB6FSEkT5U806lWuFqR4UBflxEdm35wKUlyoCunE3ah
         0RGTJFlaSrGdNPFolCFwubVSlz54QAXd6c24jJ6Le1C2yqFGxUjci21qzLPUyBqgpzWe
         MCQlhIMaH6Mq7v/RjuBJSbIPOq0KXe6HTOU6APx1btD2h47a4brTvqdoBFIbsaZpVJSt
         bSyoQU9Qn8Cx++WgqhoxmUylskQ9sFXwHf2726crsmZMQl41595K8KIpvulKGykTWZ2V
         Jgig==
X-Gm-Message-State: AOJu0Yx/fj2VCOsL67hcrlQmVbi1pqGrPul45rKUQifM5RAnKhJoJdzI
	Z+vl+7webMF5ZmDaDixgJS1ba9xwYnw39yY3xrbKJKFDGqXBG8/e
X-Google-Smtp-Source: AGHT+IFJkwUt87e3cWB/JKL40gySAvfC+UzbvKTahRXhyQGYwJttjSNmih1Iq71TpzC8oCHibYfUvQ==
X-Received: by 2002:a17:907:a588:b0:a30:3b06:571a with SMTP id vs8-20020a170907a58800b00a303b06571amr1355269ejc.101.1705949186942;
        Mon, 22 Jan 2024 10:46:26 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709062a4d00b00a290920c78csm13620735eje.187.2024.01.22.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:FREESCALE IMX / MXC FEC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 09/22] net: fill in MODULE_DESCRIPTION()s for fec
Date: Mon, 22 Jan 2024 10:45:30 -0800
Message-Id: <20240122184543.2501493-10-leitao@debian.org>
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
Add descriptions to the FEC (MPC8xx) Ethernet controller.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d42594f32275..c56807b757dc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4769,4 +4769,5 @@ static struct platform_driver fec_driver = {
 
 module_platform_driver(fec_driver);
 
+MODULE_DESCRIPTION("Fast Ethernet Controller (FEC) MPC8xx Ethernet driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3



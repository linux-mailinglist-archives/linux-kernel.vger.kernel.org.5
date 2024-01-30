Return-Path: <linux-kernel+bounces-44413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F148421C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C1D29351F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88E6A01F;
	Tue, 30 Jan 2024 10:44:00 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6467E72;
	Tue, 30 Jan 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611440; cv=none; b=IZN6AWlfK+rxNYrPhiZr+PQtxENPFwGJSc7E8RbWKSaCF3oj0RmHaGAQ/fZ8SvRsuaElAJXqeV7hAkm0DsqBo3zb857XyITIF4/B2+WRTkDRuFGaTkb+Ez+OQUjfNRccXJnXbwJ8kEOFEJ3AoRUYDMi45KShKj9Y6Fmgg+Eo+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611440; c=relaxed/simple;
	bh=QDnvM4oA4H854uqga3nFwXcmRbbdDA1nmmcnqXKuWBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dA1123ekYOhXy2ryx6gsxAw6NceZZws/TZDCmdCHqIyYjS2T53zPJae+I3ZkAikmFek3+yPMKi7K2citIYvxHrog3gxPxt3cchAbOl5ehVWQAkjZ+RHSgdWgajqOZxj94DnitcSiGIg0N8vYGcraFrgGg0aGk14gi7rMQacjFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3510d79ae9so409378066b.0;
        Tue, 30 Jan 2024 02:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611437; x=1707216237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1yUomGVGxW+ZJ/xuPk5u23oKYZV6/4kQ1dwGrkBW8Y=;
        b=NNXovl/mfwBRKIGDanxQYtmgPfiiWNUhtfhRb0EFiGoEJepIeGnjYE3C9Cxu41JDB4
         2ranWDzktoKjGyKgJ5elvsuMfgkzpTEm9/PXAF4fGGtMkdDHJzrUazYHmRt4vZoqCgpw
         Xl22oP24oIQRzlcVhL8NNwWCVMI9Q3Yk6bzr51e1318KExRJk73oOTm2z414n/B622PF
         IV5pDNKdNSuRz0BYb89JOCsa62KRKdHqiei4kqs5jLGuL/yY6R9iqsMcQrrOOZnaVDdo
         Qmy5Ba4IDZd5aEITq9WYjsNw2yMX3aja+UXYDne/i5DJk/zgTJQq8Jv8DEDjTlhn7aIt
         aa1A==
X-Gm-Message-State: AOJu0Yz5BV+Kv5bNMr16YMu53NFoY7zMj4uh5ZLKgWdjnnuNhyh1R7l0
	Kr1YubJL3XGEfHDlA8BZY4hVrOH11vVf5mYMLlA+UgVKNel7nHZv
X-Google-Smtp-Source: AGHT+IFPAznZ9OF+Rpfm2bv4z2kmctthlYlYZURZnZenl4Z93ahd7bGLWBtKdZBCk/AwhfUSfOzPlg==
X-Received: by 2002:a17:906:2b0c:b0:a36:393d:6caf with SMTP id a12-20020a1709062b0c00b00a36393d6cafmr394051ejg.48.1706611436772;
        Tue, 30 Jan 2024 02:43:56 -0800 (PST)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id rs10-20020a170907036a00b00a316a652c6csm4962734ejb.70.2024.01.30.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Loic Poulain <loic.poulain@linaro.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	wcn36xx@lists.infradead.org (open list:QUALCOMM WCN36XX WIRELESS DRIVER),
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
Subject: [PATCH net 5/9] wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
Date: Tue, 30 Jan 2024 02:42:39 -0800
Message-Id: <20240130104243.3025393-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130104243.3025393-1-leitao@debian.org>
References: <20240130104243.3025393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Qualcomm Atheros WCN3660/3680 wireless driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 41119fb177e3..4e6b4df8562f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1685,6 +1685,7 @@ static struct platform_driver wcn36xx_driver = {
 
 module_platform_driver(wcn36xx_driver);
 
+MODULE_DESCRIPTION("Qualcomm Atheros WCN3660/3680 wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Eugene Krasnikov k.eugene.e@gmail.com");
 MODULE_FIRMWARE(WLAN_NV_FILE);
-- 
2.39.3



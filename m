Return-Path: <linux-kernel+bounces-10200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D581D126
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639021F26695
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2C24A06;
	Sat, 23 Dec 2023 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="OCNN5ZkF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319F18B1E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d3846fac9so9794985ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296800; x=1703901600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nh726kqqk/+4viMnId5Yr1Sl4uR2fT43T5z2Hat3BI=;
        b=OCNN5ZkFyCJrSfoZNlJkTbl2DIT/NguaC1PPldnaGa6Oe/4IzyNdboncL1QXJQpBbJ
         3I9/w6NYmfCb2Hx18Kg5V8724M0qTITVxsgr442KjPnyh+zCwYYkYaZPI6SKrUO516Mc
         zBDRUYhcISRQrbFRSb1qnMI4/YHMg1o36VylD7R26+xZVAgc1HeRn1Mp3a/v5vyZapEK
         cvYx5iwlXt/c/nPiRnv5W+TUJze9OUFEE7CjGFAOC3sRVlsLNFTg0cWOacJ97gH1mMxq
         U6nR9S/rCZgwtik61o6Ye4txZiZxiu3AdakgJbZw79WiVXso1IPyMgOCjONwMWHh6RW4
         yOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296800; x=1703901600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nh726kqqk/+4viMnId5Yr1Sl4uR2fT43T5z2Hat3BI=;
        b=afjNCLKYN+VDqd+gDeUpT0hFQlRKAVPkjkPGzXWNGau8dDUncErY9/uivGeN2RCZ9i
         ++nzXxMOzqdkYX+x8pyW6ExyneS2lPFhQQDTwJal64VqkFKqZdh9cwT/yFqXYrLOO3zK
         GMto7LXKxogHc3pMFPICiNIjd9RwZQJYvpVvD6jX9Wbf/v8/v+J9DPigcDOPuaOxKcYR
         fMUtJcACq/k9Gcopr9bFT10YWJ+IBFJZ572cCGV6k82nlnLm2qvlSqEQn0kWXNITC1OI
         KXnatHvQY26zVC4uMhLgWENcobObDTHMDB6GSwnMxyS+B/XWD+7H+Ylf/j+wCZAzzyDk
         5aOg==
X-Gm-Message-State: AOJu0YzoQa0COnMMMXSaTUXfNUF1e5eqQDHEU66usoRw0G6qT+eLAgea
	v7Ej0taZdSfYHDzhJ58wHuic2K2zN7L16A==
X-Google-Smtp-Source: AGHT+IH1Lf96TMxxv/JghBnKSlz5rYHxiy9840iB+KFWHTNiPyDxcXt/Ja2XjzEotB5Z9olYGQatSg==
X-Received: by 2002:a05:6e02:15c2:b0:35d:59a2:6909 with SMTP id q2-20020a056e0215c200b0035d59a26909mr3217443ilu.54.1703296800539;
        Fri, 22 Dec 2023 18:00:00 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:59 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/20] Staging: rtl8192e: Rename variable BasicRate
Date: Fri, 22 Dec 2023 17:59:39 -0800
Message-Id: <20231223015942.418263-18-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable BasicRate to basic_rate to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1e025ef4bed6..3f7d2954ebd7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -142,23 +142,23 @@ u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 {
 	u16	i;
 	u8	query_rate = 0;
-	u8	BasicRate;
+	u8	basic_rate;
 
 	for (i = 0; i < ieee->current_network.rates_len; i++) {
-		BasicRate = ieee->current_network.rates[i] & 0x7F;
-		if (!rtllib_is_cck_rate(BasicRate)) {
+		basic_rate = ieee->current_network.rates[i] & 0x7F;
+		if (!rtllib_is_cck_rate(basic_rate)) {
 			if (query_rate == 0) {
-				query_rate = BasicRate;
+				query_rate = basic_rate;
 			} else {
-				if (BasicRate < query_rate)
-					query_rate = BasicRate;
+				if (basic_rate < query_rate)
+					query_rate = basic_rate;
 			}
 		}
 	}
 
 	if (query_rate == 0) {
 		query_rate = 12;
-		netdev_info(ieee->dev, "No BasicRate found!!\n");
+		netdev_info(ieee->dev, "No basic_rate found!!\n");
 	}
 	return query_rate;
 }
-- 
2.39.2



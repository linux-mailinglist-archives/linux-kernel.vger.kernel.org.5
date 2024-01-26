Return-Path: <linux-kernel+bounces-40768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD483E57C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E308F2821DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3357301;
	Fri, 26 Jan 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="HU3B3cn9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6D51C32
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308307; cv=none; b=fLDHWetrzME9EXL5jm1IGRo/HB0vt4Ala+wllzj0l52O7hkRYziEYFVIJ2k3vrcYa3NZYuVv7XqQkYkQrKD8t/nSOJ5L+tbe4a/sD3g7ljDkZuwvS0XoGoBs6oMbUbibVdGseazwkz4fOttJknmNYo4rfv7Yvc3ca2qiAevymvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308307; c=relaxed/simple;
	bh=XYHmNCHS2lZ0tCizaQyAD8HMmTWaEZnNSfa3xJDCaEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKFKMR0uqOL+TGknOu1FlxunzCcx7TirzdrM2z4CexSbgdg7SD182XEqC6WX1s8taJr/oMP79N8lJtRfJq/Uk/1VRjmQHMfHGM3l5BJvp0TpklzaovD7xDxriUWeGQZpf0WMExb0RVUBWNm/kGOoag14amCVKrBXKyHX5McC3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=HU3B3cn9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71c844811so6438155ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308305; x=1706913105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcxJDHEfCk1y2I/MmdCghduQrzDXHBl54C/3QCx3wdg=;
        b=HU3B3cn9Lx75VNe+3cRuTLQ0YJebXO706RKPgKaOR2BTNMMemvWx2V54Vhiu1OWeIR
         jFzqHOczTjLyO7MW87R4xFoiuvLtsi1b/8qm4+GvfCOqmvbM5m4EBec4PmtBBYcsZO8d
         ugdRO3CxNZPsxSimAy8aQQSkO4rwpJwvSabg4HG0qPN9CVNbDUSi1xLXAJW1aY77VF4d
         nnPo2lqJWBtqqYDQsADBQ1meIafxXMppvchZzBjd9QozThxmNd2OrL98sMAPUrk9GrTY
         CpMr/CGWj/+ykeabKl8G6/6KQqryqVUGZtvF0HP2796JvB64ZKDmgERjOKGIKhyVzPh0
         4pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308305; x=1706913105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcxJDHEfCk1y2I/MmdCghduQrzDXHBl54C/3QCx3wdg=;
        b=uD7ET+4eDudyPnu+F1tVX+8MNHYsAuAGJO/9P5eKw1icnXEU5xSyZFW8jOCSzY3KLc
         Y1/31lzA8N7f//HqYrBnszNU0qSG1A0U/xZOqYfYA5Zywa6yLTQBnTmo1yFKQt2AU3u2
         Bcr8TAcjDq93SyPiIgdQiMFivu3ZctIBdChnYksNg8NT2KYuayZglGeWlPlpPOSEwEfo
         L8a+TaKlY7d7MxCqUr3JK387VufVz/qPjKyTWUmVxcII1PVQvWElVjpfNLrHi1GtQJqR
         OBlu70Q20WbwBd9aUO6rdULYtMfO64WFuZnAz8wP1krd0gEITYBo+CyJV1REBP7pQzzz
         8dNw==
X-Gm-Message-State: AOJu0YzedTviDIuSLqmHDAJLvS3/tmO1T6iDB6dpQDM3UVJskc798z4D
	EveivlGJdBAbjHNbzojEvHKH9MBeA8MROBB2zHJZp4SqhXGD5ZJZcoYrtD+tPI8=
X-Google-Smtp-Source: AGHT+IH6bhRe2mX8pIcrYjZUu9d0qjWd7b7lw7LkbzaXLVnrDcMy7TynOC28MTNFfmky4kcdJS78hQ==
X-Received: by 2002:a17:902:e5c6:b0:1d6:fdf4:a97d with SMTP id u6-20020a170902e5c600b001d6fdf4a97dmr477678plf.50.1706308304877;
        Fri, 26 Jan 2024 14:31:44 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:44 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 09/18] Staging: rtl8192e: Rename variable LPSAwakeIntvl
Date: Fri, 26 Jan 2024 14:30:57 -0800
Message-Id: <20240126223106.986093-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable LPSAwakeIntvl to lps_awake_intvl to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Changes.
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 26 +++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c380d1c3e9b6..8de46b61416b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1072,7 +1072,7 @@ struct rt_pwr_save_ctrl {
 
 	bool				bLeisurePs;
 	u8				LpsIdleCount;
-	u8				LPSAwakeIntvl;
+	u8				lps_awake_intvl;
 
 	u32				CurPsLevel;
 };
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9ee6364f7b00..545f79387991 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1379,15 +1379,15 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 	if (time) {
 		if (ieee->awake_pkt_sent) {
-			psc->LPSAwakeIntvl = 1;
+			psc->lps_awake_intvl = 1;
 		} else {
 			u8 max_period = 5;
 
-			if (psc->LPSAwakeIntvl == 0)
-				psc->LPSAwakeIntvl = 1;
-			psc->LPSAwakeIntvl = (psc->LPSAwakeIntvl >=
+			if (psc->lps_awake_intvl == 0)
+				psc->lps_awake_intvl = 1;
+			psc->lps_awake_intvl = (psc->lps_awake_intvl >=
 					       max_period) ? max_period :
-					       (psc->LPSAwakeIntvl + 1);
+					       (psc->lps_awake_intvl + 1);
 		}
 		{
 			u8 lps_awake_intvl_tmp = 0;
@@ -1395,23 +1395,23 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 			u8 count = ieee->current_network.tim.tim_count;
 
 			if (count == 0) {
-				if (psc->LPSAwakeIntvl > period)
+				if (psc->lps_awake_intvl > period)
 					lps_awake_intvl_tmp = period +
-						 (psc->LPSAwakeIntvl -
+						 (psc->lps_awake_intvl -
 						 period) -
-						 ((psc->LPSAwakeIntvl - period) %
+						 ((psc->lps_awake_intvl - period) %
 						 period);
 				else
-					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->lps_awake_intvl;
 
 			} else {
-				if (psc->LPSAwakeIntvl >
+				if (psc->lps_awake_intvl >
 				    ieee->current_network.tim.tim_count)
 					lps_awake_intvl_tmp = count +
-					(psc->LPSAwakeIntvl - count) -
-					((psc->LPSAwakeIntvl - count) % period);
+					(psc->lps_awake_intvl - count) -
+					((psc->lps_awake_intvl - count) % period);
 				else
-					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->lps_awake_intvl;
 			}
 
 		*time = ieee->current_network.last_dtim_sta_time
-- 
2.39.2



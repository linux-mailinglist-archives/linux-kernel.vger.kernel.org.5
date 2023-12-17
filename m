Return-Path: <linux-kernel+bounces-2882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4EC816398
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15713282ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525E4CB4F;
	Sun, 17 Dec 2023 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dqsqn104"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320A4B5A1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-591487a1941so2005775eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857327; x=1703462127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQyqLl2j3iLvLgdglWKcDF464BuHW+ufozKe2II4NWc=;
        b=dqsqn104P1z9YybVvsH/FXBBTYq2TR5kbgKoXsemv4QCYCfkBnUR/0HTU/Z4sElVTD
         RIyW/WzriGjIiqDgPvcKPgI/aQpIo8UvEBf8WFIaDv1jBqrh1DeLaqagWI7XK3eIcdvp
         dQBzA2zvGmdaN4X0ckkHqzPLdQTJVZIjTd/PSicrQ5ear1gRLjvOmtH57mq2RbkIvOld
         kPgqxoXlayla/cAkK8GdfL5Lbnd/mGzsz1IhiipqhDhesDL2RuJPB+UMlFD8SU+wgbSK
         cPk0zMsxytTp2HM5Oou11j8cy4ALZF5MxH2/syGdBPjnQfUwwvkcnck3mfDCjYGxV2dM
         2SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857327; x=1703462127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQyqLl2j3iLvLgdglWKcDF464BuHW+ufozKe2II4NWc=;
        b=mZqf2y//67uN8rE1IsqrtMiqpdXr1y4/jhM+IVgfeI701e+1jWLm6FiDMh631SbEgQ
         5yW0dXCVtqZgXxZyOH5QGNwHXkPhy4EV0YPIw91o/2RAfqATM5iY0XlMtE5QejZSz5ky
         fkFNsazjZnDI0qs+e8ie4UeZblas7hK6ufGVGEe3xuBiJb5aeNtY/kMeJ2Q5q7fohxCg
         z0NZRQUM5oEtVKqcNSksSdbNvjBEesjxeY5+hy+MMc0uAGm3HZfhjcrRDSOdaPyFhXrV
         5ajBQiLOzjULUn4omB/hmMVwNobpJrGY3OCTARPl3dwPH2/K1B2hX955ZhQNHkPJEk9+
         2Y3A==
X-Gm-Message-State: AOJu0Yy7vyc0iNBdLW6/ovdbb+e7LZEChn/yJZzKWhV4rVHTVXd1F4RA
	8nDXX1C/2lNn0HqnHFGrHQATJQ==
X-Google-Smtp-Source: AGHT+IH1/iDKHIOawiUcbaHza/A6Vm6/Ocp+IYfmYobaksQrUQHzUGiA5K0lhGSEfy1ZtFqAsZyMXw==
X-Received: by 2002:a05:6358:419d:b0:170:4168:8b91 with SMTP id w29-20020a056358419d00b0017041688b91mr17715132rwc.24.1702857327426;
        Sun, 17 Dec 2023 15:55:27 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:26 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/6] Staging: rtl8192e: Rename variable pDelBaParamSet
Date: Sun, 17 Dec 2023 15:55:18 -0800
Message-Id: <20231217235520.30377-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217235520.30377-1-tdavies@darkphysics.net>
References: <20231217235520.30377-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pDelBaParamSet to del_ba_param_set to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index fd0149d3f717..2fd54312c04f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -402,7 +402,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *delba = NULL;
-	union delba_param_set *pDelBaParamSet = NULL;
+	union delba_param_set *del_ba_param_set = NULL;
 	u8 *dst = NULL;
 
 	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 6) {
@@ -427,17 +427,17 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 #endif
 	delba = (struct ieee80211_hdr_3addr *)skb->data;
 	dst = (u8 *)(&delba->addr2[0]);
-	pDelBaParamSet = (union delba_param_set *)&delba->seq_ctrl + 2;
+	del_ba_param_set = (union delba_param_set *)&delba->seq_ctrl + 2;
 
-	if (pDelBaParamSet->field.initiator == 1) {
+	if (del_ba_param_set->field.initiator == 1) {
 		struct rx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
+			   (u8)del_ba_param_set->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
 				    __func__, dst,
-				    (u8)pDelBaParamSet->field.tid);
+				    (u8)del_ba_param_set->field.tid);
 			return -1;
 		}
 
@@ -446,7 +446,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct tx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
+			   (u8)del_ba_param_set->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
-- 
2.39.2



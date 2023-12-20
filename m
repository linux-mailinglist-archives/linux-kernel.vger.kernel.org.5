Return-Path: <linux-kernel+bounces-7047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F081A0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299261F21E90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17E38F93;
	Wed, 20 Dec 2023 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvPST8UF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4B38DDD;
	Wed, 20 Dec 2023 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367a304091so739074f8f.3;
        Wed, 20 Dec 2023 06:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703081913; x=1703686713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtboqIOajZ+9kRzpEuYvtN45b5wd0evNFunITw7khVI=;
        b=kvPST8UFr0/7w/lyjF61+teanbCnJhBRWVCdAwxh3v/Sm0eHr0f8b5uO+bUrqpTT8z
         zmGMWV5xOo+dZ1CrJ8y1s72tFSAJGaryEW3Gy7jPdgESiX9eeaVdXnAJmlVdpYv4W/fa
         ket62nCJ3wr1fpRUsctfkiAfmMQOUojvsvyZ/nT4YUB3wWa63VbrYuV/fFSIfG/xY6hf
         xPRWDarR/HZzNHubv8SbFkLei5PODmGR56ib128zb8WCbM9Papi+6lu2mRjaSv3/yQZt
         b0fswzmYIVN90ILKBIHAqJEzircBVrFvsL49LgjyLj2NGTJIyOwgsPEF7YtN9HENa4tO
         W0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081913; x=1703686713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtboqIOajZ+9kRzpEuYvtN45b5wd0evNFunITw7khVI=;
        b=GuPVqLe8M4u3pKbyM4BwLZvZ05p8HVejppUTnhT2Zvu+nAtpZgBaR3Epw7FxZElzdj
         hIcOcOtDVw+YVJjpBDye3p5bXxFDRBNvnNA9UmTK8UDYt2ZGcxab+yxa+Oq/dMp41r4g
         gYusePCI/L1ua+bDC37cz8DYK95YcH3R9adu/839d4UogYaMCycp3c3/Utls0Q6PxEGj
         opbt6WDcBcyMt4lrAB27otNpeDZt6w8oLxAgQM8tusYfkwbPDCGYHazobTDczJA0cMxI
         csqzUHyGI1iWMMYttjqafRzCQzDekSsmHoKhrKoElbTmd2o0PsPsEiFeCOIAhsSXSTjV
         v8fg==
X-Gm-Message-State: AOJu0YyKadpb9bcnOxWorIY2WYpBB4gRAAgFNwbwod+5esuwHnP4Ucqh
	x+voGo/zL+DibCamxDaiGRM=
X-Google-Smtp-Source: AGHT+IEdWbD6d9z5TZVQdQB/EtJYkGf8Koa4xBUah2AE+redPoWpaaBIVcCqUqvlX3O6qFbmdBWG4Q==
X-Received: by 2002:a05:600c:4e4b:b0:40d:35a6:af23 with SMTP id e11-20020a05600c4e4b00b0040d35a6af23mr358445wmq.26.1703081913140;
        Wed, 20 Dec 2023 06:18:33 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040c31bb66dcsm7466687wmq.20.2023.12.20.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:18:32 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"
Date: Wed, 20 Dec 2023 14:18:31 +0000
Message-Id: <20231220141831.10063-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in rtw89_err error messages. Fix these
and also add space between [ERR] and message text.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index be30c9346293..4befbe06cd15 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1616,7 +1616,7 @@ static int dbcc_enable_be(struct rtw89_dev *rtwdev, bool enable)
 		if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags)) {
 			ret = rtw89_fw_h2c_notify_dbcc(rtwdev, true);
 			if (ret) {
-				rtw89_err(rtwdev, "%s:[ERR]notfify dbcc1 fail %d\n",
+				rtw89_err(rtwdev, "%s:[ERR] notify dbcc1 fail %d\n",
 					  __func__, ret);
 				return ret;
 			}
@@ -1625,7 +1625,7 @@ static int dbcc_enable_be(struct rtw89_dev *rtwdev, bool enable)
 		if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags)) {
 			ret = rtw89_fw_h2c_notify_dbcc(rtwdev, false);
 			if (ret) {
-				rtw89_err(rtwdev, "%s:[ERR]notfify dbcc1 fail %d\n",
+				rtw89_err(rtwdev, "%s:[ERR] notify dbcc1 fail %d\n",
 					  __func__, ret);
 				return ret;
 			}
-- 
2.39.2



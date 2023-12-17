Return-Path: <linux-kernel+bounces-2881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D10816397
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E1F28287A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EE4C3BF;
	Sun, 17 Dec 2023 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NxK/XjPv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6624B13E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so1575795a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857326; x=1703462126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcmVbJydKEcWtYX1J4gYneDAG9W0JB3UC1M7ZuIvgfA=;
        b=NxK/XjPvWKohdqojctlmYy7e0VsuGNvlpy6DKPlTLmKA8VJAoArRbMJQcnqxUon/BP
         CJN9ikgha0lQAURv9ZF5Vi7r0bPPxwK4JwovUPOGrly/AiGCBqodp7WHoEcAhNfJj7LL
         Q0d2/jhEx4bsaJR4HBuefvzHVPLA3I8QE1Cur/Tii+LqKYVTheEa60ZUhu9xMwSA21Ct
         WqCNXetc6+E5objqLiFjZgKtIQtVZ2QugG/h2XL+2eS4eQ51m4tCgWs3sfGftaUWasA2
         YiMEt44MKHZZBOV/0yfmFJGN7PaY3uiRrMcnYeuEGFdkUE1Ao9LivHEzJKFttwA5RoSx
         8uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857326; x=1703462126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcmVbJydKEcWtYX1J4gYneDAG9W0JB3UC1M7ZuIvgfA=;
        b=JDErcqynVjYWLsUuShyM/6hX0FgAoiyM61QjUrEvqlVbRH84LPj8+3T6U24pNAAhrV
         hb909lRlqlZTtP/o//vbhT3Zxv9MgK+uek9z/0rC7pOaqgcXUfihcXAFnqp5JaPMXUMj
         mLSSHBIerNb6ONuf85J7B+Ovx7HatGql7JvwUI8hEGkqzAYs39mb8DFkFtats+vkerFw
         +5BW8GvzyxuJCNVVm7qi8bbnBtrLZ+C0rjK2qNlnsE/h5yXMRIjvCHTjIHcxu0oO6gkg
         Cqnz1pA3XLbNNm8p0bnLTIkV3/ksxUSfvdcX3T1QjyMV3WOgPyE1RSdvLKH0UHz3aVSW
         RTGw==
X-Gm-Message-State: AOJu0YyDoQkMUEPgcxniguysorO2ZgYMLjVhby3naKIRnpHektsfx0iv
	88plFxqKt3IAG/Yg0hGEbVHlUg==
X-Google-Smtp-Source: AGHT+IGzG4RbwFRuq9imJKDCMJ+xVKs77Du/FtG5Jl2kjnXKqAUalU71OA38gz2W8J5ijf7XBOmkcQ==
X-Received: by 2002:a17:903:2b10:b0:1d3:4d31:6e3a with SMTP id mc16-20020a1709032b1000b001d34d316e3amr11271032plb.47.1702857326256;
        Sun, 17 Dec 2023 15:55:26 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:25 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/6] Staging: rtl8192e: Rename variable ucTSID
Date: Sun, 17 Dec 2023 15:55:17 -0800
Message-Id: <20231217235520.30377-4-tdavies@darkphysics.net>
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

Rename variable ucTSID to ts_id to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h    | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index cdbda65b4d50..fd0149d3f717 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -474,7 +474,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = ts->ts_common_info.tspec.ucTSID;
+	ba->ba_param_set.field.tid = ts->ts_common_info.tspec.ts_id;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
 	ba->ba_start_seq_ctrl.field.seq_num = (ts->tx_cur_seq + 3) % 4096;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 1c00092ea3a5..50e01ca49a4c 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -8,7 +8,7 @@
 #define __INC_QOS_TYPE_H
 
 struct qos_tsinfo {
-	u8		ucTSID:4;
+	u8		ts_id:4;
 	u8		ucDirection:2;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 489261831462..ad4d9e4c9b63 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -198,7 +198,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, List) {
 			if (memcmp(pRet->addr, addr, 6) == 0 &&
-			    pRet->tspec.ucTSID == TID &&
+			    pRet->tspec.ts_id == TID &&
 			    pRet->tspec.ucDirection == dir)
 				break;
 		}
@@ -305,7 +305,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		netdev_dbg(ieee->dev,
 			   "to init current TS, UP:%d, Dir:%d, addr: %pM ppTs=%p\n",
 			   UP, Dir, addr, *ppTS);
-		ts_info->ucTSID = UP;
+		ts_info->ts_id = UP;
 		ts_info->ucDirection = Dir;
 
 		MakeTSEntry(*ppTS, addr, &tspec);
-- 
2.39.2



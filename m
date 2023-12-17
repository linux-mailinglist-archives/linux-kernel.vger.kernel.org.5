Return-Path: <linux-kernel+bounces-2880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AAE816396
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D28F282AB4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762624B5AB;
	Sun, 17 Dec 2023 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DNKSzqLF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E324B12C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so2251670b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857324; x=1703462124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4USW94FsBNR0aa35+yh754CY1XmSRlXZWhpF6abWQqM=;
        b=DNKSzqLFS5K3lEd1XmSMDQ/L7snTghOKEhC4nYHASkbgRIiusAMYM+PmqaSiyjJVj+
         yRRBzCQqhYAJVp3dLHVTuurp7QHbC+/zKXlf+KqKqbFfwDj7Y4JdZelmXBfrT8EwTaey
         9WjpcSx83674TQIiXLWnvcOfttkaRISRTWkg+9xNqvI6fwwkKjoqbqAkruDH3mgiRsVK
         3vGEKShjjb/5VDec3IwW+bir1t+Cr+EEgGmurkdPkqCMsbfEjCZbZUlb0i5mUnFUMFu5
         CmsikAilhBEghxw95/yD7aMdbt+IHnRIw3hRhffJWSx48NukMPl54jGc2GtgG4qhlYgh
         P1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857324; x=1703462124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4USW94FsBNR0aa35+yh754CY1XmSRlXZWhpF6abWQqM=;
        b=ar9ixZQ/cKuM1VnFEKyrSpmRF7sfW0C/tqgjVZbHTuSkDEe69eDw7fHBXdLj45MkDG
         6c9jg31+J6sGq3yXQIgmuNo7cmlsEvbGnuudDjRKGYc/FAU92H8U+vWxgFyXHvmsSmh4
         1cBzsFfA0aXmWQY+aknY3kdSRNB6VGofnYIiuOdFjpzPd7SBTBn6jfZg/96d4tfksnnH
         aCJ28yoLlC44gK46YVZq2TE7pHS0bW3EPX+VfCO8upLvRNLEmMf65OUw7k8rT+UguVy0
         GhhgEWpA/YmtTncw11SPsrGNCfVnWYfvLAEEJTwBVsKJzvR63QM6lDNbbQq3QJZPL60B
         74dQ==
X-Gm-Message-State: AOJu0Yx5wt8WxLEA7gnAGU9Y97N1zGJgYKhJ7AD0hH1aK/vk29kLuy6U
	VjS7t+MOVQiywDajNYRDzuuvAmm6EMjaNOqCDgA=
X-Google-Smtp-Source: AGHT+IEq6+2qC+LXZozEgV7/eE1Qoo5CR9gBTOR3o3osYSJHZsA6YTyHiVR8IhIMoitOAq7YIcB2+g==
X-Received: by 2002:aca:1109:0:b0:3b8:b063:506e with SMTP id 9-20020aca1109000000b003b8b063506emr16336643oir.111.1702857324005;
        Sun, 17 Dec 2023 15:55:24 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:23 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/6] Staging: rtl8192e: Rename array variable RxTsRecord
Date: Sun, 17 Dec 2023 15:55:15 -0800
Message-Id: <20231217235520.30377-2-tdavies@darkphysics.net>
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

Rename array variable RxTsRecord to rx_ts_records to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 58a950ef77ce..401b9efb25aa 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -535,7 +535,7 @@ void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 	struct rx_ts_record *ts = from_timer(ts, t,
 					      rx_admitted_ba_record.timer);
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
-				     RxTsRecord[ts->num]);
+				     rx_ts_records[ts->num]);
 
 	rx_ts_delete_ba(ieee, ts);
 	rtllib_send_DELBA(ieee, ts->ts_common_info.addr,
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index bec73bc53dd0..d23d35d5dce1 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -12,7 +12,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 {
 	struct rx_ts_record *ts = from_timer(ts, t, rx_pkt_pending_timer);
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
-						  RxTsRecord[ts->num]);
+						  rx_ts_records[ts->num]);
 
 	struct rx_reorder_entry *pReorderEntry = NULL;
 
@@ -120,7 +120,7 @@ static void ResetRxTsEntry(struct rx_ts_record *ts)
 void rtllib_ts_init(struct rtllib_device *ieee)
 {
 	struct tx_ts_record *pTxTS  = ieee->TxTsRecord;
-	struct rx_ts_record *rxts  = ieee->RxTsRecord;
+	struct rx_ts_record *rxts  = ieee->rx_ts_records;
 	struct rx_reorder_entry *pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b4413cfcb17e..e7d4ed9eb899 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1229,7 +1229,7 @@ struct rtllib_device {
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		Rx_TS_Pending_List;
 	struct list_head		Rx_TS_Unused_List;
-	struct rx_ts_record RxTsRecord[TOTAL_TS_NUM];
+	struct rx_ts_record rx_ts_records[TOTAL_TS_NUM];
 	struct rx_reorder_entry RxReorderEntry[128];
 	struct list_head		RxReorder_Unused_List;
 
-- 
2.39.2



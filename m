Return-Path: <linux-kernel+bounces-18496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C69825E60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FC1C23BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263879FD;
	Sat,  6 Jan 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RG0A7ORw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B66FB2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c21e185df5so196572a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520573; x=1705125373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmWdmd80J+zop+fmRCsw8E/0vFIy5DUmsZqrKkyF7Pk=;
        b=RG0A7ORwBvrQ5FXuy6ONd6cSEseg7yAWaKbY7X7Nd04RXDnrLo+EnpkPLIWHWkaMxA
         Y7tjuK436RzvlWYRflxn50iBTVPdd2nPbxG7BNsQgmG0KQ1U1akQj/n0XNQPZznA0WsW
         1cAz69EZ+aANoCxQP12P+Eem4xiHRdaKtaEtxhCSpODKYFcI5VA4GDXq2xFc4B9P6rgv
         xeiJMvwAw/TY2kjqsBvtBUvafy2d0+ZLtWbqrbf+zfzbWrig0AVc7m74oFQxHV9xstCZ
         Eb4+J2bm06xePXsWusbwsW7Cbm16Qr0SqHqQ6DvAQ0j/0ocl8kPkJhOfLVH5aP3bZG49
         k6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520573; x=1705125373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmWdmd80J+zop+fmRCsw8E/0vFIy5DUmsZqrKkyF7Pk=;
        b=cN2aTWL77tUw0xXMELK6IVGDYpmDaqYYgr9X4f7MUvkR9HzeqCidzXalP5xt9uq3JX
         L/EHBsOx2T1nVlB7iZ6X2ygqceNsaHnE9QVHZ2Ef2Th5Q6z/kv8/VoEdRDzWRbHB1CQ0
         XsLE7yqCHET+J2U68l+mPivYSP+MsFSyipZhrfHdAOwyeT0LPmaouZOk4Rqbbo0feaAi
         IXSjHcg3M3y8aQhEkQMOjc8DdMS6n1c98vZDU6Fn0SrhSFrSHYMpFDoss+iC31lVkGRZ
         qoHzRAVIqRC3C+2mcKdFznxgJOBMajARuP9MRJpJCE0O+UNLFmDmr47LCFUzKspiADzr
         aFjQ==
X-Gm-Message-State: AOJu0YwEs0XwVbKWbyWZTkQuUc7C3KTcdnGF2ANcPhgEcHrOj1W/guuv
	9C7me0G2iCkMRHttmvLKgcSuHiKLsJW0wQ==
X-Google-Smtp-Source: AGHT+IHqNuWhcwGKjBi6G8KUeFW4GUoOXvZHNgDK186Hk8yLD7zU3ESc10VfdmL/H7ct75fVz5ytKw==
X-Received: by 2002:a05:6a20:d423:b0:18f:97c:9792 with SMTP id il35-20020a056a20d42300b0018f097c9792mr507479pzb.122.1704520573100;
        Fri, 05 Jan 2024 21:56:13 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:12 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/21] Staging: rtl8192e: Rename variable bAwakePktSent
Date: Fri,  5 Jan 2024 21:55:41 -0800
Message-Id: <20240106055556.430948-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bAwakePktSent to awake_pkt_sent to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 67938e212db1..c9d7484fe1cd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1257,7 +1257,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	int   idx;
 	u32 fwinfo_size = 0;
 
-	priv->rtllib->bAwakePktSent = true;
+	priv->rtllib->awake_pkt_sent = true;
 
 	fwinfo_size = sizeof(struct tx_fwinfo_8190pci);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d3c79105508..9d6704fc86ff 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1374,7 +1374,7 @@ struct rtllib_device {
 
 	/* for PS mode */
 	unsigned long last_rx_ps_time;
-	bool			bAwakePktSent;
+	bool			awake_pkt_sent;
 	u8			LPSDelayCnt;
 
 	/* used if IEEE_SOFTMAC_SINGLE_QUEUE is set */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0d53e0a92a4c..08ff55c2f1be 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1378,7 +1378,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		return 0;
 
 	if (time) {
-		if (ieee->bAwakePktSent) {
+		if (ieee->awake_pkt_sent) {
 			psc->LPSAwakeIntvl = 1;
 		} else {
 			u8 max_period = 5;
@@ -1461,7 +1461,7 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 		}
 
-		ieee->bAwakePktSent = false;
+		ieee->awake_pkt_sent = false;
 
 	} else if (sleep == 2) {
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
-- 
2.39.2



Return-Path: <linux-kernel+bounces-18505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC5825E69
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F01C2185F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EA10954;
	Sat,  6 Jan 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NdJ14BuB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02519101CD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb53e20a43so298002b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520581; x=1705125381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMCv5trULBLT55NBDg4tupxyaVglLY4THsMtNFhieP8=;
        b=NdJ14BuBiSiC07Ifl/5ObnaIsRY8fzkqsvB23QuGcBwXD1P8bwvKC3eBL0IEnMemKi
         yjj7EYT3addgKljDQ/A1C5WyDbisGG2xvg1FZaZGZNLTIcVEZbaiwUZy64NU5bAc/Bbs
         wjiTmp6zeC6fB+XS5Svm4hQt3dgcACzl3wkOyNtwgXEhM+/m57A7qcVliKFNYNM8NdZJ
         99QEEzTpdnFad2Ia2dsCZkdkQvnpEKWblfbt+7kyCl0HhvlYxSaKEfvBB96uonDktOTb
         YA8m6PurCVe6ll+3LAboAzQDPgiyivbAlOrzcEQmVywdWqDqaDd/hBLLfXg3E2qDT2SC
         v/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520581; x=1705125381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMCv5trULBLT55NBDg4tupxyaVglLY4THsMtNFhieP8=;
        b=jwchPjO32QzfbHm8/j0XvEGuPeg40Ehqj7kUJHcD2xDKi5tpj4DERd8xCVagI5G95e
         BkjaAdX/tzTEerKa45Jem1AlHpUNiXMRQS80NJtjYEFXiDWSAq3SmbS/m/9AtyTNZ/gh
         V/HW2ENI8xPo3/4o/Xy/4inFqvchTHM99R8SzJVE5Q+Skq4qhnA6D1CgqlQBbUgLCGrT
         g/qtEvr/XskYFGlNLb2jgleYF7+sAaeIxoUqL152LesxJ7/LbId+sFwY/YljIUhQYPta
         pKLBH27EACWX8gEDymuIJL6vQgUjbRn5Ot1It4uQq6jwGyISvRA/4RDtZtqJdd5maxfL
         3H3A==
X-Gm-Message-State: AOJu0YznAnt9INGTfiAZNz00euuJBNhIP+lhQdcn+cl4EsQKBPieZmkX
	Y4cynMmfO32yfIlsv/ZS48SDvv45qcVrag==
X-Google-Smtp-Source: AGHT+IFjq5QCpT2Ab8e6eb8zvJePSncO+Q3j/gL0PabkGnEABLuW337/IV1F33Bsx+CNyOO6KDoHhw==
X-Received: by 2002:a05:6808:11ca:b0:3bb:edfd:42db with SMTP id p10-20020a05680811ca00b003bbedfd42dbmr585814oiv.63.1704520581121;
        Fri, 05 Jan 2024 21:56:21 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/21] Staging: rtl8192e: Rename function RemovePeerTS()
Date: Fri,  5 Jan 2024 21:55:50 -0800
Message-Id: <20240106055556.430948-16-tdavies@darkphysics.net>
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

Rename function RemovePeerTS to remove_peer_ts to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c    | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f4e48b4a122d..e499f96e9010 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1032,7 +1032,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 			ieee->link_state = RTLLIB_ASSOCIATING;
 
-			RemovePeerTS(priv->rtllib,
+			remove_peer_ts(priv->rtllib,
 				     priv->rtllib->current_network.bssid);
 			ieee->is_roaming = true;
 			ieee->is_set_key = false;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 48374cae816d..e9a193b5ab10 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -360,7 +360,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 	}
 }
 
-void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
+void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 {
 	struct ts_common_info *ts, *pTmpTS;
 
@@ -400,7 +400,7 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
 		}
 	}
 }
-EXPORT_SYMBOL(RemovePeerTS);
+EXPORT_SYMBOL(remove_peer_ts);
 
 void remove_all_ts(struct rtllib_device *ieee)
 {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ed9ca77fbcb9..d20a1809cffd 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1788,7 +1788,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8
 void rtllib_ts_init(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
-void RemovePeerTS(struct rtllib_device *ieee, u8 *addr);
+void remove_peer_ts(struct rtllib_device *ieee, u8 *addr);
 void remove_all_ts(struct rtllib_device *ieee);
 
 static inline const char *escape_essid(const char *essid, u8 essid_len)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b9750c9b3952..ff43697768cb 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1736,7 +1736,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->is_roaming = true;
 		ieee->link_detect_info.busy_traffic = false;
 		rtllib_disassociate(ieee);
-		RemovePeerTS(ieee, header->addr2);
+		remove_peer_ts(ieee, header->addr2);
 		if (!(ieee->rtllib_ap_sec_type(ieee) &
 		    (SEC_ALG_CCMP | SEC_ALG_TKIP)))
 			schedule_delayed_work(
@@ -2247,7 +2247,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 	u8 i;
 	u8	op_mode;
 
-	RemovePeerTS(rtllib, asSta);
+	remove_peer_ts(rtllib, asSta);
 
 	if (memcmp(rtllib->current_network.bssid, asSta, 6) == 0) {
 		rtllib->link_state = MAC80211_NOLINK;
-- 
2.39.2



Return-Path: <linux-kernel+bounces-40764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22683E578
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A6E1C236F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DC051029;
	Fri, 26 Jan 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="cIjw5Q79"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0147A6D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308304; cv=none; b=CzopPaMFB6HCubxcH76oWX3ECePJKR4KMO7YuWQ+xU6+nIPn5GSsQw/HtnOofcKwJP3JwHGuq9abXaIzMRvk2B1rPUu5RmE97tZaaggaPR26wqP+ZW9FZn3q2Gjc00EF9jKzRlEo1/yM1d/riHV6SpU9Ho/26lGlhbciSJ8GugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308304; c=relaxed/simple;
	bh=tXrWRipgv+IfWoWJanojL9H7ir4dtpcd7cY4Radj6PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6wK4PbCwJ1CAmA07Wus0zJVugHjDz6jzxk2XiWrlCb+ykRD4+jImn1XIKUk9xgls4t2L9NCPE8mFiKKsqFqJp4d6HSxcXVv4+53MisJHxWVOjPvRRLzYtP1kGYGxuL0SzXi4BrdJSareZmbl1RtUVywNlkG2VDShABOzxCqnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=cIjw5Q79; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7393de183so6278325ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308301; x=1706913101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow3EKOni9BuhdA4VJdVm97xtU3J/2d5f0LEQZ2AWapA=;
        b=cIjw5Q79pY1v/TAkV7Snkn9Zm7Xnxsb0fgFevoIeG6sMH1s6ae8F3BbD4Z1tz/GhZl
         CpekrX2/ZIuZt8LDj2yZOERB9WtjojpRJxCsfzvxANgubKYhWDR5t7ZPG3iDAPXbp8Zj
         poO05hq+d/eLndgG5tog6hVLyhsxPGshHL6gnte16r4BNf/zLSV3uZdspyvnqE+k84Ju
         GG/C5AB9ksj7fnpYHvtNWuZSLgld9Qtje8lM/0t5soOpR2lwlCknb4krUR27Laq6zzx8
         30DFc7sA6m0DEUGHPM0yipAZX7jpO8OcrLYF0gzJ6jLFNKW13CLfkBiunPXsJn8AHS6u
         gjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308301; x=1706913101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow3EKOni9BuhdA4VJdVm97xtU3J/2d5f0LEQZ2AWapA=;
        b=iPHPVj1P2VLbJLx8SRBcfs3xiZfFFPiKtsh6V4Mq2Eyl91aNYTeAIFRzdPDJc9xD5/
         DhlF2L4mWFJWB9ole88j55WEZsYYiFpZKQk5pQAWecR3kCz9AhpjhpHzSaE39MeJME8a
         QvSBCuYICI+sDzsf1S2Eni33V1PQfaEVE+OCM5Ky5x/DuT6G4Z7R7ZcSiTd56+R/fN9t
         6EN2JQDiZLLesvVnV3YUpoHVy5a9MVRCf6+gcqdYLFDa4hgCh8nAiiF0cNwfeapP+5+M
         fix13azNroYzCt6USdZ2ebyV341xb8XrXKRgDi9aa8O/ME/+uKZL6p81x+BIjHp5R/oP
         pwEA==
X-Gm-Message-State: AOJu0Yx+kr9FNFv1hzZCdrvJn5tFtwIAhq8czjh0GbMe+2A5cSh1Aq/T
	TPNkynorspaxKfc6LrySsdbDl+mtchmwz76SYMqVC+rM+BWsu8/Xj4z6XFBoQPs=
X-Google-Smtp-Source: AGHT+IF8Geg3WrBuXLpGL3e46X96eIMZzU5UnGifA9iKt1tGbnTmIvuFwoX1ahktVabUNHfQoje8kg==
X-Received: by 2002:a17:903:32ca:b0:1d8:8623:bc54 with SMTP id i10-20020a17090332ca00b001d88623bc54mr545273plr.74.1706308301511;
        Fri, 26 Jan 2024 14:31:41 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:40 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 05/18] Staging: rtl8192e: Rename function pointer SetHwRegHandler()
Date: Fri, 26 Jan 2024 14:30:53 -0800
Message-Id: <20240126223106.986093-6-tdavies@darkphysics.net>
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

Rename function pointer SetHwRegHandler to set_hw_reg_handler to fix 
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update commit message.
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 12 ++++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     |  6 +++---
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      |  6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9b9d95ba06df..4cd3d7b7c31c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -164,7 +164,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				    eACI);
 			break;
 		}
-		priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACM_CTRL,
+		priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACM_CTRL,
 					      &pAcParam);
 		break;
 	}
@@ -1698,7 +1698,7 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 	u32	ulRegRead;
 
 	op_mode = RT_OP_MODE_NO_LINK;
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_MEDIA_STATUS, &op_mode);
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_MEDIA_STATUS, &op_mode);
 
 	if (!priv->rtllib->bSupportRemoteWakeUp) {
 		u1bTmp = 0x0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f986dbb215e4..79e66b726b28 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -236,14 +236,14 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		if (priv->dot11_current_preamble_mode != PREAMBLE_SHORT) {
 			ShortPreamble = true;
 			priv->dot11_current_preamble_mode = PREAMBLE_SHORT;
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACK_PREAMBLE,
 					(unsigned char *)&ShortPreamble);
 		}
 	} else {
 		if (priv->dot11_current_preamble_mode != PREAMBLE_LONG) {
 			ShortPreamble = false;
 			priv->dot11_current_preamble_mode = PREAMBLE_LONG;
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACK_PREAMBLE,
 					      (unsigned char *)&ShortPreamble);
 		}
 	}
@@ -256,13 +256,13 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
 			if (cur_slot_time != SHORT_SLOT_TIME) {
 				slot_time_val = SHORT_SLOT_TIME;
-				priv->rtllib->SetHwRegHandler(dev,
+				priv->rtllib->set_hw_reg_handler(dev,
 					 HW_VAR_SLOT_TIME, &slot_time_val);
 			}
 		} else {
 			if (cur_slot_time != NON_SHORT_SLOT_TIME) {
 				slot_time_val = NON_SHORT_SLOT_TIME;
-				priv->rtllib->SetHwRegHandler(dev,
+				priv->rtllib->set_hw_reg_handler(dev,
 					 HW_VAR_SLOT_TIME, &slot_time_val);
 			}
 		}
@@ -301,7 +301,7 @@ static void _rtl92e_qos_activate(void *data)
 		goto success;
 
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
-		priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
+		priv->rtllib->set_hw_reg_handler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
 
 success:
 	mutex_unlock(&priv->mutex);
@@ -660,7 +660,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->GetHalfNmodeSupportByAPsHandler =
 						rtl92e_is_halfn_supported_by_ap;
 
-	priv->rtllib->SetHwRegHandler = rtl92e_set_reg;
+	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
 	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
 	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 92143c50c149..57e1a361a7c9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1185,7 +1185,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		if (priv->bcurrent_turbo_EDCA) {
 			u8 tmp = AC0_BE;
 
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_AC_PARAM,
 						      (u8 *)(&tmp));
 			priv->bcurrent_turbo_EDCA = false;
 		}
@@ -1636,7 +1636,7 @@ static void _rtl92e_dm_start_hw_fsync(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cf);
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING,
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_RF_TIMING,
 				      (u8 *)(&rf_timing));
 	rtl92e_writeb(dev, 0xc3b, 0x41);
 }
@@ -1647,7 +1647,7 @@ static void _rtl92e_dm_end_hw_fsync(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c52cd);
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING, (u8 *)
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_RF_TIMING, (u8 *)
 				     (&rf_timing));
 	rtl92e_writeb(dev, 0xc3b, 0x49);
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0a366874a827..cd45a9c46a94 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1491,7 +1491,7 @@ struct rtllib_device {
 	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
 					   u8 Operation);
-	void (*SetHwRegHandler)(struct net_device *dev, u8 variable, u8 *val);
+	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
 	void (*AllowAllDestAddrHandler)(struct net_device *dev,
 					bool bAllowAllDA, bool WriteIntoReg);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b5cd030f28c8..b5fe471f765b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2256,11 +2256,11 @@ static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
 			rtllib->current_network.bssid[i] = 0x22;
 		op_mode = RT_OP_MODE_NO_LINK;
 		rtllib->op_mode = RT_OP_MODE_NO_LINK;
-		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_MEDIA_STATUS,
+		rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_MEDIA_STATUS,
 					(u8 *)(&op_mode));
 		rtllib_disassociate(rtllib);
 
-		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_BSSID,
+		rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_BSSID,
 					rtllib->current_network.bssid);
 	}
 }
@@ -2270,7 +2270,7 @@ static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 	bool filter_out_nonassociated_bssid = false;
 
 	filter_out_nonassociated_bssid = false;
-	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
+	rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_CECHK_BSSID,
 				(u8 *)(&filter_out_nonassociated_bssid));
 	rtllib_mlme_disassociate_request(rtllib, rtllib->current_network.bssid,
 				       asRsn);
-- 
2.39.2



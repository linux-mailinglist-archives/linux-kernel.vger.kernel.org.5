Return-Path: <linux-kernel+bounces-82847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B41868A85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499FC1C21B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05355646F;
	Tue, 27 Feb 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8vOq4kz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5356440
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021396; cv=none; b=IV8s1sTm+AKnVDGNxrvkflTwwtNJYO3AfXzg3j4xlYGL3q4WwmD2m3j6w3VzfJZITnpnHcSBdqR22G8M/U1PdVqsQAApp8MOMYRK/PISoKIg2m93J2+S92s957KaBV57XdQZLCKQH3eaMwzxHJTaU1wb3XQC+aEU8F7JdPNKeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021396; c=relaxed/simple;
	bh=elFxfL9A2xGcR5fGcCNyQgri3vYJ3M/gHqGTu4V1Lgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqBgamI8CTXg9L63RWUOejYRzHLjTG98K+3Q2KOsLbQpvtO2hfZFPRDd88FtHRDC1LAzbUEkk/vIReClmYPIYjRPBXgutyMVhy+FEkdGYq4gl6X8A3LZ9xHqeiyEfvyXcVGn6As1vYErG7PleHkY7/fcj0/+K+lGEctQH2rwNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8vOq4kz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc91d2384cso18225175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709021394; x=1709626194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eI87wpSxrKx5Pd/KtlbryOuE4BijaR7p0KGrHkeaOYU=;
        b=f8vOq4kz/VoT57VNJZJckESmnb4BAXSu/iNQiAgHxqtGY1B3cPoLJ4B7+FuZEQh+5b
         nStE3mLTx79FU5RDQJMERr7RjlHpj1QHcpKNmH7sFHosh+GyrN/Tq0E6fOO3/GV3FyJn
         DvGjtyoeK1pCdCpS52MZHxFNjrUrIVYCzJ1bq1yA/7md5mAkK9vdP4BgTxoYcqfkIB+1
         MTLpyyFlfcj01WwPZDogmLvL6c/wqQNjMhOVvfSTqYeQxHu+Wo4H64Ej2AKdnCMk7vTp
         rvDIisfG2pfnlf2bN4YqYLOQeghiGqGxZ4T0GygYCgNydwDSEQq1B5k16W9u5SbJLGQz
         DmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021394; x=1709626194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI87wpSxrKx5Pd/KtlbryOuE4BijaR7p0KGrHkeaOYU=;
        b=UJIEC65owxmYPP/KVnIGW1qGwuVPGwEgdzRmt1owR2o97FQVIvMhW0YxUPTmqu/e4h
         L1WAMU+1I1THuc3UpILzXE38YPKJ3QGNL7W7+k5NNyPP4qYjKYqEw1g2MKlDUkWDSWyX
         Wc/G8ALXr/CcrIulTg6TmgTap3mXlCf8qFmWhOoZ+kEg5BxIFE6nBQKS9Y4JlG+nzuGJ
         lYDstQWZvP63Oy2eQkSNoKzZ1AE6Hf3B2ZlPhKzmY88wWONK6DaS8d0APr7W/AWSJuIA
         B1QTUBWn8tD52C50tMi4kGPjjBu/IRLLinG2/5XvKb0K1oVRM38oRC9pfy79zmhnUEbm
         5AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWQgvea+u/YPgFi1QExvCoTXyFo0LFCCvbkePZvENymCXEyx3njSFXoYX+ZclzO+WdnfDqCG8JyR+Xky3RxyJx98DuDEShx8nl/iY5
X-Gm-Message-State: AOJu0Yz1Si+knkVhtQIHeGkOrynqdmdffOIkpb16Gr58Q0GVPTH+hzuZ
	2rk3D9hckpOpWJnJk5H8SkyuIp0/s13zizwbvYXJCnWERsPdFpMX
X-Google-Smtp-Source: AGHT+IGYXj5CZyrFuSJ8ejGWQyZqjq7OrKTVcYjcB+APd56hqLIPPH937YNrLrB0J4V3q4rHVXq1kA==
X-Received: by 2002:a17:902:e809:b0:1dc:abe7:a1a6 with SMTP id u9-20020a170902e80900b001dcabe7a1a6mr4480596plg.17.1709021394116;
        Tue, 27 Feb 2024 00:09:54 -0800 (PST)
Received: from phoenix.. (076-050-196-152.res.spectrum.com. [76.50.196.152])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902aa9000b001dcb18cd22esm925059plr.141.2024.02.27.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:09:53 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: hal_btcoex: fixed styling issues
Date: Tue, 27 Feb 2024 00:09:43 -0800
Message-ID: <20240227080943.13032-1-michaelharriscode@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed various checkpatch.pl styling issues: spaces before tabs, constants being on left side of comparisons, unnecessary braces, etc.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 78 +++++++++++-----------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index e26b789b9cdd..91922457e6e8 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -10,14 +10,14 @@
 #include <hal_btcoex.h>
 #include <Mp_Precomp.h>
 
-/* 		Global variables */
+/*		Global variables */
 
 struct btc_coexist GLBtCoexist;
 static u8 GLBtcWiFiInScanState;
 static u8 GLBtcWiFiInIQKState;
 
 /*  */
-/* 		Debug related function */
+/*		Debug related function */
 /*  */
 static u8 halbtcoutsrc_IsBtCoexistAvailable(struct btc_coexist *pBtCoexist)
 {
@@ -92,7 +92,7 @@ static void halbtcoutsrc_LeaveLowPower(struct btc_coexist *pBtCoexist)
 	stime = jiffies;
 	do {
 		ready = rtw_register_task_alive(padapter, BTCOEX_ALIVE);
-		if (_SUCCESS == ready)
+		if (ready == _SUCCESS)
 			break;
 
 		utime = jiffies_to_msecs(jiffies - stime);
@@ -304,8 +304,10 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 		break;
 
 	case BTC_GET_BL_WIFI_SCAN:
-		/* Use the value of the new variable GLBtcWiFiInScanState to judge whether WiFi is in scan state or not, since the originally used flag
-			WIFI_SITE_MONITOR in fwstate may not be cleared in time */
+		/*
+		 * Use the value of the new variable GLBtcWiFiInScanState to judge whether WiFi is in scan state or not, since the originally used flag
+		 * WIFI_SITE_MONITOR in fwstate may not be cleared in time
+		 */
 		*pu8 = GLBtcWiFiInScanState;
 		break;
 
@@ -365,6 +367,7 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 	case BTC_GET_U4_WIFI_TRAFFIC_DIRECTION:
 		{
 			struct rt_link_detect_t *plinkinfo;
+
 			plinkinfo = &padapter->mlmepriv.LinkDetectInfo;
 
 			if (plinkinfo->NumTxOkInPeriod > plinkinfo->NumRxOkInPeriod)
@@ -402,9 +405,9 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 
 	case BTC_GET_U1_MAC_PHY_MODE:
 		*pu8 = BTC_SMSP;
-/* 			*pU1Tmp = BTC_DMSP; */
-/* 			*pU1Tmp = BTC_DMDP; */
-/* 			*pU1Tmp = BTC_MP_UNKNOWN; */
+/*			*pU1Tmp = BTC_DMSP; */
+/*			*pU1Tmp = BTC_DMDP; */
+/*			*pU1Tmp = BTC_MP_UNKNOWN; */
 		break;
 
 	case BTC_GET_U1_AP_NUM:
@@ -562,7 +565,7 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 }
 
 /*  */
-/* 		IO related function */
+/*		IO related function */
 /*  */
 static u8 halbtcoutsrc_Read1Byte(void *pBtcContext, u32 RegAddr)
 {
@@ -669,7 +672,7 @@ static void halbtcoutsrc_WriteLocalReg1Byte(void *pBtcContext, u32 RegAddr, u8 D
 	struct btc_coexist *pBtCoexist = (struct btc_coexist *)pBtcContext;
 	struct adapter *Adapter = pBtCoexist->Adapter;
 
-	if (BTC_INTF_SDIO == pBtCoexist->chipInterface)
+	if (pBtCoexist->chipInterface == BTC_INTF_SDIO)
 		rtw_write8(Adapter, SDIO_LOCAL_BASE | RegAddr, Data);
 	else
 		rtw_write8(Adapter, RegAddr, Data);
@@ -773,7 +776,7 @@ static void halbtcoutsrc_FillH2cCmd(void *pBtcContext, u8 elementId, u32 cmdLen,
 }
 
 /*  */
-/* 		Extern functions called by other module */
+/*		Extern functions called by other module */
 /*  */
 static u8 EXhalbtcoutsrc_BindBtCoexWithAdapter(void *padapter)
 {
@@ -781,8 +784,8 @@ static u8 EXhalbtcoutsrc_BindBtCoexWithAdapter(void *padapter)
 
 	if (pBtCoexist->bBinded)
 		return false;
-	else
-		pBtCoexist->bBinded = true;
+
+	pBtCoexist->bBinded = true;
 
 	pBtCoexist->statistics.cntBind++;
 
@@ -895,20 +898,20 @@ void EXhalbtcoutsrc_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl)
 		return;
 
-	if (IPS_NONE == type)
+	if (type == IPS_NONE)
 		ipsType = BTC_IPS_LEAVE;
 	else
 		ipsType = BTC_IPS_ENTER;
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_IpsNotify(pBtCoexist, ipsType);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_IpsNotify(pBtCoexist, ipsType);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
@@ -923,7 +926,7 @@ void EXhalbtcoutsrc_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl)
 		return;
 
-	if (PS_MODE_ACTIVE == type)
+	if (type == PS_MODE_ACTIVE)
 		lpsType = BTC_LPS_DISABLE;
 	else
 		lpsType = BTC_LPS_ENABLE;
@@ -953,14 +956,14 @@ void EXhalbtcoutsrc_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	}
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_ScanNotify(pBtCoexist, scanType);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_ScanNotify(pBtCoexist, scanType);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_ConnectNotify(struct btc_coexist *pBtCoexist, u8 action)
@@ -979,14 +982,14 @@ void EXhalbtcoutsrc_ConnectNotify(struct btc_coexist *pBtCoexist, u8 action)
 		assoType = BTC_ASSOCIATE_FINISH;
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_ConnectNotify(pBtCoexist, assoType);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_ConnectNotify(pBtCoexist, assoType);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_MediaStatusNotify(struct btc_coexist *pBtCoexist, enum
@@ -1001,20 +1004,20 @@ void EXhalbtcoutsrc_MediaStatusNotify(struct btc_coexist *pBtCoexist, enum
 	if (pBtCoexist->bManualControl)
 		return;
 
-	if (RT_MEDIA_CONNECT == mediaStatus)
+	if (mediaStatus == RT_MEDIA_CONNECT)
 		mStatus = BTC_MEDIA_CONNECT;
 	else
 		mStatus = BTC_MEDIA_DISCONNECT;
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_MediaStatusNotify(pBtCoexist, mStatus);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_MediaStatusNotify(pBtCoexist, mStatus);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 pktType)
@@ -1027,25 +1030,24 @@ void EXhalbtcoutsrc_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 pktTy
 	if (pBtCoexist->bManualControl)
 		return;
 
-	if (PACKET_DHCP == pktType) {
+	if (pktType == PACKET_DHCP)
 		packetType = BTC_PACKET_DHCP;
-	} else if (PACKET_EAPOL == pktType) {
+	else if (pktType == PACKET_EAPOL)
 		packetType = BTC_PACKET_EAPOL;
-	} else if (PACKET_ARP == pktType) {
+	else if (pktType == PACKET_ARP)
 		packetType = BTC_PACKET_ARP;
-	} else {
+	else
 		return;
-	}
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_SpecialPacketNotify(pBtCoexist, packetType);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_SpecialPacketNotify(pBtCoexist, packetType);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_BtInfoNotify(struct btc_coexist *pBtCoexist, u8 *tmpBuf, u8 length)
@@ -1056,14 +1058,14 @@ void EXhalbtcoutsrc_BtInfoNotify(struct btc_coexist *pBtCoexist, u8 *tmpBuf, u8
 	pBtCoexist->statistics.cntBtInfoNotify++;
 
 	/*  All notify is called in cmd thread, don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_BtInfoNotify(pBtCoexist, tmpBuf, length);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_BtInfoNotify(pBtCoexist, tmpBuf, length);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_HaltNotify(struct btc_coexist *pBtCoexist)
@@ -1103,25 +1105,25 @@ void EXhalbtcoutsrc_Periodical(struct btc_coexist *pBtCoexist)
 
 	/*  Periodical should be called in cmd thread, */
 	/*  don't need to leave low power again */
-/* 	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
+/*	halbtcoutsrc_LeaveLowPower(pBtCoexist); */
 
 	if (pBtCoexist->boardInfo.btdmAntNum == 2)
 		EXhalbtc8723b2ant_Periodical(pBtCoexist);
 	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
 		EXhalbtc8723b1ant_Periodical(pBtCoexist);
 
-/* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
+/*	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
 void EXhalbtcoutsrc_SetAntNum(u8 type, u8 antNum)
 {
-	if (BT_COEX_ANT_TYPE_PG == type) {
+	if (type == BT_COEX_ANT_TYPE_PG) {
 		GLBtCoexist.boardInfo.pgAntNum = antNum;
 		GLBtCoexist.boardInfo.btdmAntNum = antNum;
-	} else if (BT_COEX_ANT_TYPE_ANTDIV == type) {
+	} else if (type == BT_COEX_ANT_TYPE_ANTDIV) {
 		GLBtCoexist.boardInfo.btdmAntNum = antNum;
 		/* GLBtCoexist.boardInfo.btdmAntPos = BTC_ANTENNA_AT_MAIN_PORT; */
-	} else if (BT_COEX_ANT_TYPE_DETECTED == type) {
+	} else if (type == BT_COEX_ANT_TYPE_DETECTED) {
 		GLBtCoexist.boardInfo.btdmAntNum = antNum;
 		/* GLBtCoexist.boardInfo.btdmAntPos = BTC_ANTENNA_AT_MAIN_PORT; */
 	}
-- 
2.43.2



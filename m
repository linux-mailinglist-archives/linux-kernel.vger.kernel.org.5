Return-Path: <linux-kernel+bounces-11164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD281E24C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FC4281599
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10F54BFE;
	Mon, 25 Dec 2023 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NRyAe3Xa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBA54656
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3081234a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535803; x=1704140603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY8Yj/DU7Ru4GTNDSXSvBwYAcH02TIn/sHGmgQuRGjQ=;
        b=NRyAe3XarxgcwZFjHGxUqY2syzI2BbLRx0HBomOaEWtEq5Pn4KvVWS7r5gxU2vHzlE
         tIgq+zjjEi0E0H52JCfW4De62b0vJFyOIatrEyPK3ilgm/40nf8kTkIcdQS0nmZpNZiP
         NlrKkkOupfAhsnJCsbVspc2zFTI/IAircxDxrj7p3PRmeXhcwdOF5hkqGvgSPd0zjrqx
         Fneq5keSVS6v9NP25AlwcYdtX8r1w9xqYKcWOUk5DpOAiEMsf8DuBBfEcAUnhfLyWWDw
         oW96M3S1yrCCBgReFddNJynuEEQBxz4V/4D1/rbjBRtmCGMbnfApp2WtsX0phncsR2rB
         DByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535803; x=1704140603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY8Yj/DU7Ru4GTNDSXSvBwYAcH02TIn/sHGmgQuRGjQ=;
        b=hZUZsS0ZgZ8VC602p+ac+jTrQDGP3PEWM+d9AGG3u3LXOAkAS0mOAjU48OPi6bWpVU
         z/XeCluOW2bHFs2Cc2Vl0YBpMJTrPo0chIzbBQvsJDOotlzdgO/+sOgk2UPJelsWgSe5
         g83HGolfHJ4NwAXjOiFRRk+l9wJQsopumhJmgMTY+/XKajyYiDXyl5LBUNmUAdip/lpX
         UoWp7h0FUwTWeO3ge+lgjPzyk4oiDcnelpkBmArfcRGVeG/1c0TkETrNYD96kISPtErD
         BVHdDZlvpV+HYrjnHvTONS/x8mDNNDeG1j3wf8Hy3qW5+KvN9TlvSHz09W4IUraUcyH2
         WZKw==
X-Gm-Message-State: AOJu0Yx1aczDpYFF/nhMJ8pGCijJ2uWY2D7LZmjggL46sQKRCiKCamKM
	Y35U4tN2lyPnWow+EeY6J4Fnw0HXI35FQQ==
X-Google-Smtp-Source: AGHT+IGxHy/lP2tgU3DLHGT71bu/t8Q4GMnCMpTPBHGajLrEVlge7LrR8vjYqJuBYy2IMgfQz9JHkg==
X-Received: by 2002:a17:902:680b:b0:1d4:638f:3ff6 with SMTP id h11-20020a170902680b00b001d4638f3ff6mr945916plk.66.1703535803407;
        Mon, 25 Dec 2023 12:23:23 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:22 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/6] Staging: rtl8192e: Rename variable OpMode
Date: Mon, 25 Dec 2023 12:23:14 -0800
Message-Id: <20231225202314.31869-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225202314.31869-1-tdavies@darkphysics.net>
References: <20231225202314.31869-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable OpMode to op_mode to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ed0c152c2477..c7a2eae2fdb9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -51,12 +51,12 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 
 	case HW_VAR_MEDIA_STATUS:
 	{
-		enum rt_op_mode OpMode = *((enum rt_op_mode *)(val));
+		enum rt_op_mode op_mode = *((enum rt_op_mode *)(val));
 		u8 btMsr = rtl92e_readb(dev, MSR);
 
 		btMsr &= 0xfc;
 
-		switch (OpMode) {
+		switch (op_mode) {
 		case RT_OP_MODE_INFRASTRUCTURE:
 			btMsr |= MSR_INFRA;
 			break;
@@ -1693,12 +1693,12 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int i;
-	u8	OpMode;
+	u8	op_mode;
 	u8	u1bTmp;
 	u32	ulRegRead;
 
-	OpMode = RT_OP_MODE_NO_LINK;
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_MEDIA_STATUS, &OpMode);
+	op_mode = RT_OP_MODE_NO_LINK;
+	priv->rtllib->SetHwRegHandler(dev, HW_VAR_MEDIA_STATUS, &op_mode);
 
 	if (!priv->rtllib->bSupportRemoteWakeUp) {
 		u1bTmp = 0x0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index df72504e9695..4ce80239b8b3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1187,7 +1187,7 @@ struct rtllib_device {
 	unsigned long status;
 	u8	CntAfterLink;
 
-	enum rt_op_mode OpMode;
+	enum rt_op_mode op_mode;
 
 	/* The last AssocReq/Resp IEs */
 	u8 *assocreq_ies, *assocresp_ies;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 66816155ff36..80e323030f5f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2245,7 +2245,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 					   u8 *asSta, u8 asRsn)
 {
 	u8 i;
-	u8	OpMode;
+	u8	op_mode;
 
 	RemovePeerTS(rtllib, asSta);
 
@@ -2254,10 +2254,10 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 
 		for (i = 0; i < 6; i++)
 			rtllib->current_network.bssid[i] = 0x22;
-		OpMode = RT_OP_MODE_NO_LINK;
-		rtllib->OpMode = RT_OP_MODE_NO_LINK;
+		op_mode = RT_OP_MODE_NO_LINK;
+		rtllib->op_mode = RT_OP_MODE_NO_LINK;
 		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_MEDIA_STATUS,
-					(u8 *)(&OpMode));
+					(u8 *)(&op_mode));
 		rtllib_disassociate(rtllib);
 
 		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_BSSID,
-- 
2.39.2



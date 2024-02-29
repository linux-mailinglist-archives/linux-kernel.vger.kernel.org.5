Return-Path: <linux-kernel+bounces-86055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C012B86BF10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F81F2241E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132CC36B0E;
	Thu, 29 Feb 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JthqzdTr"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955812E83C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174615; cv=none; b=WO5u8lJgnFfVRqKyyY1kd+nPJ0qKMMtNOqKfq86vTyCRNGDBYjCyPkKCGNTKEgzvUcrFNZcYsNZ0k3xVAIuaSrYMl6BydJWUiQoueaB+MsxvQvxBYjuZas0t3SWP/QX+uM9GQqSBVnCrAd3PI8nHptPFrKkPpLTgw4OEOaMIB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174615; c=relaxed/simple;
	bh=lqZNS1yOfEcElef9Qbe+fs/5cHUb7qamtig04WByLuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS4nT1PLB6QgZFxHmRx8Whuu6Idq5cnRtepe7W0afoZWY/SCpfIYFU3GBPYoOTkwtzaDC6c3CM/uTI/RwCklEfPK1gJAJ2n/6yRwhxmp8yow2rjcG3gOzPhCJZkvdvfWF/dNW17Tl9WDJSRIezK9PMu7J6XHt4OeIP8MZoenOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JthqzdTr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e572dbbc5cso354225b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174613; x=1709779413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dShJe/rHC9hLgh7lahofGuPzHasSme7uCfvioaO2S60=;
        b=JthqzdTrXDR9onAM66fDDO98gO6Uu382zM7L4NpeU5K4wssaIYMBKZvNjtLjZaun10
         dTvtOUPjoFkGAKwMAPn4gUizsBl0SweT33OrQjGTxM2KXUwBH3JwodiMxvp1hj7d/kCy
         eM9FfCOMXUf6f267Su96TvzDsRsHHDFSs5p/8VGH9RYK9j3WOua9vcSkvxy+1A44eiHv
         MVlisfxo+fP78Md3RsHconHUC6cYUBAE/M8sJnim03nQALmSVs80NErZrsToSSfZHpO1
         LiBw2gYLCTsZmNH24hjFbGvNnuErEmuyIU2ELJJu4O2ss49Qfalq33lFqlSbjMbP75Bn
         Tllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174613; x=1709779413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dShJe/rHC9hLgh7lahofGuPzHasSme7uCfvioaO2S60=;
        b=ePWdQjQMTFIKvkjihAAH2qI+MT2mJveb8Q1aU9nmx8cYb4glnhoTCkXRVLvbKHyPjh
         cxCjj3VbnDe0mTH9pqndTWtVJRiTkrDUA/J1Q67akabXXNlpOwkOSN/efGnLiiOp9a9S
         0FiDQN2u+m0aubrJhza0kP7m6qQv6C2IxZDP3/YTmm9jAGOxrn5/Pp4TVtyZSIZYRN7r
         0C7co7VNOVLQ5WaFvgYIR2IVRp59qhby/oRQyyDZsqKYFIRi+/SCGB5lATohZ+LOrTde
         RBWZ3YfWZaL6d4nUwnCzs/ayNJw5hs6yWM9xtg5AXB4QQfg4t/Av74SPBkz3EotlDvo2
         zzDg==
X-Forwarded-Encrypted: i=1; AJvYcCWN8mxMHJhPE6MqWjWvL2h+SLObYTEgqDzjX5xcRrZ2AjeB/eDveI7TEbJrUqYYt1XslLa6ybHtUw1kSAQvOQMdvtJLUjsO7xFhx2RP
X-Gm-Message-State: AOJu0YzrYYk8HHAjY16kKRnJi26DszDOJTZSSrzblYhNyjNIz3fK3m0P
	esUDSk0jcxvMsD09ak1Q2KM+V5WX7jiZhM3R5skgHuqTg15bHfayVH/1ZDe7VSc=
X-Google-Smtp-Source: AGHT+IHWPijZiBcr6DQ1BP47hzg2vlZk5MSQHoZH2xOBXWCY/ExqymD16AkhD2pptmMe/dhiPqxmyg==
X-Received: by 2002:a05:6a00:998:b0:6e5:3f63:8eb8 with SMTP id u24-20020a056a00099800b006e53f638eb8mr844841pfg.14.1709174612871;
        Wed, 28 Feb 2024 18:43:32 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:32 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 1/8] Staging: rtl8192e: Fix 5 chckpatch alignment warnings in rtl819x_BAProc.c
Date: Wed, 28 Feb 2024 18:43:18 -0800
Message-Id: <20240229024325.453374-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tabs and spaces to fix checkpatch warning: 'Alignment should match
open parenthesis'

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bd1d86e0323d..c06633867641 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -254,7 +254,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
+			   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -277,7 +277,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 	ba->ba_start_seq_ctrl = *ba_start_seq_ctrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
+	    (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		ba->ba_param_set.field.buffer_size = 1;
 	else
 		ba->ba_param_set.field.buffer_size = 32;
@@ -338,7 +338,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
+			   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -433,7 +433,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct rx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)del_ba_param_set->field.tid, RX_DIR, false)) {
+				   (u8)del_ba_param_set->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
 				    __func__, dst,
@@ -446,7 +446,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct tx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)del_ba_param_set->field.tid, TX_DIR, false)) {
+				   (u8)del_ba_param_set->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
-- 
2.39.2



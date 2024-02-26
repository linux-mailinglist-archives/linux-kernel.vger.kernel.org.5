Return-Path: <linux-kernel+bounces-80516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A5866914
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA11F1F26D36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF14C631;
	Mon, 26 Feb 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DittovyS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08E1CD3D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919966; cv=none; b=ld6sF9Ua0l37kZurbGG8eJF2tUGZKyqgzVpD67i/5nJURSeQHOZdRJWabGJE7V7E2h/OjNnFiFmimKuqw9WVnJ3k1iaRlIaKYHqQwe10uRonyDCYjkdCN1yjQaC+U4ZmT/L4lV0uYpyOI0rYAf5xrtI5VbI+a9diN2oXaBfbedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919966; c=relaxed/simple;
	bh=rn1uhe9kSvdRl3bR99SI2tz9xfp7AgAFtEZNJ3Cph+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVS0aKGj76o/WHzPs31aIADguc1ed3a4RV/YDOmnAVyyn+5RXZgmbXaEDw96BNRTjjLl0O4UNjgHZ2JxcXak3rsa7+PiJe3awcCR0UORibQcAEvCvrutgn+4VPJvG6rBLRY6xEIjS3XzuSjw4DJq2jR96wjufRceGy+Lq2Ta8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DittovyS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d51ba18e1bso34688055ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919964; x=1709524764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFPZDGKeKZyaOMKlGQ3oMS5Xrp30OXpLH+RSaWh7syU=;
        b=DittovySr1KvV4Mi3U7gE3ZL6NqqmLMG50EfsrkEPEU8ONFfD3SxnVdujEfPIUsSN2
         /wfYtUrfalIaZrL7AeMUKFTpLn9cchR5hKerliaa3YBRm0GIrUFUIY9apts8aBg67UhC
         0CyEnTwmgI+W6/Az0ZSIQKWze2ZGT8I0sTuxK2N4Mp1+exuSVToIo+lobCONofz7sep2
         EqXq6di+c03qf9q3NJnHKu+2poasu6IxEnlBuaslbC5XbF7Osk+7DONXYzbtGRMn2EU4
         D0fcXh3HBLTOv6e4F6fQp3CLHvVNfVxGa+wQmEtuwhCuSToIdPSVHmdy5bgMNfKR0vWU
         QtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919964; x=1709524764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFPZDGKeKZyaOMKlGQ3oMS5Xrp30OXpLH+RSaWh7syU=;
        b=bvK1DUNn6ZyAPoxS+irM/SEwZjWm953KXp0+J0RZGbMWp6op15qRBaGSiAGtSIyDu9
         WCyNbBp/XBXjz4IU88bNyVFV3h9ZUJIOb85gHtE/pPimbLpz7VUkQingFd0NCUTxfJ/O
         /Ms6JUavw+qcErkr9YghJ0LomI9OfRYNKPSM9gyzcTNu4VBmLPWkgT721IBGyYBLSrXH
         qqy6oNz+A51v4YPAw2JZM91EQLQU7v63LAYbpz50P+ZmZyz5V9ZG3sQ3BeynJ6xBvY3e
         K7E1zYwf3kCjNklLkSMVrc2EQxfUmqRJLJuyDU6salqkRbukHY6mpzA/effml9fTe7Ay
         0drA==
X-Forwarded-Encrypted: i=1; AJvYcCU3GoeNIwrndiSJryWNv7pFYlGNh4B8exR5QsLlAe+RQ2pTPxzsNCzealryMvs6d054L1QOzRyoQ9/qPkkH9dRx5bosqWeHCbkYRmRE
X-Gm-Message-State: AOJu0YycpMKJiqMKxzNBlm0zjxTHF5nP27PP0sBrRHriwC/811qLJqdp
	hBCxZCxjPJyTXr1z0n9fkhIwZKB/iELaHrBpECl9crgu7V5b4xuZKX3t4LqA4go=
X-Google-Smtp-Source: AGHT+IHS1JmNpzgLjr+HYVQG6oOnedLl/aKpZ55VAo3nq6VEHO3q/i/7RTUC/v94uYQ/SZ0D5CB0ng==
X-Received: by 2002:a17:903:2450:b0:1db:bbe0:9e9 with SMTP id l16-20020a170903245000b001dbbbe009e9mr8731405pls.58.1708919964699;
        Sun, 25 Feb 2024 19:59:24 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:24 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/8] Staging: rtl8192e: Rename goto OnADDBAReq_Fail
Date: Sun, 25 Feb 2024 19:59:12 -0800
Message-Id: <20240226035915.370478-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035915.370478-1-tdavies@darkphysics.net>
References: <20240226035915.370478-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename goto OnADDBAReq_Fail -> on_add_ba_req_fail
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c0006daa75ec..a3a2fe72d644 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -251,13 +251,13 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
 			    ieee->current_network.qos_data.active,
 			    ieee->ht_info->current_ht_support);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 	ba = &ts->rx_admitted_ba_record;
 
@@ -265,7 +265,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		rc = ADDBA_STATUS_INVALID_PARAM;
 		netdev_warn(ieee->dev, "%s(): BA Policy is not correct\n",
 			    __func__);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 
 	rtllib_FlushRxTsPendingPkts(ieee, ts);
@@ -287,7 +287,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	return 0;
 
-OnADDBAReq_Fail:
+on_add_ba_req_fail:
 	{
 		struct ba_record BA;
 
-- 
2.39.2



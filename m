Return-Path: <linux-kernel+bounces-75569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC585EB32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454251F23002
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B5127B66;
	Wed, 21 Feb 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWd0BQSc"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CB3A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551954; cv=none; b=K9tALd72Dl3gb3MwjHXBSXa0oRCzvE5NBoA7dREfNbnOcx+fImdIo1kBQe+iU1iM5o0aXOoH+hwAxkHmhsy9e13K5FDZKAWmmr5iK6iL64vZ3hR308y2vCh7ubHkHb+wnUjWC30mUnlQVKu69oixRvZBdBwXi/S4RfWfX6KhlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551954; c=relaxed/simple;
	bh=0TEGUrGFTs2ldCRsHu5kOVXh9bFjQpTrcnlYib8ZxMU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv/uP5eOtxWRJwJab7YFwPNQm3jrZEMyFScpqtnxR83G8qMTWMb/5z12/p4PqJg9QeXh9BC6d2Jbot8w2Rs7JupUJpv9gdxbHYykCAFqnJM6Nhwg2kJAxOym9tjk4tgDzuyTbYxKSMwNMjtLs8HhZTIzUqi23g+vUFcj0QSK9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWd0BQSc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d4efb419bso527476f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551951; x=1709156751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9zX6fLjarN6HKERIvwo4xgsOTH/c9yGUzwQg+/o3tg=;
        b=QWd0BQScUqgrmHnyMM3uXu3JwsYRMOFKOHOnKg+iFtnGZedwQcSvtT1qYpBDgO7oMF
         NfsuCyCXZxq6EsYyTU74ibZMhdFjVnWy2hUXoHVbXDXctXx154VY+aHBkGeg3sCQQIde
         F681MQZDftx0PLsUu9dI6VRs44If8CW/m3oK/5n2X7X9+jIocrEU7iygmFdBQnlBMou7
         yqOwQCvIGPXgeETbZGuwV/SnocZgj6Jg05QDipB2HNKxgf4tjsK8BYejpKUv2mihMYzn
         UDq5Pg/baXhI37icI/NRI3h1Feg19KEoMjwL5M9M462FpJhncG4ADgIPfeHdyWZc4SU9
         BhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551951; x=1709156751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9zX6fLjarN6HKERIvwo4xgsOTH/c9yGUzwQg+/o3tg=;
        b=Yu+mrbN6NcjDM55e2dC07vIduyR8315c3fzMv0vbw01DzLVcm/usqfxQZHLrjvmJSH
         BxIWb1KJ+XMgsc1dxonUKF9UKXkNrUNuQGSL1nU9T5RjeBCKWJ9uj1svdiadRLTesZRs
         tBuSKtrpHxRU/p+dNWMmCHBaLRy7Him3Pous10suBXuFRwWloW2/wLxnZsLcuTNC6xZR
         OJT+DMqxCi9NmYD/P+1uQyQXmf8/GVG5s6kuawTk6XXH2+iFuLy2tiTtvzu8PvMOkJPt
         FxGHt5PVM3uxUdoVheoOgmmt1GEDpygzVhccmrj9udbO8l37iBnGu3qSl7pvqXyEQ9dg
         4usA==
X-Forwarded-Encrypted: i=1; AJvYcCXgG7AR3sqJDJsijGFb6l8fny/NcHbaE6ix22Q9oJ2lFt+w6aOxeH+TB9Ch1nP0bRqVH/+zdn3J6zNB5b4nb4lKa7GfQfQ5loI/vlSZ
X-Gm-Message-State: AOJu0Yx5qwzgfoDGX6qywOrM+C6mFZQ3DIoSmjd0RNr+KpP3hnfVDMlb
	jQB4kUgQ8UekJOlBgwgyvLAmVIhDS7CExSnTFTRowsxnA6qgB6BT
X-Google-Smtp-Source: AGHT+IH31F0v55Y4EPuICDjMdGycQ2S4Qd7FNnJLkku6Ql8lul7R9KJwofjM2pflPONoK4wZuhWfDw==
X-Received: by 2002:a05:600c:1c24:b0:412:5670:ef62 with SMTP id j36-20020a05600c1c2400b004125670ef62mr417558wms.1.1708551951491;
        Wed, 21 Feb 2024 13:45:51 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm18270325wrn.75.2024.02.21.13.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:51 -0800 (PST)
Date: Wed, 21 Feb 2024 22:45:49 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8192e: Remove unused variables
 bShortPreamble and fragoffset
Message-ID: <17c516c195acc458366ab182e0fd1200b7e2b1da.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables bShortPreamble and fragoffset as they are set and
never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtllib.h              | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e7494b548749..f1e97da8f077 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1659,7 +1659,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 
 	stats->rate = _rtl92e_rate_hw_to_mgn((bool)pDrvInfo->RxHT,
 					     pDrvInfo->RxRate);
-	stats->bShortPreamble = pDrvInfo->SPLCP;
 
 	_rtl92e_update_received_rate_histogram_stats(dev, stats);
 
@@ -1673,7 +1672,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
-	stats->fragoffset = 0;
 	stats->ntotalfrag = 1;
 	return true;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d238fce712a4..6b33643ddae0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -481,7 +481,6 @@ struct rtllib_rx_stats {
 	u16 bHwError:1;
 	u16 bCRC:1;
 	u16 bICV:1;
-	u16 bShortPreamble:1;
 	u16 Decrypted:1;
 	u32 TimeStampLow;
 	u32 TimeStampHigh;
@@ -497,7 +496,6 @@ struct rtllib_rx_stats {
 	bool  bPacketMatchBSSID;
 	bool  bIsCCK;
 	bool  bPacketToSelf;
-	u16    fragoffset;
 	u16    ntotalfrag;
 	bool   bPacketBeacon;
 	bool   bToSelfBA;
-- 
2.43.2



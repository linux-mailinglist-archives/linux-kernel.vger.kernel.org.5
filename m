Return-Path: <linux-kernel+bounces-161623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF18B4EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5899BB21A05
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916054665;
	Sun, 28 Apr 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Vmer1/2j"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD584AEDE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345282; cv=none; b=cKX9FygQp1n/ruEOir7m+C3gMIdd4/2Wg6bWs8fFL8/1OR9dzprCT2VMffAvT3UoJycKAoNRQfYIcscMdBfzhmR6FxH4+WJwpz6Pwsl+1B1FUpfdS7RQnJr+eUIAVM0A+/I7V/gtEo5Wj6mTNu/EJjAv7V1zYZshDezX3DSln2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345282; c=relaxed/simple;
	bh=5Y3rMOfmPj9I5oo9SIOrDTqUJHDHqOhOLjPzdtcs9vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXMpuSU5xcyUOHEmSMSlFeyFPllJHHKmKXvb1XpGGVgz64fBbHDgun7rGtnsmTZe0sUUAGYH720wlsURJdDOUDH7u6YhPM35lAtVakTTQIvBPbac+qVkMWPhtOB1zznUOZvGVb2ZOWpzr/psWo4us3BtWk5NABnczxDjyVmlhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Vmer1/2j; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a7e19c440dso2860199a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345279; x=1714950079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaX0yMsXS4twHiF6maUrciZQmjJPvFyuY1/pgw0/zBU=;
        b=Vmer1/2jB4khbXSeexFsPcMbbPIvSMXnEg+xLr/xqYgSbRsUuzoonzLDqybstpuF6Q
         6MOZlantA6TFw1DqzrMvCHlbJy23AV+/nZc4vssQ5fENoGvFnJKvqVuidXTb7WHkbI58
         yBb0p8ZN0M/soYDAQIOKRK4LEQ7MMOwnONjTSzLzpXiJWWiLqOfqmm05JscBl/KmDfeA
         OjVhb1YIcQjaJZqFNT1J/VkLtXsbkuBeXRqFlqQcRgrlFy2lW9WP7A6cN+QuR5kmA8up
         d1YryrYWUomtDj2PY1jYxb9I3LbqeYJEySYjkPMKQ/+Jjdf8CVuFIXaANbd0+FsENCvO
         kS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345279; x=1714950079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaX0yMsXS4twHiF6maUrciZQmjJPvFyuY1/pgw0/zBU=;
        b=EXDBR76zc1wVULtKACVryybTk0bg3e4XtNZcdXgIpmiGdDFgaZnL+poo8P/xwT73DT
         jcS8wES5mJ0ptseWp9JqaY6wMUHGycI7W8V6W1tyyb/zOE1ROFmygHwSA0XeErk91l1g
         IBeW8Y0XxzepdoCtfuO/ctgZPNJdKMqgORrMZ3DCS6NuDFoL5jXirbwKHwVyvfwRzlfv
         J4+23+U9AljDIdxA5v0+vXeu643WXkvwEGR19LTgFw/cKGaZdPPypyp+kLFxE+DD5ksT
         DFidDei8/7STAMsdBplOliC9//fSQzrmanmmWLSl85cdnw8w03nWJIRQHKqmd2eHGZbW
         AyZA==
X-Forwarded-Encrypted: i=1; AJvYcCVWHMQWLG2yXWWegtiOCkcgd6dy7Jn5yqerv/erm7BNzgdio51OcnjCHu2wgB7jwvKFJEMKStgmWrun7ib27NsejwCIXg7T+zuMs+y2
X-Gm-Message-State: AOJu0Yyg/YqqoVzONCrtDmDsI8SjvWEZPXkg9Xam3ejUg7JncMaUl+pL
	7MtkZWo37rdjpMNwqvPxPCMe5xv90/A82ML4WL1ERu1bSx9ToDk9tYBVoQuswBc=
X-Google-Smtp-Source: AGHT+IGlUPh7Zl+7QcgueIGd9sfz8pquCRemizZTa+v6Pa3rQpQ+0/znBpeo6eWIy5FZ4ZblL1BDQQ==
X-Received: by 2002:a17:90a:fe10:b0:2ae:6e16:da91 with SMTP id ck16-20020a17090afe1000b002ae6e16da91mr7779149pjb.29.1714345279309;
        Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/18] Staging: rtl8192e: Rename variable MaxRxAMPDUFactor
Date: Sun, 28 Apr 2024 16:01:03 -0700
Message-Id: <20240428230106.6548-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable MaxRxAMPDUFactor to max_rx_ampdu_factor
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index e0906e4588c2..425df93486b3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -39,7 +39,7 @@ struct ht_capab_ele {
 	u8	Rsvd1:1;
 	u8	lsig_txop_protect:1;
 
-	u8	MaxRxAMPDUFactor:2;
+	u8	max_rx_ampdu_factor:2;
 	u8	MPDUDensity:3;
 	u8	Rsvd2:3;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7b08e549726b..516e48073dc7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,9 +276,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	if (is_encrypt) {
 		cap_ele->MPDUDensity	= 7;
-		cap_ele->MaxRxAMPDUFactor	= 2;
+		cap_ele->max_rx_ampdu_factor	= 2;
 	} else {
-		cap_ele->MaxRxAMPDUFactor	= 3;
+		cap_ele->max_rx_ampdu_factor	= 3;
 		cap_ele->MPDUDensity	= 0;
 	}
 
@@ -471,12 +471,12 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
 		if (ieee->pairwise_key_type != KEY_TYPE_NA)
 			ht_info->current_ampdu_factor =
-					 pPeerHTCap->MaxRxAMPDUFactor;
+					 pPeerHTCap->max_rx_ampdu_factor;
 		else
 			ht_info->current_ampdu_factor = HT_AGG_SIZE_64K;
 	} else {
-		ht_info->current_ampdu_factor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
-						    HT_AGG_SIZE_32K);
+		ht_info->current_ampdu_factor = min_t(u32, pPeerHTCap->max_rx_ampdu_factor,
+						      HT_AGG_SIZE_32K);
 	}
 
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
-- 
2.30.2



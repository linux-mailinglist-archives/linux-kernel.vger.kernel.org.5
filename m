Return-Path: <linux-kernel+bounces-86062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B786BF18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040BC285CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A863CF63;
	Thu, 29 Feb 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GpXCxyiK"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D362383BE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174621; cv=none; b=g+zSFRj443aD+BUO4EAtBiK2uxcKamhsz7p0TQ6HWXS6Fyo66EY7fupdj53IWNndMW7ijiG6iJ8i/pqRh/yQ3g19msHrAkbDcnH8COOoWtL/wS6QUrCBzgX2kOqmOLWAsvuIXm9bxGRmA6HLyTSyU9z5XvhznuWmAaaNPiN6sdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174621; c=relaxed/simple;
	bh=Aphcsg+jCGb/G6Iku1F7m8eyfHQ8NCqN6UuzzT5jlXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwXpc4HyV6OY81krWgHqYAQsy6UicaE7lg+MtdE1lcq63uwKnf87pGynXJ9lqRSnQpCRvRVdm41No+doLXBJtg340y1RGk94nMAAJvGuhOuonO/7OoWwON/XjGD/xLk+gJDDSi9lQhgQnyUezM9trkSBMnwKP4CsyB4SHLXL4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=GpXCxyiK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608959cfcbfso5384527b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174619; x=1709779419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Dy5NYh5SGhramiBXVD6CBtpLYzXUVrIG3KwaM2w2o=;
        b=GpXCxyiKGeeCTH7pSKEzIR1uOFhxGCKimuhg1jM8ce2fbCXxKHty/mPTYFJtBsTpeP
         dqRTU+8Z7+rj2S7gZvqr7NKO41SHxYff5ui2evU2adUskqR7QXZuoxbvswZsDd9ST5Rs
         jX0XhZkZL0gtA7mjhPyujR7bisLhXaesAl1zlo1XARANAYUiT0E2FrXmmQQYZ35N7eSX
         TziEXLYRgh5W3S6Jy6n9fJPv5pZaZJfKnQJAIpvfv9Xqru/cHp7qyQi0dNb4shss/JnX
         AdF9UyS0cDwZMD80S6Lah7eXq1R1snPMYapOAjZpvikMcWtAL6Vd1upH88YiCj0neQ+Y
         bo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174619; x=1709779419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Dy5NYh5SGhramiBXVD6CBtpLYzXUVrIG3KwaM2w2o=;
        b=nOtiErHN/xCJ5dys5jfbNgZulDBNTn8Z7Chh684fyOgJ6iZHsLbuNTYY77TaV08P2/
         LJc+i+YV6MdCamW13vUPRDZqOS/eODUMbItxuOacZ9416LtxfsBI3RGfD7KyLt81+aJi
         7bocqGERD6rRDVFbjWLDMohG8KPuNTEIShCJuuRO+cSkSbDnfCGjhFWVJeKYi9gQDWtv
         BewfYLg1dlzRooi7HEG6TAFTR9obxDAHeZaAUXsecH4U8UH1tkQemLu0dYff6bwQuw7x
         BORTVSlEqc+FnlHJbE1XJIRoIxjNP/Dy+7W4Hz0/rcssA8mR/bubKHr2yvKdrUfLAKKa
         wSIw==
X-Forwarded-Encrypted: i=1; AJvYcCWjJdn9iu2bOerQIifMJfxvx04fvkq/c3KeoO9Lpe/dpH70U6R8DnKBgMz63NaVlFI+gufzkJAAmmy8p9eJ6TiwVF8GkOaawAOrqlAE
X-Gm-Message-State: AOJu0YyIxkWjkjUMEaLKZi40xwSFVBx/OR3eY5HXfCycVnvHs7LW546s
	rY8DbIilKji+pJ96ikedaPoDSu5dNX+UbfSMsNd/mSOeimCmv0KFV3CLteq3HT8=
X-Google-Smtp-Source: AGHT+IFtGs97y0VMDfO2OhQB/ry3UAI4ptI/hO7uxjdRojwZWz8iiYnHMR7bQDffv5SgR7y3tY/Leg==
X-Received: by 2002:a0d:dd16:0:b0:608:91d2:e927 with SMTP id g22-20020a0ddd16000000b0060891d2e927mr999220ywe.30.1709174619073;
        Wed, 28 Feb 2024 18:43:39 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:38 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 7/8] Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
Date: Wed, 28 Feb 2024 18:43:24 -0800
Message-Id: <20240229024325.453374-8-tdavies@darkphysics.net>
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

Rename function rtllib_FlushRxTsPendingPkts to
rtllib_flush_rx_ts_pending_pkts to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix commit message 75 char limit, and alignment warning
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 0581ed1e9ed1..04f3fb54d1b7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -268,7 +268,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto on_add_ba_req_fail;
 	}
 
-	rtllib_FlushRxTsPendingPkts(ieee, ts);
+	rtllib_flush_rx_ts_pending_pkts(ieee, ts);
 
 	deactivate_ba_entry(ieee, ba);
 	ba->dialog_token = *dialog_token;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bbea287df535..9d9420f7a371 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1811,8 +1811,8 @@ bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 rsn);
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
  */
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *ts);
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
+				     struct rx_ts_record *ts);
 int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_info_element *info_element,
 			    u16 length,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 051371e0138c..06992450ef42 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -487,8 +487,8 @@ void rtllib_indicate_packets(struct rtllib_device *ieee,
 	}
 }
 
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *ts)
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
+				     struct rx_ts_record *ts)
 {
 	struct rx_reorder_entry *pRxReorderEntry;
 	u8 RfdCnt = 0;
-- 
2.39.2



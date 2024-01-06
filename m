Return-Path: <linux-kernel+bounces-18507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02351825E6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50559B21F22
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802515EA2;
	Sat,  6 Jan 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Yq2OxSEf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C42107B4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9e62ff056so263564b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520583; x=1705125383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N42mZy1RgaAJUilwQhTajtyKurcz2hbVBGVg2l51zRg=;
        b=Yq2OxSEfziqbKiwjOV2hJtafpH+VgHWzjDmypSOvOGntSQysIFcFfe8p0DUJOhNlZf
         Kn5E3wv0SnpLWBvyHWJLYznAjxpdPrNLAmTExFUWVM2mqiWAGEK/p6XsUfgJKHcRdPmx
         E8SXYuya32Eu3GeuSzFTcXqmw1l5oALpDXv3u5D0RcErL/s+iZqliX70gXDbu0BodlxF
         nezcHM9YDzesIA8ZgMdAqb5W/Z4BEX7xSkbW4EKEm4X/75c2RnXbyHLRTha83qp0eQlD
         6chgzcADbB05glnmzpI9W9DGvRhOnETvC4cCA2B0C3Bk7B67k4uJhzLFdtMXMI3k+Bbe
         TIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520583; x=1705125383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N42mZy1RgaAJUilwQhTajtyKurcz2hbVBGVg2l51zRg=;
        b=oAmlST0AAblKYIbz/muBqq5Gy23QKlhlhZyLQP4/nnM1rc/vm7mBHznIFYXVd5xsiO
         uRG7RSBw/HwUm/lJm3eWcxWfuY8i48fle3JDOcRqcBynNlYvG5MDaGkpHkO+yb8h6Wih
         1F2kYW4/cOX+V94LnCR/YlmE2zKoQU5Mg8zDtj8Keo/wAL+ebb/Zq2d3CRgn/Mm8q1vz
         Rejn+JICS3DJpPmKLTbVKufyoKUlX/NMtH1N/tP6ReDlot5pjgAMBVfKr4Sob50wmdWm
         g1CRezNwVtZvGjHU51y0ibYooHKSTBBtxy7zbv61UKx8KUbwj9FagPRZh+pNhIgDhp76
         4v1w==
X-Gm-Message-State: AOJu0YzHJX5CPA8bXIwb2/UTW02Yw2K7TYjHULvenLrXoW3/EDi7gkts
	p9LOJZdlok3GRf4hnecEXUDxjicXr+itFRa6AuP9EZjQ7rg=
X-Google-Smtp-Source: AGHT+IFNgYABUJkfp3G/eZs+VA7Zg2b6D0hFV/4CrTYr/uVIryh0+5T5Bp8AnxH3AVY4cv7otCv7wg==
X-Received: by 2002:a05:6a20:4f2a:b0:199:6afd:2dd7 with SMTP id gi42-20020a056a204f2a00b001996afd2dd7mr497101pzb.31.1704520582886;
        Fri, 05 Jan 2024 21:56:22 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:22 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/21] Staging: rtl8192e: Rename function SendDisassociation()
Date: Fri,  5 Jan 2024 21:55:52 -0800
Message-Id: <20240106055556.430948-18-tdavies@darkphysics.net>
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

Rename function SendDisassociation to send_disassociation to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d20a1809cffd..c453af8dec47 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1662,7 +1662,7 @@ int rtllib_rx_frame_softmac(struct rtllib_device *ieee, struct sk_buff *skb,
 void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			    struct rtllib_network *net);
 
-void SendDisassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn);
+void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn);
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee);
 
 int rtllib_softmac_init(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7c5056f9f6f5..b422ffbf0cbc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1998,7 +1998,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee)
 
 	if (ieee->link_state == MAC80211_LINKED) {
 		if (ieee->iw_mode == IW_MODE_INFRA)
-			SendDisassociation(ieee, 1, WLAN_REASON_DEAUTH_LEAVING);
+			send_disassociation(ieee, 1, WLAN_REASON_DEAUTH_LEAVING);
 		rtllib_disassociate(ieee);
 	}
 
@@ -2199,7 +2199,7 @@ rtllib_disassociate_skb(struct rtllib_network *beacon,
 	return skb;
 }
 
-void SendDisassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn)
+void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn)
 {
 	struct rtllib_network *beacon = &ieee->current_network;
 	struct sk_buff *skb;
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index f92ec0faf4d5..55a3e4222cd6 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -636,7 +636,7 @@ int rtllib_wx_set_mlme(struct rtllib_device *ieee,
 
 		ieee->cannot_notify = true;
 
-		SendDisassociation(ieee, deauth, mlme->reason_code);
+		send_disassociation(ieee, deauth, mlme->reason_code);
 		rtllib_disassociate(ieee);
 
 		ieee->wap_set = 0;
-- 
2.39.2



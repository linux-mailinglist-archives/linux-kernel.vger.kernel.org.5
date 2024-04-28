Return-Path: <linux-kernel+bounces-161621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03058B4EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661E11F2337D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370B537F1;
	Sun, 28 Apr 2024 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="J+atn9b9"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667884D9F7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345281; cv=none; b=mt73M6U5KQhITRXMzFgNl8t1Ci+/jz7uSe41P9Z+QtPlToxD/AhTQ/EO/SG2SLXbV2e1/xJfnf47ztaH/sCK3TBQMno1LJZFUO8WPFgX2SmQViAR2dGkDgPgYhRVAJJGiPa+FXji0XwdL4x2cL+qCpREEgiooL1NRX0TIX4xuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345281; c=relaxed/simple;
	bh=nGuLL4RKPCE7yaSjVqYjxISvtQPt/Yf3Og+qjS5d1yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHr+5aEFmD1dF88Atg1Lgmav2fhknAxwE0ckP7I+C4xPF863VC6I7bvb4Sv7KwDJbTgLUfaMmJeAEPK2431jopkB2yTZtcF8kfHH6Q1lUqU5QBQIpCb6hf/pnGQBGdnt4E6LCIySau1aD/QzhXTSPKhgdZwN4MQIjq3nt1tEm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=J+atn9b9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-602801ea164so2577716a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345280; x=1714950080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEMkCtn1Yy4qZr3lqWt2ugCej9fr4XUo1QhaApMv26k=;
        b=J+atn9b96x2Oy58hHqjXNsAazXpP3d8hd5uPaXC10i3JmTEZgTAM64+Ymhl7CMvgr9
         C7XSnimQC03Xb/whed+7wnYFqY4YlGl8EblcvrazG3k28Wi4aq0/h12iAUfZTKIlhDs0
         baqR2Bvwqx824xPGTWrx5DnMU8ZI4+Wh2GkFR2Ap2qTcMeJ9gioUQtfWww5iyq1M+rSh
         bPLAxi/DgOjJ9Tn3hFlBlcweHVD+cSGeLFOI/pXXA7u7ik3z26tK6Ad5QidDafETMeWo
         LPYH/xp99G2nMFT4xFmcQUpUkZmYW6eHZbEfkvr1W5mReXcMD6ulviZjuxJELU/hR9lY
         Y90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345280; x=1714950080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEMkCtn1Yy4qZr3lqWt2ugCej9fr4XUo1QhaApMv26k=;
        b=m1oYutg4t/raEuCQLjAACePDi2emA7pHKnAmMZvrcVqxe8RxoQ8lrdGE6MwtpxSEbI
         S+cTsst42ua/m/WFGVXalqj31sNW4Kwwqbm7SqB/+ahRyji9Nru2NMWC1BkSwVaUamnB
         5XH0LV+Xu+AxOYsXfhp4aUfRkGjLKvTDE2dBfhfNEzJFqKoOnwCFeTXZvmmpRVvwKj1+
         yDWHPlWyFtXqXxKx4Uia07sRCr9jnEhodQLWdpIT0cLZXFbq+LyasSRYCfqDagHCud8V
         3VgQHTT+DaaZWyb+oqfZnqxmY1Bnu3toAMKv4eFLFyQTPo9NAVT6EfyoKDzKaTxY+KzP
         GK4g==
X-Forwarded-Encrypted: i=1; AJvYcCXhAqhlF4pp/rG7zeU/qZFiWYygIC7/XY2WdJujsouCfmpurXLG/7plIV9bQU6ITQMNZ/kwWezWQWHiGqNG5SST0wfw/LvOlDSOsCCj
X-Gm-Message-State: AOJu0YwohD6kTeKnRHg3CKQBD7xfkj0WE8Lu5v5SwfG2pRBJKUfyscSO
	9mCiDp+JtOh+x9lbapKZFHESSfKZUk0z0KgRH5s3WIQ9FBgWWWEVnxmqdg6iZ3Q=
X-Google-Smtp-Source: AGHT+IGVJtNtkm44IGMVRFPIe6AQKCRnh3rzMA6pHOQxPfrYuyXCrf+qEC32RuYYvgxD3obss6f2aQ==
X-Received: by 2002:a17:90a:6c88:b0:2b1:bb1:7061 with SMTP id y8-20020a17090a6c8800b002b10bb17061mr3261931pjj.44.1714345279889;
        Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/18] Staging: rtl8192e: Rename variable MPDUDensity
Date: Sun, 28 Apr 2024 16:01:04 -0700
Message-Id: <20240428230106.6548-17-tdavies@darkphysics.net>
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

Rename variable MPDUDensity to mpdu_density
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 425df93486b3..5cea0d8ee544 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -40,7 +40,7 @@ struct ht_capab_ele {
 	u8	lsig_txop_protect:1;
 
 	u8	max_rx_ampdu_factor:2;
-	u8	MPDUDensity:3;
+	u8	mpdu_density:3;
 	u8	Rsvd2:3;
 
 	u8	MCS[16];
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 516e48073dc7..85f52d09304d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -275,11 +275,11 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		   cap_ele->chl_width, cap_ele->max_amsdu_size, cap_ele->DssCCk);
 
 	if (is_encrypt) {
-		cap_ele->MPDUDensity	= 7;
+		cap_ele->mpdu_density	= 7;
 		cap_ele->max_rx_ampdu_factor	= 2;
 	} else {
 		cap_ele->max_rx_ampdu_factor	= 3;
-		cap_ele->MPDUDensity	= 0;
+		cap_ele->mpdu_density	= 0;
 	}
 
 	memcpy(cap_ele->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
@@ -479,7 +479,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 						      HT_AGG_SIZE_32K);
 	}
 
-	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
+	ht_info->current_mpdu_density = pPeerHTCap->mpdu_density;
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable = false;
 
-- 
2.30.2



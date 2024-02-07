Return-Path: <linux-kernel+bounces-56525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E084CB3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2311C267AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6E7CF0E;
	Wed,  7 Feb 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8SZXyG9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543D7CF14;
	Wed,  7 Feb 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311478; cv=none; b=KkdUeA2cnRpzMzQMt22ZPHCAeJtwscA5aO++V+m8KSjmhYU/nSuGGtSWQR6Zd00BOEcD64Zlp9F4nTFp0k2Rop5dL0PKV50YbOq6lhGzpdtOKVMHNebkYaICVwJ9WOsuFLE90w8c1Rg+LiDJko8mSVSaqIFkiTdgUbNOQYsE6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311478; c=relaxed/simple;
	bh=3GNprG9wTEH4DW6gV31U3iQPEU8BXqZEBULVqbe4ifM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XZGGYiCSQwMkwClzVhpvcSuvIUZta/+O79PEIpQCR5iM7cFpIb/cnpkC7I+HHKeLM2jJnXzeWqwy5P6nVtQxjWatNXAFLcWDFZlXwTke0nR9AjkDrNZj666qYhxuKshh7c17xjPYlS5577ZHCIeepC263KInwKqMu7x9StC652I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8SZXyG9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3392b045e0aso391526f8f.2;
        Wed, 07 Feb 2024 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707311475; x=1707916275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1RihZit+1vSgq9G8FoQ/W9gis9ZTbZPo3dwEeqShqE=;
        b=a8SZXyG9Nk8kygk571Ar1NQu+FpT4dWv4tlsjK9BGFtfV0qGSau6wTyEqRyZRxqaY6
         43AcE5UK6bm4psGfcm+1XeV4LmT1y1xhO1ZOZqzIdUA/0lfY3X81TXle0bGgJZyy+W92
         nDLZ3FPXRCg3Y26vBZ60ejADlCIzK8quhOiqEJ986l7inIR8d8JXc+FzPoeHDp6IgCiw
         2uzu8YN8ehUvXWekrCF0GzMhqHPy/bGDZx61WbNmUv91HJKgntGrxzfcJP7Pxauc69UV
         +NbkgkD8PXiJBJm0nvBDBKQdZ0TXA1Uh3Qw2K+96KPesOZgC9S0KSU233EgShv4Ihdu0
         fHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311475; x=1707916275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1RihZit+1vSgq9G8FoQ/W9gis9ZTbZPo3dwEeqShqE=;
        b=wwF62T1nsLm5Yk1h29WOpMCjnXRwP3Q3BY/tSC8IVNxJTMV/jwA4BQB23euRAL2agg
         l9rIW1ZmVqRhLVS7FzLHW/w3MMDGWdY/WGv5d1Oe224r6CDUzbMiEiPYnwhQTsSCny6N
         3GLrq/NlTBJfPKsvVTwftAgz2z3ntKr3PrdDImk4v9pOd7/LvLi6Qj8B+4TlBdhn52fZ
         JRESnprfKtGEYPE1wywoijjb/KK5EOSp8il9ALR8OsO/0Z0OHKPMvPHB2s0Uv8BALDAr
         lqkT1o3Cy5DTxdaREGv51E0KXNdFV2eeanswX5Z9pE5q0gbOxmQH4encEx4L1FmFB32P
         X19w==
X-Gm-Message-State: AOJu0YxnbaV8LhWXV70IBI6kTgBCGvp2cYW7ZED1srV8NOLdDVNMVPsR
	eZTlImvYw0hYJY1fdZs0LkvWpaQNw9hKYkFxranB7DlkIRFMdP9F
X-Google-Smtp-Source: AGHT+IHLRqhcd11KsozD0d9k4SiStaKrBqSgCjQkcM99WIB8aENFVx+5vi0yiVtlNyO+oDye/aqZRg==
X-Received: by 2002:a5d:42ce:0:b0:33b:159d:8222 with SMTP id t14-20020a5d42ce000000b0033b159d8222mr3226920wrr.23.1707311474773;
        Wed, 07 Feb 2024 05:11:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxT+EHwt8qDaK324BHNX1CyyMnptoy+k5D9JtRhhA1qtfS43fAC/uTJ4azFCLjq6qUy7yHXJqptwncrq6Zz30BIraarUAAg4aCZvz8doOJrrFc5vzzMwjOj9mm50yrQ35CXxMmE+zI6uqz26O5PO4Iwgc0A14U40+jvVkCVgqgkHMS4CbNz1SOSgEAMkT1smp5i76gFJPdxvh+S9uH9/f6FaY6F//7fwAYg0UqJKzHnUBzPGYYh26PWt0iFjZTb7cXphqLsimqqMcaa/Mv0CpuAaCGmp9KwvDIx7Sx56P+aCSMSwYcGy+jKgK/Qz9FQL05rZXZto2cecoNE0g0VGzFl7aNCjiSDZQrU/5I+rdUp8xbIAYqTqxYPzLOvvkRKBMWia/ao53w/Y4WIFtUzAE41q2tlsdpV716qgD09uwXllHFl1cnfwPIqQCg+VsLxCOsOrQ0SGaFI6R2oxXwLW30rIL5/ZurvigKqxEyghfWT6K3KHcjJKafjyRsesv8YA==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d67ca000000b0033b4b165aa0sm1525798wrw.74.2024.02.07.05.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:11:14 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH][next] mt76: Remove redundant assignment to variable tidno
Date: Wed,  7 Feb 2024 13:11:13 +0000
Message-Id: <20240207131113.2450297-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable tidno is being assigned a value that is not being read
and is being re-assigned a new value a few statements later.
The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/net/wireless/mediatek/mt76/agg-rx.c:125:5: warning: Value stored
to 'tidno' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 10cbd9e560e7..07c386c7b4d0 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -122,7 +122,7 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 	struct ieee80211_bar *bar = mt76_skb_get_hdr(skb);
 	struct mt76_wcid *wcid = status->wcid;
 	struct mt76_rx_tid *tid;
-	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+	u8 tidno;
 	u16 seqno;
 
 	if (!ieee80211_is_ctl(bar->frame_control))
-- 
2.39.2



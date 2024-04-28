Return-Path: <linux-kernel+bounces-161622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14738B4EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B2D1F2354C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315D54276;
	Sun, 28 Apr 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="G6GXOFmB"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA2524D3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345282; cv=none; b=kT1+oAGAXWQEWkrEoTqdluOwMTeJY00B6YMs7+QmSmwNyMqG0Hv3FTqjJGhEoVgzt488A/XUhfTaIUzV8EQrUpZ6DFsJ4sJG6oVRHU5UfpY45aWwZV9MkWtl7Uj6hikBzTwsHIKLWkyBobyIHdDhzDIjPTvMHh4+/WekXnX29xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345282; c=relaxed/simple;
	bh=qQ/St9MRrbQlh6XGE4IiWOWataPu4BlfqsA8KBonyIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkU73vd7tXgIb5edA/j3JwMVlpI9rOKLG7oHbMDLTxGrZIogAdueOHVt5aAozea3p4mLv4qq6PiLPy5o95D2mBbCkCfd1NKfWLA4FVrAdOAcFJJ+ndwWPOHyIeiJ8BbaqjsD59LnaduSvkjd1ZK/lA2y5TnNNGpw4ymOas/Tq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=G6GXOFmB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so2549681a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345280; x=1714950080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5O7LSPqO38x2yv5lso6jMT1krZ5OoXK26jYFy9ODQw=;
        b=G6GXOFmBYrMEUchEf9Npsx+WlO5W54gWTNZE5K/LKhZnGsAUkNwMUJBXnRicFa+P09
         vMoOt1iRCumAlt3xGVIBGf/TGrbEDxASXL1molrOGr3ulHdty4vC2YRGf4RUnlWLXxQX
         2CymMH5uWDoe398CFrb2uyIw71ZZLOlK0OO6MgLgHc1m6N8zWLiwzOeHA5/7DWqBliLf
         8Nr1RGU6fxlFKqm5hzBDVzzoZnfhDCRGTQGuz9spgcfINHiY2/yNm1kcQwEYUVpJ0kzJ
         or7/uQvYAGloD2haya7NUGSSzxnd/7gdblHl9UFL0o8FMNvAaMgz1t2lHqc/OAddMvuf
         j1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345280; x=1714950080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5O7LSPqO38x2yv5lso6jMT1krZ5OoXK26jYFy9ODQw=;
        b=ovnrv3CF7vYCHG08XrM8mtMlq7BFvj9Rsn7QzlAEoMPfYKSNnTQlTGs/Ij2rCHXnG3
         QtVNcIsX7GTzMuflPglmlZ9wf/qsln41ADfJuqDt7xjGTd8NdxapsuJZk8+85ZQM9g/X
         xW3OQoAHiYY825N1NVt5sGoet5uAj2P1mCMh5feCtdTldmvx65hpUBzQkEIUz/BEj0oK
         DzOeAlhpYEvBz+ZcEuk0meTpfoP0MUhxUPEdPmGe84g7IboqLbjiK+/bpNNQZ+q1pxOw
         z6aHtzkD0PdMvH6RMn711Fig6Bu+MSYxuzoxrd3eC62vEI7LUfLisxVpwz7+IVP+XFDf
         3O6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLOGXSegspl8g2ipB+KF5EApK5c+DdpC49VYb1YUPXSQiyvmPWBYyGuDGc+WCiWXKfoY/BbnzWdrXuIPnagQXKqM99sV/pBevT6oNq
X-Gm-Message-State: AOJu0YwM3aRt13AH5wuQVZhHlTXSojLBeCDUem/yA03PDd9TIBFxZF1c
	TbMdeZ+1z77f/Y/IByvlkfp72Ec4jTQ05nFkFiDYOvna0FD9o2f204wERi15TVQ=
X-Google-Smtp-Source: AGHT+IE19aETjg/TUkXMV9BW0joAUugxtoa/9FmjHpAkcgbl4skRlfGuH+B4ItWRJsYj7gzaAisRjw==
X-Received: by 2002:a17:90a:de93:b0:2a2:f25c:c250 with SMTP id n19-20020a17090ade9300b002a2f25cc250mr8624814pjv.11.1714345280503;
        Sun, 28 Apr 2024 16:01:20 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:20 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/18] Staging: rtl8192e: Rename variable ExtHTCapInfo
Date: Sun, 28 Apr 2024 16:01:05 -0700
Message-Id: <20240428230106.6548-18-tdavies@darkphysics.net>
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

Rename variable ExtHTCapInfo to ext_ht_cap_info
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 5cea0d8ee544..c1446081956d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -45,7 +45,7 @@ struct ht_capab_ele {
 
 	u8	MCS[16];
 
-	u16	ExtHTCapInfo;
+	u16	ext_ht_cap_info;
 
 	u8	TxBFCap[4];
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 85f52d09304d..963d69680049 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -283,7 +283,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	}
 
 	memcpy(cap_ele->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
-	memset(&cap_ele->ExtHTCapInfo, 0, 2);
+	memset(&cap_ele->ext_ht_cap_info, 0, 2);
 	memset(cap_ele->TxBFCap, 0, 4);
 
 	cap_ele->ASCap = 0;
-- 
2.30.2



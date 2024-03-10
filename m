Return-Path: <linux-kernel+bounces-98373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386F87793B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FA8B21387
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890633D38E;
	Sun, 10 Mar 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="D+EYgsdl"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0313BB50
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114960; cv=none; b=Rv49ZPPZWzDW66l9+WQLGzVz/5fXjU6IJIYwizZHf5lnVe3+dDqQtBk5ORaqduVlKgVuwP2id5quppD2+VDaC7FznSGUfIl5OD7hwq2Hei97wVhDKa2qAqIm1IR+CM8ZimqJiqftoiYEAwie3I1ul6Q4xQfuG5bxWKDclJO4oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114960; c=relaxed/simple;
	bh=QMV0z9mf9YDD1V2uvitlkWMmFWbtS8GiCtqxLiRVx6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbD48nQJHSNkqPSkO685LRd1KXCtnGWbtdvwuKD7QatSc8wfNITg2PyxwYJ3QxJaAp135LlooeKFQhZQbe0rvQ7oqYPM5pgUQarq67HgT2+vGgphO5qhVIloF8I95jtJrqUgAp0sIHsWJ8PuZkTV+P6uiM/98ECtM/ilpLxT3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=D+EYgsdl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29b95c02ea2so1644631a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114958; x=1710719758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9TYrldhcrL23tvPQUFhNBx5Yj6HnYD00fOJGXP/nac=;
        b=D+EYgsdl+L3XN9qoQ0O3tFgANArKJvTjozz2iAg7jJgDA5+3+e040RPzWoh7slXzI3
         5Ar2WWBC3YSZEc5Emja8nQuuMG99XDIPDrsHnHvdVmy8U6v6oubp7xe9fbVeCFbX+3YQ
         ZpujJa1Ptgrxl6AdiaIZtnbtR32EOz192R7mudrnKMGWYMzCpcwzr16mYttYOs9oGlqL
         O0bu7r8NCS/1rIKGRJnj8fYgRSBGTltYEcHKjPXSmiS6dR/WwUNxl2hVkWTaNVzeKipT
         wAAK/F63jJ0oAg+yK0HheSt6b2KWwryHYV3CBJjqqyR5deYQoutXuBWt5MjjMxY+V4Ul
         1B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114958; x=1710719758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9TYrldhcrL23tvPQUFhNBx5Yj6HnYD00fOJGXP/nac=;
        b=X8KHQFOVPS0Tjm03wKCtUE8uMXfKcpt92/Q7uBD40b2USjEYeUCHt8pVLjSr2W0W8y
         HDfZxZ1NcWMdn4TfTm3+cpKxk29ZWBhh7/AWsySW1gXYXGnaf6kTRGVAN2GnxQX1DBp0
         sTISm6YuZ//D5dxL9gkoK1rtjQ3zxvZsT7mqNSDPLqkkOawZV1M525fTkDvlaQSPkpjc
         tu9V8QwTQvVumkinjY59sKh4CI2uncGVDVOL9RLTK+Jb6tV8sYOzP+83ndijYXwZrhsV
         y7Av+ziYUYIRlLX/RuqG9QD7NqcLXX+0TEASICXAdvX6OKVGOC4dpnGg3QebvdX6Tc4D
         LLzA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPi8+Tq8Cm0rgYN/TzS97DZis3r9YkRhqTpmYlbig9mtehhm/AgYhQdwYQwl/PhTmE/solD9xHLby0DOl25j0IjY3RLabga+UgFz4
X-Gm-Message-State: AOJu0YyLxSK7yDB5N8XQYv6nHJz2brI0+LQibF2jttoWUmCuN2OP5Vrw
	eiBHx1dMBJgTpQ74PNNRx3pY2FkeGgEmVIOHOM/EMW8N4TugClk01dIYP+jrJkk=
X-Google-Smtp-Source: AGHT+IFuVkhYJAzUsK7cjL//XGCmaqOPV5lvrzEu/IMY3yWrVmtaT2/naXMOXeLxEmgvfGvntiYQIA==
X-Received: by 2002:a17:90a:dc0f:b0:29b:364b:79e1 with SMTP id i15-20020a17090adc0f00b0029b364b79e1mr2598069pjv.25.1710114957753;
        Sun, 10 Mar 2024 16:55:57 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:57 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/11] Staging: rtl8192e: Rename variable TimeStampLow
Date: Sun, 10 Mar 2024 16:55:43 -0700
Message-Id: <20240310235552.4217-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TimeStampLow to time_stamp_low to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e3ed709a7674..480315404969 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1659,7 +1659,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->bFirstMPDU = (pDrvInfo->PartAggr == 1) &&
 			    (pDrvInfo->FirstAGGR == 1);
 
-	stats->TimeStampLow = pDrvInfo->TSFL;
+	stats->time_stamp_low = pDrvInfo->TSFL;
 	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
 
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b2b8947da89d..72264e1ef877 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -482,7 +482,7 @@ struct rtllib_rx_stats {
 	u16 bCRC:1;
 	u16 bICV:1;
 	u16 Decrypted:1;
-	u32 TimeStampLow;
+	u32 time_stamp_low;
 	u32 TimeStampHigh;
 
 	u8    RxDrvInfoSize;
-- 
2.30.2



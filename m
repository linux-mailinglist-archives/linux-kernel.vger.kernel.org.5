Return-Path: <linux-kernel+bounces-10194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8181D120
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3BF1C248BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A23EEDB;
	Sat, 23 Dec 2023 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="cDBj13hQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA15D30D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35fd0154368so9796055ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296795; x=1703901595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK33ly1MosSrec0UdEAxdptOYynizC2ap2lje80pN3U=;
        b=cDBj13hQ8HX60dnJuApe3JmtibC1B0Sw5dCIucet/mRben12Bozxzvu9/JVozffQF3
         0lJzKvuBWcHz8yfz66o16K69nvejI2Y51ERvAHVsR+dd2RG/b7ZazW3V4Im34W++9EZu
         zlTVzmlQAlCasgGwpDUfa2VqULs0OOg2xmWrxfYvUpvZ23+/7dRAD4pbF2CqdOKgXeOJ
         Y5HS0eKT3vA/8wp4sUkKzs7mBuXIgxMeiijw6HPK+rQ1qPd5PzvbPI7+UoDXvqCDxqsB
         MAZ1xkQywn9eUx5sL397vQgX7MbPPGU3S00+rvCT05oxeVzqwVGmytd/RNqHjf8AgTg8
         hIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296795; x=1703901595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK33ly1MosSrec0UdEAxdptOYynizC2ap2lje80pN3U=;
        b=m5axU11kdf52Kaqt/YF4zybmIX0pF1CRz52uzwKoXXg8ARanuxPwnNbKekDVSkanft
         TxiRYuq1fJVs7WRlEIdeXJIEay10aT3WFft2DerCnKOwXUZOFGIjFg1G6QkALxWpIWlq
         gIMZrf4qB1VIuUCSYosb+o//xPJyaWuccZty+YBSVMG40KjlmzOWQgcrritsNElge4nR
         uf/zkoSYbtQsH9zs77znoVTl3qfgLbMfcdbL5eS9I1o7j3aym5/Y1cYaZh9vJ37DHZjd
         91HxWYsASD8iHeMwZy2W+Pw2/rmp0wJk8uVp8Rlw0+XgMn5bf7Ru8cT61MagKhoFMYkc
         2YSw==
X-Gm-Message-State: AOJu0YyiY1ZXvc3oGyueEKOZoF45P3iPOcleBk0m+vkJGiMsx5e9UqJD
	fmfz770K91hA55KDuIFWGA15AbcrnuqRwg==
X-Google-Smtp-Source: AGHT+IECAxaMCg5nwzs+egYRazIwcfuxtVkST6lQYr5PcSec0/NZMr7/OMZy+xMwprzqgJTQP88oLQ==
X-Received: by 2002:a05:6e02:16ce:b0:35f:a1c8:a6e1 with SMTP id 14-20020a056e0216ce00b0035fa1c8a6e1mr2796020ilx.58.1703296795375;
        Fri, 22 Dec 2023 17:59:55 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:55 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/20] Staging: rtl8192e: Fixup statement broken across 2 lines in rtllib_softmac_new_net()
Date: Fri, 22 Dec 2023 17:59:33 -0800
Message-Id: <20231223015942.418263-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Join 2 lines to fix Warning: Lines should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5d14d7c0f8c8..c268ed6451af 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1225,8 +1225,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					ieee->ht_info->current_ht_support = false;
 
 				ieee->link_state = RTLLIB_ASSOCIATING;
-				schedule_delayed_work(
-					   &ieee->associate_procedure_wq, 0);
+				schedule_delayed_work(&ieee->associate_procedure_wq, 0);
 			} else {
 				if (rtllib_is_54g(&ieee->current_network)) {
 					ieee->rate = 108;
-- 
2.39.2



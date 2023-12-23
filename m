Return-Path: <linux-kernel+bounces-10190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790ED81D11C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35934287A96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A8CA5C;
	Sat, 23 Dec 2023 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lQDLIyK3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91038833
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b435966249so94969439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296792; x=1703901592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jCy9bDHWWDrYNxTyZC3ql2IYfO4Cm2hVECTFukepCU=;
        b=lQDLIyK3kGJVFqRp3iCu5+2NMdlYrAKuJ0PC4eFtFPomdnkN59vexQtPjTA7pMegFh
         EE0eAbMnq25G+2ZIs46bsyXI6/g9i/ALmVv09Vij/jkqSRqYXN1w0F0NSqOLfoqQ/F4g
         7NKjdlZ/FTbxH23+Qvani56DsXrlseRxelqBtPtY8vIkS864VpBXeczxUVwRSId75BZP
         vZ1rI4UXUcCMYPpTEJY6G8GTJNiizQel7PgZ2i5NNGHSdlo16Ahni1eLCs8xIPDC4DOs
         IOTmqKw7fNwtmRWarPupIEXBoGIWx7dohNXyx2KJN2Zu7nw2Nv9gCbhl0xIY12ehB9XI
         AL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296792; x=1703901592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jCy9bDHWWDrYNxTyZC3ql2IYfO4Cm2hVECTFukepCU=;
        b=HeciW43WV0VmYXtUyOPj4H+ptk8MhhSbTGvCPlFQXUPJC/Hu5dMqQ3t7DSCHadjRiK
         pnpOdN0Wk8nQJkm9msI3ypLi5n/a3Q4jDqSoAVTzpgqFOX2JE/4pZXpS9Mkjlw5v9Rxm
         WT2+JvKgVPPhbfGbs2bcXRtj08VrBzx3fkgOAbTz2DZSYDN24bMNcaF763mOd1o3JdzJ
         5hPEoGP8f4aIGDjFFHAfWXjhbmqatk52E5Uk6bb+YuDbR7JFYCM+4nKLkBpX82PyQGgs
         BwLMQvznwNfNvjYX9mvWrYhUg9AvI+bItrNe3Kn+bA2H8DF+3hr39hh3SlzuIKRpEWJM
         /5EA==
X-Gm-Message-State: AOJu0Yxlbkcs/Af+6jLO8fF7SscDx7N01kngPA8IS+8URc8t2CnnH+nL
	83FSnAln/x5wxSonh59eAlVFt67WiBuXCw==
X-Google-Smtp-Source: AGHT+IH+XGo4K77I+YRObnabMqaxekoDx5/KWLJjeqrVLRshinHN3xlyzzR+eA/PzfrGiUFYk7SyRw==
X-Received: by 2002:a05:6e02:2220:b0:35f:e26e:979a with SMTP id j32-20020a056e02222000b0035fe26e979amr2359392ilf.38.1703296792026;
        Fri, 22 Dec 2023 17:59:52 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:51 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/20] Staging: rtl8192e: Fixup multiple assinment in init_mgmt_queue()
Date: Fri, 22 Dec 2023 17:59:29 -0800
Message-Id: <20231223015942.418263-8-tdavies@darkphysics.net>
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

Break multiple assignment into 2 assignment statements to fix checkpatch
Warning: multiple assignments should be avoided.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ba6da717dc7e..b55e5759ebef 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -134,7 +134,8 @@ static void enqueue_mgmt(struct rtllib_device *ieee, struct sk_buff *skb)
 
 static void init_mgmt_queue(struct rtllib_device *ieee)
 {
-	ieee->mgmt_queue_tail = ieee->mgmt_queue_head = 0;
+	ieee->mgmt_queue_tail = 0;
+	ieee->mgmt_queue_head = 0;
 }
 
 u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
@@ -1911,6 +1912,7 @@ static void rtllib_link_change_wq(void *data)
 				     struct rtllib_device, link_change_wq);
 	ieee->link_change(ieee->dev);
 }
+
 /* called only in userspace context */
 void rtllib_disassociate(struct rtllib_device *ieee)
 {
-- 
2.39.2



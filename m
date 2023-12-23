Return-Path: <linux-kernel+bounces-10199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49E81D125
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97FC287B42
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9572421F;
	Sat, 23 Dec 2023 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MXcl3VYi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631215AE0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d427518d52so5662405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296799; x=1703901599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKaTV31asg8HNjRCozcslGmEYtbSfFrvyCRGCul8iCc=;
        b=MXcl3VYirGilgof+Pfh88XXDAxUMS0tqmIa+GdqIYpNLB7Av0ky5HgUXr/Y93s9jwN
         VQue1Z3SVAKQWp/GahNjCGQiJhn85KrG2+5PZB1/Wio1eo2At9oS7j1sy5pcla4/5I2a
         nVny7yEaSmOlP0bd4oIXVMaSQFS8Q7Fup+zvvFf6KBwF5nVQELwG+z89a5r1fJLgm2jK
         J+kjldUS/JTit7fQUpVSd/qpT2HIflqKmWG2Hi+v3SkW7PLDAJ6RKqYVTyjF0NCKpYCs
         2KZ3vakqz2m2EzvPBOmpBU0IfUg89yXPxhVfbsAe/OaUaKfFfy2dKq9jdUIs5s2Ro7aT
         K4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296799; x=1703901599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKaTV31asg8HNjRCozcslGmEYtbSfFrvyCRGCul8iCc=;
        b=bt3WdGlkzQM+GC6Giu1H89SST7kuKm/sDvGcVuH5Ya5PgIUQi4gXAZGGsAD45xFayk
         pAQtxJIxCLI8b2dYcw8SSbZiRGCv/h9S4ryEWCkty25SMwcnlDyfWq9/8VYP5V5NwWPm
         V1ruOG42NhuyW1eDNO665/BPEdtcZsRESPh7QzEpfA6EPrx5Mpa4oLN+FjU8jSknhK/l
         d94nz5A9O2VZqQcoiOMy3SvNQa2oIK6aXep7TwKFVPm/e52YEWbRDplgp1kQHW3bMQ2J
         d/toVQZjODb/3zCiM/8qO2nIobpyi2QG8fKZTXmNr0Z7MtGMIvF5EmE79x+AvPg+Kc1J
         03pg==
X-Gm-Message-State: AOJu0YxZkEXeCTA6k+VFiUWOqbz9vLPyMUetYtSxg/vT4Efq9FPHGNSl
	284vwG/9IDmNx7rbvi0LUNgwX8+8czHiOA==
X-Google-Smtp-Source: AGHT+IFt/Qd3ttE7f9gbYN0UNDH45p0N6KcOyPTYbOXERDvJEGvVR9DPVIBFdgiOOYgL3qNjIabumA==
X-Received: by 2002:a17:902:be06:b0:1d3:fc05:81a4 with SMTP id r6-20020a170902be0600b001d3fc0581a4mr2196870pls.35.1703296799504;
        Fri, 22 Dec 2023 17:59:59 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:59 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/20] Staging: rtl8192e: Rename variable QueryRate
Date: Fri, 22 Dec 2023 17:59:38 -0800
Message-Id: <20231223015942.418263-17-tdavies@darkphysics.net>
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

Rename variable QueryRate to query_rate to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0819efe36171..1e025ef4bed6 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -141,26 +141,26 @@ static void init_mgmt_queue(struct rtllib_device *ieee)
 u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 {
 	u16	i;
-	u8	QueryRate = 0;
+	u8	query_rate = 0;
 	u8	BasicRate;
 
 	for (i = 0; i < ieee->current_network.rates_len; i++) {
 		BasicRate = ieee->current_network.rates[i] & 0x7F;
 		if (!rtllib_is_cck_rate(BasicRate)) {
-			if (QueryRate == 0) {
-				QueryRate = BasicRate;
+			if (query_rate == 0) {
+				query_rate = BasicRate;
 			} else {
-				if (BasicRate < QueryRate)
-					QueryRate = BasicRate;
+				if (BasicRate < query_rate)
+					query_rate = BasicRate;
 			}
 		}
 	}
 
-	if (QueryRate == 0) {
-		QueryRate = 12;
+	if (query_rate == 0) {
+		query_rate = 12;
 		netdev_info(ieee->dev, "No BasicRate found!!\n");
 	}
-	return QueryRate;
+	return query_rate;
 }
 
 static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
-- 
2.39.2



Return-Path: <linux-kernel+bounces-18508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E2825E6C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6221C23E23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDDA25769;
	Sat,  6 Jan 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BSHlyqdj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEE1097F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso186593b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520584; x=1705125384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwfwhIccyziHiwo66eg7faLZcAMdjGptODSVe+nyh+Q=;
        b=BSHlyqdjun1uyfpUKTAwclb7XuEe2lJOP4M3kaubPKZ7yodb/0shCPFpH79lDipRcM
         sxEfPFlvNwB29rIX4uq5EAtDuV33mhpmJQlSaOwyLXVQEhSToFKdmTS5fOmtvzp5T3vT
         0dzkD/ysSGEv5913mv4wXX8vBjhUcetutpTGufR8BhBJj6B67B8Y6VcNQ7/oVtllaly5
         M1MQkzkUI3NIiOZtOXnHfEZH6TtQ2Npeky315X1jaaBizUqkcqmgbNy4FAplfbO2YeY4
         f+InMzckeFsQLNdqsEsJTR4+CazvYa45OstgN+9gQv4I1B/aJPlUq0esImlEhlJVTCBg
         QxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520584; x=1705125384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwfwhIccyziHiwo66eg7faLZcAMdjGptODSVe+nyh+Q=;
        b=DMLXZ3Gz2eOwaxOmrXs7esmrUyl6gdlhgh05rN638p/TCrdjgPRvz/S0uW9bdE823i
         uVJALUHwdgbEgOlQIWKZjzdaTDhiwBFpKBRNi3555oA6QO+i4Z3aiRa+DpW95aK+Pi+5
         NNJpd0K29SSCAtfmxjAum7DLZcfftHf1AAEqyTZXs3/IkzbMXZnQJTGt+okj7EB5YnZC
         Cxwc0E1Fi5Aen+IJzjEyjq30zJyGdhWi9FikLVMTUfeMsWInz8vVHrepmnZIZpHI0EDE
         VnO2IcmQwlaK1evgYdxMd80r7ZAtiWHR7BkRAC2oHEGnsVAXfdQKBnr9bTjqnlLDVvS3
         W8KA==
X-Gm-Message-State: AOJu0YzpSnBaLQttz0hqlJEJNrlSuvxx2KK2+QLJTGIsyenms66RrcJ0
	/r5dvyYPVBfksvxQtyzbVSQdZR1pXmTzmC3hPB7E4sgbDds=
X-Google-Smtp-Source: AGHT+IHLv+e/knL2B/INmeZsc8iZq7Ok/BFetW23w2eIwIYNTqywnr9LhR0sSs0Xl/U/d6mSbtaKEA==
X-Received: by 2002:a05:6a00:464c:b0:6da:c207:a2c7 with SMTP id kp12-20020a056a00464c00b006dac207a2c7mr4692549pfb.15.1704520583941;
        Fri, 05 Jan 2024 21:56:23 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:23 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/21] Staging: rtl8192e: Rename variable bHalfSupportNmode
Date: Fri,  5 Jan 2024 21:55:53 -0800
Message-Id: <20240106055556.430948-19-tdavies@darkphysics.net>
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

Rename variable bHalfSupportNmode to half_support_nmode to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b422ffbf0cbc..5305486c9594 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1648,7 +1648,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	int errcode;
 	u8 *challenge;
 	int chlen = 0;
-	bool support_nmode = true, bHalfSupportNmode = false;
+	bool support_nmode = true, half_support_nmode = false;
 
 	errcode = auth_parse(ieee->dev, skb, &challenge, &chlen);
 
@@ -1667,10 +1667,10 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 				if (is_ht_half_nmode_aps(ieee)) {
 					support_nmode = true;
-					bHalfSupportNmode = true;
+					half_support_nmode = true;
 				} else {
 					support_nmode = false;
-					bHalfSupportNmode = false;
+					half_support_nmode = false;
 				}
 			}
 		}
@@ -1684,7 +1684,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 
 		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
-		    bHalfSupportNmode) {
+		    half_support_nmode) {
 			netdev_info(ieee->dev, "======>enter half N mode\n");
 			ieee->bHalfWirelessN24GMode = true;
 		} else {
-- 
2.39.2



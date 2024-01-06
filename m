Return-Path: <linux-kernel+bounces-18500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C372825E64
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16273284F8A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BDD524;
	Sat,  6 Jan 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="abPOdoj/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310FBA48
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbca115636so184927a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520576; x=1705125376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj0JkenWNM6rWbuHRbMOTpCWBtrPTE48Nz+nx7XWeWA=;
        b=abPOdoj/S6GqOI/8P1VF6k2vEnJJ6IT51dbLiQR6FFKJBD1tVLr447E1Tr21mXPp+m
         4Ir6mG4kyizOX8oc/hPoZXcxTaq1PRsj2cNMSPYCTMRychBnw2a9q+t9bpiLa2GHO2uf
         caOID4v3y6AfazFAQNRja1cNWaVzuvHRWilihjZ1FkuHxMZm7kB0XSqvJKkwXOuiKne4
         oT/MBaGWJt1wImyJDizPIpPWZf0n0S1XVhXdYue/AwVv24Sjpnmx4JPPtJZyU/qYEHkk
         2vbGbJUT5savtdaM7jWLcYrhJ4PTufId0fAS1kUnpoz6O4Zhk3ZT6lrO+KAQYKB2MGc4
         XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520576; x=1705125376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj0JkenWNM6rWbuHRbMOTpCWBtrPTE48Nz+nx7XWeWA=;
        b=lt68Uva5EyEfywwsvueByCkFLvVpLXPV1kv3jNxXjDcy5Yl1NosPszE/Jj1BEGHApT
         29+a2lv9GT24yqQSiKxbFa/9te29MvxLGHmYYHqiZqDVi9J2yYe2cgE55HIHA258l07v
         ImOelE4xoBTG/FN1RPqVKAoplvIdBMDsJJE4pqt68p801SHpKRPr7IWrzxrFFVuK4q6G
         IpcCGAjJwJfz49LPwAoEx3V1XHU1XYm+HRqJLZMgjvKdl/bZI17qmsYgAoEBz94Kbok4
         g18GMNTY0Hd2xO9CvDi5fMKEM0KZsFu3zXiRssb3KtZoi0ZxVs1oKXA8fr0UHkel6PrR
         ktwA==
X-Gm-Message-State: AOJu0YzPh5K8YV/ZcBAgA4J/BP970vU2Z1KoIzQQy4nNg7VDmF7dmrBv
	YN+cMenUdLRKrzT+odDzzUjLr1QBJf3hBD2Fvw2+4T7vwlw=
X-Google-Smtp-Source: AGHT+IHjWQj39VdU6KYe/JAc1tlHNiJcMoRhiGMzxU5WcaqWPpj2L0qmG/YlumqV/TEs4CIyAOjzmQ==
X-Received: by 2002:a05:6830:84a:b0:6db:e1d0:6628 with SMTP id g10-20020a056830084a00b006dbe1d06628mr488203ott.74.1704520576375;
        Fri, 05 Jan 2024 21:56:16 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:15 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/21] Staging: rtl8192e: Rename variable bFilterOutNonAssociatedBSSID
Date: Fri,  5 Jan 2024 21:55:45 -0800
Message-Id: <20240106055556.430948-11-tdavies@darkphysics.net>
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

Rename variable bFilterOutNonAssociatedBSSID -> filter_out_nonassociated_bssid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3d7fad28c414..98c1041214fb 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2267,11 +2267,11 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 
 static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 {
-	bool bFilterOutNonAssociatedBSSID = false;
+	bool filter_out_nonassociated_bssid = false;
 
-	bFilterOutNonAssociatedBSSID = false;
+	filter_out_nonassociated_bssid = false;
 	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
-				(u8 *)(&bFilterOutNonAssociatedBSSID));
+				(u8 *)(&filter_out_nonassociated_bssid));
 	rtllib_MlmeDisassociateRequest(rtllib, rtllib->current_network.bssid,
 				       asRsn);
 
-- 
2.39.2



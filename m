Return-Path: <linux-kernel+bounces-11158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E083281E246
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6A1F21C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2F539E1;
	Mon, 25 Dec 2023 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="CeoxjKpV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92753809
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5944d1ce0c7so1304646eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535798; x=1704140598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xES2C4UFSivAsOy1fJwWjUsPWGiW636trT7pF5WSYQM=;
        b=CeoxjKpVHzNRN2xoUdlH/4LCOJnANSyC0dHwcN3HzldLlpayGqwmWFfTs37WX/VcUA
         Z+uSgCNB3J7Rn9cC+R4B0RxNsPph2MIhYgDTi8gpS+RWwMRaR+x8n4RRZ5QxBmYtqVPr
         Gjitsm+PUl3/El6GUqjBJp3IvAjk5plDXfWi4uVZYcBGILtpTlaODGo048aYYK2an97P
         lYmwHnEwk7q9rW6cN307GY+v07XhDINJUbVpmmQaSCr4P9hX1AeiNUrHaRRS/8I5An8+
         ZZrgumjNIp1ORe+adCczpbwLHineyaqd3ZYhuaebgJCjaVqTzKH4lySGHTugYalqLui1
         T4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535798; x=1704140598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xES2C4UFSivAsOy1fJwWjUsPWGiW636trT7pF5WSYQM=;
        b=J915lymg/Wlwx+kNOD8hsv+nVCTyHqVOsJxexoidhdQzbbSc+dmtz8qewdN29ldlGY
         Uyfl2TjB6Q/ZwmzI2lR77GZgcnEX05SYFwoBak/qp/g6pZk4NzZI5gMA8ynedDxCR/TC
         A4bl5+LU5wWg34uZC1ehUYIf0GB1r7+LPR1wHRxxvkR4q+t6/JXMAJBWkgk/9DHslBw4
         n9XH+lKwXkmbAfkztl+ChnqALBreH/y5WOxgJTTdqG00xbcFQzM2CsIZJIO6QfIlKUln
         THGpnoPmPHFpxfBLNCNo1TZxXmEi55mevroIG/9RXSj6096E/MY8neftpSKPTx3nmzg7
         S5lg==
X-Gm-Message-State: AOJu0YysytddHOcRokbZRFpIKCmyXRVUzSOwCa8VFgbz1DYJKtILpeSP
	TO0Ldff6AyiA/+Iv11+3GpGqyW9MAqXhyvbt8huZpPAHeb0=
X-Google-Smtp-Source: AGHT+IF7OBbrlT9jJgpkWnHlNkkrsaCVZjchOFcCiovyn3qMojiUguo39t8NDykShONVHQekOzkuxg==
X-Received: by 2002:a05:6358:106:b0:174:f1c7:f9f1 with SMTP id f6-20020a056358010600b00174f1c7f9f1mr1367822rwa.37.1703535798602;
        Mon, 25 Dec 2023 12:23:18 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:17 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/6] Staging: rtl8192e: Rename variable bUsed
Date: Mon, 25 Dec 2023 12:23:09 -0800
Message-Id: <20231225202314.31869-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225202314.31869-1-tdavies@darkphysics.net>
References: <20231225202314.31869-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bUsed to used to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d6cd0e0785c4..bace5dabf860 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1164,7 +1164,7 @@ struct rt_pmkid_list {
 	u8 Bssid[ETH_ALEN];
 	u8 PMKID[16];
 	u8 SsidBuf[33];
-	u8 bUsed;
+	u8 used;
 };
 
 /*************** DRIVER STATUS   *****/
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e3d51355dab3..3bff95a93650 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -670,7 +670,7 @@ static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
 	int i = 0;
 
 	do {
-		if ((ieee->PMKIDList[i].bUsed) &&
+		if ((ieee->PMKIDList[i].used) &&
 		   (memcmp(ieee->PMKIDList[i].Bssid, bssid, ETH_ALEN) == 0))
 			break;
 		i++;
-- 
2.39.2



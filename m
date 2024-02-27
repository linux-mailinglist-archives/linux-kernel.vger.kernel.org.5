Return-Path: <linux-kernel+bounces-82686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8B868847
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D82A1F24655
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A8537E2;
	Tue, 27 Feb 2024 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="J0f1v7JF"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06EC52F8D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008928; cv=none; b=Z+z3W9ZQgYPTzhWcl0mHB2JlqxXo0Bvwwfgi+EQkoiy6QeqrB0ZbwioTne7vhtpVaXKI++cHO6rU2F1OoTvaNNc6xOwZ3d8nHOHhrTZ4N/x1eSUbzbFkxFnAUeDybcmy75BSB6/0K7cAsbY/IlYzNTAm+7hTsi1DlIDgoDXwVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008928; c=relaxed/simple;
	bh=7LIDCeeXftRipDweuLYYHyh0jPpG2lXCLfRAMbzxrKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttZ0UuJdWCOQwCKw4XJOcdBmoo11qFXruKFhoLf86lmGoNn5GSrQVvYyhatwE8930yYDPBxW7NStycVQOWoGFfk7NCsINWjebhnPIn5dQBTIzG/+B7Z5bicazac6Y/FPOmmKNoaC4ihdWigvMAUm3WFtMXd4S4BIhAKWeUaFXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=J0f1v7JF; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-363bdac74c6so10269065ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008926; x=1709613726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeW6OJcZaT3D0Ifh+ovuyXecGgo3ptPQ+fpuDeZafCI=;
        b=J0f1v7JF4MJCrQIAGXtPIslRn06hO3W2EnkBV9RJp9MF8e+eLIAKpgfRgTgiSufuz+
         cRV/wceIW2+RTYwaf8FRgeJK0jZ/RQ1uiiZLZcAfYpTdqehIomTselKPOR9/6u9Znya1
         DXammF3WKSe4NA3t3Vk4kx3lPh2RZfHrXfxh0j3vH1e4Xh6lKqyykkSo+I4/H6+Qppxh
         /jdSROnGyaKmKk3cwFnK0FG9krxpNE1tENnlw/UsxNqBlSgYn0lhGmuYqnS4Q1emhGad
         mM46FWprI95w/M230qj3E22pTzbYSft2Ca8v/gnbniHQL8AUecOZrDt8trw6IihnDWN1
         phwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008926; x=1709613726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeW6OJcZaT3D0Ifh+ovuyXecGgo3ptPQ+fpuDeZafCI=;
        b=GxjzAgx5U4e6Rq7zz/st7GJmVH6b3QaIrjhNawElGr2ABhTsn2vk/6Ql0UEISl/H0M
         A0y+AWAZ3awwkPw2GvW+/2pt88PvIc773JMrITb8XH84Yb+UzAopIsHfqdkCHmwTOs0Z
         PFrWyy6gxRegIXwjw8mcu+cW97PP30+KO1fnmP3baKXJCrX9BTGyqBaGElB78O5strnA
         uUCdPnA0CQ0xSQa4R9qKsAJh2boP64wgyoVOnZZ//qQo6t9D+7liJErtC64JaeIhEGED
         nvikGcw5KOt1Srpp+GYe6fXJWMDj3wH3ogGEdyOfow87OK1mXqmPBswNspGbXBGa2M/f
         20yg==
X-Forwarded-Encrypted: i=1; AJvYcCXlvyyfgkhnUvh526L6dHkr8qbt7KziBbiS739+/PxDtPb9Xl8iuBhvKwdlfj4mxMGym/4aWtihANv9UylLkOMJu/G+8mW7fOhaKp/W
X-Gm-Message-State: AOJu0YxEa8ncjusvO0ETrzzK4boMyMjVH6jRwo0OG1GKhKbS7O8imrbC
	kGFrLEwNaYHByewUn8yYJ9Dp+OKRI8YARkZd9j0Y0uvMgP+1287n0oNcpGofp1Q=
X-Google-Smtp-Source: AGHT+IFRmhFr29TBT/8EGQQ0hBpnKFYEZK+J7pmHhxp6x7S8JLVCiIMFGm1Xhq0NqbZiX8qhwCmMDg==
X-Received: by 2002:a05:6e02:6c2:b0:365:ac37:cb85 with SMTP id p2-20020a056e0206c200b00365ac37cb85mr260167ils.3.1709008926066;
        Mon, 26 Feb 2024 20:42:06 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:05 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 04/20] Staging: rtl8192e: Rename variable PMKIDList
Date: Mon, 26 Feb 2024 20:41:41 -0800
Message-Id: <20240227044157.407379-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable PMKIDList to pmkid_list to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix checkpatch alignment warning
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 30b9178071ae..a00db0d153da 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1281,7 +1281,7 @@ struct rtllib_device {
 
 	struct sw_cam_table swcamtable[TOTAL_CAM_ENTRY];
 
-	struct rt_pmkid_list PMKIDList[NUM_PMKID_CACHE];
+	struct rt_pmkid_list pmkid_list[NUM_PMKID_CACHE];
 
 	/* Fragmentation structures */
 	struct rtllib_frag_entry frag_cache[17][RTLLIB_FRAG_CACHE_LEN];
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 607122ab4b00..a847b6505c42 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -669,8 +669,8 @@ static inline int sec_is_in_pmkid_list(struct rtllib_device *ieee, u8 *bssid)
 	int i = 0;
 
 	do {
-		if ((ieee->PMKIDList[i].used) &&
-		   (memcmp(ieee->PMKIDList[i].bssid, bssid, ETH_ALEN) == 0))
+		if ((ieee->pmkid_list[i].used) &&
+		    (memcmp(ieee->pmkid_list[i].bssid, bssid, ETH_ALEN) == 0))
 			break;
 		i++;
 	} while (i < NUM_PMKID_CACHE);
@@ -881,7 +881,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			tag = skb_put(skb, 18);
 			*tag = 1;
 			*(tag + 1) = 0;
-			memcpy((tag + 2), &ieee->PMKIDList[pmk_cache_idx].PMKID,
+			memcpy((tag + 2), &ieee->pmkid_list[pmk_cache_idx].PMKID,
 			       16);
 		}
 	}
-- 
2.39.2



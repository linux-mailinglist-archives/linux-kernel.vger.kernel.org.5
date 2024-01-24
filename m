Return-Path: <linux-kernel+bounces-37780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B783B4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9387DB26D67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018613D4EF;
	Wed, 24 Jan 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VNBaC+8D"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B461386DA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136311; cv=none; b=OIWnAPzz7LhIAbCmo0UTSFTbRSrly+iz5ulKPPCx6uCColu15IoTBugHsrFoaaiIH0Udi0KtmW/bwnmuLfDB34HpA2mKw9uykpUjh1uOsjZVPtUP/J65avReW61PX7Jk2jOCUwfyh+B9uBrg/3ZOe6f/9qNQbIvUmQ0PteXWDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136311; c=relaxed/simple;
	bh=k5ksk20LekzjDVXZmHyF5qRlDgyHicjEbCn3PLaBcOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTscImQuL3JG5OEM2SLqPD8b12/88umRkT+3VTamKtD0oTd8jpcE8+GvYdfI0sLK1AOWhkhPkqIpJFM2+1raq/b7NAO6BKeTf+NGlcNRQG7URBwHv4793q/sjyRkIKsPuTyRyGpUzeaGeaC3rFTEJSQkAH0kSAZ95YTOUK7NrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VNBaC+8D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d74045c463so29283265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136310; x=1706741110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBPudamBprV8WQHg9cEsc7jdDIfPIVmpPvPejAN2DrA=;
        b=VNBaC+8Dp+Dtfv6CGWZ1+jtAU4cm7TYeORIq7TCzna+Xjq0pdrNv3IhW92kF77pFHD
         +zNupQ4OLNONTOcoT9U7FWzJgTIALa8e4BJ/3bX3MhddooWMZfgYLa07rviEQqoi7cKL
         H+35XpLApC6zulXzX5AduFhGk1CWEeNwiQPP21v+O8Gnq1eie3Y4uvd48w+nA41RENov
         HNoJgXEIXyULrUzcc8expHFP1vRqytv4i58T9983y0Y1kxD3IpZ2nimWnoUNUGUR/Alr
         0VmW/00Gb3sKXu/pAORLG2flD/P4yrremkMxA6kbhcEGE5ekCysLhhZJRzuwKFuthzrP
         y1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136310; x=1706741110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBPudamBprV8WQHg9cEsc7jdDIfPIVmpPvPejAN2DrA=;
        b=jhTRYBq7r0w/kRi64XKsnqEEQyp2p66gapyMDvbIzqj2Gu24/3dLlsDOj9YCVwzsIL
         r/FcX+vSL/0Fj+QwSVSWfpcF8S0GtnGss7TWV7lPMWX3wOg8mLX3RIsU1+QWKQXgF6PP
         F6VfDZxoqpMfOvb3z0I6QgeBGLOAm/pTVT2eMs0HaocC+xlKbDBNZ5UHchR7Q3jDcSsX
         2EG2vDRaTkL4k2GGOIgI/4x+wG8dEq76fKF8b3JF0gsMoQB0zcMdffw7r0QmmlXcrs8r
         zhTK8kmRbKkrUnjbPpFmmbDdghmswtBTPas4cjuOIkn2xRX7UE/DITnEHbgxtLfCqIeZ
         xcSg==
X-Gm-Message-State: AOJu0YzNg3PfQxOL+frW9uDq9+qyLkaCwBz6botF2JDzaEHaiP4TLZ21
	+dlGF7EkRBsRyb5voE+M2JnKsuQT5IVALD5NzSHSkKvQz3nP2CVSw96940KG16w=
X-Google-Smtp-Source: AGHT+IHbyjNZZTgVSen4AZgSOoFktQB6IviIR5x2EbPNA+39zEfu8efyalzMRLZBiVAYtkiDAr3PDw==
X-Received: by 2002:a17:903:24e:b0:1d7:5bde:7c2f with SMTP id j14-20020a170903024e00b001d75bde7c2fmr69425plh.21.1706136309783;
        Wed, 24 Jan 2024 14:45:09 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:09 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/18] Staging: rtl8192e: Rename variable Octet
Date: Wed, 24 Jan 2024 14:44:49 -0800
Message-Id: <20240124224452.968724-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Octet to octet to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h    |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 50e01ca49a4c..dc991100742f 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -13,7 +13,7 @@ struct qos_tsinfo {
 };
 
 struct octet_string {
-	u8 *Octet;
+	u8 *octet;
 	u16 Length;
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5281138ad468..e47292455585 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -823,17 +823,17 @@ rtllib_association_req(struct rtllib_network *beacon,
 		struct octet_string osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
-		osCcxAironetIE.Octet = CcxAironetBuf;
+		osCcxAironetIE.octet = CcxAironetBuf;
 		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.Octet, AironetIeOui,
+		memcpy(osCcxAironetIE.octet, AironetIeOui,
 		       sizeof(AironetIeOui));
 
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=
+		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
-		memcpy(tag, osCcxAironetIE.Octet, osCcxAironetIE.Length);
+		memcpy(tag, osCcxAironetIE.octet, osCcxAironetIE.Length);
 		tag += osCcxAironetIE.Length;
 	}
 
@@ -842,12 +842,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 			0x00};
 		struct octet_string osCcxRmCap;
 
-		osCcxRmCap.Octet = (u8 *)CcxRmCapBuf;
+		osCcxRmCap.octet = (u8 *)CcxRmCapBuf;
 		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxRmCap.Length;
-		memcpy(tag, osCcxRmCap.Octet, osCcxRmCap.Length);
+		memcpy(tag, osCcxRmCap.octet, osCcxRmCap.Length);
 		tag += osCcxRmCap.Length;
 	}
 
@@ -856,12 +856,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 		struct octet_string osCcxVerNum;
 
 		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
-		osCcxVerNum.Octet = CcxVerNumBuf;
+		osCcxVerNum.octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxVerNum.Length;
-		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
+		memcpy(tag, osCcxVerNum.octet, osCcxVerNum.Length);
 		tag += osCcxVerNum.Length;
 	}
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-- 
2.39.2



Return-Path: <linux-kernel+bounces-37773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BB83B4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB4286952
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184A13A265;
	Wed, 24 Jan 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Q/MdWwQn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA803137C54
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136305; cv=none; b=jpAmp8SlGXQ4+1Mr0rIEObIARXIN95SHlLLOVyfs2PccGgW/JnV6UNl/2SmauCd6UU2DRPV/GfoyuCI5qGHbHW2p2letjNvrYm7OlK+6KafElrQ7LoURA1+xBygzIQ3T7KsxBDzAhkHRcIiKDsHZodK0loFwvX/EZ8+tGDvo18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136305; c=relaxed/simple;
	bh=D9k18Awv+U2dEMlY5zBqAz1WwWpla93wLTyXIuHu79o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sj9DLuLx2I2QQuDHn5pnsm6pBHMf9z6NiFQoUQGpK1tg8wvkNCWHJDnUroeGJhEkO8kRN22pBmobvglG/9FrIsZwp/3SaQ2Dok76Z67JaQcJANW8qHj8Q9rrVhciQbZ3xnArCzg4WS4VTiUtwGL1F5g+KAt+ZmB+zoNyay8tvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Q/MdWwQn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so1289815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136303; x=1706741103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LRZsfdwfrORDxZGKvig5TSB0A65chM/WW3zBOa9jbg=;
        b=Q/MdWwQnTAjyQFw8s5Q+2o8gJWOn/stvn5/0JGQ4RKEnjy2Hv14BvGqdwhCoOAbaR4
         Qwd/kliG2z0IQl2lh5eXuW0SQA0EpCbSv8HhfwoXVnppy82tS96nY4ElGtXTngsMWcfH
         4ynRPdlzjjcj8g7cPzXk7hRs89wlV0Aus7log8AyuiH8jfOQ6CUd6beu6FlEZhIo869l
         QuC0PfTnExc0YfZ9roUnCs2I4A8+eRR2pluKKlh+9qFPmo0OW00kSq3GkARyDtjFuzxp
         qnujbaTrCHNrDHjLv7Z4qdUs36EoDa7O7UZFmvJNXu//zl10rAWoOCf5Vjb6S4sLUYx3
         XzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136303; x=1706741103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LRZsfdwfrORDxZGKvig5TSB0A65chM/WW3zBOa9jbg=;
        b=f42yUHdbfK0I3IQrqaRusggo3MdmUl/CSX7VdTYBgs7OOSpZa3gLe6rZfFK3Do8u/1
         aX93EawiX6MHSo0AhsdB1Frc2+fxaxzLlWBTeJ+qjwQ9PhUuSsyhcfrSjtifVnNIq7Bs
         BJIu6NNHVuKLFaeS6rYXmjEOcnJTpDcxpXizaQUZB9HPQiEpdLgaqhgO2baujLIaDL2c
         ixNEFuB+4nl665NEEXZSjGiFr3nB4fWbikN303Vvz9Q821jmSxFtixzBGfu2kqGHCPrN
         ekraQvdrk+T2cHjatl0wk1Hma9wuWS5WA3Roqf1UttSgBDFDvwKfKl2PuqrVjfCkF4ke
         u8Gg==
X-Gm-Message-State: AOJu0YySeAs081KaTfX0LJClHFPKYTjf8nJDSZXW/7S0anpBGhQhkAG/
	nehYWVT8ZOwecN1kJP9UTL+SDu96rrWkGaX58wuUtgq3yD/Bp78uJ9IOkZVceXE=
X-Google-Smtp-Source: AGHT+IEY27lzmdA2Ee4fGHWMp3iV2kWGGYcxqXR9yHlBYLPOximp6zNF+uanQXJukAI/fN9pbTsEvw==
X-Received: by 2002:a17:903:24c:b0:1d0:4802:3b6c with SMTP id j12-20020a170903024c00b001d048023b6cmr64595plh.4.1706136303355;
        Wed, 24 Jan 2024 14:45:03 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:02 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/18] Staging: rtl8192e: Rename variable PeerHTInfoBuf
Date: Wed, 24 Jan 2024 14:44:42 -0800
Message-Id: <20240124224452.968724-9-tdavies@darkphysics.net>
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

Rename variable PeerHTInfoBuf to peer_ht_info_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib_softmac.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 29e1206078fe..18dab893270f 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -100,7 +100,7 @@ struct rt_hi_throughput {
 	enum ht_spec_ver peer_ht_spec_ver;
 	struct ht_capab_ele SelfHTCap;
 	u8 peer_ht_cap_buf[32];
-	u8 PeerHTInfoBuf[32];
+	u8 peer_ht_info_buf[32];
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index cea3284dd787..98f0ac80f1fd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -442,11 +442,11 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	else
 		pPeerHTCap = (struct ht_capab_ele *)(ht_info->peer_ht_cap_buf);
 
-	if (!memcmp(ht_info->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
+	if (!memcmp(ht_info->peer_ht_info_buf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (struct ht_info_ele *)
-			     (&ht_info->PeerHTInfoBuf[4]);
+			     (&ht_info->peer_ht_info_buf[4]);
 	else
-		pPeerHTInfo = (struct ht_info_ele *)(ht_info->PeerHTInfoBuf);
+		pPeerHTInfo = (struct ht_info_ele *)(ht_info->peer_ht_info_buf);
 
 #ifdef VERBOSE_DEBUG
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
@@ -520,8 +520,8 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	       sizeof(ht_info->SelfHTCap));
 	memset((void *)(&ht_info->peer_ht_cap_buf), 0,
 	       sizeof(ht_info->peer_ht_cap_buf));
-	memset((void *)(&ht_info->PeerHTInfoBuf), 0,
-	       sizeof(ht_info->PeerHTInfoBuf));
+	memset((void *)(&ht_info->peer_ht_info_buf), 0,
+	       sizeof(ht_info->peer_ht_info_buf));
 
 	ht_info->sw_bw_in_progress = false;
 
@@ -579,8 +579,8 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 
 		if (pNetwork->bssht.bd_ht_info_len > 0 &&
 		    pNetwork->bssht.bd_ht_info_len <=
-		    sizeof(ht_info->PeerHTInfoBuf))
-			memcpy(ht_info->PeerHTInfoBuf,
+		    sizeof(ht_info->peer_ht_info_buf))
+			memcpy(ht_info->peer_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_len);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index aa98d22db90a..9ee6364f7b00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1609,7 +1609,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 				memcpy(ieee->ht_info->peer_ht_cap_buf,
 				       network->bssht.bd_ht_cap_buf,
 				       network->bssht.bd_ht_cap_len);
-				memcpy(ieee->ht_info->PeerHTInfoBuf,
+				memcpy(ieee->ht_info->peer_ht_info_buf,
 				       network->bssht.bd_ht_info_buf,
 				       network->bssht.bd_ht_info_len);
 				ieee->handle_assoc_response(ieee->dev,
-- 
2.39.2



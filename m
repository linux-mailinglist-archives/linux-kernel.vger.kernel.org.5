Return-Path: <linux-kernel+bounces-161609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C58B4EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4572812DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB922F19;
	Sun, 28 Apr 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NrLs0D2K"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35082111A5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345273; cv=none; b=JoMAT60mY/a/O2saOOnlXa71hkCiK56PU+K4SmfJOgvfOHgyQ7XuAvnnEwxAq2bDEIZm3DsLxXC+NvhT0FOpAspK3sqbucbSYeE+inQD9WbPy6O7MXFtC46ThtwK02bCcRXf5m9LGWEIwhyWl+FmewurIgwSKih6K4fg5u3wy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345273; c=relaxed/simple;
	bh=m1D6/uyC98EV0PGKmiylDGYkLRZjkkqiIkmWezY8OMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a28YE0zdjhzhfeBP9Cwa8LsaGUpj41jXhOQcZ6fhs+ZTRv4HX2QNA272KKKpXAqPPuYXCqJz4cBjg1SGPpYyGLWiSOxCJq1swATj0i6nkaWyvgRStndZDQlJ39UHT/bf8jyzObi30antT4jMz0qhPeT6EoYLBRKT82Q7Zmhf7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NrLs0D2K; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso2490418a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345271; x=1714950071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8x1dK4AwyIF6K2TyibRSTbnCe/0I7bAw7PdKPkHIy0=;
        b=NrLs0D2KVBGnedaIj7IjV8Bv6qP6wtqkAXsxR4h3YT5d0vEImk3y9rmAJ54PhcnYYF
         3ZM0tYw+pGO21afhz1w0hwp2DQHDfoNwQiYyyU1MlEN3E9EZw5b4WABI9ZeUvqMAeaqM
         FgCZ4vVEvQ1P1TPTZsx1ATcMRrFifV4RZZFE9LTImnwntCBN7XM9OAdGf6yuvtRBhXmK
         eqWkJL0+bBTHhWj9biUVjhniVTayNyl33I1r9ThWxiifZmW/mrJqN4sZ2GtgNmJ+DVVM
         UI/SQHah+2zx7l1fHdZPDknnIpv55Z5Ct5u61hOM1fSZ/c7UCqxrxHXHg8zXECgMFzPd
         Z1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345271; x=1714950071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8x1dK4AwyIF6K2TyibRSTbnCe/0I7bAw7PdKPkHIy0=;
        b=niYWn85RxeFeUCb2ypsBgW9ralSC4WuFAXsjiNTeNf7XS1UPi0VjwcE/ZAUVqBiXUd
         AmMSNQ9RBnO7VsV4unPpPMcsETmmC70KiIhu9142S6qvWO9xpWPADDxA5atJATNr2Cc4
         MPpPEiUllFuzoBAwUzn+hAAr5cZzfbnAdUvDWzWidI40bidgZYt/17F3TjauNqrC6JqG
         zbIoojd6Tb4CrqSdMMaFcInQKU194kpDBF1DVJwaf85Q6D+tL1kqra/HnOItihL1oYW0
         2NAUmS3UmRXqixvIfK0o6z8+vIwUUIKmRz/LMMgqAxU5LxDae2U+rVYSz3ZPf6VtCw2H
         vhdw==
X-Forwarded-Encrypted: i=1; AJvYcCV0eIZiae6Xrr8HBsc0IDvtPQDkxm/3CgcVxTCNbAYAmh+2cH4EgdEvRFznRF1ZM1ux1vDFhyUYyLHoDLM5fcBqYer0Uy1Lt3ePGgvz
X-Gm-Message-State: AOJu0YwDFNhz+hev69RVhj9dCMHVnfsQpFAc0AWa5Li3o77WX9BRMf2q
	oWbY0t5NaWMTlDshXMJv4UKcAStoSlZLlDELteKtZjI0M0DjmZxhqIFnbVeoKD4=
X-Google-Smtp-Source: AGHT+IGPRe1hgJ3pnA0dCbofd4nvvs+/KyfOjg/JrI1DDLZitFUPOxYLRhz+SW3zz5gazE5Lvr3u3Q==
X-Received: by 2002:a17:90a:4296:b0:2b1:13ac:cb35 with SMTP id p22-20020a17090a429600b002b113accb35mr3524388pjg.30.1714345271610;
        Sun, 28 Apr 2024 16:01:11 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:11 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/18] Staging: rtl8192e: Rename variable OptMode
Date: Sun, 28 Apr 2024 16:00:51 -0700
Message-Id: <20240428230106.6548-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable OptMode to opt_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index b789d0f17156..d8fb2bda91e4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -62,7 +62,7 @@ struct ht_info_ele {
 	u8	PSMPAccessOnly:1;
 	u8	SrvIntGranularity:3;
 
-	u8	OptMode:2;
+	u8	opt_mode:2;
 	u8	NonGFDevPresent:1;
 	u8	Revd1:5;
 	u8	Revd2:8;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 3982c37f208c..837911934462 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -498,7 +498,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
-	ht_info->current_op_mode = pPeerHTInfo->OptMode;
+	ht_info->current_op_mode = pPeerHTInfo->opt_mode;
 }
 
 void ht_initialize_ht_info(struct rtllib_device *ieee)
@@ -617,7 +617,7 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 
 	if (ht_info->current_ht_support) {
 		if (pNetwork->bssht.bd_ht_info_len != 0)
-			ht_info->current_op_mode = pPeerHTInfo->OptMode;
+			ht_info->current_op_mode = pPeerHTInfo->opt_mode;
 	}
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
-- 
2.30.2



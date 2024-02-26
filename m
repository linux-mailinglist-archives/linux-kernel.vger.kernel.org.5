Return-Path: <linux-kernel+bounces-80485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D98668E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459022813F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5021BC31;
	Mon, 26 Feb 2024 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NhaVP9Co"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1D19BCA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919792; cv=none; b=KWanoalM+Rvgk+tNQyomVljcrpVPWWxnEMWI7Hmn2VtrUi/boiCv+6x8QTFPoDpvMkGcirGX8rXo4voHOFA29hTVtZlFm3B4eDzdSODT4ZtESMb+aXqhXTniTuEpSkE+kscWIAENEgXlyB4YcFER9gg3LZJWApjphF4UwYhnL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919792; c=relaxed/simple;
	bh=/GkI0AH4KAbueBIXyZZOUSkMKIyc+Cm1aO4KSCZ3H/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpLU1gX0LHr2d9njyZllfChj/0RA8185v3G79Rs/fe9TRWXiBImh5r5OOP+yx4nGxTSMCfCXLFHpwt/8vwDhCaq59EYlBZNloFg6pERqWnIgxhwP3KbzA5CXytN8b3NSFtyREIqlfmLcdm20AXthSbYEAmny/73YGy46gpWBkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NhaVP9Co; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dca3951ad9so3920735ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919790; x=1709524590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y94qPBIiY1LTWFk09al9S+rVSJfj9Ljec3w+8fEwPIw=;
        b=NhaVP9Coosi61VY43mose81KWdrjsjd2WQSuz8GybPU2qa+9ubKvgLM7VpEEmizo0k
         xcYu0gBx+X46rg3ACVHIDsC1r3N9AvKM6PKbcX9kTHnlqfDYCTAP+zYno4aY7n2O4m8Z
         obS64yntKn4J8Bw5yVEWN2gCETbZGzUrrLlhUc9WyqzUFY9wU/beKsLvI8XG+H0SOq2d
         qeNTx+blvSqR42rW76DsqS07tjSt4s1FEcJlohwYWkODFkZ826/sGauUalHsBAZZY8LC
         NrgogpFOdqNfyD01LxZosQwbm++uLo+rjkSGB6GeGeDkXJGQLFfGo9sQLPxkje67VKg7
         0bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919790; x=1709524590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y94qPBIiY1LTWFk09al9S+rVSJfj9Ljec3w+8fEwPIw=;
        b=gzlkyhIQXtB9/xMaCDVJogwqryGn0BhsIya/A7to5UTdy4FkytvnLM64xYdRXVyuUQ
         UlYftnEWySVaP2e58hzyXafKzVVpVXvUBdWWgJbtMYSse1xxlPrmn2Dn70NRJppiSkJ4
         r+NoVxSJ4Cq3xag9PJ+SKp7jwxFQiRSz8F/7GDa1gv3slz9ZTsY4bPTJ6jqGO0RnktiN
         7XYJaTZbJ545zdhqzlyJf+WFb/7ygA1BkPvUXm6wgmgqoGyvM96fiHIrY9tF6l49k4Le
         AeMIEWPJ8yejJ+Evfi6NsjgLqxTjUfKGZRL8H0qrIHdluMKPVBEJuICJsVi2VpyoWiY7
         XN0A==
X-Forwarded-Encrypted: i=1; AJvYcCVfaXQPXNpJi/CgDD1KSCVBShtAVvGJX3MqNGgjp6WOmx5gFV9ggwp3WAYe9dy9BIwUXJdpNhn5mYxdwCdb5abGM1qX67rxkJrYFU7H
X-Gm-Message-State: AOJu0YwcROf+h1lRXcZUjEYJgWZ2+MTETHnaf3Hxi8kZ6H1e00cuaVRY
	bWJ07ir0Y+xjw/6/OWbPu6OfykCyvhBI1DzeAxPaT2hj9jBkdtzs1XqjAzAcCvs=
X-Google-Smtp-Source: AGHT+IFNmKD/LceEGvf88RsFhDZGd4B7FIRrWhlJYJ98No9LZm6cQnNjBQCHjtrItQ7s9yfwhBAlzg==
X-Received: by 2002:a17:902:b68e:b0:1dc:a647:6979 with SMTP id c14-20020a170902b68e00b001dca6476979mr1033903pls.58.1708919790316;
        Sun, 25 Feb 2024 19:56:30 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:29 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/20] Staging: rtl8192e: Rename function SecIsInPMKIDList()
Date: Sun, 25 Feb 2024 19:56:07 -0800
Message-Id: <20240226035624.370443-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function SecIsInPMKIDList to sec_is_in_pmkid_list to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 83f337e27209..607122ab4b00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -664,7 +664,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 	return skb;
 }
 
-static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
+static inline int sec_is_in_pmkid_list(struct rtllib_device *ieee, u8 *bssid)
 {
 	int i = 0;
 
@@ -747,7 +747,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
 
-	pmk_cache_idx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
+	pmk_cache_idx = sec_is_in_pmkid_list(ieee, ieee->current_network.bssid);
 	if (pmk_cache_idx >= 0) {
 		wpa_ie_len += 18;
 		netdev_info(ieee->dev, "[PMK cache]: WPA2 IE length: %x\n",
-- 
2.39.2



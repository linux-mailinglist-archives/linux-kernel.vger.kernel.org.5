Return-Path: <linux-kernel+bounces-161619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42A8B4EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AECF1C21AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968150A6D;
	Sun, 28 Apr 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DrNZddai"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEC43145
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345280; cv=none; b=W1UeYREg1asEjpAlPxDrIGZ3pmRZoEuwmm30uLjjyOEH+BmEn1KFun+5yy9SZdolcmbJMo+/bZ3gurSIIyBX+3XcuGCJABlyV1K3sa3y52St4xm4gQFIdIKRLWAlRWE6tkWiLJD+M+xT7gZyTkusCPAW/2MG5ymSTIz8nsNSGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345280; c=relaxed/simple;
	bh=Y0A74DG/tGZ9t3qrTTILjs6Zntvgo40EARoQ+Zo6rX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3PUqZSXkp91wIJWGkoMKkoCpKG3CCtj7wkS6CAa5un9AmaaZpdFWAN4SPntSJP6t3Cn3dFopL+q5QcQW50qx2LxLvW0M+zA7yFQdHVcNPc8wN+f0pRherzCYWVyN9+JiUFY5g6eWh7i114avIG1hbKuQEkCaMfD4mD6limYdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DrNZddai; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso3271015b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345278; x=1714950078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7RKQadhdL03GnI344MEC9dJ65d8YpjEeldN/gr2M9o=;
        b=DrNZddai25HsgLiVb8ORIkC6jh4AW0ZkNXClVlZuAgfbhSkETRF+RI12Dl05h/Bid+
         9HRqeZ8QCdT+HpDukjlDpZWaSnSKeG01EzUXxrd1HjvDlB1bO7WzTIi/e3xgCwmNNNVr
         k0SCvK9Atv7WNGQk/V5CXXeudSNKbFq9msKANM5B1WMmRJZ5g+Da1R2lc86K8EM2obQX
         ikOT+DjoM4/2ilBim08Hq5iZiuo6qqFfxmQeMoULFiVEE87I0fS/0AmtQwz6MOYXJufA
         fIc2EeIPUP4tjKaC8TWknSJ+cDDZ7wNR5eQXL4hvkddO+Ww8eMyuNAe30fC9I8eYFjhG
         Rf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345278; x=1714950078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7RKQadhdL03GnI344MEC9dJ65d8YpjEeldN/gr2M9o=;
        b=G2XbcXX+kW56P0B2nEYCyQpxi9Js8SqOTufOEP0e/dCfKBJAlR0ONcZIjAxZmpks2j
         QWZb8Z6M3HFgPYyoPiw+ebtxaaRPllZVrIOZCCKHNg8RI9vjZJTthDVyi7USEJQQouDy
         DWoYg1aZ15fESsthLUg7IvIx5TsAL1VaJ41mxmkGBXyeOSf6y6ZQgjjK8JsXClzUvoRs
         ETDytxR6PQ8kKDBkoHhBh2WwV8rJC8qSCJwSL9Tgth61KDx6ZLI5XSDoqJSAcuIxM8QT
         jEXp+fDWfLHH/vtZv4wpISAhvt3LLDCf1WVqsuzgHD9TAJsxrjL7f5z4WJfnGmKJUffS
         UGyw==
X-Forwarded-Encrypted: i=1; AJvYcCVCmVKdtVrYl1HuVjWqSA9vmxAUDq6dVQyz1cZn3ABQt3+i/O/DSjkyD8Br1f4zlNfDuEEQ2Chil4mngbpRpQyJhIi47CWeWkVOV47R
X-Gm-Message-State: AOJu0Yz+UbKdv3LD9JWGm6stlASsXOwGmcxjOHxRH+VE1xx1KozfgL+R
	NuosOc0qdU4lmyFJ0SN7JGSXuGuvGwcTgjHzhznyv/QNp9y8nIOlm6/2kO3A/g0=
X-Google-Smtp-Source: AGHT+IE+jspr0n/4V+B03xGFxLMPIkTtfluHRmcZnNLxTLWoaDn9P/8okaaQZ4WfEQz9xA7SxootDg==
X-Received: by 2002:a17:90b:310f:b0:29b:c2b3:2712 with SMTP id gc15-20020a17090b310f00b0029bc2b32712mr8130596pjb.26.1714345277982;
        Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/18] Staging: rtl8192e: Rename variable DelayBA
Date: Sun, 28 Apr 2024 16:01:01 -0700
Message-Id: <20240428230106.6548-14-tdavies@darkphysics.net>
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

Rename variable DelayBA to delay_ba
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 3f8860e91793..96973c744cd0 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -32,7 +32,7 @@ struct ht_capab_ele {
 	u8	short_gi_40mhz:1;
 	u8	tx_stbc:1;
 	u8	rx_stbc:2;
-	u8	DelayBA:1;
+	u8	delay_ba:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
 	u8	PSMP:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 91c7415d5a2a..5c920a0089c9 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -264,7 +264,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	cap_ele->tx_stbc			= 1;
 	cap_ele->rx_stbc			= 0;
-	cap_ele->DelayBA		= 0;
+	cap_ele->delay_ba		= 0;
 	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	cap_ele->DssCCk = 1;
 	cap_ele->PSMP = 0;
-- 
2.30.2



Return-Path: <linux-kernel+bounces-37777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B583B4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290751F20FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1013B7AB;
	Wed, 24 Jan 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Y438QFBb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447213AA38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136309; cv=none; b=tXno0TdG+J+z2k+C4m34gKj1kEc79/QnLRCCUTsQlYkTIXNtGKIdBg89C2Vv+l6ErgMDkTxY3pip8j8f58o3NfgH99Fji+HGyWd5lh6AT9bnqg6OuY2z+VkR8vBIKHko3NiipKJVKxG3pZ93b+6BGr15cPQzR1Xgtv4xxf45Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136309; c=relaxed/simple;
	bh=6ToM+Cwy4u0qXFjonHn47fTyU4E4Qpah3eIqQAIsO6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aepoYotkG9y4oW46wpLPlFoE6a2BH03geFasCoY6n2PXhubDw4dkoDzanSGww6i/I/uSpFtmHS1/X6FwW7/eio6Wsx0CSLM6m0bOwaCkJvIKEf0ihZw5wVTdQq7DU1RlSFXlZ9IahX0y3/IEjS3rDMc4q+dMiQaCIEWCDEZVpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Y438QFBb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so30243665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136307; x=1706741107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NTpS/way35+vJRKykUjn1EX5vyHFpA61voGfYPi228=;
        b=Y438QFBbTAoJR+6E8eWqVPoXVWnl+azkONy6FJzJVJI1E1wISYu2JMb3YxpLnR4oyH
         +clGW2k8lS2R984mpFOzF0IlLDF6jmUpuvjThSD4KCad+PTf2UJkjVOHYRndwBBNVUW9
         EKNHy1cQmLFFqh1/xzHJmSvf5BtNCfDhiFV3S9/Yc8pv/JeNEeUZCMQnvIZDW2WTdJSZ
         oxEwKxNlzDjxgrwdOWCCK69B5ylfyXxiSF1XxzxUBKXetDTpNoj1JOsd+YyPKiXg6chd
         ZC+08ec/YM1f+wxcRRvQL9B+DMs5yBlRy4LqBi0EInBfltuwXh/YLFTxt/JjLzsXcnlh
         S5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136307; x=1706741107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NTpS/way35+vJRKykUjn1EX5vyHFpA61voGfYPi228=;
        b=JO/4b+vTwfFSg+k+mMIu4rKao+ypkcdSFzi0ByaLQHrSZm0qXemgxwMVAsZDfEo2Ol
         JP5yLHjYjPdinTpx2LJeMFmloR1uGwqXlmCMfJsBc745ov1hMwLl4QpfT8s+SaWYdmIB
         lyF3RfPm8LRU09HqhFGdFnUcJ0vtwUITMkJioZa4mCTsnl2bDeLs90+1MMYH8A7K1xgl
         bVYLHdmC4S6OYomvjkA1S6AY5dmotmrCVs25ALSfdPrAJERRg4z4jgDWsIn0MHxR4Enn
         KPPfW/NEhUXQ0hQVTNSujlpYhjfkRrznDtpDJl3qiT76IlKUJebFaOPPMUMinwk5b+OA
         EM9w==
X-Gm-Message-State: AOJu0YwMjtnhWJi6ZuO4ifGYhvVbS+lJiFRCqG/bi15RLIE81Rwy1xXo
	0NLr+xXSxT164bdnheRU5g7tSLsdr8ZoTnoDrcEfFKitLHUxfelendPFEoOhrLs8BtVBnvHIz+I
	D
X-Google-Smtp-Source: AGHT+IH0cHEUvO+RMY44u9A0oKjjcSfnvTB4ISwkVv06RC/1D0k5qOCWUYKNKt+QBvs/CzOT1TSl9w==
X-Received: by 2002:a17:902:820a:b0:1d5:78bd:af9e with SMTP id x10-20020a170902820a00b001d578bdaf9emr77886pln.116.1706136306792;
        Wed, 24 Jan 2024 14:45:06 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:05 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/18] Staging: rtl8192e: Fixup if statement broken across multiple lines.
Date: Wed, 24 Jan 2024 14:44:46 -0800
Message-Id: <20240124224452.968724-13-tdavies@darkphysics.net>
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

Join broken lines across if statement to fix checkpatch warning:
Lines should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 538689fb5580..ab41632def7a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1736,10 +1736,8 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->link_detect_info.busy_traffic = false;
 		rtllib_disassociate(ieee);
 		remove_peer_ts(ieee, header->addr2);
-		if (!(ieee->rtllib_ap_sec_type(ieee) &
-		    (SEC_ALG_CCMP | SEC_ALG_TKIP)))
-			schedule_delayed_work(
-				       &ieee->associate_procedure_wq, 5);
+		if (!(ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_CCMP | SEC_ALG_TKIP)))
+			schedule_delayed_work(&ieee->associate_procedure_wq, 5);
 	}
 	return 0;
 }
-- 
2.39.2



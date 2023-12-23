Return-Path: <linux-kernel+bounces-10189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C979B81D11B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075901C247EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF22BA3C;
	Sat, 23 Dec 2023 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="UaT9Dwp+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F36123
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbaf12c866so1776925a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296791; x=1703901591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAUr78/tHy+bnLYpp389Iep9Z0hW/GgVuQDVmoXVOqk=;
        b=UaT9Dwp+xBEcmrui7d7XXbsugvAtbY0RAaM30XBhy44UWbu2Loof8bUwvCurYAZYC9
         iVDYGO+bMV2WNE1hkCq7//H7gWyhyuyxwnQjL6xOwOaoXEe/deAUbF1H9cs6ljyXELhm
         Pd3sbjPxMT8zcgsKKI0+VEdCAY5HGCZTSulhPw4UEJKaM138vhQ18ElrYMj24Y+b7C9l
         /dNPOrEGn8ne1cZZHHqYi7pfU6dEOvyBp41Nr3M9cKagJjExCi0aSgnDadkAlDHZlmdV
         fdGZZ7p7ew+6A966NqGAa3Ay2FmHoZ8xu6EYltKxH73BMQjOfy9JNAb16+3XUDA8EEsa
         rlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296791; x=1703901591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAUr78/tHy+bnLYpp389Iep9Z0hW/GgVuQDVmoXVOqk=;
        b=PNTzNpU19xjLAjVnzMXKokjtjboisdM1ujXaIuieGzpwllGf5ccupJs2uuOkOfpSO0
         S2kD9pvxXyPci/VwR7EOIBEn1a69/FaNoraKu3FUrtk/oxr+gcD85H+/ZT439eMGtsRc
         MUh7qUK9gHJ35AzIiYGmeEF1m4MNYAuMZsSoAiiFLxKBzv7GCNCyznDx0movPX8Qu6Dw
         sBs9kEVnfBmoNOKlTl+fgZRZppP6fZQ8RQQ6oB3CwTX2Ukv1QOIwZ7//ixA2AQ+kV9a2
         aWwzbsUYFM9EMe8AR0ljk674hKLkM76lLPmVCSWyRiX+PYSGdKF7mdrpGw6XiGpiExeq
         CD3A==
X-Gm-Message-State: AOJu0YwwkVqwyMQgFVInv1QwY2amakCf9WazlUhrANTVVz38U2x+3ubk
	H7CjlRosEebYd/fYesxSHor4ERqkx5Lvew==
X-Google-Smtp-Source: AGHT+IGLgYEc/sdGm9KEfofUlSMPvLguXgtBDpjCgJkYSRvHPeMrALWjrzWpaNHsXhOIbfZapN2zUw==
X-Received: by 2002:a05:6808:3309:b0:3bb:72f9:86d6 with SMTP id ca9-20020a056808330900b003bb72f986d6mr3311716oib.106.1703296791021;
        Fri, 22 Dec 2023 17:59:51 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:50 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/20] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_association_req()
Date: Fri, 22 Dec 2023 17:59:28 -0800
Message-Id: <20231223015942.418263-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove parnthesis to fix checkpatch Warning:
Unnecessary parentheses around ieee->ht_info->SelfHTCap

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 32760dc65961..ba6da717dc7e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -727,7 +727,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-		ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
+		ht_cap_buf = (u8 *)&ieee->ht_info->SelfHTCap;
 		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
-- 
2.39.2



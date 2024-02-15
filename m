Return-Path: <linux-kernel+bounces-67605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DA856DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226A02835F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039513A86F;
	Thu, 15 Feb 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INZoQ/FA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE813A25D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026221; cv=none; b=tGZvqKn2shgCNLV6Do9amJL7BcfRHExGKgWhLNQZwN6u1oxAJvVWG9m1e5idCRujB/CuYcvRYWKmjy8+cMorOiWBIZ8OAcp3WzNKwQd4g0qS/lWKPDZUO0BowLr0S04h3rflZfp5MHfvOVFDgmzEoweXsqYFsQ4fI0xCvoxPHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026221; c=relaxed/simple;
	bh=HDDFchT229HxwZ+4S2Oyhh6QwaUnpPOF1xD3S5Yhof8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVvhXHBptJQJkuxjQecdWv2NKJJ8WE2vg4HCFRpLNxFPaRJzm6VFxN68n3Lr2OWmDOLU1+t5fhhWzp+1CXafWUTrt8EREiMQaraer/46VqxcMCf412E13QEnlu7Ym9kUgwtTm0jR5QCkiLZUPF71PdodQKdPMiKlzmRD4K2R5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INZoQ/FA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411de7c6b3dso9848655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708026218; x=1708631018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7D3Hve9+ECAggWL+Tt6SbntilYeA7K9pgcMz0v6dHa4=;
        b=INZoQ/FA8tl9BlvvOFbLhWKl+0iobU8yPNJBetgQmI6LhMOWfFGVt1HFLa43vTtbXr
         N6yXn+cFH0Yy+IoHfASBNuGuGHtQczdZCdKKitNLCsRjQoDsG+LitELQIpuUDA445z29
         wFcX2rH8h9AjfFIfRyylIRvuMzj2eLlANYM8RfpocjTg6C/9iZTeVJ9Pjb6TL8kNaGBL
         tqKSN3P7+C9FWPb2p6Ps6Tb65ysEnXxwkby0lOiWjm6rDS6Br+S9P9qgWgAS1t4ApFpt
         PMvP/yhLfkH8D40/dQiyItiyv3p2j419iBUSoQICWRMCsBqjptCAOwv3uAdpRUuBVbL8
         sckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026218; x=1708631018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D3Hve9+ECAggWL+Tt6SbntilYeA7K9pgcMz0v6dHa4=;
        b=NBJXfFYhJOq7QctA+6lq0eLvbII1vIo6MAVgWB/DRY8VDf/9YKOFGEXa0Iz4nZ+EXC
         taKz8b9G/N0wYazVH2+TmdVsF8kc+LRDCiXTnbBhHQM1xkTWDcjGMtEj2f8QzHYRT2KW
         1/M9QfQObfVK8SpWeCLP5PkbEeybanwIHWBBm+7OVXqYm7CczSvRilFrb0B0ZziYGp+4
         VzBgYhhk1Ht89q4o1wJa6mSnhqCq1gFkPhIouwJqvqhDQT8Val0y9Rwxxkf2UFS6os+z
         ybdyzZEWkVRzazVQL69+S91Gg4qfwUqXb4ZpkgQGKV888Dnuio9e+fjo0pV+8Wb1SWf7
         cfVg==
X-Forwarded-Encrypted: i=1; AJvYcCV40Il7rqtEZgd16siJXVGfzojKBL2v0sr3DcXSqz+WqbZhlzi3iS6nSrruseF6VUDtkH0AlcVun+iaLyhCDq9JMwcYjBgHkNNo86dI
X-Gm-Message-State: AOJu0YxK+HHCgoTk2TON/DIpBvMgrsz1yaL4a7q8D4zwCQtRQuHKk7ZM
	QttuUUVOHriwVz0k3nZTAR8zjTWDT+wUWWRueUVL0O/mBE/jeDez
X-Google-Smtp-Source: AGHT+IE4y+314+eegQYovl6v69vxT7kokVg98vDhwNONtKWxXDw7xVMWeBJpuZ/HTGCVKOJ71i2H4Q==
X-Received: by 2002:a05:6000:2cc:b0:33d:1665:b2b0 with SMTP id o12-20020a05600002cc00b0033d1665b2b0mr463406wry.53.1708026218325;
        Thu, 15 Feb 2024 11:43:38 -0800 (PST)
Received: from aaron-macbookpro.. (host-92-14-37-217.as13285.net. [92.14.37.217])
        by smtp.gmail.com with ESMTPSA id bu23-20020a056000079700b0033b7d9c14desm85706wrb.5.2024.02.15.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:43:37 -0800 (PST)
From: Aaron Parfitt <aaronparfitt123@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	philipp.g.hortmann@gmail.com,
	Aaron Parfitt <aaronparfitt123@gmail.com>
Subject: [PATCH v2] Staging: rtl8192e: rtl819x_HTProc: Removed braces from single statement block in ht_on_assoc_rsp
Date: Thu, 15 Feb 2024 19:40:47 +0000
Message-ID: <20240215194045.37205-3-aaronparfitt123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove braces from single statement blocks in the rtl8192e staging
driver to clear checkpatch.pl warnings, improving code readability
and adhering to coding style guidelines.

Changelog since v1:
- Updated the subject line to make it more unique and descriptive.
- Refined the patch description for clarity and conciseness.
- Incorporated feedback from Philipp to improve code style compliance.

Signed-off-by: Aaron Parfitt <aaronparfitt123@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..49b882c363bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
 
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
-	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable = false;
-	}
+
 	ht_info->cur_rx_reorder_enable = 1;
 
 	if (pPeerHTCap->MCS[0] == 0)
-- 
2.43.0



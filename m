Return-Path: <linux-kernel+bounces-118228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCB88B67A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6823A1F3FD64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB21C6B9;
	Tue, 26 Mar 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiplsfyJ"
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2743233;
	Tue, 26 Mar 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414964; cv=none; b=rM7ASU2REwWDOBYHL06F9bj+WZF/A+tgQCMOG+xbYuID/HAEiKYLqwJKlmLfvFdnrlkBtnG5e2GnPqYKDQsD4LamQV1yU5JLPQ+zsGX9bvGkSOeJUCuE8QlP6pDxFEVif08NqOoQ9PdCcHSwao7qkaRJlQ573CmlAk9+3SGmcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414964; c=relaxed/simple;
	bh=Yci2u2Nqawj66kr/KUuXF0uP69vmsVBHA/4TkrHnOOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7vYT0vtLV2BSJnxjsFximIece8iA6v7PNfiwbNaD4NrCVRzJzHRDkUDQPTYb74I98ugdFXnSEKYOAs/DBy5iG8kINA0f0W/p6GePZLg1/7flcGp0aZogbPKjOdymGP/WtCyQWnvPw9+gyqeZptzdlbYOIEQijTQoyQX3nKNffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiplsfyJ; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3c3d2d0e86dso552752b6e.2;
        Mon, 25 Mar 2024 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711414962; x=1712019762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LKf2jwKRUBghsb1hb9noFEqyR7Wc63fp95/WXgHPqo=;
        b=GiplsfyJKDdb04oWtbn1GVagZBggpHG6sYcI3n+VNflRRiohPMhllWqAAEXrQZIVHl
         XBoKUEXfPayBtmeYrJETsY3B3gtDJTvcgu3WnY5W/jaZpAAF/X2klhOxnHB+HFt2h+UT
         4pKBvnMtF2nhz85NroPLrmTKxnyKxsFis7Nd7cyJYF/D7or3BKzusmRnfYdvrG4S+VGs
         wZIvhZOMw6negoWpYNk352YgBKLe2M45yMO1IiqSiN5HFCoXmDF+XtThU93G6cXGHpox
         ixhdVLsxVLnilqvRZekSuhaNKdyDV21RH2975eZx1CsPINY6EnDW5OSJ1c79yK5WkFq4
         Jr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711414962; x=1712019762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LKf2jwKRUBghsb1hb9noFEqyR7Wc63fp95/WXgHPqo=;
        b=hHhaRFguwIIkH5CuvOyGn+ndf6PqPslN4R3hZog8pbZUcenOynjfzbEfaAFuTPBUEj
         /pJUPFum4RXiM6p8OCG/4b66Qf+0Xfr05Q3dAt/DKvOnjU/4KBbcXQy8GREF9nwRHAyU
         agS8KJICjJjM7B6YSGsMVCleIQCEXq+MBS7Gvl4nwPuHHDEDwxEq+1/6/f7imbVhdXqh
         ntA3lHT+rTT6xwOz0zjCv6QQfpL6tbA353MofKEeW3ZXILP/ljbMz55nac+soh3WN3ps
         18UbIsvVzLz6s0qOtoRazUlB2otwPCZonXjiY7dTIWhzWTodshmTfeG+M7Q6JH1zBJM5
         za/w==
X-Forwarded-Encrypted: i=1; AJvYcCWS3hoBfURrs4t/IABK+pSxV14yeSOsp/gYKWCUOuBlKCxAyox0sAke/AgcaNf5aJXSrOMWioG4LAT9Itxw2P7eSnfaeeAxQ/xuF2BxaVuJ/f2lDwdKvY+4uDzKfe2q8ZJEZtduw460thw=
X-Gm-Message-State: AOJu0Yw0dZNROjq4AkdFcGfVoqX8aDKt+T4hbEbGeXEI/69Mng/5whll
	VBwiK+VAjwUCoqJkv9MLZMnc60t0INKrOKsz6hVzLadJl5t2uOsMzomFEbWTT4uQHw==
X-Google-Smtp-Source: AGHT+IHgnz7INBk3M0+aautZT3lb/GWvYXaiIL5Ynv4roLiKyMREkBYvBKQKsQBqPvMl2x17AEXJ3w==
X-Received: by 2002:a05:6358:3996:b0:17c:1da1:aa8f with SMTP id b22-20020a056358399600b0017c1da1aa8fmr9438563rwe.24.1711414962405;
        Mon, 25 Mar 2024 18:02:42 -0700 (PDT)
Received: from C02ZT45ZLVDL.corp.robot.car (c-98-42-213-84.hsd1.ca.comcast.net. [98.42.213.84])
        by smtp.gmail.com with ESMTPSA id b21-20020a631b15000000b005dc8c301b9dsm6647878pgb.2.2024.03.25.18.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 18:02:42 -0700 (PDT)
From: Stephen Lee <slee08177@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	roman.gushchin@linux.dev,
	dennis@kernel.org,
	Stephen Lee <slee08177@gmail.com>
Subject: [PATCH] ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw
Date: Mon, 25 Mar 2024 18:01:31 -0700
Message-Id: <20240326010131.6211-1-slee08177@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In snd_soc_info_volsw(), mask is generated by figuring out the index of
the most significant bit set in max and converting the index to a
bitmask through bit shift 1. Unintended wraparound occurs when max is an
integer value with msb bit set. Since the bit shift value 1 is treated
as an integer type, the left shift operation will wraparound and set
mask to 0 instead of all 1's. In order to fix this, we type cast 1 as
`1ULL` to prevent the wraparound.

Fixes: 7077148fb50a ("ASoC: core: Split ops out of soc-core.c")
Signed-off-by: Stephen Lee <slee08177@gmail.com>
---

This seems to show up in quite a few places in the alsa subsystem,
should they be addressed altogether?

---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 2d25748ca706..b27e89ff6a16 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -263,7 +263,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int sign_bit = mc->sign_bit;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = (1ULL << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	int val;
 	int ret;
-- 
2.43.2



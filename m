Return-Path: <linux-kernel+bounces-70696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D4859B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DD1B20DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D538F5A;
	Mon, 19 Feb 2024 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibSaV+Yv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FC6FC2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315793; cv=none; b=ZDzgaLjKla809HvFH+UR2p9FFfXmoez+JoaKM2jzdnwzphstSCXQPf4fuZvIABGpFBKrN55SY3wrBKaXlbXvHAEkTTLBrEIP+jYFRqbkix/AERnmuiE0zVEinjSpPPiUregZRsuhNjOu0m5RpLVFFJUaT0CKEhQng9zBtqkZJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315793; c=relaxed/simple;
	bh=TC3g7r12yg/hLMumkJ5ZK916K7lRNtfFKcU36bsB3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EmpF8zkDcDmS8nwgi/t1M5bIMXOr1/kLXx/S156zcdb04Nw9lfhvQfH/NFN9M7D+ZU9KON9y9MJh5drv2Y5v5mgYB2FPtghNjJZRpx+NRcYLRg82Qs1m4u29R8GGKw8xmUkRxCmjjfW6p27yN+XollFLo8IjSSN2v88fQbBHRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibSaV+Yv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so9082185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708315791; x=1708920591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVTC/+7z9UujUPV6yizeWZYMhqdw9/+eyC0vrV47nAM=;
        b=ibSaV+YvyPKHODK8ZMTc1aVtyipND44LDA6hCtHgb9vq0rcq2PO1cTUFNT4ELbi6c7
         hwGcoxOtry4L2RouAXjgEb4u3UWWuDuj7Ri/031ZT29erhI8SWMMIi89fyHzD0BTYLW6
         dIkNWlSkuJcl5hZDK5ULDGJewVqW6+C3bEZqVBet78J/KjfZpp7sENRtW2l2h55U6S3b
         EtfUrWJhkejlOSOLqjfVUKY5OEsmhn2Fk66dVVTjo5kakUvaaCSGi/wSEfuutq/1Lxkq
         nkyTFdrHuhCMeZ9rffFQEXvEPWpAbxSsUtsh3gacDmIbMqUeeZvpgkiaDinppvlDhp5f
         ZAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708315791; x=1708920591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVTC/+7z9UujUPV6yizeWZYMhqdw9/+eyC0vrV47nAM=;
        b=JxObKS7xrOHOBUQKBOU3nU8YkyoOQrOMnalA2CWG4IsbFBUhUc4/YnYvkamalock3W
         uhA7NkiUvDuskESSUQmV5bbLDZWHK7GEZRCUqBXcY7VKm1qaY2kdZJw8VlaUUvHxHhPK
         pJOUv0qY8R1rBibPlrpPWt7/JnUFrouz3Qp+7jtBd1Q3V4em3DKVK8u7Y6uhmsB4SiiR
         Zc3yWbD2pAaiD1v6fqipO8JRXg+wTLwq6l4ucZwBgpamWpctePvYTTuEHlvXkAJPhjJr
         bApV4dl5QVVM6fF1NBHiUWbhwNkN3A/qv5TFMnLSVc+1iR6jpatNwJFZrxiTAADmOPRQ
         53KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbPfqgwCDWYuQCQDDYOfVaJYqULQc/oz7D5QhRmSy9a9njmoAh4P7JCqtDYpBEV/eR1tbXRflQI9Y5Ogphv7QWIuxislS2je8SYbGW
X-Gm-Message-State: AOJu0YzLAZNC4q3MWBb33SBNYexRQ9iKwht4tzWM/ld8KWFM20EQjU3W
	snSTvZkOgQ9vBu0EnGLFUkUMFemQKczRU5gasdPDF004efOMhWd3
X-Google-Smtp-Source: AGHT+IHmRC9PpX2tXgvlXG+oUGmuQZzU+9AW2/2ZbbfXHrb1ds1qqoWuMg+4UXRkPQF5tOFHhocoeQ==
X-Received: by 2002:a17:902:c949:b0:1dc:43d:962 with SMTP id i9-20020a170902c94900b001dc043d0962mr63325pla.42.1708315791120;
        Sun, 18 Feb 2024 20:09:51 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.79])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b001d95d47cce4sm3365746plg.138.2024.02.18.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 20:09:50 -0800 (PST)
From: Calvin Owens <jcalvinowens@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Dave Martin <Dave.Martin@arm.com>,
	jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: Silence gcc warnings about arch ABI drift
Date: Sun, 18 Feb 2024 20:09:06 -0800
Message-ID: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

32-bit arm builds uniquely emit a lot of spam like this:

    fs/bcachefs/backpointers.c: In function ‘extent_matches_bp’:
    fs/bcachefs/backpointers.c:15:13: note: parameter passing for argument of type ‘struct bch_backpointer’ changed in GCC 9.1

Apply the arm64 change from commit ebcc5928c5d9 ("arm64: Silence gcc
warnings about arch ABI drift") to silence them. It seems like Dave's
original rationale applies here too.

Cc: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
---
 arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 473280d5adce..184a5a2c7756 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -28,6 +28,9 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-fdpic)
 # This should work on most of the modern platforms
 KBUILD_DEFCONFIG := multi_v7_defconfig
 
+# Silence "note: xyz changed in GCC X.X" messages
+KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
+
 # defines filename extension depending memory management type.
 ifeq ($(CONFIG_MMU),)
 MMUEXT		:= -nommu
-- 
2.43.0



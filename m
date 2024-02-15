Return-Path: <linux-kernel+bounces-67041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A731E856539
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469951F2556B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65607131E33;
	Thu, 15 Feb 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj4jrZ9P"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116B12FF88;
	Thu, 15 Feb 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005671; cv=none; b=RwXzujbzIWfqjgkuvenVrZJsyVWwfHt3I+p0nuIx65zIgssQwuEBPxXhQTg5vR29YsRkkpxttUcibJLm2x9MIt5BRJHSTKJ116lMgzwIoGIs2Cd96nq5KZCaMiMhPalpKUojsyFr4OzLPNJsNLK6pVh/RxL10OnI9RDpjqtg83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005671; c=relaxed/simple;
	bh=2PtL4ZO+AuLDLByDl0phHsryE++u7uCY1JkYwT9390g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VCRkDhE5cU3DnH4y17b2sfcMN1YIMO0CXulQzVC61F4vAht8xIkTPKofQ6gfPYcnESlS8zQ1cTUKF/08Ib0QtETubk50uWnQIpsKeBI8kWjRUXHi58OFPAbN5CI7V5Krhsd44Ns4cYGeqCGAaBmX+DFfvbFTm8j4kiNb5ccokjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj4jrZ9P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33cf6374e58so405079f8f.3;
        Thu, 15 Feb 2024 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005668; x=1708610468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=byROdOa7RThrRxfbEAlUg2egljys0iMmL1dy4Jts6eE=;
        b=Cj4jrZ9P2STwyUpxMXDj5XLLxviR6zpmoquQBR+ToBZLgACEc0KwfoBWGhxWdn3YUC
         CMlRVxg4rpKmKv3VPAjkvMy1xmoJ8mFuQHL9ORwGUgmGgGp3iWLOzw48KbazZngHKZ0b
         LkGVjSMOhU3UztiRMinDsdtliRKgxEbgItpG4iOMLy8fTidHbOOA2W8QmjTaYaGeD1kQ
         Af7InSorL88P6VlKth0gIgKEpqmEe0vANMMyx/yA7n4qiG7YUfG2yt9mY/AAAF9sAUXv
         2KBgUwdOExtXvC7lpUovVE52MOtccBrgG767d2gsIxRedlo627uRfvczizv9A0UnDJQQ
         ND2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005668; x=1708610468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byROdOa7RThrRxfbEAlUg2egljys0iMmL1dy4Jts6eE=;
        b=g/fi/hPkNwxdI3MSP33l5pYys3ugh/jkN8HLyLidgGilJDyWYVt0ZtqZ5LAX/EyQ5S
         Euz0+cXN/t8Wp8NcR4Whh0q7gBmHrC5/tr5YMNKDGyOtKUWyIDHLzKRFcvvNf3z0QMf6
         3cp+xM3dg5xqBNJELdOsGi0fYh8guNBketYG3mBrRZ/dXq7jHAjlybkBfcopm4JJ2xAy
         43uLrSt6DkUyn35MHa4uwqlE3+/EwTf3q1AsjyTXUhFv04WQC3xfnwRdTnRqbcpAuYRc
         y5u4Jpo1vMFOlscZV6Y+7uaruIEGTBj2NhT/DhlIRxyW6wbLimVsflBz3FXTUXNtvw+k
         cECA==
X-Forwarded-Encrypted: i=1; AJvYcCVkeafAL24ihfd1JqBtp/L67nAR1xbE6Mi7mr09gm78nlrhGjjWod1h7yPkE8uiMIqDLIE1sO8FUJ9siFH2qVhqIwSYA+dng37H2qv0
X-Gm-Message-State: AOJu0YzTzHUaGs+8xRMUBuUMgXmiqVm2fpkl/83L4urHwAEK1kooacpr
	64Ano2gD6/0gLnyetoEDfSX0cyodZ55HWskZtaGRIQkQ54gcAWxGQvD8mI9VDgs=
X-Google-Smtp-Source: AGHT+IHe2sxmoy/X2Ezb2Q3D0GQv0IZZRrxcTzQ/dTI5Yy67muJihjhwDVPF4Li07ni+kuSFVdu8jA==
X-Received: by 2002:adf:e911:0:b0:33d:461:ebc2 with SMTP id f17-20020adfe911000000b0033d0461ebc2mr1302521wrm.28.1708005668074;
        Thu, 15 Feb 2024 06:01:08 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q25-20020a056000137900b0033cffd1a302sm1872343wrz.57.2024.02.15.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:01:07 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: chips: remove redundant assignment to variable timeo
Date: Thu, 15 Feb 2024 14:01:06 +0000
Message-Id: <20240215140106.2062858-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In two functions the variable timeo is being initialized with a value
that is never read, it is being re-assigned later on. The initializations
are redundant and can be removed.

Cleans up clang scan build warning:
warning: Value stored to 'timeo' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index df589d9b4d70..9f2223d3e8e1 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2411,7 +2411,7 @@ static int cfi_amdstd_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
-	unsigned long timeo = jiffies + HZ;
+	unsigned long timeo;
 	unsigned long int adr;
 	DECLARE_WAITQUEUE(wait, current);
 	int ret;
@@ -2512,7 +2512,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip, unsigned long adr, int len, void *thunk)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
-	unsigned long timeo = jiffies + HZ;
+	unsigned long timeo;
 	DECLARE_WAITQUEUE(wait, current);
 	int ret;
 	int retry_cnt = 0;
-- 
2.39.2



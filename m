Return-Path: <linux-kernel+bounces-143594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74068A3B40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34419B222EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181731CD1B;
	Sat, 13 Apr 2024 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5JnodTm"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217081C6A0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712989314; cv=none; b=Bar+vOWs1FOnnK0yd9kFXFEW/YWJ386h4PvEQfm0YzKbnPHkVO33MLOIM3Ous9bu+kGk8vB4lLV6VwIzFPXV14gq9vjg38Pt47hA4c9xz/9PS0TVrF3DnfIRXIWW7F3B9mG/e7KKRHFwfsyP/hDDXPVnLmZMU8PpG6fe2pvvCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712989314; c=relaxed/simple;
	bh=Vvv0BZjMNTN7ytI2GzQh0FPiY+0SNL9l/1DOsIB44JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QMDKC7eMArfHKbJfok22/2V5FPK+H6gM+55AH/1EUHlWQmqULt4L18/IByvHy00QB2bWkd1q1Ny4Op+Y1svTY2Pu7i6ocyn2VFUwagszFk8+4aHJu/0rwFFflehq6MBOZn8PpOsF4ZDQ4pJuYNkIUnBT1oze5XgHBFb+BPXtnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5JnodTm; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d65e76c9b9so67252639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712989312; x=1713594112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwoUC8Lk5gZoc2Xih3FgKCcBy4dD9FmKd3RULbF9kv4=;
        b=T5JnodTmF1e3QHFb8ETtLh1uzihe4dRpoPTjVVUO8oelgJGzs+e/VNoUfmELAHf7ZH
         5ttKTHVWvuZBYXnREXzRuLK8UlL4Yz27QBLhJpkXX+azse6alUMlpdraihdfHMzmpNt+
         bzBahvlfHHGv6cCnw4ftsXsny/Gl2rgfJWwuXKVsNMYgzYrMnrmIXdbpM7LpWh5elxko
         LB+BX4K1RUVj81ZYvM4e+F6mlZETyVP2xJ6AQ80oHRqz8DeuBYnIlaI7vKE4GJ0jnRlt
         nfaqm36xMk/93szkywnd0hFPHhXsL9nWQbmx4HhTTkrZXiROoorOuIkfYA2bRF/2abjA
         FtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712989312; x=1713594112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwoUC8Lk5gZoc2Xih3FgKCcBy4dD9FmKd3RULbF9kv4=;
        b=XYoa5LiAjoCZDtoOUmFVouplg3HZBzAz1pgY7r5gmVutiAR5Vc/C4kXH7iusMpNFjs
         +khv+hVFkVJ3wXaCJvu2eS+VBAhrWou+ggr6BIDqBUMUe29y8+pNC29K3gzMO4UzHo2R
         Spjj9N0JLLbp0tkrYRMpMaH4bkxuLNxKG26gZRI5xv94aJjWau9GC/J7fiOEEztNQcBv
         +EgiKHahxyarabuHKP+8Uq6a2nns59b7V1ncSUgoPgsFBDYOrXneex0Q5H/xLVUAvJfK
         xpNzwPHTYTiQRPOO9I450+moGIlcfpOWc0HJTyAUmizedC49sQ+1UjYasoskSM84f7PZ
         M9iA==
X-Forwarded-Encrypted: i=1; AJvYcCX1uKpQhDSQbJGFN00izxw7H4MAQwcP+nXQhDSCR04UXCU8jyESOmpFIIG8mkAcHS1818gkuCIwjkp1PMOgQvbKnr+YnMp2vZrhirvo
X-Gm-Message-State: AOJu0Yw0tOX0+xj87jdbEUA6SAkkkGcTs+udZlFcTW7Dsinmbt3EymVX
	CjkZwT3OqKO3axOmVsa7FgXJ1UKhNT0zbtQlW7NifuRN5zHb+xyq
X-Google-Smtp-Source: AGHT+IGEA7jC8xN0wHiXDCJ51BQXpNvbtspxZ2HZIWa06QFobBRbtAEJM6Ej2J4zxvI26cglV7y/iA==
X-Received: by 2002:a05:6602:378a:b0:7d5:e4ce:2282 with SMTP id be10-20020a056602378a00b007d5e4ce2282mr6342349iob.14.1712989312186;
        Fri, 12 Apr 2024 23:21:52 -0700 (PDT)
Received: from lima-default.. ([180.217.195.31])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001e3e13781c4sm3980168plh.54.2024.04.12.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 23:21:51 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] include/linux/bitops.h: Fix function fns
Date: Sat, 13 Apr 2024 14:12:04 +0800
Message-Id: <20240413061204.10382-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified the function fns to resolve a calculation error by:
1. Reducing n first.
2. Adding 1 at the end to get the correct index.

This commit improves the accuracy and reliability of the code.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
 include/linux/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..2457610f74eb 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -258,8 +258,8 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
 
 	while (word) {
 		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
+		if (--n == 0)
+			return bit + 1;
 		__clear_bit(bit, &word);
 	}
 

base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
-- 
2.40.1



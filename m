Return-Path: <linux-kernel+bounces-101377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03B87A64C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB56282F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB33F9E7;
	Wed, 13 Mar 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM5z6/uh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC93D552;
	Wed, 13 Mar 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327518; cv=none; b=j04q/X+9nzKfu6S3K2w5nF4r0g4X1Ye8u45oXMrrlsjysXYoFjyKYiimeAC7EZeYoTrtOjzt8HubOCuac72FtmOZE5KZ/9V7nT2CG51UduW+sEfsBy/iJQSOSMzJCeNrTOrw/QpzdVeazNUudltkKErGaN57Eg7u1NWYZbleXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327518; c=relaxed/simple;
	bh=gAtcr9DRDtLEExSTM8iIcsQhUaU6gIAgK/w6NrX+LZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEsC7gebzUHVKijRilcvLZTdB40fxwtoyHoRTRQb0DuKrtQPvn8IJ4NKDgK4GEQXS3VCumu0RhmEeMXgYfH/Vv1j2MbhfgRIxtplaVvf3wGCheq7zymDblTYxZNNWpYpngXkpyh4Y0Af4GQyQrKtOeHikx+bG0CLIe+VYHgrb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM5z6/uh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6ade6a66aso844262b3a.3;
        Wed, 13 Mar 2024 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710327517; x=1710932317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6OiDuamBBAXOaKBTYclnqW/lnJ6yR3NtB8qHgG2gks=;
        b=aM5z6/uhMg2Gu9ev29Aa3Js1pu8LWJal2SXAJ2el8qAGFwVUSQZ6OKX8BQYyZ0yuue
         YhyiTqvGC7vmYHIHbNZqmbJwjbxVxojcZaVxf+D+ETppkXDu7lcIVyG/jrZXhMtim7tF
         C8fkrqfVnaZUxZYWT96dx8Ke4GoL7wuxQIAuQF05XfIuqV9859YGDMN0kJcB5zWG2Qzk
         dVwzvQLhOzMejgCKSYLKkMm+I7OfjFluwt36oeJtUCODZWMaWNBICmn0aRncKbxXYHFx
         qBRxLGoGqPVwXxAEbqREQYQ3wXopwl5T8gvxvkrEKtKVBqhl/UOPACZTzHkKELu9b1z6
         8TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327517; x=1710932317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6OiDuamBBAXOaKBTYclnqW/lnJ6yR3NtB8qHgG2gks=;
        b=lTd7Fj3Wn975l/ssjCKUoQL6UyQwAbqUnIBT0sUG5NVAjhQ8KekiRVaXqLy21j37uA
         UvoAnVe7gccqlOU4H1vwM60tLhfe97viwT2zXZdNWh4HkSk/XuUm4SwH+c4fKDHDaqbb
         VLvqgW7uyjoZRsJBgZLpFfJ340Wouk6XCpO23I943IXwuYt56k7AfCRSUBOnduXd3mAH
         RdHcNLYNuwdtkGijtE3hjLrB32AmV6jXiY5kY2ibUijMg98v2974UfkE56G6wXidrLMM
         mTKaDp4fdcIbnHu8LZjHuyFiOIIMSRXmix8r83B9oZiBDMeN3JtM+erW0warbTI3g34w
         eenA==
X-Forwarded-Encrypted: i=1; AJvYcCVpRMazo/ZRFOOgOBF0MqpruzZSIgkCcbQMjw/xhWmV3XKediml0NVRBjm6TAm8l1PEPA7wC8I0vmzL8xcUXVIipUSqer8+IWOGrbrfX/Iv7cX3K6sr0AW9pwuiOnwwA8uBxmO5W4FWBN0=
X-Gm-Message-State: AOJu0YyIwxMGv1i8qzu0V4AbtFJquqdzyW0Zf9h2FwxKgu8XwKlawh01
	O9lr2leTQGzD+V9Y6BgyqTfzHjvHFCwTgNHK2MnACohkqzIG4EEh
X-Google-Smtp-Source: AGHT+IEZbTzpHSY+/UqHdmOYvQwGB+CuM6omlG4CxlKwJuTmNzewj8VFGfgbXJcEhNx0OYFpqLclQw==
X-Received: by 2002:a05:6a00:2382:b0:6e5:bb8:dc1c with SMTP id f2-20020a056a00238200b006e50bb8dc1cmr2159870pfc.2.1710327516575;
        Wed, 13 Mar 2024 03:58:36 -0700 (PDT)
Received: from carrot.. (i223-217-148-4.s42.a014.ap.plala.or.jp. [223.217.148.4])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006e6ab7cb10esm2338844pfa.186.2024.03.13.03.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:58:35 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nilfs2: prevent kernel bug at submit_bh_wbc()
Date: Wed, 13 Mar 2024 19:58:27 +0900
Message-Id: <20240313105827.5296-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313105827.5296-1-konishi.ryusuke@gmail.com>
References: <0000000000002df264056a35b16b@google.com>
 <20240313105827.5296-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug where nilfs_get_block() returns a successful status when
searching and inserting the specified block both fail inconsistently.
If this inconsistent behavior is not due to a previously fixed bug,
then an unexpected race is occurring, so return a temporary error
-EAGAIN instead.

This prevents callers such as __block_write_begin_int() from
requesting a read into a buffer that is not mapped, which would cause
the BUG_ON check for the BH_Mapped flag in submit_bh_wbc() to fail.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: 1f5abe7e7dbc ("nilfs2: replace BUG_ON and BUG calls triggerable from ioctl")
Cc: stable@vger.kernel.org
---
 fs/nilfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 9c334c722fc1..5a888b2c1803 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -112,7 +112,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
 					   __func__, inode->i_ino,
 					   (unsigned long long)blkoff);
-				err = 0;
+				err = -EAGAIN;
 			}
 			nilfs_transaction_abort(inode->i_sb);
 			goto out;
-- 
2.34.1



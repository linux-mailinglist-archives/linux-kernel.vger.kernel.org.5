Return-Path: <linux-kernel+bounces-138118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0E89ECD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2621F231D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D413D8B2;
	Wed, 10 Apr 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJf1uZtu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033813D886;
	Wed, 10 Apr 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735803; cv=none; b=tGJcAteXrHyuMJ1i5jetFBawHeQmVk9GmWHTpvL8RE+QLBUDFaPO+lVhSBdPaykFvvzYR2hE2k/aqaZQ/hxi+0xeXyPo2bjRZqfMX4DwcvYraBAx90Q5Grrcwq/YNQ7bt6ew1bCvj3/Sg0WV7KGxoYLlbd8zfM205s6cNZiBJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735803; c=relaxed/simple;
	bh=jrgOXdafrMcx7grNirnyJC6h5hhvJTQeITYQGc4zzCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcXbPHvY0KPI1oDcML89VtjkmBZzf26yu6UpuaEn1m8miRXeMC2Jk02cG88+zj3e6WlgMvIIqnVAVy1EUPu+kReSyvsHg+J07LW4nlT4clGArGz/xlFNV0r/ThlkH7sZRgLeajs7fQnFJeRX77LkNX31KADNgmfqMRcYTelxL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJf1uZtu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso4684543a91.2;
        Wed, 10 Apr 2024 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712735801; x=1713340601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J09RByZyhyeDXvBilXqv6zRleliC/Y8g7rTwW7io2nQ=;
        b=eJf1uZtu65sC1DwcdBrZUN/CivgyKdCg9lnBrl7+PeoaGr6K1O2InflP1EOalEXInP
         8FW+8A419dugWUrzsX7oVOAFuPb3yFmLmlWI4VOzuA6eorImQMXxm9ynxDrocIXNgk+G
         wCkwj+PXQQastqN7XQ7qFi2RMH7B8PLaxNMivOwWTCQo8vugLnkiqriptaRqGzTq8Fjg
         1u5on7I0Q0HPbyefQYTijZ+kQ6gas466gNhjbTOndXVQMMGLw5IfUD8I3p4oDmsRGrhD
         3igrBWsDtPPGeRX+Few+xxb7P4kfY9tqpRVV5IuaAqqqlanN7MYhNtiH2M7oJQ3x6w1l
         r9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735801; x=1713340601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J09RByZyhyeDXvBilXqv6zRleliC/Y8g7rTwW7io2nQ=;
        b=RgM5F5GsFucqJfUuk0PQMUSdR8GPPl65WzC896I2tNP0tHejn8VfANKJW+9nl9VOHL
         4NJhntQ5UvEsNLt2G2GtcOZHKQmeF2BnfdQTL5+atZgaPz/qzZlscFHu5tJ/jsa4nisT
         4eQWX87qm+UPTOYjl3akea5SibtSKb47EmJbM7y/V6uATkpFPU+imFddu/5RbRcSM1sT
         Ne5Ycm8zJ5ow4T4W05a4D/XYo7lyyIfa7qZgpTMnI0py53Zqp8vQYi+pyJGEutIW0N4i
         x4x7N/WPYleERSea8yAVD3hsZOC3w4Ed2QFBCCknaaBCiwVUdPTbmYbRANQyUCTRn9ls
         U3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXOM6RjORCsmDPO5fJk0e5snxCMIqAlwfZgY+S2vZp9Xb6YdPUKaB861ucvCginnk+p99/ETsmEIHNZE2/+a9tBbYYekPMk9uPibP+G
X-Gm-Message-State: AOJu0YyHb7I+Lj9Govba/cW7Iygz4ZLJP/pweg5icLuGw2rsy9qwv8ME
	ZTvG3eECp03UDckHstOpvBMbfs0udT7SXsnoxp6k3E5DQIAaLTNhgIMXAaQL
X-Google-Smtp-Source: AGHT+IFntzDtG7EXIma34/gE6LivnSxvn5mY2wOS0ppIRUApDKJovl5/inEq8n95frNn0z+kjZlP4w==
X-Received: by 2002:a17:90a:c294:b0:2a2:399c:a859 with SMTP id f20-20020a17090ac29400b002a2399ca859mr1894381pjt.35.1712735801113;
        Wed, 10 Apr 2024 00:56:41 -0700 (PDT)
Received: from carrot.. (i220-108-140-44.s42.a014.ap.plala.or.jp. [220.108.140.44])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm9438001pgy.45.2024.04.10.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:56:40 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] nilfs2: Add kernel-doc comments to nilfs_remove_all_gcinodes()
Date: Wed, 10 Apr 2024 16:56:29 +0900
Message-Id: <20240410075629.3441-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
References: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_remove_all_gcinodes.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/gcinode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index bf9a11d58817..1c9ae36a03ab 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -175,6 +175,7 @@ int nilfs_init_gcinode(struct inode *inode)
 
 /**
  * nilfs_remove_all_gcinodes() - remove all unprocessed gc inodes
+ * @nilfs: NILFS filesystem instance
  */
 void nilfs_remove_all_gcinodes(struct the_nilfs *nilfs)
 {
-- 
2.34.1



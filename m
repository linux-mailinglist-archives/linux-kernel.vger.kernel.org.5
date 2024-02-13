Return-Path: <linux-kernel+bounces-63190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F503852C23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1985F28650C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CBD22097;
	Tue, 13 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFdjmP4T"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E8225A4;
	Tue, 13 Feb 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815853; cv=none; b=foaX+5QSc80adFER9JPO+pjo9wxNllr0qPGdo4ZWrCmZCswjSDhhKX5UgWGtR3W/zsfNnGVcrnfCQjl/gdjQMhb+pbj+FQjjfKJSX8L8u+mill/YJKiznovtoMkpgPLaQa9c+PKrVGqTgGcdhlPPqoe/yOAgdQDpQgX6slwA+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815853; c=relaxed/simple;
	bh=ZfYUeVMl6AYblsdyIrX3nVKH+xT9BNV6zy6NmrP+hoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=doSlJa2yEESvBqnfMIoQsCJKWxEjBCBa4Fc8m0F4VKWuAI9xTC9c8Ur+gKf2Qf/Awamb9tgV/yITE8yg3L6diOIINipVOb1StdvoIJGp7M7H1T80ts6mY/JCa4859laUlClUfoqL0KmE0C/9BWDxzQ3EwwdtZPrX+u1ikNnwvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFdjmP4T; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a9c21f9ecso22848101cf.0;
        Tue, 13 Feb 2024 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707815851; x=1708420651; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8l8YBrC4jhYQEFBTPrrabrCLybr3DvkI5ByH89g4rc=;
        b=TFdjmP4TP2SznhhCc3RzlKuSDhwXo53ItMRFQAAFW/jhZ3W6QcNfKa9gTdg13CI0Uf
         FohaelAOf2Vl6qBwV/V0PsSIOlqdoAmGI7Yn3XvSu0Kgm016vdrXU05cCZwdndUW4SA2
         aWhhMKpl5ktRbErJtcrHKIOLIC6fKKQyL7jR4HiN38qwLWf7qRJd8Q1I8VeM/u2MIg5E
         p+5/G58myTulIlNl5w8iI9kgNHSLW56OFM/SS4gWsZkz1rHkIjH5TFnrnKKsGgzjEDWg
         9g4CEm8cm6qivOg32xhXYHNSsBveA3FcJH6vKzONSH/bNJ/6kuq2wy20EBT4CYqqA7Y9
         DtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815851; x=1708420651;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8l8YBrC4jhYQEFBTPrrabrCLybr3DvkI5ByH89g4rc=;
        b=PeHHfMzsYOysxVuDneT2teIeKtV9W62zmofCrCsSp3VeWqVh38FdSJbgg7ifgQ2Q+Z
         wO6lXO7uSa/tAbai83QzfR5Typys7aS7IQkH+/cO40dLVe5REZezj8uUgZbpUbWhamGo
         Q+VV9eLCEgaOmRwDsNb8sarYhdltdoVj9amgo5Nzqi8ItU4qVZ4ybg+6DSo9npcYAgka
         UyxE9I2GMp3R/Kr9FY+THHPdQJq9KjyeLG461QlmEDCdEan6YOqdT3pKdRgTGBBPM4B5
         V4x6KnpnQQVPPvBQslhoU6FSv56rPK9cm1imrM4IB+SlFf1JMOYUw+ZUqIoB6XIyRI5H
         JqmA==
X-Gm-Message-State: AOJu0YwUNlXc+dVkNl60mOKfhmBb7EgoyOejJThkbDR8LOU9i7fSemkp
	q0ZCkvo3oHD1/24GTLCgNIpyQf+ezYVH5K8Vky8utqdPTl2tHDboLp4K1tHN2A==
X-Google-Smtp-Source: AGHT+IEr6JjDsOTC5+jgquFmev1o/xNjgQ72kQIXg07hiJvXnWbnKoP7UbRqufY0oe1W1Nodgvctxw==
X-Received: by 2002:a05:622a:44b:b0:42b:fda6:dbf9 with SMTP id o11-20020a05622a044b00b0042bfda6dbf9mr13589667qtx.60.1707815850629;
        Tue, 13 Feb 2024 01:17:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr7WfCVPQHipV6ZVVxCf6WWqNgWUWFQXPGtE++2Aa/OqMmr2Skc++a/B6EKs4gNGX/BYWJ0M3bhYONWrjM0/cI3w/dtZcKpJ+StNSsSwjUXm8IV0v1VDa3UCvMTNm0D1ybCJ3j/BqlrnUArL7omtuqhxJYlXqJ1yEOeG0S6m8i8z5dx3A=
Received: from localhost ([207.181.197.26])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85c8d000000b0042dabcf07eesm596424qta.6.2024.02.13.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:17:29 -0800 (PST)
Date: Tue, 13 Feb 2024 03:17:28 -0600
From: Lenko Donchev <lenko.donchev@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: use kcalloc() instead of kzalloc()
Message-ID: <ZcszqPoW8RMaOvTN@nixos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]

Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
---
Changes in v2:
  - Use sizeof on actual pointer.
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d435446537ca..725aa84dbd22 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2636,7 +2636,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		goto out1;
 	}
 
-	pages_disk = kzalloc(npages_disk, sizeof(struct page *), GFP_NOFS);
+	pages_disk = kcalloc(npages_disk, sizeof(*pages_disk), GFP_NOFS);
 	if (!pages_disk) {
 		err = -ENOMEM;
 		goto out2;
-- 
2.43.0



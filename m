Return-Path: <linux-kernel+bounces-5460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B249818AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF82D28738D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785DA1CF90;
	Tue, 19 Dec 2023 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb8LY7GB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546241CAA6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d337dc9697so37589515ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702998730; x=1703603530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baJt6G/4qPb8zglT/xyJaL6ZBHyfDB+Q6WEILSj7ppg=;
        b=Gb8LY7GBW9BOV3oReMiJQfOURwYEkfL18VVHBIF4ygUJv0Macx/JsPfSBeNMECdElV
         FHTuThv8qVp/FFLMi45bbrgXIwnABGByTh7LBrDmBbVdh/Gj+7PhuNHa7bAyxq0ZsnpB
         BX/KpFFNX4FT8okaTsOp04bmmSdw+TxqUtKvVYgVkP3WiEjBkKRkkpRhg9G2MUkKdWCj
         2i1Khxg6a2iol3V+uiE6s3f0K2g7MBlZHC/ka1E3dOvkCiWoKFuL2785MNEgQYrajzYR
         wjbcYfMO+qanczcny3MrcamocO/DA+4iKGFntUYOQfTEhGMS77VZ3hlvQxXLI8VvblbR
         nzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998730; x=1703603530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baJt6G/4qPb8zglT/xyJaL6ZBHyfDB+Q6WEILSj7ppg=;
        b=kUY+lYQLl3t6+qAKJ80WN8CTcyBfsVw+bGSHbPOJgjxWS81U14qlgpXq/a+YJF8H+k
         WRHLTrlhNTOhxQ9DdY4FRl3iMPei66cui0fpzF1Ug2RpGeHWAoQQd5BeU1fxwtdzprtl
         HT/k2eNMy0kEfd8CKt2h8XDp3OioesFqQIRHSlUIicQs7jidCh6sCCPOUZxTWYFJGEOZ
         wP1rWmr6ActgEfDGTm8RHJBhUkeiUiMx1Psk+QpVp8okbKjGzRuFMFQavL3SBRulHCLZ
         GgBWc92+AjMNa7Q2FSsNDqEFgKZ+OrfrLdZQXKIpvPciGCT/1lGmOo+FS/gDFmRuvA9x
         wL3g==
X-Gm-Message-State: AOJu0YxFk6SoSd65MWANFmJtyM3bu5EmM9MLEXUjo2OTa6Uh2jy4wwuO
	RjApNWnuUgiTfQLQN2noyrX3uW/ak4Fcsg==
X-Google-Smtp-Source: AGHT+IHfdZ6R0U+E2xX6yCPVgWUy5sQVy2si5HU/UPm//vCJHd77Xz2+r2mUt2rvJPYe/t6oROHAYQ==
X-Received: by 2002:a17:90a:578c:b0:285:cc9c:7406 with SMTP id g12-20020a17090a578c00b00285cc9c7406mr12346074pji.15.1702998730174;
        Tue, 19 Dec 2023 07:12:10 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id pl18-20020a17090b269200b0028ae9a419f0sm1713763pjb.44.2023.12.19.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:12:09 -0800 (PST)
From: Piro Yang <piroyangg@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Piro Yang <piroyangg@gmail.com>,
	linux-staging@lists.linux.dev,
	Linux Outreachy <outreachy@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] staging:vme_user:Fix the issue of return the wrong error code
Date: Tue, 19 Dec 2023 23:12:02 +0800
Message-Id: <20231219151202.50368-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue of returning the -ENOSYS error code when an error occurs

The error code of -ENOSYS indicates Invalid system call number, but there is not system call error

Replace -ENOSYS error code by returning -EINVAL error code

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 v3: change the description and format for the patch

 v2: split two different changes,
     only fix the issue of wrong error code
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..9bc2d35405af 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 
 	if (!bridge->slave_set) {
 		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.25.1



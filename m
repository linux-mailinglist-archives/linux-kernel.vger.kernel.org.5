Return-Path: <linux-kernel+bounces-5654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAAB818DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DC1F26473
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFF8374D8;
	Tue, 19 Dec 2023 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTkQ9RS6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9EF37D18
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3b547cd4cso13236395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005492; x=1703610292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PM3d/NIEm0CgHdjXGgWJHdZqyX/EyowpB1E8sCeJFsQ=;
        b=nTkQ9RS6yF6YTUXaJfSKTnVAWwbpqrJDPPXw0BYmwcULXPYtd/eMNGrY89VEpCpcQq
         679wuwAnv48eZOSw4AMDx+HzAE4uC0vN3WXInh5Cm51gVx73srCKd0QJ3eUrtTer5HMS
         l2u4TP87labe2eIfMel77YBgPM5b5I+wEIUanfPGPkRQoQZc0NZuwGlNNFY4mk5JBhz6
         nigQs/hkpeq+DN5QPAvw13fxoxlRqhgmL5vgQ/we4+R5gn7uzGltTAflxjTIErKFuUhL
         ZCQkq918FK2TnhdYlVhzuHGMpjHHLp7JdqzdYz11I056GBW35zZ3h/zrCG7k3q4p1xGC
         uTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005492; x=1703610292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM3d/NIEm0CgHdjXGgWJHdZqyX/EyowpB1E8sCeJFsQ=;
        b=tRWVOQdRc56aMfr3g16ayMWWEW9ZM2vQZinpPJMV7DADOUWSdcb0PUFfOdPHHb4gaQ
         FqJTzx0Ygsy5rDDcjDkBQhMcZa61d5Rv56YFpwUX9YkPCb4b0UtHnznWi7Hlz3UwJfPJ
         FcS4/Wr475E1g7FLwZ1pPpshH/FXyP/FCVuIKVkRCzSTCyQkiiW6Jn/pxxhJJtLhz5/T
         EDFk575ka9wSikpANPk0nHR4rjH6lHMLhwNcZ6ay9o0fY9L97VOD4o2/Bzp2aFPglF6p
         /xpFFk5mdE300gU31M0ySBnqhIcR2ATItpm7PFOOi0ZSKdzYZWGoATPoxAKZOhoQnZcw
         TvPQ==
X-Gm-Message-State: AOJu0Yxe7knfowVYp3FlwEgWz8uuotTaJdvS3VriFBdIGxiycS8TLMNa
	TojaY/wgWfFqkNcH+mKYNgjsDwKmTiSJIVEi
X-Google-Smtp-Source: AGHT+IHQgNuhzqrQPtNQjBc+osfO174/ED1jJW/wYAuP9su9cJ07/ku+lOPExF3f3YGLZQ1xsJM4/w==
X-Received: by 2002:a17:902:a517:b0:1d0:6ffe:1e8d with SMTP id s23-20020a170902a51700b001d06ffe1e8dmr9592303plq.112.1703005492195;
        Tue, 19 Dec 2023 09:04:52 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b001d349240e60sm7785817plb.72.2023.12.19.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:04:51 -0800 (PST)
From: Piro Yang <piroyangg@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Piro Yang <piroyangg@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4] staging: vme_user: Fix the issue of return the wrong error code
Date: Wed, 20 Dec 2023 01:04:47 +0800
Message-Id: <20231219170447.51237-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue of returning the -ENOSYS error code when an error occurs.

The error code of -ENOSYS indicates Invalid system call number, but
there is not system call error. So replace -ENOSYS error code by the
return -EINVAL error code.

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 v4: change the format of subject and changelog.

 v3: change the description and format for the patch.

 v2: split two different changes,
     only fix the issue of wrong error code.

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



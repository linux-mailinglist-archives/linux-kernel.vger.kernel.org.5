Return-Path: <linux-kernel+bounces-10517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26581D56F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC4E282D96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1512E5B;
	Sat, 23 Dec 2023 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrRLT6S2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4C12E4C;
	Sat, 23 Dec 2023 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fd902c6b5so16919445ab.3;
        Sat, 23 Dec 2023 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703354092; x=1703958892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SaUDwNTg1blaUyP750dMZEiGn9n6kuZs/1CtsChhpc=;
        b=hrRLT6S25u72WwAFWYiC/Wp02SuZhWwl2KRxALOQZWw47s7zxIA2whN8AhpVNyHbdx
         0ixDeDqhTnLcVY61wYjWOF+K84QEevpAfMd8WzTv+hJJV/ORQRxtTnzUh8q+lzXwkzLz
         ROo0ttBpOhVbyByL/ZwYVQ/GS79IIOb9OipO34q7DBp3dvzNPtZjJ+E9bB3hvlCwu2BT
         WpmXtYQsJectIkM19kIDK6yKGT+yqfpqHpttuDJnmdBqBGiZwUYTFqXQgUe8OxvT6881
         EUIuHzSoU3IO3lYHPIdWC4SMKGoxztM7TuSOi5w73l9ahwRaYinBNtf0B244TZ9o0v84
         C+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703354092; x=1703958892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SaUDwNTg1blaUyP750dMZEiGn9n6kuZs/1CtsChhpc=;
        b=ixTxfslsj0BsKlHufqbVXFiGql2Wcerh71iqLmNg/jIsgnwEsFB/pzIrYtKvd4fERU
         HasMInCRrJ76AW4RkWlYvY8Vk1AGPQQznQ42coPJjzUexP29woL5ekZdyycRomPeqSTs
         awYx6KkrmkZbPODI65YZ71OfY0lu5lg/2I/6rIAWkLdUkAjMTsENBoTZXGtpfJl2u68H
         nDfuL56mUzhUK+45gWJzWEJxtEyY/cU0tQLdvJoX8l2cXL0/Zll1ebLXLc5UmW1w4elA
         oAUXNKm6H7cpmhJKYSqynOHIUEnkV5nfzpxe7KpUMye9fnsJxfKKL82U5qVCki2H0Yop
         nPVQ==
X-Gm-Message-State: AOJu0YwjQONOmGAa6o1FJxLJgR5sxRq7b3m8j3b19SVivKZLsdybBI6C
	RQ4C8HmiMEg47O5McU8OR6qvOaxStvq8NQ==
X-Google-Smtp-Source: AGHT+IERPgfpQuTesSrKnIiLJNquBCYTfP1+C208hU8VZwgj1UhObQKLG54cEziGRzt3NXFp1azWAQ==
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c538:8aa7 with SMTP id i12-20020a056e021d0c00b0035fc5388aa7mr5174639ila.91.1703354092380;
        Sat, 23 Dec 2023 09:54:52 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([27.5.150.118])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm5373750pls.196.2023.12.23.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:54:51 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	corbet@lwn.net
Cc: attreyee-muk <tintinm2017@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/core-api : fix typo in workqueue
Date: Sat, 23 Dec 2023 23:23:17 +0530
Message-Id: <20231223175316.24951-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct to “boundaries” from “bounaries” in “CPUs are grouped according to NUMA bounaries.”

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 Documentation/core-api/workqueue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 0046af06531a..33c4539155d9 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -379,7 +379,7 @@ Workqueue currently supports the following affinity scopes.
   cases. This is the default affinity scope.
 
 ``numa``
-  CPUs are grouped according to NUMA bounaries.
+  CPUs are grouped according to NUMA boundaries.
 
 ``system``
   All CPUs are put in the same group. Workqueue makes no effort to process a
-- 
2.34.1



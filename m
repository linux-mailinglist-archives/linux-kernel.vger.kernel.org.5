Return-Path: <linux-kernel+bounces-27422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3F82EFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FD1F23C83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8681BDC2;
	Tue, 16 Jan 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq8OELEY"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C541BC55
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db786df38dso1881562b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705411929; x=1706016729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toKzuFniRcNlr/ckldQaNDhULExFRcUqJOSIbFFbNgg=;
        b=iq8OELEYdiOz8NYoumXVB+GvTE9hiLxZI/4y2bL7GdbPReCC5etCuHw2/0UG2jYA1P
         LoUxupjOPEs7ySGUR+YhUurU8bOmixlSkh7WSFfxd9HMhuvSMoak7ILAEsL1pR1XWAFu
         XbqX57NsMxe2IW/E2/YPX8sEganyBP2SylyMcvGBiMYn2USqbMvD0/6U5rGkEget4aDJ
         GHv5FIrx/HCKR0x3tOg5ZUb2HGokcP28yIowpa4s/zM7GUDk2Uc+BkJu+wTy8QtJ/TpI
         SLM8fxLFZ7SmKKapTVdaGXGO1WQfF0z8nMNjE0L6Dxh7+um+EqP4OyoNOEwU/2zcq18W
         3ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705411929; x=1706016729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toKzuFniRcNlr/ckldQaNDhULExFRcUqJOSIbFFbNgg=;
        b=lqt8EsISLxJ97vjXiRlZ/EtwSQ2vQjLa7x55FbmOvVUuvqg+dmfjr9lzTN104S/THH
         1i/JBVF06MOAtLyZJTTIiIpJUVglrNApDtQrbGWbHcQMP0icGx5erZ0S1K5Pu5UdJ/F4
         r4SpRXkJ/cX9ddDZIXHjB4Ug+ik0d2RPasDsBB9L9PwYiZxZ+r96fFGGRIS10R+eRL7/
         Y4p/517F+XIAeIqnmeVdUicV58D+suqITQHYk7kah14hjywSM/VGwuxwgvEmPlgjzaIc
         a7lIz+RwnH9PePPbNVFDMwaBF7xVHw92/8Xq+iwW28YWHQdt3gRtiyyImPT5hwr5A6kt
         7iGg==
X-Gm-Message-State: AOJu0Yxjtjk9ytveG8CwtbuN8Inba5QWA92FAInsWHpXdRIt7DVa9duu
	xAmQ/a6oXTW6BOcZcqzfmkY=
X-Google-Smtp-Source: AGHT+IE936n+Xe38cFygc8eo7sinvQaf/CW5svZJqPkKmqnFtxc6+RfgXV040dD6uSB+3F7ZyySrww==
X-Received: by 2002:a05:6a00:2da2:b0:6da:1833:cb6b with SMTP id fb34-20020a056a002da200b006da1833cb6bmr8654996pfb.59.1705411929442;
        Tue, 16 Jan 2024 05:32:09 -0800 (PST)
Received: from eagle-5590.. ([192.166.246.176])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a0010cd00b006da04ab75a8sm9259336pfu.1.2024.01.16.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:32:09 -0800 (PST)
From: Ronald Monthero <debug.penguin32@gmail.com>
To: nphamcs@gmail.com
Cc: sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ronald Monthero <debug.penguin32@gmail.com>
Subject: [PATCH] mm/zswap: Improve with alloc_workqueue() call
Date: Tue, 16 Jan 2024 23:31:45 +1000
Message-Id: <20240116133145.12454-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core-api create_workqueue is deprecated, this patch replaces
the create_workqueue with alloc_workqueue. The previous
implementation workqueue of zswap was a bounded workqueue, this
patch uses alloc_workqueue() to create an unbounded workqueue.
The WQ_UNBOUND attribute is desirable making the workqueue
not localized to a specific cpu so that the scheduler is free
to exercise improvisations in any demanding scenarios for
offloading cpu time slices for workqueues.
For example if any other workqueues of the same primary cpu
had to be served which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.
Also Unbound workqueue happens to be more efficient
in a system during memory pressure scenarios in comparison
 to a bounded workqueue.

shrink_wq = alloc_workqueue("zswap-shrink",
                     WQ_UNBOUND|WQ_MEM_RECLAIM, 1);

Overall the change suggested in this patch should be
seamless and does not alter the existing behavior,
other than the improvisation to be an unbounded workqueue.

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 mm/zswap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 74411dfdad92..64dbe3e944a2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1620,7 +1620,8 @@ static int zswap_setup(void)
 		zswap_enabled = false;
 	}
 
-	shrink_wq = create_workqueue("zswap-shrink");
+	shrink_wq = alloc_workqueue("zswap-shrink",
+			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
 	if (!shrink_wq)
 		goto fallback_fail;
 
-- 
2.34.1



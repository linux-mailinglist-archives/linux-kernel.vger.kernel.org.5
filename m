Return-Path: <linux-kernel+bounces-4942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E0818428
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5268028719B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8412E44;
	Tue, 19 Dec 2023 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLkJqo/t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A573134AE;
	Tue, 19 Dec 2023 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdc159034eso49209a12.0;
        Tue, 19 Dec 2023 01:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702976971; x=1703581771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUeSDdZw8uPeQ2XORpdHymUrGMNnnZoNXCwu3+iQlGc=;
        b=FLkJqo/tLRRlWROKKRTlberWFPlEgdWloTW35BBfcTju/p8a0vGDc00UREKarUCnwM
         m3SFtVQj7N69L1zhEfMLUiVrJvY3asatdVD77bKnKaVxiruOc09mTwq3S5HY0R/9UqZq
         xrs9MNKhq7uzaQwTriVnKThBGtCj19sPwqWGdqu3HSo+zoFIxSn/puL0IcdrntpKNBEM
         WK6qzMi1S9JtXlMOnWZ3eWV1DwednpWODtfV4gHRvwGk51RsqaPbE8/SE/V9a65azOWv
         4Jmlxi8FeHtr0UGlgZnb+TQY8qpanCLi7lJbRYkhe2FN+pYT2ylH0zBcfyyrPJI9B/zZ
         JihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976971; x=1703581771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUeSDdZw8uPeQ2XORpdHymUrGMNnnZoNXCwu3+iQlGc=;
        b=bRuxrgOP/HTOHGnKfLysWzMGgg9RSi3Qa2URCnjIv4Ld+A9/3nBPckOzjus03OM7N7
         0AIxZ91XFcMFUp9qZjefxsX9+yj2Ae8GW9sCFuA7X2ks1icouYehLJMjDEOtFs3ya93H
         Ugb/L/ADlCJo6dLoz1+ZK35T7FrtiYLFM2RSwUw9SohFnZVwZIovmGIFcfu3LwjqDMBB
         YgxEjfsOYX1DjeC1Q/iGRo3x/5DviPPT2JRWmfe5LI4hI9DlE6PQG131ZIGZTFI2JYdj
         L5Iyqyv4Ku4KcbdsqDvxOMtFj4ctvhhj1oTcOcCxgTNLSEo8n+6bC59kH+fabThJUzKY
         CRdA==
X-Gm-Message-State: AOJu0YwivWhthAql3SvzF6TQJBf1e3dzdjMu4CZGFmpqCAOkh9GXgAPg
	dNSQk2sy/jDClQUqCLhlyj4vqq8A/Ww=
X-Google-Smtp-Source: AGHT+IG2yOOGtRSe+pLzQg4kdVa4susxKnGV96oGSYuCCkD6NA3l78QmqUTqm9Qo5bGXhE1eZzpI7w==
X-Received: by 2002:a05:6a20:7d9c:b0:190:31c1:31aa with SMTP id v28-20020a056a207d9c00b0019031c131aamr10212260pzj.49.1702976970716;
        Tue, 19 Dec 2023 01:09:30 -0800 (PST)
Received: from carrot.. (i118-19-13-241.s42.a014.ap.plala.or.jp. [118.19.13.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001d35223d0besm7435399plt.251.2023.12.19.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:09:29 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Add missing set_freezable() for freezable kthread
Date: Tue, 19 Dec 2023 18:09:18 +0900
Message-Id: <20231219090918.2329-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

The kernel thread function nilfs_segctor_thread() invokes
the try_to_freeze() in its loop. But all the kernel threads are
non-freezable by default. So if we want to make a kernel thread to be
freezable, we have to invoke set_freezable() explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Andrew, please add this to the queue for the next merge window (if
it's still ok).  This fixes an issue where the log writer thread was
not calling try_to_freeze() as intended when starting suspend or
hibernation.

I haven't run into any problems with or without this change in various
suspend/hibernation tests so far, so I haven't added a Cc tag to the
stable team.

If any suspend failures are reported due to the lack of this setup,
I will separately request the stable team to backport this.

Thanks,
Ryusuke Konishi

fs/nilfs2/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 52995838f2de..2590a0860eab 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2588,6 +2588,7 @@ static int nilfs_segctor_thread(void *arg)
 		   "segctord starting. Construction interval = %lu seconds, CP frequency < %lu seconds",
 		   sci->sc_interval / HZ, sci->sc_mjcp_freq / HZ);
 
+	set_freezable();
 	spin_lock(&sci->sc_state_lock);
  loop:
 	for (;;) {
-- 
2.34.1



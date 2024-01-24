Return-Path: <linux-kernel+bounces-36471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABB83A15F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FCC1F23986
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E5E57C;
	Wed, 24 Jan 2024 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCUx8dvZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF3D308;
	Wed, 24 Jan 2024 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074568; cv=none; b=HSnmpYHQbY/PPk1bhRTaJMGJux9W49dsAMcO1S43+odds1I/lJcNeBoLPQp8locB43LDiy9qKRsmVTkQ3LLdMplb542dNOlBMdl0SfVT2vYbyYt17LVxAytS9GcN2BEBPC/C1GNG7Vyykb1r2nKzfLVLLsddu/1cV77MagWZN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074568; c=relaxed/simple;
	bh=v/ix+cVRZOEdhWEOGitbvf7VzG2VcCJT99ME+jnSzMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asp9SgQmDGYoXUiOhJjqt8+Tl8myJvbcSEffHAvU+GabSVOCiF0qq4uKh2dOJ8KJ0mBTxZc3QlFygzgctwoKB9K/Q3vx+vlSVQBueNtHyb4v4ipz8SJyk5jcFNShT9Kr432KiuzhSB5Vg+5LCuUkTAFQARsUWnFv3YMaIoXWoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCUx8dvZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71e24845aso29265375ad.0;
        Tue, 23 Jan 2024 21:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706074566; x=1706679366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ0sCmGXLP/qfV9K0ib2ZteYu2JlA9j0Rku1SRZce/Y=;
        b=WCUx8dvZhRciTxtYJ5PaZA/d+8kk4RKZhR4TegqxoJ7QB8EjA3y9kXOOF7GcYj9c0Q
         Fxt1x08CwG2nPtAaPGCZXwpXfVy4VpVMJZIdj5a9Lz2ZYshuPox4JwF1aTV9dylBL2Qy
         IH6p7DTj+bkLfpQ84u2+8mMuhwNRCHLB0sj00OCPn0XxzNGO4N0yxk33wS5KWxphUrXH
         c3AIImNeom0dPDFfduF8aUSOOU+Rt8ihK5xTbJBPyrKolUoARUAJkAbSzzM0UePhkRLR
         rfdx8xmA+j4AVFnUoZLb9J3fektlDTVZvWZ0IGbPGteJiHJTJJ2tsUTxGLNhgoNsfHIG
         x7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706074566; x=1706679366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ0sCmGXLP/qfV9K0ib2ZteYu2JlA9j0Rku1SRZce/Y=;
        b=Ds6m14sPTjMyqSN1+z9+JrfF0EfO4SDRU4ObLV8jr1eB2lblOEHx6bwhwEJuGP8Srb
         V3a3SmnBuIUVJhmfFFtu2kf5QOhE8dcd94wX23XyeZkTPPNRUAetENP4KFe/JMj2p6IF
         VXnXdx5IFreQWHo1PwCvjOj7KPHLYvZdeJy5YCy+Yz1+tr3EVZSEK0ADH8cQBkuFhVDu
         KgUPNBN3c11dMlaJWPd2wHGKqee7YJNpi41nIyksBCyuEzd8nRM1YYzCsSh3+JK5i1kD
         Il9++c8RyioXZCpSGxNcyAOODq8Kg/4B4WgXzEij0lercpbiVzMSxu/Ewlk2/jXfZiQd
         gecw==
X-Gm-Message-State: AOJu0Yws40kEwevVN4U5N0HnVwRolXXFXlnQ66LYmnmO9OsdINFzmoJM
	cmbkrZuCNTm1l0E1yXPAKeKZAVjRSrUXhq3cX9M1T9O1KcAoTrVOD5o6hQ6m
X-Google-Smtp-Source: AGHT+IF9xntCNFkSUHl3PujvHK/HRxkb9K/5UgfQmqV1GYtatOjVmSeH4Ik442zFBBKwdkB2ywPk4w==
X-Received: by 2002:a17:902:d50e:b0:1d7:396a:2188 with SMTP id b14-20020a170902d50e00b001d7396a2188mr200652plg.12.1706074566033;
        Tue, 23 Jan 2024 21:36:06 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm4015663plb.189.2024.01.23.21.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:36:05 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v8 0/5] Fix I/O priority lost in device-mapper
Date: Wed, 24 Jan 2024 13:35:51 +0800
Message-Id: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

High-priority tasks get data from dm-verity devices via RT IO priority,
I/O will lose RT priority when reading FEC and hash values via kworker
submission IO during verification, and the verification phase may be
blocked by low-priority IO.

Dm-crypt has the same problem in the data writing process.

This is because io_context and blkcg are missing.

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. Make the IO priority of the original bio to be passed to dm,
   and the dm target inherits the IO priority as needed.

Changes in v8:
  - Rebase patch 1 on commit 7ed2632ec7d7
Changes in v7:
  - Modify patch 4: change dm-verity-fec.c
Changes in v6:
  - Rebase patch and resolve conflict for patch 1, 3, 4
  - Modify patch 4: fec_read_parity() follow the priority of original
    bio
  - Update commit message
Changes in v5:
  - Rewrite patch 2, add ioprio parameter in dm_io();
  - Modify dm_io() in patch 3
Changes in v4:
  - Modify commit message by Suggestion
  - Modify patch for dm-crypt
Changes in v3:
  - Split patch for device-mapper
  - Add patch to fix dm-crypy I/O priority question
  - Add block patch to review together
  - Fix some error in v2 patch
Changes in v2:
  - Add ioprio field in struct dm_io_region
  - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
  - Add two interface


Hongyu Jin (5):
  block: Fix bio IO priority setting
  dm: Support I/O priority for dm_io()
  dm-bufio: Support I/O priority
  dm verity: Fix I/O priority lost when read FEC and hash
  dm-crypt: Fix lost ioprio when queuing write bios

 block/blk-core.c                              | 10 +++++
 block/blk-mq.c                                | 10 -----
 drivers/md/dm-bufio.c                         | 43 +++++++++++--------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 +++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    | 21 +++++----
 drivers/md/dm-verity-target.c                 | 13 ++++--
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 ++-
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 102 insertions(+), 83 deletions(-)


base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
-- 
2.34.1



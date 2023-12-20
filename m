Return-Path: <linux-kernel+bounces-6682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF008819C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B70C282632
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECDA20310;
	Wed, 20 Dec 2023 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9hhbzbr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C9200AC;
	Wed, 20 Dec 2023 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ad3ad517so15507635ad.0;
        Wed, 20 Dec 2023 02:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066627; x=1703671427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv7pcKESPT+TCkl9Xrdp73a8YfbSAnnQTKjLK4qwwlY=;
        b=T9hhbzbrVuOcUjp1vYUrxu0M6NAAvZK3U3pP+WtzQBHyJWKvbLCbFSIJwJUsg2eGxd
         axg7XJywoy1/a8EwgF0tK86vikMgFa9CBSoNfDhqvdxbD9KrlbTXUb7sONeXLXtz7t/Y
         ltlEnJzp7y63JDiF7l1SoZN8ns0ttN0/tjnp63eouq/60XdmkL0/BpEKxC2w0u1IhkyC
         EilxRhKWfNxhQ14m7bsbLH5Ck1RcMTCAdf5vLCGUKGG0P4gEpki0kFZ0cwIyc/u1SRNd
         iZqggvQOtUkhwsIFccpKIAMF1Elhbw4Cf2ej89ZsmJ8gkO4puBPUmgjYzxOOq4wHqYT7
         r0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066627; x=1703671427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv7pcKESPT+TCkl9Xrdp73a8YfbSAnnQTKjLK4qwwlY=;
        b=QRZeZNdRfpKmfqWDuyw3L3bmaQpvQhF/8YQ72ruiTtt6tSttQ1uHyE8Oo2DemJ+oRT
         TfRYRT/V+5f2ukie73d6dx4ezzNM9EoYMj/Q5UapLiUQpK2OTyDrlDT5zWu57oG3jYSr
         cH3xN4ZQSqH2bemeOkUbCbxIKURati1LEujgtABalYr5VY7I974xlWiJ+13ojyohvAH3
         M4rt3CW6mIpWq5eBsOjFYyjQEy1ujv8Won+YgjuTD1O4hjyGgc4kVuTAofeCj6PEr9mJ
         ZXjpMN2yQsOebt3NzjoVHPM4MCJ3nmqIZR5N4tcJfqIRRg2CURHnQiH+ooHvydo1Ovn5
         dy9Q==
X-Gm-Message-State: AOJu0YyR0L1tcdylnhaIbXJPVrE9aHpXJBlGVRdkXxTIOW2zj1IIFUYo
	/9N5LkIAwSrwTDCRTVMtBZg=
X-Google-Smtp-Source: AGHT+IHhiWsmvk8dt5jOgK6dEcjg/B7A85Yb4vK4Rg4/4wRjtDW6C6AggyThrr8x7F4bzVhlh86gJg==
X-Received: by 2002:a17:902:f682:b0:1d3:bb5b:c38 with SMTP id l2-20020a170902f68200b001d3bb5b0c38mr3126088plg.46.1703066627370;
        Wed, 20 Dec 2023 02:03:47 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001d3b7c5776asm5721619plm.160.2023.12.20.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:03:46 -0800 (PST)
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
Subject: [PATCH v6 0/5] Fix I/O priority lost in device-mapper
Date: Wed, 20 Dec 2023 18:03:28 +0800
Message-Id: <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
References: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
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

All changes are based on master branch commit 2cf4f94d8e86 ("Merge tag
'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

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
 block/blk-mq.c                                | 11 -----
 drivers/md/dm-bufio.c                         | 43 +++++++++++--------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 +++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    | 20 ++++++---
 drivers/md/dm-verity-target.c                 | 13 ++++--
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 ++-
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 105 insertions(+), 80 deletions(-)


base-commit: 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
-- 
2.34.1



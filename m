Return-Path: <linux-kernel+bounces-2904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E1816409
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5CD2825CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B92113;
	Mon, 18 Dec 2023 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evvNjqUf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD741FB5;
	Mon, 18 Dec 2023 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d5c4cb8a4cso218208b3a.3;
        Sun, 17 Dec 2023 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702862887; x=1703467687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XbRmEorx477xFodzpUGsRs+Ea5Cx9SIbi/zT57pfLE=;
        b=evvNjqUfCPiotFlPGFTBvKGLF38HC/yo+iafSx91x5DnYYu184h4jLdPk43kNl/T+L
         HZpz/Iz8nAWvAV6VraZ2omley4p3TxuYvJd/9hR6Yi/c+4KB0hj2bag9ZL904NOWNbfK
         1dyXN6U4ppGoSVkqslyf9blpzI3gDchabU3fO61b0nubYIKTqFaJVJL1qb5yKUGSXswh
         3w6hP/C0L22hFbbJRjeaKnioTGEjBC5Es/Emv3Vp+S2AT1XBx+JUc7r/MmZIsIxzoxAw
         PnBN6R5X4nw3VmOhFd3jikNOA4B3HqZ3fgU8yn4DLe2txOf8InS2LW1HIOcrjFWjsyc+
         nzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862887; x=1703467687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XbRmEorx477xFodzpUGsRs+Ea5Cx9SIbi/zT57pfLE=;
        b=Dic8Bi3SRhbZ+JRs8NRfQXH+kMfqPtl/wrQDWIl8QW/17n+DdtJQc5QnByPrTyEAyq
         Ga+iIsRmWvwAR8rbYHpPIBYUjTDpk2MEjUy9P9YslMkDj4QjsOOsgio0Zmf4hFdgMVUk
         CnpV9ioKzOKCYGntVZew9XqpM6ldFxdIW68qap/c6G6sCp0YVlcUreJ8yJEkOj5HMVBF
         fP2z0BflI9AEk42ii2F+DHXfXaGD2aKU2AsG4QeEy9N1gj/yXE68K6+KWYTVk6j2EXpo
         lePlzGtuEHxRfwMd1UMUof/EOJy3veU2zx8jh/RUQaPpoNTBvE/1Ludv6RsksMTx9hCN
         a60w==
X-Gm-Message-State: AOJu0Yy7pcEc56SeVo94DgErWCPuwVV+bo7lOr9B5VBIN1Da7yVTXHBf
	b7+cPFSxO/VQjJ4QOQmP6lY=
X-Google-Smtp-Source: AGHT+IEIj1g+ALu+llTy+0U8YpeRqpaf/PZWMxD1k32jbxyhAB3Ln0clf+wgvOy4GUepvOcneCXDKw==
X-Received: by 2002:a05:6a00:2301:b0:6cb:a60c:14 with SMTP id h1-20020a056a00230100b006cba60c0014mr9340439pfh.18.1702862886625;
        Sun, 17 Dec 2023 17:28:06 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s6-20020a625e06000000b006d64c4cb661sm1414014pfb.200.2023.12.17.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 17:28:06 -0800 (PST)
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
Subject: [PATCH v5 RESEND 0/5] Fix I/O priority lost in device-mapper
Date: Mon, 18 Dec 2023 09:27:41 +0800
Message-Id: <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

A high-priority task obtains data from the dm-verity device using the
RT IO priority, during the verification, the IO reading FEC and hash
by kworker loses the RT priority and is blocked by the low-priority IO.
dm-crypt has the same problem in the process of writing data.

This is because io_context and blkcg are missing.

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. Make the IO priority of the original bio to be passed to dm,
   and the dm target inherits the IO priority as needed.


All changes are based on commit 9bacdd8996c7 ("Merge tag 'for-6.7-rc1-tag'
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
on the master branch.


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
 block/blk-mq.c                                | 11 ------
 drivers/md/dm-bufio.c                         | 39 ++++++++++---------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 ++++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    |  5 ++-
 drivers/md/dm-verity-target.c                 |  8 +++-
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 +--
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 85 insertions(+), 76 deletions(-)

-- 
2.34.1



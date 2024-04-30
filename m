Return-Path: <linux-kernel+bounces-163511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B798B6C55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7FD283E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FA40BE1;
	Tue, 30 Apr 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et9RM925"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A214AB7;
	Tue, 30 Apr 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464007; cv=none; b=PkRh/h5eT9oFE4yZUadUNLhbfVuWKDuhgDH4iQQ4mFzBvmUc0Ud4jwoj4h+Nmx9D1YPge7ZmKJ+2/k5ORWRzxoso/hSF9zo067jFdOqbwe/Kc6D8jlyWWITO3OdL0Wpk/oyz4B3v5aF7WKvS2b1JKZGVuit3yfJbBY1bJfdaYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464007; c=relaxed/simple;
	bh=cbv4NS4KXT7eORtWz16x5PzzhyBf8SDUbInHnzGm9AY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eV2w4mGpDnmbnmU6JyINioAC++bGRbjT3VGo+aiEh2spYXN9rMtV+mKURSUck+mnxBINjLPg4Sm2tScrubBF+HBQG+1UA/V43ZhavvYQev9EEZ0tpF3/pOJi+E0CcCh8AaSPPQScHF1UfJawyImu0ZtT7p0oi4f1Jh/OCs3M3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et9RM925; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ece8991654so4986848b3a.3;
        Tue, 30 Apr 2024 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714464006; x=1715068806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvF3FS0YfGe0QCPcpSCTuhnUbnY/t6nhJEzEAYq2d3k=;
        b=et9RM925O06qhqJK4rBsGhi5SY/ysdVu/UmhSu0IBPtfAAhsXxWK5X9eE0hLD7gNTP
         QNViRX7cBftfLPd2Xcnm0R+RWjB54qvMOVVZPG/6+6ykU6FIcf7tJIJ0iEWHldL/R7G9
         1yeF/7EeDpaHabUSWl7m6bPkM+uLnxb97t2f4qFKS2mWshqJh4fnw5VnZeY5Awn26MHm
         nFsRjGnx+2Fhgtwb4ELIHbkDlFcyhhVjYQlhNvntax5peUt9jUzDps5bfwN80eEzU4Qf
         HWJrF3sVUT5FKjBcarSq++Vk9+MTGOuGl3v3p9CxK7+f42FwIkFZ9Iart6oZE1bAe2hY
         jN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464006; x=1715068806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvF3FS0YfGe0QCPcpSCTuhnUbnY/t6nhJEzEAYq2d3k=;
        b=rOmFBKV3nlF8MFHW2IJV2gwwqs3zzmM/o8pfBHCn+0b0cnM3n11TcNrFQAof/q9UHf
         q7KZjcFkfbn2Q7tsKPQhB1Qz8/ZmGYAoTXJvDP9s/kBxCW+VQ35XMaUiI0fH982dJB40
         W2+7py1vt4ebvqZdu+7en9bSsASUd0vX5gfAPB++9LwnyJC6KxgxM0tzOb4lfazQpMAW
         nMYtIyvZu7NZLeL3+TWofnxC9mKY7eEy1J38Nu8fLqgfFw1YmkQdRjVXcV9XgC23aPAm
         8QsCYjgODYlYn3ztOHgK/G0cZdIM8nwKCMlvW5XdUsyQsED/VhaqSKA8DmVWqzWZa0Cm
         Uy7g==
X-Forwarded-Encrypted: i=1; AJvYcCV74Gm7LzMIOx9PwJhCWPXGF4M7hGyRf1GEB19H3V+Ri+MV9Gd5X6v6nlrWu6HlFh/cJcvpf6tGUMcifw/1bW/vwUC9vV6JA7VwnFqi
X-Gm-Message-State: AOJu0YxlOFYh201DQfop5jr4cGiZx+K31uReqQ82iPOqHJaHdeFN0MkX
	kHdjMKI7yjmVDjQg02LWA54s6WpobkqYiT0tJ7ZuhWmEThEoZiPP
X-Google-Smtp-Source: AGHT+IEzdxa4RZSXofRzB5Re3WDIdU3OsKaRAj+4PDa6K9IGGTyG2qZeHXUfP49cAbA3Dykoae7leg==
X-Received: by 2002:a05:6a20:9147:b0:1aa:2285:2cd0 with SMTP id x7-20020a056a20914700b001aa22852cd0mr19350286pzc.23.1714464005042;
        Tue, 30 Apr 2024 01:00:05 -0700 (PDT)
Received: from carrot.. (i223-218-155-26.s42.a014.ap.plala.or.jp. [223.218.155.26])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm20461760pfo.126.2024.04.30.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:00:03 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH -mm 0/2] nilfs2: reduce build warnings with "make C=1"
Date: Tue, 30 Apr 2024 17:00:17 +0900
Message-Id: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Please add these to the queue for the next merge window.

These two are cleanups that eliminate the warnings output by sparse
(not including common one related to refcount_dec_and_lock).
Neither is a bugfix.

Thanks,
Ryusuke Konishi


Ryusuke Konishi (2):
  nilfs2: use integer type instead of enum req_op for event tracing
    header
  nilfs2: make superblock data array index computation sparse friendly

 fs/nilfs2/mdt.c               |  2 +-
 fs/nilfs2/the_nilfs.c         | 20 ++++++++++++++++++--
 include/trace/events/nilfs2.h |  4 ++--
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.34.1



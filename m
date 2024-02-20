Return-Path: <linux-kernel+bounces-73507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859985C39F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC302B23F81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936B127B5A;
	Tue, 20 Feb 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naKk3zcZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B51272C3;
	Tue, 20 Feb 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453881; cv=none; b=SORlQrpq6r/FxcXRSM1Mh/csU900q2caDBRkma0VNXh4KzWyHkEcF32pSBh3aZSu1YJ7ZtClvzj0GQ6WVRAa5QqAyLCWeEwZfbwXDS7v5BiWFt7HrtX7qxyzLLh7Ptj3ZMSkuUzCq/zMEjtIz6x9Z+1gmce7Z8P5w8FGUOlPaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453881; c=relaxed/simple;
	bh=G8M3esNp4w3cKqktdmkXzcUCOTICX2MvjGQfFXO7bDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioP3NiEx4yyY3h5wKas3iuEKC9Ju645X6ONe08BGVMX1P0dk45isbWKIuOhs++u/LdNG9U8WFO01PXo34TQm/JLkfORffjvriiyD1qhU/4AZORLcYdhkVr6LRBD535PIz94KZY/hMxTBmdzAXDUdXhORNOtHv/CaxWIiFyF2iMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naKk3zcZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so4598695e87.1;
        Tue, 20 Feb 2024 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453878; x=1709058678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1m1CBnTzdSNLBkji0F8nlKue38PNkEwKG+U7wyI74bs=;
        b=naKk3zcZN8HnRfXAThd/AyuK4i6Hwx/KVzVDzCFbsvKWTISW+f1rdNjd8emFCyeUzC
         VJmVpILDBTEB1FkxuWl9ZRXxunRbk5jHTU+jkM/NOG7Cf1pGxaOY6Hr6dBMLzVy8LPY8
         SmKrgA3C1SklUKfA3o3hgVCweSs0apw31ePySOgbhBXfWylWOPAl+81iua3177eLm0mk
         VqOpllOjjay8yNgELim6e1KLteS8pRL0630n4CUivtazmpmztzx4SiW/ShwqfhziMCHe
         BgMZC5kuYRRofZVMKGH1g52aSScSzKGYUBSDpV4FPtefahrith9FZRfJWvamY7ytOI2Z
         /SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453878; x=1709058678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m1CBnTzdSNLBkji0F8nlKue38PNkEwKG+U7wyI74bs=;
        b=B7AwoD5LpodQCjSxuD9IcpY9GTiNbared2WjmHTpbAjDSGHEkUrs/8o26WY4L1ffww
         QMQ0yhZ5IsQpmK6w4J3R9A5Yyzc/PnjCmJRsHcABT2Tzi+ScfR6dEAgH7Fl2ZCjpyfGn
         1JsVf8gjnG/fmnNDZwf1TZ03ZpoiC0aHiRaeztE3ssHB/0htjPXdXgYmkfeP9WfzkuDX
         +GkpsgGqorRhaPlwTJPDDcPUeyUsg2YiUpPE+fWtqwTC1vpdx5YJXRM95T00JJqO7uGA
         kbDi4K3Vho9nrCaIS8ZamTDCmddzMqvslPejYKDv4gakjbzcFH/QppmLlP3Fo/uuXQFK
         HpEg==
X-Forwarded-Encrypted: i=1; AJvYcCXaYJfk/jBxQ2i4rHKaqd1kXTitSBJO8uDgqEneIdEuXN6gGLkWXz1/q7PBO9Wpqx41gr37OZOkwXOlNNlx+8Rx1qiCbJqet2Dlpe4m
X-Gm-Message-State: AOJu0YzFDGRKO6PxVqvqvmK1R+mLF3+dGTnwzk8lv09mcHbH87vDyo5N
	tRwDiHkkENeBKlf5Tl8HwDaEWRy2kONwyXX7VijABUY5cjakjtsm
X-Google-Smtp-Source: AGHT+IE80WTV84xht2QSbCvx9mPk9MWQOHojJwLEQhMY5jSLNdK7zItYVtsizEJe63xpcr6DTzJuUQ==
X-Received: by 2002:a05:6512:138f:b0:512:c3dd:2e9f with SMTP id fc15-20020a056512138f00b00512c3dd2e9fmr2020891lfb.45.1708453877791;
        Tue, 20 Feb 2024 10:31:17 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id b14-20020ac247ee000000b005118add498asm1365937lfp.130.2024.02.20.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:31:17 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v5 0/4] Reduce synchronize_rcu() latency(v5)
Date: Tue, 20 Feb 2024 19:31:11 +0100
Message-Id: <20240220183115.74124-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v5 that tends to improve synchronize_rcu() call in terms of
latency reduction. This has been developed together with Neeraj Upadhyay.
The delta between previous v4 and v5 is rather small. Main difference
are cosmetic changes related to patch squashing and data structures
splitting.

It is based on Paul's dev branch.

v4 -> v5:
 - furthers squashing to reduce number of patches;
 - remove the CONFIG_RCU_SR_NORMAL_DEBUG_GP Kconfig option and
   reuse already existing debug option which is CONFIG_PROVE_RCU;
 - add data structures in a separate patch.

v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/

Uladzislau Rezki (Sony) (4):
  rcu: Add data structures for synchronize_rcu()
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  rcu: Support direct wake-up of synchronize_rcu() users

 .../admin-guide/kernel-parameters.txt         |  14 +
 include/trace/events/rcu.h                    |  27 ++
 kernel/rcu/tree.c                             | 363 +++++++++++++++++-
 kernel/rcu/tree.h                             |  20 +
 kernel/rcu/tree_exp.h                         |   2 +-
 5 files changed, 424 insertions(+), 2 deletions(-)

-- 
2.39.2



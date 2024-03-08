Return-Path: <linux-kernel+bounces-97393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F48769F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC45283BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4463BBDD;
	Fri,  8 Mar 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzrr+Z75"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BF36D;
	Fri,  8 Mar 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919256; cv=none; b=jCqL7uB2iiRR/Yz1+5EMr2JrmE8DRZfUkm68LEuzmhiHlwYRgHHuk/3GSOEEqXuUrCbQFmzaYfaYgTU18NuZ8sYCtAiz5TQhkV3AnTl5JgocXBZr+irbAytZdWIyObmBanL++wiRhkQC6FsdB0rvFGf47753crqGF1dJsohafrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919256; c=relaxed/simple;
	bh=WoFOscuDpyEDpIlN2yM8YrqGAhCm1K6ezIayPoX8JFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCX1c1JXhazCnzGIfIV0/brJs4XqDz7ZZM4ThveHoWUTKNKhYa7BSWVK/AvJrtX+zcc9wOcF5QFIAoa8nWjKXXaSG8HDnA+jOL2hMquFsMq9Exqb4KVKXCzYnZz49r7wXwnCdGKPnOkWlmdRrU8Lg/vW4dDJu7/Wa4q4e4XD8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzrr+Z75; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512ed314881so2269500e87.2;
        Fri, 08 Mar 2024 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919253; x=1710524053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLEgHytLvHaZwqeMHCqC8Ki/7/3bQNN2P4aJjeTSI1o=;
        b=jzrr+Z75Ek4cVAc5DJ8tWgPVxBjVXOGXvDLuuYLza3+bjT0Xg5fkjL48d+sEJfOLtK
         JZzX7m4M86tzSPDMohnK6eTt+NRlyk7I8sBlgBpTNEbDN7ZXKF3nShJL+unvqfu7qTyX
         spNp7bkncq7O6VCML7dbZ+FsIrPB2GpBkcSzpG7F7O5915d9LKxms3JjC1N7PAAvCWRe
         FlXfYxBTKJKCMEMtc685buQ3e9rdGb3IA1JY2rRofcF6DNDTA7JwpbW05y0IysDW0nrL
         04dS48zkb5VpY3YiVY7/ubZZ1ecT642JJ1/kc5LBWVyCDb6svD3UNY5BwUKMOrWVFCfU
         Ky+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919253; x=1710524053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLEgHytLvHaZwqeMHCqC8Ki/7/3bQNN2P4aJjeTSI1o=;
        b=gzdKR7n/5I/GXACNjkh0xs78fgvEwyvUAx1ceIpTcGaDkZwB7jYYfriNRiyZwCu3O1
         HI8K2eKjTqAvtWabOrT8Sq/pN2lKBGKgj5ozqcQPDuZiagQ0yQWw1/kL+6YLZVVR1a7O
         bqVOwdaI9podVd9t4PwNqAS699NuM6oFsI1bFeZGsMv2rWWrxPQ4KzDbOx7FvtWYtdkV
         U6Suhzgq+k6lUZcjh8ojKQRKEpygw7x0JJ7eA72jf36UH2cgnHflgRGRAHgz6QVqrbJm
         4ZjtkceW6R5S1DBdgEfm9Fr6hTF+EJdS+Y7U+SIRRsIUJ6VXho/gt1ozUzP7v9wZgFDC
         WiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56jLlVjyrHMII2OJCN52mf81QuzM+JPQ8fBCpiAEeorQPYLhstpq7lkqS82ZX2N5rZGsLAliIHyCR350XiU2u8tpWPwnbUIekfHOT
X-Gm-Message-State: AOJu0YwCyoy211wfGYo9SoZa1QWbnPXn4HOW03GIh/aI8j8K2LHDKPFy
	7M3h8gkLLA5/BXfoDhmgD/+CfKAoptGZGbukw7+lxXNwZHo/RhMW
X-Google-Smtp-Source: AGHT+IFPsGVncVowsBADHGCgjO7LZWzXLR/FvOHuqAnst2eLGxsY1R3QZw9hsPjsf+LrGQgVet0PRQ==
X-Received: by 2002:a05:6512:ac8:b0:513:8266:f5d7 with SMTP id n8-20020a0565120ac800b005138266f5d7mr4060066lfu.3.1709919252470;
        Fri, 08 Mar 2024 09:34:12 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:12 -0800 (PST)
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
Subject: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
Date: Fri,  8 Mar 2024 18:34:03 +0100
Message-Id: <20240308173409.335345-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v6. It is based on the Paul's "dev" branch:

HEAD: f1bfe538c7970283040a7188a291aca9f18f0c42

please note, that patches should be applied from scratch,
i.e. the v5 has to be dropped from the "dev".

v5 -> v6:
 - Fix a race due to realising a wait-head from the gp-kthread;
 - Use our own private workqueue with WQ_MEM_RECLAIM to have
   at least one execution context.

v5: https://lore.kernel.org/lkml/20240220183115.74124-1-urezki@gmail.com/
v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/


Uladzislau Rezki (Sony) (6):
  rcu: Add data structures for synchronize_rcu()
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  rcu: Support direct wake-up of synchronize_rcu() users
  rcu: Do not release a wait-head from a GP kthread
  rcu: Allocate WQ with WQ_MEM_RECLAIM bit set

 .../admin-guide/kernel-parameters.txt         |  14 +
 include/trace/events/rcu.h                    |  27 ++
 kernel/rcu/tree.c                             | 361 +++++++++++++++++-
 kernel/rcu/tree.h                             |  20 +
 kernel/rcu/tree_exp.h                         |   2 +-
 5 files changed, 422 insertions(+), 2 deletions(-)

-- 
2.39.2



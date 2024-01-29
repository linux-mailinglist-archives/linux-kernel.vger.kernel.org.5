Return-Path: <linux-kernel+bounces-43596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280DE841615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BF8B20DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B851C3B;
	Mon, 29 Jan 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+lnl2CG"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5C51C28;
	Mon, 29 Jan 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569138; cv=none; b=mh0khap3eX6NDoouZnrwNuobCXtsuO/ydQbr0KKJaBBPMfraRElfk9z4KkdjE/0q6f5zwlRpwZyOEXqhs/mERb+JslTLvzfBffyibpAJW/r0ZFd1FJ8uMZkSbpC6IhJmYuvveA1iN1fWNDLIIHKovz3ISgZ5tFoLQ4Zx8ckPCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569138; c=relaxed/simple;
	bh=qS23eDY70akmM70VDnGqTtUWdP2J5XcCRDZiyee/T2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bow+A2lP7iB24kpy05F6zadRuR7rKZPvuV1jU7ct1DoGo+gOIMwYiZQlYB/gJVMXysa4/3YrwEKSCfJfHVJ1Q54pKBYXOFHFWrJNv0laRCUrhdvw1tifqdZNPU2SGP2RlTQEZqZqAueB2YJjiGWR2/uSR24Kw3QK40cV4dkXoic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+lnl2CG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78407987510so31036285a.3;
        Mon, 29 Jan 2024 14:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706569135; x=1707173935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wthQQJasdY/xtJzaegSNHR3FbQOt8xCueJTLlZMyKNw=;
        b=I+lnl2CGgqA+UmaygcbDBLJfZPTRK1umDUZe4p3Zx70jS5+3ato8l0Q+0FIM9TWjmb
         VX8ZA+aMbP/tMZ6qLwV9QbK/S6xVaRxwYrgISqWm4FtXLSk4+v7tgcMFRcT79EnPwmZr
         zXGlC5CdTeik9ovx+drat5ZElu4HgDYSFfK8NIfPJ4DkBxOpgYGD86e/dtt6ZOLS662h
         FPe+DjPN5fNggCxYVLFuvvYEXrzBP8u0XPtEAi2YxAl1Wz2w9t8QiaCoOIJEH8MP3/n4
         h5llh1lkBs7EgYVSGVhxj8nOBTE1qnAhRSNmyqFJz13OidDFD/Kh5QJTKbKXZbT/d5LW
         eRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569135; x=1707173935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wthQQJasdY/xtJzaegSNHR3FbQOt8xCueJTLlZMyKNw=;
        b=qCETpls+9/7kiHSs33fuAtweCSaePNRDmbU0h+N8ZYmEdOFQpgr6IJ+VmjdhHRWYpj
         hfdl71tGc4DAtZusRYQ3pjJy3EchXsTWn0bc+rQjSflD7Yq6xXa+jY7LK/JOXdrVkx5N
         hhe+jDC9mNS6KbAQgoDdf3Ks6bwnZZLvEzV+XtupcHYdc0xvSozTNDcPPxPw/gx36UXX
         bauRjmUNBq9o4BnamsC4nO2GQzJr48abhB3VK3/b1bjot6WDOvvYp50P+QPd0Vw1Je61
         A9rOEXOs08vNLE7M0dHLVK59uP+eeP4tkYJhaw3gYbvecqadRF2pPGbzvqkNnOwAbOWD
         ruCw==
X-Gm-Message-State: AOJu0Ywjc9lJUbrQ6J3i+hrOLgowu7xYWVxeIrBU0nIoJJbNJbtTPBcV
	1ML4qEFtWsCmPqLOFvO716faaKTAxeGxDR250o6giGp5l43JuJTl
X-Google-Smtp-Source: AGHT+IG/SLTAX9urGP6GW8SUccff/hKTG4d7myXMaI9D2kvz5V7qmCmxkEjzsiergEXe7IxH4U8Whw==
X-Received: by 2002:a05:620a:222b:b0:783:95fa:727c with SMTP id n11-20020a05620a222b00b0078395fa727cmr5924666qkh.3.1706569135722;
        Mon, 29 Jan 2024 14:58:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWNG21MZ3XQk98KV1GwTNT3chbb4Hvrm/9yMoGfU+u5MXPbLFRdPTStsdY+fmzsinecocRpGGC3IvcV5I6+wQ9E6Xho3HcQyyOEpbAeQDfO4HsBH/xkgYw1JSqujbzM
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a409200b00783f449f587sm2093117qko.80.2024.01.29.14.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:58:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id E9DBB27C0068;
	Mon, 29 Jan 2024 17:58:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 17:58:54 -0500
X-ME-Sender: <xms:ri24ZV73zC8EOVx3sxuwJTfqjYdwO3f6O4kaExONiT-Wme1MO66n5g>
    <xme:ri24ZS7jIVeQw4eqKMC1BUnkdGhBqmAzIQXjm0epLKzRp6FLIFwrKSV9rbj8r09nx
    hX82h34FNZ4SJw2VA>
X-ME-Received: <xmr:ri24ZcdmUdUkR6tIx-6epccSc80mLycR_Dn_PB5cTRyuAhhefSIdskw6LmfejQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfftddtkeelvdefleeghfelleevge
    ffteehheeljeejudehueejhefggeevfeetnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:ri24ZeL4Voy1mtrAorsCDl6VhWJA25xe2T2iixCDP8n3xJ5spi04IA>
    <xmx:ri24ZZLIPo3Ha_G3nOXoUrSXeyq4WOWORt3dlzxyGl5kT9D19JbOzQ>
    <xmx:ri24ZXwubY-wofDqXIoyRuuTPPD2CJ0CxAYEd8Se0LdGcTdFf40lDA>
    <xmx:ri24ZZ1nhu4V_ve2s-hO1Gcsh9vrX5qFa8clKhGELcM-JIetpjyp1g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 17:58:54 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/2] RCU tasks fixes for v6.9
Date: Mon, 29 Jan 2024 14:57:25 -0800
Message-ID: <20240129225730.3168681-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains the fixes of RCU tasks for v6.9. You can also find
the series at:

	https://github.com/fbq/linux.git rcu-tasks.2024.01.24a

Th detailed list of the changes:

Paul E. McKenney (2):
  rcu-tasks: Repair RCU Tasks Trace quiescence check
  rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks

 include/linux/rcupdate.h |  4 +-
 include/linux/sched.h    |  2 +
 init/init_task.c         |  1 +
 kernel/fork.c            |  1 +
 kernel/rcu/tasks.h       | 89 ++++++++++++++++++++++++++++------------
 5 files changed, 69 insertions(+), 28 deletions(-)

-- 
2.43.0



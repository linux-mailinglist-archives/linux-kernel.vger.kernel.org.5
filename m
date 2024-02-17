Return-Path: <linux-kernel+bounces-69641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0E858CBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27011F232F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E331B7EA;
	Sat, 17 Feb 2024 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPA8WyuQ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB621171A4;
	Sat, 17 Feb 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133282; cv=none; b=fSimHPEmynRtVzOQPBpCNKixMqp2FCILicMt37EgO9cObvP/voDw7SJ4vUyytXI4ltxMhXcpf6K8zHh2Dxmm6bmIp29Y/H9oXBQnrzZmHyQVmBO2OGBT/y2qhgLouYp9YYp1RjwUCkXE6euknyRsOvnKS8nKg3vz/hxrwiIR9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133282; c=relaxed/simple;
	bh=ee0+gDUZjljn1JGls3JEeGbj0kI8DwHRyYLu9P9SdDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTk6LBid53rYx2xSaUny0KZ7YlaKPEHa2LtDethQyWfYgc47UCECaqmf6z5LH0s7eUPV8VI/FlBa5CDCvkRUXwEvHDVQiOmY3wqayqe9U0n3XLTOprC20ZDELOz/cpcVvygj4lTYK0ZD5VLc6/289bIqu6+W+M6VRrnQPYiQVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPA8WyuQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a35c720b8so10320061cf.3;
        Fri, 16 Feb 2024 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133280; x=1708738080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RiEUogJffZFEalDXnRQaeim1wj3yBupsNhm8md1h220=;
        b=kPA8WyuQ1N2pX43HtUGduBuE0SxOvSf94zOB7r71I5tbzPIwFnNUnrcJy8kfLAR5dL
         oTF91dUU6QWf3CvdXRv/BiuoGi4XuweHAo+vYbJhcgjJNraK1Hxl6Cj+Hq8BHSVhl9CI
         i3pTT/Nj8qHvQFsRgxbbQ9Cblh+tsquFih846J9csoJ6k6+wsiduBuCmujDxBXy9TukB
         RY/H2hfdGcr8HZUfj8zvtE4SEmGc1CHHkvRop92i1mKGJTGLmxoByBlOrInVD4HR30eB
         tExkF30WlEQ3qhR/thH4w4goFK/i4qgza6LYr3ZIwMf8nK/pN1RqHLpmduILfr1dHxw1
         rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133280; x=1708738080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiEUogJffZFEalDXnRQaeim1wj3yBupsNhm8md1h220=;
        b=us6jFvxrV7wKgBXArYin7ArmL4M7g+mjIL07hmteDXxjRQ/dHJ12LCWWCuwNEh8Xgc
         J+hnlKbtSpJz1+uoaFVvY1qvrGPDmd84JnXR7YKe2aopaY5086TqkbHdvjaogIcUldGt
         Ws3N9KQw+C42lpqrq3TWFXy5/flNfWOvZtsaTiTKP7BD+R89YtoQZ72eHujKUni3lqHs
         I9z2hLnaPHg0Tyr8ZwaASQ3Kriw8mmpPWr/u7hxYrlNRoVSuOWjTSugYylWjcVn5j1JC
         eBTjo5CDH6/Oarh109tRYgqTUWihDSrm6f8JF4Ld/pWqTEqMQLA/h5yJPqXIE/xAKmJw
         8oFg==
X-Forwarded-Encrypted: i=1; AJvYcCVCUfzieKqxd/aK7DgNvNv3kuEZyn9RUfUY6YHv5C4494KSIEpsu2yS8rp9mdIQoG2ZWXrEdhbgeZKz/gRl/Nfnrn+O
X-Gm-Message-State: AOJu0YyYEnZ+Ceq90BinOjjtQsy0QHDUCgsOfHIx6CyzLHjUBv8QBW31
	PoOzK+x0C1qlH9hP2ZZA28xFb6T6TeCD90UX5DLAihAlhdXybZI2
X-Google-Smtp-Source: AGHT+IFI2PqcGXv8TjaF36JAd9uK89q/BdSe7DcMznHHQ84jSNJOEvR7hQhdTGx3m/bkIDCuhza1Ow==
X-Received: by 2002:ad4:5fc6:0:b0:68e:ed2f:318d with SMTP id jq6-20020ad45fc6000000b0068eed2f318dmr8353272qvb.65.1708133279767;
        Fri, 16 Feb 2024 17:27:59 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id lu8-20020a0562145a0800b0068f1435192esm478911qvb.122.2024.02.16.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:27:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 739721200043;
	Fri, 16 Feb 2024 20:27:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Feb 2024 20:27:54 -0500
X-ME-Sender: <xms:mgvQZe5oaXurbAx8Hs221Qbiq93cr_tv9tuTHmZuLGhODTJkm-C61Q>
    <xme:mgvQZX6dhadsihXwUT-UiI0ZDFt-Kicornrpi2rPFg5LlotqApQkVgB1n4jw5OIib
    ULwmo0TYpBgZGp9Ww>
X-ME-Received: <xmr:mgvQZdea68qrGKtFQWXiD3BWKPGvfco10yznGVBg_gfx9_NC66cZyx2L6RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mgvQZbKDhYjNEzwmi6wUIDzYf0yt4i6UHaAJOiNJFYPnud1ZACaxDw>
    <xmx:mgvQZSLDhhVM2JwkqlKUIGQxPTT5zSvUlGLR9WXocV9fOMKvMQu0wA>
    <xmx:mgvQZcw98B0Vksnz11MbLtqXsaS-A2FaKmE_ctlDlwRqEqzzlMbRGQ>
    <xmx:mgvQZe0Qfppo7GpylnOUjM3ezaNoOsBH3t1drAy8A3LdoPiJSq2C72Aa11c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:27:53 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 0/6] RCU tasks fixes for v6.9
Date: Fri, 16 Feb 2024 17:27:35 -0800
Message-ID: <20240217012745.3446231-1-boqun.feng@gmail.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-tasks.2024.02.14a

Changes since v1:

*	Update with Paul's rework on "Eliminate deadlocks involving
	do_exit() and RCU task"

The detailed list of changes:

Paul E. McKenney (6):
  rcu-tasks: Repair RCU Tasks Trace quiescence check
  rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
  rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
  rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
  rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
  rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

 include/linux/rcupdate.h |   4 +-
 include/linux/sched.h    |   2 +
 init/init_task.c         |   1 +
 kernel/fork.c            |   1 +
 kernel/rcu/tasks.h       | 110 ++++++++++++++++++++++++++++++---------
 5 files changed, 90 insertions(+), 28 deletions(-)

-- 
2.43.0



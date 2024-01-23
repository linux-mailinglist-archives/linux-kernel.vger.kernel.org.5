Return-Path: <linux-kernel+bounces-35562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6F83934B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A1AB292D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21462657A1;
	Tue, 23 Jan 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Rc5liliN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yMl9ymMe"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB562604C6;
	Tue, 23 Jan 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024113; cv=none; b=AxQWyZKIalaFYc3qupQ2RBT4/ys1lvrNJhM0jzG98JgH7KpY3ge7rLzqW7rUoRlogtH6te7F4LJkN4Bp5uJacZ+awnQj5P70y23wzCfOGu/sgv5cv9Cbz3oflxGhGScWS95wX/tWEyJwg+RWX5OEVokJELkoorsKLXYvSm6Ek9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024113; c=relaxed/simple;
	bh=p7kDtRxNmyebETMhw6b+Mx4k05Ru5n+gRX2phozmjyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZtDRUzuU3LKKh3l8WXzeYlI7kDeoc73G8gaZaQOUdyKy8Ltr2wM/RZgOSWF31zyfrp8WM/eoDjcATZKT6E7HEVD1itP7Yxc66ptqCFMKxl7qB6hggRuOTkZ/NrtFK8+hBchl5awL8oL0jaJeb++euL3/krac1y2jeqfBoL1vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Rc5liliN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yMl9ymMe; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C3A795C0216;
	Tue, 23 Jan 2024 10:35:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Jan 2024 10:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706024110; x=
	1706110510; bh=gJLT8vRm8Hjo8wbk8FioBAMkLCd1UJ0XB+b0Hp92i1E=; b=R
	c5liliN7MdwemxXRAq0BjXl/IcCZaMPQUOHHXZWqmMEGfViRLQ1lwxTvqehRWrcS
	D0hwdi0tEkZv+pdjwvl8tHkgddRBz0Bq73nQ/cwt36qx2XjfkMmlIqDXEnMuWRxc
	m9KEmWF/lGAyIMfJbeEBaE0YB+54IhcVLMSdpTI2XLdN+3P3dEECbdaS3Cwojc/H
	OstS2f371urwJhfwtXYlnjwfQnEyshLH0CNd+rRkYybKHb+mF4YepV/YDd5LhRkq
	1p8VM6iGcRaSv+9Z5kTeftdM2YOlpbagYJwAFegvNBfjjUazwlo6jWaOVSGQx9sn
	87rkq/TUy0+RnVr0T3UmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706024110; x=
	1706110510; bh=gJLT8vRm8Hjo8wbk8FioBAMkLCd1UJ0XB+b0Hp92i1E=; b=y
	Ml9ymMeJbiYAnQ23lM9QD/UKt2mqjtHxSgW/+QFxRIZaAcPbAiKTqTnTbJhY+YM3
	hIg6hjxDYClQFOdauQ+2Qc95bqTI7iZAw29Q9jwtt54cVANjCDyOK2JOIVWN4MMa
	wJqdSB2Q6dB+Hs9r5VF0sC5+6bQTpXvEMZUj79HyAHoAkvpGifov7PQgE99yEURN
	vhwN1IkDHNFeb0a87RdciaifTITHZ4cYpJZdZQ8MrgMY2M7mphj0ICn2fczABEhW
	14k9KvBwnxS/S4bVsq8D2OS38GBXj2RSRoV9YUIEBbJOcn6fQcfCzKJfPWxBUtis
	k0WHKCETus9OG/vgP/uNw==
X-ME-Sender: <xms:rtyvZV9DrHK3dK7WexEzdKv_kace6CVVAN7LassKATINmr56fN6S5A>
    <xme:rtyvZZslal2hT8KOBFH-LvGiKcsJXptAZu_mJ_RjVF-bxEFMox_eCu6RtN_t-zEnU
    ctrm124XW9AY1lvR8U>
X-ME-Received: <xmr:rtyvZTCdPzB_yoFdpDjPrwoLOHweoiLJaqmUu4aZNU_AtguinyiJurMYp5bLgI9bDzcRuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:rtyvZZd5cn8nHPJgrdKARmeqwAS77NQWE1tNrgmhYzlXi2E-97LhXw>
    <xmx:rtyvZaMzc2IP6fYyihvmJIZk1cBjTOdBfgQ7rxUkBkxGm9OYY5byLg>
    <xmx:rtyvZbkKnOC1_l_A6TdFWrAsbF2nl_SpgW0RqYFUJFBBAwsw5fZ7zw>
    <xmx:rtyvZR1nUwLjjW8ccXLWcLXSW7H6O23hkaSLhzgP-6C1nS0iR3ue2Q>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:35:09 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v3 3/3] clone: allow CLONE_THREAD | CLONE_PIDFD together
Date: Tue, 23 Jan 2024 08:34:52 -0700
Message-Id: <20240123153452.170866-4-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153452.170866-1-tycho@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

This removes the restriction of CLONE_THREAD | CLONE_PIDFD being specified
together. Assuming the previous patch sorts out all the thorny issues this
should be safe. I've left it as a separate patch since it is not strictly
necessary as a usecase for us, but might be nice? Perhaps we want to wait
until someone actually needs it though.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 kernel/fork.c                                   |  3 +--
 .../selftests/pidfd/pidfd_non_tgl_test.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 44969cd472f0..25fccf7c08a7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2296,9 +2296,8 @@ __latent_entropy struct task_struct *copy_process(
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
 		 *   reuse it later for CLONE_PIDFD.
-		 * - CLONE_THREAD is blocked until someone really needs it.
 		 */
-		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
+		if (clone_flags & CLONE_DETACHED)
 			return ERR_PTR(-EINVAL);
 	}
 
diff --git a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
index c0624b127fab..a34208c2307e 100644
--- a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
@@ -546,6 +546,22 @@ static int test_non_tgl_waitid_exec(void)
 	return ret;
 }
 
+static int test_clone_thread_pidfd(void)
+{
+	pid_t pid;
+	int flags = CLONE_THREAD | CLONE_VM | CLONE_SIGHAND | CLONE_PIDFD;
+	int pidfd;
+
+	pid = clone(thread_sleep, stack + STACK_SIZE, flags, NULL, &pidfd);
+	if (pid < 0) {
+		perror("clone");
+		return KSFT_FAIL;
+	}
+
+	close(pidfd);
+	return KSFT_PASS;
+}
+
 #define T(x) { x, #x }
 struct pidfd_non_tgl_test {
 	int (*fn)();
@@ -557,6 +573,7 @@ struct pidfd_non_tgl_test {
 	T(test_non_tgl_exit_poll),
 	T(test_non_tgl_waitid_exit),
 	T(test_non_tgl_waitid_exec),
+	T(test_clone_thread_pidfd),
 };
 #undef T
 
-- 
2.34.1



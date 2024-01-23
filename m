Return-Path: <linux-kernel+bounces-35559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23D839345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9C91F2209D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76E6027C;
	Tue, 23 Jan 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="fBlX29H2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgEPaiM3"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C75FDCC;
	Tue, 23 Jan 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024108; cv=none; b=lzNJEjhIdt7LfB5+1RhIypctyCMEfGCGMOUZ1vjkj7IJHgdt8CtMcHuqCWs2uzvxydnSj2WgSLDCVc6Ay+Y2tkWPz/lZLjlIZV2k51Z6zN/x16mEjnrOSlUj/INqMxKKQjOoy8TglMATgIkcjrO3YHxVQLHtfmRquLlMuqY9LWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024108; c=relaxed/simple;
	bh=XcJc/yvMCH0RbyeBdmRrU6syGsXpx3+8eaxSeIwzZ+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=flIB3cmH5zNla5LNw09b8aSXdW7MDxX2p+ocQMHHAmk1NzSQGLmFGW4p0NWFKYWjDUnDEw1XCUMYQhCm4DGx2DfpfFmxUv4M/XNn66EO3ztOMWb2Q5LZFOeyQ27o2YRa+axGJ3yOyrCLYmNjh8b7qW7CpOaQ+79DvNs/vg/sFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=fBlX29H2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgEPaiM3; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CD27B5C01C5;
	Tue, 23 Jan 2024 10:35:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 10:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1706024104; x=1706110504; bh=cpXoKTh0mBiWlf0Tpz7Tl
	cUg3DJUYpaHX2Su09+jA0s=; b=fBlX29H2GKnOsOdTnWheKvb5z7HjLMeIi1o6h
	y5T5Odtf6rADsoffBEXIEHKzCAGqDJ3kjkXC9DlRg0CMOKcimfCWAigJO6eOLNpL
	m0o1SnrSHqqcD4HyiSquik2WtrVZDOY6PrCGXE0RvfxDirdm4FbuSkg8dxHjyHIH
	GE0Gzm3ARElfQuNna13DK40ThMSrxmDfuilQV4Y52+IK5d2dvJyv7CjCdRT3jL+b
	9mdMbw1yqwMFyDgEhDMRxc2qo5uoUXw1DaRLCT/LCS/bIPYkEB1Rb3FJzLKB1IN+
	C8TGlyNSp42TdPMuTjKJqSYw75kWlzuSyDO4EDopzn6WfIkfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706024104; x=1706110504; bh=cpXoKTh0mBiWlf0Tpz7TlcUg3DJU
	YpaHX2Su09+jA0s=; b=dgEPaiM3Y4oX1IDgLIegPeyh4zh6oMZ2vJHohdGCS92g
	FBzKO5BfQh4LadliUm4805B68V1+bkLooin4lKGpcOuRilaCWBF2yaKDCPwjm3p/
	VMGWwuF4DbhNjAV3fTbS0m51b6D9Qqb/og9eAkQdHtnwnNUdLDeiHVbT+l4qEmWe
	e/KKgmAQniU9AKD1C/QMFZPv1CCxIC0mvfAAUsqydkuwMr0JWrgS5Z6IWJ2drvtA
	1CjSF+txfzpjOVDddiMNO3ZucKIHJddnKMJnhh9hIeGC6Yl0Cr8lPu3Xh5L/VGOv
	SLhCRKO9ZB5+we4sQSKVA4I+8AhEDqYTfCb8I8D9jA==
X-ME-Sender: <xms:qNyvZad-mdVR3C25zUPtYXnATsRYsJiCFSFzY4jyBWvZo-Wuq-d7xA>
    <xme:qNyvZUMTD7Zrs1cQFdqu2CWwHjCoeYnRSxRKO5l_DYVcmYuBDVz3j9N9o0MlsYl1a
    CPwItqJ1pgfNdgLFPs>
X-ME-Received: <xmr:qNyvZbi93eKSQniq2kPm4JMcMLAuu1-OGuJHPlaYdirnqtwq0swEREX3osSLNf0ibic9PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepheeffeehleeftdfgjeegheelieefvdfghfeuudeuheehuefhhffhtefhiedv
    geegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
    ihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:qNyvZX-DYIs2e7X-Z5zhwtLRDOAU5ptt4g25_0-h6WxHHnWHdVghBw>
    <xmx:qNyvZWvbk6USd5KEB8NVKqTLvW2K1-mMcuglJRrzaI_NvlDg_tUyvg>
    <xmx:qNyvZeEqoei83qLCLw-l9sFUelWMBiLqbvn3zejMd27-Mlw5pLeZRw>
    <xmx:qNyvZYI_2S7v59IVBvJ37iqkqXbKmCOFSMV7zLhHFWcSfpZYa-wAGw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:35:03 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v3 0/3] pidfds for non thread group leaders
Date: Tue, 23 Jan 2024 08:34:49 -0700
Message-Id: <20240123153452.170866-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

Hi all,

Finally picking this back up. I looked for a location where we could put
the do_notify_pidfd() call so that we'd only need one for an
embarassingly long time, but couldn't find anything that worked. So, we
have a new call in a similar location in v1, just using the actual
helper. Perhaps this makes sense, since we're adding a new feature.

Hopefully all the tests even pass this time! I looked for a bit but
couldn't figure out why they don't exit(0) when something failed. I'll
keep looking at that.

Thoughts welcome,

Tycho

Tycho Andersen (3):
  pidfd: allow pidfd_open() on non-thread-group leaders
  selftests/pidfd: add non-thread-group leader tests
  clone: allow CLONE_THREAD | CLONE_PIDFD together

 include/linux/sched/signal.h                  |   1 +
 kernel/exit.c                                 |  11 +
 kernel/fork.c                                 |   7 +-
 kernel/pid.c                                  |  11 +-
 kernel/signal.c                               |   2 +-
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 .../selftests/pidfd/pidfd_non_tgl_test.c      | 600 ++++++++++++++++++
 8 files changed, 619 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_non_tgl_test.c


base-commit: 610347effc2ecb5ededf5037e82240b151f883ab
-- 
2.34.1



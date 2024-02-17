Return-Path: <linux-kernel+bounces-69862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDA858F97
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B539DB20A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804717A733;
	Sat, 17 Feb 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXv7XBkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BB69DE7
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175355; cv=none; b=FNo/AobyOswhCeZTo8vvo2h6xtf7pu5C9YKIwfjTuWSkd94xha3rKgpbjAQtUz/YuAKvMzHGfpFJ/ziFI9btrEvFRoxUPGhrJpVcAkM4YU6/s37h8u770s7D1AfAHtqtTFJmXq1prOUjQT93iPqvhDom8mNWPyfcLqMN14qwZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175355; c=relaxed/simple;
	bh=chd1s0x8FHVjXs8tFypVu+I55ajfqUpr9kRz2ytdnWQ=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=gJmmhlFN9D87sA9WL5HXrE+Fyn6lPqr4H2JG78HOYMYsLwgBxgnSflH19s57+KNcNnAPORXgnvsUqTfqp0Pb9DqqHtmuMCsmI+82gndO6Og3FzvDaX6d39LQrCw9Af0N+HIUE8HvyDtCDrv3xVs/Q2LJiIbXrmqVvCSOabr463Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXv7XBkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF606C433C7;
	Sat, 17 Feb 2024 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708175355;
	bh=chd1s0x8FHVjXs8tFypVu+I55ajfqUpr9kRz2ytdnWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=iXv7XBkSMuS77qJ6eij4+W2X+psMg9J+sHwdw5MFcU9h5D3KKsdLg2rxhTDx0ZbKB
	 3YSVc1h7ZpB0PU6FGbd1Q6KP0ZrrMMaUi9D4B9wXf4YL1KNFejN1xtH4IyIfyVz4MA
	 gkyk9YCa34MCivH5xq8F3KrUaMrbOd4V3emrJIxjYPehvWndEeV5HzHC6voK1VNOwG
	 BezHL0K+EYWlpMMCCchb4MDzFTzjhA1GDE3QS5n5mdkc+bezHVVzHB4oIXuQ/0mJiY
	 e8mC9zl3tabnEzsopgaXs2HulXZtTzPAbi6NYEa1BENM1i+3kUjX2DHRAOrBpK9HuV
	 TpsoTac6b1J0A==
Date: Sat, 17 Feb 2024 22:09:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.8-rc4
Message-Id: <20240217220911.b6be7031dcb84aeb99a131b0@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.8-rc4:

  - tracing/probes: Fix BTF structure member finder to find the members
    which are placed after any anonymous union member correctly.


Please pull the latest probes-fixes-v6.8-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.8-rc4

Tag SHA1: b3dfe85ccea60e12ad1c78fc06a15c6475de12c8
Head SHA1: 9704669c386f9bbfef2e002e7e690c56b7dcf5de


Masami Hiramatsu (Google) (1):
      tracing/probes: Fix to search structure fields correctly

----
 kernel/trace/trace_btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


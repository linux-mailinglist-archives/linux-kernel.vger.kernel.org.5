Return-Path: <linux-kernel+bounces-54119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE084AB0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A342B21BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087B818;
	Tue,  6 Feb 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DeicHDOc"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6838D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178546; cv=none; b=AgAFHcbELx0ixRl3vreoqAnj5wlSQ96YAlQcYNwOuOvpxGDww9XmMPVRo1/TLKBz7L2fP85yIqyU79xJXvaKWMZp2PC9ngqhkQ4cll/kPJC/ANY5sx3Q4+YZ6x91GODwvIkqsU784Pw+vd3WkHkbGAfFGB0NtjvY8QI58+2gP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178546; c=relaxed/simple;
	bh=9NypLZM2tEXd+GyB6FpQmrft/6iRx1o5Z33y+VeHbpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=brpRhcz4XwCroEnTkw16+jOkgE7LoWLaWZrbGxXvf7ZAb0oNj9LEAjwm/E2TwEQheY1B62jzwb4hPUL47OLINNsJdFM0hwE8luYS7yGuCbFPG9BWo4PG90lgiUF/mEioIRCe/t9c4Fdiw9x2PCStKi2AdJPaIM1PNioU5J7LNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DeicHDOc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 19:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707178540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=heVNvJcnn6416qhrWoUDj7AImSBv0rywq2SJ2v2xunk=;
	b=DeicHDOcckGsOp/J4wGcUd6QLXQbkhuFW+8ms0A5sP4k9wD2JOJ/mX/VnA8Thw1QrKHjKu
	0D0gpg+YLG3CINRgf0oS8Jg6Y+1UL44u6763x2XVn8dN4i3eyTU5s5D5AfzV+UAMZ/in92
	pfrMmKjANw4yUZRtK0IOkgRGtZGf/Yg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.8-rc4
Message-ID: <v6czqjwdsso2hy6be7qeu4mqxsx4oydq6shavws4k7sexshcrp@np4inrse4e4p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit d2fda304bb739b97c1a3e46e39700eb49f07a62c:

  bcachefs: __lookup_dirent() works in snapshot, not subvol (2024-01-25 20:02:11 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-02-05

for you to fetch changes up to 7b508b323b2ec45be59769bd4e4aeba729c52cf6:

  bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-05 01:16:31 -0500)

----------------------------------------------------------------
bcachefs fixes for v6.8-rc4

Two serious ones here that we'll want to backport to stable: a fix for a
race in the thread_with_file code, and another locking fixup in the
subvolume deletion path.

----------------------------------------------------------------
Guoyu Ou (1):
      bcachefs: unlock parent dir if entry is not found in subvolume deletion

Helge Deller (1):
      bcachefs: Fix build on parisc by avoiding __multi3()

Kent Overstreet (1):
      bcachefs: time_stats: Check for last_event == 0 when updating freq stats

Mathias Krause (1):
      bcachefs: install fd later to avoid race with close

 fs/bcachefs/fs-ioctl.c          | 4 ++--
 fs/bcachefs/mean_and_variance.h | 2 +-
 fs/bcachefs/thread_with_file.c  | 2 +-
 fs/bcachefs/util.c              | 5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)


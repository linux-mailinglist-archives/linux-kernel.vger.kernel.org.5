Return-Path: <linux-kernel+bounces-78932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE03861AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A932B20EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDDF13F007;
	Fri, 23 Feb 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StgKFPL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878F13EFFC;
	Fri, 23 Feb 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710900; cv=none; b=EvJytIiz1XK4ndtZLi75r55Ngw7Ig4RIh4K8bSD0u/m7r/aYTQDcMcbtQ8qVGqzCYpaDUe6fIaHFRJTN7R/8+K9hcepEC3xoYNfmz7Dz1RLdfRFaa5ZG4CW92MZnA7plTqgbc1DtoYdCTBVL2Za45h6z42CJMyeNm7QMCe7js10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710900; c=relaxed/simple;
	bh=kBMP3DNZGgm9mZ4gC+151NbDQDns4LJpJpDMR5SkalA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R2+E1wNDcT+3MyPFIYoCmGx0/NMKbstht1vME/3CXoAHznZp9B8wabKFHTsKg9Nj/yQJmfk/6Jh0vey5O9mFnlmSfqKVywoVs2KiumtNInhPs4RhplylxTPzLztqYekwOST8v8P8M/r+LM3iUp9uGMy4482LhLUsA1qXBg8bhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StgKFPL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DACC433F1;
	Fri, 23 Feb 2024 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710900;
	bh=kBMP3DNZGgm9mZ4gC+151NbDQDns4LJpJpDMR5SkalA=;
	h=Date:From:To:Subject:From;
	b=StgKFPL4MZ8xYqpuD+Sz2AECuqLjgmAMlwQd8ZkzWBg4FnmilOyMUIAVRTDPK9zCU
	 hNk8AQ115qExdrEtfMuPGYXmwjX8GXBWT6VGtyR4CCRqoGyOyA0uUf9vCQDzFvnNqJ
	 YPL4ScZpWi+/GFsX6dhyltBwrP5lxJ9+gEuNgd169z+wNZrEC6U0ExjcGjh9q/wcBF
	 lyZ6vQURve27HaXOpT5AZBRoTAKWS3mKZFuublpJc2bMw//5lcisdxQjCXk48ROB8t
	 MnmABGL0ptErPO7XLpfzPmogKGZ+evIb8Yo+hL4+bt7f7uYFfvMWQRBUH00vhJgENi
	 mC7W71ap/suDw==
Date: Fri, 23 Feb 2024 18:54:56 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.8-rc6
Message-ID: <Zdjb8E0XItxNJyVB@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull four small fixes for the parisc architecture for 6.8-rc6:

Fixes CPU hotplug, the parisc stack unwinder and two possible build errors
in kprobes and ftrace area.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc6

for you to fetch changes up to 882a2a724ee964c1ebe7268a91d5c8c8ddc796bf:

  parisc: Fix stack unwinder (2024-02-19 21:55:22 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.8-rc6:

- Fix CPU hotplug
- Fix unaligned accesses and faults in stack unwinder
- Fix potential build errors by always including asm-generic/kprobes.h
- Fix build bug by add missing CONFIG_DYNAMIC_FTRACE check

----------------------------------------------------------------
Guenter Roeck (1):
      parisc: Fix stack unwinder

Helge Deller (1):
      Revert "parisc: Only list existing CPUs in cpu_possible_mask"

Max Kellermann (2):
      parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
      parisc/kprobes: always include asm-generic/kprobes.h

 arch/parisc/include/asm/kprobes.h |  3 ++-
 arch/parisc/kernel/ftrace.c       |  2 +-
 arch/parisc/kernel/processor.c    |  8 --------
 arch/parisc/kernel/unwind.c       | 14 ++++++--------
 4 files changed, 9 insertions(+), 18 deletions(-)


Return-Path: <linux-kernel+bounces-152482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFECD8ABF17
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAE281031
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168C111A2;
	Sun, 21 Apr 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQal100J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C6DDDA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699433; cv=none; b=e4blIBulM2CSfymGWoy2pRqnjdQUNfDI+KHngPM/zsnABv5VciEAIx3xcVjwX8JsCyKg+2U7P3G7AYH/KWX2JY20mrSsniFTx3i0f8YYtlIR9IvdqpYm4opZuK5bRTXGFQzuS6OP4ZLptDi0Kk6QNgDpPdZ/g0lGpRC1j4gT1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699433; c=relaxed/simple;
	bh=oAiKP9tHaeGg6RJRZTOiQmhWjZHuzgGHctxB3Dc2V6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TmTsCFIb+K7ySewBsJUM0ZtxkV9EfnQRsbMa+D6RZ1BxLN8dRI02alc5hEMq95xJNVpMixaYXDL7D+cLKDE7ghr2Wql0cDijsVolCj+7qrlv7Gl6Q0WYpmjmJc10id2uzU2TbyZTsJHW6bHo/8N7N7I2ooLPVuLR4d2TOP177qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQal100J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C01C113CE;
	Sun, 21 Apr 2024 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713699433;
	bh=oAiKP9tHaeGg6RJRZTOiQmhWjZHuzgGHctxB3Dc2V6U=;
	h=Date:From:To:Cc:Subject:From;
	b=VQal100Jz6JSxwAFL6VEQSrkDvy8Ce2GbAEWzRgg/KIrhiSU3H2qp+HQ5YQhBXzrH
	 3l5YuO9DIOocxjIkKgigidWE5gnc04tyYqq6HQJKhYPUN9BHsBmSX6EcfG47bQOt49
	 Yyv+HlH5r6Z/aHHlaqPZYrm/5m3juL/73Sp0+rE0=
Date: Sun, 21 Apr 2024 13:37:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.9-rc5
Message-ID: <ZiT6ZlO9fECvbipo@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc5

for you to fetch changes up to 156539fd65019e8ed6b9fbac0583cf519cdbb227:

  Documentation: embargoed-hardware-issues.rst: Add myself for Power (2024-04-11 15:21:18 +0200)

----------------------------------------------------------------
Kernfs bugfix and documentation update for 6.9-rc5

Here are 2 changes for 6.9-rc5 that deal with "driver core" stuff, that
do the following:
  - sysfs reference leak fix
  - embargoed-hardware-issues.rst update for Power

Both of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Michael Ellerman (1):
      Documentation: embargoed-hardware-issues.rst: Add myself for Power

 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 fs/sysfs/file.c                                     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


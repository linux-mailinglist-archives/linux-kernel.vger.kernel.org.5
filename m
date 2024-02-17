Return-Path: <linux-kernel+bounces-69931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205D485906C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1CB211DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A757C6C3;
	Sat, 17 Feb 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nGuvFxj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1887C0BB
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182861; cv=none; b=H+ryhkp4W3pz4DT0Ck69L1Gpz5j5e/WRFr+RIw2is2mjnaX1/wZNisyMlscArGn070YvU+Qg8Bl5nAlGKc+a3FVChNfYIW3nrd/Oxk56TBgSwt8Utr7fNBYohT3STs5a9F81NZxgBN6M3/jV0ke+0CrC06AjbzCgQbdUEld1gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182861; c=relaxed/simple;
	bh=fGzK/EtpRxV8Keho3Vn2ZVp4gCcxZ3TdoV5kAVx1bUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gtoNi2kAdolcYoU5uZqrkeHgE871+RcpxkTIvwPSPCISk6ZBa/aCo7h6A6SDBram0jGsWbzyXARM2zqYRcb++6V5l6mZprsWj9ea0dBGeWdRQ868ztWyV4B5oZYfEMeG2rH2jYqdCUMZ5zu2tgCtsY1ZMtcKdUcbrDYgEpsyYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nGuvFxj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19270C433C7;
	Sat, 17 Feb 2024 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708182860;
	bh=fGzK/EtpRxV8Keho3Vn2ZVp4gCcxZ3TdoV5kAVx1bUU=;
	h=Date:From:To:Cc:Subject:From;
	b=nGuvFxj3Gew/C5CY0x/uDUZ/874de9QLFR3YRescGr1EWCJacdqSvLp4rTxcWXrfl
	 R8FLeAId6LcYyLz3IcBn5teD+TxBbG7tqzCxAArZK+jueNxA/DkicB1nGMVbZrLHcB
	 8eVyLafqCa7h7dyButkHvMzTTvkUeAcH0Zt2MCdk=
Date: Sat, 17 Feb 2024 16:14:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.8-rc5
Message-ID: <ZdDNSRgtgUoosT7Q@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc5

for you to fetch changes up to 5928d411557ec5d53832cdd39fc443704a3e5b77:

  Documentation: Document the Linux Kernel CVE process (2024-02-17 14:46:39 +0100)

----------------------------------------------------------------
Driver core fixes for 6.8-rc5

Here are some driver core fixes, a kobject fix, and a documentation
update for 6.8-rc5.  In detail these changes are:
  - devlink fixes for reported issues with 6.8-rc1
  - topology scheduling regression fix that has been reported by many
  - kobject loosening of checks change in -rc1 is now reverted as some
    codepaths seemed to need the checks
  - documentation update for the CVE process.  Has been reviewed by
    many, the last minute change to the document was to bring the .rst
    format back into the the new style rules, the contents did not
    change.

All of these, except for the documentation update, have been in
linux-next for over a week.  The documentation update has been reviewed
for weeks by a group of developers, and in public for a week and the
wording has stabilized for now.  If future changes are needed, we can do
so before 6.8-final is out (or anytime after that.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      Revert "kobject: Remove redundant checks for whether ktype is NULL"
      Documentation: Document the Linux Kernel CVE process

Saravana Kannan (3):
      driver core: Fix device_link_flag_is_sync_state_only()
      driver core: fw_devlink: Improve detection of overlapping cycles
      driver core: fw_devlink: Improve logs for cycle detection

Vincent Guittot (1):
      topology: Set capacity_freq_ref in all cases

 Documentation/process/cve.rst           | 121 ++++++++++++++++++++++++++++++++
 Documentation/process/index.rst         |   1 +
 Documentation/process/security-bugs.rst |   5 +-
 MAINTAINERS                             |   5 ++
 drivers/base/arch_topology.c            |  13 ++--
 drivers/base/core.c                     |  26 +++++--
 lib/kobject.c                           |  24 ++++---
 7 files changed, 169 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/process/cve.rst


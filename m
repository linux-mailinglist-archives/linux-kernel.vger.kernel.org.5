Return-Path: <linux-kernel+bounces-152483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4138ABF18
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DC1F2112F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831711733;
	Sun, 21 Apr 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCwixMy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE06111A2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699453; cv=none; b=rR/12sDzMXbXG4wO48rrUTg2mlZCIafNKY+dBuy81RTTYLY1miypkwpLQr0fjqFjTBhRC/4hLHzWiqqlC4a795kv8K0jo+wjeA4ySGtJizEd6WlfktYjjNhv3dOHB3ZJtNYnUfiCaIis9aaSO7P9fjZzHKMdZFelygjejuDGoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699453; c=relaxed/simple;
	bh=i5shS/meQIR2KVS5veJuv7o07BZVwUaDmIxxq9cnvCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KbPO17u0LOjqx25HPYD9WlIiGqqO/zo7GJWvJ6NoDmGYZLHQMgU3lnE10mDphn911WKGXGVeuYbObO1PSBcJsm1PVcC11uWwDp2QIiydBouy8mbD5ckDmbbkLs5/2jJ12sRNJtW+Pe/R4svDWJi48mLo5NDxZ2DTwrmCHGkDA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCwixMy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC0C113CE;
	Sun, 21 Apr 2024 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713699452;
	bh=i5shS/meQIR2KVS5veJuv7o07BZVwUaDmIxxq9cnvCo=;
	h=Date:From:To:Cc:Subject:From;
	b=uCwixMy55xJyoiPgqiHGMgDnzraVBxldQbdEdXaSbF1ysoKLBMNDvr115Xd7f2vOq
	 N7o7ExfV7mRBcqOJrsLXbDAEinok01qGYKxNPR+AooGD+hCAdFJzHei/hGbnE8TEQr
	 qFqsQtf8ss5dmoGWRGt99Oz7oLYuSCEK9SV13Yyc=
Date: Sun, 21 Apr 2024 13:37:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.9-rc5
Message-ID: <ZiT6ed-F2vh8sCwP@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc5

for you to fetch changes up to ebaed6d4def877d2035786ff318379eb750044c8:

  peci: linux/peci.h: fix Excess kernel-doc description warning (2024-04-11 17:06:06 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.9-rc5

Here are some small char/misc and other driver fixes for 6.9-rc5.
Included in here are the following:
  - binder driver fix for reported problem
  - speakup crash fix
  - mei driver fixes for reported problems
  - comdei driver fix
  - interconnect driver fixes
  - rtsx driver fix
  - peci.h kernel doc fix

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Greg Kroah-Hartman (1):
      Merge tag 'icc-6.9-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-work-linus

Konrad Dybcio (1):
      interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Randy Dunlap (1):
      peci: linux/peci.h: fix Excess kernel-doc description warning

Ricky Wu (1):
      misc: rtsx: Fix rts5264 driver status incorrect when card removed

Sakari Ailus (2):
      Revert "mei: vsc: Call wake_up() in the threaded IRQ handler"
      mei: vsc: Unregister interrupt handler for system suspend

Samuel Thibault (1):
      speakup: Avoid crash on very long word

 drivers/accessibility/speakup/main.c |  2 +-
 drivers/android/binder.c             |  4 +-
 drivers/comedi/drivers/vmk80xx.c     | 35 ++++++---------
 drivers/interconnect/core.c          |  8 ++++
 drivers/interconnect/qcom/x1e80100.c | 26 -----------
 drivers/misc/cardreader/rtsx_pcr.c   |  2 +-
 drivers/misc/mei/pci-me.c            |  2 +-
 drivers/misc/mei/platform-vsc.c      | 17 +++++++-
 drivers/misc/mei/vsc-tp.c            | 84 +++++++++++++++++++++++++-----------
 drivers/misc/mei/vsc-tp.h            |  3 ++
 include/linux/peci.h                 |  1 -
 11 files changed, 104 insertions(+), 80 deletions(-)


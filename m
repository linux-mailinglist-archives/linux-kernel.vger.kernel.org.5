Return-Path: <linux-kernel+bounces-25557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98C82D29B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A428178F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6EE2C68D;
	Sun, 14 Jan 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MiMDevn8"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E72C681
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32DA320002;
	Sun, 14 Jan 2024 23:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705274935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ekj1BIKc/p7PMvxdbAIJtXPBTFLeIHgU2AxKmlazIDg=;
	b=MiMDevn8ZcZvevdrLRQVM9K5HqIy8Xu1qveVBRn0BxKzb2sUfB7EabEPjzzbzbl/EvCs74
	dFvia3LBGA35jGYC2UGvTaJHh2Csnz94bRzKvg4iEM9RiTTgnTxbvH3gQWTSENw3ks5gDH
	IEXzAt7aCkaT28criefjGd7NWiWA9JQpIslwcuMrheIbycvlc1CKZNUK/eXh8lFsJ2GS7S
	sdtPqJUqvFi560S612Z7LL+i5WAPvnpaYY3KuCSbeXrOAVAnT4irOjgCqy5A7iakex+t8H
	XTVhudIHEAsqmh1MQkJT5V7OOgTMNOPrmiW3twpSC34lQd4sSmZnBoo7AeMuZQ==
Date: Mon, 15 Jan 2024 00:28:54 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.8
Message-ID: <2024011423285495e8345d@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com


Hello Linus,

Here is the i3c subsytem pull request for 6.8. We are continuing to see
more fixes as hardware is available and code is actually getting tested.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.8

for you to fetch changes up to 4fa0888f6f3e6a67cac5afafb23e33f8222cfdd0:

  i3c: document hotjoin sysfs entry (2024-01-15 00:21:14 +0100)

----------------------------------------------------------------
I3C for 6.7

Core:
 - Add a sysfs control for hotjoin
 - Add fallback method for GETMXDS CCC

Drivers:
 - cdns: fix prescale for i2c clock
 - mipi-i3c-hci: more fixes now that the driver is used
 - svc: hotjoin enabling/disabling support

----------------------------------------------------------------
Alexandre Belloni (1):
      i3c: document hotjoin sysfs entry

Frank Li (6):
      i3c: master: add enable(disable) hot join in sys entry
      i3c: master: svc: add hot join support
      i3c: add actual_len in i3c_priv_xfer
      i3c: master: svc: rename read_len as actual_len
      i3c: master: svc: return actual transfer data len
      i3c: master: fix kernel-doc check warning

Harshit Shah (1):
      i3c: master: cdns: Update maximum prescaler value for i2c clock

Jarkko Nikula (5):
      i3c: mipi-i3c-hci: Report NACK response from CCC command to core
      i3c: mipi-i3c-hci: Do not overallocate transfers in hci_cmd_v1_daa()
      i3c: mipi-i3c-hci: Handle I3C address header error in hci_cmd_v1_daa()
      i3c: mipi-i3c-hci: Add DMA bounce buffer for private transfers
      i3c: master: Fix build error

Joshua Yeong (1):
      i3c: Add fallback method for GETMXDS CCC

Randy Dunlap (1):
      i3c: master: fix Excess kernel-doc description warning

 Documentation/ABI/testing/sysfs-bus-i3c  | 15 +++++
 drivers/i3c/master.c                     | 95 +++++++++++++++++++++++++++++++-
 drivers/i3c/master/i3c-master-cdns.c     |  7 ++-
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c |  7 ++-
 drivers/i3c/master/mipi-i3c-hci/core.c   | 49 +++++++++++++++-
 drivers/i3c/master/mipi-i3c-hci/dma.c    |  4 +-
 drivers/i3c/master/mipi-i3c-hci/hci.h    |  1 +
 drivers/i3c/master/svc-i3c-master.c      | 95 ++++++++++++++++++++++++++------
 include/linux/i3c/device.h               |  2 +
 include/linux/i3c/master.h               |  9 ++-
 10 files changed, 256 insertions(+), 28 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-25601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B432D82D344
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688051F21233
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665AD1FAA;
	Mon, 15 Jan 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnrL1kcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8A1841;
	Mon, 15 Jan 2024 03:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE31BC433F1;
	Mon, 15 Jan 2024 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705288802;
	bh=KekZRUCdk+6iYc2MN6ZVcrBLUJzvM3qNm8Vxd8INX3I=;
	h=From:To:Cc:Subject:Date:From;
	b=qnrL1kcKdYMKuGv9o2LJD1t6rGQdd3DZOtZqwW0fEXa2AlerCpuP45f5Ilqw+dT1+
	 M3k3jLPmwws7Vr++uXwyh37fCPQfmmh/s6DmqFiFcaVt4A8tUD+YficN7bkSA2Aa5v
	 3HK9nrcq48sSRy1yTAnWK8EDiAjhh4OmHzfYAuIwwj4wVv9UxB76XHl68XZ/6m1bh/
	 /nPw547cM8xyHOcz1bIeGZPld/omIFXqV/9N4a/0H/NtuBrXNLpiY0Jtd9DI0SXuVM
	 crzoLtScg2KjJHzorPgqdSGB+BxErlIw0L4GXKNr/yO5iUxnndqMUoWocQPvooN9V/
	 7/kXvk1SWm5hQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrien Leravat <adrien.leravat@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: [GIT PULL] rpmsg updates for v6.8
Date: Sun, 14 Jan 2024 19:24:43 -0800
Message-ID: <20240115032444.155078-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.8

for you to fetch changes up to d5362c37e1f8a40096452fc201c30e705750e687:

  rpmsg: virtio: Free driver_override when rpmsg_remove() (2023-12-18 10:56:03 -0700)

----------------------------------------------------------------
rpmsg updates for v6.8

This make virtio free driver_override upon removal. It also updates the
rpmsg documentation after earlier API updates.

----------------------------------------------------------------
Adrien Leravat (1):
      doc: rmpsg: Update with rpmsg_endpoint

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

 Documentation/staging/rpmsg.rst  | 50 ++++++++++++++++++++++------------------
 drivers/rpmsg/virtio_rpmsg_bus.c |  1 +
 2 files changed, 28 insertions(+), 23 deletions(-)


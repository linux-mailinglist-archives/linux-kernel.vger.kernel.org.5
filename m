Return-Path: <linux-kernel+bounces-25607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1382D362
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451C61C20DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7223BE;
	Mon, 15 Jan 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZyqqgwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96120E3;
	Mon, 15 Jan 2024 03:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5220FC433F1;
	Mon, 15 Jan 2024 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705289773;
	bh=UQCp8KZU0G1sik3A84WMFs1XwhsvaxMaJQ1lvDWr3SY=;
	h=From:To:Cc:Subject:Date:From;
	b=uZyqqgwyuzsZHf+qrjEhzP2ZBqk5hdxYWI91WNVMBbfDfaVCYkDVcxkXSYX2B6Vi+
	 juZ/ehQ4I1WTYpiZVkcOGR0v0A1/29Hy22cezARaVRGueYqQslq9gpxOASYSc0RdOX
	 d/aiTOI1xce9nPSlXhD/dmkkgaFSUtMl0dfIj5Xsd7x7Iwx1bMn/Dl+MUDmU+8uL2v
	 b4+mkflMDGOQK3rUgg7YVBPcZPDO6MHJG9Y/e74xmHEf+xBzg191Jnp3lcOT0iR/H/
	 voWSJD5FS5FSn3f7mrmB9xmLh1CHDPG5WNd2NXfaduz/UZ0Apky29qP3WpMRUG2h34
	 tf5LsRB8xREYw==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [GIT PULL] hwspinlock updates to v6.8
Date: Sun, 14 Jan 2024 19:40:55 -0800
Message-ID: <20240115034056.155592-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.8

for you to fetch changes up to bcd0f5d18b0b1134ccf9ef68e7a0cf637aab380d:

  hwspinlock/core: fix kernel-doc warnings (2023-12-07 14:51:38 -0800)

----------------------------------------------------------------
hwspinlock updates to v6.8

Correct kernel-doc through the hwspinlock core, to address build
warnings (and improve the documentation).

Drop unused compatible in the Qualcomm TCSR mutex driver.

----------------------------------------------------------------
Randy Dunlap (1):
      hwspinlock/core: fix kernel-doc warnings

Vignesh Viswanathan (1):
      hwspinlock: qcom: Remove IPQ6018 SOC specific compatible

 drivers/hwspinlock/hwspinlock_core.c | 53 ++++++++++++++++++++----------------
 drivers/hwspinlock/qcom_hwspinlock.c |  1 -
 2 files changed, 29 insertions(+), 25 deletions(-)


Return-Path: <linux-kernel+bounces-182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29556813D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829D3283781
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49C67215;
	Thu, 14 Dec 2023 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuCak/0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C001671FD;
	Thu, 14 Dec 2023 22:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A0C433C7;
	Thu, 14 Dec 2023 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592506;
	bh=jO7MRbXXdGDQpTCdLNxdAdtZPGNzYDrxpX/fHJWSCAo=;
	h=From:To:Cc:Subject:Date:From;
	b=DuCak/0/K2NvO6yZ5qSoxkf0mhVQR/8CVGvyZeBjYxgH5FdRAKt1WrE4Fy4Z/vuCj
	 gRnczw5S5kcFaZJJa5Irfwc2ooyqNYK8gjXEckLSFC/wkqJKMg6vZHUDd7Q8XblSUL
	 sOAU1O9YM9KrR6fDoCxCyhvXQeG/eqoYQRlaSTOQZ7ShJw6mEhq17LLg6L2usRFtms
	 /H69YD2JQCKpjzq8koI1iyZMMGye2Qv+nYQTic0joGlnkgJqjLZR5Wq4E+lObgvQg8
	 y5jjhhR1hQsxt4VWAVwd28crbY+a62Cr2FyhTYjIzrnNLK4o3YyNP0xNknUt6PW/On
	 kPSYiJ95AzvHw==
From: Song Liu <song@kernel.org>
To: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Song Liu <song@kernel.org>
Subject: [PATCH 0/3] md: Remove deprecated flavors
Date: Thu, 14 Dec 2023 14:21:04 -0800
Message-Id: <20231214222107.2016042-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear, multipath, and faulty have been marked as deprecated for 2.5 years.
Let's remove them.

Thanks,
Song

Song Liu (3):
  md: Remove deprecated CONFIG_MD_LINEAR
  md: Remove deprecated CONFIG_MD_MULTIPATH
  md: Remove deprecated CONFIG_MD_FAULTY

 drivers/md/Kconfig             |  34 ---
 drivers/md/Makefile            |  10 +-
 drivers/md/md-autodetect.c     |   8 +-
 drivers/md/md-faulty.c         | 365 --------------------------
 drivers/md/md-linear.c         | 318 ----------------------
 drivers/md/md-multipath.c      | 463 ---------------------------------
 drivers/md/md.c                | 186 ++++++-------
 include/uapi/linux/raid/md_p.h |   8 +-
 include/uapi/linux/raid/md_u.h |  11 +-
 9 files changed, 91 insertions(+), 1312 deletions(-)
 delete mode 100644 drivers/md/md-faulty.c
 delete mode 100644 drivers/md/md-linear.c
 delete mode 100644 drivers/md/md-multipath.c

--
2.34.1


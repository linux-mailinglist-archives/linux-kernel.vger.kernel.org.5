Return-Path: <linux-kernel+bounces-69768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D645E858E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9561F219FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190C81D528;
	Sat, 17 Feb 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH0Yw64O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332213AE2;
	Sat, 17 Feb 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708160893; cv=none; b=gpim1JKGvDj4M87EATS9OtL46k2D5spBTG9m8e/Gte7+WOJjgPyZf8NsmXnjdcjN71p9S0rOEYM+OGgAZpR8jVY3x7jWgB6GbMC/ZmLqIFWE3mATswoL/YyXUs/sDF3OTD2kcAHqCMG09tG8wVF1p7EGlDy2XwlXRbgERYjraVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708160893; c=relaxed/simple;
	bh=oBeLX5tgQL4xanUHIVI7PWJf0sy/YCEOyZM8/vqF40w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EoY+g+qtZK7S+PmJzEzlyDG+5bJjUA6d7ZniJwQzpvV7/1KUtKQyhKXoCzxFCsfbNNkkjr2Fiv9hVDo4yn5fMWAXcB0kriruWRPBXyaMJeipnmYLK/NtZRIuh6uicE4X+nVDRXNP0/A3E2e7Z7AwEenC/kiEvMI5fzxZ3xafyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH0Yw64O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5CEC433C7;
	Sat, 17 Feb 2024 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708160892;
	bh=oBeLX5tgQL4xanUHIVI7PWJf0sy/YCEOyZM8/vqF40w=;
	h=Date:From:To:Cc:Subject:From;
	b=kH0Yw64OtjlHvTkHUab3A7Je0ztw5Bc14ixMm5TFUUzgBHy6BCTvJaQza/m/38DN8
	 bF6vZ5J8F+yhqxI9Z31QMnLX9OLfbgmUfEQpicOSMRqkmUfevDkSzLW4e0PWNQm3cH
	 ynufnJgTsuQwf1Xha4aAFzUkSIFkxyb8psu7lsWTNg1xWO5xyr9q1o8j+UUw4l4gQd
	 KwzQUJDMO1GDzPvUmHPmmC81pxPDtLNwud08nbUaNw1I2iQNrgRuJlCvAH3qeE3JF5
	 n/e1kSYqXOsWJDv8XqiYgoGZjDdOGeweeA9Gdp+fb1nJtHDgq5ixAtOYChxe6jN+Eq
	 IHOwiTgfPK0fg==
Date: Sat, 17 Feb 2024 10:08:08 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.8-rc5] media fixes
Message-ID: <20240217100808.58ef40b6@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-4

For:

- a regression fix at rkisp1 shared IRQ logic;
- a breakage fix on atomisp due to a kAPI change;
- a permission fix for remote controller BPF support;
- a memleak on ir_toy driver;
- a Kconfig dependency on pwm-ir-rx.

The following changes since commit b32431b753217d8d45b018443b1a7aac215921fb:

  media: vb2: refactor setting flags and caps, fix missing cap (2024-01-24 17:27:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-4

for you to fetch changes up to 346c84e281a963437b9fe9dfcd92c531630289de:

  media: pwm-ir-tx: Depend on CONFIG_HIGH_RES_TIMERS (2024-02-01 13:49:39 +0100)

----------------------------------------------------------------
media fixes for v6.8-rc5

----------------------------------------------------------------
Hans de Goede (1):
      media: atomisp: Adjust for v4l2_subdev_state handling changes in 6.8

Sean Young (2):
      media: rc: bpf attach/detach requires write permission
      media: pwm-ir-tx: Depend on CONFIG_HIGH_RES_TIMERS

Tomi Valkeinen (2):
      media: Revert "media: rkisp1: Drop IRQF_SHARED"
      media:  : Fix IRQ handling due to shared interrupts

Zhipeng Lu (1):
      media: ir_toy: fix a memleak in irtoy_tx

 .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 ++
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |  2 +
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  3 ++
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 24 ++++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  3 ++
 drivers/media/rc/Kconfig                           |  1 +
 drivers/media/rc/bpf-lirc.c                        |  6 +--
 drivers/media/rc/ir_toy.c                          |  2 +
 drivers/media/rc/lirc_dev.c                        |  5 +-
 drivers/media/rc/rc-core-priv.h                    |  2 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    | 58 ++++++++++++---------
 .../staging/media/atomisp/pci/atomisp_internal.h   |  4 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  | 52 +++++++++++--------
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   | 59 ++++++++++++++++------
 14 files changed, 156 insertions(+), 68 deletions(-)



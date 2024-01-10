Return-Path: <linux-kernel+bounces-21920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F2829690
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F7EB268E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CAC3FB1F;
	Wed, 10 Jan 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmemkoVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331343FB1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BEAC433C7;
	Wed, 10 Jan 2024 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704880108;
	bh=hO/kEPYwUKcbceRzmTND4gQ9MKoxkMU7ou09hpPmzOA=;
	h=Date:From:To:Cc:Subject:From;
	b=MmemkoVkNKnZ8OST97lVqtScnY2X2eyVsm826lKqGOFRfa+rCnTrzNZDKpTzh3VVP
	 CaLMoM32PjgDgB2G89yatapGqknXN3KjCE00E9ihH00nxE4JxTZLqu/E69jLMPDGMf
	 8KZqVeHlU2M5MPxbUHuqRpVuhwvMzVDaco/bjXA7kIWt6gru3lxr+huf70y4Atsk4W
	 bWByK/VexBJgXs7ZtkCwOuqHJpYhYWK/MiF+6Poc946HQjTn6aPVrFSMfsYY9BeCJJ
	 i+hRWLk4Z0hQ5ZsCrbR5R58YXxzfqota1V1P/xyq9gT64sFfCvCJ6uOSaRc9fKCemF
	 OBaV/FUwgCVzg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rNVCI-0000Am-29;
	Wed, 10 Jan 2024 10:48:30 +0100
Date: Wed, 10 Jan 2024 10:48:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 6.8-rc1
Message-ID: <ZZ5n7rDOXH1c5S81@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the GNSS updates for 6.8.

Johan


The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.8-rc1

for you to fetch changes up to 0cbbbe09d49b959d0225f7f2223a8ae3b2c1964c:

  gnss: ubx: add support for the reset gpio (2023-12-15 09:29:54 +0100)

----------------------------------------------------------------
GNSS updates for 6.8-rc1

Here are the GNSS updates for 6.8-rc1, including:

 - support for the reset pin found on some u-blox receivers
 - use new regulator helper for the u-blox backup supply

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Wolfram Sang (3):
      gnss: ubx: use new helper to remove open coded regulator handling
      dt-bindings: gnss: u-blox: add "reset-gpios" binding
      gnss: ubx: add support for the reset gpio

 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |  6 +++++
 drivers/gnss/ubx.c                                 | 31 ++++++++--------------
 2 files changed, 17 insertions(+), 20 deletions(-)


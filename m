Return-Path: <linux-kernel+bounces-48188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12084586C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAD6285B14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F13A8D2;
	Thu,  1 Feb 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcAM+fIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB312135B;
	Thu,  1 Feb 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792771; cv=none; b=tjB8Y0WClgMn6cdoRcQou2friUKroymMArOAtA1gE0ov8GnWfihZ+wAzlsYUu4yHHPPW/z6aeTFaA9AgD9in+/TdE3VumNVXsm3r+y9E/O4x6PTHj+CrxMpivyFYGVWq+IcxTFRIXXBF8oIfNde/QPAAkUldA9NQwox/PO1u1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792771; c=relaxed/simple;
	bh=6pvTxGKjDkNH/OXfRp2ulBOrP5l6tDhn0YEhIfEMK2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifRMWOCYFU/5WBqjENl7VUD+UMnzM14L/87nQrn6uJlXC1xd5wmCZWL6Gas5W9HMEuf/gt6FSPNwhJVfrLNf0oYB6wnUqujiwKDwbAEeoe5eedpVyV65LD3rBYvipyZECQljQB7lMc9NlxNMeYyM7RUtArEtl61leyUhkRGy2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcAM+fIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E36C433F1;
	Thu,  1 Feb 2024 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706792770;
	bh=6pvTxGKjDkNH/OXfRp2ulBOrP5l6tDhn0YEhIfEMK2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcAM+fINDSL+E3SsXqnTf84QclcABIPA5RyvWas0WFWSc6W/WjhTR9WxWPaKRMa6f
	 23FyO0qpuvQpo0ZkyQ58J3XyAnt2y0Ktq6mzaas7/qUwo7y3bgZ1aupwioZuMhFxNN
	 r9pc5zcnGlDBoA1HXtdi/fTR26i9sqCUtAb9Z7cGCwgqnZdlgujKYnJP9KPTKLel9E
	 80koMdTMPNV3DhHW0SnkC/7UljvvWckToEjNcba6nIRkWW0bEo9gkj8ePgoRM9XBX9
	 1MDC5AKOqpkwrRoUPMD1qFUEZKXTpViTgWRoQAS2dddrB6/7GbFHmsalGefnnCRWQW
	 F6KsgXefyYiGA==
Date: Thu, 1 Feb 2024 13:06:05 +0000
From: Lee Jones <lee@kernel.org>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] Immutable branch between MFD, CROS and Watchdog due for
 the v6.9 merge window
Message-ID: <20240201130605.GA1379817@google.com>
References: <20240126095721.782782-1-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126095721.782782-1-lma@chromium.org>

Good afternoon,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-watchdog-v6.9

for you to fetch changes up to 843dac4d3687f7628ba4f76e1481ee3838b27a35:

  watchdog: Add ChromeOS EC-based watchdog driver (2024-02-01 11:49:30 +0000)

----------------------------------------------------------------
Immutable branch between MFD, CROS and Watchdog due for the v6.9 merge window

----------------------------------------------------------------
Lukasz Majczak (2):
      platform/chrome: Update binary interface for EC-based watchdog
      watchdog: Add ChromeOS EC-based watchdog driver

 MAINTAINERS                                    |   6 +
 drivers/watchdog/Kconfig                       |  11 ++
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/cros_ec_wdt.c                 | 204 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  78 +++++-----
 5 files changed, 257 insertions(+), 43 deletions(-)
 create mode 100644 drivers/watchdog/cros_ec_wdt.c

-- 
Lee Jones [李琼斯]


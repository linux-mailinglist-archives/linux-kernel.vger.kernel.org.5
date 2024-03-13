Return-Path: <linux-kernel+bounces-102654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDB87B564
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261831C20E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D375D8E0;
	Wed, 13 Mar 2024 23:54:35 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE659B42
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374074; cv=none; b=ZeFTVtbll/Jei09zZqvBRrDi9CNnDfbbLnnQO7gnMALldW/dG60vrfrDDK1BsAm4xByCaMI9KfiuDbf3/BXMspTkLKvnTdoDN2mso21FyfdaJSTqE52EtSG9hDCqF4epCoWSndA0qr8kdmSCPyo9av0DiYoqC+vayLKZNjVcuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374074; c=relaxed/simple;
	bh=W7n9rnLmfEzlLBG+KiFX/ueeD4PehyBKcG79MOrjkMs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NHVKHI4BWscSG2ilZhqFOyKas+W/hFnMgijCVZNxTYjL5pnMhF6c+CaFvN3ssw3JiCFU6OoZpVMiqQFNCqsD4bQ5KGLbWRkWVX5zvpAGgQBRlbXCNeA9DcTxFocpcIW3OlIUGri4FvB+0vhnZVuSDVua9/ZsUMs7fTPh3wlfuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 04d36d4b-e195-11ee-b3cf-005056bd6ce9;
	Thu, 14 Mar 2024 01:54:24 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/11] pinctrl: aw9523: number of cleanups
Date: Thu, 14 Mar 2024 01:52:03 +0200
Message-ID: <20240313235422.180075-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just noticed that the newly introduced driver has some leftovers or unneeded
customisation. Hence this series. It may (or may not :-) be sent as an update
after v6.9-rc1 for v6.9 cycle, but TBH there is nothing functional critical.

Andy Shevchenko (11):
  pinctrl: aw9523: Destroy mutex on ->remove()
  pinctrl: aw9523: Use correct error code for not supported
    functionality
  pinctrl: aw9523: Always try both ports in aw9523_gpio_set_multiple()
  pinctrl: aw9523: Make use of struct pinfunction and
    PINCTRL_PINFUNCTION()
  pinctrl: aw9523: Use temporary variable for HW IRQ number
  pinctrl: aw9523: Get rid of redundant ' & U8_MAX' pieces
  pinctrl: aw9523: Remove unused irqchip field in struct aw9523_irq
  pinctrl: aw9523: Make use of dev_err_probe()
  pinctrl: aw9523: Sort headers and group pinctrl/*
  pinctrl: aw9523: Fix indentation in a few places
  pinctrl: aw9523: Remove redundant dependency to OF

 drivers/pinctrl/Kconfig          |   2 +-
 drivers/pinctrl/pinctrl-aw9523.c | 132 +++++++++++--------------------
 2 files changed, 48 insertions(+), 86 deletions(-)

-- 
2.44.0



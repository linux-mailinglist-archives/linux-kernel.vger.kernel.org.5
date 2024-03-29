Return-Path: <linux-kernel+bounces-124408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C492D891726
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E549287C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721506A356;
	Fri, 29 Mar 2024 10:56:46 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E096A33F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709806; cv=none; b=eDy2aN7IbDZN0imuxcb0Dl0J5nW6S8lM0kkrLjwTUkIjvitbFlYqU8kR2ppuT9tHF6RqQ2cOadCdeDt0tWcLJxd113zxX9k2aq3+X8IPEaCg4lrsUUSne8+CVxIy6yPI2xnCUCiY1erCcFpHH6qZyvAH50epU4ozvZmYhV1+P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709806; c=relaxed/simple;
	bh=/X5KBrNsZRef/ZlLD/N/CjefnjFBzODdabXbvmtFE0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cx++lppCuMl6cyC/FbLzwgrfL1lQ5mJbs+gn9inaOjpt3o+sJlmT/j1RBY0DEngvelI3LxlyiJ3Mw1p8LbH9JXfSv79CP3gDWx9QQY7SpEJE9QYgjHpQpxOaGsfOkuDJkpMImq133RaJ7SWx7AHt7Q0gtsJKurUQFpUTLqYUcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 031b16c6-edbb-11ee-abf4-005056bdd08f;
	Fri, 29 Mar 2024 12:56:36 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] aw9523: number of cleanups
Date: Fri, 29 Mar 2024 12:55:14 +0200
Message-ID: <20240329105634.712457-1-andy.shevchenko@gmail.com>
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
for v6.9 cycle, but TBH there is nothing functional critical. 

In v2:
- fixed typo in patch 4 (LKP)

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



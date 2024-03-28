Return-Path: <linux-kernel+bounces-122735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9EB88FC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1813B21F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837B7BAE5;
	Thu, 28 Mar 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBRo0qGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDE657CE;
	Thu, 28 Mar 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619797; cv=none; b=Ur2UkBv5gV8U6YeRoQzybVw8TBq/VVZuSzJSkb61XLsXOFZAOOgfWbzh0WSwE+DeWzhjBdH3W2gY5Bj0zC2SGcwgBos9Twm2VqTY8DwLFUTVS7pbz5Wiw2jS7GYjtTuK9Sb+BQzPG8qB8s60zmrDQ2cI52S+8aV8KFJkF6V7GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619797; c=relaxed/simple;
	bh=4lASHVnVg6S7loQBgqB597z0tEChvGkK6reXfIrHBrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BikZgSkfNYBZMti5MetFX0k7gTzRvdOPXZD8gcpJdubJDqmCYdfsN5vQWq09p6yuiOATjvTxONRrM9X4nTznd9ijmHNFsirVLdzobP/ZzN28lanvMU/tYXMwTxignLmO8+cQ82/E/5mySi1At6gUHvehBiQxSqQcnelBw3ol//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBRo0qGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C71C433C7;
	Thu, 28 Mar 2024 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619797;
	bh=4lASHVnVg6S7loQBgqB597z0tEChvGkK6reXfIrHBrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBRo0qGp1bTyVS7voadFK5xuefdu2C8csOywCLWtpBbLoakD3ybONzy8P805rWfgg
	 iE4j8ATggEctCu/qW/gZr02shDCi8OQ8FKDaTdYuzk1BkL7vYPZG6mgMfwbjJ9F48o
	 Qs897hVNptG/8v84VZEq5WiYcDn4QEVcaROhIyMWxz2miSFQyyr94mmlCINQDxHNWf
	 S+lEjQByEBETJ79gyhgoLpTgi8DzIFiMgkvlXvW9QgsnAjYfaAwoWR1skrpSULDu2Q
	 BT8GvnFexYcBSqrbtggaJpjTolhoywUMKPzpQpEH6RMTHe5zRqLPJ3VhtSBfkP9adk
	 OiXwcZdfOWmqw==
Date: Thu, 28 Mar 2024 09:56:31 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v6.9 merge window:wq
Message-ID: <20240328095631.GW13211@google.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240310010211.28653-1-andre.przywara@arm.com>

Enjoy!

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.9

for you to fetch changes up to d2ac3df75c3a995064cfac0171e082a30d8c4c66:

  regulator: axp20x: add support for the AXP717 (2024-03-28 09:51:03 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v6.9 merge window

----------------------------------------------------------------
Andre Przywara (4):
      regulator: axp20x: fix typo-ed identifier
      dt-bindings: mfd: x-powers,axp152: Document AXP717
      mfd: axp20x: Add support for AXP717 PMIC
      regulator: axp20x: add support for the AXP717

 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |  2 +
 drivers/mfd/axp20x-i2c.c                           |  2 +
 drivers/mfd/axp20x-rsb.c                           |  1 +
 drivers/mfd/axp20x.c                               | 90 ++++++++++++++++++++
 drivers/regulator/axp20x-regulator.c               | 94 +++++++++++++++++++--
 include/linux/mfd/axp20x.h                         | 98 ++++++++++++++++++++--
 6 files changed, 277 insertions(+), 10 deletions(-)

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-96167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFF8757FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9FCB263B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2BF138490;
	Thu,  7 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9ozR1+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FB13340E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842414; cv=none; b=POa1AR1Xk/5/nsmK+aONysAl/uaH3iqsJiUfDWdSgpYKJ+8UqdZ9ynIJE/NW5Zq3bka48QjcMpqlRh5/g84dpSo/KQJyoVQzbIcu2zqAElfcRkUfFZPLX8jSoPFd/5ws54WOX3DIAsHJc5voTd1CXCNDvAyiOQL5KGzuiZmzVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842414; c=relaxed/simple;
	bh=yEsb/IjXyK5uuQi2q6L51SNxPWU4MDwyDroxMCpKU94=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oIzSoZLyQrHln26vDa5i219+6o3TVYcBxm687H/rliKTHYW7L6JNyfaFgKsPiz6gMkg3XvsR3C2RqLZS7bn5IEa7t2j6UJvdp+IRD3TqKhfgZETo+IFZNzRbTnjAoOLIxvfcZMvYT8VRatrtoubJ3iPZSGYGIW+ufl51S7mJ9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9ozR1+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99745C433F1;
	Thu,  7 Mar 2024 20:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709842414;
	bh=yEsb/IjXyK5uuQi2q6L51SNxPWU4MDwyDroxMCpKU94=;
	h=From:To:Cc:Subject:Date:From;
	b=B9ozR1+S9N6toO7GSlWdyXFfqCrku6YGV4gkG1bc/GgZ635Gkrx4aiT885JVjGBIu
	 ZTbORugLTWY6TffeMWwkpc50+14QkApfmsdmiG2qsaD0W9CmHtxKdTuYFxwobHOMVg
	 /5YbJ1YmLOVcrhGNBHxsJolY9wukhVHO7p68C7LcFIEzBI+OqvbZNyvrNO9L1SReI0
	 uLQvG+8DI0RNkIJP+X4HuRVzW6tQrWkzgVsMQDoh0ktG99GPXZtVdpDs8A3U8fuE2Y
	 oTBL8Or2gXWA6C65xSJlUz9CHI63JoJh/qk6Ml1yFCTwKjIOdGtlGNltQfbrfIEM8p
	 UXkA4/QugG56Q==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.8-rc7
Date: Thu, 07 Mar 2024 20:13:19 +0000
Message-Id: <20240307201333.99745C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit e5d40e9afd84cec01cdbbbfe62d52f89959ab3ee:

  regulator: max5970: Fix regulator child node name (2024-02-13 15:38:23 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc7

for you to fetch changes up to 6717ff5533f332ef7294655629b8fa5fb8b132de:

  regulator: rk808: fix LDO range on RK806 (2024-03-04 14:54:32 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.8

A couple of small fixes for the rk808 driver, the regulator voltage
configurations were incorrectly described.  The changes are not expected
to have practical impact but given that we're dealing with power it's
generally better to follow the hardware specification as closely as we
can to avoid unexpected stresses.

----------------------------------------------------------------
Quentin Schulz (2):
      regulator: rk808: fix buck range on RK806
      regulator: rk808: fix LDO range on RK806

 drivers/regulator/rk808-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


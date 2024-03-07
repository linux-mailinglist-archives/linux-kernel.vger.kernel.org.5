Return-Path: <linux-kernel+bounces-96168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0048757FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291C3B264F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D11384AB;
	Thu,  7 Mar 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVn8rnAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B5137C3B;
	Thu,  7 Mar 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842428; cv=none; b=rEqnBcS1zDO+7BNC3FuNV9HLBvUJ65Lr30YJWR5E8c63jWFWFjr4cu9KaEgf/Ab4RrnO3Kw+xdOSE6ERvYNe+8EGd0/l3L9XOrprcxyYxtj5lDA+2xoALlwK9M0079rG9ADFs3irGO/dLS5XftJHTyo7fY0TiPSyxPUy7aIC8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842428; c=relaxed/simple;
	bh=Bo58KYdVplorn2jeODv+Wjj7A+Q/o4nw6F/WCe/5+58=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JXXzfTXcgFGlNtojuq3cpX1io0r/RXgPw5xUgjyCfC/cmADFsKR4g4KEEyB5BQz/ZfP/Oqe2YggzBmPGlXO2k4Ch+/JYzgWYaYLV3+cTrPEAp0DzpC0iQwAOYykqrvIB2+IfT65PCXVqoUNXz9WKnr/kKsCXhaF7dIGUzGBw9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVn8rnAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377CAC433F1;
	Thu,  7 Mar 2024 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709842427;
	bh=Bo58KYdVplorn2jeODv+Wjj7A+Q/o4nw6F/WCe/5+58=;
	h=From:To:Cc:Subject:Date:From;
	b=rVn8rnARu2LgI7XtnaXy+UFLvNSrBczoMf1EiAXP/QnPpmHikojahJtXz9olKXOg2
	 DgmeeNZBNSeOIqvDBG/9sotW/tJ4Rg6D2soLLI2E1ID/uQunlu4IkAei4wvA4bY2xk
	 7ihnmBdGisstdL9fIntnkoOcAZPET8+HhJRpoNvXaj1Wkpixiqyw5A30QyDl9HnqSz
	 eVCnjr9JBlEw08xaF9xYdG3stDlUrD+ZMDuj4gu3ufTw5ECIe9YwQ6ZP7Onp2wrhQD
	 jiLLnllL/HEgrMv25Bkd19bCG6S+AFpnridtkXmN1ISv0shCkvYd9ynZTn+yVil0Pe
	 2nsXU86fyPfiw==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-rc7
Date: Thu, 07 Mar 2024 20:13:39 +0000
Message-Id: <20240307201347.377CAC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6415c7fe7cf420fa469095a34d9153f991391116:

  spi: Drop mismerged fix (2024-02-27 12:52:51 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc7

for you to fetch changes up to 177cddaa5bdfcbc4c3d4594bb44ed8338765fc29:

  spi: cs42l43: Don't limit native CS to the first chip select (2024-03-06 17:44:28 +0000)

----------------------------------------------------------------
spi: Fix for v6.8

One small fix for the newly added cs42l43 driver which would have caused
it problems working in some system configurations by needlessly
restricting chip select configurations.

----------------------------------------------------------------
Charles Keepax (1):
      spi: cs42l43: Don't limit native CS to the first chip select

 drivers/spi/spi-cs42l43.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


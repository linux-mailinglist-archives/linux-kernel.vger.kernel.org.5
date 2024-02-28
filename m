Return-Path: <linux-kernel+bounces-85497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F374486B6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD411F20FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF279B74;
	Wed, 28 Feb 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbRykRQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8A79B63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143372; cv=none; b=WkhVDBolVx3pBXzGiXZabn+WtNM04TsecTDuIbeZobXP3UE11zYSHjkGmUyfYtoHIDhIv8I1f8nMXZ0o6TdvHFInqfL2PdqmuxuqypS8AfJaj/ehrSocEzYdXXb4RwkKoCvDDkC0rhNUWMXrSlgzRs38ZBEMe+/mqpR49+fE0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143372; c=relaxed/simple;
	bh=32A2jcgWXaikzd67jkX0VtnkGK0iMI6HWY+r8YeVAe4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lYq+XMhrsMyvIndfZAQNLd9yxB5OYp/rhI8/SZK+/xiA8GX1Ew3Drq+GDWF7tZq6W5ZK5prhnvtldr8Y2ieCY3P47rvKf6xIpTw1TQiB3VmpnXueXJVm5igHaVO9Hp5J3579lCPj25ssLvs+ZvFMRpEA0Izpj045Mgi4gatjRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbRykRQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB39C433F1;
	Wed, 28 Feb 2024 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709143372;
	bh=32A2jcgWXaikzd67jkX0VtnkGK0iMI6HWY+r8YeVAe4=;
	h=From:To:Cc:Subject:Date:From;
	b=PbRykRQ6vROMC6ixnqUn7afk2O6HyBMmuF0Fbkib8O464JF64ZVRTcPAviwQTFgo3
	 tE1al5hwCD8Rh7Bqz39U9gF4oSMegX+0JMVJZhabeOBQZzKN3/h8PZGUt1SyAxCcqD
	 FBPEsyBpV21bVdj/OGQluDTr7k0n1VQp3fCUf7hWhd2fVFp6aK5y9db3yv2zO1zSNK
	 l+5Q7wE5+h76KNMtZ3GMQF1w6Ubg7Bjem8lWWVVyCamKyUGk2PD9EVd7N+dwInh8Qt
	 WcEMYZGneBgc+zLGjJjef/OXviCyoqCmJZKDoc2SxM6J2JuIWYQYmDxKYQahXKVuqG
	 BJSwdUqumw+LQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.8-rc5
Date: Wed, 28 Feb 2024 18:02:39 +0000
Message-Id: <20240228180251.CFB39C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit a3fa9838e8140584a6f338e8516f2b05d3bea812:

  regulator (max5970): Fix IRQ handler (2024-01-30 15:27:16 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc5

for you to fetch changes up to e5d40e9afd84cec01cdbbbfe62d52f89959ab3ee:

  regulator: max5970: Fix regulator child node name (2024-02-13 15:38:23 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.8

Two small fixes, one small update for the max5970 driver bringing the
driver and DT binding documentation into sync plus a missed update to
the patterns in MAINTAINERS after a DT binding YAML conversion.

----------------------------------------------------------------
Lukas Bulwahn (1):
      MAINTAINERS: repair entry for MICROCHIP MCP16502 PMIC DRIVER

Naresh Solanki (1):
      regulator: max5970: Fix regulator child node name

 MAINTAINERS                           | 2 +-
 drivers/regulator/max5970-regulator.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)


Return-Path: <linux-kernel+bounces-56533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65284CB56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790C6286F11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609176C81;
	Wed,  7 Feb 2024 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMJG/47U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E476C69;
	Wed,  7 Feb 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311969; cv=none; b=rw3NOfNtyK1+znfQH83ICmIawt29LREXVFMKTnhVbDdocMiWFrToZj1CAeIYGg2PHUaHkJBT8qWP16Dns3whNykeygoYKTvFZwp0799JxtlXafsTnHUyTimvh2t9Pqi7ldt5h+Blbuk4EB4ff/17d2vdsosRc5pU5V6oKxr5DyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311969; c=relaxed/simple;
	bh=FIFIH6ul/CA3ihQljEMF1AXMMN7m8ldvAOQFpoy1h6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yh+ncyjZ2YmxeAVVArMps8pK5nwOiLOdwChS05xrWWKiOroGLE3Q7ng+T/1LZETvgfUCrbB8saibAHCSPGOepyT5cv8NStv3QrYC+NNBrVDPQyzZZ10wcQW5llxUIzGK8fXlfVlCo5gzllcibShi3dR0Hzgl1aGYWY7eBU8hEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMJG/47U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717ECC433C7;
	Wed,  7 Feb 2024 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707311968;
	bh=FIFIH6ul/CA3ihQljEMF1AXMMN7m8ldvAOQFpoy1h6o=;
	h=From:To:Cc:Subject:Date:From;
	b=bMJG/47UnxeWWJakmWhp3dwpUI+meVTQaosVEoV9q1ZWlWuXReCjGTyXHtWyOhykW
	 4yePrkyV2nDi4Q7nARYwFmFlduWSg/EM7BZnpTOGv4lPM9SwqoxX8fzU39ZiNZ+DEm
	 6XT2CSxsFvaKXFabqDkXA2csL7YkQH2QlPFUbor/XSHw9oN4Ehx3LZRGPhQMw8qk9t
	 tnUxByAr/NraRk4Z84L2jBR6QdmcG4KZuD8zMEMR8gUniCg2l038ZUDU/IKwu5zyWm
	 BizrQtLb+FOdH4Zd4/MIwq9NphJd9GVH4nr7i8eqVf46ZW2av1fAHI7qN0NpKgFZyt
	 rv4DCN0bz6/cg==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.8-rc
Date: Wed,  7 Feb 2024 15:19:05 +0200
Message-Id: <20240207131905.2355454-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request brings in some oneliner fixes for the current cycle. The
details are in the signed tag as usual. All patches have been in linux-next
for a few days now. Please pull into char-misc-linus when you get a chance.

Thanks,
Georgi


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.8-rc4

for you to fetch changes up to 5464e7acea4a6c56b3c5c2d7aeef2eda92227b33:

  interconnect: qcom: x1e80100: Add missing ACV enable_mask (2024-02-04 23:36:06 +0200)

----------------------------------------------------------------
interconnect fixes for v6.8-rc

These are tiny fixes for reported issues in driver code for a few
platforms. One of them sorts out a hang issue, the other improves
the power consumption and the rest are fixing some bitmasks to make
sure the hardware does thing right.

-  interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
-  interconnect: qcom: sm8550: Enable sync_state
-  interconnect: qcom: sm8650: Use correct ACV enable_mask
-  interconnect: qcom: x1e80100: Add missing ACV enable_mask

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Konrad Dybcio (2):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      interconnect: qcom: sm8550: Enable sync_state

Mike Tipton (2):
      interconnect: qcom: sm8650: Use correct ACV enable_mask
      interconnect: qcom: x1e80100: Add missing ACV enable_mask

 drivers/interconnect/qcom/sc8180x.c  | 1 +
 drivers/interconnect/qcom/sm8550.c   | 1 +
 drivers/interconnect/qcom/sm8650.c   | 2 +-
 drivers/interconnect/qcom/x1e80100.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)


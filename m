Return-Path: <linux-kernel+bounces-75985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8485F197
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31BC8B22FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8E101E2;
	Thu, 22 Feb 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaGzIhpS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A3DDB0;
	Thu, 22 Feb 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584323; cv=none; b=RCB0C45w2Acg+LyIdrQGT1VqSXhnVP1B7W/jRnfvvOC8KN8QGFosVRjBGMyqXxDJVXF3rFMcpXmZeD8MHe8wB8q95MjbAXrpiDvBIG2lJlyQNtTZbPJ53qyYjQ4tEPU+KWyuC8xe+Zg8i8oNsEHMNKzvf0dQAiG09pcWkt09TCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584323; c=relaxed/simple;
	bh=UREFP8xlBh5Qm8G/QRhbCFONxmsaZT1CbLGgbZzkVMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jH0Cf784JyuaoNWuYwnYCdIOQDSEM9C+7zT6JilBxwM0Py5HKbmERhYJZ4iH+SFNz9PCaSevKHvi14Jyh3p8rjm1dJJv7VcKlAM5MZGeVxvgp0pP2lzWfmqCu64LX/8ohzgGRevyaNmj307jAXZ73nc0TV51yZpTDvw44IMd7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaGzIhpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0412C433F1;
	Thu, 22 Feb 2024 06:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708584323;
	bh=UREFP8xlBh5Qm8G/QRhbCFONxmsaZT1CbLGgbZzkVMU=;
	h=From:To:Cc:Subject:Date:From;
	b=GaGzIhpSKgeC8rKQW+Vq+VzXHNwBIjnJLUG9tr+9UPvgyoWvg8kYU9Iu4TWt9OQSy
	 77K+xs39nk85xt7L76ahFnBrje248iyJ2M3MEuHF3hS8I4vFsjNxvIu9NWJPlcdri3
	 zltSy0Q6wThjILqOYlKoQupewS1Z73EpyVJaH+WhPi0USgHy+CwRhR6SvOGuNikynm
	 Yhqj2uRjLielCF+mpdL+zlZqf2aH3bLE+qvQ9ybDnMc2taSRcJZdjUb9dC8pUV5AGn
	 uCGb+IGmw1SXEeL6GeSo8jhwPunSrjNMPpwWCz6gzikoAcz+biRsbsk/KgvhE6Cgur
	 9/uL5AIvfHFtQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.8-rc5
Date: Wed, 21 Feb 2024 22:45:21 -0800
Message-ID: <20240222064521.2538149-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to cc976dbc492c2bf67d8225845b609ea72e292128:

  Merge tag 'samsung-clk-fixes-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes (2024-01-29 16:47:05 -0800)

----------------------------------------------------------------
Here's some Samsung clk driver fixes I've been sitting on for far too
long. They fix the bindings and clk driver for the Google GS101 SoC.

----------------------------------------------------------------
Stephen Boyd (1):
      Merge tag 'samsung-clk-fixes-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes

Tudor Ambarus (2):
      dt-bindings: clock: gs101: rename cmu_misc clock-names
      clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names

 Documentation/devicetree/bindings/clock/google,gs101-clock.yaml | 4 ++--
 drivers/clk/samsung/clk-gs101.c                                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


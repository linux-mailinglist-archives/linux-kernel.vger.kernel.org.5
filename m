Return-Path: <linux-kernel+bounces-94005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D987382D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C62F1C2347A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15516131E51;
	Wed,  6 Mar 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVIko+LR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4E13174A;
	Wed,  6 Mar 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733349; cv=none; b=oiX9LTI+7ZLUejir9YQTZjEZLpgnGjuvH17jhkQROrk/SOoG4oDrUFSsiRvqZdAQktb39NZBZvsupQk810u2l97sb0ZVRCVlu1iDYMSwzGR6N1BQxhxtEzB+3YEo0xySX3ioTU+4ExTwqIm+NN2qPKlTUvkZbGWbedfdZl1vfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733349; c=relaxed/simple;
	bh=jLiY1VyOnlLZFwOuXhMvVv7YYk/BquLiS8Ez9vTbB7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohoqcj8oNEEUbhhjsXT79L2i9nMiMGYkRuqvbjcEu5JZaNEYW9U3r6hidSYpRZWPSOTENO/+y4UUR05zLdGXp6zvCHVgv2fbOMBgDzwaZLy6cOIFVLG0JirZWFQq3EtaO4PdY6i48H+0tRmDkxJ99KEbItM7hLmFN/u9NWIKDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVIko+LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB4C433C7;
	Wed,  6 Mar 2024 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709733348;
	bh=jLiY1VyOnlLZFwOuXhMvVv7YYk/BquLiS8Ez9vTbB7E=;
	h=From:To:Cc:Subject:Date:From;
	b=aVIko+LRnJWRKTsU6ERuKAewIihmA9wCBTzehUj8BL7QCKMIDGKDC0BoXsjghJ0sH
	 yb6XEEiwcZdoZtn9lCMTZ44hPPuVWz7OnzLAPbnAQqM8D+8KrOZNix6cuQ94p57sDg
	 hcFna7PQf17xKVoXvrRgkdtL4Vu9djlEOl52Klm8ie5zorLPhmNmWxIqJe8sAWn+vg
	 tK7FCrfCX5ekWAJsLeRHWrdZDhLFLP/Sk7AeZvbr+SP1H7vMVD67uolo4EDn+BTGp2
	 uWL1m09Fh7eZz64UuVn72W6wycdAs8Y/1nEtFfyRZJLYWzO22rjOCXUta+r3QvHR24
	 CdJrIQgxX4Uhw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.9
Date: Wed,  6 Mar 2024 15:55:16 +0200
Message-Id: <20240306135516.510557-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.9-rc1 merge
window. It contains new drivers and clean-ups. As always, the summary is
in the signed tag.

All patches have been in linux-next for a week with no reported issues.
Please pull into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.9-rc1

for you to fetch changes up to d1c16491134c726a78dd6936034f117acdc57185:

  Merge branch 'icc-sm7150' into icc-next (2024-02-29 22:43:01 +0200)

----------------------------------------------------------------
interconnect changes for 6.9

This pull request contains the interconnect changes for the 6.9-rc1 merge
window. The highlights are below:

Core changes:
- Constify the of_phandle_args in xlate functions.

Driver changes:
- New interconnect driver for the MSM8909 platform.
- New interconnect driver for the SM7150 platform.
- Clean-up and removal of unused resources in drivers.
- Constify some pointers to structs.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Adam Skladowski (2):
      dt-bindings: interconnect: Add Qualcomm MSM8909 DT bindings
      interconnect: qcom: Add MSM8909 interconnect provider driver

Danila Tikhonov (2):
      dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
      interconnect: qcom: Add SM7150 driver support

Georgi Djakov (3):
      Merge branch 'icc-msm8909' into icc-next
      Merge branch 'icc-cleanup' into icc-next
      Merge branch 'icc-sm7150' into icc-next

Jeffrey Hugo (1):
      dt-bindings: interconnect: qcom,rpmh: Fix bouncing @codeaurora address

Konrad Dybcio (3):
      interconnect: qcom: sm8550: Remove bogus per-RSC BCMs and nodes
      dt-bindings: interconnect: Remove bogus interconnect nodes
      interconnect: qcom: x1e80100: Remove bogus per-RSC BCMs and nodes

Krzysztof Kozlowski (7):
      interconnect: qcom: msm8909: constify pointer to qcom_icc_node
      interconnect: qcom: sa8775p: constify pointer to qcom_icc_node
      interconnect: qcom: sm8250: constify pointer to qcom_icc_node
      interconnect: qcom: sm6115: constify pointer to qcom_icc_node
      interconnect: qcom: sa8775p: constify pointer to qcom_icc_bcm
      interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
      interconnect: constify of_phandle_args in xlate

 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml   |    3 +
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml     |   84 +
 drivers/interconnect/core.c                                    |    4 +-
 drivers/interconnect/qcom/Kconfig                              |   18 +
 drivers/interconnect/qcom/Makefile                             |    4 +
 drivers/interconnect/qcom/icc-common.c                         |    3 +-
 drivers/interconnect/qcom/icc-common.h                         |    3 +-
 drivers/interconnect/qcom/msm8909.c                            | 1329 ++++++
 drivers/interconnect/qcom/sa8775p.c                            |   56 +-
 drivers/interconnect/qcom/sm6115.c                             |   12 +-
 drivers/interconnect/qcom/sm7150.c                             | 1754 ++++++++
 drivers/interconnect/qcom/sm7150.h                             |  140 +
 drivers/interconnect/qcom/sm8250.c                             |    2 +-
 drivers/interconnect/qcom/sm8550.c                             |  574 ---
 drivers/interconnect/qcom/sm8550.h                             |  284 +-
 drivers/interconnect/qcom/x1e80100.c                           |  327 +-
 drivers/interconnect/samsung/exynos.c                          |    2 +-
 drivers/memory/tegra/mc.c                                      |    2 +-
 drivers/memory/tegra/tegra124-emc.c                            |    2 +-
 drivers/memory/tegra/tegra124.c                                |    2 +-
 drivers/memory/tegra/tegra186-emc.c                            |    2 +-
 drivers/memory/tegra/tegra20-emc.c                             |    2 +-
 drivers/memory/tegra/tegra20.c                                 |    2 +-
 drivers/memory/tegra/tegra30-emc.c                             |    2 +-
 drivers/memory/tegra/tegra30.c                                 |    2 +-
 include/dt-bindings/interconnect/qcom,msm8909.h                |   93 +
 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h            |  150 +
 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h          |   24 -
 include/linux/interconnect-provider.h                          |   11 +-
 include/soc/tegra/mc.h                                         |    7 +-
 31 files changed, 3764 insertions(+), 1138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/msm8909.c
 create mode 100644 drivers/interconnect/qcom/sm7150.c
 create mode 100644 drivers/interconnect/qcom/sm7150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8909.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h


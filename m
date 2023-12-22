Return-Path: <linux-kernel+bounces-9623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B224081C89D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E31B22EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704FC156D0;
	Fri, 22 Dec 2023 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFOp2d2U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0217742;
	Fri, 22 Dec 2023 10:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3475EC433C8;
	Fri, 22 Dec 2023 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703242620;
	bh=yxOODCQy7qdFmmgdHpYsbarUrclf58haVTyhf7Ua4hg=;
	h=From:To:Cc:Subject:Date:From;
	b=oFOp2d2ULZLDtmEDim4t3dyCQ4kuNv3BAP8Olo15d9hN34s2Lm+MX6ynrMxXw5ZqC
	 HvSF5h32r5r9zzaidgHPF96wbbUq3F3bP4hBRdb1cgnttCpufpQ0od0Ydq/CregAEs
	 GLQ9uYWWMMcXJtS4rK5J6z7gtaClDTxZBPAkTJ0d15CQUeD/ivbkLJ9WZhmiz7Ois6
	 WxSPFpqjEEW51D6y1SN3WHW64a+bLP4rJF47QO8iQnOHfcxJzPAxT2BeTU2kUVceXe
	 iU98W6rj4bRzxfUQ/tMYMKPPdC0VUGjjwSMGcP1U4GcI3p1LYcezVGT82N6+IgN5B6
	 0hufQmzZKJ8Dg==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.8
Date: Fri, 22 Dec 2023 12:56:49 +0200
Message-Id: <20231222105649.1607990-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.8-rc1 merge
window. It contains some new drivers. As always, the summary is in the
signed tag.

All patches have been in linux-next for more than a week. Please pull into
char-misc-next when possible.

Thanks,
Georgi

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.8-rc1

for you to fetch changes up to addb5295403270f9b287f2d76f1072b6f653af1d:

  Merge branch 'icc-qcm2290' into icc-next (2023-12-15 00:43:01 +0200)

----------------------------------------------------------------
interconnect changes for 6.8

This pull request contains the interconnect changes for the 6.8-rc1 merge
window. These are just driver changes with the following highlights:

Driver changes:
- New interconnect driver for the SM8650 platform.
- New interconnect driver for the SM6115 platform.
- New interconnect driver for the X1E80100 (Snapdragon X Elite) platform.
- Add compatible string for the BWMONv4 instance on the QCM2290 platform.
- Complete the platform drivers conversion to the .remove_new callback
  returning void (mostly iMX, Exynos and the rest of Qcom drivers).

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (5):
      Merge branch 'icc-sm8650' into icc-next
      Merge branch 'icc-platform-remove' into icc-next
      Merge branch 'icc-x1e80100' into icc-next
      Merge branch 'icc-sm6115' into icc-next
      Merge branch 'icc-qcm2290' into icc-next

Konrad Dybcio (5):
      dt-bindings: interconnect: Add Qualcomm SM6115 NoC
      interconnect: qcom: Add SM6115 interconnect provider driver
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6115 bwmon instance
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
      interconnect: qcom: sm6115: Fix up includes

Neil Armstrong (3):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM8650 SoC
      interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC
      dt-bindings: interconnect: qcom-bwmon: document SM8650 BWMONs

Rajendra Nayak (2):
      dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
      interconnect: qcom: Add X1E80100 interconnect provider driver

Uwe Kleine-König (9):
      interconnect: qcom: Make qnoc_remove return void
      interconnect: imx8mm: Convert to platform remove callback returning void
      interconnect: imx8mn: Convert to platform remove callback returning void
      interconnect: imx8mp: Convert to platform remove callback returning void
      interconnect: imx8mq: Convert to platform remove callback returning void
      interconnect: qcom/msm8974: Convert to platform remove callback returning void
      interconnect: qcom/osm-l3: Convert to platform remove callback returning void
      interconnect: qcom/smd-rpm: Convert to platform remove callback returning void
      interconnect: exynos: Convert to platform remove callback returning void

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    4 +
 .../devicetree/bindings/interconnect/qcom,sm6115.yaml          |  152 +
 .../devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml     |  136 +
 .../devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml   |   83 +
 drivers/interconnect/imx/imx8mm.c                              |    9 +-
 drivers/interconnect/imx/imx8mn.c                              |    9 +-
 drivers/interconnect/imx/imx8mp.c                              |    9 +-
 drivers/interconnect/imx/imx8mq.c                              |    9 +-
 drivers/interconnect/qcom/Kconfig                              |   27 +
 drivers/interconnect/qcom/Makefile                             |    6 +
 drivers/interconnect/qcom/icc-rpm.c                            |    4 +-
 drivers/interconnect/qcom/icc-rpm.h                            |    2 +-
 drivers/interconnect/qcom/msm8916.c                            |    2 +-
 drivers/interconnect/qcom/msm8939.c                            |    2 +-
 drivers/interconnect/qcom/msm8974.c                            |    6 +-
 drivers/interconnect/qcom/msm8996.c                            |    2 +-
 drivers/interconnect/qcom/osm-l3.c                             |    6 +-
 drivers/interconnect/qcom/qcm2290.c                            |    2 +-
 drivers/interconnect/qcom/qcs404.c                             |    2 +-
 drivers/interconnect/qcom/sdm660.c                             |    2 +-
 drivers/interconnect/qcom/sm6115.c                             | 1423 +++++
 drivers/interconnect/qcom/sm8650.c                             | 1674 ++++++
 drivers/interconnect/qcom/sm8650.h                             |  143 +
 drivers/interconnect/qcom/smd-rpm.c                            |    6 +-
 drivers/interconnect/qcom/x1e80100.c                           | 2328 ++++++++
 drivers/interconnect/qcom/x1e80100.h                           |  192 +
 drivers/interconnect/samsung/exynos.c                          |    6 +-
 include/dt-bindings/interconnect/qcom,sm6115.h                 |  111 +
 include/dt-bindings/interconnect/qcom,sm8650-rpmh.h            |  154 +
 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h          |  207 +
 30 files changed, 6660 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm6115.c
 create mode 100644 drivers/interconnect/qcom/sm8650.c
 create mode 100644 drivers/interconnect/qcom/sm8650.h
 create mode 100644 drivers/interconnect/qcom/x1e80100.c
 create mode 100644 drivers/interconnect/qcom/x1e80100.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6115.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h


Return-Path: <linux-kernel+bounces-25605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D682D356
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306761F21441
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B261FAA;
	Mon, 15 Jan 2024 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0k5F8wK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1701842;
	Mon, 15 Jan 2024 03:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576FC433F1;
	Mon, 15 Jan 2024 03:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705289454;
	bh=adWi+22vHYVKbEpGcebQWCFjzm8EvmYm2B3dJLIoD8k=;
	h=From:To:Cc:Subject:Date:From;
	b=S0k5F8wKCcPUtHhLxm7WtM308Wom6KVwc7SEqW5O8w7PjdR5o9T+c8S61k3p5OSXf
	 PZv8WwNCii/dVlq77w1/ovsPMYUP4JOn8ILAj8IdNuTFycbTdFDCnETcU8+h0AWGAk
	 Cpwwqu5WNoaATrcb0rtJ96fj8+OyG2QM5OM2YlR6PqTniX5mu/jNmoQRiVKyYXNy8P
	 fMAVLU6o9ObRe1OICzT3Z3z1BE2zPhbWjzI4WwLTxFUFkwlDTFl0P5vzMKOi+LpzqU
	 ff2ffulAlpNMrqSDIWV1wBneRw1G73CWXM7Q+XVN0EBO/SMhYyyQDbDpSsC1DvwYYw
	 aoi1ArnIlA+uA==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [GIT PULL] remoteproc updates for v6.8
Date: Sun, 14 Jan 2024 19:35:34 -0800
Message-ID: <20240115033537.155277-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.8

for you to fetch changes up to 300ed425dfa99f6926299ec196a1eedf05f47b21:

  remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS (2023-12-17 10:06:32 -0800)

----------------------------------------------------------------
remoteproc updates for v6.8

The i.MX DSP remoteproc driver adds support for providing a resource
table, in order to enable IPC with the core.

The TI K3 DSP driver is transitioned to remove_new, error messages are
changed to use symbolic error codes, and dev_err_probe() is used where
applicable.

Support for the Qualcomm SC7280 audio, compute and WiFi co-processors
are added to the Qualcomm TrustZone based remoteproc driver.

----------------------------------------------------------------
Iuliana Prodan (2):
      remoteproc: imx_dsp_rproc: Add mandatory find_loaded_rsc_table op
      arm64: dts: imx8mp: Add reserve-memory nodes for DSP

Luca Weiss (3):
      dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280 MPSS PD-names
      dt-bindings: remoteproc: qcom: sc7180-pas: Add SC7280 compatibles
      remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS

Uwe Kleine-König (3):
      remoteproc: k3-dsp: Suppress duplicate error message in .remove()
      remoteproc: k3-dsp: Use symbolic error codes in error messages
      remoteproc: k3-dsp: Convert to platform remove callback returning void

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       | 21 ++++++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       | 22 ++++++
 drivers/remoteproc/imx_dsp_rproc.c                 |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 | 19 +++++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          | 87 ++++++++++------------
 5 files changed, 101 insertions(+), 49 deletions(-)


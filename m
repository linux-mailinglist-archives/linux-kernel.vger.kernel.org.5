Return-Path: <linux-kernel+bounces-110053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B4885966
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C14B22D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6383CC5;
	Thu, 21 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw6IvNzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C73717B;
	Thu, 21 Mar 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025428; cv=none; b=IvAIikfjvCkMspmZrXc6IhpshKzcaWMhTn5bj2Dy8cwJ9Umtio/Qqkp2KvI6KuoXGV2PlnlAty+7mGgoVN/iUcz9hkbmDVH8p4ROIfVu+QHhR+cKTlzXfIDXSwF2KE+08a1Bxe8sc8wnmQfFabT73+WNMOT08sreapm02XHHoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025428; c=relaxed/simple;
	bh=T48VhPL7uTyMjF8hE8VTkaJAtzTXjPh6XEzhs1te5hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfO1fU3wEna/2j/AIKF7GRZjFQ4zmQcCvmYYGL9Ua63XHdP2AsGZLeOXjBgs6TXPDzoZzkqT4IC2evSo/eEETE8SBA7Fr8PpYcI+zVbMfyYim6uUe5iL4QAkYPe0iAfjHF90AG5kuJkNTfiL1nSXL14BhSlKU/cM9Zr9RrlZQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw6IvNzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EBDC433F1;
	Thu, 21 Mar 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025428;
	bh=T48VhPL7uTyMjF8hE8VTkaJAtzTXjPh6XEzhs1te5hM=;
	h=From:To:Cc:Subject:Date:From;
	b=jw6IvNzzkZzIUDIVBvBGSx1oIznHpgsyibO8XYde2Ltu1vIjJldA9wG5rolCd0YOE
	 OulgRx0EK5tsjlrmk/YI7PshMLcyRRBB8dqiS4MkMsbLacfOMPlGIAyQaTAcLUzaaE
	 KeDbnFQCCLgzCqUj9inkvxv/UOMI5nGunhMK/RbC2v6sYjyHJISmKG8tcNQiBd3P3u
	 upZOkhWaYRTuxmBH29et6GK7IflPNn7qoRT7y7p5Pk5u1F8icK5qUwyQ6c7ts44GJW
	 yVDcx4l4qHX/PPBS6uRAIO7cCk5iVcp+FYQW1RgBze9ui1w5jn/oQ58zZdcyuDhQbc
	 iGYDSgmqEDfZA==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joakim Zhang <joakim.zhang@cixtech.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [GIT PULL] remoteproc updates for v6.9
Date: Thu, 21 Mar 2024 05:55:13 -0700
Message-ID: <20240321125518.1675903-1-andersson@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sorry for the late pull request, I apparently had managed to get git
send-email to only deliver my mail to /dev/null on the machine where I prepared
this.

Regards,
Bjorn

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.9

for you to fetch changes up to 62210f7509e13a2caa7b080722a45229b8f17a0a:

  remoteproc: qcom_q6v5_pas: Unload lite firmware on ADSP (2024-03-05 20:02:07 -0800)

----------------------------------------------------------------
remoteproc updates for v6.9

Qualcomm SM8650 audio, compute and modem remoteproc are added. Qualcomm
X1 Elite audio and compute remoteprocs are added, after support for
shutting down the bootloader-loaded firmware loaded into the audio DSP..

A dozen drivers in the subsystem are transitioned to use devres helpers
for remoteproc and memory allocations.

It makes it possible to acquire in-kernel handle to individual
remoteproc instances in a cluster.

The release of DMA memory for remoteproc virtio is corrected to ensure
that restarting due to a watchdog bite doesn't attempt to allocate the
memory again without first freeing it.

Last, but not least, a couple of DeviceTree binding cleanups.

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the X1E80100 aDSP & cDSP

Andrew Davis (17):
      remoteproc: k3-dsp: Use devm_rproc_alloc() helper
      remoteproc: k3-dsp: Add devm action to release reserved memory
      remoteproc: k3-dsp: Use devm_kcalloc() helper
      remoteproc: imx_dsp_rproc: Use devm_rproc_alloc() helper
      remoteproc: imx_rproc: Use devm_rproc_alloc() helper
      remoteproc: st: Use devm_rproc_alloc() helper
      remoteproc: stm32: Use devm_rproc_alloc() helper
      remoteproc: k3-dsp: Use devm_ti_sci_get_by_phandle() helper
      remoteproc: k3-dsp: Use devm_kzalloc() helper
      remoteproc: k3-dsp: Add devm action to release tsp
      remoteproc: k3-dsp: Use devm_ioremap_wc() helper
      remoteproc: k3-dsp: Use devm_rproc_add() helper
      remoteproc: qcom_q6v5_adsp: Use devm_rproc_alloc() helper
      remoteproc: qcom_q6v5_mss: Use devm_rproc_alloc() helper
      remoteproc: qcom_q6v5_pas: Use devm_rproc_alloc() helper
      remoteproc: qcom_q6v5_wcss: Use devm_rproc_alloc() helper
      remoteproc: qcom_wcnss: Use devm_rproc_alloc() helper

Arnaud Pouliquen (2):
      remoteproc: stm32: Fix incorrect type in assignment for va
      remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef

Dmitry Baryshkov (1):
      remoteproc: qcom: pas: correct data indentation

Joakim Zhang (1):
      remoteproc: virtio: Fix wdg cannot recovery remote processor

Krzysztof Kozlowski (2):
      dt-bindings: remoteproc: qcom,glink-rpm-edge: drop redundant type from label
      dt-bindings: remoteproc: do not override firmware-name $ref

Mathieu Poirier (1):
      remoteproc: Make rproc_get_by_phandle() work for clusters

Neil Armstrong (3):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the SM8650 PAS
      remoteproc: qcom: pas: make region assign more generic
      remoteproc: qcom: pas: Add SM8650 remoteproc support

Sibi Sankar (2):
      remoteproc: qcom_q6v5_pas: Add support for X1E80100 ADSP/CDSP
      remoteproc: qcom_q6v5_pas: Unload lite firmware on ADSP

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   4 +-
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |   1 -
 .../bindings/remoteproc/qcom,qcs404-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  |   2 +-
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |   2 +-
 .../bindings/remoteproc/qcom,sm6115-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sm6350-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sm6375-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sm8150-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       |   2 +-
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  51 +++-
 .../bindings/remoteproc/qcom,wcnss-pil.yaml        |   2 +-
 drivers/remoteproc/imx_dsp_rproc.c                 |  11 +-
 drivers/remoteproc/imx_rproc.c                     |  16 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |  14 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  28 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 326 ++++++++++++++-------
 drivers/remoteproc/qcom_q6v5_wcss.c                |  24 +-
 drivers/remoteproc/qcom_wcnss.c                    |  17 +-
 drivers/remoteproc/remoteproc_core.c               |  29 +-
 drivers/remoteproc/remoteproc_virtio.c             |   6 +-
 drivers/remoteproc/st_remoteproc.c                 |  15 +-
 drivers/remoteproc/stm32_rproc.c                   |  10 +-
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          | 156 ++++------
 25 files changed, 419 insertions(+), 309 deletions(-)


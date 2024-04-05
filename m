Return-Path: <linux-kernel+bounces-133568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83B89A5C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D43F1C216B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FA174EE9;
	Fri,  5 Apr 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR84H4YO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D921327FD;
	Fri,  5 Apr 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349620; cv=none; b=jBH0cIBCTcKCPU7f6I4bGgyjn4FZEn78LL0U0/nPrvJ6toAPBI21YtLcxp7dzATbxeYXGZcwMM0/G7Kyf7UtIfrEquKa7bq9cE4qZqTmJQxuosvGKCU+yLHfJbCRLgFA5RcJm/2g2ca1TtePf3nLMD9AVnj3RXkyErKoo6j8oXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349620; c=relaxed/simple;
	bh=KKHqecoYIY5uSH4kmMdMPzfpUjYXfpRio0vfTLXUmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cJ/39f37sQaZdoOqKrwfL/KKEPTBaYgH7pG/FpvacXanmulYHGefFcVzIm2rxHlWOlaQRYg1o8O3rnDAghsQgliVk6xrJ83jZQY+DpkVhEhBncrbCW+zrD/ScosUxRPn8sLyUwMotO5jvoAAbAIvXVAAoGUgg653UQqRGBJZMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR84H4YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9F7C433F1;
	Fri,  5 Apr 2024 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712349619;
	bh=KKHqecoYIY5uSH4kmMdMPzfpUjYXfpRio0vfTLXUmtg=;
	h=Date:From:To:Cc:Subject:From;
	b=BR84H4YOtVFf1NIe9wK/VVUVfr1EaWQuUUzWfT5ETRH6Uogo1EcxLUgVni9yVfbdI
	 +1ZsS8I2Uy0YLuz1zEwSb79cltAHUnqBLReuB3oxIOP+OECDN8eMc1jwwed5+ISO+l
	 eLUnV/Q+YDqUeizEKc+nfRJhQ5i7Js7Gy+NQOOMiAiw9EG4cwLj0OswGFd71v88axT
	 WXhyh7+LkVUQcnaqWugY0uAOA9htF74tLTm0gujJTPP8h6v3244bQGSmczpz1cMTAh
	 6+uuNv5uLS30Iq18Y13YzHr7r23sYnmrTVcaZmRxw3oWSpLBlPuImibLNxYs5TGj5i
	 9xV0cbTOVijPQ==
Date: Fri, 5 Apr 2024 15:40:17 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.9, part 1
Message-ID: <20240405204017.GA1394619-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT fixes for v6.9.

Rob


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.9-1

for you to fetch changes up to de164a7f19248fb03229a4af9b0db333d9591e55:

  nios2: Only use built-in devicetree blob if configured to do so (2024-04-03 14:35:53 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.9, part 1:

- Fix NIOS2 boot with external DTB

- Add missing synchronization needed between fw_devlink and DT overlay
  removals

- Fix some unit-address regex's to be hex only

- Drop some 10+ year old "unstable binding" statements

- Add new SoCs to QCom UFS binding

- Add TPM bindings to TPM maintainers

----------------------------------------------------------------
Guenter Roeck (1):
      nios2: Only use built-in devicetree blob if configured to do so

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Krzysztof Kozlowski (9):
      docs: dt-bindings: add missing address/size-cells to example
      dt-bindings: ufs: qcom: document SC8180X UFS
      dt-bindings: ufs: qcom: document SC7180 UFS
      dt-bindings: ufs: qcom: document SM6125 UFS
      dt-bindings: clock: keystone: remove unstable remark
      dt-bindings: clock: ti: remove unstable remark
      dt-bindings: remoteproc: ti,davinci: remove unstable remark
      dt-bindings: soc: fsl: narrow regex for unit address to hex numbers
      dt-bindings: timer: narrow regex for unit address to hex numbers

Rob Herring (1):
      MAINTAINERS: Add TPM DT bindings to TPM maintainers

Sergey Shtylyov (1):
      of: module: prevent NULL pointer dereference in vsnprintf()

 .../devicetree/bindings/clock/keystone-gate.txt    |  2 --
 .../devicetree/bindings/clock/keystone-pll.txt     |  2 --
 .../devicetree/bindings/clock/ti/adpll.txt         |  2 --
 .../devicetree/bindings/clock/ti/apll.txt          |  2 --
 .../devicetree/bindings/clock/ti/autoidle.txt      |  2 --
 .../devicetree/bindings/clock/ti/clockdomain.txt   |  2 --
 .../devicetree/bindings/clock/ti/composite.txt     |  2 --
 .../devicetree/bindings/clock/ti/divider.txt       |  2 --
 .../devicetree/bindings/clock/ti/dpll.txt          |  2 --
 .../devicetree/bindings/clock/ti/fapll.txt         |  2 --
 .../bindings/clock/ti/fixed-factor-clock.txt       |  2 --
 .../devicetree/bindings/clock/ti/gate.txt          |  2 --
 .../devicetree/bindings/clock/ti/interface.txt     |  2 --
 Documentation/devicetree/bindings/clock/ti/mux.txt |  2 --
 .../devicetree/bindings/dts-coding-style.rst       |  2 ++
 .../bindings/remoteproc/ti,davinci-rproc.txt       |  3 --
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  2 +-
 .../bindings/soc/fsl/fsl,layerscape-scfg.yaml      |  2 +-
 .../bindings/timer/arm,arch_timer_mmio.yaml        |  2 +-
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 38 +++++++++++++++++++---
 MAINTAINERS                                        |  1 +
 arch/nios2/kernel/prom.c                           |  6 +++-
 drivers/base/core.c                                | 26 +++++++++++++--
 drivers/of/dynamic.c                               | 12 +++++++
 drivers/of/module.c                                |  8 +++++
 include/linux/device.h                             |  1 +
 26 files changed, 89 insertions(+), 42 deletions(-)


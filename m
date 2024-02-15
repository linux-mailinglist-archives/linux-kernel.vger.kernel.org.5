Return-Path: <linux-kernel+bounces-67195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB28567E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5652863C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8E133425;
	Thu, 15 Feb 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScmA7EFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD9132C13;
	Thu, 15 Feb 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011172; cv=none; b=F9Ja7dl2nw213uMRPG76BFrLoDfn3roUwYMEQGvTzpg1JSPCh1TMw3Tagyrflt8Wk1SjmapKp3uCrM/QQnphPoQetASgd6tUjgQT07zb8cHi04CqNEogZqjgom3Vhc00nIaW18RAvzxIlp00bAXzd+Llu+7gB4ShiQfyID2bodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011172; c=relaxed/simple;
	bh=w95nUrhyNSbM1lYPsRxeWQzJj/TfrgaNgfXeD6b7tPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eNoXMLE0DD3u82e/ax8XabA2r4WyUTgytrbYu4PbQiMGobHrr4gbE3j2jlNuh2fpzn4l23gTgghA5Fib/cbbjE/9+Ll5jcJsOD6cwo/jRO+ad9s81BgTY5WFj0TBYxeyQGS8yh4+TdcEl+FNug9J8PhC5tlgEW317kqJunNOhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScmA7EFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C5AC433C7;
	Thu, 15 Feb 2024 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708011172;
	bh=w95nUrhyNSbM1lYPsRxeWQzJj/TfrgaNgfXeD6b7tPU=;
	h=Date:From:To:Cc:Subject:From;
	b=ScmA7EFjU/CbMaEttI/s+eQx+J5cBqq3fKTFxT5ulmtoIIxuxEMa8aglNkbmJ/ARw
	 q36G/7RdGi+qPSTlaOzgSHQB5+InFg0ENo5Xf8M+yanAb4f4ubWr3sMwAzxsJ6VKL9
	 Hy7c8tGma/I0DuVLAoot4SXa4b2QnYQxEp7WlilStp/MMFBPgVtutNQSBZdjdHplO+
	 8IDwGUDed/g0fAYQ6+QW+zwdsgMs/AUoHV+n6/H+sTLCXwYs8AVdrvzscKeRYdRY1i
	 QnZo2maIS9G6ugDzhDRq16Zi+CdAZaLILt/avwwJU6sZyhLGTpHyelsl752NSFKfjk
	 xdI9WolG+03yg==
Date: Thu, 15 Feb 2024 09:32:48 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.8
Message-ID: <20240215153248.GA181950-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT fixes for 6.8.

Rob


The following changes since commit 716089b417cf98d01f0dc1b39f9c47e1d7b4c965:

  of: unittest: Fix of_count_phandle_with_args() expected value message (2024-01-11 16:18:30 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-1

for you to fetch changes up to 4e06ec0774f5bebf10e27bc7a5ace4b48ae0fa56:

  dt-bindings: ufs: samsung,exynos-ufs: Add size constraints on "samsung,sysreg" (2024-02-13 10:32:13 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.8:

- Improve devlink dependency parsing for DT graphs

- Fix devlink handling of io-channels dependencies

- Fix PCI addressing in marvell,prestera example

- A few schema fixes for property constraints

- Improve performance of DT unprobed devices kselftest

- Fix regression in DT_SCHEMA_FILES handling

- Fix compile error in unittest for !OF_DYNAMIC

----------------------------------------------------------------
André Draszik (1):
      dt-bindings: don't anchor DT_SCHEMA_FILES to bindings directory

Christian A. Ehrhardt (1):
      of: unittest: Fix compile in the non-dynamic case

Nuno Sa (1):
      of: property: fix typo in io-channels

Nícolas F. R. A. Prado (1):
      kselftest: dt: Stop relying on dirname to improve performance

Radhey Shyam Pandey (1):
      dt-bindings: xilinx: replace Piyush Mehta maintainership

Rob Herring (4):
      dt-bindings: display: nxp,tda998x: Fix 'audio-ports' constraints
      dt-bindings: tpm: Drop type from "resets"
      net: marvell,prestera: Fix example PCI bus addressing
      dt-bindings: ufs: samsung,exynos-ufs: Add size constraints on "samsung,sysreg"

Saravana Kannan (3):
      of: property: Improve finding the consumer of a remote-endpoint property
      of: property: Improve finding the supplier of a remote-endpoint property
      of: property: Add in-ports/out-ports support to of_graph_get_port_parent()

 Documentation/devicetree/bindings/Makefile         |  5 +-
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    |  3 +-
 .../bindings/display/bridge/nxp,tda998x.yaml       |  7 ++-
 .../bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml    |  3 +-
 .../devicetree/bindings/net/marvell,prestera.yaml  |  4 +-
 .../bindings/reset/xlnx,zynqmp-reset.yaml          |  3 +-
 .../devicetree/bindings/tpm/tpm-common.yaml        |  2 +-
 .../bindings/ufs/samsung,exynos-ufs.yaml           |  9 ++-
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       |  3 +-
 .../devicetree/bindings/usb/microchip,usb5744.yaml |  3 +-
 .../devicetree/bindings/usb/xlnx,usb2.yaml         |  3 +-
 drivers/of/property.c                              | 65 +++++++++-------------
 drivers/of/unittest.c                              | 12 +++-
 .../testing/selftests/dt/test_unprobed_devices.sh  | 13 +++--
 14 files changed, 71 insertions(+), 64 deletions(-)


Return-Path: <linux-kernel+bounces-12525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEE81F617
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B011F226F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204463AD;
	Thu, 28 Dec 2023 08:52:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762572F45
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BS8ogVp005935;
	Thu, 28 Dec 2023 16:50:42 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T129l5QqDz2QJG93;
	Thu, 28 Dec 2023 16:44:11 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 28 Dec
 2023 16:50:40 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang
	<chunyan.zhang@unisoc.com>,
        <linux-kernel@vger.kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
Subject: [GIT PULL] ARM: sprd: DTS and bindings for v6.8-rc1
Date: Thu, 28 Dec 2023 16:49:58 +0800
Message-ID: <20231228084958.1439115-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BS8ogVp005935

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://github.com/lyrazhang/linux.git tags/sprd-dt-6.8-rc1

for you to fetch changes up to 1cff7243334f851b7dddf450abdaa6223a7a28e3:

  arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings (2023-12-28 16:10:39 +0800)

----------------------------------------------------------------
ARM: sprd: DTS and bindings for v6.8-rc1

Unisoc ARM64 DTS and bindings changes are:
- Fixed a few dtb_check warnings
- Add bindings for a new SoC - UMS9620
- Fixed an issue on UMS512

----------------------------------------------------------------
Chunyan Zhang (5):
      dt-bindings: arm: Add compatible strings for Unisoc's UMS9620
      arm64: dts: sprd: Add support for Unisoc's UMS9620
      arm64: dts: sprd: Removed unused clock references from etm nodes
      arm64: dts: sprd: Add clock reference for pll2 on UMS512
      arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings

Cixi Geng (1):
      arm64: dts: sprd: fix the cpu node for UMS512

 .../devicetree/bindings/arm/sprd/sprd.yaml         |   5 +
 arch/arm64/boot/dts/sprd/Makefile                  |   3 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi               |  39 ++--
 arch/arm64/boot/dts/sprd/ums9620-2h10.dts          |  38 ++++
 arch/arm64/boot/dts/sprd/ums9620.dtsi              | 245 +++++++++++++++++++++
 5 files changed, 310 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620-2h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620.dtsi


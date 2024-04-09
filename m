Return-Path: <linux-kernel+bounces-137383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA989E15A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7507AB22274
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB79156227;
	Tue,  9 Apr 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8TAVXKzs"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B74C85;
	Tue,  9 Apr 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682871; cv=none; b=Sxdc/c2i+6G4/x/qwqlxveXFgzl+IijbFCZ/1IRNGHEBUvFVYh5gIgxd2DG7ebT3x6E86gXUIeBdrdx9podmvFc175X2SnLqn5sjeKQRcProQGtyH6Mk/GLABHyY1ioql6Iyb9cqioj331nNAdiTW6mStRfkH3beWVmpOOHQNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682871; c=relaxed/simple;
	bh=mBJH5LRE5IWghmV68o5B0cJWn1OYLQpvrgOwNBVNTFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvDRx3J5HxW8X8bw/sVHKsCmnu9FhmpFRb8PpbxPbpPSpefqbY904uENZ5eDbIKERrIwujGnCRek29cigJ8qm0K74eIy9jcjnM/7YrFDYhoDK47xZMuTIJh7UItZESVvi/lZU2PxGB9vBnxJaJUtJaGcHP6U64mFsAXUb5kmg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8TAVXKzs; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439H01kA012542;
	Tue, 9 Apr 2024 19:13:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=gNMZO/g
	ZNrwN12lTMDycNW5qDShKc3uIHZDokyLEt2E=; b=8TAVXKzspfVriha6jqmEgq6
	n0MBvmnceDINt2HRYxuiqytjVy9nWKn3zUbjaB4o9TKftRdWjjyV9mXvTNcBIVNR
	AbEkCXuNlnHfpJv3WyHSvCOWVRA79J5qQQSF8v0yoIOpFxyPkYEpX6xBsegTktF5
	zCY/UoeIh5fOyo4ArbC0TOC75ZD9p55pabE1q5/yk3pRkikBQ5NcyDuYdv1bSdb6
	hB2Ms2HpXjorcFybwVcwXalsiIXJ3I2A64pqQtw+rrCwdwhuKk+2kHt63Q9zelSh
	pV4xl35N6RseGyC+Srt1PtbDo3wcvrz8ccNEmWNUPKA5hv/zKutNFepejh348+A=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbhbj27q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 19:13:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 41BCC40046;
	Tue,  9 Apr 2024 19:13:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DA62E226FA9;
	Tue,  9 Apr 2024 19:12:58 +0200 (CEST)
Received: from localhost (10.48.86.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 19:12:58 +0200
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/4] Introduce STM32MP257 clock driver
Date: Tue, 9 Apr 2024 19:12:37 +0200
Message-ID: <20240409171241.274600-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

v10:
  - patch 'dt-bindings: stm32: update DT bingding for stm32mp25'
    - cosmetic change (add change blank line) to YAML documentation
    - rename USB2 into USBH to be compliant with last Reference Manuel
    - Update commit message
    cant't add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>' because modification above

  - patch 'clk: stm32: introduce clocks for STM32MP257 platform'
    - rename USB2 into USBH to be compliant with last Reference Manuel
    - cosmetic changes to be aligned with open parenthesis.

v9: base on next-20240207
  - update dt binding documentation with v8 modidification on RCC driver
    (use .index of clk_parent_data struct to define a parent)
  - rebase patch "arm64: dts: st: add rcc support for STM32MP25"
     with next-20240207 tag

v8:
  - use .index of clk_parent_data struct to define a parent
  - remove unnecessary dependency check with SCMI clock driver
  - convert to platform device APIs
  - convert to devm_of_clk_add_hw_provider()
  - convert single value enum to a define

v7: base on next-20231219
  - These patches below are applied to clk-next:
      clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
      clk: stm32mp1: use stm32mp13 reset driver
      dt-bindings: stm32: add clocks and reset binding for stm32mp25
  - remove unnecessary includes
  - migrate clock parents to struct clk_parent_data and remove
    CLK_STM32_XXX() macros  to have a more readble code
  - use platform device APIs (devm_of_iomap() instead of_iomap())
  - move content of stm32mp25_rcc_init() to stm32mp25_rcc_clocks_probe()
  - simply get_clock_deps()
  - add const to stm32mp25_data struct
  - remove ck_icn_p_serc clock (will be integrate later with security
    management)

v6:
  - remove useless defines in drivers/clk/stm32/stm32mp25_rcc.h

v5:
  - Fix sparse warnings: was not declared. Should it be static?
    drivers/clk/stm32/clk-stm32mp13.c:1516:29: symbol 'stm32mp13_reset_data'
    drivers/clk/stm32/clk-stm32mp1.c:2148:29: symbol 'stm32mp1_reset_data'
    drivers/clk/stm32/clk-stm32mp25.c:1003:5: symbol 'stm32mp25_cpt_gate'
    drivers/clk/stm32/clk-stm32mp25.c:1005:29: symbol 'stm32mp25_clock_data'
    drivers/clk/stm32/clk-stm32mp25.c:1011:29: symbol 'stm32mp25_reset_data'

v4:
  - use GPL-2.0-only OR BSD-2-Clause for clock and reset binding files
  - use quotes ' for #clock-cells and #reset-cells in YAML documentation
  - reset binding start now to 0 instead 1
  - improve management of reset lines that are not managed

v3:
  - from Rob Herring change clock item description in YAML documentation
v2:
  - rework reset binding (use ID witch start from 0)
  - rework reset driver to manage STM32MP13 / STM32MP15 / STM32MP25
  - rework YAML documentation

Gabriel Fernandez (4):
  clk: stm32mp13: use platform device APIs
  dt-bindings: stm32: update DT bingding for stm32mp25
  clk: stm32: introduce clocks for STM32MP257 platform
  arm64: dts: st: add rcc support for STM32MP25

 .../bindings/clock/st,stm32mp25-rcc.yaml      |  170 +-
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  144 +-
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |    4 +-
 drivers/clk/stm32/Kconfig                     |    7 +
 drivers/clk/stm32/Makefile                    |    1 +
 drivers/clk/stm32/clk-stm32-core.c            |   11 +-
 drivers/clk/stm32/clk-stm32mp13.c             |   72 +-
 drivers/clk/stm32/clk-stm32mp25.c             | 1876 +++++++++++++++++
 drivers/clk/stm32/reset-stm32.c               |   59 +-
 drivers/clk/stm32/reset-stm32.h               |    7 +
 drivers/clk/stm32/stm32mp25_rcc.h             |  712 +++++++
 include/dt-bindings/reset/st,stm32mp25-rcc.h  |    2 +-
 12 files changed, 2923 insertions(+), 142 deletions(-)
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h

-- 
2.25.1



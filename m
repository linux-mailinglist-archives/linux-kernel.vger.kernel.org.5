Return-Path: <linux-kernel+bounces-865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFC814737
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D6F1C2325C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7225108;
	Fri, 15 Dec 2023 11:45:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BE2555B;
	Fri, 15 Dec 2023 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BFBg8l2006898;
	Fri, 15 Dec 2023 19:42:08 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ss6c337Vlz2PDtHV;
	Fri, 15 Dec 2023 19:36:03 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 15 Dec
 2023 19:42:07 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V2 0/3] clk: sprd: Add reset controller driver for ums512
Date: Fri, 15 Dec 2023 19:41:26 +0800
Message-ID: <20231215114129.11313-1-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 3BFBg8l2006898

From: "zhifeng.tang" <zhifeng.tang@unisoc.com>

Add reset controller driver for ums512,The reset register has 
the same base address as the gate register.

Changes in v2:
  - The binding files are combined into one patch

zhifeng.tang (3):
  dt-bindings: reset: Add reset controller bindings for Unisoc's ums512
  clk: sprd: Add reset controller driver for ums512
  arm64: dts: sprd: Add reset controller driver for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |   3 +
 arch/arm64/boot/dts/sprd/ums512.dtsi          |   9 +
 drivers/clk/sprd/Makefile                     |   1 +
 drivers/clk/sprd/common.c                     |   1 +
 drivers/clk/sprd/common.h                     |   2 +
 drivers/clk/sprd/reset.c                      |  78 ++++++
 drivers/clk/sprd/reset.h                      |  30 +++
 drivers/clk/sprd/ums512-clk.c                 | 240 ++++++++++++++++++
 include/dt-bindings/reset/sprd,ums512-reset.h | 203 +++++++++++++++
 9 files changed, 567 insertions(+)
 create mode 100644 drivers/clk/sprd/reset.c
 create mode 100644 drivers/clk/sprd/reset.h
 create mode 100644 include/dt-bindings/reset/sprd,ums512-reset.h

-- 
2.17.1



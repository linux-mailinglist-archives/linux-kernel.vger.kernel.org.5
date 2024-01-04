Return-Path: <linux-kernel+bounces-16307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFD823C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7505A1F25E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8E01F60C;
	Thu,  4 Jan 2024 07:22:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E51DFE5;
	Thu,  4 Jan 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4047M60j002224;
	Thu, 4 Jan 2024 15:22:06 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T5Ht14l0yz2QdFD2;
	Thu,  4 Jan 2024 15:15:21 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 15:22:03 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 0/3] Add UMS9620 clocks driver and bindings
Date: Thu, 4 Jan 2024 15:21:45 +0800
Message-ID: <20240104072148.1619009-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4047M60j002224

Add UMS9620 clock driver and update clock bindings for UMS9620.

V2:
- Fixed compile warnings reported by kernel test robot <lkp@intel.com>.

Chunyan Zhang (3):
  dt-bindings: clk: sprd: Add UMS9620 support
  clk: sprd: Add dt-bindings include file for UMS9620
  clk: sprd: add support for UMS9620

 .../bindings/clock/sprd,ums512-clk.yaml       |   79 +-
 drivers/clk/sprd/Kconfig                      |    9 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums9620-clk.c                | 3120 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums9620-clk.h  |  515 +++
 5 files changed, 3713 insertions(+), 11 deletions(-)
 create mode 100644 drivers/clk/sprd/ums9620-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums9620-clk.h

-- 
2.41.0



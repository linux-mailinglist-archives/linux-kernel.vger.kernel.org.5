Return-Path: <linux-kernel+bounces-647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE12814401
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3591F233BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CDC171A6;
	Fri, 15 Dec 2023 08:57:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5D16404
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BF8uafa026141;
	Fri, 15 Dec 2023 16:56:36 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ss2x308ffz2PfFhY;
	Fri, 15 Dec 2023 16:50:30 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 15 Dec
 2023 16:56:34 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add DTS and bindings for Unisoc's UMS9620
Date: Fri, 15 Dec 2023 16:56:26 +0800
Message-ID: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 3BF8uafa026141

Add a basic DTS for UMS9620 SoC and UMS9620-2H10 board, with this patchset
the board can run into console.

Chunyan Zhang (4):
  dt-bindings: mfd: sprd: Add support for UMS9620
  dt-bindings: arm: Add compatible strings for Unisoc's UMS9620
  dt-bindings: serial: Add a new compatible string for UMS9620
  arm64: dts: sprd: Add support for Unisoc's UMS9620

 .../devicetree/bindings/arm/sprd/sprd.yaml    |   5 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   4 +-
 .../devicetree/bindings/serial/sprd-uart.yaml |   1 +
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/ums9620-2h10.dts     |  38 +++
 arch/arm64/boot/dts/sprd/ums9620.dtsi         | 247 ++++++++++++++++++
 6 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620-2h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums9620.dtsi

-- 
2.41.0



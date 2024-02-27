Return-Path: <linux-kernel+bounces-83745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C25869DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BD1F23918
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AE4F5FD;
	Tue, 27 Feb 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Kltus1ML"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F84EB4F;
	Tue, 27 Feb 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055559; cv=none; b=LCHUKl4iyF4ZOHjuypukqy7oV/XT5vSG/aVT2QGXv2Et3vquiP0d2O9tW/oai9EnRAdOt5EYIkLG7utX1pVPmocNCA3vfaAYimsOnmCrGIIAPfb/AiRSgNifRO7ImstWflK8iyygvXL2xRgM/Ly0rm47+j2y+xGmVU9QQQQm+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055559; c=relaxed/simple;
	bh=gKPmQTh5KOy0eWYjaolje3xhtYBIWvYAwj9C5as56Dg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jL3WUOoyUDnU1S39qNatlOjqmBRnhys2IDxGhNsDckCeNIaGJmzyWZT2zDl9A+WB45wH6+/hdQVMvCOBCIAhK+wEAPX8N+B8HvC53SzozQYNSZsCGMgrh5hFqKrSmHGePsfyDmkpfaVpusaxoE4ZQoj/sm32ezLL9G2sC6hU/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Kltus1ML; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiGf2022677;
	Tue, 27 Feb 2024 18:38:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=vv7xjnx
	3S8lRZ/RtrOHHgb66VqkumPKVgXrCY0yTp0k=; b=Kltus1ML//jRWONW930Dvyl
	M2OQWMQ+qoVnp9pisuMzLU8kmx9Vp/gsJrhM33MmzFLZknFkYpk1cypDE4BudfaN
	LcRbFl28niKIBTEERV7NHwXdspuDXR6H3ZQdActZVOEyzhC0iAmXjIm4K8Wg/azj
	bPf7aC5nlei2eOSLomgpHIG8thdvZDec7hymLi93UoboXa8h+0MDiFzYgn2HTiQt
	VxDKZyJBej2ZyDjUOhrLTbwCyRsGt7bzEDHZZA3APH4oNr1ktLM7E/Hwd9X3Vv3S
	WHTUC3ZrKZ1/41QPLE5A18mO0A0+TiSwVXppsbiye8UqW/cAMJZqAOW50tF3Ycg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4csbf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:38:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6BFF640045;
	Tue, 27 Feb 2024 18:38:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3B742AD12D;
	Tue, 27 Feb 2024 18:38:17 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:38:15 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/11] counter: Add stm32 timer events support
Date: Tue, 27 Feb 2024 18:37:52 +0100
Message-ID: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02

Improves the stm32 timer counter driver by introducing new signals,
e.g. counting frequency, and missing channels.

It also adds support for interrupt based events using the chrdev interface.
Two event types are added in this series: overflows and capture.

Up to now, stm32 timer counter driver focused mainly on quadrature
encoder feature on channel 1 & 2. It was limited to timers that has
the HW quadrature encoder.

With this series, all timer instances can be enabled for:
- Quadrature encoder on channel 1 and channel 2 (when supported in HW)
- Simple counting on internal clock
- Capture counter value when rising and falling edges are observed at
  channel 1 to channel 4 input (number of channels varies depending on
  the timer instance used)
- Push overflow and/or capture events through the chardev interface

Changes in v4:
- Introduce new COUNTER_COMP_FREQUENCY() macro
- Mainly update two last patchs, to address William's review comments
  (details in each patch)

Changes in V3:
- This series has been split [1] and renamed.
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
- Watch events tool patch applied, hence dropped from this series
- Refactor / split several patches
- Keep original signals order, to avoid breaking existing user space
- Don't adjust number of signals: adopt static configuration. rely on
  error mechanism to manage diversity across STM32 Timers instances.

Changes in v2:
- counter fix and improvement patch applied, hence dropped in v2 series
- mfd patch applied, hence dropped in v2 series
- revisit watch events tool (mainly command line interface)
- add one patch to rename STM32 Timer counter
- various review comments from v1

Fabrice Gasnier (11):
  counter: Introduce the COUNTER_COMP_FREQUENCY() macro
  counter: stm32-timer-cnt: rename quadrature signal
  counter: stm32-timer-cnt: rename counter
  counter: stm32-timer-cnt: adopt signal definitions
  counter: stm32-timer-cnt: introduce clock signal
  counter: stm32-timer-cnt: add counter prescaler extension
  counter: stm32-timer-cnt: add checks on quadrature encoder capability
  counter: stm32-timer-cnt: introduce channels
  counter: stm32-timer-cnt: probe number of channels from registers
  counter: stm32-timer-cnt: add support for overflow events
  counter: stm32-timer-cnt: add support for capture events

 drivers/counter/stm32-timer-cnt.c | 461 +++++++++++++++++++++++++++++-
 include/linux/counter.h           |   3 +
 include/linux/mfd/stm32-timers.h  |  13 +
 3 files changed, 463 insertions(+), 14 deletions(-)

-- 
2.25.1



Return-Path: <linux-kernel+bounces-151667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B18AB1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A811F22E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044412FF73;
	Fri, 19 Apr 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gF1/pnP7"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96A12AAF4;
	Fri, 19 Apr 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540562; cv=none; b=KzeUHU1MqstvLUodAQzxAoo4k3D5NPA5pN+yWmD83JjAslpftOaDF5TnUJD5Chd3J6BVFc2rL63iwqElp5loSe1enP6INQj26Bu/OC6LBAGhUZlVzhFAXAf3L2bWcfjrgnfqAHiT73unpIbsUdZlFgb+GJ/U4IC2EfTGlj4Tlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540562; c=relaxed/simple;
	bh=36ym3FNp+EwbDRMoVF7bYwlv9S4ZRA9nVXv5N6DtNjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKl5ot1ity4tJHqlY2vNI9nm/tygm53jaovpbE4qLilbEca3IArfVoLXzjNd+3EUNabTRDVKUsisqkcj2Rq/D9yHpDlS9U24MiEOtLaWjqQIHsbS0IqDO4dqvD0FYFrm7MpHcLUK+0I4lMoCZsOTE2gvod0v5HlqXTXxp+zqzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gF1/pnP7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JEkaek032318;
	Fri, 19 Apr 2024 17:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=sT9qlm8
	Vo8N7LFXF3kZTIfAN4NmsL6mJS+Lg4I00mhE=; b=gF1/pnP7esMIgSH1/I1GqEb
	aOn5HCDtnwGDlPwxtS3HYnmjOhHPSWqE21ZPb+KIDFN86czzjx7CeuSkr07fzrnN
	FftuP1IadIo/c3qWdmnkYWzamakg0BJK1QBRcrM9V5yidLGMCda8LP3NzeRYMUox
	L/UrnDmNkvsBf2rnMtyL28D2FTStAFSHnRSfNsrhOZavtqKIaRdIpFk2zzfRrraM
	IwMUBrj4AeMdFOe2HThM51cvvp+QZfIdLx+vCrrWysOmrnSlNKbOGOuhWR6a5cil
	1KByS4aq+9yyyJj8eC2qjirA3F1fD8Emr4dG0bxjWf+Jr7uysJ+1GYy7yggLcWw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecys4kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:28:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7766B40044;
	Fri, 19 Apr 2024 17:28:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D97122367A;
	Fri, 19 Apr 2024 17:27:53 +0200 (CEST)
Received: from localhost (10.252.27.3) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 17:27:52 +0200
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
Subject: [PATCH 0/4] Use STM32 access controller for STM32MP25 clocks
Date: Fri, 19 Apr 2024 17:27:19 +0200
Message-ID: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use an STM32 access controller to filter the registration of clocks.
Don't register a clock if this clock is secured or declared as shared (this
clock is generally managed by the security world).

Gabriel Fernandez (4):
  dt-bindings: clocks: stm32mp25: add access-controllers description
  clk: stm32mp2: use of STM32 access controller
  clk: stm32mp25: add security clocks
  arm64: dts: st: add rcc support for STM32MP25

 .../bindings/clock/st,stm32mp25-rcc.yaml      |   4 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 145 +++--
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |   4 +-
 drivers/clk/stm32/clk-stm32-core.c            |   2 +-
 drivers/clk/stm32/clk-stm32-core.h            |   2 +-
 drivers/clk/stm32/clk-stm32mp13.c             |   2 +-
 drivers/clk/stm32/clk-stm32mp25.c             | 509 +++++++++++-------
 7 files changed, 432 insertions(+), 236 deletions(-)

-- 
2.25.1



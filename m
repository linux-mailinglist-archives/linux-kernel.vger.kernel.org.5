Return-Path: <linux-kernel+bounces-160206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD58B3A98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6781F238AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94520148FED;
	Fri, 26 Apr 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xr8vjMSk"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABE1E504;
	Fri, 26 Apr 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143993; cv=none; b=G1thVUR5fDiOqg+Yd92MU5DBYiRZgRcR2ihMclQ3IPgQdmJjFgMzqSkKoeCiGrdEeFGc8Wqx0BsBD6g/Y5eMUR0ffcI4Wf1bm2nGOzo5oT8KPufSSZphoWvTwyqzc/8FHPWnKlGcvS7sG4CZDGxym39yDnvJZyJcI1EGBzOkE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143993; c=relaxed/simple;
	bh=sEtypbArG4SiU/AUEn52RhRKG31JlSlAuh3Zf62iJj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXBZi8O9Kqu0/AcFd1QJTXdYOaw5w1jU5F+cJzsIbcJ9CfREcHhvo3ZdBhOuEYPmPKXTCjofVKx2EDsfjAxRfkSojs9asEtLnNP5yvp0e3llYI5L2YKsoddVEJDzuO6uOLEyBymAFQf/E5Fb2SPrqNZuZpZFIve/b5Ma3eIZwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xr8vjMSk; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDJ35s019021;
	Fri, 26 Apr 2024 17:06:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=E0FfjvT
	J8EE6qRQgLPxGMJaY0peaJk9VEhJQyyJY68Q=; b=xr8vjMSkI1DmVxH77Q7w0MY
	W8weouV37KhjwgCNXfmHg98/70P50O9PlLeVbWdJe5+j4y1zb3yKDfkXC7/IDG7U
	szkqb+ArzbTzCrDjA9GqSUV7EqOgC1+Uxxwwtnmb4fcU9XgaVMVGUmqof1N1zGsU
	Yy7f+PKF9lxDLZhKJIKBPRwWTwdc97r0taMeTyAR1tBlCQEjOiIw4LluyFJftyh7
	ORpzGthicfK0tupWftzkdUWEkvxoaIrC88EmCMaYkv4msd3Uu/ChLGPSx9QFL1cL
	SHuyVRP34/wyKHgr0uMd+0SFJxl12e/x24dsjdJPCO4sYp2yWfE3UYctY4udEGA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cnu1xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 17:06:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6B7E340045;
	Fri, 26 Apr 2024 17:06:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09554227EFC;
	Fri, 26 Apr 2024 17:05:35 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 17:05:34 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Alain Volmat <alain.volmat@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ARM: dts: stm32: enable camera on stm32mp135f-dk
Date: Fri, 26 Apr 2024 17:05:23 +0200
Message-ID: <20240426150526.3094607-1-alain.volmat@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

This serie enable the camera on the stm32mp135f-dk board.
It adds pinctrl configuration for dcmipp parallel input and add
gc2145/st-mipid02/dcmipp nodes within stm32mp135f-dk.dts

Alain Volmat (2):
  ARM: dts: stm32: add DCMIPP pinctrl on STM32MP13x SoC family
  ARM: dts: stm32: enable camera support on stm32mp135f-dk board

 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 33 ++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 87 +++++++++++++++++++++
 2 files changed, 120 insertions(+)

-- 
2.34.1



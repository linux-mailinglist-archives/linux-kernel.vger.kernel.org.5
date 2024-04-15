Return-Path: <linux-kernel+bounces-144680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9D8A4920
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC761C2222D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570ED2575F;
	Mon, 15 Apr 2024 07:35:38 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7ED2C1A7;
	Mon, 15 Apr 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166537; cv=none; b=TKRYZkvSaro6oHOLWLuNhYFY0/HgZKBZd52nb8BvLI144ZtTpNh9ev5/sle4eBbq8vionf6JO15Pfj1CSv1z9Mh1U4uwWzyyYpgVzYgfPZRaGvNDpBQsskBYNR+sg8J36T3WSIW2SbguQ01RyBUfd6410LcHcPJLWFt7x3t0W0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166537; c=relaxed/simple;
	bh=TVphkgPIbaKZ9UblBuJEkcSWMubdmdRr+kaRCEvWeqI=;
	h=From:To:Subject:Date:Message-Id; b=T3u9Go4YF3ofatr8wfASSG+nZr+unpkpiGh3T56XMVgPbA63B8DJyojmsqznxtRQkh8HuQm6HikZvlXHV7/+CQUgTXHI93w/qa6D0xsNxyAURxqs8pb2BsLwImHMOYjOj/Rm2PW8gtXTe29Uvqp/Zet4i5VKNOxiAevN+CS0PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F7172001C5;
	Mon, 15 Apr 2024 09:35:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCAFA2001C4;
	Mon, 15 Apr 2024 09:35:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DF879183ACAF;
	Mon, 15 Apr 2024 15:35:26 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] ASoC: fsl-asoc-card: add wm8904 codec support
Date: Mon, 15 Apr 2024 15:17:34 +0800
Message-Id: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

add wm8904 codec support in fsl-asoc-card.

Shengjiu Wang (2):
  ASoC: fsl-asoc-card: add wm8904 codec support
  ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904
    codec

 .../devicetree/bindings/sound/fsl-asoc-card.yaml          | 1 +
 sound/soc/fsl/fsl-asoc-card.c                             | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.34.1



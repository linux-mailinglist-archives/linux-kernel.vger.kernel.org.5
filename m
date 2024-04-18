Return-Path: <linux-kernel+bounces-149384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE58D8A9071
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0528232C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399C374D1;
	Thu, 18 Apr 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rxor/uoU"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4F4C99;
	Thu, 18 Apr 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402870; cv=none; b=DGJZCmI8T31X8PbMWG3m7QbdwU2mH6094jd9XZ1rwlWSd1NNHDfnxU2W/sphxQugPkorvj/keB4i127w3+Px73gDnTRoLOHIxBvcouIa5ofEy7LMGzUPo8JA0DrUVMydzyylfQU40s34ljeWHeAxH8iqeU5qEZDrtPPiuZjfSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402870; c=relaxed/simple;
	bh=k7MvKnXqya45kLcJKWNtNiuNrNq9vFwjKwSGjbbduKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srwhOLZMjjVgOdVsmq3DwDL3k3v3SefFuwO3W/kKyRPp76UkfvAdjbEhyleEBEKM3e17GnQjVCr2QWBcMtlzALvbeWpLfIgKd3/cfkivPA2ig0ljBQEuPHNAaIbzLMgRXJTkgyzaoocZJB3I3hCKThdKMjIzXdf6s7srAlV2HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rxor/uoU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIeDPa014942;
	Wed, 17 Apr 2024 18:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=AbRwsBAI5QJ6NZ9kn6oGIUcjLSvAYsoGbWYrtgLSLAI=; b=Rxo
	r/uoU/89YmZx0F0tPj6kto0TyHIo/ux/IjFX6KI9HK7NjkWWQdtxL91+HhpfUIfg
	Eyin5Qyvk7YqjQHMM5TyQTFg5gAV4+TAuY8akJCbZeYT7b4iEX+rGNShc9YTOmNH
	SBwLlg3eSx0bgKikpV/9FnBbuG85Y149W9ykz1fGV35N9FJW/BNdKN3KewdyGho3
	qNvNuzYEFgNJrPXU1S7TaH5iNToCUSCCw6Pe/xMiPKL6cM3v3Ct+940XmP48xqPl
	KMIUSYFZmJfDW8wsl5P8eIjt+PPrslfz0LKPPgzEiWP+d3QBlx6Y03pYdnb6NWZ1
	nyb7t3U7kifRcvJcizw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xjkw694v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 18:14:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 18:14:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 18:14:11 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 63BFB3F7070;
	Wed, 17 Apr 2024 18:14:11 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v3 0/5] Marvell HW overlay support for Cadence xSPI
Date: Wed, 17 Apr 2024 18:13:47 -0700
Message-ID: <20240418011353.1764672-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329194849.25554-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: prOxLNbeL3L_NKPEKwy5dN1bbsVa3OqU
X-Proofpoint-ORIG-GUID: prOxLNbeL3L_NKPEKwy5dN1bbsVa3OqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02

This patch series is adding support for second version of Marvell HW
overlay for Cadence xSPI IP block.
Overlay extends xSPI features, with clock configuration, interrupt
masking and full-duplex, variable length SPI operations.
All that functionalites allows xSPI block to operate not only with
memory devices, but also with simple SPI devices, or TPM devices.

Piyush Malgujar (1):
  spi: cadence: Allow to read basic xSPI configuration from ACPI

Witold Sadowski (4):
  spi: cadence: Ensure data lines set to low during dummy-cycle period
  spi: cadence: Add MRVL overlay bindings documentation for Cadence XSPI
  spi: cadence: Add Marvell xSPI IP overlay changes
  spi: cadence: Add MRVL overlay xfer operation support

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  92 ++-
 drivers/spi/spi-cadence-xspi.c                | 691 +++++++++++++++++-
 2 files changed, 762 insertions(+), 21 deletions(-)

-- 
2.43.0



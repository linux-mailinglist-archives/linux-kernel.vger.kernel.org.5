Return-Path: <linux-kernel+bounces-125355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A8892480
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9A283537
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C03813AD23;
	Fri, 29 Mar 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hKyZjr2W"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7B320B;
	Fri, 29 Mar 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741747; cv=none; b=ekqpB93QUxDP+/j8XVLsEtbien47yLsWHy+E8l/nHT8K77nJyoGGZyZk+bskmb+Ysd2jTz1UBoYFbdj02PU2Fby0E3N46E2U5y+kJpRiXJiXw1BQWDe7D4+aZM8XUoUMIOgFY7f7siDT3wipc/lP7BaY/KG2uX7R33S4EZwPdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741747; c=relaxed/simple;
	bh=jUOc3STXmxZAYuCEU6pzgbs0cfdWm5uqQzFxzImd+I4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzoXq48GNw1U6FYC0qYzXy+3db4ciWndneXfx9YgUKzvAEkwOdrXzJAHH2WsG4uM8YMXUXQ/jhziY0jWbbpxyBM5iXG+spfVdksN9DP0cdJMGrwyeUxQYQTCkRmgC/LrlYSwbCAwcelgAs+HpTf581NZSgnLvOyKuK90G/mIEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hKyZjr2W; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TE0VOj014325;
	Fri, 29 Mar 2024 12:49:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=H7/O3IWe
	4xilIhLlEZ6vLeDVNbQaXzvMHEPQKrsnLLE=; b=hKyZjr2WAO9CAdHka+Ys6A+s
	mmvDoX+F3SkE0GoeqVazWuu4+KVPOtyOaR694T1ov76iWhffsR5vAjVhw27LYj9t
	F6fOcwHGHaQr9zFsiWwf1BEA9mUNEhgAlAGPDTbK6CpW3oI/DZGhjW5kRagHX6HA
	Xt/AXebYAq6iHzDNkzkpBWua7SZ1Oet9CrKCpbyneCTTVWwLHpkIaMq2SqMzF0OD
	h/voIGoxwY+0BDIYu+AgG8jPg+ViI6erBeWwX0yF6nUQjOnVA/RLohkUEz8Pu7rb
	wYuTXWkUTvC9bh3bpnlLHf/mD474f7sFcKnVut9b7wb2z1B4v5Ww/uphNCLjDA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x5gm3krpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 12:49:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 12:48:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Mar 2024 12:48:59 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
	by maili.marvell.com (Postfix) with ESMTP id 8CFD63F707F;
	Fri, 29 Mar 2024 12:48:59 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH 0/5] Support for Cadence xSPI Marvell modifications
Date: Fri, 29 Mar 2024 12:48:44 -0700
Message-ID: <20240329194849.25554-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: b2YHB22n1qoQQ1wcJob260CoXSDPlRxB
X-Proofpoint-ORIG-GUID: b2YHB22n1qoQQ1wcJob260CoXSDPlRxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02

This patch series is adding support for additional
Marvell HW overlay build on top of Cadence xSPI IP
It includes:
- Clock and PHY configuration
- ACPI support
- Additional MRVL HW overlay to support tranfer operations

Piyush Malgujar (1):
  driver: spi: cadence: Add ACPI support

Witold Sadowski (4):
  spi: cadence: Add new bindings documentation for Cadence XSPI
  spi: cadence: Add Marvell IP modification changes
  spi: cadence: Force single modebyte
  cadence-xspi: Add xfer capabilities

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  84 ++-
 drivers/spi/spi-cadence-xspi.c                | 675 +++++++++++++++++-
 2 files changed, 738 insertions(+), 21 deletions(-)

-- 
2.17.1



Return-Path: <linux-kernel+bounces-138145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F689ED44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB70B21CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112A13D60F;
	Wed, 10 Apr 2024 08:11:13 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2721C0DD9;
	Wed, 10 Apr 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736672; cv=none; b=G5E/aS9sGUj0/oTC+nOdKQxYilvnWmBh/XwzTzcG70MpAaWmgtVwTBYhFgYyw10Wnka+Xjg/q6aRj1FvUnMXazpYOYvQLHEvv/D/efyHnN/Kj5xfRHizFUVznJPz57u0OVOHSphAET27Vy+a94d8b5XF6TRbC6N9uKtmZHlOvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736672; c=relaxed/simple;
	bh=aDoySUW0f6x8n5i6pbvRD7e32dK1WDjQkjJh3ud7g7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=reGRG3KzO+OsizoIkcRzulvRQofWCuCZVPlKAaTcqmd6u3ZnjRUC4XRe1Ckwo+IvZPDRsL0rD+LvdBqRCy02sGJVGLtSbHJTISYBSd2FccIGKXIOrzfivvpxA0GWQ7CIPyDJFbTJEJPh/80T/Ne71Nfe4IPsMd+7ctvDa/UX7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D517200257;
	Wed, 10 Apr 2024 10:11:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11703200231;
	Wed, 10 Apr 2024 10:11:08 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 169E3183AD25;
	Wed, 10 Apr 2024 16:11:06 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 0/2] Bluetooth: btnxpuart: Update firmware names
Date: Wed, 10 Apr 2024 13:40:46 +0530
Message-Id: <20240410081049.775382-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This patch series updates the BT firmware file names in BTNXPUART
driver, and adds a new optional firmware-name device tree property to
override the firmware file names hardcoded in the driver. This will
allow user to continue using the older firmware files.

This change is necessary as newer firmware releases will have
standardized naming convention aligned across all newer and legacy
chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add firmware-name property
  Bluetooth: btnxpuart: Update firmware names

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  4 +++
 drivers/bluetooth/btnxpuart.c                 | 28 +++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1



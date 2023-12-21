Return-Path: <linux-kernel+bounces-8503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CF81B8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E11F21C53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DD7B3D8;
	Thu, 21 Dec 2023 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUnPxv6Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C374E17;
	Thu, 21 Dec 2023 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166046; x=1734702046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+d1eruEgFzaUZmbFRKZnQX7tcnQVjmv2hkzB5mVXtk=;
  b=eUnPxv6ZmJzJ+ohrKLHdIWcfKcmNKGJ622Kc5dPKYTXphkuEdrcRCT3E
   3YcWZvc1Ltt3wGw85qn+APfrvUKorhr51L3we8XMVrnr6ZZaODOWory73
   4cb6Ri+5aBZOw9zSKL+mbkU+RC1UeZkICsvNO19OXvaRMCmqFxhZHq+rV
   Tyiw0827Gk0eeJ1Ow+J71JhOZj25h0mpN2f46iGJ6x2edMjAfITqjCkUQ
   WdwCRlyZUmLTfM14hbfbgOmRtDTg3cTM5offXJJhghmQP2zXeEaLXdzSj
   CXOWmktDHgrnO1NlYHuz2ZKej6LKgmMEsXRxUPqEZWv3c7k4L+3bSSwE5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9446053"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9446053"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108105158"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108105158"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:40:43 -0800
From: <deepakx.nagaraju@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdavem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Subject: [PATCH v2 0/4] Rename functions and their prototypes and move to common files.
Date: Thu, 21 Dec 2023 21:40:37 +0800
Message-Id: <20231221134041.27104-1-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Hi,
Moving the standard DMA interface for SGDMA and MSGDMA and renaming from
tse_private to dma_private. Moving read-write function prototypes from
altera_tse.h to altera_utils.h. Commonize DMA for upcoming altera Drivers.

Patch1: Removing unneeded assignments.
Patch2: Fixing indentation warnings.
Patch3: Moving read write Function prototypes.
Patch4: Renaming function prototypes.

changelog v2:
* Build issue resolved.

Nagaraju DeepakX (4):
  net: ethernet: altera: remove unneeded assignments
  net: ethernet: altera: fix indentation warnings
  net: ethernet: altera: move read write functions
  net: ethernet: altera: rename functions and their prototypes

 drivers/net/ethernet/altera/Makefile          |   5 +-
 drivers/net/ethernet/altera/altera_eth_dma.c  |  58 ++++
 drivers/net/ethernet/altera/altera_eth_dma.h  | 121 +++++++++
 drivers/net/ethernet/altera/altera_msgdma.c   |  38 +--
 drivers/net/ethernet/altera/altera_msgdma.h   |  28 +-
 drivers/net/ethernet/altera/altera_sgdma.c    | 138 +++++-----
 drivers/net/ethernet/altera/altera_sgdma.h    |  30 +--
 drivers/net/ethernet/altera/altera_tse.h      |  71 +----
 .../net/ethernet/altera/altera_tse_ethtool.c  |   2 +
 drivers/net/ethernet/altera/altera_tse_main.c | 251 +++++++-----------
 drivers/net/ethernet/altera/altera_utils.c    |   1 +
 drivers/net/ethernet/altera/altera_utils.h    |  43 +++
 12 files changed, 447 insertions(+), 339 deletions(-)
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.c
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.h

--
2.26.2



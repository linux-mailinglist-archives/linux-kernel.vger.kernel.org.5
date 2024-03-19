Return-Path: <linux-kernel+bounces-107051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4A87F6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA651F22677
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DB57C6D5;
	Tue, 19 Mar 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1smB/Pz5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23A7C0B2;
	Tue, 19 Mar 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827627; cv=none; b=cjsDzpwSgUpbVP7eIRxQSdEJO+6WrL1qlvSRQ3g19lwRnoZbFmWv9S5r6fyTHoFPeCFJiZ8xqDBzu9uU19TjkSCav74lbGvOnPtmP+JsGQOYNp7zkD3olT4e4Qv8MQIsD4jrlkesLI6MewkuVqG4yjDt/jnosZ3eAK/a6cwyovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827627; c=relaxed/simple;
	bh=h8STsQMndqtQLRxWZ/502ZZ2IGP8EzUZ+KWr5huUdSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGk3uCpsaqqR0aHEwElHlyyijiqAjgljqaLf9aXH5CkzPbfXwX+OhHsYl8ABwX/CY/DYdNVO2Cdh8M6OuNibLkcQNrJcZU7TUtRXUzEiU37iRvTT3lmB1aWG4Sr203hSDcLyrFKrIsH2rFR+LKFiAM9XIk1fuc53dkNw3gKAwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1smB/Pz5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710827625; x=1742363625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h8STsQMndqtQLRxWZ/502ZZ2IGP8EzUZ+KWr5huUdSY=;
  b=1smB/Pz5z3ty8cpF22CLXXStca0yIJOgy1Qsz8ecpLznK9dTyrS8WoFN
   1stUASzv3quubPcxXWRxzGo8xM2N4EPo09PTR2V29QPaoJx0HEoOZyVK7
   NMlrBE3OhS9h8u6KLL846D+bfQT1sJBdjq7jvYqjRgd1GT1wvr7/G9aan
   MNQ8odGVyIECId7KDrpGyyw2BXUCoO724qIDhvd0aTZsgo8ABt7sa7Uk5
   FyRygBfzjkSKMPQf+mtXJ8Js/LsAXJyG+dlfd3JMV1fgHxrZTZDw2wT+k
   jjMUzKQJab9nKtNVZZ4gIik804uMvhYZQa///XPm34gsaTVTpmB8buE8u
   w==;
X-CSE-ConnectionGUID: unQe8ohHTbCZ5NhrklpG1g==
X-CSE-MsgGUID: bgmS1SoqRJaNQXc+N1vVpg==
X-IronPort-AV: E=Sophos;i="6.07,136,1708412400"; 
   d="scan'208";a="17825495"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 22:53:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 22:53:24 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 22:53:21 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V1 0/2] net: lan743x: Fixes for multiple WOL related issues
Date: Tue, 19 Mar 2024 11:21:07 +0530
Message-ID: <20240319055110.764002-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series implement the following fixes:
1. Disable WOL upon resume in order to restore full data path operation
2. Support WOL in MAC even when PHY does not

Change List:
------------
V0 -> V1:
  - Include the missing maintainer's email ids in 'CC list
  - Remove the patch "Address problems with wake option flags configuration
    sequences" from this patch series. Will fix this in next patch series.
  - Variable "data" change from "int" to "unsigned int"
  - Change the "phy does not support WOL" print from netif_info() to
    netif_dbg()

Raju Lakkaraju (2):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: support WOL in MAC even when PHY does not

 .../net/ethernet/microchip/lan743x_ethtool.c  | 14 +++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
 3 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.34.1



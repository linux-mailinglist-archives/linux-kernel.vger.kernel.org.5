Return-Path: <linux-kernel+bounces-120511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BF88D88F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD37A29E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9B2E652;
	Wed, 27 Mar 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="QZ0Gt1fV"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F12D608;
	Wed, 27 Mar 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527334; cv=none; b=NSuapoz444x9pl7fC3vJFOHt5kxaxC93uKcggSCryPLEsHK9LDWolf1Xe37rmx4DHccCwn5UiauHHRwg9S4v/oIF3AoOPXpYgcyhHTMRoUsyUATuw7ZPraSNbPsLhlQunLYMog5mVUVSpv9iD+K8wr7CSvMNNHtikAUc2P9pwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527334; c=relaxed/simple;
	bh=bwTaJYoOBQkF6LmWoVbC5LbrdBob5Fa5c9FLhiT8Iag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZ5Ma71m0/gR/rnLl06jNFBpcRAqDguPhQf7NEdHiKr1OhmDz+mLejMb1nSY5/UaIUzbTLAR1wFBt8AuVYxk1lkFZSug8qH91p8alTBJnbequqIczZF5yUUDa/ZIwL7PBtKKIi3OzrN2En630mxSUUnH50A4chNtCe7W7GXYa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=QZ0Gt1fV; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 7B91460462;
	Wed, 27 Mar 2024 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527330;
	bh=bwTaJYoOBQkF6LmWoVbC5LbrdBob5Fa5c9FLhiT8Iag=;
	h=From:To:Cc:Subject:Date:From;
	b=QZ0Gt1fVE1vAAnvaHYSCVH6b1GhQdms4zbA69UDa+2hyKHAEI31Iu/zmi4Qvcjbkt
	 GAzb2JG4fzjmA2hpQa0KBt9vXDSWbZsJhZZ/Modqw3bM4A/f5Isnpj9Uz/9Kr2LGNd
	 KUM75770M10hhLherPp1GZCe+XgYy4pLhG9JyUCEd4lVhSStt3SNd/wPMArymJTLOU
	 N0nNlYwXNxSm7Ga30k0C6Aj4kDO8d/tWCoxyotV5uy4zpFDbWKIbEruiwU5vLplCOP
	 hbMbqfy8LFZpKVL6hY6BWNJZV9CX4XEBX73H8nmgQtAoIyoOxQNF+Bczkk5cwj+gwg
	 7hU1tSF6X0JSQ==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Updates for ti-sysc interconnect target driver
Date: Wed, 27 Mar 2024 10:15:03 +0200
Message-ID: <20240327081508.36747-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here are few updates for ti-sysc. We were missing copyrights, have one
non-urgent issue on reset handling, and can finally drop all the quirks
related to the legacy use of pm_runtime_irq_safe() for uart and
smartreflex.

Regards,

Tony

Tony Lindgren (5):
  bus: ti-sysc: Move check for no-reset-on-init
  bus: ti-sysc: Add a description and copyrights
  bus: ti-sysc: Drop legacy quirk handling for uarts
  bus: ti-sysc: Drop legacy quirk handling for smartreflex
  bus: ti-sysc: Drop legacy idle quirk handling

 drivers/bus/ti-sysc.c                 | 165 ++++++--------------------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 34 insertions(+), 132 deletions(-)

-- 
2.44.0


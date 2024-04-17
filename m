Return-Path: <linux-kernel+bounces-148624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED88A8537
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDBF1C20B34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F1140360;
	Wed, 17 Apr 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEveFQoX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001913F440
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361755; cv=none; b=KubF0fnESum67u7S1BnXBVWJ0IzlgBvjpKKkboJvbaXtgPpLn9+BLTS7j+ta9e5LHAuf1+8TmZycuPbkXsIIHcZ1GvwYkFs1T2idDHG+pCubUH14x7wNPo69GRoNwpRZgnZBxDzCu7dscT5fL0RgAMZK5aKjD6dGFtQ4jZ1j3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361755; c=relaxed/simple;
	bh=ltyfGUT+Q1+XHGbLf8LZqsmChBW2AZtse+4kwOov8BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJTT2HRhh+rC39vlJYS6aZLVkTM/4USTIWcNb3JntkI8TqTFhreWsnu7Idv64voLhqTiaz2MnuVylZk+BfF4QRjmwN4j1LVjqrSf81lsf0NL83U/VzXc0yfz9IPVS9rJIfnRLBL41HPrTaFJMXfcrXQzW6KIh75EQIhXWef60b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEveFQoX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713361754; x=1744897754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ltyfGUT+Q1+XHGbLf8LZqsmChBW2AZtse+4kwOov8BQ=;
  b=fEveFQoX8oUYTPkv4tlqICkL7yxDXswytD33vLnsgXH5CFPxNu97VLNK
   6Ow5pRT6cn2ckdKVtB/kHJMlqIQGvUSLlDTlviokxdbCXIAxESE4Xj4Jk
   GF1B+DbAwuckGCiZq1N7sB7wxEg8m3b1fvsg7yaIOSeRG8TrUT9FU3hui
   X4O0WoZ/crZISbafBt9dyUYxafd10CC1W/kyCih/aSh2EVY01OI5CK1aK
   F0cGtsIdyHp3FHI84dSAtMpXo+j88Bg445oUJJPiZBdG+2zjnPiu0YAXT
   OpRJboOU1ALqx5ZSj24VMWase5jkQ8v7Y7Zib3j/D8BSl88V7Unv/F6FL
   Q==;
X-CSE-ConnectionGUID: 4Z6pXW6/TnK72y5iGjqcig==
X-CSE-MsgGUID: 2azH8IkPQ4+GZKInvxRnmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20243259"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20243259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:49:13 -0700
X-CSE-ConnectionGUID: 15UkjXbFQ0yniwze6OGHzw==
X-CSE-MsgGUID: lHfY7O6WRHO4OiRM3eJPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23059043"
Received: from molech-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.36])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:49:12 -0700
From: Iwona Winiarska <iwona.winiarska@intel.com>
To: openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH] peci: aspeed: Clear clock_divider value before setting it
Date: Wed, 17 Apr 2024 15:48:49 +0200
Message-ID: <20240417134849.5793-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PECI clock divider is programmed on 10:8 bits of PECI Control register.
Before setting a new value, clear bits read from hardware.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 drivers/peci/controller/peci-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 7fdc25afcf2f..de7046e6b9c4 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -351,6 +351,7 @@ static int clk_aspeed_peci_set_rate(struct clk_hw *hw, unsigned long rate,
 	clk_aspeed_peci_find_div_values(this_rate, &msg_timing, &clk_div_exp);
 
 	val = readl(aspeed_peci->base + ASPEED_PECI_CTRL);
+	val &= ~ASPEED_PECI_CTRL_CLK_DIV_MASK;
 	val |= FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, clk_div_exp);
 	writel(val, aspeed_peci->base + ASPEED_PECI_CTRL);
 
-- 
2.44.0



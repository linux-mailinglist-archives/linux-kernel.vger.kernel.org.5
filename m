Return-Path: <linux-kernel+bounces-61595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD463851408
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83421C22ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3923B2AD;
	Mon, 12 Feb 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EexXGJ1S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2F3A8EA;
	Mon, 12 Feb 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742979; cv=none; b=Tm4e15nhEG0XG3bpJWJPTWXw6fAdF0qyHFIV7g+VZlhvKOg4+gbEJPeCBfVZxXgJVTOxi4Vp2Ag3z+fwdUcXWmhsR4i4AG9CEX0WvIT+DVW6ojRHt4Drw2kZrQOPhrN+TEEY8Pcbkt5t3SL6hy7SAQuPZGUmXQ7/0l+QDzN37ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742979; c=relaxed/simple;
	bh=iXxsS0W5mU5/Io+UvC+pcKSPNr+I3Jfk8yxtNeL8oyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6tP5MP+EvHrVXd3YLpldYy2NCT748XHRs5+A6WWBwno6MrUCQMKdHm0iAMyE/FgLz6/NqQhG2owLnyuAxtGnvkwg2x2JPnQ1HN2acRYlmacY3HlhUGzzxAeLmCZmFrB3qqMxDDBFfFzclzf+yy2C81vnwUB7NaRmCE61OGIw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EexXGJ1S; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742977; x=1739278977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXxsS0W5mU5/Io+UvC+pcKSPNr+I3Jfk8yxtNeL8oyU=;
  b=EexXGJ1SN2RfRPT/soSOyQl4/3XnpM9bmbeB8HHec/k0LrHYY4IrG0Bp
   CLmqVAmdAH9f4zMlC4oV6ReZP1tczO/YFERRl0CmCnorrN8Ai9kUwc4Gg
   UhzTdpu/J38rkNXcr3wx97liIi7aDaMLn1XEJKHyHeL3qQZx4VnlD3STx
   qR/A/bdiBq7fzNK6MKbaglW3OM/U4WV9xvVzmYS/neizORPGBnjvryhlR
   r1mRUXfn6I25XERfUgq121e8HZNlfd8dera5EAJqkfgHRvCTXJ4hlXcrX
   t43gp26tGk0FUVxSd7+haPC0/8CVAph0YLpnRUErH3brFkcrKOxCHHU2n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594839"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594839"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378399"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:52 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5A13B1CAFF;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 54EA81600104; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 4/5] pwm: dwc: simplify error handling
Date: Mon, 12 Feb 2024 18:32:46 +0530
Message-Id: <20240212130247.9985-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212130247.9985-1-raag.jadav@intel.com>
References: <20240212130247.9985-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify error handling in ->probe() function using dev_err_probe() helper
and while at it, drop error codes from the message to prevent duplication.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 6d922afcb20a..56fac8655c7b 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -51,18 +51,14 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	int i, ret;
 
 	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable device\n");
 
 	pci_set_master(pci);
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret) {
-		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
 
 	info = (const struct dwc_pwm_info *)id->driver_data;
 
-- 
2.35.3



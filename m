Return-Path: <linux-kernel+bounces-132377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E48993C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D961C22676
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A65224DC;
	Fri,  5 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwweTE2X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6111B966;
	Fri,  5 Apr 2024 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287517; cv=none; b=U1FSPoYUrSe9KWn2KbILP/U/ANx+V7kHrGgBbYK0+eq9DEdI+JAJ8+Yg7m9a7rQgSULh4OCuzGkLEPZCxWG4zm45E9IHSQOIqYdGsafSWFByFKhwQAcynxfNgsrUU08mCkAJE0JBjVfsQUsjZfWInNZ1VHKJWySSb2eS6Ey7cgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287517; c=relaxed/simple;
	bh=rCiQ3SyTKOCFjc8KT+P1+wtxwhSkGXl8g9I/aRLcpdY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOZ2G0ndQS7bqj1MdRRyxYcYuq3Ysmr0T0OqYU4c0sQ0YpLzsR6qwGzY3pJ8ZKBpWbLSEkWeE+LdJbxTFD+GC+kcvZKTHZlt/xvIlRehxU4mgHpi0k3rry8hnrpaKpTInXe5Rxf/RqwL7/Ai4Udwhv7qR40NZ4V3fjCbIAdDpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwweTE2X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287516; x=1743823516;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rCiQ3SyTKOCFjc8KT+P1+wtxwhSkGXl8g9I/aRLcpdY=;
  b=KwweTE2X+Geu6U6eNJlGS3QiZMOkDT78kBX+pQHO2StXGRNTkttzEqWO
   tpRoR4EM0Xa8C+SB0nJZtaXolp5/iCO1yWMnrYtBNvFrL8+Jm/R7cF/I+
   lhYsQxOQmNKmPmD7knPt0CrDZum/0UAbdKbu/JOWTdbc+8DMq+Ylrt3N4
   zk9Hfia9zKinwBv8fq5OG80LKL3g0ofPyTX/2JnRK4PsZOH/00Um9ojt/
   71nFdpjxA9cyQ+2OTekvfscPbtIr+91hKhNhxQkL7fFoCkoNvWrWwAx2G
   3fXQ1bV0xDeVdXHFYC1Ppkk+/Havlunwrty8fzWgH/EQuyq74XSou+ZTT
   Q==;
X-CSE-ConnectionGUID: jiD5+Dq1S06/xXeBpOlGRA==
X-CSE-MsgGUID: 3jjLHC2OQnCM7aU6m7qq1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112462"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112462"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:13 -0700
X-CSE-ConnectionGUID: j/juyGTySku1f+8X5djD3w==
X-CSE-MsgGUID: Zql7IxtISZanFQYQOA+jrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955982"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:13 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 3/9] platform/x86/intel/sdsi: Add in-band BIOS lock support
Date: Thu,  4 Apr 2024 20:25:01 -0700
Message-Id: <20240405032507.2637311-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per SDSi in-band interface specification, sec titled "BIOS lock for
in-band provisioning", when IB_LOCK bit is set in control qword, the
SDSI agent is only allowed to perform the read flow, but not allowed to
provision license blob or license key. So add check for it in
sdsi_provision().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V3 - no changes

V2 - Move sdsi_ib_locked() check after overflow check

 drivers/platform/x86/intel/sdsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index d80c2dc0ce71..bb3eaf5eb382 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -67,6 +67,7 @@
 #define CTRL_OWNER			GENMASK(5, 4)
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
+#define CTRL_INBAND_LOCK		BIT(32)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -346,6 +347,11 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 	return sdsi_mbox_cmd_read(priv, info, data_size);
 }
 
+static bool sdsi_ib_locked(struct sdsi_priv *priv)
+{
+	return !!FIELD_GET(CTRL_INBAND_LOCK, readq(priv->control_addr));
+}
+
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
@@ -355,6 +361,10 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
 		return -EOVERFLOW;
 
+	/* Make sure In-band lock is not set */
+	if (sdsi_ib_locked(priv))
+		return -EPERM;
+
 	/* Qword aligned message + command qword */
 	info.size = round_up(count, SDSI_SIZE_CMD) + SDSI_SIZE_CMD;
 
-- 
2.34.1



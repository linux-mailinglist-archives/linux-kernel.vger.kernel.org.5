Return-Path: <linux-kernel+bounces-139675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9778A065D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6041C22B85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281813BAED;
	Thu, 11 Apr 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW6Cdytc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40113B5BD;
	Thu, 11 Apr 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804348; cv=none; b=FcE+GxfWJl0AEMnIUIMFUtJCaTAHHMHApL1K9k91F5BxaYMVrIGbqVsKwNADn1w+RQsGlvxKZ+asJn2OZ6VJceNa4dggACQ7/4oEAPulHN+yNnH3qm62ZgfbXSvU17gk1tPxB3+h0JLt9SXWOVqMdWrRMpDBnO9ioonQpik4lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804348; c=relaxed/simple;
	bh=cBTLirTBJBwSxst8wwRMTW3f8qvRaiWv1a8ZNKwqNp0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZavlLqsTO3xO+IZ1FSswM4UBS5Ie5eE46KV/N44BzyWNQtt4xu4234d0Oj8awTyuaMjUk5TqhRUDPye1xOnuNDNFCikRkQAvfXbNHaordGPsS+ZWu2t40rpZPUzsIcowHJyE3NrMPXRvdZSWioXiLt43X/gaUfvkBuz+pcS1zV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW6Cdytc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804347; x=1744340347;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cBTLirTBJBwSxst8wwRMTW3f8qvRaiWv1a8ZNKwqNp0=;
  b=aW6CdytcT3gyxa8dy6zgqG++v1D9SdRISlM5DcLSABhANPnLOh36bk34
   PehOqZUtsPCgudS0QLaZE7hZyZSpM7exHsMXzs2+tQeiFldhZtjOX8xF3
   XC9qjYCkEUasYlTaORhPdB+5yy1rxgmY/CIDCGxXJ56+46l/4chgqlybO
   xDPjDHj0isLfPS1iOiJcfiyA0BEy/stVDwF+XPpddFAAB0jV76eOQLxX3
   dgpcFMOFvCJfdlmI8of7SMt906zX6bgbKcRjX6jvx2kADA/vuJyw0SKuo
   ccw2Vf8zaLVqgiv5m5XDLHnJG+qSy7dDWS/MBUl6GLMMqgKwNoQ+PyJcy
   w==;
X-CSE-ConnectionGUID: TQwuMB2IQI2hf/PsWOvz+Q==
X-CSE-MsgGUID: ENQfLzi1R7qvAt/W497/2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054668"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054668"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
X-CSE-ConnectionGUID: z4+JcSawSua84TQdg5Lc5Q==
X-CSE-MsgGUID: g06Acc3mQGSXG5ngkKcoMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730475"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 3/9] platform/x86/intel/sdsi: Add in-band BIOS lock support
Date: Wed, 10 Apr 2024 19:58:50 -0700
Message-Id: <20240411025856.2782476-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411025856.2782476-1-david.e.box@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
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
V4 - no changes

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



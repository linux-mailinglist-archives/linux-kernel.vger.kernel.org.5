Return-Path: <linux-kernel+bounces-139673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B18A0659
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8761F21DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BC13B792;
	Thu, 11 Apr 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJfYwv6d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7C13B5A4;
	Thu, 11 Apr 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804346; cv=none; b=M5eE2IXzGlH8m9iGM9CawEHd9M1MQ975H2xxlOrNbeCuN0mAx0m1G8C34WXdnpzFT5dXsEeAEfeTG38JjKkQAQCr2+4WebP54czkQ6RVr5eoABYnIboOiaf3PlLYEhh++YNWyZNPGKufszOYCQxLO3XlETEC0YIZQRvg1mXBFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804346; c=relaxed/simple;
	bh=CTPfAf9JLTY1RbU9IHKPYHqPV+9U57SjzkSRNZBIc8c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz9YC1z8jbB3XvoCEKP6/HuiwnuR/ugb5+kDVugv/2NOcGLtk3dNf039kh95GGAdNkxviscLq75Zjnlb0tpyvQik5l9XRWyZMzqtsoJbNXqOstRd95D6GEe2SoOm7exObv2gBRnBYDtTJvAmyvc4dAEwCc4aN4B2p7f34UNmvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJfYwv6d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804346; x=1744340346;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CTPfAf9JLTY1RbU9IHKPYHqPV+9U57SjzkSRNZBIc8c=;
  b=HJfYwv6dy27Vr89xQZuM1ts8kx9DFeZVLXp40+tTeEU+Wu9NYvnWc/nj
   gTiz44M9o0L8VbrgWTLVX9jm2Db+0In0UsGGSEczkWiXhAbN7KyUYVhbi
   bcKYHxiI6L4QhT/xgrweLsSlNEoJffRGjO+nPDpoXI85Py5VpnG5bEwdZ
   QJBzv9/pZBYiYbGANZEEVLX1qftHNJJfcUJyXw7FKzFmfK/MxKkiLYFTD
   LyQYnveoHmrKyleNHNNLnjEbI/U7xPqbBrCUMxo/Vzv/AbOWQ92HhJLIf
   HT41sTbpaQ2AwWVUTQZLqykZLAInlMvH5K6zPSbtKXc6gSavKGsSUgxQe
   Q==;
X-CSE-ConnectionGUID: 4fkEOJBxRfmrNQnk53T+NA==
X-CSE-MsgGUID: X1ABumbPQxqji0CHOVyGWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054663"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054663"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
X-CSE-ConnectionGUID: OVPiTtQgRdKYhz/5s6UUQA==
X-CSE-MsgGUID: jdVyvfjuR3qmnarI3RyIOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730472"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 1/9] platform/x86/intel/sdsi: Set message size during writes
Date: Wed, 10 Apr 2024 19:58:48 -0700
Message-Id: <20240411025856.2782476-2-david.e.box@linux.intel.com>
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

New mailbox commands will support sending multi packet writes and updated
firmware now requires that the message size be written for all commands
along with the packet size. Since the driver doesn't perform writes larger
than the packet size, set the message size to the same value.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V4 - no changes
V3 - no changes
V2 - no changes

 drivers/platform/x86/intel/sdsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 556e7c6dbb05..a70c071de6e2 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
 		  FIELD_PREP(CTRL_READ_WRITE, 1) |
+		  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-- 
2.34.1



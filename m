Return-Path: <linux-kernel+bounces-139650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99E8A05CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB63F1F22ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2764CC0;
	Thu, 11 Apr 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqB0U+hi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F49449
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802284; cv=none; b=adDFPJlQYhS4RTQ/GCUxu866rWZNSZlZusY7J+Je6O6gw9SUYatJ8asWQ9DtqRfUsRTZytOhsCVMZwOZxcX8uUy8WlW5UB2BxDrvjkZ7lbM4Ur4Yo8J3qwABZkRX0Y88BPvO6b2Z//OaRgqRq36/JVKE71cAQFmOf/8mMmwyL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802284; c=relaxed/simple;
	bh=PBtTGg+KxkivwLx5wdmoXtwRB7rw0cHhoIWq7wumrf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6skcrlg97kmPOSjfbwkE+O55hZomjfKAJvJvFOQncepZJ90aXh21Uell/59ZQL/ZHlDF7+sO4m9R9iHF0VlGMD65muFyMAc7PIGS/DxQzlOibLQCuyLo4aCU67wpLJxVvYfo4+ku68qdLyyAtv4Dt7OrUEQp840VUXxl6nzmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqB0U+hi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712802283; x=1744338283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PBtTGg+KxkivwLx5wdmoXtwRB7rw0cHhoIWq7wumrf0=;
  b=fqB0U+hiMe+KdvTklwDBbbnQxEUdfqz3ODPiaq6htO0Mp4QatGT2q1+8
   KaC21xI0aG27vREpDudG3hD5q8kfk/oNu9Vgz7q1AbXe+shiZjfiwJDpP
   +pgIQmkst/MNPpV6RpeUFViM5ztOON2o+cPdFNmgL7cGOSYvaPquSyxA2
   NmnQSzvKGa4Sn6vnFghSZUyDo+UZyFLyqGstXSwxP70AV+V8VuLu+k7hY
   eXAtkcxx7IwSmPdZOWcCWSGlCQkM9ZQiec9X2tAlgqjzAMsLZhCWVY3/d
   jj2Me+8Wemgd2K5isCZDeVH9jeKpqnkGazc19jK55eD6E/+JZWLOEy7Cb
   g==;
X-CSE-ConnectionGUID: e3Fm8PjSTmW59L653bq4Og==
X-CSE-MsgGUID: 1s5R6CMcRnmkTp8o1zi6/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8072124"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8072124"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:24:42 -0700
X-CSE-ConnectionGUID: NfOudVKLQdWbxhPJnaZ6Vw==
X-CSE-MsgGUID: 9KmDHdEjSbaLevZ/g693lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20731921"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:24:42 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v4] virt: tdx-guest: Handle GetQuote request error code
Date: Thu, 11 Apr 2024 02:22:50 +0000
Message-Id: <20240411022250.4091435-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tdx-guest driver marshals quote requests via hypercall to have a
quoting enclave sign attestation evidence about the current state of
the TD. There are 2 possible failures, a transport failure (failure
to communicate with the quoting agent) and payload failure (a failed
quote). The driver only checks the former, update it to consider the
latter payload errors as well.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
Reviewed-by: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * Rebased on top of v6.9-rc1
 * Added Dan's Reviewed-by tag.

Changes since v2:
 * Updated the commit log (Dan)
 * Removed pr_err message.

Changes since v1:
 * Updated the commit log (Kirill)

 drivers/virt/coco/tdx-guest/tdx-guest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..c39f0007958d 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -228,6 +228,11 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 		goto done;
 	}
 
+	if (quote_buf->status != GET_QUOTE_SUCCESS) {
+		ret = -EIO;
+		goto done;
+	}
+
 	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
-- 
2.25.1



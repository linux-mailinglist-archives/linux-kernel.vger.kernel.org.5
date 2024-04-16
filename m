Return-Path: <linux-kernel+bounces-147660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1798A76FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F6E281470
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2D13A24D;
	Tue, 16 Apr 2024 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3RcKL80"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F584E01;
	Tue, 16 Apr 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304022; cv=none; b=SlXKx+XDO4SNtc02euFUKfh6EsVRCxq+IlpSN1gfYgsqgnDPrLEN2PP7VMxvLZvpxLr6DebVDe4z/LGSP5a0PvJxgtn+8PEeaw3kFvG0bBjrZWrfw2DmL5eGqp5Uen9GF65FxGxO0kZ+OJTCuoRLk0qrpIiz/Htys78V6Inw7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304022; c=relaxed/simple;
	bh=AYcLtBXwGHJ1lHYc9yCNHOV9e648ufAKYQk7scG7Fsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hbfu7ryWlM4xSNIixThFo3tmP4KtidgUKTMiLH6yfbf5kZnY0KUnwUyKoflmBTbTWVbDqY8QtDZl17jwR0jTlrn7irzJJavbvpSYi2e6ZPyl1payN1R6VnQWIvoZSwD0TzuMx9K7Kgyke7R524s5co8Z0TQWY01g7mre3fnDKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3RcKL80; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713304021; x=1744840021;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AYcLtBXwGHJ1lHYc9yCNHOV9e648ufAKYQk7scG7Fsg=;
  b=j3RcKL80Bi+5fqQg3GWJ9VIUxF2XqyPKy4rDFLa0Pd3eTxjirZQSK8yA
   lG3/ztJ1cf9GWQmc0O4KwHfDU7DTOT/X/lrvI+Vl4/CxbVCxSpaupzLUF
   +a9gZacwOnF9OLWaeSKvFDiEihtn1qX+PYlsYacD2ylfWTG0vmJ1BVbAt
   fit3OedGbGHNbOifpt+Es2g1GgZ7Su49EeruG9dfM9P5Jm+n+KUrwbumQ
   zmWMuCevzDhV6L6c+JiyfkwZuXdbD1cCgvnDewk8G6KeuSLgjfiL7dtt4
   KqTr8H09Gf/6qbV+z8w+Xp0DbMT22+IzuiY3LV3jeQ0Cx8jkXzCWx38qf
   A==;
X-CSE-ConnectionGUID: MdokQsaNQayuAGeFkLrP+Q==
X-CSE-MsgGUID: 1qCj+0mcTp6+wGeINu+T6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12553099"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12553099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:46:42 -0700
X-CSE-ConnectionGUID: s1a4Z6cJRL2V22y5xiFIww==
X-CSE-MsgGUID: bK9wP8dUQouG4fYcXSLgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22464251"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.14.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:46:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 16 Apr 2024 15:46:18 -0600
Subject: [PATCH v2 3/4] dax/bus.c: Don't use down_write_killable for
 non-user processes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-vv-dax_abi_fixes-v2-3-d5f0c8ec162e@intel.com>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=AYcLtBXwGHJ1lHYc9yCNHOV9e648ufAKYQk7scG7Fsg=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGlyH/eznQ6+pWqQlbF2O3P16ZOcZuv1fx+ODZZUelDJr
 T5/u3xDRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACYyhZfhfx5nV2XyapeCRXr5
 C7ouPGUP+yo0baK3lMaESw9ZzerP/Gdk6De6+NvljPkOrsdnpKX2fTJhWy/MpXC20st3X/aDqPl
 hLAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Change an instance of down_write_killable() to a simple down_write() where
there is no user process that might want to interrupt the operation.

Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 4e04b228b080..db183eb5ce3a 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1542,12 +1542,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dev_dax *dev_dax;
-	int rc;
-
-	rc = down_write_killable(&dax_region_rwsem);
-	if (rc)
-		return ERR_PTR(rc);
 
+	down_write(&dax_region_rwsem);
 	dev_dax = __devm_create_dev_dax(data);
 	up_write(&dax_region_rwsem);
 

-- 
2.44.0



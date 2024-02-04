Return-Path: <linux-kernel+bounces-51565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F124848C93
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E8EB216D5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EB1947D;
	Sun,  4 Feb 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0fSYYtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209F19473;
	Sun,  4 Feb 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039998; cv=none; b=G6uNmpwRxBv+8RJDP4zRPEWUni7BE+hIEn/woURsUMZY8T1ZdXNDuTPXOioQDu/ujmBCvqR8+/Kzq80O5vGT9lEAAetkEu8brOFvcBN9AFVNaEmRQ2XT3Y+5b04yvl6OHDrJvO1Y6ZDHDkQ6oPRw+s911Vp9Bc1zkX2l9VkvAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039998; c=relaxed/simple;
	bh=QYK8Ji2HLdnUjamB2FwcFhgMyE7rE4gdVyWPZdDXkMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QywGu4Fv59dc2pdpNRE7p/wk4ZWGWQUgb7Mz2Na7CWOaPeIvqhmzXauQvZarXfoGCUh2fWtF8nKDu60UHBDae3QiiSoX46YKO7qJa9RnJyIKgLu5A/UzsFOZRybRLPBzFJwlGxdYKoYI9JXp6EnRL2gq0P38LSHyd2SS9SUmbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0fSYYtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DDEC433C7;
	Sun,  4 Feb 2024 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707039998;
	bh=QYK8Ji2HLdnUjamB2FwcFhgMyE7rE4gdVyWPZdDXkMo=;
	h=From:To:Cc:Subject:Date:From;
	b=X0fSYYtEkhbU0H5/sVxw3jaa5pwk5aa5tVnB7pSjzlEHx3MlZJaP0i55A0W8s2ewi
	 I9AHs83/cBnHLnx70+s/VZAtPRjQcIIMP69/cZC34iAw8OO1YG5/Cu9TzzM8EQ4Sbp
	 lXPaqdv4fk3YsvAmnm4oaQ6sZXzJ09lcR7dzQJpIbH5xc+qSCuSJi+M90n+adjGXG4
	 gtt082LSceK+SuBHD+1KHGYsWTtYuIFwAWMcinGNgkhtAWvLER1AXHmJqi3E+u5dMe
	 /WO3EWG3FD2bt3k3lmmL8G5En4nLscCALnuwloKEZp3hoDmowEBR1+j+USFalF6wk1
	 KDy7uSz7YlFew==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
Date: Sun,  4 Feb 2024 18:46:13 +0900
Message-Id: <20240204094613.40687-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
added the config entries for CXL_PMU in drivers/cxl/Kconfig and
drivers/perf/Kconfig, so it can be toggled from multiple locations:

[1] Device Drivers
     -> PCI support
       -> CXL (Compute Expres Link) Devices
         -> CXL Performance Monitoring Unit

[2] Device Drivers
     -> Performance monitor support
       -> CXL Performance Monitoring Unit

This complicates things, and nobody else does this.

I kept the one in drivers/perf/Kconfig because CONFIG_CXL_PMU controls
the compilation of drivers/perf/cxl_pmu.c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/cxl/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..5f3c9c5529b9 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -144,17 +144,4 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
-config CXL_PMU
-	tristate "CXL Performance Monitoring Unit"
-	default CXL_BUS
-	depends on PERF_EVENTS
-	help
-	  Support performance monitoring as defined in CXL rev 3.0
-	  section 13.2: Performance Monitoring. CXL components may have
-	  one or more CXL Performance Monitoring Units (CPMUs).
-
-	  Say 'y/m' to enable a driver that will attach to performance
-	  monitoring units and provide standard perf based interfaces.
-
-	  If unsure say 'm'.
 endif
-- 
2.40.1



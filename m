Return-Path: <linux-kernel+bounces-26953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0B82E874
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE88B224CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831D101E8;
	Tue, 16 Jan 2024 04:12:08 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D079EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134626162"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134626162"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:11:53 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 668B6D9D93
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:51 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CBFFD94BA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1306200983C7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7461E1A015F;
	Tue, 16 Jan 2024 12:11:49 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Subject: [PATCH 01/42] coccinelle: device_attr_show.cocci: update description and warning message
Date: Tue, 16 Jan 2024 12:10:48 +0800
Message-Id: <20240116041129.3937800-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116041129.3937800-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--0.154700-10.000000
X-TMASE-MatchedRID: IFC3LZnGWUf3Ybb8DqkBoAmyVrMCuJ9STFQnI+epPIbAuQ0xDMaXkH4q
	tYI9sRE/w/kunvvd5s1nlNbmTKHyww3mZXbns8PVmIe0I1iNyQyOQOsE4nDCdHzc/BG56XhAcA7
	WCVo6LQWCHEmJAv3UX+zybZtwM2Apr9Xz9yCPONIrUvpNWR2DO30tCKdnhB589yM15V5aWpj6C0
	ePs7A07Yjdp2MG2wysi6yNzaxO813R0YoSnR2PtDxB4surgMm4mkv75gGCnQY8hk4wKydwKTQ/0
	+wkNXa38YbjvKSNI73i1wbJ9QSMPb3T15bjbgCvhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP
	4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Update them according to latest Documentation/filesystems/sysfs.rst.

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index a28dc061653a..a621e9610479 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
 /// From Documentation/filesystems/sysfs.rst:
-///  show() must not use snprintf() when formatting the value to be
-///  returned to user space. If you can guarantee that an overflow
-///  will never happen you can use sprintf() otherwise you must use
-///  scnprintf().
+/// show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+/// the value to be returned to user space.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
@@ -46,10 +44,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit")
 
 @script: python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit")
-- 
2.29.2



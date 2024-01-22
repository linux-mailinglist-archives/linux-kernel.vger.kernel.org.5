Return-Path: <linux-kernel+bounces-32299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73B8359B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54F41C21EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2F1849;
	Mon, 22 Jan 2024 03:28:19 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE415CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894098; cv=none; b=JHIVw9/US4oVMl+n8i+GAfJHqRzKu9/xMUzoNf92y+N8vkIZ84CZg0SWbdRh1GEO9nxPBb0Xve5uuDVMScjw4763Vg5UIwiX4XyVOMgOQlF3dy+d2kbT8sx1jCo1QectNcIeASAzMofasOjyhlLZR3DrsCmZS4U78NdYQ2Jq+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894098; c=relaxed/simple;
	bh=9PmDJxALKqE0jFYqV8RF4USCz8guKSn75GbOoorunrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mbcw5PfyDdKs4qWcv2ym+Iy7n7Tehup0YIjyVG0VdcqGfGTGI9b4+X6AMCPMnSdsLtN/N/oVQabzsC1WlCK/0B1mLId61AGZBK/PQnjrVequibSiRzSyAvg44v5I05LDP/GqlX9H+8Q4lC0ozYWdwFebZoCZUY0qr9F57TPscG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="125607436"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="125607436"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:28:06 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85F3AD9D93
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:28:04 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B530CD4BCE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:28:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 54286E250B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:28:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B6A441A0072;
	Mon, 22 Jan 2024 11:28:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Subject: [PATCH] coccinelle: device_attr_show: Remove useless expression STR
Date: Mon, 22 Jan 2024 11:28:00 +0800
Message-Id: <20240122032800.33026-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28134.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28134.004
X-TMASE-Result: 10--0.455700-10.000000
X-TMASE-MatchedRID: MqppGi75AUV0AdYYTJWxRBFbgtHjUWLy1QQ6Jx/fflaZtziFUn+D+VDO
	mRheGpIyFyzfcBR8wcvmn3xyPJAJoh2P280ZiGmRGYJhRh6ssevRW9GSMIeErpsoi2XrUn/Js98
	n9dYnJNNQSFbL1bvQASdET58jp62SAhVVB5z0sflF+IsnUJfkL1RCd8l/HzOb8aPI9eQYwt4pe8
	xpRQnWIVnW9zbTJCbj37LvzsUFnIDWyJ18TBwTnsDKJLsrHxQRwGC8e6520fKw0PJt06oJaHpaQ
	l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
simplifies the patch case, as a result, STR is no longer needed.

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index 550d1d2fc02a..dfcf9304195f 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
-expression BUF, SZ, FORMAT, STR;
+expression BUF, SZ, FORMAT;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.29.2



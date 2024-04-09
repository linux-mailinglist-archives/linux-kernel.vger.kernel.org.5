Return-Path: <linux-kernel+bounces-137303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786E89E026
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173F21F241F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81113DB8A;
	Tue,  9 Apr 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TP1Z+fos"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492013DBA2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679333; cv=none; b=bsCqDqR+dO2LYP60j994QIMn2LQGE2SIPEf/54V5oIfehH1YCQTqtdnQJ6uFJMAEH1texnr7jzuks3buKPwhxBfdKKMOGy9jC20Bd+yBtS8X5RsibX7gr0AseLJoIVoR9y+GrGdIUoMzqMzCZy/8F6wFxauthXRgjZWAXFKOEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679333; c=relaxed/simple;
	bh=BtY6Rf+hWsZrTY3h3s8J+qLaAvrzTMz+pO7euoVQNqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUTEaxp0bBF32Z99eHaAHzuaMeE1uHGBtQayeYsBQ+XwFy4gWRrmzn69aRRYpj3E/KF712AjWkciVP7HunGDQ3Uf78AYP8pAHEnRXQEWjzqpwPWnPsIeKVuVbVjpRujVgpKAQBegeU/3x7TY8+Q/Jv9mr4WNVLWaj24K8ASMzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TP1Z+fos; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712679332; x=1744215332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtY6Rf+hWsZrTY3h3s8J+qLaAvrzTMz+pO7euoVQNqM=;
  b=TP1Z+fosNqirRpuzUcHPY4V2pGFuQSssTeG30gP6z87+ez61QoGcu1vu
   m6gBoh41CEVNG83Ur0/NLy1BhBvnfleX1iNyfEOaHIYWTHtziNZQcbvCf
   byzj2KcBv8IbasIKOkz1DF8ZsalZ03ywqDU45QBTQFiSmQd9G0yWGm3pg
   XFtPL1WGVJfujXVNlaNtVE2BoD71lgrG+Sgk0G0Q0LcxlRVGoCKZzdar0
   H06Fca0pZ6rYD9v4UPU6Ao3Z1xe+KKbpJX8sJizc0JcqXXgY0zEGHbnBV
   seBbC0IidQ2kvYg6b2Y5T92EeY45R3LAU6ytMlBfBIiK7EDpVVMQjSlti
   g==;
X-CSE-ConnectionGUID: kxRbAjBxQv2vlkiJEllWZA==
X-CSE-MsgGUID: HcCzVPeGS+C8yCpTnwH8ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33409817"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="33409817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093593"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 09:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AAA712E9; Tue,  9 Apr 2024 19:15:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 2/2] auxdisplay: charlcd: Provide a forward declaration
Date: Tue,  9 Apr 2024 19:14:45 +0300
Message-ID: <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there is no compilation error, strictly speaking compiler
should know about used types beforehand. Provide a forward decration
for struct charlcd_ops before using it in struct charlcd.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index eed80063a6d2..4d4287209d04 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -36,6 +36,8 @@ enum charlcd_lines {
 	CHARLCD_LINES_2,
 };
 
+struct charlcd_ops;
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
-- 
2.43.0.rc1.1.gbec44491f096



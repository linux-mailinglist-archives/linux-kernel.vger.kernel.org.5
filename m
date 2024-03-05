Return-Path: <linux-kernel+bounces-92784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3778725F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797B7289388
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB218B04;
	Tue,  5 Mar 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxFjD61T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BB17995;
	Tue,  5 Mar 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660983; cv=none; b=OC9jQVk+9qrt0v3cQTEI/VuCzYyB/WiZNmHoD2cqygWsfvvWe74PzNDPFADZCAzRqIgPs2wn/Ucz6om5mGIKxG/F9E6wIBc7Z4b86Vo4dMkZy7NVDyaD28JWDFj2O/6aWjmb5OQFQvS9wFzXh1O23LTuom42L2DzjjBKXGPwy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660983; c=relaxed/simple;
	bh=1DZsC5+yI7D+7hL4sdGWoG5tYvav/8DJD0BJtC1dNTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT+WNaWxzgaERmAcTT08Peat7uOJPktL4jMSMJ91Pn962L0UzsNx9U4ZzGj94Yf6mVXdDFvZHN/bnAyAckkJl4/F6OZhix95jlK33n4v0CU2jBYE0VDpkOTQBYRU9wP5Q1ZOW4XGdVzpxQTB7P7QqLH25RkHiQlm0KkjUXjzFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxFjD61T; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660982; x=1741196982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DZsC5+yI7D+7hL4sdGWoG5tYvav/8DJD0BJtC1dNTk=;
  b=gxFjD61TOoWRDdhw7/qWW8e19Ba74cJJZmGkdH0USYRzn+hNM6q9jyTv
   XMmYZTllPokdEAJOXo4RplfHWpXGvMcdRPc7cX3nllC6OtXSpy+CWEGwC
   tryLjz7E3z3LKID53jhh12KoX2AeH9KU8/BghMf7L1iOyOy5fY1qjZGAU
   pRCoqQcTq0+nfU0XxBt1JSVklqcRnp1Xqj91HE3DTgziMpE5PWf0P2s4k
   dH/s4NkZ6rconnpZAfoMVy8XUsnTWcOQMJlCStxcchKbkP5fl/gLfWpkF
   7tTWBJnQgd58cnsRP9V+ilEsn9MoMDETrfiCFH/G6zxxHO2mmBUfKX+Kk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092448"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042797"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042797"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5C58A799; Tue,  5 Mar 2024 19:49:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 4/5] media: ir-spi: Remove trailing comma in the terminator entry
Date: Tue,  5 Mar 2024 19:48:29 +0200
Message-ID: <20240305174933.1370708-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing comma in the terminator entry in ID table(s).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/ir-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 19102bdcfd6f..801de3d108cc 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -159,13 +159,13 @@ static int ir_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id ir_spi_of_match[] = {
 	{ .compatible = "ir-spi-led" },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ir_spi_of_match);
 
 static const struct spi_device_id ir_spi_ids[] = {
 	{ "ir-spi-led" },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(spi, ir_spi_ids);
 
-- 
2.43.0.rc1.1.gbec44491f096



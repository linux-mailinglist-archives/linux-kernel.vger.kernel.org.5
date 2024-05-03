Return-Path: <linux-kernel+bounces-167969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C68BB1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6841F2427F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B069158DD6;
	Fri,  3 May 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zkb01Vkp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B3158A28;
	Fri,  3 May 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756788; cv=none; b=sGdid1seeETx0+FvHnALqSSnd+0c0JfH/Vb9ZGvM2Wfbqp5CTR7G2fOpMR9kejHEQVTgQNnhsi3oY5A5IvVVe73UkoLx+0fmdxrQFzhMBQ0JI7oIhrDYlAoRW1SPsl27h2zFyinhawk7IZjs2+eDLHEpfqFIyu/bKG+EnccawHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756788; c=relaxed/simple;
	bh=ApZmymISPHSWnRB5/ENeA8JTBA7ROD/xcdRdMyHymqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXCrWivdNT3dGe7vLIT7WIDerDYt15Q1anZbwNpFNEZL+6stwwPnrP/pwF77g5T0bAo4F2Zg7MusZu9JFx//VyvQ2BRJEe+7ddEHcoc3CBo7qrXXBK2Eh3lNPnuAfAuDNcmbQDTpfl1AKeBAF7EIxjBBEJx0lIt8zebL1/bHd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zkb01Vkp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756787; x=1746292787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApZmymISPHSWnRB5/ENeA8JTBA7ROD/xcdRdMyHymqc=;
  b=Zkb01VkpHHRbUaDI/ugCLF5BEfmF+q2UCqAR/U3p6mPNybZAbvR7mCet
   9sm2Ro523cNWT2hU3mJbK9gJ2vgpWHvVEaxg500jJNDgfGKEAPkAFVVj7
   MT9Pu7EKZRlM0+eMPmzZWFGQt6x/WAIJRqD3UdQVWlxZvnBM4eJ5/x2Nh
   Yf/GjT/2kHwLZz0m/TPk2iGBjIxGxAGo/VEioDPh5XAuRURInOn9QrBKH
   5FWndRUY3uvOv9ljgTXF5Si5sO99ZtjRr14IltcRgNUgxqWeYXj52B6sl
   WiaJ5m+sevvA+oAPfGLp/L0UYmww2DDRJrBHA3jVXIZr1xol58+D4yIS3
   Q==;
X-CSE-ConnectionGUID: Wu6QqbvwR/uQC5OW+RJFmA==
X-CSE-MsgGUID: 3DCICFT/RF+QhiJBktZriQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962114"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: jR5XVg1lR4yM8jR9MMwgVA==
X-CSE-MsgGUID: 8Mih6RDrQ0KulOp7OZRO8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098218"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9F717BDF; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 12/13] serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
Date: Fri,  3 May 2024 20:16:04 +0300
Message-ID: <20240503171917.2921250-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make type of bit parameter and returned one the same in exar_ee_*_bit().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 93d2c8dd3cd8..85085b73706c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -280,7 +280,7 @@ static inline void exar_ee_deselect(struct exar8250 *priv)
 	exar_write_reg(priv, UART_EXAR_REGB, 0x00);
 }
 
-static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
+static inline void exar_ee_write_bit(struct exar8250 *priv, u8 bit)
 {
 	u8 value = UART_EXAR_REGB_EECS;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac



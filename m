Return-Path: <linux-kernel+bounces-166582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14908B9CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6389284D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309E153BFA;
	Thu,  2 May 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTWgcac4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73115380B;
	Thu,  2 May 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661198; cv=none; b=L8mXZev4GMVVNyEbYApdrW8XE9BYw/u/5e4IgjeXE7G0c0LA+OwcSlJmMMtqGVuWoL5+twfDo6Y+33EtqrZoZ22F+MLDm8ZxVt+LRfw+3WY1EJvHZPOd1/bGeBsDUsI4+f7TvTgPwO6DPIqsNsbGNXKhlFDVkN7npp66yVqyOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661198; c=relaxed/simple;
	bh=HwZRHpqXAKSgF7uYpTCL5EyzBalalYcUyQjZhusykaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtXslmTuIJpqFFqKEj9SzX2Mh5aZ3dVeU5Qt9C59rpi9sRxvh7tX/wA3nvh2i1GgESDRP2E/0zPk+m4LE9uHX/NUfXPmGttZZfloSM5yqLX/Gr6jI75vlvGX9tYFPDJOTfFkOoeeX2B8H+Of0TPiOKXuddx7ZyvqajEuJwqlgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTWgcac4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661197; x=1746197197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwZRHpqXAKSgF7uYpTCL5EyzBalalYcUyQjZhusykaw=;
  b=LTWgcac41CsQNVS3lMo+b5fziaOARi3EVnRBKmnAqWqDRz47S5HCn4oq
   6bd+LvYNrCc7fQxqXtBOuq6BCaAxDsqIwQf2Tkv8Yy+SjiGCIfgbj95b/
   iIuvJI5hHgUEPIAETH0a5h3dNEH3AIs0N+3kf4ADitYwNzdd7NhyrXQme
   M/iVn0wZ8Xrq+LkvQLepE0UNsgJBee4v40JmJhcy0Yh1SLGuPCQmBrjdH
   nSslbQhuBOdfmJtzh+hJj8pA0qQ5sQpjzpeLShyv8iyeRDYSgnwBHWlXw
   h1A94gknxSFJCeoK05a/Re+PRffT1C6+bUle9hnUS0AKCn0zoy/DXRz+4
   w==;
X-CSE-ConnectionGUID: idAx8vOhRBex+Ik8jkl+MQ==
X-CSE-MsgGUID: fHTMoC1ST+iVdR7BgahOFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10590806"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10590806"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: AhbXdLd3QNqEqCnADN94yQ==
X-CSE-MsgGUID: gDcM4FSqR+GDYZNbsAVGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31753961"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5254ED5D; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Date: Thu,  2 May 2024 17:44:05 +0300
Message-ID: <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BIT() in exar_ee_read() like other functions do.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 306bc6d7c141..bf3730f4231d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -340,13 +340,13 @@ static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
 	exar_ee_write_bit(priv, 0);
 
 	// Send address to read from
-	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
-		exar_ee_write_bit(priv, (ee_addr & i));
+	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
+		exar_ee_write_bit(priv, ee_addr & BIT(i));
 
 	// Read data 1 bit at a time
 	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
-		data <<= 1;
-		data |= exar_ee_read_bit(priv);
+		if (exar_ee_read_bit(priv))
+			data |= BIT(i);
 	}
 
 	exar_ee_deselect(priv);
-- 
2.43.0.rc1.1336.g36b5255a03ac



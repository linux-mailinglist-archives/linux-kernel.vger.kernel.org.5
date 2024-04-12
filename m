Return-Path: <linux-kernel+bounces-143146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB48A34F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B901285413
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FA14D44D;
	Fri, 12 Apr 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh71hG/c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEC14C587;
	Fri, 12 Apr 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943583; cv=none; b=reQRJ4UJOnm0Ga1knlqwC3rt2iDZ1a4t4o+JPiZ1+NOCzKHaF03j5QSW0jb6MBbwjxZbKO33a2YxhUD2V8fpc2TXnaspRrC8ppCzjY0Jk1PYMkZ6dRpWvMnudmAHv/2y5ywMUDsbOax/ERpQVywlf3p1OW+ygY7j2nV5InyyiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943583; c=relaxed/simple;
	bh=+nDF4mzA3qfuixFkwc6U/sURTYNxPE6F4fsKO8OZGPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3dVTkn6ewTYOk0NlcAl50Db+sjd0k+DIA0n3Q9h4Utih42Ss5DhvA9ABn6OSQk13mA7G+PtA+PJfrPil0zFiRT5afTPDeDXlRREy2WA1wquAzI5+BrpslrPfhmwRSB6TtNj8rJVF6yl4hnUkyUEQKjqz4sdJb3PvTGRTLKOtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh71hG/c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943582; x=1744479582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+nDF4mzA3qfuixFkwc6U/sURTYNxPE6F4fsKO8OZGPQ=;
  b=Uh71hG/cdSwfmJCXPlrtX+6y0Tvin1o9fot1xuuOZbSjvPwRPuF91uSh
   JeJWqLyXnW30bhdwpjq6LAJ9spMMvjauDHlRfQpJfJqzwancQrP+gioag
   eu9hVLvx/Iz9WSMsyyD8ZikkM6JQiK56HxvyTWRapAtbeWLIgF/PqOds7
   fQuLGYpA53SGScy3N0QVXqcp0pP/6Au0aCC1PWIkWQacUX1FKIoyCTAuC
   HaI2q81eqpV8Y88FvFLQ0trmJMBMYUSv5NWAdqS8azl65iqtU82hL5aGG
   risiXG4h+kfmi/FpxT7fyA0D0xy7llZZT3K/PjYB2ApdkY5TEnM9zsN93
   w==;
X-CSE-ConnectionGUID: All1xElWQSKMWTalYv5l1g==
X-CSE-MsgGUID: fG8jMI/MQeOiA8xHRP42uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="11366222"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="11366222"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:39:41 -0700
X-CSE-ConnectionGUID: 88R/a6r7T5ColwXA8APiBQ==
X-CSE-MsgGUID: 9r/m6aWtRxOKWB5KqsCd0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21782593"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 12 Apr 2024 10:39:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1FDC2FF; Fri, 12 Apr 2024 20:39:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Hide a cast in dw8250_serial_inq()
Date: Fri, 12 Apr 2024 20:39:37 +0300
Message-ID: <20240412173937.187442-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw8250_serial_inq() uses unsigned int variable to store 8-bit value.
Due to that it needs a cast which can be avoided by switching to use
u8 instead of unsigned int.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1e81024f8fd3..ba9f4dc4e71d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -185,9 +185,7 @@ static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
 #ifdef CONFIG_64BIT
 static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 {
-	unsigned int value;
-
-	value = (u8)__raw_readq(p->membase + (offset << p->regshift));
+	u8 value = __raw_readq(p->membase + (offset << p->regshift));
 
 	return dw8250_modify_msr(p, offset, value);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac



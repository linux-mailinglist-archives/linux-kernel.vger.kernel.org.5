Return-Path: <linux-kernel+bounces-167959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9D8BB1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9421C2264F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF91158852;
	Fri,  3 May 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIH++ql5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C2157E7D;
	Fri,  3 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756784; cv=none; b=clWYysruTJRmRRkhxvokykliNoF/G+63/wR8iHeZGLdHNJ8XQpBt1i0pN4a2Ct34fsZ2NwwTLTV4EvWxI6RLMbmFkLSIyRMv8y+Ki/AOMKRcVvEhiWI9TeyEVuOvHdGkwqeDjM+d0EOi4vL9BY4okxrgxolJQgRjKBKAKa6LcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756784; c=relaxed/simple;
	bh=gwi0Y1q+5n0D0n3Bzr328+LnxrPKT8VdPbVuxfggMIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Guk/1U5hdT+ka89n2XM1O8JsbQms2UZEPWH1Vqyf0ygQL41zOqEH56kjrPVzgBoXqy0kTJX9I4f3ugONb8PdsIdh+1PsisePQmW+/hSmS0srn5GsLYyYZST+WlvasXSbcvJwugPvYdWPBz8znytc58+tMs5Artj4HmPeTD54c9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIH++ql5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756783; x=1746292783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwi0Y1q+5n0D0n3Bzr328+LnxrPKT8VdPbVuxfggMIE=;
  b=SIH++ql5NCj0Apw62HUP9tvFGjrozyc79XR6q6gRxd9ewxmi3JGOWEQX
   prdrapzg6P0S3m+n9QENNH8xp+Dft9fs6rwIN4qmtM4178EhIvBfvSDF0
   GHvjjfEsPeNDtabyfYbEpqc3fZg27bXXfDVa/C9p5zyHkUHaq68lrHr3L
   1bchKQysrsR67GKZuuMLQUXfhsBOIlIxIn/EIAGHvYkqTT9wwWv/8rwfy
   eXtlXdUTXx7/Y5269c0CEGqNJRv5PFi3AFF1ZYrA7R42Oef+9xEtqdNnZ
   NL1FEdv7563MTZhCp3niCwsvmBXFG7EzkJmcbINf7pVfPX9HJUMr4jmtq
   Q==;
X-CSE-ConnectionGUID: C0F9Cu5nTmuEpBaQd5BA0Q==
X-CSE-MsgGUID: klyF8XKSRjSHE5WatV6Cpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107798"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107798"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:41 -0700
X-CSE-ConnectionGUID: OJhCfnmTTYG9CzazOSfQoA==
X-CSE-MsgGUID: TjjpVU++T9iEpXUJe3DW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415415"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3709A366; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 02/13] serial: 8250_exar: Describe all parameters in kernel doc
Date: Fri,  3 May 2024 20:15:54 +0300
Message-ID: <20240503171917.2921250-3-andriy.shevchenko@linux.intel.com>
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

Kernel doc validator is not happy:

 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17c15x_xr17v25x'
 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_fpga'
 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17v35x'

Add missed descriptions.

Fixes: f7ce07062988 ("serial: exar: add CTI specific setup code")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 9930668610ca..150c4abd92fc 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -715,6 +715,7 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 /**
  * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17v25x
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: Port to get type of
  *
  * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
@@ -807,6 +808,7 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
 /**
  * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: Port to get type of
  *
  * FPGA based cards port types are based on PCI IDs.
@@ -836,6 +838,7 @@ static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
 /**
  * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: port offset
  *
  * CTI XR17V35X based cards have the port types stored in the EEPROM.
-- 
2.43.0.rc1.1336.g36b5255a03ac



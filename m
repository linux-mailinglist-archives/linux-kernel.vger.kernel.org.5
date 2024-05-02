Return-Path: <linux-kernel+bounces-166584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DE8B9CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3761B2260F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76FA15530C;
	Thu,  2 May 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQigFkEW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648A15359D;
	Thu,  2 May 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661199; cv=none; b=jsKJnmFK8IfbBEaJV75mO/0frfDe9iov48vI4UCylzGEOIPgsTG6JcePlwYV31Pe+Qa3K0/mvvN91+VXyjShuTwzpp7yyxkOBfnp0wfCj4SnZApigieCZhQYJ6nt1Ek3iYC1189kedNNzYvGNtZ003a85uZm92BeLYEn8ZlrlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661199; c=relaxed/simple;
	bh=0VpPJMdPe+aSRC95rZ8nfI5XtCmL1qQshMgBSd3OLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjBayxX0uZEFnOcOIdFh1idD3ZE7UFPtxPHShY2UVIU8uKOPefEN1iSJSLWfkEX90oAV7McUfvbQeQzFs946RBE261epykwwI7X8CvIX9E5sPkuZvqnofMf4cgUh6263ShynjiP94kuRTiA1x81ICEQ12bGkpRIaCDpPehecwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQigFkEW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661198; x=1746197198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VpPJMdPe+aSRC95rZ8nfI5XtCmL1qQshMgBSd3OLKA=;
  b=TQigFkEWmlrk5+0gOR0qF17reSu1owWkSkJfspYPEMsiG2LldBbqZ3iy
   +l9TkxjYyf7LmCcvxFoQHn69+3hbSUgGLrybmP7wBcsGEXpelU+swhjVJ
   +uCK/D2x0EmcPtcGj16Sh8KqwoeAVCMfmtgo+CzCRqhqonIQvX0o1UPJn
   XP1HdEqnNl+o6KGSPoX0ACQ6QQ6lHicSb3qK4orsrWTyyVblO0vGA0pmx
   uVr/5eMc7IDQ7wP1RJX2ia9iX8Kf16zqo6v6ee20pbaDNL8XWK7pN3spx
   cTh7pYoRW7Z4saQ8amLWY8So3dZALUXoXT//ycrVrI5lTngdWBBIuh77M
   A==;
X-CSE-ConnectionGUID: E53Lzz/DRYmCj65zm71TWA==
X-CSE-MsgGUID: sM+tYp9pRs+DqSbmhWKCbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306078"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306078"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:34 -0700
X-CSE-ConnectionGUID: pP7p5MdcRnW8B9meZxA4sw==
X-CSE-MsgGUID: lzzrS8VmRkqlzhn1cjUivA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632827"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EA5DE194; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 04/13] serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
Date: Thu,  2 May 2024 17:43:58 +0300
Message-ID: <20240502144626.2716994-5-andriy.shevchenko@linux.intel.com>
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

Use PCI_SUBVENDOR_ID_IBM for subvendor ID instead of vendor one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ab0abc14ecf8..5405a1f463f1 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1752,7 +1752,7 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	PCI_DEVICE_SUB(					\
 		PCI_VENDOR_ID_EXAR,			\
 		PCI_DEVICE_ID_EXAR_##devid,		\
-		PCI_VENDOR_ID_IBM,			\
+		PCI_SUBVENDOR_ID_IBM,			\
 		PCI_SUBDEVICE_ID_IBM_##sdevid), 0, 0,	\
 		(kernel_ulong_t)&bd			\
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac



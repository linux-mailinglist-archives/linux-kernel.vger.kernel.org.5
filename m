Return-Path: <linux-kernel+bounces-166585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1C8B9CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD5FB2211D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709E15532F;
	Thu,  2 May 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3jjlIN6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F8153BCA;
	Thu,  2 May 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661200; cv=none; b=BokSVHhjLk80FffXdj9Eo8P8d4Thlm3di9x1waQUnYcD2u2x/DFZxWzjKe3C+CQPnyBpQGhNtB5zr6VHOBUTFDqhZ36e04R+Y0GFRhVfxCvXgU37+VKuPYesrbBOZ6gjL2HFjgRpxTYFyzxW+b/Oir4+kCY0HvAW66eiux1orVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661200; c=relaxed/simple;
	bh=KxyK8ZGKsiW++U8bXvlHx6KRpe2z/axkKPSBZA7qYtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shIVPV4mOt4ByJL7rE9QfEXAToxKmjQvxSqc59XEgn6gKKfX0k3ahaqVj7bzHNlN9ODzKomuXe5328TGeP3+wf4wlIuXK9SymQqvcqva/dt/ienoSC3rchShuPksaPz0H4KtLy/izhwCxOmSCVfKiNR5xbyPNEYDYM09vqZsIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3jjlIN6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661199; x=1746197199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxyK8ZGKsiW++U8bXvlHx6KRpe2z/axkKPSBZA7qYtk=;
  b=h3jjlIN6lbGFL02iqpdcYbdFIff9IVpBwsdDbLZkITit4nzZsrivbKS3
   aTGcdiL7eOBw1onrt52fCCdysrEPWmdaTB+WvJAVmZUY6rdSqzNNmZVnN
   P7CVpQID2sZMPwCOMuSuea3XrOYFQq9dIUgSjEX740qK4Up3vMtVbZ8qE
   OS7BeWkTdxotKIBzceJjDZp3F9feghpQJlpfoX6Ep1Z9Oq97g+gnGx6/1
   N8hjdFp9XLpVdrOYXM2oc+okKrAOajaApE5JqIqj7MHdyI0zJpY2h3pFw
   qk3CazPVIYcPy8FMR5pI03T9gUkWm6jvswSUvtIvCGaNY7+pgsxIanRTj
   A==;
X-CSE-ConnectionGUID: JWyTZYIgQ56DQj/DU1XFRg==
X-CSE-MsgGUID: 8dRMQNf8SmK7DjrSKfRfog==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10590811"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10590811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: MuZk85TcQr+yqM9qgiA6Cg==
X-CSE-MsgGUID: Yfo8qtO5T3O63GTpzpmeYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31753962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5A44AD79; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 12/13] serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
Date: Thu,  2 May 2024 17:44:06 +0300
Message-ID: <20240502144626.2716994-13-andriy.shevchenko@linux.intel.com>
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

Make type of bit parameter and returned one the same in exar_ee_*_bit().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index bf3730f4231d..6764aaa20df2 100644
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



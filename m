Return-Path: <linux-kernel+bounces-148943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518818A8972
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0986C283BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F51581F0;
	Wed, 17 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1Hti2V+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC1171065;
	Wed, 17 Apr 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373037; cv=none; b=Y16gVsssYHWaQiWB9vf8ZpYi+hpSKXNlgSnQQHpEaIIdFkcjizd8WRmr548cOFydZnqAKVOgffeb731LF2AJbyJhC075ewi6u2iwumrz9TXzZ3ukNXconlmx1jRTF37SBfsPbShlcoJecAPPoM6ZCIoEc36q8SML+Lf+ciR6rm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373037; c=relaxed/simple;
	bh=nnPwhmqR5uv6fWz7NfCdn9lU2POCEtx4qFDnpKF8Gko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGa+aazJlMpbOZ9FA9bNROdeR1Nv+0F3pXIcx6GUZVn56igjxpwQ+fhilLhJIcTN82yz3fJiwbVn+ba/iBidTuhHUbuLOtyh4dxCFnnjJMs5oB4mOM+CRGdxJ29fS36mBgxMED0vV65MCBFGO7EyAthDgum6tkIPqeyFotg46zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1Hti2V+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373036; x=1744909036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nnPwhmqR5uv6fWz7NfCdn9lU2POCEtx4qFDnpKF8Gko=;
  b=c1Hti2V+1yBm44Wi4LS4qMalw4MT9SnYF26QgCkJzGwhHkZP9J7ntYoH
   KRH73iyulQwZv9GGrGVZI3LuxKWfRREyo4+CBvbxj0muKsQivNG1s27KQ
   NDbspphQjSLPwvWGhFh4e8b5VfPl2VeDiOiLgeI4WhCEi6eOVxUoRgHI8
   jfEFHW0D21oVh0VfPYSxIk143EbtMdaL5yjp6nodl11fKHQFp6De1bTbG
   MiDmTsyZFBjg9GkUmWnXODXywVfpbzUysZOaP9m1tiz20anzTkQvUWg02
   pG77NDtKV7doh3wyF38AM4pCwQwEt018bfniAtsIE9l0yV+eDiyM4G6Km
   Q==;
X-CSE-ConnectionGUID: eIOya1voQNiHDdxj9JHpUQ==
X-CSE-MsgGUID: TvYeObRbTxia+WojptR8Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737005"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:15 -0700
X-CSE-ConnectionGUID: HqoFZmTHRpq8oXio9GQFiA==
X-CSE-MsgGUID: 3yg0nCVHTwa5Ro4jN/zkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22571636"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 09:57:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C237E1; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v1 0/5] mmc: atmel-mci: Get rid of leftovers and clean up
Date: Wed, 17 Apr 2024 19:55:12 +0300
Message-ID: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I used to have some patches against the driver, but it appears that part
of it has been applied (in different form as done by someone else).
However, there is still room to improve, hence this spring cleanup series.

Andy Shevchenko (5):
  mmc: atmel-mci: Get rid of platform data leftovers
  mmc: atmel-mci: Use temporary variable for struct device
  mmc: atmel-mci: Replace platform device pointer by generic one
  mmc: atmel-mci: Incapsulate used to be a platform data into host
    structure
  mmc: atmel-mci: Switch to use dev_err_probe()

 drivers/mmc/host/atmel-mci.c | 308 +++++++++++++++--------------------
 1 file changed, 131 insertions(+), 177 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac



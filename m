Return-Path: <linux-kernel+bounces-134826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CA89B785
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AF61C20F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E92FF9E9;
	Mon,  8 Apr 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWwIsZOl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0C7470;
	Mon,  8 Apr 2024 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557036; cv=none; b=uRM7bcd81ZrLY4f43DG9fBJmHucvD6yvAvTfHzhh02h5cPMZxiLXv4Yyakw2/DSDIJUjd2TlBYSaHHuIG6xuv+EkmwhWd8qqryDtfrkspIZDOBzbxvcVf4HigI5BUAUMGdRqSH/GWi40GYacogiocP7WX5bFLwnNgx1mPnS4jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557036; c=relaxed/simple;
	bh=OziQqOlr0jwrXZHS75y+H+NpigCrK3eEQkFJgpX31s8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9zOcz3i5XZqMRhwVqUwRmN4RHd/mnZyfkINdue9Nmy5hdK4yAfqtSHNp7/HSw0i1qT0+DOhDNbMv3zHHvPR8ihNIUwFO40T7cosTbXskCn25PII0V/XYPV56vHKvMyt5949MmiQ6KeUafD1NkVfZlnQ1ipwxoix0Sdq7I5smH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWwIsZOl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712557035; x=1744093035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OziQqOlr0jwrXZHS75y+H+NpigCrK3eEQkFJgpX31s8=;
  b=kWwIsZOl3nXmdUPzuCl4FiyD2AM6rqIBsh01DYACvVG3vUAlPMb4JjlI
   AZxZLs3y4SeicrfYpLqcwilwkKqy4nUw87Q0bET4WQYFlW9cCCjWUFhcD
   0TEkKAVQ5joq2mYDWRH9g3TmoK0+UlHqIXBDX8O7TTGp5AnWuSKa/Gohe
   WaSCw/TQGhh58uvgcLg57uJBxUOxqeiejlroqrhcy1zJQCyLwRfVv3Edn
   JvPpSmr2gwGzD4/rC2l8dd9IZLF7aC3OPVK2iBImeNbCuWt4ajjz938bz
   jEPg8DpSY3vW3NoYIhXabZtpT+jZlHNiXJvWTyLgI7URo4oqCtAcDxGl8
   Q==;
X-CSE-ConnectionGUID: 6n/hSUNpSRSo7Or6vSOsCA==
X-CSE-MsgGUID: r5IzjDzuSpeOtulo307mxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7675326"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7675326"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:14 -0700
X-CSE-ConnectionGUID: k+iup9NeRdGDWb5MrUb8oA==
X-CSE-MsgGUID: xgJWaSzhSV+M+IbFAT+NkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24511953"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: intel_ace2x: fix wakeup handling for LunarLake
Date: Mon,  8 Apr 2024 06:16:41 +0000
Message-Id: <20240408061643.420916-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For LunarLake, the SoundWire in-band wake detection is reported with
the HDAudio WAKE_EN/WAKE_STS registers.

Pierre-Louis Bossart (2):
  soundwire: intel_ace2x: fix wakeup handling
  soundwire: intel_ace2x: simplify check_wake()

 drivers/soundwire/intel_ace2x.c | 43 +++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 16 deletions(-)

-- 
2.34.1



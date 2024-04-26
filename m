Return-Path: <linux-kernel+bounces-159588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C068B30A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50001C211E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A513AA32;
	Fri, 26 Apr 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjC2XAZ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426313A87E;
	Fri, 26 Apr 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113642; cv=none; b=iKlNVBe7xmevsT4gGQqkbNA9TGUDW6IlIwnLbm2YjFSQNPWglSfklFY4zlHlgTreeBIB3xRRSF1v5uUiUCeXq2XvrEIUoFSiLspDR9WhrGpBldqvXMbKTElYfaKR9TsnQvJOP5TVeV2q2pCainBROB5yOwatNrBAmjU54YxJhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113642; c=relaxed/simple;
	bh=OziQqOlr0jwrXZHS75y+H+NpigCrK3eEQkFJgpX31s8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBAgaK2UDnbJDE8MBh9koTInEslrOVcjT5BYAoMMOkbU2MG6zHjENivv4vGx8Ine595KOkNiNkQWrZHGAtXCj0Mod0tj72e7WgW9YvAdfwbXIbmzxuMASL6owtn67dtxBRSIydalStCpnwWj/9zS+xIbaF2Faup3FNWfqcWtXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjC2XAZ4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714113640; x=1745649640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OziQqOlr0jwrXZHS75y+H+NpigCrK3eEQkFJgpX31s8=;
  b=UjC2XAZ4gFDTVOQRNtg56SQ1eH+3zy6waGLHtWDS/UpucGMvPqeWKz7m
   6oLcCYG4SjbSCKEzfFecQtqfZrbV0UYOqtLF4Ha6z6tNy7Yknh9xOJdMo
   w+gjE3lh5BIL4Ce6BiZ6ZxCBA1RFiqEVikS+lL42/neDD7FNTzIe3pcuk
   6107+PG8ea/+nB0nhUZtyYe91WGyDd0KrUp5bTgVqfFQEQfLOkXTA+kLz
   TF6Rvo5ICNw2CbdL2v29IFG6FpFc8pLF/ThUYnunAlMJRkDTQpUVz+CBr
   lL8aCOiz6gcnTv93xGUJDpmLY4vH5r8PoA72cW9FIad+XGekKNFCDPGG4
   g==;
X-CSE-ConnectionGUID: NBmlo7rXSrmoM5X6KjvCdg==
X-CSE-MsgGUID: Lh2ExoFwTbGQvEc98NhV6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20526091"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20526091"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:39 -0700
X-CSE-ConnectionGUID: gw2JqBENSuWS9Pkd9kO+HA==
X-CSE-MsgGUID: I69Ux9lxTOu6LFQNlWKMHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25399048"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND 0/2] soundwire: intel_ace2x: fix wakeup handling for LunarLake
Date: Fri, 26 Apr 2024 06:40:28 +0000
Message-Id: <20240426064030.2305343-1-yung-chuan.liao@linux.intel.com>
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



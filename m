Return-Path: <linux-kernel+bounces-159386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC08B2E02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75F92828C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698657EC;
	Fri, 26 Apr 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvHFTTM6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C759364;
	Fri, 26 Apr 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091277; cv=none; b=oz21Nozi4m4n84VOKq7Els5I6pIQOIK/ImnPGGtNxiakpQe/1JWoNIMi2L4DHra/YfCacVp3EuF6ENDbxOgjWf9NCMZENDhX9OrYq1hBcS7WXyGm9hY23YZ40PTmaKb6eaIjjPM3BAmwQeU52BhTYp2+EmM966l7zKuUk7pC+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091277; c=relaxed/simple;
	bh=9+vyBhz0c7nCsFzvVCaUX48qXAhH3D8lNfBAEfJuX/E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WcSVnw/vqitAACXADEeoHxLNThfOSs/4BPVVNWynQVtR9Oj8nPLrNRxEb6NaKR5sazPBHlcOn+DFkvT43btAwFfNr5iIwCRouvdm9pGou/En8uPmXWVhjoJUZbRjSggT4fQMAwASaH4AmdkmysqwdI2Gl234QTplk71lAZkauRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvHFTTM6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714091276; x=1745627276;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+vyBhz0c7nCsFzvVCaUX48qXAhH3D8lNfBAEfJuX/E=;
  b=ZvHFTTM6axNfFlu4jdciOv3amTJf7u3I52RthF7iCrMIG32lVPRoZYp0
   R5oMIgpku/2MBw4vEyIm5MSYRvhD4y04SC5S6G2QS3W3cpCWILuwOZFvL
   iKxLc61QvLtRGRGZ62MhqBxHMKMWSPZ8MzdMH5o1Hcwve7+GfDiXoZZ8u
   BjEfymEOapZ2axHE8ze6rFaK613rQzbJfM5Bt6z2aJ39ZxLRb0l8LpcJg
   Am9/PcaIJQYKK8q9br/kkpcsP+4EkC9mg1NPGqbIonx2dsD4POCTqFTuW
   /NVsmyzKP3qcF9QVoJXreBdjLPudEUx9+FFVYMUnLaWbUP67xS5BVz7v7
   w==;
X-CSE-ConnectionGUID: eLmLf1RASO+KvrZdHh9iTw==
X-CSE-MsgGUID: 7ymG6WRpTtaq+bDlwaal/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9650237"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9650237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:55 -0700
X-CSE-ConnectionGUID: A6ciTaYtT8yAGfqRQCoaTg==
X-CSE-MsgGUID: UWXpLnNAQNa4n/XeFcTRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25329107"
Received: from breannah-mobl.amr.corp.intel.com (HELO xpardee-test1.hsd1.or.comcast.net) ([10.209.32.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:55 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Show Lunar Lake S0ix blocker counter in PMC Core
Date: Thu, 25 Apr 2024 17:27:49 -0700
Message-Id: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds support to show S0ix blocker counter values
in debugfs and enables it in Lunar Lake platforms.

Xi Pardee (3):
  platform/x86:intel/pmc: Update LNL signal status map
  platform/x86:intel/pmc: Add support to show S0ix blocker counter
  platform/x86:intel/pmc: Enable S0ix blocker show in Lunar Lake

 drivers/platform/x86/intel/pmc/core.c |  38 +++
 drivers/platform/x86/intel/pmc/core.h |   9 +
 drivers/platform/x86/intel/pmc/lnl.c  | 475 ++++++++++++++------------
 3 files changed, 311 insertions(+), 211 deletions(-)

-- 
2.34.1



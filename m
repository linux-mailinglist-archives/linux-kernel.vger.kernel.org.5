Return-Path: <linux-kernel+bounces-163843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DA8B73FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09180281DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ABB12D75C;
	Tue, 30 Apr 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KddEGC3h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6017592;
	Tue, 30 Apr 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476338; cv=none; b=CzeK4k+crOUouXU6TgJwS/aeoZ5ND12ewwHDcGzZ9tqZgxBN/Rf5CalhkK1A0o4YZWoyQK/gtA2iHdVQ78phOAAW7L64G/8h7M1PdfpZWO4kHHWujI8gYSYBgTiGuF/as0gRNgNjJBv/vbNLGZnOtjANzbvauTy2V973Fl8KyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476338; c=relaxed/simple;
	bh=Ju5DL/cXl2Ysb+lg16R6jeISSE7KbwX2aIp1XO1/A4s=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=RQRNAoWRgxnrn5HJKy0HiiA47A+cP5h1zaPuQKwg2FWoitIRx6WTezJOUsXeJjTNOcINZRf4ewV+ehCZYOYaW4Rlj9Jx0Z8QVJgez1PyuOpJyjXsi++P6AkWuINwgXK7JK+fMkJ3v7pAQav6nxn6bv8oHDHWGVnKbl+IP6Tnd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KddEGC3h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714476337; x=1746012337;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ju5DL/cXl2Ysb+lg16R6jeISSE7KbwX2aIp1XO1/A4s=;
  b=KddEGC3hMUdb4tjdlrL8RcOsJi6WB/WOeSoUk9a0mX6ts7vaq0v23A98
   nbMC+yHzF0SeX6QP/xhd+cjK6yV2Msr4CDkU0nmDWL1G+rOPqaJQbyoP+
   onqiQuzixSmyb6lwxZ5aKhq6tyOC36Jmydd70j/O6AP9ZWL7uSY2W7Khi
   d6nkbBOum63NSMukmDkyLfLyqPbSR+0sYld4lXuHME7HKKLXH00iPiIVT
   KY1zqaIJDYSpMQN1+Lrn+UJFCFafO0Pbrrdq3hoKi0Bq/Ns3bCJjk4XkP
   JJxPyABwnO/uzr4DPWyMg3M2EMQGCQThSfsZb8zCVhoa1Y0yHaj63lZmU
   w==;
X-CSE-ConnectionGUID: 0p3w/EFsTaO1jHIHtsLTKg==
X-CSE-MsgGUID: hVyuFfkZSLqe1w+MbESi3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="35565349"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="35565349"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:25:36 -0700
X-CSE-ConnectionGUID: U/caQJ89Qh232zvAS+nNuw==
X-CSE-MsgGUID: Jo8ugeb/TmaCn0bZCFj/yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26445179"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.49])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:25:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Tue, 30 Apr 2024 14:23:34 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.9-4
Message-ID: <pdx86-pr-20240430142334-272144146@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.9.


Regards, i.


The following changes since commit f609e7b1b49e4d15cf107d2069673ee63860c398:

  platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes (2024-04-17 17:05:30 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-4

for you to fetch changes up to 515a3c3a5489a890c7c3c1df3855eb4868a27598:

  platform/x86: ISST: Add Grand Ridge to HPM CPU list (2024-04-29 14:25:29 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.9-4

The following is an automated shortlog grouped by driver:

ISST:
 -  Add Grand Ridge to HPM CPU list

----------------------------------------------------------------
Srinivas Pandruvada (1):
      platform/x86: ISST: Add Grand Ridge to HPM CPU list

 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)


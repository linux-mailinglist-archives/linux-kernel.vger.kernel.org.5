Return-Path: <linux-kernel+bounces-16958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D1824688
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE4E286D06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43825119;
	Thu,  4 Jan 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge5K4PuS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412B250E9;
	Thu,  4 Jan 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704386695; x=1735922695;
  h=from:message-id:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=/DQS4wqv+vvwhHxOf2aClwntwxDonsfP8n12aAK5U0c=;
  b=Ge5K4PuS/dUzvXfAf1cdcGA/kWut8AmDhFE+463NpmgTSACoLii4kBaN
   m6Rb9cj+RbPtIlqhq2wAJ4IxC3VfrxgpFkyDL1zXDBdQPPb9/hA+mG4Ql
   T8sckV0wgUav+Co19yDv9uoHAQfZc6JOQWgDTbvKew6/NlIpBr7z6YM7O
   VwWrVUApL/yiBlN1+XZguj7+EkF9syLKsKO4EJjx+QjDfAho0LthUvrsk
   CDmzOrCdNItCUoTKI/9auTHTxlj5d5Jw7upAcDeULKCKJZKrsn4gMMFG4
   YnGCTHxcSYOc1QIER5MdcGYlol8CJ5lecIaIpB0NSsf9vGW1lACOGePBl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382276291"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="382276291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="814703587"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="814703587"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.230])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:44:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <1a6657ef8475862e4fc282efe832fa86.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 04 Jan 2024 18:32:23 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.7-7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a last minute platform-drivers-x86 fixes PR for v6.7.

Unfortunately the P2SB deadlock fix broke some older HW and we need some
time to figure out the best way to fix the issue so reverting the deadlock
fix for now.

Regards, i.


The following changes since commit 70681aa0746ae61d7668b9f651221fad5e30c71e:

  platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback (2023-12-29 15:31:22 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-7

for you to fetch changes up to b20712e853305cbd04673f02b7e52ba5b12c11a9:

  Revert "platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe" (2024-01-04 18:16:51 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-7

Revert P2SB / PCI deadlock fix due issue with older HW w/o P2SB.

The following is an automated shortlog grouped by driver:

p2sb:
 - Revert: Allow p2sb_bar() calls during PCI device probe

----------------------------------------------------------------
Shin'ichiro Kawasaki (1):
      Revert "platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe"

 drivers/platform/x86/p2sb.c | 172 +++++++++++---------------------------------
 1 file changed, 41 insertions(+), 131 deletions(-)


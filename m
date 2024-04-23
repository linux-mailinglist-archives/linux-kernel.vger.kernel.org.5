Return-Path: <linux-kernel+bounces-155268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A38AE7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4BC28DE02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21C135A6C;
	Tue, 23 Apr 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFDTD8K8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB3135406;
	Tue, 23 Apr 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878430; cv=none; b=VLnfszoQ3YsLZJYiLYvWBW0jqqJR6mWiCLU7i38NdDVojfZIUoayUHCGoT3IfwnCF0YDKG8xMQHTkcldr81epLW7SSFpgSMVI+L1KX6wi2NxIotEUy6C7mTr++IR2J1VqNHkQgY1Sl1CiM87ocU6azQxQFRX0TVKeNLTZDnCPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878430; c=relaxed/simple;
	bh=KToQEQ24M4apaUsqhZmf6UywFUrFoJF7/2LXb/JJ6BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuJGYVPjtwrVE30WUnwsthSWesDVAlEJyJOV7GPs3LEQdDrl8zXSjP7TKNw0qxR2AE7Xr2rYi1At/o0oSnomjQX+FzLPVr7zM5uqmM/RMHHLX0EKtMfpmpI/m2S9JKmaa0LoAqz+JPGNqprZHl2mMrXt4pI2MbofDAsFfY3W1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFDTD8K8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713878429; x=1745414429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KToQEQ24M4apaUsqhZmf6UywFUrFoJF7/2LXb/JJ6BA=;
  b=JFDTD8K8trRSQ4l5Rbf43p/bGazoDkCXCJ3jdiZutN7jxQNYBNLHZ9oh
   nKXzdP8MhbsgKj1jiSjdBZ8SupYwJ8A2j2YcGFaJUQ+pRcbIYqQBT9a+H
   VO4SVekkNBzXbuaZbpBilwbajsRTD7ksLrnr+Cikfbo5Y2bGwvgsejaSb
   F/vZz1VC9+y0gBd1gM6WlOr2EO3ZCszcIA/GTzWRQCLobxVLDh1tuY31B
   ChIOI9gJEnnTr6lOmewmLEOlgKsCkwfTRAPJs0zm78PkOYB34GYCJLfCw
   GrhF/jcqseKvtfcUFKXaKkmQRoO6of7/njRc2u68MV+vGcZ5HxdQjgP47
   g==;
X-CSE-ConnectionGUID: 1yETo01GRdm7CbcDpnjisQ==
X-CSE-MsgGUID: 0LiSeurnS5C2Oqe/pNWZmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9325267"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9325267"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:20:28 -0700
X-CSE-ConnectionGUID: tNH0OMm+QhWOAfxLmDqJbQ==
X-CSE-MsgGUID: 7GDFmkHgSGK6ct/B1OvD0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24815699"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Apr 2024 06:20:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 41E811C5; Tue, 23 Apr 2024 16:20:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 1/2] Documentation: process: Avoid unneeded Cc: tags
Date: Tue, 23 Apr 2024 16:19:37 +0300
Message-ID: <20240423132024.2368662-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note that explains that  Cc: email header is implied by other
tags, such as Reviewed-by:. In this case an explicit Cc: is _not_
needed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/process/5.Posting.rst          | 4 +++-
 Documentation/process/submitting-patches.rst | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index de4edd42d5c0..90a7fe2a85f2 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -267,7 +267,9 @@ The tags in common use are:
    being reported.
 
  - Cc: the named person received a copy of the patch and had the
-   opportunity to comment on it.
+   opportunity to comment on it. Note that other formal tags are automatically
+   converted to the ``Cc:`` email header and you do not need to have an
+   explicit Cc: tag, if the person is already mentioned by another tag.
 
 Be careful in the addition of tags to your patches, as only Cc: is appropriate
 for addition without the explicit permission of the person named; using
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..6775f0698136 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -486,7 +486,10 @@ provided such comments, you may optionally add a ``Cc:`` tag to the patch.
 This is the only tag which might be added without an explicit action by the
 person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
-have been included in the discussion.
+have been included in the discussion. Note that other formal tags are
+automatically converted to the Cc: email header and you do not need to
+have an explicit ``Cc:`` tag, if the person is already mentioned by another
+tag.
 
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
-- 
2.43.0.rc1.1336.g36b5255a03ac



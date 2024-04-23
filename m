Return-Path: <linux-kernel+bounces-155267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B28AE7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FABA28DDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6A135A61;
	Tue, 23 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k85gPVQb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19B745E2;
	Tue, 23 Apr 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878430; cv=none; b=f1/18xkUJtLfxbubS9I+835a30NutUNWVPn7M3qZ6+4Sku4oUDsreHs2qKQs0D7bM3OdH7QsoRDHB8OnQGLSMXx+o1WtwlbWLQc65Yd+8XTsYjp+H/Yfm3b2Jcs9/3107cERMXdQNchTyq3PE3qR9/LcGT2/sWgLoBXGKEKZntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878430; c=relaxed/simple;
	bh=dwxGe68AaFcC3uVyUNsjWLGssrP0iEGQWVADx4GC830=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYWVaRoOXesFPcy3a0uq/O3fT9VpmQcaBRgp2oVQmyRYsMvcdlm0Sm9Pb2yMUdTaVglQNJ1AxG0Y0um0vLX2CEZa18YYWLxA6WkYylNDgKx468SLFkDPxY9jT+EAt973iL8z6Hyl57pdgHYOTLkyLcc9kJ/kNm4qFQyrn9mz9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k85gPVQb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713878429; x=1745414429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwxGe68AaFcC3uVyUNsjWLGssrP0iEGQWVADx4GC830=;
  b=k85gPVQbcJBMm7huZxNk0/sMFCNBPes3gogv14xmZybCca7R6J6lQ1/b
   BTn9pBKIaFz4kW0UhOujoPRn8ZCEdNTbRR2CxX3ev7w5IvoCsXLjfYjM3
   UuGHF1zGiVcaxUoUFEqXT56taOU2AFZwJmCyxwQP12MjnN01I1mouxuyI
   VJa3hr84RR5INlcXcYe3TyIrbBMlR6iHmR3G949IMhG9SMviTvk3ic7r/
   wx8qW8cmIEDEqTDio/gTYUbsbeKHWXrbw9uKIXBT6PADNRHEAUoR9gFRi
   QCq2cRMs9Bzh+ONGZP1YXPoHjzmr62oAFHdkftxBoe/PgNEPhObboWre5
   A==;
X-CSE-ConnectionGUID: LT0Lg5YIQJKVeFDkeNkm/w==
X-CSE-MsgGUID: QrhTaxBGQ4S5FOnjAd/X6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9630379"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9630379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:20:28 -0700
X-CSE-ConnectionGUID: CnAY08CmSHSn6vJfH89M/g==
X-CSE-MsgGUID: Uabu8h9gT5ejj9xCCPeL7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24348995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 06:20:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4B26E489; Tue, 23 Apr 2024 16:20:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags after cutter '---' line
Date: Tue, 23 Apr 2024 16:19:38 +0300
Message-ID: <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
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

The recommendation is based on the following rationale:

- it makes the commit messages much cleaner and easy to read, especially
  on the screens of the mobile devices;

- it reduces resources (memory, time, energy) to retrieve all these
  headers, which are barely needed by a mere user, as for automation
  they will be still available via mail archives, such as
  https://lore.kernel.org, assuming the Link: or Message-ID tag is
  provided.

Let's be environment friendly and save the planet!

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/process/5.Posting.rst          | 4 ++++
 Documentation/process/submitting-patches.rst | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 90a7fe2a85f2..157b3fc0087a 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -276,6 +276,10 @@ for addition without the explicit permission of the person named; using
 Reported-by: is fine most of the time as well, but ask for permission if
 the bug was reported in private.
 
+It's recommended to locate the additional Cc: tags after the cutter '---' line
+in the patches as it makes sure the commit message won't be polluted with them.
+At the same time they will be available via email headers on the mail archives,
+such as https://lore.kernel.org.
 
 Sending the patch
 -----------------
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 6775f0698136..0c898d9e00f5 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -491,6 +491,11 @@ automatically converted to the Cc: email header and you do not need to
 have an explicit ``Cc:`` tag, if the person is already mentioned by another
 tag.
 
+It's recommended to locate the additional ``Cc:`` tags after the cutter '---' line
+in the patches as it makes sure the commit message won't be polluted with them.
+At the same time they will be available via email headers on the mail archives,
+such as https://lore.kernel.org.
+
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
 attributed by the From: tag) when several people work on a single patch.  Since
-- 
2.43.0.rc1.1336.g36b5255a03ac



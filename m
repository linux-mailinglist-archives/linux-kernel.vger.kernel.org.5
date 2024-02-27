Return-Path: <linux-kernel+bounces-83647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F1869CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D21F26942
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CB2576F;
	Tue, 27 Feb 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAt5aIZU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1202C69D;
	Tue, 27 Feb 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052531; cv=none; b=NxexG2HgZKgTvYhLIy/S59IppVrzfXvRKni1mUO0ZUP/l/wzAqmrrWob4/fPuF7exE9aVnqf8YI+HeI6fUYoRhwMS+oLprdgukMYrpZRlOan7ZqGl8o/nezOJsPSj9JPtjC9P/u6JJIRQojabLII30C2zGMhivuvRCaXKAtgve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052531; c=relaxed/simple;
	bh=GtJSUs8Zd08aEwUhpwlgPs5kZeQj2tOYnSlh4NGkwac=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ede/qpHqHpIVM6a9cJEyZKiFfep59qqU5GaXRulntV5/gtBrDJJJP7b74DeMQ+5dSPx6H5S5+8HDcaghVL5/Vo7HPkhbRzCERJtUV0NZkhK9Hr6GRt6OxKSADiw2TfZeOFbeHxawVa6VxWI1gvJ0HIjXcr6aP8+wMZkreEGVbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAt5aIZU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052529; x=1740588529;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GtJSUs8Zd08aEwUhpwlgPs5kZeQj2tOYnSlh4NGkwac=;
  b=VAt5aIZUs9Lg5f8h3pCUYEwZVJUn9RXNEvg9Rf73c9swibJLXIa7bLkH
   8UIBmeoYeVX6asbavo9nqhptmEqrZ8WYGFyo+VCymCsfWGI16tEpSzHpF
   8Ibnj9noy3OQ88c8h1CoiGJDtwtg+IdoF4n3K8ljlK78qlAPm2sPVH+GI
   MbjKipZ6flBxn/gPbCJcsBHWLuRRM7A0wKDnzhIG3D3HoBJZqJ9VwuzJq
   mWaygvF9/XWNpigF0GPfqgDty3cgdzXGCGjGx2glQ3Zwz+GnG5G+Jx2QE
   NlKN3fyENeiQatlTB/cM1n1V2SHs5xscGCHxCQLsp+mv5R6vjRucsriF9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14043579"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14043579"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="44614001"
Received: from sshaik-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.88.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:48:49 -0800
Subject: [PATCH 0/2] cleanup: A couple extensions for conditional resource
 management
From: Dan Williams <dan.j.williams@intel.com>
To: torvalds@linux-foundation.org, peterz@infradead.org,
 gregkh@linuxfoundation.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Tue, 27 Feb 2024 08:48:47 -0800
Message-ID: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Peter, Linus, Greg,

The cond_guard() patch has gone through several rounds of review and is
looking good to me, but is missing feedback from one of you that have
been grappling with a cross-kernel view of what these new facilities
should look like.

Separately I have been running into trouble trying to fit no_free_ptr()
into some cleanup patches and thought of another way to build on the
conditional syntax originated in scoped_cond_guard().

More specifically, scoped_cond_guard() introduced the concept of passing
a statement to the macro to handle the failure case. cond_guard()
extends that to be used within an existing scope to automatically
release a conditionally acquired lock rather than defining a new scope.

The cond_no_free_ptr() helper takes that concept for ending the cleanup
scope for objects when responsibility for freeing them has been
transferred to a 3rd object or subsystem.

---

Dan Williams (1):
      cleanup: Introduce cond_no_free_ptr()

Fabio M. De Francesco (1):
      cleanup: Add cond_guard() to conditional guards


 include/linux/cleanup.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478


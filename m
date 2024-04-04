Return-Path: <linux-kernel+bounces-132182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A768990FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A721F227C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8B13C3DE;
	Thu,  4 Apr 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ic5V3XIC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596C13C3D2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268337; cv=none; b=KQyV1PvkAmJIFUrmJH/DYe0hfNJuBQbPY2ohn1OV6PYzaZeRiKic1ptuAh9c+XdSp8ep+htI8snOPmxcQ1Yk/ibTe7YG7DoKYUIt4itHyYKrs2krgyuah0K93Dtk+izfCeBZDVWgQZLKXI127DVW4hks4nCUKqLy5c6t0V6UbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268337; c=relaxed/simple;
	bh=Uao7gbUbelyGa8S9RMcw0JQSbxoZPY++pri7MyCJu7g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q+ERlU5afE50oekjLuPFxdGH+7oIjml+mbHryzrGCcbX8EJ/K0yK8pWxJv4eJx4AibvZSXlawdR021VQc05xZBDJ0l1zNyJO7bwotfYUNSsYtl99/HITC3LpU0MDUPxTQnk7sQrqLaVIcLUC/Trar+3culGA2SXBOBG79taTt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ic5V3XIC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712268336; x=1743804336;
  h=date:from:to:subject:message-id:mime-version;
  bh=Uao7gbUbelyGa8S9RMcw0JQSbxoZPY++pri7MyCJu7g=;
  b=Ic5V3XICUY1pcL1+s2O5hIwtI9BCp4nvPRk0IejkxfrJbl4DONbnDkdr
   5iSIF1Z5OkxJNV7NG5Mm03v8Z975eCFe2TE9o+7TW0BTrnVQHsCDM9B2E
   BbnTY9OUc1qwKEIwqOLg9z8jdkCHkqqrt2pORS61rfLqDmbJKWLa4b6cC
   mBRh4GGtP+fdFDJPD5su7N3fqzET7zm4JDI5RVDfB6A/dI3ZLCAU8pINY
   ug9PjvvyguT/kvY0KdIvdKxBaIZg1GJME7gQf7dy9758eY3FAYh7EpvQD
   IJb2pNbAxqqkEZTaAizeTbb+HVcrbQNWrF3Nt6tJq7uR6X5lArJPSbVlY
   Q==;
X-CSE-ConnectionGUID: VOSb6C1kT4C13q8df9LTjA==
X-CSE-MsgGUID: xp8I/BTOTKqwn3x3gX5TJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7447817"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7447817"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:05:35 -0700
X-CSE-ConnectionGUID: x+OpkRLUQTez6KbWLJF5pA==
X-CSE-MsgGUID: J/801aP4Tq6P8GnZL+h08Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23593501"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:05:35 -0700
Date: Thu, 4 Apr 2024 15:05:33 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Machine check recovery broken in v6.9-rc1
Message-ID: <Zg8kLSl2yAlA3o5D@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v6.8 works. v6.9-rc1 fails with:

kernel BUG at include/linux/swapops.h:119

117 static inline unsigned long swp_offset_pfn(swp_entry_t entry)
118 {
119         VM_BUG_ON(!is_pfn_swap_entry(entry));
120         return swp_offset(entry) & SWP_PFN_MASK;
121 }


I've messed up the bisection three times now and ended up
pointing at some innocent looking commit. So I wonder if
anyone else has noticed and tried debugging.

-Tony


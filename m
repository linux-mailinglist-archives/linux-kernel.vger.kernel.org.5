Return-Path: <linux-kernel+bounces-146789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7C8A6AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876F11F21D90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5BD41C77;
	Tue, 16 Apr 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAwYl57T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAF1D530;
	Tue, 16 Apr 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270733; cv=none; b=ZCPuQhdduMm2zPFstvmCQKH31McZlsGwSH7PtUiIbaBa3x9641ZtG1J8qNwBwCKtRBFQlDwcstRckiezDx25WzP9BfJA0fwLSxSd+FrVIx9OrcHVE3TfhzQVgNJ3U/VrodobxeBzuev6TLAxLrhRIn0W9U1IvqzAVf03qITrBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270733; c=relaxed/simple;
	bh=yc1OHvnCJrrwOA0Sled1/e0GCb4ZpXzGgDvC/GtJAHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bm/yrDEVwUkVebeIk1Hmyl67pXgKBzOaqfCN1joytcBXRDGYFmo64BGNV48spEwxv/nEHQ+YZ8XkQTrwWcn2pQKY1zZWy+NwMmSG/EFZLRjcZ3EmXPULOr/739at+5CLAN0rYQ17ZDPA6IsyF0GtRNXiG1+Wxhy6f0gGtrgJlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAwYl57T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713270732; x=1744806732;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=yc1OHvnCJrrwOA0Sled1/e0GCb4ZpXzGgDvC/GtJAHA=;
  b=JAwYl57TD2JXXzF4ogM6Qdj8pxLz6qaiM4tEEVdqVEkSzgELadg1Prqh
   wewvABhJxxwcy9mMitY5+qqE4mGNK7jb5TdGSpV8d5MA5RznizeyclG1c
   Z0BsWPH/gedNq1o/nkIwJPQ8IN6MnwxAhWoUUImjDBZ3pWBZvwFzm9erg
   V8F9GYMEuH5aKvrKqdYagG5GCY2m5Q6VB9fEFx3dt0jb4JnvkvoQSEaSh
   CvL2HKjXK9R4iuRtXAqDsd2sNogSqlRq8CAxo/vC15mNxUkw+iYvY+wEA
   sUFNbkkICTOmLcRZQak0Lmbxl80a706xrKnxcumkN7M8yzDaTnNvdDljh
   g==;
X-CSE-ConnectionGUID: 4VNomxXSRNqgNFLDogS9eA==
X-CSE-MsgGUID: EctLl3DtQ+Glypz1Lyrt+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8868755"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8868755"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:32:11 -0700
X-CSE-ConnectionGUID: MRuugAAZSO2xKeIREtP0lg==
X-CSE-MsgGUID: 6JqSE1nESkOfEkiC/U89ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26887543"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.34])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:32:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, markgross@kernel.org, 
 andriy.shevchenko@linux.intel.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240415212853.2820470-1-srinivas.pandruvada@linux.intel.com>
References: <20240415212853.2820470-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: Add Granite Rapids-D to HPM CPU
 list
Message-Id: <171327072346.3662.18169670503368574548.b4-ty@linux.intel.com>
Date: Tue, 16 Apr 2024 15:32:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 15 Apr 2024 14:28:53 -0700, Srinivas Pandruvada wrote:

> Add Granite Rapids-D to hpm_cpu_ids, so that MSR 0x54 can be used.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
      commit: d8c2d38c4d1dee8fe8e015b9ebf65bdd8e4da99b

--
 i.



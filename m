Return-Path: <linux-kernel+bounces-135619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5A89C89A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4122AB24373
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496D1420DA;
	Mon,  8 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWzxgVr3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2D1420B6;
	Mon,  8 Apr 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590954; cv=none; b=EWP76zCYRAQy+jy+gj/gan4m5AAErgrJfZzk/J4dj1/nEzs12Kw+RMXPQwUFNV1emQg1bvfTEowahCTSmUm+DrF7XL3EfOzqtjafeqP1TK9ZewlceOEBSfA09lEaZ07sOl3BUqoqjiP6+h3gwfDrp4APj6onbn87fR1i1k8Fk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590954; c=relaxed/simple;
	bh=wAt9hHU1NvhG5I5QM0RA8vIU8EEsSSGfsnpVfKylQxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vD6vC5FqnpRZnVxaAdsV2m5SZO/KuTwUi1CZpAc4SbwSMUz2Q8l4XQp9Ix4zAzTg/oME+HRjRdqMGsXbg1V65hCrs+nWYC0c2KBE8jL1INcyF/mHgkaqByYL7VDQtxWibvJL2yiVOkT1dxvZwAVCZVukISTOUqiLR/xQN1d1LvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWzxgVr3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590953; x=1744126953;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=wAt9hHU1NvhG5I5QM0RA8vIU8EEsSSGfsnpVfKylQxQ=;
  b=jWzxgVr3k9ZttHyTzQR9cmFm50TN+tcSWogxL528IVrtAdlAf6UIfnZz
   buy2UHfjtNDHUoxco0zqnXvR6ii2WXDmrq9wdVoHL9xlCiSdqhfB2PJbe
   5Vg5ELlQooK6fqm3nFU+9w3HDm89wd6vViuQGI9jLOXwU8LYVgkMpYMbh
   T5O/fVss8oM8BwdMkgyhdQaY8Rvzzq5lBjMDUICGqQOV3iPyOrjcxqT2Z
   p2WJGFvh1DrP/rzDQTph0b3EN9q37aDR/PzGRMCg5OY61vfWW4smtE9EN
   LpqwXuKW9MsdJgJMsjnZ32qxVOerkVX4x65QK7Pwniq+tSDjXTo6Y4zqz
   A==;
X-CSE-ConnectionGUID: 8B757hh7R5SudEQ3WoInjA==
X-CSE-MsgGUID: wz3ekWUERFWYdBttBZ+uig==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8037053"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8037053"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:32 -0700
X-CSE-ConnectionGUID: JBctKsOcQD6iCmMqaMO37A==
X-CSE-MsgGUID: hTnfXv0FTMmOGbZ6/A5viQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20355701"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Matan Ziv-Av <matan@svgalib.org>, Hans de Goede <hdegoede@redhat.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <33d40e976f08f82b9227d0ecae38c787fcc0c0b2.1712154684.git.soyer@irl.hu>
References: <33d40e976f08f82b9227d0ecae38c787fcc0c0b2.1712154684.git.soyer@irl.hu>
Subject: Re: [PATCH] platform/x86: lg-laptop: fix %s null argument warning
Message-Id: <171259094483.17776.6352383956854097118.b4-ty@linux.intel.com>
Date: Mon, 08 Apr 2024 18:42:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 03 Apr 2024 16:34:27 +0200, Gergo Koteles wrote:

> W=1 warns about null argument to kprintf:
> warning: ‘%s’ directive argument is null [-Wformat-overflow=]
> pr_info("product: %s  year: %d\n", product, year);
> 
> Use "unknown" instead of NULL.
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: lg-laptop: fix %s null argument warning
      commit: e71c8481692582c70cdfd0996c20cdcc71e425d3

--
 i.



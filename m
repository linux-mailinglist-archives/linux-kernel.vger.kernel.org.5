Return-Path: <linux-kernel+bounces-137954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26AA89EA42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EF41F23C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFF20304;
	Wed, 10 Apr 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ldx8Rly/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A341BF3D;
	Wed, 10 Apr 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728837; cv=none; b=QMWRS+nPKrXK8ijJLnAnJrcZOWnJcYgbrFN9HQZVFCNRZtcbRyEeWRjNaUSvnmhal7VrE9GNlJ51BbVnchBTjNuoePRVpaeQT4Pu3i9iH3j9ZfwF4JOgOBIqzu4CfRtuGEwdR4zyOx0W/02SBYvaYuSprvJKzBdeiJU7l/UXCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728837; c=relaxed/simple;
	bh=lS08xQB5+dfJ13UYeFRd5tnUYpoDHhzEWxLWJIVAq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpUcXwvDtHOBXm0XeM12TUIyD5Nll068d+02PHY+JVibxRvq325C8v/F12wMR1E7eNtj7asLllTwGGuQaI0u0ajMnkMF6+hLMMi5+nSSI7/MlpNfqe/8Lq5hX96PRDrmmN++Pqm7w2N710LCyHpvRJMxy2tMchZrtCRGCFWurJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ldx8Rly/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712728834; x=1744264834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lS08xQB5+dfJ13UYeFRd5tnUYpoDHhzEWxLWJIVAq3w=;
  b=Ldx8Rly/4Scf6JyWnoW/7fPPr939waRqk/9pjcCyqWqzJ4U/C3HJN4WB
   C5smzXGiiUXmyFfWB1Uqe1X4emRXQpl3ce9P/xt4F4vBfKCOv2xBzQf2S
   8QMjJxhoRdgEcYVIXPMvkPVAbF9H9RzC/Xfmf5ACnxghAydmB21jMLvSp
   9ebzjMOTlt5rJeEIkVYlse3EnHmLOIgS/J/jLUbWp1fiuMTkeqzqL2GM1
   2MjFtn4sZgKwti/TdDKNIiG6qqrK+9De3AagoPC/AQ6aXuRZ3otP/DUPf
   bvxMXMrguG4NjZO1E2flnvildXibHzbHYNnLFPuoroPLVWVMmeUYeedmB
   A==;
X-CSE-ConnectionGUID: H6G2pFEuSXS2aGKgU0UjxQ==
X-CSE-MsgGUID: LlSxPT6YT3iXczubOO53Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11039203"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11039203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937094562"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937094562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:00:30 -0700
Date: Wed, 10 Apr 2024 09:00:28 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ACPI: bus: allow _UID matching for integer zero
Message-ID: <ZhYq_HDwAi4B49Zz@black.fi.intel.com>
References: <20240328035540.13194-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328035540.13194-1-raag.jadav@intel.com>

On Thu, Mar 28, 2024 at 09:25:40AM +0530, Raag Jadav wrote:
> Commit b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to
> support multiple types") added _UID matching support for both integer
> and string types, which satisfies NULL @uid2 argument for string types
> using inversion, but this logic prevents _UID comparision in case the
> argument is integer 0, which may result in false positives.
> 
> Fix this using _Generic(), which will allow NULL @uid2 argument for
> string types as well as _UID matching for all possible integer values.
> 
> Fixes: b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Bump.

Anything I can do to move this forward?

Raag


Return-Path: <linux-kernel+bounces-160598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78A8B3FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC005B23D42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBADB156E4;
	Fri, 26 Apr 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGPqK6Qp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E2125AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158480; cv=none; b=TEqeqReMn1sJ0HF+pTHjw6zx6K13uzYs8XTxO3bdBMEhczXyLhPYuR4rWE3zUWAzYsY9iFhbLazWyMkRoOIqc6Lil/q6MqazLkPYr/VyWqCtceZRVm+aaFJWcM+CthQCs97X8KdNmWR1iVxRlTuXcu0ryp/vYloWZi/tSD108yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158480; c=relaxed/simple;
	bh=UeSxCdJbzGcsS1QJmeuULnQ8iK3ONz8IzPRxX1f/Ppc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjTFSVyLbg0D+RHY7hW+/VjT8RPEgEVnqW4v2nkzlMEq6GgPksvxui72UZ0BmW/YjYdOOrx1aTihJkhCsfEQuhPYxhfgiGPivlvV3kOOMvcPUwgMw/pGEN8/tyGwrurJGw/XdxOmdGJKOVWsCt2txBp5qkFah/NXVV84uDFjHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGPqK6Qp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714158479; x=1745694479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UeSxCdJbzGcsS1QJmeuULnQ8iK3ONz8IzPRxX1f/Ppc=;
  b=XGPqK6QpyL086kuKKagZ4JOV5f9nO7e2Xhd39DfQUKtBiNO1/8sZYl8h
   aFRCySf2FujEZlmMEGrIiHxqIVaQ1/6uC8a8F1KqaOjMCUo5a/HYzSBas
   DSQiSaLAE8K5E2lpdipNc4Ipq75fktIeKmk9dOLPGYqb4HL+maBT3Il8V
   jaZViGO6SoDmCDqdhNgve/817sJL875h2twokep3MRk+1gbLH6krNDBT+
   8PaMRbCtbi6h3P1BrJRNrJ19F9yEtIxfZ4dRCmolL2qnNK/ZE5mt8Iym8
   9FWro7Jc9+GUGknk40EjEWpQI5BzDVmCElzuMzXQMAySiJNJZ1JKje/k2
   g==;
X-CSE-ConnectionGUID: RUqmjtn5QqmKIUf57nTnEg==
X-CSE-MsgGUID: q8SiylM5SSmS+N+b2pAFew==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="21315007"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="21315007"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:07:58 -0700
X-CSE-ConnectionGUID: de3DcQFlTCqc1GasD9tfMw==
X-CSE-MsgGUID: jx4p2FM4RlmrEIyfjsPppQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="26006350"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 26 Apr 2024 12:07:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 34F561D5; Fri, 26 Apr 2024 22:07:54 +0300 (EEST)
Date: Fri, 26 Apr 2024 22:07:54 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: alison.schofield@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unneeded MKTME detection
Message-ID: <wjmqlbz7nw4waifnjcpf666os7k4ghsorbkwovzftawaywxpon@ohsc3wdtehxx>
References: <cover.1713929290.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713929290.git.alison.schofield@intel.com>

On Thu, Apr 25, 2024 at 09:24:51PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> MKTME detection was added in anticipation of full kernel support
> that never followed. Aside from just good housekeeping, this
> cleanup is inspired by users who are confused by the TME/MKTME
> messaging during boot.
> 
> The first patch cleans up the TME & MKTME detection code and the
> second patch removes the unused pconfig code.
> 
> Testing was done on a platform supporting MKTME using the BIOS
> option to enable/disable MKTME prior to boot.
> 
> 
> Alison Schofield (2):
>   x86/cpu: Remove useless work in detect_tme_early()
>   x86/pconfig: Remove unused MKTME pconfig code

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


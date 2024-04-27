Return-Path: <linux-kernel+bounces-161106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC18B4735
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88851F21CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F211419BA;
	Sat, 27 Apr 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo5PO85d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAB628
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236804; cv=none; b=WBj0ChqUsa1+28YIpmDdai+5goIJQKu3YaqT70OpKzycN0ohIYS1AUU+gNFxR/sA4XutlRcGXet/e/3c3918aNOAoIrR2OvWEWFLfd+HzfaxZJ2M4cV82OA4IirLHZm7LTu+AV1xihaWjlANKt9k0V+eKub9X5/c3jcJy24VoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236804; c=relaxed/simple;
	bh=QWybhLUhrELLESM27F8WIrWgZG2CGCVmC7Q3DMOepaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnB8U7MQKcahCbpWkyq3l+506y3phCVd5bF732yw9DxRZGLwEu3A14y0G94Y+F45IdG9OTh/DJzQwYlguGI/r1eD9KpB0OaZDFBRNmuFwLOSzYm9deLj1U+RSh4p70QAP577qNJ8ExdqzT3DkOCHcYdaOKFZOzZ9J85QXGzxevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo5PO85d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714236803; x=1745772803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QWybhLUhrELLESM27F8WIrWgZG2CGCVmC7Q3DMOepaM=;
  b=Oo5PO85dOod9E/HrotklbM7H1xgbRapk3QMMCtE3MyPgLfyr6Uta6v+3
   xDqWWQ7jFFTjqctkHsz9szlAwt5NmYWq28K2DCZt3PXdejND97avwNAmc
   EBFGLexlp97ZQu0WGmUelpTpIZYFfeVrwLL/rlZ1qOgF59TlIREB8JVBa
   xfTfN9VHaIQTicQLzd2WLIubMWUonf740rB1mT+EMp6UsSga7tJHjfxBm
   gHHowSGGMBDmTuL1mxBXBVjSb6g4by/UnE5oEy6JQvSVNUmVoV+iumVlB
   Ab3jmROb1l+sVBhki6wtWTIab33JuZ1IamHlzoQA2Yu4ZCsZC8Io7LuL/
   Q==;
X-CSE-ConnectionGUID: dxJX6hMzTWGUpjilb1uVOA==
X-CSE-MsgGUID: N696blKkQuyN+q8QQ6o5/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21362566"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="21362566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 09:53:22 -0700
X-CSE-ConnectionGUID: Z3zAs51+SDCIkuEOvtFanA==
X-CSE-MsgGUID: cutovxMVQHiT6sg+voIfPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="26119745"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2024 09:53:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D8347118; Sat, 27 Apr 2024 19:53:17 +0300 (EEST)
Date: Sat, 27 Apr 2024 19:53:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, hpa@zytor.com, seanjc@google.com, elena.reshetova@intel.com, 
	rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Message-ID: <cazjiiltxc2ydvmhfexu7gpnfwlaqq54dplyjbamcu72ucawat@m3xuliqigt6p>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <20240325104607.2653307-5-kirill.shutemov@linux.intel.com>
 <8f4c664e-665b-495c-b6d0-04899a3c216b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4c664e-665b-495c-b6d0-04899a3c216b@intel.com>

On Wed, Apr 24, 2024 at 03:20:54PM -0700, Dave Hansen wrote:
> But seriously, why all the complexity over and over?  What does this buy?

Thanks. That's a good perspective. I will rework the patchset dropping all
unneeded enumeration.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


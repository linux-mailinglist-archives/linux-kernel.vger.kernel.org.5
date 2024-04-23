Return-Path: <linux-kernel+bounces-154952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9E8AE378
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B532B239A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3CC76C61;
	Tue, 23 Apr 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+PQLdoB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1120612EB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870605; cv=none; b=QVKwMRVyZaGi5/ji4+sDRminJwXsoD5boKtb162HZsLyjBJe73k4uQreUju8uPiRhuwIbhJwMWILCZjF1tHPsVrGkvBGfT81oGcTednU/OCPErPNhynIl2G0cISMZuqq+TX7KR8DXjzG93KWjFGHEu/ZZVkAhNJC0boSa5apfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870605; c=relaxed/simple;
	bh=RRS+5et4R4ukcEKGXKBGRT47swch/7s60XsJ4XLfqR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOA5I47dtk6Ol98n68ml3Hc0udMkOv9HEf3+YMIfgsUVSOUq+DfTRPdxNRLxkwBXjc57BJM94xOYLnSoWWUD7SI6V/ljmvMlWvSQ/Dl9CNlEO46COOarzMJhrcO5jl8nShi4dYO9+3oBdvtBttU7nQnK/8T4WAvw9bAZ5FNRZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+PQLdoB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713870604; x=1745406604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRS+5et4R4ukcEKGXKBGRT47swch/7s60XsJ4XLfqR8=;
  b=C+PQLdoB0Mwe7IQhvAUs/t4c6EVAQLvJZEPwLf+Pk3ApLPsMJT9kNkeE
   Y7llDBlvMcF8vd+tz0eD3vShvwlqSV3Zrg6Abe0wlY1cYipm6Bkki+fuV
   vQfZwL2TDvsmlKB59JNPtfW4bVFE0fdS853mfKm9Pk3V+ykua2JogAYrl
   VqiNmNCyyS520GzDyYw+IM5pjjXKyZ5PYyWyJCxde1TnzgUvKdIChbdN3
   M1Fb9ek2elhG/yC64EpLwf4N2+1U4S1HL9lHQyxbpI/IOtt+IrUK4DurA
   OQ6f8i4CM8aS6jNlth+YZQ/HB1NvLsM58vmffKF8seG2J3EVXqDeibbhc
   g==;
X-CSE-ConnectionGUID: 7P2hiHkkRdW5D/B4X9hvcA==
X-CSE-MsgGUID: KwbKyUQ8S/iSlq4/xBI8xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13280573"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13280573"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:10:01 -0700
X-CSE-ConnectionGUID: doVcCCmjSU6grJ+ZVtLP4A==
X-CSE-MsgGUID: w7/Eg5zyQQqPRUuSGjbuZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24390296"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 04:09:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8A748192; Tue, 23 Apr 2024 14:09:56 +0300 (EEST)
Date: Tue, 23 Apr 2024 14:09:56 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, sathyanarayanan.kuppuswamy@linux.intel.com, 
	hpa@zytor.com, seanjc@google.com, elena.reshetova@intel.com, 
	rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Chris Oo <cho@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCHv2] x86/tdx: Preserve shared bit on mprotect()
Message-ID: <xa2g4a3hydmucjlfjci7yfuxfsk5yfsbpnbqg4rqzdyjnpq3xp@5q7srdiupbiv>
References: <20240419201353.3937135-1-kirill.shutemov@linux.intel.com>
 <17930444-3740-f874-91e7-3ed81304b1a9@amd.com>
 <d0be5e5c-2103-4bf6-8ef2-44451b105e1f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0be5e5c-2103-4bf6-8ef2-44451b105e1f@intel.com>

On Mon, Apr 22, 2024 at 01:18:26PM -0700, Dave Hansen wrote:
> On 4/22/24 12:46, Tom Lendacky wrote:
> > Appears to be no functional change on the AMD side.
> > 
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Thanks a bunch for that!  I was just noodling over this one and that was
> one of my worries.

Please hold. 0-day found more build issues. Apparently 'cc_mask' is used in
couple of drivers for unrelated reasons and "#define cc_mask 0" breaks them.

I will send v3.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


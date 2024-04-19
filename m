Return-Path: <linux-kernel+bounces-151933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E688AB5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72DD1F228B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0B13CAB4;
	Fri, 19 Apr 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQZwXEtc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC011DFFB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557968; cv=none; b=ZZJIsO9r3CSGSP49ET7KwLywDc93puW4C26uM03tc3QwnQ22ffR7cijPJ/F1Q9P6yrOI8U2xCqxvep1Ihw6/uvhIM1Mkn+ooea/7aLtepuCPzR0KmTRBE7mI35YIsSGlXCIiqvfNK7C1D1zVjdZfWhOb6Vaa+ghUQZ5OQOl8ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557968; c=relaxed/simple;
	bh=rmnOIxFyG7Po4/I0mLeVDTsdddkUvx6bPa4pHOOmpXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzPjKATrguJcrQcWeCvLr58YBBDpTXiccI2tT6O1XsZxZlVewjNOgEgqAh2pO+VnbXYQcnD5RkxhdZx8GC+qJBecOAaMhmc/XuxwNDjsmMWqzkQ09coVGADh7o0rpLnJ+TmDqd3BBvFZD9BCOww/gGL0mUgMAORDqhf2KOVjmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQZwXEtc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713557967; x=1745093967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmnOIxFyG7Po4/I0mLeVDTsdddkUvx6bPa4pHOOmpXs=;
  b=OQZwXEtcRAKNEwH/3VMwNFEYReKOubcm449k3rytQ6ccniVmKtPLJuNx
   C4/h8GiuT4mhHyE5YnNdLIz3c1IE0VSjB0N659YDLK7db48kZw96MBFnE
   26Vy7ZeY4j6o5rlanWYJrcAEO9zPy4YPOBZarGv4m+3L9LH6lrnfvKVl3
   WKuJOFomXscCjdN7ErQ8a4smMImhZufcR6WNDAdrqNGs9ZtsujanEA826
   k824QdFi+R1Mmai+8dC1eQEDAp/8C1r8gswz38Qy5EsyQ66lYtARjVlAX
   Pe7Ftu5ZUYsDFPuXqyq6sJwyv6zK8sbwADtoL/eO+9IFd6HT5gzZr2zay
   g==;
X-CSE-ConnectionGUID: raZSPSzLR4OaQO/ahRyP0A==
X-CSE-MsgGUID: Db19yxnpQN6zSt4xprEEaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34575658"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="34575658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:19:26 -0700
X-CSE-ConnectionGUID: DpFBtG7ZSb+obh+pFwcuIg==
X-CSE-MsgGUID: OqxXQ6wnSHqTaikWU1zUdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="54647362"
Received: from jncarlic-mobl1.amr.corp.intel.com (HELO desk) ([10.209.73.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:19:25 -0700
Date: Fri, 19 Apr 2024 13:19:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dan.j.williams@intel.com,
	bernie.keany@intel.com, charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com, Josh Poimboeuf <jpoimboe@kernel.org>,
	antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker
 feature is present
Message-ID: <20240419201918.czmg6rq3whovhafw@desk>
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
 <24713e0d-779f-4084-ba5c-7375d4b05955@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24713e0d-779f-4084-ba5c-7375d4b05955@linux.intel.com>

On Fri, Apr 19, 2024 at 11:03:28AM -0700, Daniel Sneddon wrote:
> On 4/19/24 10:47, Pawan Gupta wrote:
> > +	u64 gds_lock = 0;
> >  
> >  	switch (gds_mitigation) {
> >  	case GDS_MITIGATION_OFF:
> > @@ -769,6 +769,8 @@ void update_gds_msr(void)
> >  		 * the same state. Make sure the mitigation is enabled on all
> >  		 * CPUs.
> >  		 */
> > +		gds_lock = GDS_MITG_LOCKED;
> Can't we just drop the new gds_lock var and set mcu_ctrl |= GDS_MITG_LOCKED here?

Unfortunately no, because ...

> > +		fallthrough;
> >  	case GDS_MITIGATION_FULL:
> >  		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);

.. mcu_ctrl is read here, it will overwrite any previous value.

> >  		mcu_ctrl &= ~GDS_MITG_DIS;
> > @@ -779,6 +781,7 @@ void update_gds_msr(void)
> >  		return;
> >  	}
> >  
> > +	mcu_ctrl |= gds_lock;
> >  	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);


Return-Path: <linux-kernel+bounces-147360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73668A72EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CBC1C2194A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DB134CE8;
	Tue, 16 Apr 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiFk10Rv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503B84A32
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291369; cv=none; b=mGd/wKh6DM8cAoJON7u+MkjNFHkYtVobEX4l/5s/MAtlkTZvAD1GxprWgKCYzVN2lvCc6Mes5wClcjLZRxmWIGYIyp+xCQahryt9SQ5l/I/DVwfy2At+H46kN9rIFjZG+X/6bEMkqdsA6I7j+HZiY0+R1SEdJ6y/skbVOCkbovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291369; c=relaxed/simple;
	bh=NEewj1CKW99Q8HY/ZVFl8Uew1VV2WqrmJhOA7mr3/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGkiTMq3Wj3Zci3L5R9NBDgiDB22ocGXKb6AU382jVNS66GoxRhYBa+CqhMn2U7Eu90lHjtsW9s98AqHCnOPpjZvkj8IVn07fQlACj8OZrWjjhPX414Infot4TRuDLYeNI8U4/IuqmmN4CwBUkdtKxVNVyHCSiNdT0ZaQitbwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiFk10Rv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713291367; x=1744827367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEewj1CKW99Q8HY/ZVFl8Uew1VV2WqrmJhOA7mr3/5c=;
  b=TiFk10RvzBwSMy+d2qeqTfHvYJlLy4ltyIj9nru5cYZcijKoDq6LHxsf
   wcTJ8PFpZL5mnZ4cBvKTNFW7ro/6q871eEbAI+hY4wgXlEa/XgwJOWhqD
   +vRBtJn9rBpr6hpQc6ybKoFiTcXunzKVSZlfZpk9r3s2+k8kTTydZg8OV
   L2ZpIS2k2krhka/y4AkRyBVZ+dF+rCCaFcZPxPBmdwizaSXjxRluFDUI0
   6G6hFTwykp7+4n83+qBouohnd1uiZa9f/3FMKqDuOR604xPlQlnl5a91p
   sktCFqfBc3giwHB/DSIRWvT0WiK520tnNp5I2ROcax5zrsdgO1ifhvCR2
   A==;
X-CSE-ConnectionGUID: dl06NTwrRGyOfNzrsJvyMA==
X-CSE-MsgGUID: YNBjIZDUT5OfP/Mjg2dbQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8921720"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8921720"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:16:07 -0700
X-CSE-ConnectionGUID: v+Ou0dG3T5Ka4X/8UlERcA==
X-CSE-MsgGUID: 4xQo2RBzSxeNCWa75Wq5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22930317"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:16:06 -0700
Date: Tue, 16 Apr 2024 11:16:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <Zh7AZY5X8_uyHrjz@agluck-desk3>
References: <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>

On Tue, Apr 09, 2024 at 10:22:17AM +0200, Borislav Petkov wrote:
> On Mon, Apr 08, 2024 at 04:20:36PM +0000, Luck, Tony wrote:
> > So are parts 1-3 ready for TIP? If they get added I can start collecting
> > reviews for parts 4-72.
> 
> I'd like for tglx to have a look at this first too.

Boris,

Thomas gave his Reviewed-by for parts 1-3

Link: https://lore.kernel.org/all/871q7e7lfu.ffs@tglx/
Link: https://lore.kernel.org/all/87y19m66tu.ffs@tglx/
Link: https://lore.kernel.org/all/87v84q66sn.ffs@tglx/

Is there anyone else that needs a quick poke to look at these?

-Tony


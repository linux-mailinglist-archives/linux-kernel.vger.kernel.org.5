Return-Path: <linux-kernel+bounces-160027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E78B3805
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA7FB23220
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88A146D43;
	Fri, 26 Apr 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiFyMw+o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A05147C62;
	Fri, 26 Apr 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137056; cv=none; b=U3w1JQJpZcFgNMc/eFUY6Z3gX4ANCLLqbRrsxebBQIWffNEPjRuZCU++0sGgSGdqS3pYN432DF3pNXR57/WOQRfDMTL+rY5gwtQaal0j+yHEQCsUw5wC2JmfveLnCVO7H0/kzzWjs6pHnNaFhXC7N3EZEW/2WRQ8kzjh6l6wKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137056; c=relaxed/simple;
	bh=F8Bo2pBp4CBzrWEGtBurDTewnj7beNkSoEBY6dW1Z5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUKI8bCdhjDLn7uI+oexz202reU6aMrA/rfu3nPHpj5DdbFWlvOLi7EyxzXKOz8tXlUOfQiZF76Yae67SXloASK212m32KltqeCcyfBvI8s0tFQAVRXN21lpUbMWz7Yotv1KYo1i7qNe9X02j9N+8/iEn02qT5nYW04uP6TtQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiFyMw+o; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137055; x=1745673055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8Bo2pBp4CBzrWEGtBurDTewnj7beNkSoEBY6dW1Z5Q=;
  b=OiFyMw+oWx/YJHP3KGjM3a9lEDl/ORwWondLFVnN4l9o+kIoDfkJAFcg
   V4UV+a7BHmewYurml6KiPGOOTta/MqHp+TxaLRsn58VGJngHwboOvWCl8
   NQKt/AUq02/K1nCh2BlJYsEtcsZJyJa9Wi3X9PHzop0mbros9F5opReel
   9u1YD64GuHoJmaUC0cQWv9REriI3CP/g+wdFZtBrUy1aPj+P2VNXcb5nQ
   2qrp3N71p6jJnQm9HBbs3gIw5KnqkJj+JENQx5iWOXS/qlNiEcOOZw1uB
   64yycT/aIcMtkSCXtcTwYfQBt9Tk0qP87TX8UngsmeMGRVIDFqJrquSqJ
   Q==;
X-CSE-ConnectionGUID: 2fuaFQWrRR67zmLW6dWjBg==
X-CSE-MsgGUID: uf5qvRH0T5+UCHRrt64QNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="32369082"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="32369082"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:10:54 -0700
X-CSE-ConnectionGUID: I91opZe0QOCYr6k80Mwxlg==
X-CSE-MsgGUID: 7AYKl2cjT4Kk9lDltl+iZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="29863132"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Apr 2024 06:10:49 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0LLj-0003jK-0O;
	Fri, 26 Apr 2024 13:10:47 +0000
Date: Fri, 26 Apr 2024 21:10:43 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <202404262003.qsWvGwZU-lkp@intel.com>
References: <20240425100434.198925-3-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-3-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc5 next-20240426]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
base:   linus/master
patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?

vim +/keys_header +31 kernel/crash_dump_dm_crypt.c

    27	
    28	struct keys_header {
    29		unsigned int key_count;
    30		struct dm_crypt_key keys[] __counted_by(key_count);
  > 31	} *keys_header;
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


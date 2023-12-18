Return-Path: <linux-kernel+bounces-4404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59F7817C91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F3828401C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89136740A5;
	Mon, 18 Dec 2023 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q188g71d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FD73465;
	Mon, 18 Dec 2023 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702934482; x=1734470482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59SP83dOu7bE+wlgAIUbh0lOytZrwfO2TAn0TlI0bMA=;
  b=Q188g71dZXWjtk2B8M1dLz7bKtn3skdyBvPIfzC5vt4nkly08XkBUZ9f
   ydbCX7D2k8SCC7AwCQUsV9hgKo215iJBAHMXaX8Jj5YxoyaWVJTzAuhUM
   /WbOF2XMPJrFTwsSRqMD0DHD8jsCQRJVQE/d0FAEEIYd2ZPs0dE8xnHUN
   uNz0buXw+EQ6ulH6zuJH5OXhze+dEPQVtc6DdG4dON0o1gxWPz/fSUQdI
   aBnQRgQyfR7l7HVdv5l+PX3rDYP4Y2AUNmRwHvgrbZph67Ri8GK2lRELY
   u670GyKFwh2YtgM1EDXlVIfH3pKFYwFvaNU6IHfzNY89TIXbsuJo5DcZs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392744400"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="392744400"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919397432"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="919397432"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2023 13:21:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFL36-0004XH-2c;
	Mon, 18 Dec 2023 21:21:16 +0000
Date: Tue, 19 Dec 2023 05:20:34 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>,
	jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mailbox: starfive: Add StarFive Meu Mailbox Driver
Message-ID: <202312190442.dVG2haPq-lkp@intel.com>
References: <20231218061201.98136-2-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218061201.98136-2-joshua.yeong@starfivetech.com>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7-rc6]
[cannot apply to next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Yeong/mailbox-starfive-Add-StarFive-Meu-Mailbox-Driver/20231218-141510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231218061201.98136-2-joshua.yeong%40starfivetech.com
patch subject: [PATCH 1/3] mailbox: starfive: Add StarFive Meu Mailbox Driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231219/202312190442.dVG2haPq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312190442.dVG2haPq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190442.dVG2haPq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/starfive-meu.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * StarFive MEU Mailbox allocated channel information


vim +50 drivers/mailbox/starfive-meu.c

    48	
    49	/**
  > 50	 * StarFive MEU Mailbox allocated channel information
    51	 *
    52	 * @meu: Pointer to parent mailbox device
    53	 * @pchan: Physical channel within which this doorbell resides in
    54	 * @doorbell: doorbell number pertaining to this channel
    55	 */
    56	struct meu_db_channel {
    57		struct starfive_meu *meu;
    58		unsigned int pchan;
    59		unsigned int doorbell;
    60	};
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


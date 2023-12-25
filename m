Return-Path: <linux-kernel+bounces-11082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF4E81E118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4EF1C218DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F7C524D1;
	Mon, 25 Dec 2023 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYlh34bp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4A524C7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703513904; x=1735049904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y0JotREU7n3rZ8efH60CDpNZbLbldKJgPdEjnuGmt80=;
  b=DYlh34bpl3woZjhkkGpRzZGMRnIKyJFJs94xlx62DQe4Hyv+c3gihXVH
   RKvWPmOilW9inwBiEr7m7XRCKSqlGRGEEaTaImRxtW9XyEzqavWsHhG9b
   /FGycDPADGXywKVBs60SWg3pBbxNNQS+ZDV77GBWM3iuH8mQo2PzzZka+
   aYEmV6lG8gXlR5D4Cq32KFkcUhK9d28cF2LyPiTROspPEw6EWYHOakIpf
   +u968D8tWZh5Bx7wKaNyFgcYyFhiRiC82uyS7RpKX0xYGIL+zmcGAUt8s
   N4+KtAQgUj5L2E4oaqLWG+e3HUsZzCv5kdwLn8SPNXHtX50LJhena+/OG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="395179912"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="395179912"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 06:18:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109156260"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="1109156260"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Dec 2023 06:18:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHlme-000DKn-1Z;
	Mon, 25 Dec 2023 14:18:20 +0000
Date: Mon, 25 Dec 2023 22:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: arch/x86/platform/olpc/olpc_dt.c:226:19: warning: variable 'len' set
 but not used
Message-ID: <202312252216.1j7qX0Nl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: a7a9bacb9a32f9cebe5feda2e33064440f52d61d x86/platform/olpc: Use a correct version when making up a battery node
date:   4 years, 8 months ago
config: i386-buildonly-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231225/202312252216.1j7qX0Nl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312252216.1j7qX0Nl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312252216.1j7qX0Nl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/platform/olpc/olpc_dt.c:223:5: warning: no previous prototype for 'olpc_dt_compatible_match' [-Wmissing-prototypes]
     223 | int olpc_dt_compatible_match(phandle node, const char *compat)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc_dt.c: In function 'olpc_dt_compatible_match':
>> arch/x86/platform/olpc/olpc_dt.c:226:19: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     226 |         int plen, len;
         |                   ^~~
   arch/x86/platform/olpc/olpc_dt.c: At top level:
   arch/x86/platform/olpc/olpc_dt.c:241:13: warning: no previous prototype for 'olpc_dt_fixup' [-Wmissing-prototypes]
     241 | void __init olpc_dt_fixup(void)
         |             ^~~~~~~~~~~~~


vim +/len +226 arch/x86/platform/olpc/olpc_dt.c

   222	
   223	int olpc_dt_compatible_match(phandle node, const char *compat)
   224	{
   225		char buf[64], *p;
 > 226		int plen, len;
   227	
   228		plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
   229		if (plen <= 0)
   230			return 0;
   231	
   232		len = strlen(compat);
   233		for (p = buf; p < buf + plen; p += strlen(p) + 1) {
   234			if (strcmp(p, compat) == 0)
   235				return 1;
   236		}
   237	
   238		return 0;
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


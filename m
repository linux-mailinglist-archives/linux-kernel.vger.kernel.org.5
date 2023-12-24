Return-Path: <linux-kernel+bounces-10644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C6481D805
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 06:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995641F21B97
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 05:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F010EC;
	Sun, 24 Dec 2023 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N59Mg2rc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30EEC6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703396303; x=1734932303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uYYJ06mw5SMC891s0ZSQRKKOEOIVdWwQcOO8xMl2JC0=;
  b=N59Mg2rcliIKBUuRlrj1RoBM/3/SE2THRQAQhqhhhy5sqGm/t+sgMI8k
   XqlrAN68TodpM+kuDi9NNo4EGGC7cGB2zMfMPr0yzVamghS47AH6DzGiR
   X1k7O8M7As8VAptQ+5zD3TptI8D+qDpF2Uy8konJEn8U3NaXEj1ge/OFF
   5O6fpZXIk1g4z9DW37vdodVwuwwIHBtEE4y+vmMnt8TNOrLMuDfH4BTP0
   fwzBdJD8J2qAsBgAR+IZ3hkmJkDD7lTqbpp/tN9FMaOkw1H7vIF+0/N+A
   MixhtYkU4ysq87vH+XLgzDAWH/a9z9qzatnq9jfwjh9Uq1IRgtl6Vqq9b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="427389046"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="427389046"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="770714190"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="770714190"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2023 21:38:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHHAS-000Bsb-1U;
	Sun, 24 Dec 2023 05:37:30 +0000
Date: Sun, 24 Dec 2023 13:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol bpf_skb_set_xfrm_info
Message-ID: <202312241309.l4zdLgN8-lkp@intel.com>
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
commit: 94151f5aa9667c562281abeaaa5e89b9d5c17729 xfrm: interface: Add unstable helpers for setting/getting XFRM metadata from TC-BPF
date:   1 year, 1 month ago
config: mips-randconfig-m031-20220120 (https://download.01.org/0day-ci/archive/20231224/202312241309.l4zdLgN8-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312241309.l4zdLgN8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312241309.l4zdLgN8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got member (0xd)!
   die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
>> WARN: resolve_btfids: unresolved symbol bpf_skb_set_xfrm_info
>> WARN: resolve_btfids: unresolved symbol bpf_skb_get_xfrm_info

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


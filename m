Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1108126DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443168AbjLNFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443162AbjLNFTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:19:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB2AD;
        Wed, 13 Dec 2023 21:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702531196; x=1734067196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LP1hgWHB8YhuPGik6J6Bc7+zlLntvB/l6rZVFN707T4=;
  b=XOy08tALqK/UC5ISwCN8jiAjHQbypOJa5HAnMctwbOb5g4eaLJWgJmDy
   CtlWNOiIa379eCORDJ8zCk8dNBN3iMMEca4nHU5WZ2d4sBBf6UAjDgOFE
   hSjM9bkIjL0xY7c4IZwVpvBQKBBPhxn4c3RWlhCQ32OuETuhd8ZeMWt/M
   YPCY2NfVD0acx6idrP1WNXE2xLrF/tvtvyRZFsDogXKUk+2lTApo7iQfq
   fnbQjz7+6Affz2ki3ZbZ1vycjZlKmgs15L5qY3O2WfqsBVqSD9YuvFGzx
   XP5vYHjQr7U0n2+whsFOEug7vQCVOKnjCsZlavOI/qhL0ROLVCZ1x+LMp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375225560"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375225560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 21:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="897612760"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="897612760"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2023 21:19:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDe8U-000LcB-08;
        Thu, 14 Dec 2023 05:19:50 +0000
Date:   Thu, 14 Dec 2023 13:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Akhil R <akhilrajeev@nvidia.com>
Subject: Re: [PATCH 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <202312141305.pZ3rThjo-lkp@intel.com>
References: <20231213122030.11734-4-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213122030.11734-4-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on drm/drm-next arm64/for-next/core robh/for-next linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-R/dt-bindings-crypto-Add-Tegra-SE-DT-binding-doc/20231213-202407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20231213122030.11734-4-akhilrajeev%40nvidia.com
patch subject: [PATCH 3/5] crypto: tegra: Add Tegra Security Engine driver
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141305.pZ3rThjo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141305.pZ3rThjo-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -Wformat-overflow -Wformat-truncation -Wstringop-overflow -Wrestrict -Wenum-conversion W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j32 KBUILD_MODPOST_WARN=1 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/crypto/tegra/tegra-se.h: 12 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 403: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9947E0D1D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjKDBvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:51:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B40D49
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699062668; x=1730598668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6FWBipzeoWojXcrhCPjx0tYc+KKv82iiEgHT6klAO7k=;
  b=aJeoviSu2UFOVAZbCSSnpM0j7YeyW2pXCL5z1ILPQJ1IjyO38s43PrUF
   cwfRH3q8p9mYVWz3DQzaKfupOnCD8XKdXci5W5EzFpPQ46VK6QKHtSeVk
   lBqmvRNu0Es8BcI1QrZQklYBTrNfDH664LmtNlvEXhXHzH2eHUgBtaGG4
   iS8eyRfefIkiHoAgy7bQ9HzBrQJxvafSB7eYzysxPT96/1LG2xS4w/RPf
   qqSElZtWEszT68qBLLvYlhvd1fil5iyzgLyuOn8V8JihTqvsgAuilOsHq
   zbrzkwyC+cPYtln97WJprHOMzTFBEZAVPAlTjfIY8rx/tPEsneD6t+yWj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10588146"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="10588146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="827668317"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="827668317"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2023 18:51:06 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz5oW-0003DK-1B;
        Sat, 04 Nov 2023 01:51:04 +0000
Date:   Sat, 4 Nov 2023 09:50:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: versioncheck: ./samples/trace_events/trace_custom_sched.c: 11
 linux/version.h not needed.
Message-ID: <202311040928.cHK2Czr7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: 953c2f052112a857c00058a641dc0c58ec7551d4 tracing: Add sample code for custom trace events
date:   1 year, 8 months ago
reproduce: (https://download.01.org/0day-ci/archive/20231104/202311040928.cHK2Czr7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040928.cHK2Czr7-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wrestrict -Wformat-overflow -Wformat-truncation -Wstringop-overflow -Wundef -funsigned-char -Wenum-conversion -Wno-error=return-type -Wreturn-type -Wno-error=missing-prototypes W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j32 KBUILD_MODPOST_WARN=1 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
   ./arch/csky/kernel/process.c: 5 linux/version.h not needed.
   ./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h: 16 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./init/version.c: 17 linux/version.h not needed.
>> ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 262: need linux/version.h
   ./tools/perf/include/bpf/bpf.h: 70: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 25 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

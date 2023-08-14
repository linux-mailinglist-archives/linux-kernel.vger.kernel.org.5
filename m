Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0477BF26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjHNRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHNRii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:38:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B86133
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692034717; x=1723570717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LloplWAO59EGyy/RU+gqtSWHiJMszm1V+qQKYLZP3Xg=;
  b=HLQQzMcTRLEOa1ebDYVdsqm2lP00E33iTZQ/SVk9YZhYaxge7M0kaQ7p
   pp4BUyf2w08nhspdD2BFO+KK+Y+tQoj+iXW8H6WklgTl4iWQsSw6CTU19
   MaETAaLBWJ2CQ4ffFaLF9Hu5zkaA8B/7F+n5JD2D/yMC48mIrYLyxpeAR
   WHcHr/hWX/ovz1epkrGL/cjxj+N3/Cpivpxd8DEdsVmHdLyoR7HIPfctY
   g1iO0l0MGRLjxbIVi2NKmGegat+TGJaiDW30AZogpp0Wkuc8jfouMy0Kd
   wd1jd0b3ccJu30kTcfpWFdwJRAXMbRpqQyXfFm5E6Qcr5bH8dLjR1eFkv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351690078"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="351690078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="907295979"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="907295979"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2023 10:38:30 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVbWP-0000Jv-0A;
        Mon, 14 Aug 2023 17:38:29 +0000
Date:   Tue, 15 Aug 2023 01:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: versioncheck: ./tools/lib/bpf/bpf_helpers.h: 146: need
 linux/version.h
Message-ID: <202308150131.WbNYqIFu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ccdd1b13c591d306f0401d98dedc4bdcd02b421
commit: 9ae2c26e43248b722e79fe867be38062c9dd1e5f libbpf: provide NULL and KERNEL_VERSION macros in bpf_helpers.h
date:   2 years, 5 months ago
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150131.WbNYqIFu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150131.WbNYqIFu-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
   ./arch/csky/include/asm/uaccess.h: 14 linux/version.h not needed.
   ./arch/csky/kernel/process.c: 5 linux/version.h not needed.
   ./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
   ./arch/s390/include/asm/setup.h: 177: need linux/version.h
   ./arch/um/drivers/vector_kern.c: 11 linux/version.h not needed.
   ./arch/x86/hyperv/hv_proc.c: 3 linux/version.h not needed.
   ./drivers/crypto/cavium/cpt/cptpf_main.c: 13 linux/version.h not needed.
   ./drivers/crypto/cavium/zip/common.h: 59 linux/version.h not needed.
   ./drivers/gpu/drm/pl111/pl111_display.c: 14 linux/version.h not needed.
   ./drivers/gpu/drm/pl111/pl111_drv.c: 47 linux/version.h not needed.
   ./drivers/hv/hv.c: 16 linux/version.h not needed.
   ./drivers/i2c/busses/i2c-brcmstb.c: 25 linux/version.h not needed.
   ./drivers/i2c/busses/i2c-xgene-slimpro.c: 22 linux/version.h not needed.
   ./drivers/media/pci/cx25821/cx25821.h: 31 linux/version.h not needed.
   ./drivers/media/platform/s3c-camif/camif-core.c: 26 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h: 16 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c: 31 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c: 14 linux/version.h not needed.
   ./drivers/media/usb/uvc/uvc_driver.c: 19 linux/version.h not needed.
   ./drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c: 21 linux/version.h not needed.
   ./drivers/net/ethernet/mellanox/mlx5/core/main.c: 53 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_main.c: 10 linux/version.h not needed.
   ./drivers/net/usb/lan78xx.c: 5 linux/version.h not needed.
   ./drivers/net/wireless/rsi/rsi_91x_ps.c: 19 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/scsi/qedf/qedf.h: 14 linux/version.h not needed.
   ./drivers/scsi/qedf/qedf_dbg.h: 13 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/soc/tegra/powergate-bpmp.c: 10 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./drivers/staging/rtl8723bs/include/drv_types.h: 17 linux/version.h not needed.
   ./drivers/staging/rtl8723bs/include/ioctl_cfg80211.h: 10 linux/version.h not needed.
   ./drivers/usb/core/hcd.c: 14 linux/version.h not needed.
   ./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not needed.
   ./include/linux/qed/qed_ll2_if.h: 15 linux/version.h not needed.
   ./include/linux/usb/composite.h: 39 linux/version.h not needed.
   ./init/version.c: 16 linux/version.h not needed.
   ./kernel/sys.c: 42 linux/version.h not needed.
   ./samples/bpf/sampleip_kern.c: 7 linux/version.h not needed.
   ./samples/bpf/trace_event_kern.c: 8 linux/version.h not needed.
   ./sound/soc/codecs/cs35l35.c: 12 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
>> ./tools/lib/bpf/bpf_helpers.h: 146: need linux/version.h
   ./tools/perf/include/bpf/bpf.h: 70: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 25 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

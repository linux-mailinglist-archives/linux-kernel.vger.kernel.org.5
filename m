Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C09B7F3141
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjKUOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjKUOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:39:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579A90;
        Tue, 21 Nov 2023 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700577568; x=1732113568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WwsA4VpLz0plLBebxbiTbKHjaqMAa5v25iteuGSMov0=;
  b=EYyBNJ7Dfi0lIZ3PBLzhhZHKv20qURM7/3/FXX+oHlbCyv8BhW3cTQz5
   efoV+w4OQJZ348QK7diy0/xE7QLMg94oTtX0matRzAxQdZGud6sZ6EjBH
   nOlIJwjEr+BEiFV8/fTOABJ8k/XXC1I+EXL4wEgoLT2ByF40MO3TLbdRB
   kVz4PnyUJFmU1iiHy3mtMkzG4q+pjBFOCRp2umlQR9XB5I9hX97o/jSSN
   31taGJkmTzeKVRJAtH5SmUW4oooOJFSS3E7nHUoakhSTHggcACnLG7JTj
   tcjXo5+YrQdMbV6eM7uk40QQMHTIcl0XaxVyV0ljcezJB4XQzpI41AX+L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="388999777"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="388999777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910472645"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="910472645"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2023 06:39:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Ru1-0007vS-2K;
        Tue, 21 Nov 2023 14:39:01 +0000
Date:   Tue, 21 Nov 2023 22:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Stanner <pstanner@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kmo@daterainc.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311212238.EIuwP56e-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231120215945.52027-3-pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-202311=
21]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-=
move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40=
redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: openrisc-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_OPENRISC-0-0 (https=
://download.01.org/0day-ci/archive/20231121/202311212238.EIuwP56e-lkp@intel=
=2Ecom/config)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311212238.E=
IuwP56e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212238.EIuwP56e-lkp@i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMA=
P when selected by OPENRISC
   /usr/bin/grep: /db/releases/20231121182703/kernel-tests/etc/kcflags: No =
such file or directory
   {"timestamp":"2023-11-21 20:53:27 +0800", "level":"WARN", "event":"kbuil=
d.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)", "detail":"cmd: '=
/usr/bin/grep' '-v' '-e' '^#' '-e' '^$' '/db/releases/20231121182703/kernel=
-tests/etc/kcflags' \nstderr: \n\n", "hostname":"community-kbuild-consumer-=
92", "host_hostname":"lkp-worker20", "call_stack":"/zday/kernel-tests/lib/k=
build.sh:3942:in `add_etc_kcflags':  (ShellError 2)\n  from /zday/kernel-te=
sts/lib/kbuild.sh:3971: setup_kcflags\n  from /zday/kernel-tests/lib/kbuild=
=2Esh:4016: invoke_make\n  from /zday/kernel-tests/lib/kbuild.sh:4122: make=
\n  from /zday/kernel-tests/lib/kbuild.sh:5623: make_config_allyes\n  from =
/zday/kernel-tests/common.sh:209: redirect_error_to_screen\n  from /zday/ke=
rnel-tests/common.sh:217: redirect_command_errors\n  from /zday/kernel-test=
s/lib/kbuild.sh:5630: make_config\n  from /zday/kernel-tests/lib/builder/ki=
smet.sh:156: generate_make_olddefconfig_warnings\n  from /zday/kernel-tests=
/lib/builder/kismet.sh:297: builder_compile\n  from /zday/kernel-tests/bise=
ct-test-build-error.sh:94: main\n"}
  =20
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - OPENRISC [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

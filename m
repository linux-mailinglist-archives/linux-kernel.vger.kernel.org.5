Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73C7F4951
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjKVOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKVOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:49:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE11BD;
        Wed, 22 Nov 2023 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700664593; x=1732200593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nfdr0Ooij/TeetoP3qp69zSstmzeKd/kvnng0AiVoSg=;
  b=CWaDKTq9fpTulO1SVf6E7+b0SvMprR3qYGwoUpd60dRKzWESUnfCNFt/
   kck80+b1T8krkoArlgPFcg0LYcKD3WDVPwmwRB18kD0wUZ/2U3hHGe249
   vDAcWgeHS1HKEBP7tiYIbuoEyzAhN0YuiOAIiF7DdqghV8wG+JqZCVnql
   dxlkmwUcUYMPXUh+CjyQVlIHB55iY2P+MSysxAt2P2qFoQop39eg1odDY
   Dop/mfvmgaYGPEn1hXiF7YugMNtcvypPIewo5ZC5Ut7hrmyjooQ52Nmsy
   0nQEBs5QB01ese0HsGGJuf48Qe9WGwQ4JPPGJYE1mrhuO2mxu+QbCZ0ul
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395989808"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="395989808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="884635683"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="884635683"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2023 06:48:59 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5oXB-0000ZI-1X;
        Wed, 22 Nov 2023 14:48:57 +0000
Date:   Wed, 22 Nov 2023 22:48:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com, jyanchou@realtek.com
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Message-ID: <202311221803.TyaHE7Ik-lkp@intel.com>
References: <20231121091101.5540-3-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231121091101.5540-3-jyanchou@realtek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.7-rc2 next-20231=
122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-Add-Sy=
nopsys-DesignWare-mmc-cmdq-host-driver/20231121-171551
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121091101.5540-3-jyanchou%40r=
ealtek.com
patch subject: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host d=
river
config: m68k-kismet-CONFIG_MMC_CQHCI-CONFIG_MMC_DW_CQE-0-0 (https://downloa=
d.01.org/0day-ci/archive/20231122/202311221803.TyaHE7Ik-lkp@intel.com/confi=
g)
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221803.T=
yaHE7Ik-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221803.TyaHE7Ik-lkp@i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MMC_CQHCI when s=
elected by MMC_DW_CQE
   /usr/bin/grep: /db/releases/20231122101355/kernel-tests/etc/kcflags: No =
such file or directory
   {"timestamp":"2023-11-22 18:07:24 +0800", "level":"WARN", "event":"kbuil=
d.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)", "detail":"cmd: '=
/usr/bin/grep' '-v' '-e' '^#' '-e' '^$' '/db/releases/20231122101355/kernel=
-tests/etc/kcflags' \nstderr: /usr/bin/grep: /db/releases/20231122101355/ke=
rnel-tests/etc/kcflags: No such file or directory\n\n", "hostname":"communi=
ty-kbuild-consumer-181", "host_hostname":"lkp-worker74", "call_stack":"/zda=
y/kernel-tests/lib/kbuild.sh:3942:in `add_etc_kcflags': /usr/bin/grep: /db/=
releases/20231122101355/kernel-tests/etc/kcflags: No such file or directory=
 (ShellError 2)\n  from /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflag=
s\n  from /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n  from /zday/=
kernel-tests/lib/kbuild.sh:4122: make\n  from /zday/kernel-tests/lib/kbuild=
=2Esh:5623: make_config_allyes\n  from /zday/kernel-tests/common.sh:209: re=
direct_error_to_screen\n  from /zday/kernel-tests/common.sh:217: redirect_c=
ommand_errors\n  from /zday/kernel-tests/lib/kbuild.sh:5630: make_config\n =
 from /zday/kernel-tests/lib/builder/kismet.sh:156: generate_make_olddefcon=
fig_warnings\n  from /zday/kernel-tests/lib/builder/kismet.sh:297: builder_=
compile\n  from /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
  =20
   WARNING: unmet direct dependencies detected for MMC_CQHCI
     Depends on [n]: MMC [=3Dy] && HAS_DMA [=3Dn]
     Selected by [y]:
     - MMC_DW_CQE [=3Dy] && MMC [=3Dy] && (ARC || ARM || ARM64 || MIPS || C=
OMPILE_TEST [=3Dy])

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

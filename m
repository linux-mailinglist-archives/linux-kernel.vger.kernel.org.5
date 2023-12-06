Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0138807082
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378384AbjLFNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:04:56 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB60AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5nAkWiQtXa9kt+ivIVcZPDeOMWxEMs6zxXitEh1wqH4=;
  b=Xnel6NkPAEZ5VOoybYVJoeSEdYbSfKgXEV4uvGQzp1tP1t+poLwj/1bt
   5vh7dWynde1T0Vnoj3FvzSkIO1xcuRAaapZNPTDmlXsrWdmKHIF49KmLv
   r9B3DcpQb/iRBOEBt9r9GLAJOHU3hUqEPyxxZN6wB1kDpn2RQKmnsMM3R
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,255,1695679200"; 
   d="scan'208";a="73589937"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 14:05:00 +0100
Date:   Wed, 6 Dec 2023 14:04:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Ian Lin <ian.lin@infineon.com>
cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:116:6-9:
 WARNING use flexible-array member instead
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <4b2b846e-bdd3-e2ef-da1b-ff99a528190@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please check on whether the array of size 1 is supposed to be a flexible
array, ie [].

julia

---------- Forwarded message ----------
Date: Wed, 6 Dec 2023 20:18:15 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:116:6-9:
    WARNING use flexible-array member instead
    (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
    and-one-element-arrays)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Wright Feng <wright.feng@cypress.com>
CC: Kalle Valo <kvalo@kernel.org>
CC: "Chi-hsien Lin" <chi-hsien.lin@cypress.com>
CC: Ian Lin <ian.lin@infineon.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 6c04deae1438e5df59fc4848795248fc34961f51 brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
date:   1 year, 2 months ago
:::::: branch date: 2 days ago
:::::: commit date: 1 year, 2 months ago
config: csky-randconfig-r053-20231201 (https://download.01.org/0day-ci/archive/20231206/202312062022.N0mzFcPn-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312062022.N0mzFcPn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312062022.N0mzFcPn-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:116:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

vim +116 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

6c04deae1438e5 Wright Feng 2022-09-28  112
6c04deae1438e5 Wright Feng 2022-09-28  113  struct cca_stats_n_flags {
6c04deae1438e5 Wright Feng 2022-09-28  114  	u32 msrmnt_time; /* Time for Measurement (msec) */
6c04deae1438e5 Wright Feng 2022-09-28  115  	u32 msrmnt_done; /* flag set when measurement complete */
6c04deae1438e5 Wright Feng 2022-09-28 @116  	char buf[1];
6c04deae1438e5 Wright Feng 2022-09-28  117  };
6c04deae1438e5 Wright Feng 2022-09-28  118

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

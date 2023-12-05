Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18478060E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjLEVf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345718AbjLEVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:35:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F2A5;
        Tue,  5 Dec 2023 13:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701812159; x=1733348159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHRfx1lLTTEUbpIitHnXG4zSRin4Toua4V/h/F5B9uY=;
  b=B8sZf6ZXHM/xHLwx8t8niZYuLl/e0LoP8ZhdUHWTDkTKpo2qxzoMOn7s
   vzH4jK4S3ewblDnXXkaqsIL/+VGCqC4+B4fyct9gICqsiAvo64mT7oagS
   JdW24ipKwQ0ovgYoKMxeKqpHSVyMUmyJFZ/AalDE5CN3dC2qSPoq3gU1e
   35GM3Nd9dYgwlH5z9XwLwX+0STEyqY5GNuZA3WM4lPmM7CgLngE4BMX++
   g548NznFv+QFhNJI7qWRFOPdRIKoxSdWUMRMTlo98WnhcA3hbIsOm7bs1
   7bMWqLCyo/B5A7q/cdb2w2yqb8rLDiS8es2h7SPEvBsTgEt86Vj7x5K7C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391128807"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391128807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837084266"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="837084266"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Dec 2023 13:35:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAd55-0009lI-12;
        Tue, 05 Dec 2023 21:35:51 +0000
Date:   Wed, 6 Dec 2023 05:35:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <202312060510.XsWjRD4I-lkp@intel.com>
References: <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kory-Maincent/ethtool-Expand-Ethernet-Power-Equipment-with-c33-PoE-alongside-PoDL/20231202-021033
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231201-feature_poe-v2-8-56d8cac607fa%40bootlin.com
patch subject: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller driver
config: alpha-kismet-CONFIG_FW_UPLOAD-CONFIG_PSE_PD692X0-0-0 (https://download.01.org/0day-ci/archive/20231206/202312060510.XsWjRD4I-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060510.XsWjRD4I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060510.XsWjRD4I-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FW_UPLOAD when selected by PSE_PD692X0
   
   WARNING: unmet direct dependencies detected for FW_UPLOAD
     Depends on [n]: FW_LOADER [=n]
     Selected by [y]:
     - PSE_PD692X0 [=y] && NETDEVICES [=y] && PSE_CONTROLLER [=y] && I2C [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AB806620
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjLFEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLFEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:24:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94F6D45;
        Tue,  5 Dec 2023 20:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701836681; x=1733372681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsZ2Q4U8UY65YpbcLnRP1WWpz/335NVd/R5/RmX/Y3c=;
  b=FWNbUgRQV1vgu/BOYWaCl5CObPemBgUhideRaOYvW1W2VMaVuu48J9RK
   HF46g3XIviUebVanBY01zI5Rnp0B7JJCRysRI0AqVJmwRPtXt7xu093Gr
   20SQre029e+vn/V6QvpuyTOftncEN5/iSHxtGR6yh98cVuAObdlSeJAMS
   uCDIWE8Jw3Vv9UNIsJ8ZaMxwnVmo5uvlI+6bAVntk71ygxiaEGRdqsewZ
   P81lkeIv6VkfR4Txe4g+Agqqm4hxtdUtZWAp9iHwuGUagZJaUxzDMfFxo
   kmn2MDj7X8fiYtOfseVNH+CNX5Sstine2caPn9YDgxrYt0+2f5bOYw7cs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1097561"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1097561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 20:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774864744"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="774864744"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 20:24:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAjSb-000AFc-0h;
        Wed, 06 Dec 2023 04:24:33 +0000
Date:   Wed, 6 Dec 2023 12:23:38 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
Message-ID: <202312061223.iHikO4O3-lkp@intel.com>
References: <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231201-feature_poe-v2-2-56d8cac607fa%40bootlin.com
patch subject: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061223.iHikO4O3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061223.iHikO4O3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/networking/pse-pd/introduction.rst:56: WARNING: Title underline too short.

vim +56 Documentation/networking/pse-pd/introduction.rst

    46	
    47	- For general PSE (PoE) code, use "c33_pse" key words. For example:
    48	  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
    49	  This aligns with Clause 33, encompassing various PoE forms.
    50	
    51	- For PoDL PSE - specific code, use "podl_pse". For example:
    52	  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to differentiate
    53	  PoDL PSE settings according to Clause 104.
    54	
    55	Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Dependent Interface (MDI)
  > 56	-------------------------------------------------------------------------------------------
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

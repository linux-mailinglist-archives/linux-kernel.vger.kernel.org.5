Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554747EFD9B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjKRD4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:56:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634FD79;
        Fri, 17 Nov 2023 19:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700279791; x=1731815791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmR/I9SjDyuqbZa8xaQjea+2jnKMA4EejRbqRkPplhM=;
  b=CbetOfXpRHGvoKdOR1ttN7SX1SmcFtfmGUlMuYK9yaxWyON7Dx5L8QAW
   kpiPCXjYjXbakGOPwbvviDcGNaX/K0GGMe0Ou6R0RxlVsUze8g4PdX8oU
   CaniDWWfT6+rNXK9d0U1Wb09MHCzA+E0aS4ykP2pVwKd+uduy54z7LYnb
   FBHiO3TTioIF9zZ9thW4WBh4MMdXlV03gg4jbAZXeXgN71gLfP6w6kvkg
   Pz8HpP/gZuo4J6aVTfG0Rb8VOvxzKA4cgVVOHQKVDVhYvnLz/PW+wEyiG
   VpR+E99Rg/bI6YcueUOxAYOg0A8+9OyJy4jqOuBzqM9jKZTVBxtUnsi/s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="4555599"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="4555599"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 19:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939331045"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="939331045"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 19:56:26 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4CRT-0003VI-2n;
        Sat, 18 Nov 2023 03:56:23 +0000
Date:   Sat, 18 Nov 2023 11:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] spi: axi-spi-engine: move msg state to new struct
Message-ID: <202311181130.WXViTdUs-lkp@intel.com>
References: <20231117-axi-spi-engine-series-1-v1-9-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-9-cc59db999b87@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6f9da18171889fae105e1413a825c53fa5aab40c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-spi-axi-spi-engine-convert-to-yaml/20231118-041730
base:   6f9da18171889fae105e1413a825c53fa5aab40c
patch link:    https://lore.kernel.org/r/20231117-axi-spi-engine-series-1-v1-9-cc59db999b87%40baylibre.com
patch subject: [PATCH 09/14] spi: axi-spi-engine: move msg state to new struct
config: alpha-randconfig-r081-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181130.WXViTdUs-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181130.WXViTdUs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181130.WXViTdUs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'p' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'cmd_length' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'cmd_buf' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'tx_xfer' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'tx_length' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'tx_buf' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'rx_xfer' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'rx_length' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'rx_buf' not described in 'spi_engine_message_state'
>> drivers/spi/spi-axi-spi-engine.c:106: warning: Function parameter or member 'sync_id' not described in 'spi_engine_message_state'


vim +106 drivers/spi/spi-axi-spi-engine.c

    81	
    82	/**
    83	 * struct spi_engine_message_state - SPI engine per-message state
    84	 */
    85	struct spi_engine_message_state {
    86		/** Instructions for executing this message. */
    87		struct spi_engine_program *p;
    88		/** Number of elements in cmd_buf array. */
    89		unsigned cmd_length;
    90		/** Array of commands not yet written to CMD FIFO. */
    91		const uint16_t *cmd_buf;
    92		/** Next xfer with tx_buf not yet fully written to TX FIFO. */
    93		struct spi_transfer *tx_xfer;
    94		/** Size of tx_buf in bytes. */
    95		unsigned int tx_length;
    96		/** Bytes not yet written to TX FIFO. */
    97		const uint8_t *tx_buf;
    98		/** Next xfer with rx_buf not yet fully written to RX FIFO. */
    99		struct spi_transfer *rx_xfer;
   100		/** Size of tx_buf in bytes. */
   101		unsigned int rx_length;
   102		/** Bytes not yet written to the RX FIFO. */
   103		uint8_t *rx_buf;
   104		/** ID to correlate SYNC interrupts with this message. */
   105		u8 sync_id;
 > 106	};
   107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

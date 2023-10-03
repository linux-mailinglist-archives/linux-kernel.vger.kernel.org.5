Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798F7B62A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjJCHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbjJCHk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:40:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F6BB;
        Tue,  3 Oct 2023 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696318852; x=1727854852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAHPwKBx2VXXhwErA1g4BrQu3mmm/TsAggXL8ezzFFM=;
  b=kPasbqhgYFdiYPbhJSee95HEwFkfEp7+/bfDgc/j/KztMVRfr8bKJb2p
   /18zFSH0ECL3NfIwFmxg7d0zLfG/1ihf1h9cVoPq2rW7ssyKkijFFd9q+
   wVEuzdvurJfPgTs0gla4n0I8WGyH6L3GudL7Iut1ZdC3kYwYljUWm98q4
   uTfIgGHq9n3/UKG6ZyRZ2OnCSCk7aEXzaS+vH7NrX7keLVtZRRaEDfVAp
   PRbwYPmkUq0IFbR926LT1WIxchgKZS8UDRwwaJpI7JGcIrFM3sj9sYxvz
   SCD9C4O4izA2vh5L9B2vuSqUPLBWRxeJkzcg80HSG7QECTacVywVPoo+U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="446974838"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="446974838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821140725"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="821140725"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2023 00:40:48 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qna1O-0006tZ-25;
        Tue, 03 Oct 2023 07:40:46 +0000
Date:   Tue, 3 Oct 2023 15:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ayush Singh <ayushdevel1325@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
Subject: Re: [PATCH v6 2/3] greybus: Add BeaglePlay Linux Driver
Message-ID: <202310031521.Iq3S1RE9-lkp@intel.com>
References: <20231002182454.211165-3-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002182454.211165-3-ayushdevel1325@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6269320850097903b30be8f07a5c61d9f7592393]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/dt-bindings-Add-beaglecc1352/20231003-031225
base:   6269320850097903b30be8f07a5c61d9f7592393
patch link:    https://lore.kernel.org/r/20231002182454.211165-3-ayushdevel1325%40gmail.com
patch subject: [PATCH v6 2/3] greybus: Add BeaglePlay Linux Driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231003/202310031521.Iq3S1RE9-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310031521.Iq3S1RE9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310031521.Iq3S1RE9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/greybus/gb-beagleplay.c:45: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * BeaglePlay Greybus driver
   drivers/greybus/gb-beagleplay.c:78: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Structure to represent part of HDCL frame payload data.
   drivers/greybus/gb-beagleplay.c:107: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Consume HDLC Buffer. This function assumes that consumer lock has been acquired.
   drivers/greybus/gb-beagleplay.c:127: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Queue HDLC data for sending. This function assumes that producer lock as been acquired.


vim +45 drivers/greybus/gb-beagleplay.c

    43	
    44	/**
  > 45	 * BeaglePlay Greybus driver
    46	 *
    47	 * @sd: underlying serdev device
    48	 *
    49	 * @gb_hd: greybus host device of this driver
    50	 *
    51	 * @tx_work: hdlc transmit work
    52	 * @tx_producer_lock: hdlc transmit data producer lock. acquired when appending data to buffer.
    53	 * @tx_consumer_lock: hdlc transmit data consumer lock. acquired when sending data over uart.
    54	 * @tx_circ_buf: hdlc transmit circular buffer.
    55	 * @tx_crc: hdlc transmit crc-ccitt fcs
    56	 *
    57	 * @rx_buffer_len: length of receive buffer filled.
    58	 * @rx_buffer: hdlc frame receive buffer
    59	 * @rx_in_esc: hdlc rx flag to indicate ESC frame
    60	 */
    61	struct gb_beagleplay {
    62		struct serdev_device *sd;
    63	
    64		struct gb_host_device *gb_hd;
    65	
    66		struct work_struct tx_work;
    67		spinlock_t tx_producer_lock;
    68		spinlock_t tx_consumer_lock;
    69		struct circ_buf tx_circ_buf;
    70		u16 tx_crc;
    71	
    72		u16 rx_buffer_len;
    73		bool rx_in_esc;
    74		u8 rx_buffer[MAX_RX_HDLC];
    75	};
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

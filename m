Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137F7BEFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379290AbjJJAxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJAxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:53:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E3A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696899190; x=1728435190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JIjaFn6DsxR7utn5EzXRyfsPasYQZ0Luc3OwnIxsEd8=;
  b=cg+BYen7ZjAbDTY+feiN5qV40meokw66RAfZEMSaTPs8ZTjWpWDwVFoC
   baFJ4oc0ytSKnhvv9EAX6hz5NGV1U7QhMZu+mbudo1q+8UOIYLG6rycfp
   j7j03a21xo/z7nXJe0PUx7a/HjyyGWBcz0CTp5TXIt62rnn8qMPsXaV+A
   KU9fgbxfDqELDHy1gdT5GtCofE4iMc8TYkEz8WEerJDiVFUw5pc7TjKSm
   4lgkp82Fph3XExsiq6WWC0fjZi7yivaV9lJPlSVnM/DVngqdUEl1pCoXr
   fj7WvsWzfN6XVHFc4xBYTmWNaINDfdhx5oRCxsf+Gwb8ZXvs4P6JG8+fv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374626305"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374626305"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746874828"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="746874828"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2023 17:53:07 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq0zh-0000tQ-16;
        Tue, 10 Oct 2023 00:53:05 +0000
Date:   Tue, 10 Oct 2023 08:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Message-ID: <202310100854.sQn1xMV5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
date:   3 weeks ago
config: um-randconfig-001-20231010 (https://download.01.org/0day-ci/archive/20231010/202310100854.sQn1xMV5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100854.sQn1xMV5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100854.sQn1xMV5-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>> pcap-dbus.o:(.text+0x244ef): undefined reference to `dbus_message_demarshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24505): undefined reference to `dbus_connection_send'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2450e): undefined reference to `dbus_connection_flush'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24516): undefined reference to `dbus_message_unref'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24564): undefined reference to `dbus_error_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>> pcap-dbus.o:(.text+0x245b0): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x245d2): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x245e8): undefined reference to `dbus_connection_read_write'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24652): undefined reference to `dbus_message_is_signal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2466e): undefined reference to `dbus_message_marshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x246d6): undefined reference to `dbus_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>> pcap-dbus.o:(.text+0x2473c): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>> pcap-dbus.o:(.text+0x247e6): undefined reference to `dbus_connection_open'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x247fe): undefined reference to `dbus_bus_register'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248ec): undefined reference to `dbus_bus_add_match'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248f4): undefined reference to `dbus_error_is_set'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2493b): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2496c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2497d): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24985): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x249be): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x249ca): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x249f6): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24a32): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a45): undefined reference to `dbus_connection_set_max_received_size'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24a56): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24acc): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24b0a): undefined reference to `dbus_error_free'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

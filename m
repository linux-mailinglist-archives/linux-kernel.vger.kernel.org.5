Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1F766023
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjG0XIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0XIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:08:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD030CD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690499314; x=1722035314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Pch5lpsDk+3w/CzZ1DNlF+ia3fZB4B7Zj+PnF+VAZc=;
  b=eXx8WPFFZmzD4HsXguVOQ1qnBRowpuhg9XJH7dTaSotTBn57w4+7eqDp
   kPT8mrJ55HL8by1ax3bztjc4vDxcEUJQSJAZKyLEWNazWMMyBjXxXot5S
   U4MDlEJuhQ6TQxpLEknTdNBtO7oI0CAuqWthr3FannfVbLVjjJuDOaQKg
   WfzND4hsxGAHjQrJdNacyryJc+Zfmk7vGfPaZH6drY6Cc4dzMgX/fAgA8
   ghNKx7AfBkkwleNmXpznr6ZnP7IC6nOaAMLKZhAPxcxTBUAMavmYHCjkY
   rJfS1KeAfMgiX0Y+Gf2V+DzDq0DUMw1Sm4I2dg/NZ6lU/Hi+PTId8vlvn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348733909"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348733909"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 16:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727180959"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="727180959"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2023 16:08:30 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPA5t-0002hH-2D;
        Thu, 27 Jul 2023 23:08:29 +0000
Date:   Fri, 28 Jul 2023 07:07:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202307280759.RA4cH0yQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   2 years, 11 months ago
config: sh-randconfig-r081-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280759.RA4cH0yQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280759.RA4cH0yQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280759.RA4cH0yQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_optlen @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected int const *__gu_addr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int [noderef] __user *_optlen
>> net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int const *__gu_addr
--
   net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1310:13: sparse:     got int [noderef] __user *optlen
>> net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/kcm/kcmsock.c:1310:13: sparse:     got int const *__gu_addr
--
   net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected int const *__gu_addr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int [noderef] __user *optlen
>> net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int const *__gu_addr
--
   net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int const *__gu_addr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/phonet/datagram.c:47:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int const *__gu_addr
--
   net/phonet/socket.c:367:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/phonet/socket.c:367:21: sparse:     expected unsigned short const *__gu_addr
   net/phonet/socket.c:367:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/phonet/socket.c:367:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/socket.c:367:21: sparse:     got unsigned short const *__gu_addr
   net/phonet/socket.c:623:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:623:14: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:623:14: sparse:    struct sock *
   net/phonet/socket.c:646:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:646:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:646:17: sparse:    struct sock *
   net/phonet/socket.c:662:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:662:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:662:17: sparse:    struct sock *
   net/phonet/socket.c:681:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:681:25: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:681:25: sparse:    struct sock *
   net/phonet/socket.c:730:21: sparse: sparse: context imbalance in 'pn_res_seq_start' - wrong count at exit
   net/phonet/socket.c:745:13: sparse: sparse: context imbalance in 'pn_res_seq_stop' - wrong count at exit
--
   net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1047:13: sparse:     expected int const *__gu_addr
   net/phonet/pep.c:1047:13: sparse:     got int [noderef] __user *optlen
>> net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/phonet/pep.c:1047:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1047:13: sparse:     got int const *__gu_addr
--
   net/dccp/proto.c:535:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [addressable] val @@
   net/dccp/proto.c:535:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:535:52: sparse:     got int [addressable] val
   net/dccp/proto.c:620:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:620:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:620:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/dccp/proto.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/dccp/proto.c:620:13: sparse:     got int const *__gu_addr
   net/dccp/proto.c:718:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:718:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:718:57: sparse:     got int cmsg_type
--
   net/sctp/socket.c: note: in included file (through include/net/sctp/sctp.h):
   include/net/sctp/structs.h:329:41: sparse: sparse: array of flexible structures
   net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/sctp/socket.c:7814:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:7814:13: sparse:     got int [noderef] __user *optlen
>> net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/sctp/socket.c:7814:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:7814:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:8210:20: sparse: sparse: context imbalance in 'sctp_get_port_local' - unexpected unlock
--
   net/rds/af_rds.c:245:22: sparse: sparse: invalid assignment: |=
   net/rds/af_rds.c:245:22: sparse:    left side has type restricted __poll_t
   net/rds/af_rds.c:245:22: sparse:    right side has type int
   net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   net/rds/af_rds.c:262:21: sparse:     expected unsigned char const *__gu_addr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char [noderef] [usertype] __user *
>> net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   net/rds/af_rds.c:262:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char const *__gu_addr
   net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/af_rds.c:493:13: sparse:     expected int const *__gu_addr
   net/rds/af_rds.c:493:13: sparse:     got int [noderef] __user *optlen
>> net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/af_rds.c:493:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:493:13: sparse:     got int const *__gu_addr
--
   net/rds/info.c:171:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/info.c:171:13: sparse:     expected int const *__gu_addr
   net/rds/info.c:171:13: sparse:     got int [noderef] __user *optlen
>> net/rds/info.c:171:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/info.c:171:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/info.c:171:13: sparse:     got int const *__gu_addr
--
   net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/nfc/llcp_sock.c:308:13: sparse:     expected int const *__gu_addr
   net/nfc/llcp_sock.c:308:13: sparse:     got int [noderef] __user *optlen
>> net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/nfc/llcp_sock.c:308:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:308:13: sparse:     got int const *__gu_addr
--
   net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected int const *__gu_addr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int [noderef] __user *optlen
>> net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr
--
   net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected int const *__gu_addr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:892:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:892:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:892:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:892:13: sparse:     got int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:957:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:957:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:957:13: sparse:     got int const *__gu_addr
--
>> arch/sh/kernel/cpu/sh3/clock-sh7706.c:24:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:24:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:24:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:36:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:36:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:36:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:48:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:48:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:48:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:60:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:60:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7706.c:60:21: sparse:     got unsigned int
--
>> arch/sh/boards/board-shmin.c:21:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-shmin.c:21:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-shmin.c:21:9: sparse:     got unsigned long
   arch/sh/boards/board-shmin.c:22:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-shmin.c:22:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-shmin.c:22:9: sparse:     got unsigned long
--
   kernel/locking/lockdep_proc.c:448:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const *
   kernel/locking/lockdep_proc.c:449:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const *
   kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected char const *__gu_addr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const [noderef] __user *buf
>> kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const *__gu_addr
--
   fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/jfs/ioctl.c:83:21: sparse:     expected int const *__gu_addr
   fs/jfs/ioctl.c:83:21: sparse:     got int [noderef] __user *
>> fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/jfs/ioctl.c:83:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/ioctl.c:83:21: sparse:     got int const *__gu_addr
--
   fs/nfsd/nfs4recover.c:798:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:798:13: sparse:     expected unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:798:13: sparse:     got unsigned char const [noderef] __user *
>> fs/nfsd/nfs4recover.c:798:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   fs/nfsd/nfs4recover.c:798:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nfsd/nfs4recover.c:798:13: sparse:     got unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:807:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:807:29: sparse:     expected unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:807:29: sparse:     got unsigned short const [noderef] __user *
>> fs/nfsd/nfs4recover.c:807:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:807:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nfsd/nfs4recover.c:807:29: sparse:     got unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:813:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:813:25: sparse:     expected unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:813:25: sparse:     got unsigned char const [noderef] __user *
   fs/nfsd/nfs4recover.c:813:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   fs/nfsd/nfs4recover.c:813:25: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nfsd/nfs4recover.c:813:25: sparse:     got unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:827:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:827:29: sparse:     expected unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:827:29: sparse:     got unsigned short const [noderef] __user *
   fs/nfsd/nfs4recover.c:827:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:827:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nfsd/nfs4recover.c:827:29: sparse:     got unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:878:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed short const *__gu_addr @@     got signed short [noderef] __user * @@
   fs/nfsd/nfs4recover.c:878:13: sparse:     expected signed short const *__gu_addr
   fs/nfsd/nfs4recover.c:878:13: sparse:     got signed short [noderef] __user *
>> fs/nfsd/nfs4recover.c:878:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:878:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nfsd/nfs4recover.c:878:13: sparse:     got signed short const *__gu_addr
--
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   security/tomoyo/common.c:2687:21: sparse:     expected char const *__gu_addr
   security/tomoyo/common.c:2687:21: sparse:     got char const [noderef] __user *buffer
>> security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   security/tomoyo/common.c:2687:21: sparse:     expected void const volatile [noderef] __user *ptr
   security/tomoyo/common.c:2687:21: sparse:     got char const *__gu_addr
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
--
   drivers/android/binder.c:3613:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3613:21: sparse:     expected unsigned int const *__gu_addr
   drivers/android/binder.c:3613:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/android/binder.c:3613:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/android/binder.c:3613:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3613:21: sparse:     got unsigned int const *__gu_addr
   drivers/android/binder.c:3633:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3633:29: sparse:     expected unsigned int const *__gu_addr
   drivers/android/binder.c:3633:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:3633:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/android/binder.c:3633:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3633:29: sparse:     got unsigned int const *__gu_addr
   drivers/android/binder.c:3699:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3699:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3699:29: sparse:     got unsigned long long [noderef] [usertype] __user *
>> drivers/android/binder.c:3699:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/android/binder.c:3699:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3699:29: sparse:     got unsigned long long const *__gu_addr
   drivers/android/binder.c:3702:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3702:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3702:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3702:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/android/binder.c:3702:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3702:29: sparse:     got unsigned long long const *__gu_addr
   drivers/android/binder.c:3771:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3771:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3771:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3771:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/android/binder.c:3771:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3771:29: sparse:     got unsigned long long const *__gu_addr
   drivers/android/binder.c:3868:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3868:29: sparse:     expected unsigned int const *__gu_addr
   drivers/android/binder.c:3868:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:3868:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/android/binder.c:3868:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3868:29: sparse:     got unsigned int const *__gu_addr
   drivers/android/binder.c:3871:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3871:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3871:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3871:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/android/binder.c:3871:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3871:29: sparse:     got unsigned long long const *__gu_addr
   drivers/android/binder.c:3990:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3990:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3990:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3990:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/android/binder.c:3990:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3990:29: sparse:     got unsigned long long const *__gu_addr
   drivers/android/binder.c:4824:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4824:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4824:24: sparse:     got int
--
   drivers/block/rbd.c:699:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/block/rbd.c:699:13: sparse:     expected int const *__gu_addr
   drivers/block/rbd.c:699:13: sparse:     got int [noderef] __user *
>> drivers/block/rbd.c:699:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/block/rbd.c:699:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/block/rbd.c:699:13: sparse:     got int const *__gu_addr
--
   sound/soc/uniphier/aio-compress.c:295:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     expected unsigned int const *__gu_addr
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     got unsigned int [noderef] [usertype] __user *
>> sound/soc/uniphier/aio-compress.c:295:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     expected void const volatile [noderef] __user *ptr
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     got unsigned int const *__gu_addr
   sound/soc/uniphier/aio-compress.c:309:34: sparse: sparse: cast to restricted __be16
--
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod
   drivers/infiniband/core/user_mad.c:886:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *arg @@
   drivers/infiniband/core/user_mad.c:886:13: sparse:     expected unsigned int const *__gu_addr
   drivers/infiniband/core/user_mad.c:886:13: sparse:     got unsigned int [noderef] [usertype] __user *arg
>> drivers/infiniband/core/user_mad.c:886:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/infiniband/core/user_mad.c:886:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/user_mad.c:886:13: sparse:     got unsigned int const *__gu_addr
--
   net/socket.c:1126:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/socket.c:1126:29: sparse:     expected int const *__gu_addr
   net/socket.c:1126:29: sparse:     got int [noderef] __user *
>> net/socket.c:1126:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/socket.c:1126:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1126:29: sparse:     got int const *__gu_addr
   net/socket.c:227:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ulen @@
   net/socket.c:227:15: sparse:     expected int const *__gu_addr
   net/socket.c:227:15: sparse:     got int [noderef] __user *ulen
   net/socket.c:227:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/socket.c:227:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:227:15: sparse:     got int const *__gu_addr
--
   net/core/pktgen.c:720:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:720:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:720:21: sparse:     got char const [noderef] __user *
>> net/core/pktgen.c:720:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:720:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:720:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:738:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:738:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:738:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:738:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:764:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:764:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:764:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:764:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:781:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:781:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:781:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:781:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:815:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:815:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:815:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:815:21: sparse:     got char const *__gu_addr
--
   net/core/sock.c:1313:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/core/sock.c:1313:13: sparse:     expected int const *__gu_addr
   net/core/sock.c:1313:13: sparse:     got int [noderef] __user *optlen
>> net/core/sock.c:1313:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/core/sock.c:1313:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1313:13: sparse:     got int const *__gu_addr
   net/core/sock.c:1997:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2001:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3093:6: sparse: sparse: context imbalance in 'lock_sock_fast' - different lock contexts for basic block
   net/core/sock.c:3565:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3577:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
   drivers/isdn/mISDN/socket.c:319:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:319:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:319:21: sparse:     got int [noderef] __user *
>> drivers/isdn/mISDN/socket.c:319:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/socket.c:319:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/socket.c:319:21: sparse:     got int const *__gu_addr
   drivers/isdn/mISDN/socket.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:333:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:333:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:333:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/socket.c:333:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/socket.c:333:21: sparse:     got int const *__gu_addr
   drivers/isdn/mISDN/socket.c:371:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:371:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:371:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:371:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/socket.c:371:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/socket.c:371:21: sparse:     got int const *__gu_addr
   drivers/isdn/mISDN/socket.c:441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   drivers/isdn/mISDN/socket.c:441:13: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:441:13: sparse:     got int [noderef] __user *optlen
   drivers/isdn/mISDN/socket.c:441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/socket.c:441:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/socket.c:441:13: sparse:     got int const *__gu_addr
   drivers/isdn/mISDN/socket.c:654:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:654:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:654:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:654:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/socket.c:654:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/socket.c:654:21: sparse:     got int const *__gu_addr
--
   drivers/isdn/mISDN/timerdev.c:229:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     got int [noderef] __user *
>> drivers/isdn/mISDN/timerdev.c:229:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     got int const *__gu_addr
   drivers/isdn/mISDN/timerdev.c:245:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/timerdev.c:245:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     got int const *__gu_addr
--
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
--
   drivers/net/hamradio/mkiss.c:829:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/mkiss.c:829:21: sparse:     expected int const *__gu_addr
   drivers/net/hamradio/mkiss.c:829:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/mkiss.c:829:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/hamradio/mkiss.c:829:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/hamradio/mkiss.c:829:21: sparse:     got int const *__gu_addr
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:415:21: sparse:     got int [noderef] __user *
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:415:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:415:21: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:419:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:419:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] __user * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse:     got signed int [noderef] __user *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/scsi/sg.c:425:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:425:32: sparse:     got signed int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:431:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:431:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *[assigned] buf @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse:     got char const [noderef] __user *[assigned] buf
>> drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/scsi/sg.c:638:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:638:13: sparse:     got char const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:955:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:955:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:955:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:998:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:998:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:998:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1026:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1026:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1026:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1051:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1051:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1051:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1059:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1059:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1059:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1067:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1067:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1067:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1111:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1111:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1111:26: sparse:     got int const *__gu_addr
--
   drivers/tty/ipwireless/network.c:174:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:174:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:174:21: sparse:     got int [noderef] __user *user_arg
>> drivers/tty/ipwireless/network.c:174:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:174:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:174:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:188:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:188:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:188:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:188:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:188:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:188:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:200:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:200:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:200:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:200:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:200:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:200:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:228:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:228:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:228:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:228:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:228:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:228:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
>> drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
--
   drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *eventsp @@
   drivers/vhost/scsi.c:1697:21: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int [noderef] [usertype] __user *eventsp
>> drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/scsi.c:1697:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __virtio16 const *__gu_addr @@     got restricted __virtio16 [noderef] [usertype] __user * @@
   drivers/vhost/vringh.c:567:18: sparse:     expected restricted __virtio16 const *__gu_addr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 [noderef] [usertype] __user *
>> drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __virtio16 const *__gu_addr @@
   drivers/vhost/vringh.c:567:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 const *__gu_addr
--
   drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *idxp @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int [noderef] [usertype] __user *idxp
>> drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse:     got int [noderef] __user *
>> drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1771:21: sparse:     got int const *__gu_addr
--
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int const *__gu_addr
--
   net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1147:14: sparse:     expected int const *__gu_addr
   net/llc/af_llc.c:1147:14: sparse:     got int [noderef] __user *optlen
>> net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/llc/af_llc.c:1147:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1147:14: sparse:     got int const *__gu_addr
--
   net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected int const *__gu_addr
   net/netlink/af_netlink.c:1734:13: sparse:     got int [noderef] __user *optlen
>> net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1734:13: sparse:     got int const *__gu_addr
   net/netlink/af_netlink.c:2535:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2541:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2591:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
   net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int const *__gu_addr
--
   net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected unsigned int const *__gu_addr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr
>> net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int const *__gu_addr
--
   net/ipv4/ip_sockglue.c:1530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1530:13: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:1530:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/ip_sockglue.c:1530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:1530:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1530:13: sparse:     got int const *__gu_addr
   net/ipv4/ip_sockglue.c:1775:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1775:21: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:1775:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1775:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:1775:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1775:21: sparse:     got int const *__gu_addr
--
   net/ipv4/tcp.c:3577:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3577:13: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3577:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/tcp.c:3577:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3577:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3577:13: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3626:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3626:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3626:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3626:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3626:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3626:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3644:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3644:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3644:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3644:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3644:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3644:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3663:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3663:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3663:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3663:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3663:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3663:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3673:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3673:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3673:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3673:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3673:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3673:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3691:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3691:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3691:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3691:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3691:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3691:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3725:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3725:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3725:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3725:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3725:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3725:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3786:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3786:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3786:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3786:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3786:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3786:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3823:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3823:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3823:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3823:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h, include/linux/errqueue.h):
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'tcp_ioctl' - unexpected unlock
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'tcp_get_info' - unexpected unlock
--
   net/ipv4/raw.c:825:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/raw.c:825:13: sparse:     expected int const *__gu_addr
   net/ipv4/raw.c:825:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/raw.c:825:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/raw.c:825:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:825:13: sparse:     got int const *__gu_addr
   net/ipv4/raw.c: note: in included file (through arch/sh/include/asm/checksum.h, include/net/checksum.h, include/linux/skbuff.h, ...):
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
--
   net/ipv4/udp.c:2720:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/udp.c:2720:13: sparse:     expected int const *__gu_addr
   net/ipv4/udp.c:2720:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/udp.c:2720:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/udp.c:2720:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:2720:13: sparse:     got int const *__gu_addr
   net/ipv4/udp.c:1457:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1489:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1501:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c: note: in included file (through include/net/inet_sock.h, include/net/icmp.h):
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'skb_consume_udp' - unexpected unlock
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'udp_destroy_sock' - unexpected unlock
   net/ipv4/udp.c:2888:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:2910:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:2960:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
   net/ipv4/bpfilter/sockopt.c:65:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/bpfilter/sockopt.c:65:13: sparse:     expected int const *__gu_addr
   net/ipv4/bpfilter/sockopt.c:65:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/bpfilter/sockopt.c:65:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/bpfilter/sockopt.c:65:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/bpfilter/sockopt.c:65:13: sparse:     got int const *__gu_addr
--
   net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/tls/tls_main.c:341:13: sparse:     expected int const *__gu_addr
   net/tls/tls_main.c:341:13: sparse:     got int [noderef] __user *optlen
>> net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/tls/tls_main.c:341:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/tls/tls_main.c:341:13: sparse:     got int const *__gu_addr
--
   net/packet/af_packet.c:3942:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/packet/af_packet.c:3942:13: sparse:     expected int const *__gu_addr
   net/packet/af_packet.c:3942:13: sparse:     got int [noderef] __user *optlen
>> net/packet/af_packet.c:3942:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/packet/af_packet.c:3942:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:3942:13: sparse:     got int const *__gu_addr
   net/packet/af_packet.c:1008:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2402:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:1742:21: sparse:     got long const *__gu_addr
--
   net/can/raw.c:659:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/raw.c:659:13: sparse:     expected int const *__gu_addr
   net/can/raw.c:659:13: sparse:     got int [noderef] __user *optlen
>> net/can/raw.c:659:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/can/raw.c:659:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/raw.c:659:13: sparse:     got int const *__gu_addr

vim +697 net/rxrpc/af_rxrpc.c

17926a79320afa David Howells 2007-04-26  685  
515559ca217132 David Howells 2017-06-07  686  /*
515559ca217132 David Howells 2017-06-07  687   * Get socket options.
515559ca217132 David Howells 2017-06-07  688   */
515559ca217132 David Howells 2017-06-07  689  static int rxrpc_getsockopt(struct socket *sock, int level, int optname,
515559ca217132 David Howells 2017-06-07  690  			    char __user *optval, int __user *_optlen)
515559ca217132 David Howells 2017-06-07  691  {
515559ca217132 David Howells 2017-06-07  692  	int optlen;
515559ca217132 David Howells 2017-06-07  693  
515559ca217132 David Howells 2017-06-07  694  	if (level != SOL_RXRPC)
515559ca217132 David Howells 2017-06-07  695  		return -EOPNOTSUPP;
515559ca217132 David Howells 2017-06-07  696  
515559ca217132 David Howells 2017-06-07 @697  	if (get_user(optlen, _optlen))
515559ca217132 David Howells 2017-06-07  698  		return -EFAULT;
515559ca217132 David Howells 2017-06-07  699  
515559ca217132 David Howells 2017-06-07  700  	switch (optname) {
515559ca217132 David Howells 2017-06-07  701  	case RXRPC_SUPPORTED_CMSG:
515559ca217132 David Howells 2017-06-07  702  		if (optlen < sizeof(int))
515559ca217132 David Howells 2017-06-07  703  			return -ETOOSMALL;
515559ca217132 David Howells 2017-06-07  704  		if (put_user(RXRPC__SUPPORTED - 1, (int __user *)optval) ||
515559ca217132 David Howells 2017-06-07  705  		    put_user(sizeof(int), _optlen))
515559ca217132 David Howells 2017-06-07  706  			return -EFAULT;
515559ca217132 David Howells 2017-06-07  707  		return 0;
515559ca217132 David Howells 2017-06-07  708  
515559ca217132 David Howells 2017-06-07  709  	default:
515559ca217132 David Howells 2017-06-07  710  		return -EOPNOTSUPP;
515559ca217132 David Howells 2017-06-07  711  	}
515559ca217132 David Howells 2017-06-07  712  }
515559ca217132 David Howells 2017-06-07  713  

:::::: The code at line 697 was first introduced by commit
:::::: 515559ca21713218595f3a4dad44a4e7eea2fcfb rxrpc: Provide a getsockopt call to query what cmsgs types are supported

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

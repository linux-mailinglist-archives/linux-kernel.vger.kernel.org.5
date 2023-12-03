Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A438025B7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjLCQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjLCQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:52:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393AF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701622332; x=1733158332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TV4FxYeQ6Vmf66KOQHRGGH0GIF2D+zixeVRb89ChpEw=;
  b=nYnueFTqgrSIpTYywa1Hi6cszlMv7V24KnHsXxZzN4scYCYtw5fdjEh7
   YyzQwZ/QbJLdBK4vU6a9e5CBqZqO/8CzWcwZpBZTh1VHJeWSDzSDai2ay
   jZPWo925NMxfte+NE6jPCJxY0VuJtiL6H7Hxt+lEZwoFsF4mrKQKyydCl
   RLzxnpxM6nyZQpmcRPzvpTqrJj/QUPLDTcaoQaFRdM8eI1MGw04l+hkeo
   og/tGKS+b9hkRqB+pTHaUCM5fBxL2Rdud9ipzgR4orxFvW6iT4Z4eztnB
   mX12WtzrBxIF/cRnV7vGOEwSDPyvbwsnz7fdhAuwuDfXAwt1fXZ7X/6ga
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="687157"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="687157"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 08:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720083217"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="720083217"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2023 08:52:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9phK-0006tQ-0a;
        Sun, 03 Dec 2023 16:52:03 +0000
Date:   Mon, 4 Dec 2023 00:51:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: lib/test_bpf.c:10608:9: sparse: sparse: cast truncates bits from
 constant value (123456789acbdef becomes 89acbdef)
Message-ID: <202312040021.M0ehFBos-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 0bbaa02b481682004cf812dbeca68272752a5e8a bpf/tests: Add tests to check source register zero-extension
date:   2 years, 2 months ago
config: mips-randconfig-r123-20231130 (https://download.01.org/0day-ci/archive/20231204/202312040021.M0ehFBos-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312040021.M0ehFBos-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040021.M0ehFBos-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:6949:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6961:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7018:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7029:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7043:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7049:30: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7054:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7067:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7078:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7092:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7098:30: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7103:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7116:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7127:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7141:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7147:30: sparse: sparse: cast truncates bits from constant value (efcdab8967452301 becomes 67452301)
   lib/test_bpf.c:7152:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7165:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7176:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7190:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7196:30: sparse: sparse: cast truncates bits from constant value (1032547698badcfe becomes 98badcfe)
   lib/test_bpf.c:7201:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7214:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7234:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7254:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7274:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7294:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7314:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7335:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7336:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7337:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e008 becomes c0d0e008)
   lib/test_bpf.c:7357:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7358:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7359:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e088 becomes c0d0e088)
   lib/test_bpf.c:7379:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7380:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7381:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d00708 becomes c0d00708)
   lib/test_bpf.c:7401:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7402:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7403:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d08788 becomes c0d08788)
   lib/test_bpf.c:7423:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7424:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7425:25: sparse: sparse: cast truncates bits from constant value (8090a0b005060708 becomes 5060708)
   lib/test_bpf.c:7445:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7446:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7447:25: sparse: sparse: cast truncates bits from constant value (8090a0b085868788 becomes 85868788)
   lib/test_bpf.c:7601:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:7647:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7665:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7780:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7781:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7782:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7783:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7785:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7786:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7787:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7788:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7800:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7801:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7802:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7803:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7805:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7806:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7807:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7808:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7820:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7821:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7822:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7823:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7825:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7826:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7827:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7828:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7840:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7841:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7842:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7843:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7845:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7846:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7847:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7848:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7860:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7861:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7862:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7863:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7953:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7954:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7970:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7971:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7988:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7989:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8006:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8007:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8025:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8026:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8030:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:9233:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:9262:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:9277:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:9306:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
>> lib/test_bpf.c:10608:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10608:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10609:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10609:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10610:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10610:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10611:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10611:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10612:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10612:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10613:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10613:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10614:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10614:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10615:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10615:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10616:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10616:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10638:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10639:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10640:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10641:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10647:25: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10683:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10684:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10685:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10686:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10687:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10688:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10689:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10690:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10691:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10692:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10693:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10694:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10719:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10719:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10720:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10720:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10721:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10721:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10722:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10722:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10723:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10723:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10724:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10724:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10725:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10725:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10726:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10726:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10727:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10727:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10728:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10728:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10729:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10729:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10730:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:10730:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)

vim +10608 lib/test_bpf.c

  7702	
  7703	#define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
  7704	{									\
  7705		"BPF_ATOMIC | " #width ", " #op ": Test: "			\
  7706			#old " " #logic " " #update " = " #result,		\
  7707		.u.insns_int = {						\
  7708			BPF_LD_IMM64(R5, (update) | BPF_ATOMIC_POISON(width)),	\
  7709			BPF_ST_MEM(width, R10, -40, old),			\
  7710			BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
  7711			BPF_LDX_MEM(width, R0, R10, -40),			\
  7712			BPF_ALU64_REG(BPF_MOV, R1, R0),				\
  7713			BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
  7714			BPF_ALU64_REG(BPF_OR, R0, R1),				\
  7715			BPF_EXIT_INSN(),					\
  7716		},								\
  7717		INTERNAL,							\
  7718		{ },								\
  7719		{ { 0, result } },						\
  7720		.stack_depth = 40,						\
  7721	}
  7722	#define BPF_ATOMIC_OP_TEST2(width, op, logic, old, update, result)	\
  7723	{									\
  7724		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r10: "	\
  7725			#old " " #logic " " #update " = " #result,		\
  7726		.u.insns_int = {						\
  7727			BPF_ALU64_REG(BPF_MOV, R1, R10),			\
  7728			BPF_LD_IMM64(R0, (update) | BPF_ATOMIC_POISON(width)),	\
  7729			BPF_ST_MEM(BPF_W, R10, -40, old),			\
  7730			BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
  7731			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7732			BPF_ALU64_REG(BPF_SUB, R0, R1),				\
  7733			BPF_ALU64_REG(BPF_MOV, R1, R0),				\
  7734			BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
  7735			BPF_ALU64_REG(BPF_OR, R0, R1),				\
  7736			BPF_EXIT_INSN(),					\
  7737		},								\
  7738		INTERNAL,							\
  7739		{ },								\
  7740		{ { 0, 0 } },							\
  7741		.stack_depth = 40,						\
  7742	}
  7743	#define BPF_ATOMIC_OP_TEST3(width, op, logic, old, update, result)	\
  7744	{									\
  7745		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r0: "	\
  7746			#old " " #logic " " #update " = " #result,		\
  7747		.u.insns_int = {						\
  7748			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7749			BPF_LD_IMM64(R1, (update) | BPF_ATOMIC_POISON(width)),	\
  7750			BPF_ST_MEM(width, R10, -40, old),			\
  7751			BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
  7752			BPF_ALU64_REG(BPF_SUB, R0, R10),			\
  7753			BPF_ALU64_REG(BPF_MOV, R1, R0),				\
  7754			BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
  7755			BPF_ALU64_REG(BPF_OR, R0, R1),				\
  7756			BPF_EXIT_INSN(),					\
  7757		},								\
  7758		INTERNAL,                                                       \
  7759		{ },                                                            \
  7760		{ { 0, 0 } },                                                   \
  7761		.stack_depth = 40,                                              \
  7762	}
  7763	#define BPF_ATOMIC_OP_TEST4(width, op, logic, old, update, result)	\
  7764	{									\
  7765		"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
  7766			#old " " #logic " " #update " = " #result,		\
  7767		.u.insns_int = {						\
  7768			BPF_LD_IMM64(R3, (update) | BPF_ATOMIC_POISON(width)),	\
  7769			BPF_ST_MEM(width, R10, -40, old),			\
  7770			BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
  7771			BPF_ALU32_REG(BPF_MOV, R0, R3),                         \
  7772			BPF_EXIT_INSN(),					\
  7773		},								\
  7774		INTERNAL,                                                       \
  7775		{ },                                                            \
  7776		{ { 0, (op) & BPF_FETCH ? old : update } },			\
  7777		.stack_depth = 40,                                              \
  7778	}
  7779		/* BPF_ATOMIC | BPF_W: BPF_ADD */
  7780		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7781		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7782		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7783		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7784		/* BPF_ATOMIC | BPF_W: BPF_ADD | BPF_FETCH */
  7785		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7786		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7787		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7788		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7789		/* BPF_ATOMIC | BPF_DW: BPF_ADD */
  7790		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7791		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7792		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7793		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7794		/* BPF_ATOMIC | BPF_DW: BPF_ADD | BPF_FETCH */
  7795		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7796		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7797		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7798		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7799		/* BPF_ATOMIC | BPF_W: BPF_AND */
  7800		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7801		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7802		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7803		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7804		/* BPF_ATOMIC | BPF_W: BPF_AND | BPF_FETCH */
  7805		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7806		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7807		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7808		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7809		/* BPF_ATOMIC | BPF_DW: BPF_AND */
  7810		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7811		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7812		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7813		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7814		/* BPF_ATOMIC | BPF_DW: BPF_AND | BPF_FETCH */
  7815		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7816		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7817		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7818		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7819		/* BPF_ATOMIC | BPF_W: BPF_OR */
  7820		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7821		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7822		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7823		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7824		/* BPF_ATOMIC | BPF_W: BPF_OR | BPF_FETCH */
  7825		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7826		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7827		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7828		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7829		/* BPF_ATOMIC | BPF_DW: BPF_OR */
  7830		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7831		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7832		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7833		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7834		/* BPF_ATOMIC | BPF_DW: BPF_OR | BPF_FETCH */
  7835		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7836		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7837		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7838		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7839		/* BPF_ATOMIC | BPF_W: BPF_XOR */
  7840		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7841		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7842		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7843		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7844		/* BPF_ATOMIC | BPF_W: BPF_XOR | BPF_FETCH */
  7845		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7846		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7847		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7848		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7849		/* BPF_ATOMIC | BPF_DW: BPF_XOR */
  7850		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7851		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7852		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7853		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7854		/* BPF_ATOMIC | BPF_DW: BPF_XOR | BPF_FETCH */
  7855		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7856		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7857		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7858		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7859		/* BPF_ATOMIC | BPF_W: BPF_XCHG */
  7860		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7861		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7862		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7863		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7864		/* BPF_ATOMIC | BPF_DW: BPF_XCHG */
  7865		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7866		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7867		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7868		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7869	#undef BPF_ATOMIC_POISON
  7870	#undef BPF_ATOMIC_OP_TEST1
  7871	#undef BPF_ATOMIC_OP_TEST2
  7872	#undef BPF_ATOMIC_OP_TEST3
  7873	#undef BPF_ATOMIC_OP_TEST4
  7874		/* BPF_ATOMIC | BPF_W, BPF_CMPXCHG */
  7875		{
  7876			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful return",
  7877			.u.insns_int = {
  7878				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7879				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7880				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7881				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7882				BPF_EXIT_INSN(),
  7883			},
  7884			INTERNAL,
  7885			{ },
  7886			{ { 0, 0x01234567 } },
  7887			.stack_depth = 40,
  7888		},
  7889		{
  7890			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful store",
  7891			.u.insns_int = {
  7892				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7893				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7894				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7895				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7896				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7897				BPF_EXIT_INSN(),
  7898			},
  7899			INTERNAL,
  7900			{ },
  7901			{ { 0, 0x89abcdef } },
  7902			.stack_depth = 40,
  7903		},
  7904		{
  7905			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure return",
  7906			.u.insns_int = {
  7907				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7908				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7909				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7910				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7911				BPF_EXIT_INSN(),
  7912			},
  7913			INTERNAL,
  7914			{ },
  7915			{ { 0, 0x01234567 } },
  7916			.stack_depth = 40,
  7917		},
  7918		{
  7919			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure store",
  7920			.u.insns_int = {
  7921				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7922				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7923				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7924				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7925				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7926				BPF_EXIT_INSN(),
  7927			},
  7928			INTERNAL,
  7929			{ },
  7930			{ { 0, 0x01234567 } },
  7931			.stack_depth = 40,
  7932		},
  7933		{
  7934			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test side effects",
  7935			.u.insns_int = {
  7936				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7937				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7938				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7939				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7940				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7941				BPF_ALU32_REG(BPF_MOV, R0, R3),
  7942				BPF_EXIT_INSN(),
  7943			},
  7944			INTERNAL,
  7945			{ },
  7946			{ { 0, 0x89abcdef } },
  7947			.stack_depth = 40,
  7948		},
  7949		/* BPF_ATOMIC | BPF_DW, BPF_CMPXCHG */
  7950		{
  7951			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful return",
  7952			.u.insns_int = {
  7953				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7954				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7955				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7956				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7957				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7958				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7959				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7960				BPF_EXIT_INSN(),
  7961			},
  7962			INTERNAL,
  7963			{ },
  7964			{ { 0, 0 } },
  7965			.stack_depth = 40,
  7966		},
  7967		{
  7968			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful store",
  7969			.u.insns_int = {
  7970				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7971				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7972				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7973				BPF_STX_MEM(BPF_DW, R10, R0, -40),
  7974				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7975				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7976				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7977				BPF_ALU64_REG(BPF_SUB, R0, R2),
  7978				BPF_EXIT_INSN(),
  7979			},
  7980			INTERNAL,
  7981			{ },
  7982			{ { 0, 0 } },
  7983			.stack_depth = 40,
  7984		},
  7985		{
  7986			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure return",
  7987			.u.insns_int = {
  7988				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7989				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7990				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7991				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  7992				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7993				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7994				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7995				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7996				BPF_EXIT_INSN(),
  7997			},
  7998			INTERNAL,
  7999			{ },
  8000			{ { 0, 0 } },
  8001			.stack_depth = 40,
  8002		},
  8003		{
  8004			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure store",
  8005			.u.insns_int = {
  8006				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  8007				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  8008				BPF_ALU64_REG(BPF_MOV, R0, R1),
  8009				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  8010				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  8011				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  8012				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  8013				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  8014				BPF_ALU64_REG(BPF_SUB, R0, R1),
  8015				BPF_EXIT_INSN(),
  8016			},
  8017			INTERNAL,
  8018			{ },
  8019			{ { 0, 0 } },
  8020			.stack_depth = 40,
  8021		},
  8022		{
  8023			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test side effects",
  8024			.u.insns_int = {
  8025				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  8026				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  8027				BPF_ALU64_REG(BPF_MOV, R0, R1),
  8028				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  8029				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  8030				BPF_LD_IMM64(R0, 0xfecdba9876543210ULL),
  8031				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8032				BPF_ALU64_REG(BPF_SUB, R0, R2),
  8033				BPF_EXIT_INSN(),
  8034			},
  8035			INTERNAL,
  8036			{ },
  8037			{ { 0, 0 } },
  8038			.stack_depth = 40,
  8039		},
  8040		/* BPF_JMP32 | BPF_JEQ | BPF_K */
  8041		{
  8042			"JMP32_JEQ_K: Small immediate",
  8043			.u.insns_int = {
  8044				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8045				BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
  8046				BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
  8047				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8048				BPF_EXIT_INSN(),
  8049			},
  8050			INTERNAL,
  8051			{ },
  8052			{ { 0, 123 } }
  8053		},
  8054		{
  8055			"JMP32_JEQ_K: Large immediate",
  8056			.u.insns_int = {
  8057				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  8058				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
  8059				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
  8060				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8061				BPF_EXIT_INSN(),
  8062			},
  8063			INTERNAL,
  8064			{ },
  8065			{ { 0, 12345678 } }
  8066		},
  8067		{
  8068			"JMP32_JEQ_K: negative immediate",
  8069			.u.insns_int = {
  8070				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8071				BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
  8072				BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
  8073				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8074				BPF_EXIT_INSN(),
  8075			},
  8076			INTERNAL,
  8077			{ },
  8078			{ { 0, -123 } }
  8079		},
  8080		/* BPF_JMP32 | BPF_JEQ | BPF_X */
  8081		{
  8082			"JMP32_JEQ_X",
  8083			.u.insns_int = {
  8084				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  8085				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  8086				BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
  8087				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  8088				BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
  8089				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8090				BPF_EXIT_INSN(),
  8091			},
  8092			INTERNAL,
  8093			{ },
  8094			{ { 0, 1234 } }
  8095		},
  8096		/* BPF_JMP32 | BPF_JNE | BPF_K */
  8097		{
  8098			"JMP32_JNE_K: Small immediate",
  8099			.u.insns_int = {
  8100				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8101				BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
  8102				BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
  8103				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8104				BPF_EXIT_INSN(),
  8105			},
  8106			INTERNAL,
  8107			{ },
  8108			{ { 0, 123 } }
  8109		},
  8110		{
  8111			"JMP32_JNE_K: Large immediate",
  8112			.u.insns_int = {
  8113				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  8114				BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
  8115				BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
  8116				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8117				BPF_EXIT_INSN(),
  8118			},
  8119			INTERNAL,
  8120			{ },
  8121			{ { 0, 12345678 } }
  8122		},
  8123		{
  8124			"JMP32_JNE_K: negative immediate",
  8125			.u.insns_int = {
  8126				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8127				BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
  8128				BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
  8129				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8130				BPF_EXIT_INSN(),
  8131			},
  8132			INTERNAL,
  8133			{ },
  8134			{ { 0, -123 } }
  8135		},
  8136		/* BPF_JMP32 | BPF_JNE | BPF_X */
  8137		{
  8138			"JMP32_JNE_X",
  8139			.u.insns_int = {
  8140				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  8141				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  8142				BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
  8143				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  8144				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  8145				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8146				BPF_EXIT_INSN(),
  8147			},
  8148			INTERNAL,
  8149			{ },
  8150			{ { 0, 1234 } }
  8151		},
  8152		/* BPF_JMP32 | BPF_JSET | BPF_K */
  8153		{
  8154			"JMP32_JSET_K: Small immediate",
  8155			.u.insns_int = {
  8156				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8157				BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
  8158				BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
  8159				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8160				BPF_EXIT_INSN(),
  8161			},
  8162			INTERNAL,
  8163			{ },
  8164			{ { 0, 1 } }
  8165		},
  8166		{
  8167			"JMP32_JSET_K: Large immediate",
  8168			.u.insns_int = {
  8169				BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
  8170				BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
  8171				BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
  8172				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8173				BPF_EXIT_INSN(),
  8174			},
  8175			INTERNAL,
  8176			{ },
  8177			{ { 0, 0x40000000 } }
  8178		},
  8179		{
  8180			"JMP32_JSET_K: negative immediate",
  8181			.u.insns_int = {
  8182				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8183				BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
  8184				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8185				BPF_EXIT_INSN(),
  8186			},
  8187			INTERNAL,
  8188			{ },
  8189			{ { 0, -123 } }
  8190		},
  8191		/* BPF_JMP32 | BPF_JSET | BPF_X */
  8192		{
  8193			"JMP32_JSET_X",
  8194			.u.insns_int = {
  8195				BPF_ALU32_IMM(BPF_MOV, R0, 8),
  8196				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  8197				BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
  8198				BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
  8199				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  8200				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8201				BPF_EXIT_INSN(),
  8202			},
  8203			INTERNAL,
  8204			{ },
  8205			{ { 0, 8 } }
  8206		},
  8207		/* BPF_JMP32 | BPF_JGT | BPF_K */
  8208		{
  8209			"JMP32_JGT_K: Small immediate",
  8210			.u.insns_int = {
  8211				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8212				BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
  8213				BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
  8214				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8215				BPF_EXIT_INSN(),
  8216			},
  8217			INTERNAL,
  8218			{ },
  8219			{ { 0, 123 } }
  8220		},
  8221		{
  8222			"JMP32_JGT_K: Large immediate",
  8223			.u.insns_int = {
  8224				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8225				BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
  8226				BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
  8227				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8228				BPF_EXIT_INSN(),
  8229			},
  8230			INTERNAL,
  8231			{ },
  8232			{ { 0, 0xfffffffe } }
  8233		},
  8234		/* BPF_JMP32 | BPF_JGT | BPF_X */
  8235		{
  8236			"JMP32_JGT_X",
  8237			.u.insns_int = {
  8238				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8239				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  8240				BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
  8241				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  8242				BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
  8243				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8244				BPF_EXIT_INSN(),
  8245			},
  8246			INTERNAL,
  8247			{ },
  8248			{ { 0, 0xfffffffe } }
  8249		},
  8250		/* BPF_JMP32 | BPF_JGE | BPF_K */
  8251		{
  8252			"JMP32_JGE_K: Small immediate",
  8253			.u.insns_int = {
  8254				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8255				BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
  8256				BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
  8257				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8258				BPF_EXIT_INSN(),
  8259			},
  8260			INTERNAL,
  8261			{ },
  8262			{ { 0, 123 } }
  8263		},
  8264		{
  8265			"JMP32_JGE_K: Large immediate",
  8266			.u.insns_int = {
  8267				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8268				BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
  8269				BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
  8270				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8271				BPF_EXIT_INSN(),
  8272			},
  8273			INTERNAL,
  8274			{ },
  8275			{ { 0, 0xfffffffe } }
  8276		},
  8277		/* BPF_JMP32 | BPF_JGE | BPF_X */
  8278		{
  8279			"JMP32_JGE_X",
  8280			.u.insns_int = {
  8281				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8282				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  8283				BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
  8284				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  8285				BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
  8286				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8287				BPF_EXIT_INSN(),
  8288			},
  8289			INTERNAL,
  8290			{ },
  8291			{ { 0, 0xfffffffe } }
  8292		},
  8293		/* BPF_JMP32 | BPF_JLT | BPF_K */
  8294		{
  8295			"JMP32_JLT_K: Small immediate",
  8296			.u.insns_int = {
  8297				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8298				BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
  8299				BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
  8300				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8301				BPF_EXIT_INSN(),
  8302			},
  8303			INTERNAL,
  8304			{ },
  8305			{ { 0, 123 } }
  8306		},
  8307		{
  8308			"JMP32_JLT_K: Large immediate",
  8309			.u.insns_int = {
  8310				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8311				BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
  8312				BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
  8313				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8314				BPF_EXIT_INSN(),
  8315			},
  8316			INTERNAL,
  8317			{ },
  8318			{ { 0, 0xfffffffe } }
  8319		},
  8320		/* BPF_JMP32 | BPF_JLT | BPF_X */
  8321		{
  8322			"JMP32_JLT_X",
  8323			.u.insns_int = {
  8324				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8325				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  8326				BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
  8327				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  8328				BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
  8329				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8330				BPF_EXIT_INSN(),
  8331			},
  8332			INTERNAL,
  8333			{ },
  8334			{ { 0, 0xfffffffe } }
  8335		},
  8336		/* BPF_JMP32 | BPF_JLE | BPF_K */
  8337		{
  8338			"JMP32_JLE_K: Small immediate",
  8339			.u.insns_int = {
  8340				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8341				BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
  8342				BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
  8343				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8344				BPF_EXIT_INSN(),
  8345			},
  8346			INTERNAL,
  8347			{ },
  8348			{ { 0, 123 } }
  8349		},
  8350		{
  8351			"JMP32_JLE_K: Large immediate",
  8352			.u.insns_int = {
  8353				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8354				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
  8355				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
  8356				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8357				BPF_EXIT_INSN(),
  8358			},
  8359			INTERNAL,
  8360			{ },
  8361			{ { 0, 0xfffffffe } }
  8362		},
  8363		/* BPF_JMP32 | BPF_JLE | BPF_X */
  8364		{
  8365			"JMP32_JLE_X",
  8366			.u.insns_int = {
  8367				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8368				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  8369				BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
  8370				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  8371				BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
  8372				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8373				BPF_EXIT_INSN(),
  8374			},
  8375			INTERNAL,
  8376			{ },
  8377			{ { 0, 0xfffffffe } }
  8378		},
  8379		/* BPF_JMP32 | BPF_JSGT | BPF_K */
  8380		{
  8381			"JMP32_JSGT_K: Small immediate",
  8382			.u.insns_int = {
  8383				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8384				BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
  8385				BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
  8386				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8387				BPF_EXIT_INSN(),
  8388			},
  8389			INTERNAL,
  8390			{ },
  8391			{ { 0, -123 } }
  8392		},
  8393		{
  8394			"JMP32_JSGT_K: Large immediate",
  8395			.u.insns_int = {
  8396				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8397				BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
  8398				BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
  8399				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8400				BPF_EXIT_INSN(),
  8401			},
  8402			INTERNAL,
  8403			{ },
  8404			{ { 0, -12345678 } }
  8405		},
  8406		/* BPF_JMP32 | BPF_JSGT | BPF_X */
  8407		{
  8408			"JMP32_JSGT_X",
  8409			.u.insns_int = {
  8410				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8411				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8412				BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
  8413				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  8414				BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
  8415				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8416				BPF_EXIT_INSN(),
  8417			},
  8418			INTERNAL,
  8419			{ },
  8420			{ { 0, -12345678 } }
  8421		},
  8422		/* BPF_JMP32 | BPF_JSGE | BPF_K */
  8423		{
  8424			"JMP32_JSGE_K: Small immediate",
  8425			.u.insns_int = {
  8426				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8427				BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
  8428				BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
  8429				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8430				BPF_EXIT_INSN(),
  8431			},
  8432			INTERNAL,
  8433			{ },
  8434			{ { 0, -123 } }
  8435		},
  8436		{
  8437			"JMP32_JSGE_K: Large immediate",
  8438			.u.insns_int = {
  8439				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8440				BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
  8441				BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
  8442				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8443				BPF_EXIT_INSN(),
  8444			},
  8445			INTERNAL,
  8446			{ },
  8447			{ { 0, -12345678 } }
  8448		},
  8449		/* BPF_JMP32 | BPF_JSGE | BPF_X */
  8450		{
  8451			"JMP32_JSGE_X",
  8452			.u.insns_int = {
  8453				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8454				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  8455				BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
  8456				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8457				BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
  8458				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8459				BPF_EXIT_INSN(),
  8460			},
  8461			INTERNAL,
  8462			{ },
  8463			{ { 0, -12345678 } }
  8464		},
  8465		/* BPF_JMP32 | BPF_JSLT | BPF_K */
  8466		{
  8467			"JMP32_JSLT_K: Small immediate",
  8468			.u.insns_int = {
  8469				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8470				BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
  8471				BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
  8472				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8473				BPF_EXIT_INSN(),
  8474			},
  8475			INTERNAL,
  8476			{ },
  8477			{ { 0, -123 } }
  8478		},
  8479		{
  8480			"JMP32_JSLT_K: Large immediate",
  8481			.u.insns_int = {
  8482				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8483				BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
  8484				BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
  8485				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8486				BPF_EXIT_INSN(),
  8487			},
  8488			INTERNAL,
  8489			{ },
  8490			{ { 0, -12345678 } }
  8491		},
  8492		/* BPF_JMP32 | BPF_JSLT | BPF_X */
  8493		{
  8494			"JMP32_JSLT_X",
  8495			.u.insns_int = {
  8496				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8497				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8498				BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
  8499				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  8500				BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
  8501				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8502				BPF_EXIT_INSN(),
  8503			},
  8504			INTERNAL,
  8505			{ },
  8506			{ { 0, -12345678 } }
  8507		},
  8508		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  8509		{
  8510			"JMP32_JSLE_K: Small immediate",
  8511			.u.insns_int = {
  8512				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8513				BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
  8514				BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
  8515				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8516				BPF_EXIT_INSN(),
  8517			},
  8518			INTERNAL,
  8519			{ },
  8520			{ { 0, -123 } }
  8521		},
  8522		{
  8523			"JMP32_JSLE_K: Large immediate",
  8524			.u.insns_int = {
  8525				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8526				BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
  8527				BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
  8528				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8529				BPF_EXIT_INSN(),
  8530			},
  8531			INTERNAL,
  8532			{ },
  8533			{ { 0, -12345678 } }
  8534		},
  8535		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  8536		{
  8537			"JMP32_JSLE_X",
  8538			.u.insns_int = {
  8539				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8540				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  8541				BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
  8542				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8543				BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
  8544				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8545				BPF_EXIT_INSN(),
  8546			},
  8547			INTERNAL,
  8548			{ },
  8549			{ { 0, -12345678 } }
  8550		},
  8551		/* BPF_JMP | BPF_EXIT */
  8552		{
  8553			"JMP_EXIT",
  8554			.u.insns_int = {
  8555				BPF_ALU32_IMM(BPF_MOV, R0, 0x4711),
  8556				BPF_EXIT_INSN(),
  8557				BPF_ALU32_IMM(BPF_MOV, R0, 0x4712),
  8558			},
  8559			INTERNAL,
  8560			{ },
  8561			{ { 0, 0x4711 } },
  8562		},
  8563		/* BPF_JMP | BPF_JA */
  8564		{
  8565			"JMP_JA: Unconditional jump: if (true) return 1",
  8566			.u.insns_int = {
  8567				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8568				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
  8569				BPF_EXIT_INSN(),
  8570				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8571				BPF_EXIT_INSN(),
  8572			},
  8573			INTERNAL,
  8574			{ },
  8575			{ { 0, 1 } },
  8576		},
  8577		/* BPF_JMP | BPF_JSLT | BPF_K */
  8578		{
  8579			"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
  8580			.u.insns_int = {
  8581				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8582				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8583				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8584				BPF_EXIT_INSN(),
  8585				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8586				BPF_EXIT_INSN(),
  8587			},
  8588			INTERNAL,
  8589			{ },
  8590			{ { 0, 1 } },
  8591		},
  8592		{
  8593			"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
  8594			.u.insns_int = {
  8595				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8596				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8597				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8598				BPF_EXIT_INSN(),
  8599				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8600				BPF_EXIT_INSN(),
  8601			},
  8602			INTERNAL,
  8603			{ },
  8604			{ { 0, 1 } },
  8605		},
  8606		/* BPF_JMP | BPF_JSGT | BPF_K */
  8607		{
  8608			"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
  8609			.u.insns_int = {
  8610				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8611				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8612				BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
  8613				BPF_EXIT_INSN(),
  8614				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8615				BPF_EXIT_INSN(),
  8616			},
  8617			INTERNAL,
  8618			{ },
  8619			{ { 0, 1 } },
  8620		},
  8621		{
  8622			"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
  8623			.u.insns_int = {
  8624				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8625				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8626				BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
  8627				BPF_EXIT_INSN(),
  8628				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8629				BPF_EXIT_INSN(),
  8630			},
  8631			INTERNAL,
  8632			{ },
  8633			{ { 0, 1 } },
  8634		},
  8635		/* BPF_JMP | BPF_JSLE | BPF_K */
  8636		{
  8637			"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
  8638			.u.insns_int = {
  8639				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8640				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8641				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8642				BPF_EXIT_INSN(),
  8643				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8644				BPF_EXIT_INSN(),
  8645			},
  8646			INTERNAL,
  8647			{ },
  8648			{ { 0, 1 } },
  8649		},
  8650		{
  8651			"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
  8652			.u.insns_int = {
  8653				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8654				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8655				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8656				BPF_EXIT_INSN(),
  8657				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8658				BPF_EXIT_INSN(),
  8659			},
  8660			INTERNAL,
  8661			{ },
  8662			{ { 0, 1 } },
  8663		},
  8664		{
  8665			"JMP_JSLE_K: Signed jump: value walk 1",
  8666			.u.insns_int = {
  8667				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8668				BPF_LD_IMM64(R1, 3),
  8669				BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
  8670				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8671				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8672				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8673				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8674				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8675				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8676				BPF_EXIT_INSN(),		/* bad exit */
  8677				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8678				BPF_EXIT_INSN(),
  8679			},
  8680			INTERNAL,
  8681			{ },
  8682			{ { 0, 1 } },
  8683		},
  8684		{
  8685			"JMP_JSLE_K: Signed jump: value walk 2",
  8686			.u.insns_int = {
  8687				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8688				BPF_LD_IMM64(R1, 3),
  8689				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8690				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8691				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8692				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8693				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8694				BPF_EXIT_INSN(),		/* bad exit */
  8695				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8696				BPF_EXIT_INSN(),
  8697			},
  8698			INTERNAL,
  8699			{ },
  8700			{ { 0, 1 } },
  8701		},
  8702		/* BPF_JMP | BPF_JSGE | BPF_K */
  8703		{
  8704			"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
  8705			.u.insns_int = {
  8706				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8707				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8708				BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
  8709				BPF_EXIT_INSN(),
  8710				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8711				BPF_EXIT_INSN(),
  8712			},
  8713			INTERNAL,
  8714			{ },
  8715			{ { 0, 1 } },
  8716		},
  8717		{
  8718			"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
  8719			.u.insns_int = {
  8720				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8721				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8722				BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
  8723				BPF_EXIT_INSN(),
  8724				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8725				BPF_EXIT_INSN(),
  8726			},
  8727			INTERNAL,
  8728			{ },
  8729			{ { 0, 1 } },
  8730		},
  8731		{
  8732			"JMP_JSGE_K: Signed jump: value walk 1",
  8733			.u.insns_int = {
  8734				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8735				BPF_LD_IMM64(R1, -3),
  8736				BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
  8737				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8738				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8739				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8740				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8741				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8742				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8743				BPF_EXIT_INSN(),		/* bad exit */
  8744				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8745				BPF_EXIT_INSN(),
  8746			},
  8747			INTERNAL,
  8748			{ },
  8749			{ { 0, 1 } },
  8750		},
  8751		{
  8752			"JMP_JSGE_K: Signed jump: value walk 2",
  8753			.u.insns_int = {
  8754				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8755				BPF_LD_IMM64(R1, -3),
  8756				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8757				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8758				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8759				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8760				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8761				BPF_EXIT_INSN(),		/* bad exit */
  8762				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8763				BPF_EXIT_INSN(),
  8764			},
  8765			INTERNAL,
  8766			{ },
  8767			{ { 0, 1 } },
  8768		},
  8769		/* BPF_JMP | BPF_JGT | BPF_K */
  8770		{
  8771			"JMP_JGT_K: if (3 > 2) return 1",
  8772			.u.insns_int = {
  8773				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8774				BPF_LD_IMM64(R1, 3),
  8775				BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
  8776				BPF_EXIT_INSN(),
  8777				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8778				BPF_EXIT_INSN(),
  8779			},
  8780			INTERNAL,
  8781			{ },
  8782			{ { 0, 1 } },
  8783		},
  8784		{
  8785			"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
  8786			.u.insns_int = {
  8787				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8788				BPF_LD_IMM64(R1, -1),
  8789				BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
  8790				BPF_EXIT_INSN(),
  8791				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8792				BPF_EXIT_INSN(),
  8793			},
  8794			INTERNAL,
  8795			{ },
  8796			{ { 0, 1 } },
  8797		},
  8798		/* BPF_JMP | BPF_JLT | BPF_K */
  8799		{
  8800			"JMP_JLT_K: if (2 < 3) return 1",
  8801			.u.insns_int = {
  8802				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8803				BPF_LD_IMM64(R1, 2),
  8804				BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
  8805				BPF_EXIT_INSN(),
  8806				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8807				BPF_EXIT_INSN(),
  8808			},
  8809			INTERNAL,
  8810			{ },
  8811			{ { 0, 1 } },
  8812		},
  8813		{
  8814			"JMP_JGT_K: Unsigned jump: if (1 < -1) return 1",
  8815			.u.insns_int = {
  8816				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8817				BPF_LD_IMM64(R1, 1),
  8818				BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
  8819				BPF_EXIT_INSN(),
  8820				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8821				BPF_EXIT_INSN(),
  8822			},
  8823			INTERNAL,
  8824			{ },
  8825			{ { 0, 1 } },
  8826		},
  8827		/* BPF_JMP | BPF_JGE | BPF_K */
  8828		{
  8829			"JMP_JGE_K: if (3 >= 2) return 1",
  8830			.u.insns_int = {
  8831				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8832				BPF_LD_IMM64(R1, 3),
  8833				BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
  8834				BPF_EXIT_INSN(),
  8835				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8836				BPF_EXIT_INSN(),
  8837			},
  8838			INTERNAL,
  8839			{ },
  8840			{ { 0, 1 } },
  8841		},
  8842		/* BPF_JMP | BPF_JLE | BPF_K */
  8843		{
  8844			"JMP_JLE_K: if (2 <= 3) return 1",
  8845			.u.insns_int = {
  8846				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8847				BPF_LD_IMM64(R1, 2),
  8848				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8849				BPF_EXIT_INSN(),
  8850				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8851				BPF_EXIT_INSN(),
  8852			},
  8853			INTERNAL,
  8854			{ },
  8855			{ { 0, 1 } },
  8856		},
  8857		/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
  8858		{
  8859			"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
  8860			.u.insns_int = {
  8861				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8862				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8863				BPF_EXIT_INSN(),
  8864				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8865				BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
  8866				BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
  8867				BPF_EXIT_INSN(),
  8868			},
  8869			INTERNAL,
  8870			{ },
  8871			{ { 0, 1 } },
  8872		},
  8873		{
  8874			"JMP_JGE_K: if (3 >= 3) return 1",
  8875			.u.insns_int = {
  8876				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8877				BPF_LD_IMM64(R1, 3),
  8878				BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
  8879				BPF_EXIT_INSN(),
  8880				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8881				BPF_EXIT_INSN(),
  8882			},
  8883			INTERNAL,
  8884			{ },
  8885			{ { 0, 1 } },
  8886		},
  8887		/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
  8888		{
  8889			"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
  8890			.u.insns_int = {
  8891				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8892				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8893				BPF_EXIT_INSN(),
  8894				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8895				BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
  8896				BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
  8897				BPF_EXIT_INSN(),
  8898			},
  8899			INTERNAL,
  8900			{ },
  8901			{ { 0, 1 } },
  8902		},
  8903		{
  8904			"JMP_JLE_K: if (3 <= 3) return 1",
  8905			.u.insns_int = {
  8906				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8907				BPF_LD_IMM64(R1, 3),
  8908				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8909				BPF_EXIT_INSN(),
  8910				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8911				BPF_EXIT_INSN(),
  8912			},
  8913			INTERNAL,
  8914			{ },
  8915			{ { 0, 1 } },
  8916		},
  8917		/* BPF_JMP | BPF_JNE | BPF_K */
  8918		{
  8919			"JMP_JNE_K: if (3 != 2) return 1",
  8920			.u.insns_int = {
  8921				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8922				BPF_LD_IMM64(R1, 3),
  8923				BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
  8924				BPF_EXIT_INSN(),
  8925				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8926				BPF_EXIT_INSN(),
  8927			},
  8928			INTERNAL,
  8929			{ },
  8930			{ { 0, 1 } },
  8931		},
  8932		/* BPF_JMP | BPF_JEQ | BPF_K */
  8933		{
  8934			"JMP_JEQ_K: if (3 == 3) return 1",
  8935			.u.insns_int = {
  8936				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8937				BPF_LD_IMM64(R1, 3),
  8938				BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
  8939				BPF_EXIT_INSN(),
  8940				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8941				BPF_EXIT_INSN(),
  8942			},
  8943			INTERNAL,
  8944			{ },
  8945			{ { 0, 1 } },
  8946		},
  8947		/* BPF_JMP | BPF_JSET | BPF_K */
  8948		{
  8949			"JMP_JSET_K: if (0x3 & 0x2) return 1",
  8950			.u.insns_int = {
  8951				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8952				BPF_LD_IMM64(R1, 3),
  8953				BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
  8954				BPF_EXIT_INSN(),
  8955				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8956				BPF_EXIT_INSN(),
  8957			},
  8958			INTERNAL,
  8959			{ },
  8960			{ { 0, 1 } },
  8961		},
  8962		{
  8963			"JMP_JSET_K: if (0x3 & 0xffffffff) return 1",
  8964			.u.insns_int = {
  8965				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8966				BPF_LD_IMM64(R1, 3),
  8967				BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
  8968				BPF_EXIT_INSN(),
  8969				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8970				BPF_EXIT_INSN(),
  8971			},
  8972			INTERNAL,
  8973			{ },
  8974			{ { 0, 1 } },
  8975		},
  8976		/* BPF_JMP | BPF_JSGT | BPF_X */
  8977		{
  8978			"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
  8979			.u.insns_int = {
  8980				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8981				BPF_LD_IMM64(R1, -1),
  8982				BPF_LD_IMM64(R2, -2),
  8983				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8984				BPF_EXIT_INSN(),
  8985				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8986				BPF_EXIT_INSN(),
  8987			},
  8988			INTERNAL,
  8989			{ },
  8990			{ { 0, 1 } },
  8991		},
  8992		{
  8993			"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
  8994			.u.insns_int = {
  8995				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8996				BPF_LD_IMM64(R1, -1),
  8997				BPF_LD_IMM64(R2, -1),
  8998				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8999				BPF_EXIT_INSN(),
  9000				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9001				BPF_EXIT_INSN(),
  9002			},
  9003			INTERNAL,
  9004			{ },
  9005			{ { 0, 1 } },
  9006		},
  9007		/* BPF_JMP | BPF_JSLT | BPF_X */
  9008		{
  9009			"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
  9010			.u.insns_int = {
  9011				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9012				BPF_LD_IMM64(R1, -1),
  9013				BPF_LD_IMM64(R2, -2),
  9014				BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
  9015				BPF_EXIT_INSN(),
  9016				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9017				BPF_EXIT_INSN(),
  9018			},
  9019			INTERNAL,
  9020			{ },
  9021			{ { 0, 1 } },
  9022		},
  9023		{
  9024			"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
  9025			.u.insns_int = {
  9026				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9027				BPF_LD_IMM64(R1, -1),
  9028				BPF_LD_IMM64(R2, -1),
  9029				BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
  9030				BPF_EXIT_INSN(),
  9031				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9032				BPF_EXIT_INSN(),
  9033			},
  9034			INTERNAL,
  9035			{ },
  9036			{ { 0, 1 } },
  9037		},
  9038		/* BPF_JMP | BPF_JSGE | BPF_X */
  9039		{
  9040			"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
  9041			.u.insns_int = {
  9042				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9043				BPF_LD_IMM64(R1, -1),
  9044				BPF_LD_IMM64(R2, -2),
  9045				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  9046				BPF_EXIT_INSN(),
  9047				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9048				BPF_EXIT_INSN(),
  9049			},
  9050			INTERNAL,
  9051			{ },
  9052			{ { 0, 1 } },
  9053		},
  9054		{
  9055			"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
  9056			.u.insns_int = {
  9057				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9058				BPF_LD_IMM64(R1, -1),
  9059				BPF_LD_IMM64(R2, -1),
  9060				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  9061				BPF_EXIT_INSN(),
  9062				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9063				BPF_EXIT_INSN(),
  9064			},
  9065			INTERNAL,
  9066			{ },
  9067			{ { 0, 1 } },
  9068		},
  9069		/* BPF_JMP | BPF_JSLE | BPF_X */
  9070		{
  9071			"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
  9072			.u.insns_int = {
  9073				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9074				BPF_LD_IMM64(R1, -1),
  9075				BPF_LD_IMM64(R2, -2),
  9076				BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
  9077				BPF_EXIT_INSN(),
  9078				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9079				BPF_EXIT_INSN(),
  9080			},
  9081			INTERNAL,
  9082			{ },
  9083			{ { 0, 1 } },
  9084		},
  9085		{
  9086			"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
  9087			.u.insns_int = {
  9088				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9089				BPF_LD_IMM64(R1, -1),
  9090				BPF_LD_IMM64(R2, -1),
  9091				BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
  9092				BPF_EXIT_INSN(),
  9093				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9094				BPF_EXIT_INSN(),
  9095			},
  9096			INTERNAL,
  9097			{ },
  9098			{ { 0, 1 } },
  9099		},
  9100		/* BPF_JMP | BPF_JGT | BPF_X */
  9101		{
  9102			"JMP_JGT_X: if (3 > 2) return 1",
  9103			.u.insns_int = {
  9104				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9105				BPF_LD_IMM64(R1, 3),
  9106				BPF_LD_IMM64(R2, 2),
  9107				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  9108				BPF_EXIT_INSN(),
  9109				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9110				BPF_EXIT_INSN(),
  9111			},
  9112			INTERNAL,
  9113			{ },
  9114			{ { 0, 1 } },
  9115		},
  9116		{
  9117			"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
  9118			.u.insns_int = {
  9119				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9120				BPF_LD_IMM64(R1, -1),
  9121				BPF_LD_IMM64(R2, 1),
  9122				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  9123				BPF_EXIT_INSN(),
  9124				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9125				BPF_EXIT_INSN(),
  9126			},
  9127			INTERNAL,
  9128			{ },
  9129			{ { 0, 1 } },
  9130		},
  9131		/* BPF_JMP | BPF_JLT | BPF_X */
  9132		{
  9133			"JMP_JLT_X: if (2 < 3) return 1",
  9134			.u.insns_int = {
  9135				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9136				BPF_LD_IMM64(R1, 3),
  9137				BPF_LD_IMM64(R2, 2),
  9138				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  9139				BPF_EXIT_INSN(),
  9140				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9141				BPF_EXIT_INSN(),
  9142			},
  9143			INTERNAL,
  9144			{ },
  9145			{ { 0, 1 } },
  9146		},
  9147		{
  9148			"JMP_JLT_X: Unsigned jump: if (1 < -1) return 1",
  9149			.u.insns_int = {
  9150				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9151				BPF_LD_IMM64(R1, -1),
  9152				BPF_LD_IMM64(R2, 1),
  9153				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  9154				BPF_EXIT_INSN(),
  9155				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9156				BPF_EXIT_INSN(),
  9157			},
  9158			INTERNAL,
  9159			{ },
  9160			{ { 0, 1 } },
  9161		},
  9162		/* BPF_JMP | BPF_JGE | BPF_X */
  9163		{
  9164			"JMP_JGE_X: if (3 >= 2) return 1",
  9165			.u.insns_int = {
  9166				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9167				BPF_LD_IMM64(R1, 3),
  9168				BPF_LD_IMM64(R2, 2),
  9169				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  9170				BPF_EXIT_INSN(),
  9171				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9172				BPF_EXIT_INSN(),
  9173			},
  9174			INTERNAL,
  9175			{ },
  9176			{ { 0, 1 } },
  9177		},
  9178		{
  9179			"JMP_JGE_X: if (3 >= 3) return 1",
  9180			.u.insns_int = {
  9181				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9182				BPF_LD_IMM64(R1, 3),
  9183				BPF_LD_IMM64(R2, 3),
  9184				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  9185				BPF_EXIT_INSN(),
  9186				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9187				BPF_EXIT_INSN(),
  9188			},
  9189			INTERNAL,
  9190			{ },
  9191			{ { 0, 1 } },
  9192		},
  9193		/* BPF_JMP | BPF_JLE | BPF_X */
  9194		{
  9195			"JMP_JLE_X: if (2 <= 3) return 1",
  9196			.u.insns_int = {
  9197				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9198				BPF_LD_IMM64(R1, 3),
  9199				BPF_LD_IMM64(R2, 2),
  9200				BPF_JMP_REG(BPF_JLE, R2, R1, 1),
  9201				BPF_EXIT_INSN(),
  9202				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9203				BPF_EXIT_INSN(),
  9204			},
  9205			INTERNAL,
  9206			{ },
  9207			{ { 0, 1 } },
  9208		},
  9209		{
  9210			"JMP_JLE_X: if (3 <= 3) return 1",
  9211			.u.insns_int = {
  9212				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9213				BPF_LD_IMM64(R1, 3),
  9214				BPF_LD_IMM64(R2, 3),
  9215				BPF_JMP_REG(BPF_JLE, R1, R2, 1),
  9216				BPF_EXIT_INSN(),
  9217				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9218				BPF_EXIT_INSN(),
  9219			},
  9220			INTERNAL,
  9221			{ },
  9222			{ { 0, 1 } },
  9223		},
  9224		{
  9225			/* Mainly testing JIT + imm64 here. */
  9226			"JMP_JGE_X: ldimm64 test 1",
  9227			.u.insns_int = {
  9228				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9229				BPF_LD_IMM64(R1, 3),
  9230				BPF_LD_IMM64(R2, 2),
  9231				BPF_JMP_REG(BPF_JGE, R1, R2, 2),
  9232				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9233				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  9234				BPF_EXIT_INSN(),
  9235			},
  9236			INTERNAL,
  9237			{ },
  9238			{ { 0, 0xeeeeeeeeU } },
  9239		},
  9240		{
  9241			"JMP_JGE_X: ldimm64 test 2",
  9242			.u.insns_int = {
  9243				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9244				BPF_LD_IMM64(R1, 3),
  9245				BPF_LD_IMM64(R2, 2),
  9246				BPF_JMP_REG(BPF_JGE, R1, R2, 0),
  9247				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9248				BPF_EXIT_INSN(),
  9249			},
  9250			INTERNAL,
  9251			{ },
  9252			{ { 0, 0xffffffffU } },
  9253		},
  9254		{
  9255			"JMP_JGE_X: ldimm64 test 3",
  9256			.u.insns_int = {
  9257				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9258				BPF_LD_IMM64(R1, 3),
  9259				BPF_LD_IMM64(R2, 2),
  9260				BPF_JMP_REG(BPF_JGE, R1, R2, 4),
  9261				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9262				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  9263				BPF_EXIT_INSN(),
  9264			},
  9265			INTERNAL,
  9266			{ },
  9267			{ { 0, 1 } },
  9268		},
  9269		{
  9270			"JMP_JLE_X: ldimm64 test 1",
  9271			.u.insns_int = {
  9272				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9273				BPF_LD_IMM64(R1, 3),
  9274				BPF_LD_IMM64(R2, 2),
  9275				BPF_JMP_REG(BPF_JLE, R2, R1, 2),
  9276				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9277				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  9278				BPF_EXIT_INSN(),
  9279			},
  9280			INTERNAL,
  9281			{ },
  9282			{ { 0, 0xeeeeeeeeU } },
  9283		},
  9284		{
  9285			"JMP_JLE_X: ldimm64 test 2",
  9286			.u.insns_int = {
  9287				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9288				BPF_LD_IMM64(R1, 3),
  9289				BPF_LD_IMM64(R2, 2),
  9290				BPF_JMP_REG(BPF_JLE, R2, R1, 0),
  9291				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9292				BPF_EXIT_INSN(),
  9293			},
  9294			INTERNAL,
  9295			{ },
  9296			{ { 0, 0xffffffffU } },
  9297		},
  9298		{
  9299			"JMP_JLE_X: ldimm64 test 3",
  9300			.u.insns_int = {
  9301				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9302				BPF_LD_IMM64(R1, 3),
  9303				BPF_LD_IMM64(R2, 2),
  9304				BPF_JMP_REG(BPF_JLE, R2, R1, 4),
  9305				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  9306				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  9307				BPF_EXIT_INSN(),
  9308			},
  9309			INTERNAL,
  9310			{ },
  9311			{ { 0, 1 } },
  9312		},
  9313		/* BPF_JMP | BPF_JNE | BPF_X */
  9314		{
  9315			"JMP_JNE_X: if (3 != 2) return 1",
  9316			.u.insns_int = {
  9317				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9318				BPF_LD_IMM64(R1, 3),
  9319				BPF_LD_IMM64(R2, 2),
  9320				BPF_JMP_REG(BPF_JNE, R1, R2, 1),
  9321				BPF_EXIT_INSN(),
  9322				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9323				BPF_EXIT_INSN(),
  9324			},
  9325			INTERNAL,
  9326			{ },
  9327			{ { 0, 1 } },
  9328		},
  9329		/* BPF_JMP | BPF_JEQ | BPF_X */
  9330		{
  9331			"JMP_JEQ_X: if (3 == 3) return 1",
  9332			.u.insns_int = {
  9333				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9334				BPF_LD_IMM64(R1, 3),
  9335				BPF_LD_IMM64(R2, 3),
  9336				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  9337				BPF_EXIT_INSN(),
  9338				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9339				BPF_EXIT_INSN(),
  9340			},
  9341			INTERNAL,
  9342			{ },
  9343			{ { 0, 1 } },
  9344		},
  9345		/* BPF_JMP | BPF_JSET | BPF_X */
  9346		{
  9347			"JMP_JSET_X: if (0x3 & 0x2) return 1",
  9348			.u.insns_int = {
  9349				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9350				BPF_LD_IMM64(R1, 3),
  9351				BPF_LD_IMM64(R2, 2),
  9352				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  9353				BPF_EXIT_INSN(),
  9354				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9355				BPF_EXIT_INSN(),
  9356			},
  9357			INTERNAL,
  9358			{ },
  9359			{ { 0, 1 } },
  9360		},
  9361		{
  9362			"JMP_JSET_X: if (0x3 & 0xffffffff) return 1",
  9363			.u.insns_int = {
  9364				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9365				BPF_LD_IMM64(R1, 3),
  9366				BPF_LD_IMM64(R2, 0xffffffff),
  9367				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  9368				BPF_EXIT_INSN(),
  9369				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9370				BPF_EXIT_INSN(),
  9371			},
  9372			INTERNAL,
  9373			{ },
  9374			{ { 0, 1 } },
  9375		},
  9376		{
  9377			"JMP_JA: Jump, gap, jump, ...",
  9378			{ },
  9379			CLASSIC | FLAG_NO_DATA,
  9380			{ },
  9381			{ { 0, 0xababcbac } },
  9382			.fill_helper = bpf_fill_ja,
  9383		},
  9384		{	/* Mainly checking JIT here. */
  9385			"BPF_MAXINSNS: Maximum possible literals",
  9386			{ },
  9387			CLASSIC | FLAG_NO_DATA,
  9388			{ },
  9389			{ { 0, 0xffffffff } },
  9390			.fill_helper = bpf_fill_maxinsns1,
  9391		},
  9392		{	/* Mainly checking JIT here. */
  9393			"BPF_MAXINSNS: Single literal",
  9394			{ },
  9395			CLASSIC | FLAG_NO_DATA,
  9396			{ },
  9397			{ { 0, 0xfefefefe } },
  9398			.fill_helper = bpf_fill_maxinsns2,
  9399		},
  9400		{	/* Mainly checking JIT here. */
  9401			"BPF_MAXINSNS: Run/add until end",
  9402			{ },
  9403			CLASSIC | FLAG_NO_DATA,
  9404			{ },
  9405			{ { 0, 0x947bf368 } },
  9406			.fill_helper = bpf_fill_maxinsns3,
  9407		},
  9408		{
  9409			"BPF_MAXINSNS: Too many instructions",
  9410			{ },
  9411			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  9412			{ },
  9413			{ },
  9414			.fill_helper = bpf_fill_maxinsns4,
  9415			.expected_errcode = -EINVAL,
  9416		},
  9417		{	/* Mainly checking JIT here. */
  9418			"BPF_MAXINSNS: Very long jump",
  9419			{ },
  9420			CLASSIC | FLAG_NO_DATA,
  9421			{ },
  9422			{ { 0, 0xabababab } },
  9423			.fill_helper = bpf_fill_maxinsns5,
  9424		},
  9425		{	/* Mainly checking JIT here. */
  9426			"BPF_MAXINSNS: Ctx heavy transformations",
  9427			{ },
  9428			CLASSIC,
  9429			{ },
  9430			{
  9431				{  1, SKB_VLAN_PRESENT },
  9432				{ 10, SKB_VLAN_PRESENT }
  9433			},
  9434			.fill_helper = bpf_fill_maxinsns6,
  9435		},
  9436		{	/* Mainly checking JIT here. */
  9437			"BPF_MAXINSNS: Call heavy transformations",
  9438			{ },
  9439			CLASSIC | FLAG_NO_DATA,
  9440			{ },
  9441			{ { 1, 0 }, { 10, 0 } },
  9442			.fill_helper = bpf_fill_maxinsns7,
  9443		},
  9444		{	/* Mainly checking JIT here. */
  9445			"BPF_MAXINSNS: Jump heavy test",
  9446			{ },
  9447			CLASSIC | FLAG_NO_DATA,
  9448			{ },
  9449			{ { 0, 0xffffffff } },
  9450			.fill_helper = bpf_fill_maxinsns8,
  9451		},
  9452		{	/* Mainly checking JIT here. */
  9453			"BPF_MAXINSNS: Very long jump backwards",
  9454			{ },
  9455			INTERNAL | FLAG_NO_DATA,
  9456			{ },
  9457			{ { 0, 0xcbababab } },
  9458			.fill_helper = bpf_fill_maxinsns9,
  9459		},
  9460		{	/* Mainly checking JIT here. */
  9461			"BPF_MAXINSNS: Edge hopping nuthouse",
  9462			{ },
  9463			INTERNAL | FLAG_NO_DATA,
  9464			{ },
  9465			{ { 0, 0xabababac } },
  9466			.fill_helper = bpf_fill_maxinsns10,
  9467		},
  9468		{
  9469			"BPF_MAXINSNS: Jump, gap, jump, ...",
  9470			{ },
  9471			CLASSIC | FLAG_NO_DATA,
  9472			{ },
  9473			{ { 0, 0xababcbac } },
  9474			.fill_helper = bpf_fill_maxinsns11,
  9475		},
  9476		{
  9477			"BPF_MAXINSNS: jump over MSH",
  9478			{ },
  9479			CLASSIC | FLAG_EXPECTED_FAIL,
  9480			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  9481			{ { 4, 0xabababab } },
  9482			.fill_helper = bpf_fill_maxinsns12,
  9483			.expected_errcode = -EINVAL,
  9484		},
  9485		{
  9486			"BPF_MAXINSNS: exec all MSH",
  9487			{ },
  9488			CLASSIC,
  9489			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  9490			{ { 4, 0xababab83 } },
  9491			.fill_helper = bpf_fill_maxinsns13,
  9492		},
  9493		{
  9494			"BPF_MAXINSNS: ld_abs+get_processor_id",
  9495			{ },
  9496			CLASSIC,
  9497			{ },
  9498			{ { 1, 0xbee } },
  9499			.fill_helper = bpf_fill_ld_abs_get_processor_id,
  9500		},
  9501		/*
  9502		 * LD_IND / LD_ABS on fragmented SKBs
  9503		 */
  9504		{
  9505			"LD_IND byte frag",
  9506			.u.insns = {
  9507				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9508				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x0),
  9509				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9510			},
  9511			CLASSIC | FLAG_SKB_FRAG,
  9512			{ },
  9513			{ {0x40, 0x42} },
  9514			.frag_data = {
  9515				0x42, 0x00, 0x00, 0x00,
  9516				0x43, 0x44, 0x00, 0x00,
  9517				0x21, 0x07, 0x19, 0x83,
  9518			},
  9519		},
  9520		{
  9521			"LD_IND halfword frag",
  9522			.u.insns = {
  9523				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9524				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x4),
  9525				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9526			},
  9527			CLASSIC | FLAG_SKB_FRAG,
  9528			{ },
  9529			{ {0x40, 0x4344} },
  9530			.frag_data = {
  9531				0x42, 0x00, 0x00, 0x00,
  9532				0x43, 0x44, 0x00, 0x00,
  9533				0x21, 0x07, 0x19, 0x83,
  9534			},
  9535		},
  9536		{
  9537			"LD_IND word frag",
  9538			.u.insns = {
  9539				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9540				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x8),
  9541				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9542			},
  9543			CLASSIC | FLAG_SKB_FRAG,
  9544			{ },
  9545			{ {0x40, 0x21071983} },
  9546			.frag_data = {
  9547				0x42, 0x00, 0x00, 0x00,
  9548				0x43, 0x44, 0x00, 0x00,
  9549				0x21, 0x07, 0x19, 0x83,
  9550			},
  9551		},
  9552		{
  9553			"LD_IND halfword mixed head/frag",
  9554			.u.insns = {
  9555				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9556				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  9557				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9558			},
  9559			CLASSIC | FLAG_SKB_FRAG,
  9560			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9561			{ {0x40, 0x0519} },
  9562			.frag_data = { 0x19, 0x82 },
  9563		},
  9564		{
  9565			"LD_IND word mixed head/frag",
  9566			.u.insns = {
  9567				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9568				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9569				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9570			},
  9571			CLASSIC | FLAG_SKB_FRAG,
  9572			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9573			{ {0x40, 0x25051982} },
  9574			.frag_data = { 0x19, 0x82 },
  9575		},
  9576		{
  9577			"LD_ABS byte frag",
  9578			.u.insns = {
  9579				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x40),
  9580				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9581			},
  9582			CLASSIC | FLAG_SKB_FRAG,
  9583			{ },
  9584			{ {0x40, 0x42} },
  9585			.frag_data = {
  9586				0x42, 0x00, 0x00, 0x00,
  9587				0x43, 0x44, 0x00, 0x00,
  9588				0x21, 0x07, 0x19, 0x83,
  9589			},
  9590		},
  9591		{
  9592			"LD_ABS halfword frag",
  9593			.u.insns = {
  9594				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x44),
  9595				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9596			},
  9597			CLASSIC | FLAG_SKB_FRAG,
  9598			{ },
  9599			{ {0x40, 0x4344} },
  9600			.frag_data = {
  9601				0x42, 0x00, 0x00, 0x00,
  9602				0x43, 0x44, 0x00, 0x00,
  9603				0x21, 0x07, 0x19, 0x83,
  9604			},
  9605		},
  9606		{
  9607			"LD_ABS word frag",
  9608			.u.insns = {
  9609				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x48),
  9610				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9611			},
  9612			CLASSIC | FLAG_SKB_FRAG,
  9613			{ },
  9614			{ {0x40, 0x21071983} },
  9615			.frag_data = {
  9616				0x42, 0x00, 0x00, 0x00,
  9617				0x43, 0x44, 0x00, 0x00,
  9618				0x21, 0x07, 0x19, 0x83,
  9619			},
  9620		},
  9621		{
  9622			"LD_ABS halfword mixed head/frag",
  9623			.u.insns = {
  9624				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  9625				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9626			},
  9627			CLASSIC | FLAG_SKB_FRAG,
  9628			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9629			{ {0x40, 0x0519} },
  9630			.frag_data = { 0x19, 0x82 },
  9631		},
  9632		{
  9633			"LD_ABS word mixed head/frag",
  9634			.u.insns = {
  9635				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3e),
  9636				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9637			},
  9638			CLASSIC | FLAG_SKB_FRAG,
  9639			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9640			{ {0x40, 0x25051982} },
  9641			.frag_data = { 0x19, 0x82 },
  9642		},
  9643		/*
  9644		 * LD_IND / LD_ABS on non fragmented SKBs
  9645		 */
  9646		{
  9647			/*
  9648			 * this tests that the JIT/interpreter correctly resets X
  9649			 * before using it in an LD_IND instruction.
  9650			 */
  9651			"LD_IND byte default X",
  9652			.u.insns = {
  9653				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9654				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9655			},
  9656			CLASSIC,
  9657			{ [0x1] = 0x42 },
  9658			{ {0x40, 0x42 } },
  9659		},
  9660		{
  9661			"LD_IND byte positive offset",
  9662			.u.insns = {
  9663				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9664				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9665				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9666			},
  9667			CLASSIC,
  9668			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9669			{ {0x40, 0x82 } },
  9670		},
  9671		{
  9672			"LD_IND byte negative offset",
  9673			.u.insns = {
  9674				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9675				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x1),
  9676				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9677			},
  9678			CLASSIC,
  9679			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9680			{ {0x40, 0x05 } },
  9681		},
  9682		{
  9683			"LD_IND byte positive offset, all ff",
  9684			.u.insns = {
  9685				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9686				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9687				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9688			},
  9689			CLASSIC,
  9690			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9691			{ {0x40, 0xff } },
  9692		},
  9693		{
  9694			"LD_IND byte positive offset, out of bounds",
  9695			.u.insns = {
  9696				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9697				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9698				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9699			},
  9700			CLASSIC,
  9701			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9702			{ {0x3f, 0 }, },
  9703		},
  9704		{
  9705			"LD_IND byte negative offset, out of bounds",
  9706			.u.insns = {
  9707				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9708				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x3f),
  9709				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9710			},
  9711			CLASSIC,
  9712			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9713			{ {0x3f, 0 } },
  9714		},
  9715		{
  9716			"LD_IND byte negative offset, multiple calls",
  9717			.u.insns = {
  9718				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9719				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 1),
  9720				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 2),
  9721				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 3),
  9722				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 4),
  9723				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9724			},
  9725			CLASSIC,
  9726			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9727			{ {0x40, 0x82 }, },
  9728		},
  9729		{
  9730			"LD_IND halfword positive offset",
  9731			.u.insns = {
  9732				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9733				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x2),
  9734				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9735			},
  9736			CLASSIC,
  9737			{
  9738				[0x1c] = 0xaa, [0x1d] = 0x55,
  9739				[0x1e] = 0xbb, [0x1f] = 0x66,
  9740				[0x20] = 0xcc, [0x21] = 0x77,
  9741				[0x22] = 0xdd, [0x23] = 0x88,
  9742			},
  9743			{ {0x40, 0xdd88 } },
  9744		},
  9745		{
  9746			"LD_IND halfword negative offset",
  9747			.u.insns = {
  9748				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9749				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x2),
  9750				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9751			},
  9752			CLASSIC,
  9753			{
  9754				[0x1c] = 0xaa, [0x1d] = 0x55,
  9755				[0x1e] = 0xbb, [0x1f] = 0x66,
  9756				[0x20] = 0xcc, [0x21] = 0x77,
  9757				[0x22] = 0xdd, [0x23] = 0x88,
  9758			},
  9759			{ {0x40, 0xbb66 } },
  9760		},
  9761		{
  9762			"LD_IND halfword unaligned",
  9763			.u.insns = {
  9764				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9765				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  9766				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9767			},
  9768			CLASSIC,
  9769			{
  9770				[0x1c] = 0xaa, [0x1d] = 0x55,
  9771				[0x1e] = 0xbb, [0x1f] = 0x66,
  9772				[0x20] = 0xcc, [0x21] = 0x77,
  9773				[0x22] = 0xdd, [0x23] = 0x88,
  9774			},
  9775			{ {0x40, 0x66cc } },
  9776		},
  9777		{
  9778			"LD_IND halfword positive offset, all ff",
  9779			.u.insns = {
  9780				BPF_STMT(BPF_LDX | BPF_IMM, 0x3d),
  9781				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9782				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9783			},
  9784			CLASSIC,
  9785			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9786			{ {0x40, 0xffff } },
  9787		},
  9788		{
  9789			"LD_IND halfword positive offset, out of bounds",
  9790			.u.insns = {
  9791				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9792				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9793				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9794			},
  9795			CLASSIC,
  9796			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9797			{ {0x3f, 0 }, },
  9798		},
  9799		{
  9800			"LD_IND halfword negative offset, out of bounds",
  9801			.u.insns = {
  9802				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9803				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x3f),
  9804				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9805			},
  9806			CLASSIC,
  9807			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9808			{ {0x3f, 0 } },
  9809		},
  9810		{
  9811			"LD_IND word positive offset",
  9812			.u.insns = {
  9813				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9814				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x4),
  9815				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9816			},
  9817			CLASSIC,
  9818			{
  9819				[0x1c] = 0xaa, [0x1d] = 0x55,
  9820				[0x1e] = 0xbb, [0x1f] = 0x66,
  9821				[0x20] = 0xcc, [0x21] = 0x77,
  9822				[0x22] = 0xdd, [0x23] = 0x88,
  9823				[0x24] = 0xee, [0x25] = 0x99,
  9824				[0x26] = 0xff, [0x27] = 0xaa,
  9825			},
  9826			{ {0x40, 0xee99ffaa } },
  9827		},
  9828		{
  9829			"LD_IND word negative offset",
  9830			.u.insns = {
  9831				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9832				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x4),
  9833				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9834			},
  9835			CLASSIC,
  9836			{
  9837				[0x1c] = 0xaa, [0x1d] = 0x55,
  9838				[0x1e] = 0xbb, [0x1f] = 0x66,
  9839				[0x20] = 0xcc, [0x21] = 0x77,
  9840				[0x22] = 0xdd, [0x23] = 0x88,
  9841				[0x24] = 0xee, [0x25] = 0x99,
  9842				[0x26] = 0xff, [0x27] = 0xaa,
  9843			},
  9844			{ {0x40, 0xaa55bb66 } },
  9845		},
  9846		{
  9847			"LD_IND word unaligned (addr & 3 == 2)",
  9848			.u.insns = {
  9849				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9850				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9851				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9852			},
  9853			CLASSIC,
  9854			{
  9855				[0x1c] = 0xaa, [0x1d] = 0x55,
  9856				[0x1e] = 0xbb, [0x1f] = 0x66,
  9857				[0x20] = 0xcc, [0x21] = 0x77,
  9858				[0x22] = 0xdd, [0x23] = 0x88,
  9859				[0x24] = 0xee, [0x25] = 0x99,
  9860				[0x26] = 0xff, [0x27] = 0xaa,
  9861			},
  9862			{ {0x40, 0xbb66cc77 } },
  9863		},
  9864		{
  9865			"LD_IND word unaligned (addr & 3 == 1)",
  9866			.u.insns = {
  9867				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9868				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3),
  9869				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9870			},
  9871			CLASSIC,
  9872			{
  9873				[0x1c] = 0xaa, [0x1d] = 0x55,
  9874				[0x1e] = 0xbb, [0x1f] = 0x66,
  9875				[0x20] = 0xcc, [0x21] = 0x77,
  9876				[0x22] = 0xdd, [0x23] = 0x88,
  9877				[0x24] = 0xee, [0x25] = 0x99,
  9878				[0x26] = 0xff, [0x27] = 0xaa,
  9879			},
  9880			{ {0x40, 0x55bb66cc } },
  9881		},
  9882		{
  9883			"LD_IND word unaligned (addr & 3 == 3)",
  9884			.u.insns = {
  9885				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9886				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x1),
  9887				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9888			},
  9889			CLASSIC,
  9890			{
  9891				[0x1c] = 0xaa, [0x1d] = 0x55,
  9892				[0x1e] = 0xbb, [0x1f] = 0x66,
  9893				[0x20] = 0xcc, [0x21] = 0x77,
  9894				[0x22] = 0xdd, [0x23] = 0x88,
  9895				[0x24] = 0xee, [0x25] = 0x99,
  9896				[0x26] = 0xff, [0x27] = 0xaa,
  9897			},
  9898			{ {0x40, 0x66cc77dd } },
  9899		},
  9900		{
  9901			"LD_IND word positive offset, all ff",
  9902			.u.insns = {
  9903				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9904				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9905				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9906			},
  9907			CLASSIC,
  9908			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9909			{ {0x40, 0xffffffff } },
  9910		},
  9911		{
  9912			"LD_IND word positive offset, out of bounds",
  9913			.u.insns = {
  9914				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9915				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9916				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9917			},
  9918			CLASSIC,
  9919			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9920			{ {0x3f, 0 }, },
  9921		},
  9922		{
  9923			"LD_IND word negative offset, out of bounds",
  9924			.u.insns = {
  9925				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9926				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3f),
  9927				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9928			},
  9929			CLASSIC,
  9930			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9931			{ {0x3f, 0 } },
  9932		},
  9933		{
  9934			"LD_ABS byte",
  9935			.u.insns = {
  9936				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x20),
  9937				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9938			},
  9939			CLASSIC,
  9940			{
  9941				[0x1c] = 0xaa, [0x1d] = 0x55,
  9942				[0x1e] = 0xbb, [0x1f] = 0x66,
  9943				[0x20] = 0xcc, [0x21] = 0x77,
  9944				[0x22] = 0xdd, [0x23] = 0x88,
  9945				[0x24] = 0xee, [0x25] = 0x99,
  9946				[0x26] = 0xff, [0x27] = 0xaa,
  9947			},
  9948			{ {0x40, 0xcc } },
  9949		},
  9950		{
  9951			"LD_ABS byte positive offset, all ff",
  9952			.u.insns = {
  9953				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9954				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9955			},
  9956			CLASSIC,
  9957			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9958			{ {0x40, 0xff } },
  9959		},
  9960		{
  9961			"LD_ABS byte positive offset, out of bounds",
  9962			.u.insns = {
  9963				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9964				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9965			},
  9966			CLASSIC,
  9967			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9968			{ {0x3f, 0 }, },
  9969		},
  9970		{
  9971			"LD_ABS byte negative offset, out of bounds load",
  9972			.u.insns = {
  9973				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, -1),
  9974				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9975			},
  9976			CLASSIC | FLAG_EXPECTED_FAIL,
  9977			.expected_errcode = -EINVAL,
  9978		},
  9979		{
  9980			"LD_ABS byte negative offset, in bounds",
  9981			.u.insns = {
  9982				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9983				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9984			},
  9985			CLASSIC,
  9986			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9987			{ {0x40, 0x82 }, },
  9988		},
  9989		{
  9990			"LD_ABS byte negative offset, out of bounds",
  9991			.u.insns = {
  9992				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9993				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9994			},
  9995			CLASSIC,
  9996			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9997			{ {0x3f, 0 }, },
  9998		},
  9999		{
 10000			"LD_ABS byte negative offset, multiple calls",
 10001			.u.insns = {
 10002				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3c),
 10003				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3d),
 10004				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3e),
 10005				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
 10006				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10007			},
 10008			CLASSIC,
 10009			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10010			{ {0x40, 0x82 }, },
 10011		},
 10012		{
 10013			"LD_ABS halfword",
 10014			.u.insns = {
 10015				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x22),
 10016				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10017			},
 10018			CLASSIC,
 10019			{
 10020				[0x1c] = 0xaa, [0x1d] = 0x55,
 10021				[0x1e] = 0xbb, [0x1f] = 0x66,
 10022				[0x20] = 0xcc, [0x21] = 0x77,
 10023				[0x22] = 0xdd, [0x23] = 0x88,
 10024				[0x24] = 0xee, [0x25] = 0x99,
 10025				[0x26] = 0xff, [0x27] = 0xaa,
 10026			},
 10027			{ {0x40, 0xdd88 } },
 10028		},
 10029		{
 10030			"LD_ABS halfword unaligned",
 10031			.u.insns = {
 10032				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x25),
 10033				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10034			},
 10035			CLASSIC,
 10036			{
 10037				[0x1c] = 0xaa, [0x1d] = 0x55,
 10038				[0x1e] = 0xbb, [0x1f] = 0x66,
 10039				[0x20] = 0xcc, [0x21] = 0x77,
 10040				[0x22] = 0xdd, [0x23] = 0x88,
 10041				[0x24] = 0xee, [0x25] = 0x99,
 10042				[0x26] = 0xff, [0x27] = 0xaa,
 10043			},
 10044			{ {0x40, 0x99ff } },
 10045		},
 10046		{
 10047			"LD_ABS halfword positive offset, all ff",
 10048			.u.insns = {
 10049				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3e),
 10050				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10051			},
 10052			CLASSIC,
 10053			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
 10054			{ {0x40, 0xffff } },
 10055		},
 10056		{
 10057			"LD_ABS halfword positive offset, out of bounds",
 10058			.u.insns = {
 10059				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
 10060				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10061			},
 10062			CLASSIC,
 10063			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10064			{ {0x3f, 0 }, },
 10065		},
 10066		{
 10067			"LD_ABS halfword negative offset, out of bounds load",
 10068			.u.insns = {
 10069				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, -1),
 10070				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10071			},
 10072			CLASSIC | FLAG_EXPECTED_FAIL,
 10073			.expected_errcode = -EINVAL,
 10074		},
 10075		{
 10076			"LD_ABS halfword negative offset, in bounds",
 10077			.u.insns = {
 10078				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
 10079				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10080			},
 10081			CLASSIC,
 10082			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10083			{ {0x40, 0x1982 }, },
 10084		},
 10085		{
 10086			"LD_ABS halfword negative offset, out of bounds",
 10087			.u.insns = {
 10088				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
 10089				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10090			},
 10091			CLASSIC,
 10092			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10093			{ {0x3f, 0 }, },
 10094		},
 10095		{
 10096			"LD_ABS word",
 10097			.u.insns = {
 10098				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x1c),
 10099				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10100			},
 10101			CLASSIC,
 10102			{
 10103				[0x1c] = 0xaa, [0x1d] = 0x55,
 10104				[0x1e] = 0xbb, [0x1f] = 0x66,
 10105				[0x20] = 0xcc, [0x21] = 0x77,
 10106				[0x22] = 0xdd, [0x23] = 0x88,
 10107				[0x24] = 0xee, [0x25] = 0x99,
 10108				[0x26] = 0xff, [0x27] = 0xaa,
 10109			},
 10110			{ {0x40, 0xaa55bb66 } },
 10111		},
 10112		{
 10113			"LD_ABS word unaligned (addr & 3 == 2)",
 10114			.u.insns = {
 10115				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x22),
 10116				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10117			},
 10118			CLASSIC,
 10119			{
 10120				[0x1c] = 0xaa, [0x1d] = 0x55,
 10121				[0x1e] = 0xbb, [0x1f] = 0x66,
 10122				[0x20] = 0xcc, [0x21] = 0x77,
 10123				[0x22] = 0xdd, [0x23] = 0x88,
 10124				[0x24] = 0xee, [0x25] = 0x99,
 10125				[0x26] = 0xff, [0x27] = 0xaa,
 10126			},
 10127			{ {0x40, 0xdd88ee99 } },
 10128		},
 10129		{
 10130			"LD_ABS word unaligned (addr & 3 == 1)",
 10131			.u.insns = {
 10132				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x21),
 10133				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10134			},
 10135			CLASSIC,
 10136			{
 10137				[0x1c] = 0xaa, [0x1d] = 0x55,
 10138				[0x1e] = 0xbb, [0x1f] = 0x66,
 10139				[0x20] = 0xcc, [0x21] = 0x77,
 10140				[0x22] = 0xdd, [0x23] = 0x88,
 10141				[0x24] = 0xee, [0x25] = 0x99,
 10142				[0x26] = 0xff, [0x27] = 0xaa,
 10143			},
 10144			{ {0x40, 0x77dd88ee } },
 10145		},
 10146		{
 10147			"LD_ABS word unaligned (addr & 3 == 3)",
 10148			.u.insns = {
 10149				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x23),
 10150				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10151			},
 10152			CLASSIC,
 10153			{
 10154				[0x1c] = 0xaa, [0x1d] = 0x55,
 10155				[0x1e] = 0xbb, [0x1f] = 0x66,
 10156				[0x20] = 0xcc, [0x21] = 0x77,
 10157				[0x22] = 0xdd, [0x23] = 0x88,
 10158				[0x24] = 0xee, [0x25] = 0x99,
 10159				[0x26] = 0xff, [0x27] = 0xaa,
 10160			},
 10161			{ {0x40, 0x88ee99ff } },
 10162		},
 10163		{
 10164			"LD_ABS word positive offset, all ff",
 10165			.u.insns = {
 10166				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3c),
 10167				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10168			},
 10169			CLASSIC,
 10170			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
 10171			{ {0x40, 0xffffffff } },
 10172		},
 10173		{
 10174			"LD_ABS word positive offset, out of bounds",
 10175			.u.insns = {
 10176				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3f),
 10177				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10178			},
 10179			CLASSIC,
 10180			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10181			{ {0x3f, 0 }, },
 10182		},
 10183		{
 10184			"LD_ABS word negative offset, out of bounds load",
 10185			.u.insns = {
 10186				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, -1),
 10187				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10188			},
 10189			CLASSIC | FLAG_EXPECTED_FAIL,
 10190			.expected_errcode = -EINVAL,
 10191		},
 10192		{
 10193			"LD_ABS word negative offset, in bounds",
 10194			.u.insns = {
 10195				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
 10196				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10197			},
 10198			CLASSIC,
 10199			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10200			{ {0x40, 0x25051982 }, },
 10201		},
 10202		{
 10203			"LD_ABS word negative offset, out of bounds",
 10204			.u.insns = {
 10205				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
 10206				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10207			},
 10208			CLASSIC,
 10209			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10210			{ {0x3f, 0 }, },
 10211		},
 10212		{
 10213			"LDX_MSH standalone, preserved A",
 10214			.u.insns = {
 10215				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10216				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
 10217				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10218			},
 10219			CLASSIC,
 10220			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10221			{ {0x40, 0xffeebbaa }, },
 10222		},
 10223		{
 10224			"LDX_MSH standalone, preserved A 2",
 10225			.u.insns = {
 10226				BPF_STMT(BPF_LD | BPF_IMM, 0x175e9d63),
 10227				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
 10228				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3d),
 10229				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
 10230				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3f),
 10231				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10232			},
 10233			CLASSIC,
 10234			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10235			{ {0x40, 0x175e9d63 }, },
 10236		},
 10237		{
 10238			"LDX_MSH standalone, test result 1",
 10239			.u.insns = {
 10240				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10241				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
 10242				BPF_STMT(BPF_MISC | BPF_TXA, 0),
 10243				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10244			},
 10245			CLASSIC,
 10246			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10247			{ {0x40, 0x14 }, },
 10248		},
 10249		{
 10250			"LDX_MSH standalone, test result 2",
 10251			.u.insns = {
 10252				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10253				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
 10254				BPF_STMT(BPF_MISC | BPF_TXA, 0),
 10255				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10256			},
 10257			CLASSIC,
 10258			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10259			{ {0x40, 0x24 }, },
 10260		},
 10261		{
 10262			"LDX_MSH standalone, negative offset",
 10263			.u.insns = {
 10264				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10265				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, -1),
 10266				BPF_STMT(BPF_MISC | BPF_TXA, 0),
 10267				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10268			},
 10269			CLASSIC,
 10270			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10271			{ {0x40, 0 }, },
 10272		},
 10273		{
 10274			"LDX_MSH standalone, negative offset 2",
 10275			.u.insns = {
 10276				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10277				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_LL_OFF + 0x3e),
 10278				BPF_STMT(BPF_MISC | BPF_TXA, 0),
 10279				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10280			},
 10281			CLASSIC,
 10282			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10283			{ {0x40, 0x24 }, },
 10284		},
 10285		{
 10286			"LDX_MSH standalone, out of bounds",
 10287			.u.insns = {
 10288				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
 10289				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x40),
 10290				BPF_STMT(BPF_MISC | BPF_TXA, 0),
 10291				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10292			},
 10293			CLASSIC,
 10294			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
 10295			{ {0x40, 0 }, },
 10296		},
 10297		/*
 10298		 * verify that the interpreter or JIT correctly sets A and X
 10299		 * to 0.
 10300		 */
 10301		{
 10302			"ADD default X",
 10303			.u.insns = {
 10304				/*
 10305				 * A = 0x42
 10306				 * A = A + X
 10307				 * ret A
 10308				 */
 10309				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10310				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
 10311				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10312			},
 10313			CLASSIC | FLAG_NO_DATA,
 10314			{},
 10315			{ {0x1, 0x42 } },
 10316		},
 10317		{
 10318			"ADD default A",
 10319			.u.insns = {
 10320				/*
 10321				 * A = A + 0x42
 10322				 * ret A
 10323				 */
 10324				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
 10325				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10326			},
 10327			CLASSIC | FLAG_NO_DATA,
 10328			{},
 10329			{ {0x1, 0x42 } },
 10330		},
 10331		{
 10332			"SUB default X",
 10333			.u.insns = {
 10334				/*
 10335				 * A = 0x66
 10336				 * A = A - X
 10337				 * ret A
 10338				 */
 10339				BPF_STMT(BPF_LD | BPF_IMM, 0x66),
 10340				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
 10341				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10342			},
 10343			CLASSIC | FLAG_NO_DATA,
 10344			{},
 10345			{ {0x1, 0x66 } },
 10346		},
 10347		{
 10348			"SUB default A",
 10349			.u.insns = {
 10350				/*
 10351				 * A = A - -0x66
 10352				 * ret A
 10353				 */
 10354				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
 10355				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10356			},
 10357			CLASSIC | FLAG_NO_DATA,
 10358			{},
 10359			{ {0x1, 0x66 } },
 10360		},
 10361		{
 10362			"MUL default X",
 10363			.u.insns = {
 10364				/*
 10365				 * A = 0x42
 10366				 * A = A * X
 10367				 * ret A
 10368				 */
 10369				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10370				BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
 10371				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10372			},
 10373			CLASSIC | FLAG_NO_DATA,
 10374			{},
 10375			{ {0x1, 0x0 } },
 10376		},
 10377		{
 10378			"MUL default A",
 10379			.u.insns = {
 10380				/*
 10381				 * A = A * 0x66
 10382				 * ret A
 10383				 */
 10384				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
 10385				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10386			},
 10387			CLASSIC | FLAG_NO_DATA,
 10388			{},
 10389			{ {0x1, 0x0 } },
 10390		},
 10391		{
 10392			"DIV default X",
 10393			.u.insns = {
 10394				/*
 10395				 * A = 0x42
 10396				 * A = A / X ; this halt the filter execution if X is 0
 10397				 * ret 0x42
 10398				 */
 10399				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10400				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
 10401				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10402			},
 10403			CLASSIC | FLAG_NO_DATA,
 10404			{},
 10405			{ {0x1, 0x0 } },
 10406		},
 10407		{
 10408			"DIV default A",
 10409			.u.insns = {
 10410				/*
 10411				 * A = A / 1
 10412				 * ret A
 10413				 */
 10414				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
 10415				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10416			},
 10417			CLASSIC | FLAG_NO_DATA,
 10418			{},
 10419			{ {0x1, 0x0 } },
 10420		},
 10421		{
 10422			"MOD default X",
 10423			.u.insns = {
 10424				/*
 10425				 * A = 0x42
 10426				 * A = A mod X ; this halt the filter execution if X is 0
 10427				 * ret 0x42
 10428				 */
 10429				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10430				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
 10431				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10432			},
 10433			CLASSIC | FLAG_NO_DATA,
 10434			{},
 10435			{ {0x1, 0x0 } },
 10436		},
 10437		{
 10438			"MOD default A",
 10439			.u.insns = {
 10440				/*
 10441				 * A = A mod 1
 10442				 * ret A
 10443				 */
 10444				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
 10445				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10446			},
 10447			CLASSIC | FLAG_NO_DATA,
 10448			{},
 10449			{ {0x1, 0x0 } },
 10450		},
 10451		{
 10452			"JMP EQ default A",
 10453			.u.insns = {
 10454				/*
 10455				 * cmp A, 0x0, 0, 1
 10456				 * ret 0x42
 10457				 * ret 0x66
 10458				 */
 10459				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
 10460				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10461				BPF_STMT(BPF_RET | BPF_K, 0x66),
 10462			},
 10463			CLASSIC | FLAG_NO_DATA,
 10464			{},
 10465			{ {0x1, 0x42 } },
 10466		},
 10467		{
 10468			"JMP EQ default X",
 10469			.u.insns = {
 10470				/*
 10471				 * A = 0x0
 10472				 * cmp A, X, 0, 1
 10473				 * ret 0x42
 10474				 * ret 0x66
 10475				 */
 10476				BPF_STMT(BPF_LD | BPF_IMM, 0x0),
 10477				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
 10478				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10479				BPF_STMT(BPF_RET | BPF_K, 0x66),
 10480			},
 10481			CLASSIC | FLAG_NO_DATA,
 10482			{},
 10483			{ {0x1, 0x42 } },
 10484		},
 10485		/* Checking interpreter vs JIT wrt signed extended imms. */
 10486		{
 10487			"JNE signed compare, test 1",
 10488			.u.insns_int = {
 10489				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10490				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10491				BPF_MOV64_REG(R2, R1),
 10492				BPF_ALU64_REG(BPF_AND, R2, R3),
 10493				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10494				BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
 10495				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10496				BPF_EXIT_INSN(),
 10497			},
 10498			INTERNAL,
 10499			{ },
 10500			{ { 0, 1 } },
 10501		},
 10502		{
 10503			"JNE signed compare, test 2",
 10504			.u.insns_int = {
 10505				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10506				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10507				BPF_MOV64_REG(R2, R1),
 10508				BPF_ALU64_REG(BPF_AND, R2, R3),
 10509				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10510				BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
 10511				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10512				BPF_EXIT_INSN(),
 10513			},
 10514			INTERNAL,
 10515			{ },
 10516			{ { 0, 1 } },
 10517		},
 10518		{
 10519			"JNE signed compare, test 3",
 10520			.u.insns_int = {
 10521				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10522				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10523				BPF_ALU32_IMM(BPF_MOV, R4, 0xfefb0000),
 10524				BPF_MOV64_REG(R2, R1),
 10525				BPF_ALU64_REG(BPF_AND, R2, R3),
 10526				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10527				BPF_JMP_REG(BPF_JNE, R2, R4, 1),
 10528				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10529				BPF_EXIT_INSN(),
 10530			},
 10531			INTERNAL,
 10532			{ },
 10533			{ { 0, 2 } },
 10534		},
 10535		{
 10536			"JNE signed compare, test 4",
 10537			.u.insns_int = {
 10538				BPF_LD_IMM64(R1, -17104896),
 10539				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10540				BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
 10541				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10542				BPF_EXIT_INSN(),
 10543			},
 10544			INTERNAL,
 10545			{ },
 10546			{ { 0, 2 } },
 10547		},
 10548		{
 10549			"JNE signed compare, test 5",
 10550			.u.insns_int = {
 10551				BPF_LD_IMM64(R1, 0xfefb0000),
 10552				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10553				BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
 10554				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10555				BPF_EXIT_INSN(),
 10556			},
 10557			INTERNAL,
 10558			{ },
 10559			{ { 0, 1 } },
 10560		},
 10561		{
 10562			"JNE signed compare, test 6",
 10563			.u.insns_int = {
 10564				BPF_LD_IMM64(R1, 0x7efb0000),
 10565				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10566				BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
 10567				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10568				BPF_EXIT_INSN(),
 10569			},
 10570			INTERNAL,
 10571			{ },
 10572			{ { 0, 2 } },
 10573		},
 10574		{
 10575			"JNE signed compare, test 7",
 10576			.u.insns = {
 10577				BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
 10578				BPF_STMT(BPF_MISC | BPF_TAX, 0),
 10579				BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
 10580				BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
 10581				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
 10582				BPF_STMT(BPF_RET | BPF_K, 1),
 10583				BPF_STMT(BPF_RET | BPF_K, 2),
 10584			},
 10585			CLASSIC | FLAG_NO_DATA,
 10586			{},
 10587			{ { 0, 2 } },
 10588		},
 10589		/* Checking that ALU32 src is not zero extended in place */
 10590	#define BPF_ALU32_SRC_ZEXT(op)					\
 10591		{							\
 10592			"ALU32_" #op "_X: src preserved in zext",	\
 10593			.u.insns_int = {				\
 10594				BPF_LD_IMM64(R1, 0x0123456789acbdefULL),\
 10595				BPF_LD_IMM64(R2, 0xfedcba9876543210ULL),\
 10596				BPF_ALU64_REG(BPF_MOV, R0, R1),		\
 10597				BPF_ALU32_REG(BPF_##op, R2, R1),	\
 10598				BPF_ALU64_REG(BPF_SUB, R0, R1),		\
 10599				BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 10600				BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
 10601				BPF_ALU64_REG(BPF_OR, R0, R1),		\
 10602				BPF_EXIT_INSN(),			\
 10603			},						\
 10604			INTERNAL,					\
 10605			{ },						\
 10606			{ { 0, 0 } },					\
 10607		}
 10608		BPF_ALU32_SRC_ZEXT(MOV),
 10609		BPF_ALU32_SRC_ZEXT(AND),
 10610		BPF_ALU32_SRC_ZEXT(OR),
 10611		BPF_ALU32_SRC_ZEXT(XOR),
 10612		BPF_ALU32_SRC_ZEXT(ADD),
 10613		BPF_ALU32_SRC_ZEXT(SUB),
 10614		BPF_ALU32_SRC_ZEXT(MUL),
 10615		BPF_ALU32_SRC_ZEXT(DIV),
 10616		BPF_ALU32_SRC_ZEXT(MOD),
 10617	#undef BPF_ALU32_SRC_ZEXT
 10618		/* Checking that ATOMIC32 src is not zero extended in place */
 10619	#define BPF_ATOMIC32_SRC_ZEXT(op)					\
 10620		{								\
 10621			"ATOMIC_W_" #op ": src preserved in zext",		\
 10622			.u.insns_int = {					\
 10623				BPF_LD_IMM64(R0, 0x0123456789acbdefULL),	\
 10624				BPF_ALU64_REG(BPF_MOV, R1, R0),			\
 10625				BPF_ST_MEM(BPF_W, R10, -4, 0),			\
 10626				BPF_ATOMIC_OP(BPF_W, BPF_##op, R10, R1, -4),	\
 10627				BPF_ALU64_REG(BPF_SUB, R0, R1),			\
 10628				BPF_ALU64_REG(BPF_MOV, R1, R0),			\
 10629				BPF_ALU64_IMM(BPF_RSH, R1, 32),			\
 10630				BPF_ALU64_REG(BPF_OR, R0, R1),			\
 10631				BPF_EXIT_INSN(),				\
 10632			},							\
 10633			INTERNAL,						\
 10634			{ },							\
 10635			{ { 0, 0 } },						\
 10636			.stack_depth = 8,					\
 10637		}
 10638		BPF_ATOMIC32_SRC_ZEXT(ADD),
 10639		BPF_ATOMIC32_SRC_ZEXT(AND),
 10640		BPF_ATOMIC32_SRC_ZEXT(OR),
 10641		BPF_ATOMIC32_SRC_ZEXT(XOR),
 10642	#undef BPF_ATOMIC32_SRC_ZEXT
 10643		/* Checking that CMPXCHG32 src is not zero extended in place */
 10644		{
 10645			"ATOMIC_W_CMPXCHG: src preserved in zext",
 10646			.u.insns_int = {
 10647				BPF_LD_IMM64(R1, 0x0123456789acbdefULL),
 10648				BPF_ALU64_REG(BPF_MOV, R2, R1),
 10649				BPF_ALU64_REG(BPF_MOV, R0, 0),
 10650				BPF_ST_MEM(BPF_W, R10, -4, 0),
 10651				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R1, -4),
 10652				BPF_ALU64_REG(BPF_SUB, R1, R2),
 10653				BPF_ALU64_REG(BPF_MOV, R2, R1),
 10654				BPF_ALU64_IMM(BPF_RSH, R2, 32),
 10655				BPF_ALU64_REG(BPF_OR, R1, R2),
 10656				BPF_ALU64_REG(BPF_MOV, R0, R1),
 10657				BPF_EXIT_INSN(),
 10658			},
 10659			INTERNAL,
 10660			{ },
 10661			{ { 0, 0 } },
 10662			.stack_depth = 8,
 10663		},
 10664		/* Checking that JMP32 immediate src is not zero extended in place */
 10665	#define BPF_JMP32_IMM_ZEXT(op)					\
 10666		{							\
 10667			"JMP32_" #op "_K: operand preserved in zext",	\
 10668			.u.insns_int = {				\
 10669				BPF_LD_IMM64(R0, 0x0123456789acbdefULL),\
 10670				BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 10671				BPF_JMP32_IMM(BPF_##op, R0, 1234, 1),	\
 10672				BPF_JMP_A(0), /* Nop */			\
 10673				BPF_ALU64_REG(BPF_SUB, R0, R1),		\
 10674				BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 10675				BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
 10676				BPF_ALU64_REG(BPF_OR, R0, R1),		\
 10677				BPF_EXIT_INSN(),			\
 10678			},						\
 10679			INTERNAL,					\
 10680			{ },						\
 10681			{ { 0, 0 } },					\
 10682		}
 10683		BPF_JMP32_IMM_ZEXT(JEQ),
 10684		BPF_JMP32_IMM_ZEXT(JNE),
 10685		BPF_JMP32_IMM_ZEXT(JSET),
 10686		BPF_JMP32_IMM_ZEXT(JGT),
 10687		BPF_JMP32_IMM_ZEXT(JGE),
 10688		BPF_JMP32_IMM_ZEXT(JLT),
 10689		BPF_JMP32_IMM_ZEXT(JLE),
 10690		BPF_JMP32_IMM_ZEXT(JSGT),
 10691		BPF_JMP32_IMM_ZEXT(JSGE),
 10692		BPF_JMP32_IMM_ZEXT(JSGT),
 10693		BPF_JMP32_IMM_ZEXT(JSLT),
 10694		BPF_JMP32_IMM_ZEXT(JSLE),
 10695	#undef BPF_JMP2_IMM_ZEXT
 10696		/* Checking that JMP32 dst & src are not zero extended in place */
 10697	#define BPF_JMP32_REG_ZEXT(op)					\
 10698		{							\
 10699			"JMP32_" #op "_X: operands preserved in zext",	\
 10700			.u.insns_int = {				\
 10701				BPF_LD_IMM64(R0, 0x0123456789acbdefULL),\
 10702				BPF_LD_IMM64(R1, 0xfedcba9876543210ULL),\
 10703				BPF_ALU64_REG(BPF_MOV, R2, R0),		\
 10704				BPF_ALU64_REG(BPF_MOV, R3, R1),		\
 10705				BPF_JMP32_IMM(BPF_##op, R0, R1, 1),	\
 10706				BPF_JMP_A(0), /* Nop */			\
 10707				BPF_ALU64_REG(BPF_SUB, R0, R2),		\
 10708				BPF_ALU64_REG(BPF_SUB, R1, R3),		\
 10709				BPF_ALU64_REG(BPF_OR, R0, R1),		\
 10710				BPF_ALU64_REG(BPF_MOV, R1, R0),		\
 10711				BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
 10712				BPF_ALU64_REG(BPF_OR, R0, R1),		\
 10713				BPF_EXIT_INSN(),			\
 10714			},						\
 10715			INTERNAL,					\
 10716			{ },						\
 10717			{ { 0, 0 } },					\
 10718		}
 10719		BPF_JMP32_REG_ZEXT(JEQ),
 10720		BPF_JMP32_REG_ZEXT(JNE),
 10721		BPF_JMP32_REG_ZEXT(JSET),
 10722		BPF_JMP32_REG_ZEXT(JGT),
 10723		BPF_JMP32_REG_ZEXT(JGE),
 10724		BPF_JMP32_REG_ZEXT(JLT),
 10725		BPF_JMP32_REG_ZEXT(JLE),
 10726		BPF_JMP32_REG_ZEXT(JSGT),
 10727		BPF_JMP32_REG_ZEXT(JSGE),
 10728		BPF_JMP32_REG_ZEXT(JSGT),
 10729		BPF_JMP32_REG_ZEXT(JSLT),
 10730		BPF_JMP32_REG_ZEXT(JSLE),
 10731	#undef BPF_JMP2_REG_ZEXT
 10732		/* Exhaustive test of ALU64 shift operations */
 10733		{
 10734			"ALU64_LSH_K: all shift values",
 10735			{ },
 10736			INTERNAL | FLAG_NO_DATA,
 10737			{ },
 10738			{ { 0, 1 } },
 10739			.fill_helper = bpf_fill_alu_lsh_imm,
 10740		},
 10741		{
 10742			"ALU64_RSH_K: all shift values",
 10743			{ },
 10744			INTERNAL | FLAG_NO_DATA,
 10745			{ },
 10746			{ { 0, 1 } },
 10747			.fill_helper = bpf_fill_alu_rsh_imm,
 10748		},
 10749		{
 10750			"ALU64_ARSH_K: all shift values",
 10751			{ },
 10752			INTERNAL | FLAG_NO_DATA,
 10753			{ },
 10754			{ { 0, 1 } },
 10755			.fill_helper = bpf_fill_alu_arsh_imm,
 10756		},
 10757		{
 10758			"ALU64_LSH_X: all shift values",
 10759			{ },
 10760			INTERNAL | FLAG_NO_DATA,
 10761			{ },
 10762			{ { 0, 1 } },
 10763			.fill_helper = bpf_fill_alu_lsh_reg,
 10764		},
 10765		{
 10766			"ALU64_RSH_X: all shift values",
 10767			{ },
 10768			INTERNAL | FLAG_NO_DATA,
 10769			{ },
 10770			{ { 0, 1 } },
 10771			.fill_helper = bpf_fill_alu_rsh_reg,
 10772		},
 10773		{
 10774			"ALU64_ARSH_X: all shift values",
 10775			{ },
 10776			INTERNAL | FLAG_NO_DATA,
 10777			{ },
 10778			{ { 0, 1 } },
 10779			.fill_helper = bpf_fill_alu_arsh_reg,
 10780		},
 10781		/* Exhaustive test of ALU32 shift operations */
 10782		{
 10783			"ALU32_LSH_K: all shift values",
 10784			{ },
 10785			INTERNAL | FLAG_NO_DATA,
 10786			{ },
 10787			{ { 0, 1 } },
 10788			.fill_helper = bpf_fill_alu32_lsh_imm,
 10789		},
 10790		{
 10791			"ALU32_RSH_K: all shift values",
 10792			{ },
 10793			INTERNAL | FLAG_NO_DATA,
 10794			{ },
 10795			{ { 0, 1 } },
 10796			.fill_helper = bpf_fill_alu32_rsh_imm,
 10797		},
 10798		{
 10799			"ALU32_ARSH_K: all shift values",
 10800			{ },
 10801			INTERNAL | FLAG_NO_DATA,
 10802			{ },
 10803			{ { 0, 1 } },
 10804			.fill_helper = bpf_fill_alu32_arsh_imm,
 10805		},
 10806		{
 10807			"ALU32_LSH_X: all shift values",
 10808			{ },
 10809			INTERNAL | FLAG_NO_DATA,
 10810			{ },
 10811			{ { 0, 1 } },
 10812			.fill_helper = bpf_fill_alu32_lsh_reg,
 10813		},
 10814		{
 10815			"ALU32_RSH_X: all shift values",
 10816			{ },
 10817			INTERNAL | FLAG_NO_DATA,
 10818			{ },
 10819			{ { 0, 1 } },
 10820			.fill_helper = bpf_fill_alu32_rsh_reg,
 10821		},
 10822		{
 10823			"ALU32_ARSH_X: all shift values",
 10824			{ },
 10825			INTERNAL | FLAG_NO_DATA,
 10826			{ },
 10827			{ { 0, 1 } },
 10828			.fill_helper = bpf_fill_alu32_arsh_reg,
 10829		},
 10830		/* ALU64 immediate magnitudes */
 10831		{
 10832			"ALU64_MOV_K: all immediate value magnitudes",
 10833			{ },
 10834			INTERNAL | FLAG_NO_DATA,
 10835			{ },
 10836			{ { 0, 1 } },
 10837			.fill_helper = bpf_fill_alu64_mov_imm,
 10838			.nr_testruns = NR_PATTERN_RUNS,
 10839		},
 10840		{
 10841			"ALU64_AND_K: all immediate value magnitudes",
 10842			{ },
 10843			INTERNAL | FLAG_NO_DATA,
 10844			{ },
 10845			{ { 0, 1 } },
 10846			.fill_helper = bpf_fill_alu64_and_imm,
 10847			.nr_testruns = NR_PATTERN_RUNS,
 10848		},
 10849		{
 10850			"ALU64_OR_K: all immediate value magnitudes",
 10851			{ },
 10852			INTERNAL | FLAG_NO_DATA,
 10853			{ },
 10854			{ { 0, 1 } },
 10855			.fill_helper = bpf_fill_alu64_or_imm,
 10856			.nr_testruns = NR_PATTERN_RUNS,
 10857		},
 10858		{
 10859			"ALU64_XOR_K: all immediate value magnitudes",
 10860			{ },
 10861			INTERNAL | FLAG_NO_DATA,
 10862			{ },
 10863			{ { 0, 1 } },
 10864			.fill_helper = bpf_fill_alu64_xor_imm,
 10865			.nr_testruns = NR_PATTERN_RUNS,
 10866		},
 10867		{
 10868			"ALU64_ADD_K: all immediate value magnitudes",
 10869			{ },
 10870			INTERNAL | FLAG_NO_DATA,
 10871			{ },
 10872			{ { 0, 1 } },
 10873			.fill_helper = bpf_fill_alu64_add_imm,
 10874			.nr_testruns = NR_PATTERN_RUNS,
 10875		},
 10876		{
 10877			"ALU64_SUB_K: all immediate value magnitudes",
 10878			{ },
 10879			INTERNAL | FLAG_NO_DATA,
 10880			{ },
 10881			{ { 0, 1 } },
 10882			.fill_helper = bpf_fill_alu64_sub_imm,
 10883			.nr_testruns = NR_PATTERN_RUNS,
 10884		},
 10885		{
 10886			"ALU64_MUL_K: all immediate value magnitudes",
 10887			{ },
 10888			INTERNAL | FLAG_NO_DATA,
 10889			{ },
 10890			{ { 0, 1 } },
 10891			.fill_helper = bpf_fill_alu64_mul_imm,
 10892			.nr_testruns = NR_PATTERN_RUNS,
 10893		},
 10894		{
 10895			"ALU64_DIV_K: all immediate value magnitudes",
 10896			{ },
 10897			INTERNAL | FLAG_NO_DATA,
 10898			{ },
 10899			{ { 0, 1 } },
 10900			.fill_helper = bpf_fill_alu64_div_imm,
 10901			.nr_testruns = NR_PATTERN_RUNS,
 10902		},
 10903		{
 10904			"ALU64_MOD_K: all immediate value magnitudes",
 10905			{ },
 10906			INTERNAL | FLAG_NO_DATA,
 10907			{ },
 10908			{ { 0, 1 } },
 10909			.fill_helper = bpf_fill_alu64_mod_imm,
 10910			.nr_testruns = NR_PATTERN_RUNS,
 10911		},
 10912		/* ALU32 immediate magnitudes */
 10913		{
 10914			"ALU32_MOV_K: all immediate value magnitudes",
 10915			{ },
 10916			INTERNAL | FLAG_NO_DATA,
 10917			{ },
 10918			{ { 0, 1 } },
 10919			.fill_helper = bpf_fill_alu32_mov_imm,
 10920			.nr_testruns = NR_PATTERN_RUNS,
 10921		},
 10922		{
 10923			"ALU32_AND_K: all immediate value magnitudes",
 10924			{ },
 10925			INTERNAL | FLAG_NO_DATA,
 10926			{ },
 10927			{ { 0, 1 } },
 10928			.fill_helper = bpf_fill_alu32_and_imm,
 10929			.nr_testruns = NR_PATTERN_RUNS,
 10930		},
 10931		{
 10932			"ALU32_OR_K: all immediate value magnitudes",
 10933			{ },
 10934			INTERNAL | FLAG_NO_DATA,
 10935			{ },
 10936			{ { 0, 1 } },
 10937			.fill_helper = bpf_fill_alu32_or_imm,
 10938			.nr_testruns = NR_PATTERN_RUNS,
 10939		},
 10940		{
 10941			"ALU32_XOR_K: all immediate value magnitudes",
 10942			{ },
 10943			INTERNAL | FLAG_NO_DATA,
 10944			{ },
 10945			{ { 0, 1 } },
 10946			.fill_helper = bpf_fill_alu32_xor_imm,
 10947			.nr_testruns = NR_PATTERN_RUNS,
 10948		},
 10949		{
 10950			"ALU32_ADD_K: all immediate value magnitudes",
 10951			{ },
 10952			INTERNAL | FLAG_NO_DATA,
 10953			{ },
 10954			{ { 0, 1 } },
 10955			.fill_helper = bpf_fill_alu32_add_imm,
 10956			.nr_testruns = NR_PATTERN_RUNS,
 10957		},
 10958		{
 10959			"ALU32_SUB_K: all immediate value magnitudes",
 10960			{ },
 10961			INTERNAL | FLAG_NO_DATA,
 10962			{ },
 10963			{ { 0, 1 } },
 10964			.fill_helper = bpf_fill_alu32_sub_imm,
 10965			.nr_testruns = NR_PATTERN_RUNS,
 10966		},
 10967		{
 10968			"ALU32_MUL_K: all immediate value magnitudes",
 10969			{ },
 10970			INTERNAL | FLAG_NO_DATA,
 10971			{ },
 10972			{ { 0, 1 } },
 10973			.fill_helper = bpf_fill_alu32_mul_imm,
 10974			.nr_testruns = NR_PATTERN_RUNS,
 10975		},
 10976		{
 10977			"ALU32_DIV_K: all immediate value magnitudes",
 10978			{ },
 10979			INTERNAL | FLAG_NO_DATA,
 10980			{ },
 10981			{ { 0, 1 } },
 10982			.fill_helper = bpf_fill_alu32_div_imm,
 10983			.nr_testruns = NR_PATTERN_RUNS,
 10984		},
 10985		{
 10986			"ALU32_MOD_K: all immediate value magnitudes",
 10987			{ },
 10988			INTERNAL | FLAG_NO_DATA,
 10989			{ },
 10990			{ { 0, 1 } },
 10991			.fill_helper = bpf_fill_alu32_mod_imm,
 10992			.nr_testruns = NR_PATTERN_RUNS,
 10993		},
 10994		/* ALU64 register magnitudes */
 10995		{
 10996			"ALU64_MOV_X: all register value magnitudes",
 10997			{ },
 10998			INTERNAL | FLAG_NO_DATA,
 10999			{ },
 11000			{ { 0, 1 } },
 11001			.fill_helper = bpf_fill_alu64_mov_reg,
 11002			.nr_testruns = NR_PATTERN_RUNS,
 11003		},
 11004		{
 11005			"ALU64_AND_X: all register value magnitudes",
 11006			{ },
 11007			INTERNAL | FLAG_NO_DATA,
 11008			{ },
 11009			{ { 0, 1 } },
 11010			.fill_helper = bpf_fill_alu64_and_reg,
 11011			.nr_testruns = NR_PATTERN_RUNS,
 11012		},
 11013		{
 11014			"ALU64_OR_X: all register value magnitudes",
 11015			{ },
 11016			INTERNAL | FLAG_NO_DATA,
 11017			{ },
 11018			{ { 0, 1 } },
 11019			.fill_helper = bpf_fill_alu64_or_reg,
 11020			.nr_testruns = NR_PATTERN_RUNS,
 11021		},
 11022		{
 11023			"ALU64_XOR_X: all register value magnitudes",
 11024			{ },
 11025			INTERNAL | FLAG_NO_DATA,
 11026			{ },
 11027			{ { 0, 1 } },
 11028			.fill_helper = bpf_fill_alu64_xor_reg,
 11029			.nr_testruns = NR_PATTERN_RUNS,
 11030		},
 11031		{
 11032			"ALU64_ADD_X: all register value magnitudes",
 11033			{ },
 11034			INTERNAL | FLAG_NO_DATA,
 11035			{ },
 11036			{ { 0, 1 } },
 11037			.fill_helper = bpf_fill_alu64_add_reg,
 11038			.nr_testruns = NR_PATTERN_RUNS,
 11039		},
 11040		{
 11041			"ALU64_SUB_X: all register value magnitudes",
 11042			{ },
 11043			INTERNAL | FLAG_NO_DATA,
 11044			{ },
 11045			{ { 0, 1 } },
 11046			.fill_helper = bpf_fill_alu64_sub_reg,
 11047			.nr_testruns = NR_PATTERN_RUNS,
 11048		},
 11049		{
 11050			"ALU64_MUL_X: all register value magnitudes",
 11051			{ },
 11052			INTERNAL | FLAG_NO_DATA,
 11053			{ },
 11054			{ { 0, 1 } },
 11055			.fill_helper = bpf_fill_alu64_mul_reg,
 11056			.nr_testruns = NR_PATTERN_RUNS,
 11057		},
 11058		{
 11059			"ALU64_DIV_X: all register value magnitudes",
 11060			{ },
 11061			INTERNAL | FLAG_NO_DATA,
 11062			{ },
 11063			{ { 0, 1 } },
 11064			.fill_helper = bpf_fill_alu64_div_reg,
 11065			.nr_testruns = NR_PATTERN_RUNS,
 11066		},
 11067		{
 11068			"ALU64_MOD_X: all register value magnitudes",
 11069			{ },
 11070			INTERNAL | FLAG_NO_DATA,
 11071			{ },
 11072			{ { 0, 1 } },
 11073			.fill_helper = bpf_fill_alu64_mod_reg,
 11074			.nr_testruns = NR_PATTERN_RUNS,
 11075		},
 11076		/* ALU32 register magnitudes */
 11077		{
 11078			"ALU32_MOV_X: all register value magnitudes",
 11079			{ },
 11080			INTERNAL | FLAG_NO_DATA,
 11081			{ },
 11082			{ { 0, 1 } },
 11083			.fill_helper = bpf_fill_alu32_mov_reg,
 11084			.nr_testruns = NR_PATTERN_RUNS,
 11085		},
 11086		{
 11087			"ALU32_AND_X: all register value magnitudes",
 11088			{ },
 11089			INTERNAL | FLAG_NO_DATA,
 11090			{ },
 11091			{ { 0, 1 } },
 11092			.fill_helper = bpf_fill_alu32_and_reg,
 11093			.nr_testruns = NR_PATTERN_RUNS,
 11094		},
 11095		{
 11096			"ALU32_OR_X: all register value magnitudes",
 11097			{ },
 11098			INTERNAL | FLAG_NO_DATA,
 11099			{ },
 11100			{ { 0, 1 } },
 11101			.fill_helper = bpf_fill_alu32_or_reg,
 11102			.nr_testruns = NR_PATTERN_RUNS,
 11103		},
 11104		{
 11105			"ALU32_XOR_X: all register value magnitudes",
 11106			{ },
 11107			INTERNAL | FLAG_NO_DATA,
 11108			{ },
 11109			{ { 0, 1 } },
 11110			.fill_helper = bpf_fill_alu32_xor_reg,
 11111			.nr_testruns = NR_PATTERN_RUNS,
 11112		},
 11113		{
 11114			"ALU32_ADD_X: all register value magnitudes",
 11115			{ },
 11116			INTERNAL | FLAG_NO_DATA,
 11117			{ },
 11118			{ { 0, 1 } },
 11119			.fill_helper = bpf_fill_alu32_add_reg,
 11120			.nr_testruns = NR_PATTERN_RUNS,
 11121		},
 11122		{
 11123			"ALU32_SUB_X: all register value magnitudes",
 11124			{ },
 11125			INTERNAL | FLAG_NO_DATA,
 11126			{ },
 11127			{ { 0, 1 } },
 11128			.fill_helper = bpf_fill_alu32_sub_reg,
 11129			.nr_testruns = NR_PATTERN_RUNS,
 11130		},
 11131		{
 11132			"ALU32_MUL_X: all register value magnitudes",
 11133			{ },
 11134			INTERNAL | FLAG_NO_DATA,
 11135			{ },
 11136			{ { 0, 1 } },
 11137			.fill_helper = bpf_fill_alu32_mul_reg,
 11138			.nr_testruns = NR_PATTERN_RUNS,
 11139		},
 11140		{
 11141			"ALU32_DIV_X: all register value magnitudes",
 11142			{ },
 11143			INTERNAL | FLAG_NO_DATA,
 11144			{ },
 11145			{ { 0, 1 } },
 11146			.fill_helper = bpf_fill_alu32_div_reg,
 11147			.nr_testruns = NR_PATTERN_RUNS,
 11148		},
 11149		{
 11150			"ALU32_MOD_X: all register value magnitudes",
 11151			{ },
 11152			INTERNAL | FLAG_NO_DATA,
 11153			{ },
 11154			{ { 0, 1 } },
 11155			.fill_helper = bpf_fill_alu32_mod_reg,
 11156			.nr_testruns = NR_PATTERN_RUNS,
 11157		},
 11158		/* LD_IMM64 immediate magnitudes */
 11159		{
 11160			"LD_IMM64: all immediate value magnitudes",
 11161			{ },
 11162			INTERNAL | FLAG_NO_DATA,
 11163			{ },
 11164			{ { 0, 1 } },
 11165			.fill_helper = bpf_fill_ld_imm64,
 11166		},
 11167		/* 64-bit ATOMIC magnitudes */
 11168		{
 11169			"ATOMIC_DW_ADD: all operand magnitudes",
 11170			{ },
 11171			INTERNAL | FLAG_NO_DATA,
 11172			{ },
 11173			{ { 0, 1 } },
 11174			.fill_helper = bpf_fill_atomic64_add,
 11175			.stack_depth = 8,
 11176			.nr_testruns = NR_PATTERN_RUNS,
 11177		},
 11178		{
 11179			"ATOMIC_DW_AND: all operand magnitudes",
 11180			{ },
 11181			INTERNAL | FLAG_NO_DATA,
 11182			{ },
 11183			{ { 0, 1 } },
 11184			.fill_helper = bpf_fill_atomic64_and,
 11185			.stack_depth = 8,
 11186			.nr_testruns = NR_PATTERN_RUNS,
 11187		},
 11188		{
 11189			"ATOMIC_DW_OR: all operand magnitudes",
 11190			{ },
 11191			INTERNAL | FLAG_NO_DATA,
 11192			{ },
 11193			{ { 0, 1 } },
 11194			.fill_helper = bpf_fill_atomic64_or,
 11195			.stack_depth = 8,
 11196			.nr_testruns = NR_PATTERN_RUNS,
 11197		},
 11198		{
 11199			"ATOMIC_DW_XOR: all operand magnitudes",
 11200			{ },
 11201			INTERNAL | FLAG_NO_DATA,
 11202			{ },
 11203			{ { 0, 1 } },
 11204			.fill_helper = bpf_fill_atomic64_xor,
 11205			.stack_depth = 8,
 11206			.nr_testruns = NR_PATTERN_RUNS,
 11207		},
 11208		{
 11209			"ATOMIC_DW_ADD_FETCH: all operand magnitudes",
 11210			{ },
 11211			INTERNAL | FLAG_NO_DATA,
 11212			{ },
 11213			{ { 0, 1 } },
 11214			.fill_helper = bpf_fill_atomic64_add_fetch,
 11215			.stack_depth = 8,
 11216			.nr_testruns = NR_PATTERN_RUNS,
 11217		},
 11218		{
 11219			"ATOMIC_DW_AND_FETCH: all operand magnitudes",
 11220			{ },
 11221			INTERNAL | FLAG_NO_DATA,
 11222			{ },
 11223			{ { 0, 1 } },
 11224			.fill_helper = bpf_fill_atomic64_and_fetch,
 11225			.stack_depth = 8,
 11226			.nr_testruns = NR_PATTERN_RUNS,
 11227		},
 11228		{
 11229			"ATOMIC_DW_OR_FETCH: all operand magnitudes",
 11230			{ },
 11231			INTERNAL | FLAG_NO_DATA,
 11232			{ },
 11233			{ { 0, 1 } },
 11234			.fill_helper = bpf_fill_atomic64_or_fetch,
 11235			.stack_depth = 8,
 11236			.nr_testruns = NR_PATTERN_RUNS,
 11237		},
 11238		{
 11239			"ATOMIC_DW_XOR_FETCH: all operand magnitudes",
 11240			{ },
 11241			INTERNAL | FLAG_NO_DATA,
 11242			{ },
 11243			{ { 0, 1 } },
 11244			.fill_helper = bpf_fill_atomic64_xor_fetch,
 11245			.stack_depth = 8,
 11246			.nr_testruns = NR_PATTERN_RUNS,
 11247		},
 11248		{
 11249			"ATOMIC_DW_XCHG: all operand magnitudes",
 11250			{ },
 11251			INTERNAL | FLAG_NO_DATA,
 11252			{ },
 11253			{ { 0, 1 } },
 11254			.fill_helper = bpf_fill_atomic64_xchg,
 11255			.stack_depth = 8,
 11256			.nr_testruns = NR_PATTERN_RUNS,
 11257		},
 11258		{
 11259			"ATOMIC_DW_CMPXCHG: all operand magnitudes",
 11260			{ },
 11261			INTERNAL | FLAG_NO_DATA,
 11262			{ },
 11263			{ { 0, 1 } },
 11264			.fill_helper = bpf_fill_cmpxchg64,
 11265			.stack_depth = 8,
 11266			.nr_testruns = NR_PATTERN_RUNS,
 11267		},
 11268		/* 64-bit atomic magnitudes */
 11269		{
 11270			"ATOMIC_W_ADD: all operand magnitudes",
 11271			{ },
 11272			INTERNAL | FLAG_NO_DATA,
 11273			{ },
 11274			{ { 0, 1 } },
 11275			.fill_helper = bpf_fill_atomic32_add,
 11276			.stack_depth = 8,
 11277			.nr_testruns = NR_PATTERN_RUNS,
 11278		},
 11279		{
 11280			"ATOMIC_W_AND: all operand magnitudes",
 11281			{ },
 11282			INTERNAL | FLAG_NO_DATA,
 11283			{ },
 11284			{ { 0, 1 } },
 11285			.fill_helper = bpf_fill_atomic32_and,
 11286			.stack_depth = 8,
 11287			.nr_testruns = NR_PATTERN_RUNS,
 11288		},
 11289		{
 11290			"ATOMIC_W_OR: all operand magnitudes",
 11291			{ },
 11292			INTERNAL | FLAG_NO_DATA,
 11293			{ },
 11294			{ { 0, 1 } },
 11295			.fill_helper = bpf_fill_atomic32_or,
 11296			.stack_depth = 8,
 11297			.nr_testruns = NR_PATTERN_RUNS,
 11298		},
 11299		{
 11300			"ATOMIC_W_XOR: all operand magnitudes",
 11301			{ },
 11302			INTERNAL | FLAG_NO_DATA,
 11303			{ },
 11304			{ { 0, 1 } },
 11305			.fill_helper = bpf_fill_atomic32_xor,
 11306			.stack_depth = 8,
 11307			.nr_testruns = NR_PATTERN_RUNS,
 11308		},
 11309		{
 11310			"ATOMIC_W_ADD_FETCH: all operand magnitudes",
 11311			{ },
 11312			INTERNAL | FLAG_NO_DATA,
 11313			{ },
 11314			{ { 0, 1 } },
 11315			.fill_helper = bpf_fill_atomic32_add_fetch,
 11316			.stack_depth = 8,
 11317			.nr_testruns = NR_PATTERN_RUNS,
 11318		},
 11319		{
 11320			"ATOMIC_W_AND_FETCH: all operand magnitudes",
 11321			{ },
 11322			INTERNAL | FLAG_NO_DATA,
 11323			{ },
 11324			{ { 0, 1 } },
 11325			.fill_helper = bpf_fill_atomic32_and_fetch,
 11326			.stack_depth = 8,
 11327			.nr_testruns = NR_PATTERN_RUNS,
 11328		},
 11329		{
 11330			"ATOMIC_W_OR_FETCH: all operand magnitudes",
 11331			{ },
 11332			INTERNAL | FLAG_NO_DATA,
 11333			{ },
 11334			{ { 0, 1 } },
 11335			.fill_helper = bpf_fill_atomic32_or_fetch,
 11336			.stack_depth = 8,
 11337			.nr_testruns = NR_PATTERN_RUNS,
 11338		},
 11339		{
 11340			"ATOMIC_W_XOR_FETCH: all operand magnitudes",
 11341			{ },
 11342			INTERNAL | FLAG_NO_DATA,
 11343			{ },
 11344			{ { 0, 1 } },
 11345			.fill_helper = bpf_fill_atomic32_xor_fetch,
 11346			.stack_depth = 8,
 11347			.nr_testruns = NR_PATTERN_RUNS,
 11348		},
 11349		{
 11350			"ATOMIC_W_XCHG: all operand magnitudes",
 11351			{ },
 11352			INTERNAL | FLAG_NO_DATA,
 11353			{ },
 11354			{ { 0, 1 } },
 11355			.fill_helper = bpf_fill_atomic32_xchg,
 11356			.stack_depth = 8,
 11357			.nr_testruns = NR_PATTERN_RUNS,
 11358		},
 11359		{
 11360			"ATOMIC_W_CMPXCHG: all operand magnitudes",
 11361			{ },
 11362			INTERNAL | FLAG_NO_DATA,
 11363			{ },
 11364			{ { 0, 1 } },
 11365			.fill_helper = bpf_fill_cmpxchg32,
 11366			.stack_depth = 8,
 11367			.nr_testruns = NR_PATTERN_RUNS,
 11368		},
 11369		/* JMP immediate magnitudes */
 11370		{
 11371			"JMP_JSET_K: all immediate value magnitudes",
 11372			{ },
 11373			INTERNAL | FLAG_NO_DATA,
 11374			{ },
 11375			{ { 0, 1 } },
 11376			.fill_helper = bpf_fill_jmp_jset_imm,
 11377			.nr_testruns = NR_PATTERN_RUNS,
 11378		},
 11379		{
 11380			"JMP_JEQ_K: all immediate value magnitudes",
 11381			{ },
 11382			INTERNAL | FLAG_NO_DATA,
 11383			{ },
 11384			{ { 0, 1 } },
 11385			.fill_helper = bpf_fill_jmp_jeq_imm,
 11386			.nr_testruns = NR_PATTERN_RUNS,
 11387		},
 11388		{
 11389			"JMP_JNE_K: all immediate value magnitudes",
 11390			{ },
 11391			INTERNAL | FLAG_NO_DATA,
 11392			{ },
 11393			{ { 0, 1 } },
 11394			.fill_helper = bpf_fill_jmp_jne_imm,
 11395			.nr_testruns = NR_PATTERN_RUNS,
 11396		},
 11397		{
 11398			"JMP_JGT_K: all immediate value magnitudes",
 11399			{ },
 11400			INTERNAL | FLAG_NO_DATA,
 11401			{ },
 11402			{ { 0, 1 } },
 11403			.fill_helper = bpf_fill_jmp_jgt_imm,
 11404			.nr_testruns = NR_PATTERN_RUNS,
 11405		},
 11406		{
 11407			"JMP_JGE_K: all immediate value magnitudes",
 11408			{ },
 11409			INTERNAL | FLAG_NO_DATA,
 11410			{ },
 11411			{ { 0, 1 } },
 11412			.fill_helper = bpf_fill_jmp_jge_imm,
 11413			.nr_testruns = NR_PATTERN_RUNS,
 11414		},
 11415		{
 11416			"JMP_JLT_K: all immediate value magnitudes",
 11417			{ },
 11418			INTERNAL | FLAG_NO_DATA,
 11419			{ },
 11420			{ { 0, 1 } },
 11421			.fill_helper = bpf_fill_jmp_jlt_imm,
 11422			.nr_testruns = NR_PATTERN_RUNS,
 11423		},
 11424		{
 11425			"JMP_JLE_K: all immediate value magnitudes",
 11426			{ },
 11427			INTERNAL | FLAG_NO_DATA,
 11428			{ },
 11429			{ { 0, 1 } },
 11430			.fill_helper = bpf_fill_jmp_jle_imm,
 11431			.nr_testruns = NR_PATTERN_RUNS,
 11432		},
 11433		{
 11434			"JMP_JSGT_K: all immediate value magnitudes",
 11435			{ },
 11436			INTERNAL | FLAG_NO_DATA,
 11437			{ },
 11438			{ { 0, 1 } },
 11439			.fill_helper = bpf_fill_jmp_jsgt_imm,
 11440			.nr_testruns = NR_PATTERN_RUNS,
 11441		},
 11442		{
 11443			"JMP_JSGE_K: all immediate value magnitudes",
 11444			{ },
 11445			INTERNAL | FLAG_NO_DATA,
 11446			{ },
 11447			{ { 0, 1 } },
 11448			.fill_helper = bpf_fill_jmp_jsge_imm,
 11449			.nr_testruns = NR_PATTERN_RUNS,
 11450		},
 11451		{
 11452			"JMP_JSLT_K: all immediate value magnitudes",
 11453			{ },
 11454			INTERNAL | FLAG_NO_DATA,
 11455			{ },
 11456			{ { 0, 1 } },
 11457			.fill_helper = bpf_fill_jmp_jslt_imm,
 11458			.nr_testruns = NR_PATTERN_RUNS,
 11459		},
 11460		{
 11461			"JMP_JSLE_K: all immediate value magnitudes",
 11462			{ },
 11463			INTERNAL | FLAG_NO_DATA,
 11464			{ },
 11465			{ { 0, 1 } },
 11466			.fill_helper = bpf_fill_jmp_jsle_imm,
 11467			.nr_testruns = NR_PATTERN_RUNS,
 11468		},
 11469		/* JMP register magnitudes */
 11470		{
 11471			"JMP_JSET_X: all register value magnitudes",
 11472			{ },
 11473			INTERNAL | FLAG_NO_DATA,
 11474			{ },
 11475			{ { 0, 1 } },
 11476			.fill_helper = bpf_fill_jmp_jset_reg,
 11477			.nr_testruns = NR_PATTERN_RUNS,
 11478		},
 11479		{
 11480			"JMP_JEQ_X: all register value magnitudes",
 11481			{ },
 11482			INTERNAL | FLAG_NO_DATA,
 11483			{ },
 11484			{ { 0, 1 } },
 11485			.fill_helper = bpf_fill_jmp_jeq_reg,
 11486			.nr_testruns = NR_PATTERN_RUNS,
 11487		},
 11488		{
 11489			"JMP_JNE_X: all register value magnitudes",
 11490			{ },
 11491			INTERNAL | FLAG_NO_DATA,
 11492			{ },
 11493			{ { 0, 1 } },
 11494			.fill_helper = bpf_fill_jmp_jne_reg,
 11495			.nr_testruns = NR_PATTERN_RUNS,
 11496		},
 11497		{
 11498			"JMP_JGT_X: all register value magnitudes",
 11499			{ },
 11500			INTERNAL | FLAG_NO_DATA,
 11501			{ },
 11502			{ { 0, 1 } },
 11503			.fill_helper = bpf_fill_jmp_jgt_reg,
 11504			.nr_testruns = NR_PATTERN_RUNS,
 11505		},
 11506		{
 11507			"JMP_JGE_X: all register value magnitudes",
 11508			{ },
 11509			INTERNAL | FLAG_NO_DATA,
 11510			{ },
 11511			{ { 0, 1 } },
 11512			.fill_helper = bpf_fill_jmp_jge_reg,
 11513			.nr_testruns = NR_PATTERN_RUNS,
 11514		},
 11515		{
 11516			"JMP_JLT_X: all register value magnitudes",
 11517			{ },
 11518			INTERNAL | FLAG_NO_DATA,
 11519			{ },
 11520			{ { 0, 1 } },
 11521			.fill_helper = bpf_fill_jmp_jlt_reg,
 11522			.nr_testruns = NR_PATTERN_RUNS,
 11523		},
 11524		{
 11525			"JMP_JLE_X: all register value magnitudes",
 11526			{ },
 11527			INTERNAL | FLAG_NO_DATA,
 11528			{ },
 11529			{ { 0, 1 } },
 11530			.fill_helper = bpf_fill_jmp_jle_reg,
 11531			.nr_testruns = NR_PATTERN_RUNS,
 11532		},
 11533		{
 11534			"JMP_JSGT_X: all register value magnitudes",
 11535			{ },
 11536			INTERNAL | FLAG_NO_DATA,
 11537			{ },
 11538			{ { 0, 1 } },
 11539			.fill_helper = bpf_fill_jmp_jsgt_reg,
 11540			.nr_testruns = NR_PATTERN_RUNS,
 11541		},
 11542		{
 11543			"JMP_JSGE_X: all register value magnitudes",
 11544			{ },
 11545			INTERNAL | FLAG_NO_DATA,
 11546			{ },
 11547			{ { 0, 1 } },
 11548			.fill_helper = bpf_fill_jmp_jsge_reg,
 11549			.nr_testruns = NR_PATTERN_RUNS,
 11550		},
 11551		{
 11552			"JMP_JSLT_X: all register value magnitudes",
 11553			{ },
 11554			INTERNAL | FLAG_NO_DATA,
 11555			{ },
 11556			{ { 0, 1 } },
 11557			.fill_helper = bpf_fill_jmp_jslt_reg,
 11558			.nr_testruns = NR_PATTERN_RUNS,
 11559		},
 11560		{
 11561			"JMP_JSLE_X: all register value magnitudes",
 11562			{ },
 11563			INTERNAL | FLAG_NO_DATA,
 11564			{ },
 11565			{ { 0, 1 } },
 11566			.fill_helper = bpf_fill_jmp_jsle_reg,
 11567			.nr_testruns = NR_PATTERN_RUNS,
 11568		},
 11569		/* JMP32 immediate magnitudes */
 11570		{
 11571			"JMP32_JSET_K: all immediate value magnitudes",
 11572			{ },
 11573			INTERNAL | FLAG_NO_DATA,
 11574			{ },
 11575			{ { 0, 1 } },
 11576			.fill_helper = bpf_fill_jmp32_jset_imm,
 11577			.nr_testruns = NR_PATTERN_RUNS,
 11578		},
 11579		{
 11580			"JMP32_JEQ_K: all immediate value magnitudes",
 11581			{ },
 11582			INTERNAL | FLAG_NO_DATA,
 11583			{ },
 11584			{ { 0, 1 } },
 11585			.fill_helper = bpf_fill_jmp32_jeq_imm,
 11586			.nr_testruns = NR_PATTERN_RUNS,
 11587		},
 11588		{
 11589			"JMP32_JNE_K: all immediate value magnitudes",
 11590			{ },
 11591			INTERNAL | FLAG_NO_DATA,
 11592			{ },
 11593			{ { 0, 1 } },
 11594			.fill_helper = bpf_fill_jmp32_jne_imm,
 11595			.nr_testruns = NR_PATTERN_RUNS,
 11596		},
 11597		{
 11598			"JMP32_JGT_K: all immediate value magnitudes",
 11599			{ },
 11600			INTERNAL | FLAG_NO_DATA,
 11601			{ },
 11602			{ { 0, 1 } },
 11603			.fill_helper = bpf_fill_jmp32_jgt_imm,
 11604			.nr_testruns = NR_PATTERN_RUNS,
 11605		},
 11606		{
 11607			"JMP32_JGE_K: all immediate value magnitudes",
 11608			{ },
 11609			INTERNAL | FLAG_NO_DATA,
 11610			{ },
 11611			{ { 0, 1 } },
 11612			.fill_helper = bpf_fill_jmp32_jge_imm,
 11613			.nr_testruns = NR_PATTERN_RUNS,
 11614		},
 11615		{
 11616			"JMP32_JLT_K: all immediate value magnitudes",
 11617			{ },
 11618			INTERNAL | FLAG_NO_DATA,
 11619			{ },
 11620			{ { 0, 1 } },
 11621			.fill_helper = bpf_fill_jmp32_jlt_imm,
 11622			.nr_testruns = NR_PATTERN_RUNS,
 11623		},
 11624		{
 11625			"JMP32_JLE_K: all immediate value magnitudes",
 11626			{ },
 11627			INTERNAL | FLAG_NO_DATA,
 11628			{ },
 11629			{ { 0, 1 } },
 11630			.fill_helper = bpf_fill_jmp32_jle_imm,
 11631			.nr_testruns = NR_PATTERN_RUNS,
 11632		},
 11633		{
 11634			"JMP32_JSGT_K: all immediate value magnitudes",
 11635			{ },
 11636			INTERNAL | FLAG_NO_DATA,
 11637			{ },
 11638			{ { 0, 1 } },
 11639			.fill_helper = bpf_fill_jmp32_jsgt_imm,
 11640			.nr_testruns = NR_PATTERN_RUNS,
 11641		},
 11642		{
 11643			"JMP32_JSGE_K: all immediate value magnitudes",
 11644			{ },
 11645			INTERNAL | FLAG_NO_DATA,
 11646			{ },
 11647			{ { 0, 1 } },
 11648			.fill_helper = bpf_fill_jmp32_jsge_imm,
 11649			.nr_testruns = NR_PATTERN_RUNS,
 11650		},
 11651		{
 11652			"JMP32_JSLT_K: all immediate value magnitudes",
 11653			{ },
 11654			INTERNAL | FLAG_NO_DATA,
 11655			{ },
 11656			{ { 0, 1 } },
 11657			.fill_helper = bpf_fill_jmp32_jslt_imm,
 11658			.nr_testruns = NR_PATTERN_RUNS,
 11659		},
 11660		{
 11661			"JMP32_JSLE_K: all immediate value magnitudes",
 11662			{ },
 11663			INTERNAL | FLAG_NO_DATA,
 11664			{ },
 11665			{ { 0, 1 } },
 11666			.fill_helper = bpf_fill_jmp32_jsle_imm,
 11667			.nr_testruns = NR_PATTERN_RUNS,
 11668		},
 11669		/* JMP32 register magnitudes */
 11670		{
 11671			"JMP32_JSET_X: all register value magnitudes",
 11672			{ },
 11673			INTERNAL | FLAG_NO_DATA,
 11674			{ },
 11675			{ { 0, 1 } },
 11676			.fill_helper = bpf_fill_jmp32_jset_reg,
 11677			.nr_testruns = NR_PATTERN_RUNS,
 11678		},
 11679		{
 11680			"JMP32_JEQ_X: all register value magnitudes",
 11681			{ },
 11682			INTERNAL | FLAG_NO_DATA,
 11683			{ },
 11684			{ { 0, 1 } },
 11685			.fill_helper = bpf_fill_jmp32_jeq_reg,
 11686			.nr_testruns = NR_PATTERN_RUNS,
 11687		},
 11688		{
 11689			"JMP32_JNE_X: all register value magnitudes",
 11690			{ },
 11691			INTERNAL | FLAG_NO_DATA,
 11692			{ },
 11693			{ { 0, 1 } },
 11694			.fill_helper = bpf_fill_jmp32_jne_reg,
 11695			.nr_testruns = NR_PATTERN_RUNS,
 11696		},
 11697		{
 11698			"JMP32_JGT_X: all register value magnitudes",
 11699			{ },
 11700			INTERNAL | FLAG_NO_DATA,
 11701			{ },
 11702			{ { 0, 1 } },
 11703			.fill_helper = bpf_fill_jmp32_jgt_reg,
 11704			.nr_testruns = NR_PATTERN_RUNS,
 11705		},
 11706		{
 11707			"JMP32_JGE_X: all register value magnitudes",
 11708			{ },
 11709			INTERNAL | FLAG_NO_DATA,
 11710			{ },
 11711			{ { 0, 1 } },
 11712			.fill_helper = bpf_fill_jmp32_jge_reg,
 11713			.nr_testruns = NR_PATTERN_RUNS,
 11714		},
 11715		{
 11716			"JMP32_JLT_X: all register value magnitudes",
 11717			{ },
 11718			INTERNAL | FLAG_NO_DATA,
 11719			{ },
 11720			{ { 0, 1 } },
 11721			.fill_helper = bpf_fill_jmp32_jlt_reg,
 11722			.nr_testruns = NR_PATTERN_RUNS,
 11723		},
 11724		{
 11725			"JMP32_JLE_X: all register value magnitudes",
 11726			{ },
 11727			INTERNAL | FLAG_NO_DATA,
 11728			{ },
 11729			{ { 0, 1 } },
 11730			.fill_helper = bpf_fill_jmp32_jle_reg,
 11731			.nr_testruns = NR_PATTERN_RUNS,
 11732		},
 11733		{
 11734			"JMP32_JSGT_X: all register value magnitudes",
 11735			{ },
 11736			INTERNAL | FLAG_NO_DATA,
 11737			{ },
 11738			{ { 0, 1 } },
 11739			.fill_helper = bpf_fill_jmp32_jsgt_reg,
 11740			.nr_testruns = NR_PATTERN_RUNS,
 11741		},
 11742		{
 11743			"JMP32_JSGE_X: all register value magnitudes",
 11744			{ },
 11745			INTERNAL | FLAG_NO_DATA,
 11746			{ },
 11747			{ { 0, 1 } },
 11748			.fill_helper = bpf_fill_jmp32_jsge_reg,
 11749			.nr_testruns = NR_PATTERN_RUNS,
 11750		},
 11751		{
 11752			"JMP32_JSLT_X: all register value magnitudes",
 11753			{ },
 11754			INTERNAL | FLAG_NO_DATA,
 11755			{ },
 11756			{ { 0, 1 } },
 11757			.fill_helper = bpf_fill_jmp32_jslt_reg,
 11758			.nr_testruns = NR_PATTERN_RUNS,
 11759		},
 11760		{
 11761			"JMP32_JSLE_X: all register value magnitudes",
 11762			{ },
 11763			INTERNAL | FLAG_NO_DATA,
 11764			{ },
 11765			{ { 0, 1 } },
 11766			.fill_helper = bpf_fill_jmp32_jsle_reg,
 11767			.nr_testruns = NR_PATTERN_RUNS,
 11768		},
 11769		/* Conditional jumps with constant decision */
 11770		{
 11771			"JMP_JSET_K: imm = 0 -> never taken",
 11772			.u.insns_int = {
 11773				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11774				BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
 11775				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11776				BPF_EXIT_INSN(),
 11777			},
 11778			INTERNAL | FLAG_NO_DATA,
 11779			{ },
 11780			{ { 0, 0 } },
 11781		},
 11782		{
 11783			"JMP_JLT_K: imm = 0 -> never taken",
 11784			.u.insns_int = {
 11785				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11786				BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
 11787				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11788				BPF_EXIT_INSN(),
 11789			},
 11790			INTERNAL | FLAG_NO_DATA,
 11791			{ },
 11792			{ { 0, 0 } },
 11793		},
 11794		{
 11795			"JMP_JGE_K: imm = 0 -> always taken",
 11796			.u.insns_int = {
 11797				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11798				BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
 11799				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11800				BPF_EXIT_INSN(),
 11801			},
 11802			INTERNAL | FLAG_NO_DATA,
 11803			{ },
 11804			{ { 0, 1 } },
 11805		},
 11806		{
 11807			"JMP_JGT_K: imm = 0xffffffff -> never taken",
 11808			.u.insns_int = {
 11809				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11810				BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
 11811				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11812				BPF_EXIT_INSN(),
 11813			},
 11814			INTERNAL | FLAG_NO_DATA,
 11815			{ },
 11816			{ { 0, 0 } },
 11817		},
 11818		{
 11819			"JMP_JLE_K: imm = 0xffffffff -> always taken",
 11820			.u.insns_int = {
 11821				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11822				BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
 11823				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11824				BPF_EXIT_INSN(),
 11825			},
 11826			INTERNAL | FLAG_NO_DATA,
 11827			{ },
 11828			{ { 0, 1 } },
 11829		},
 11830		{
 11831			"JMP32_JSGT_K: imm = 0x7fffffff -> never taken",
 11832			.u.insns_int = {
 11833				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11834				BPF_JMP32_IMM(BPF_JSGT, R1, S32_MAX, 1),
 11835				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11836				BPF_EXIT_INSN(),
 11837			},
 11838			INTERNAL | FLAG_NO_DATA,
 11839			{ },
 11840			{ { 0, 0 } },
 11841		},
 11842		{
 11843			"JMP32_JSGE_K: imm = -0x80000000 -> always taken",
 11844			.u.insns_int = {
 11845				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11846				BPF_JMP32_IMM(BPF_JSGE, R1, S32_MIN, 1),
 11847				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11848				BPF_EXIT_INSN(),
 11849			},
 11850			INTERNAL | FLAG_NO_DATA,
 11851			{ },
 11852			{ { 0, 1 } },
 11853		},
 11854		{
 11855			"JMP32_JSLT_K: imm = -0x80000000 -> never taken",
 11856			.u.insns_int = {
 11857				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11858				BPF_JMP32_IMM(BPF_JSLT, R1, S32_MIN, 1),
 11859				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11860				BPF_EXIT_INSN(),
 11861			},
 11862			INTERNAL | FLAG_NO_DATA,
 11863			{ },
 11864			{ { 0, 0 } },
 11865		},
 11866		{
 11867			"JMP32_JSLE_K: imm = 0x7fffffff -> always taken",
 11868			.u.insns_int = {
 11869				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11870				BPF_JMP32_IMM(BPF_JSLE, R1, S32_MAX, 1),
 11871				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11872				BPF_EXIT_INSN(),
 11873			},
 11874			INTERNAL | FLAG_NO_DATA,
 11875			{ },
 11876			{ { 0, 1 } },
 11877		},
 11878		{
 11879			"JMP_JEQ_X: dst = src -> always taken",
 11880			.u.insns_int = {
 11881				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11882				BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
 11883				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11884				BPF_EXIT_INSN(),
 11885			},
 11886			INTERNAL | FLAG_NO_DATA,
 11887			{ },
 11888			{ { 0, 1 } },
 11889		},
 11890		{
 11891			"JMP_JGE_X: dst = src -> always taken",
 11892			.u.insns_int = {
 11893				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11894				BPF_JMP_REG(BPF_JGE, R1, R1, 1),
 11895				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11896				BPF_EXIT_INSN(),
 11897			},
 11898			INTERNAL | FLAG_NO_DATA,
 11899			{ },
 11900			{ { 0, 1 } },
 11901		},
 11902		{
 11903			"JMP_JLE_X: dst = src -> always taken",
 11904			.u.insns_int = {
 11905				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11906				BPF_JMP_REG(BPF_JLE, R1, R1, 1),
 11907				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11908				BPF_EXIT_INSN(),
 11909			},
 11910			INTERNAL | FLAG_NO_DATA,
 11911			{ },
 11912			{ { 0, 1 } },
 11913		},
 11914		{
 11915			"JMP_JSGE_X: dst = src -> always taken",
 11916			.u.insns_int = {
 11917				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11918				BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
 11919				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11920				BPF_EXIT_INSN(),
 11921			},
 11922			INTERNAL | FLAG_NO_DATA,
 11923			{ },
 11924			{ { 0, 1 } },
 11925		},
 11926		{
 11927			"JMP_JSLE_X: dst = src -> always taken",
 11928			.u.insns_int = {
 11929				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11930				BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
 11931				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11932				BPF_EXIT_INSN(),
 11933			},
 11934			INTERNAL | FLAG_NO_DATA,
 11935			{ },
 11936			{ { 0, 1 } },
 11937		},
 11938		{
 11939			"JMP_JNE_X: dst = src -> never taken",
 11940			.u.insns_int = {
 11941				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11942				BPF_JMP_REG(BPF_JNE, R1, R1, 1),
 11943				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11944				BPF_EXIT_INSN(),
 11945			},
 11946			INTERNAL | FLAG_NO_DATA,
 11947			{ },
 11948			{ { 0, 0 } },
 11949		},
 11950		{
 11951			"JMP_JGT_X: dst = src -> never taken",
 11952			.u.insns_int = {
 11953				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11954				BPF_JMP_REG(BPF_JGT, R1, R1, 1),
 11955				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11956				BPF_EXIT_INSN(),
 11957			},
 11958			INTERNAL | FLAG_NO_DATA,
 11959			{ },
 11960			{ { 0, 0 } },
 11961		},
 11962		{
 11963			"JMP_JLT_X: dst = src -> never taken",
 11964			.u.insns_int = {
 11965				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11966				BPF_JMP_REG(BPF_JLT, R1, R1, 1),
 11967				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11968				BPF_EXIT_INSN(),
 11969			},
 11970			INTERNAL | FLAG_NO_DATA,
 11971			{ },
 11972			{ { 0, 0 } },
 11973		},
 11974		{
 11975			"JMP_JSGT_X: dst = src -> never taken",
 11976			.u.insns_int = {
 11977				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11978				BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
 11979				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11980				BPF_EXIT_INSN(),
 11981			},
 11982			INTERNAL | FLAG_NO_DATA,
 11983			{ },
 11984			{ { 0, 0 } },
 11985		},
 11986		{
 11987			"JMP_JSLT_X: dst = src -> never taken",
 11988			.u.insns_int = {
 11989				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11990				BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
 11991				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11992				BPF_EXIT_INSN(),
 11993			},
 11994			INTERNAL | FLAG_NO_DATA,
 11995			{ },
 11996			{ { 0, 0 } },
 11997		},
 11998		/* Short relative jumps */
 11999		{
 12000			"Short relative jump: offset=0",
 12001			.u.insns_int = {
 12002				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 12003				BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
 12004				BPF_EXIT_INSN(),
 12005				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 12006			},
 12007			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 12008			{ },
 12009			{ { 0, 0 } },
 12010		},
 12011		{
 12012			"Short relative jump: offset=1",
 12013			.u.insns_int = {
 12014				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 12015				BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
 12016				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12017				BPF_EXIT_INSN(),
 12018				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 12019			},
 12020			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 12021			{ },
 12022			{ { 0, 0 } },
 12023		},
 12024		{
 12025			"Short relative jump: offset=2",
 12026			.u.insns_int = {
 12027				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 12028				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
 12029				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12030				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12031				BPF_EXIT_INSN(),
 12032				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 12033			},
 12034			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 12035			{ },
 12036			{ { 0, 0 } },
 12037		},
 12038		{
 12039			"Short relative jump: offset=3",
 12040			.u.insns_int = {
 12041				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 12042				BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
 12043				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12044				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12045				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12046				BPF_EXIT_INSN(),
 12047				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 12048			},
 12049			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 12050			{ },
 12051			{ { 0, 0 } },
 12052		},
 12053		{
 12054			"Short relative jump: offset=4",
 12055			.u.insns_int = {
 12056				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 12057				BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
 12058				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12059				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12060				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12061				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 12062				BPF_EXIT_INSN(),
 12063				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 12064			},
 12065			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 12066			{ },
 12067			{ { 0, 0 } },
 12068		},
 12069		/* Conditional branch conversions */
 12070		{
 12071			"Long conditional jump: taken at runtime",
 12072			{ },
 12073			INTERNAL | FLAG_NO_DATA,
 12074			{ },
 12075			{ { 0, 1 } },
 12076			.fill_helper = bpf_fill_max_jmp_taken,
 12077		},
 12078		{
 12079			"Long conditional jump: not taken at runtime",
 12080			{ },
 12081			INTERNAL | FLAG_NO_DATA,
 12082			{ },
 12083			{ { 0, 2 } },
 12084			.fill_helper = bpf_fill_max_jmp_not_taken,
 12085		},
 12086		{
 12087			"Long conditional jump: always taken, known at JIT time",
 12088			{ },
 12089			INTERNAL | FLAG_NO_DATA,
 12090			{ },
 12091			{ { 0, 1 } },
 12092			.fill_helper = bpf_fill_max_jmp_always_taken,
 12093		},
 12094		{
 12095			"Long conditional jump: never taken, known at JIT time",
 12096			{ },
 12097			INTERNAL | FLAG_NO_DATA,
 12098			{ },
 12099			{ { 0, 2 } },
 12100			.fill_helper = bpf_fill_max_jmp_never_taken,
 12101		},
 12102		/* Staggered jump sequences, immediate */
 12103		{
 12104			"Staggered jumps: JMP_JA",
 12105			{ },
 12106			INTERNAL | FLAG_NO_DATA,
 12107			{ },
 12108			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12109			.fill_helper = bpf_fill_staggered_ja,
 12110			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12111		},
 12112		{
 12113			"Staggered jumps: JMP_JEQ_K",
 12114			{ },
 12115			INTERNAL | FLAG_NO_DATA,
 12116			{ },
 12117			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12118			.fill_helper = bpf_fill_staggered_jeq_imm,
 12119			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12120		},
 12121		{
 12122			"Staggered jumps: JMP_JNE_K",
 12123			{ },
 12124			INTERNAL | FLAG_NO_DATA,
 12125			{ },
 12126			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12127			.fill_helper = bpf_fill_staggered_jne_imm,
 12128			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12129		},
 12130		{
 12131			"Staggered jumps: JMP_JSET_K",
 12132			{ },
 12133			INTERNAL | FLAG_NO_DATA,
 12134			{ },
 12135			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12136			.fill_helper = bpf_fill_staggered_jset_imm,
 12137			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12138		},
 12139		{
 12140			"Staggered jumps: JMP_JGT_K",
 12141			{ },
 12142			INTERNAL | FLAG_NO_DATA,
 12143			{ },
 12144			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12145			.fill_helper = bpf_fill_staggered_jgt_imm,
 12146			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12147		},
 12148		{
 12149			"Staggered jumps: JMP_JGE_K",
 12150			{ },
 12151			INTERNAL | FLAG_NO_DATA,
 12152			{ },
 12153			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12154			.fill_helper = bpf_fill_staggered_jge_imm,
 12155			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12156		},
 12157		{
 12158			"Staggered jumps: JMP_JLT_K",
 12159			{ },
 12160			INTERNAL | FLAG_NO_DATA,
 12161			{ },
 12162			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12163			.fill_helper = bpf_fill_staggered_jlt_imm,
 12164			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12165		},
 12166		{
 12167			"Staggered jumps: JMP_JLE_K",
 12168			{ },
 12169			INTERNAL | FLAG_NO_DATA,
 12170			{ },
 12171			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12172			.fill_helper = bpf_fill_staggered_jle_imm,
 12173			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12174		},
 12175		{
 12176			"Staggered jumps: JMP_JSGT_K",
 12177			{ },
 12178			INTERNAL | FLAG_NO_DATA,
 12179			{ },
 12180			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12181			.fill_helper = bpf_fill_staggered_jsgt_imm,
 12182			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12183		},
 12184		{
 12185			"Staggered jumps: JMP_JSGE_K",
 12186			{ },
 12187			INTERNAL | FLAG_NO_DATA,
 12188			{ },
 12189			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12190			.fill_helper = bpf_fill_staggered_jsge_imm,
 12191			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12192		},
 12193		{
 12194			"Staggered jumps: JMP_JSLT_K",
 12195			{ },
 12196			INTERNAL | FLAG_NO_DATA,
 12197			{ },
 12198			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12199			.fill_helper = bpf_fill_staggered_jslt_imm,
 12200			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12201		},
 12202		{
 12203			"Staggered jumps: JMP_JSLE_K",
 12204			{ },
 12205			INTERNAL | FLAG_NO_DATA,
 12206			{ },
 12207			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12208			.fill_helper = bpf_fill_staggered_jsle_imm,
 12209			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12210		},
 12211		/* Staggered jump sequences, register */
 12212		{
 12213			"Staggered jumps: JMP_JEQ_X",
 12214			{ },
 12215			INTERNAL | FLAG_NO_DATA,
 12216			{ },
 12217			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12218			.fill_helper = bpf_fill_staggered_jeq_reg,
 12219			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12220		},
 12221		{
 12222			"Staggered jumps: JMP_JNE_X",
 12223			{ },
 12224			INTERNAL | FLAG_NO_DATA,
 12225			{ },
 12226			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12227			.fill_helper = bpf_fill_staggered_jne_reg,
 12228			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12229		},
 12230		{
 12231			"Staggered jumps: JMP_JSET_X",
 12232			{ },
 12233			INTERNAL | FLAG_NO_DATA,
 12234			{ },
 12235			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12236			.fill_helper = bpf_fill_staggered_jset_reg,
 12237			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12238		},
 12239		{
 12240			"Staggered jumps: JMP_JGT_X",
 12241			{ },
 12242			INTERNAL | FLAG_NO_DATA,
 12243			{ },
 12244			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12245			.fill_helper = bpf_fill_staggered_jgt_reg,
 12246			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12247		},
 12248		{
 12249			"Staggered jumps: JMP_JGE_X",
 12250			{ },
 12251			INTERNAL | FLAG_NO_DATA,
 12252			{ },
 12253			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12254			.fill_helper = bpf_fill_staggered_jge_reg,
 12255			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12256		},
 12257		{
 12258			"Staggered jumps: JMP_JLT_X",
 12259			{ },
 12260			INTERNAL | FLAG_NO_DATA,
 12261			{ },
 12262			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12263			.fill_helper = bpf_fill_staggered_jlt_reg,
 12264			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12265		},
 12266		{
 12267			"Staggered jumps: JMP_JLE_X",
 12268			{ },
 12269			INTERNAL | FLAG_NO_DATA,
 12270			{ },
 12271			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12272			.fill_helper = bpf_fill_staggered_jle_reg,
 12273			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12274		},
 12275		{
 12276			"Staggered jumps: JMP_JSGT_X",
 12277			{ },
 12278			INTERNAL | FLAG_NO_DATA,
 12279			{ },
 12280			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12281			.fill_helper = bpf_fill_staggered_jsgt_reg,
 12282			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12283		},
 12284		{
 12285			"Staggered jumps: JMP_JSGE_X",
 12286			{ },
 12287			INTERNAL | FLAG_NO_DATA,
 12288			{ },
 12289			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12290			.fill_helper = bpf_fill_staggered_jsge_reg,
 12291			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12292		},
 12293		{
 12294			"Staggered jumps: JMP_JSLT_X",
 12295			{ },
 12296			INTERNAL | FLAG_NO_DATA,
 12297			{ },
 12298			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12299			.fill_helper = bpf_fill_staggered_jslt_reg,
 12300			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12301		},
 12302		{
 12303			"Staggered jumps: JMP_JSLE_X",
 12304			{ },
 12305			INTERNAL | FLAG_NO_DATA,
 12306			{ },
 12307			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12308			.fill_helper = bpf_fill_staggered_jsle_reg,
 12309			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12310		},
 12311		/* Staggered jump sequences, JMP32 immediate */
 12312		{
 12313			"Staggered jumps: JMP32_JEQ_K",
 12314			{ },
 12315			INTERNAL | FLAG_NO_DATA,
 12316			{ },
 12317			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12318			.fill_helper = bpf_fill_staggered_jeq32_imm,
 12319			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12320		},
 12321		{
 12322			"Staggered jumps: JMP32_JNE_K",
 12323			{ },
 12324			INTERNAL | FLAG_NO_DATA,
 12325			{ },
 12326			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12327			.fill_helper = bpf_fill_staggered_jne32_imm,
 12328			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12329		},
 12330		{
 12331			"Staggered jumps: JMP32_JSET_K",
 12332			{ },
 12333			INTERNAL | FLAG_NO_DATA,
 12334			{ },
 12335			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12336			.fill_helper = bpf_fill_staggered_jset32_imm,
 12337			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12338		},
 12339		{
 12340			"Staggered jumps: JMP32_JGT_K",
 12341			{ },
 12342			INTERNAL | FLAG_NO_DATA,
 12343			{ },
 12344			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12345			.fill_helper = bpf_fill_staggered_jgt32_imm,
 12346			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12347		},
 12348		{
 12349			"Staggered jumps: JMP32_JGE_K",
 12350			{ },
 12351			INTERNAL | FLAG_NO_DATA,
 12352			{ },
 12353			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12354			.fill_helper = bpf_fill_staggered_jge32_imm,
 12355			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12356		},
 12357		{
 12358			"Staggered jumps: JMP32_JLT_K",
 12359			{ },
 12360			INTERNAL | FLAG_NO_DATA,
 12361			{ },
 12362			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12363			.fill_helper = bpf_fill_staggered_jlt32_imm,
 12364			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12365		},
 12366		{
 12367			"Staggered jumps: JMP32_JLE_K",
 12368			{ },
 12369			INTERNAL | FLAG_NO_DATA,
 12370			{ },
 12371			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12372			.fill_helper = bpf_fill_staggered_jle32_imm,
 12373			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12374		},
 12375		{
 12376			"Staggered jumps: JMP32_JSGT_K",
 12377			{ },
 12378			INTERNAL | FLAG_NO_DATA,
 12379			{ },
 12380			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12381			.fill_helper = bpf_fill_staggered_jsgt32_imm,
 12382			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12383		},
 12384		{
 12385			"Staggered jumps: JMP32_JSGE_K",
 12386			{ },
 12387			INTERNAL | FLAG_NO_DATA,
 12388			{ },
 12389			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12390			.fill_helper = bpf_fill_staggered_jsge32_imm,
 12391			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12392		},
 12393		{
 12394			"Staggered jumps: JMP32_JSLT_K",
 12395			{ },
 12396			INTERNAL | FLAG_NO_DATA,
 12397			{ },
 12398			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12399			.fill_helper = bpf_fill_staggered_jslt32_imm,
 12400			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12401		},
 12402		{
 12403			"Staggered jumps: JMP32_JSLE_K",
 12404			{ },
 12405			INTERNAL | FLAG_NO_DATA,
 12406			{ },
 12407			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12408			.fill_helper = bpf_fill_staggered_jsle32_imm,
 12409			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12410		},
 12411		/* Staggered jump sequences, JMP32 register */
 12412		{
 12413			"Staggered jumps: JMP32_JEQ_X",
 12414			{ },
 12415			INTERNAL | FLAG_NO_DATA,
 12416			{ },
 12417			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12418			.fill_helper = bpf_fill_staggered_jeq32_reg,
 12419			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12420		},
 12421		{
 12422			"Staggered jumps: JMP32_JNE_X",
 12423			{ },
 12424			INTERNAL | FLAG_NO_DATA,
 12425			{ },
 12426			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12427			.fill_helper = bpf_fill_staggered_jne32_reg,
 12428			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12429		},
 12430		{
 12431			"Staggered jumps: JMP32_JSET_X",
 12432			{ },
 12433			INTERNAL | FLAG_NO_DATA,
 12434			{ },
 12435			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12436			.fill_helper = bpf_fill_staggered_jset32_reg,
 12437			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12438		},
 12439		{
 12440			"Staggered jumps: JMP32_JGT_X",
 12441			{ },
 12442			INTERNAL | FLAG_NO_DATA,
 12443			{ },
 12444			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12445			.fill_helper = bpf_fill_staggered_jgt32_reg,
 12446			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12447		},
 12448		{
 12449			"Staggered jumps: JMP32_JGE_X",
 12450			{ },
 12451			INTERNAL | FLAG_NO_DATA,
 12452			{ },
 12453			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12454			.fill_helper = bpf_fill_staggered_jge32_reg,
 12455			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12456		},
 12457		{
 12458			"Staggered jumps: JMP32_JLT_X",
 12459			{ },
 12460			INTERNAL | FLAG_NO_DATA,
 12461			{ },
 12462			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12463			.fill_helper = bpf_fill_staggered_jlt32_reg,
 12464			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12465		},
 12466		{
 12467			"Staggered jumps: JMP32_JLE_X",
 12468			{ },
 12469			INTERNAL | FLAG_NO_DATA,
 12470			{ },
 12471			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12472			.fill_helper = bpf_fill_staggered_jle32_reg,
 12473			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12474		},
 12475		{
 12476			"Staggered jumps: JMP32_JSGT_X",
 12477			{ },
 12478			INTERNAL | FLAG_NO_DATA,
 12479			{ },
 12480			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12481			.fill_helper = bpf_fill_staggered_jsgt32_reg,
 12482			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12483		},
 12484		{
 12485			"Staggered jumps: JMP32_JSGE_X",
 12486			{ },
 12487			INTERNAL | FLAG_NO_DATA,
 12488			{ },
 12489			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12490			.fill_helper = bpf_fill_staggered_jsge32_reg,
 12491			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12492		},
 12493		{
 12494			"Staggered jumps: JMP32_JSLT_X",
 12495			{ },
 12496			INTERNAL | FLAG_NO_DATA,
 12497			{ },
 12498			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12499			.fill_helper = bpf_fill_staggered_jslt32_reg,
 12500			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12501		},
 12502		{
 12503			"Staggered jumps: JMP32_JSLE_X",
 12504			{ },
 12505			INTERNAL | FLAG_NO_DATA,
 12506			{ },
 12507			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 12508			.fill_helper = bpf_fill_staggered_jsle32_reg,
 12509			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 12510		},
 12511	};
 12512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

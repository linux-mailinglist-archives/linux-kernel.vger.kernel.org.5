Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F757A1095
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjINWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:09:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2BE270B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694729393; x=1726265393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tjg2RypE8ZmSJhS1/ioVdiv5NX1uITgdokZk/s/UCpg=;
  b=YSCbIP1NXh16TOEJQbrjWrLi4lc+IdQgHQhwWIIvT//lP43SP+xvLgb+
   ees4eNi1JvCsScnwea4BLueyExq1ktYbIKiKEBMHZXoSSn4/V9zh5hlpi
   D8HaCTHuKSzItsbzJvPXoXchjkAZmoOafBKia33Xwjjal6pU6fFj32mB9
   jgpTo2aX2CuXYzBfJJS6KhQBKGe6hsCD4uMF621fC8mfarUp1VphA7qdZ
   rbxUSd0stDY/ylBAJFSon8DWs+77fe8AsiEbEVBZTLJjbUVyQaozy2YTH
   NyHLm8HYnEpOPFEznspIa9Ja8oIHbWSpRqmhims+PZ2DRd+/SIjTrlqoE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410028989"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410028989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 15:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075550994"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="1075550994"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2023 15:09:51 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qguWz-000271-0U;
        Thu, 14 Sep 2023 22:09:49 +0000
Date:   Fri, 15 Sep 2023 06:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:843:1: warning:
 the frame size of 1228 bytes is larger than 1024 bytes
Message-ID: <202309150608.QJq73Uqn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: 67d637516fa91c718dd60acd9358a9fb0e19b7b5 net: microchip: sparx5: Adding KUNIT test for the VCAP API
date:   11 months ago
config: i386-buildonly-randconfig-003-20230915 (https://download.01.org/0day-ci/archive/20230915/202309150608.QJq73Uqn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150608.QJq73Uqn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150608.QJq73Uqn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:1183:
   drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c: In function 'vcap_api_encode_rule_keyset_test':
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:843:1: warning: the frame size of 1228 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     843 | }
         | ^


vim +843 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c

   732	
   733	static void vcap_api_encode_rule_keyset_test(struct kunit *test)
   734	{
   735		u32 keywords[16] = {0};
   736		u32 maskwords[16] = {0};
   737		struct vcap_admin admin = {
   738			.vtype = VCAP_TYPE_IS2,
   739			.cache = {
   740				.keystream = keywords,
   741				.maskstream = maskwords,
   742			},
   743		};
   744		struct vcap_rule_internal rule = {
   745			.admin = &admin,
   746			.data = {
   747				.keyset = VCAP_KFS_MAC_ETYPE,
   748			},
   749			.vctrl = &test_vctrl,
   750		};
   751		struct vcap_client_keyfield ckf[] = {
   752			{
   753				.ctrl.key = VCAP_KF_TYPE,
   754				.ctrl.type = VCAP_FIELD_U32,
   755				.data.u32.value = 0x00,
   756				.data.u32.mask = 0x0f,
   757			},
   758			{
   759				.ctrl.key = VCAP_KF_LOOKUP_FIRST_IS,
   760				.ctrl.type = VCAP_FIELD_BIT,
   761				.data.u1.value = 0x01,
   762				.data.u1.mask = 0x01,
   763			},
   764			{
   765				.ctrl.key = VCAP_KF_IF_IGR_PORT_MASK_L3,
   766				.ctrl.type = VCAP_FIELD_BIT,
   767				.data.u1.value = 0x00,
   768				.data.u1.mask = 0x01,
   769			},
   770			{
   771				.ctrl.key = VCAP_KF_IF_IGR_PORT_MASK_RNG,
   772				.ctrl.type = VCAP_FIELD_U32,
   773				.data.u32.value = 0x00,
   774				.data.u32.mask = 0x0f,
   775			},
   776			{
   777				.ctrl.key = VCAP_KF_IF_IGR_PORT_MASK,
   778				.ctrl.type = VCAP_FIELD_U72,
   779				.data.u72.value = {0x0, 0x00, 0x00, 0x00},
   780				.data.u72.mask = {0xfd, 0xff, 0xff, 0xff},
   781			},
   782			{
   783				.ctrl.key = VCAP_KF_L2_DMAC,
   784				.ctrl.type = VCAP_FIELD_U48,
   785				/* Opposite endianness */
   786				.data.u48.value = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06},
   787				.data.u48.mask = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
   788			},
   789			{
   790				.ctrl.key = VCAP_KF_ETYPE_LEN_IS,
   791				.ctrl.type = VCAP_FIELD_BIT,
   792				.data.u1.value = 0x01,
   793				.data.u1.mask = 0x01,
   794			},
   795			{
   796				.ctrl.key = VCAP_KF_ETYPE,
   797				.ctrl.type = VCAP_FIELD_U32,
   798				.data.u32.value = 0xaabb,
   799				.data.u32.mask = 0xffff,
   800			},
   801		};
   802		int idx;
   803		int ret;
   804	
   805		/* Empty entry list */
   806		INIT_LIST_HEAD(&rule.data.keyfields);
   807		ret = vcap_encode_rule_keyset(&rule);
   808		KUNIT_EXPECT_EQ(test, -EINVAL, ret);
   809	
   810		for (idx = 0; idx < ARRAY_SIZE(ckf); idx++)
   811			list_add_tail(&ckf[idx].ctrl.list, &rule.data.keyfields);
   812		ret = vcap_encode_rule_keyset(&rule);
   813		KUNIT_EXPECT_EQ(test, 0, ret);
   814	
   815		/* The key and mask values below are from an actual Sparx5 rule config */
   816		/* Key */
   817		KUNIT_EXPECT_EQ(test, (u32)0x00000042, keywords[0]);
   818		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[1]);
   819		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[2]);
   820		KUNIT_EXPECT_EQ(test, (u32)0x00020100, keywords[3]);
   821		KUNIT_EXPECT_EQ(test, (u32)0x60504030, keywords[4]);
   822		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[5]);
   823		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[6]);
   824		KUNIT_EXPECT_EQ(test, (u32)0x0002aaee, keywords[7]);
   825		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[8]);
   826		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[9]);
   827		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[10]);
   828		KUNIT_EXPECT_EQ(test, (u32)0x00000000, keywords[11]);
   829	
   830		/* Mask: they will be inverted when applied to the register */
   831		KUNIT_EXPECT_EQ(test, (u32)~0x00b07f80, maskwords[0]);
   832		KUNIT_EXPECT_EQ(test, (u32)~0xfff00000, maskwords[1]);
   833		KUNIT_EXPECT_EQ(test, (u32)~0xfffffffc, maskwords[2]);
   834		KUNIT_EXPECT_EQ(test, (u32)~0xfff000ff, maskwords[3]);
   835		KUNIT_EXPECT_EQ(test, (u32)~0x00000000, maskwords[4]);
   836		KUNIT_EXPECT_EQ(test, (u32)~0xfffffff0, maskwords[5]);
   837		KUNIT_EXPECT_EQ(test, (u32)~0xfffffffe, maskwords[6]);
   838		KUNIT_EXPECT_EQ(test, (u32)~0xfffc0001, maskwords[7]);
   839		KUNIT_EXPECT_EQ(test, (u32)~0xffffffff, maskwords[8]);
   840		KUNIT_EXPECT_EQ(test, (u32)~0xffffffff, maskwords[9]);
   841		KUNIT_EXPECT_EQ(test, (u32)~0xffffffff, maskwords[10]);
   842		KUNIT_EXPECT_EQ(test, (u32)~0xffffffff, maskwords[11]);
 > 843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

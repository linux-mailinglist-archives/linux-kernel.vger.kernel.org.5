Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422A804114
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjLDVo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjLDVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:44:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29821CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701726273; x=1733262273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNJZGm91Ibr6J8esVUNzX4TuaPkqF6V07nw5A9qII8Y=;
  b=N+zIgYYpSlINx3j04mpCcTt0zfvKm8wQ3r42R07KIRgOLiUR30PQk9q7
   dsNjmqzsdmJWSC/c4/OsD7grpkwPpAVL3HTMwdjyFSC4kzamXzHT2sGV8
   uljo7ByVX+cUjfuO+sJLiC4Ncjwede9Wq9AgxaimRTyO+O9vi6A7bXtMG
   i8M9kb9eEuod0CRt0IGI6KYiiBPKMTNfehpom9eYxzz/9aJ9VL67bm0Ul
   Z0GpfBEthvq6vhPejCbp//z4y7MjFJpi7O3uBa+PB0AvObZT06/SM8oAH
   p7UYv6Jd3OHpC7nLKYkL0Rcr1VY787aG6uw9r/975/hdTVPHVbsAvJ1b4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378829575"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="378829575"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841205965"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="841205965"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2023 13:44:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAGjt-00086h-00;
        Mon, 04 Dec 2023 21:44:29 +0000
Date:   Tue, 5 Dec 2023 05:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/misc/iqs626a.c:780:61: warning: '%d' directive output
 may be truncated writing between 1 and 10 bytes into a region of size 2
Message-ID: <202312050442.h4TNpY9h-lkp@intel.com>
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

Hi Jeff,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 4d3d2694e168c542b088eef5059d31498f679020 Input: iqs626a - drop unused device node references
date:   10 months ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231205/202312050442.h4TNpY9h-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050442.h4TNpY9h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050442.h4TNpY9h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/misc/iqs626a.c: In function 'iqs626_parse_trackpad':
>> drivers/input/misc/iqs626a.c:780:61: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
     780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
         |                                                             ^~
   drivers/input/misc/iqs626a.c:780:52: note: directive argument in the range [0, 2147483646]
     780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
         |                                                    ^~~~~~~~~~~~
   drivers/input/misc/iqs626a.c:780:17: note: 'snprintf' output between 10 and 19 bytes into a destination of size 10
     780 |                 snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +780 drivers/input/misc/iqs626a.c

   712	
   713	static int iqs626_parse_trackpad(struct iqs626_private *iqs626,
   714					 struct fwnode_handle *ch_node,
   715					 enum iqs626_ch_id ch_id)
   716	{
   717		struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
   718		struct i2c_client *client = iqs626->client;
   719		u8 *hyst = &sys_reg->tp_grp_reg.hyst;
   720		int error, count, i;
   721		unsigned int val;
   722	
   723		if (!fwnode_property_read_u32(ch_node, "azoteq,lta-update", &val)) {
   724			if (val > IQS626_MISC_A_TPx_LTA_UPDATE_MAX) {
   725				dev_err(&client->dev,
   726					"Invalid %s channel update rate: %u\n",
   727					fwnode_get_name(ch_node), val);
   728				return -EINVAL;
   729			}
   730	
   731			sys_reg->misc_a &= ~IQS626_MISC_A_TPx_LTA_UPDATE_MASK;
   732			sys_reg->misc_a |= (val << IQS626_MISC_A_TPx_LTA_UPDATE_SHIFT);
   733		}
   734	
   735		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-trackpad",
   736					      &val)) {
   737			if (val > IQS626_FILT_STR_MAX) {
   738				dev_err(&client->dev,
   739					"Invalid %s channel filter strength: %u\n",
   740					fwnode_get_name(ch_node), val);
   741				return -EINVAL;
   742			}
   743	
   744			sys_reg->misc_b &= ~IQS626_MISC_B_FILT_STR_TPx;
   745			sys_reg->misc_b |= val;
   746		}
   747	
   748		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-np-cnt",
   749					      &val)) {
   750			if (val > IQS626_FILT_STR_MAX) {
   751				dev_err(&client->dev,
   752					"Invalid %s channel filter strength: %u\n",
   753					fwnode_get_name(ch_node), val);
   754				return -EINVAL;
   755			}
   756	
   757			*hyst &= ~IQS626_FILT_STR_NP_TPx_MASK;
   758			*hyst |= (val << IQS626_FILT_STR_NP_TPx_SHIFT);
   759		}
   760	
   761		if (!fwnode_property_read_u32(ch_node, "azoteq,filt-str-lp-cnt",
   762					      &val)) {
   763			if (val > IQS626_FILT_STR_MAX) {
   764				dev_err(&client->dev,
   765					"Invalid %s channel filter strength: %u\n",
   766					fwnode_get_name(ch_node), val);
   767				return -EINVAL;
   768			}
   769	
   770			*hyst &= ~IQS626_FILT_STR_LP_TPx_MASK;
   771			*hyst |= (val << IQS626_FILT_STR_LP_TPx_SHIFT);
   772		}
   773	
   774		for (i = 0; i < iqs626_channels[ch_id].num_ch; i++) {
   775			u8 *ati_base = &sys_reg->tp_grp_reg.ch_reg_tp[i].ati_base;
   776			u8 *thresh = &sys_reg->tp_grp_reg.ch_reg_tp[i].thresh;
   777			struct fwnode_handle *tc_node;
   778			char tc_name[10];
   779	
 > 780			snprintf(tc_name, sizeof(tc_name), "channel-%d", i);
   781	
   782			tc_node = fwnode_get_named_child_node(ch_node, tc_name);
   783			if (!tc_node)
   784				continue;
   785	
   786			if (!fwnode_property_read_u32(tc_node, "azoteq,ati-base",
   787						      &val)) {
   788				if (val < IQS626_TPx_ATI_BASE_MIN ||
   789				    val > IQS626_TPx_ATI_BASE_MAX) {
   790					dev_err(&client->dev,
   791						"Invalid %s %s ATI base: %u\n",
   792						fwnode_get_name(ch_node), tc_name, val);
   793					fwnode_handle_put(tc_node);
   794					return -EINVAL;
   795				}
   796	
   797				*ati_base = val - IQS626_TPx_ATI_BASE_MIN;
   798			}
   799	
   800			if (!fwnode_property_read_u32(tc_node, "azoteq,thresh",
   801						      &val)) {
   802				if (val > IQS626_CHx_THRESH_MAX) {
   803					dev_err(&client->dev,
   804						"Invalid %s %s threshold: %u\n",
   805						fwnode_get_name(ch_node), tc_name, val);
   806					fwnode_handle_put(tc_node);
   807					return -EINVAL;
   808				}
   809	
   810				*thresh = val;
   811			}
   812	
   813			fwnode_handle_put(tc_node);
   814		}
   815	
   816		if (!fwnode_property_present(ch_node, "linux,keycodes"))
   817			return 0;
   818	
   819		count = fwnode_property_count_u32(ch_node, "linux,keycodes");
   820		if (count > IQS626_NUM_GESTURES) {
   821			dev_err(&client->dev, "Too many keycodes present\n");
   822			return -EINVAL;
   823		} else if (count < 0) {
   824			dev_err(&client->dev, "Failed to count keycodes: %d\n", count);
   825			return count;
   826		}
   827	
   828		error = fwnode_property_read_u32_array(ch_node, "linux,keycodes",
   829						       iqs626->tp_code, count);
   830		if (error) {
   831			dev_err(&client->dev, "Failed to read keycodes: %d\n", error);
   832			return error;
   833		}
   834	
   835		sys_reg->misc_b &= ~IQS626_MISC_B_TPx_SWIPE;
   836		if (fwnode_property_present(ch_node, "azoteq,gesture-swipe"))
   837			sys_reg->misc_b |= IQS626_MISC_B_TPx_SWIPE;
   838	
   839		if (!fwnode_property_read_u32(ch_node, "azoteq,timeout-tap-ms",
   840					      &val)) {
   841			if (val > IQS626_TIMEOUT_TAP_MS_MAX) {
   842				dev_err(&client->dev,
   843					"Invalid %s channel timeout: %u\n",
   844					fwnode_get_name(ch_node), val);
   845				return -EINVAL;
   846			}
   847	
   848			sys_reg->timeout_tap = val / 16;
   849		}
   850	
   851		if (!fwnode_property_read_u32(ch_node, "azoteq,timeout-swipe-ms",
   852					      &val)) {
   853			if (val > IQS626_TIMEOUT_SWIPE_MS_MAX) {
   854				dev_err(&client->dev,
   855					"Invalid %s channel timeout: %u\n",
   856					fwnode_get_name(ch_node), val);
   857				return -EINVAL;
   858			}
   859	
   860			sys_reg->timeout_swipe = val / 16;
   861		}
   862	
   863		if (!fwnode_property_read_u32(ch_node, "azoteq,thresh-swipe",
   864					      &val)) {
   865			if (val > IQS626_THRESH_SWIPE_MAX) {
   866				dev_err(&client->dev,
   867					"Invalid %s channel threshold: %u\n",
   868					fwnode_get_name(ch_node), val);
   869				return -EINVAL;
   870			}
   871	
   872			sys_reg->thresh_swipe = val;
   873		}
   874	
   875		sys_reg->event_mask &= ~IQS626_EVENT_MASK_GESTURE;
   876	
   877		return 0;
   878	}
   879	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

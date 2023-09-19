Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0837A6907
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjISQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:34:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE15CFD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695141242; x=1726677242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H03Jf9FFMNf6FaC979uZV3ZvEnmQtg+O5M6lBEFqbz8=;
  b=EXFp+u+YNjCK+f/GNBKdTVXgbPaOD4fZKlQw+WSJzHT/PwY3HNprmwIA
   F0z/XmNMKBpRnZ5AhcKJcACqzxtPCoz3vQETDjYFm/cQ8dFn/CE2Ip+JI
   1m0+IEfHgrLmuw2de5TsouxwNX46qSWT36xC61ttHApKnbb32mXxzsOAE
   pmcXB8hIQpzg4vvXF1zGDbv9MPbBtvrwuTu1Vet+CJd5O7QWy5VANIl46
   l/DPUOklmtSvvthh/tPIWDWvVGrDkprofA+GKLRzhTK1IZYc2FdCMngaI
   y7hfZPQpLQ+AjdJog2S0a0+cSNE5eHuAV/sV7LMziTT98VashVmBPl9Go
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410920628"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410920628"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870024856"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="870024856"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2023 09:33:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qidfh-0007f8-0k;
        Tue, 19 Sep 2023 16:33:57 +0000
Date:   Wed, 20 Sep 2023 00:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhishek Naik <abhishek.naik@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c:819:16: warning:
 '%s' directive argument is null
Message-ID: <202309200054.oMYrtDGK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 9457077df49e2a637a1f1c3be42c14af604fa920 wifi: iwlwifi: mvm: Add debugfs to get TAS status
date:   6 months ago
config: sparc64-allyesconfig (https://download.01.org/0day-ci/archive/20230920/202309200054.oMYrtDGK-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200054.oMYrtDGK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200054.oMYrtDGK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c: In function 'iwl_dbgfs_tas_get_status_read':
>> drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c:819:16: warning: '%s' directive argument is null [-Wformat-overflow=]
     819 |         pos += scnprintf(pos, endpos - pos, "\nOEM name: %s\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     820 |                          dmi_get_system_info(DMI_SYS_VENDOR));
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +819 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c

   718	
   719	static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
   720						     char __user *user_buf,
   721						     size_t count, loff_t *ppos)
   722	{
   723		struct iwl_mvm *mvm = file->private_data;
   724		struct iwl_mvm_tas_status_resp tas_rsp;
   725		struct iwl_mvm_tas_status_resp *rsp = &tas_rsp;
   726		static const size_t bufsz = 1024;
   727		char *buff, *pos, *endpos;
   728		const char * const tas_dis_reason[TAS_DISABLED_REASON_MAX] = {
   729			[TAS_DISABLED_DUE_TO_BIOS] =
   730				"Due To BIOS",
   731			[TAS_DISABLED_DUE_TO_SAR_6DBM] =
   732				"Due To SAR Limit Less Than 6 dBm",
   733			[TAS_DISABLED_REASON_INVALID] =
   734				"N/A",
   735		};
   736		const char * const tas_current_status[TAS_DYNA_STATUS_MAX] = {
   737			[TAS_DYNA_INACTIVE] = "INACTIVE",
   738			[TAS_DYNA_INACTIVE_MVM_MODE] =
   739				"inactive due to mvm mode",
   740			[TAS_DYNA_INACTIVE_TRIGGER_MODE] =
   741				"inactive due to trigger mode",
   742			[TAS_DYNA_INACTIVE_BLOCK_LISTED] =
   743				"inactive due to block listed",
   744			[TAS_DYNA_INACTIVE_UHB_NON_US] =
   745				"inactive due to uhb non US",
   746			[TAS_DYNA_ACTIVE] = "ACTIVE",
   747		};
   748		struct iwl_host_cmd hcmd = {
   749			.id = WIDE_ID(DEBUG_GROUP, GET_TAS_STATUS),
   750			.flags = CMD_WANT_SKB,
   751			.len = { 0, },
   752			.data = { NULL, },
   753		};
   754		int ret, i, tmp;
   755		bool tas_enabled = false;
   756		unsigned long dyn_status;
   757	
   758		if (!iwl_mvm_firmware_running(mvm))
   759			return -ENODEV;
   760	
   761		mutex_lock(&mvm->mutex);
   762		ret = iwl_mvm_send_cmd(mvm, &hcmd);
   763		mutex_unlock(&mvm->mutex);
   764		if (ret < 0)
   765			return ret;
   766	
   767		buff = kzalloc(bufsz, GFP_KERNEL);
   768		if (!buff)
   769			return -ENOMEM;
   770		pos = buff;
   771		endpos = pos + bufsz;
   772	
   773		rsp = (void *)hcmd.resp_pkt->data;
   774	
   775		pos += scnprintf(pos, endpos - pos, "TAS Conclusion:\n");
   776		for (i = 0; i < rsp->in_dual_radio + 1; i++) {
   777			if (rsp->tas_status_mac[i].band != TAS_LMAC_BAND_INVALID &&
   778			    rsp->tas_status_mac[i].dynamic_status & BIT(TAS_DYNA_ACTIVE)) {
   779				pos += scnprintf(pos, endpos - pos, "\tON for ");
   780				switch (rsp->tas_status_mac[i].band) {
   781				case TAS_LMAC_BAND_HB:
   782					pos += scnprintf(pos, endpos - pos, "HB\n");
   783					break;
   784				case TAS_LMAC_BAND_LB:
   785					pos += scnprintf(pos, endpos - pos, "LB\n");
   786					break;
   787				case TAS_LMAC_BAND_UHB:
   788					pos += scnprintf(pos, endpos - pos, "UHB\n");
   789					break;
   790				case TAS_LMAC_BAND_INVALID:
   791					pos += scnprintf(pos, endpos - pos,
   792							 "INVALID BAND\n");
   793					break;
   794				default:
   795					pos += scnprintf(pos, endpos - pos,
   796							 "Unsupported band (%d)\n",
   797							 rsp->tas_status_mac[i].band);
   798					goto out;
   799				}
   800				tas_enabled = true;
   801			}
   802		}
   803		if (!tas_enabled)
   804			pos += scnprintf(pos, endpos - pos, "\tOFF\n");
   805	
   806		pos += scnprintf(pos, endpos - pos, "TAS Report\n");
   807		pos += scnprintf(pos, endpos - pos, "TAS FW version: %d\n",
   808				 rsp->tas_fw_version);
   809		pos += scnprintf(pos, endpos - pos, "Is UHB enabled for USA?: %s\n",
   810				 rsp->is_uhb_for_usa_enable ? "True" : "False");
   811		pos += scnprintf(pos, endpos - pos, "Current MCC: 0x%x\n",
   812				 le16_to_cpu(rsp->curr_mcc));
   813	
   814		pos += scnprintf(pos, endpos - pos, "Block list entries:");
   815		for (i = 0; i < APCI_WTAS_BLACK_LIST_MAX; i++)
   816			pos += scnprintf(pos, endpos - pos, " 0x%x",
   817					 le16_to_cpu(rsp->block_list[i]));
   818	
 > 819		pos += scnprintf(pos, endpos - pos, "\nOEM name: %s\n",
   820				 dmi_get_system_info(DMI_SYS_VENDOR));
   821		pos += scnprintf(pos, endpos - pos, "\tVendor In Approved List: %s\n",
   822				 iwl_mvm_is_vendor_in_approved_list() ? "YES" : "NO");
   823		pos += scnprintf(pos, endpos - pos,
   824				 "\tDo TAS Support Dual Radio?: %s\n",
   825				 rsp->in_dual_radio ? "TRUE" : "FALSE");
   826	
   827		for (i = 0; i < rsp->in_dual_radio + 1; i++) {
   828			if (rsp->tas_status_mac[i].static_status == 0) {
   829				pos += scnprintf(pos, endpos - pos,
   830						 "Static status: disabled\n");
   831				pos += scnprintf(pos, endpos - pos,
   832						 "Static disabled reason: %s (0)\n",
   833						 tas_dis_reason[0]);
   834				goto out;
   835			}
   836	
   837			pos += scnprintf(pos, endpos - pos, "TAS status for ");
   838			switch (rsp->tas_status_mac[i].band) {
   839			case TAS_LMAC_BAND_HB:
   840				pos += scnprintf(pos, endpos - pos, "High band\n");
   841				break;
   842			case TAS_LMAC_BAND_LB:
   843				pos += scnprintf(pos, endpos - pos, "Low band\n");
   844				break;
   845			case TAS_LMAC_BAND_UHB:
   846				pos += scnprintf(pos, endpos - pos,
   847						 "Ultra high band\n");
   848				break;
   849			case TAS_LMAC_BAND_INVALID:
   850				pos += scnprintf(pos, endpos - pos,
   851						 "INVALID band\n");
   852				break;
   853			default:
   854				pos += scnprintf(pos, endpos - pos,
   855						 "Unsupported band (%d)\n",
   856						 rsp->tas_status_mac[i].band);
   857				goto out;
   858			}
   859			pos += scnprintf(pos, endpos - pos, "Static status: %sabled\n",
   860					 rsp->tas_status_mac[i].static_status ?
   861					 "En" : "Dis");
   862			pos += scnprintf(pos, endpos - pos,
   863					 "\tStatic Disabled Reason: ");
   864			if (rsp->tas_status_mac[i].static_dis_reason < TAS_DISABLED_REASON_MAX)
   865				pos += scnprintf(pos, endpos - pos, "%s (%d)\n",
   866						 tas_dis_reason[rsp->tas_status_mac[i].static_dis_reason],
   867						 rsp->tas_status_mac[i].static_dis_reason);
   868			else
   869				pos += scnprintf(pos, endpos - pos,
   870						 "unsupported value (%d)\n",
   871						 rsp->tas_status_mac[i].static_dis_reason);
   872	
   873			pos += scnprintf(pos, endpos - pos, "Dynamic status:\n");
   874			dyn_status = (rsp->tas_status_mac[i].dynamic_status);
   875			for_each_set_bit(tmp, &dyn_status, sizeof(dyn_status)) {
   876				if (tmp >= 0 && tmp < TAS_DYNA_STATUS_MAX)
   877					pos += scnprintf(pos, endpos - pos,
   878							 "\t%s (%d)\n",
   879							 tas_current_status[tmp], tmp);
   880			}
   881	
   882			pos += scnprintf(pos, endpos - pos,
   883					 "Is near disconnection?: %s\n",
   884					 rsp->tas_status_mac[i].near_disconnection ?
   885					 "True" : "False");
   886			tmp = le16_to_cpu(rsp->tas_status_mac[i].max_reg_pwr_limit);
   887			pos += scnprintf(pos, endpos - pos,
   888					 "Max. regulatory pwr limit (dBm): %d.%03d\n",
   889					 tmp / 8, 125 * (tmp % 8));
   890			tmp = le16_to_cpu(rsp->tas_status_mac[i].sar_limit);
   891			pos += scnprintf(pos, endpos - pos,
   892					 "SAR limit (dBm): %d.%03d\n",
   893					 tmp / 8, 125 * (tmp % 8));
   894		}
   895	
   896	out:
   897		ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
   898		kfree(buff);
   899		iwl_free_resp(&hcmd);
   900		return ret;
   901	}
   902	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

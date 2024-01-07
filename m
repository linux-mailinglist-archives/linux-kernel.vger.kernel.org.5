Return-Path: <linux-kernel+bounces-18966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CDB8265CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5A81F2117A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AF1118C;
	Sun,  7 Jan 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjHH13eO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277F11703
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704655850; x=1736191850;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XEukWokYebCfRmqAsgqf8DT3RcM7YADJLHmMXt/Jx58=;
  b=LjHH13eOiyhmgaalNRUCGhalZHFnpIgJ6guPICd3EJOvXilt7hsNWMlu
   pycQd8pxRcIn6ZwPDevit627gnPMXcU8WQ6MZdBSLSOq2xYmwS2ifSmAX
   FupINSpBLDDtgcbo9sdtVYJ8fYRhKanOItBoqc1/a3Lcx+4zQbEvu8ZFn
   p7IEWf283J2wsjdoA3yV9K9kFifpSe9bsa/qnB+sy2N6KaTYi7V4hql5y
   89Uu7ed7TuIhub8IttcK8GrwDiKE3GRVqPuLSUnDIqCDTN+SVCj6L/B9N
   5VFAXpkDxHQthtDsEE1haUTYC0nkWHhLhwp7iA3uCJGuL9naHmU1n0Eaa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="377236252"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="377236252"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 11:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028211303"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="1028211303"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2024 11:30:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMYr8-000440-0Q;
	Sun, 07 Jan 2024 19:30:46 +0000
Date: Mon, 8 Jan 2024 03:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Naik <abhishek.naik@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c:819:16: warning:
 '%s' directive argument is null
Message-ID: <202401080349.DpysLlAx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Abhishek,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 9457077df49e2a637a1f1c3be42c14af604fa920 wifi: iwlwifi: mvm: Add debugfs to get TAS status
date:   10 months ago
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240108/202401080349.DpysLlAx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080349.DpysLlAx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080349.DpysLlAx-lkp@intel.com/

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


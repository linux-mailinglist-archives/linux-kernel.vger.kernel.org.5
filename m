Return-Path: <linux-kernel+bounces-12945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF481FD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBC283309
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2E23B4;
	Fri, 29 Dec 2023 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrTmbdpC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC11FC6;
	Fri, 29 Dec 2023 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703826462; x=1735362462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RW9NR0qy+yngvdt3sOR4g5zaC03TNEsf7LMbSGcr3/c=;
  b=RrTmbdpCfrOZ+IcNOHNf5RmafIOCBxiblRYR6acewM1TfsySZ6Bk+kAg
   A+KnUrKsZdtgtqJvFXgclOX2FnavtibvT/BXsRx5OW+/LaeAKnpnkomVG
   CSwL7pf1bmVwQxfksffxweBQwBFfNpTjW3QbATTEp6qLqJExlZDQQflo3
   TTmM+3BWFybgnHXbEqGZW4LlNSPesI+43TDwBynM++QVMfKpHtVh4l5yL
   b7Az9C2onQqXx3iQvc5XdBg46hG1wRQtPVE3fwHE97ciYzp0mXDZKBQIu
   MbfLq2N/LRNptQOlAJ4oIGuhEtd4apNsYTOCJl29Qhtf9hPN+66Jen0gb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="399401786"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="399401786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 21:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="951994868"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="951994868"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2023 21:07:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ55s-000H6b-18;
	Fri, 29 Dec 2023 05:07:36 +0000
Date: Fri, 29 Dec 2023 13:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Tsao <peter.tsao@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Peter Tsao <peter.tsao@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fix MT7925 fail to send download patch
 command
Message-ID: <202312291253.5LoPimum-lkp@intel.com>
References: <20231228092014.23184-1-peter.tsao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228092014.23184-1-peter.tsao@mediatek.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Tsao/Bluetooth-btusb-Fix-MT7925-fail-to-send-download-patch-command/20231228-172328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20231228092014.23184-1-peter.tsao%40mediatek.com
patch subject: [PATCH] Bluetooth: btusb: Fix MT7925 fail to send download patch command
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231229/202312291253.5LoPimum-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291253.5LoPimum-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291253.5LoPimum-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_mtk_setup':
>> drivers/bluetooth/btusb.c:3122:63: error: 'val' undeclared (first use in this function)
    3122 |                 btusb_mtk_uhw_reg_read(data, MT7925_SLPPROT, &val);
         |                                                               ^~~
   drivers/bluetooth/btusb.c:3122:63: note: each undeclared identifier is reported only once for each function it appears in


vim +/val +3122 drivers/bluetooth/btusb.c

  3068	
  3069	static int btusb_mtk_setup(struct hci_dev *hdev)
  3070	{
  3071		struct btusb_data *data = hci_get_drvdata(hdev);
  3072		struct btmtk_hci_wmt_params wmt_params;
  3073		ktime_t calltime, delta, rettime;
  3074		struct btmtk_tci_sleep tci_sleep;
  3075		unsigned long long duration;
  3076		struct sk_buff *skb;
  3077		const char *fwname;
  3078		int err, status;
  3079		u32 dev_id = 0;
  3080		char fw_bin_name[64];
  3081		u32 fw_version = 0;
  3082		u8 param;
  3083		struct btmediatek_data *mediatek;
  3084	
  3085		calltime = ktime_get();
  3086	
  3087		err = btusb_mtk_id_get(data, 0x80000008, &dev_id);
  3088		if (err < 0) {
  3089			bt_dev_err(hdev, "Failed to get device id (%d)", err);
  3090			return err;
  3091		}
  3092	
  3093		if (!dev_id || dev_id != 0x7663) {
  3094			err = btusb_mtk_id_get(data, 0x70010200, &dev_id);
  3095			if (err < 0) {
  3096				bt_dev_err(hdev, "Failed to get device id (%d)", err);
  3097				return err;
  3098			}
  3099			err = btusb_mtk_id_get(data, 0x80021004, &fw_version);
  3100			if (err < 0) {
  3101				bt_dev_err(hdev, "Failed to get fw version (%d)", err);
  3102				return err;
  3103			}
  3104		}
  3105	
  3106		mediatek = hci_get_priv(hdev);
  3107		mediatek->dev_id = dev_id;
  3108		mediatek->reset_sync = btusb_mtk_reset;
  3109	
  3110		err = btmtk_register_coredump(hdev, btusb_driver.name, fw_version);
  3111		if (err < 0)
  3112			bt_dev_err(hdev, "Failed to register coredump (%d)", err);
  3113	
  3114		switch (dev_id) {
  3115		case 0x7663:
  3116			fwname = FIRMWARE_MT7663;
  3117			break;
  3118		case 0x7668:
  3119			fwname = FIRMWARE_MT7668;
  3120			break;
  3121		case 0x7925:
> 3122			btusb_mtk_uhw_reg_read(data, MT7925_SLPPROT, &val);
  3123			val |= SLPPROT_BYPASS;
  3124			btusb_mtk_uhw_reg_write(data, MT7925_SLPPROT, val);
  3125			fallthrough;
  3126		case 0x7922:
  3127		case 0x7961:
  3128			if (dev_id == 0x7925)
  3129				snprintf(fw_bin_name, sizeof(fw_bin_name),
  3130					 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
  3131					 dev_id & 0xffff, dev_id & 0xffff, (fw_version & 0xff) + 1);
  3132			else
  3133				snprintf(fw_bin_name, sizeof(fw_bin_name),
  3134					 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
  3135					 dev_id & 0xffff, (fw_version & 0xff) + 1);
  3136	
  3137			err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
  3138							btusb_mtk_hci_wmt_sync);
  3139			if (err < 0) {
  3140				bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
  3141				return err;
  3142			}
  3143	
  3144			/* It's Device EndPoint Reset Option Register */
  3145			btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
  3146	
  3147			/* Enable Bluetooth protocol */
  3148			param = 1;
  3149			wmt_params.op = BTMTK_WMT_FUNC_CTRL;
  3150			wmt_params.flag = 0;
  3151			wmt_params.dlen = sizeof(param);
  3152			wmt_params.data = &param;
  3153			wmt_params.status = NULL;
  3154	
  3155			err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
  3156			if (err < 0) {
  3157				bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
  3158				return err;
  3159			}
  3160	
  3161			hci_set_msft_opcode(hdev, 0xFD30);
  3162			hci_set_aosp_capable(hdev);
  3163			goto done;
  3164		default:
  3165			bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
  3166				   dev_id);
  3167			return -ENODEV;
  3168		}
  3169	
  3170		/* Query whether the firmware is already download */
  3171		wmt_params.op = BTMTK_WMT_SEMAPHORE;
  3172		wmt_params.flag = 1;
  3173		wmt_params.dlen = 0;
  3174		wmt_params.data = NULL;
  3175		wmt_params.status = &status;
  3176	
  3177		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
  3178		if (err < 0) {
  3179			bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
  3180			return err;
  3181		}
  3182	
  3183		if (status == BTMTK_WMT_PATCH_DONE) {
  3184			bt_dev_info(hdev, "firmware already downloaded");
  3185			goto ignore_setup_fw;
  3186		}
  3187	
  3188		/* Setup a firmware which the device definitely requires */
  3189		err = btmtk_setup_firmware(hdev, fwname,
  3190					   btusb_mtk_hci_wmt_sync);
  3191		if (err < 0)
  3192			return err;
  3193	
  3194	ignore_setup_fw:
  3195		err = readx_poll_timeout(btusb_mtk_func_query, hdev, status,
  3196					 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
  3197					 2000, 5000000);
  3198		/* -ETIMEDOUT happens */
  3199		if (err < 0)
  3200			return err;
  3201	
  3202		/* The other errors happen in btusb_mtk_func_query */
  3203		if (status < 0)
  3204			return status;
  3205	
  3206		if (status == BTMTK_WMT_ON_DONE) {
  3207			bt_dev_info(hdev, "function already on");
  3208			goto ignore_func_on;
  3209		}
  3210	
  3211		/* Enable Bluetooth protocol */
  3212		param = 1;
  3213		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
  3214		wmt_params.flag = 0;
  3215		wmt_params.dlen = sizeof(param);
  3216		wmt_params.data = &param;
  3217		wmt_params.status = NULL;
  3218	
  3219		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
  3220		if (err < 0) {
  3221			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
  3222			return err;
  3223		}
  3224	
  3225	ignore_func_on:
  3226		/* Apply the low power environment setup */
  3227		tci_sleep.mode = 0x5;
  3228		tci_sleep.duration = cpu_to_le16(0x640);
  3229		tci_sleep.host_duration = cpu_to_le16(0x640);
  3230		tci_sleep.host_wakeup_pin = 0;
  3231		tci_sleep.time_compensation = 0;
  3232	
  3233		skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
  3234				     HCI_INIT_TIMEOUT);
  3235		if (IS_ERR(skb)) {
  3236			err = PTR_ERR(skb);
  3237			bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
  3238			return err;
  3239		}
  3240		kfree_skb(skb);
  3241	
  3242	done:
  3243		rettime = ktime_get();
  3244		delta = ktime_sub(rettime, calltime);
  3245		duration = (unsigned long long)ktime_to_ns(delta) >> 10;
  3246	
  3247		bt_dev_info(hdev, "Device setup in %llu usecs", duration);
  3248	
  3249		return 0;
  3250	}
  3251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


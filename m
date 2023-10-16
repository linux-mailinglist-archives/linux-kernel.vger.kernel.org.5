Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735887CA69D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJPLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:21:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAC0C5;
        Mon, 16 Oct 2023 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697455290; x=1728991290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LEfQzEzFnqWpsMa+RsPd1j9BAK5jemhjh3eEmQXEtPQ=;
  b=kf268ueko+UuJVfHBVtfqbiBjXn/0nEPw7WGxYUtt2W6BcKr1SqIYyvK
   Gm7J+nD5GN8XL4+dgPzraf/92O2dEMASdeqYUhHEWIvC6ucev0J5cULRx
   xwpMB2DTZerClNH2oUkFFP7JgbmSMNuhx3w4rlV15fWq9ymcX/299mcLX
   hh1IqBF4KRtF3nKFSykTg+KWK/54gdo1mJtEQ442pYz4wb8bq8CuuO+Zd
   WWEboCaKn69Pba69NwBQMztRg4gnVaK+LEyDkxidUaUXaYQuGxWnD/FEd
   JBCFHmyj8V/X2FP33yckw/JEnG4k/2OVes6fHZmfRL3BHKP+vna7m1hKq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="451983864"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="451983864"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846362126"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846362126"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2023 04:21:27 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsLf3-0008Kt-0D;
        Mon, 16 Oct 2023 11:21:25 +0000
Date:   Mon, 16 Oct 2023 19:21:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Message-ID: <202310161944.966gHsq4-lkp@intel.com>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011190017.1230898-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231016]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Werner-Sembach/leds-rgb-Implement-per-key-keyboard-backlight-for-several-TUXEDO-devices/20231012-030206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20231011190017.1230898-1-wse%40tuxedocomputers.com
patch subject: [PATCH] leds: rgb: Implement per-key keyboard backlight for several TUXEDO devices
config: x86_64-randconfig-122-20231016 (https://download.01.org/0day-ci/archive/20231016/202310161944.966gHsq4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161944.966gHsq4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310161944.966gHsq4-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `leds_tuxedo_ite8291_hid_feature_report_set':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:89: undefined reference to `hid_hw_raw_request'
   ld: vmlinux.o: in function `leds_tuxedo_ite8291_write_row':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:130: undefined reference to `hid_hw_output_report'
   ld: vmlinux.o: in function `hid_parse':
>> include/linux/hid.h:1091: undefined reference to `hid_open_report'
   ld: vmlinux.o: in function `leds_tuxedo_ite8291_start_hw':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:186: undefined reference to `hid_hw_start'
>> ld: drivers/leds/rgb/leds-tuxedo-ite8291.c:194: undefined reference to `hid_hw_open'
>> ld: drivers/leds/rgb/leds-tuxedo-ite8291.c:203: undefined reference to `hid_hw_stop'
>> ld: drivers/leds/rgb/leds-tuxedo-ite8291.c:203: undefined reference to `hid_hw_stop'
   ld: vmlinux.o: in function `leds_tuxedo_ite8291_stop_hw':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:210: undefined reference to `hid_hw_close'
   ld: drivers/leds/rgb/leds-tuxedo-ite8291.c:212: undefined reference to `hid_hw_stop'
   ld: vmlinux.o: in function `leds_tuxedo_ite8291_init':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:447: undefined reference to `__hid_register_driver'
   ld: vmlinux.o: in function `leds_tuxedo_ite8291_exit':
>> drivers/leds/rgb/leds-tuxedo-ite8291.c:447: undefined reference to `hid_unregister_driver'


vim +89 drivers/leds/rgb/leds-tuxedo-ite8291.c

    77	
    78	/**
    79	 * Just a generic helper function to reduce boilerplate code
    80	 */
    81	static int leds_tuxedo_ite8291_hid_feature_report_set(struct hid_device *hdev, u8 *data, size_t len)
    82	{
    83		int result;
    84		u8 *buf;
    85	
    86		buf = kmemdup(data, len, GFP_KERNEL);
    87		if (!buf)
    88			return -ENOMEM;
  > 89		result = hid_hw_raw_request(hdev, buf[0], buf, len, HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
    90		kfree(buf);
    91	
    92		return result;
    93	}
    94	
    95	/**
    96	 * Update brightness of the whole keyboard. Only used for initialization as this doesn't allow per
    97	 * key brightness control. That is implemented with RGB value scaling.
    98	 */
    99	static int leds_tuxedo_ite8291_write_brightness(struct hid_device *hdev, u8 brightness)
   100	{
   101		int result;
   102		u8 brightness_capped = brightness > LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_MAX ?
   103				       LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_MAX : brightness;
   104		u8 ctrl_set_brightness[8] = {0x08, 0x02, LEDS_TUXEDO_ITE8291_PARAM_MODE_USER, 0x00,
   105					     brightness_capped, 0x00, 0x00, 0x00};
   106	
   107		result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_set_brightness,
   108								    sizeof(ctrl_set_brightness));
   109		if (result < 0)
   110			return result;
   111	
   112		return 0;
   113	}
   114	
   115	/**
   116	 * Update color of a singular row from row_data. This is the smallest unit this device allows to
   117	 * write. Changes are applied when the last row (row_index == 5) is written.
   118	 */
   119	static int leds_tuxedo_ite8291_write_row(struct hid_device *hdev, row_data_t row_data,
   120						 int row_index)
   121	{
   122		int result;
   123		u8 ctrl_announce_row_data[8] = {0x16, 0x00, row_index, 0x00, 0x00, 0x00, 0x00, 0x00};
   124	
   125		result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_announce_row_data,
   126								    sizeof(ctrl_announce_row_data));
   127		if (result < 0)
   128			return result;
   129	
 > 130		result = hid_hw_output_report(hdev, row_data[row_index], sizeof(row_data[row_index]));
   131		if (result < 0)
   132			return result;
   133	
   134		return 0;
   135	}
   136	
   137	/**
   138	 * Write color and brightness to the whole keyboard from row data. Note that per key brightness is
   139	 * encoded in the RGB values of the row_data and the gobal brightness is a fixed value.
   140	 */
   141	static int leds_tuxedo_ite8291_write_all(struct hid_device *hdev, row_data_t row_data)
   142	{
   143		int result, row_index;
   144	
   145		if (hdev == NULL)
   146			return -ENODEV;
   147	
   148		result = leds_tuxedo_ite8291_write_brightness(hdev,
   149							      LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_DEFAULT);
   150		if (result < 0)
   151			return result;
   152	
   153		for (row_index = 0; row_index < LEDS_TUXEDO_ITE8291_ROWS; ++row_index) {
   154			result = leds_tuxedo_ite8291_write_row(hdev, row_data, row_index);
   155			if (result < 0)
   156				return result;
   157		}
   158	
   159		return 0;
   160	}
   161	
   162	static int leds_tuxedo_ite8291_write_state(struct hid_device *hdev)
   163	{
   164		struct leds_tuxedo_ite8291_driver_data_t *driver_data = hid_get_drvdata(hdev);
   165	
   166		return leds_tuxedo_ite8291_write_all(hdev, driver_data->row_data);
   167	}
   168	
   169	static int leds_tuxedo_ite8291_write_off(struct hid_device *hdev)
   170	{
   171		int result;
   172		u8 ctrl_write_off[8] = {0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
   173	
   174		result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_write_off,
   175								    sizeof(ctrl_write_off));
   176		if (result < 0)
   177			return result;
   178	
   179		return 0;
   180	}
   181	
   182	static int leds_tuxedo_ite8291_start_hw(struct hid_device *hdev)
   183	{
   184		int result;
   185	
 > 186		result = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
   187		if (result < 0)
   188			goto err_start;
   189	
   190		result = hid_hw_power(hdev, PM_HINT_FULLON);
   191		if (result < 0)
   192			goto err_power;
   193	
 > 194		result = hid_hw_open(hdev);
   195		if (result)
   196			goto err_open;
   197	
   198		return 0;
   199	
   200	err_open:
   201		hid_hw_power(hdev, PM_HINT_NORMAL);
   202	err_power:
 > 203		hid_hw_stop(hdev);
   204	err_start:
   205		return result;
   206	}
   207	
   208	static void leds_tuxedo_ite8291_stop_hw(struct hid_device *hdev)
   209	{
 > 210		hid_hw_close(hdev);
   211		hid_hw_power(hdev, PM_HINT_NORMAL);
   212		hid_hw_stop(hdev);
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

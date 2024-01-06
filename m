Return-Path: <linux-kernel+bounces-18623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0C826029
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E7BB22403
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E038493;
	Sat,  6 Jan 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtwZVw6D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CA8475
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704555070; x=1736091070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mn/6av/XNJuAb/ztGwlHaZRbtQEQ/y06WilMKnwMVLc=;
  b=OtwZVw6DDYtZIu7eQv8JYDBq7BGoyPcNC5/Cwt4W3x9B7GcPtUB61oOn
   zHZg+Ed0fioHIdtjYMfNdk4izTP8jZB1Zar+o7KVqZOxRVc7+hO9V7rGp
   r9JFbMSrECKOBZOEn85k2ePakAPRYLqopTcaAvg5TAKXecaou1bmi7pWs
   TeaR/uwKsTgTajYlswVm0Q/jQIch1Tqnu3NzoNGJI49EYXaIHxEb4KV8l
   Yap7oBu1hMRPk9UpMDe9duxkTDiFxt+jGUb+mA02oC9H99q/z69TgbrW1
   mOuD9jGbjsXAwK9j45EEXpCkjGPjmvOwvnncMT8NMi6ZzvxjV21KhHKM9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="388116347"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="388116347"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="815208055"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="815208055"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2024 07:31:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM8dd-0002d2-1r;
	Sat, 06 Jan 2024 15:31:05 +0000
Date: Sat, 6 Jan 2024 23:30:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Geoffrey D. Bennett" <g@b4.vu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: sound/usb/mixer_scarlett2.c:3226:48: warning: ' Volume Control
 Playback Enum' directive output may be truncated writing 29 bytes into a
 region of size between 25 and 33
Message-ID: <202401062344.AzZCYlpa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: efc3d7d20361cc59325a9f0525e079333b4459c0 ALSA: scarlett2: Rename scarlett_gen2 to scarlett2
date:   2 months ago
config: arm64-randconfig-001-20240106 (https://download.01.org/0day-ci/archive/20240106/202401062344.AzZCYlpa-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062344.AzZCYlpa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062344.AzZCYlpa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/usb/mixer_scarlett2.c: In function 'scarlett2_add_line_out_ctls':
>> sound/usb/mixer_scarlett2.c:3226:48: warning: ' Volume Control Playback Enum' directive output may be truncated writing 29 bytes into a region of size between 25 and 33 [-Wformat-truncation=]
    3226 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/usb/mixer_scarlett2.c:3225:25: note: 'snprintf' output between 41 and 49 bytes into a destination of size 44
    3225 |                         snprintf(s, sizeof(s),
         |                         ^~~~~~~~~~~~~~~~~~~~~~
    3226 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3227 |                                  i + 1);
         |                                  ~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_OV2640
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [m]:
   - VIDEO_EM28XX_V4L2 [=m] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=m] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
   WARNING: unmet direct dependencies detected for VIDEO_OV7640
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [m]:
   - VIDEO_GO7007 [=m] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=m] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
   WARNING: unmet direct dependencies detected for VIDEO_MT9V011
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [m]:
   - VIDEO_EM28XX_V4L2 [=m] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=m] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]


vim +3226 sound/usb/mixer_scarlett2.c

9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3166  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3167  static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3168  {
e46f2195c86b00 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3169  	struct scarlett2_data *private = mixer->private_data;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3170  	const struct scarlett2_device_info *info = private->info;
e2cc91ac8f4e1b sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3171  	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3172  	int num_line_out =
e2cc91ac8f4e1b sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3173  		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3174  	int err, i;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3175  	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3176  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3177  	/* Add R/O HW volume control */
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3178  	if (info->line_out_hw_vol) {
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3179  		snprintf(s, sizeof(s), "Master HW Playback Volume");
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3180  		err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3181  					    &scarlett2_master_volume_ctl,
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3182  					    0, 1, s, &private->master_vol_ctl);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3183  		if (err < 0)
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3184  			return err;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3185  	}
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3186  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3187  	/* Add volume controls */
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3188  	for (i = 0; i < num_line_out; i++) {
9cfe1276a6736f sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3189  		int index = line_out_remap(private, i);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3190  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3191  		/* Fader */
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3192  		if (info->line_out_descrs[i])
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3193  			snprintf(s, sizeof(s),
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3194  				 "Line %02d (%s) Playback Volume",
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3195  				 i + 1, info->line_out_descrs[i]);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3196  		else
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3197  			snprintf(s, sizeof(s),
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3198  				 "Line %02d Playback Volume",
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3199  				 i + 1);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3200  		err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3201  					    &scarlett2_line_out_volume_ctl,
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3202  					    i, 1, s, &private->vol_ctls[i]);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3203  		if (err < 0)
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3204  			return err;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3205  
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3206  		/* Mute Switch */
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3207  		snprintf(s, sizeof(s),
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3208  			 "Line %02d Mute Playback Switch",
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3209  			 i + 1);
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3210  		err = scarlett2_add_new_ctl(mixer,
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3211  					    &scarlett2_mute_ctl,
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3212  					    i, 1, s,
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3213  					    &private->mute_ctls[i]);
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3214  		if (err < 0)
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3215  			return err;
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3216  
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3217  		/* Make the fader and mute controls read-only if the
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3218  		 * SW/HW switch is set to HW
0c88f9db1910ff sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3219  		 */
9cfe1276a6736f sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3220  		if (private->vol_sw_hw_switch[index])
06250c89d47cef sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-22  3221  			scarlett2_vol_ctl_set_writable(mixer, i, 0);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3222  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3223  		/* SW/HW Switch */
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3224  		if (info->line_out_hw_vol) {
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3225  			snprintf(s, sizeof(s),
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29 @3226  				 "Line Out %02d Volume Control Playback Enum",
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3227  				 i + 1);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3228  			err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3229  						    &scarlett2_sw_hw_enum_ctl,
f02da6534810ac sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3230  						    i, 1, s,
f02da6534810ac sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3231  						    &private->sw_hw_ctls[i]);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3232  			if (err < 0)
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3233  				return err;
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3234  
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3235  			/* Make the switch read-only if the line is
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3236  			 * involved in speaker switching
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3237  			 */
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3238  			if (private->speaker_switching_switch && i < 4)
e914d8432cb4b9 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-23  3239  				scarlett2_sw_hw_ctl_ro(private, i);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3240  		}
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3241  	}
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3242  
dbd82c0550633c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3243  	/* Add dim/mute controls */
03bdbcf08a8cb7 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3244  	if (info->line_out_hw_vol)
dbd82c0550633c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3245  		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++) {
03bdbcf08a8cb7 sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3246  			err = scarlett2_add_new_ctl(
dbd82c0550633c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3247  				mixer, &scarlett2_dim_mute_ctl,
dbd82c0550633c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3248  				i, 1, scarlett2_dim_mute_names[i],
dbd82c0550633c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2021-06-21  3249  				&private->dim_mute_ctls[i]);
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3250  			if (err < 0)
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3251  				return err;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3252  		}
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3253  
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3254  	return 0;
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3255  }
9e4d5c1be21f0c sound/usb/mixer_scarlett_gen2.c Geoffrey D. Bennett 2019-07-29  3256  

:::::: The code at line 3226 was first introduced by commit
:::::: 9e4d5c1be21f0c00e747e92186784f3298309b3e ALSA: usb-audio: Scarlett Gen 2 mixer interface

:::::: TO: Geoffrey D. Bennett <g@b4.vu>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


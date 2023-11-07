Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4E7E4C69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjKGXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjKGXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:04:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24610C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699398239; x=1730934239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gvMsD4vup1yDr8Oge4Pea1tRQMCRXNHZSf4KJ7myNls=;
  b=mBUleS6Zupa5BwYF6b5FeT6BGwJqSBq3UEW7HZhe+8mVDrDq1h6BQ1jg
   rd8Sli9ZXwzrjCcDK2WHQQb2l0+V4cGhelpJYW+7P5GPtbjpFqqYzimq+
   EV4sPjPr2zAxMYknIiAbTe2I9klVvt0Z4OzvP9jHGbwAFqNXAGfTD0lXR
   FLq6z0tEIaZFmiKco1ZQPn24SyY68jnnVeDsbitA4tkZcRYR92BqHcDbf
   4vpmmzD64rHE4hmANZeEAgezmhURJq8PzK8eLj/ynYJVOJCTG7xHVcMcj
   +ky6itnIcItIMSlpaTHxnhzqP021zm7yFvIIpEp7myt246LkAlltAgRUr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="8294042"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="8294042"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 15:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="1010072952"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="1010072952"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2023 15:03:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0V6w-0007Sm-1S;
        Tue, 07 Nov 2023 23:03:54 +0000
Date:   Wed, 8 Nov 2023 07:02:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Geoffrey D. Bennett" <g@b4.vu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: sound/usb/mixer_scarlett2.c:3226:48: error: ' Volume Control
 Playback Enum' directive output may be truncated writing 29 bytes into a
 region of size between 25 and 33
Message-ID: <202311080640.fM2RLOUC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoffrey,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13d88ac54ddd1011b6e94443958e798aa06eb835
commit: efc3d7d20361cc59325a9f0525e079333b4459c0 ALSA: scarlett2: Rename scarlett_gen2 to scarlett2
date:   12 days ago
config: x86_64-sof-customedconfig-memory-debug-defconfig (https://download.01.org/0day-ci/archive/20231108/202311080640.fM2RLOUC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080640.fM2RLOUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080640.fM2RLOUC-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/usb/mixer_scarlett2.c: In function 'snd_scarlett2_init':
>> sound/usb/mixer_scarlett2.c:3226:48: error: ' Volume Control Playback Enum' directive output may be truncated writing 29 bytes into a region of size between 25 and 33 [-Werror=format-truncation=]
    3226 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/usb/mixer_scarlett2.c:3225:25: note: 'snprintf' output between 41 and 49 bytes into a destination of size 44
    3225 |                         snprintf(s, sizeof(s),
         |                         ^~~~~~~~~~~~~~~~~~~~~~
    3226 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3227 |                                  i + 1);
         |                                  ~~~~~~
   cc1: all warnings being treated as errors


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

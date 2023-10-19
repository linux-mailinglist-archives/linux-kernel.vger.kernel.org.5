Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB77D055A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346692AbjJSXXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjJSXXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:23:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4E115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697757817; x=1729293817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rKQ5yE8TuY6zKrse41m44t5g4NIEJIfLSgs8jCyZ3PA=;
  b=cdPgjKv9/ADK4epC3S06vk3YNbkJBO6xqr7Dm8UGdiUfby60OOZUh63l
   6pTA8azx87VTaun84F8JcPKg/26fHOzht+uR+p82qOTlL39ZbAgVyKjkH
   lqRfFZ50zgIXAAyx+FwjCY6mh6Q9/ePm81Vm+R7ZNJhKavJvPvmJ+Lh8/
   fldSrPvd1kX1eJphmQwxaNl9WOp0UWiLGzxLA0YVJOcuMwjrtntFfYZ6n
   KXtnHVLgt4Ca2/B1CANgH337eE8zY29NhilzS4FPbzMVybyOtAjNxgQQV
   7Je2V9ynC18b/NajHfP9Jd+AFP4CJXVXGUC8rEA0wG4Glg76rAySerFfR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450615131"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450615131"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 16:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827530162"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827530162"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2023 16:23:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtcMW-0002i8-2A;
        Thu, 19 Oct 2023 23:23:32 +0000
Date:   Fri, 20 Oct 2023 07:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: sound/usb/mixer_scarlett_gen2.c:3135:48: error: ' Volume Control
 Playback Enum' directive output may be truncated writing 29 bytes into a
 region of size between 25 and 33
Message-ID: <202310200711.olDz9VTe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce55c22ec8b223a90ff3e084d842f73cfba35588
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   9 months ago
config: x86_64-sof-customedconfig-memory-debug-defconfig (https://download.01.org/0day-ci/archive/20231020/202310200711.olDz9VTe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200711.olDz9VTe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200711.olDz9VTe-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/usb/mixer_scarlett_gen2.c: In function 'snd_scarlett_gen2_init':
>> sound/usb/mixer_scarlett_gen2.c:3135:48: error: ' Volume Control Playback Enum' directive output may be truncated writing 29 bytes into a region of size between 25 and 33 [-Werror=format-truncation=]
    3135 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/usb/mixer_scarlett_gen2.c:3134:25: note: 'snprintf' output between 41 and 49 bytes into a destination of size 44
    3134 |                         snprintf(s, sizeof(s),
         |                         ^~~~~~~~~~~~~~~~~~~~~~
    3135 |                                  "Line Out %02d Volume Control Playback Enum",
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3136 |                                  i + 1);
         |                                  ~~~~~~
   sound/usb/mixer_scarlett_gen2.c:3175:54: error: '%s' directive output may be truncated writing 6 bytes into a region of size between 2 and 10 [-Werror=format-truncation=]
    3175 |         const char *fmt2 = "Line In %d-%d %s Capture %s";
         |                                                      ^~
   ......
    3222 |                                  "Phantom Power", "Switch");
         |                                                   ~~~~~~~~
   sound/usb/mixer_scarlett_gen2.c:3221:25: note: 'snprintf' output between 41 and 49 bytes into a destination of size 44
    3221 |                         snprintf(s, sizeof(s), fmt2, from, to,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3222 |                                  "Phantom Power", "Switch");
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +3135 sound/usb/mixer_scarlett_gen2.c

9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3075  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3076  static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3077  {
e46f2195c86b00 Geoffrey D. Bennett 2021-06-21  3078  	struct scarlett2_data *private = mixer->private_data;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3079  	const struct scarlett2_device_info *info = private->info;
e2cc91ac8f4e1b Geoffrey D. Bennett 2021-06-22  3080  	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3081  	int num_line_out =
e2cc91ac8f4e1b Geoffrey D. Bennett 2021-06-22  3082  		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3083  	int err, i;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3084  	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3085  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3086  	/* Add R/O HW volume control */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3087  	if (info->line_out_hw_vol) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3088  		snprintf(s, sizeof(s), "Master HW Playback Volume");
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3089  		err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3090  					    &scarlett2_master_volume_ctl,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3091  					    0, 1, s, &private->master_vol_ctl);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3092  		if (err < 0)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3093  			return err;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3094  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3095  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3096  	/* Add volume controls */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3097  	for (i = 0; i < num_line_out; i++) {
9cfe1276a6736f Geoffrey D. Bennett 2021-06-23  3098  		int index = line_out_remap(private, i);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3099  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3100  		/* Fader */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3101  		if (info->line_out_descrs[i])
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3102  			snprintf(s, sizeof(s),
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3103  				 "Line %02d (%s) Playback Volume",
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3104  				 i + 1, info->line_out_descrs[i]);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3105  		else
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3106  			snprintf(s, sizeof(s),
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3107  				 "Line %02d Playback Volume",
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3108  				 i + 1);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3109  		err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3110  					    &scarlett2_line_out_volume_ctl,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3111  					    i, 1, s, &private->vol_ctls[i]);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3112  		if (err < 0)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3113  			return err;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3114  
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3115  		/* Mute Switch */
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3116  		snprintf(s, sizeof(s),
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3117  			 "Line %02d Mute Playback Switch",
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3118  			 i + 1);
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3119  		err = scarlett2_add_new_ctl(mixer,
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3120  					    &scarlett2_mute_ctl,
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3121  					    i, 1, s,
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3122  					    &private->mute_ctls[i]);
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3123  		if (err < 0)
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3124  			return err;
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3125  
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3126  		/* Make the fader and mute controls read-only if the
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3127  		 * SW/HW switch is set to HW
0c88f9db1910ff Geoffrey D. Bennett 2021-06-22  3128  		 */
9cfe1276a6736f Geoffrey D. Bennett 2021-06-23  3129  		if (private->vol_sw_hw_switch[index])
06250c89d47cef Geoffrey D. Bennett 2021-06-22  3130  			scarlett2_vol_ctl_set_writable(mixer, i, 0);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3131  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3132  		/* SW/HW Switch */
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3133  		if (info->line_out_hw_vol) {
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3134  			snprintf(s, sizeof(s),
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29 @3135  				 "Line Out %02d Volume Control Playback Enum",
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3136  				 i + 1);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3137  			err = scarlett2_add_new_ctl(mixer,
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3138  						    &scarlett2_sw_hw_enum_ctl,
f02da6534810ac Geoffrey D. Bennett 2021-06-23  3139  						    i, 1, s,
f02da6534810ac Geoffrey D. Bennett 2021-06-23  3140  						    &private->sw_hw_ctls[i]);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3141  			if (err < 0)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3142  				return err;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3143  
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3144  			/* Make the switch read-only if the line is
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3145  			 * involved in speaker switching
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3146  			 */
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3147  			if (private->speaker_switching_switch && i < 4)
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  3148  				scarlett2_sw_hw_ctl_ro(private, i);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3149  		}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3150  	}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3151  
dbd82c0550633c Geoffrey D. Bennett 2021-06-21  3152  	/* Add dim/mute controls */
03bdbcf08a8cb7 Geoffrey D. Bennett 2021-06-21  3153  	if (info->line_out_hw_vol)
dbd82c0550633c Geoffrey D. Bennett 2021-06-21  3154  		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++) {
03bdbcf08a8cb7 Geoffrey D. Bennett 2021-06-21  3155  			err = scarlett2_add_new_ctl(
dbd82c0550633c Geoffrey D. Bennett 2021-06-21  3156  				mixer, &scarlett2_dim_mute_ctl,
dbd82c0550633c Geoffrey D. Bennett 2021-06-21  3157  				i, 1, scarlett2_dim_mute_names[i],
dbd82c0550633c Geoffrey D. Bennett 2021-06-21  3158  				&private->dim_mute_ctls[i]);
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3159  			if (err < 0)
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3160  				return err;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3161  		}
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3162  
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3163  	return 0;
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3164  }
9e4d5c1be21f0c Geoffrey D. Bennett 2019-07-29  3165  

:::::: The code at line 3135 was first introduced by commit
:::::: 9e4d5c1be21f0c00e747e92186784f3298309b3e ALSA: usb-audio: Scarlett Gen 2 mixer interface

:::::: TO: Geoffrey D. Bennett <g@b4.vu>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

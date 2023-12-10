Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728E80BCDE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjLJUGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:06:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF4DA;
        Sun, 10 Dec 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702238769; x=1733774769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCov2ZnqT+3A1iiJk7lG+2aChDkarFR+QHCckZdK2Mc=;
  b=Zita9nrxuX0Hiw+fa4kXbv3k7xFghAVQOcbrc5pZnDztwDIG3hrPD/z9
   Yc7Dai1Mw2a/hY4rDLTnCS8+QpI5+QddIgo/bosbn86+c9zIzL/ZO+tVM
   6pvDKItlyk2pscwbXvj6niJ8MfbJqdWQeJqO38GHs49/Y8DQc1EkvpDR+
   NICazg+biSvyEc4V5qH0ViwKg1SCAmWLLPsInlKapx2CPICHbabDK9x/Q
   2966bCc40hZeJqPRbF85dJSHznzo+Qo0GzFCCMy/6kvoziPyj1ETPGsbl
   274q79ycj5jSlSBGxN+z9bNmVy48BIZ5pVFrCDTMbS1TKSxE1xHhNX7Ey
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7906194"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="7906194"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 12:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1019972871"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="1019972871"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Dec 2023 12:06:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCQ3u-000HED-00;
        Sun, 10 Dec 2023 20:06:02 +0000
Date:   Mon, 11 Dec 2023 04:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] usb: typec: mux: add Qualcomm WCD939X USB SubSystem
 Altmode Mux driver
Message-ID: <202312110337.uzelx86z-lkp@intel.com>
References: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

kernel test robot noticed the following build errors:

[auto build test ERROR on bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/dt-bindings-usb-Document-WCD939x-USB-SubSystem-Altmode-Analog-Audio-Switch/20231208-232926
base:   bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
patch link:    https://lore.kernel.org/r/20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0%40linaro.org
patch subject: [PATCH 2/2] usb: typec: mux: add Qualcomm WCD939X USB SubSystem Altmode Mux driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231211/202312110337.uzelx86z-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231211/202312110337.uzelx86z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312110337.uzelx86z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/mux/wcd939x-usbss.c:353:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                            FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
                                            ^
   drivers/usb/typec/mux/wcd939x-usbss.c:456:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                    FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
                                    ^
>> drivers/usb/typec/mux/wcd939x-usbss.c:602:22: error: call to undeclared function 'devm_gpiod_get_optional'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           usbss->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
                               ^
   drivers/usb/typec/mux/wcd939x-usbss.c:602:22: note: did you mean 'devm_regulator_get_optional'?
   include/linux/regulator/consumer.h:163:32: note: 'devm_regulator_get_optional' declared here
   struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
                                  ^
>> drivers/usb/typec/mux/wcd939x-usbss.c:602:60: error: use of undeclared identifier 'GPIOD_OUT_LOW'
           usbss->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
                                                                     ^
>> drivers/usb/typec/mux/wcd939x-usbss.c:627:2: error: call to undeclared function 'gpiod_set_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           gpiod_set_value(usbss->reset_gpio, 1);
           ^
   drivers/usb/typec/mux/wcd939x-usbss.c:650:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                    FIELD_PREP(WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT,
                                    ^
   6 errors generated.


vim +/FIELD_PREP +353 drivers/usb/typec/mux/wcd939x-usbss.c

   237	
   238	static int wcd939x_usbss_set(struct wcd939x_usbss *usbss)
   239	{
   240		bool reverse = (usbss->orientation == TYPEC_ORIENTATION_REVERSE);
   241		bool enable_audio = false;
   242		bool enable_usb = false;
   243		bool enable_dp = false;
   244		int ret;
   245	
   246		/* USB Mode */
   247		if (usbss->mode < TYPEC_STATE_MODAL ||
   248		    (!usbss->svid && (usbss->mode == TYPEC_MODE_USB2 ||
   249				      usbss->mode == TYPEC_MODE_USB3))) {
   250			enable_usb = true;
   251		} else if (usbss->svid) {
   252			switch (usbss->mode) {
   253			/* DP Only */
   254			case TYPEC_DP_STATE_C:
   255			case TYPEC_DP_STATE_E:
   256				enable_dp = true;
   257				break;
   258	
   259			/* DP + USB */
   260			case TYPEC_DP_STATE_D:
   261			case TYPEC_DP_STATE_F:
   262				enable_usb = true;
   263				enable_dp = true;
   264				break;
   265	
   266			default:
   267				return -EOPNOTSUPP;
   268			}
   269		} else if (usbss->mode == TYPEC_MODE_AUDIO) {
   270			enable_audio = true;
   271		} else {
   272			return -EOPNOTSUPP;
   273		}
   274	
   275		/* Disable all switches */
   276		ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   277					WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXP_TO_MGX_SWITCHES |
   278					WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXM_TO_MGX_SWITCHES |
   279					WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES |
   280					WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES |
   281					WCD_USBSS_SWITCH_SETTINGS_ENABLE_SENSE_SWITCHES |
   282					WCD_USBSS_SWITCH_SETTINGS_ENABLE_MIC_SWITCHES |
   283					WCD_USBSS_SWITCH_SETTINGS_ENABLE_AGND_SWITCHES);
   284		if (ret)
   285			return ret;
   286	
   287		/* Clear switches */
   288		ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   289					WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
   290					WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES |
   291					WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
   292					WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES |
   293					WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES |
   294					WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES);
   295		if (ret)
   296			return ret;
   297	
   298		ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
   299					WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
   300		if (ret)
   301			return ret;
   302	
   303		/* Enable OVP_MG1_BIAS PCOMP_DYN_BST_EN */
   304		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG1_BIAS,
   305				      WCD_USBSS_MG1_BIAS_PCOMP_DYN_BST_EN);
   306		if (ret)
   307			return ret;
   308	
   309		/* Enable OVP_MG2_BIAS PCOMP_DYN_BST_EN */
   310		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG2_BIAS,
   311				      WCD_USBSS_MG2_BIAS_PCOMP_DYN_BST_EN);
   312		if (ret)
   313			return ret;
   314	
   315		/* Disable Equalizer in safe mode */
   316		ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_EQUALIZER1,
   317					WCD_USBSS_EQUALIZER1_EQ_EN);
   318		if (ret)
   319			return ret;
   320	
   321		/* Start FSM with all disabled, force write */
   322		ret = regmap_write_bits(usbss->regmap, WCD_USBSS_AUDIO_FSM_START,
   323					WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG,
   324					WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG);
   325	
   326		/* 35us to allow the SBU switch to turn off */
   327		usleep_range(35, 1000);
   328	
   329		/* Setup Audio Accessory mux/switch */
   330		if (enable_audio) {
   331			int i;
   332	
   333			/*
   334			 * AATC switch configuration:
   335			 * "Normal":
   336			 * - R: DNR
   337			 * - L: DNL
   338			 * - Sense: GSBU2
   339			 * - Mic: MG1
   340			 * - AGND: MG2
   341			 * "Swapped":
   342			 * - R: DNR
   343			 * - L: DNL
   344			 * - Sense: GSBU1
   345			 * - Mic: MG2
   346			 * - AGND: MG1
   347			 * Swapped information is given by the codec MBHC logic
   348			 */
   349	
   350			/* Set AATC mode */
   351			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
   352						 WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
 > 353						 FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
   354							    WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_AATC));
   355			if (ret)
   356				return ret;
   357	
   358			/* Select L for DNL_SWITCHES and R for DPR_SWITCHES */
   359			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   360					WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
   361					WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
   362					FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
   363						WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_L) |
   364					FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES,
   365						WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_R));
   366			if (ret)
   367				return ret;
   368	
   369			if (reverse)
   370				/* Select MG2 for MIC, SBU1 for Sense */
   371				ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   372							 WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES,
   373							 WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES);
   374			else
   375				/* Select MG1 for MIC, SBU2 for Sense */
   376				ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   377							 WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES,
   378							 WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES);
   379			if (ret)
   380				return ret;
   381	
   382			if (reverse)
   383				/* Disable OVP_MG1_BIAS PCOMP_DYN_BST_EN */
   384				ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_MG1_BIAS,
   385							WCD_USBSS_MG1_BIAS_PCOMP_DYN_BST_EN);
   386			else
   387				/* Disable OVP_MG2_BIAS PCOMP_DYN_BST_EN */
   388				ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_MG2_BIAS,
   389							WCD_USBSS_MG2_BIAS_PCOMP_DYN_BST_EN);
   390			if (ret)
   391				return ret;
   392	
   393			/*  Enable SENSE, MIC switches */
   394			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   395					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_SENSE_SWITCHES |
   396					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_MIC_SWITCHES);
   397			if (ret)
   398				return ret;
   399	
   400			if (reverse)
   401				/* Select MG1 for AGND_SWITCHES */
   402				ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
   403							WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
   404			else
   405				/* Select MG2 for AGND_SWITCHES */
   406				ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
   407						      WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
   408			if (ret)
   409				return ret;
   410	
   411			/* Enable AGND switches */
   412			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   413					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_AGND_SWITCHES);
   414			if (ret)
   415				return ret;
   416	
   417			/* Enable DPR, DNL switches */
   418			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   419					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES |
   420					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES);
   421			if (ret)
   422				return ret;
   423	
   424			/* Setup FSM delays */
   425			ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_L_SW, 0x02);
   426			if (ret)
   427				return ret;
   428	
   429			ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_R_SW, 0x02);
   430			if (ret)
   431				return ret;
   432	
   433			ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_MIC_SW, 0x01);
   434			if (ret)
   435				return ret;
   436	
   437			/* Start FSM, force write */
   438			ret = regmap_write_bits(usbss->regmap, WCD_USBSS_AUDIO_FSM_START,
   439						WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG,
   440						WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG);
   441			if (ret)
   442				return ret;
   443	
   444			/* Default Linearlizer coefficients */
   445			for (i = 0; i < ARRAY_SIZE(wcd939x_usbss_coeff_init); ++i)
   446				regmap_update_bits(usbss->regmap,
   447						   wcd939x_usbss_coeff_init[i].offset,
   448						   wcd939x_usbss_coeff_init[i].mask,
   449						   wcd939x_usbss_coeff_init[i].value);
   450	
   451			return 0;
   452		}
   453	
   454		ret = regmap_update_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
   455					 WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
   456					 FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
   457						    WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_USB));
   458		if (ret)
   459			return ret;
   460	
   461		/* Enable USB muxes */
   462		if (enable_usb) {
   463			/* Do not enable Equalizer in safe mode */
   464			if (usbss->mode != TYPEC_STATE_SAFE) {
   465				ret = regmap_set_bits(usbss->regmap, WCD_USBSS_EQUALIZER1,
   466						      WCD_USBSS_EQUALIZER1_EQ_EN);
   467				if (ret)
   468					return ret;
   469			}
   470	
   471			/* Select DN for DNL_SWITCHES and DP for DPR_SWITCHES */
   472			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   473						 WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
   474						 WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
   475						 FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
   476							    WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_DN) |
   477						 FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES,
   478							    WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_DP));
   479			if (ret)
   480				return ret;
   481	
   482			/* Enable DNL_SWITCHES and DPR_SWITCHES */
   483			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   484					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES |
   485					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES);
   486			if (ret)
   487				return ret;
   488		}
   489	
   490		/* Enable DP AUX muxes */
   491		if (enable_dp) {
   492			/* Update Leakage Canceller Coefficient for AUXP pins */
   493			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_DISP_AUXP_CTL,
   494						 WCD_USBSS_DISP_AUXP_CTL_LK_CANCEL_TRK_COEFF,
   495						 FIELD_PREP(WCD_USBSS_DISP_AUXP_CTL_LK_CANCEL_TRK_COEFF,
   496							    5));
   497			if (ret)
   498				return ret;
   499	
   500			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_DISP_AUXP_THRESH,
   501					      WCD_USBSS_DISP_AUXP_THRESH_DISP_AUXP_OVPON_CM);
   502			if (ret)
   503				return ret;
   504	
   505			if (reverse)
   506				/* Select MG2 for AUXP and MG1 for AUXM */
   507				ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   508							 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
   509							 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES,
   510							 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES);
   511			else
   512				/* Select MG1 for AUXP and MG2 for AUXM */
   513				ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
   514							 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
   515							 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES,
   516							 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES);
   517			if (ret)
   518				return ret;
   519	
   520			/* Enable DP_AUXP_TO_MGX and DP_AUXM_TO_MGX switches */
   521			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
   522					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXP_TO_MGX_SWITCHES |
   523					      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXM_TO_MGX_SWITCHES);
   524	
   525			/* 15us to allow the SBU switch to turn on again */
   526			usleep_range(15, 1000);
   527		}
   528	
   529		return 0;
   530	}
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

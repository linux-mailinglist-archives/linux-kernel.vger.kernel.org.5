Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D755880801F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjLGF0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGF0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:26:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA596D51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:26:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332f90a375eso517618f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701926779; x=1702531579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7z0RXkoXYkLl1p5YIwWXp82DBhxPyJ1qOpvwjveyO4=;
        b=JGCOOiVUHCkYWkl+HRNoPTl4m4kVJnnnHbgiaeyFx+YG2GtAb6Hz1t4FuehWwdTccL
         ZZF5F886bzQLD5WmwcMsMo0I7zpP+ZiLrtPLKzQBPphJdb8APdWDILQZmiArSSD8rby0
         hiJW6pfbW6TcWbf7IO+WBaudDk0mp9mO7G3D1KTVKcVDyGFIVtoUyJa5A6DDKW2SCYMk
         HQrDEaW/WAIdPGRoFnAlQEhDQKhTNK2057bvg6J0Smw0holHGPBo6oQCZf475d5VBrG8
         Ls1swZohCXhOlXdIpv7jm8V1m/dyRzCg8YrKTZwESOhvJ5323nVTqTEJJxVpidRhxlJl
         //uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701926779; x=1702531579;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7z0RXkoXYkLl1p5YIwWXp82DBhxPyJ1qOpvwjveyO4=;
        b=QNto6x4j8+z2xDYmLBMlW2qg3nuKT2p4g55AYG92W/PlwYAtN0Zu2YTtoX/hZdG73v
         6Q60jVE0PAStILVWsKJgZ8oB96+G6H9poeiGdBtamSfyFYhrbf2ITAJ+wj/ViYU44vK6
         D6miILEmteZDQntJ41vGvmjFhLTfFdS7/rDY+F70hEJQvvlbvN+tbQd2K5Z+xIc6tpjL
         8hehFDCoMXXNZxRIuoHWI9jcafmPIUyq2wZBZU7KLGuIVqUBkX1ODrepp++JAHyt9pWY
         r9i8QHszdyRNqzZQzUdzkX0elH0ODc7Yk84fjPeqWwa2JtjY3W+b1N2gVHZNvKAypfj8
         NQkQ==
X-Gm-Message-State: AOJu0YzjIYDt86E2KRMSPuAdNkv7fE5iON3gjL5C6PwNapSnyx2WlnRJ
        oPudGbMzdzejEbKSOTb9tJDlcQ==
X-Google-Smtp-Source: AGHT+IEtMvE6B+5pXLBT+duzDpyx4x4YiJIjKZqE8bbzfzR49FgeGTytFNRVKhTMcDDUQ3a9d0h+4Q==
X-Received: by 2002:a5d:5252:0:b0:332:ec48:a132 with SMTP id k18-20020a5d5252000000b00332ec48a132mr1172607wrc.53.1701926779204;
        Wed, 06 Dec 2023 21:26:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003332faefd86sm472453wrw.0.2023.12.06.21.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:26:18 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:26:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        michael@amarulasolutions.com
Subject: Re: [PATCH v4 06/10] drm/panel: Add Synaptics R63353 panel driver
Message-ID: <db6486a4-0a2c-435d-908b-8d61472b51c4@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205105341.4100896-7-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dario-Binacchi/drm-bridge-Fix-bridge-disable-logic/20231205-185455
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231205105341.4100896-7-dario.binacchi%40amarulasolutions.com
patch subject: [PATCH v4 06/10] drm/panel: Add Synaptics R63353 panel driver
config: i386-randconfig-r071-20231206 (https://download.01.org/0day-ci/archive/20231207/202312070214.Eyi9T4eq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312070214.Eyi9T4eq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312070214.Eyi9T4eq-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/panel/panel-synaptics-r63353.c:132 r63353_panel_activate() warn: missing unwind goto?

vim +132 drivers/gpu/drm/panel/panel-synaptics-r63353.c

64f91a53613aea Michael Trimarchi 2023-12-05  107  static int r63353_panel_activate(struct r63353_panel *rpanel)
64f91a53613aea Michael Trimarchi 2023-12-05  108  {
64f91a53613aea Michael Trimarchi 2023-12-05  109  	struct mipi_dsi_device *dsi = rpanel->dsi;
64f91a53613aea Michael Trimarchi 2023-12-05  110  	struct device *dev = &dsi->dev;
64f91a53613aea Michael Trimarchi 2023-12-05  111  	int i, ret;
64f91a53613aea Michael Trimarchi 2023-12-05  112  
64f91a53613aea Michael Trimarchi 2023-12-05  113  	ret = mipi_dsi_dcs_soft_reset(dsi);
64f91a53613aea Michael Trimarchi 2023-12-05  114  	if (ret < 0) {
64f91a53613aea Michael Trimarchi 2023-12-05  115  		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
64f91a53613aea Michael Trimarchi 2023-12-05  116  		goto fail;
64f91a53613aea Michael Trimarchi 2023-12-05  117  	}
64f91a53613aea Michael Trimarchi 2023-12-05  118  
64f91a53613aea Michael Trimarchi 2023-12-05  119  	usleep_range(15000, 17000);
64f91a53613aea Michael Trimarchi 2023-12-05  120  
64f91a53613aea Michael Trimarchi 2023-12-05  121  	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
64f91a53613aea Michael Trimarchi 2023-12-05  122  	if (ret < 0) {
64f91a53613aea Michael Trimarchi 2023-12-05  123  		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
64f91a53613aea Michael Trimarchi 2023-12-05  124  		goto fail;
64f91a53613aea Michael Trimarchi 2023-12-05  125  	}
64f91a53613aea Michael Trimarchi 2023-12-05  126  
64f91a53613aea Michael Trimarchi 2023-12-05  127  	for (i = 0; i < rpanel->pdata->init_length; i++) {
64f91a53613aea Michael Trimarchi 2023-12-05  128  		const struct r63353_instr *instr = &rpanel->pdata->init[i];
64f91a53613aea Michael Trimarchi 2023-12-05  129  
64f91a53613aea Michael Trimarchi 2023-12-05  130  		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
64f91a53613aea Michael Trimarchi 2023-12-05  131  		if (ret < 0)
64f91a53613aea Michael Trimarchi 2023-12-05 @132  			return ret;

goto fail?

64f91a53613aea Michael Trimarchi 2023-12-05  133  	}
64f91a53613aea Michael Trimarchi 2023-12-05  134  
64f91a53613aea Michael Trimarchi 2023-12-05  135  	msleep(120);
64f91a53613aea Michael Trimarchi 2023-12-05  136  
64f91a53613aea Michael Trimarchi 2023-12-05  137  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
64f91a53613aea Michael Trimarchi 2023-12-05  138  	if (ret < 0) {
64f91a53613aea Michael Trimarchi 2023-12-05  139  		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
64f91a53613aea Michael Trimarchi 2023-12-05  140  		goto fail;
64f91a53613aea Michael Trimarchi 2023-12-05  141  	}
64f91a53613aea Michael Trimarchi 2023-12-05  142  
64f91a53613aea Michael Trimarchi 2023-12-05  143  	usleep_range(5000, 10000);
64f91a53613aea Michael Trimarchi 2023-12-05  144  
64f91a53613aea Michael Trimarchi 2023-12-05  145  	ret = mipi_dsi_dcs_set_display_on(dsi);
64f91a53613aea Michael Trimarchi 2023-12-05  146  	if (ret < 0) {
64f91a53613aea Michael Trimarchi 2023-12-05  147  		dev_err(dev, "Failed to set display ON (%d)\n", ret);
64f91a53613aea Michael Trimarchi 2023-12-05  148  		goto fail;
64f91a53613aea Michael Trimarchi 2023-12-05  149  	}
64f91a53613aea Michael Trimarchi 2023-12-05  150  
64f91a53613aea Michael Trimarchi 2023-12-05  151  	return 0;
64f91a53613aea Michael Trimarchi 2023-12-05  152  
64f91a53613aea Michael Trimarchi 2023-12-05  153  fail:
64f91a53613aea Michael Trimarchi 2023-12-05  154  	gpiod_set_value(rpanel->reset_gpio, 0);
64f91a53613aea Michael Trimarchi 2023-12-05  155  
64f91a53613aea Michael Trimarchi 2023-12-05  156  	return ret;
64f91a53613aea Michael Trimarchi 2023-12-05  157  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


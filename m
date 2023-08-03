Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566776E54D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjHCKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjHCKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:13:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E07171B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:13:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso1370911e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691057588; x=1691662388;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OU5jzGZ8m41pATVhJIjp/1tCj5Z8zNWOvgLIF0xT0VI=;
        b=WhRABPa8KudWq8HGeFEQHTRnJX5bqXx3uuHCrwIy+PRZWiV74ZFYdMLx97qnMd2aHR
         KtVwZdiTWzaztZ0XvOPgiF32MinhIqiyyXR6WLjjsI2iKxwzV0oydua3OqTaELn05yij
         ejOEGg+h0GeUXjiuAvk5mz1yB9ZVsflAxVSbv4CwnHwN+71j0hfopIZTmTsIuQHc03gu
         KzQpuWjtaxjGtmKmBp3vXma01nZbeTbjzDEp23VpVbIEkW2d+rgFmT5P47V3wUslfNAH
         tm24mdR7DyDf+bYUOTYS7s6mmU47UHrB5ZYKio67dbYD2TG1qvYBRYbmrvlMvJvOyS10
         r/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057588; x=1691662388;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU5jzGZ8m41pATVhJIjp/1tCj5Z8zNWOvgLIF0xT0VI=;
        b=OzOoEPPzkqxHRGiEbfKBR80+BD2wA8tit2IHVEYeDdRzNSbldnQwIQeG0ihetANQ9A
         EabTLoPgYvgqrlG6FXCJSV4znhS7EJDQq22lwZJwzgYOTok3tggQxrYmQPSUCweK3NSd
         VepwERrGu3cMQDdkxua2rSYiQR6Ngu5XSe9DgbJTWnvLyMB5fLnbwVdwG4vEnP6gFsQY
         SRJUXXtUZ+l1IJPcjIIngsF6c9WT2kZa8xT9MCWBo5B6D4OMmuYh+jkd2bcM7V+hwrjw
         hOBhhBFEEKIaYcToqJSHVHA7nuuH6jM7WDL8B7YUhRK8/64Ruyn8aR/Gy6ZOaJIKZNSx
         anGg==
X-Gm-Message-State: ABy/qLZ0QsUoDcHvXlmRB1Axhl8I1WSmRceD0+ku7ioPuolJ5nbUv9Dn
        byw1ia3Pt2arkIi9EdMoPnux6w==
X-Google-Smtp-Source: APBJJlFzLvmCL4CL7n09K35pdMou3HjnQXAkP5YaT0kUUukk6bteJ+F+BRkjTzQJlPFEkNS7BDWsJg==
X-Received: by 2002:ac2:5332:0:b0:4f1:3d7d:409e with SMTP id f18-20020ac25332000000b004f13d7d409emr6539094lfh.0.1691057588186;
        Thu, 03 Aug 2023 03:13:08 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7c847000000b0051e2549c4f9sm9974394edt.47.2023.08.03.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:13:07 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:13:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <b9040273-aca8-432a-83aa-b0d6b1b88529@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801182132.1058707-6-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/nvmem-core-Create-all-cells-before-adding-the-nvmem-device/20230802-022331
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230801182132.1058707-6-miquel.raynal%40bootlin.com
patch subject: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform devices
config: x86_64-randconfig-m001-20230730 (https://download.01.org/0day-ci/archive/20230803/202308030002.DnSFOrMB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308030002.DnSFOrMB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/

New smatch warnings:
drivers/nvmem/core.c:1003 nvmem_register() warn: 'layout_np' is an error pointer or valid
drivers/nvmem/core.c:2130 nvmem_try_loading_layout_driver() warn: 'layout_np' is an error pointer or valid

Old smatch warnings:
drivers/nvmem/core.c:761 nvmem_add_cells_from_fixed_layout() warn: 'layout_np' is an error pointer or valid
drivers/nvmem/core.c:802 nvmem_layout_get() warn: 'layout_np' is an error pointer or valid

vim +/layout_np +1003 drivers/nvmem/core.c

266570f496b90d Michael Walle         2023-04-04  1000  
00d059fd6702f0 Miquel Raynal         2023-08-01  1001  	/* Populate layouts as devices */
00d059fd6702f0 Miquel Raynal         2023-08-01  1002  	layout_np = of_nvmem_layout_get_container(nvmem);
00d059fd6702f0 Miquel Raynal         2023-08-01 @1003  	if (layout_np) {

So, ugh, of_nvmem_layout_get_container() return NULL on error or error
pointer if either CONFIG_NVMEM or CONFIG_OF is turned off.  I feel like
that's a mistake.  Normally when a function returns both error pointers
and NULL then the NULL means the feature is disabled and the error
pointers mean there was an error.  Here it is the opposite.

I have written a blog about this:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

At first I thought that this was to do with CONFIG_COMPILE_TEST but
actually that is disabled.  The issue here is that CONFIG_OF is turned
off.  So this is a genuine bug, we're compiling a module which will
always crash.

So I guess the fix is easy that this should return NULL if either
CONFIG_NVMEM or CONFIG_OF is turned off.  That was a long explanation
which is no longer required now that it's not a COMPILE_TEST issue.  :P

00d059fd6702f0 Miquel Raynal         2023-08-01  1004  		rval = of_platform_populate(nvmem->dev.of_node, NULL, NULL, NULL);
00d059fd6702f0 Miquel Raynal         2023-08-01  1005  		if (rval)
00d059fd6702f0 Miquel Raynal         2023-08-01  1006  			goto err_remove_cells;
00d059fd6702f0 Miquel Raynal         2023-08-01  1007  		of_node_put(layout_np);
00d059fd6702f0 Miquel Raynal         2023-08-01  1008  	}
00d059fd6702f0 Miquel Raynal         2023-08-01  1009  
25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1010  	mutex_lock(&nvmem_devices_mutex);
25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1011  	list_add_tail(&nvmem->node, &nvmem_devices_list);
25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1012  	mutex_unlock(&nvmem_devices_mutex);
25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1013  
f4853e1c321edb Bartosz Golaszewski   2019-02-15  1014  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
bee1138bea15a6 Bartosz Golaszewski   2018-09-21  1015  
eace75cfdcf7d9 Srinivas Kandagatla   2015-07-27  1016  	return nvmem;
3360acdf839170 Johan Hovold          2017-06-09  1017  
b985f4cba6dbb3 Bartosz Golaszewski   2018-09-21  1018  err_remove_cells:
b985f4cba6dbb3 Bartosz Golaszewski   2018-09-21  1019  	nvmem_device_remove_all_cells(nvmem);
fa72d847d68d78 Bartosz Golaszewski   2018-09-21  1020  	if (config->compat)
ae0c2d725512f3 Srinivas Kandagatla   2019-04-16  1021  		nvmem_sysfs_remove_compat(nvmem, config);
3360acdf839170 Johan Hovold          2017-06-09  1022  err_put_device:
3360acdf839170 Johan Hovold          2017-06-09  1023  	put_device(&nvmem->dev);
3360acdf839170 Johan Hovold          2017-06-09  1024  
b6c217ab9be689 Andrew Lunn           2016-02-26  1025  	return ERR_PTR(rval);
eace75cfdcf7d9 Srinivas Kandagatla   2015-07-27  1026  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


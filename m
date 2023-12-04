Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C2C802BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjLDGzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjLDGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:55:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F06D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 22:55:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso383675e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 22:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701672922; x=1702277722; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWZ3xHevBq7/IxqTa8ww23Un8tQbcWbjjl38PMj7wwE=;
        b=gwdkrzOZTFR7hPAOSNEDMyW4f2boxhy/6Qp5kuoeE6Fdbj7LJWsXGoUqs4rDq70Avg
         A9FbDsGljK+dGRTEfAgtzBe9PsbUo7deGfw3QwsnjwAD7t7Ck96MdERhsewZ3uFsvIaT
         xAKDmWmZfOv8YixeQM8epp/SDcD9cQb+FpWWpG6xvv4g84bXl3f04fTsUDRsvSmX0xix
         QUqRLEgfuKcYyysGqj8vjwGIcR5a1TwttnCWxSHXERrs5lzUZvrfL97s2iTm83+fosG/
         Ln7+StBeVuoJrWtUSUobZVdtuGueQxqMmI2DzzGUROe+ld4fJWC0X1mRuxkvchsa5SOo
         rwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701672922; x=1702277722;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWZ3xHevBq7/IxqTa8ww23Un8tQbcWbjjl38PMj7wwE=;
        b=M9+VBYVKDfmt3cw1aK8Vt8fZ70DU2WX4TyaCIcfy/VJGKQ3ENUOkgmK/GJaIV4jBAW
         wHoDuE806CCNLUVLG6AOU7qP+yNIlh5amn4f9SYC74Qdyi9VNiafkaOj/+c+cOTzABlV
         kPnaUN/tHn90PXBGgOtz39sIZvJyk2rBf3iwuAcFyr7aTTflV9byMCCzDxRsGjNXKgH8
         0eIHEJhIvm1+p7tuttplvksBOCqoWqkpJZqzNrkqcxbyV0q6vmBLsuLNLuEdJK1+duZ4
         44HKd6XdxXHqMv9JB1U3/aZybS/Odtr48jjp8eszADFWrtj+7MR1nkkepTDgViu/aHgQ
         Thow==
X-Gm-Message-State: AOJu0Ywm6N3b1GwOHVP1/Z4ArU87kox1b6KUVWypZz4ASiOMBBYOvaSc
        itZydiwrf0UEHU8yTF6/MaFWhDaGItbZ7eUzE1s=
X-Google-Smtp-Source: AGHT+IFiOHRh6KgggrgE9oHGoBI0IKj+Fa+i1jkpxKqSlUGD/Fc2nUUAsmd23wu7naHM5HjvVzS9Qw==
X-Received: by 2002:a05:600c:4e8b:b0:40b:5e21:dd1c with SMTP id f11-20020a05600c4e8b00b0040b5e21dd1cmr2258397wmq.74.1701672922626;
        Sun, 03 Dec 2023 22:55:22 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm13892825wmb.15.2023.12.03.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 22:55:22 -0800 (PST)
Date:   Mon, 4 Dec 2023 09:55:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/nios2/kernel/time.c:223 nios2_timer_get_base_and_freq() warn:
 '*base' from of_iomap() not released on lines: 220.
Message-ID: <49db8904-e10d-4c91-be72-3dc182fb6e39@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: dd1364a7439be4d20f87637a72eb7bd4553827f0 clocksource/drivers/nios2: Convert init function to return error
config: nios2-randconfig-r081-20231120 (https://download.01.org/0day-ci/archive/20231204/202312040334.l78lahzX-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312040334.l78lahzX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312040334.l78lahzX-lkp@intel.com/

New smatch warnings:
arch/nios2/kernel/time.c:223 nios2_timer_get_base_and_freq() warn: '*base' from of_iomap() not released on lines: 220.

Old smatch warnings:
internal error: arch/nios2/include/asm/irqflags.h:25 SQL error #2: near "and": syntax error
internal error: arch/nios2/include/asm/irqflags.h:25 SQL: 'select * from return_states where  and type = 1044 and parameter = -1 and key = '$' limit 1;'
arch/nios2/kernel/time.c:139 nios2_timer_config() warn: inconsistent indenting

vim +223 arch/nios2/kernel/time.c

dd1364a7439be4 Daniel Lezcano 2016-06-07  209  static int __init nios2_timer_get_base_and_freq(struct device_node *np,
4182de9e6356c0 Ley Foon Tan   2014-11-06  210  				void __iomem **base, u32 *freq)
4182de9e6356c0 Ley Foon Tan   2014-11-06  211  {
4182de9e6356c0 Ley Foon Tan   2014-11-06  212  	*base = of_iomap(np, 0);
dd1364a7439be4 Daniel Lezcano 2016-06-07  213  	if (!*base) {
dd1364a7439be4 Daniel Lezcano 2016-06-07  214  		pr_crit("Unable to map reg for %s\n", np->name);
dd1364a7439be4 Daniel Lezcano 2016-06-07  215  		return -ENXIO;
dd1364a7439be4 Daniel Lezcano 2016-06-07  216  	}
dd1364a7439be4 Daniel Lezcano 2016-06-07  217  
dd1364a7439be4 Daniel Lezcano 2016-06-07  218  	if (of_property_read_u32(np, "clock-frequency", freq)) {
dd1364a7439be4 Daniel Lezcano 2016-06-07  219  		pr_crit("Unable to get %s clock frequency\n", np->name);
dd1364a7439be4 Daniel Lezcano 2016-06-07  220  		return -EINVAL;

Over the weekend the kbuild bot started going through some truly ancient
warnings.  Apparently we're supposed to iounmap() on this error path.

dd1364a7439be4 Daniel Lezcano 2016-06-07  221  	}
4182de9e6356c0 Ley Foon Tan   2014-11-06  222  
dd1364a7439be4 Daniel Lezcano 2016-06-07 @223  	return 0;
4182de9e6356c0 Ley Foon Tan   2014-11-06  224  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A6792B42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbjIEQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354422AbjIELbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:31:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68F1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:31:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401f68602a8so23476725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693913498; x=1694518298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ucSMS6f1i4AJkmKZWAiTc8WB+F0d5XaASaMmBm7ZJv0=;
        b=vLBeAy8m9T9JIfk/d47cB5i8zfi83j9+DjUBWeHNpYmKa1wDd5/ldv32HD9TeFoP+i
         3X60O5xuVzq+0CXfSsjl8PXLmbDYHk2jUmuvBkKYzHWnX4cpejmOQY42hRv6qZ88ycXB
         jQxxVP36Ye6VbhmHlWTf0/9KLmx7ymd0m9/cyKhLFVIVqlFHnhQZKVHZ0pkPIXgP5w1E
         nj9A+pBxn4B0vcjijqZ3DRbgAgRdfpiJzDRzm5o6VZUZhld++tWv7X6FJbql7FIL0UHp
         /znsReTvQePi1kXcxj5Y99VnNIlJS9B6Cawq4xWe5QOIgWodGDkxBhlhcjJQULirTiax
         gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693913498; x=1694518298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucSMS6f1i4AJkmKZWAiTc8WB+F0d5XaASaMmBm7ZJv0=;
        b=HQ7XMD1iK9JTwwFX6ryfwiCdawrF0tkPdd/g7VAi8Q1V5q9wlMQSdJIgXIgfYX/3cs
         9rWMQ5nguiHcPomisqJdxDf436puZqS0o2umtwRZr2g201fUJ/pr+PYDoE7zWruMlXB+
         Zkm32OYcInM6oMY8v8Qa4Qgz1eNmlud1T95Bg1CaoEqgymtFFxoAXJ27z/79snkOOFoO
         ZSwDHqcs0LAvK2uMf6m5dDcsKF0LQnSverW/r1mMZVJgA5Z5hAUQnMeL492aGq2bWQ2p
         FySzXgyf8ecLvlrSdwCL11Y8dQEOfIUx2Bh97zjEEzuJNurcMu/t6RZKL401DIGccfyk
         DJxA==
X-Gm-Message-State: AOJu0YwyGeGkMrG/hEVBJkTF7ojvwHNQTl/hR/xJHCoPFJeX7v6KV7tS
        STO3e/mAxmS8kFYPDloVHF4ASQ==
X-Google-Smtp-Source: AGHT+IEpJmilH9Tppz6BKD/gVURbvbPERFqtmnEdu+ZGNvg+ETGDXFXfFdgWvlIP9ozV8luG9EA7aA==
X-Received: by 2002:a1c:4b08:0:b0:3fe:d1b9:7ea9 with SMTP id y8-20020a1c4b08000000b003fed1b97ea9mr9575348wma.36.1693913498664;
        Tue, 05 Sep 2023 04:31:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bcb89000000b003fe26244858sm19823929wmi.46.2023.09.05.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:31:38 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:31:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pinctrl: mcp23s08: Simplify probe()
Message-ID: <2ce09856-244a-4e3f-89ff-d9439ea06af9@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230902090937.32195-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju-Das/pinctrl-mcp23s08-Extend-match-support-for-OF-tables/20230902-171023
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230902090937.32195-3-biju.das.jz%40bp.renesas.com
patch subject: [PATCH 2/2] pinctrl: mcp23s08: Simplify probe()
config: i386-randconfig-141-20230902 (https://download.01.org/0day-ci/archive/20230903/202309030751.GQvtrZnS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230903/202309030751.GQvtrZnS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309030751.GQvtrZnS-lkp@intel.com/

smatch warnings:
drivers/pinctrl/pinctrl-mcp23s08_i2c.c:33 mcp230xx_probe() error: we previously assumed 'info' could be null (see line 31)

vim +/info +33 drivers/pinctrl/pinctrl-mcp23s08_i2c.c

8bb5811129f9e4 Uwe Kleine-König 2022-11-18  19  static int mcp230xx_probe(struct i2c_client *client)
0f04a81784fe3d Andy Shevchenko  2020-04-07  20  {
b5f259f6fc5912 Biju Das         2023-09-02  21  	const struct mcp23s08_i2c_info *info;
0f04a81784fe3d Andy Shevchenko  2020-04-07  22  	struct device *dev = &client->dev;
0f04a81784fe3d Andy Shevchenko  2020-04-07  23  	struct mcp23s08 *mcp;
0f04a81784fe3d Andy Shevchenko  2020-04-07  24  	int ret;
0f04a81784fe3d Andy Shevchenko  2020-04-07  25  
0f04a81784fe3d Andy Shevchenko  2020-04-07  26  	mcp = devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
0f04a81784fe3d Andy Shevchenko  2020-04-07  27  	if (!mcp)
0f04a81784fe3d Andy Shevchenko  2020-04-07  28  		return -ENOMEM;
0f04a81784fe3d Andy Shevchenko  2020-04-07  29  
b5f259f6fc5912 Biju Das         2023-09-02  30  	info = i2c_get_match_data(client);
b5f259f6fc5912 Biju Das         2023-09-02 @31  	if (!info)
b5f259f6fc5912 Biju Das         2023-09-02  32  		return dev_err_probe(dev, -EINVAL, "invalid device type (%d)\n",
b5f259f6fc5912 Biju Das         2023-09-02 @33  				     info->type);
                                                                                     ^^^^^^^^^^
info is NULL.

0f04a81784fe3d Andy Shevchenko  2020-04-07  34  
b5f259f6fc5912 Biju Das         2023-09-02  35  	mcp->reg_shift = info->reg_shift;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


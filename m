Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82D17F5807
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344749AbjKWGK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWGKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:10:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8C110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:10:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32deb2809daso321939f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700719829; x=1701324629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhvG/cBSfaRPoasqLeuPzQWIXK6FL28oMwCUuCagJt0=;
        b=IoB7xbz6od+a4wpRsS3qatfIwiQK9wtCdwYQ2HI4opP/Ns9uArd9ndVJk88NrrpGjR
         zzEA8f8v4c2Qgv0UQ9UMQrhWkGItQxpeJokDAlLPCFsvBviKI4ONtM9t06+jpKqSi/Kv
         CiJHpqkRdfmlGGvXGlBnkNe63XG3/A5ktUMTE6+CHteInsf+tSfLcDFaZYbJrUxBCLpe
         UVDfAXYYQIJzW2wdZ75pYt7SkvxpUJuA2ZBvuxUomweTb6Qg7pXvb6dTd7fRkDaX3/ix
         fYwZRgwI4b4o+IG5ZJo4azlzHkmhD4jpSEoZuBrANvhyJKiMHPIM5I0Y2Q3q0Tvi1KdC
         8tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700719829; x=1701324629;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhvG/cBSfaRPoasqLeuPzQWIXK6FL28oMwCUuCagJt0=;
        b=PGYKcqIIW9fhxoUDZ/ksEbYBldXpdZy7YNaF9ToVLS33FO7WPFvqqzk+j/9VqtI61s
         VazVdbDInXjwluAc75VMD093ms4/g4mretJPRK6KaFwaAoBqfwnqW6T3XR25ZQbLOI58
         ZvI5Q9ePYNwHpohBsbcvWsBvKzDwjQXOzt+Acf4RQTVCjK4BZOOEcuHgr5tpW46of6Bi
         bNokr6ZBaTiV4XJvP0i7NV9QGu1Ym/CvZ1yLE+vsoRua2vCFAjB/M3Wwku8IXD8AZ0fl
         iRwqOARkS0qN9+R2RVgO5VlHAzkSOLIj/MuPAS/iY2rc/0c+3PgADR0jP98HhtFwAQnx
         52mw==
X-Gm-Message-State: AOJu0YxyqfvzKoO7xMMdd+SKRtwtX1H9ardtg3cbCt+cm3YJB689hXix
        +nbHXDqOHfSqAPuyn7cCI2k7YA==
X-Google-Smtp-Source: AGHT+IG5E0J+F3kI7IYUeGWwGwjyH+HM0RRgSN6O6Q9IxonmzR/N7zH+77peiECJsn59NOfrikGrWA==
X-Received: by 2002:a5d:5987:0:b0:332:c585:400d with SMTP id n7-20020a5d5987000000b00332c585400dmr2890916wri.10.1700719828609;
        Wed, 22 Nov 2023 22:10:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x12-20020adff64c000000b0032dcb08bf94sm602993wrp.60.2023.11.22.22.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:10:28 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 23 Nov 2023 09:10:25 +0300
To:     oe-kbuild@lists.linux.dev, Umang Jain <umang.jain@ideasonboard.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c:507
 vchiq_ioc_await_completion() warn: inconsistent indenting
Message-ID: <a4901693-b034-4a63-b97d-a6c2d9ddcb29@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b6de136b5f0158c60844f85286a593cb70fb364
commit: 1d8915cf889932e085880f4bdbf7ae0f3d8605e5 staging: vc04: Convert vchiq_log_error() to use dynamic debug
config: mips-randconfig-r081-20231121 (https://download.01.org/0day-ci/archive/20231123/202311230705.w4DPJjm0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231123/202311230705.w4DPJjm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311230705.w4DPJjm0-lkp@intel.com/

smatch warnings:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c:507 vchiq_ioc_await_completion() warn: inconsistent indenting

vim +507 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c

f05916281fd75db Ojaswin Mujoo   2021-07-21  496  		header = completion->header;
f05916281fd75db Ojaswin Mujoo   2021-07-21  497  		if (header) {
f05916281fd75db Ojaswin Mujoo   2021-07-21  498  			void __user *msgbuf;
f05916281fd75db Ojaswin Mujoo   2021-07-21  499  			int msglen;
f05916281fd75db Ojaswin Mujoo   2021-07-21  500  
f05916281fd75db Ojaswin Mujoo   2021-07-21  501  			msglen = header->size + sizeof(struct vchiq_header);
f05916281fd75db Ojaswin Mujoo   2021-07-21  502  			/* This must be a VCHIQ-style service */
f05916281fd75db Ojaswin Mujoo   2021-07-21  503  			if (args->msgbufsize < msglen) {
1d8915cf889932e Umang Jain      2023-10-24  504  				vchiq_log_error(service->state->dev, VCHIQ_ARM,
f05916281fd75db Ojaswin Mujoo   2021-07-21  505  						"header %pK: msgbufsize %x < msglen %x",
f05916281fd75db Ojaswin Mujoo   2021-07-21  506  						header, args->msgbufsize, msglen);
f05916281fd75db Ojaswin Mujoo   2021-07-21 @507  						WARN(1, "invalid message size\n");

WARN() is indented too far.

f05916281fd75db Ojaswin Mujoo   2021-07-21  508  				if (ret == 0)
f05916281fd75db Ojaswin Mujoo   2021-07-21  509  					ret = -EMSGSIZE;
f05916281fd75db Ojaswin Mujoo   2021-07-21  510  				break;
f05916281fd75db Ojaswin Mujoo   2021-07-21  511  			}
f05916281fd75db Ojaswin Mujoo   2021-07-21  512  			if (msgbufcount <= 0)
f05916281fd75db Ojaswin Mujoo   2021-07-21  513  				/* Stall here for lack of a buffer for the message. */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


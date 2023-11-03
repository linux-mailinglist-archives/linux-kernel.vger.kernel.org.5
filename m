Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4997DFEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjKCGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKCGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:01:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8A1BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:01:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2825242a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698991297; x=1699596097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukb8C5mDZsObaz53quLRVItiO2EF/GZE516uqejG/ko=;
        b=Uq5X9lDDg11NNxXl17Y3k1jv8//M4ed08HADWK+b9BD+z3hve1KgAtMpCkIEcwUYZa
         /iTWijZBcq5gznKDa4ORjoOXVHyx3Wdnwuk/gPhNXZUS9hIpvFX0qkkvZ7lgU1GBnt0g
         lOPtYflLXojV31Zd2XDEjdjJMk5RfSKjuVWqEWVonMgol5KTSC4wa9aks0xq6egxe/JV
         iY1Qw5UHke4hJlsqv1niFDpXIss9/9l8jaLOCwYLoSPrScbgktMQ9pyJ1pzMFbWorkEc
         c9vfKsRFfq5nHg0aXnOQVwMabj15t5yzS7RCTadMl7Yo60eAN4vtzjfWJj/lRPoiNfw6
         vhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698991297; x=1699596097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukb8C5mDZsObaz53quLRVItiO2EF/GZE516uqejG/ko=;
        b=D+zRwY96g5+FeGLXgofnLW8Nv3kK//k3ULZaxw26z8BqEPHwVhJs8VprXedpTv168+
         +MK/HkWD8kkXP4jBOu7ChE1m8YNaXy2bbFjqot2TyLTnDbr0IUd3BwC5XnLZPH84Cstl
         SkEmqOpBC01RFlo/q3yX0PbMvywjQOxOFOrNAIFr82LrXJ62CQSpTQtv6o9+gVeRAOom
         XG/XvqFebLtAaLb6F/4CZ1+RyMUKUXCPDYd1I/4XcdJNKIjgR5nlN6DcOLV/+zc3aI4B
         MiB97dsDJlGs5zq4NUy8vt5CCzuuLqXWfD1y0oEzPdOBLPyBNJi6+voftVlKqpAQZ/zF
         Tuow==
X-Gm-Message-State: AOJu0Yz67E59cZdYTcXMKodFR31helIxC7fN86YrTq8npfdcW5QcmgEa
        MfTQUGgYHcoGrYW/widO2iAOPg==
X-Google-Smtp-Source: AGHT+IG/ottftTOCLDvRabQSmO51TPU5plBCAZTFoa9mzIMz0bWPwX8u081urBBrSA0HCRk5BA8v3g==
X-Received: by 2002:aa7:c90f:0:b0:53e:34c5:fc14 with SMTP id b15-20020aa7c90f000000b0053e34c5fc14mr16474627edt.23.1698991297468;
        Thu, 02 Nov 2023 23:01:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i14-20020aa7c9ce000000b0053fa13e27dcsm563137edt.48.2023.11.02.23.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:01:37 -0700 (PDT)
Date:   Fri, 3 Nov 2023 09:01:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/thunderbolt/tmu.c:617 tb_switch_tmu_change_mode() warn:
 missing unwind goto?
Message-ID: <9a426df0-2ad2-48e7-aa6a-21e5c40ec839@kadam.mountain>
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

Hi Mika,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: c437dcb18310f296eb9db58a361f309f7817014d thunderbolt: Fix a couple of style issues in TMU code
config: i386-randconfig-141-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030814.AXtCk7PO-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311030814.AXtCk7PO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311030814.AXtCk7PO-lkp@intel.com/

smatch warnings:
drivers/thunderbolt/tmu.c:617 tb_switch_tmu_change_mode() warn: missing unwind goto?

vim +617 drivers/thunderbolt/tmu.c

c437dcb18310f2 Mika Westerberg 2022-10-07  596  static int tb_switch_tmu_change_mode(struct tb_switch *sw)
b017a46d486cd4 Gil Fine        2022-05-26  597  {
b017a46d486cd4 Gil Fine        2022-05-26  598  	struct tb_port *up, *down;
b017a46d486cd4 Gil Fine        2022-05-26  599  	int ret;
b017a46d486cd4 Gil Fine        2022-05-26  600  
b017a46d486cd4 Gil Fine        2022-05-26  601  	up = tb_upstream_port(sw);
7ce542219b6323 Gil Fine        2022-09-23  602  	down = tb_switch_downstream_port(sw);
b017a46d486cd4 Gil Fine        2022-05-26  603  	ret = tb_port_tmu_set_unidirectional(down, sw->tmu.unidirectional_request);
b017a46d486cd4 Gil Fine        2022-05-26  604  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26  605  		goto out;
b017a46d486cd4 Gil Fine        2022-05-26  606  
b017a46d486cd4 Gil Fine        2022-05-26  607  	if (sw->tmu.unidirectional_request)
7ce542219b6323 Gil Fine        2022-09-23  608  		ret = tb_switch_tmu_rate_write(tb_switch_parent(sw),
7ce542219b6323 Gil Fine        2022-09-23  609  					       sw->tmu.rate_request);
b017a46d486cd4 Gil Fine        2022-05-26  610  	else
b017a46d486cd4 Gil Fine        2022-05-26  611  		ret = tb_switch_tmu_rate_write(sw, sw->tmu.rate_request);
b017a46d486cd4 Gil Fine        2022-05-26  612  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26  613  		return ret;

These error paths should be goto out;

b017a46d486cd4 Gil Fine        2022-05-26  614  
b017a46d486cd4 Gil Fine        2022-05-26  615  	ret = tb_switch_set_tmu_mode_params(sw, sw->tmu.rate_request);
b017a46d486cd4 Gil Fine        2022-05-26  616  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26 @617  		return ret;

Same.  (I guess before goto out was a do-nothing goto so it didn't
matter).

b017a46d486cd4 Gil Fine        2022-05-26  618  
b017a46d486cd4 Gil Fine        2022-05-26  619  	ret = tb_port_tmu_set_unidirectional(up, sw->tmu.unidirectional_request);
b017a46d486cd4 Gil Fine        2022-05-26  620  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26  621  		goto out;
b017a46d486cd4 Gil Fine        2022-05-26  622  
b017a46d486cd4 Gil Fine        2022-05-26  623  	ret = tb_port_tmu_time_sync_enable(down);
b017a46d486cd4 Gil Fine        2022-05-26  624  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26  625  		goto out;
b017a46d486cd4 Gil Fine        2022-05-26  626  
b017a46d486cd4 Gil Fine        2022-05-26  627  	ret = tb_port_tmu_time_sync_enable(up);
b017a46d486cd4 Gil Fine        2022-05-26  628  	if (ret)
b017a46d486cd4 Gil Fine        2022-05-26  629  		goto out;
b017a46d486cd4 Gil Fine        2022-05-26  630  
b017a46d486cd4 Gil Fine        2022-05-26  631  	return 0;
b017a46d486cd4 Gil Fine        2022-05-26  632  
b017a46d486cd4 Gil Fine        2022-05-26  633  out:
c437dcb18310f2 Mika Westerberg 2022-10-07  634  	tb_switch_tmu_change_mode_prev(sw);
b017a46d486cd4 Gil Fine        2022-05-26  635  	return ret;
b017a46d486cd4 Gil Fine        2022-05-26  636  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


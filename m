Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4A7C6596
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbjJLG1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbjJLG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:27:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E83A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:27:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so567438f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697092064; x=1697696864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qh/FqmK5/lSlV2dRf/mKoA/boJ1aJkcrMskY/i85Ijc=;
        b=cTb+ayxHtEIlXj8Avj6tQc4A6eJxbO728Rq0JtYPi4pFGxO7S2gNDkaESMhLRufDNO
         GGx7g2PxhI5Mo8LExNSbAQTRZ8JbSOWdY8FYUsLGZgVfiEeE4025z1rnaIuVQmrM9opW
         8Olu92c7kO048puRdROLukGI7dmjTBFlieHs1rOLdI0i1KNGiqPxZQbmn1I+7yJKtTfd
         i5w5rwDFCBp8HuERK5PUtm3bzyrm7ijNc14g8uzCKgW4ZeKgI6yus/pHcS0WKJ8+nSOB
         +cCSLeMbr+g8Toq8qeXegs6D2e67kNgitnokrrRiQZ6pwT9frl9pXdqCUOQUVavdVCQe
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092064; x=1697696864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh/FqmK5/lSlV2dRf/mKoA/boJ1aJkcrMskY/i85Ijc=;
        b=bthe4WCCWoBTGCRnq713cn1LXPMGPJIliLaDClNR+XvhxkOZElhFRJpKGGBnFkgOCc
         ROPbQwK5/xsUkmjwwSGHDIegAkYFk7WL8uGPFtVWnmrRiqlxyLJd3MXJBRtoOMo+qI7C
         9fwmAhua7aFEiXxvMLiKBxWpYNP8HV/G82HrLpuYXX0vwdEvDcJTvwimnZRW3TYJfck+
         WQ6BZchgCEvy1njRbf1Uww0DrvtWHEg1YMFSYRiSHaNv8rLkcHJxgg09LPts/V1O2nFn
         iMn9TaIwndUU2ZI4nTEDn131uxp0XOarLHSX4JBbMeIHobzSGa1CjCKEanla91TzdIm5
         znLg==
X-Gm-Message-State: AOJu0Yz/1pmH4Hslv8o3i8F9sfgFazu4eEc/eaiNB+5ukErQTpeKzCOb
        xHOZXFDjsW7tfS8uSGOL2uPJCg==
X-Google-Smtp-Source: AGHT+IFKOom+QTQFKBsgi61DlMK8S8xzCP5xg6dkfXy5nGPIUU2fUpDRZMujLqBLW2h7XQbeUiqHbg==
X-Received: by 2002:adf:9bc3:0:b0:32d:87df:6de5 with SMTP id e3-20020adf9bc3000000b0032d87df6de5mr2654429wrc.49.1697092064534;
        Wed, 11 Oct 2023 23:27:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f8-20020adfe908000000b0032d8ce46caasm1470343wrm.93.2023.10.11.23.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:27:44 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:27:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Li zeming <zeming@nfschina.com>,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] profile: Remove =?utf-8?Q?unne?=
 =?utf-8?B?Y2Vzc2FyeSDigJgw4oCZ?= values from err
Message-ID: <767e9a6f-5470-491e-a08a-e5a8ee48b1cb@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919014126.8168-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-zeming/profile-Remove-unnecessary-0-values-from-err/20230919-094202
base:   linus/master
patch link:    https://lore.kernel.org/r/20230919014126.8168-1-zeming%40nfschina.com
patch subject: [PATCH] profile: Remove unnecessary ‘0’ values from err
config: i386-randconfig-141-20230921 (https://download.01.org/0day-ci/archive/20231012/202310120931.henXte1M-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231012/202310120931.henXte1M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310120931.henXte1M-lkp@intel.com/

smatch warnings:
kernel/profile.c:491 create_proc_profile() error: uninitialized symbol 'err'.

vim +/err +491 kernel/profile.c

^1da177e4c3f41 Linus Torvalds            2005-04-16  467  
1997ab2b2a8d46 Li zeming                 2023-09-19  468  	int err;
^1da177e4c3f41 Linus Torvalds            2005-04-16  469  
^1da177e4c3f41 Linus Torvalds            2005-04-16  470  	if (!prof_on)
^1da177e4c3f41 Linus Torvalds            2005-04-16  471  		return 0;
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  472  #ifdef CONFIG_SMP
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  473  	err = cpuhp_setup_state(CPUHP_PROFILE_PREPARE, "PROFILE_PREPARE",
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  474  				profile_prepare_cpu, profile_dead_cpu);
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  475  	if (err)
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  476  		return err;
c270a817196a93 Srivatsa S. Bhat          2014-03-11  477  
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  478  	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "AP_PROFILE_ONLINE",
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  479  				profile_online_cpu, NULL);
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  480  	if (err < 0)
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  481  		goto err_state_prep;
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  482  	online_state = err;
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  483  	err = 0;
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  484  #endif

err is uninitialized on single processor systems.

c33fff0afbef4f Denis V. Lunev            2008-04-29  485  	entry = proc_create("profile", S_IWUSR | S_IRUGO,
97a32539b9568b Alexey Dobriyan           2020-02-03  486  			    NULL, &profile_proc_ops);
1ad82fd547c716 Paolo Ciarrocchi          2008-01-25  487  	if (!entry)
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13  488  		goto err_state_onl;
271a15eabe0945 David Howells             2013-04-12  489  	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
c270a817196a93 Srivatsa S. Bhat          2014-03-11  490  
e722d8daafb974 Sebastian Andrzej Siewior 2016-07-13 @491  	return err;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


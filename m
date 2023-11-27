Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC07F9BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjK0Ii6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjK0Iit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:38:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C2135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:38:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so5554648e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701074333; x=1701679133; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+3L96NjIz2RWvf2gmLIvMPT1EB5fPTxOYm9b8qLDp0=;
        b=ROj2g7cr+ig1bhz2bPAYmpPabdcUTbbEDL05KOYIPsw15AxYjY1iJ4DxkiACE65Lqn
         B2XIq7abF55/FsMoz1T2FuPBOVDQgEDX5wAxaX+/Dk6uW0o7LDS4jCugrpb9GgakurjO
         jNx2wL9zt23iLOqqmYhH8cppLkCPZKbbf94wngrmVugk1r4fh5Z6FpZrFHyhTmE4x3kF
         3GtS4i0xpsrXFJSBFkhInGF3f7aTvHBSXVXpOI+z2BC8PwyivE6JLPbqUxzVcJ6CfRAz
         rDN3eVhxkFpzMOeyGKwZHhRCFsF9knxLVlB6eRACRd1aW5EBsksED+eVfoiX+Svjwkeg
         7HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074333; x=1701679133;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+3L96NjIz2RWvf2gmLIvMPT1EB5fPTxOYm9b8qLDp0=;
        b=EUVgfHVUiECnOo0DsQDrL6vF9m6y/I2t62CQTEPE1psjosM1BksG0pCw+8OTLVUWC/
         jX81Aw8Msf2BUMAvBFnWLezFD6hMlT++eNHo61zNhJN6a+v7H9AcojFvcnutP6R9AOod
         MJqD9bXsHmfA8e7m9anCi1DiFE+T8OyJ7l6Vgz9nCAhBy1DWKiQLu0qG6KV1L1qh5FVM
         qQmyV/lYddTRhSaIRbiOj9ShvydQjI9CwtrHGgjIYoiGOB+639arA2tkuFDukjWV2mzP
         nVoD/YN/1sGILitRPDCNntDpwtoU+lr5876xBQoVYYuEoqPBB7sJXt7/E0bNkn4hPUon
         1/Fg==
X-Gm-Message-State: AOJu0YwzHNMYJRadbURE12ZLjhR0ZPYSNGpeX0xZk6/5ryCINOg+JY1+
        vugiWYnFRkhjBT5b2PizfOELNg==
X-Google-Smtp-Source: AGHT+IH1lV7fJUCBtxnjaOz/DUnKc8vizm037rCEh5sYL2qpZN9rN2jJ82wkap3SnCOBneVERtKuAA==
X-Received: by 2002:a05:6512:2350:b0:507:9fc1:ca7a with SMTP id p16-20020a056512235000b005079fc1ca7amr5307062lfu.9.1701074333070;
        Mon, 27 Nov 2023 00:38:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b00327de0173f6sm11370105wrr.115.2023.11.27.00.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:38:52 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 27 Nov 2023 11:38:49 +0300
To:     oe-kbuild@lists.linux.dev, Qi Hu <huqi@loongson.cn>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: arch/loongarch/kernel/traps.c:407 die() warn: variable dereferenced
 before check 'regs' (see line 401)
Message-ID: <90f50994-3cc7-4f35-9fab-a62ac129a93d@suswa.mountain>
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

Hi Qi,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2da77f431ac49b5763b88751a75f70daa46296c
commit: 346dc929623cef70ff7832a4fa0ffd1b696e312a LoongArch: Fix the write_fcsr() macro
config: loongarch-randconfig-r071-20231126 (https://download.01.org/0day-ci/archive/20231127/202311270400.2cHw6Jsv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231127/202311270400.2cHw6Jsv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311270400.2cHw6Jsv-lkp@intel.com/

New smatch warnings:
arch/loongarch/kernel/traps.c:407 die() warn: variable dereferenced before check 'regs' (see line 401)

vim +/regs +407 arch/loongarch/kernel/traps.c

0603839b18f4fb Huacai Chen  2022-05-31  385  void __noreturn die(const char *str, struct pt_regs *regs)
0603839b18f4fb Huacai Chen  2022-05-31  386  {
0603839b18f4fb Huacai Chen  2022-05-31  387  	static int die_counter;
0603839b18f4fb Huacai Chen  2022-05-31  388  	int sig = SIGSEGV;
0603839b18f4fb Huacai Chen  2022-05-31  389  
0603839b18f4fb Huacai Chen  2022-05-31  390  	oops_enter();
0603839b18f4fb Huacai Chen  2022-05-31  391  
0603839b18f4fb Huacai Chen  2022-05-31  392  	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
0603839b18f4fb Huacai Chen  2022-05-31  393  		       SIGSEGV) == NOTIFY_STOP)
0603839b18f4fb Huacai Chen  2022-05-31  394  		sig = 0;
0603839b18f4fb Huacai Chen  2022-05-31  395  
0603839b18f4fb Huacai Chen  2022-05-31  396  	console_verbose();
0603839b18f4fb Huacai Chen  2022-05-31  397  	raw_spin_lock_irq(&die_lock);
0603839b18f4fb Huacai Chen  2022-05-31  398  	bust_spinlocks(1);
0603839b18f4fb Huacai Chen  2022-05-31  399  
0603839b18f4fb Huacai Chen  2022-05-31  400  	printk("%s[#%d]:\n", str, ++die_counter);
0603839b18f4fb Huacai Chen  2022-05-31 @401  	show_registers(regs);
                                                               ^^^^
Dereferenced

0603839b18f4fb Huacai Chen  2022-05-31  402  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
0603839b18f4fb Huacai Chen  2022-05-31  403  	raw_spin_unlock_irq(&die_lock);
0603839b18f4fb Huacai Chen  2022-05-31  404  
0603839b18f4fb Huacai Chen  2022-05-31  405  	oops_exit();
0603839b18f4fb Huacai Chen  2022-05-31  406  
4e62d1d86585e1 Youling Tang 2022-10-12 @407  	if (regs && kexec_should_crash(current))
                                                    ^^^^
Checked too late

4e62d1d86585e1 Youling Tang 2022-10-12  408  		crash_kexec(regs);
4e62d1d86585e1 Youling Tang 2022-10-12  409  
0603839b18f4fb Huacai Chen  2022-05-31  410  	if (in_interrupt())
0603839b18f4fb Huacai Chen  2022-05-31  411  		panic("Fatal exception in interrupt");
0603839b18f4fb Huacai Chen  2022-05-31  412  
0603839b18f4fb Huacai Chen  2022-05-31  413  	if (panic_on_oops)
0603839b18f4fb Huacai Chen  2022-05-31  414  		panic("Fatal exception");
0603839b18f4fb Huacai Chen  2022-05-31  415  
0603839b18f4fb Huacai Chen  2022-05-31  416  	make_task_dead(sig);
0603839b18f4fb Huacai Chen  2022-05-31  417  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


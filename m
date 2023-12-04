Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF58802AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjLDEiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:38:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F692
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 20:38:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-33338c47134so1491056f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 20:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701664700; x=1702269500; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVQn0i2hfX92sEXFDpbefnTwnACZ1HnUoqi+/6j93j8=;
        b=Exp/RHcgW00uUahgk3pgePyTnYJv/tC4ombAKFaC0jGpVUv6W06E8rCnvpaGdZCJwp
         KVnq8Y6Dk3uoMQyu67H9apXg+zmAEOO5x2gHKJJtJ+TnALybHOmjAtyTVfMqul3wVTu2
         Rx8sbFQi5kmQC8O+84Mi2xdBMMGEXv02jn+hgZcJ/50FkJEoodiFqwEtCGRrNF9n+nsr
         UgxSIPmkKYa8oYz+6LefyzDm1u72G7uqJ1sujNlBI1o6Ofh8Kfnw/FoenfjDvk03Z2bZ
         jiM8nJvcmkSvxZkA2P9AGQsM5cBrlpHmLuVk62f+cs3hAUqgVEH5L+9tN1zSzrwzVLT9
         cvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701664700; x=1702269500;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVQn0i2hfX92sEXFDpbefnTwnACZ1HnUoqi+/6j93j8=;
        b=q/9VIRm5OIeLqusKmXwoDxXEDp6zjtoesmj6/PjmOYHbC8oLBEMkMSmf3UGiqgD5t4
         XqjL1Zn4pD/vG93x4j1IDMpBWPXLh8GNjssq27V3evZoUWEqHRBsCKlZqCQQpYot0ktO
         arf2JawL1IlDp0N7Eos7YNO0g2bwMEfUUYJ/Bq9kIJY+idpBV+7F/goO3rhMPxtmREeQ
         7wINUbOP8XPKXyHh9/egFFHcQwmvLbvcbc3IRv+mcWf0bgBCKLwP7V4WQeFgHf1WiD48
         ng9aswV9++s9i/pYoX93XqTpI0G7aNpf4JX6TFImG4jzUrHA+X8YXPCsDThdZVhjNXOs
         JYng==
X-Gm-Message-State: AOJu0Yx7Jf04frpSFh+tvKArbn2uZAzlQD5eKRTvl6zSkV6Q52EyZvZZ
        g2YJ1GtKL2eYfvcS9DARuS8DlA==
X-Google-Smtp-Source: AGHT+IELbIovpSTTHbjvjBC+0p6JC2qnWO3TVU8MRU19xKwPNO0iWFc//mgnvGbqB+waFxweUaauQQ==
X-Received: by 2002:a05:6000:12ca:b0:333:2fd2:6f59 with SMTP id l10-20020a05600012ca00b003332fd26f59mr3133348wrx.99.1701664700336;
        Sun, 03 Dec 2023 20:38:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6283000000b0033335cabb9csm6139719wru.28.2023.12.03.20.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 20:38:20 -0800 (PST)
Date:   Mon, 4 Dec 2023 07:38:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_dp.c:237 nouveau_dp_irq() warn:
 variable dereferenced before check 'outp' (see line 232)
Message-ID: <18b847e9-a8ab-455f-a293-a3ac5fba2653@suswa.mountain>
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
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 773eb04d14a11552b2c3953097ed09cde2ab4831 drm/nouveau/disp: expose conn event class
config: i386-randconfig-141-20231105 (https://download.01.org/0day-ci/archive/20231202/202312021916.U9nxtVaD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312021916.U9nxtVaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312021916.U9nxtVaD-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/nouveau/nouveau_dp.c:237 nouveau_dp_irq() warn: variable dereferenced before check 'outp' (see line 232)

vim +/outp +237 drivers/gpu/drm/nouveau/nouveau_dp.c

773eb04d14a115 Ben Skeggs 2022-06-01  225  void
773eb04d14a115 Ben Skeggs 2022-06-01  226  nouveau_dp_irq(struct work_struct *work)
a0922278f83eae Lyude Paul 2020-08-26  227  {
773eb04d14a115 Ben Skeggs 2022-06-01  228  	struct nouveau_connector *nv_connector =
773eb04d14a115 Ben Skeggs 2022-06-01  229  		container_of(work, typeof(*nv_connector), irq_work);
a0922278f83eae Lyude Paul 2020-08-26  230  	struct drm_connector *connector = &nv_connector->base;
a0922278f83eae Lyude Paul 2020-08-26  231  	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
773eb04d14a115 Ben Skeggs 2022-06-01 @232  	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
                                                                                      ^^^^^^
Dereference

a0922278f83eae Lyude Paul 2020-08-26  233  	struct nv50_mstm *mstm;
016dacb60e6d4b Ben Skeggs 2022-06-01  234  	u64 hpd = 0;
a4efad354cf1b9 Lyude Paul 2020-08-26  235  	int ret;
a0922278f83eae Lyude Paul 2020-08-26  236  
a0922278f83eae Lyude Paul 2020-08-26 @237  	if (!outp)
                                                    ^^^^^
Too late.

a0922278f83eae Lyude Paul 2020-08-26  238  		return;
a0922278f83eae Lyude Paul 2020-08-26  239  
a0922278f83eae Lyude Paul 2020-08-26  240  	mstm = outp->dp.mstm;
a0922278f83eae Lyude Paul 2020-08-26  241  	NV_DEBUG(drm, "service %s\n", connector->name);
a0922278f83eae Lyude Paul 2020-08-26  242  
a0922278f83eae Lyude Paul 2020-08-26  243  	mutex_lock(&outp->dp.hpd_irq_lock);
a0922278f83eae Lyude Paul 2020-08-26  244  
a0922278f83eae Lyude Paul 2020-08-26  245  	if (mstm && mstm->is_mst) {
a0922278f83eae Lyude Paul 2020-08-26  246  		if (!nv50_mstm_service(drm, nv_connector, mstm))
773eb04d14a115 Ben Skeggs 2022-06-01  247  			hpd |= NVIF_CONN_EVENT_V0_UNPLUG;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


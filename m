Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92EA7DFEFD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjKCGAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjKCGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:00:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D01B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:00:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so242521066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698991202; x=1699596002; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxDSdMzVCpjHsvR+qZrln4myCmxkfc2LuMbC+pvU/84=;
        b=ZPME3n6RnkaqT4H76e+wnFZhYT1NE0Uueug2maXIyjCp9bU0B8kvLeBD/wVq/GDXcC
         fTPpsnXyEoSrqnKhJPYJBjiuBXbMLW+2rMbt14p8WzI7Mf0IYcYSK10+zzmmE6QRtgTk
         Rxxlh93oaCp1piuWVhrMODwSHLNlH/eG3H7YRQwEhXYa5eIMps6h5HQwDZ+1zEzgf489
         nZJvQA/IhhbpIwRYxevl1RK8j3EY0cSlrMmkFH8CIZ9b7hA7TPCnlzLlcWFF5oP8s8pp
         hSRMWGiFZjW2k7b9n6jXTRhguQx2TKk1T0ssQjhpYK01bQ/S0YU6WqkauMC6gYiRCq+K
         6IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698991202; x=1699596002;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxDSdMzVCpjHsvR+qZrln4myCmxkfc2LuMbC+pvU/84=;
        b=rK9taVxo1XXp2U2Q63lYvyQ67DWQP+ZBCJZ5U54acX43WKZl1JeZZ3mF6Hw1j7zMad
         og823HIoPzpoKU5SCNdQFHWxF2iMPjSFrmCql6XPnTij1F3vyRIL99a3OIrua7796Gki
         62xr9DUJK7epkFFXHH14MuZaPMuI+bpTNrRsCfd+9p1qbZm97s94cUoEfknNGH/E+9CN
         iFLirKysuHK12L9EroQDfiPGKqL3IxPCPv6xbS1/8QFI/sd/u75o5U3lG09zf6CwoAv7
         gTkW4Plndpxrcu1NXauZdm5w5bFIQ0diooybfhnXv6albSaTI//oZZqBbPus9F+3bNVU
         SMOw==
X-Gm-Message-State: AOJu0YypW5YCZ7d1KvdcbKTnnGIxQAlaXqaf6GZGVg4obsxW/sx1o7xu
        KFFr9dUlVIksBYyNCm/JK7Lp/x/WzkJT6lYaIwU=
X-Google-Smtp-Source: AGHT+IETB8T1GhUXYuMPcptvFaualbInBCIx8AiSdFPyi1Gp2XP3C8B1h6EpdqwUNTo2KtbGkxL/uA==
X-Received: by 2002:a17:906:478b:b0:9c7:4e5d:12bc with SMTP id cw11-20020a170906478b00b009c74e5d12bcmr6141917ejc.51.1698991201698;
        Thu, 02 Nov 2023 23:00:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709060c4900b00997c1d125fasm507494ejf.170.2023.11.02.23.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:00:01 -0700 (PDT)
Date:   Fri, 3 Nov 2023 08:59:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/chardev.c:391 bch2_ioctl_fs_usage() warn: check for
 integer overflow 'replica_entries_bytes'
Message-ID: <84d54213-e093-4c6e-a126-4df1253ca73d@kadam.mountain>
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
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: 22502ac23a2eaa3714b77d4a9242df352a9cd0c0 bcachefs: Redo filesystem usage ioctls
config: x86_64-randconfig-161-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030618.5bKFt0YI-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311030618.5bKFt0YI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311030618.5bKFt0YI-lkp@intel.com/

New smatch warnings:
fs/bcachefs/chardev.c:391 bch2_ioctl_fs_usage() warn: check for integer overflow 'replica_entries_bytes'

Old smatch warnings:
fs/bcachefs/chardev.c:444 bch2_ioctl_fs_usage() warn: maybe return -EFAULT instead of the bytes remaining?
fs/bcachefs/chardev.c:524 bch2_ioctl_read_super() warn: maybe return -EFAULT instead of the bytes remaining?

vim +/replica_entries_bytes +391 fs/bcachefs/chardev.c

22502ac23a2eaa Kent Overstreet 2019-12-16  375  static long bch2_ioctl_fs_usage(struct bch_fs *c,
22502ac23a2eaa Kent Overstreet 2019-12-16  376  				struct bch_ioctl_fs_usage __user *user_arg)
1c6fdbd8f2465d Kent Overstreet 2017-03-16  377  {
22502ac23a2eaa Kent Overstreet 2019-12-16  378  	struct bch_ioctl_fs_usage *arg = NULL;
22502ac23a2eaa Kent Overstreet 2019-12-16  379  	struct bch_replicas_usage *dst_e, *dst_end;
22502ac23a2eaa Kent Overstreet 2019-12-16  380  	struct bch_fs_usage_online *src;
22502ac23a2eaa Kent Overstreet 2019-12-16  381  	u32 replica_entries_bytes;
22502ac23a2eaa Kent Overstreet 2019-12-16  382  	unsigned i;
22502ac23a2eaa Kent Overstreet 2019-12-16  383  	int ret = 0;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  384  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  385  	if (!test_bit(BCH_FS_STARTED, &c->flags))
1c6fdbd8f2465d Kent Overstreet 2017-03-16  386  		return -EINVAL;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  387  
22502ac23a2eaa Kent Overstreet 2019-12-16  388  	if (get_user(replica_entries_bytes, &user_arg->replica_entries_bytes))

This comes from the user.

1c6fdbd8f2465d Kent Overstreet 2017-03-16  389  		return -EFAULT;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  390  
22502ac23a2eaa Kent Overstreet 2019-12-16 @391  	arg = kzalloc(sizeof(*arg) + replica_entries_bytes, GFP_KERNEL);

This can lead to an integer overflow on 32 bit systems.

This API is a bit problematice because we don't ensure that sizeof()
bytes is divisible by sizeof(struct bch_replicas_usage).  Use
struct_size() or size_add() to fix the integer overflow.

22502ac23a2eaa Kent Overstreet 2019-12-16  392  	if (!arg)
22502ac23a2eaa Kent Overstreet 2019-12-16  393  		return -ENOMEM;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  394  
22502ac23a2eaa Kent Overstreet 2019-12-16  395  	src = bch2_fs_usage_read(c);
22502ac23a2eaa Kent Overstreet 2019-12-16  396  	if (!src) {
22502ac23a2eaa Kent Overstreet 2019-12-16  397  		ret = -ENOMEM;
22502ac23a2eaa Kent Overstreet 2019-12-16  398  		goto err;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  399  	}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  400  
22502ac23a2eaa Kent Overstreet 2019-12-16  401  	arg->capacity		= c->capacity;
22502ac23a2eaa Kent Overstreet 2019-12-16  402  	arg->used		= bch2_fs_sectors_used(c, src);
22502ac23a2eaa Kent Overstreet 2019-12-16  403  	arg->online_reserved	= src->online_reserved;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


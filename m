Return-Path: <linux-kernel+bounces-32397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E919835B31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4F1B21573
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED7C8FD;
	Mon, 22 Jan 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0ILfza+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AEFBE4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905884; cv=none; b=P/nijY8IMGd6d46pytQ9RclY1MuduLjI/XN2+P8ohpScKMwAJZcp33Ck+tKGWn7yYXJjFxLr2g9Sj05tvHWXRzfQ1nbMZCOA9d9dvJDNMqgDGFQafKsXUxj0mqwx9T5uAjNwN8rQYW3ih45kHW0oeeHdvJEaBh54jr/p9GIQymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905884; c=relaxed/simple;
	bh=rqfbJaTavukHqNcWA/aI44nUtPbzn4mQR4BhbHCOIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SxHhm7MR4omD2ooXE98vbnCdk1T1CM+pKJ4MJjAH4rGfiiEgA9p7N4oBYKY+8JmX5R0ofd2YQlYgnyA55W/I9o3amsRepa+gRgu+2TokHLHXu4AFm/frPS+SMOn3tBifT8HmOUg0SwLI+pY8fBtedevhTK6pvPv1fe8vOpgDBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c0ILfza+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337b8da1f49so2575559f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705905881; x=1706510681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5xHkIHav/DyHDr3s4AUIxAaw4nqa+rIE0HQuqV2AoY=;
        b=c0ILfza+WdYtI2z+yA3gmfN33iNgMy51Tg8ldfYfyj/kk/R2IjPI6+Ne074n32CmZ/
         bppJLA4bT6i0P6nXKrs09WiI/btW0F7ksYTAGNwKzGfPhO7UHB1JyzvW/NdlLgpCJJv7
         TLIa0rTAktgTMgNOZfijw9uCifQPfro4PUe+5KjjWImIEOF57B7bfJ1gedcu5DfF9glH
         JqeBTMp4wuJKWsVjPUf1q990Qm/umK0mDeSLzxXlLT70dR6QfUcyGyEWSbcqTffMgQ5K
         qmf8brnEwi89yJH6W091G6+djGIpHCUeL0ufmumbFT8tOVAfsd61cwh7yOfwgUOrfZJn
         lqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705905881; x=1706510681;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5xHkIHav/DyHDr3s4AUIxAaw4nqa+rIE0HQuqV2AoY=;
        b=N0DVDNO2MgC4UcW4JPX9JRfUKZy06q3inFGIW3E8E287oLMeID11zolVTB00i4tlOA
         4t/GFvMHd4Rh+4yEEGeNTAAdAb2Npamf9EcgvI6BuZg6iN7gFvqHPcSx5329OMf4U92B
         teMY+PiGPXJiQ7+Y7nZRKeOaUKkqUuaPDoPhlb53iQoT7CriKzpTdOk5SJrgI/Rjea5K
         4N4/LiLsrcJJ+7VARFC6oHl3FN0vWWa1bdAADypny8kncBI0vrBT7ffY6k58EJZfE84j
         lfq80jYL+9gIG0j+YgTWXkutmYK4GQYA3lpAJ13SJR/EbFpSGvmHrF+NrOAWj8vDfWdA
         1vxw==
X-Gm-Message-State: AOJu0YxxXra+8w4ypMkyQcOj+m9b3Ya0p2uLp4JKyKwDgFzMbaeg15Ht
	EyFeSiylhdopbtLQjGBBkzEDHC4nyOBKPCHPycjMnMKKZKfFdxdIztXqEPvjA+U=
X-Google-Smtp-Source: AGHT+IG67cw43mThfXEsC9o9+iXpXAmakGy90SkFFf1P6ebKwfwMmhLzILumIpwFFYr7EL1DHjc5bA==
X-Received: by 2002:a05:6000:18a2:b0:339:3814:c7ce with SMTP id b2-20020a05600018a200b003393814c7cemr334880wri.178.1705905880957;
        Sun, 21 Jan 2024 22:44:40 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b003377680c55bsm8302984wrj.16.2024.01.21.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:44:40 -0800 (PST)
Date: Mon, 22 Jan 2024 09:44:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Wenjie Qi <qwjhust@gmail.com>,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: Re: [PATCH v2] f2fs: fix zoned block device information
 initialization
Message-ID: <397e7ad5-5c49-474a-b32e-ac1d24289862@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116140513.1222-1-qwjhust@gmail.com>

Hi Wenjie,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenjie-Qi/f2fs-fix-zoned-block-device-information-initialization/20240116-220824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20240116140513.1222-1-qwjhust%40gmail.com
patch subject: [PATCH v2] f2fs: fix zoned block device information initialization
config: x86_64-randconfig-161-20240119 (https://download.01.org/0day-ci/archive/20240120/202401201237.ovVyEKvs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401201237.ovVyEKvs-lkp@intel.com/

New smatch warnings:
fs/f2fs/super.c:2393 f2fs_remount() warn: missing error code 'err'

Old smatch warnings:
fs/f2fs/super.c:4040 read_raw_super_block() warn: possible memory leak of 'super'

vim +/err +2393 fs/f2fs/super.c

4b2414d04e9912 Chao Yu        2017-08-08  2371  
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2372  	/* recover superblocks we couldn't write due to previous RO mount */
1751e8a6cb935e Linus Torvalds 2017-11-27  2373  	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2374  		err = f2fs_commit_super(sbi, false);
dcbb4c10e6d969 Joe Perches    2019-06-18  2375  		f2fs_info(sbi, "Try to recover all the superblocks, ret: %d",
dcbb4c10e6d969 Joe Perches    2019-06-18  2376  			  err);
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2377  		if (!err)
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2378  			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2379  	}
df728b0f6954c3 Jaegeuk Kim    2016-03-23  2380  
458c15dfbce62c Chao Yu        2023-05-23  2381  	default_options(sbi, true);
26666c8a4366de Chao Yu        2014-09-15  2382  
696c018c7718f5 Namjae Jeon    2013-06-16  2383  	/* parse mount options */
ed318a6cc0b620 Eric Biggers   2020-05-12  2384  	err = parse_options(sb, data, true);
696c018c7718f5 Namjae Jeon    2013-06-16  2385  	if (err)
696c018c7718f5 Namjae Jeon    2013-06-16  2386  		goto restore_opts;
696c018c7718f5 Namjae Jeon    2013-06-16  2387  
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2388  #ifdef CONFIG_BLK_DEV_ZONED
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2389  	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2390  		f2fs_err(sbi,
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2391  			"zoned: max active zones %u is too small, need at least %u active zones",
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2392  				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
ed7a1efe8afd55 Wenjie Qi      2024-01-16 @2393  		goto restore_opts;

err = -EINVAL?

ed7a1efe8afd55 Wenjie Qi      2024-01-16  2394  	}
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2395  #endif
ed7a1efe8afd55 Wenjie Qi      2024-01-16  2396  
b62e71be2110d8 Chao Yu        2023-04-23  2397  	/* flush outstanding errors before changing fs state */
b62e71be2110d8 Chao Yu        2023-04-23  2398  	flush_work(&sbi->s_error_work);
b62e71be2110d8 Chao Yu        2023-04-23  2399  
696c018c7718f5 Namjae Jeon    2013-06-16  2400  	/*
696c018c7718f5 Namjae Jeon    2013-06-16  2401  	 * Previous and new state of filesystem is RO,
876dc59eb1f013 Gu Zheng       2014-04-11  2402  	 * so skip checking GC and FLUSH_MERGE conditions.
696c018c7718f5 Namjae Jeon    2013-06-16  2403  	 */
1751e8a6cb935e Linus Torvalds 2017-11-27  2404  	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
696c018c7718f5 Namjae Jeon    2013-06-16  2405  		goto skip;
696c018c7718f5 Namjae Jeon    2013-06-16  2406  
d78dfefcde9d31 Chao Yu        2023-04-04  2407  	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
a7d9fe3c338870 Jaegeuk Kim    2021-05-21  2408  		err = -EROFS;
a7d9fe3c338870 Jaegeuk Kim    2021-05-21  2409  		goto restore_opts;
a7d9fe3c338870 Jaegeuk Kim    2021-05-21  2410  	}
a7d9fe3c338870 Jaegeuk Kim    2021-05-21  2411  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



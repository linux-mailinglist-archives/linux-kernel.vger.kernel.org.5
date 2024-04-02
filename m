Return-Path: <linux-kernel+bounces-128125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1D895679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E76628434C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EE86622;
	Tue,  2 Apr 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMpwN3Fa"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5AF8615F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067530; cv=none; b=HXSmxgwevXsktmFtwnN1Wkfyq76jWh/Jdv5XuUFtbuGmFbAzsf8ZJ/UWIjM0WBOV7Eu1ni+tysEFAlRkQ7H94C2NfQwH51NBsn/7eBWEaGZ7aEeR+8WSPC9Oqq0TIRiiiV3joGh/wJeyZKR6Yj2QyxhAIH+NEH1Jth+b2Qb3r7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067530; c=relaxed/simple;
	bh=wiDHT8TMADMr0k5sMytKbIcCoIAcT6po0ivZBwAYIQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b3JvZYZISxOpK11jLuJdRKRi2t6KFIgqb8SPwpLlal8PDnIadqaXhdn1ek47+ODPGVD1FnvvPFVwu9tfEf9coTD24WNsiRAYyjtufhUmpv3iqxN+qIKbkxcDriO9Br5U7zY1G3PsTCjXYAuwn0f1k3CWaVQZtfp9NngjXXAeEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMpwN3Fa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso694027166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712067527; x=1712672327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHqwqOqMwuq0heOz6Rq6ltrV9J/l+osW6nWJpwlL8Gc=;
        b=IMpwN3FaqrZIaf9x1362TSOeAuVikEbih1P3u9e8aAzpRKZ5w/K2OgljcDRM8A1UD2
         Fpnbz/BjKz0ubgSaX1dCLDUSbT4PHovg+RrNwXSaYj3SjU3EdrEXV0xDN2hebOrpvXZg
         EDxeLL7Iq4TtOwFWlssyEEZPS9Z1Vn4KABu/0El5RdNCj4D3tx7SmbkxQ+3kPk7rrZrz
         B6pncl1xv2eXHBkaoLOvMxmSazbVcYuBa6vT+7k7iTrcE8qUjagyFL5u623ZigipCWWr
         y2JV8fbb0kKJOhPyKI8s9YZeha9XPHtqXKNPp1SQIB5f1wzr72NB0iaSYpt6TKSc+UKD
         ujsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067527; x=1712672327;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHqwqOqMwuq0heOz6Rq6ltrV9J/l+osW6nWJpwlL8Gc=;
        b=VanqBNl/S6DCD33oOnruVwxfh9RenO8POrx3VH8hWvaUdaHcHi7uXCHJJY6e2OQae0
         OaubOve/bzD4Wd2zDrNfRCxS0n/vwcokLw7c2sGUk08v6rzGGjCLLth4I+6l+JrS22Sg
         f6e6ZEzGs08TvQn+aNmfqxt0l8a+ie/eeBSRjDfSwvuJEotnD+bzYrG9UcYPLJobySlm
         kjWZ6J+YkjfqX7NkEmBr3Zv9ZxymL7jHiuwWKzchX8Dlo3iH90vfrdtHiQ9zOy6WDDWU
         Q9Yg6oH8I8rEnQmR8dnCjEo34zVZOIl9sweG1xlP4gPA4ly4YBFQXHxO2z8qiGO1s5sh
         qxiw==
X-Forwarded-Encrypted: i=1; AJvYcCUw7ngrkfuoDJFKbwL+iflyyUsBTPnZp+FRLeXsY90o2/oSfEAYIns4Ed8a/E4jkNEfBREYo8hvFNJ03j0QbQIokV3c9lOtar83CNUM
X-Gm-Message-State: AOJu0Yw8MiG9nCUik71UlYgMruh1iDhjlLzHHG/LaeAimm5+Pt95XTwF
	KTjmWmYgB4oePryG7QJ7Vmttyhya2ZfIArqV0MrcV2L33Lm18nA3D3MSBIlmKok=
X-Google-Smtp-Source: AGHT+IE6fvPRYka4VhAIMmpKaSaPP2sgJ0pcc7VRcf6Znppd4NfZ4EpKbo1VQD32oqm2sznJPh7tFA==
X-Received: by 2002:a17:906:b28c:b0:a4e:83bf:e1bb with SMTP id q12-20020a170906b28c00b00a4e83bfe1bbmr1664183ejz.1.1712067526302;
        Tue, 02 Apr 2024 07:18:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dc13-20020a170906c7cd00b00a4655513f0bsm6559279ejb.88.2024.04.02.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:18:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:15:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, tada keisuke <keisuke1.tada@kioxia.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/11] md: avoid conflicts in active_aligned_reads
 operations
Message-ID: <a35d6b54-8e63-4b0b-be18-bb5ab7d12bdf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb112e756514a0eaab891379df0d834@kioxia.com>

Hi tada,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/tada-keisuke/md-add-infra-for-active_aligned_reads-changes/20240326-201827
base:   fcf3f7e2fc8a53a6140beee46ec782a4c88e4744
patch link:    https://lore.kernel.org/r/ffb112e756514a0eaab891379df0d834%40kioxia.com
patch subject: [PATCH 06/11] md: avoid conflicts in active_aligned_reads operations
config: i386-randconfig-141-20240328 (https://download.01.org/0day-ci/archive/20240331/202403312116.Sh5vFCWf-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202403312116.Sh5vFCWf-lkp@intel.com/

New smatch warnings:
drivers/md/raid5.c:7680 setup_conf() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +7680 drivers/md/raid5.c

39eda94c2b8f91 tada keisuke       2024-03-26  7414  static struct r5conf *setup_conf(struct mddev *mddev, bool quiesce)
^1da177e4c3f41 Linus Torvalds     2005-04-16  7415  {
d1688a6d5515f1 NeilBrown          2011-10-11  7416  	struct r5conf *conf;
5e5e3e78ed9038 NeilBrown          2009-10-16  7417  	int raid_disk, memory, max_disks;
3cb03002000f13 NeilBrown          2011-10-11  7418  	struct md_rdev *rdev;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7419  	struct disk_info *disk;
0232605d987d82 NeilBrown          2012-07-03  7420  	char pers_name[6];
566c09c53455d7 Shaohua Li         2013-11-14  7421  	int i;
d2c9ad41249ac8 Guoqing Jiang      2019-12-20  7422  	int group_cnt;
60aaf933854511 majianpeng         2013-11-14  7423  	struct r5worker_group *new_group;
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7424  	int ret = -ENOMEM;
39eda94c2b8f91 tada keisuke       2024-03-26  7425  	unsigned int percpu_ref_init_flags;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7426  
91adb56473febe NeilBrown          2009-03-31  7427  	if (mddev->new_level != 5
91adb56473febe NeilBrown          2009-03-31  7428  	    && mddev->new_level != 4
91adb56473febe NeilBrown          2009-03-31  7429  	    && mddev->new_level != 6) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7430  		pr_warn("md/raid:%s: raid level not set to 4/5/6 (%d)\n",
91adb56473febe NeilBrown          2009-03-31  7431  			mdname(mddev), mddev->new_level);
91adb56473febe NeilBrown          2009-03-31  7432  		return ERR_PTR(-EIO);
^1da177e4c3f41 Linus Torvalds     2005-04-16  7433  	}
91adb56473febe NeilBrown          2009-03-31  7434  	if ((mddev->new_level == 5
91adb56473febe NeilBrown          2009-03-31  7435  	     && !algorithm_valid_raid5(mddev->new_layout)) ||
91adb56473febe NeilBrown          2009-03-31  7436  	    (mddev->new_level == 6
91adb56473febe NeilBrown          2009-03-31  7437  	     && !algorithm_valid_raid6(mddev->new_layout))) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7438  		pr_warn("md/raid:%s: layout %d not supported\n",
91adb56473febe NeilBrown          2009-03-31  7439  			mdname(mddev), mddev->new_layout);
91adb56473febe NeilBrown          2009-03-31  7440  		return ERR_PTR(-EIO);
99c0fb5f92828a NeilBrown          2009-03-31  7441  	}
91adb56473febe NeilBrown          2009-03-31  7442  	if (mddev->new_level == 6 && mddev->raid_disks < 4) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7443  		pr_warn("md/raid:%s: not enough configured devices (%d, minimum 4)\n",
91adb56473febe NeilBrown          2009-03-31  7444  			mdname(mddev), mddev->raid_disks);
91adb56473febe NeilBrown          2009-03-31  7445  		return ERR_PTR(-EINVAL);
4bbf3771ca40d0 NeilBrown          2008-10-13  7446  	}
4bbf3771ca40d0 NeilBrown          2008-10-13  7447  
664e7c413f1e90 Andre Noll         2009-06-18  7448  	if (!mddev->new_chunk_sectors ||
664e7c413f1e90 Andre Noll         2009-06-18  7449  	    (mddev->new_chunk_sectors << 9) % PAGE_SIZE ||
664e7c413f1e90 Andre Noll         2009-06-18  7450  	    !is_power_of_2(mddev->new_chunk_sectors)) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7451  		pr_warn("md/raid:%s: invalid chunk size %d\n",
0c55e02259115c NeilBrown          2010-05-03  7452  			mdname(mddev), mddev->new_chunk_sectors << 9);
91adb56473febe NeilBrown          2009-03-31  7453  		return ERR_PTR(-EINVAL);
f67055780caac6 NeilBrown          2006-03-27  7454  	}
f67055780caac6 NeilBrown          2006-03-27  7455  
d1688a6d5515f1 NeilBrown          2011-10-11  7456  	conf = kzalloc(sizeof(struct r5conf), GFP_KERNEL);
91adb56473febe NeilBrown          2009-03-31  7457  	if (conf == NULL)
^1da177e4c3f41 Linus Torvalds     2005-04-16  7458  		goto abort;
c911c46c017c74 Yufen Yu           2020-07-18  7459  
e236858243d7a8 Yufen Yu           2020-07-18  7460  #if PAGE_SIZE != DEFAULT_STRIPE_SIZE
e236858243d7a8 Yufen Yu           2020-07-18  7461  	conf->stripe_size = DEFAULT_STRIPE_SIZE;
e236858243d7a8 Yufen Yu           2020-07-18  7462  	conf->stripe_shift = ilog2(DEFAULT_STRIPE_SIZE) - 9;
e236858243d7a8 Yufen Yu           2020-07-18  7463  	conf->stripe_sectors = DEFAULT_STRIPE_SIZE >> 9;
e236858243d7a8 Yufen Yu           2020-07-18  7464  #endif
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7465  	INIT_LIST_HEAD(&conf->free_list);
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7466  	INIT_LIST_HEAD(&conf->pending_list);
6396bb221514d2 Kees Cook          2018-06-12  7467  	conf->pending_data = kcalloc(PENDING_IO_MAX,
6396bb221514d2 Kees Cook          2018-06-12  7468  				     sizeof(struct r5pending_data),
6396bb221514d2 Kees Cook          2018-06-12  7469  				     GFP_KERNEL);
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7470  	if (!conf->pending_data)
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7471  		goto abort;
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7472  	for (i = 0; i < PENDING_IO_MAX; i++)
aaf9f12ebfafd1 Shaohua Li         2017-03-03  7473  		list_add(&conf->pending_data[i].sibling, &conf->free_list);
851c30c9badfc6 Shaohua Li         2013-08-28  7474  	/* Don't enable multi-threading by default*/
d2c9ad41249ac8 Guoqing Jiang      2019-12-20  7475  	if (!alloc_thread_groups(conf, 0, &group_cnt, &new_group)) {
60aaf933854511 majianpeng         2013-11-14  7476  		conf->group_cnt = group_cnt;
d2c9ad41249ac8 Guoqing Jiang      2019-12-20  7477  		conf->worker_cnt_per_group = 0;
60aaf933854511 majianpeng         2013-11-14  7478  		conf->worker_groups = new_group;
60aaf933854511 majianpeng         2013-11-14  7479  	} else
851c30c9badfc6 Shaohua Li         2013-08-28  7480  		goto abort;
f5efd45ae597c9 Dan Williams       2009-10-16  7481  	spin_lock_init(&conf->device_lock);
0a87b25ff2eb61 Ahmed S. Darwish   2020-07-20  7482  	seqcount_spinlock_init(&conf->gen_lock, &conf->device_lock);
2d5b569b665ea6 NeilBrown          2015-07-06  7483  	mutex_init(&conf->cache_size_mutex);
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7484  
b1b4648648e187 Yuanhan Liu        2015-05-08  7485  	init_waitqueue_head(&conf->wait_for_quiescent);
6ab2a4b806ae21 Shaohua Li         2016-02-25  7486  	init_waitqueue_head(&conf->wait_for_stripe);
f5efd45ae597c9 Dan Williams       2009-10-16  7487  	init_waitqueue_head(&conf->wait_for_overlap);
f5efd45ae597c9 Dan Williams       2009-10-16  7488  	INIT_LIST_HEAD(&conf->handle_list);
535ae4eb1225f1 Shaohua Li         2017-02-15  7489  	INIT_LIST_HEAD(&conf->loprio_list);
f5efd45ae597c9 Dan Williams       2009-10-16  7490  	INIT_LIST_HEAD(&conf->hold_list);
f5efd45ae597c9 Dan Williams       2009-10-16  7491  	INIT_LIST_HEAD(&conf->delayed_list);
f5efd45ae597c9 Dan Williams       2009-10-16  7492  	INIT_LIST_HEAD(&conf->bitmap_list);
773ca82fa1ee58 Shaohua Li         2013-08-27  7493  	init_llist_head(&conf->released_stripes);
f5efd45ae597c9 Dan Williams       2009-10-16  7494  	atomic_set(&conf->active_stripes, 0);
f5efd45ae597c9 Dan Williams       2009-10-16  7495  	atomic_set(&conf->preread_active_stripes, 0);
39eda94c2b8f91 tada keisuke       2024-03-26  7496  	if (quiesce)
39eda94c2b8f91 tada keisuke       2024-03-26  7497  		percpu_ref_init_flags = PERCPU_REF_ALLOW_REINIT | PERCPU_REF_INIT_DEAD;
39eda94c2b8f91 tada keisuke       2024-03-26  7498  	else
39eda94c2b8f91 tada keisuke       2024-03-26  7499  		percpu_ref_init_flags = PERCPU_REF_ALLOW_REINIT;
d5f345aef75231 tada keisuke       2024-03-26  7500  	ret = percpu_ref_init(&conf->active_aligned_reads, percpu_wakeup_handle_req_active,
d5f345aef75231 tada keisuke       2024-03-26  7501  		percpu_ref_init_flags, GFP_KERNEL);
d5f345aef75231 tada keisuke       2024-03-26  7502  	if (ret)
                                                        ^^^^^^^^
"ret" set here now.

d5f345aef75231 tada keisuke       2024-03-26  7503  		goto abort;
765d704db1f583 Shaohua Li         2017-01-04  7504  	spin_lock_init(&conf->pending_bios_lock);
765d704db1f583 Shaohua Li         2017-01-04  7505  	conf->batch_bio_dispatch = true;
765d704db1f583 Shaohua Li         2017-01-04  7506  	rdev_for_each(rdev, mddev) {
765d704db1f583 Shaohua Li         2017-01-04  7507  		if (test_bit(Journal, &rdev->flags))
765d704db1f583 Shaohua Li         2017-01-04  7508  			continue;
10f0d2a517796b Christoph Hellwig  2022-04-15  7509  		if (bdev_nonrot(rdev->bdev)) {
765d704db1f583 Shaohua Li         2017-01-04  7510  			conf->batch_bio_dispatch = false;
765d704db1f583 Shaohua Li         2017-01-04  7511  			break;
765d704db1f583 Shaohua Li         2017-01-04  7512  		}
765d704db1f583 Shaohua Li         2017-01-04  7513  	}
765d704db1f583 Shaohua Li         2017-01-04  7514  
f5efd45ae597c9 Dan Williams       2009-10-16  7515  	conf->bypass_threshold = BYPASS_THRESHOLD;
d890fa2b0586b6 NeilBrown          2011-10-26  7516  	conf->recovery_disabled = mddev->recovery_disabled - 1;
91adb56473febe NeilBrown          2009-03-31  7517  
f67055780caac6 NeilBrown          2006-03-27  7518  	conf->raid_disks = mddev->raid_disks;
91adb56473febe NeilBrown          2009-03-31  7519  	if (mddev->reshape_position == MaxSector)
91adb56473febe NeilBrown          2009-03-31  7520  		conf->previous_raid_disks = mddev->raid_disks;
91adb56473febe NeilBrown          2009-03-31  7521  	else
f67055780caac6 NeilBrown          2006-03-27  7522  		conf->previous_raid_disks = mddev->raid_disks - mddev->delta_disks;
5e5e3e78ed9038 NeilBrown          2009-10-16  7523  	max_disks = max(conf->raid_disks, conf->previous_raid_disks);
f67055780caac6 NeilBrown          2006-03-27  7524  
6396bb221514d2 Kees Cook          2018-06-12  7525  	conf->disks = kcalloc(max_disks, sizeof(struct disk_info),
b55e6bfcd23cb2 NeilBrown          2006-03-27  7526  			      GFP_KERNEL);
d7bd398e97f236 Song Liu           2016-11-23  7527  
b55e6bfcd23cb2 NeilBrown          2006-03-27  7528  	if (!conf->disks)
b55e6bfcd23cb2 NeilBrown          2006-03-27  7529  		goto abort;

Missing error code.

9ffae0cf3ea02f NeilBrown          2006-01-06  7530  
d7bd398e97f236 Song Liu           2016-11-23  7531  	for (i = 0; i < max_disks; i++) {
d7bd398e97f236 Song Liu           2016-11-23  7532  		conf->disks[i].extra_page = alloc_page(GFP_KERNEL);
d7bd398e97f236 Song Liu           2016-11-23  7533  		if (!conf->disks[i].extra_page)
d7bd398e97f236 Song Liu           2016-11-23  7534  			goto abort;
d7bd398e97f236 Song Liu           2016-11-23  7535  	}
d7bd398e97f236 Song Liu           2016-11-23  7536  
afeee514ce7f4c Kent Overstreet    2018-05-20  7537  	ret = bioset_init(&conf->bio_split, BIO_POOL_SIZE, 0, 0);
afeee514ce7f4c Kent Overstreet    2018-05-20  7538  	if (ret)
dd7a8f5dee81ff NeilBrown          2017-04-05  7539  		goto abort;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7540  	conf->mddev = mddev;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7541  
5f7ef4875f9953 Dan Carpenter      2022-07-19  7542  	ret = -ENOMEM;
5f7ef4875f9953 Dan Carpenter      2022-07-19  7543  	conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL);
5f7ef4875f9953 Dan Carpenter      2022-07-19  7544  	if (!conf->stripe_hashtbl)
^1da177e4c3f41 Linus Torvalds     2005-04-16  7545  		goto abort;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7546  
566c09c53455d7 Shaohua Li         2013-11-14  7547  	/* We init hash_locks[0] separately to that it can be used
566c09c53455d7 Shaohua Li         2013-11-14  7548  	 * as the reference lock in the spin_lock_nest_lock() call
566c09c53455d7 Shaohua Li         2013-11-14  7549  	 * in lock_all_device_hash_locks_irq in order to convince
566c09c53455d7 Shaohua Li         2013-11-14  7550  	 * lockdep that we know what we are doing.
566c09c53455d7 Shaohua Li         2013-11-14  7551  	 */
566c09c53455d7 Shaohua Li         2013-11-14  7552  	spin_lock_init(conf->hash_locks);
566c09c53455d7 Shaohua Li         2013-11-14  7553  	for (i = 1; i < NR_STRIPE_HASH_LOCKS; i++)
566c09c53455d7 Shaohua Li         2013-11-14  7554  		spin_lock_init(conf->hash_locks + i);
566c09c53455d7 Shaohua Li         2013-11-14  7555  
566c09c53455d7 Shaohua Li         2013-11-14  7556  	for (i = 0; i < NR_STRIPE_HASH_LOCKS; i++)
566c09c53455d7 Shaohua Li         2013-11-14  7557  		INIT_LIST_HEAD(conf->inactive_list + i);
566c09c53455d7 Shaohua Li         2013-11-14  7558  
566c09c53455d7 Shaohua Li         2013-11-14  7559  	for (i = 0; i < NR_STRIPE_HASH_LOCKS; i++)
566c09c53455d7 Shaohua Li         2013-11-14  7560  		INIT_LIST_HEAD(conf->temp_inactive_list + i);
566c09c53455d7 Shaohua Li         2013-11-14  7561  
1e6d690b9334b7 Song Liu           2016-11-17  7562  	atomic_set(&conf->r5c_cached_full_stripes, 0);
1e6d690b9334b7 Song Liu           2016-11-17  7563  	INIT_LIST_HEAD(&conf->r5c_full_stripe_list);
1e6d690b9334b7 Song Liu           2016-11-17  7564  	atomic_set(&conf->r5c_cached_partial_stripes, 0);
1e6d690b9334b7 Song Liu           2016-11-17  7565  	INIT_LIST_HEAD(&conf->r5c_partial_stripe_list);
e33fbb9cc73d65 Shaohua Li         2017-02-10  7566  	atomic_set(&conf->r5c_flushing_full_stripes, 0);
e33fbb9cc73d65 Shaohua Li         2017-02-10  7567  	atomic_set(&conf->r5c_flushing_partial_stripes, 0);
1e6d690b9334b7 Song Liu           2016-11-17  7568  
36d1c6476be511 Dan Williams       2009-07-14  7569  	conf->level = mddev->new_level;
46d5b785621ad1 shli@kernel.org    2014-12-15  7570  	conf->chunk_sectors = mddev->new_chunk_sectors;
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7571  	ret = raid5_alloc_percpu(conf);
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7572  	if (ret)
16a53ecc35f2a8 NeilBrown          2006-06-26  7573  		goto abort;
36d1c6476be511 Dan Williams       2009-07-14  7574  
0c55e02259115c NeilBrown          2010-05-03  7575  	pr_debug("raid456: run(%s) called.\n", mdname(mddev));
^1da177e4c3f41 Linus Torvalds     2005-04-16  7576  
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7577  	ret = -EIO;
dafb20fa34320a NeilBrown          2012-03-19  7578  	rdev_for_each(rdev, mddev) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  7579  		raid_disk = rdev->raid_disk;
5e5e3e78ed9038 NeilBrown          2009-10-16  7580  		if (raid_disk >= max_disks
f2076e7d0643d1 Shaohua Li         2015-10-08  7581  		    || raid_disk < 0 || test_bit(Journal, &rdev->flags))
^1da177e4c3f41 Linus Torvalds     2005-04-16  7582  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7583  		disk = conf->disks + raid_disk;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7584  
17045f52ac76d9 NeilBrown          2011-12-23  7585  		if (test_bit(Replacement, &rdev->flags)) {
17045f52ac76d9 NeilBrown          2011-12-23  7586  			if (disk->replacement)
17045f52ac76d9 NeilBrown          2011-12-23  7587  				goto abort;
b0920ede081b3f Logan Gunthorpe    2022-04-07  7588  			RCU_INIT_POINTER(disk->replacement, rdev);
17045f52ac76d9 NeilBrown          2011-12-23  7589  		} else {
17045f52ac76d9 NeilBrown          2011-12-23  7590  			if (disk->rdev)
17045f52ac76d9 NeilBrown          2011-12-23  7591  				goto abort;
b0920ede081b3f Logan Gunthorpe    2022-04-07  7592  			RCU_INIT_POINTER(disk->rdev, rdev);
17045f52ac76d9 NeilBrown          2011-12-23  7593  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  7594  
b2d444d7ad975d NeilBrown          2005-11-08  7595  		if (test_bit(In_sync, &rdev->flags)) {
913cce5a1e588e Christoph Hellwig  2022-05-12  7596  			pr_info("md/raid:%s: device %pg operational as raid disk %d\n",
913cce5a1e588e Christoph Hellwig  2022-05-12  7597  				mdname(mddev), rdev->bdev, raid_disk);
d6b212f4b19da5 Jonathan Brassow   2011-06-08  7598  		} else if (rdev->saved_raid_disk != raid_disk)
8c2e870a625bd3 Neil Brown         2008-06-28  7599  			/* Cannot rely on bitmap to complete recovery */
8c2e870a625bd3 Neil Brown         2008-06-28  7600  			conf->fullsync = 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  7601  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  7602  
91adb56473febe NeilBrown          2009-03-31  7603  	conf->level = mddev->new_level;
584acdd49cd247 Markus Stockhausen 2014-12-15  7604  	if (conf->level == 6) {
16a53ecc35f2a8 NeilBrown          2006-06-26  7605  		conf->max_degraded = 2;
584acdd49cd247 Markus Stockhausen 2014-12-15  7606  		if (raid6_call.xor_syndrome)
584acdd49cd247 Markus Stockhausen 2014-12-15  7607  			conf->rmw_level = PARITY_ENABLE_RMW;
16a53ecc35f2a8 NeilBrown          2006-06-26  7608  		else
584acdd49cd247 Markus Stockhausen 2014-12-15  7609  			conf->rmw_level = PARITY_DISABLE_RMW;
584acdd49cd247 Markus Stockhausen 2014-12-15  7610  	} else {
16a53ecc35f2a8 NeilBrown          2006-06-26  7611  		conf->max_degraded = 1;
584acdd49cd247 Markus Stockhausen 2014-12-15  7612  		conf->rmw_level = PARITY_ENABLE_RMW;
584acdd49cd247 Markus Stockhausen 2014-12-15  7613  	}
91adb56473febe NeilBrown          2009-03-31  7614  	conf->algorithm = mddev->new_layout;
fef9c61fdfabf9 NeilBrown          2009-03-31  7615  	conf->reshape_progress = mddev->reshape_position;
e183eaedd53807 NeilBrown          2009-03-31  7616  	if (conf->reshape_progress != MaxSector) {
09c9e5fa1b93ad Andre Noll         2009-06-18  7617  		conf->prev_chunk_sectors = mddev->chunk_sectors;
e183eaedd53807 NeilBrown          2009-03-31  7618  		conf->prev_algo = mddev->layout;
5cac6bcb9312a1 NeilBrown          2015-07-17  7619  	} else {
5cac6bcb9312a1 NeilBrown          2015-07-17  7620  		conf->prev_chunk_sectors = conf->chunk_sectors;
5cac6bcb9312a1 NeilBrown          2015-07-17  7621  		conf->prev_algo = conf->algorithm;
e183eaedd53807 NeilBrown          2009-03-31  7622  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  7623  
edbe83ab4c27ea NeilBrown          2015-02-26  7624  	conf->min_nr_stripes = NR_STRIPES;
ad5b0f7685dbfc Shaohua Li         2016-08-30  7625  	if (mddev->reshape_position != MaxSector) {
ad5b0f7685dbfc Shaohua Li         2016-08-30  7626  		int stripes = max_t(int,
c911c46c017c74 Yufen Yu           2020-07-18  7627  			((mddev->chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4,
c911c46c017c74 Yufen Yu           2020-07-18  7628  			((mddev->new_chunk_sectors << 9) / RAID5_STRIPE_SIZE(conf)) * 4);
ad5b0f7685dbfc Shaohua Li         2016-08-30  7629  		conf->min_nr_stripes = max(NR_STRIPES, stripes);
ad5b0f7685dbfc Shaohua Li         2016-08-30  7630  		if (conf->min_nr_stripes != NR_STRIPES)
cc6167b4f3b3ca NeilBrown          2016-11-02  7631  			pr_info("md/raid:%s: force stripe size %d for reshape\n",
ad5b0f7685dbfc Shaohua Li         2016-08-30  7632  				mdname(mddev), conf->min_nr_stripes);
ad5b0f7685dbfc Shaohua Li         2016-08-30  7633  	}
edbe83ab4c27ea NeilBrown          2015-02-26  7634  	memory = conf->min_nr_stripes * (sizeof(struct stripe_head) +
5e5e3e78ed9038 NeilBrown          2009-10-16  7635  		 max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;
4bda556aea1d29 Shaohua Li         2013-11-14  7636  	atomic_set(&conf->empty_inactive_list_nr, NR_STRIPE_HASH_LOCKS);
edbe83ab4c27ea NeilBrown          2015-02-26  7637  	if (grow_stripes(conf, conf->min_nr_stripes)) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7638  		pr_warn("md/raid:%s: couldn't allocate %dkB for buffers\n",
0c55e02259115c NeilBrown          2010-05-03  7639  			mdname(mddev), memory);
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7640  		ret = -ENOMEM;
91adb56473febe NeilBrown          2009-03-31  7641  		goto abort;
91adb56473febe NeilBrown          2009-03-31  7642  	} else
cc6167b4f3b3ca NeilBrown          2016-11-02  7643  		pr_debug("md/raid:%s: allocated %dkB\n", mdname(mddev), memory);
edbe83ab4c27ea NeilBrown          2015-02-26  7644  	/*
edbe83ab4c27ea NeilBrown          2015-02-26  7645  	 * Losing a stripe head costs more than the time to refill it,
edbe83ab4c27ea NeilBrown          2015-02-26  7646  	 * it reduces the queue depth and so can hurt throughput.
edbe83ab4c27ea NeilBrown          2015-02-26  7647  	 * So set it rather large, scaled by number of devices.
edbe83ab4c27ea NeilBrown          2015-02-26  7648  	 */
86298d8b8ceacc Qi Zheng           2023-09-11  7649  	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
86298d8b8ceacc Qi Zheng           2023-09-11  7650  	if (!conf->shrinker) {
86298d8b8ceacc Qi Zheng           2023-09-11  7651  		ret = -ENOMEM;
86298d8b8ceacc Qi Zheng           2023-09-11  7652  		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
6a0f53ff351dfd Chao Yu            2016-09-20  7653  			mdname(mddev));
6a0f53ff351dfd Chao Yu            2016-09-20  7654  		goto abort;
6a0f53ff351dfd Chao Yu            2016-09-20  7655  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  7656  
86298d8b8ceacc Qi Zheng           2023-09-11  7657  	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
86298d8b8ceacc Qi Zheng           2023-09-11  7658  	conf->shrinker->scan_objects = raid5_cache_scan;
86298d8b8ceacc Qi Zheng           2023-09-11  7659  	conf->shrinker->count_objects = raid5_cache_count;
86298d8b8ceacc Qi Zheng           2023-09-11  7660  	conf->shrinker->batch = 128;
86298d8b8ceacc Qi Zheng           2023-09-11  7661  	conf->shrinker->private_data = conf;
86298d8b8ceacc Qi Zheng           2023-09-11  7662  
86298d8b8ceacc Qi Zheng           2023-09-11  7663  	shrinker_register(conf->shrinker);
86298d8b8ceacc Qi Zheng           2023-09-11  7664  
0232605d987d82 NeilBrown          2012-07-03  7665  	sprintf(pers_name, "raid%d", mddev->new_level);
44693154398272 Yu Kuai            2023-05-23  7666  	rcu_assign_pointer(conf->thread,
44693154398272 Yu Kuai            2023-05-23  7667  			   md_register_thread(raid5d, mddev, pers_name));
91adb56473febe NeilBrown          2009-03-31  7668  	if (!conf->thread) {
cc6167b4f3b3ca NeilBrown          2016-11-02  7669  		pr_warn("md/raid:%s: couldn't allocate thread.\n",
91adb56473febe NeilBrown          2009-03-31  7670  			mdname(mddev));
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7671  		ret = -ENOMEM;
16a53ecc35f2a8 NeilBrown          2006-06-26  7672  		goto abort;
16a53ecc35f2a8 NeilBrown          2006-06-26  7673  	}
91adb56473febe NeilBrown          2009-03-31  7674  
91adb56473febe NeilBrown          2009-03-31  7675  	return conf;
91adb56473febe NeilBrown          2009-03-31  7676  
91adb56473febe NeilBrown          2009-03-31  7677   abort:
8fbcba6b999beb Logan Gunthorpe    2022-04-07  7678  	if (conf)
95fc17aac45300 Dan Williams       2009-07-31  7679  		free_conf(conf);
8fbcba6b999beb Logan Gunthorpe    2022-04-07 @7680  	return ERR_PTR(ret);
                                                               ^^^^^^^^^^^^
This will return NULL instead of an error pointer.

^1da177e4c3f41 Linus Torvalds     2005-04-16  7681  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



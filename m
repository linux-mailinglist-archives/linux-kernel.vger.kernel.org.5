Return-Path: <linux-kernel+bounces-157059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCF8B0C53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD91C21442
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0C15E5C9;
	Wed, 24 Apr 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6AdF/aC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2615E5B1;
	Wed, 24 Apr 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968266; cv=none; b=mBSaEpEovflSWcSIJVp3sVzBt+Pl9aFuLgUJly1wkREYExKjjdFQtjQYUi99kJXg3F9hyH8LGo0EOFFeYqQ+d79JmT65quNQ2ygYXS/pLzW/yjMMAs8ar8+K3qvR+ZOgaSfz8sJH1limqFlHmBgcdVxAUBVHJk+T/x0kJDly+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968266; c=relaxed/simple;
	bh=hyNzl6UHSzZchf9V7Gzo3JKQ9WWb5GYJYSs/R7191MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY9zNL5FMIJs5ACFn4tw1TQcbYzkvBBCnX3UIsex5FZvNK2rlNSvdzteesyzaqSlbpgMzWExwxFpMhFukN4kk9Gr3DdPiv++gLObLCrii/TJb3A82H9dKhxbQgPLA2O3VCdo4tbQrFUlmIFPqZ8Mcu3EXdCtWrnjKlqX7okb7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6AdF/aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D148EC2BBFC;
	Wed, 24 Apr 2024 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968265;
	bh=hyNzl6UHSzZchf9V7Gzo3JKQ9WWb5GYJYSs/R7191MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6AdF/aCeqUK+VBjdffOWQqcyN3U73+GM1EOKOkw8bZ4ZBR1/o8ENmj7G6xrH0Sz3
	 IWhfpKCHEMtgLjIBIm+2xT+8azlEMxDrjeU2mI+rMnKXq3PMl/8mEVeVggKGsAQxJ6
	 tfloeZFgxZgCtHlcmhqECG03f9A9G/2ZSzPjgA5UM6+pl3s0stJOSVORRTeTme4LTo
	 7myYTWHjBu56ei5lmkopt+zkCDi/cOt3nbTa3T5FXKqRry8DpztUK6GieY0JSx4aH+
	 6UAvFgD6utL4pKvQqTSk4QMNoGM96pXw5dChDVORXZtzypKwXKaGmKbBug8WBOpTcW
	 RV/GsAHSwTT1w==
Date: Wed, 24 Apr 2024 16:17:41 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: bpf: lazy load the hid_tail_call entrypoint
Message-ID: <x7ffovagmqjazr6jhr6urkctcj7ozn6poakvjluorhzuxmyyg2@dxw7ucw3qc6z>
References: <20240419-hid_bpf_lazy_skel-v1-3-9210bcd4b61c@kernel.org>
 <74d0e9d1-7ac6-4f08-bab6-76c51e69cebf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d0e9d1-7ac6-4f08-bab6-76c51e69cebf@moroto.mountain>

On Apr 23 2024, Dan Carpenter wrote:
> Hi Benjamin,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/HID-bpf-fix-a-comment-in-a-define/20240419-225110
> base:   b912cf042072e12e93faa874265b30cc0aa521b9
> patch link:    https://lore.kernel.org/r/20240419-hid_bpf_lazy_skel-v1-3-9210bcd4b61c%40kernel.org
> patch subject: [PATCH 3/3] HID: bpf: lazy load the hid_tail_call entrypoint
> config: i386-randconfig-141-20240423 (https://download.01.org/0day-ci/archive/20240423/202404231109.h2IRrMMD-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202404231109.h2IRrMMD-lkp@intel.com/
> 
> smatch warnings:
> drivers/hid/bpf/hid_bpf_jmp_table.c:478 __hid_bpf_attach_prog() error: uninitialized symbol 'link'.
> 
> vim +/link +478 drivers/hid/bpf/hid_bpf_jmp_table.c
> 
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  396  noinline int
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  397  __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
> 7cdd2108903a4e3 Benjamin Tissoires 2024-01-24  398  		      int prog_fd, struct bpf_prog *prog, __u32 flags)
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  399  {
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  400  	struct bpf_link_primer link_primer;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  401  	struct hid_bpf_link *link;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  402  	struct hid_bpf_prog_entry *prog_entry;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  403  	int cnt, err = -EINVAL, prog_table_idx = -1;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  404  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  405  	mutex_lock(&hid_bpf_attach_lock);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  406  
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  407  	if (!jmp_table.map) {
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  408  		err = hid_bpf_preload_skel();
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  409  		WARN_ONCE(err, "error while preloading HID BPF dispatcher: %d", err);
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  410  		if (err)
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  411  			goto err_unlock;
>                                                                         ^^^^^^^^^^^^^^^^
> link isn't initialized.

Well spotted! Thanks
I'll send a v2 soon.

Cheers,
Benjamin

> 
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  412  	}
> 60caa381da7dc38 Benjamin Tissoires 2024-04-19  413  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  414  	link = kzalloc(sizeof(*link), GFP_USER);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  415  	if (!link) {
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  416  		err = -ENOMEM;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  417  		goto err_unlock;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  418  	}
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  419  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  420  	bpf_link_init(&link->link, BPF_LINK_TYPE_UNSPEC,
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  421  		      &hid_bpf_link_lops, prog);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  422  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  423  	/* do not attach too many programs to a given HID device */
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  424  	cnt = hid_bpf_program_count(hdev, NULL, prog_type);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  425  	if (cnt < 0) {
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  426  		err = cnt;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  427  		goto err_unlock;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  428  	}
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  429  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  430  	if (cnt >= hid_bpf_max_programs(prog_type)) {
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  431  		err = -E2BIG;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  432  		goto err_unlock;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  433  	}
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  434  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  435  	prog_table_idx = hid_bpf_insert_prog(prog_fd, prog);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  436  	/* if the jmp table is full, abort */
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  437  	if (prog_table_idx < 0) {
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  438  		err = prog_table_idx;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  439  		goto err_unlock;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  440  	}
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  441  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  442  	if (flags & HID_BPF_FLAG_INSERT_HEAD) {
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  443  		/* take the previous prog_entry slot */
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  444  		jmp_table.tail = PREV(jmp_table.tail);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  445  		prog_entry = &jmp_table.entries[jmp_table.tail];
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  446  	} else {
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  447  		/* take the next prog_entry slot */
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  448  		prog_entry = &jmp_table.entries[jmp_table.head];
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  449  		jmp_table.head = NEXT(jmp_table.head);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  450  	}
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  451  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  452  	/* we steal the ref here */
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  453  	prog_entry->prog = prog;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  454  	prog_entry->idx = prog_table_idx;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  455  	prog_entry->hdev = hdev;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  456  	prog_entry->type = prog_type;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  457  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  458  	/* finally store the index in the device list */
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  459  	err = hid_bpf_populate_hdev(hdev, prog_type);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  460  	if (err) {
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  461  		hid_bpf_release_prog_at(prog_table_idx);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  462  		goto err_unlock;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  463  	}
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  464  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  465  	link->hid_table_index = prog_table_idx;
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  466  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  467  	err = bpf_link_prime(&link->link, &link_primer);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  468  	if (err)
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  469  		goto err_unlock;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  470  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  471  	mutex_unlock(&hid_bpf_attach_lock);
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  472  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  473  	return bpf_link_settle(&link_primer);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  474  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  475   err_unlock:
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  476  	mutex_unlock(&hid_bpf_attach_lock);
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  477  
> 4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13 @478  	kfree(link);
>                                                               ^^^^
> 
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  479  
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  480  	return err;
> f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  481  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


Return-Path: <linux-kernel+bounces-154588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1D8ADE01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F58E1C2192A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722732E62D;
	Tue, 23 Apr 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjOutRJt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BF29429
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856216; cv=none; b=lsJXGrbM9v7lAK3U24lO27wBFIKfYoTyERnrbHb7GRmdCkBDf9fYuNWZ6yCbEn+qi9yOg8m7BgAZkl+ZH7vs0uyRiUS+0Q4Qxk22kBqsMZMhS3NN/+mWot1Fr2oIJ8l4Sh3lohrrN7mSEWgvLYHKlVqh0pISmTwFna5zZjHR1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856216; c=relaxed/simple;
	bh=yBIV7zaqZvrg/tg/0BisDRTKHzM1BXfxz5hj9GRS73o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V5Tp8ck86bVjjl6D9Fu801mvx0R84Qx5FOnWOblVsTjqZoTtVOSVmhHArXCyJbhQ+8lPtVhCnrDpaSc+iS2D9sap0v13PvgSprJmkPHkbNehsSWiQWnB4rSG1ULgrxXerhZgMVlOLCtU4h2TlZwZT3LJv0IgSC81mCiEPzIaj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjOutRJt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so25265961fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713856213; x=1714461013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNtgb93EKXjvpP7lBU0smspsckMSUnUQVOfoYoovNGA=;
        b=SjOutRJtQE2F14utSPilZJvRysEoR1YRtJ3vEWqjKk26kuSV6OhgyaCscmArSZ6u0n
         aTJrouUJ1fWOu0TrWKlyKes6aOvnzPL6/+YJGj8+yeS9AYBAFUSZmEVOj1afckSCjWlg
         8iwAI7IlY3m1lsavjJYY25/qQtXvVNzSMXOjkDpPLRnw4aOxfhJoQEZsWgxjac4YSbBH
         t4MeDkwyFGvUd3W1R08tozfIgH4Zo4neYIWieJGfgB4EZmufqGfVsW+QUdgR1mBX0H6D
         PWR7E+2ymQeo+VyCRvYM53NIzEHRNm4cvpMHvUArEiBEhoqQXZTBrlWfr7HNrXhKEpDJ
         Nc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856213; x=1714461013;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNtgb93EKXjvpP7lBU0smspsckMSUnUQVOfoYoovNGA=;
        b=WN2yGeRXNzic1xn2tqH49U0BiMwn06QjSjJb1AGiE1NfHDgZVQSX17rWHYTJ/fsOvG
         GvKueYkpweddqQJjJK4xp8HlpaPozc2CKgez72fdxzzlgb+A5+SWaZZ2UM38kitvjoyM
         xprisOKttv0QMAMTgXLvLqZ35VAt3rzbod1T6kdw7NOfzAbqPth2UHamRDAxthPIDXe0
         q3qQQCqPImZc/QU7jQ0oRpQKOxri25m8FoUYAPqactmJLRYOqCyEKQZIA22L9vTsG2cj
         /EWhyvbuHN1A1+3QkvdRo5iq/a98Jnovgh9tEvbZ8oIX3moqZq7s6eX9f86DZ+HU5jGK
         pKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYJCN5QLCSxl9MkvHb3q7AgP0nl2QAxchZXW4zd6D0BKUDJCcprAe0edWu82AguelLPZ5K0EMeCzJO60r7jb+AAUlP9SHjZV+Nn5t/
X-Gm-Message-State: AOJu0Yy2ee8lIpSiCqi+MPkCe5IXHZw8xxB9TeZs7FHo6PzgEtvq647U
	I0OI1JbXx05o7th4IUDoUb9ykUqde5FLAJkpQuyAHyD2hUPdV6k+PBqGNJCA8qk=
X-Google-Smtp-Source: AGHT+IHESngGEjaTUV55LrK4cQ6o/pIuWEi1SD7AjVauRAH3j0Pyo9KShhcL6+N1ff5xMADJssFuqA==
X-Received: by 2002:a05:651c:2010:b0:2d8:3eaf:86d2 with SMTP id s16-20020a05651c201000b002d83eaf86d2mr7773324ljo.47.1713856212449;
        Tue, 23 Apr 2024 00:10:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402148600b005702c757af2sm6305825edv.30.2024.04.23.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:10:09 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:10:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: bpf: lazy load the hid_tail_call entrypoint
Message-ID: <74d0e9d1-7ac6-4f08-bab6-76c51e69cebf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-hid_bpf_lazy_skel-v1-3-9210bcd4b61c@kernel.org>

Hi Benjamin,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/HID-bpf-fix-a-comment-in-a-define/20240419-225110
base:   b912cf042072e12e93faa874265b30cc0aa521b9
patch link:    https://lore.kernel.org/r/20240419-hid_bpf_lazy_skel-v1-3-9210bcd4b61c%40kernel.org
patch subject: [PATCH 3/3] HID: bpf: lazy load the hid_tail_call entrypoint
config: i386-randconfig-141-20240423 (https://download.01.org/0day-ci/archive/20240423/202404231109.h2IRrMMD-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404231109.h2IRrMMD-lkp@intel.com/

smatch warnings:
drivers/hid/bpf/hid_bpf_jmp_table.c:478 __hid_bpf_attach_prog() error: uninitialized symbol 'link'.

vim +/link +478 drivers/hid/bpf/hid_bpf_jmp_table.c

f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  396  noinline int
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  397  __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
7cdd2108903a4e3 Benjamin Tissoires 2024-01-24  398  		      int prog_fd, struct bpf_prog *prog, __u32 flags)
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  399  {
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  400  	struct bpf_link_primer link_primer;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  401  	struct hid_bpf_link *link;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  402  	struct hid_bpf_prog_entry *prog_entry;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  403  	int cnt, err = -EINVAL, prog_table_idx = -1;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  404  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  405  	mutex_lock(&hid_bpf_attach_lock);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  406  
60caa381da7dc38 Benjamin Tissoires 2024-04-19  407  	if (!jmp_table.map) {
60caa381da7dc38 Benjamin Tissoires 2024-04-19  408  		err = hid_bpf_preload_skel();
60caa381da7dc38 Benjamin Tissoires 2024-04-19  409  		WARN_ONCE(err, "error while preloading HID BPF dispatcher: %d", err);
60caa381da7dc38 Benjamin Tissoires 2024-04-19  410  		if (err)
60caa381da7dc38 Benjamin Tissoires 2024-04-19  411  			goto err_unlock;
                                                                        ^^^^^^^^^^^^^^^^
link isn't initialized.

60caa381da7dc38 Benjamin Tissoires 2024-04-19  412  	}
60caa381da7dc38 Benjamin Tissoires 2024-04-19  413  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  414  	link = kzalloc(sizeof(*link), GFP_USER);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  415  	if (!link) {
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  416  		err = -ENOMEM;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  417  		goto err_unlock;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  418  	}
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  419  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  420  	bpf_link_init(&link->link, BPF_LINK_TYPE_UNSPEC,
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  421  		      &hid_bpf_link_lops, prog);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  422  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  423  	/* do not attach too many programs to a given HID device */
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  424  	cnt = hid_bpf_program_count(hdev, NULL, prog_type);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  425  	if (cnt < 0) {
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  426  		err = cnt;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  427  		goto err_unlock;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  428  	}
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  429  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  430  	if (cnt >= hid_bpf_max_programs(prog_type)) {
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  431  		err = -E2BIG;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  432  		goto err_unlock;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  433  	}
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  434  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  435  	prog_table_idx = hid_bpf_insert_prog(prog_fd, prog);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  436  	/* if the jmp table is full, abort */
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  437  	if (prog_table_idx < 0) {
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  438  		err = prog_table_idx;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  439  		goto err_unlock;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  440  	}
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  441  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  442  	if (flags & HID_BPF_FLAG_INSERT_HEAD) {
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  443  		/* take the previous prog_entry slot */
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  444  		jmp_table.tail = PREV(jmp_table.tail);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  445  		prog_entry = &jmp_table.entries[jmp_table.tail];
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  446  	} else {
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  447  		/* take the next prog_entry slot */
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  448  		prog_entry = &jmp_table.entries[jmp_table.head];
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  449  		jmp_table.head = NEXT(jmp_table.head);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  450  	}
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  451  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  452  	/* we steal the ref here */
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  453  	prog_entry->prog = prog;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  454  	prog_entry->idx = prog_table_idx;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  455  	prog_entry->hdev = hdev;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  456  	prog_entry->type = prog_type;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  457  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  458  	/* finally store the index in the device list */
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  459  	err = hid_bpf_populate_hdev(hdev, prog_type);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  460  	if (err) {
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  461  		hid_bpf_release_prog_at(prog_table_idx);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  462  		goto err_unlock;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  463  	}
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  464  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  465  	link->hid_table_index = prog_table_idx;
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  466  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  467  	err = bpf_link_prime(&link->link, &link_primer);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  468  	if (err)
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  469  		goto err_unlock;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  470  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  471  	mutex_unlock(&hid_bpf_attach_lock);
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  472  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  473  	return bpf_link_settle(&link_primer);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  474  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  475   err_unlock:
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  476  	mutex_unlock(&hid_bpf_attach_lock);
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13  477  
4b9a3f49f02bf68 Benjamin Tissoires 2023-01-13 @478  	kfree(link);
                                                              ^^^^

f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  479  
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  480  	return err;
f5c27da4e3c8a2e Benjamin Tissoires 2022-11-03  481  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



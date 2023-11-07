Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C887E3486
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjKGE17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjKGE1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:27:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F81FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 20:27:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507ad511315so7551936e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699331270; x=1699936070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz4ibFEani6ikAiwKtvYQFIOOBnNzX2wLnv6rOwCCMs=;
        b=GNqp7n1p66wPlnB4E/S3CX+7x5J6beEzFXIv/prYoqTcsPbzO4SVmaVMGWDxh7lObN
         iBovWIZ2P4EJmBEc+MkFXX+r73s0gJ7APcmP0utgD6+/OdoI2F8wmIfBn+fWQpNOhkkT
         vqg49l4XVxJTyff01ai/ha0+MPrE1pL4CRuk8fxWy6TncAF7wjWoQmIOOfn2lJRhHP8M
         6oTCM1p5DOWOpIrze+KGn+WZqnnpULP/dJ5uzD9wlzH+XtRUxYD9gXzLRcwZ3dhyEKcL
         RqO7UbUcXH7GSajFKHVfEfvMo2wX+dmVyU8RsqxO3upjtnCf2XDMTvCLsksEIZIcolrZ
         BO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699331270; x=1699936070;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bz4ibFEani6ikAiwKtvYQFIOOBnNzX2wLnv6rOwCCMs=;
        b=xMyLamKNezDXcLpvgV7QXqUjTqcRGPWi1SrBQ3OgwMAmD3IRfqtbEPCgrkAzzsjH7W
         ThwoIzgIB2ttKO4DM4ic9aA1w2AoE+WtNa/Og3LQnlSfNTrSaMnrvlrK+GUbUzEUwoRN
         JjZmgbuwc5AWRwNdlBlrKm9PogiZPkBFOQ2H6urDFww9pODODZ1Iivn9ExJZQOC2r4Nx
         z+uTVHz0FuywUDBDndD2mDdPT0+nbZVSODCn486kOYXb7vawrBRMxHBMlT4cbRwgXC1g
         6g0G0wuWnNE70rxPsXZNmpYEYQWCTWV8+F7FxK0y4SaqYJykEYe+ILGTdCCszGLofNzb
         uUTg==
X-Gm-Message-State: AOJu0YxQSA0rJZkl0GNJDJWE6wj13xf+RzCavFnqINr/SH34WohT6FLh
        QvrNwpuusoqKdbxhwtn7LWVQyw==
X-Google-Smtp-Source: AGHT+IFk9UPUznehgtsFa3wG1YIBTyBLMwYw8zTr1jNMtB7C1OcB8sHn4sRwgOB6wi5Zu5GGegmbOw==
X-Received: by 2002:ac2:4850:0:b0:507:a089:caf4 with SMTP id 16-20020ac24850000000b00507a089caf4mr23066306lfy.60.1699331270333;
        Mon, 06 Nov 2023 20:27:50 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d26-20020a50cd5a000000b0053dab756073sm5148167edj.84.2023.11.06.20.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:27:50 -0800 (PST)
Date:   Tue, 7 Nov 2023 07:27:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Zhou Jifeng <zhoujifeng@kylinos.com.cn>,
        miklos@szeredi.hu
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Subject: Re: [PATCH] fuse: Track process write operations in both direct and
 writethrough modes
Message-ID: <70dde24c-5aee-4752-a14e-74ffdc6f7359@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Jifeng/fuse-Track-process-write-operations-in-both-direct-and-writethrough-modes/20231028-150119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20231028065912.6084-1-zhoujifeng%40kylinos.com.cn
patch subject: [PATCH] fuse: Track process write operations in both direct and writethrough modes
config: x86_64-randconfig-161-20231103 (https://download.01.org/0day-ci/archive/20231107/202311070338.uJNMq6Sh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070338.uJNMq6Sh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311070338.uJNMq6Sh-lkp@intel.com/

smatch warnings:
fs/fuse/file.c:1359 fuse_cache_write_iter() error: uninitialized symbol 'err'.

vim +/err +1359 fs/fuse/file.c

55752a3aba1387 Miklos Szeredi    2019-01-24  1302  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1303  {
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1304  	struct file *file = iocb->ki_filp;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1305  	struct address_space *mapping = file->f_mapping;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1306  	ssize_t written = 0;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1307  	struct inode *inode = mapping->host;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1308  	ssize_t err;
56597c4ddc107c Zhou Jifeng       2023-10-28  1309  	ssize_t count;
8981bdfda7445a Vivek Goyal       2020-10-09  1310  	struct fuse_conn *fc = get_fuse_conn(inode);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1311  
8981bdfda7445a Vivek Goyal       2020-10-09  1312  	if (fc->writeback_cache) {
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1313  		/* Update size (EOF optimization) and mode (SUID clearing) */
c6c745b81033a4 Miklos Szeredi    2021-10-22  1314  		err = fuse_update_attributes(mapping->host, file,
c6c745b81033a4 Miklos Szeredi    2021-10-22  1315  					     STATX_SIZE | STATX_MODE);
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1316  		if (err)
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1317  			return err;
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1318  
8981bdfda7445a Vivek Goyal       2020-10-09  1319  		if (fc->handle_killpriv_v2 &&
9452e93e6dae86 Christian Brauner 2023-01-13  1320  		    setattr_should_drop_suidgid(&nop_mnt_idmap,
9452e93e6dae86 Christian Brauner 2023-01-13  1321  						file_inode(file))) {
8981bdfda7445a Vivek Goyal       2020-10-09  1322  			goto writethrough;
8981bdfda7445a Vivek Goyal       2020-10-09  1323  		}
8981bdfda7445a Vivek Goyal       2020-10-09  1324  
84c3d55cc474f9 Al Viro           2014-04-03  1325  		return generic_file_write_iter(iocb, from);
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1326  	}
4d99ff8f12eb20 Pavel Emelyanov   2013-10-10  1327  
8981bdfda7445a Vivek Goyal       2020-10-09  1328  writethrough:
5955102c9984fa Al Viro           2016-01-22  1329  	inode_lock(inode);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1330  
56597c4ddc107c Zhou Jifeng       2023-10-28  1331  	count = generic_write_checks(iocb, from);
56597c4ddc107c Zhou Jifeng       2023-10-28  1332  	if (count <= 0)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1333  		goto out;

Missing error code?

ea9b9907b82a09 Nicholas Piggin   2008-04-30  1334  
56597c4ddc107c Zhou Jifeng       2023-10-28  1335  	task_io_account_write(count);
56597c4ddc107c Zhou Jifeng       2023-10-28  1336  
5fa8e0a1c6a762 Jan Kara          2015-05-21  1337  	err = file_remove_privs(file);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1338  	if (err)
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1339  		goto out;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1340  
c3b2da31483449 Josef Bacik       2012-03-26  1341  	err = file_update_time(file);
c3b2da31483449 Josef Bacik       2012-03-26  1342  	if (err)
c3b2da31483449 Josef Bacik       2012-03-26  1343  		goto out;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1344  
2ba48ce513c4e5 Al Viro           2015-04-09  1345  	if (iocb->ki_flags & IOCB_DIRECT) {
1af5bb491fbb41 Christoph Hellwig 2016-04-07  1346  		written = generic_file_direct_write(iocb, from);
84c3d55cc474f9 Al Viro           2014-04-03  1347  		if (written < 0 || !iov_iter_count(from))
4273b793ec6875 Anand Avati       2012-02-17  1348  			goto out;
64d1b4dd826d88 Christoph Hellwig 2023-06-01  1349  		written = direct_write_fallback(iocb, from, written,
64d1b4dd826d88 Christoph Hellwig 2023-06-01  1350  				fuse_perform_write(iocb, from));
4273b793ec6875 Anand Avati       2012-02-17  1351  	} else {
596df33d673d9d Christoph Hellwig 2023-06-01  1352  		written = fuse_perform_write(iocb, from);
4273b793ec6875 Anand Avati       2012-02-17  1353  	}
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1354  out:
5955102c9984fa Al Viro           2016-01-22  1355  	inode_unlock(inode);
e1c0eecba1a415 Miklos Szeredi    2017-09-12  1356  	if (written > 0)
e1c0eecba1a415 Miklos Szeredi    2017-09-12  1357  		written = generic_write_sync(iocb, written);
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1358  
ea9b9907b82a09 Nicholas Piggin   2008-04-30 @1359  	return written ? written : err;
ea9b9907b82a09 Nicholas Piggin   2008-04-30  1360  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


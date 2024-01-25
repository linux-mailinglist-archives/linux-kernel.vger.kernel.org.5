Return-Path: <linux-kernel+bounces-39219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121883CD02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B552914BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312E137C34;
	Thu, 25 Jan 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="LAaKtxuI"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C7136666
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212809; cv=none; b=jhvjrbKiCVHON1dfonEwGtd0dvR/jSv4mBXNFxkPj4i0Zsc8PPVlL09lW8Cia4iN8XyWhZtzFT0FME1t7QdjChSXdkH3n+PWhNS3YSObBm4NRZULfpTePEhe1YqGL1xj1G9D1peIDsyxZe2Z4hZWREDJGwNoJhFOOAf4bTaU+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212809; c=relaxed/simple;
	bh=jZqqf66o5UsIlpPJOTDIWc0dEexi4t+3VzVeQrbsKIo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VCEKKBwkRPoQVr8gDa8O6hBnGmBWcQp/7jWaNRuLeQ+ocJzmfkvzT9ngQj2TjPFCKQTq9AVmm3/al66CjJi0bTxtdJaBubzGAVboKdkFpWrpvBllT/JhFxWeeZtmzV3eGNZ28Kpf8ckJqNueyEmiNa9vcXs/lsPNpSOh5eqqKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=LAaKtxuI; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a9J/yrDP4CX+CTRHVc0s+P7nNxhLXEGaLVDWqs988UM=;
  b=LAaKtxuIA7mCGoKo13JRZ8hQTOxd63xipQcJdwS/Q6b5u3aB9khpUtUl
   RS8WxJvLce1WcepE0E08mqj43JEv7j7AgKyzsIUopnEnXC+fm5CZvme5e
   6H4anfpZjP3vErrIz5akrGkgupthVAemfJpizDmT67/Bk63bLmO/fRKDO
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148687757"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:00:04 +0100
Date: Thu, 25 Jan 2024 21:00:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Chenyuan Mi <cymi20@fudan.edu.cn>
cc: Mike Marshall <hubcap@omnibond.com>, Xiyu Yang <xiyuyang19@fudan.edu.cn>, 
    Xin Tan <tanxin.ctf@gmail.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: fs/orangefs/super.c:583:18-25: ERROR: ORANGEFS_SB ( sb ) is NULL
 but dereferenced. (fwd)
Message-ID: <alpine.DEB.2.22.394.2401252058450.3273@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please check lines 527-529 and the goto, where it looks like tere is a
null pointer dereference.

julia

---------- Forwarded message ----------
Date: Fri, 26 Jan 2024 03:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: fs/orangefs/super.c:583:18-25: ERROR: ORANGEFS_SB ( sb ) is NULL but
    dereferenced.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Chenyuan Mi <cymi20@fudan.edu.cn>
CC: Mike Marshall <hubcap@omnibond.com>
CC: Xiyu Yang <xiyuyang19@fudan.edu.cn>
CC: Xin Tan <tanxin.ctf@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: ac2c63757f4f413980d6c676dbe1ae2941b94afa orangefs: Fix sb refcount leak when allocate sb info failed.
date:   2 years, 3 months ago
:::::: branch date: 18 hours ago
:::::: commit date: 2 years, 3 months ago
config: arm-randconfig-r062-20240117 (https://download.01.org/0day-ci/archive/20240126/202401260328.WPmVVmk3-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401260328.WPmVVmk3-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/orangefs/super.c:583:18-25: ERROR: ORANGEFS_SB ( sb ) is NULL but dereferenced.

vim +583 fs/orangefs/super.c

1182fca3bc0044 Mike Marshall      2015-07-17  472
8bb8aefd5afb54 Yi Liu             2015-11-24  473  struct dentry *orangefs_mount(struct file_system_type *fst,
1182fca3bc0044 Mike Marshall      2015-07-17  474  			   int flags,
1182fca3bc0044 Mike Marshall      2015-07-17  475  			   const char *devname,
1182fca3bc0044 Mike Marshall      2015-07-17  476  			   void *data)
1182fca3bc0044 Mike Marshall      2015-07-17  477  {
507874c08f633e Colin Ian King     2021-09-10  478  	int ret;
1182fca3bc0044 Mike Marshall      2015-07-17  479  	struct super_block *sb = ERR_PTR(-EINVAL);
8bb8aefd5afb54 Yi Liu             2015-11-24  480  	struct orangefs_kernel_op_s *new_op;
1be21f865aa5a9 Mike Marshall      2015-09-29  481  	struct dentry *d = ERR_PTR(-EINVAL);
1182fca3bc0044 Mike Marshall      2015-07-17  482
1182fca3bc0044 Mike Marshall      2015-07-17  483  	gossip_debug(GOSSIP_SUPER_DEBUG,
8bb8aefd5afb54 Yi Liu             2015-11-24  484  		     "orangefs_mount: called with devname %s\n",
1182fca3bc0044 Mike Marshall      2015-07-17  485  		     devname);
1182fca3bc0044 Mike Marshall      2015-07-17  486
1182fca3bc0044 Mike Marshall      2015-07-17  487  	if (!devname) {
1182fca3bc0044 Mike Marshall      2015-07-17  488  		gossip_err("ERROR: device name not specified.\n");
1182fca3bc0044 Mike Marshall      2015-07-17  489  		return ERR_PTR(-EINVAL);
1182fca3bc0044 Mike Marshall      2015-07-17  490  	}
1182fca3bc0044 Mike Marshall      2015-07-17  491
8bb8aefd5afb54 Yi Liu             2015-11-24  492  	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
1182fca3bc0044 Mike Marshall      2015-07-17  493  	if (!new_op)
1182fca3bc0044 Mike Marshall      2015-07-17  494  		return ERR_PTR(-ENOMEM);
1182fca3bc0044 Mike Marshall      2015-07-17  495
8bb8aefd5afb54 Yi Liu             2015-11-24  496  	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
1182fca3bc0044 Mike Marshall      2015-07-17  497  		devname,
6bdfb48dae8e1b Xiongfeng Wang     2018-01-08  498  		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
1182fca3bc0044 Mike Marshall      2015-07-17  499
1182fca3bc0044 Mike Marshall      2015-07-17  500  	gossip_debug(GOSSIP_SUPER_DEBUG,
8bb8aefd5afb54 Yi Liu             2015-11-24  501  		     "Attempting ORANGEFS Mount via host %s\n",
8bb8aefd5afb54 Yi Liu             2015-11-24  502  		     new_op->upcall.req.fs_mount.orangefs_config_server);
1182fca3bc0044 Mike Marshall      2015-07-17  503
8bb8aefd5afb54 Yi Liu             2015-11-24  504  	ret = service_operation(new_op, "orangefs_mount", 0);
1182fca3bc0044 Mike Marshall      2015-07-17  505  	gossip_debug(GOSSIP_SUPER_DEBUG,
8bb8aefd5afb54 Yi Liu             2015-11-24  506  		     "orangefs_mount: mount got return value of %d\n", ret);
1182fca3bc0044 Mike Marshall      2015-07-17  507  	if (ret)
1182fca3bc0044 Mike Marshall      2015-07-17  508  		goto free_op;
1182fca3bc0044 Mike Marshall      2015-07-17  509
8bb8aefd5afb54 Yi Liu             2015-11-24  510  	if (new_op->downcall.resp.fs_mount.fs_id == ORANGEFS_FS_ID_NULL) {
1182fca3bc0044 Mike Marshall      2015-07-17  511  		gossip_err("ERROR: Retrieved null fs_id\n");
1182fca3bc0044 Mike Marshall      2015-07-17  512  		ret = -EINVAL;
1182fca3bc0044 Mike Marshall      2015-07-17  513  		goto free_op;
1182fca3bc0044 Mike Marshall      2015-07-17  514  	}
1182fca3bc0044 Mike Marshall      2015-07-17  515
1be21f865aa5a9 Mike Marshall      2015-09-29  516  	sb = sget(fst, NULL, set_anon_super, flags, NULL);
1be21f865aa5a9 Mike Marshall      2015-09-29  517
1be21f865aa5a9 Mike Marshall      2015-09-29  518  	if (IS_ERR(sb)) {
1be21f865aa5a9 Mike Marshall      2015-09-29  519  		d = ERR_CAST(sb);
9d286b0d8207a7 Martin Brandenburg 2017-04-25  520  		orangefs_unmount(new_op->downcall.resp.fs_mount.id,
9d286b0d8207a7 Martin Brandenburg 2017-04-25  521  		    new_op->downcall.resp.fs_mount.fs_id, devname);
1182fca3bc0044 Mike Marshall      2015-07-17  522  		goto free_op;
1182fca3bc0044 Mike Marshall      2015-07-17  523  	}
1182fca3bc0044 Mike Marshall      2015-07-17  524
f2d34c738cbf21 Martin Brandenburg 2018-02-12  525  	/* alloc and init our private orangefs sb info */
f2d34c738cbf21 Martin Brandenburg 2018-02-12  526  	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
f2d34c738cbf21 Martin Brandenburg 2018-02-12  527  	if (!ORANGEFS_SB(sb)) {
f2d34c738cbf21 Martin Brandenburg 2018-02-12  528  		d = ERR_PTR(-ENOMEM);
ac2c63757f4f41 Chenyuan Mi        2021-09-07  529  		goto free_sb_and_op;
f2d34c738cbf21 Martin Brandenburg 2018-02-12  530  	}
f2d34c738cbf21 Martin Brandenburg 2018-02-12  531
8bb8aefd5afb54 Yi Liu             2015-11-24  532  	ret = orangefs_fill_sb(sb,
5c0dbbc64b25fd Al Viro            2015-10-08  533  	      &new_op->downcall.resp.fs_mount, data,
1751e8a6cb935e Linus Torvalds     2017-11-27  534  	      flags & SB_SILENT ? 1 : 0);
1be21f865aa5a9 Mike Marshall      2015-09-29  535
1be21f865aa5a9 Mike Marshall      2015-09-29  536  	if (ret) {
1be21f865aa5a9 Mike Marshall      2015-09-29  537  		d = ERR_PTR(ret);
1ec1688c5360e1 Martin Brandenburg 2017-04-14  538  		goto free_sb_and_op;
1be21f865aa5a9 Mike Marshall      2015-09-29  539  	}
1182fca3bc0044 Mike Marshall      2015-07-17  540
1182fca3bc0044 Mike Marshall      2015-07-17  541  	/*
1182fca3bc0044 Mike Marshall      2015-07-17  542  	 * on successful mount, store the devname and data
1182fca3bc0044 Mike Marshall      2015-07-17  543  	 * used
1182fca3bc0044 Mike Marshall      2015-07-17  544  	 */
8bb8aefd5afb54 Yi Liu             2015-11-24  545  	strncpy(ORANGEFS_SB(sb)->devname,
1182fca3bc0044 Mike Marshall      2015-07-17  546  		devname,
6bdfb48dae8e1b Xiongfeng Wang     2018-01-08  547  		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
1182fca3bc0044 Mike Marshall      2015-07-17  548
1182fca3bc0044 Mike Marshall      2015-07-17  549  	/* mount_pending must be cleared */
8bb8aefd5afb54 Yi Liu             2015-11-24  550  	ORANGEFS_SB(sb)->mount_pending = 0;
1182fca3bc0044 Mike Marshall      2015-07-17  551
1182fca3bc0044 Mike Marshall      2015-07-17  552  	/*
8bb8aefd5afb54 Yi Liu             2015-11-24  553  	 * finally, add this sb to our list of known orangefs
1182fca3bc0044 Mike Marshall      2015-07-17  554  	 * sb's
1182fca3bc0044 Mike Marshall      2015-07-17  555  	 */
45996492e5c85a Al Viro            2016-03-25  556  	gossip_debug(GOSSIP_SUPER_DEBUG,
45996492e5c85a Al Viro            2016-03-25  557  		     "Adding SB %p to orangefs superblocks\n",
45996492e5c85a Al Viro            2016-03-25  558  		     ORANGEFS_SB(sb));
45996492e5c85a Al Viro            2016-03-25  559  	spin_lock(&orangefs_superblocks_lock);
45996492e5c85a Al Viro            2016-03-25  560  	list_add_tail(&ORANGEFS_SB(sb)->list, &orangefs_superblocks);
45996492e5c85a Al Viro            2016-03-25  561  	spin_unlock(&orangefs_superblocks_lock);
1182fca3bc0044 Mike Marshall      2015-07-17  562  	op_release(new_op);
482664ddba81b3 Martin Brandenburg 2016-08-12  563
1ec1688c5360e1 Martin Brandenburg 2017-04-14  564  	/* Must be removed from the list now. */
1ec1688c5360e1 Martin Brandenburg 2017-04-14  565  	ORANGEFS_SB(sb)->no_list = 0;
1ec1688c5360e1 Martin Brandenburg 2017-04-14  566
f60fbdbf41c802 Mike Marshall      2016-10-03  567  	if (orangefs_userspace_version >= 20906) {
482664ddba81b3 Martin Brandenburg 2016-08-12  568  		new_op = op_alloc(ORANGEFS_VFS_OP_FEATURES);
482664ddba81b3 Martin Brandenburg 2016-08-12  569  		if (!new_op)
482664ddba81b3 Martin Brandenburg 2016-08-12  570  			return ERR_PTR(-ENOMEM);
482664ddba81b3 Martin Brandenburg 2016-08-12  571  		new_op->upcall.req.features.features = 0;
482664ddba81b3 Martin Brandenburg 2016-08-12  572  		ret = service_operation(new_op, "orangefs_features", 0);
482664ddba81b3 Martin Brandenburg 2016-08-12  573  		orangefs_features = new_op->downcall.resp.features.features;
482664ddba81b3 Martin Brandenburg 2016-08-12  574  		op_release(new_op);
482664ddba81b3 Martin Brandenburg 2016-08-12  575  	} else {
482664ddba81b3 Martin Brandenburg 2016-08-12  576  		orangefs_features = 0;
482664ddba81b3 Martin Brandenburg 2016-08-12  577  	}
482664ddba81b3 Martin Brandenburg 2016-08-12  578
1be21f865aa5a9 Mike Marshall      2015-09-29  579  	return dget(sb->s_root);
1182fca3bc0044 Mike Marshall      2015-07-17  580
1ec1688c5360e1 Martin Brandenburg 2017-04-14  581  free_sb_and_op:
1ec1688c5360e1 Martin Brandenburg 2017-04-14  582  	/* Will call orangefs_kill_sb with sb not in list. */
1ec1688c5360e1 Martin Brandenburg 2017-04-14 @583  	ORANGEFS_SB(sb)->no_list = 1;
9d286b0d8207a7 Martin Brandenburg 2017-04-25  584  	/* ORANGEFS_VFS_OP_FS_UMOUNT is done by orangefs_kill_sb. */
1ec1688c5360e1 Martin Brandenburg 2017-04-14  585  	deactivate_locked_super(sb);
1182fca3bc0044 Mike Marshall      2015-07-17  586  free_op:
8bb8aefd5afb54 Yi Liu             2015-11-24  587  	gossip_err("orangefs_mount: mount request failed with %d\n", ret);
1182fca3bc0044 Mike Marshall      2015-07-17  588  	if (ret == -EINVAL) {
8bb8aefd5afb54 Yi Liu             2015-11-24  589  		gossip_err("Ensure that all orangefs-servers have the same FS configuration files\n");
1182fca3bc0044 Mike Marshall      2015-07-17  590  		gossip_err("Look at pvfs2-client-core log file (typically /tmp/pvfs2-client.log) for more details\n");
1182fca3bc0044 Mike Marshall      2015-07-17  591  	}
1182fca3bc0044 Mike Marshall      2015-07-17  592
1182fca3bc0044 Mike Marshall      2015-07-17  593  	op_release(new_op);
1182fca3bc0044 Mike Marshall      2015-07-17  594
1be21f865aa5a9 Mike Marshall      2015-09-29  595  	return d;
1182fca3bc0044 Mike Marshall      2015-07-17  596  }
1182fca3bc0044 Mike Marshall      2015-07-17  597

:::::: The code at line 583 was first introduced by commit
:::::: 1ec1688c5360e14dde4094d6acbf7516bf6db37e orangefs: free superblock when mount fails

:::::: TO: Martin Brandenburg <martin@omnibond.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289217B20A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjI1PMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjI1PMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:12:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D221AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:12:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40537481094so134075925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695913951; x=1696518751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbZ/IqNedSBPQT19iHqk9aJKTCqpT7A2JizGg5+9yTU=;
        b=m12T7TE24TZURDentk80QMd+V7G3YPqvryJzAAsb5hmunjiM7f3/q8twNFhzsd/hPj
         UebDk8tXlOvtteuTbffluBFdNDf1PBOORmY3eaJXBWCxn97cW9NuEDv0TjV5dcCuWRwZ
         n7HEsAPb6wKYSOFlNkrMk9iZu1MbHqKPvXtsHBRUj9rsAv5XVUNtDEm2bTGb1CfmyIWa
         l39BmLW1SP+DCsx/Tl/wSVw1VZ0dvPVe5bU7BR5+T1Uqd4VollgYVPAb2R2bciruNaRE
         Wl60Q3t6TO8R8wt0igXQp91jnFK7AXurBkcD3FlV5ju92tL0c4xFIUu99mww42mJ/mvg
         I7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913951; x=1696518751;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbZ/IqNedSBPQT19iHqk9aJKTCqpT7A2JizGg5+9yTU=;
        b=df8i3qAi/JuJ9CkGXlrgtYH3hARV5KWATZftrLJ8Tg2+eA107Kb+VjSnE0PLYZ5rQa
         3id/tFwn3a+8Pstxv5kvCDgmimITuPE/JiQ/b9SY76wp6KOcyg4QFZ0fB2Eq4h45kzRx
         xAlK6QaPgDcCUMl/wBZE1O0Sb+upQgcK7SBqfK8dRU3KWDNi7C7yQ2VKO+oCO5CNHEDh
         0MKS7Bg34gChI1NzKL5cD4ujZaFU0rjQnIQjl2FOPpYkyfumXoJT96N3xYsu87aiGQkq
         QI8Ec3VW6g1xbzvjtOFnIldGrYuskz54MFCuL6HGOyQbp9+4nr4L6ocyTWHMnhcpebRv
         aXLQ==
X-Gm-Message-State: AOJu0YyhsBP6b8fk3YU/U/AGwdvq2g4wW3qg09byBqeXdVKA42fuxxZf
        ssRAUCRWhlc/LNL2zTnBeKTqgQ==
X-Google-Smtp-Source: AGHT+IGnch1UoBa2jDjMOtVTX2kWLxJsEK2B3q+kzsrdf7SdOiCY8CqOEICMXM1NQiFOJg/HOVKVMg==
X-Received: by 2002:a7b:c5c6:0:b0:406:51a0:17fd with SMTP id n6-20020a7bc5c6000000b0040651a017fdmr1384997wmk.18.1695913950564;
        Thu, 28 Sep 2023 08:12:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b004064cd71aa8sm2086981wma.34.2023.09.28.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:12:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 18:12:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>
Subject: fs/ceph/crypto.c:465 ceph_fname_to_usr() warn: variable dereferenced
 before IS_ERR check 'dir' (see line 403)
Message-ID: <b5a0acdb-9c25-46f3-aa44-ac57da8efeee@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: dd66df0053ef84add5e684df517aa9b498342381 ceph: add support for encrypted snapshot names
config: x86_64-randconfig-161-20230928 (https://download.01.org/0day-ci/archive/20230928/202309282202.xZxGdvS3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230928/202309282202.xZxGdvS3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309282202.xZxGdvS3-lkp@intel.com/

smatch warnings:
fs/ceph/crypto.c:465 ceph_fname_to_usr() warn: variable dereferenced before IS_ERR check 'dir' (see line 403)

vim +/dir +465 fs/ceph/crypto.c

457117f077c674 Jeff Layton    2021-03-26  380  int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
457117f077c674 Jeff Layton    2021-03-26  381  		      struct fscrypt_str *oname, bool *is_nokey)
457117f077c674 Jeff Layton    2021-03-26  382  {
dd66df0053ef84 Luís Henriques 2022-08-25  383  	struct inode *dir = fname->dir;
457117f077c674 Jeff Layton    2021-03-26  384  	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
457117f077c674 Jeff Layton    2021-03-26  385  	struct fscrypt_str iname;
dd66df0053ef84 Luís Henriques 2022-08-25  386  	char *name = fname->name;
dd66df0053ef84 Luís Henriques 2022-08-25  387  	int name_len = fname->name_len;
dd66df0053ef84 Luís Henriques 2022-08-25  388  	int ret;
457117f077c674 Jeff Layton    2021-03-26  389  
457117f077c674 Jeff Layton    2021-03-26  390  	/* Sanity check that the resulting name will fit in the buffer */
457117f077c674 Jeff Layton    2021-03-26  391  	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
457117f077c674 Jeff Layton    2021-03-26  392  		return -EIO;
457117f077c674 Jeff Layton    2021-03-26  393  
dd66df0053ef84 Luís Henriques 2022-08-25  394  	/* Handle the special case of snapshot names that start with '_' */
dd66df0053ef84 Luís Henriques 2022-08-25  395  	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
dd66df0053ef84 Luís Henriques 2022-08-25  396  	    (name[0] == '_')) {
dd66df0053ef84 Luís Henriques 2022-08-25  397  		dir = parse_longname(dir, name, &name_len);
dd66df0053ef84 Luís Henriques 2022-08-25  398  		if (IS_ERR(dir))
dd66df0053ef84 Luís Henriques 2022-08-25  399  			return PTR_ERR(dir);

If dir is an error pointer, then we return directly.

dd66df0053ef84 Luís Henriques 2022-08-25  400  		name++; /* skip initial '_' */
dd66df0053ef84 Luís Henriques 2022-08-25  401  	}
dd66df0053ef84 Luís Henriques 2022-08-25  402  
dd66df0053ef84 Luís Henriques 2022-08-25 @403  	if (!IS_ENCRYPTED(dir)) {
dd66df0053ef84 Luís Henriques 2022-08-25  404  		oname->name = fname->name;
dd66df0053ef84 Luís Henriques 2022-08-25  405  		oname->len = fname->name_len;
dd66df0053ef84 Luís Henriques 2022-08-25  406  		ret = 0;
dd66df0053ef84 Luís Henriques 2022-08-25  407  		goto out_inode;
dd66df0053ef84 Luís Henriques 2022-08-25  408  	}
dd66df0053ef84 Luís Henriques 2022-08-25  409  
dd66df0053ef84 Luís Henriques 2022-08-25  410  	ret = ceph_fscrypt_prepare_readdir(dir);
dd66df0053ef84 Luís Henriques 2022-08-25  411  	if (ret)
dd66df0053ef84 Luís Henriques 2022-08-25  412  		goto out_inode;
457117f077c674 Jeff Layton    2021-03-26  413  
457117f077c674 Jeff Layton    2021-03-26  414  	/*
457117f077c674 Jeff Layton    2021-03-26  415  	 * Use the raw dentry name as sent by the MDS instead of
457117f077c674 Jeff Layton    2021-03-26  416  	 * generating a nokey name via fscrypt.
457117f077c674 Jeff Layton    2021-03-26  417  	 */
dd66df0053ef84 Luís Henriques 2022-08-25  418  	if (!fscrypt_has_encryption_key(dir)) {
af9ffa6df7e337 Xiubo Li       2022-03-14  419  		if (fname->no_copy)
af9ffa6df7e337 Xiubo Li       2022-03-14  420  			oname->name = fname->name;
af9ffa6df7e337 Xiubo Li       2022-03-14  421  		else
457117f077c674 Jeff Layton    2021-03-26  422  			memcpy(oname->name, fname->name, fname->name_len);
457117f077c674 Jeff Layton    2021-03-26  423  		oname->len = fname->name_len;
457117f077c674 Jeff Layton    2021-03-26  424  		if (is_nokey)
457117f077c674 Jeff Layton    2021-03-26  425  			*is_nokey = true;
dd66df0053ef84 Luís Henriques 2022-08-25  426  		ret = 0;
dd66df0053ef84 Luís Henriques 2022-08-25  427  		goto out_inode;
457117f077c674 Jeff Layton    2021-03-26  428  	}
457117f077c674 Jeff Layton    2021-03-26  429  
457117f077c674 Jeff Layton    2021-03-26  430  	if (fname->ctext_len == 0) {
457117f077c674 Jeff Layton    2021-03-26  431  		int declen;
457117f077c674 Jeff Layton    2021-03-26  432  
457117f077c674 Jeff Layton    2021-03-26  433  		if (!tname) {
457117f077c674 Jeff Layton    2021-03-26  434  			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
457117f077c674 Jeff Layton    2021-03-26  435  			if (ret)
dd66df0053ef84 Luís Henriques 2022-08-25  436  				goto out_inode;
457117f077c674 Jeff Layton    2021-03-26  437  			tname = &_tname;
457117f077c674 Jeff Layton    2021-03-26  438  		}
457117f077c674 Jeff Layton    2021-03-26  439  
dd66df0053ef84 Luís Henriques 2022-08-25  440  		declen = ceph_base64_decode(name, name_len, tname->name);
457117f077c674 Jeff Layton    2021-03-26  441  		if (declen <= 0) {
457117f077c674 Jeff Layton    2021-03-26  442  			ret = -EIO;
457117f077c674 Jeff Layton    2021-03-26  443  			goto out;
457117f077c674 Jeff Layton    2021-03-26  444  		}
457117f077c674 Jeff Layton    2021-03-26  445  		iname.name = tname->name;
457117f077c674 Jeff Layton    2021-03-26  446  		iname.len = declen;
457117f077c674 Jeff Layton    2021-03-26  447  	} else {
457117f077c674 Jeff Layton    2021-03-26  448  		iname.name = fname->ctext;
457117f077c674 Jeff Layton    2021-03-26  449  		iname.len = fname->ctext_len;
457117f077c674 Jeff Layton    2021-03-26  450  	}
457117f077c674 Jeff Layton    2021-03-26  451  
dd66df0053ef84 Luís Henriques 2022-08-25  452  	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
dd66df0053ef84 Luís Henriques 2022-08-25  453  	if (!ret && (dir != fname->dir)) {
dd66df0053ef84 Luís Henriques 2022-08-25  454  		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
dd66df0053ef84 Luís Henriques 2022-08-25  455  
dd66df0053ef84 Luís Henriques 2022-08-25  456  		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
dd66df0053ef84 Luís Henriques 2022-08-25  457  				    oname->len, oname->name, dir->i_ino);
dd66df0053ef84 Luís Henriques 2022-08-25  458  		memcpy(oname->name, tmp_buf, name_len);
dd66df0053ef84 Luís Henriques 2022-08-25  459  		oname->len = name_len;
dd66df0053ef84 Luís Henriques 2022-08-25  460  	}
dd66df0053ef84 Luís Henriques 2022-08-25  461  
457117f077c674 Jeff Layton    2021-03-26  462  out:
457117f077c674 Jeff Layton    2021-03-26  463  	fscrypt_fname_free_buffer(&_tname);
dd66df0053ef84 Luís Henriques 2022-08-25  464  out_inode:
dd66df0053ef84 Luís Henriques 2022-08-25 @465  	if ((dir != fname->dir) && !IS_ERR(dir)) {
                                                                           ^^^^^^^^^^^^
Checking a second time, is harmless but annoys static analysis.  I think
if you have the cross function database then this warning is not
triggered because Smatch tries to not warn about unnecessary checks so
long as we are sure they are harmless.  Without the cross function
database we know that "dir" isn't an error pointer but it might still
be an invalid pointer.  I guess I could make this more strict to only
count dereferencing which are potentially error pointer dereferences
instead of just potentially invalid.  With the cross function database
we know that parse_longname() either returns valid or error pointers.

dd66df0053ef84 Luís Henriques 2022-08-25  466  		if ((dir->i_state & I_NEW))
dd66df0053ef84 Luís Henriques 2022-08-25  467  			discard_new_inode(dir);
dd66df0053ef84 Luís Henriques 2022-08-25  468  		else
dd66df0053ef84 Luís Henriques 2022-08-25  469  			iput(dir);
dd66df0053ef84 Luís Henriques 2022-08-25  470  	}
457117f077c674 Jeff Layton    2021-03-26  471  	return ret;
457117f077c674 Jeff Layton    2021-03-26  472  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


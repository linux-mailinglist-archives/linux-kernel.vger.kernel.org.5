Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B627B2ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjI2JGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI2JGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:06:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B90494
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:06:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C50B51F45E;
        Fri, 29 Sep 2023 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695978372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRsZf1pplGepqP9aipigqi9rZI39Tqxq9C+/yMVZbrk=;
        b=F4hhoi9CadpF6CO33OymGXwS1dO61J1qkrtAcl+QHRUrBPNYNUM5CCDuPN6GocBAb3rEHA
        bd4LpAvXiQQCuad4aDO2tclUBC9bj9wnvQ+JVnCL/9MY5bCizbxyar0Ip/y5tQHHnYx47t
        VtrxXFJR40kfa7GRDcndS8Uo2bGTI6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695978372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRsZf1pplGepqP9aipigqi9rZI39Tqxq9C+/yMVZbrk=;
        b=X1rfM2q+eXA8hBq8BhcB0A4dQbdESf1Wd6d5wrVAE83Rbmwh71t6CVORM+x8ynhbL53G72
        YWjDxzjnKWpOhVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329AB13434;
        Fri, 29 Sep 2023 09:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2K8sCYSTFmXYfQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 29 Sep 2023 09:06:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 7a904682;
        Fri, 29 Sep 2023 09:06:09 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>
Subject: Re: fs/ceph/crypto.c:465 ceph_fname_to_usr() warn: variable
 dereferenced before IS_ERR check 'dir' (see line 403)
In-Reply-To: <b5a0acdb-9c25-46f3-aa44-ac57da8efeee@kadam.mountain> (Dan
        Carpenter's message of "Thu, 28 Sep 2023 18:12:27 +0300")
References: <b5a0acdb-9c25-46f3-aa44-ac57da8efeee@kadam.mountain>
Date:   Fri, 29 Sep 2023 10:06:09 +0100
Message-ID: <87ttrdz6v2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@linaro.org> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
> commit: dd66df0053ef84add5e684df517aa9b498342381 ceph: add support for en=
crypted snapshot names
> config: x86_64-randconfig-161-20230928 (https://download.01.org/0day-ci/a=
rchive/20230928/202309282202.xZxGdvS3-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230928/202309282202=
.xZxGdvS3-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202309282202.xZxGdvS3-lkp@intel.com/
>
> smatch warnings:
> fs/ceph/crypto.c:465 ceph_fname_to_usr() warn: variable dereferenced befo=
re IS_ERR check 'dir' (see line 403)

I agree that this check here is indeed useless and the IS_ERR() here
could/should be dropped.  In fact, function ceph_encode_encrypted_dname()
has a similar structure and is not repeating this error check in the
clean-up code.

I'll send out a clean-up fix for this in a second (although I also don't
think there's a real bug here).  Thank you for your report.

Cheers,
--=20
Lu=C3=ADs


> vim +/dir +465 fs/ceph/crypto.c
>
> 457117f077c674 Jeff Layton    2021-03-26  380  int ceph_fname_to_usr(cons=
t struct ceph_fname *fname, struct fscrypt_str *tname,
> 457117f077c674 Jeff Layton    2021-03-26  381  		      struct fscrypt_str=
 *oname, bool *is_nokey)
> 457117f077c674 Jeff Layton    2021-03-26  382  {
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  383  	struct inode *dir =
=3D fname->dir;
> 457117f077c674 Jeff Layton    2021-03-26  384  	struct fscrypt_str _tname=
 =3D FSTR_INIT(NULL, 0);
> 457117f077c674 Jeff Layton    2021-03-26  385  	struct fscrypt_str iname;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  386  	char *name =3D fname=
->name;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  387  	int name_len =3D fna=
me->name_len;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  388  	int ret;
> 457117f077c674 Jeff Layton    2021-03-26  389=20=20
> 457117f077c674 Jeff Layton    2021-03-26  390  	/* Sanity check that the =
resulting name will fit in the buffer */
> 457117f077c674 Jeff Layton    2021-03-26  391  	if (fname->name_len > NAM=
E_MAX || fname->ctext_len > NAME_MAX)
> 457117f077c674 Jeff Layton    2021-03-26  392  		return -EIO;
> 457117f077c674 Jeff Layton    2021-03-26  393=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  394  	/* Handle the specia=
l case of snapshot names that start with '_' */
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  395  	if ((ceph_snap(dir) =
=3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  396  	    (name[0] =3D=3D =
'_')) {
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  397  		dir =3D parse_longn=
ame(dir, name, &name_len);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  398  		if (IS_ERR(dir))
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  399  			return PTR_ERR(dir=
);
>
> If dir is an error pointer, then we return directly.
>
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  400  		name++; /* skip ini=
tial '_' */
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  401  	}
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  402=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25 @403  	if (!IS_ENCRYPTED(di=
r)) {
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  404  		oname->name =3D fna=
me->name;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  405  		oname->len =3D fnam=
e->name_len;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  406  		ret =3D 0;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  407  		goto out_inode;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  408  	}
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  409=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  410  	ret =3D ceph_fscrypt=
_prepare_readdir(dir);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  411  	if (ret)
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  412  		goto out_inode;
> 457117f077c674 Jeff Layton    2021-03-26  413=20=20
> 457117f077c674 Jeff Layton    2021-03-26  414  	/*
> 457117f077c674 Jeff Layton    2021-03-26  415  	 * Use the raw dentry nam=
e as sent by the MDS instead of
> 457117f077c674 Jeff Layton    2021-03-26  416  	 * generating a nokey nam=
e via fscrypt.
> 457117f077c674 Jeff Layton    2021-03-26  417  	 */
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  418  	if (!fscrypt_has_enc=
ryption_key(dir)) {
> af9ffa6df7e337 Xiubo Li       2022-03-14  419  		if (fname->no_copy)
> af9ffa6df7e337 Xiubo Li       2022-03-14  420  			oname->name =3D fname->=
name;
> af9ffa6df7e337 Xiubo Li       2022-03-14  421  		else
> 457117f077c674 Jeff Layton    2021-03-26  422  			memcpy(oname->name, fna=
me->name, fname->name_len);
> 457117f077c674 Jeff Layton    2021-03-26  423  		oname->len =3D fname->na=
me_len;
> 457117f077c674 Jeff Layton    2021-03-26  424  		if (is_nokey)
> 457117f077c674 Jeff Layton    2021-03-26  425  			*is_nokey =3D true;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  426  		ret =3D 0;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  427  		goto out_inode;
> 457117f077c674 Jeff Layton    2021-03-26  428  	}
> 457117f077c674 Jeff Layton    2021-03-26  429=20=20
> 457117f077c674 Jeff Layton    2021-03-26  430  	if (fname->ctext_len =3D=
=3D 0) {
> 457117f077c674 Jeff Layton    2021-03-26  431  		int declen;
> 457117f077c674 Jeff Layton    2021-03-26  432=20=20
> 457117f077c674 Jeff Layton    2021-03-26  433  		if (!tname) {
> 457117f077c674 Jeff Layton    2021-03-26  434  			ret =3D fscrypt_fname_a=
lloc_buffer(NAME_MAX, &_tname);
> 457117f077c674 Jeff Layton    2021-03-26  435  			if (ret)
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  436  				goto out_inode;
> 457117f077c674 Jeff Layton    2021-03-26  437  			tname =3D &_tname;
> 457117f077c674 Jeff Layton    2021-03-26  438  		}
> 457117f077c674 Jeff Layton    2021-03-26  439=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  440  		declen =3D ceph_bas=
e64_decode(name, name_len, tname->name);
> 457117f077c674 Jeff Layton    2021-03-26  441  		if (declen <=3D 0) {
> 457117f077c674 Jeff Layton    2021-03-26  442  			ret =3D -EIO;
> 457117f077c674 Jeff Layton    2021-03-26  443  			goto out;
> 457117f077c674 Jeff Layton    2021-03-26  444  		}
> 457117f077c674 Jeff Layton    2021-03-26  445  		iname.name =3D tname->na=
me;
> 457117f077c674 Jeff Layton    2021-03-26  446  		iname.len =3D declen;
> 457117f077c674 Jeff Layton    2021-03-26  447  	} else {
> 457117f077c674 Jeff Layton    2021-03-26  448  		iname.name =3D fname->ct=
ext;
> 457117f077c674 Jeff Layton    2021-03-26  449  		iname.len =3D fname->cte=
xt_len;
> 457117f077c674 Jeff Layton    2021-03-26  450  	}
> 457117f077c674 Jeff Layton    2021-03-26  451=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  452  	ret =3D fscrypt_fnam=
e_disk_to_usr(dir, 0, 0, &iname, oname);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  453  	if (!ret && (dir !=
=3D fname->dir)) {
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  454  		char tmp_buf[CEPH_B=
ASE64_CHARS(NAME_MAX)];
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  455=20=20
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  456  		name_len =3D snprin=
tf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  457  				    oname->len, o=
name->name, dir->i_ino);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  458  		memcpy(oname->name,=
 tmp_buf, name_len);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  459  		oname->len =3D name=
_len;
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  460  	}
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  461=20=20
> 457117f077c674 Jeff Layton    2021-03-26  462  out:
> 457117f077c674 Jeff Layton    2021-03-26  463  	fscrypt_fname_free_buffer=
(&_tname);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  464  out_inode:
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25 @465  	if ((dir !=3D fname-=
>dir) && !IS_ERR(dir)) {
>                                                                          =
  ^^^^^^^^^^^^
> Checking a second time, is harmless but annoys static analysis.  I think
> if you have the cross function database then this warning is not
> triggered because Smatch tries to not warn about unnecessary checks so
> long as we are sure they are harmless.  Without the cross function
> database we know that "dir" isn't an error pointer but it might still
> be an invalid pointer.  I guess I could make this more strict to only
> count dereferencing which are potentially error pointer dereferences
> instead of just potentially invalid.  With the cross function database
> we know that parse_longname() either returns valid or error pointers.
>
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  466  		if ((dir->i_state &=
 I_NEW))
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  467  			discard_new_inode(=
dir);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  468  		else
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  469  			iput(dir);
> dd66df0053ef84 Lu=C3=ADs Henriques 2022-08-25  470  	}
> 457117f077c674 Jeff Layton    2021-03-26  471  	return ret;
> 457117f077c674 Jeff Layton    2021-03-26  472  }
>
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898307BC373
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjJGBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjJGBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:01:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAFBB6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 18:01:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CC9C433CA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696640471;
        bh=17frnwogUVzqkQyypX9LPSD7rbMja1BVb5kebfkCKGY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MPNANiZCtrTxCb236M/W3Ia12rOjUztdKY5hQMY81w7MmWkMRJ/orQOWHodRfL5qW
         GqJSojxBgJ/Dd8StFn3KWmFihBUQuxvcg98nLU659U4arN5qz+l7UPIMYNwJhs99ip
         YuM/L5hE2sm1KIdjxiC2tSM/ZLqMAiiw2njZ2UK+j/ObY0SfwmGdav541VkrlOUfQE
         PnYyIZ5ykx6ZgKf1tQ0hTddqmyC8dflKdtbEYSmN+HNt8LstGGj49hO6OOzO05MpoU
         t1W/GKT4q0K5B398pUeYTLaI+stFKkmFcfMR8D5Cy7DpMaloXJ9uriLbCyj2rA3gb5
         O081gbgYWmpVA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ae5a014d78so1917962b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 18:01:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzD7iHU2HyzuGOfa8F9Udv973ltMcvIfLlddivcp6rVtLfIpFsq
        AvpagLxaGW8csqHYvSHB7iE1BDl8DQBjg/4jgvQ=
X-Google-Smtp-Source: AGHT+IHaLSyU2vsrCRkvnMYduh4Zj4hOlVQCbyh3d0lpItdfQAQ7p0xnZH8+2/xvBNF+55lLDmBaviytvyw65mKp4UQ=
X-Received: by 2002:a05:6808:15a1:b0:3a1:db91:c5ef with SMTP id
 t33-20020a05680815a100b003a1db91c5efmr3888286oiw.23.1696640471094; Fri, 06
 Oct 2023 18:01:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b41:0:b0:4fa:bc5a:10a5 with HTTP; Fri, 6 Oct 2023
 18:01:09 -0700 (PDT)
In-Reply-To: <202310070441.73IUVG65-lkp@intel.com>
References: <202310070441.73IUVG65-lkp@intel.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 7 Oct 2023 10:01:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-t3wP-w8_UT453V_vurV7Xmh+G=6pqmzc0hY91kXhQaw@mail.gmail.com>
Message-ID: <CAKYAXd-t3wP-w8_UT453V_vurV7Xmh+G=6pqmzc0hY91kXhQaw@mail.gmail.com>
Subject: Re: fs/smb/server/vfs.c:929: warning: Function parameter or member
 'path' not described in 'ksmbd_vfs_setxattr'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-07 5:41 GMT+09:00, kernel test robot <lkp@intel.com>:
> Hi Namjae,
Hi,
>
> FYI, the error/warning still remains.
Okay, I will fix it.
Thanks for your report:)
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
> commit: 40b268d384a22276dca1450549f53eed60e21deb ksmbd: add mnt_want_write
> to ksmbd vfs functions
> date:   4 months ago
> config: m68k-allyesconfig
> (https://download.01.org/0day-ci/archive/20231007/202310070441.73IUVG65-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build):
> (https://download.01.org/0day-ci/archive/20231007/202310070441.73IUVG65-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version
> of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202310070441.73IUVG65-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    fs/smb/server/vfs.c:54: warning: Function parameter or member 'parent'
> not described in 'ksmbd_vfs_lock_parent'
>    fs/smb/server/vfs.c:54: warning: Function parameter or member 'child' not
> described in 'ksmbd_vfs_lock_parent'
>    fs/smb/server/vfs.c:372: warning: Function parameter or member 'fp' not
> described in 'ksmbd_vfs_read'
>    fs/smb/server/vfs.c:372: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_read'
>    fs/smb/server/vfs.c:488: warning: Function parameter or member 'fp' not
> described in 'ksmbd_vfs_write'
>    fs/smb/server/vfs.c:488: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_write'
>    fs/smb/server/vfs.c:551: warning: Function parameter or member 'path' not
> described in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:551: warning: Function parameter or member 'stat' not
> described in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:551: warning: Excess function parameter 'work'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:551: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:551: warning: Excess function parameter 'attrs'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:568: warning: Function parameter or member 'p_id' not
> described in 'ksmbd_vfs_fsync'
>    fs/smb/server/vfs.c:591: warning: Function parameter or member 'work' not
> described in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:591: warning: Function parameter or member 'path' not
> described in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:591: warning: Excess function parameter 'name'
> description in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:634: warning: Function parameter or member 'work' not
> described in 'ksmbd_vfs_link'
>    fs/smb/server/vfs.c:811: warning: Function parameter or member 'fp' not
> described in 'ksmbd_vfs_truncate'
>    fs/smb/server/vfs.c:811: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_truncate'
>    fs/smb/server/vfs.c:852: warning: Excess function parameter 'size'
> description in 'ksmbd_vfs_listxattr'
>>> fs/smb/server/vfs.c:929: warning: Function parameter or member 'path' not
>>> described in 'ksmbd_vfs_setxattr'
>>> fs/smb/server/vfs.c:929: warning: Excess function parameter 'dentry'
>>> description in 'ksmbd_vfs_setxattr'
>    fs/smb/server/vfs.c:954: warning: Function parameter or member 'option'
> not described in 'ksmbd_vfs_set_fadvise'
>    fs/smb/server/vfs.c:954: warning: Excess function parameter 'options'
> description in 'ksmbd_vfs_set_fadvise'
>    fs/smb/server/vfs.c:1168: warning: Function parameter or member 'um' not
> described in 'ksmbd_vfs_lookup_in_dir'
>    fs/smb/server/vfs.c:1203: warning: Function parameter or member 'work'
> not described in 'ksmbd_vfs_kern_path_locked'
>
>
> vim +929 fs/smb/server/vfs.c
>
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  914
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  915  /**
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  916   *
> ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
> 4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  917   *
> @idmap:	idmap of the relevant mount
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  918   *
> @dentry:	dentry to set XATTR at
> 63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  919   *
> @attr_name:	xattr name for setxattr
> 63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  920   *
> @attr_value:	xattr value to set
> 63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  921   *
> @attr_size:	size of xattr value
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  922   *
> @flags:	destination buffer length
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  923   *
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  924   *
> Return:	0 on success, otherwise error
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  925   */
> 4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  926  int
> ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  927  		
>   const struct path *path, const char *attr_name,
> 0c5fd887d2bb47 fs/ksmbd/vfs.c      Christian Brauner 2022-07-06  928  		
>   void *attr_value, size_t attr_size, int flags)
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16 @929  {
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  930  	int
> err;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  931
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  932  	err =
> mnt_want_write(path->mnt);
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  933  	if
> (err)
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  934
> 		return err;
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  935
> 4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  936  	err =
> vfs_setxattr(idmap,
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  937  			
> path->dentry,
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  938  			
> attr_name,
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  939  			
> attr_value,
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  940  			
> attr_size,
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  941  			
> flags);
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  942  	if
> (err)
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  943
> 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
> 40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  944
> 	mnt_drop_write(path->mnt);
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  945
> 	return err;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  946  }
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  947
>
> :::::: The code at line 929 was first introduced by commit
> :::::: f44158485826c076335d6860d35872271a83791d cifsd: add file operations
>
> :::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
> :::::: CC: Steve French <stfrench@microsoft.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

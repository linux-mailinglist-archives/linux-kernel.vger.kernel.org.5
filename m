Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B897E120B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 03:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjKECe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 22:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKECe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 22:34:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70209A7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 19:34:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081B8C433C9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 02:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699151663;
        bh=SfI09hRWheDLYBHeMGajwLALAP1q/t+EQdiQqx9uGlg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=o/fTpJlVpOIvwpQ8a5K7+sUuGYIZHNEa4QfeVtRY7YAAA0w5Qhn7W42oVu74M/ODW
         Yg0uvgfAPC+/o9UYSpUDcLh6DQ5JD2TuF76E7APT/9kJsq0zCYBybO3Nsy5tePSCt3
         fWJsQ5PEjUeFjASkkpAHYQq3ySXUFSehmHaHGXh4M36tP4jdOXSvmz2LrThai8KGLk
         fVinQkDKnPkPg38j/Th1MRoOPCNik6Pirb5TDge2TQtdxTkOcx3LG0ZJ81EbmkJTpI
         5yBjoKRR9FZqkN9lk9wprAQkbctJ7TBSxsPN8PiODPcQdRJfUbvEgGY0fhz7YsRKOb
         goHeF84zx5uHQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2c5b2154so2151689a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 19:34:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoipRy/EqLmZh+yq2U3L8hhNtu8akl1FL6wD76PXs85A5OTU57
        cV9jAOf+GMhgdBxKmR2SFttlJTQKrbSE7PJY63M=
X-Google-Smtp-Source: AGHT+IFCDINii8qbHOobowPhlgEUJdz7hw9YfBNiuRYZqgMDCtNbAPMaKj8YhG4z2nSXhKLLx63TAoVf70JWLQUVPAo=
X-Received: by 2002:a05:6830:2b08:b0:6d3:1f91:22e8 with SMTP id
 l8-20020a0568302b0800b006d31f9122e8mr14103194otv.2.1699151662230; Sat, 04 Nov
 2023 19:34:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7459:0:b0:506:a3fc:1021 with HTTP; Sat, 4 Nov 2023
 19:34:21 -0700 (PDT)
In-Reply-To: <202311042024.12w45Xsm-lkp@intel.com>
References: <202311042024.12w45Xsm-lkp@intel.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 5 Nov 2023 11:34:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd87xZCXthjnpDsrTVyxbB4z=2d9LY6UEx9_4ECaqWC-RA@mail.gmail.com>
Message-ID: <CAKYAXd87xZCXthjnpDsrTVyxbB4z=2d9LY6UEx9_4ECaqWC-RA@mail.gmail.com>
Subject: Re: fs/smb/server/vfs.c:1207: warning: Function parameter or member
 'parent_path' not described in 'ksmbd_vfs_kern_path_locked'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-11-04 21:36 GMT+09:00, kernel test robot <lkp@intel.com>:
> Hi Namjae,
Hi,
>
> FYI, the error/warning still remains.
I have fixed it:). I will apply it soon.

Thanks for your report!
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
> master
> head:   90b0c2b2edd1adff742c621e246562fbefa11b70
> commit: 2b57a4322b1b14348940744fdc02f9a86cbbdbeb ksmbd: check if a mount
> point is crossed during path lookup
> date:   3 months ago
> config: sh-allyesconfig
> (https://download.01.org/0day-ci/archive/20231104/202311042024.12w45Xsm-l=
kp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20231104/202311042024.12w45Xsm-l=
kp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202311042024.12w45Xsm-lkp@intel.com=
/
>
> All warnings (new ones prefixed by >>):
>
>    fs/smb/server/vfs.c:54: warning: Function parameter or member 'parent'
> not described in 'ksmbd_vfs_lock_parent'
>    fs/smb/server/vfs.c:54: warning: Function parameter or member 'child' =
not
> described in 'ksmbd_vfs_lock_parent'
>    fs/smb/server/vfs.c:375: warning: Function parameter or member 'fp' no=
t
> described in 'ksmbd_vfs_read'
>    fs/smb/server/vfs.c:375: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_read'
>    fs/smb/server/vfs.c:492: warning: Function parameter or member 'fp' no=
t
> described in 'ksmbd_vfs_write'
>    fs/smb/server/vfs.c:492: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_write'
>    fs/smb/server/vfs.c:555: warning: Function parameter or member 'path' =
not
> described in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:555: warning: Function parameter or member 'stat' =
not
> described in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:555: warning: Excess function parameter 'work'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:555: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:555: warning: Excess function parameter 'attrs'
> description in 'ksmbd_vfs_getattr'
>    fs/smb/server/vfs.c:572: warning: Function parameter or member 'p_id' =
not
> described in 'ksmbd_vfs_fsync'
>    fs/smb/server/vfs.c:595: warning: Function parameter or member 'work' =
not
> described in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:595: warning: Function parameter or member 'path' =
not
> described in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:595: warning: Excess function parameter 'name'
> description in 'ksmbd_vfs_remove_file'
>    fs/smb/server/vfs.c:638: warning: Function parameter or member 'work' =
not
> described in 'ksmbd_vfs_link'
>    fs/smb/server/vfs.c:815: warning: Function parameter or member 'fp' no=
t
> described in 'ksmbd_vfs_truncate'
>    fs/smb/server/vfs.c:815: warning: Excess function parameter 'fid'
> description in 'ksmbd_vfs_truncate'
>    fs/smb/server/vfs.c:856: warning: Excess function parameter 'size'
> description in 'ksmbd_vfs_listxattr'
>    fs/smb/server/vfs.c:933: warning: Function parameter or member 'path' =
not
> described in 'ksmbd_vfs_setxattr'
>    fs/smb/server/vfs.c:933: warning: Excess function parameter 'dentry'
> description in 'ksmbd_vfs_setxattr'
>    fs/smb/server/vfs.c:958: warning: Function parameter or member 'option=
'
> not described in 'ksmbd_vfs_set_fadvise'
>    fs/smb/server/vfs.c:958: warning: Excess function parameter 'options'
> description in 'ksmbd_vfs_set_fadvise'
>    fs/smb/server/vfs.c:1172: warning: Function parameter or member 'um' n=
ot
> described in 'ksmbd_vfs_lookup_in_dir'
>    fs/smb/server/vfs.c:1207: warning: Function parameter or member 'work'
> not described in 'ksmbd_vfs_kern_path_locked'
>>> fs/smb/server/vfs.c:1207: warning: Function parameter or member
>>> 'parent_path' not described in 'ksmbd_vfs_kern_path_locked'
>
>
> vim +1207 fs/smb/server/vfs.c
>
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1194
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1195  /**
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1196   *
> ksmbd_vfs_kern_path_locked() - lookup a file and get path info
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1197   *
> @name:	file path that is relative to share
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1198   *
> @flags:	lookup flags
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1199   *
> @path:	if lookup succeed, return path info
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1200   *
> @caseless:	caseless filename lookup
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1201   *
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1202   *
> Return:	0 on success, otherwise error
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1203   */
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1204  int
> ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1205  		=09
> unsigned int flags, struct path *parent_path,
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1206  		=09
> struct path *path, bool caseless)
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16 @1207  {
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1208  	struc=
t
> ksmbd_share_config *share_conf =3D work->tcon->share_conf;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1209  	int
> err;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1210
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1211  	err =
=3D
> ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1212  				=
=09
> path);
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1213  	if
> (!err)
> cf5e7f734f4455 fs/smb/server/vfs.c Namjae Jeon   2023-05-30  1214  		retu=
rn
> 0;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1215
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1216  	if
> (caseless) {
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1217  		char
> *filepath;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1218  		size=
_t
> path_len, remain_len;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1219
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1220
> 		filepath =3D kstrdup(name, GFP_KERNEL);
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1221  		if
> (!filepath)
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1222  			ret=
urn
> -ENOMEM;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1223
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1224
> 		path_len =3D strlen(filepath);
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1225
> 		remain_len =3D path_len;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1226
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1227
> 		*parent_path =3D share_conf->vfs_path;
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1228
> 		path_get(parent_path);
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1229
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1230  		whil=
e
> (d_can_lookup(parent_path->dentry)) {
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1231  			cha=
r
> *filename =3D filepath + path_len - remain_len;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1232  			cha=
r
> *next =3D strchrnul(filename, '/');
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1233  			siz=
e_t
> filename_len =3D next - filename;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1234  			boo=
l
> is_last =3D !next[0];
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1235
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1236  			if
> (filename_len =3D=3D 0)
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1237
> 				break;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1238
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1239  			err=
 =3D
> ksmbd_vfs_lookup_in_dir(parent_path, filename,
> dbab80e2071ad8 fs/ksmbd/vfs.c      Atte Heikkil=C3=A4 2022-09-28  1240  	=
				=09
>   filename_len,
> dbab80e2071ad8 fs/ksmbd/vfs.c      Atte Heikkil=C3=A4 2022-09-28  1241  	=
				=09
>   work->conn->um);
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1242  			if
> (err)
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1243  				go=
to
> out2;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1244
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1245
> 			next[0] =3D '\0';
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1246
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1247  			err=
 =3D
> vfs_path_lookup(share_conf->vfs_path.dentry,
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1248  				=
=09
>  share_conf->vfs_path.mnt,
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1249  				=
=09
>  filepath,
> 265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1250  				=
=09
>  flags,
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1251  				=
=09
>  path);
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1252  			if
> (err)
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1253  				go=
to
> out2;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1254  			els=
e
> if (is_last)
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1255  				go=
to
> out1;
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1256
> 			path_put(parent_path);
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1257
> 			*parent_path =3D *path;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1258
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1259
> 			next[0] =3D '/';
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1260
> 			remain_len -=3D filename_len + 1;
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1261  		}
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1262
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1263  		err =
=3D
> -EINVAL;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1264  out2:
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1265
> 		path_put(parent_path);
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1266  out1:
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1267
> 		kfree(filepath);
> 3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1268  	}
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1269
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1270  	if
> (!err) {
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1271  		err =
=3D
> ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1272  		if
> (err) {
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1273
> 			path_put(path);
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1274
> 			path_put(parent_path);
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1275  		}
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1276  	}
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1277  	retur=
n
> err;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1278  }
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1279
>
> :::::: The code at line 1207 was first introduced by commit
> :::::: f44158485826c076335d6860d35872271a83791d cifsd: add file operation=
s
>
> :::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
> :::::: CC: Steve French <stfrench@microsoft.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E1797684
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjIGQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjIGQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BBE3A8D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD56EC433B9;
        Thu,  7 Sep 2023 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694081313;
        bh=Uvh3itFPi3f2rNpOz+0wOaEQRtpvKFcxcWUQaF3LklI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EtWqmmplqobrFkXZqA+C7sfxzPaEIL9Y22Fcnw9YpEvU2FEsElv/t+cy0s6+7mf1m
         bHrY6wtyiXtwsZ12km6c23k6cyvDWtlRqEkV/MjGcERAB3hc289tg2dJACy5uvBTTH
         YhU19WjlcM3/U14KPux3paYzq4EEHRmp5DYyB9/H7NEIJgcQ1QojzRfh/SYOtS9wCo
         LA7bSBlqWWGZ34OJwnsqNHXDbprUvWgiwqme1wFI1Hf0AtJP0WUBJuyNuf60Uah/YN
         mCzzU4voEA/JR07skPUB74LyKMTmBieFxHvGbDBU1TrqaTMDKLA6mQOQrbRgcY3kwR
         y4RNefNwkmlNA==
Message-ID: <84d2418526ca59f3c706eea27dee583ccf678c14.camel@kernel.org>
Subject: Re: [linus:master] [tmpfs]  d48c339729: ltp.mount03.fail
From:   Jeff Layton <jlayton@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org, ltp@lists.linux.it
Date:   Thu, 07 Sep 2023 06:08:31 -0400
In-Reply-To: <202309071017.a64aca5e-oliver.sang@intel.com>
References: <202309071017.a64aca5e-oliver.sang@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 10:59 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed "ltp.mount03.fail" on:
>=20
> commit: d48c3397291690c3576d6c983b0a86ecbc203cac ("tmpfs: add support for=
 multigrain timestamps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linus/master 708283abf896dd4853e673cc8cba70acaf9bf4ea]
> [test failed on linux-next/master a47fc304d2b678db1a5d760a7d644dac9b06775=
2]
>=20
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230715
> with following parameters:
>=20
> 	disk: 1HDD
> 	fs: f2fs
> 	test: syscalls-00/mount03
>=20
>=20
>=20
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz=
 (Ivy Bridge) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.san=
g@intel.com
>=20
>=20
> we also noticed this issue doesn't always happen, as below, on d48c339729=
,
> 13 out of 30 runs failed, while others can pass.
> and on parent commit, we didn't observe the failure on 30 runs.
>=20
> ffb6cf19e0633406 d48c3397291690c3576d6c983b0
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :30          43%          13:30    ltp.mount03.fail
>=20
>=20
> when failure happens, it shows
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on tmpfs =3D=3D=3D
> ...
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)
>=20
>=20
> when it pass:
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1693999383) > atime(1693999381)
>=20
>=20
> below detail log while running mount03:
>=20
> Running tests.......
> <<<test_start>>>
> tag=3Dmount03 stime=3D1694017062
> cmdline=3D"mount03"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
> tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:157: TINFO: Skipping vfat as requested by the te=
st
> tst_supported_fs_types.c:157: TINFO: Skipping exfat as requested by the t=
est
> tst_supported_fs_types.c:157: TINFO: Skipping ntfs as requested by the te=
st
> tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on ext2 =3D=3D=3D
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra o=
pts=3D''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dext2 flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017064)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017064)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017066) > atime(1694017064)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017064)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017067) > atime(1694017066)
> mount03.c:148: TPASS: dir_st.st_atime(1694017067) > dir_atime(1694017064)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on ext3 =3D=3D=3D
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra o=
pts=3D''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dext3 flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017068)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017068)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017070) > atime(1694017068)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017068)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017072) > atime(1694017070)
> mount03.c:148: TPASS: dir_st.st_atime(1694017072) > dir_atime(1694017068)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on ext4 =3D=3D=3D
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra o=
pts=3D''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dext4 flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017073)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017073)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017075) > atime(1694017073)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017073)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017076) > atime(1694017075)
> mount03.c:148: TPASS: dir_st.st_atime(1694017076) > dir_atime(1694017073)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on xfs =3D=3D=3D
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra op=
ts=3D''
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dxfs flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017077)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017077)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017080) > atime(1694017077)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017077)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017081) > atime(1694017080)
> mount03.c:148: TPASS: dir_st.st_atime(1694017081) > dir_atime(1694017077)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on btrfs =3D=3D=3D
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra =
opts=3D''
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dbtrfs flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017082)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017082)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017084) > atime(1694017082)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017082)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017085) > atime(1694017084)
> mount03.c:148: TPASS: dir_st.st_atime(1694017085) > dir_atime(1694017082)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: =3D=3D=3D Testing on tmpfs =3D=3D=3D
> tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) : EROFS =
(30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd =3D open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd=
6/LTP_mouxTci2R/mntpoint fstyp=3Dtmpfs flags=3D20
> mount03.c:74: TPASS: otfd =3D open(file, O_CREAT | O_RDWR, 0700) returned=
 fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime =3D=3D atime (1694017085)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017085)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017087) > atime(1694017086)
> mount03.c:154: TPASS: dir_st.st_atime =3D=3D dir_atime (1694017086)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)
> mount03.c:148: TPASS: dir_st.st_atime(1694017088) > dir_atime(1694017087)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTc=
i2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
>=20
> Summary:
> passed   113
> failed   1
> broken   0
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D26 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D5 cstime=3D284
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20230516-75-g2e582e743
>=20
>        ###############################################################
>=20
>             Done executing testcases.
>             LTP Version:  20230516-75-g2e582e743
>        ###############################################################
>=20
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230907/202309071017.a64aca5e-ol=
iver.sang@intel.com
>=20
>=20
>=20

I suspect what happened here is that the atime got updated to a fine-
grained value (possibly at create time), and then later got updated with
an earlier, coarse-grained value.

Probably we can just fix this by being more careful not to update unless
the new atime is later than the older one. I'll see if I can reproduce
it and come up with a fix.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

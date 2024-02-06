Return-Path: <linux-kernel+bounces-54473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C484AFA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED5BB24747
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5512B14A;
	Tue,  6 Feb 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgcR4LAG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855512A17C;
	Tue,  6 Feb 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206870; cv=none; b=eqXfYhRP6qrBM8XvxifVocSYaJFDQXdjCSY6xnwuCppfT1ncaOhzPxSG4do/4hYn6PG8FqlwuLuaM25Wj167KtiCgTxzqPejXotNb7dmGUbeWO8nRZvgku+3JHmQ5wQeY9oYl0TjGo9xf1drQdG5AvH5A2U13KklkObEM/BdZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206870; c=relaxed/simple;
	bh=0KdOyQP5YNXhdX6GF4oEK/J8Apn0951e5RTs3Ez0SZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+To6pPTOV6eTAbPC4owhme7vvqmkQISqGx1xRSjLO/xAbnJ9+og7XclL+AFNEL/hV15rerzE0ZGPK0tQdxor0RglXJrZyFnxE23MDYKEsg6jVMREuAa6rSivAjZuCt6cTJROuHwiVaEWv1DNCZzRGIC9h06tXUJjYcvRy1QE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgcR4LAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E5C433C7;
	Tue,  6 Feb 2024 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707206870;
	bh=0KdOyQP5YNXhdX6GF4oEK/J8Apn0951e5RTs3Ez0SZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RgcR4LAGY9tP1cmySGDRHutvU403efWJGrfe9/P9Ioc1r98kKKZOgK9LItwJPv1+l
	 mzSxq90Pxain9Jvax8nseuAxkQXmkl0IBnn3GsLpkf/W6Pw/2dNZirUlfRGc2BC1d6
	 MQGFnRaCnn9eVhE4BNRm1Ktn+J5jDlICHi2+BPU8zEvcc71cTPznjC+DTOZ1gGKrDO
	 Vxyz2fZbVWPJAWUVeTQOr/3P5mCIiezY+cEGZn/wEwmr4jfjYO9KMoKBu1Rvajh45k
	 tDwGUoUcO5h4wwjfcivN3OcgFUz8yYdMf4R/yxLrmdtbi04ZSMpUqKkoacLG0JdZ87
	 E8rjJ/1zTJK9g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0be2cc034so3301661fa.0;
        Tue, 06 Feb 2024 00:07:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxD2E9sagbYZ8bXBW1MYyJdMEzvH5tzLVClvcd/vEx12VQhlu1F
	HS3d1JIr/6y3pErf2OvPK9TrajpyMuXLGKfzkbrTW3+Lfs0bYFlEWiMZ+eSzJu/xheH+9EmQvxw
	OqrQZVNnjPbe13Xu6+OGN5eY1pJU=
X-Google-Smtp-Source: AGHT+IEqr/RMoaw1+tLSssWxsN2Qob/acBlyig1+T6sPks7geIvWPgti7f1gkRQQ2iVVMnUo8Tiw87wjfb6729oO38M=
X-Received: by 2002:a2e:3c16:0:b0:2d0:aca4:b955 with SMTP id
 j22-20020a2e3c16000000b002d0aca4b955mr1320750lja.48.1707206868601; Tue, 06
 Feb 2024 00:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com> <20240125203130.28187-1-dan@danm.net>
In-Reply-To: <20240125203130.28187-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Tue, 6 Feb 2024 00:07:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW58VdmZwigxP6t_fstkSDb34GB9+gTM0Sziet=n17HzQg@mail.gmail.com>
Message-ID: <CAPhsuW58VdmZwigxP6t_fstkSDb34GB9+gTM0Sziet=n17HzQg@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>
Cc: junxiao.bi@oracle.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:31=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> Hi Junxiao,
>
> I first noticed this problem the next day after I had upgraded some
> machines to the 6.7.1 kernel. One of the machines is a backup server.
> Just a few hours after the upgrade to 6.7.1, it started running its
> overnight backup jobs. Those backup jobs hung part way through. When I
> tried to check on the backups in the morning, I found the server
> mostly unresponsive. I could SSH in but most shell commands would just
> hang. I was able to run top and see that the md0_raid5 kernel thread
> was using 100% CPU. I tried to reboot the server, but it wasn't able
> to successfully shutdown and eventually I had to hard reset it.
>
> The next day, the same sequence of events occurred on that server
> again when it tried to run its backup jobs. Then the following day, I
> experienced another hang on a different machine, with a similar RAID-5
> configuration. That time I was scp'ing a large file to a virtual
> machine whose image was stored on the RAID-5 array. Part way through
> the transfer scp reported that the transfer had stalled. I checked top
> on that machine and found once again that the md0_raid5 kernel thread
> was using 100% CPU.
>
> Yesterday I created a fresh Fedora 39 VM for the purposes of
> reproducing this problem in a different environment (the other two
> machines are both Gentoo servers running v6.7 kernels straight from
> the stable trees with a custom kernel configuration). I am able to
> reproduce the problem on Fedora 39 running both the v6.6.13 stable
> tree kernel code and the Fedora 39 6.6.13 distribution kernel.
>
> On this Fedora 39 VM, I created a 1GiB LVM volume to use as the RAID-5
> journal from space on the "boot" disk. Then I attached 3 additional
> 100 GiB virtual disks and created the RAID-5 from those 3 disks and
> the write-journal device. I then created a new LVM volume group from
> the md0 array and created one LVM logical volume named "data", using
> all but 64GiB of the available VG space. I then created an ext4 file
> system on the "data" volume, mounted it, and used "dd" to copy 1MiB
> blocks from /dev/urandom to a file on the "data" file system, and just
> let it run. Eventually "dd" hangs and top shows that md0_raid5 is
> using 100% CPU.
>
> Here is an example command I just ran, which has hung after writing
> 4.1 GiB of random data to the array:
>
> test@localhost:~$ dd if=3D/dev/urandom bs=3D1M of=3D/data/random.dat stat=
us=3Dprogress
> 4410310656 bytes (4.4 GB, 4.1 GiB) copied, 324 s, 13.6 MB/s

Update on this..

I haven't been testing the following config md-6.9 branch [1].
The array works fine afaict.

Dan, could you please run the test on this branch
(83cbdaf61b1ab9cdaa0321eeea734bc70ca069c8)?

Thanks,
Song


[1] https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd=
-6.9

[root@eth50-1 ~]# lsblk
NAME                             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sr0                               11:0    1 1024M  0 rom
vda                              253:0    0   32G  0 disk
=E2=94=9C=E2=94=80vda1                           253:1    0    2G  0 part  =
/boot
=E2=94=94=E2=94=80vda2                           253:2    0   30G  0 part  =
/
nvme2n1                          259:0    0   50G  0 disk
=E2=94=94=E2=94=80md0                              9:0    0  100G  0 raid5
  =E2=94=9C=E2=94=80vg--md--data-md--data-real   250:2    0   50G  0 lvm
  =E2=94=82 =E2=94=9C=E2=94=80vg--md--data-md--data      250:1    0   50G  =
0 lvm   /mnt/2
  =E2=94=82 =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  =
0 lvm
  =E2=94=94=E2=94=80vg--md--data-snap-cow        250:3    0   49G  0 lvm
    =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  0 lvm
nvme0n1                          259:1    0   50G  0 disk
=E2=94=94=E2=94=80md0                              9:0    0  100G  0 raid5
  =E2=94=9C=E2=94=80vg--md--data-md--data-real   250:2    0   50G  0 lvm
  =E2=94=82 =E2=94=9C=E2=94=80vg--md--data-md--data      250:1    0   50G  =
0 lvm   /mnt/2
  =E2=94=82 =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  =
0 lvm
  =E2=94=94=E2=94=80vg--md--data-snap-cow        250:3    0   49G  0 lvm
    =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  0 lvm
nvme1n1                          259:2    0   50G  0 disk
=E2=94=94=E2=94=80md0                              9:0    0  100G  0 raid5
  =E2=94=9C=E2=94=80vg--md--data-md--data-real   250:2    0   50G  0 lvm
  =E2=94=82 =E2=94=9C=E2=94=80vg--md--data-md--data      250:1    0   50G  =
0 lvm   /mnt/2
  =E2=94=82 =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  =
0 lvm
  =E2=94=94=E2=94=80vg--md--data-snap-cow        250:3    0   49G  0 lvm
    =E2=94=94=E2=94=80vg--md--data-snap          250:4    0   50G  0 lvm
nvme4n1                          259:3    0    2G  0 disk
nvme3n1                          259:4    0   50G  0 disk
=E2=94=94=E2=94=80vg--data-lv--journal           250:0    0  512M  0 lvm
  =E2=94=94=E2=94=80md0                            9:0    0  100G  0 raid5
    =E2=94=9C=E2=94=80vg--md--data-md--data-real 250:2    0   50G  0 lvm
    =E2=94=82 =E2=94=9C=E2=94=80vg--md--data-md--data    250:1    0   50G  =
0 lvm   /mnt/2
    =E2=94=82 =E2=94=94=E2=94=80vg--md--data-snap        250:4    0   50G  =
0 lvm
    =E2=94=94=E2=94=80vg--md--data-snap-cow      250:3    0   49G  0 lvm
      =E2=94=94=E2=94=80vg--md--data-snap        250:4    0   50G  0 lvm
nvme5n1                          259:5    0    2G  0 disk
nvme6n1                          259:6    0    4G  0 disk
[root@eth50-1 ~]# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
md0 : active raid5 nvme2n1[4] dm-0[3](J) nvme1n1[1] nvme0n1[0]
      104790016 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UU=
U]

unused devices: <none>
[root@eth50-1 ~]# mount | grep /mnt/2
/dev/mapper/vg--md--data-md--data on /mnt/2 type ext4 (rw,relatime,stripe=
=3D256)


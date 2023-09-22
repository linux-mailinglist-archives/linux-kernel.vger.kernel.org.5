Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046997AAD2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjIVIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:53:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208799;
        Fri, 22 Sep 2023 01:53:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1ff5b741cso17175165ad.2;
        Fri, 22 Sep 2023 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695372790; x=1695977590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmDcovxKvO6RGlBrllGnpgrERZDZ08169YqpcOuuzVw=;
        b=gLoXiVK4nC0zQDQ/chG76nc5yVDOBlCMqkbFIqbdp9AwAKnX/alVQKg41PjieUO88J
         q+7Bq3Fqdd/HLGuryUEunJ3oRtAq+LSMp7gGJfm/Cy3Xyhr3E8fgc+jAaAWFdsm1VEWh
         tIh5cxxRS7iBQYRevzVfHY3t4ecuRnTj6f/H7dZ12/2vDffGU6ZegDvVmddqfKgYUCsS
         sVXJg2jZ4ll6xwoD4Y+l/H7bGZxUYcD9dfjHbPcyUuiGtxoHuMs7ce7ysJmlhlibsiZn
         Pg2HBQ2OVg2P0EZGcIiZXg8bsIKFPUmkSas3YQQOLP0x/nggIdIIOEItTJl9LCFYFLRa
         K58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372790; x=1695977590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmDcovxKvO6RGlBrllGnpgrERZDZ08169YqpcOuuzVw=;
        b=t+JoqWz0kxRy9+D4wAmJvzaAlJrvILyQbY3Lwf+frnfPY9i5Rs4LhftjStf/mgVgPW
         uOXs6s+wdlqqkpSQxSCBRgcDbecZezgaoqPe8QdAQSww7iQgxmPHYyVCOc2lGSEG7+vG
         7M2cod74qZ8WiBgdLoCl4HDbLPcuxXMC66rnKZAT/f16isGgYV+ZPvp9ShQuJWjGTmBj
         l8VY43lxwa3jPMeYS/PnU6Vg4e5FMJBNSUaJu2rooZeo0PQ3Za7znIheRkFBe4Oc6M/N
         lojI6QRHuamJfQV3KysoYxWkjk4ew7yCi5rnA5BITsplEpVL6Q3OD1QHPgwwuK4Xajkq
         Py9g==
X-Gm-Message-State: AOJu0YwemcYPN8wpAQN9IuZwGaUEdYMYFhDwkGL7sBMSvPmxAzEFZZBg
        +7t8OpLUGyNX2zrxV5ceoi57aAjIDwU=
X-Google-Smtp-Source: AGHT+IEPKyWNSGrewvC5a67oYrqAAbBav4kJG0DkCzoDLAWACqbFkza++XFW6a39FBqODDtrcE4uBw==
X-Received: by 2002:a17:902:e812:b0:1c0:7e86:4f6 with SMTP id u18-20020a170902e81200b001c07e8604f6mr8915200plg.14.1695372790246;
        Fri, 22 Sep 2023 01:53:10 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090282c200b001bc445e2497sm2916011plz.79.2023.09.22.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:53:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E0E1A81B96C9; Fri, 22 Sep 2023 15:53:06 +0700 (WIB)
Date:   Fri, 22 Sep 2023 15:53:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Changhui Zhong <czhong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Devices <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report] RIP: 0010:throtl_trim_slice+0xc6/0x320 caused
 kernel panic
Message-ID: <ZQ1V8rcSdKg_Jfgh@debian.me>
References: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DThIrotSsoUQK5EI"
Content-Disposition: inline
In-Reply-To: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DThIrotSsoUQK5EI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 10:10:45AM +0800, Changhui Zhong wrote:
> Hello,
>=20
> triggered below issue with branch 'for-next',please help check,
>=20
> INFO: HEAD of cloned kernel:
> commit d975b468819a142a49c8e7db83feb07c3018c550
> Merge: 58fac6aac7a2 df137dff93fc
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Sep 13 13:16:19 2023 -0600
>=20
>     Merge branch 'io_uring-futex' into for-next
>=20
>     * io_uring-futex:
>       io_uring: add support for vectored futex waits
>       futex: make the vectored futex operations available
>       futex: make futex_parse_waitv() available as a helper
>       futex: add wake_data to struct futex_q
>       io_uring: add support for futex wake and wait
>       futex: abstract out a __futex_wake_mark() helper
>       futex: factor out the futex wake handling
>       futex: move FUTEX2_VALID_MASK to futex.h
>       futex: Validate futex value against futex size
>       futex: Flag conversion
>       futex: Extend the FUTEX2 flags
>       futex: Clarify FUTEX2 flags
>=20
>=20
> reproduce steps:
> echo "+cpuset +cpu +io" > /sys/fs/cgroup/cgroup.subtree_control
> mkdir /sys/fs/cgroup/test
> MAJ=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $1}' | awk -F ' ' '{print=
 $NF}')
> MIN=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $2}' | awk -F ' ' '{print=
 $1}')
> echo "$MAJ:$MIN wbps=3D1024" > /sys/fs/cgroup/test/io.max
> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> wait
>=20
> console log:
> [ 1979.303330] divide error: 0000 [#1] PREEMPT SMP NOPTI
> [ 1979.308393] CPU: 28 PID: 0 Comm: swapper/28 Not tainted 6.6.0-rc1+ #1
> [ 1979.314837] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS
> 2.6.6 01/13/2022
> [ 1979.322402] RIP: 0010:throtl_trim_slice+0xc6/0x320
> [ 1979.327195] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> ff ff
> [ 1979.345942] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> [ 1979.351169] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 000000000=
00003e8
> [ 1979.358300] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f548=
6a99800
> [ 1979.365435] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f565=
a67b818
> [ 1979.372565] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 000000000=
0000001
> [ 1979.379698] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 000000000=
0000021
> [ 1979.386833] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> knlGS:0000000000000000
> [ 1979.394916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1979.400663] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 000000000=
0350ee0
> [ 1979.407797] Call Trace:
> [ 1979.410250]  <IRQ>
> [ 1979.412270]  ? die+0x33/0x90
> [ 1979.415157]  ? do_trap+0xe0/0x110
> [ 1979.418476]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.422662]  ? do_error_trap+0x65/0x80
> [ 1979.426412]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.430600]  ? exc_divide_error+0x36/0x50
> [ 1979.434612]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.438800]  ? asm_exc_divide_error+0x16/0x20
> [ 1979.443163]  ? throtl_trim_slice+0xc6/0x320
> [ 1979.447347]  tg_dispatch_one_bio+0xf0/0x1e0
> [ 1979.451533]  throtl_pending_timer_fn+0x1e5/0x510
> [ 1979.456152]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> [ 1979.461287]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> [ 1979.466427]  call_timer_fn+0x27/0x130
> [ 1979.470096]  __run_timers.part.0+0x1ee/0x280
> [ 1979.474368]  ? srso_return_thunk+0x5/0x10
> [ 1979.478379]  ? __hrtimer_run_queues+0x121/0x2b0
> [ 1979.482914]  ? srso_return_thunk+0x5/0x10
> [ 1979.486925]  ? srso_return_thunk+0x5/0x10
> [ 1979.490939]  ? srso_return_thunk+0x5/0x10
> [ 1979.494953]  run_timer_softirq+0x26/0x50
> [ 1979.498878]  __do_softirq+0xcb/0x2ab
> [ 1979.502459]  __irq_exit_rcu+0xa1/0xc0
> [ 1979.506124]  sysvec_apic_timer_interrupt+0x72/0x90
> [ 1979.510917]  </IRQ>
> [ 1979.513021]  <TASK>
> [ 1979.515128]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 1979.520265] RIP: 0010:mwait_idle+0x4f/0x70
> [ 1979.524365] Code: 31 d2 48 89 d1 65 48 8b 04 25 80 18 03 00 0f 01
> c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 96 f3 36 00 31 c0 48 89 c1 fb
> 0f 01 c9 <fa> 65 48 8b 04 25 80 18 03 00 f0 80 60 02 df e9 6d 3f 01 00
> 0f ae
> [ 1979.543111] RSP: 0018:ffffadf9c04a7ed0 EFLAGS: 00000246
> [ 1979.548338] RAX: 0000000000000000 RBX: ffff8f548019cd40 RCX: 000000000=
0000000
> [ 1979.555471] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 000000000=
016e484
> [ 1979.562605] RBP: 0000000000000000 R08: ffff8f5677d22a80 R09: 000000000=
0000000
> [ 1979.569738] R10: 00000000000001dc R11: 0000000000000000 R12: 000000000=
0000000
> [ 1979.576868] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [ 1979.584009]  default_idle_call+0x28/0xd0
> [ 1979.587938]  cpuidle_idle_call+0x125/0x160
> [ 1979.592036]  ? sched_clock_cpu+0xb/0x190
> [ 1979.595963]  do_idle+0x7b/0xe0
> [ 1979.599022]  cpu_startup_entry+0x19/0x20
> [ 1979.602949]  start_secondary+0x115/0x140
> [ 1979.606875]  secondary_startup_64_no_verify+0x17d/0x18b
> [ 1979.612104]  </TASK>
> [ 1979.614293] Modules linked in: binfmt_misc dm_crypt raid10 raid1
> raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
> async_xor xor async_tx raid6_pq loop tls rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc
> dm_multipath ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac
> edac_mce_amd kvm_amd kvm mgag200 i2c_algo_bit dcdbas acpi_ipmi
> drm_shmem_helper irqbypass ipmi_si drm_kms_helper dell_smbios rapl
> wmi_bmof pcspkr dell_wmi_descriptor ipmi_devintf k10temp ptdma
> i2c_piix4 ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c
> sd_mod t10_pi sg ahci libahci crct10dif_pclmul crc32_pclmul
> crc32c_intel libata ghash_clmulni_intel tg3 ccp sp5100_tco wmi
> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> [ 1979.681931] ---[ end trace 0000000000000000 ]---
> [ 1979.706620] pstore: backend (erst) writing error (-22)
> [ 1979.711761] RIP: 0010:throtl_trim_slice+0xc6/0x320
> [ 1979.716555] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> ff ff
> [ 1979.735301] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> [ 1979.740527] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 000000000=
00003e8
> [ 1979.747659] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f548=
6a99800
> [ 1979.754793] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f565=
a67b818
> [ 1979.761924] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 000000000=
0000001
> [ 1979.769056] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 000000000=
0000021
> [ 1979.776190] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> knlGS:0000000000000000
> [ 1979.784278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1979.790023] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 000000000=
0350ee0
> [ 1979.797155] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1979.805797] Kernel Offset: 0x30600000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1979.835382] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
>=20

Does v6.6-rc2 have this issue? v6.5?

--=20
An old man doll... just what I always wanted! - Clara

--DThIrotSsoUQK5EI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQ1V4QAKCRD2uYlJVVFO
o+p5AP9XCYsKKf8KIaxJM31rHVVfInEfE26wXar/0Vm05I5AWwEAotCgSwzMmfTV
jvzkNU6xMeLymT8Q2qJpTfqfBaZgagM=
=UZ9I
-----END PGP SIGNATURE-----

--DThIrotSsoUQK5EI--

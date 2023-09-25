Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18F7AD323
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjIYIRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIYIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2AA2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695629814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmlqEOKzieyMrOvJcNEFQN/QkumuwvpMNjsVbZv5/HM=;
        b=A0E2xw1dM5tWNWFIzjADECi+DkqE9aBZN9n67sVh0lUlYFitj1uliq2XfT7KretquDt2Lp
        KZQMHiMemRxE2Dd7/bDrZv8fE7Qd0XAYCs7J9el1Oi9VGUKMQXGZhS6c2eHetLEfOy+/My
        rxR3q4U8q6eDNHhS5ApVa8FjMqlwhM4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rPlW3u1pOHGKVy-Lpz0GPw-1; Mon, 25 Sep 2023 04:16:53 -0400
X-MC-Unique: rPlW3u1pOHGKVy-Lpz0GPw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27731a63481so4767707a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629812; x=1696234612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmlqEOKzieyMrOvJcNEFQN/QkumuwvpMNjsVbZv5/HM=;
        b=fpmyC8vwwWiErDnhK0WfRzIMzbGQCaw3S9+Aov1mlNaOJf3DJ+7ckPmg7n5o+ceIgt
         uTjN2mwK51NDcHpOq8kAq5FkMO5P2PJUPBhUKtu+RknEHbBp3FhmuNFI3AcVIS73wouQ
         PYJXwaq/oMrrPqJP1O1o7uo3u8RBkCMTn8cGvrZ7Dh+k1OzlVe6+5dBcHa22zqa2QkDd
         9dkrBAOmRcZjCi7surjTMi7jbTIi957dL/7POBJZZb/ztXtbdimC0nCBZ1P8r5KjlJ5D
         +kO63qIEVIZKgvICRQbCkC2WcFb7PxPH+52ANJtctnuKDsPueAi2nH9iUT2wfhjnEn94
         fxNQ==
X-Gm-Message-State: AOJu0Yx3Sg7CDnKzIgveyg7H2OOI8akADDfeavZK5cV/8fehar8sABrF
        G1fUy1FbfETXB08cbIm7cOif0PfYmQIM2x63Fx4TGWfRt8Pi3HsKSVDuZqvditm9ePFTOQNV0pN
        ngBcGn1Bp+GNEcj73g34SNmwI2Feq5lNaL98ZTArc
X-Received: by 2002:a17:90a:de90:b0:274:84a2:f0d8 with SMTP id n16-20020a17090ade9000b0027484a2f0d8mr5701887pjv.25.1695629812095;
        Mon, 25 Sep 2023 01:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPkrY91pdKyMizFE5ZTjKreSpR3IuqXGoU/iKRTJoYRRIPH+VZqK5GDcCivbhlh07Kg/4/0P3axh+gDEI6bo8=
X-Received: by 2002:a17:90a:de90:b0:274:84a2:f0d8 with SMTP id
 n16-20020a17090ade9000b0027484a2f0d8mr5701873pjv.25.1695629811716; Mon, 25
 Sep 2023 01:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
 <ZQ1V8rcSdKg_Jfgh@debian.me>
In-Reply-To: <ZQ1V8rcSdKg_Jfgh@debian.me>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 25 Sep 2023 16:16:40 +0800
Message-ID: <CAGVVp+WXNpAb8_6BHKB9t9TwAuoxwNi8j7wpjxeQBQ_TjW+etw@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:throtl_trim_slice+0xc6/0x320 caused kernel panic
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Devices <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:53=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Fri, Sep 22, 2023 at 10:10:45AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > triggered below issue with branch 'for-next',please help check,
> >
> > INFO: HEAD of cloned kernel:
> > commit d975b468819a142a49c8e7db83feb07c3018c550
> > Merge: 58fac6aac7a2 df137dff93fc
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed Sep 13 13:16:19 2023 -0600
> >
> >     Merge branch 'io_uring-futex' into for-next
> >
> >     * io_uring-futex:
> >       io_uring: add support for vectored futex waits
> >       futex: make the vectored futex operations available
> >       futex: make futex_parse_waitv() available as a helper
> >       futex: add wake_data to struct futex_q
> >       io_uring: add support for futex wake and wait
> >       futex: abstract out a __futex_wake_mark() helper
> >       futex: factor out the futex wake handling
> >       futex: move FUTEX2_VALID_MASK to futex.h
> >       futex: Validate futex value against futex size
> >       futex: Flag conversion
> >       futex: Extend the FUTEX2 flags
> >       futex: Clarify FUTEX2 flags
> >
> >
> > reproduce steps:
> > echo "+cpuset +cpu +io" > /sys/fs/cgroup/cgroup.subtree_control
> > mkdir /sys/fs/cgroup/test
> > MAJ=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $1}' | awk -F ' ' '{pri=
nt $NF}')
> > MIN=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $2}' | awk -F ' ' '{pri=
nt $1}')
> > echo "$MAJ:$MIN wbps=3D1024" > /sys/fs/cgroup/test/io.max
> > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > wait
> >
> > console log:
> > [ 1979.303330] divide error: 0000 [#1] PREEMPT SMP NOPTI
> > [ 1979.308393] CPU: 28 PID: 0 Comm: swapper/28 Not tainted 6.6.0-rc1+ #=
1
> > [ 1979.314837] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS
> > 2.6.6 01/13/2022
> > [ 1979.322402] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 1979.327195] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 1979.345942] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> > [ 1979.351169] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 0000000=
0000003e8
> > [ 1979.358300] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5=
486a99800
> > [ 1979.365435] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f5=
65a67b818
> > [ 1979.372565] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000=
000000001
> > [ 1979.379698] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 1979.386833] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> > knlGS:0000000000000000
> > [ 1979.394916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1979.400663] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000=
000350ee0
> > [ 1979.407797] Call Trace:
> > [ 1979.410250]  <IRQ>
> > [ 1979.412270]  ? die+0x33/0x90
> > [ 1979.415157]  ? do_trap+0xe0/0x110
> > [ 1979.418476]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.422662]  ? do_error_trap+0x65/0x80
> > [ 1979.426412]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.430600]  ? exc_divide_error+0x36/0x50
> > [ 1979.434612]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.438800]  ? asm_exc_divide_error+0x16/0x20
> > [ 1979.443163]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.447347]  tg_dispatch_one_bio+0xf0/0x1e0
> > [ 1979.451533]  throtl_pending_timer_fn+0x1e5/0x510
> > [ 1979.456152]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 1979.461287]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 1979.466427]  call_timer_fn+0x27/0x130
> > [ 1979.470096]  __run_timers.part.0+0x1ee/0x280
> > [ 1979.474368]  ? srso_return_thunk+0x5/0x10
> > [ 1979.478379]  ? __hrtimer_run_queues+0x121/0x2b0
> > [ 1979.482914]  ? srso_return_thunk+0x5/0x10
> > [ 1979.486925]  ? srso_return_thunk+0x5/0x10
> > [ 1979.490939]  ? srso_return_thunk+0x5/0x10
> > [ 1979.494953]  run_timer_softirq+0x26/0x50
> > [ 1979.498878]  __do_softirq+0xcb/0x2ab
> > [ 1979.502459]  __irq_exit_rcu+0xa1/0xc0
> > [ 1979.506124]  sysvec_apic_timer_interrupt+0x72/0x90
> > [ 1979.510917]  </IRQ>
> > [ 1979.513021]  <TASK>
> > [ 1979.515128]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [ 1979.520265] RIP: 0010:mwait_idle+0x4f/0x70
> > [ 1979.524365] Code: 31 d2 48 89 d1 65 48 8b 04 25 80 18 03 00 0f 01
> > c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 96 f3 36 00 31 c0 48 89 c1 fb
> > 0f 01 c9 <fa> 65 48 8b 04 25 80 18 03 00 f0 80 60 02 df e9 6d 3f 01 00
> > 0f ae
> > [ 1979.543111] RSP: 0018:ffffadf9c04a7ed0 EFLAGS: 00000246
> > [ 1979.548338] RAX: 0000000000000000 RBX: ffff8f548019cd40 RCX: 0000000=
000000000
> > [ 1979.555471] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 0000000=
00016e484
> > [ 1979.562605] RBP: 0000000000000000 R08: ffff8f5677d22a80 R09: 0000000=
000000000
> > [ 1979.569738] R10: 00000000000001dc R11: 0000000000000000 R12: 0000000=
000000000
> > [ 1979.576868] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> > [ 1979.584009]  default_idle_call+0x28/0xd0
> > [ 1979.587938]  cpuidle_idle_call+0x125/0x160
> > [ 1979.592036]  ? sched_clock_cpu+0xb/0x190
> > [ 1979.595963]  do_idle+0x7b/0xe0
> > [ 1979.599022]  cpu_startup_entry+0x19/0x20
> > [ 1979.602949]  start_secondary+0x115/0x140
> > [ 1979.606875]  secondary_startup_64_no_verify+0x17d/0x18b
> > [ 1979.612104]  </TASK>
> > [ 1979.614293] Modules linked in: binfmt_misc dm_crypt raid10 raid1
> > raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
> > async_xor xor async_tx raid6_pq loop tls rpcsec_gss_krb5 auth_rpcgss
> > nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc
> > dm_multipath ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac
> > edac_mce_amd kvm_amd kvm mgag200 i2c_algo_bit dcdbas acpi_ipmi
> > drm_shmem_helper irqbypass ipmi_si drm_kms_helper dell_smbios rapl
> > wmi_bmof pcspkr dell_wmi_descriptor ipmi_devintf k10temp ptdma
> > i2c_piix4 ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c
> > sd_mod t10_pi sg ahci libahci crct10dif_pclmul crc32_pclmul
> > crc32c_intel libata ghash_clmulni_intel tg3 ccp sp5100_tco wmi
> > dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> > [ 1979.681931] ---[ end trace 0000000000000000 ]---
> > [ 1979.706620] pstore: backend (erst) writing error (-22)
> > [ 1979.711761] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 1979.716555] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 1979.735301] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> > [ 1979.740527] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 0000000=
0000003e8
> > [ 1979.747659] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5=
486a99800
> > [ 1979.754793] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f5=
65a67b818
> > [ 1979.761924] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000=
000000001
> > [ 1979.769056] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 1979.776190] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> > knlGS:0000000000000000
> > [ 1979.784278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1979.790023] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000=
000350ee0
> > [ 1979.797155] Kernel panic - not syncing: Fatal exception in interrupt
> > [ 1979.805797] Kernel Offset: 0x30600000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [ 1979.835382] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> >
>
> Does v6.6-rc2 have this issue? v6.5?
>

v6.6-rc2 have this issue too,

[ 1987.693190] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 6.6.0-rc2+ #1
[ 1987.699452] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS
2.6.6 01/13/2022
[ 1987.707022] RIP: 0010:throtl_trim_slice+0xc6/0x320
[ 1987.711821] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
ff ff
[ 1987.730568] RSP: 0018:ffffa2be407e8dc0 EFLAGS: 00010847
[ 1987.735792] RAX: ffffffffffffd8f0 RBX: ffff8f6e85ad5800 RCX: 00000000000=
003e8
[ 1987.742927] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f6e85a=
d5800
[ 1987.750058] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f6e857=
35018
[ 1987.757191] R10: ffff8f6e85ad5810 R11: ffff8f6e85735030 R12: 00000000000=
00001
[ 1987.764323] R13: ffff8f6e85ad5808 R14: 0000000000000001 R15: 00000000000=
00021
[ 1987.771458] FS:  0000000000000000(0000) GS:ffff8f7077a00000(0000)
knlGS:0000000000000000
[ 1987.779543] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1987.785290] CR2: 0000559c2e11aae0 CR3: 000000010aa8e000 CR4: 00000000003=
50ee0
[ 1987.792424] Call Trace:
[ 1987.794877]  <IRQ>
[ 1987.796898]  ? die+0x33/0x90
[ 1987.799782]  ? do_trap+0xe0/0x110
[ 1987.803101]  ? throtl_trim_slice+0xc6/0x320
[ 1987.807289]  ? do_error_trap+0x65/0x80
[ 1987.811040]  ? throtl_trim_slice+0xc6/0x320
[ 1987.815226]  ? exc_divide_error+0x36/0x50
[ 1987.819239]  ? throtl_trim_slice+0xc6/0x320
[ 1987.823426]  ? asm_exc_divide_error+0x16/0x20
[ 1987.827790]  ? throtl_trim_slice+0xc6/0x320
[ 1987.831982]  tg_dispatch_one_bio+0xf0/0x1e0
[ 1987.836167]  throtl_pending_timer_fn+0x1e5/0x510
[ 1987.840786]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
[ 1987.845924]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
[ 1987.851063]  call_timer_fn+0x27/0x130
[ 1987.854730]  __run_timers.part.0+0x1ee/0x280
[ 1987.859004]  ? srso_return_thunk+0x5/0x10
[ 1987.863014]  ? __hrtimer_run_queues+0x121/0x2b0
[ 1987.867548]  ? srso_return_thunk+0x5/0x10
[ 1987.871559]  ? srso_return_thunk+0x5/0x10
[ 1987.875574]  ? srso_return_thunk+0x5/0x10
[ 1987.879586]  run_timer_softirq+0x26/0x50
[ 1987.883513]  __do_softirq+0xcb/0x2ab
[ 1987.887093]  __irq_exit_rcu+0xa1/0xc0
[ 1987.890756]  sysvec_apic_timer_interrupt+0x72/0x90
[ 1987.895550]  </IRQ>
[ 1987.897656]  <TASK>
[ 1987.899763]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 1987.904902] RIP: 0010:mwait_idle+0x4f/0x70
[ 1987.909002] Code: 31 d2 48 89 d1 65 48 8b 04 25 c0 18 03 00 0f 01
c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 96 03 37 00 31 c0 48 89 c1 fb
0f 01 c9 <fa> 65 48 8b 04 25 c0 18 03 00 f0 80 60 02 df e9 6d 3f 01 00
0f ae
[ 1987.927747] RSP: 0018:ffffa2be402f7ed0 EFLAGS: 00000246
[ 1987.932972] RAX: 0000000000000000 RBX: ffff8f6e80120000 RCX: 00000000000=
00000
[ 1987.940104] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 00000000001=
68424
[ 1987.947237] RBP: 0000000000000000 R08: ffff8f7077a22ac0 R09: 00000000000=
00000
[ 1987.954372] R10: 0000000000000400 R11: 0000000000000000 R12: 00000000000=
00000
[ 1987.961505] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 1987.968640]  default_idle_call+0x28/0xd0
[ 1987.972563]  cpuidle_idle_call+0x125/0x160
[ 1987.976662]  ? sched_clock_cpu+0xb/0x190
[ 1987.980588]  do_idle+0x7b/0xe0
[ 1987.983650]  cpu_startup_entry+0x26/0x30
[ 1987.987575]  start_secondary+0x115/0x140
[ 1987.991501]  secondary_startup_64_no_verify+0x17d/0x18b
[ 1987.996733]  </TASK>
[ 1987.998920] Modules linked in: binfmt_misc dm_crypt raid10 raid1
raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
async_xor xor async_tx raid6_pq loop rfkill sunrpc dm_multipath
ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd
kvm_amd kvm mgag200 dcdbas i2c_algo_bit acpi_ipmi drm_shmem_helper
ipmi_si irqbypass dell_smbios drm_kms_helper ipmi_devintf rapl
wmi_bmof dell_wmi_descriptor pcspkr i2c_piix4 ptdma k10temp
ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod t10_pi
sg ahci libahci crct10dif_pclmul crc32_pclmul crc32c_intel libata
ghash_clmulni_intel tg3 ccp sp5100_tco wmi dm_mirror dm_region_hash
dm_log dm_mod [last unloaded: scsi_debug]
[ 1988.059529] ---[ end trace 0000000000000000 ]---
[ 1988.092310] RIP: 0010:throtl_trim_slice+0xc6/0x320
[ 1988.097106] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
ff ff
[ 1988.115854] RSP: 0018:ffffa2be407e8dc0 EFLAGS: 00010847
[ 1988.121078] RAX: ffffffffffffd8f0 RBX: ffff8f6e85ad5800 RCX: 00000000000=
003e8
[ 1988.128211] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f6e85a=
d5800
[ 1988.135345] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f6e857=
35018
[ 1988.142477] R10: ffff8f6e85ad5810 R11: ffff8f6e85735030 R12: 00000000000=
00001
[ 1988.149609] R13: ffff8f6e85ad5808 R14: 0000000000000001 R15: 00000000000=
00021
[ 1988.156741] FS:  0000000000000000(0000) GS:ffff8f7077a00000(0000)
knlGS:0000000000000000
[ 1988.164830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1988.170574] CR2: 0000559c2e11aae0 CR3: 000000010aa8e000 CR4: 00000000003=
50ee0
[ 1988.177707] Kernel panic - not syncing: Fatal exception in interrupt
[ 1988.185995] Kernel Offset: 0x19400000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1988.217854] pstore: backend (erst) writing error (-22)
[ 1988.222993] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86F7838A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjHVDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHVDyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:54:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FA187
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:54:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso2888585a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692676480; x=1693281280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFx79Ng7ajz5OjNQeJkWLfHWi/51nTFCrOxXIAQQ8UU=;
        b=shXcRT1CZBBJS6kdTHeiEl+vvjKwl4JdgjlM7w9DUbJsJkWX2+DfayGXMTwehQd/3H
         DsVV2PI0NZm26m2Op9Ttng5wOUJYViViD6rPZXVox4gxzzQxe4V3L7MYQiDZeVmRxNDm
         XjnrCekg+KV7PI0YPFHJSapZZ/eBClxJhLLdk7sBqwcpaYdLdFBau3CF9awyqEwlcnU6
         1FqlEPJT+k3idr+DD9cqYN8OZcnJj+5Xw6WU+lb6hEtvl3crEtWFybMRmfhBL716/B7L
         aKSM1R8nc4pi0eUAAxz3F9oPeC7QxceK7cZiiBvB6Xx60utEQJIRSJVPMM02Cg+DamZC
         j6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692676480; x=1693281280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFx79Ng7ajz5OjNQeJkWLfHWi/51nTFCrOxXIAQQ8UU=;
        b=CzVY9RpXhWRZSZrTvHREsObQQxekOSomdgD2g04dbH1vb3eN1UNc6/r+f/OKyGFHGW
         11G4N6NrKCrTPeR2wcTF8jk7c41uYo8HfadZgdHWYjua+YIWqy4yX10/+zORdkjPwq/F
         5qC5OZrubdGAvPQ59Z7fiJuTIuyhVLCBoHg1LfEwhpbqNyVLypP7A9bcP2iZSFrkBPkg
         Qvv6U2pYNbxzPP/H6d9kD+Jq3fzp7V22rRyyrCvWjM6trgHrq8J4/gFnV9RkYDpD/vN6
         H2jXL8nzANxSPf174UNjj9xMjbTdwl6chhkRXwCf/4FTMt6Ze8jwvuSMmOwxVAsglNKH
         a8wg==
X-Gm-Message-State: AOJu0Yz+8hBmQ9CcoBG9JU4LA2mdiiHuXijOfynU5LmdMUfhNLVNeXul
        +sA4cJO1sJqo+O/RvFWasc6PLUq2c2/rEHgezfA=
X-Google-Smtp-Source: AGHT+IFczFPQ+yZe5iIs4GSa7j8507smk9FI4G8xCQ5D4jZH9/+3t/3yurn7FTBzRBVoBa4SaY1MLW7UYcMCptfopx8=
X-Received: by 2002:a17:90b:1486:b0:26c:e606:f455 with SMTP id
 js6-20020a17090b148600b0026ce606f455mr7319264pjb.36.1692676479770; Mon, 21
 Aug 2023 20:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv> <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv> <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
From:   Alexander Kamensky <alexander.kamensky42@gmail.com>
Date:   Mon, 21 Aug 2023 20:54:28 -0700
Message-ID: <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64 platform
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the top post, but I believe that I might have posted a fix
for this issue a couple days ago.

Please check and see if it helps
https://lore.kernel.org/kexec/20230819191119.975299-1-alexander.kamensky42@=
gmail.com/T/#u

Explanation for the issue I observed with a similar secondary kernel
traceback on arm64 is in the commit message.

Best Regards,
Alexander Kamensky

On Mon, Aug 21, 2023 at 5:25=E2=80=AFAM Pandey, Radhey Shyam
<radhey.shyam.pandey@amd.com> wrote:
>
> > -----Original Message-----
> > From: bhe@redhat.com <bhe@redhat.com>
> > Sent: Monday, August 14, 2023 6:08 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: piliu@redhat.com; kexec@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Sarangi, Anirudha <anirudha.sarangi@amd.com>
> > Subject: Re: kexec reports "Cannot get kernel _text symbol address" on
> > arm64 platform
> >
> > On 08/11/23 at 01:27pm, Pandey, Radhey Shyam wrote:
> > > > -----Original Message-----
> > > > From: bhe@redhat.com <bhe@redhat.com>
> > > > Sent: Wednesday, August 9, 2023 7:42 AM
> > > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > > > piliu@redhat.com
> > > > Cc: kexec@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: kexec reports "Cannot get kernel _text symbol address"
> > > > on
> > > > arm64 platform
> > > >
> > > > On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> > > > > Hi,
> > > > >
> > > > > I am trying to bring up kdump on arm64 platform[1]. But I get
> > > > > "Cannot get
> > > > kernel _text symbol address".
> > > > >
> > > > > Is there some Dump-capture kernel config options that I am missin=
g?
> > > > >
> > > > > FYI, copied below complete kexec debug log.
> > > > >
> > > > > [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html
> > > >
> > > > Your description isn't clear. You saw the printing, then your kdump
> > > > kernel loading succeeded or not?
> > > >
> > > > If no, have you tried applying Pingfan's patchset and still saw the=
 issue?
> > > >
> > > > [PATCHv7 0/5] arm64: zboot support
> > > > https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com=
/
> > > > T/#u
> > >
> > > I was able to proceed further with loading with crash kernel on trigg=
ering
> > system crash.
> > > echo c > /proc/sysrq-trigger
> > >
> > > But when I copy /proc/vmcore it throws memory abort. Also I see size =
of
> > /proc/vmcore really huge (18446603353488633856).
> > > Any possible guess on what could be wrong?
> >
> > I didn't reproduce this issue on a arm64 baremetal system with the late=
st
> > kernel. From the log, It could be the iov_iter convertion patch which c=
aused
> > this. Can you revert below patch to see if it works?
> >
> > 5d8de293c224 vmcore: convert copy_oldmem_page() to take an iov_iter
>
> Revert of this commit resulted in lot of conflicts. So as a safer side I =
checkout
> v5.18 kernel version before above commit. Still I see the same issue.
>
> / # ls -lrth /proc/vmcore
> -r--------    1 root     root       16.0E Aug 21 12:16 /proc/vmcore
> / # dmesg | grep -i 5.18
> [    0.000000] Linux version 5.18.0-00001-g689fdf110e63-dirty (radheys@xh=
dradheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU ld (GNU Binuti=
ls) 2.39.0.20220819) #37 SMP Mon Aug 21 17:38:24 IST 2023
> [    2.494578] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.18
> [    2.514941] usb usb1: Manufacturer: Linux 5.18.0-00001-g689fdf110e63-d=
irty xhci-hcd
> [    2.555265] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.18
> [    2.575621] usb usb2: Manufacturer: Linux 5.18.0-00001-g689fdf110e63-d=
irty xhci-hcd
> [    3.152182] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> / # cp /proc/vmcore dump
> [   86.204704] Unable to handle kernel level 3 address size fault at virt=
ual address ffff800009b75000
> [   86.213677] Mem abort info:
> [   86.216464]   ESR =3D 0x96000003
> [   86.219508]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   86.224812]   SET =3D 0, FnV =3D 0
> [   86.227856]   EA =3D 0, S1PTW =3D 0
> [   86.230989]   FSC =3D 0x03: level 3 address size fault
> [   86.235945] Data abort info:
> [   86.238819]   ISV =3D 0, ISS =3D 0x00000003
> [   86.242646]   CM =3D 0, WnR =3D 0
> [   86.245608] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004304=
9000
> [   86.252304] [ffff800009b75000] pgd=3D1000000061ffe003, p4d=3D100000006=
1ffe003, pud=3D1000000061ffd003, pmd=3D1000000043c12003, pte=3D00687ffff820=
0703
> [   86.264828] Internal error: Oops: 96000003 [#1] SMP
> [   86.269696] Modules linked in:
> [   86.272741] CPU: 1 PID: 298 Comm: cp Not tainted 5.18.0-00001-g689fdf1=
10e63-dirty #37
> [   86.280562] Hardware name: Xilinx Versal vck190 Eval board revA (DT)
> [   86.286905] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   86.293857] pc : __arch_copy_to_user+0x180/0x240
> [   86.298475] lr : copy_oldmem_page+0xa8/0x110
> [   86.302738] sp : ffff80000af6bc50
> [   86.306041] x29: ffff80000af6bc50 x28: ffff8000097de3b0 x27: ffff80000=
97de228
> [   86.313170] x26: 0000000000000000 x25: ffff80000af6bd60 x24: 000000000=
0000000
> [   86.320299] x23: ffff800009b75000 x22: 0000000000000001 x21: 0000fffff=
fa1e5a8
> [   86.327427] x20: 0000000000000000 x19: 0000000000001000 x18: 000000000=
0000000
> [   86.334555] x17: 0000000000000000 x16: 0000000000000000 x15: ffff80000=
9b75000
> [   86.341682] x14: ffff800009863568 x13: 0000000000000000 x12: ffff80000=
8000000
> [   86.348810] x11: 00007ffff8201000 x10: ffff800009b75fff x9 : 000000000=
0000000
> [   86.355937] x8 : ffff800009b76000 x7 : 0400000000000001 x6 : 0000fffff=
fa1e5a8
> [   86.363065] x5 : 0000ffffffa1f5a8 x4 : 0000000000000000 x3 : 0000fffff=
fffffff
> [   86.370192] x2 : 0000000000000f80 x1 : ffff800009b75000 x0 : 0000fffff=
fa1e5a8
> [   86.377320] Call trace:
> [   86.379755]  __arch_copy_to_user+0x180/0x240
> [   86.384018]  read_from_oldmem.part.0+0x160/0x1f4
> [   86.388629]  read_vmcore+0xe4/0x214
> [   86.392109]  proc_reg_read+0xb0/0x100
> [   86.395763]  vfs_read+0x90/0x1dc
> [   86.398981]  ksys_read+0x70/0x10c
> [   86.402286]  __arm64_sys_read+0x20/0x30
> [   86.406111]  invoke_syscall+0x54/0x124
> [   86.409852]  el0_svc_common.constprop.0+0x44/0xec
> [   86.414547]  do_el0_svc+0x70/0x90
> [   86.417853]  el0_svc+0x50/0xa4
> [   86.420899]  el0t_64_sync_handler+0x10c/0x140
> [   86.425247]  el0t_64_sync+0x18c/0x190
> [   86.428902] Code: d503201f d503201f d503201f d503201f (a8c12027)
> [   86.434984] ---[ end trace 0000000000000000 ]---
> Segmentation fault
>
>
> >
> > >
> > >
> > > [   80.733523] Starting crashdump kernel...
> > > [   80.737435] Bye!
> > > [    0.000000] Booting Linux on physical CPU 0x0000000001 [0x410fd083=
]
> > > [    0.000000] Linux version 6.5.0-rc4-ge28001fb4e07
> > (radheys@xhdradheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU=
 ld
> > (GNU Binutils) 2.39.0.20220819) #23 SMP Fri Aug 11 16:25:34 IST 2023
> > > <snip>
> > >
> > >
> > >
> > > xilinx-vck190-20232:/run/media/mmcblk0p1# cat /proc/meminfo | head
> > > MemTotal:        2092876 kB
> > > MemFree:         1219928 kB
> > > MemAvailable:    1166004 kB
> > > Buffers:              32 kB
> > > Cached:           756952 kB
> > > SwapCached:            0 kB
> > > Active:             1480 kB
> > > Inactive:          24164 kB
> > > Active(anon):       1452 kB
> > > Inactive(anon):    24160 kB
> > > xilinx-vck190-20232:/run/media/mmcblk0p1# cp /proc/vmcore dump
> > > [  975.284865] Unable to handle kernel level 3 address size fault at
> > > virtual address ffff80008d7cf000 [  975.293871] Mem abort info:
> > > [  975.296669]   ESR =3D 0x0000000096000003
> > > [  975.300425]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [  975.305738]   SET =3D 0, FnV =3D 0
> > > [  975.308788]   EA =3D 0, S1PTW =3D 0
> > > [  975.311925]   FSC =3D 0x03: level 3 address size fault
> > > [  975.316888] Data abort info:
> > > [  975.319763]   ISV =3D 0, ISS =3D 0x00000003, ISS2 =3D 0x00000000
> > > [  975.325245]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > [  975.330292]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > [  975.335599] swapper pgtable: 4k pages, 48-bit VAs,
> > > pgdp=3D000005016ef6b000 [  975.342297] [ffff80008d7cf000]
> > > pgd=3D10000501eddfe003, p4d=3D10000501eddfe003, pud=3D10000501eddfd00=
3,
> > > pmd=3D100005017b695003, pte=3D00687fff84000703 [  975.354827] Interna=
l
> > error: Oops: 0000000096000003 [#4] SMP [  975.360392] Modules linked in=
:
> > > 3  975.
> > > 63440] CBPrUo:a d0c aPID: 664 Comm: cp Tainted: G      D            6=
.5.0-rc4-
> > ge28001fb4e07 #23
> > > [  975.372822] Hardware name: Xilinx Versal vck190 Eval board revA
> > > (DT) [  975.379165] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT
> > > -SSBS BTYPE=3D--) [  975.386119] pc : __memcpy+0x110/0x230 [
> > > 975.389783] lr : _copy_to_iter+0x3d8/0x4d0 [  975.393874] sp :
> > > ffff80008dc939a0 [  975.397178] x29: ffff80008dc939a0 x28:
> > > ffff05013c1bea30 x27: 0000000000001000 [  975.404309] x26:
> > > 0000000000001000 x25: 0000000000001000 x24: ffff80008d7cf000 [
> > > 975.411440] x23: 0000040000000000 x22: ffff80008dc93ba0 x21:
> > > 0000000000001000 [  975.418570] x20: ffff000000000000 x19:
> > > 0000000000001000 x18: 0000000000000000 [  975.425699] x17:
> > > 0000000000000000 x16: 0000000000000000 x15: 0140000000000000 [
> > > 975.432829] x14: ffff8500a9919000 x13: 0040000000000001 x12:
> > > 0000fffef6831000 [  975.439958] x11: ffff80008d9cf000 x10:
> > > 0000000000000000 x9 : 0000000000000000 [  975.447088] x8 :
> > > ffff80008d7d0000 x7 : ffff0501addfd358 x6 : 0400000000000001 [
> > > 975.454217] x5 : ffff0501370e9000 x4 : ffff80008d7d0000 x3 :
> > 0000000000000000 [  975.461346] x2 : 0000000000001000 x1 :
> > ffff80008d7cf000 x0 : ffff0501370e8000 [  975.468476] Call trace:
> > > [  975.470912]  __memcpy+0x110/0x230
> > > [  975.474221]  copy_oldmem_page+0x70/0xac [  975.478050]
> > > read_from_oldmem.part.0+0x120/0x188
> > > [  975.482663]  read_vmcore+0x14c/0x238 [  975.486231]
> > > proc_reg_read_iter+0x84/0xd8 [  975.490233]
> > > copy_splice_read+0x160/0x288 [  975.494236]
> > > vfs_splice_read+0xac/0x10c [  975.498063]
> > > splice_direct_to_actor+0xa4/0x26c [  975.502498]
> > > do_splice_direct+0x90/0xdc [  975.506325]  do_sendfile+0x344/0x454 [
> > > 975.509892]  __arm64_sys_sendfile64+0x134/0x140
> > > [  975.514415]  invoke_syscall+0x54/0x124 [  975.518157]
> > > el0_svc_common.constprop.0+0xc4/0xe4
> > > [  975.522854]  do_el0_svc+0x38/0x98
> > > [  975.526162]  el0_svc+0x2c/0x84
> > > [  975.529211]  el0t_64_sync_handler+0x100/0x12c [  975.533562]
> > > el0t_64_sync+0x190/0x194 [  975.537218] Code: cb01000e b4fffc2e
> > > eb0201df 540004a3 (a940342c) [  975.543302] ---[ end trace
> > > 0000000000000000 ]--- t message from
> > > systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):
> > >
> > > kernel[539]: [  975.354827] Internal error: Oops: 0000000096000003
> > > [#4] SMP
> > >
> > >
> > > Broadcast message from systemd-journald@xilinx-vck190-20232 (Tue
> > 2022-11-08 14:16:20 UTC):
> > >
> > > kernel[539]: [  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3
> > > (a940342c)
> > >
> > > Segmentation fault
> > > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lrth /proc/vmcore
> > > -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> > > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lh /proc/vmcore
> > > -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> > > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -l /proc/vmcore
> > > -r--------    1 root     root     18446603353488633856 Nov  8 14:05
> > /proc/vmcore
> > >
> > > Thanks,
> > > Radhey
> > >
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

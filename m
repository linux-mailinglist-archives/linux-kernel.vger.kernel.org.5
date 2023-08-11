Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757E779B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjHKXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHKXMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C0ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691795508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+LZshQm/6ML7WHR1PdypnMefvzGwjFcqqGAglrLfgQ4=;
        b=G7zS0pS4enK+bNCwio5/VhOnXqeYANPMUgtG42RADe+iamKKCKDix/UhqJ220TObnS1abB
        25aPVJbM9zvnU6De3OSkJi+B0wx/MNFuEtNsK78Ar21efbZmL+UI73YOpbUa7q79rZxhYB
        XlE2UEOG6ttWnGss/H6HNeMAr8vHbeo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-2qTi0atnMausLWZ1_jpJVA-1; Fri, 11 Aug 2023 19:11:44 -0400
X-MC-Unique: 2qTi0atnMausLWZ1_jpJVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83079101A528;
        Fri, 11 Aug 2023 23:11:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF827492C13;
        Fri, 11 Aug 2023 23:11:37 +0000 (UTC)
Date:   Sat, 12 Aug 2023 07:11:34 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Message-ID: <ZNbAC+nq2+CJSQX8@MiWiFi-R3L-srv>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
 <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/23 at 01:27pm, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: bhe@redhat.com <bhe@redhat.com>
> > Sent: Wednesday, August 9, 2023 7:42 AM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > piliu@redhat.com
> > Cc: kexec@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: kexec reports "Cannot get kernel _text symbol address" on
> > arm64 platform
> > 
> > On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> > > Hi,
> > >
> > > I am trying to bring up kdump on arm64 platform[1]. But I get "Cannot get
> > kernel _text symbol address".
> > >
> > > Is there some Dump-capture kernel config options that I am missing?
> > >
> > > FYI, copied below complete kexec debug log.
> > >
> > > [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html
> > 
> > Your description isn't clear. You saw the printing, then your kdump kernel
> > loading succeeded or not?
> > 
> > If no, have you tried applying Pingfan's patchset and still saw the issue?
> > 
> > [PATCHv7 0/5] arm64: zboot support
> > https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com/T/#u
> 
> I was able to proceed further with loading with crash kernel on triggering system crash.
> echo c > /proc/sysrq-trigger
> 
> But when I copy /proc/vmcore it throws memory abort. Also I see size of /proc/vmcore really huge (18446603353488633856).

This is a better symptom description.

It's very similar with a solved issue even though the calltrace is not
completely same, can you try below patch to see if it fix your problem?

[PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions
https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.com/T/#u

> Any possible guess on what could be wrong?
> 
> 
> [   80.733523] Starting crashdump kernel...
> [   80.737435] Bye!
> [    0.000000] Booting Linux on physical CPU 0x0000000001 [0x410fd083]
> [    0.000000] Linux version 6.5.0-rc4-ge28001fb4e07 (radheys@xhdradheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #23 SMP Fri Aug 11 16:25:34 IST 2023
> <snip>
> 
> 
> 
> xilinx-vck190-20232:/run/media/mmcblk0p1# cat /proc/meminfo | head
> MemTotal:        2092876 kB
> MemFree:         1219928 kB
> MemAvailable:    1166004 kB
> Buffers:              32 kB
> Cached:           756952 kB
> SwapCached:            0 kB
> Active:             1480 kB
> Inactive:          24164 kB
> Active(anon):       1452 kB
> Inactive(anon):    24160 kB
> xilinx-vck190-20232:/run/media/mmcblk0p1# cp /proc/vmcore dump     
> [  975.284865] Unable to handle kernel level 3 address size fault at virtual address ffff80008d7cf000
> [  975.293871] Mem abort info:
> [  975.296669]   ESR = 0x0000000096000003
> [  975.300425]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  975.305738]   SET = 0, FnV = 0
> [  975.308788]   EA = 0, S1PTW = 0
> [  975.311925]   FSC = 0x03: level 3 address size fault
> [  975.316888] Data abort info:
> [  975.319763]   ISV = 0, ISS = 0x00000003, ISS2 = 0x00000000
> [  975.325245]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  975.330292]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  975.335599] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000005016ef6b000
> [  975.342297] [ffff80008d7cf000] pgd=10000501eddfe003, p4d=10000501eddfe003, pud=10000501eddfd003, pmd=100005017b695003, pte=00687fff84000703
> [  975.354827] Internal error: Oops: 0000000096000003 [#4] SMP
> [  975.360392] Modules linked in:
> 3  975.
> 63440] CBPrUo:a d0c aPID: 664 Comm: cp Tainted: G      D            6.5.0-rc4-ge28001fb4e07 #23
> [  975.372822] Hardware name: Xilinx Versal vck190 Eval board revA (DT)
> [  975.379165] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  975.386119] pc : __memcpy+0x110/0x230
> [  975.389783] lr : _copy_to_iter+0x3d8/0x4d0
> [  975.393874] sp : ffff80008dc939a0
> [  975.397178] x29: ffff80008dc939a0 x28: ffff05013c1bea30 x27: 0000000000001000
> [  975.404309] x26: 0000000000001000 x25: 0000000000001000 x24: ffff80008d7cf000
> [  975.411440] x23: 0000040000000000 x22: ffff80008dc93ba0 x21: 0000000000001000
> [  975.418570] x20: ffff000000000000 x19: 0000000000001000 x18: 0000000000000000
> [  975.425699] x17: 0000000000000000 x16: 0000000000000000 x15: 0140000000000000
> [  975.432829] x14: ffff8500a9919000 x13: 0040000000000001 x12: 0000fffef6831000
> [  975.439958] x11: ffff80008d9cf000 x10: 0000000000000000 x9 : 0000000000000000
> [  975.447088] x8 : ffff80008d7d0000 x7 : ffff0501addfd358 x6 : 0400000000000001
> [  975.454217] x5 : ffff0501370e9000 x4 : ffff80008d7d0000 x3 : 0000000000000000
> [  975.461346] x2 : 0000000000001000 x1 : ffff80008d7cf000 x0 : ffff0501370e8000
> [  975.468476] Call trace:
> [  975.470912]  __memcpy+0x110/0x230
> [  975.474221]  copy_oldmem_page+0x70/0xac
> [  975.478050]  read_from_oldmem.part.0+0x120/0x188
> [  975.482663]  read_vmcore+0x14c/0x238
> [  975.486231]  proc_reg_read_iter+0x84/0xd8
> [  975.490233]  copy_splice_read+0x160/0x288
> [  975.494236]  vfs_splice_read+0xac/0x10c
> [  975.498063]  splice_direct_to_actor+0xa4/0x26c
> [  975.502498]  do_splice_direct+0x90/0xdc
> [  975.506325]  do_sendfile+0x344/0x454
> [  975.509892]  __arm64_sys_sendfile64+0x134/0x140
> [  975.514415]  invoke_syscall+0x54/0x124
> [  975.518157]  el0_svc_common.constprop.0+0xc4/0xe4
> [  975.522854]  do_el0_svc+0x38/0x98
> [  975.526162]  el0_svc+0x2c/0x84
> [  975.529211]  el0t_64_sync_handler+0x100/0x12c
> [  975.533562]  el0t_64_sync+0x190/0x194
> [  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3 (a940342c) 
> [  975.543302] ---[ end trace 0000000000000000 ]---
> t message from systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):
> 
> kernel[539]: [  975.354827] Internal error: Oops: 0000000096000003 [#4] SMP
> 
> 
> Broadcast message from systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):
> 
> kernel[539]: [  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3 (a940342c)
> 
> Segmentation fault
> xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lrth /proc/vmcore 
> -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lh /proc/vmcore
> -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> xilinx-vck190-20232:/run/media/mmcblk0p1# ls -l /proc/vmcore
> -r--------    1 root     root     18446603353488633856 Nov  8 14:05 /proc/vmcore
> 
> Thanks,
> Radhey
> 


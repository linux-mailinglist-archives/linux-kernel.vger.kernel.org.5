Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1998133BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573598AbjLNO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573569AbjLNO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:59:16 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE919BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:59:21 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:55106)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDnBD-00298x-8O; Thu, 14 Dec 2023 07:59:15 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48054 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDnBC-009bes-10; Thu, 14 Dec 2023 07:59:14 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
Date:   Thu, 14 Dec 2023 08:58:49 -0600
In-Reply-To: <20231213000452.88295-1-graf@amazon.com> (Alexander Graf's
        message of "Wed, 13 Dec 2023 00:04:37 +0000")
Message-ID: <87r0jo7rva.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rDnBC-009bes-10;;;mid=<87r0jo7rva.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/OhbNhEazZ4D40H/sN4yD6DjQIF1U06u0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexander Graf <graf@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 587 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.07
        (0.2%), extract_message_metadata: 12 (2.1%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-2000: 4.8 (0.8%), tests_pri_-1000: 3.8 (0.6%),
        tests_pri_-950: 1.19 (0.2%), tests_pri_-900: 1.01 (0.2%),
        tests_pri_-90: 68 (11.7%), check_bayes: 67 (11.4%), b_tokenize: 12
        (2.0%), b_tok_get_all: 13 (2.3%), b_comp_prob: 3.8 (0.7%),
        b_tok_touch_all: 34 (5.8%), b_finish: 0.86 (0.1%), tests_pri_0: 461
        (78.6%), check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 2.2
        (0.4%), poll_dns_idle: 0.70 (0.1%), tests_pri_10: 2.4 (0.4%),
        tests_pri_500: 16 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/15] kexec: Allow preservation of ftrace buffers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Graf <graf@amazon.com> writes:

> Kexec today considers itself purely a boot loader: When we enter the new
> kernel, any state the previous kernel left behind is irrelevant and the
> new kernel reinitializes the system.
>
> However, there are use cases where this mode of operation is not what we
> actually want. In virtualization hosts for example, we want to use kexec
> to update the host kernel while virtual machine memory stays untouched.
> When we add device assignment to the mix, we also need to ensure that
> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
> need to do the same for the PCI subsystem. If we want to kexec while an
> SEV-SNP enabled virtual machine is running, we need to preserve the VM
> context pages and physical memory. See James' and my Linux Plumbers
> Conference 2023 presentation for details:
>
>   https://lpc.events/event/17/contributions/1485/
>
> To start us on the journey to support all the use cases above, this
> patch implements basic infrastructure to allow hand over of kernel state
> across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
> With this patch set applied, you can read ftrace records from the
> pre-kexec environment in your post-kexec one. This creates a very powerful
> debugging and performance analysis tool for kexec. It's also slightly
> easier to reason about than full blown VFIO state preservation.
>
> == Alternatives ==
>
> There are alternative approaches to (parts of) the problems above:
>
>   * Memory Pools [1] - preallocated persistent memory region + allocator
>   * PRMEM [2] - resizable persistent memory regions with fixed metadata
>                 pointer on the kernel command line + allocator
>   * Pkernfs [3] - preallocated file system for in-kernel data with fixed
>                   address location on the kernel command line
>   * PKRAM [4] - handover of user space pages using a fixed metadata page
>                 specified via command line
>
> All of the approaches above fundamentally have the same problem: They
> require the administrator to explicitly carve out a physical memory
> location because they have no mechanism outside of the kernel command
> line to pass data (including memory reservations) between kexec'ing
> kernels.
>
> KHO provides that base foundation. We will determine later whether we
> still need any of the approaches above for fast bulk memory handover of for
> example IOMMU page tables. But IMHO they would all be users of KHO, with
> KHO providing the foundational primitive to pass metadata and bulk memory
> reservations as well as provide easy versioning for data.

What you are describe in many ways is the same problem as
kexec-on-panic.  The goal of leaving devices running absolutely requires
carving out memory for the new kernel to live in while it is coming up
so that DMA from a device that was not shutdown down does not stomp the
kernel coming up.

If I understand the virtualization case some of those virtual machines
are going to have virtual NICs that are going to want to DMA memory to
the host system.  Which if I understand things correctly means that
among the devices you explicitly want to keep running there is a not
a way to avoid the chance of DMA coming in while the kernel is being
changed.

There is also a huge maintenance challenge associated with all of this.

If you go with something that is essentially kexec-on-panic and then
add a little bit to help find things in the memory of the previous
kernel while the new kernel is coming up I can see it as a possibility.

As an example I think preserving ftrace data of kexec seems bizarre.
I don't see how that is an interesting use case at all.  Not in
the situation of preserving virtual machines, and not in the situation
of kexec on panic.

If you are doing an orderly shutdown and kernel switch you should be
able to manually change the memory.  If you are not doing an orderly
shutdown then I really don't get it.

I don't hate the capability you are trying to build.

I have not read or looked at most of this so I am probably
missing subtle details.

As you are currently describing things I have the sense you have
completely misframed the problem and are trying to solve the wrong parts
of the problem.

Eric

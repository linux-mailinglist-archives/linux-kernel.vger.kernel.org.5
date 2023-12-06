Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1A8067D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376912AbjLFG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:59:01 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89E1B5;
        Tue,  5 Dec 2023 22:58:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8774F5C02E4;
        Wed,  6 Dec 2023 01:58:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Dec 2023 01:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701845933; x=1701932333; bh=XD
        BD04DWxIy9FwDyVpvcElWRIMmcHhSXklyKTsp1VBs=; b=xCNCOUa1ujnFhO/GHj
        Gnft26aQH4iUryuEAIZ+ZNpDDwl9Y1oAcKxRYqvB8UD/kKThceL4K4sn2PBGvKSQ
        oS9Xb4ZWY7B6jkUfbE68tGvKTVlUJYaoAPvV8ft+WhDW91H+HxUwb5r83eQn/Xr6
        whiJ9F33ioaTtML9klISh/kafTp5cdKdPkX6nRTUNzIz8yR1hlYZaueqgnvZcGd7
        AGOGJR2VqT6WkaYuDjc7CAb4RMKOEDQQ9YnFyVmvnrqgn5XLbhbNW8FAAgP6tU//
        dV+Oi8pOJe0kBVhbYM13nKWQDj7AkNke0eqAfJIh4UmmNOKxCd3uY9wDiL/VU1+W
        qWjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701845933; x=1701932333; bh=XDBD04DWxIy9F
        wDyVpvcElWRIMmcHhSXklyKTsp1VBs=; b=PStAwgwHZjYkJa5AOe3jHq3oYJE9R
        pA+Hrweyp4QUX/6LahRDAnultFwcP2fC/1fIMpyOKrbWwbfuTQqDr2CXq8fpPoAZ
        dZfv9yRnM7eFOAWOxpK/w7H2xhGeCYq8UbDkqArJATni1sD7B2F8YKbblgt0yx5d
        VF9jqDNwlCcI5tzZ7BdzT0g8/0mjnHqpUccCV51JV+oLNav1PF2JB8WULA7ybo8L
        ZlCgi33KRQrE9m/EW5+uvzFYH7wSF37VkHjADTI2R81C5sXLoLXHY/0TGY/HWDcq
        v+nXoIEUJfnYJTF6Z0q9M0TyFyWSqO7j6nfs0uLhY7hcZuhvunc+8bhmQ==
X-ME-Sender: <xms:rRtwZY6oKvrE_9j6zAuGMgMT9mIVnepsTiona3C5hp4Z4TOgbvW39g>
    <xme:rRtwZZ50d6alhUQQJq5EhfRUQGBHLMBkd3S6pmOvXORJm4p9ZdKeyCUS-0e-sW8mD
    qr32PaA6pXmgoqKVg>
X-ME-Received: <xmr:rRtwZXfzqrDTSse5sUVvcvHW0UC5IbHJtVfJexKab9O38Y9Au-oQWpR7CRCHI32SickH7JhFwCN8T0mEGXnV3nUU4GC0_ZVTit4UZBO4-1k1J22CGM4uJmDzrmCl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesmhdtreertddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepffeftdehffdvudefueduveehfefgheetvdejveeggeejtedtjeefvedt
    gefgueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:rRtwZdL_HbhNry1108e0AXyX6-9d_arQ-eqjBSzPCKLJV9_B-IYQxQ>
    <xmx:rRtwZcJceIZnGo5T7Q0Ihm2MCcpqS-6NY7_ZBMrJkeN-lu-VHKOPpg>
    <xmx:rRtwZexmVKT-MRBK4CKJcPPPdP7TOK44njmvJs4--i9fAnZDr62QBA>
    <xmx:rRtwZRW52sPusy7mKDUFAbO_6GonCHoaXCWGQ0CPX92OXev8RuzNMQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 01:58:52 -0500 (EST)
Date:   Tue, 5 Dec 2023 22:58:50 -0800
From:   Andres Freund <andres@anarazel.de>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com>
 <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
 <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mv2j6utfjb65nsuh"
Content-Disposition: inline
In-Reply-To: <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mv2j6utfjb65nsuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 2023-12-01 08:31:48 +0000, Zhang, Rui wrote:
> As a quick fix, I'm not going to fix the "potential issue" describes
> above because we have not seen a real problem caused by this yet.
>
> Can you please try the below patch to confirm if the problem is gone on
> your system?
> This patch falls back to the previous way as sent at
> https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/


I've just spent a couple hours bisecting why upgrading to 6.7-rc4 left me with
just a single CPU core on my dual socket workstation.


before:
[    0.000000] Linux version 6.6.0-andres-00003-g31255e072b2e ...
...
[    0.022960] ACPI: Using ACPI (MADT) for SMP configuration information
...
[    0.022968] smpboot: Allowing 40 CPUs, 0 hotplug CPUs
...
[    0.345921] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
...
[    0.347229] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9
[    0.349082] .... node  #1, CPUs:   #10 #11 #12 #13 #14 #15 #16 #17 #18 #19
[    0.003190] smpboot: CPU 10 Converting physical 0 to logical die 1

[    0.361053] .... node  #0, CPUs:   #20 #21 #22 #23 #24 #25 #26 #27 #28 #29
[    0.363990] .... node  #1, CPUs:   #30 #31 #32 #33 #34 #35 #36 #37 #38 #39
...
[    0.370886] smp: Brought up 2 nodes, 40 CPUs
[    0.370891] smpboot: Max logical packages: 2
[    0.370896] smpboot: Total of 40 processors activated (200000.00 BogoMIPS)
[    0.403905] node 0 deferred pages initialised in 32ms
[    0.408865] node 1 deferred pages initialised in 37ms


after:
[    0.000000] Linux version 6.6.0-andres-00004-gec9aedb2aa1a ...
...
[    0.022935] ACPI: Using ACPI (MADT) for SMP configuration information
...
[    0.022942] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
...
[    0.356424] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
...
[    0.357098] smp: Bringing up secondary CPUs ...
[    0.357107] smp: Brought up 2 nodes, 1 CPU
[    0.357108] smpboot: Max logical packages: 1
[    0.357110] smpboot: Total of 1 processors activated (5000.00 BogoMIPS)
[    0.726283] node 0 deferred pages initialised in 368ms
[    0.774704] node 1 deferred pages initialised in 418ms


There does seem to be something off with the ACPI data, when booting without
the patch, I do see messages like:
[    0.715228] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 40/0x7f00 ignored.
[    0.715231] ACPI: Unable to map lapic to logical cpu number

But other than that, the system has worked for a couple years.


It's obviously not good to regress from 2x10/20 cores/threads to a single
core.   I guess it's at least somewhat funny to imagine a 2 socket system with
a single core...


It seems particularly worrying that this patch has apparently been selected
for -stable:
https://lore.kernel.org/all/20231122153212.852040-2-sashal@kernel.org/

Even if it didn't have these unintended consequences, it seems like a commit
like this hardly is -stable material?


I've attached .config, dmesg of a boot with gec9aedb2aa1a and one with
gec9aedb2aa1a^.

Greetings,

Andres Freund

--mv2j6utfjb65nsuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.7-ec9aedb2aa1a-onecpu"

[    0.000000] microcode: updated early: 0x5003303 -> 0x5003604, date = 2023-03-17
[    0.000000] Linux version 6.6.0-andres-00004-gec9aedb2aa1a (andres@awork3) (gcc (Debian 13.2.0-8) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231202) #70 SMP PREEMPT_DYNAMIC Tue Dec  5 21:43:03 PST 2023
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.6.0-andres-00004-gec9aedb2aa1a root=/dev/mapper/awork3--sa--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=sm_on iommu=pt nvme.poll_queues=4 cgroup.memory=nokmem coredump_filter=511 log_buf_len=16M hugetlb_cma=48G quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000687fbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000687fc000-0x000000006a8fbfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006a8fc000-0x000000006aed7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006aed8000-0x000000006c0f9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006c0fa000-0x000000006fb33fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006fb34000-0x000000006fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x5bbb4018-0x5bbbc057] usable ==> usable
[    0.000000] e820: update [mem 0x5bbb4018-0x5bbbc057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb8f018-0x5bbb3e57] usable ==> usable
[    0.000000] e820: update [mem 0x5bb8f018-0x5bbb3e57] usable ==> usable
[    0.000000] e820: update [mem 0x5bb84018-0x5bb8e057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb84018-0x5bb8e057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb79018-0x5bb83057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb79018-0x5bb83057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb44018-0x5bb78257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb44018-0x5bb78257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb0f018-0x5bb43257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb0f018-0x5bb43257] usable ==> usable
[    0.000000] e820: update [mem 0x5baf3018-0x5bb0e857] usable ==> usable
[    0.000000] e820: update [mem 0x5baf3018-0x5bb0e857] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000005baf3017] usable
[    0.000000] reserve setup_data: [mem 0x000000005baf3018-0x000000005bb0e857] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb0e858-0x000000005bb0f017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb0f018-0x000000005bb43257] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb43258-0x000000005bb44017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb44018-0x000000005bb78257] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb78258-0x000000005bb79017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb79018-0x000000005bb83057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb83058-0x000000005bb84017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb84018-0x000000005bb8e057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb8e058-0x000000005bb8f017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb8f018-0x000000005bbb3e57] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbb3e58-0x000000005bbb4017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbb4018-0x000000005bbbc057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbbc058-0x00000000687fbfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000687fc000-0x000000006a8fbfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006a8fc000-0x000000006aed7fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000006aed8000-0x000000006c0f9fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000006c0fa000-0x000000006fb33fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006fb34000-0x000000006fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=0x6b8ab000 ACPI=0x6b8ab000 SMBIOS=0x6f5ca000 SMBIOS 3.0=0x6f5c9000 MEMATTR=0x64037018 ESRT=0x62ecae18 INITRD=0x5ef8ac98 
[    0.000000] efi: Remove mem50: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
[    0.000000] efi: Remove mem51: MMIO range=[0xfd000000-0xfe7fffff] (24MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfe7fffff] reserved
[    0.000000] efi: Not removing mem52: MMIO range=[0xfed20000-0xfed44fff] (148KB) from e820 map
[    0.000000] efi: Remove mem53: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.2.1 present.
[    0.000000] DMI: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.8b 01/12/2023
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000015] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000017] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000029] last_pfn = 0x3040000 max_arch_pfn = 0x400000000
[    0.000033] MTRR map: 7 entries (2 fixed + 5 variable; max 22), built from 10 variable MTRRs
[    0.000036] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000277] e820: update [mem 0x70000000-0x73ffffff] usable ==> reserved
[    0.000280] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.000282] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000283] last_pfn = 0x70000 max_arch_pfn = 0x400000000
[    0.000290] esrt: Reserving ESRT space from 0x0000000062ecae18 to 0x0000000062ecae50.
[    0.000296] e820: update [mem 0x62eca000-0x62ecafff] usable ==> reserved
[    0.000318] Using GB pages for direct mapping
[    0.018247] printk: log_buf_len: 16777216 bytes
[    0.018249] printk: early log buf free: 255552(97%)
[    0.018251] Secure boot disabled
[    0.018251] RAMDISK: [mem 0x5bbbd000-0x5da34fff]
[    0.018257] ACPI: Early table checksum verification disabled
[    0.018260] ACPI: RSDP 0x000000006B8AB000 000024 (v02 ALASKA)
[    0.018265] ACPI: XSDT 0x000000006B8AB0D0 00011C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018271] ACPI: FACP 0x000000006BA478C8 000114 (v06 ALASKA A M I    01072009 INTL 20091013)
[    0.018276] ACPI: DSDT 0x000000006B8AB280 19C643 (v02 ALASKA A M I    01072009 INTL 20091013)
[    0.018279] ACPI: FACS 0x000000006C0B6080 000040
[    0.018281] ACPI: FPDT 0x000000006BA479E0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018284] ACPI: FIDT 0x000000006BA47A28 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018287] ACPI: SPMI 0x000000006BA47AC8 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.018290] ACPI: SSDT 0x000000006BA47B10 00046C (v02 INTEL  ADDRXLAT 00000001 INTL 20140828)
[    0.018293] ACPI: MCFG 0x000000006BA47F80 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.018296] ACPI: HPET 0x000000006BA47FC0 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018299] ACPI: APIC 0x000000006BA47FF8 000C5E (v03 ALASKA A M I    00000000 INTL 20091013)
[    0.018302] ACPI: MIGT 0x000000006BA48C58 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018305] ACPI: MSCT 0x000000006BA48C98 000064 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018308] ACPI: PCAT 0x000000006BA48D00 000088 (v02 ALASKA A M I    00000002 INTL 20091013)
[    0.018310] ACPI: PCCT 0x000000006BA48D88 00006E (v01 ALASKA A M I    00000002 INTL 20091013)
[    0.018313] ACPI: RASF 0x000000006BA48DF8 000030 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018316] ACPI: SLIT 0x000000006BA48E28 00012C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018318] ACPI: SRAT 0x000000006BA48F58 0016B0 (v03 ALASKA A M I    00000002 INTL 20091013)
[    0.018321] ACPI: SVOS 0x000000006BA4A608 000032 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018324] ACPI: WDDT 0x000000006BA4A640 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018326] ACPI: OEM1 0x000000006BA4A680 015174 (v02 INTEL  CPU EIST 00003000 INTL 20140828)
[    0.018329] ACPI: OEM2 0x000000006BA5F7F8 017554 (v02 INTEL  CPU  HWP 00003000 INTL 20140828)
[    0.018332] ACPI: SSDT 0x000000006BA76D50 019D00 (v02 INTEL  SSDT  PM 00004000 INTL 20140828)
[    0.018335] ACPI: OEM3 0x000000006BA90A50 013344 (v02 INTEL  CPU  TST 00003000 INTL 20140828)
[    0.018337] ACPI: SSDT 0x000000006BAA3D98 00065B (v02 ALASKA A M I    00000000 INTL 20091013)
[    0.018340] ACPI: VFCT 0x000000006BAA43F8 00E284 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.018343] ACPI: SPCR 0x000000006BAB2680 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000E)
[    0.018346] ACPI: SSDT 0x000000006BAB26D0 001B4E (v02 INTEL  SpsNm    00000002 INTL 20140828)
[    0.018348] ACPI: DMAR 0x000000006BAB4220 0002F0 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018351] ACPI: HEST 0x000000006BAB4510 0000A8 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018354] ACPI: BERT 0x000000006BAB45B8 000030 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018357] ACPI: ERST 0x000000006BAB45E8 000230 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018359] ACPI: EINJ 0x000000006BAB4818 000150 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018362] ACPI: WSMT 0x000000006BAB4968 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018364] ACPI: Reserving FACP table memory at [mem 0x6ba478c8-0x6ba479db]
[    0.018366] ACPI: Reserving DSDT table memory at [mem 0x6b8ab280-0x6ba478c2]
[    0.018367] ACPI: Reserving FACS table memory at [mem 0x6c0b6080-0x6c0b60bf]
[    0.018368] ACPI: Reserving FPDT table memory at [mem 0x6ba479e0-0x6ba47a23]
[    0.018369] ACPI: Reserving FIDT table memory at [mem 0x6ba47a28-0x6ba47ac3]
[    0.018370] ACPI: Reserving SPMI table memory at [mem 0x6ba47ac8-0x6ba47b08]
[    0.018371] ACPI: Reserving SSDT table memory at [mem 0x6ba47b10-0x6ba47f7b]
[    0.018372] ACPI: Reserving MCFG table memory at [mem 0x6ba47f80-0x6ba47fbb]
[    0.018373] ACPI: Reserving HPET table memory at [mem 0x6ba47fc0-0x6ba47ff7]
[    0.018373] ACPI: Reserving APIC table memory at [mem 0x6ba47ff8-0x6ba48c55]
[    0.018374] ACPI: Reserving MIGT table memory at [mem 0x6ba48c58-0x6ba48c97]
[    0.018375] ACPI: Reserving MSCT table memory at [mem 0x6ba48c98-0x6ba48cfb]
[    0.018376] ACPI: Reserving PCAT table memory at [mem 0x6ba48d00-0x6ba48d87]
[    0.018377] ACPI: Reserving PCCT table memory at [mem 0x6ba48d88-0x6ba48df5]
[    0.018378] ACPI: Reserving RASF table memory at [mem 0x6ba48df8-0x6ba48e27]
[    0.018379] ACPI: Reserving SLIT table memory at [mem 0x6ba48e28-0x6ba48f53]
[    0.018380] ACPI: Reserving SRAT table memory at [mem 0x6ba48f58-0x6ba4a607]
[    0.018381] ACPI: Reserving SVOS table memory at [mem 0x6ba4a608-0x6ba4a639]
[    0.018382] ACPI: Reserving WDDT table memory at [mem 0x6ba4a640-0x6ba4a67f]
[    0.018383] ACPI: Reserving OEM1 table memory at [mem 0x6ba4a680-0x6ba5f7f3]
[    0.018384] ACPI: Reserving OEM2 table memory at [mem 0x6ba5f7f8-0x6ba76d4b]
[    0.018385] ACPI: Reserving SSDT table memory at [mem 0x6ba76d50-0x6ba90a4f]
[    0.018387] ACPI: Reserving OEM3 table memory at [mem 0x6ba90a50-0x6baa3d93]
[    0.018387] ACPI: Reserving SSDT table memory at [mem 0x6baa3d98-0x6baa43f2]
[    0.018388] ACPI: Reserving VFCT table memory at [mem 0x6baa43f8-0x6bab267b]
[    0.018389] ACPI: Reserving SPCR table memory at [mem 0x6bab2680-0x6bab26cf]
[    0.018390] ACPI: Reserving SSDT table memory at [mem 0x6bab26d0-0x6bab421d]
[    0.018391] ACPI: Reserving DMAR table memory at [mem 0x6bab4220-0x6bab450f]
[    0.018392] ACPI: Reserving HEST table memory at [mem 0x6bab4510-0x6bab45b7]
[    0.018393] ACPI: Reserving BERT table memory at [mem 0x6bab45b8-0x6bab45e7]
[    0.018394] ACPI: Reserving ERST table memory at [mem 0x6bab45e8-0x6bab4817]
[    0.018395] ACPI: Reserving EINJ table memory at [mem 0x6bab4818-0x6bab4967]
[    0.018396] ACPI: Reserving WSMT table memory at [mem 0x6bab4968-0x6bab498f]
[    0.018464] APIC: Switched APIC routing to: cluster x2apic
[    0.018488] SRAT: PXM 0 -> APIC 0x0000 -> Node 0
[    0.018489] SRAT: PXM 0 -> APIC 0x0002 -> Node 0
[    0.018490] SRAT: PXM 0 -> APIC 0x0004 -> Node 0
[    0.018491] SRAT: PXM 0 -> APIC 0x0006 -> Node 0
[    0.018491] SRAT: PXM 0 -> APIC 0x0008 -> Node 0
[    0.018492] SRAT: PXM 0 -> APIC 0x0010 -> Node 0
[    0.018493] SRAT: PXM 0 -> APIC 0x0012 -> Node 0
[    0.018494] SRAT: PXM 0 -> APIC 0x0014 -> Node 0
[    0.018495] SRAT: PXM 0 -> APIC 0x0016 -> Node 0
[    0.018495] SRAT: PXM 0 -> APIC 0x0018 -> Node 0
[    0.018496] SRAT: PXM 1 -> APIC 0x0020 -> Node 1
[    0.018497] SRAT: PXM 1 -> APIC 0x0022 -> Node 1
[    0.018498] SRAT: PXM 1 -> APIC 0x0024 -> Node 1
[    0.018498] SRAT: PXM 1 -> APIC 0x0026 -> Node 1
[    0.018499] SRAT: PXM 1 -> APIC 0x0028 -> Node 1
[    0.018500] SRAT: PXM 1 -> APIC 0x0030 -> Node 1
[    0.018501] SRAT: PXM 1 -> APIC 0x0032 -> Node 1
[    0.018501] SRAT: PXM 1 -> APIC 0x0034 -> Node 1
[    0.018502] SRAT: PXM 1 -> APIC 0x0036 -> Node 1
[    0.018503] SRAT: PXM 1 -> APIC 0x0038 -> Node 1
[    0.018503] SRAT: PXM 0 -> APIC 0x0001 -> Node 0
[    0.018504] SRAT: PXM 0 -> APIC 0x0003 -> Node 0
[    0.018505] SRAT: PXM 0 -> APIC 0x0005 -> Node 0
[    0.018506] SRAT: PXM 0 -> APIC 0x0007 -> Node 0
[    0.018506] SRAT: PXM 0 -> APIC 0x0009 -> Node 0
[    0.018507] SRAT: PXM 0 -> APIC 0x0011 -> Node 0
[    0.018508] SRAT: PXM 0 -> APIC 0x0013 -> Node 0
[    0.018508] SRAT: PXM 0 -> APIC 0x0015 -> Node 0
[    0.018509] SRAT: PXM 0 -> APIC 0x0017 -> Node 0
[    0.018510] SRAT: PXM 0 -> APIC 0x0019 -> Node 0
[    0.018510] SRAT: PXM 1 -> APIC 0x0021 -> Node 1
[    0.018511] SRAT: PXM 1 -> APIC 0x0023 -> Node 1
[    0.018512] SRAT: PXM 1 -> APIC 0x0025 -> Node 1
[    0.018513] SRAT: PXM 1 -> APIC 0x0027 -> Node 1
[    0.018513] SRAT: PXM 1 -> APIC 0x0029 -> Node 1
[    0.018514] SRAT: PXM 1 -> APIC 0x0031 -> Node 1
[    0.018515] SRAT: PXM 1 -> APIC 0x0033 -> Node 1
[    0.018515] SRAT: PXM 1 -> APIC 0x0035 -> Node 1
[    0.018516] SRAT: PXM 1 -> APIC 0x0037 -> Node 1
[    0.018517] SRAT: PXM 1 -> APIC 0x0039 -> Node 1
[    0.018521] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.018523] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x183fffffff]
[    0.018525] ACPI: SRAT: Node 1 PXM 1 [mem 0x1840000000-0x303fffffff]
[    0.018532] NUMA: Initialized distance table, cnt=2
[    0.018535] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x183fffffff] -> [mem 0x00000000-0x183fffffff]
[    0.018547] NODE_DATA(0) allocated [mem 0x183ffde000-0x183fffffff]
[    0.018562] NODE_DATA(1) allocated [mem 0x303b7db000-0x303b7fcfff]
[    0.018710] hugetlb_cma: reserve 49152 MiB, up to 24576 MiB per node
[    0.018714] cma: Reserved 24576 MiB at 0x0000000100000000 on node 0
[    0.018716] hugetlb_cma: reserved 24576 MiB on node 0
[    0.018717] cma: Reserved 24576 MiB at 0x0000001840000000 on node 1
[    0.018719] hugetlb_cma: reserved 24576 MiB on node 1
[    0.018866] Zone ranges:
[    0.018867]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018869]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018870]   Normal   [mem 0x0000000100000000-0x000000303fffffff]
[    0.018872] Movable zone start for each node
[    0.018874] Early memory node ranges
[    0.018875]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.018876]   node   0: [mem 0x0000000000100000-0x00000000687fbfff]
[    0.018878]   node   0: [mem 0x000000006fb34000-0x000000006fffffff]
[    0.018878]   node   0: [mem 0x0000000100000000-0x000000183fffffff]
[    0.018887]   node   1: [mem 0x0000001840000000-0x000000303fffffff]
[    0.018896] Initmem setup node 0 [mem 0x0000000000001000-0x000000183fffffff]
[    0.018899] Initmem setup node 1 [mem 0x0000001840000000-0x000000303fffffff]
[    0.018903] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018931] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.022054] On node 0, zone DMA32: 29496 pages in unavailable ranges
[    0.022847] ACPI: PM-Timer IO Port: 0x508
[    0.022862] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.022865] ACPI: LAPIC_NMI (acpi_id[0xff] dfl edge lint[0x1])
[    0.022884] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.022889] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.022894] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.022898] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.022902] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.022907] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 72-79
[    0.022912] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 80-87
[    0.022916] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 88-95
[    0.022921] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 96-103
[    0.022925] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.022927] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.022935] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.022936] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.022940] ACPI: SPCR: console: uart,io,0x2f8,115200
[    0.022941] TSC deadline timer available
[    0.022942] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.022960] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.022963] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.022965] PM: hibernation: Registered nosave memory: [mem 0x5baf3000-0x5baf3fff]
[    0.022967] PM: hibernation: Registered nosave memory: [mem 0x5bb0e000-0x5bb0efff]
[    0.022968] PM: hibernation: Registered nosave memory: [mem 0x5bb0f000-0x5bb0ffff]
[    0.022970] PM: hibernation: Registered nosave memory: [mem 0x5bb43000-0x5bb43fff]
[    0.022971] PM: hibernation: Registered nosave memory: [mem 0x5bb44000-0x5bb44fff]
[    0.022973] PM: hibernation: Registered nosave memory: [mem 0x5bb78000-0x5bb78fff]
[    0.022974] PM: hibernation: Registered nosave memory: [mem 0x5bb79000-0x5bb79fff]
[    0.022976] PM: hibernation: Registered nosave memory: [mem 0x5bb83000-0x5bb83fff]
[    0.022977] PM: hibernation: Registered nosave memory: [mem 0x5bb84000-0x5bb84fff]
[    0.022979] PM: hibernation: Registered nosave memory: [mem 0x5bb8e000-0x5bb8efff]
[    0.022980] PM: hibernation: Registered nosave memory: [mem 0x5bb8f000-0x5bb8ffff]
[    0.022982] PM: hibernation: Registered nosave memory: [mem 0x5bbb3000-0x5bbb3fff]
[    0.022983] PM: hibernation: Registered nosave memory: [mem 0x5bbb4000-0x5bbb4fff]
[    0.022985] PM: hibernation: Registered nosave memory: [mem 0x5bbbc000-0x5bbbcfff]
[    0.022987] PM: hibernation: Registered nosave memory: [mem 0x62eca000-0x62ecafff]
[    0.022989] PM: hibernation: Registered nosave memory: [mem 0x687fc000-0x6a8fbfff]
[    0.022989] PM: hibernation: Registered nosave memory: [mem 0x6a8fc000-0x6aed7fff]
[    0.022990] PM: hibernation: Registered nosave memory: [mem 0x6aed8000-0x6c0f9fff]
[    0.022991] PM: hibernation: Registered nosave memory: [mem 0x6c0fa000-0x6fb33fff]
[    0.022993] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x7fffffff]
[    0.022994] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xfed1ffff]
[    0.022995] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed44fff]
[    0.022996] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xffffffff]
[    0.022997] [mem 0x80000000-0xfed1ffff] available for PCI devices
[    0.023000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.034559] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:2
[    0.034804] percpu: Embedded 56 pages/cpu s189800 r8192 d31384 u2097152
[    0.034813] pcpu-alloc: s189800 r8192 d31384 u2097152 alloc=1*2097152
[    0.034816] pcpu-alloc: [0] 0 
[    0.034839] Kernel command line: BOOT_IMAGE=/vmlinuz-6.6.0-andres-00004-gec9aedb2aa1a root=/dev/mapper/awork3--sa--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=sm_on iommu=pt nvme.poll_queues=4 cgroup.memory=nokmem coredump_filter=511 log_buf_len=16M hugetlb_cma=48G quiet
[    0.034918] DMAR: Enable scalable mode if hardware supports
[    0.034933] Booting kernel: `4' invalid for parameter `nvme.poll_queues'
[    0.034980] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.6.0-andres-00004-gec9aedb2aa1a apparmor=0", will be passed to user space.
[    0.035002] random: crng init done
[    0.035026] Fallback order for Node 0: 0 1 
[    0.035029] Fallback order for Node 1: 1 0 
[    0.035031] Built 2 zonelists, mobility grouping on.  Total pages: 49193364
[    0.035033] Policy zone: Normal
[    0.035034] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.035047] software IO TLB: area num 1.
[    0.247252] Memory: 1640300K/199897500K available (26624K kernel code, 4315K rwdata, 22808K rodata, 2812K init, 3272K bss, 3407556K reserved, 50331648K cma-reserved)
[    0.247725] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=2
[    0.247744] ftrace: allocating 78581 entries in 307 pages
[    0.263249] ftrace: allocated 307 pages with 5 groups
[    0.264414] Dynamic Preempt: voluntary
[    0.264441] rcu: Preemptible hierarchical RCU implementation.
[    0.264442] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=1.
[    0.264443] 	Trampoline variant of Tasks RCU enabled.
[    0.264444] 	Rude variant of Tasks RCU enabled.
[    0.264445] 	Tracing variant of Tasks RCU enabled.
[    0.264445] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.264446] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.268596] NR_IRQS: 524544, nr_irqs: 256, preallocated irqs: 16
[    0.268792] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.268888] Console: colour dummy device 80x25
[    0.268890] printk: console [tty0] enabled
[    0.268946] printk: console [ttyS1] enabled
[    0.276502] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.276506] ACPI: Core revision 20230628
[    0.278338] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.278384] APIC: Switch to symmetric I/O mode setup
[    0.278387] DMAR: Host address width 46
[    0.278388] DMAR: DRHD base: 0x000000d37fc000 flags: 0x0
[    0.278395] DMAR: dmar0: reg_base_addr d37fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278398] DMAR: DRHD base: 0x000000e0ffc000 flags: 0x0
[    0.278403] DMAR: dmar1: reg_base_addr e0ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278406] DMAR: DRHD base: 0x000000ee7fc000 flags: 0x0
[    0.278411] DMAR: dmar2: reg_base_addr ee7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278413] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.278416] DMAR: dmar3: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278418] DMAR: DRHD base: 0x000000aaffc000 flags: 0x0
[    0.278421] DMAR: dmar4: reg_base_addr aaffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278423] DMAR: DRHD base: 0x000000b87fc000 flags: 0x0
[    0.278427] DMAR: dmar5: reg_base_addr b87fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278428] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
[    0.278433] DMAR: dmar6: reg_base_addr c5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278434] DMAR: DRHD base: 0x0000009d7fc000 flags: 0x1
[    0.278438] DMAR: dmar7: reg_base_addr 9d7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.278440] DMAR: RMRR base: 0x0000006f605000 end: 0x0000006f615fff
[    0.278442] DMAR: ATSR flags: 0x0
[    0.278443] DMAR: ATSR flags: 0x0
[    0.278444] DMAR: RHSA base: 0x0000009d7fc000 proximity domain: 0x0
[    0.278446] DMAR: RHSA base: 0x000000aaffc000 proximity domain: 0x0
[    0.278447] DMAR: RHSA base: 0x000000b87fc000 proximity domain: 0x0
[    0.278448] DMAR: RHSA base: 0x000000c5ffc000 proximity domain: 0x0
[    0.278449] DMAR: RHSA base: 0x000000d37fc000 proximity domain: 0x1
[    0.278450] DMAR: RHSA base: 0x000000e0ffc000 proximity domain: 0x1
[    0.278451] DMAR: RHSA base: 0x000000ee7fc000 proximity domain: 0x1
[    0.278452] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x1
[    0.278454] DMAR-IR: IOAPIC id 12 under DRHD base  0xc5ffc000 IOMMU 6
[    0.278456] DMAR-IR: IOAPIC id 11 under DRHD base  0xb87fc000 IOMMU 5
[    0.278458] DMAR-IR: IOAPIC id 10 under DRHD base  0xaaffc000 IOMMU 4
[    0.278459] DMAR-IR: IOAPIC id 18 under DRHD base  0xfbffc000 IOMMU 3
[    0.278460] DMAR-IR: IOAPIC id 17 under DRHD base  0xee7fc000 IOMMU 2
[    0.278461] DMAR-IR: IOAPIC id 16 under DRHD base  0xe0ffc000 IOMMU 1
[    0.278463] DMAR-IR: IOAPIC id 15 under DRHD base  0xd37fc000 IOMMU 0
[    0.278464] DMAR-IR: IOAPIC id 8 under DRHD base  0x9d7fc000 IOMMU 7
[    0.278465] DMAR-IR: IOAPIC id 9 under DRHD base  0x9d7fc000 IOMMU 7
[    0.278466] DMAR-IR: HPET id 0 under DRHD base 0x9d7fc000
[    0.278468] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.280680] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.281715] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.286364] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
[    0.286369] Calibrating delay loop (skipped), value calculated using timer frequency.. 5000.00 BogoMIPS (lpj=2500000)
[    0.286397] CPU0: Thermal monitoring enabled (TM1)
[    0.286552] process: using mwait in idle threads
[    0.286555] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.286557] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.286562] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.286565] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.287368] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.287369] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.287370] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.287372] RETBleed: Mitigation: Enhanced IBRS
[    0.287374] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.287376] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.287383] TAA: Mitigation: TSX disabled
[    0.287384] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.287394] GDS: Mitigation: Microcode
[    0.287400] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.287402] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.287403] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.287404] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.287405] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.287406] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.287407] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.287408] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.287409] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.287410] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.287412] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.287413] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.287415] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.287416] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.287417] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.287418] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.287419] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.304911] Freeing SMP alternatives memory: 60K
[    0.304914] pid_max: default: 32768 minimum: 301
[    0.306395] LSM: initializing lsm=capability,integrity
[    0.338333] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc hugepage)
[    0.354272] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc hugepage)
[    0.354822] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    0.355351] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    0.356424] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
[    0.356572] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.356587] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.356601] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.356614] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.356641] ... version:                4
[    0.356642] ... bit width:              48
[    0.356643] ... generic registers:      4
[    0.356644] ... value mask:             0000ffffffffffff
[    0.356645] ... max period:             00007fffffffffff
[    0.356646] ... fixed-purpose events:   3
[    0.356647] ... event mask:             000000070000000f
[    0.356749] signal: max sigframe size: 3632
[    0.356764] Estimated ratio of average max frequency by base frequency (times 1024): 1310
[    0.356790] rcu: Hierarchical SRCU implementation.
[    0.356791] rcu: 	Max phase no-delay instances is 400.
[    0.357098] smp: Bringing up secondary CPUs ...
[    0.357107] smp: Brought up 2 nodes, 1 CPU
[    0.357108] smpboot: Max logical packages: 1
[    0.357110] smpboot: Total of 1 processors activated (5000.00 BogoMIPS)
[    0.726283] node 0 deferred pages initialised in 368ms
[    0.774704] node 1 deferred pages initialised in 418ms
[    0.781943] devtmpfs: initialized
[    0.781989] x86/mm: Memory block size: 2048MB
[    0.786056] ACPI: PM: Registering ACPI NVS region [mem 0x6aed8000-0x6c0f9fff] (19013632 bytes)
[    0.786303] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.786310] futex hash table entries: 256 (order: 2, 16384 bytes, vmalloc)
[    0.980778] pinctrl core: initialized pinctrl subsystem
[    0.981682] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.981818] audit: initializing netlink subsys (disabled)
[    0.981844] audit: type=2000 audit(1701843060.703:1): state=initialized audit_enabled=0 res=1
[    0.981933] thermal_sys: Registered thermal governor 'fair_share'
[    0.981934] thermal_sys: Registered thermal governor 'bang_bang'
[    0.981935] thermal_sys: Registered thermal governor 'step_wise'
[    0.981936] thermal_sys: Registered thermal governor 'user_space'
[    0.981936] thermal_sys: Registered thermal governor 'power_allocator'
[    0.981945] cpuidle: using governor ladder
[    0.981949] cpuidle: using governor menu
[    0.981965] Detected 1 PCC Subspaces
[    0.981966] Registering PCC driver as Mailbox controller
[    0.982045] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.982047] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.982097] dca service started, version 1.12.1
[    0.982108] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.982112] PCI: not using MMCONFIG
[    0.982113] PCI: Using configuration type 1 for base access
[    0.982204] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.982268] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.038517] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.038519] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.038521] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.038523] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.041505] cryptd: max_cpu_qlen set to 1000
[    1.041640] raid6: skipped pq benchmark and selected avx512x4
[    1.041642] raid6: using avx512x2 recovery algorithm
[    1.041709] ACPI: Added _OSI(Module Device)
[    1.041710] ACPI: Added _OSI(Processor Device)
[    1.041712] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.041713] ACPI: Added _OSI(Processor Aggregator Device)
[    1.137540] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    1.140504] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.153754] ACPI: _OSC evaluated successfully for all CPUs
[    1.154245] ACPI: Interpreter enabled
[    1.154264] ACPI: PM: (supports S0 S4 S5)
[    1.154266] ACPI: Using IOAPIC for interrupt routing
[    1.154289] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    1.160865] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[    1.160867] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
[    1.160905] HEST: Table parsing has been initialized.
[    1.161374] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    1.161378] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.161380] PCI: Ignoring E820 reservations for host bridge windows
[    1.165297] ACPI: Enabled 6 GPEs in block 00 to 7F
[    1.187961] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 1/0x7f00 ignored.
[    1.187964] ACPI: Unable to map lapic to logical cpu number
[    1.188191] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 2/0x7f02 ignored.
[    1.188192] ACPI: Unable to map lapic to logical cpu number
[    1.188417] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 3/0x7f04 ignored.
[    1.188419] ACPI: Unable to map lapic to logical cpu number
[    1.188641] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 4/0x7f06 ignored.
[    1.188642] ACPI: Unable to map lapic to logical cpu number
[    1.188859] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 5/0x7f08 ignored.
[    1.188861] ACPI: Unable to map lapic to logical cpu number
[    1.189077] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 6/0x7f10 ignored.
[    1.189079] ACPI: Unable to map lapic to logical cpu number
[    1.189295] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 7/0x7f12 ignored.
[    1.189296] ACPI: Unable to map lapic to logical cpu number
[    1.189517] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 8/0x7f14 ignored.
[    1.189518] ACPI: Unable to map lapic to logical cpu number
[    1.189735] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 9/0x7f16 ignored.
[    1.189736] ACPI: Unable to map lapic to logical cpu number
[    1.189951] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 10/0x7f18 ignored.
[    1.189952] ACPI: Unable to map lapic to logical cpu number
[    1.190168] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 11/0x7f01 ignored.
[    1.190170] ACPI: Unable to map lapic to logical cpu number
[    1.190387] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 12/0x7f03 ignored.
[    1.190388] ACPI: Unable to map lapic to logical cpu number
[    1.190604] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 13/0x7f05 ignored.
[    1.190606] ACPI: Unable to map lapic to logical cpu number
[    1.190821] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 14/0x7f07 ignored.
[    1.190822] ACPI: Unable to map lapic to logical cpu number
[    1.191038] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 15/0x7f09 ignored.
[    1.191039] ACPI: Unable to map lapic to logical cpu number
[    1.191254] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 16/0x7f11 ignored.
[    1.191256] ACPI: Unable to map lapic to logical cpu number
[    1.191476] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 17/0x7f13 ignored.
[    1.191477] ACPI: Unable to map lapic to logical cpu number
[    1.191693] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 18/0x7f15 ignored.
[    1.191694] ACPI: Unable to map lapic to logical cpu number
[    1.191910] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 19/0x7f17 ignored.
[    1.191912] ACPI: Unable to map lapic to logical cpu number
[    1.192128] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 20/0x7f19 ignored.
[    1.192129] ACPI: Unable to map lapic to logical cpu number
[    1.193033] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 21/0x7f20 ignored.
[    1.193035] ACPI: Unable to map lapic to logical cpu number
[    1.193253] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 22/0x7f22 ignored.
[    1.193254] ACPI: Unable to map lapic to logical cpu number
[    1.193471] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 23/0x7f24 ignored.
[    1.193472] ACPI: Unable to map lapic to logical cpu number
[    1.193688] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 24/0x7f26 ignored.
[    1.193690] ACPI: Unable to map lapic to logical cpu number
[    1.193905] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 25/0x7f28 ignored.
[    1.193907] ACPI: Unable to map lapic to logical cpu number
[    1.194122] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 26/0x7f30 ignored.
[    1.194123] ACPI: Unable to map lapic to logical cpu number
[    1.194338] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 27/0x7f32 ignored.
[    1.194340] ACPI: Unable to map lapic to logical cpu number
[    1.194559] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 28/0x7f34 ignored.
[    1.194560] ACPI: Unable to map lapic to logical cpu number
[    1.194777] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 29/0x7f36 ignored.
[    1.194778] ACPI: Unable to map lapic to logical cpu number
[    1.194995] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 30/0x7f38 ignored.
[    1.194996] ACPI: Unable to map lapic to logical cpu number
[    1.195212] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 31/0x7f21 ignored.
[    1.195213] ACPI: Unable to map lapic to logical cpu number
[    1.195433] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 32/0x7f23 ignored.
[    1.195434] ACPI: Unable to map lapic to logical cpu number
[    1.195651] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 33/0x7f25 ignored.
[    1.195652] ACPI: Unable to map lapic to logical cpu number
[    1.195867] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 34/0x7f27 ignored.
[    1.195869] ACPI: Unable to map lapic to logical cpu number
[    1.196084] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 35/0x7f29 ignored.
[    1.196086] ACPI: Unable to map lapic to logical cpu number
[    1.196301] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 36/0x7f31 ignored.
[    1.196303] ACPI: Unable to map lapic to logical cpu number
[    1.196519] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 37/0x7f33 ignored.
[    1.196521] ACPI: Unable to map lapic to logical cpu number
[    1.196736] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 38/0x7f35 ignored.
[    1.196737] ACPI: Unable to map lapic to logical cpu number
[    1.196953] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 39/0x7f37 ignored.
[    1.196954] ACPI: Unable to map lapic to logical cpu number
[    1.197169] APIC: NR_CPUS/possible_cpus limit of 1 reached. Processor 40/0x7f39 ignored.
[    1.197170] ACPI: Unable to map lapic to logical cpu number
[    1.198005] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    1.198011] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.198066] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]
[    1.198158] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.198160] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.198689] PCI host bridge to bus 0000:00
[    1.198691] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.198693] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.198695] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    1.198696] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    1.198697] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    1.198699] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.198700] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    1.198702] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    1.198703] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7fffff window]
[    1.198705] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383fffffffff window]
[    1.198707] pci_bus 0000:00: root bus resource [bus 00-16]
[    1.198728] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    1.198886] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    1.198905] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff40000-0x383ffff43fff 64bit]
[    1.199009] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    1.199028] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff3c000-0x383ffff3ffff 64bit]
[    1.199127] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    1.199146] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff38000-0x383ffff3bfff 64bit]
[    1.199244] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    1.199263] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff34000-0x383ffff37fff 64bit]
[    1.199358] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    1.199377] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff30000-0x383ffff33fff 64bit]
[    1.199473] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    1.199492] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff2c000-0x383ffff2ffff 64bit]
[    1.199587] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    1.199606] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff28000-0x383ffff2bfff 64bit]
[    1.199702] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    1.199720] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff24000-0x383ffff27fff 64bit]
[    1.199814] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    1.199912] pci 0000:00:05.1: [8086:2022] type 00 class 0x088000
[    1.200034] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    1.200128] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    1.200145] pci 0000:00:05.4: reg 0x10: [mem 0x9d30a000-0x9d30afff]
[    1.200256] pci 0000:00:05.6: [8086:2027] type 00 class 0x110100
[    1.200348] pci 0000:00:07.0: [8086:2028] type 00 class 0x088000
[    1.200442] pci 0000:00:07.4: [8086:202c] type 00 class 0x088000
[    1.200534] pci 0000:00:07.7: [8086:202d] type 00 class 0x088000
[    1.200624] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    1.200715] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    1.200783] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    1.200875] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    1.200968] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    1.200991] pci 0000:00:11.5: reg 0x10: [mem 0x9d306000-0x9d307fff]
[    1.201006] pci 0000:00:11.5: reg 0x14: [mem 0x9d309000-0x9d3090ff]
[    1.201020] pci 0000:00:11.5: reg 0x18: [io  0x3070-0x3077]
[    1.201034] pci 0000:00:11.5: reg 0x1c: [io  0x3060-0x3063]
[    1.201049] pci 0000:00:11.5: reg 0x20: [io  0x3020-0x303f]
[    1.201063] pci 0000:00:11.5: reg 0x24: [mem 0x9d280000-0x9d2fffff]
[    1.201104] pci 0000:00:11.5: PME# supported from D3hot
[    1.201306] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    1.201337] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff10000-0x383ffff1ffff 64bit]
[    1.201435] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.201621] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    1.201652] pci 0000:00:14.2: reg 0x10: [mem 0x383ffff47000-0x383ffff47fff 64bit]
[    1.201808] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    1.201845] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff46000-0x383ffff46fff 64bit]
[    1.201960] pci 0000:00:16.0: PME# supported from D3hot
[    1.202026] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
[    1.202063] pci 0000:00:16.1: reg 0x10: [mem 0x383ffff45000-0x383ffff45fff 64bit]
[    1.202178] pci 0000:00:16.1: PME# supported from D3hot
[    1.202246] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    1.202283] pci 0000:00:16.4: reg 0x10: [mem 0x383ffff44000-0x383ffff44fff 64bit]
[    1.202398] pci 0000:00:16.4: PME# supported from D3hot
[    1.202463] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    1.202486] pci 0000:00:17.0: reg 0x10: [mem 0x9d304000-0x9d305fff]
[    1.202501] pci 0000:00:17.0: reg 0x14: [mem 0x9d308000-0x9d3080ff]
[    1.202515] pci 0000:00:17.0: reg 0x18: [io  0x3050-0x3057]
[    1.202529] pci 0000:00:17.0: reg 0x1c: [io  0x3040-0x3043]
[    1.202543] pci 0000:00:17.0: reg 0x20: [io  0x3000-0x301f]
[    1.202557] pci 0000:00:17.0: reg 0x24: [mem 0x9d200000-0x9d27ffff]
[    1.202599] pci 0000:00:17.0: PME# supported from D3hot
[    1.202780] pci 0000:00:1c.0: [8086:a190] type 01 class 0x060400
[    1.202872] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.203229] pci 0000:00:1c.2: [8086:a192] type 01 class 0x060400
[    1.203326] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.203687] pci 0000:00:1c.5: [8086:a195] type 01 class 0x060400
[    1.203784] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.204146] pci 0000:00:1f.0: [8086:a1c1] type 00 class 0x060100
[    1.204417] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    1.204437] pci 0000:00:1f.2: reg 0x10: [mem 0x9d300000-0x9d303fff]
[    1.204645] pci 0000:00:1f.3: [8086:a1f0] type 00 class 0x040300
[    1.204675] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff20000-0x383ffff23fff 64bit]
[    1.204713] pci 0000:00:1f.3: reg 0x20: [mem 0x383ffff00000-0x383ffff0ffff 64bit]
[    1.204776] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    1.205023] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    1.205058] pci 0000:00:1f.4: reg 0x10: [mem 0x9d7fb000-0x9d7fb0ff 64bit]
[    1.205099] pci 0000:00:1f.4: reg 0x20: [io  0x3fe0-0x3fff]
[    1.205183] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    1.205208] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    1.205378] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.205442] pci 0000:02:00.0: [1b21:2142] type 00 class 0x0c0330
[    1.205477] pci 0000:02:00.0: reg 0x10: [mem 0x9d100000-0x9d107fff 64bit]
[    1.205561] pci 0000:02:00.0: enabling Extended Tags
[    1.205626] pci 0000:02:00.0: PME# supported from D0
[    1.205756] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.205760] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    1.205819] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
[    1.205899] pci 0000:03:00.0: enabling Extended Tags
[    1.205963] pci 0000:03:00.0: supports D1 D2
[    1.205964] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.206068] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    1.206071] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    1.206074] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.206113] pci_bus 0000:04: extended config space not accessible
[    1.206137] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
[    1.206168] pci 0000:04:00.0: reg 0x10: [mem 0x9c000000-0x9cffffff]
[    1.206187] pci 0000:04:00.0: reg 0x14: [mem 0x9d000000-0x9d01ffff]
[    1.206205] pci 0000:04:00.0: reg 0x18: [io  0x2000-0x207f]
[    1.206290] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.206327] pci 0000:04:00.0: supports D1 D2
[    1.206328] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.206428] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.206434] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    1.206437] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.206478] pci_bus 0000:00: on NUMA node 0
[    1.207040] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    1.207044] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.207304] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]
[    1.207509] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.207511] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.207667] PCI host bridge to bus 0000:17
[    1.207669] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    1.207671] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaaffffff window]
[    1.207672] pci_bus 0000:17: root bus resource [mem 0x384000000000-0x387fffffffff window]
[    1.207674] pci_bus 0000:17: root bus resource [bus 17-39]
[    1.207692] pci 0000:17:00.0: [8086:2030] type 01 class 0x060400
[    1.207741] pci 0000:17:00.0: enabling Extended Tags
[    1.207776] pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
[    1.207929] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    1.208025] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    1.208118] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    1.208135] pci 0000:17:05.4: reg 0x10: [mem 0xaaf00000-0xaaf00fff]
[    1.208246] pci 0000:17:05.6: [8086:2037] type 00 class 0x110100
[    1.208337] pci 0000:17:07.0: [8086:2038] type 00 class 0x088000
[    1.208428] pci 0000:17:07.1: [8086:2039] type 00 class 0x088000
[    1.208518] pci 0000:17:07.2: [8086:203a] type 00 class 0x088000
[    1.208608] pci 0000:17:07.3: [8086:203b] type 00 class 0x088000
[    1.208699] pci 0000:17:07.4: [8086:203c] type 00 class 0x088000
[    1.208790] pci 0000:17:07.7: [8086:203d] type 00 class 0x088000
[    1.208877] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    1.208958] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    1.209024] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    1.209089] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    1.209153] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    1.209217] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    1.209281] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    1.209346] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    1.209411] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    1.209491] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    1.209556] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    1.209620] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    1.209685] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    1.209748] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    1.209814] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    1.209879] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    1.209944] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    1.210025] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    1.210095] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    1.210174] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    1.210239] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    1.210304] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    1.210369] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    1.210433] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    1.210497] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    1.210563] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    1.210628] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    1.210707] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    1.210772] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    1.210837] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    1.210903] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    1.210967] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    1.211031] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    1.211096] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    1.211160] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    1.211240] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    1.211312] pci 0000:17:14.0: [8086:208f] type 00 class 0x088000
[    1.211391] pci 0000:17:14.1: [8086:208f] type 00 class 0x088000
[    1.211457] pci 0000:17:14.2: [8086:208f] type 00 class 0x088000
[    1.211521] pci 0000:17:14.3: [8086:208f] type 00 class 0x088000
[    1.211585] pci 0000:17:14.4: [8086:208f] type 00 class 0x088000
[    1.211650] pci 0000:17:14.5: [8086:208f] type 00 class 0x088000
[    1.211714] pci 0000:17:14.6: [8086:208f] type 00 class 0x088000
[    1.211779] pci 0000:17:14.7: [8086:208f] type 00 class 0x088000
[    1.211844] pci 0000:17:15.0: [8086:208f] type 00 class 0x088000
[    1.211927] pci 0000:17:15.1: [8086:208f] type 00 class 0x088000
[    1.211992] pci 0000:17:15.2: [8086:208f] type 00 class 0x088000
[    1.212056] pci 0000:17:15.3: [8086:208f] type 00 class 0x088000
[    1.212121] pci 0000:17:15.4: [8086:208f] type 00 class 0x088000
[    1.212185] pci 0000:17:15.5: [8086:208f] type 00 class 0x088000
[    1.212250] pci 0000:17:15.6: [8086:208f] type 00 class 0x088000
[    1.212314] pci 0000:17:15.7: [8086:208f] type 00 class 0x088000
[    1.212380] pci 0000:17:16.0: [8086:208f] type 00 class 0x088000
[    1.212460] pci 0000:17:16.1: [8086:208f] type 00 class 0x088000
[    1.212536] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    1.212616] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    1.212681] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    1.212746] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    1.212817] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    1.212896] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    1.212961] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    1.213034] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    1.213102] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    1.213167] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    1.213232] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    1.213299] pci 0000:17:1f.0: [8086:2078] type 00 class 0x088000
[    1.213381] pci 0000:17:1f.1: [8086:2079] type 00 class 0x088000
[    1.213446] pci 0000:17:1f.2: [8086:207a] type 00 class 0x088000
[    1.213511] pci 0000:17:1f.3: [8086:207b] type 00 class 0x088000
[    1.213576] pci 0000:17:1f.4: [8086:207c] type 00 class 0x088000
[    1.213642] pci 0000:17:1f.5: [8086:207d] type 00 class 0x088000
[    1.213708] pci 0000:17:1f.6: [8086:207e] type 00 class 0x088000
[    1.213774] pci 0000:17:1f.7: [8086:207f] type 00 class 0x088000
[    1.213884] pci 0000:18:00.0: [8086:1528] type 00 class 0x020000
[    1.213912] pci 0000:18:00.0: reg 0x10: [mem 0xaa800000-0xaa9fffff 64bit pref]
[    1.213958] pci 0000:18:00.0: reg 0x20: [mem 0xaaa00000-0xaaa03fff 64bit pref]
[    1.213972] pci 0000:18:00.0: reg 0x30: [mem 0xaac00000-0xaac7ffff pref]
[    1.214030] pci 0000:18:00.0: PME# supported from D0 D3hot
[    1.214060] pci 0000:18:00.0: reg 0x184: [mem 0xaad80000-0xaad83fff 64bit]
[    1.214062] pci 0000:18:00.0: VF(n) BAR0 space: [mem 0xaad80000-0xaae7ffff 64bit] (contains BAR0 for 64 VFs)
[    1.214083] pci 0000:18:00.0: reg 0x190: [mem 0xaac80000-0xaac83fff 64bit]
[    1.214084] pci 0000:18:00.0: VF(n) BAR3 space: [mem 0xaac80000-0xaad7ffff 64bit] (contains BAR3 for 64 VFs)
[    1.214282] pci 0000:17:00.0: PCI bridge to [bus 18]
[    1.214286] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    1.214289] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.214304] pci_bus 0000:17: on NUMA node 0
[    1.214416] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    1.214419] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.214677] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]
[    1.214870] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.214872] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.214997] PCI host bridge to bus 0000:3a
[    1.214999] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    1.215001] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87fffff window]
[    1.215003] pci_bus 0000:3a: root bus resource [mem 0x388000000000-0x38bfffffffff window]
[    1.215004] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    1.215021] pci 0000:3a:00.0: [8086:2030] type 01 class 0x060400
[    1.215069] pci 0000:3a:00.0: enabling Extended Tags
[    1.215102] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    1.215255] pci 0000:3a:01.0: [8086:2031] type 01 class 0x060400
[    1.215303] pci 0000:3a:01.0: enabling Extended Tags
[    1.215335] pci 0000:3a:01.0: PME# supported from D0 D3hot D3cold
[    1.215431] pci 0000:3a:02.0: [8086:2032] type 01 class 0x060400
[    1.215478] pci 0000:3a:02.0: enabling Extended Tags
[    1.215510] pci 0000:3a:02.0: PME# supported from D0 D3hot D3cold
[    1.215602] pci 0000:3a:03.0: [8086:2033] type 01 class 0x060400
[    1.215649] pci 0000:3a:03.0: enabling Extended Tags
[    1.215680] pci 0000:3a:03.0: PME# supported from D0 D3hot D3cold
[    1.215766] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    1.215860] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    1.215950] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    1.215967] pci 0000:3a:05.4: reg 0x10: [mem 0xb8700000-0xb8700fff]
[    1.216077] pci 0000:3a:05.6: [8086:2037] type 00 class 0x110100
[    1.216169] pci 0000:3a:07.0: [8086:2038] type 00 class 0x088000
[    1.216259] pci 0000:3a:07.1: [8086:2039] type 00 class 0x088000
[    1.216348] pci 0000:3a:07.2: [8086:203a] type 00 class 0x088000
[    1.216435] pci 0000:3a:07.3: [8086:203b] type 00 class 0x088000
[    1.216526] pci 0000:3a:07.4: [8086:203c] type 00 class 0x088000
[    1.216615] pci 0000:3a:07.7: [8086:203d] type 00 class 0x088000
[    1.216703] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    1.216795] pci 0000:3a:08.1: [8086:2067] type 00 class 0x088000
[    1.216866] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    1.216958] pci 0000:3a:09.1: [8086:2067] type 00 class 0x088000
[    1.217027] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    1.217122] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    1.217202] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    1.217281] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    1.217361] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    1.217440] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    1.217519] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    1.217598] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    1.217678] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    1.217771] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    1.217852] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    1.217933] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    1.218015] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    1.218108] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    1.218188] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    1.218269] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    1.218349] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    1.218428] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    1.218508] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    1.218589] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    1.218670] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    1.218764] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    1.218845] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    1.218925] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    1.219056] pci 0000:3b:00.0: [1cc1:8201] type 00 class 0x010802
[    1.219084] pci 0000:3b:00.0: reg 0x10: [mem 0xb8600000-0xb8603fff 64bit]
[    1.219275] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    1.219278] pci 0000:3a:00.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    1.219322] pci 0000:3c:00.0: [144d:a808] type 00 class 0x010802
[    1.219350] pci 0000:3c:00.0: reg 0x10: [mem 0xb8500000-0xb8503fff 64bit]
[    1.219558] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    1.219561] pci 0000:3a:01.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    1.219604] pci 0000:3d:00.0: [144d:a808] type 00 class 0x010802
[    1.219632] pci 0000:3d:00.0: reg 0x10: [mem 0xb8400000-0xb8403fff 64bit]
[    1.219837] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    1.219840] pci 0000:3a:02.0:   bridge window [mem 0xb8400000-0xb84fffff]
[    1.219882] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    1.219910] pci 0000:3e:00.0: reg 0x10: [mem 0xb8300000-0xb8303fff 64bit]
[    1.220114] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    1.220117] pci 0000:3a:03.0:   bridge window [mem 0xb8300000-0xb83fffff]
[    1.220157] pci_bus 0000:3a: on NUMA node 0
[    1.220241] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[    1.220245] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.220503] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]
[    1.220697] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.220699] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.220840] PCI host bridge to bus 0000:5d
[    1.220842] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[    1.220844] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
[    1.220845] pci_bus 0000:5d: root bus resource [mem 0x38c000000000-0x38ffffffffff window]
[    1.220847] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[    1.220865] pci 0000:5d:00.0: [8086:2030] type 01 class 0x060400
[    1.220947] pci 0000:5d:00.0: PME# supported from D0 D3hot D3cold
[    1.221049] pci 0000:5d:01.0: [8086:2031] type 01 class 0x060400
[    1.221130] pci 0000:5d:01.0: PME# supported from D0 D3hot D3cold
[    1.221221] pci 0000:5d:02.0: [8086:2032] type 01 class 0x060400
[    1.221270] pci 0000:5d:02.0: enabling Extended Tags
[    1.221305] pci 0000:5d:02.0: PME# supported from D0 D3hot D3cold
[    1.221402] pci 0000:5d:03.0: [8086:2033] type 01 class 0x060400
[    1.221450] pci 0000:5d:03.0: enabling Extended Tags
[    1.221485] pci 0000:5d:03.0: PME# supported from D0 D3hot D3cold
[    1.221575] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[    1.221670] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[    1.221765] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[    1.221782] pci 0000:5d:05.4: reg 0x10: [mem 0xc5f00000-0xc5f00fff]
[    1.221895] pci 0000:5d:05.6: [8086:2037] type 00 class 0x110100
[    1.221990] pci 0000:5d:07.0: [8086:2038] type 00 class 0x088000
[    1.222083] pci 0000:5d:07.1: [8086:2039] type 00 class 0x088000
[    1.222175] pci 0000:5d:07.2: [8086:203a] type 00 class 0x088000
[    1.222266] pci 0000:5d:07.3: [8086:203b] type 00 class 0x088000
[    1.222359] pci 0000:5d:07.4: [8086:203c] type 00 class 0x088000
[    1.222452] pci 0000:5d:07.7: [8086:203d] type 00 class 0x088000
[    1.222546] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[    1.222641] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[    1.222721] pci 0000:5d:0e.2: [8086:205a] type 00 class 0x088000
[    1.222799] pci 0000:5d:0e.3: [8086:205b] type 00 class 0x088000
[    1.222879] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[    1.222974] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[    1.223053] pci 0000:5d:0f.2: [8086:205a] type 00 class 0x088000
[    1.223135] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[    1.223228] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[    1.223295] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[    1.223360] pci 0000:5d:12.3: [8086:204f] type 00 class 0x088000
[    1.223426] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[    1.223506] pci 0000:5d:15.1: [8086:2088] type 00 class 0x110100
[    1.223571] pci 0000:5d:15.3: [8086:2019] type 00 class 0x088000
[    1.223638] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[    1.223717] pci 0000:5d:16.1: [8086:2088] type 00 class 0x110100
[    1.223783] pci 0000:5d:16.3: [8086:2019] type 00 class 0x088000
[    1.223847] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[    1.223913] pci 0000:5d:16.5: [8086:2088] type 00 class 0x110100
[    1.223978] pci 0000:5d:16.7: [8086:2019] type 00 class 0x088000
[    1.224089] pci 0000:5e:00.0: [8086:4140] type 00 class 0x010802
[    1.224114] pci 0000:5e:00.0: reg 0x10: [mem 0xc5d10000-0xc5d13fff 64bit]
[    1.224155] pci 0000:5e:00.0: reg 0x20: [mem 0xc5c00000-0xc5cfffff 64bit]
[    1.224167] pci 0000:5e:00.0: reg 0x30: [mem 0xc5d00000-0xc5d0ffff pref]
[    1.224269] pci 0000:5e:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:5d:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    1.224330] pci 0000:5d:00.0: PCI bridge to [bus 5e]
[    1.224334] pci 0000:5d:00.0:   bridge window [mem 0xc5c00000-0xc5dfffff]
[    1.224382] pci 0000:5f:00.0: [8086:4140] type 00 class 0x010802
[    1.224407] pci 0000:5f:00.0: reg 0x10: [mem 0xc5b10000-0xc5b13fff 64bit]
[    1.224448] pci 0000:5f:00.0: reg 0x20: [mem 0xc5a00000-0xc5afffff 64bit]
[    1.224460] pci 0000:5f:00.0: reg 0x30: [mem 0xc5b00000-0xc5b0ffff pref]
[    1.224561] pci 0000:5f:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:5d:01.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    1.224622] pci 0000:5d:01.0: PCI bridge to [bus 5f]
[    1.224625] pci 0000:5d:01.0:   bridge window [mem 0xc5a00000-0xc5bfffff]
[    1.224670] pci 0000:60:00.0: [144d:a808] type 00 class 0x010802
[    1.224698] pci 0000:60:00.0: reg 0x10: [mem 0xc5e00000-0xc5e03fff 64bit]
[    1.224903] pci 0000:5d:02.0: PCI bridge to [bus 60]
[    1.224907] pci 0000:5d:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
[    1.224950] pci 0000:61:00.0: [8086:37c0] type 01 class 0x060400
[    1.224978] pci 0000:61:00.0: reg 0x10: [mem 0xc5900000-0xc591ffff 64bit]
[    1.224991] pci 0000:61:00.0: reg 0x38: [mem 0xc5700000-0xc57fffff pref]
[    1.225051] pci 0000:61:00.0: PME# supported from D0 D3hot D3cold
[    1.225117] pci 0000:5d:03.0: PCI bridge to [bus 61-63]
[    1.225120] pci 0000:5d:03.0:   bridge window [mem 0xc5700000-0xc59fffff]
[    1.225123] pci 0000:5d:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.225161] pci 0000:62:03.0: [8086:37c5] type 01 class 0x060400
[    1.225275] pci 0000:62:03.0: PME# supported from D0 D3hot D3cold
[    1.225354] pci 0000:61:00.0: PCI bridge to [bus 62-63]
[    1.225358] pci 0000:61:00.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    1.225362] pci 0000:61:00.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.225407] pci 0000:63:00.0: [8086:37d1] type 00 class 0x020000
[    1.225438] pci 0000:63:00.0: reg 0x10: [mem 0xc3000000-0xc3ffffff 64bit pref]
[    1.225473] pci 0000:63:00.0: reg 0x1c: [mem 0xc4808000-0xc480ffff 64bit pref]
[    1.225502] pci 0000:63:00.0: reg 0x30: [mem 0xc5880000-0xc58fffff pref]
[    1.225509] pci 0000:63:00.0: enabling Extended Tags
[    1.225581] pci 0000:63:00.0: PME# supported from D0 D3hot D3cold
[    1.225618] pci 0000:63:00.0: reg 0x184: [mem 0xc4400000-0xc441ffff 64bit pref]
[    1.225619] pci 0000:63:00.0: VF(n) BAR0 space: [mem 0xc4400000-0xc47fffff 64bit pref] (contains BAR0 for 32 VFs)
[    1.225642] pci 0000:63:00.0: reg 0x190: [mem 0xc4890000-0xc4893fff 64bit pref]
[    1.225644] pci 0000:63:00.0: VF(n) BAR3 space: [mem 0xc4890000-0xc490ffff 64bit pref] (contains BAR3 for 32 VFs)
[    1.225839] pci 0000:63:00.1: [8086:37d1] type 00 class 0x020000
[    1.225870] pci 0000:63:00.1: reg 0x10: [mem 0xc2000000-0xc2ffffff 64bit pref]
[    1.225906] pci 0000:63:00.1: reg 0x1c: [mem 0xc4800000-0xc4807fff 64bit pref]
[    1.225934] pci 0000:63:00.1: reg 0x30: [mem 0xc5800000-0xc587ffff pref]
[    1.225941] pci 0000:63:00.1: enabling Extended Tags
[    1.226013] pci 0000:63:00.1: PME# supported from D0 D3hot D3cold
[    1.226043] pci 0000:63:00.1: reg 0x184: [mem 0xc4000000-0xc401ffff 64bit pref]
[    1.226044] pci 0000:63:00.1: VF(n) BAR0 space: [mem 0xc4000000-0xc43fffff 64bit pref] (contains BAR0 for 32 VFs)
[    1.226067] pci 0000:63:00.1: reg 0x190: [mem 0xc4810000-0xc4813fff 64bit pref]
[    1.226068] pci 0000:63:00.1: VF(n) BAR3 space: [mem 0xc4810000-0xc488ffff 64bit pref] (contains BAR3 for 32 VFs)
[    1.226256] pci 0000:62:03.0: PCI bridge to [bus 63]
[    1.226261] pci 0000:62:03.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    1.226265] pci 0000:62:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.226323] pci_bus 0000:5d: on NUMA node 0
[    1.226471] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[    1.226475] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.226606] acpi PNP0A08:06: _OSC: platform does not support [AER LTR]
[    1.226745] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.226747] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.226866] PCI host bridge to bus 0000:80
[    1.226868] pci_bus 0000:80: root bus resource [io  0xa000-0xbfff window]
[    1.226870] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37fffff window]
[    1.226872] pci_bus 0000:80: root bus resource [mem 0x390000000000-0x393fffffffff window]
[    1.226874] pci_bus 0000:80: root bus resource [bus 80-84]
[    1.226899] pci 0000:80:00.0: [8086:2030] type 01 class 0x060400
[    1.226949] pci 0000:80:00.0: enabling Extended Tags
[    1.226989] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    1.227093] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
[    1.227113] pci 0000:80:04.0: reg 0x10: [mem 0x393ffff1c000-0x393ffff1ffff 64bit]
[    1.227220] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
[    1.227240] pci 0000:80:04.1: reg 0x10: [mem 0x393ffff18000-0x393ffff1bfff 64bit]
[    1.227340] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
[    1.227359] pci 0000:80:04.2: reg 0x10: [mem 0x393ffff14000-0x393ffff17fff 64bit]
[    1.227458] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
[    1.227478] pci 0000:80:04.3: reg 0x10: [mem 0x393ffff10000-0x393ffff13fff 64bit]
[    1.227579] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
[    1.227598] pci 0000:80:04.4: reg 0x10: [mem 0x393ffff0c000-0x393ffff0ffff 64bit]
[    1.227698] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
[    1.227718] pci 0000:80:04.5: reg 0x10: [mem 0x393ffff08000-0x393ffff0bfff 64bit]
[    1.227816] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
[    1.227836] pci 0000:80:04.6: reg 0x10: [mem 0x393ffff04000-0x393ffff07fff 64bit]
[    1.227934] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
[    1.227954] pci 0000:80:04.7: reg 0x10: [mem 0x393ffff00000-0x393ffff03fff 64bit]
[    1.228052] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[    1.228153] pci 0000:80:05.1: [8086:2022] type 00 class 0x088000
[    1.228283] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[    1.228380] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[    1.228398] pci 0000:80:05.4: reg 0x10: [mem 0xd3700000-0xd3700fff]
[    1.228514] pci 0000:80:05.6: [8086:2027] type 00 class 0x110100
[    1.228611] pci 0000:80:07.0: [8086:2028] type 00 class 0x088000
[    1.228708] pci 0000:80:07.4: [8086:202c] type 00 class 0x088000
[    1.228804] pci 0000:80:07.7: [8086:202d] type 00 class 0x088000
[    1.228898] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[    1.228991] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[    1.229060] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[    1.229177] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.229194] pci_bus 0000:80: on NUMA node 1
[    1.229269] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[    1.229273] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.229530] acpi PNP0A08:07: _OSC: platform does not support [AER LTR]
[    1.229724] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.229725] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.229902] PCI host bridge to bus 0000:85
[    1.229904] pci_bus 0000:85: root bus resource [io  0xc000-0xdfff window]
[    1.229906] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0ffffff window]
[    1.229907] pci_bus 0000:85: root bus resource [mem 0x394000000000-0x397fffffffff window]
[    1.229909] pci_bus 0000:85: root bus resource [bus 85-ad]
[    1.229928] pci 0000:85:00.0: [8086:2030] type 01 class 0x060400
[    1.229978] pci 0000:85:00.0: enabling Extended Tags
[    1.230018] pci 0000:85:00.0: PME# supported from D0 D3hot D3cold
[    1.230181] pci 0000:85:02.0: [8086:2032] type 01 class 0x060400
[    1.230265] pci 0000:85:02.0: PME# supported from D0 D3hot D3cold
[    1.230413] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[    1.230514] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[    1.230611] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[    1.230629] pci 0000:85:05.4: reg 0x10: [mem 0xe0f00000-0xe0f00fff]
[    1.230745] pci 0000:85:05.6: [8086:2037] type 00 class 0x110100
[    1.230843] pci 0000:85:07.0: [8086:2038] type 00 class 0x088000
[    1.230938] pci 0000:85:07.1: [8086:2039] type 00 class 0x088000
[    1.231035] pci 0000:85:07.2: [8086:203a] type 00 class 0x088000
[    1.231131] pci 0000:85:07.3: [8086:203b] type 00 class 0x088000
[    1.231225] pci 0000:85:07.4: [8086:203c] type 00 class 0x088000
[    1.231322] pci 0000:85:07.7: [8086:203d] type 00 class 0x088000
[    1.231414] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[    1.231501] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[    1.231569] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[    1.231637] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[    1.231704] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[    1.231772] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[    1.231839] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[    1.231906] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[    1.231974] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[    1.232058] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[    1.232126] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[    1.232193] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[    1.232260] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[    1.232329] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[    1.232397] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[    1.232464] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[    1.232532] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[    1.232614] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[    1.232687] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[    1.232772] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[    1.232839] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[    1.232907] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[    1.232974] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[    1.233042] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[    1.233109] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[    1.233177] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[    1.233245] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[    1.233327] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[    1.233395] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[    1.233463] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[    1.233530] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[    1.233597] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[    1.233665] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[    1.233733] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[    1.233801] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[    1.233884] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[    1.233959] pci 0000:85:14.0: [8086:208f] type 00 class 0x088000
[    1.234042] pci 0000:85:14.1: [8086:208f] type 00 class 0x088000
[    1.234109] pci 0000:85:14.2: [8086:208f] type 00 class 0x088000
[    1.234175] pci 0000:85:14.3: [8086:208f] type 00 class 0x088000
[    1.234242] pci 0000:85:14.4: [8086:208f] type 00 class 0x088000
[    1.234311] pci 0000:85:14.5: [8086:208f] type 00 class 0x088000
[    1.234379] pci 0000:85:14.6: [8086:208f] type 00 class 0x088000
[    1.234447] pci 0000:85:14.7: [8086:208f] type 00 class 0x088000
[    1.234515] pci 0000:85:15.0: [8086:208f] type 00 class 0x088000
[    1.234600] pci 0000:85:15.1: [8086:208f] type 00 class 0x088000
[    1.234668] pci 0000:85:15.2: [8086:208f] type 00 class 0x088000
[    1.234735] pci 0000:85:15.3: [8086:208f] type 00 class 0x088000
[    1.234802] pci 0000:85:15.4: [8086:208f] type 00 class 0x088000
[    1.234869] pci 0000:85:15.5: [8086:208f] type 00 class 0x088000
[    1.234936] pci 0000:85:15.6: [8086:208f] type 00 class 0x088000
[    1.235003] pci 0000:85:15.7: [8086:208f] type 00 class 0x088000
[    1.235072] pci 0000:85:16.0: [8086:208f] type 00 class 0x088000
[    1.235155] pci 0000:85:16.1: [8086:208f] type 00 class 0x088000
[    1.235233] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[    1.235317] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[    1.235385] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[    1.235453] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[    1.235525] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[    1.235609] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[    1.235677] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[    1.235746] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[    1.235813] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[    1.235881] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[    1.235949] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[    1.236019] pci 0000:85:1f.0: [8086:2078] type 00 class 0x088000
[    1.236101] pci 0000:85:1f.1: [8086:2079] type 00 class 0x088000
[    1.236169] pci 0000:85:1f.2: [8086:207a] type 00 class 0x088000
[    1.236237] pci 0000:85:1f.3: [8086:207b] type 00 class 0x088000
[    1.236306] pci 0000:85:1f.4: [8086:207c] type 00 class 0x088000
[    1.236374] pci 0000:85:1f.5: [8086:207d] type 00 class 0x088000
[    1.236442] pci 0000:85:1f.6: [8086:207e] type 00 class 0x088000
[    1.236510] pci 0000:85:1f.7: [8086:207f] type 00 class 0x088000
[    1.236611] pci 0000:85:00.0: PCI bridge to [bus 86]
[    1.236661] pci 0000:87:00.0: [1987:5016] type 00 class 0x010802
[    1.236690] pci 0000:87:00.0: reg 0x10: [mem 0xe0e00000-0xe0e03fff 64bit]
[    1.236865] pci 0000:87:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:85:02.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    1.236931] pci 0000:85:02.0: PCI bridge to [bus 87]
[    1.236934] pci 0000:85:02.0:   bridge window [mem 0xe0e00000-0xe0efffff]
[    1.236960] pci_bus 0000:85: on NUMA node 1
[    1.237074] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[    1.237078] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.237331] acpi PNP0A08:08: _OSC: platform does not support [AER LTR]
[    1.237524] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.237526] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.237675] PCI host bridge to bus 0000:ae
[    1.237677] pci_bus 0000:ae: root bus resource [io  0xe000-0xefff window]
[    1.237679] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7fffff window]
[    1.237681] pci_bus 0000:ae: root bus resource [mem 0x398000000000-0x39bfffffffff window]
[    1.237682] pci_bus 0000:ae: root bus resource [bus ae-d6]
[    1.237701] pci 0000:ae:00.0: [8086:2030] type 01 class 0x060400
[    1.237785] pci 0000:ae:00.0: PME# supported from D0 D3hot D3cold
[    1.237941] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[    1.238041] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[    1.238138] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[    1.238157] pci 0000:ae:05.4: reg 0x10: [mem 0xee700000-0xee700fff]
[    1.238272] pci 0000:ae:05.6: [8086:2037] type 00 class 0x110100
[    1.238369] pci 0000:ae:07.0: [8086:2038] type 00 class 0x088000
[    1.238465] pci 0000:ae:07.1: [8086:2039] type 00 class 0x088000
[    1.238561] pci 0000:ae:07.2: [8086:203a] type 00 class 0x088000
[    1.238656] pci 0000:ae:07.3: [8086:203b] type 00 class 0x088000
[    1.238752] pci 0000:ae:07.4: [8086:203c] type 00 class 0x088000
[    1.238847] pci 0000:ae:07.7: [8086:203d] type 00 class 0x088000
[    1.238943] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[    1.239044] pci 0000:ae:08.1: [8086:2067] type 00 class 0x088000
[    1.239117] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[    1.239214] pci 0000:ae:09.1: [8086:2067] type 00 class 0x088000
[    1.239287] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[    1.239387] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[    1.239472] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[    1.239557] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[    1.239642] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[    1.239727] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[    1.239813] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[    1.239898] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[    1.239983] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[    1.240082] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[    1.240166] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[    1.240250] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[    1.240338] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[    1.240439] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[    1.240524] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[    1.240610] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[    1.240697] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[    1.240782] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[    1.240867] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[    1.240952] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[    1.241038] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[    1.241138] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[    1.241223] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[    1.241309] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[    1.241452] pci 0000:af:00.0: [1002:1478] type 01 class 0x060400
[    1.241475] pci 0000:af:00.0: reg 0x10: [mem 0xee600000-0xee603fff]
[    1.241591] pci 0000:af:00.0: PME# supported from D0 D3hot D3cold
[    1.241647] pci 0000:af:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:ae:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    1.241714] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.241717] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.241719] pci 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    1.241722] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.241763] pci 0000:b0:00.0: [1002:1479] type 01 class 0x060400
[    1.241895] pci 0000:b0:00.0: PME# supported from D0 D3hot D3cold
[    1.242007] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.242012] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.242015] pci 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.242019] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.242058] pci 0000:b1:00.0: [1002:744c] type 00 class 0x030000
[    1.242087] pci 0000:b1:00.0: reg 0x10: [mem 0x39bfe0000000-0x39bfefffffff 64bit pref]
[    1.242108] pci 0000:b1:00.0: reg 0x18: [mem 0x39bff0000000-0x39bff01fffff 64bit pref]
[    1.242122] pci 0000:b1:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    1.242136] pci 0000:b1:00.0: reg 0x24: [mem 0xee400000-0xee4fffff]
[    1.242150] pci 0000:b1:00.0: reg 0x30: [mem 0xee500000-0xee51ffff pref]
[    1.242178] pci 0000:b1:00.0: BAR 0: assigned to efifb
[    1.242228] pci 0000:b1:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.242284] pci 0000:b1:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:ae:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    1.242347] pci 0000:b1:00.1: [1002:ab30] type 00 class 0x040300
[    1.242368] pci 0000:b1:00.1: reg 0x10: [mem 0xee520000-0xee523fff]
[    1.242499] pci 0000:b1:00.1: PME# supported from D1 D2 D3hot D3cold
[    1.242585] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    1.242589] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.242592] pci 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.242596] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.242629] pci_bus 0000:ae: on NUMA node 1
[    1.242718] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[    1.242721] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.242971] acpi PNP0A08:09: _OSC: platform does not support [AER LTR]
[    1.243162] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.243163] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.243309] PCI host bridge to bus 0000:d7
[    1.243311] pci_bus 0000:d7: root bus resource [io  0xf000-0xffff window]
[    1.243313] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbffffff window]
[    1.243314] pci_bus 0000:d7: root bus resource [mem 0x39c000000000-0x39ffffffffff window]
[    1.243316] pci_bus 0000:d7: root bus resource [bus d7-ff]
[    1.243335] pci 0000:d7:00.0: [8086:2030] type 01 class 0x060400
[    1.243386] pci 0000:d7:00.0: enabling Extended Tags
[    1.243428] pci 0000:d7:00.0: PME# supported from D0 D3hot D3cold
[    1.243588] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[    1.243689] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[    1.243788] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[    1.243807] pci 0000:d7:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    1.243924] pci 0000:d7:05.6: [8086:2037] type 00 class 0x110100
[    1.244025] pci 0000:d7:07.0: [8086:2038] type 00 class 0x088000
[    1.244122] pci 0000:d7:07.1: [8086:2039] type 00 class 0x088000
[    1.244219] pci 0000:d7:07.2: [8086:203a] type 00 class 0x088000
[    1.244317] pci 0000:d7:07.3: [8086:203b] type 00 class 0x088000
[    1.244411] pci 0000:d7:07.4: [8086:203c] type 00 class 0x088000
[    1.244508] pci 0000:d7:07.7: [8086:203d] type 00 class 0x088000
[    1.244606] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[    1.244708] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[    1.244792] pci 0000:d7:0e.2: [8086:205a] type 00 class 0x088000
[    1.244875] pci 0000:d7:0e.3: [8086:205b] type 00 class 0x088000
[    1.244961] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[    1.245062] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[    1.245146] pci 0000:d7:0f.2: [8086:205a] type 00 class 0x088000
[    1.245233] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[    1.245330] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[    1.245398] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[    1.245466] pci 0000:d7:12.3: [8086:204f] type 00 class 0x088000
[    1.245538] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[    1.245620] pci 0000:d7:15.1: [8086:2088] type 00 class 0x110100
[    1.245690] pci 0000:d7:15.3: [8086:2019] type 00 class 0x088000
[    1.245761] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[    1.245844] pci 0000:d7:16.1: [8086:2088] type 00 class 0x110100
[    1.245912] pci 0000:d7:16.3: [8086:2019] type 00 class 0x088000
[    1.245978] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[    1.246047] pci 0000:d7:16.5: [8086:2088] type 00 class 0x110100
[    1.246115] pci 0000:d7:16.7: [8086:2019] type 00 class 0x088000
[    1.246217] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    1.246234] pci_bus 0000:d7: on NUMA node 1
[    1.246559] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    1.246601] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.246641] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.246681] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.246721] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    1.246761] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    1.246800] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    1.246840] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    1.247114] iommu: Default domain type: Passthrough (set via kernel command line)
[    1.247202] SCSI subsystem initialized
[    1.247211] libata version 3.00 loaded.
[    1.247227] ACPI: bus type USB registered
[    1.247239] usbcore: registered new interface driver usbfs
[    1.247245] usbcore: registered new interface driver hub
[    1.247249] usbcore: registered new device driver usb
[    1.247265] mc: Linux media interface: v0.10
[    1.247272] videodev: Linux video capture interface: v2.00
[    1.247281] pps_core: LinuxPPS API ver. 1 registered
[    1.247283] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.247285] PTP clock support registered
[    1.247362] EDAC MC: Ver: 3.0.0
[    1.247857] efivars: Registered efivars operations
[    1.247905] Advanced Linux Sound Architecture Driver Initialized.
[    1.248016] Bluetooth: Core ver 2.22
[    1.248021] NET: Registered PF_BLUETOOTH protocol family
[    1.248022] Bluetooth: HCI device and connection manager initialized
[    1.248024] Bluetooth: HCI socket layer initialized
[    1.248025] Bluetooth: L2CAP socket layer initialized
[    1.248028] Bluetooth: SCO socket layer initialized
[    1.248030] NetLabel: Initializing
[    1.248030] NetLabel:  domain hash size = 128
[    1.248031] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.248045] NetLabel:  unlabeled traffic allowed by default
[    1.248075] PCI: Using ACPI for IRQ routing
[    1.251194] PCI: pci_cache_line_size set to 64 bytes
[    1.251615] e820: reserve RAM buffer [mem 0x5baf3018-0x5bffffff]
[    1.251618] e820: reserve RAM buffer [mem 0x5bb0f018-0x5bffffff]
[    1.251620] e820: reserve RAM buffer [mem 0x5bb44018-0x5bffffff]
[    1.251622] e820: reserve RAM buffer [mem 0x5bb79018-0x5bffffff]
[    1.251623] e820: reserve RAM buffer [mem 0x5bb84018-0x5bffffff]
[    1.251624] e820: reserve RAM buffer [mem 0x5bb8f018-0x5bffffff]
[    1.251625] e820: reserve RAM buffer [mem 0x5bbb4018-0x5bffffff]
[    1.251626] e820: reserve RAM buffer [mem 0x62eca000-0x63ffffff]
[    1.251627] e820: reserve RAM buffer [mem 0x687fc000-0x6bffffff]
[    1.251677] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    1.251679] pci 0000:04:00.0: vgaarb: bridge control possible
[    1.251680] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.251715] pci 0000:b1:00.0: vgaarb: setting as boot VGA device (overriding previous)
[    1.251717] pci 0000:b1:00.0: vgaarb: bridge control possible
[    1.251718] pci 0000:b1:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    1.251722] vgaarb: loaded
[    1.251951] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.251959] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    1.253436] clocksource: Switched to clocksource tsc-early
[    1.255782] VFS: Disk quotas dquot_6.6.0
[    1.255791] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.255853] pnp: PnP ACPI init
[    1.259059] system 00:01: [io  0x0500-0x05fe] has been reserved
[    1.259063] system 00:01: [io  0x0400-0x047f] has been reserved
[    1.259065] system 00:01: [io  0x0600-0x061f] has been reserved
[    1.259067] system 00:01: [io  0x0880-0x0883] has been reserved
[    1.259069] system 00:01: [io  0x0800-0x081f] has been reserved
[    1.259071] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    1.259074] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    1.259077] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    1.259079] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.259081] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    1.259083] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    1.259084] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    1.259449] system 00:02: [io  0x0a00-0x0a0f] has been reserved
[    1.259452] system 00:02: [io  0x0a10-0x0a1f] has been reserved
[    1.259453] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    1.259455] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    1.259689] pnp 00:03: [dma 0 disabled]
[    1.259867] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    1.259870] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    1.259872] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[    1.259874] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    1.259876] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    1.259879] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    1.259881] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    1.259883] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    1.260133] system 00:05: [io  0x0f00-0x0ffe] has been reserved
[    1.260749] pnp: PnP ACPI: found 6 devices
[    1.266028] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.266094] NET: Registered PF_INET protocol family
[    1.266642] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    1.269840] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    1.269966] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    1.269987] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hugepage)
[    1.270546] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    1.270843] TCP: Hash tables configured (established 524288 bind 65536)
[    1.271279] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, vmalloc)
[    1.271446] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    1.271763] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    1.272069] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.272076] NET: Registered PF_XDP protocol family
[    1.272101] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.272127] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.272136] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    1.272154] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.272157] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    1.272167] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.272186] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    1.272188] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    1.272197] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.272213] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    1.272215] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    1.272217] pci_bus 0000:00: resource 6 [io  0x03b0-0x03bb window]
[    1.272218] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    1.272219] pci_bus 0000:00: resource 8 [io  0x1000-0x3fff window]
[    1.272221] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    1.272222] pci_bus 0000:00: resource 10 [mem 0x000c4000-0x000c7fff window]
[    1.272223] pci_bus 0000:00: resource 11 [mem 0xfe010000-0xfe010fff window]
[    1.272225] pci_bus 0000:00: resource 12 [mem 0x90000000-0x9d7fffff window]
[    1.272226] pci_bus 0000:00: resource 13 [mem 0x380000000000-0x383fffffffff window]
[    1.272228] pci_bus 0000:02: resource 1 [mem 0x9d100000-0x9d1fffff]
[    1.272230] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.272231] pci_bus 0000:03: resource 1 [mem 0x9c000000-0x9d0fffff]
[    1.272232] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    1.272234] pci_bus 0000:04: resource 1 [mem 0x9c000000-0x9d0fffff]
[    1.272300] pci 0000:17:00.0: PCI bridge to [bus 18]
[    1.272308] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    1.272314] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.272327] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[    1.272328] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff window]
[    1.272329] pci_bus 0000:17: resource 6 [mem 0x384000000000-0x387fffffffff window]
[    1.272331] pci_bus 0000:18: resource 1 [mem 0xaac00000-0xaaefffff]
[    1.272332] pci_bus 0000:18: resource 2 [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.272352] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    1.272360] pci 0000:3a:00.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    1.272375] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    1.272383] pci 0000:3a:01.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    1.272398] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    1.272406] pci 0000:3a:02.0:   bridge window [mem 0xb8400000-0xb84fffff]
[    1.272421] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    1.272429] pci 0000:3a:03.0:   bridge window [mem 0xb8300000-0xb83fffff]
[    1.272444] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[    1.272446] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff window]
[    1.272447] pci_bus 0000:3a: resource 6 [mem 0x388000000000-0x38bfffffffff window]
[    1.272449] pci_bus 0000:3b: resource 1 [mem 0xb8600000-0xb86fffff]
[    1.272450] pci_bus 0000:3c: resource 1 [mem 0xb8500000-0xb85fffff]
[    1.272451] pci_bus 0000:3d: resource 1 [mem 0xb8400000-0xb84fffff]
[    1.272452] pci_bus 0000:3e: resource 1 [mem 0xb8300000-0xb83fffff]
[    1.272464] pci 0000:5d:00.0: bridge window [io  0x1000-0x0fff] to [bus 5e] add_size 1000
[    1.272466] pci 0000:5d:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 5e] add_size 200000 add_align 100000
[    1.272469] pci 0000:5d:01.0: bridge window [io  0x1000-0x0fff] to [bus 5f] add_size 1000
[    1.272471] pci 0000:5d:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 5f] add_size 200000 add_align 100000
[    1.272480] pci 0000:5d:00.0: BAR 15: assigned [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    1.272483] pci 0000:5d:01.0: BAR 15: assigned [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    1.272485] pci 0000:5d:00.0: BAR 13: assigned [io  0x8000-0x8fff]
[    1.272486] pci 0000:5d:01.0: BAR 13: assigned [io  0x9000-0x9fff]
[    1.272488] pci 0000:5d:00.0: PCI bridge to [bus 5e]
[    1.272490] pci 0000:5d:00.0:   bridge window [io  0x8000-0x8fff]
[    1.272498] pci 0000:5d:00.0:   bridge window [mem 0xc5c00000-0xc5dfffff]
[    1.272504] pci 0000:5d:00.0:   bridge window [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    1.272518] pci 0000:5d:01.0: PCI bridge to [bus 5f]
[    1.272519] pci 0000:5d:01.0:   bridge window [io  0x9000-0x9fff]
[    1.272527] pci 0000:5d:01.0:   bridge window [mem 0xc5a00000-0xc5bfffff]
[    1.272533] pci 0000:5d:01.0:   bridge window [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    1.272544] pci 0000:5d:02.0: PCI bridge to [bus 60]
[    1.272552] pci 0000:5d:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
[    1.272568] pci 0000:62:03.0: PCI bridge to [bus 63]
[    1.272577] pci 0000:62:03.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    1.272583] pci 0000:62:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272595] pci 0000:61:00.0: PCI bridge to [bus 62-63]
[    1.272604] pci 0000:61:00.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    1.272610] pci 0000:61:00.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272622] pci 0000:5d:03.0: PCI bridge to [bus 61-63]
[    1.272630] pci 0000:5d:03.0:   bridge window [mem 0xc5700000-0xc59fffff]
[    1.272635] pci 0000:5d:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272647] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[    1.272648] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff window]
[    1.272650] pci_bus 0000:5d: resource 6 [mem 0x38c000000000-0x38ffffffffff window]
[    1.272652] pci_bus 0000:5e: resource 0 [io  0x8000-0x8fff]
[    1.272653] pci_bus 0000:5e: resource 1 [mem 0xc5c00000-0xc5dfffff]
[    1.272655] pci_bus 0000:5e: resource 2 [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    1.272656] pci_bus 0000:5f: resource 0 [io  0x9000-0x9fff]
[    1.272658] pci_bus 0000:5f: resource 1 [mem 0xc5a00000-0xc5bfffff]
[    1.272659] pci_bus 0000:5f: resource 2 [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    1.272661] pci_bus 0000:60: resource 1 [mem 0xc5e00000-0xc5efffff]
[    1.272662] pci_bus 0000:61: resource 1 [mem 0xc5700000-0xc59fffff]
[    1.272663] pci_bus 0000:61: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272665] pci_bus 0000:62: resource 1 [mem 0xc5800000-0xc58fffff]
[    1.272666] pci_bus 0000:62: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272667] pci_bus 0000:63: resource 1 [mem 0xc5800000-0xc58fffff]
[    1.272669] pci_bus 0000:63: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    1.272683] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.272706] pci_bus 0000:80: resource 4 [io  0xa000-0xbfff window]
[    1.272707] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xd37fffff window]
[    1.272708] pci_bus 0000:80: resource 6 [mem 0x390000000000-0x393fffffffff window]
[    1.272725] pci 0000:85:00.0: PCI bridge to [bus 86]
[    1.272748] pci 0000:85:02.0: PCI bridge to [bus 87]
[    1.272756] pci 0000:85:02.0:   bridge window [mem 0xe0e00000-0xe0efffff]
[    1.272772] pci_bus 0000:85: resource 4 [io  0xc000-0xdfff window]
[    1.272774] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff window]
[    1.272775] pci_bus 0000:85: resource 6 [mem 0x394000000000-0x397fffffffff window]
[    1.272777] pci_bus 0000:87: resource 1 [mem 0xe0e00000-0xe0efffff]
[    1.272794] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    1.272801] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.272810] pci 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.272816] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272828] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.272830] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.272839] pci 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.272845] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272857] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.272859] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.272867] pci 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    1.272873] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272884] pci_bus 0000:ae: resource 4 [io  0xe000-0xefff window]
[    1.272886] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff window]
[    1.272887] pci_bus 0000:ae: resource 6 [mem 0x398000000000-0x39bfffffffff window]
[    1.272888] pci_bus 0000:af: resource 0 [io  0xe000-0xefff]
[    1.272890] pci_bus 0000:af: resource 1 [mem 0xee400000-0xee6fffff]
[    1.272891] pci_bus 0000:af: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272892] pci_bus 0000:b0: resource 0 [io  0xe000-0xefff]
[    1.272894] pci_bus 0000:b0: resource 1 [mem 0xee400000-0xee5fffff]
[    1.272895] pci_bus 0000:b0: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272896] pci_bus 0000:b1: resource 0 [io  0xe000-0xefff]
[    1.272898] pci_bus 0000:b1: resource 1 [mem 0xee400000-0xee5fffff]
[    1.272899] pci_bus 0000:b1: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.272912] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    1.272935] pci_bus 0000:d7: resource 4 [io  0xf000-0xffff window]
[    1.272936] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff window]
[    1.272937] pci_bus 0000:d7: resource 6 [mem 0x39c000000000-0x39ffffffffff window]
[    1.273219] pci 0000:02:00.0: PME# does not work under D0, disabling it
[    1.273337] pci 0000:17:05.0: disabled boot interrupts on device [8086:2034]
[    1.273454] pci 0000:18:00.0: CLS mismatch (64 != 32), using 64 bytes
[    1.273461] pci 0000:3a:05.0: disabled boot interrupts on device [8086:2034]
[    1.273518] pci 0000:5d:05.0: disabled boot interrupts on device [8086:2034]
[    1.273584] pci 0000:85:05.0: disabled boot interrupts on device [8086:2034]
[    1.273676] pci 0000:ae:05.0: disabled boot interrupts on device [8086:2034]
[    1.273769] pci 0000:b1:00.1: D0 power state depends on 0000:b1:00.0
[    1.273775] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2034]
[    1.273875] Unpacking initramfs...
[    1.274687] DMAR: No SATC found
[    1.274690] DMAR: dmar6: Using Queued invalidation
[    1.274694] DMAR: dmar5: Using Queued invalidation
[    1.274699] DMAR: dmar4: Using Queued invalidation
[    1.274702] DMAR: dmar3: Using Queued invalidation
[    1.274706] DMAR: dmar2: Using Queued invalidation
[    1.274710] DMAR: dmar1: Using Queued invalidation
[    1.274715] DMAR: dmar0: Using Queued invalidation
[    1.274719] DMAR: dmar7: Using Queued invalidation
[    1.274899] pci 0000:5d:00.0: Adding to iommu group 0
[    1.274941] pci 0000:5d:01.0: Adding to iommu group 1
[    1.274981] pci 0000:5d:02.0: Adding to iommu group 2
[    1.275020] pci 0000:5d:03.0: Adding to iommu group 3
[    1.275068] pci 0000:5e:00.0: Adding to iommu group 4
[    1.275109] pci 0000:5f:00.0: Adding to iommu group 5
[    1.275151] pci 0000:60:00.0: Adding to iommu group 6
[    1.275191] pci 0000:61:00.0: Adding to iommu group 7
[    1.275232] pci 0000:62:03.0: Adding to iommu group 8
[    1.275276] pci 0000:63:00.0: Adding to iommu group 9
[    1.275321] pci 0000:63:00.1: Adding to iommu group 10
[    1.276878] pci 0000:3a:00.0: Adding to iommu group 11
[    1.276925] pci 0000:3a:01.0: Adding to iommu group 12
[    1.276966] pci 0000:3a:02.0: Adding to iommu group 13
[    1.277006] pci 0000:3a:03.0: Adding to iommu group 14
[    1.277054] pci 0000:3b:00.0: Adding to iommu group 15
[    1.277095] pci 0000:3c:00.0: Adding to iommu group 16
[    1.277136] pci 0000:3d:00.0: Adding to iommu group 17
[    1.277178] pci 0000:3e:00.0: Adding to iommu group 18
[    1.277322] pci 0000:17:00.0: Adding to iommu group 19
[    1.277379] pci 0000:18:00.0: Adding to iommu group 20
[    1.278921] pci 0000:d7:00.0: Adding to iommu group 21
[    1.279075] pci 0000:ae:00.0: Adding to iommu group 22
[    1.279124] pci 0000:af:00.0: Adding to iommu group 23
[    1.279164] pci 0000:b0:00.0: Adding to iommu group 24
[    1.279213] pci 0000:b1:00.0: Adding to iommu group 25
[    1.279256] pci 0000:b1:00.1: Adding to iommu group 26
[    1.279386] pci 0000:85:00.0: Adding to iommu group 27
[    1.279426] pci 0000:85:02.0: Adding to iommu group 28
[    1.279482] pci 0000:87:00.0: Adding to iommu group 29
[    1.280840] pci 0000:80:00.0: Adding to iommu group 30
[    1.280882] pci 0000:80:04.0: Adding to iommu group 31
[    1.280922] pci 0000:80:04.1: Adding to iommu group 32
[    1.280964] pci 0000:80:04.2: Adding to iommu group 33
[    1.281005] pci 0000:80:04.3: Adding to iommu group 34
[    1.281045] pci 0000:80:04.4: Adding to iommu group 35
[    1.281084] pci 0000:80:04.5: Adding to iommu group 36
[    1.281125] pci 0000:80:04.6: Adding to iommu group 37
[    1.281165] pci 0000:80:04.7: Adding to iommu group 38
[    1.281294] pci 0000:00:00.0: Adding to iommu group 39
[    1.281334] pci 0000:00:04.0: Adding to iommu group 40
[    1.281373] pci 0000:00:04.1: Adding to iommu group 41
[    1.281415] pci 0000:00:04.2: Adding to iommu group 42
[    1.281454] pci 0000:00:04.3: Adding to iommu group 43
[    1.281493] pci 0000:00:04.4: Adding to iommu group 44
[    1.282598] pci 0000:00:04.5: Adding to iommu group 45
[    1.282645] pci 0000:00:04.6: Adding to iommu group 46
[    1.282686] pci 0000:00:04.7: Adding to iommu group 47
[    1.282725] pci 0000:00:05.0: Adding to iommu group 48
[    1.282766] pci 0000:00:05.1: Adding to iommu group 49
[    1.282806] pci 0000:00:05.2: Adding to iommu group 50
[    1.282846] pci 0000:00:05.4: Adding to iommu group 51
[    1.282885] pci 0000:00:05.6: Adding to iommu group 52
[    1.282924] pci 0000:00:07.0: Adding to iommu group 53
[    1.282966] pci 0000:00:07.4: Adding to iommu group 54
[    1.283005] pci 0000:00:07.7: Adding to iommu group 55
[    1.283045] pci 0000:00:08.0: Adding to iommu group 56
[    1.283118] pci 0000:00:08.1: Adding to iommu group 57
[    1.283158] pci 0000:00:08.2: Adding to iommu group 58
[    1.283265] pci 0000:00:11.0: Adding to iommu group 59
[    1.283305] pci 0000:00:11.5: Adding to iommu group 59
[    1.283412] pci 0000:00:14.0: Adding to iommu group 60
[    1.283452] pci 0000:00:14.2: Adding to iommu group 60
[    1.284580] pci 0000:00:16.0: Adding to iommu group 61
[    1.284627] pci 0000:00:16.1: Adding to iommu group 61
[    1.284668] pci 0000:00:16.4: Adding to iommu group 61
[    1.284708] pci 0000:00:17.0: Adding to iommu group 62
[    1.284786] pci 0000:00:1c.0: Adding to iommu group 63
[    1.284829] pci 0000:00:1c.2: Adding to iommu group 64
[    1.284872] pci 0000:00:1c.5: Adding to iommu group 65
[    1.285046] pci 0000:00:1f.0: Adding to iommu group 66
[    1.285088] pci 0000:00:1f.2: Adding to iommu group 66
[    1.285127] pci 0000:00:1f.3: Adding to iommu group 67
[    1.285169] pci 0000:00:1f.4: Adding to iommu group 66
[    1.285215] pci 0000:00:1f.5: Adding to iommu group 66
[    1.285256] pci 0000:02:00.0: Adding to iommu group 68
[    1.285297] pci 0000:03:00.0: Adding to iommu group 69
[    1.285301] pci 0000:04:00.0: Adding to iommu group 69
[    1.285343] pci 0000:17:05.0: Adding to iommu group 70
[    1.285383] pci 0000:17:05.2: Adding to iommu group 71
[    1.285424] pci 0000:17:05.4: Adding to iommu group 72
[    1.285464] pci 0000:17:05.6: Adding to iommu group 73
[    1.285505] pci 0000:17:07.0: Adding to iommu group 74
[    1.286747] pci 0000:17:07.1: Adding to iommu group 75
[    1.286792] pci 0000:17:07.2: Adding to iommu group 76
[    1.286833] pci 0000:17:07.3: Adding to iommu group 77
[    1.286875] pci 0000:17:07.4: Adding to iommu group 78
[    1.286916] pci 0000:17:07.7: Adding to iommu group 79
[    1.287229] pci 0000:17:08.0: Adding to iommu group 80
[    1.287273] pci 0000:17:08.1: Adding to iommu group 80
[    1.287316] pci 0000:17:08.2: Adding to iommu group 80
[    1.287358] pci 0000:17:08.3: Adding to iommu group 80
[    1.287402] pci 0000:17:08.4: Adding to iommu group 80
[    1.287444] pci 0000:17:08.5: Adding to iommu group 80
[    1.287487] pci 0000:17:08.6: Adding to iommu group 80
[    1.287538] pci 0000:17:08.7: Adding to iommu group 80
[    1.287851] pci 0000:17:09.0: Adding to iommu group 81
[    1.287895] pci 0000:17:09.1: Adding to iommu group 81
[    1.287938] pci 0000:17:09.2: Adding to iommu group 81
[    1.287982] pci 0000:17:09.3: Adding to iommu group 81
[    1.288025] pci 0000:17:09.4: Adding to iommu group 81
[    1.288068] pci 0000:17:09.5: Adding to iommu group 81
[    1.288111] pci 0000:17:09.6: Adding to iommu group 81
[    1.288154] pci 0000:17:09.7: Adding to iommu group 81
[    1.288260] pci 0000:17:0a.0: Adding to iommu group 82
[    1.288305] pci 0000:17:0a.1: Adding to iommu group 82
[    1.289832] pci 0000:17:0e.0: Adding to iommu group 83
[    1.289882] pci 0000:17:0e.1: Adding to iommu group 83
[    1.289927] pci 0000:17:0e.2: Adding to iommu group 83
[    1.289971] pci 0000:17:0e.3: Adding to iommu group 83
[    1.290014] pci 0000:17:0e.4: Adding to iommu group 83
[    1.290059] pci 0000:17:0e.5: Adding to iommu group 83
[    1.290103] pci 0000:17:0e.6: Adding to iommu group 83
[    1.290147] pci 0000:17:0e.7: Adding to iommu group 83
[    1.290456] pci 0000:17:0f.0: Adding to iommu group 84
[    1.290502] pci 0000:17:0f.1: Adding to iommu group 84
[    1.290551] pci 0000:17:0f.2: Adding to iommu group 84
[    1.290595] pci 0000:17:0f.3: Adding to iommu group 84
[    1.290639] pci 0000:17:0f.4: Adding to iommu group 84
[    1.290683] pci 0000:17:0f.5: Adding to iommu group 84
[    1.290728] pci 0000:17:0f.6: Adding to iommu group 84
[    1.290772] pci 0000:17:0f.7: Adding to iommu group 84
[    1.290877] pci 0000:17:10.0: Adding to iommu group 85
[    1.290923] pci 0000:17:10.1: Adding to iommu group 85
[    1.291232] pci 0000:17:14.0: Adding to iommu group 86
[    1.291279] pci 0000:17:14.1: Adding to iommu group 86
[    1.291324] pci 0000:17:14.2: Adding to iommu group 86
[    1.291369] pci 0000:17:14.3: Adding to iommu group 86
[    1.291414] pci 0000:17:14.4: Adding to iommu group 86
[    1.291458] pci 0000:17:14.5: Adding to iommu group 86
[    1.291502] pci 0000:17:14.6: Adding to iommu group 86
[    1.293543] pci 0000:17:14.7: Adding to iommu group 86
[    1.293861] pci 0000:17:15.0: Adding to iommu group 87
[    1.293910] pci 0000:17:15.1: Adding to iommu group 87
[    1.293957] pci 0000:17:15.2: Adding to iommu group 87
[    1.294002] pci 0000:17:15.3: Adding to iommu group 87
[    1.294048] pci 0000:17:15.4: Adding to iommu group 87
[    1.294093] pci 0000:17:15.5: Adding to iommu group 87
[    1.294138] pci 0000:17:15.6: Adding to iommu group 87
[    1.294183] pci 0000:17:15.7: Adding to iommu group 87
[    1.294288] pci 0000:17:16.0: Adding to iommu group 88
[    1.294336] pci 0000:17:16.1: Adding to iommu group 88
[    1.294508] pci 0000:17:1d.0: Adding to iommu group 89
[    1.295654] pci 0000:17:1d.1: Adding to iommu group 89
[    1.295709] pci 0000:17:1d.2: Adding to iommu group 89
[    1.295757] pci 0000:17:1d.3: Adding to iommu group 89
[    1.296033] pci 0000:17:1e.0: Adding to iommu group 90
[    1.296083] pci 0000:17:1e.1: Adding to iommu group 90
[    1.296130] pci 0000:17:1e.2: Adding to iommu group 90
[    1.296176] pci 0000:17:1e.3: Adding to iommu group 90
[    1.296222] pci 0000:17:1e.4: Adding to iommu group 90
[    1.296268] pci 0000:17:1e.5: Adding to iommu group 90
[    1.296314] pci 0000:17:1e.6: Adding to iommu group 90
[    1.297770] pci 0000:17:1f.0: Adding to iommu group 91
[    1.297826] pci 0000:17:1f.1: Adding to iommu group 91
[    1.297873] pci 0000:17:1f.2: Adding to iommu group 91
[    1.297921] pci 0000:17:1f.3: Adding to iommu group 91
[    1.297967] pci 0000:17:1f.4: Adding to iommu group 91
[    1.298014] pci 0000:17:1f.5: Adding to iommu group 91
[    1.298061] pci 0000:17:1f.6: Adding to iommu group 91
[    1.298107] pci 0000:17:1f.7: Adding to iommu group 91
[    1.298148] pci 0000:3a:05.0: Adding to iommu group 92
[    1.298188] pci 0000:3a:05.2: Adding to iommu group 93
[    1.298229] pci 0000:3a:05.4: Adding to iommu group 94
[    1.298269] pci 0000:3a:05.6: Adding to iommu group 95
[    1.298310] pci 0000:3a:07.0: Adding to iommu group 96
[    1.298351] pci 0000:3a:07.1: Adding to iommu group 97
[    1.298392] pci 0000:3a:07.2: Adding to iommu group 98
[    1.298432] pci 0000:3a:07.3: Adding to iommu group 99
[    1.298474] pci 0000:3a:07.4: Adding to iommu group 100
[    1.299638] pci 0000:3a:07.7: Adding to iommu group 101
[    1.299685] pci 0000:3a:08.0: Adding to iommu group 102
[    1.299759] pci 0000:3a:08.1: Adding to iommu group 103
[    1.299800] pci 0000:3a:09.0: Adding to iommu group 104
[    1.299874] pci 0000:3a:09.1: Adding to iommu group 105
[    1.299913] pci 0000:3a:0a.0: Adding to iommu group 106
[    1.299953] pci 0000:3a:0a.1: Adding to iommu group 107
[    1.299994] pci 0000:3a:0a.2: Adding to iommu group 108
[    1.300033] pci 0000:3a:0a.3: Adding to iommu group 109
[    1.300073] pci 0000:3a:0a.4: Adding to iommu group 110
[    1.300113] pci 0000:3a:0a.5: Adding to iommu group 111
[    1.300154] pci 0000:3a:0a.6: Adding to iommu group 112
[    1.300194] pci 0000:3a:0a.7: Adding to iommu group 113
[    1.300233] pci 0000:3a:0b.0: Adding to iommu group 114
[    1.300272] pci 0000:3a:0b.1: Adding to iommu group 115
[    1.300312] pci 0000:3a:0b.2: Adding to iommu group 116
[    1.300351] pci 0000:3a:0b.3: Adding to iommu group 117
[    1.300391] pci 0000:3a:0c.0: Adding to iommu group 118
[    1.300431] pci 0000:3a:0c.1: Adding to iommu group 119
[    1.300471] pci 0000:3a:0c.2: Adding to iommu group 120
[    1.300511] pci 0000:3a:0c.3: Adding to iommu group 121
[    1.301609] pci 0000:3a:0c.4: Adding to iommu group 122
[    1.301652] pci 0000:3a:0c.5: Adding to iommu group 123
[    1.301695] pci 0000:3a:0c.6: Adding to iommu group 124
[    1.301737] pci 0000:3a:0c.7: Adding to iommu group 125
[    1.301778] pci 0000:3a:0d.0: Adding to iommu group 126
[    1.301818] pci 0000:3a:0d.1: Adding to iommu group 127
[    1.301859] pci 0000:3a:0d.2: Adding to iommu group 128
[    1.301901] pci 0000:3a:0d.3: Adding to iommu group 129
[    1.301942] pci 0000:5d:05.0: Adding to iommu group 130
[    1.301982] pci 0000:5d:05.2: Adding to iommu group 131
[    1.302023] pci 0000:5d:05.4: Adding to iommu group 132
[    1.302064] pci 0000:5d:05.6: Adding to iommu group 133
[    1.302105] pci 0000:5d:07.0: Adding to iommu group 134
[    1.302145] pci 0000:5d:07.1: Adding to iommu group 135
[    1.302186] pci 0000:5d:07.2: Adding to iommu group 136
[    1.302226] pci 0000:5d:07.3: Adding to iommu group 137
[    1.302267] pci 0000:5d:07.4: Adding to iommu group 138
[    1.302307] pci 0000:5d:07.7: Adding to iommu group 139
[    1.302349] pci 0000:5d:0e.0: Adding to iommu group 140
[    1.302389] pci 0000:5d:0e.1: Adding to iommu group 141
[    1.302430] pci 0000:5d:0e.2: Adding to iommu group 142
[    1.302469] pci 0000:5d:0e.3: Adding to iommu group 143
[    1.302510] pci 0000:5d:0f.0: Adding to iommu group 144
[    1.303616] pci 0000:5d:0f.1: Adding to iommu group 145
[    1.303659] pci 0000:5d:0f.2: Adding to iommu group 146
[    1.303700] pci 0000:5d:12.0: Adding to iommu group 147
[    1.303841] pci 0000:5d:12.1: Adding to iommu group 148
[    1.303897] pci 0000:5d:12.2: Adding to iommu group 148
[    1.303950] pci 0000:5d:12.3: Adding to iommu group 148
[    1.304081] pci 0000:5d:15.0: Adding to iommu group 149
[    1.304138] pci 0000:5d:15.1: Adding to iommu group 149
[    1.304192] pci 0000:5d:15.3: Adding to iommu group 149
[    1.304426] pci 0000:5d:16.0: Adding to iommu group 150
[    1.304482] pci 0000:5d:16.1: Adding to iommu group 150
[    1.305578] pci 0000:5d:16.3: Adding to iommu group 150
[    1.305641] pci 0000:5d:16.4: Adding to iommu group 150
[    1.305695] pci 0000:5d:16.5: Adding to iommu group 150
[    1.305748] pci 0000:5d:16.7: Adding to iommu group 150
[    1.305789] pci 0000:80:05.0: Adding to iommu group 151
[    1.305829] pci 0000:80:05.1: Adding to iommu group 152
[    1.305870] pci 0000:80:05.2: Adding to iommu group 153
[    1.305911] pci 0000:80:05.4: Adding to iommu group 154
[    1.305951] pci 0000:80:05.6: Adding to iommu group 155
[    1.305992] pci 0000:80:07.0: Adding to iommu group 156
[    1.306031] pci 0000:80:07.4: Adding to iommu group 157
[    1.306071] pci 0000:80:07.7: Adding to iommu group 158
[    1.306112] pci 0000:80:08.0: Adding to iommu group 159
[    1.306186] pci 0000:80:08.1: Adding to iommu group 160
[    1.306226] pci 0000:80:08.2: Adding to iommu group 161
[    1.306267] pci 0000:85:05.0: Adding to iommu group 162
[    1.306307] pci 0000:85:05.2: Adding to iommu group 163
[    1.306347] pci 0000:85:05.4: Adding to iommu group 164
[    1.306388] pci 0000:85:05.6: Adding to iommu group 165
[    1.306428] pci 0000:85:07.0: Adding to iommu group 166
[    1.306469] pci 0000:85:07.1: Adding to iommu group 167
[    1.306510] pci 0000:85:07.2: Adding to iommu group 168
[    1.307659] pci 0000:85:07.3: Adding to iommu group 169
[    1.307704] pci 0000:85:07.4: Adding to iommu group 170
[    1.307746] pci 0000:85:07.7: Adding to iommu group 171
[    1.308055] pci 0000:85:08.0: Adding to iommu group 172
[    1.308115] pci 0000:85:08.1: Adding to iommu group 172
[    1.308172] pci 0000:85:08.2: Adding to iommu group 172
[    1.308229] pci 0000:85:08.3: Adding to iommu group 172
[    1.308286] pci 0000:85:08.4: Adding to iommu group 172
[    1.308344] pci 0000:85:08.5: Adding to iommu group 172
[    1.308402] pci 0000:85:08.6: Adding to iommu group 172
[    1.308459] pci 0000:85:08.7: Adding to iommu group 172
[    1.310780] pci 0000:85:09.0: Adding to iommu group 173
[    1.310847] pci 0000:85:09.1: Adding to iommu group 173
[    1.310907] pci 0000:85:09.2: Adding to iommu group 173
[    1.310965] pci 0000:85:09.3: Adding to iommu group 173
[    1.311024] pci 0000:85:09.4: Adding to iommu group 173
[    1.311083] pci 0000:85:09.5: Adding to iommu group 173
[    1.311143] pci 0000:85:09.6: Adding to iommu group 173
[    1.311202] pci 0000:85:09.7: Adding to iommu group 173
[    1.311305] pci 0000:85:0a.0: Adding to iommu group 174
[    1.311367] pci 0000:85:0a.1: Adding to iommu group 174
[    1.311681] pci 0000:85:0e.0: Adding to iommu group 175
[    1.311744] pci 0000:85:0e.1: Adding to iommu group 175
[    1.311808] pci 0000:85:0e.2: Adding to iommu group 175
[    1.311869] pci 0000:85:0e.3: Adding to iommu group 175
[    1.311930] pci 0000:85:0e.4: Adding to iommu group 175
[    1.311991] pci 0000:85:0e.5: Adding to iommu group 175
[    1.312051] pci 0000:85:0e.6: Adding to iommu group 175
[    1.312111] pci 0000:85:0e.7: Adding to iommu group 175
[    1.312423] pci 0000:85:0f.0: Adding to iommu group 176
[    1.312485] pci 0000:85:0f.1: Adding to iommu group 176
[    1.312555] pci 0000:85:0f.2: Adding to iommu group 176
[    1.312617] pci 0000:85:0f.3: Adding to iommu group 176
[    1.312678] pci 0000:85:0f.4: Adding to iommu group 176
[    1.312740] pci 0000:85:0f.5: Adding to iommu group 176
[    1.312801] pci 0000:85:0f.6: Adding to iommu group 176
[    1.312862] pci 0000:85:0f.7: Adding to iommu group 176
[    1.312968] pci 0000:85:10.0: Adding to iommu group 177
[    1.313031] pci 0000:85:10.1: Adding to iommu group 177
[    1.313342] pci 0000:85:14.0: Adding to iommu group 178
[    1.313404] pci 0000:85:14.1: Adding to iommu group 178
[    1.313466] pci 0000:85:14.2: Adding to iommu group 178
[    1.314534] pci 0000:85:14.3: Adding to iommu group 178
[    1.314604] pci 0000:85:14.4: Adding to iommu group 178
[    1.314667] pci 0000:85:14.5: Adding to iommu group 178
[    1.314729] pci 0000:85:14.6: Adding to iommu group 178
[    1.314790] pci 0000:85:14.7: Adding to iommu group 178
[    1.315102] pci 0000:85:15.0: Adding to iommu group 179
[    1.315166] pci 0000:85:15.1: Adding to iommu group 179
[    1.315229] pci 0000:85:15.2: Adding to iommu group 179
[    1.315293] pci 0000:85:15.3: Adding to iommu group 179
[    1.315357] pci 0000:85:15.4: Adding to iommu group 179
[    1.315419] pci 0000:85:15.5: Adding to iommu group 179
[    1.315481] pci 0000:85:15.6: Adding to iommu group 179
[    1.316543] pci 0000:85:15.7: Adding to iommu group 179
[    1.316658] pci 0000:85:16.0: Adding to iommu group 180
[    1.316723] pci 0000:85:16.1: Adding to iommu group 180
[    1.316898] pci 0000:85:1d.0: Adding to iommu group 181
[    1.316962] pci 0000:85:1d.1: Adding to iommu group 181
[    1.317026] pci 0000:85:1d.2: Adding to iommu group 181
[    1.317090] pci 0000:85:1d.3: Adding to iommu group 181
[    1.317367] pci 0000:85:1e.0: Adding to iommu group 182
[    1.317431] pci 0000:85:1e.1: Adding to iommu group 182
[    1.317495] pci 0000:85:1e.2: Adding to iommu group 182
[    1.318563] pci 0000:85:1e.3: Adding to iommu group 182
[    1.318634] pci 0000:85:1e.4: Adding to iommu group 182
[    1.318699] pci 0000:85:1e.5: Adding to iommu group 182
[    1.318763] pci 0000:85:1e.6: Adding to iommu group 182
[    1.319076] pci 0000:85:1f.0: Adding to iommu group 183
[    1.319141] pci 0000:85:1f.1: Adding to iommu group 183
[    1.319206] pci 0000:85:1f.2: Adding to iommu group 183
[    1.319271] pci 0000:85:1f.3: Adding to iommu group 183
[    1.319335] pci 0000:85:1f.4: Adding to iommu group 183
[    1.319399] pci 0000:85:1f.5: Adding to iommu group 183
[    1.319463] pci 0000:85:1f.6: Adding to iommu group 183
[    1.320550] pci 0000:85:1f.7: Adding to iommu group 183
[    1.320597] pci 0000:ae:05.0: Adding to iommu group 184
[    1.320640] pci 0000:ae:05.2: Adding to iommu group 185
[    1.320681] pci 0000:ae:05.4: Adding to iommu group 186
[    1.320722] pci 0000:ae:05.6: Adding to iommu group 187
[    1.320763] pci 0000:ae:07.0: Adding to iommu group 188
[    1.320804] pci 0000:ae:07.1: Adding to iommu group 189
[    1.320844] pci 0000:ae:07.2: Adding to iommu group 190
[    1.320884] pci 0000:ae:07.3: Adding to iommu group 191
[    1.320924] pci 0000:ae:07.4: Adding to iommu group 192
[    1.320966] pci 0000:ae:07.7: Adding to iommu group 193
[    1.321007] pci 0000:ae:08.0: Adding to iommu group 194
[    1.321081] pci 0000:ae:08.1: Adding to iommu group 195
[    1.321122] pci 0000:ae:09.0: Adding to iommu group 196
[    1.321197] pci 0000:ae:09.1: Adding to iommu group 197
[    1.321237] pci 0000:ae:0a.0: Adding to iommu group 198
[    1.321278] pci 0000:ae:0a.1: Adding to iommu group 199
[    1.321318] pci 0000:ae:0a.2: Adding to iommu group 200
[    1.321359] pci 0000:ae:0a.3: Adding to iommu group 201
[    1.321398] pci 0000:ae:0a.4: Adding to iommu group 202
[    1.321438] pci 0000:ae:0a.5: Adding to iommu group 203
[    1.321477] pci 0000:ae:0a.6: Adding to iommu group 204
[    1.322732] pci 0000:ae:0a.7: Adding to iommu group 205
[    1.322778] pci 0000:ae:0b.0: Adding to iommu group 206
[    1.322818] pci 0000:ae:0b.1: Adding to iommu group 207
[    1.322858] pci 0000:ae:0b.2: Adding to iommu group 208
[    1.322901] pci 0000:ae:0b.3: Adding to iommu group 209
[    1.322941] pci 0000:ae:0c.0: Adding to iommu group 210
[    1.322980] pci 0000:ae:0c.1: Adding to iommu group 211
[    1.323020] pci 0000:ae:0c.2: Adding to iommu group 212
[    1.323060] pci 0000:ae:0c.3: Adding to iommu group 213
[    1.323100] pci 0000:ae:0c.4: Adding to iommu group 214
[    1.323139] pci 0000:ae:0c.5: Adding to iommu group 215
[    1.323179] pci 0000:ae:0c.6: Adding to iommu group 216
[    1.323219] pci 0000:ae:0c.7: Adding to iommu group 217
[    1.323259] pci 0000:ae:0d.0: Adding to iommu group 218
[    1.323298] pci 0000:ae:0d.1: Adding to iommu group 219
[    1.323339] pci 0000:ae:0d.2: Adding to iommu group 220
[    1.323381] pci 0000:ae:0d.3: Adding to iommu group 221
[    1.323423] pci 0000:d7:05.0: Adding to iommu group 222
[    1.323463] pci 0000:d7:05.2: Adding to iommu group 223
[    1.323503] pci 0000:d7:05.4: Adding to iommu group 224
[    1.324619] pci 0000:d7:05.6: Adding to iommu group 225
[    1.324665] pci 0000:d7:07.0: Adding to iommu group 226
[    1.324707] pci 0000:d7:07.1: Adding to iommu group 227
[    1.324747] pci 0000:d7:07.2: Adding to iommu group 228
[    1.324788] pci 0000:d7:07.3: Adding to iommu group 229
[    1.324829] pci 0000:d7:07.4: Adding to iommu group 230
[    1.324869] pci 0000:d7:07.7: Adding to iommu group 231
[    1.324910] pci 0000:d7:0e.0: Adding to iommu group 232
[    1.324953] pci 0000:d7:0e.1: Adding to iommu group 233
[    1.324993] pci 0000:d7:0e.2: Adding to iommu group 234
[    1.325033] pci 0000:d7:0e.3: Adding to iommu group 235
[    1.325074] pci 0000:d7:0f.0: Adding to iommu group 236
[    1.325116] pci 0000:d7:0f.1: Adding to iommu group 237
[    1.325156] pci 0000:d7:0f.2: Adding to iommu group 238
[    1.325196] pci 0000:d7:12.0: Adding to iommu group 239
[    1.325339] pci 0000:d7:12.1: Adding to iommu group 240
[    1.325411] pci 0000:d7:12.2: Adding to iommu group 240
[    1.325483] pci 0000:d7:12.3: Adding to iommu group 240
[    1.326584] pci 0000:d7:15.0: Adding to iommu group 241
[    1.326662] pci 0000:d7:15.1: Adding to iommu group 241
[    1.326734] pci 0000:d7:15.3: Adding to iommu group 241
[    1.326979] pci 0000:d7:16.0: Adding to iommu group 242
[    1.327051] pci 0000:d7:16.1: Adding to iommu group 242
[    1.327123] pci 0000:d7:16.3: Adding to iommu group 242
[    1.327195] pci 0000:d7:16.4: Adding to iommu group 242
[    1.327266] pci 0000:d7:16.5: Adding to iommu group 242
[    1.327339] pci 0000:d7:16.7: Adding to iommu group 242
[    1.328627] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.328629] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.328630] software IO TLB: mapped [mem 0x000000005ee40000-0x0000000062e40000] (64MB)
[    1.328696] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    1.328698] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.328699] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    1.330130] skx_uncore: probe of 0000:ae:08.0 failed with error -22
[    1.330136] skx_uncore: probe of 0000:ae:09.0 failed with error -22
[    1.330141] skx_uncore: probe of 0000:ae:0a.2 failed with error -22
[    1.330145] skx_uncore: probe of 0000:ae:0a.6 failed with error -22
[    1.330150] skx_uncore: probe of 0000:ae:0b.2 failed with error -22
[    1.330154] skx_uncore: probe of 0000:ae:0c.2 failed with error -22
[    1.330158] skx_uncore: probe of 0000:ae:0c.6 failed with error -22
[    1.330162] skx_uncore: probe of 0000:ae:0d.2 failed with error -22
[    1.330170] skx_uncore: probe of 0000:d7:0e.0 failed with error -22
[    1.330175] skx_uncore: probe of 0000:d7:0f.0 failed with error -22
[    1.330181] skx_uncore: probe of 0000:d7:12.1 failed with error -22
[    1.330185] skx_uncore: probe of 0000:d7:12.2 failed with error -22
[    1.330189] skx_uncore: probe of 0000:d7:15.1 failed with error -22
[    1.330194] skx_uncore: probe of 0000:d7:16.1 failed with error -22
[    1.330199] skx_uncore: probe of 0000:d7:16.5 failed with error -22
[    1.334272] Initialise system trusted keyrings
[    1.334280] Key type blacklist registered
[    1.335563] workingset: timestamp_bits=36 max_order=26 bucket_order=0
[    1.335658] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.335705] fuse: init (API version 7.39)
[    1.335857] SGI XFS with ACLs, security attributes, realtime, scrub, quota, fatal assert, debug enabled
[    1.352535] NET: Registered PF_ALG protocol family
[    1.352541] xor: automatically using best checksumming function   avx       
[    1.352544] async_tx: api initialized (async)
[    1.352547] Key type asymmetric registered
[    1.352548] Asymmetric key parser 'x509' registered
[    1.352549] Asymmetric key parser 'pkcs8' registered
[    1.352586] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    1.352588] io scheduler mq-deadline registered
[    1.352590] io scheduler kyber registered
[    1.352599] io scheduler bfq registered
[    1.352896] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
[    1.353066] pcieport 0000:00:1c.2: PME: Signaling with IRQ 25
[    1.353303] pcieport 0000:00:1c.5: PME: Signaling with IRQ 26
[    1.353624] pcieport 0000:17:00.0: PME: Signaling with IRQ 28
[    1.353922] pcieport 0000:3a:00.0: PME: Signaling with IRQ 30
[    1.354615] pcieport 0000:3a:01.0: PME: Signaling with IRQ 31
[    1.355564] pcieport 0000:3a:02.0: PME: Signaling with IRQ 32
[    1.355875] pcieport 0000:3a:03.0: PME: Signaling with IRQ 33
[    1.356664] pcieport 0000:5d:00.0: PME: Signaling with IRQ 35
[    1.356745] pcieport 0000:5d:00.0: pciehp: Slot #7 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.357076] pcieport 0000:5d:01.0: PME: Signaling with IRQ 36
[    1.357594] pcieport 0000:5d:01.0: pciehp: Slot #8 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.357948] pcieport 0000:5d:02.0: PME: Signaling with IRQ 37
[    1.358599] pcieport 0000:5d:03.0: PME: Signaling with IRQ 38
[    1.359625] pcieport 0000:80:00.0: PME: Signaling with IRQ 42
[    1.359909] pcieport 0000:85:00.0: PME: Signaling with IRQ 44
[    1.360142] pcieport 0000:85:02.0: PME: Signaling with IRQ 45
[    1.360388] pcieport 0000:ae:00.0: PME: Signaling with IRQ 47
[    1.362014] pcieport 0000:d7:00.0: PME: Signaling with IRQ 51
[    1.364003] IPMI message handler: version 39.2
[    1.364011] ipmi device interface
[    1.364066] ipmi_si: IPMI System Interface driver
[    1.364075] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    1.364078] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    1.364081] ipmi_si: Adding SMBIOS-specified kcs state machine
[    1.364148] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[    1.364233] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    1.518161] Freeing initrd memory: 31200K
[    1.521721] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[    1.521724] ipmi_si: Adding ACPI-specified kcs state machine
[    1.521836] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    1.597611] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[    1.624209] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_id: 0x097a, dev_id: 0x20)
[    1.661227] ipmi_si IPI0001:00: IPMI kcs interface initialized
[    1.661230] ipmi_ssif: IPMI SSIF Interface driver
[    1.667744] IPMI Watchdog: driver initialized
[    1.667748] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
[    1.673531] IPMI poweroff: ATCA Detect mfg 0x2A7C prod 0x97A
[    1.673535] IPMI poweroff: Found a chassis style poweroff function
[    1.673926] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.674067] ACPI: button: Power Button [PWRF]
[    1.674490] ERST: Error Record Serialization Table (ERST) support is initialized.
[    1.674499] pstore: Using crash dump compression: deflate
[    1.674500] pstore: Registered erst as persistent store backend
[    1.674709] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    1.674727] ioatdma 0000:00:04.0: enabling device (0004 -> 0006)
[    1.682643] ioatdma 0000:00:04.1: enabling device (0004 -> 0006)
[    1.689397] ioatdma 0000:00:04.2: enabling device (0004 -> 0006)
[    1.695996] ioatdma 0000:00:04.3: enabling device (0004 -> 0006)
[    1.702506] ioatdma 0000:00:04.4: enabling device (0004 -> 0006)
[    1.709033] ioatdma 0000:00:04.5: enabling device (0004 -> 0006)
[    1.715533] ioatdma 0000:00:04.6: enabling device (0004 -> 0006)
[    1.722039] ioatdma 0000:00:04.7: enabling device (0004 -> 0006)
[    1.728617] ioatdma 0000:80:04.0: enabling device (0004 -> 0006)
[    1.737014] ioatdma 0000:80:04.1: enabling device (0004 -> 0006)
[    1.744119] ioatdma 0000:80:04.2: enabling device (0004 -> 0006)
[    1.750970] ioatdma 0000:80:04.3: enabling device (0004 -> 0006)
[    1.757815] ioatdma 0000:80:04.4: enabling device (0004 -> 0006)
[    1.764705] ioatdma 0000:80:04.5: enabling device (0004 -> 0006)
[    1.771829] ioatdma 0000:80:04.6: enabling device (0004 -> 0006)
[    1.778684] ioatdma 0000:80:04.7: enabling device (0004 -> 0006)
[    1.785601] idxd driver failed to load without MOVDIR64B.
[    1.785960] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.786365] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.790194] Non-volatile memory driver v1.3
[    1.790563] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.791117] ACPI: bus type drm_connector registered
[    1.791152] [drm] amdgpu kernel modesetting enabled.
[    1.791290] amdgpu: Virtual CRAT table created for CPU
[    1.791300] amdgpu: Topology: Add CPU node
[    1.791602] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1DA2:0x471E 0xCC).
[    1.791617] [drm] register mmio base: 0xEE400000
[    1.791618] [drm] register mmio size: 1048576
[    1.795736] [drm] add ip block number 0 <soc21_common>
[    1.795738] [drm] add ip block number 1 <gmc_v11_0>
[    1.795739] [drm] add ip block number 2 <ih_v6_0>
[    1.795740] [drm] add ip block number 3 <psp>
[    1.795741] [drm] add ip block number 4 <smu>
[    1.795742] [drm] add ip block number 5 <dm>
[    1.795744] [drm] add ip block number 6 <gfx_v11_0>
[    1.795745] [drm] add ip block number 7 <sdma_v6_0>
[    1.795746] [drm] add ip block number 8 <vcn_v4_0>
[    1.795747] [drm] add ip block number 9 <jpeg_v4_0>
[    1.795747] [drm] add ip block number 10 <mes_v11_0>
[    1.795794] amdgpu 0000:b1:00.0: amdgpu: Fetched VBIOS from VFCT
[    1.795797] amdgpu: ATOM BIOS: 113-D70401XT-P11
[    1.800743] amdgpu 0000:b1:00.0: amdgpu: CP RS64 enable
[    1.803670] [drm] VCN(0) encode/decode are enabled in VM mode
[    1.803671] [drm] VCN(1) encode/decode are enabled in VM mode
[    1.805092] amdgpu 0000:b1:00.0: [drm:jpeg_v4_0_early_init] JPEG decode is enabled in VM mode
[    1.805114] amdgpu 0000:b1:00.0: Direct firmware load for amdgpu/gc_11_0_0_mes_2.bin failed with error -2
[    1.805117] [drm] try to fall back to amdgpu/gc_11_0_0_mes.bin
[    1.807052] amdgpu 0000:b1:00.0: vgaarb: deactivate vga console
[    1.807055] amdgpu 0000:b1:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    1.807086] amdgpu 0000:b1:00.0: amdgpu: MEM ECC is not presented.
[    1.807087] amdgpu 0000:b1:00.0: amdgpu: SRAM ECC is not presented.
[    1.807094] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    1.807107] amdgpu 0000:b1:00.0: BAR 2: releasing [mem 0x39bff0000000-0x39bff01fffff 64bit pref]
[    1.807110] amdgpu 0000:b1:00.0: BAR 0: releasing [mem 0x39bfe0000000-0x39bfefffffff 64bit pref]
[    1.807124] pcieport 0000:b0:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.807127] pcieport 0000:af:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.807129] pcieport 0000:ae:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.807136] pcieport 0000:ae:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807138] pcieport 0000:af:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807140] pcieport 0000:b0:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807143] amdgpu 0000:b1:00.0: BAR 0: assigned [mem 0x398000000000-0x3987ffffffff 64bit pref]
[    1.807157] amdgpu 0000:b1:00.0: BAR 2: assigned [mem 0x398800000000-0x3988001fffff 64bit pref]
[    1.807172] pcieport 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.807174] pcieport 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.807183] pcieport 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    1.807189] pcieport 0000:ae:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807199] pcieport 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.807201] pcieport 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.807210] pcieport 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.807217] pcieport 0000:af:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807229] pcieport 0000:b0:00.0: PCI bridge to [bus b1]
[    1.807231] pcieport 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.807240] pcieport 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.807246] pcieport 0000:b0:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.807262] amdgpu 0000:b1:00.0: amdgpu: VRAM: 20464M 0x0000008000000000 - 0x00000084FEFFFFFF (20464M used)
[    1.807265] amdgpu 0000:b1:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
[    1.807267] amdgpu 0000:b1:00.0: amdgpu: AGP: 267878400M 0x0000008800000000 - 0x0000FFFFFFFFFFFF
[    1.807280] [drm] Detected VRAM RAM=20464M, BAR=32768M
[    1.807282] [drm] RAM width 320bits GDDR6
[    1.807347] [drm] amdgpu: 20464M of VRAM memory ready
[    1.807348] [drm] amdgpu: 95976M of GTT memory ready.
[    1.807364] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    1.807421] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
[    1.807916] [drm] Loading DMUB firmware via PSP: version=0x07001900
[    1.808725] [drm] Found VCN firmware Version ENC: 1.11 DEC: 5 VEP: 0 Revision: 12
[    1.808735] amdgpu 0000:b1:00.0: amdgpu: Will use PSP to load VCN firmware
[    1.935071] [drm] reserve 0x1300000 from 0x84fc000000 for PSP TMR
[    2.061752] amdgpu 0000:b1:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    2.061757] amdgpu 0000:b1:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    2.061822] amdgpu 0000:b1:00.0: amdgpu: smu driver if version = 0x0000003d, smu fw if version = 0x0000003b, smu fw program = 0, smu fw version = 0x004e5500 (78.85.0)
[    2.061825] amdgpu 0000:b1:00.0: amdgpu: SMU driver if version not matched
[    2.224484] amdgpu 0000:b1:00.0: amdgpu: SMU is initialized successfully!
[    2.224873] [drm] Display Core v3.2.247 initialized on DCN 3.2
[    2.224875] [drm] DP-HDMI FRL PCON supported
[    2.226734] [drm] DMUB hardware initialized: version=0x07001900
[    2.365173] tsc: Refined TSC clocksource calibration: 2499.999 MHz
[    2.365178] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240938fe3e8, max_idle_ns: 440795307177 ns
[    2.365187] clocksource: Switched to clocksource tsc
[    2.782405] [drm] kiq ring mec 3 pipe 1 q 0
[    2.788977] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[    2.789111] amdgpu 0000:b1:00.0: [drm:jpeg_v4_0_hw_init] JPEG decode initialized successfully.
[    2.791243] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.791260] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    2.791272] amdgpu: Virtual CRAT table created for GPU
[    2.791274] amdgpu: Error parsing VCRAT for GPU (ID: 0xc2cc)
[    2.797638] kfd kfd: amdgpu: Error adding device to topology
[    2.803996] kfd kfd: amdgpu: Error initializing KFD node
[    2.810548] kfd kfd: amdgpu: device 1002:744c NOT added due to errors
[    2.817695] amdgpu 0000:b1:00.0: amdgpu: SE 6, SH per SE 2, CU per SH 8, active_cu_number 84
[    2.818018] amdgpu 0000:b1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.818021] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.818023] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.818024] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.818026] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.818027] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.818029] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.818030] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.818032] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.818033] amdgpu 0000:b1:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    2.818035] amdgpu 0000:b1:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[    2.818036] amdgpu 0000:b1:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.818037] amdgpu 0000:b1:00.0: amdgpu: ring vcn_unified_1 uses VM inv eng 1 on hub 8
[    2.818038] amdgpu 0000:b1:00.0: amdgpu: ring jpeg_dec uses VM inv eng 4 on hub 8
[    2.818039] amdgpu 0000:b1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[    2.819071] [drm] ring gfx_32768.1.1 was added
[    2.819486] [drm] ring compute_32768.2.2 was added
[    2.819839] [drm] ring sdma_32768.3.3 was added
[    2.819888] [drm] ring gfx_32768.1.1 ib test pass
[    2.819936] [drm] ring compute_32768.2.2 ib test pass
[    2.819967] [drm] ring sdma_32768.3.3 ib test pass
[    2.821017] amdgpu 0000:b1:00.0: amdgpu: Using BACO for runtime pm
[    2.821613] [drm] Initialized amdgpu 3.54.0 20150101 for 0000:b1:00.0 on minor 0
[    2.845819] fbcon: amdgpudrmfb (fb0) is primary device
[    2.846370] [drm] DSC precompute is not needed.
[    3.188315] Console: switching to colour frame buffer device 240x75
[    3.227088] amdgpu 0000:b1:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    3.231702] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 1
[    3.231733] usbcore: registered new interface driver udl
[    3.232889] loop: module loaded
[    3.233094] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
[    3.233097] lpc_ich 0000:00:1f.0: No MFD cells added
[    3.234189] SCSI Media Changer driver v0.25 
[    3.234662] nvme nvme0: pci function 0000:3b:00.0
[    3.234874] nvme nvme1: pci function 0000:3c:00.0
[    3.235253] nvme nvme2: pci function 0000:3d:00.0
[    3.235434] nvme nvme3: pci function 0000:3e:00.0
[    3.235691] nvme nvme4: pci function 0000:5e:00.0
[    3.235907] nvme nvme5: pci function 0000:5f:00.0
[    3.236138] nvme nvme6: pci function 0000:60:00.0
[    3.236356] nvme nvme7: pci function 0000:87:00.0
[    3.236781] ahci 0000:00:11.5: version 3.0
[    3.236967] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    3.236971] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    3.239835] nvme nvme7: Shutdown timeout set to 10 seconds
[    3.240379] nvme nvme5: 1/0/0 default/read/poll queues
[    3.240553] nvme nvme4: 1/0/0 default/read/poll queues
[    3.240806] nvme nvme2: missing or invalid SUBNQN field.
[    3.240844] nvme nvme7: 1/0/0 default/read/poll queues
[    3.240971] nvme nvme2: Shutdown timeout set to 8 seconds
[    3.241771] nvme nvme7: Ignoring bogus Namespace Identifiers
[    3.241833] nvme nvme3: missing or invalid SUBNQN field.
[    3.241872] nvme nvme6: missing or invalid SUBNQN field.
[    3.242062] nvme nvme3: Shutdown timeout set to 8 seconds
[    3.242196] nvme nvme6: Shutdown timeout set to 8 seconds
[    3.242971]  nvme7n1: p1 p2 p3
[    3.243494] nvme nvme0: 1/0/0 default/read/poll queues
[    3.244911] nvme nvme1: missing or invalid SUBNQN field.
[    3.245110] nvme nvme1: Shutdown timeout set to 8 seconds
[    3.246903] nvme nvme2: 1/0/0 default/read/poll queues
[    3.247839] nvme nvme3: 1/0/0 default/read/poll queues
[    3.248041] nvme nvme6: 1/0/0 default/read/poll queues
[    3.251161]  nvme6n1: p1 p2 p3
[    3.251278] nvme nvme1: 1/0/0 default/read/poll queues
[    3.252237] scsi host0: ahci
[    3.252390] scsi host1: ahci
[    3.252502] scsi host2: ahci
[    3.252677] scsi host3: ahci
[    3.252822] scsi host4: ahci
[    3.252930] scsi host5: ahci
[    3.252960] ata1: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280100 irq 89
[    3.252962] ata2: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280180 irq 89
[    3.252964] ata3: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280200 irq 89
[    3.252966] ata4: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280280 irq 89
[    3.252968] ata5: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280300 irq 89
[    3.252969] ata6: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280380 irq 89
[    3.263718] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    3.263730] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    3.285557] scsi host6: ahci
[    3.285699] scsi host7: ahci
[    3.285830] scsi host8: ahci
[    3.285957] scsi host9: ahci
[    3.286088] scsi host10: ahci
[    3.286218] scsi host11: ahci
[    3.286347] scsi host12: ahci
[    3.286474] scsi host13: ahci
[    3.286558] ata7: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200100 irq 98
[    3.286561] ata8: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200180 irq 98
[    3.286563] ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200200 irq 98
[    3.286564] ata10: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200280 irq 98
[    3.286566] ata11: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200300 irq 98
[    3.286568] ata12: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200380 irq 98
[    3.286569] ata13: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 98
[    3.286571] ata14: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200480 irq 98
[    3.287198] e1000e: Intel(R) PRO/1000 Network Driver
[    3.287199] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.287339] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.287341] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.287415] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    3.287416] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    3.287459] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    3.287460] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    3.545634] ixgbe 0000:18:00.0: Multiqueue Disabled: Rx Queue count = 1, Tx Queue count = 1 XDP Queue count = 0
[    3.566037] ata5: SATA link down (SStatus 0 SControl 300)
[    3.566064] ata6: SATA link down (SStatus 0 SControl 300)
[    3.566089] ata2: SATA link down (SStatus 0 SControl 300)
[    3.566108] ata3: SATA link down (SStatus 0 SControl 300)
[    3.566127] ata4: SATA link down (SStatus 0 SControl 300)
[    3.566148] ata1: SATA link down (SStatus 0 SControl 300)
[    3.596865] ata13: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596891] ata14: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596910] ata12: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596926] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596943] ata11: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596960] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596977] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.596993] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.597287] ata13.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    3.597306] ata14.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    3.598441] ata11.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.598458] ata10.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.598784] ata10.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.598791] ata11.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.598795] ata7.00: supports DRM functions and may not be fully accessible
[    3.598796] ata7.00: ATA-11: Samsung SSD 860 PRO 4TB, RVM01B6Q, max UDMA/133
[    3.598852] ata8.00: supports DRM functions and may not be fully accessible
[    3.598853] ata8.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    3.598855] ata9.00: supports DRM functions and may not be fully accessible
[    3.598859] ata9.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    3.598865] ata12.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.602560] ata7.00: 8001573552 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.602564] ata12.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.604573] ata10.00: configured for UDMA/133
[    3.604581] ata11.00: configured for UDMA/133
[    3.604630] ata9.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.604633] ata8.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.606615] ata12.00: configured for UDMA/133
[    3.607418] ata7.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.607840] ata7.00: supports DRM functions and may not be fully accessible
[    3.608061] ata14.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.608065] ata14.00: Features: NCQ-sndrcv NCQ-prio
[    3.609428] ata13.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.609432] ata13.00: Features: NCQ-sndrcv NCQ-prio
[    3.612201] ata7.00: configured for UDMA/133
[    3.612316] scsi 6:0:0:0: Direct-Access     ATA      Samsung SSD 860  1B6Q PQ: 0 ANSI: 5
[    3.612618] ata7.00: Enabling discard_zeroes_data
[    3.612624] sd 6:0:0:0: [sda] 8001573552 512-byte logical blocks: (4.10 TB/3.73 TiB)
[    3.612628] sd 6:0:0:0: [sda] Write Protect is off
[    3.612630] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.612634] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.612642] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.612881] ata7.00: Enabling discard_zeroes_data
[    3.612947] sd 6:0:0:0: Attached scsi generic sg0 type 0
[    3.614057] sd 6:0:0:0: [sda] supports TCG Opal
[    3.614062] sd 6:0:0:0: [sda] Attached SCSI disk
[    3.614130] ata9.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.614148] ata8.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.614317] ata8.00: supports DRM functions and may not be fully accessible
[    3.614320] ata9.00: supports DRM functions and may not be fully accessible
[    3.619552] ata14.00: configured for UDMA/133
[    3.622147] ata13.00: configured for UDMA/133
[    3.626532] ixgbe 0000:18:00.0: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
[    3.628665] ata8.00: configured for UDMA/133
[    3.628783] scsi 7:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    3.628958] scsi 7:0:0:0: Attached scsi generic sg1 type 0
[    3.629037] sd 7:0:0:0: [sdb] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    3.629041] sd 7:0:0:0: [sdb] Write Protect is off
[    3.629043] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.629047] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.629055] sd 7:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    3.629385] ata9.00: configured for UDMA/133
[    3.629448] scsi 8:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    3.629469] sd 7:0:0:0: [sdb] supports TCG Opal
[    3.629471] sd 7:0:0:0: [sdb] Attached SCSI disk
[    3.629641] sd 8:0:0:0: [sdc] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    3.629645] sd 8:0:0:0: [sdc] Write Protect is off
[    3.629646] sd 8:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.629650] sd 8:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.629658] sd 8:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[    3.629897] sd 8:0:0:0: Attached scsi generic sg2 type 0
[    3.629978] scsi 9:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.630059] scsi 9:0:0:0: Attached scsi generic sg3 type 0
[    3.630142] sd 9:0:0:0: [sdd] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.630143] sd 9:0:0:0: [sdd] 4096-byte physical blocks
[    3.630147] sd 9:0:0:0: [sdd] Write Protect is off
[    3.630148] sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    3.630153] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.630159] sd 9:0:0:0: [sdd] Preferred minimum I/O size 4096 bytes
[    3.630215] scsi 10:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.630296] scsi 10:0:0:0: Attached scsi generic sg4 type 0
[    3.630479] sd 10:0:0:0: [sde] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.630481] sd 10:0:0:0: [sde] 4096-byte physical blocks
[    3.630484] sd 10:0:0:0: [sde] Write Protect is off
[    3.630486] sd 10:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    3.630490] sd 10:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.630495] sd 10:0:0:0: [sde] Preferred minimum I/O size 4096 bytes
[    3.630907] scsi 11:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.631036] sd 11:0:0:0: [sdf] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.631038] sd 11:0:0:0: [sdf] 4096-byte physical blocks
[    3.631041] sd 11:0:0:0: [sdf] Write Protect is off
[    3.631043] sd 11:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    3.631047] sd 11:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.631053] sd 11:0:0:0: [sdf] Preferred minimum I/O size 4096 bytes
[    3.631225] sd 11:0:0:0: Attached scsi generic sg5 type 0
[    3.631311] scsi 12:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    3.631434] sd 12:0:0:0: [sdg] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.631437] sd 12:0:0:0: [sdg] Write Protect is off
[    3.631439] sd 12:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[    3.631443] sd 12:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.631449] sd 12:0:0:0: [sdg] Preferred minimum I/O size 512 bytes
[    3.631757] sd 12:0:0:0: Attached scsi generic sg6 type 0
[    3.631877] scsi 13:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    3.632005] sd 13:0:0:0: [sdh] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.632009] sd 13:0:0:0: [sdh] Write Protect is off
[    3.632010] sd 13:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[    3.632015] sd 13:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.632020] sd 13:0:0:0: [sdh] Preferred minimum I/O size 512 bytes
[    3.632112] sd 13:0:0:0: Attached scsi generic sg7 type 0
[    3.632502] sd 8:0:0:0: [sdc] supports TCG Opal
[    3.632505] sd 8:0:0:0: [sdc] Attached SCSI disk
[    3.633605] sd 9:0:0:0: [sdd] Attached SCSI disk
[    3.650997] sd 11:0:0:0: [sdf] Attached SCSI disk
[    3.651406] sd 10:0:0:0: [sde] Attached SCSI disk
[    3.676079]  sdh: sdh1
[    3.676176] sd 13:0:0:0: [sdh] Attached SCSI disk
[    3.676326]  sdg: sdg1
[    3.676398] sd 12:0:0:0: [sdg] Attached SCSI disk
[    3.723050] ixgbe 0000:18:00.0: MAC: 3, PHY: 0, PBA No: G54042-008
[    3.723058] ixgbe 0000:18:00.0: 00:1b:21:e2:59:80
[    3.872628] ixgbe 0000:18:00.0: Intel(R) 10 Gigabit Network Connection
[    3.872777] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    3.872779] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    3.887828] i40e 0000:63:00.0: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[    3.892044] i40e 0000:63:00.0: MAC address: 00:25:90:be:7e:20
[    3.892376] i40e 0000:63:00.0: FW LLDP is enabled
[    3.898101] i40e 0000:63:00.0 eth1: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[    3.899254] i40e 0000:63:00.0: Features: PF-id[0] VFs: 32 VSIs: 34 QP: 1 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[    3.912711] i40e 0000:63:00.1: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[    3.916670] i40e 0000:63:00.1: MAC address: 00:25:90:be:7e:21
[    3.917008] i40e 0000:63:00.1: FW LLDP is enabled
[    3.922855] i40e 0000:63:00.1 eth2: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[    3.924001] i40e 0000:63:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 1 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[    3.924458] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.924512] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.925599] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    3.925931] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.925983] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.925986] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    3.926016] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    3.926019] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.926021] usb usb1: Product: xHCI Host Controller
[    3.926022] usb usb1: Manufacturer: Linux 6.6.0-andres-00004-gec9aedb2aa1a xhci-hcd
[    3.926024] usb usb1: SerialNumber: 0000:00:14.0
[    3.926176] hub 1-0:1.0: USB hub found
[    3.926195] hub 1-0:1.0: 16 ports detected
[    3.927564] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    3.927567] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.927569] usb usb2: Product: xHCI Host Controller
[    3.927571] usb usb2: Manufacturer: Linux 6.6.0-andres-00004-gec9aedb2aa1a xhci-hcd
[    3.927572] usb usb2: SerialNumber: 0000:00:14.0
[    3.927690] hub 2-0:1.0: USB hub found
[    3.927705] hub 2-0:1.0: 10 ports detected
[    3.928350] usb: port power management may be unreliable
[    3.928670] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    3.928722] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
[    3.983584] xhci_hcd 0000:02:00.0: hcc params 0x0200ef80 hci version 0x110 quirks 0x0000000000800010
[    3.983862] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    3.983909] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
[    3.983912] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    3.983958] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    3.983961] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.983963] usb usb3: Product: xHCI Host Controller
[    3.983964] usb usb3: Manufacturer: Linux 6.6.0-andres-00004-gec9aedb2aa1a xhci-hcd
[    3.983966] usb usb3: SerialNumber: 0000:02:00.0
[    3.984072] hub 3-0:1.0: USB hub found
[    3.984079] hub 3-0:1.0: 2 ports detected
[    3.984187] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.984201] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    3.984203] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.984205] usb usb4: Product: xHCI Host Controller
[    3.984207] usb usb4: Manufacturer: Linux 6.6.0-andres-00004-gec9aedb2aa1a xhci-hcd
[    3.984208] usb usb4: SerialNumber: 0000:02:00.0
[    3.984307] hub 4-0:1.0: USB hub found
[    3.984313] hub 4-0:1.0: 2 ports detected
[    3.984536] usbcore: registered new interface driver usb-storage
[    3.984641] i8042: PNP: No PS/2 controller found.
[    3.984793] mousedev: PS/2 mouse device common for all mice
[    3.984918] usbcore: registered new interface driver synaptics_usb
[    3.984987] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    3.985444] rtc_cmos 00:00: RTC can wake from S4
[    3.985990] rtc_cmos 00:00: registered as rtc0
[    3.986054] rtc_cmos 00:00: setting system clock to 2023-12-06T06:11:03 UTC (1701843063)
[    3.986099] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
[    3.986172] i2c_dev: i2c /dev entries driver
[    3.986658] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.986678] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.986715] pci 0000:00:1f.1: [8086:a1a0] type 00 class 0x058000
[    3.986752] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
[    3.986946] pci 0000:00:1f.1: Adding to iommu group 243
[    3.989249] i2c i2c-8: 12/16 memory slots populated (from DMI)
[    3.989252] i2c i2c-8: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    4.200524] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    4.286640] usb 3-2: new high-speed USB device number 2 using xhci_hcd
[    4.327461] usb 1-1: New USB device found, idVendor=1397, idProduct=0509, bcdDevice= 1.12
[    4.327471] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=0
[    4.327476] usb 1-1: Product: UMC404HD 192k
[    4.327480] usb 1-1: Manufacturer: BEHRINGER
[    4.442602] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    4.498544] usb 3-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.01
[    4.498554] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.498559] usb 3-2: Product: USB2.1 Hub
[    4.498563] usb 3-2: Manufacturer: Generic
[    4.504100] hub 3-2:1.0: USB hub found
[    4.505486] hub 3-2:1.0: 4 ports detected
[    4.569090] usb 1-7: New USB device found, idVendor=0557, idProduct=7000, bcdDevice= 0.00
[    4.569108] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.569715] hub 1-7:1.0: USB hub found
[    4.569894] hub 1-7:1.0: 4 ports detected
[    4.601887] usb 4-2: new SuperSpeed USB device number 2 using xhci_hcd
[    4.638427] usb 4-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.01
[    4.638437] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.638442] usb 4-2: Product: USB3.2 Hub
[    4.638446] usb 4-2: Manufacturer: Generic
[    4.646655] hub 4-2:1.0: USB hub found
[    4.648674] hub 4-2:1.0: 4 ports detected
[    4.804588] usb 3-2.2: new low-speed USB device number 3 using xhci_hcd
[    4.858600] usb 1-7.1: new low-speed USB device number 4 using xhci_hcd
[    4.948046] usb 1-7.1: New USB device found, idVendor=0557, idProduct=2419, bcdDevice= 1.00
[    4.948057] usb 1-7.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.990206] usb 3-2.2: New USB device found, idVendor=17ef, idProduct=6009, bcdDevice= 1.27
[    4.990217] usb 3-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.990222] usb 3-2.2: Product: ThinkPad USB Keyboard with TrackPoint
[    4.990225] usb 3-2.2: Manufacturer: Lite-On Technology Corp.
[    5.030609] power_meter ACPI000D:00: Found ACPI power meter.
[    5.030626] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    5.060629] usb 4-2.4: new SuperSpeed USB device number 3 using xhci_hcd
[    5.096414] usb 4-2.4: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.01
[    5.096424] usb 4-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.096429] usb 4-2.4: Product: USB3.2 Hub
[    5.096433] usb 4-2.4: Manufacturer: Generic
[    5.104088] hub 4-2.4:1.0: USB hub found
[    5.106415] hub 4-2.4:1.0: 4 ports detected
[    5.150247] i2c i2c-0: adapter quirk: no zero length (addr 0x0018, size 0, write)
[    5.164390] usb 3-2.3: new high-speed USB device number 4 using xhci_hcd
[    5.164401] i2c i2c-0: adapter quirk: no zero length (addr 0x0019, size 0, write)
[    5.172635] i2c i2c-0: adapter quirk: no zero length (addr 0x001a, size 0, write)
[    5.186408] i2c i2c-0: adapter quirk: no zero length (addr 0x001b, size 0, write)
[    5.194664] i2c i2c-0: adapter quirk: no zero length (addr 0x001c, size 0, write)
[    5.206892] i2c i2c-0: adapter quirk: no zero length (addr 0x001d, size 0, write)
[    5.216892] i2c i2c-0: adapter quirk: no zero length (addr 0x001e, size 0, write)
[    5.229149] i2c i2c-0: adapter quirk: no zero length (addr 0x001f, size 0, write)
[    5.239343] i2c i2c-1: adapter quirk: no zero length (addr 0x0018, size 0, write)
[    5.251286] i2c i2c-1: adapter quirk: no zero length (addr 0x0019, size 0, write)
[    5.265186] iTCO_wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[    5.265199] iTCO_vendor_support: vendor-support=0
[    5.265335] device-mapper: uevent: version 1.0.3
[    5.265393] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    5.265426] usbcore: registered new interface driver btusb
[    5.265642] EDAC igen6: v2.5.1
[    5.266574] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
[    5.266610] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
[    5.266642] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
[    5.266672] EDAC MC3: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
[    5.266676] intel_pstate: Intel P-state driver initializing
[    5.266705] intel_pstate: HWP enabled
[    5.266714] ledtrig-cpu: registered to indicate activity on CPUs
[    5.266944] pstore: backend 'erst' already in use: ignoring 'efi_pstore'
[    5.267039] hid: raw HID events driver (C) Jiri Kosina
[    5.268228] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.0/0003:0557:2419.0001/input/input2
[    5.290610] usb 3-2.3: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    5.290621] usb 3-2.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.297262] hub 3-2.3:1.0: USB hub found
[    5.297285] hub 3-2.3:1.0: 4 ports detected
[    5.320195] hid-generic 0003:0557:2419.0001: input,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-7.1/input0
[    5.321225] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.1/0003:0557:2419.0002/input/input3
[    5.321312] hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-7.1/input1
[    5.324565] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.0/0003:17EF:6009.0003/input/input4
[    5.377178] hid-generic 0003:17EF:6009.0003: input,hidraw2: USB HID v1.10 Keyboard [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:02:00.0-2.2/input0
[    5.382526] usb 3-2.4: new high-speed USB device number 5 using xhci_hcd
[    5.384269] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint Mouse as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input5
[    5.384360] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint System Control as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input6
[    5.435726] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint Consumer Control as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input7
[    5.436172] hid-generic 0003:17EF:6009.0004: input,hiddev0,hidraw3: USB HID v1.10 Mouse [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:02:00.0-2.2/input1
[    5.436236] usbcore: registered new interface driver usbhid
[    5.436237] usbhid: USB HID core driver
[    5.436492] intel_rapl_common: Found RAPL domain package
[    5.436497] intel_rapl_common: Found RAPL domain dram
[    5.436501] intel_rapl_common: package-0:dram:long_term locked by BIOS
[    5.437455] GACT probability on
[    5.437457] Mirror/redirect action on
[    5.437462] Simple TC action Loaded
[    5.437608] netem: version 1.3
[    5.437614] u32 classifier
[    5.437615]     Performance counters on
[    5.437615]     input device check on
[    5.437616]     Actions configured
[    5.459645] NET: Registered PF_INET6 protocol family
[    5.464794] Segment Routing with IPv6
[    5.464796] RPL Segment Routing with IPv6
[    5.464805] In-situ OAM (IOAM) with IPv6
[    5.464834] mip6: Mobile IPv6
[    5.464858] NET: Registered PF_PACKET protocol family
[    5.464861] NET: Registered PF_KEY protocol family
[    5.464867] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    5.464884] Bluetooth: RFCOMM TTY layer initialized
[    5.464899] Bluetooth: RFCOMM socket layer initialized
[    5.464903] Bluetooth: RFCOMM ver 1.11
[    5.464904] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.464905] Bluetooth: BNEP filters: protocol multicast
[    5.464907] Bluetooth: BNEP socket layer initialized
[    5.464908] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    5.464909] Bluetooth: HIDP socket layer initialized
[    5.464927] 8021q: 802.1Q VLAN Support v1.8
[    5.465004] Key type dns_resolver registered
[    5.465240] microcode: Microcode Update Driver: v2.2.
[    5.465367] resctrl: MB allocation detected
[    5.465368] resctrl: L3 monitoring detected
[    5.465373] IPI shorthand broadcast: enabled
[    5.465377] AVX2 version of gcm_enc/dec engaged.
[    5.465393] AES CTR mode by8 optimization enabled
[    5.484554] sched_clock: Marking stable (5475001592, 9512638)->(5512612101, -28097871)
[    5.485864] registered taskstats version 1
[    5.485936] Loading compiled-in X.509 certificates
[    5.487178] Key type .fscrypt registered
[    5.487180] Key type fscrypt-provisioning registered
[    5.487450] Btrfs loaded, zoned=yes, fsverity=no
[    5.487465] Key type big_key registered
[    5.490114] Key type encrypted registered
[    5.490606] printk: console [netcon0] enabled
[    5.490608] netconsole: network logging started
[    5.490715] RAS: Correctable Errors collector initialized.
[    5.490750] clk: Disabling unused clocks
[    5.490751] ALSA device list:
[    5.490752]   #0: Loopback 1
[    5.490754]   #1: Virtual MIDI Card 1
[    5.491525] Freeing unused kernel image (initmem) memory: 2812K
[    5.493522] Write protecting the kernel read-only data: 51200k
[    5.494272] Freeing unused kernel image (rodata/data gap) memory: 1768K
[    5.506534] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.506544] Run /init as init process
[    5.506545]   with arguments:
[    5.506546]     /init
[    5.506548]   with environment:
[    5.506548]     HOME=/
[    5.506549]     TERM=linux
[    5.506550]     BOOT_IMAGE=/vmlinuz-6.6.0-andres-00004-gec9aedb2aa1a
[    5.506551]     apparmor=0
[    5.507866] usb 3-2.4: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.01
[    5.507870] usb 3-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.507871] usb 3-2.4: Product: USB2.1 Hub
[    5.507873] usb 3-2.4: Manufacturer: Generic
[    5.516588] hub 3-2.4:1.0: USB hub found
[    5.518286] hub 3-2.4:1.0: 4 ports detected
[    5.586977] usb 3-2.3.4: new full-speed USB device number 6 using xhci_hcd
[    5.763155] ixgbe 0000:18:00.0 en10gbe: renamed from eth0
[    5.802450] i40e 0000:63:00.1 enipmi: renamed from eth2
[    5.809835] i40e 0000:63:00.0 en1gbe: renamed from eth1
[    5.840962] md127: detected capacity change from 0 to 23441316864
[    5.852525] usb 3-2.4.1: new high-speed USB device number 7 using xhci_hcd
[    5.861462] usb 3-2.3.4: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=88.91
[    5.861467] usb 3-2.3.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    5.861468] usb 3-2.3.4: Product: CSR8510 A10
[    5.886545] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=6 rev=22bb
[    5.886548] Bluetooth: hci0: LMP ver=6 subver=22bb; manufacturer=10
[    5.910805] power_meter ACPI000D:00: Found ACPI power meter.
[    5.910823] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[    5.950560] usb 3-2.4.1: New USB device found, idVendor=046d, idProduct=085e, bcdDevice= 0.17
[    5.950571] usb 3-2.4.1: New USB device strings: Mfr=0, Product=2, SerialNumber=3
[    5.950576] usb 3-2.4.1: Product: Logitech BRIO
[    5.950580] usb 3-2.4.1: SerialNumber: 3852FD74
[    5.982964] md0: detected capacity change from 0 to 15627538432
[    6.036596] usb 3-2.4.3: new full-speed USB device number 8 using xhci_hcd
[    6.294363] usb 3-2.4.3: New USB device found, idVendor=1050, idProduct=0407, bcdDevice= 5.12
[    6.294375] usb 3-2.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.294381] usb 3-2.4.3: Product: YubiKey OTP+FIDO+CCID
[    6.294385] usb 3-2.4.3: Manufacturer: Yubico
[    6.339602] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.4/3-2.4.3/3-2.4.3:1.0/0003:1050:0407.0005/input/input8
[    6.392054] hid-generic 0003:1050:0407.0005: input,hidraw4: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:02:00.0-2.4.3/input0
[    6.392505] hid-generic 0003:1050:0407.0006: hiddev1,hidraw5: USB HID v1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:02:00.0-2.4.3/input1
[    6.469585] usb 3-2.4.4: new full-speed USB device number 9 using xhci_hcd
[    6.730246] usb 3-2.4.4: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=24.11
[    6.730257] usb 3-2.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.730263] usb 3-2.4.4: Product: USB Receiver
[    6.730267] usb 3-2.4.4: Manufacturer: Logitech
[    6.767552] logitech-djreceiver 0003:046D:C52B.0009: hiddev2,hidraw6: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:02:00.0-2.4.4/input2
[    6.881583] input: Logitech MX Master 3 as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.4/3-2.4.4/3-2.4.4:1.2/0003:046D:C52B.0009/0003:046D:4082.000A/input/input9
[    6.881680] logitech-hidpp-device 0003:046D:4082.000A: input,hidraw7: USB HID v1.11 Keyboard [Logitech MX Master 3] on usb-0000:02:00.0-2.4.4/input2:1
[    6.923452] 8021q: adding VLAN 0 to HW filter on device enipmi
[    6.939812] pps pps0: new PPS source ptp2
[    6.939831] ixgbe 0000:18:00.0: registered PHC device on en10gbe
[    7.074853] 8021q: adding VLAN 0 to HW filter on device en10gbe
[    7.081461] 8021q: adding VLAN 0 to HW filter on device en1gbe
[   11.553525] ixgbe 0000:18:00.0 en10gbe: NIC Link is Up 10 Gbps, Flow Control: None
[   18.625154] PM: Image not found (code -22)
[   18.664436] EXT4-fs (dm-3): mounted filesystem 0140b8fa-fc6e-444b-ba96-4449f7320b34 ro with writeback data mode. Quota mode: none.
[   18.673821] ixgbe 0000:18:00.0: removed PHC on en10gbe
[   19.256219] systemd[1]: systemd 255~rc4-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)

--mv2j6utfjb65nsuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.7-ec9aedb2aa1a^-onecpu"

[    0.000000] microcode: updated early: 0x5003303 -> 0x5003604, date = 2023-03-17
[    0.000000] Linux version 6.6.0-andres-00003-g31255e072b2e (andres@awork3) (gcc (Debian 13.2.0-8) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231202) #71 SMP PREEMPT_DYNAMIC Tue Dec  5 21:51:53 PST 2023
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.6.0-andres-00003-g31255e072b2e root=/dev/mapper/awork3--sa--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=sm_on iommu=pt nvme.poll_queues=4 cgroup.memory=nokmem coredump_filter=511 log_buf_len=16M hugetlb_cma=48G quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000687fbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000687fc000-0x000000006a8fbfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006a8fc000-0x000000006aed7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006aed8000-0x000000006c0f9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006c0fa000-0x000000006fb33fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006fb34000-0x000000006fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x5bbb4018-0x5bbbc057] usable ==> usable
[    0.000000] e820: update [mem 0x5bbb4018-0x5bbbc057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb8f018-0x5bbb3e57] usable ==> usable
[    0.000000] e820: update [mem 0x5bb8f018-0x5bbb3e57] usable ==> usable
[    0.000000] e820: update [mem 0x5bb84018-0x5bb8e057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb84018-0x5bb8e057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb79018-0x5bb83057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb79018-0x5bb83057] usable ==> usable
[    0.000000] e820: update [mem 0x5bb44018-0x5bb78257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb44018-0x5bb78257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb0f018-0x5bb43257] usable ==> usable
[    0.000000] e820: update [mem 0x5bb0f018-0x5bb43257] usable ==> usable
[    0.000000] e820: update [mem 0x5baf3018-0x5bb0e857] usable ==> usable
[    0.000000] e820: update [mem 0x5baf3018-0x5bb0e857] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000005baf3017] usable
[    0.000000] reserve setup_data: [mem 0x000000005baf3018-0x000000005bb0e857] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb0e858-0x000000005bb0f017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb0f018-0x000000005bb43257] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb43258-0x000000005bb44017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb44018-0x000000005bb78257] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb78258-0x000000005bb79017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb79018-0x000000005bb83057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb83058-0x000000005bb84017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb84018-0x000000005bb8e057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb8e058-0x000000005bb8f017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bb8f018-0x000000005bbb3e57] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbb3e58-0x000000005bbb4017] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbb4018-0x000000005bbbc057] usable
[    0.000000] reserve setup_data: [mem 0x000000005bbbc058-0x00000000687fbfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000687fc000-0x000000006a8fbfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006a8fc000-0x000000006aed7fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000006aed8000-0x000000006c0f9fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000006c0fa000-0x000000006fb33fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006fb34000-0x000000006fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=0x6b8ab000 ACPI=0x6b8ab000 SMBIOS=0x6f5ca000 SMBIOS 3.0=0x6f5c9000 MEMATTR=0x64037018 ESRT=0x62ecae18 INITRD=0x5ef8ac98 
[    0.000000] efi: Remove mem50: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
[    0.000000] efi: Remove mem51: MMIO range=[0xfd000000-0xfe7fffff] (24MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfe7fffff] reserved
[    0.000000] efi: Not removing mem52: MMIO range=[0xfed20000-0xfed44fff] (148KB) from e820 map
[    0.000000] efi: Remove mem53: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.2.1 present.
[    0.000000] DMI: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.8b 01/12/2023
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000017] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000020] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000032] last_pfn = 0x3040000 max_arch_pfn = 0x400000000
[    0.000036] MTRR map: 7 entries (2 fixed + 5 variable; max 22), built from 10 variable MTRRs
[    0.000039] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000279] e820: update [mem 0x70000000-0x73ffffff] usable ==> reserved
[    0.000282] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.000284] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000285] last_pfn = 0x70000 max_arch_pfn = 0x400000000
[    0.000293] esrt: Reserving ESRT space from 0x0000000062ecae18 to 0x0000000062ecae50.
[    0.000299] e820: update [mem 0x62eca000-0x62ecafff] usable ==> reserved
[    0.000321] Using GB pages for direct mapping
[    0.018262] printk: log_buf_len: 16777216 bytes
[    0.018264] printk: early log buf free: 255552(97%)
[    0.018265] Secure boot disabled
[    0.018266] RAMDISK: [mem 0x5bbbd000-0x5da34fff]
[    0.018272] ACPI: Early table checksum verification disabled
[    0.018276] ACPI: RSDP 0x000000006B8AB000 000024 (v02 ALASKA)
[    0.018280] ACPI: XSDT 0x000000006B8AB0D0 00011C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018286] ACPI: FACP 0x000000006BA478C8 000114 (v06 ALASKA A M I    01072009 INTL 20091013)
[    0.018291] ACPI: DSDT 0x000000006B8AB280 19C643 (v02 ALASKA A M I    01072009 INTL 20091013)
[    0.018294] ACPI: FACS 0x000000006C0B6080 000040
[    0.018297] ACPI: FPDT 0x000000006BA479E0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018300] ACPI: FIDT 0x000000006BA47A28 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018303] ACPI: SPMI 0x000000006BA47AC8 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.018305] ACPI: SSDT 0x000000006BA47B10 00046C (v02 INTEL  ADDRXLAT 00000001 INTL 20140828)
[    0.018308] ACPI: MCFG 0x000000006BA47F80 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.018311] ACPI: HPET 0x000000006BA47FC0 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018314] ACPI: APIC 0x000000006BA47FF8 000C5E (v03 ALASKA A M I    00000000 INTL 20091013)
[    0.018317] ACPI: MIGT 0x000000006BA48C58 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018320] ACPI: MSCT 0x000000006BA48C98 000064 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018323] ACPI: PCAT 0x000000006BA48D00 000088 (v02 ALASKA A M I    00000002 INTL 20091013)
[    0.018325] ACPI: PCCT 0x000000006BA48D88 00006E (v01 ALASKA A M I    00000002 INTL 20091013)
[    0.018328] ACPI: RASF 0x000000006BA48DF8 000030 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018331] ACPI: SLIT 0x000000006BA48E28 00012C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018333] ACPI: SRAT 0x000000006BA48F58 0016B0 (v03 ALASKA A M I    00000002 INTL 20091013)
[    0.018336] ACPI: SVOS 0x000000006BA4A608 000032 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018339] ACPI: WDDT 0x000000006BA4A640 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.018341] ACPI: OEM1 0x000000006BA4A680 015174 (v02 INTEL  CPU EIST 00003000 INTL 20140828)
[    0.018344] ACPI: OEM2 0x000000006BA5F7F8 017554 (v02 INTEL  CPU  HWP 00003000 INTL 20140828)
[    0.018347] ACPI: SSDT 0x000000006BA76D50 019D00 (v02 INTEL  SSDT  PM 00004000 INTL 20140828)
[    0.018350] ACPI: OEM3 0x000000006BA90A50 013344 (v02 INTEL  CPU  TST 00003000 INTL 20140828)
[    0.018352] ACPI: SSDT 0x000000006BAA3D98 00065B (v02 ALASKA A M I    00000000 INTL 20091013)
[    0.018355] ACPI: VFCT 0x000000006BAA43F8 00E284 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.018358] ACPI: SPCR 0x000000006BAB2680 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000E)
[    0.018361] ACPI: SSDT 0x000000006BAB26D0 001B4E (v02 INTEL  SpsNm    00000002 INTL 20140828)
[    0.018363] ACPI: DMAR 0x000000006BAB4220 0002F0 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.018366] ACPI: HEST 0x000000006BAB4510 0000A8 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018369] ACPI: BERT 0x000000006BAB45B8 000030 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018371] ACPI: ERST 0x000000006BAB45E8 000230 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018374] ACPI: EINJ 0x000000006BAB4818 000150 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.018377] ACPI: WSMT 0x000000006BAB4968 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018379] ACPI: Reserving FACP table memory at [mem 0x6ba478c8-0x6ba479db]
[    0.018381] ACPI: Reserving DSDT table memory at [mem 0x6b8ab280-0x6ba478c2]
[    0.018382] ACPI: Reserving FACS table memory at [mem 0x6c0b6080-0x6c0b60bf]
[    0.018383] ACPI: Reserving FPDT table memory at [mem 0x6ba479e0-0x6ba47a23]
[    0.018384] ACPI: Reserving FIDT table memory at [mem 0x6ba47a28-0x6ba47ac3]
[    0.018385] ACPI: Reserving SPMI table memory at [mem 0x6ba47ac8-0x6ba47b08]
[    0.018385] ACPI: Reserving SSDT table memory at [mem 0x6ba47b10-0x6ba47f7b]
[    0.018386] ACPI: Reserving MCFG table memory at [mem 0x6ba47f80-0x6ba47fbb]
[    0.018387] ACPI: Reserving HPET table memory at [mem 0x6ba47fc0-0x6ba47ff7]
[    0.018388] ACPI: Reserving APIC table memory at [mem 0x6ba47ff8-0x6ba48c55]
[    0.018389] ACPI: Reserving MIGT table memory at [mem 0x6ba48c58-0x6ba48c97]
[    0.018390] ACPI: Reserving MSCT table memory at [mem 0x6ba48c98-0x6ba48cfb]
[    0.018391] ACPI: Reserving PCAT table memory at [mem 0x6ba48d00-0x6ba48d87]
[    0.018392] ACPI: Reserving PCCT table memory at [mem 0x6ba48d88-0x6ba48df5]
[    0.018393] ACPI: Reserving RASF table memory at [mem 0x6ba48df8-0x6ba48e27]
[    0.018394] ACPI: Reserving SLIT table memory at [mem 0x6ba48e28-0x6ba48f53]
[    0.018395] ACPI: Reserving SRAT table memory at [mem 0x6ba48f58-0x6ba4a607]
[    0.018396] ACPI: Reserving SVOS table memory at [mem 0x6ba4a608-0x6ba4a639]
[    0.018397] ACPI: Reserving WDDT table memory at [mem 0x6ba4a640-0x6ba4a67f]
[    0.018398] ACPI: Reserving OEM1 table memory at [mem 0x6ba4a680-0x6ba5f7f3]
[    0.018399] ACPI: Reserving OEM2 table memory at [mem 0x6ba5f7f8-0x6ba76d4b]
[    0.018400] ACPI: Reserving SSDT table memory at [mem 0x6ba76d50-0x6ba90a4f]
[    0.018401] ACPI: Reserving OEM3 table memory at [mem 0x6ba90a50-0x6baa3d93]
[    0.018402] ACPI: Reserving SSDT table memory at [mem 0x6baa3d98-0x6baa43f2]
[    0.018403] ACPI: Reserving VFCT table memory at [mem 0x6baa43f8-0x6bab267b]
[    0.018404] ACPI: Reserving SPCR table memory at [mem 0x6bab2680-0x6bab26cf]
[    0.018405] ACPI: Reserving SSDT table memory at [mem 0x6bab26d0-0x6bab421d]
[    0.018406] ACPI: Reserving DMAR table memory at [mem 0x6bab4220-0x6bab450f]
[    0.018407] ACPI: Reserving HEST table memory at [mem 0x6bab4510-0x6bab45b7]
[    0.018408] ACPI: Reserving BERT table memory at [mem 0x6bab45b8-0x6bab45e7]
[    0.018409] ACPI: Reserving ERST table memory at [mem 0x6bab45e8-0x6bab4817]
[    0.018409] ACPI: Reserving EINJ table memory at [mem 0x6bab4818-0x6bab4967]
[    0.018410] ACPI: Reserving WSMT table memory at [mem 0x6bab4968-0x6bab498f]
[    0.018480] APIC: Switched APIC routing to: cluster x2apic
[    0.018503] SRAT: PXM 0 -> APIC 0x0000 -> Node 0
[    0.018504] SRAT: PXM 0 -> APIC 0x0002 -> Node 0
[    0.018505] SRAT: PXM 0 -> APIC 0x0004 -> Node 0
[    0.018506] SRAT: PXM 0 -> APIC 0x0006 -> Node 0
[    0.018506] SRAT: PXM 0 -> APIC 0x0008 -> Node 0
[    0.018507] SRAT: PXM 0 -> APIC 0x0010 -> Node 0
[    0.018508] SRAT: PXM 0 -> APIC 0x0012 -> Node 0
[    0.018509] SRAT: PXM 0 -> APIC 0x0014 -> Node 0
[    0.018510] SRAT: PXM 0 -> APIC 0x0016 -> Node 0
[    0.018510] SRAT: PXM 0 -> APIC 0x0018 -> Node 0
[    0.018511] SRAT: PXM 1 -> APIC 0x0020 -> Node 1
[    0.018512] SRAT: PXM 1 -> APIC 0x0022 -> Node 1
[    0.018513] SRAT: PXM 1 -> APIC 0x0024 -> Node 1
[    0.018513] SRAT: PXM 1 -> APIC 0x0026 -> Node 1
[    0.018514] SRAT: PXM 1 -> APIC 0x0028 -> Node 1
[    0.018515] SRAT: PXM 1 -> APIC 0x0030 -> Node 1
[    0.018516] SRAT: PXM 1 -> APIC 0x0032 -> Node 1
[    0.018517] SRAT: PXM 1 -> APIC 0x0034 -> Node 1
[    0.018518] SRAT: PXM 1 -> APIC 0x0036 -> Node 1
[    0.018518] SRAT: PXM 1 -> APIC 0x0038 -> Node 1
[    0.018519] SRAT: PXM 0 -> APIC 0x0001 -> Node 0
[    0.018520] SRAT: PXM 0 -> APIC 0x0003 -> Node 0
[    0.018521] SRAT: PXM 0 -> APIC 0x0005 -> Node 0
[    0.018521] SRAT: PXM 0 -> APIC 0x0007 -> Node 0
[    0.018522] SRAT: PXM 0 -> APIC 0x0009 -> Node 0
[    0.018523] SRAT: PXM 0 -> APIC 0x0011 -> Node 0
[    0.018523] SRAT: PXM 0 -> APIC 0x0013 -> Node 0
[    0.018524] SRAT: PXM 0 -> APIC 0x0015 -> Node 0
[    0.018525] SRAT: PXM 0 -> APIC 0x0017 -> Node 0
[    0.018526] SRAT: PXM 0 -> APIC 0x0019 -> Node 0
[    0.018527] SRAT: PXM 1 -> APIC 0x0021 -> Node 1
[    0.018528] SRAT: PXM 1 -> APIC 0x0023 -> Node 1
[    0.018528] SRAT: PXM 1 -> APIC 0x0025 -> Node 1
[    0.018529] SRAT: PXM 1 -> APIC 0x0027 -> Node 1
[    0.018530] SRAT: PXM 1 -> APIC 0x0029 -> Node 1
[    0.018531] SRAT: PXM 1 -> APIC 0x0031 -> Node 1
[    0.018532] SRAT: PXM 1 -> APIC 0x0033 -> Node 1
[    0.018532] SRAT: PXM 1 -> APIC 0x0035 -> Node 1
[    0.018533] SRAT: PXM 1 -> APIC 0x0037 -> Node 1
[    0.018534] SRAT: PXM 1 -> APIC 0x0039 -> Node 1
[    0.018538] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.018540] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x183fffffff]
[    0.018542] ACPI: SRAT: Node 1 PXM 1 [mem 0x1840000000-0x303fffffff]
[    0.018548] NUMA: Initialized distance table, cnt=2
[    0.018552] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x183fffffff] -> [mem 0x00000000-0x183fffffff]
[    0.018563] NODE_DATA(0) allocated [mem 0x183ffde000-0x183fffffff]
[    0.018578] NODE_DATA(1) allocated [mem 0x303b7db000-0x303b7fcfff]
[    0.018726] hugetlb_cma: reserve 49152 MiB, up to 24576 MiB per node
[    0.018729] cma: Reserved 24576 MiB at 0x0000000100000000 on node 0
[    0.018731] hugetlb_cma: reserved 24576 MiB on node 0
[    0.018733] cma: Reserved 24576 MiB at 0x0000001840000000 on node 1
[    0.018734] hugetlb_cma: reserved 24576 MiB on node 1
[    0.018882] Zone ranges:
[    0.018883]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018885]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018886]   Normal   [mem 0x0000000100000000-0x000000303fffffff]
[    0.018888] Movable zone start for each node
[    0.018890] Early memory node ranges
[    0.018891]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.018892]   node   0: [mem 0x0000000000100000-0x00000000687fbfff]
[    0.018894]   node   0: [mem 0x000000006fb34000-0x000000006fffffff]
[    0.018895]   node   0: [mem 0x0000000100000000-0x000000183fffffff]
[    0.018904]   node   1: [mem 0x0000001840000000-0x000000303fffffff]
[    0.018913] Initmem setup node 0 [mem 0x0000000000001000-0x000000183fffffff]
[    0.018916] Initmem setup node 1 [mem 0x0000001840000000-0x000000303fffffff]
[    0.018918] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018945] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.022070] On node 0, zone DMA32: 29496 pages in unavailable ranges
[    0.022872] ACPI: PM-Timer IO Port: 0x508
[    0.022888] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.022891] ACPI: LAPIC_NMI (acpi_id[0xff] dfl edge lint[0x1])
[    0.022909] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.022914] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.022919] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.022923] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.022927] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.022932] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 72-79
[    0.022937] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 80-87
[    0.022941] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 88-95
[    0.022946] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 96-103
[    0.022950] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.022952] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.022960] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.022961] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.022966] ACPI: SPCR: console: uart,io,0x2f8,115200
[    0.022967] TSC deadline timer available
[    0.022968] smpboot: Allowing 40 CPUs, 0 hotplug CPUs
[    0.022986] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.022989] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.022991] PM: hibernation: Registered nosave memory: [mem 0x5baf3000-0x5baf3fff]
[    0.022993] PM: hibernation: Registered nosave memory: [mem 0x5bb0e000-0x5bb0efff]
[    0.022994] PM: hibernation: Registered nosave memory: [mem 0x5bb0f000-0x5bb0ffff]
[    0.022996] PM: hibernation: Registered nosave memory: [mem 0x5bb43000-0x5bb43fff]
[    0.022997] PM: hibernation: Registered nosave memory: [mem 0x5bb44000-0x5bb44fff]
[    0.022999] PM: hibernation: Registered nosave memory: [mem 0x5bb78000-0x5bb78fff]
[    0.023000] PM: hibernation: Registered nosave memory: [mem 0x5bb79000-0x5bb79fff]
[    0.023002] PM: hibernation: Registered nosave memory: [mem 0x5bb83000-0x5bb83fff]
[    0.023003] PM: hibernation: Registered nosave memory: [mem 0x5bb84000-0x5bb84fff]
[    0.023005] PM: hibernation: Registered nosave memory: [mem 0x5bb8e000-0x5bb8efff]
[    0.023006] PM: hibernation: Registered nosave memory: [mem 0x5bb8f000-0x5bb8ffff]
[    0.023009] PM: hibernation: Registered nosave memory: [mem 0x5bbb3000-0x5bbb3fff]
[    0.023010] PM: hibernation: Registered nosave memory: [mem 0x5bbb4000-0x5bbb4fff]
[    0.023012] PM: hibernation: Registered nosave memory: [mem 0x5bbbc000-0x5bbbcfff]
[    0.023013] PM: hibernation: Registered nosave memory: [mem 0x62eca000-0x62ecafff]
[    0.023016] PM: hibernation: Registered nosave memory: [mem 0x687fc000-0x6a8fbfff]
[    0.023016] PM: hibernation: Registered nosave memory: [mem 0x6a8fc000-0x6aed7fff]
[    0.023017] PM: hibernation: Registered nosave memory: [mem 0x6aed8000-0x6c0f9fff]
[    0.023018] PM: hibernation: Registered nosave memory: [mem 0x6c0fa000-0x6fb33fff]
[    0.023020] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x7fffffff]
[    0.023021] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xfed1ffff]
[    0.023022] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed44fff]
[    0.023022] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xffffffff]
[    0.023024] [mem 0x80000000-0xfed1ffff] available for PCI devices
[    0.023027] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.034649] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:40 nr_cpu_ids:40 nr_node_ids:2
[    0.037016] percpu: Embedded 56 pages/cpu s189800 r8192 d31384 u262144
[    0.037026] pcpu-alloc: s189800 r8192 d31384 u262144 alloc=1*2097152
[    0.037029] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 20 21 22 23 24 25 
[    0.037038] pcpu-alloc: [0] 26 27 28 29 -- -- -- -- [1] 10 11 12 13 14 15 16 17 
[    0.037046] pcpu-alloc: [1] 18 19 30 31 32 33 34 35 [1] 36 37 38 39 -- -- -- -- 
[    0.037084] Kernel command line: BOOT_IMAGE=/vmlinuz-6.6.0-andres-00003-g31255e072b2e root=/dev/mapper/awork3--sa--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=sm_on iommu=pt nvme.poll_queues=4 cgroup.memory=nokmem coredump_filter=511 log_buf_len=16M hugetlb_cma=48G quiet
[    0.037164] DMAR: Enable scalable mode if hardware supports
[    0.037226] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.6.0-andres-00003-g31255e072b2e apparmor=0", will be passed to user space.
[    0.037249] random: crng init done
[    0.037615] Fallback order for Node 0: 0 1 
[    0.037619] Fallback order for Node 1: 1 0 
[    0.037623] Built 2 zonelists, mobility grouping on.  Total pages: 49193364
[    0.037625] Policy zone: Normal
[    0.037626] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.037641] software IO TLB: area num 64.
[    0.249377] Memory: 1640300K/199897500K available (26624K kernel code, 4315K rwdata, 22836K rodata, 2812K init, 3272K bss, 3416316K reserved, 50331648K cma-reserved)
[    0.250052] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=40, Nodes=2
[    0.250090] ftrace: allocating 78581 entries in 307 pages
[    0.265617] ftrace: allocated 307 pages with 5 groups
[    0.266887] Dynamic Preempt: voluntary
[    0.267130] rcu: Preemptible hierarchical RCU implementation.
[    0.267131] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=40.
[    0.267133] 	Trampoline variant of Tasks RCU enabled.
[    0.267134] 	Rude variant of Tasks RCU enabled.
[    0.267134] 	Tracing variant of Tasks RCU enabled.
[    0.267135] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.267136] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=40
[    0.271270] NR_IRQS: 524544, nr_irqs: 2104, preallocated irqs: 16
[    0.271580] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.271771] Console: colour dummy device 80x25
[    0.271773] printk: console [tty0] enabled
[    0.271827] printk: console [ttyS1] enabled
[    0.271958] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.271962] ACPI: Core revision 20230628
[    0.273803] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.273849] APIC: Switch to symmetric I/O mode setup
[    0.273851] DMAR: Host address width 46
[    0.273852] DMAR: DRHD base: 0x000000d37fc000 flags: 0x0
[    0.273859] DMAR: dmar0: reg_base_addr d37fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273862] DMAR: DRHD base: 0x000000e0ffc000 flags: 0x0
[    0.273867] DMAR: dmar1: reg_base_addr e0ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273870] DMAR: DRHD base: 0x000000ee7fc000 flags: 0x0
[    0.273875] DMAR: dmar2: reg_base_addr ee7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273877] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.273882] DMAR: dmar3: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273884] DMAR: DRHD base: 0x000000aaffc000 flags: 0x0
[    0.273887] DMAR: dmar4: reg_base_addr aaffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273889] DMAR: DRHD base: 0x000000b87fc000 flags: 0x0
[    0.273892] DMAR: dmar5: reg_base_addr b87fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273894] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
[    0.273897] DMAR: dmar6: reg_base_addr c5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273899] DMAR: DRHD base: 0x0000009d7fc000 flags: 0x1
[    0.273904] DMAR: dmar7: reg_base_addr 9d7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.273906] DMAR: RMRR base: 0x0000006f605000 end: 0x0000006f615fff
[    0.273908] DMAR: ATSR flags: 0x0
[    0.273909] DMAR: ATSR flags: 0x0
[    0.273910] DMAR: RHSA base: 0x0000009d7fc000 proximity domain: 0x0
[    0.273912] DMAR: RHSA base: 0x000000aaffc000 proximity domain: 0x0
[    0.273913] DMAR: RHSA base: 0x000000b87fc000 proximity domain: 0x0
[    0.273914] DMAR: RHSA base: 0x000000c5ffc000 proximity domain: 0x0
[    0.273915] DMAR: RHSA base: 0x000000d37fc000 proximity domain: 0x1
[    0.273916] DMAR: RHSA base: 0x000000e0ffc000 proximity domain: 0x1
[    0.273917] DMAR: RHSA base: 0x000000ee7fc000 proximity domain: 0x1
[    0.273918] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x1
[    0.273921] DMAR-IR: IOAPIC id 12 under DRHD base  0xc5ffc000 IOMMU 6
[    0.273923] DMAR-IR: IOAPIC id 11 under DRHD base  0xb87fc000 IOMMU 5
[    0.273924] DMAR-IR: IOAPIC id 10 under DRHD base  0xaaffc000 IOMMU 4
[    0.273925] DMAR-IR: IOAPIC id 18 under DRHD base  0xfbffc000 IOMMU 3
[    0.273926] DMAR-IR: IOAPIC id 17 under DRHD base  0xee7fc000 IOMMU 2
[    0.273928] DMAR-IR: IOAPIC id 16 under DRHD base  0xe0ffc000 IOMMU 1
[    0.273929] DMAR-IR: IOAPIC id 15 under DRHD base  0xd37fc000 IOMMU 0
[    0.273930] DMAR-IR: IOAPIC id 8 under DRHD base  0x9d7fc000 IOMMU 7
[    0.273932] DMAR-IR: IOAPIC id 9 under DRHD base  0x9d7fc000 IOMMU 7
[    0.273933] DMAR-IR: HPET id 0 under DRHD base 0x9d7fc000
[    0.273934] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.276118] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.277473] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.281832] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
[    0.281838] Calibrating delay loop (skipped), value calculated using timer frequency.. 5000.00 BogoMIPS (lpj=2500000)
[    0.281865] CPU0: Thermal monitoring enabled (TM1)
[    0.282019] process: using mwait in idle threads
[    0.282022] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.282024] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.282029] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.282032] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.282837] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.282838] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.282839] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.282840] RETBleed: Mitigation: Enhanced IBRS
[    0.282841] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.282844] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.282851] TAA: Mitigation: TSX disabled
[    0.282851] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.282861] GDS: Mitigation: Microcode
[    0.282867] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.282869] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.282870] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.282871] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.282872] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.282873] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.282874] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.282875] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.282875] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.282877] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.282878] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.282880] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.282881] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.282882] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.282883] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.282884] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.282885] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.294362] Freeing SMP alternatives memory: 60K
[    0.294364] pid_max: default: 40960 minimum: 320
[    0.295959] LSM: initializing lsm=capability,integrity
[    0.328034] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc hugepage)
[    0.343957] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc hugepage)
[    0.344527] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    0.345063] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    0.345921] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
[    0.346123] RCU Tasks: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1.
[    0.346143] RCU Tasks Rude: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1.
[    0.346169] RCU Tasks Trace: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1.
[    0.346189] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.346220] ... version:                4
[    0.346221] ... bit width:              48
[    0.346222] ... generic registers:      4
[    0.346223] ... value mask:             0000ffffffffffff
[    0.346225] ... max period:             00007fffffffffff
[    0.346226] ... fixed-purpose events:   3
[    0.346227] ... event mask:             000000070000000f
[    0.346356] signal: max sigframe size: 3632
[    0.346372] Estimated ratio of average max frequency by base frequency (times 1024): 1310
[    0.346404] rcu: Hierarchical SRCU implementation.
[    0.346405] rcu: 	Max phase no-delay instances is 400.
[    0.347116] smp: Bringing up secondary CPUs ...
[    0.347228] smpboot: x86: Booting SMP configuration:
[    0.347229] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9
[    0.349082] .... node  #1, CPUs:   #10 #11 #12 #13 #14 #15 #16 #17 #18 #19
[    0.003190] smpboot: CPU 10 Converting physical 0 to logical die 1

[    0.361053] .... node  #0, CPUs:   #20 #21 #22 #23 #24 #25 #26 #27 #28 #29
[    0.363990] .... node  #1, CPUs:   #30 #31 #32 #33 #34 #35 #36 #37 #38 #39
[    0.365842] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.370886] smp: Brought up 2 nodes, 40 CPUs
[    0.370891] smpboot: Max logical packages: 2
[    0.370896] smpboot: Total of 40 processors activated (200000.00 BogoMIPS)
[    0.403905] node 0 deferred pages initialised in 32ms
[    0.408865] node 1 deferred pages initialised in 37ms
[    0.416879] devtmpfs: initialized
[    0.416886] x86/mm: Memory block size: 2048MB
[    0.421644] ACPI: PM: Registering ACPI NVS region [mem 0x6aed8000-0x6c0f9fff] (19013632 bytes)
[    0.421990] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.422018] futex hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
[    0.610202] pinctrl core: initialized pinctrl subsystem
[    0.611176] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.611400] audit: initializing netlink subsys (disabled)
[    0.611407] audit: type=2000 audit(1701842058.337:1): state=initialized audit_enabled=0 res=1
[    0.611407] thermal_sys: Registered thermal governor 'fair_share'
[    0.611407] thermal_sys: Registered thermal governor 'bang_bang'
[    0.611407] thermal_sys: Registered thermal governor 'step_wise'
[    0.611407] thermal_sys: Registered thermal governor 'user_space'
[    0.611407] thermal_sys: Registered thermal governor 'power_allocator'
[    0.611407] cpuidle: using governor ladder
[    0.611407] cpuidle: using governor menu
[    0.611407] Detected 1 PCC Subspaces
[    0.611407] Registering PCC driver as Mailbox controller
[    0.611895] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.611898] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.612059] dca service started, version 1.12.1
[    0.612070] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.612074] PCI: not using MMCONFIG
[    0.612075] PCI: Using configuration type 1 for base access
[    0.612839] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.613969] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.613979] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.613979] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.613979] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.613979] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.613979] cryptd: max_cpu_qlen set to 1000
[    0.614921] raid6: skipped pq benchmark and selected avx512x4
[    0.614921] raid6: using avx512x2 recovery algorithm
[    0.614983] ACPI: Added _OSI(Module Device)
[    0.614984] ACPI: Added _OSI(Processor Device)
[    0.614986] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.614987] ACPI: Added _OSI(Processor Aggregator Device)
[    0.664260] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.667331] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.680266] ACPI: _OSC evaluated successfully for all CPUs
[    0.680768] ACPI: Interpreter enabled
[    0.680787] ACPI: PM: (supports S0 S4 S5)
[    0.680789] ACPI: Using IOAPIC for interrupt routing
[    0.680812] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.687536] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[    0.687539] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
[    0.687579] HEST: Table parsing has been initialized.
[    0.687845] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    0.687848] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.687850] PCI: Ignoring E820 reservations for host bridge windows
[    0.691797] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.715228] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 40/0x7f00 ignored.
[    0.715231] ACPI: Unable to map lapic to logical cpu number
[    0.715460] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 41/0x7f02 ignored.
[    0.715462] ACPI: Unable to map lapic to logical cpu number
[    0.715683] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 42/0x7f04 ignored.
[    0.715685] ACPI: Unable to map lapic to logical cpu number
[    0.715914] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 43/0x7f06 ignored.
[    0.715916] ACPI: Unable to map lapic to logical cpu number
[    0.716136] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 44/0x7f08 ignored.
[    0.716138] ACPI: Unable to map lapic to logical cpu number
[    0.716357] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 45/0x7f10 ignored.
[    0.716358] ACPI: Unable to map lapic to logical cpu number
[    0.716577] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 46/0x7f12 ignored.
[    0.716579] ACPI: Unable to map lapic to logical cpu number
[    0.716798] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 47/0x7f14 ignored.
[    0.716800] ACPI: Unable to map lapic to logical cpu number
[    0.717026] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 48/0x7f16 ignored.
[    0.717028] ACPI: Unable to map lapic to logical cpu number
[    0.717246] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 49/0x7f18 ignored.
[    0.717248] ACPI: Unable to map lapic to logical cpu number
[    0.717467] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 50/0x7f01 ignored.
[    0.717468] ACPI: Unable to map lapic to logical cpu number
[    0.717686] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 51/0x7f03 ignored.
[    0.717687] ACPI: Unable to map lapic to logical cpu number
[    0.717911] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 52/0x7f05 ignored.
[    0.717913] ACPI: Unable to map lapic to logical cpu number
[    0.718131] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 53/0x7f07 ignored.
[    0.718133] ACPI: Unable to map lapic to logical cpu number
[    0.718351] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 54/0x7f09 ignored.
[    0.718353] ACPI: Unable to map lapic to logical cpu number
[    0.718570] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 55/0x7f11 ignored.
[    0.718572] ACPI: Unable to map lapic to logical cpu number
[    0.718790] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 56/0x7f13 ignored.
[    0.718791] ACPI: Unable to map lapic to logical cpu number
[    0.719014] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 57/0x7f15 ignored.
[    0.719016] ACPI: Unable to map lapic to logical cpu number
[    0.719234] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 58/0x7f17 ignored.
[    0.719235] ACPI: Unable to map lapic to logical cpu number
[    0.719453] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 59/0x7f19 ignored.
[    0.719454] ACPI: Unable to map lapic to logical cpu number
[    0.720433] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 60/0x7f20 ignored.
[    0.720434] ACPI: Unable to map lapic to logical cpu number
[    0.720653] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 61/0x7f22 ignored.
[    0.720654] ACPI: Unable to map lapic to logical cpu number
[    0.720879] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 62/0x7f24 ignored.
[    0.720880] ACPI: Unable to map lapic to logical cpu number
[    0.721100] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 63/0x7f26 ignored.
[    0.721101] ACPI: Unable to map lapic to logical cpu number
[    0.721320] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 64/0x7f28 ignored.
[    0.721321] ACPI: Unable to map lapic to logical cpu number
[    0.721540] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 65/0x7f30 ignored.
[    0.721541] ACPI: Unable to map lapic to logical cpu number
[    0.721760] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 66/0x7f32 ignored.
[    0.721761] ACPI: Unable to map lapic to logical cpu number
[    0.721985] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 67/0x7f34 ignored.
[    0.721986] ACPI: Unable to map lapic to logical cpu number
[    0.722205] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 68/0x7f36 ignored.
[    0.722206] ACPI: Unable to map lapic to logical cpu number
[    0.722424] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 69/0x7f38 ignored.
[    0.722425] ACPI: Unable to map lapic to logical cpu number
[    0.722643] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 70/0x7f21 ignored.
[    0.722644] ACPI: Unable to map lapic to logical cpu number
[    0.722867] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 71/0x7f23 ignored.
[    0.722868] ACPI: Unable to map lapic to logical cpu number
[    0.723087] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 72/0x7f25 ignored.
[    0.723089] ACPI: Unable to map lapic to logical cpu number
[    0.723306] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 73/0x7f27 ignored.
[    0.723307] ACPI: Unable to map lapic to logical cpu number
[    0.723525] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 74/0x7f29 ignored.
[    0.723526] ACPI: Unable to map lapic to logical cpu number
[    0.723744] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 75/0x7f31 ignored.
[    0.723746] ACPI: Unable to map lapic to logical cpu number
[    0.723968] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 76/0x7f33 ignored.
[    0.723970] ACPI: Unable to map lapic to logical cpu number
[    0.724188] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 77/0x7f35 ignored.
[    0.724189] ACPI: Unable to map lapic to logical cpu number
[    0.724406] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 78/0x7f37 ignored.
[    0.724408] ACPI: Unable to map lapic to logical cpu number
[    0.724626] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 79/0x7f39 ignored.
[    0.724628] ACPI: Unable to map lapic to logical cpu number
[    0.725475] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    0.725481] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.725536] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]
[    0.725628] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.725630] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.726279] PCI host bridge to bus 0000:00
[    0.726281] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.726283] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.726285] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    0.726286] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    0.726288] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    0.726289] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.726291] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.726292] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    0.726294] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7fffff window]
[    0.726295] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383fffffffff window]
[    0.726297] pci_bus 0000:00: root bus resource [bus 00-16]
[    0.726322] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    0.726488] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    0.726507] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff40000-0x383ffff43fff 64bit]
[    0.726619] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    0.726638] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff3c000-0x383ffff3ffff 64bit]
[    0.726742] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    0.726761] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff38000-0x383ffff3bfff 64bit]
[    0.726866] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    0.726885] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff34000-0x383ffff37fff 64bit]
[    0.726988] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    0.727007] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff30000-0x383ffff33fff 64bit]
[    0.727108] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    0.727127] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff2c000-0x383ffff2ffff 64bit]
[    0.727231] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    0.727250] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff28000-0x383ffff2bfff 64bit]
[    0.727351] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    0.727370] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff24000-0x383ffff27fff 64bit]
[    0.727470] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    0.727573] pci 0000:00:05.1: [8086:2022] type 00 class 0x088000
[    0.727698] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    0.727794] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    0.727812] pci 0000:00:05.4: reg 0x10: [mem 0x9d30a000-0x9d30afff]
[    0.727929] pci 0000:00:05.6: [8086:2027] type 00 class 0x110100
[    0.728025] pci 0000:00:07.0: [8086:2028] type 00 class 0x088000
[    0.728122] pci 0000:00:07.4: [8086:202c] type 00 class 0x088000
[    0.728217] pci 0000:00:07.7: [8086:202d] type 00 class 0x088000
[    0.728313] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    0.728408] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    0.728479] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    0.728576] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    0.728675] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    0.728698] pci 0000:00:11.5: reg 0x10: [mem 0x9d306000-0x9d307fff]
[    0.728712] pci 0000:00:11.5: reg 0x14: [mem 0x9d309000-0x9d3090ff]
[    0.728727] pci 0000:00:11.5: reg 0x18: [io  0x3070-0x3077]
[    0.728741] pci 0000:00:11.5: reg 0x1c: [io  0x3060-0x3063]
[    0.728755] pci 0000:00:11.5: reg 0x20: [io  0x3020-0x303f]
[    0.728770] pci 0000:00:11.5: reg 0x24: [mem 0x9d280000-0x9d2fffff]
[    0.728812] pci 0000:00:11.5: PME# supported from D3hot
[    0.729025] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    0.729057] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff10000-0x383ffff1ffff 64bit]
[    0.729152] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.729354] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    0.729385] pci 0000:00:14.2: reg 0x10: [mem 0x383ffff47000-0x383ffff47fff 64bit]
[    0.729545] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    0.729581] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff46000-0x383ffff46fff 64bit]
[    0.729696] pci 0000:00:16.0: PME# supported from D3hot
[    0.729767] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
[    0.729804] pci 0000:00:16.1: reg 0x10: [mem 0x383ffff45000-0x383ffff45fff 64bit]
[    0.729920] pci 0000:00:16.1: PME# supported from D3hot
[    0.729993] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    0.730030] pci 0000:00:16.4: reg 0x10: [mem 0x383ffff44000-0x383ffff44fff 64bit]
[    0.730145] pci 0000:00:16.4: PME# supported from D3hot
[    0.730216] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    0.730239] pci 0000:00:17.0: reg 0x10: [mem 0x9d304000-0x9d305fff]
[    0.730253] pci 0000:00:17.0: reg 0x14: [mem 0x9d308000-0x9d3080ff]
[    0.730268] pci 0000:00:17.0: reg 0x18: [io  0x3050-0x3057]
[    0.730282] pci 0000:00:17.0: reg 0x1c: [io  0x3040-0x3043]
[    0.730296] pci 0000:00:17.0: reg 0x20: [io  0x3000-0x301f]
[    0.730310] pci 0000:00:17.0: reg 0x24: [mem 0x9d200000-0x9d27ffff]
[    0.730352] pci 0000:00:17.0: PME# supported from D3hot
[    0.730542] pci 0000:00:1c.0: [8086:a190] type 01 class 0x060400
[    0.730634] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.731003] pci 0000:00:1c.2: [8086:a192] type 01 class 0x060400
[    0.731102] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.731469] pci 0000:00:1c.5: [8086:a195] type 01 class 0x060400
[    0.731567] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.731938] pci 0000:00:1f.0: [8086:a1c1] type 00 class 0x060100
[    0.732219] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    0.732239] pci 0000:00:1f.2: reg 0x10: [mem 0x9d300000-0x9d303fff]
[    0.732451] pci 0000:00:1f.3: [8086:a1f0] type 00 class 0x040300
[    0.732481] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff20000-0x383ffff23fff 64bit]
[    0.732520] pci 0000:00:1f.3: reg 0x20: [mem 0x383ffff00000-0x383ffff0ffff 64bit]
[    0.732583] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.732835] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    0.732872] pci 0000:00:1f.4: reg 0x10: [mem 0x9d7fb000-0x9d7fb0ff 64bit]
[    0.732913] pci 0000:00:1f.4: reg 0x20: [io  0x3fe0-0x3fff]
[    0.733003] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    0.733029] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.733201] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.733267] pci 0000:02:00.0: [1b21:2142] type 00 class 0x0c0330
[    0.733303] pci 0000:02:00.0: reg 0x10: [mem 0x9d100000-0x9d107fff 64bit]
[    0.733386] pci 0000:02:00.0: enabling Extended Tags
[    0.733452] pci 0000:02:00.0: PME# supported from D0
[    0.733582] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.733587] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    0.733647] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
[    0.733727] pci 0000:03:00.0: enabling Extended Tags
[    0.733791] pci 0000:03:00.0: supports D1 D2
[    0.733792] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.733901] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    0.733904] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.733907] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    0.733946] pci_bus 0000:04: extended config space not accessible
[    0.733972] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
[    0.734003] pci 0000:04:00.0: reg 0x10: [mem 0x9c000000-0x9cffffff]
[    0.734022] pci 0000:04:00.0: reg 0x14: [mem 0x9d000000-0x9d01ffff]
[    0.734040] pci 0000:04:00.0: reg 0x18: [io  0x2000-0x207f]
[    0.734125] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.734163] pci 0000:04:00.0: supports D1 D2
[    0.734164] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.734268] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.734274] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    0.734277] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    0.734319] pci_bus 0000:00: on NUMA node 0
[    0.734907] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    0.734912] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.735178] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]
[    0.735385] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.735387] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.735551] PCI host bridge to bus 0000:17
[    0.735553] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    0.735555] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaaffffff window]
[    0.735557] pci_bus 0000:17: root bus resource [mem 0x384000000000-0x387fffffffff window]
[    0.735558] pci_bus 0000:17: root bus resource [bus 17-39]
[    0.735577] pci 0000:17:00.0: [8086:2030] type 01 class 0x060400
[    0.735626] pci 0000:17:00.0: enabling Extended Tags
[    0.735661] pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
[    0.735815] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    0.735916] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    0.736011] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    0.736029] pci 0000:17:05.4: reg 0x10: [mem 0xaaf00000-0xaaf00fff]
[    0.736141] pci 0000:17:05.6: [8086:2037] type 00 class 0x110100
[    0.736236] pci 0000:17:07.0: [8086:2038] type 00 class 0x088000
[    0.736330] pci 0000:17:07.1: [8086:2039] type 00 class 0x088000
[    0.736422] pci 0000:17:07.2: [8086:203a] type 00 class 0x088000
[    0.736514] pci 0000:17:07.3: [8086:203b] type 00 class 0x088000
[    0.736606] pci 0000:17:07.4: [8086:203c] type 00 class 0x088000
[    0.736699] pci 0000:17:07.7: [8086:203d] type 00 class 0x088000
[    0.736790] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    0.736875] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    0.736942] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    0.737009] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    0.737075] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    0.737143] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    0.737210] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    0.737277] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    0.737344] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    0.737428] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    0.737495] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    0.737561] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    0.737628] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    0.737694] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    0.737761] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    0.737827] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    0.737897] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    0.737980] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    0.738055] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    0.738136] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    0.738202] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    0.738268] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    0.738335] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    0.738401] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    0.738469] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    0.738535] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    0.738603] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    0.738685] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    0.738751] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    0.738818] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    0.738885] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    0.738952] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    0.739018] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    0.739084] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    0.739151] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    0.739233] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    0.739308] pci 0000:17:14.0: [8086:208f] type 00 class 0x088000
[    0.739391] pci 0000:17:14.1: [8086:208f] type 00 class 0x088000
[    0.739458] pci 0000:17:14.2: [8086:208f] type 00 class 0x088000
[    0.739525] pci 0000:17:14.3: [8086:208f] type 00 class 0x088000
[    0.739592] pci 0000:17:14.4: [8086:208f] type 00 class 0x088000
[    0.739659] pci 0000:17:14.5: [8086:208f] type 00 class 0x088000
[    0.739726] pci 0000:17:14.6: [8086:208f] type 00 class 0x088000
[    0.739793] pci 0000:17:14.7: [8086:208f] type 00 class 0x088000
[    0.739862] pci 0000:17:15.0: [8086:208f] type 00 class 0x088000
[    0.739945] pci 0000:17:15.1: [8086:208f] type 00 class 0x088000
[    0.740013] pci 0000:17:15.2: [8086:208f] type 00 class 0x088000
[    0.740080] pci 0000:17:15.3: [8086:208f] type 00 class 0x088000
[    0.740146] pci 0000:17:15.4: [8086:208f] type 00 class 0x088000
[    0.740213] pci 0000:17:15.5: [8086:208f] type 00 class 0x088000
[    0.740280] pci 0000:17:15.6: [8086:208f] type 00 class 0x088000
[    0.740348] pci 0000:17:15.7: [8086:208f] type 00 class 0x088000
[    0.740415] pci 0000:17:16.0: [8086:208f] type 00 class 0x088000
[    0.740498] pci 0000:17:16.1: [8086:208f] type 00 class 0x088000
[    0.740576] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    0.740659] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    0.740727] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    0.740794] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    0.740867] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    0.740951] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    0.741020] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    0.741120] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    0.741188] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    0.741261] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    0.741328] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    0.741399] pci 0000:17:1f.0: [8086:2078] type 00 class 0x088000
[    0.741483] pci 0000:17:1f.1: [8086:2079] type 00 class 0x088000
[    0.741551] pci 0000:17:1f.2: [8086:207a] type 00 class 0x088000
[    0.741619] pci 0000:17:1f.3: [8086:207b] type 00 class 0x088000
[    0.741687] pci 0000:17:1f.4: [8086:207c] type 00 class 0x088000
[    0.741754] pci 0000:17:1f.5: [8086:207d] type 00 class 0x088000
[    0.741822] pci 0000:17:1f.6: [8086:207e] type 00 class 0x088000
[    0.741891] pci 0000:17:1f.7: [8086:207f] type 00 class 0x088000
[    0.742005] pci 0000:18:00.0: [8086:1528] type 00 class 0x020000
[    0.742034] pci 0000:18:00.0: reg 0x10: [mem 0xaa800000-0xaa9fffff 64bit pref]
[    0.742080] pci 0000:18:00.0: reg 0x20: [mem 0xaaa00000-0xaaa03fff 64bit pref]
[    0.742094] pci 0000:18:00.0: reg 0x30: [mem 0xaac00000-0xaac7ffff pref]
[    0.742153] pci 0000:18:00.0: PME# supported from D0 D3hot
[    0.742184] pci 0000:18:00.0: reg 0x184: [mem 0xaad80000-0xaad83fff 64bit]
[    0.742186] pci 0000:18:00.0: VF(n) BAR0 space: [mem 0xaad80000-0xaae7ffff 64bit] (contains BAR0 for 64 VFs)
[    0.742206] pci 0000:18:00.0: reg 0x190: [mem 0xaac80000-0xaac83fff 64bit]
[    0.742208] pci 0000:18:00.0: VF(n) BAR3 space: [mem 0xaac80000-0xaad7ffff 64bit] (contains BAR3 for 64 VFs)
[    0.742411] pci 0000:17:00.0: PCI bridge to [bus 18]
[    0.742415] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    0.742418] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    0.742433] pci_bus 0000:17: on NUMA node 0
[    0.742551] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    0.742555] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.742820] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]
[    0.743018] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.743020] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.743152] PCI host bridge to bus 0000:3a
[    0.743153] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    0.743155] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87fffff window]
[    0.743157] pci_bus 0000:3a: root bus resource [mem 0x388000000000-0x38bfffffffff window]
[    0.743159] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    0.743176] pci 0000:3a:00.0: [8086:2030] type 01 class 0x060400
[    0.743224] pci 0000:3a:00.0: enabling Extended Tags
[    0.743258] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    0.743414] pci 0000:3a:01.0: [8086:2031] type 01 class 0x060400
[    0.743461] pci 0000:3a:01.0: enabling Extended Tags
[    0.743494] pci 0000:3a:01.0: PME# supported from D0 D3hot D3cold
[    0.743592] pci 0000:3a:02.0: [8086:2032] type 01 class 0x060400
[    0.743639] pci 0000:3a:02.0: enabling Extended Tags
[    0.743671] pci 0000:3a:02.0: PME# supported from D0 D3hot D3cold
[    0.743766] pci 0000:3a:03.0: [8086:2033] type 01 class 0x060400
[    0.743813] pci 0000:3a:03.0: enabling Extended Tags
[    0.743846] pci 0000:3a:03.0: PME# supported from D0 D3hot D3cold
[    0.743936] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    0.744031] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    0.744125] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    0.744142] pci 0000:3a:05.4: reg 0x10: [mem 0xb8700000-0xb8700fff]
[    0.744253] pci 0000:3a:05.6: [8086:2037] type 00 class 0x110100
[    0.744347] pci 0000:3a:07.0: [8086:2038] type 00 class 0x088000
[    0.744438] pci 0000:3a:07.1: [8086:2039] type 00 class 0x088000
[    0.744531] pci 0000:3a:07.2: [8086:203a] type 00 class 0x088000
[    0.744623] pci 0000:3a:07.3: [8086:203b] type 00 class 0x088000
[    0.744714] pci 0000:3a:07.4: [8086:203c] type 00 class 0x088000
[    0.744806] pci 0000:3a:07.7: [8086:203d] type 00 class 0x088000
[    0.744896] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    0.744990] pci 0000:3a:08.1: [8086:2067] type 00 class 0x088000
[    0.745063] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    0.745158] pci 0000:3a:09.1: [8086:2067] type 00 class 0x088000
[    0.745231] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    0.745329] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    0.745412] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    0.745495] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    0.745577] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    0.745658] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    0.745740] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    0.745822] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    0.745912] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    0.746009] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    0.746091] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    0.746174] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    0.746258] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    0.746356] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    0.746438] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    0.746521] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    0.746605] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    0.746687] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    0.746769] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    0.746854] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    0.746937] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    0.747035] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    0.747118] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    0.747202] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    0.747336] pci 0000:3b:00.0: [1cc1:8201] type 00 class 0x010802
[    0.747364] pci 0000:3b:00.0: reg 0x10: [mem 0xb8600000-0xb8603fff 64bit]
[    0.747558] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    0.747561] pci 0000:3a:00.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    0.747607] pci 0000:3c:00.0: [144d:a808] type 00 class 0x010802
[    0.747635] pci 0000:3c:00.0: reg 0x10: [mem 0xb8500000-0xb8503fff 64bit]
[    0.747844] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    0.747847] pci 0000:3a:01.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    0.747893] pci 0000:3d:00.0: [144d:a808] type 00 class 0x010802
[    0.747922] pci 0000:3d:00.0: reg 0x10: [mem 0xb8400000-0xb8403fff 64bit]
[    0.748130] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    0.748133] pci 0000:3a:02.0:   bridge window [mem 0xb8400000-0xb84fffff]
[    0.748178] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.748206] pci 0000:3e:00.0: reg 0x10: [mem 0xb8300000-0xb8303fff 64bit]
[    0.748413] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    0.748416] pci 0000:3a:03.0:   bridge window [mem 0xb8300000-0xb83fffff]
[    0.748456] pci_bus 0000:3a: on NUMA node 0
[    0.748547] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[    0.748551] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.748815] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]
[    0.749016] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.749017] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.749162] PCI host bridge to bus 0000:5d
[    0.749164] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[    0.749166] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
[    0.749168] pci_bus 0000:5d: root bus resource [mem 0x38c000000000-0x38ffffffffff window]
[    0.749170] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[    0.749188] pci 0000:5d:00.0: [8086:2030] type 01 class 0x060400
[    0.749271] pci 0000:5d:00.0: PME# supported from D0 D3hot D3cold
[    0.749372] pci 0000:5d:01.0: [8086:2031] type 01 class 0x060400
[    0.749453] pci 0000:5d:01.0: PME# supported from D0 D3hot D3cold
[    0.749548] pci 0000:5d:02.0: [8086:2032] type 01 class 0x060400
[    0.749597] pci 0000:5d:02.0: enabling Extended Tags
[    0.749632] pci 0000:5d:02.0: PME# supported from D0 D3hot D3cold
[    0.749734] pci 0000:5d:03.0: [8086:2033] type 01 class 0x060400
[    0.749783] pci 0000:5d:03.0: enabling Extended Tags
[    0.749818] pci 0000:5d:03.0: PME# supported from D0 D3hot D3cold
[    0.749913] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[    0.750011] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[    0.750110] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[    0.750128] pci 0000:5d:05.4: reg 0x10: [mem 0xc5f00000-0xc5f00fff]
[    0.750243] pci 0000:5d:05.6: [8086:2037] type 00 class 0x110100
[    0.750340] pci 0000:5d:07.0: [8086:2038] type 00 class 0x088000
[    0.750436] pci 0000:5d:07.1: [8086:2039] type 00 class 0x088000
[    0.750530] pci 0000:5d:07.2: [8086:203a] type 00 class 0x088000
[    0.750624] pci 0000:5d:07.3: [8086:203b] type 00 class 0x088000
[    0.750718] pci 0000:5d:07.4: [8086:203c] type 00 class 0x088000
[    0.750814] pci 0000:5d:07.7: [8086:203d] type 00 class 0x088000
[    0.750908] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[    0.751009] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[    0.751089] pci 0000:5d:0e.2: [8086:205a] type 00 class 0x088000
[    0.751170] pci 0000:5d:0e.3: [8086:205b] type 00 class 0x088000
[    0.751251] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[    0.751348] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[    0.751429] pci 0000:5d:0f.2: [8086:205a] type 00 class 0x088000
[    0.751514] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[    0.751608] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[    0.751676] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[    0.751743] pci 0000:5d:12.3: [8086:204f] type 00 class 0x088000
[    0.751813] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[    0.751895] pci 0000:5d:15.1: [8086:2088] type 00 class 0x110100
[    0.751962] pci 0000:5d:15.3: [8086:2019] type 00 class 0x088000
[    0.752031] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[    0.752112] pci 0000:5d:16.1: [8086:2088] type 00 class 0x110100
[    0.752179] pci 0000:5d:16.3: [8086:2019] type 00 class 0x088000
[    0.752245] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[    0.752311] pci 0000:5d:16.5: [8086:2088] type 00 class 0x110100
[    0.752380] pci 0000:5d:16.7: [8086:2019] type 00 class 0x088000
[    0.752493] pci 0000:5e:00.0: [8086:4140] type 00 class 0x010802
[    0.752518] pci 0000:5e:00.0: reg 0x10: [mem 0xc5d10000-0xc5d13fff 64bit]
[    0.752559] pci 0000:5e:00.0: reg 0x20: [mem 0xc5c00000-0xc5cfffff 64bit]
[    0.752572] pci 0000:5e:00.0: reg 0x30: [mem 0xc5d00000-0xc5d0ffff pref]
[    0.752673] pci 0000:5e:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:5d:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.752737] pci 0000:5d:00.0: PCI bridge to [bus 5e]
[    0.752740] pci 0000:5d:00.0:   bridge window [mem 0xc5c00000-0xc5dfffff]
[    0.752789] pci 0000:5f:00.0: [8086:4140] type 00 class 0x010802
[    0.752815] pci 0000:5f:00.0: reg 0x10: [mem 0xc5b10000-0xc5b13fff 64bit]
[    0.752855] pci 0000:5f:00.0: reg 0x20: [mem 0xc5a00000-0xc5afffff 64bit]
[    0.752868] pci 0000:5f:00.0: reg 0x30: [mem 0xc5b00000-0xc5b0ffff pref]
[    0.752970] pci 0000:5f:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:5d:01.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.753030] pci 0000:5d:01.0: PCI bridge to [bus 5f]
[    0.753034] pci 0000:5d:01.0:   bridge window [mem 0xc5a00000-0xc5bfffff]
[    0.753080] pci 0000:60:00.0: [144d:a808] type 00 class 0x010802
[    0.753108] pci 0000:60:00.0: reg 0x10: [mem 0xc5e00000-0xc5e03fff 64bit]
[    0.753316] pci 0000:5d:02.0: PCI bridge to [bus 60]
[    0.753320] pci 0000:5d:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
[    0.753365] pci 0000:61:00.0: [8086:37c0] type 01 class 0x060400
[    0.753393] pci 0000:61:00.0: reg 0x10: [mem 0xc5900000-0xc591ffff 64bit]
[    0.753406] pci 0000:61:00.0: reg 0x38: [mem 0xc5700000-0xc57fffff pref]
[    0.753467] pci 0000:61:00.0: PME# supported from D0 D3hot D3cold
[    0.753532] pci 0000:5d:03.0: PCI bridge to [bus 61-63]
[    0.753535] pci 0000:5d:03.0:   bridge window [mem 0xc5700000-0xc59fffff]
[    0.753538] pci 0000:5d:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.753577] pci 0000:62:03.0: [8086:37c5] type 01 class 0x060400
[    0.753691] pci 0000:62:03.0: PME# supported from D0 D3hot D3cold
[    0.753772] pci 0000:61:00.0: PCI bridge to [bus 62-63]
[    0.753776] pci 0000:61:00.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    0.753780] pci 0000:61:00.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.753825] pci 0000:63:00.0: [8086:37d1] type 00 class 0x020000
[    0.753858] pci 0000:63:00.0: reg 0x10: [mem 0xc3000000-0xc3ffffff 64bit pref]
[    0.753894] pci 0000:63:00.0: reg 0x1c: [mem 0xc4808000-0xc480ffff 64bit pref]
[    0.753922] pci 0000:63:00.0: reg 0x30: [mem 0xc5880000-0xc58fffff pref]
[    0.753929] pci 0000:63:00.0: enabling Extended Tags
[    0.754003] pci 0000:63:00.0: PME# supported from D0 D3hot D3cold
[    0.754039] pci 0000:63:00.0: reg 0x184: [mem 0xc4400000-0xc441ffff 64bit pref]
[    0.754041] pci 0000:63:00.0: VF(n) BAR0 space: [mem 0xc4400000-0xc47fffff 64bit pref] (contains BAR0 for 32 VFs)
[    0.754064] pci 0000:63:00.0: reg 0x190: [mem 0xc4890000-0xc4893fff 64bit pref]
[    0.754066] pci 0000:63:00.0: VF(n) BAR3 space: [mem 0xc4890000-0xc490ffff 64bit pref] (contains BAR3 for 32 VFs)
[    0.754265] pci 0000:63:00.1: [8086:37d1] type 00 class 0x020000
[    0.754296] pci 0000:63:00.1: reg 0x10: [mem 0xc2000000-0xc2ffffff 64bit pref]
[    0.754331] pci 0000:63:00.1: reg 0x1c: [mem 0xc4800000-0xc4807fff 64bit pref]
[    0.754360] pci 0000:63:00.1: reg 0x30: [mem 0xc5800000-0xc587ffff pref]
[    0.754367] pci 0000:63:00.1: enabling Extended Tags
[    0.754439] pci 0000:63:00.1: PME# supported from D0 D3hot D3cold
[    0.754469] pci 0000:63:00.1: reg 0x184: [mem 0xc4000000-0xc401ffff 64bit pref]
[    0.754471] pci 0000:63:00.1: VF(n) BAR0 space: [mem 0xc4000000-0xc43fffff 64bit pref] (contains BAR0 for 32 VFs)
[    0.754494] pci 0000:63:00.1: reg 0x190: [mem 0xc4810000-0xc4813fff 64bit pref]
[    0.754495] pci 0000:63:00.1: VF(n) BAR3 space: [mem 0xc4810000-0xc488ffff 64bit pref] (contains BAR3 for 32 VFs)
[    0.754685] pci 0000:62:03.0: PCI bridge to [bus 63]
[    0.754689] pci 0000:62:03.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    0.754694] pci 0000:62:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.754752] pci_bus 0000:5d: on NUMA node 0
[    0.754905] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[    0.754909] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.755045] acpi PNP0A08:06: _OSC: platform does not support [AER LTR]
[    0.755184] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.755186] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.755308] PCI host bridge to bus 0000:80
[    0.755310] pci_bus 0000:80: root bus resource [io  0xa000-0xbfff window]
[    0.755312] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37fffff window]
[    0.755314] pci_bus 0000:80: root bus resource [mem 0x390000000000-0x393fffffffff window]
[    0.755316] pci_bus 0000:80: root bus resource [bus 80-84]
[    0.755341] pci 0000:80:00.0: [8086:2030] type 01 class 0x060400
[    0.755392] pci 0000:80:00.0: enabling Extended Tags
[    0.755432] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    0.755540] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
[    0.755560] pci 0000:80:04.0: reg 0x10: [mem 0x393ffff1c000-0x393ffff1ffff 64bit]
[    0.755667] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
[    0.755687] pci 0000:80:04.1: reg 0x10: [mem 0x393ffff18000-0x393ffff1bfff 64bit]
[    0.755791] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
[    0.755811] pci 0000:80:04.2: reg 0x10: [mem 0x393ffff14000-0x393ffff17fff 64bit]
[    0.755918] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
[    0.755937] pci 0000:80:04.3: reg 0x10: [mem 0x393ffff10000-0x393ffff13fff 64bit]
[    0.756042] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
[    0.756062] pci 0000:80:04.4: reg 0x10: [mem 0x393ffff0c000-0x393ffff0ffff 64bit]
[    0.756164] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
[    0.756184] pci 0000:80:04.5: reg 0x10: [mem 0x393ffff08000-0x393ffff0bfff 64bit]
[    0.756286] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
[    0.756306] pci 0000:80:04.6: reg 0x10: [mem 0x393ffff04000-0x393ffff07fff 64bit]
[    0.756411] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
[    0.756431] pci 0000:80:04.7: reg 0x10: [mem 0x393ffff00000-0x393ffff03fff 64bit]
[    0.756533] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[    0.756637] pci 0000:80:05.1: [8086:2022] type 00 class 0x088000
[    0.756768] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[    0.756870] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[    0.756889] pci 0000:80:05.4: reg 0x10: [mem 0xd3700000-0xd3700fff]
[    0.757007] pci 0000:80:05.6: [8086:2027] type 00 class 0x110100
[    0.757106] pci 0000:80:07.0: [8086:2028] type 00 class 0x088000
[    0.757204] pci 0000:80:07.4: [8086:202c] type 00 class 0x088000
[    0.757302] pci 0000:80:07.7: [8086:202d] type 00 class 0x088000
[    0.757397] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[    0.757494] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[    0.757566] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[    0.757687] pci 0000:80:00.0: PCI bridge to [bus 81]
[    0.757704] pci_bus 0000:80: on NUMA node 1
[    0.757785] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[    0.757789] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.758055] acpi PNP0A08:07: _OSC: platform does not support [AER LTR]
[    0.758250] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.758251] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.758439] PCI host bridge to bus 0000:85
[    0.758441] pci_bus 0000:85: root bus resource [io  0xc000-0xdfff window]
[    0.758443] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0ffffff window]
[    0.758445] pci_bus 0000:85: root bus resource [mem 0x394000000000-0x397fffffffff window]
[    0.758447] pci_bus 0000:85: root bus resource [bus 85-ad]
[    0.758467] pci 0000:85:00.0: [8086:2030] type 01 class 0x060400
[    0.758517] pci 0000:85:00.0: enabling Extended Tags
[    0.758558] pci 0000:85:00.0: PME# supported from D0 D3hot D3cold
[    0.758724] pci 0000:85:02.0: [8086:2032] type 01 class 0x060400
[    0.758808] pci 0000:85:02.0: PME# supported from D0 D3hot D3cold
[    0.758963] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[    0.759064] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[    0.759163] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[    0.759181] pci 0000:85:05.4: reg 0x10: [mem 0xe0f00000-0xe0f00fff]
[    0.759299] pci 0000:85:05.6: [8086:2037] type 00 class 0x110100
[    0.759399] pci 0000:85:07.0: [8086:2038] type 00 class 0x088000
[    0.759497] pci 0000:85:07.1: [8086:2039] type 00 class 0x088000
[    0.759595] pci 0000:85:07.2: [8086:203a] type 00 class 0x088000
[    0.759692] pci 0000:85:07.3: [8086:203b] type 00 class 0x088000
[    0.759789] pci 0000:85:07.4: [8086:203c] type 00 class 0x088000
[    0.759889] pci 0000:85:07.7: [8086:203d] type 00 class 0x088000
[    0.759983] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[    0.760070] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[    0.760140] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[    0.760209] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[    0.760279] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[    0.760348] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[    0.760416] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[    0.760485] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[    0.760556] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[    0.760641] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[    0.760710] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[    0.760780] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[    0.760852] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[    0.760921] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[    0.760991] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[    0.761060] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[    0.761132] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[    0.761218] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[    0.761294] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[    0.761380] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[    0.761450] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[    0.761519] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[    0.761588] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[    0.761657] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[    0.761726] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[    0.761794] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[    0.761868] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[    0.761952] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[    0.762022] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[    0.762091] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[    0.762161] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[    0.762230] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[    0.762300] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[    0.762369] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[    0.762440] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[    0.762526] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[    0.762604] pci 0000:85:14.0: [8086:208f] type 00 class 0x088000
[    0.762689] pci 0000:85:14.1: [8086:208f] type 00 class 0x088000
[    0.762758] pci 0000:85:14.2: [8086:208f] type 00 class 0x088000
[    0.762828] pci 0000:85:14.3: [8086:208f] type 00 class 0x088000
[    0.762899] pci 0000:85:14.4: [8086:208f] type 00 class 0x088000
[    0.762970] pci 0000:85:14.5: [8086:208f] type 00 class 0x088000
[    0.763039] pci 0000:85:14.6: [8086:208f] type 00 class 0x088000
[    0.763108] pci 0000:85:14.7: [8086:208f] type 00 class 0x088000
[    0.763179] pci 0000:85:15.0: [8086:208f] type 00 class 0x088000
[    0.763266] pci 0000:85:15.1: [8086:208f] type 00 class 0x088000
[    0.763336] pci 0000:85:15.2: [8086:208f] type 00 class 0x088000
[    0.763407] pci 0000:85:15.3: [8086:208f] type 00 class 0x088000
[    0.763477] pci 0000:85:15.4: [8086:208f] type 00 class 0x088000
[    0.763546] pci 0000:85:15.5: [8086:208f] type 00 class 0x088000
[    0.763615] pci 0000:85:15.6: [8086:208f] type 00 class 0x088000
[    0.763685] pci 0000:85:15.7: [8086:208f] type 00 class 0x088000
[    0.763756] pci 0000:85:16.0: [8086:208f] type 00 class 0x088000
[    0.763846] pci 0000:85:16.1: [8086:208f] type 00 class 0x088000
[    0.763929] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[    0.764017] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[    0.764088] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[    0.764159] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[    0.764233] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[    0.764319] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[    0.764390] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[    0.764465] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[    0.764535] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[    0.764605] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[    0.764675] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[    0.764747] pci 0000:85:1f.0: [8086:2078] type 00 class 0x088000
[    0.764833] pci 0000:85:1f.1: [8086:2079] type 00 class 0x088000
[    0.764905] pci 0000:85:1f.2: [8086:207a] type 00 class 0x088000
[    0.764976] pci 0000:85:1f.3: [8086:207b] type 00 class 0x088000
[    0.765047] pci 0000:85:1f.4: [8086:207c] type 00 class 0x088000
[    0.765116] pci 0000:85:1f.5: [8086:207d] type 00 class 0x088000
[    0.765188] pci 0000:85:1f.6: [8086:207e] type 00 class 0x088000
[    0.765258] pci 0000:85:1f.7: [8086:207f] type 00 class 0x088000
[    0.765361] pci 0000:85:00.0: PCI bridge to [bus 86]
[    0.765412] pci 0000:87:00.0: [1987:5016] type 00 class 0x010802
[    0.765441] pci 0000:87:00.0: reg 0x10: [mem 0xe0e00000-0xe0e03fff 64bit]
[    0.765618] pci 0000:87:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:85:02.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.765687] pci 0000:85:02.0: PCI bridge to [bus 87]
[    0.765691] pci 0000:85:02.0:   bridge window [mem 0xe0e00000-0xe0efffff]
[    0.765716] pci_bus 0000:85: on NUMA node 1
[    0.765841] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[    0.765845] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.766108] acpi PNP0A08:08: _OSC: platform does not support [AER LTR]
[    0.766301] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.766302] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.766457] PCI host bridge to bus 0000:ae
[    0.766459] pci_bus 0000:ae: root bus resource [io  0xe000-0xefff window]
[    0.766461] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7fffff window]
[    0.766462] pci_bus 0000:ae: root bus resource [mem 0x398000000000-0x39bfffffffff window]
[    0.766464] pci_bus 0000:ae: root bus resource [bus ae-d6]
[    0.766483] pci 0000:ae:00.0: [8086:2030] type 01 class 0x060400
[    0.766567] pci 0000:ae:00.0: PME# supported from D0 D3hot D3cold
[    0.766727] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[    0.766829] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[    0.766929] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[    0.766947] pci 0000:ae:05.4: reg 0x10: [mem 0xee700000-0xee700fff]
[    0.767066] pci 0000:ae:05.6: [8086:2037] type 00 class 0x110100
[    0.767165] pci 0000:ae:07.0: [8086:2038] type 00 class 0x088000
[    0.767262] pci 0000:ae:07.1: [8086:2039] type 00 class 0x088000
[    0.767359] pci 0000:ae:07.2: [8086:203a] type 00 class 0x088000
[    0.767455] pci 0000:ae:07.3: [8086:203b] type 00 class 0x088000
[    0.767550] pci 0000:ae:07.4: [8086:203c] type 00 class 0x088000
[    0.767648] pci 0000:ae:07.7: [8086:203d] type 00 class 0x088000
[    0.767743] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[    0.767845] pci 0000:ae:08.1: [8086:2067] type 00 class 0x088000
[    0.767921] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[    0.768021] pci 0000:ae:09.1: [8086:2067] type 00 class 0x088000
[    0.768096] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[    0.768199] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[    0.768286] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[    0.768374] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[    0.768461] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[    0.768548] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[    0.768635] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[    0.768722] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[    0.768810] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[    0.768914] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[    0.769002] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[    0.769089] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[    0.769179] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[    0.769285] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[    0.769373] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[    0.769460] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[    0.769548] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[    0.769636] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[    0.769723] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[    0.769811] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[    0.769900] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[    0.770003] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[    0.770090] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[    0.770178] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[    0.770328] pci 0000:af:00.0: [1002:1478] type 01 class 0x060400
[    0.770351] pci 0000:af:00.0: reg 0x10: [mem 0xee600000-0xee603fff]
[    0.770467] pci 0000:af:00.0: PME# supported from D0 D3hot D3cold
[    0.770523] pci 0000:af:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:ae:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.770592] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    0.770595] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    0.770598] pci 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    0.770601] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.770643] pci 0000:b0:00.0: [1002:1479] type 01 class 0x060400
[    0.770777] pci 0000:b0:00.0: PME# supported from D0 D3hot D3cold
[    0.770893] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    0.770897] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    0.770900] pci 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    0.770905] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.770945] pci 0000:b1:00.0: [1002:744c] type 00 class 0x030000
[    0.770975] pci 0000:b1:00.0: reg 0x10: [mem 0x39bfe0000000-0x39bfefffffff 64bit pref]
[    0.770996] pci 0000:b1:00.0: reg 0x18: [mem 0x39bff0000000-0x39bff01fffff 64bit pref]
[    0.771010] pci 0000:b1:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.771024] pci 0000:b1:00.0: reg 0x24: [mem 0xee400000-0xee4fffff]
[    0.771038] pci 0000:b1:00.0: reg 0x30: [mem 0xee500000-0xee51ffff pref]
[    0.771067] pci 0000:b1:00.0: BAR 0: assigned to efifb
[    0.771117] pci 0000:b1:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.771172] pci 0000:b1:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:ae:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.771239] pci 0000:b1:00.1: [1002:ab30] type 00 class 0x040300
[    0.771261] pci 0000:b1:00.1: reg 0x10: [mem 0xee520000-0xee523fff]
[    0.771393] pci 0000:b1:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.771479] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    0.771484] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    0.771487] pci 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    0.771491] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.771524] pci_bus 0000:ae: on NUMA node 1
[    0.771620] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[    0.771623] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.771886] acpi PNP0A08:09: _OSC: platform does not support [AER LTR]
[    0.772080] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.772081] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.772235] PCI host bridge to bus 0000:d7
[    0.772236] pci_bus 0000:d7: root bus resource [io  0xf000-0xffff window]
[    0.772238] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbffffff window]
[    0.772240] pci_bus 0000:d7: root bus resource [mem 0x39c000000000-0x39ffffffffff window]
[    0.772242] pci_bus 0000:d7: root bus resource [bus d7-ff]
[    0.772262] pci 0000:d7:00.0: [8086:2030] type 01 class 0x060400
[    0.772314] pci 0000:d7:00.0: enabling Extended Tags
[    0.772356] pci 0000:d7:00.0: PME# supported from D0 D3hot D3cold
[    0.772517] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[    0.772622] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[    0.772724] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[    0.772742] pci 0000:d7:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    0.772864] pci 0000:d7:05.6: [8086:2037] type 00 class 0x110100
[    0.772965] pci 0000:d7:07.0: [8086:2038] type 00 class 0x088000
[    0.773064] pci 0000:d7:07.1: [8086:2039] type 00 class 0x088000
[    0.773164] pci 0000:d7:07.2: [8086:203a] type 00 class 0x088000
[    0.773263] pci 0000:d7:07.3: [8086:203b] type 00 class 0x088000
[    0.773362] pci 0000:d7:07.4: [8086:203c] type 00 class 0x088000
[    0.773460] pci 0000:d7:07.7: [8086:203d] type 00 class 0x088000
[    0.773561] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[    0.773664] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[    0.773751] pci 0000:d7:0e.2: [8086:205a] type 00 class 0x088000
[    0.773836] pci 0000:d7:0e.3: [8086:205b] type 00 class 0x088000
[    0.773924] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[    0.774027] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[    0.774113] pci 0000:d7:0f.2: [8086:205a] type 00 class 0x088000
[    0.774203] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[    0.774302] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[    0.774373] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[    0.774445] pci 0000:d7:12.3: [8086:204f] type 00 class 0x088000
[    0.774518] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[    0.774603] pci 0000:d7:15.1: [8086:2088] type 00 class 0x110100
[    0.774673] pci 0000:d7:15.3: [8086:2019] type 00 class 0x088000
[    0.774744] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[    0.774829] pci 0000:d7:16.1: [8086:2088] type 00 class 0x110100
[    0.774898] pci 0000:d7:16.3: [8086:2019] type 00 class 0x088000
[    0.774967] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[    0.775036] pci 0000:d7:16.5: [8086:2088] type 00 class 0x110100
[    0.775106] pci 0000:d7:16.7: [8086:2019] type 00 class 0x088000
[    0.775213] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    0.775231] pci_bus 0000:d7: on NUMA node 1
[    0.775558] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.775599] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.775640] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.775680] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.775720] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.775759] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.775799] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.775842] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.776146] iommu: Default domain type: Passthrough (set via kernel command line)
[    0.776146] SCSI subsystem initialized
[    0.776146] libata version 3.00 loaded.
[    0.776146] ACPI: bus type USB registered
[    0.776146] usbcore: registered new interface driver usbfs
[    0.776146] usbcore: registered new interface driver hub
[    0.776146] usbcore: registered new device driver usb
[    0.776146] mc: Linux media interface: v0.10
[    0.776146] videodev: Linux video capture interface: v2.00
[    0.776146] pps_core: LinuxPPS API ver. 1 registered
[    0.776146] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.776146] PTP clock support registered
[    0.776146] EDAC MC: Ver: 3.0.0
[    0.776997] efivars: Registered efivars operations
[    0.776997] Advanced Linux Sound Architecture Driver Initialized.
[    0.777010] Bluetooth: Core ver 2.22
[    0.777016] NET: Registered PF_BLUETOOTH protocol family
[    0.777017] Bluetooth: HCI device and connection manager initialized
[    0.777019] Bluetooth: HCI socket layer initialized
[    0.777021] Bluetooth: L2CAP socket layer initialized
[    0.777023] Bluetooth: SCO socket layer initialized
[    0.777026] NetLabel: Initializing
[    0.777027] NetLabel:  domain hash size = 128
[    0.777028] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.777042] NetLabel:  unlabeled traffic allowed by default
[    0.777054] PCI: Using ACPI for IRQ routing
[    0.780584] PCI: pci_cache_line_size set to 64 bytes
[    0.780994] e820: reserve RAM buffer [mem 0x5baf3018-0x5bffffff]
[    0.780998] e820: reserve RAM buffer [mem 0x5bb0f018-0x5bffffff]
[    0.780999] e820: reserve RAM buffer [mem 0x5bb44018-0x5bffffff]
[    0.781001] e820: reserve RAM buffer [mem 0x5bb79018-0x5bffffff]
[    0.781002] e820: reserve RAM buffer [mem 0x5bb84018-0x5bffffff]
[    0.781003] e820: reserve RAM buffer [mem 0x5bb8f018-0x5bffffff]
[    0.781004] e820: reserve RAM buffer [mem 0x5bbb4018-0x5bffffff]
[    0.781005] e820: reserve RAM buffer [mem 0x62eca000-0x63ffffff]
[    0.781007] e820: reserve RAM buffer [mem 0x687fc000-0x6bffffff]
[    0.781065] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.781067] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.781068] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.781128] pci 0000:b1:00.0: vgaarb: setting as boot VGA device (overriding previous)
[    0.781129] pci 0000:b1:00.0: vgaarb: bridge control possible
[    0.781130] pci 0000:b1:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.781137] vgaarb: loaded
[    0.781140] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.781140] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.783035] clocksource: Switched to clocksource tsc-early
[    0.785448] VFS: Disk quotas dquot_6.6.0
[    0.785471] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.785579] pnp: PnP ACPI init
[    0.788878] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.788881] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.788883] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.788885] system 00:01: [io  0x0880-0x0883] has been reserved
[    0.788887] system 00:01: [io  0x0800-0x081f] has been reserved
[    0.788889] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    0.788893] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    0.788895] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.788897] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.788901] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    0.788903] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    0.788905] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    0.789323] system 00:02: [io  0x0a00-0x0a0f] has been reserved
[    0.789325] system 00:02: [io  0x0a10-0x0a1f] has been reserved
[    0.789327] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.789328] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    0.789563] pnp 00:03: [dma 0 disabled]
[    0.789789] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.789791] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.789793] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.789796] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    0.789798] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    0.789800] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.789802] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.789804] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.790101] system 00:05: [io  0x0f00-0x0ffe] has been reserved
[    0.790726] pnp: PnP ACPI: found 6 devices
[    0.796344] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.796444] NET: Registered PF_INET protocol family
[    0.796991] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    0.800284] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    0.800424] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    0.800445] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hugepage)
[    0.800987] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    0.801287] TCP: Hash tables configured (established 524288 bind 65536)
[    0.801805] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, vmalloc)
[    0.801976] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    0.802282] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    0.802631] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.802638] NET: Registered PF_XDP protocol family
[    0.802667] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.802692] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.802701] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    0.802720] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.802722] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    0.802732] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    0.802751] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    0.802753] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.802762] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    0.802779] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.802781] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.802782] pci_bus 0000:00: resource 6 [io  0x03b0-0x03bb window]
[    0.802783] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    0.802785] pci_bus 0000:00: resource 8 [io  0x1000-0x3fff window]
[    0.802786] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    0.802787] pci_bus 0000:00: resource 10 [mem 0x000c4000-0x000c7fff window]
[    0.802789] pci_bus 0000:00: resource 11 [mem 0xfe010000-0xfe010fff window]
[    0.802790] pci_bus 0000:00: resource 12 [mem 0x90000000-0x9d7fffff window]
[    0.802791] pci_bus 0000:00: resource 13 [mem 0x380000000000-0x383fffffffff window]
[    0.802794] pci_bus 0000:02: resource 1 [mem 0x9d100000-0x9d1fffff]
[    0.802795] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.802796] pci_bus 0000:03: resource 1 [mem 0x9c000000-0x9d0fffff]
[    0.802798] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    0.802799] pci_bus 0000:04: resource 1 [mem 0x9c000000-0x9d0fffff]
[    0.802864] pci 0000:17:00.0: PCI bridge to [bus 18]
[    0.802872] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    0.802878] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    0.802891] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[    0.802892] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff window]
[    0.802893] pci_bus 0000:17: resource 6 [mem 0x384000000000-0x387fffffffff window]
[    0.802895] pci_bus 0000:18: resource 1 [mem 0xaac00000-0xaaefffff]
[    0.802896] pci_bus 0000:18: resource 2 [mem 0xaa800000-0xaaafffff 64bit pref]
[    0.802914] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    0.802923] pci 0000:3a:00.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    0.802938] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    0.802945] pci 0000:3a:01.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    0.802960] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    0.802968] pci 0000:3a:02.0:   bridge window [mem 0xb8400000-0xb84fffff]
[    0.802983] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    0.802991] pci 0000:3a:03.0:   bridge window [mem 0xb8300000-0xb83fffff]
[    0.803006] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[    0.803008] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff window]
[    0.803009] pci_bus 0000:3a: resource 6 [mem 0x388000000000-0x38bfffffffff window]
[    0.803011] pci_bus 0000:3b: resource 1 [mem 0xb8600000-0xb86fffff]
[    0.803012] pci_bus 0000:3c: resource 1 [mem 0xb8500000-0xb85fffff]
[    0.803013] pci_bus 0000:3d: resource 1 [mem 0xb8400000-0xb84fffff]
[    0.803015] pci_bus 0000:3e: resource 1 [mem 0xb8300000-0xb83fffff]
[    0.803027] pci 0000:5d:00.0: bridge window [io  0x1000-0x0fff] to [bus 5e] add_size 1000
[    0.803029] pci 0000:5d:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 5e] add_size 200000 add_align 100000
[    0.803032] pci 0000:5d:01.0: bridge window [io  0x1000-0x0fff] to [bus 5f] add_size 1000
[    0.803034] pci 0000:5d:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 5f] add_size 200000 add_align 100000
[    0.803042] pci 0000:5d:00.0: BAR 15: assigned [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    0.803045] pci 0000:5d:01.0: BAR 15: assigned [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    0.803047] pci 0000:5d:00.0: BAR 13: assigned [io  0x8000-0x8fff]
[    0.803049] pci 0000:5d:01.0: BAR 13: assigned [io  0x9000-0x9fff]
[    0.803051] pci 0000:5d:00.0: PCI bridge to [bus 5e]
[    0.803053] pci 0000:5d:00.0:   bridge window [io  0x8000-0x8fff]
[    0.803061] pci 0000:5d:00.0:   bridge window [mem 0xc5c00000-0xc5dfffff]
[    0.803066] pci 0000:5d:00.0:   bridge window [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    0.803077] pci 0000:5d:01.0: PCI bridge to [bus 5f]
[    0.803079] pci 0000:5d:01.0:   bridge window [io  0x9000-0x9fff]
[    0.803087] pci 0000:5d:01.0:   bridge window [mem 0xc5a00000-0xc5bfffff]
[    0.803093] pci 0000:5d:01.0:   bridge window [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    0.803104] pci 0000:5d:02.0: PCI bridge to [bus 60]
[    0.803111] pci 0000:5d:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
[    0.803128] pci 0000:62:03.0: PCI bridge to [bus 63]
[    0.803137] pci 0000:62:03.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    0.803143] pci 0000:62:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803155] pci 0000:61:00.0: PCI bridge to [bus 62-63]
[    0.803164] pci 0000:61:00.0:   bridge window [mem 0xc5800000-0xc58fffff]
[    0.803170] pci 0000:61:00.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803181] pci 0000:5d:03.0: PCI bridge to [bus 61-63]
[    0.803190] pci 0000:5d:03.0:   bridge window [mem 0xc5700000-0xc59fffff]
[    0.803199] pci 0000:5d:03.0:   bridge window [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803210] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[    0.803211] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff window]
[    0.803213] pci_bus 0000:5d: resource 6 [mem 0x38c000000000-0x38ffffffffff window]
[    0.803214] pci_bus 0000:5e: resource 0 [io  0x8000-0x8fff]
[    0.803216] pci_bus 0000:5e: resource 1 [mem 0xc5c00000-0xc5dfffff]
[    0.803217] pci_bus 0000:5e: resource 2 [mem 0x38c000000000-0x38c0001fffff 64bit pref]
[    0.803219] pci_bus 0000:5f: resource 0 [io  0x9000-0x9fff]
[    0.803220] pci_bus 0000:5f: resource 1 [mem 0xc5a00000-0xc5bfffff]
[    0.803221] pci_bus 0000:5f: resource 2 [mem 0x38c000200000-0x38c0003fffff 64bit pref]
[    0.803223] pci_bus 0000:60: resource 1 [mem 0xc5e00000-0xc5efffff]
[    0.803224] pci_bus 0000:61: resource 1 [mem 0xc5700000-0xc59fffff]
[    0.803225] pci_bus 0000:61: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803227] pci_bus 0000:62: resource 1 [mem 0xc5800000-0xc58fffff]
[    0.803228] pci_bus 0000:62: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803229] pci_bus 0000:63: resource 1 [mem 0xc5800000-0xc58fffff]
[    0.803231] pci_bus 0000:63: resource 2 [mem 0xc2000000-0xc49fffff 64bit pref]
[    0.803244] pci 0000:80:00.0: PCI bridge to [bus 81]
[    0.803267] pci_bus 0000:80: resource 4 [io  0xa000-0xbfff window]
[    0.803269] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xd37fffff window]
[    0.803270] pci_bus 0000:80: resource 6 [mem 0x390000000000-0x393fffffffff window]
[    0.803285] pci 0000:85:00.0: PCI bridge to [bus 86]
[    0.803308] pci 0000:85:02.0: PCI bridge to [bus 87]
[    0.803316] pci 0000:85:02.0:   bridge window [mem 0xe0e00000-0xe0efffff]
[    0.803333] pci_bus 0000:85: resource 4 [io  0xc000-0xdfff window]
[    0.803334] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff window]
[    0.803336] pci_bus 0000:85: resource 6 [mem 0x394000000000-0x397fffffffff window]
[    0.803337] pci_bus 0000:87: resource 1 [mem 0xe0e00000-0xe0efffff]
[    0.803354] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    0.803360] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    0.803370] pci 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    0.803376] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803388] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    0.803390] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    0.803399] pci 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    0.803406] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803418] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    0.803420] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    0.803428] pci 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    0.803434] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803445] pci_bus 0000:ae: resource 4 [io  0xe000-0xefff window]
[    0.803446] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff window]
[    0.803448] pci_bus 0000:ae: resource 6 [mem 0x398000000000-0x39bfffffffff window]
[    0.803449] pci_bus 0000:af: resource 0 [io  0xe000-0xefff]
[    0.803450] pci_bus 0000:af: resource 1 [mem 0xee400000-0xee6fffff]
[    0.803452] pci_bus 0000:af: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803453] pci_bus 0000:b0: resource 0 [io  0xe000-0xefff]
[    0.803455] pci_bus 0000:b0: resource 1 [mem 0xee400000-0xee5fffff]
[    0.803456] pci_bus 0000:b0: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803457] pci_bus 0000:b1: resource 0 [io  0xe000-0xefff]
[    0.803459] pci_bus 0000:b1: resource 1 [mem 0xee400000-0xee5fffff]
[    0.803460] pci_bus 0000:b1: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    0.803473] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    0.803496] pci_bus 0000:d7: resource 4 [io  0xf000-0xffff window]
[    0.803497] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff window]
[    0.803499] pci_bus 0000:d7: resource 6 [mem 0x39c000000000-0x39ffffffffff window]
[    0.803825] pci 0000:02:00.0: PME# does not work under D0, disabling it
[    0.803952] pci 0000:17:05.0: disabled boot interrupts on device [8086:2034]
[    0.804076] pci 0000:18:00.0: CLS mismatch (64 != 32), using 64 bytes
[    0.804083] pci 0000:3a:05.0: disabled boot interrupts on device [8086:2034]
[    0.804138] pci 0000:5d:05.0: disabled boot interrupts on device [8086:2034]
[    0.804213] pci 0000:85:05.0: disabled boot interrupts on device [8086:2034]
[    0.804311] pci 0000:ae:05.0: disabled boot interrupts on device [8086:2034]
[    0.804430] pci 0000:b1:00.1: D0 power state depends on 0000:b1:00.0
[    0.804437] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2034]
[    0.804582] Unpacking initramfs...
[    0.804691] DMAR: No SATC found
[    0.804693] DMAR: dmar6: Using Queued invalidation
[    0.804697] DMAR: dmar5: Using Queued invalidation
[    0.804701] DMAR: dmar4: Using Queued invalidation
[    0.804705] DMAR: dmar3: Using Queued invalidation
[    0.804708] DMAR: dmar2: Using Queued invalidation
[    0.804713] DMAR: dmar1: Using Queued invalidation
[    0.804718] DMAR: dmar0: Using Queued invalidation
[    0.804722] DMAR: dmar7: Using Queued invalidation
[    0.804913] pci 0000:5d:00.0: Adding to iommu group 0
[    0.804980] pci 0000:5d:01.0: Adding to iommu group 1
[    0.805046] pci 0000:5d:02.0: Adding to iommu group 2
[    0.805114] pci 0000:5d:03.0: Adding to iommu group 3
[    0.805189] pci 0000:5e:00.0: Adding to iommu group 4
[    0.805260] pci 0000:5f:00.0: Adding to iommu group 5
[    0.805327] pci 0000:60:00.0: Adding to iommu group 6
[    0.805394] pci 0000:61:00.0: Adding to iommu group 7
[    0.805462] pci 0000:62:03.0: Adding to iommu group 8
[    0.805533] pci 0000:63:00.0: Adding to iommu group 9
[    0.805603] pci 0000:63:00.1: Adding to iommu group 10
[    0.805776] pci 0000:3a:00.0: Adding to iommu group 11
[    0.805843] pci 0000:3a:01.0: Adding to iommu group 12
[    0.805910] pci 0000:3a:02.0: Adding to iommu group 13
[    0.805976] pci 0000:3a:03.0: Adding to iommu group 14
[    0.806051] pci 0000:3b:00.0: Adding to iommu group 15
[    0.806118] pci 0000:3c:00.0: Adding to iommu group 16
[    0.806186] pci 0000:3d:00.0: Adding to iommu group 17
[    0.806256] pci 0000:3e:00.0: Adding to iommu group 18
[    0.806406] pci 0000:17:00.0: Adding to iommu group 19
[    0.806491] pci 0000:18:00.0: Adding to iommu group 20
[    0.806715] pci 0000:d7:00.0: Adding to iommu group 21
[    0.806875] pci 0000:ae:00.0: Adding to iommu group 22
[    0.806950] pci 0000:af:00.0: Adding to iommu group 23
[    0.807017] pci 0000:b0:00.0: Adding to iommu group 24
[    0.807092] pci 0000:b1:00.0: Adding to iommu group 25
[    0.807162] pci 0000:b1:00.1: Adding to iommu group 26
[    0.807314] pci 0000:85:00.0: Adding to iommu group 27
[    0.807381] pci 0000:85:02.0: Adding to iommu group 28
[    0.807465] pci 0000:87:00.0: Adding to iommu group 29
[    0.807614] pci 0000:80:00.0: Adding to iommu group 30
[    0.807681] pci 0000:80:04.0: Adding to iommu group 31
[    0.807747] pci 0000:80:04.1: Adding to iommu group 32
[    0.807814] pci 0000:80:04.2: Adding to iommu group 33
[    0.807880] pci 0000:80:04.3: Adding to iommu group 34
[    0.807946] pci 0000:80:04.4: Adding to iommu group 35
[    0.808012] pci 0000:80:04.5: Adding to iommu group 36
[    0.808080] pci 0000:80:04.6: Adding to iommu group 37
[    0.808147] pci 0000:80:04.7: Adding to iommu group 38
[    0.808279] pci 0000:00:00.0: Adding to iommu group 39
[    0.808346] pci 0000:00:04.0: Adding to iommu group 40
[    0.808413] pci 0000:00:04.1: Adding to iommu group 41
[    0.808481] pci 0000:00:04.2: Adding to iommu group 42
[    0.808548] pci 0000:00:04.3: Adding to iommu group 43
[    0.808615] pci 0000:00:04.4: Adding to iommu group 44
[    0.808681] pci 0000:00:04.5: Adding to iommu group 45
[    0.808748] pci 0000:00:04.6: Adding to iommu group 46
[    0.808815] pci 0000:00:04.7: Adding to iommu group 47
[    0.808882] pci 0000:00:05.0: Adding to iommu group 48
[    0.808948] pci 0000:00:05.1: Adding to iommu group 49
[    0.809014] pci 0000:00:05.2: Adding to iommu group 50
[    0.809081] pci 0000:00:05.4: Adding to iommu group 51
[    0.809147] pci 0000:00:05.6: Adding to iommu group 52
[    0.809219] pci 0000:00:07.0: Adding to iommu group 53
[    0.809285] pci 0000:00:07.4: Adding to iommu group 54
[    0.809352] pci 0000:00:07.7: Adding to iommu group 55
[    0.809418] pci 0000:00:08.0: Adding to iommu group 56
[    0.809545] pci 0000:00:08.1: Adding to iommu group 57
[    0.809611] pci 0000:00:08.2: Adding to iommu group 58
[    0.809799] pci 0000:00:11.0: Adding to iommu group 59
[    0.809867] pci 0000:00:11.5: Adding to iommu group 59
[    0.810054] pci 0000:00:14.0: Adding to iommu group 60
[    0.810122] pci 0000:00:14.2: Adding to iommu group 60
[    0.810371] pci 0000:00:16.0: Adding to iommu group 61
[    0.810440] pci 0000:00:16.1: Adding to iommu group 61
[    0.810509] pci 0000:00:16.4: Adding to iommu group 61
[    0.810575] pci 0000:00:17.0: Adding to iommu group 62
[    0.810704] pci 0000:00:1c.0: Adding to iommu group 63
[    0.810771] pci 0000:00:1c.2: Adding to iommu group 64
[    0.810839] pci 0000:00:1c.5: Adding to iommu group 65
[    0.811146] pci 0000:00:1f.0: Adding to iommu group 66
[    0.811219] pci 0000:00:1f.2: Adding to iommu group 66
[    0.811285] pci 0000:00:1f.3: Adding to iommu group 67
[    0.811355] pci 0000:00:1f.4: Adding to iommu group 66
[    0.811424] pci 0000:00:1f.5: Adding to iommu group 66
[    0.811492] pci 0000:02:00.0: Adding to iommu group 68
[    0.811559] pci 0000:03:00.0: Adding to iommu group 69
[    0.811563] pci 0000:04:00.0: Adding to iommu group 69
[    0.811629] pci 0000:17:05.0: Adding to iommu group 70
[    0.811697] pci 0000:17:05.2: Adding to iommu group 71
[    0.811763] pci 0000:17:05.4: Adding to iommu group 72
[    0.811829] pci 0000:17:05.6: Adding to iommu group 73
[    0.811898] pci 0000:17:07.0: Adding to iommu group 74
[    0.811964] pci 0000:17:07.1: Adding to iommu group 75
[    0.812031] pci 0000:17:07.2: Adding to iommu group 76
[    0.812097] pci 0000:17:07.3: Adding to iommu group 77
[    0.812163] pci 0000:17:07.4: Adding to iommu group 78
[    0.812233] pci 0000:17:07.7: Adding to iommu group 79
[    0.812782] pci 0000:17:08.0: Adding to iommu group 80
[    0.812855] pci 0000:17:08.1: Adding to iommu group 80
[    0.812927] pci 0000:17:08.2: Adding to iommu group 80
[    0.812999] pci 0000:17:08.3: Adding to iommu group 80
[    0.813071] pci 0000:17:08.4: Adding to iommu group 80
[    0.813143] pci 0000:17:08.5: Adding to iommu group 80
[    0.813218] pci 0000:17:08.6: Adding to iommu group 80
[    0.813290] pci 0000:17:08.7: Adding to iommu group 80
[    0.813839] pci 0000:17:09.0: Adding to iommu group 81
[    0.813913] pci 0000:17:09.1: Adding to iommu group 81
[    0.813986] pci 0000:17:09.2: Adding to iommu group 81
[    0.814059] pci 0000:17:09.3: Adding to iommu group 81
[    0.814134] pci 0000:17:09.4: Adding to iommu group 81
[    0.814211] pci 0000:17:09.5: Adding to iommu group 81
[    0.814284] pci 0000:17:09.6: Adding to iommu group 81
[    0.814358] pci 0000:17:09.7: Adding to iommu group 81
[    0.814543] pci 0000:17:0a.0: Adding to iommu group 82
[    0.814618] pci 0000:17:0a.1: Adding to iommu group 82
[    0.815167] pci 0000:17:0e.0: Adding to iommu group 83
[    0.815248] pci 0000:17:0e.1: Adding to iommu group 83
[    0.815322] pci 0000:17:0e.2: Adding to iommu group 83
[    0.815397] pci 0000:17:0e.3: Adding to iommu group 83
[    0.815471] pci 0000:17:0e.4: Adding to iommu group 83
[    0.815546] pci 0000:17:0e.5: Adding to iommu group 83
[    0.815621] pci 0000:17:0e.6: Adding to iommu group 83
[    0.815696] pci 0000:17:0e.7: Adding to iommu group 83
[    0.816248] pci 0000:17:0f.0: Adding to iommu group 84
[    0.816325] pci 0000:17:0f.1: Adding to iommu group 84
[    0.816401] pci 0000:17:0f.2: Adding to iommu group 84
[    0.816477] pci 0000:17:0f.3: Adding to iommu group 84
[    0.816553] pci 0000:17:0f.4: Adding to iommu group 84
[    0.816628] pci 0000:17:0f.5: Adding to iommu group 84
[    0.816704] pci 0000:17:0f.6: Adding to iommu group 84
[    0.816780] pci 0000:17:0f.7: Adding to iommu group 84
[    0.816966] pci 0000:17:10.0: Adding to iommu group 85
[    0.817044] pci 0000:17:10.1: Adding to iommu group 85
[    0.817593] pci 0000:17:14.0: Adding to iommu group 86
[    0.817671] pci 0000:17:14.1: Adding to iommu group 86
[    0.817749] pci 0000:17:14.2: Adding to iommu group 86
[    0.817827] pci 0000:17:14.3: Adding to iommu group 86
[    0.817905] pci 0000:17:14.4: Adding to iommu group 86
[    0.817983] pci 0000:17:14.5: Adding to iommu group 86
[    0.818061] pci 0000:17:14.6: Adding to iommu group 86
[    0.818138] pci 0000:17:14.7: Adding to iommu group 86
[    0.818688] pci 0000:17:15.0: Adding to iommu group 87
[    0.818769] pci 0000:17:15.1: Adding to iommu group 87
[    0.818848] pci 0000:17:15.2: Adding to iommu group 87
[    0.818927] pci 0000:17:15.3: Adding to iommu group 87
[    0.819006] pci 0000:17:15.4: Adding to iommu group 87
[    0.819085] pci 0000:17:15.5: Adding to iommu group 87
[    0.819164] pci 0000:17:15.6: Adding to iommu group 87
[    0.819245] pci 0000:17:15.7: Adding to iommu group 87
[    0.819430] pci 0000:17:16.0: Adding to iommu group 88
[    0.819512] pci 0000:17:16.1: Adding to iommu group 88
[    0.819819] pci 0000:17:1d.0: Adding to iommu group 89
[    0.819900] pci 0000:17:1d.1: Adding to iommu group 89
[    0.819980] pci 0000:17:1d.2: Adding to iommu group 89
[    0.820061] pci 0000:17:1d.3: Adding to iommu group 89
[    0.820549] pci 0000:17:1e.0: Adding to iommu group 90
[    0.820631] pci 0000:17:1e.1: Adding to iommu group 90
[    0.820713] pci 0000:17:1e.2: Adding to iommu group 90
[    0.820793] pci 0000:17:1e.3: Adding to iommu group 90
[    0.820874] pci 0000:17:1e.4: Adding to iommu group 90
[    0.820954] pci 0000:17:1e.5: Adding to iommu group 90
[    0.821035] pci 0000:17:1e.6: Adding to iommu group 90
[    0.821584] pci 0000:17:1f.0: Adding to iommu group 91
[    0.821669] pci 0000:17:1f.1: Adding to iommu group 91
[    0.821751] pci 0000:17:1f.2: Adding to iommu group 91
[    0.821838] pci 0000:17:1f.3: Adding to iommu group 91
[    0.821920] pci 0000:17:1f.4: Adding to iommu group 91
[    0.822002] pci 0000:17:1f.5: Adding to iommu group 91
[    0.822084] pci 0000:17:1f.6: Adding to iommu group 91
[    0.822165] pci 0000:17:1f.7: Adding to iommu group 91
[    0.822234] pci 0000:3a:05.0: Adding to iommu group 92
[    0.822302] pci 0000:3a:05.2: Adding to iommu group 93
[    0.822369] pci 0000:3a:05.4: Adding to iommu group 94
[    0.822436] pci 0000:3a:05.6: Adding to iommu group 95
[    0.822502] pci 0000:3a:07.0: Adding to iommu group 96
[    0.822570] pci 0000:3a:07.1: Adding to iommu group 97
[    0.822638] pci 0000:3a:07.2: Adding to iommu group 98
[    0.822705] pci 0000:3a:07.3: Adding to iommu group 99
[    0.822771] pci 0000:3a:07.4: Adding to iommu group 100
[    0.822839] pci 0000:3a:07.7: Adding to iommu group 101
[    0.822906] pci 0000:3a:08.0: Adding to iommu group 102
[    0.823033] pci 0000:3a:08.1: Adding to iommu group 103
[    0.823100] pci 0000:3a:09.0: Adding to iommu group 104
[    0.823230] pci 0000:3a:09.1: Adding to iommu group 105
[    0.823298] pci 0000:3a:0a.0: Adding to iommu group 106
[    0.823364] pci 0000:3a:0a.1: Adding to iommu group 107
[    0.823430] pci 0000:3a:0a.2: Adding to iommu group 108
[    0.823497] pci 0000:3a:0a.3: Adding to iommu group 109
[    0.823563] pci 0000:3a:0a.4: Adding to iommu group 110
[    0.823629] pci 0000:3a:0a.5: Adding to iommu group 111
[    0.823696] pci 0000:3a:0a.6: Adding to iommu group 112
[    0.823763] pci 0000:3a:0a.7: Adding to iommu group 113
[    0.823830] pci 0000:3a:0b.0: Adding to iommu group 114
[    0.823896] pci 0000:3a:0b.1: Adding to iommu group 115
[    0.823962] pci 0000:3a:0b.2: Adding to iommu group 116
[    0.824029] pci 0000:3a:0b.3: Adding to iommu group 117
[    0.824096] pci 0000:3a:0c.0: Adding to iommu group 118
[    0.824162] pci 0000:3a:0c.1: Adding to iommu group 119
[    0.824231] pci 0000:3a:0c.2: Adding to iommu group 120
[    0.824299] pci 0000:3a:0c.3: Adding to iommu group 121
[    0.824366] pci 0000:3a:0c.4: Adding to iommu group 122
[    0.824432] pci 0000:3a:0c.5: Adding to iommu group 123
[    0.824498] pci 0000:3a:0c.6: Adding to iommu group 124
[    0.824565] pci 0000:3a:0c.7: Adding to iommu group 125
[    0.824632] pci 0000:3a:0d.0: Adding to iommu group 126
[    0.824698] pci 0000:3a:0d.1: Adding to iommu group 127
[    0.824764] pci 0000:3a:0d.2: Adding to iommu group 128
[    0.824832] pci 0000:3a:0d.3: Adding to iommu group 129
[    0.824899] pci 0000:5d:05.0: Adding to iommu group 130
[    0.824966] pci 0000:5d:05.2: Adding to iommu group 131
[    0.825032] pci 0000:5d:05.4: Adding to iommu group 132
[    0.825099] pci 0000:5d:05.6: Adding to iommu group 133
[    0.825165] pci 0000:5d:07.0: Adding to iommu group 134
[    0.825233] pci 0000:5d:07.1: Adding to iommu group 135
[    0.825299] pci 0000:5d:07.2: Adding to iommu group 136
[    0.825366] pci 0000:5d:07.3: Adding to iommu group 137
[    0.825433] pci 0000:5d:07.4: Adding to iommu group 138
[    0.825500] pci 0000:5d:07.7: Adding to iommu group 139
[    0.825567] pci 0000:5d:0e.0: Adding to iommu group 140
[    0.825634] pci 0000:5d:0e.1: Adding to iommu group 141
[    0.825700] pci 0000:5d:0e.2: Adding to iommu group 142
[    0.825767] pci 0000:5d:0e.3: Adding to iommu group 143
[    0.825833] pci 0000:5d:0f.0: Adding to iommu group 144
[    0.825904] pci 0000:5d:0f.1: Adding to iommu group 145
[    0.825970] pci 0000:5d:0f.2: Adding to iommu group 146
[    0.826037] pci 0000:5d:12.0: Adding to iommu group 147
[    0.826282] pci 0000:5d:12.1: Adding to iommu group 148
[    0.826378] pci 0000:5d:12.2: Adding to iommu group 148
[    0.826471] pci 0000:5d:12.3: Adding to iommu group 148
[    0.826711] pci 0000:5d:15.0: Adding to iommu group 149
[    0.826806] pci 0000:5d:15.1: Adding to iommu group 149
[    0.826899] pci 0000:5d:15.3: Adding to iommu group 149
[    0.827323] pci 0000:5d:16.0: Adding to iommu group 150
[    0.827419] pci 0000:5d:16.1: Adding to iommu group 150
[    0.827513] pci 0000:5d:16.3: Adding to iommu group 150
[    0.827606] pci 0000:5d:16.4: Adding to iommu group 150
[    0.827699] pci 0000:5d:16.5: Adding to iommu group 150
[    0.827791] pci 0000:5d:16.7: Adding to iommu group 150
[    0.827857] pci 0000:80:05.0: Adding to iommu group 151
[    0.827925] pci 0000:80:05.1: Adding to iommu group 152
[    0.827992] pci 0000:80:05.2: Adding to iommu group 153
[    0.828058] pci 0000:80:05.4: Adding to iommu group 154
[    0.828125] pci 0000:80:05.6: Adding to iommu group 155
[    0.828195] pci 0000:80:07.0: Adding to iommu group 156
[    0.828263] pci 0000:80:07.4: Adding to iommu group 157
[    0.828329] pci 0000:80:07.7: Adding to iommu group 158
[    0.828396] pci 0000:80:08.0: Adding to iommu group 159
[    0.828524] pci 0000:80:08.1: Adding to iommu group 160
[    0.828591] pci 0000:80:08.2: Adding to iommu group 161
[    0.828658] pci 0000:85:05.0: Adding to iommu group 162
[    0.828726] pci 0000:85:05.2: Adding to iommu group 163
[    0.828793] pci 0000:85:05.4: Adding to iommu group 164
[    0.828860] pci 0000:85:05.6: Adding to iommu group 165
[    0.828926] pci 0000:85:07.0: Adding to iommu group 166
[    0.828992] pci 0000:85:07.1: Adding to iommu group 167
[    0.829059] pci 0000:85:07.2: Adding to iommu group 168
[    0.829126] pci 0000:85:07.3: Adding to iommu group 169
[    0.829196] pci 0000:85:07.4: Adding to iommu group 170
[    0.829262] pci 0000:85:07.7: Adding to iommu group 171
[    0.829810] pci 0000:85:08.0: Adding to iommu group 172
[    0.829913] pci 0000:85:08.1: Adding to iommu group 172
[    0.830015] pci 0000:85:08.2: Adding to iommu group 172
[    0.830117] pci 0000:85:08.3: Adding to iommu group 172
[    0.830220] pci 0000:85:08.4: Adding to iommu group 172
[    0.830321] pci 0000:85:08.5: Adding to iommu group 172
[    0.830422] pci 0000:85:08.6: Adding to iommu group 172
[    0.830523] pci 0000:85:08.7: Adding to iommu group 172
[    0.831069] pci 0000:85:09.0: Adding to iommu group 173
[    0.831173] pci 0000:85:09.1: Adding to iommu group 173
[    0.831278] pci 0000:85:09.2: Adding to iommu group 173
[    0.831381] pci 0000:85:09.3: Adding to iommu group 173
[    0.831483] pci 0000:85:09.4: Adding to iommu group 173
[    0.831586] pci 0000:85:09.5: Adding to iommu group 173
[    0.831689] pci 0000:85:09.6: Adding to iommu group 173
[    0.831792] pci 0000:85:09.7: Adding to iommu group 173
[    0.831975] pci 0000:85:0a.0: Adding to iommu group 174
[    0.832080] pci 0000:85:0a.1: Adding to iommu group 174
[    0.832630] pci 0000:85:0e.0: Adding to iommu group 175
[    0.832735] pci 0000:85:0e.1: Adding to iommu group 175
[    0.832839] pci 0000:85:0e.2: Adding to iommu group 175
[    0.832944] pci 0000:85:0e.3: Adding to iommu group 175
[    0.833048] pci 0000:85:0e.4: Adding to iommu group 175
[    0.833152] pci 0000:85:0e.5: Adding to iommu group 175
[    0.833257] pci 0000:85:0e.6: Adding to iommu group 175
[    0.833362] pci 0000:85:0e.7: Adding to iommu group 175
[    0.833909] pci 0000:85:0f.0: Adding to iommu group 176
[    0.834015] pci 0000:85:0f.1: Adding to iommu group 176
[    0.834121] pci 0000:85:0f.2: Adding to iommu group 176
[    0.834229] pci 0000:85:0f.3: Adding to iommu group 176
[    0.834335] pci 0000:85:0f.4: Adding to iommu group 176
[    0.834440] pci 0000:85:0f.5: Adding to iommu group 176
[    0.834547] pci 0000:85:0f.6: Adding to iommu group 176
[    0.834653] pci 0000:85:0f.7: Adding to iommu group 176
[    0.834837] pci 0000:85:10.0: Adding to iommu group 177
[    0.834947] pci 0000:85:10.1: Adding to iommu group 177
[    0.835498] pci 0000:85:14.0: Adding to iommu group 178
[    0.835606] pci 0000:85:14.1: Adding to iommu group 178
[    0.835714] pci 0000:85:14.2: Adding to iommu group 178
[    0.835822] pci 0000:85:14.3: Adding to iommu group 178
[    0.835929] pci 0000:85:14.4: Adding to iommu group 178
[    0.836036] pci 0000:85:14.5: Adding to iommu group 178
[    0.836145] pci 0000:85:14.6: Adding to iommu group 178
[    0.836254] pci 0000:85:14.7: Adding to iommu group 178
[    0.836802] pci 0000:85:15.0: Adding to iommu group 179
[    0.836912] pci 0000:85:15.1: Adding to iommu group 179
[    0.837021] pci 0000:85:15.2: Adding to iommu group 179
[    0.837129] pci 0000:85:15.3: Adding to iommu group 179
[    0.837240] pci 0000:85:15.4: Adding to iommu group 179
[    0.837350] pci 0000:85:15.5: Adding to iommu group 179
[    0.837459] pci 0000:85:15.6: Adding to iommu group 179
[    0.837567] pci 0000:85:15.7: Adding to iommu group 179
[    0.837752] pci 0000:85:16.0: Adding to iommu group 180
[    0.837863] pci 0000:85:16.1: Adding to iommu group 180
[    0.838171] pci 0000:85:1d.0: Adding to iommu group 181
[    0.838285] pci 0000:85:1d.1: Adding to iommu group 181
[    0.838397] pci 0000:85:1d.2: Adding to iommu group 181
[    0.838507] pci 0000:85:1d.3: Adding to iommu group 181
[    0.838996] pci 0000:85:1e.0: Adding to iommu group 182
[    0.839108] pci 0000:85:1e.1: Adding to iommu group 182
[    0.839222] pci 0000:85:1e.2: Adding to iommu group 182
[    0.839334] pci 0000:85:1e.3: Adding to iommu group 182
[    0.839446] pci 0000:85:1e.4: Adding to iommu group 182
[    0.839558] pci 0000:85:1e.5: Adding to iommu group 182
[    0.839669] pci 0000:85:1e.6: Adding to iommu group 182
[    0.840220] pci 0000:85:1f.0: Adding to iommu group 183
[    0.840334] pci 0000:85:1f.1: Adding to iommu group 183
[    0.840446] pci 0000:85:1f.2: Adding to iommu group 183
[    0.840560] pci 0000:85:1f.3: Adding to iommu group 183
[    0.840673] pci 0000:85:1f.4: Adding to iommu group 183
[    0.840787] pci 0000:85:1f.5: Adding to iommu group 183
[    0.840900] pci 0000:85:1f.6: Adding to iommu group 183
[    0.841013] pci 0000:85:1f.7: Adding to iommu group 183
[    0.841080] pci 0000:ae:05.0: Adding to iommu group 184
[    0.841147] pci 0000:ae:05.2: Adding to iommu group 185
[    0.841216] pci 0000:ae:05.4: Adding to iommu group 186
[    0.841283] pci 0000:ae:05.6: Adding to iommu group 187
[    0.841350] pci 0000:ae:07.0: Adding to iommu group 188
[    0.841416] pci 0000:ae:07.1: Adding to iommu group 189
[    0.841483] pci 0000:ae:07.2: Adding to iommu group 190
[    0.841550] pci 0000:ae:07.3: Adding to iommu group 191
[    0.841616] pci 0000:ae:07.4: Adding to iommu group 192
[    0.841682] pci 0000:ae:07.7: Adding to iommu group 193
[    0.841750] pci 0000:ae:08.0: Adding to iommu group 194
[    0.841876] pci 0000:ae:08.1: Adding to iommu group 195
[    0.841942] pci 0000:ae:09.0: Adding to iommu group 196
[    0.842069] pci 0000:ae:09.1: Adding to iommu group 197
[    0.842136] pci 0000:ae:0a.0: Adding to iommu group 198
[    0.842206] pci 0000:ae:0a.1: Adding to iommu group 199
[    0.842272] pci 0000:ae:0a.2: Adding to iommu group 200
[    0.842339] pci 0000:ae:0a.3: Adding to iommu group 201
[    0.842407] pci 0000:ae:0a.4: Adding to iommu group 202
[    0.842473] pci 0000:ae:0a.5: Adding to iommu group 203
[    0.842539] pci 0000:ae:0a.6: Adding to iommu group 204
[    0.842605] pci 0000:ae:0a.7: Adding to iommu group 205
[    0.842672] pci 0000:ae:0b.0: Adding to iommu group 206
[    0.842739] pci 0000:ae:0b.1: Adding to iommu group 207
[    0.842805] pci 0000:ae:0b.2: Adding to iommu group 208
[    0.842871] pci 0000:ae:0b.3: Adding to iommu group 209
[    0.842938] pci 0000:ae:0c.0: Adding to iommu group 210
[    0.843004] pci 0000:ae:0c.1: Adding to iommu group 211
[    0.843070] pci 0000:ae:0c.2: Adding to iommu group 212
[    0.843138] pci 0000:ae:0c.3: Adding to iommu group 213
[    0.843207] pci 0000:ae:0c.4: Adding to iommu group 214
[    0.843274] pci 0000:ae:0c.5: Adding to iommu group 215
[    0.843340] pci 0000:ae:0c.6: Adding to iommu group 216
[    0.843407] pci 0000:ae:0c.7: Adding to iommu group 217
[    0.843474] pci 0000:ae:0d.0: Adding to iommu group 218
[    0.843540] pci 0000:ae:0d.1: Adding to iommu group 219
[    0.843606] pci 0000:ae:0d.2: Adding to iommu group 220
[    0.843672] pci 0000:ae:0d.3: Adding to iommu group 221
[    0.843740] pci 0000:d7:05.0: Adding to iommu group 222
[    0.843806] pci 0000:d7:05.2: Adding to iommu group 223
[    0.843873] pci 0000:d7:05.4: Adding to iommu group 224
[    0.843939] pci 0000:d7:05.6: Adding to iommu group 225
[    0.844005] pci 0000:d7:07.0: Adding to iommu group 226
[    0.844073] pci 0000:d7:07.1: Adding to iommu group 227
[    0.844139] pci 0000:d7:07.2: Adding to iommu group 228
[    0.844208] pci 0000:d7:07.3: Adding to iommu group 229
[    0.844276] pci 0000:d7:07.4: Adding to iommu group 230
[    0.844342] pci 0000:d7:07.7: Adding to iommu group 231
[    0.844409] pci 0000:d7:0e.0: Adding to iommu group 232
[    0.844475] pci 0000:d7:0e.1: Adding to iommu group 233
[    0.844543] pci 0000:d7:0e.2: Adding to iommu group 234
[    0.844609] pci 0000:d7:0e.3: Adding to iommu group 235
[    0.844676] pci 0000:d7:0f.0: Adding to iommu group 236
[    0.844743] pci 0000:d7:0f.1: Adding to iommu group 237
[    0.844810] pci 0000:d7:0f.2: Adding to iommu group 238
[    0.844876] pci 0000:d7:12.0: Adding to iommu group 239
[    0.845124] pci 0000:d7:12.1: Adding to iommu group 240
[    0.845250] pci 0000:d7:12.2: Adding to iommu group 240
[    0.845373] pci 0000:d7:12.3: Adding to iommu group 240
[    0.845623] pci 0000:d7:15.0: Adding to iommu group 241
[    0.845746] pci 0000:d7:15.1: Adding to iommu group 241
[    0.845870] pci 0000:d7:15.3: Adding to iommu group 241
[    0.846303] pci 0000:d7:16.0: Adding to iommu group 242
[    0.846427] pci 0000:d7:16.1: Adding to iommu group 242
[    0.846553] pci 0000:d7:16.3: Adding to iommu group 242
[    0.846678] pci 0000:d7:16.4: Adding to iommu group 242
[    0.846803] pci 0000:d7:16.5: Adding to iommu group 242
[    0.846928] pci 0000:d7:16.7: Adding to iommu group 242
[    0.847192] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.847194] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.847195] software IO TLB: mapped [mem 0x000000005ee40000-0x0000000062e40000] (64MB)
[    0.850707] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    0.850709] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.850710] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    0.872555] Initialise system trusted keyrings
[    0.872565] Key type blacklist registered
[    0.872688] workingset: timestamp_bits=36 max_order=26 bucket_order=0
[    0.872798] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.872824] fuse: init (API version 7.39)
[    0.872941] SGI XFS with ACLs, security attributes, realtime, scrub, quota, fatal assert, debug enabled
[    0.881270] NET: Registered PF_ALG protocol family
[    0.881276] xor: automatically using best checksumming function   avx       
[    0.881388] async_tx: api initialized (async)
[    0.881390] Key type asymmetric registered
[    0.881391] Asymmetric key parser 'x509' registered
[    0.881393] Asymmetric key parser 'pkcs8' registered
[    0.881404] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    0.881406] io scheduler mq-deadline registered
[    0.881408] io scheduler kyber registered
[    0.881415] io scheduler bfq registered
[    0.882099] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
[    0.882237] pcieport 0000:00:1c.2: PME: Signaling with IRQ 25
[    0.882417] pcieport 0000:00:1c.5: PME: Signaling with IRQ 26
[    0.882699] pcieport 0000:17:00.0: PME: Signaling with IRQ 28
[    0.882939] pcieport 0000:3a:00.0: PME: Signaling with IRQ 30
[    0.883163] pcieport 0000:3a:01.0: PME: Signaling with IRQ 31
[    0.883399] pcieport 0000:3a:02.0: PME: Signaling with IRQ 32
[    0.883620] pcieport 0000:3a:03.0: PME: Signaling with IRQ 33
[    0.883865] pcieport 0000:5d:00.0: PME: Signaling with IRQ 35
[    0.883896] pcieport 0000:5d:00.0: pciehp: Slot #7 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.884226] pcieport 0000:5d:01.0: PME: Signaling with IRQ 36
[    0.884257] pcieport 0000:5d:01.0: pciehp: Slot #8 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    0.884525] pcieport 0000:5d:02.0: PME: Signaling with IRQ 37
[    0.884743] pcieport 0000:5d:03.0: PME: Signaling with IRQ 38
[    0.885512] pcieport 0000:80:00.0: PME: Signaling with IRQ 42
[    0.885824] pcieport 0000:85:00.0: PME: Signaling with IRQ 44
[    0.886093] pcieport 0000:85:02.0: PME: Signaling with IRQ 45
[    0.886381] pcieport 0000:ae:00.0: PME: Signaling with IRQ 47
[    0.886864] pcieport 0000:d7:00.0: PME: Signaling with IRQ 51
[    0.889496] IPMI message handler: version 39.2
[    0.889510] ipmi device interface
[    0.889564] ipmi_si: IPMI System Interface driver
[    0.889574] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    0.889576] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    0.889579] ipmi_si: Adding SMBIOS-specified kcs state machine
[    0.889628] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[    0.889720] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    1.007328] Freeing initrd memory: 31200K
[    1.007964] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[    1.007969] ipmi_si: Adding ACPI-specified kcs state machine
[    1.008103] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    1.094305] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[    1.121931] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_id: 0x097a, dev_id: 0x20)
[    1.159979] ipmi_si IPI0001:00: IPMI kcs interface initialized
[    1.159984] ipmi_ssif: IPMI SSIF Interface driver
[    1.166208] IPMI Watchdog: driver initialized
[    1.166209] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
[    1.172637] IPMI poweroff: ATCA Detect mfg 0x2A7C prod 0x97A
[    1.172640] IPMI poweroff: Found a chassis style poweroff function
[    1.172867] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.172966] ACPI: button: Power Button [PWRF]
[    1.173793] ERST: Error Record Serialization Table (ERST) support is initialized.
[    1.173804] pstore: Using crash dump compression: deflate
[    1.173805] pstore: Registered erst as persistent store backend
[    1.174001] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    1.174021] ioatdma 0000:00:04.0: enabling device (0004 -> 0006)
[    1.182362] ioatdma 0000:00:04.1: enabling device (0004 -> 0006)
[    1.189542] ioatdma 0000:00:04.2: enabling device (0004 -> 0006)
[    1.196665] ioatdma 0000:00:04.3: enabling device (0004 -> 0006)
[    1.203762] ioatdma 0000:00:04.4: enabling device (0004 -> 0006)
[    1.211232] ioatdma 0000:00:04.5: enabling device (0004 -> 0006)
[    1.218501] ioatdma 0000:00:04.6: enabling device (0004 -> 0006)
[    1.225905] ioatdma 0000:00:04.7: enabling device (0004 -> 0006)
[    1.233399] ioatdma 0000:80:04.0: enabling device (0004 -> 0006)
[    1.242064] ioatdma 0000:80:04.1: enabling device (0004 -> 0006)
[    1.249946] ioatdma 0000:80:04.2: enabling device (0004 -> 0006)
[    1.257372] ioatdma 0000:80:04.3: enabling device (0004 -> 0006)
[    1.264709] ioatdma 0000:80:04.4: enabling device (0004 -> 0006)
[    1.271931] ioatdma 0000:80:04.5: enabling device (0004 -> 0006)
[    1.279209] ioatdma 0000:80:04.6: enabling device (0004 -> 0006)
[    1.286330] ioatdma 0000:80:04.7: enabling device (0004 -> 0006)
[    1.293558] idxd driver failed to load without MOVDIR64B.
[    1.293827] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.294166] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.297474] Non-volatile memory driver v1.3
[    1.298001] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.298347] ACPI: bus type drm_connector registered
[    1.298376] [drm] amdgpu kernel modesetting enabled.
[    1.298495] amdgpu: Virtual CRAT table created for CPU
[    1.298512] amdgpu: Topology: Add CPU node
[    1.298821] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1DA2:0x471E 0xCC).
[    1.298841] [drm] register mmio base: 0xEE400000
[    1.298842] [drm] register mmio size: 1048576
[    1.302183] [drm] add ip block number 0 <soc21_common>
[    1.302185] [drm] add ip block number 1 <gmc_v11_0>
[    1.302187] [drm] add ip block number 2 <ih_v6_0>
[    1.302188] [drm] add ip block number 3 <psp>
[    1.302190] [drm] add ip block number 4 <smu>
[    1.302196] [drm] add ip block number 5 <dm>
[    1.302198] [drm] add ip block number 6 <gfx_v11_0>
[    1.302199] [drm] add ip block number 7 <sdma_v6_0>
[    1.302201] [drm] add ip block number 8 <vcn_v4_0>
[    1.302202] [drm] add ip block number 9 <jpeg_v4_0>
[    1.302203] [drm] add ip block number 10 <mes_v11_0>
[    1.302263] amdgpu 0000:b1:00.0: amdgpu: Fetched VBIOS from VFCT
[    1.302265] amdgpu: ATOM BIOS: 113-D70401XT-P11
[    1.307169] amdgpu 0000:b1:00.0: amdgpu: CP RS64 enable
[    1.310091] [drm] VCN(0) encode/decode are enabled in VM mode
[    1.310093] [drm] VCN(1) encode/decode are enabled in VM mode
[    1.311509] amdgpu 0000:b1:00.0: [drm:jpeg_v4_0_early_init] JPEG decode is enabled in VM mode
[    1.311535] amdgpu 0000:b1:00.0: Direct firmware load for amdgpu/gc_11_0_0_mes_2.bin failed with error -2
[    1.311538] [drm] try to fall back to amdgpu/gc_11_0_0_mes.bin
[    1.313439] amdgpu 0000:b1:00.0: vgaarb: deactivate vga console
[    1.313442] amdgpu 0000:b1:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    1.313471] amdgpu 0000:b1:00.0: amdgpu: MEM ECC is not presented.
[    1.313472] amdgpu 0000:b1:00.0: amdgpu: SRAM ECC is not presented.
[    1.313479] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    1.313493] amdgpu 0000:b1:00.0: BAR 2: releasing [mem 0x39bff0000000-0x39bff01fffff 64bit pref]
[    1.313497] amdgpu 0000:b1:00.0: BAR 0: releasing [mem 0x39bfe0000000-0x39bfefffffff 64bit pref]
[    1.313510] pcieport 0000:b0:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.313512] pcieport 0000:af:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.313514] pcieport 0000:ae:00.0: BAR 15: releasing [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.313520] pcieport 0000:ae:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313523] pcieport 0000:af:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313525] pcieport 0000:b0:00.0: BAR 15: assigned [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313527] amdgpu 0000:b1:00.0: BAR 0: assigned [mem 0x398000000000-0x3987ffffffff 64bit pref]
[    1.313542] amdgpu 0000:b1:00.0: BAR 2: assigned [mem 0x398800000000-0x3988001fffff 64bit pref]
[    1.313556] pcieport 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.313558] pcieport 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.313567] pcieport 0000:ae:00.0:   bridge window [mem 0xee400000-0xee6fffff]
[    1.313573] pcieport 0000:ae:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313584] pcieport 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.313586] pcieport 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.313595] pcieport 0000:af:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.313601] pcieport 0000:af:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313613] pcieport 0000:b0:00.0: PCI bridge to [bus b1]
[    1.313615] pcieport 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.313624] pcieport 0000:b0:00.0:   bridge window [mem 0xee400000-0xee5fffff]
[    1.313630] pcieport 0000:b0:00.0:   bridge window [mem 0x398000000000-0x398bffffffff 64bit pref]
[    1.313646] amdgpu 0000:b1:00.0: amdgpu: VRAM: 20464M 0x0000008000000000 - 0x00000084FEFFFFFF (20464M used)
[    1.313648] amdgpu 0000:b1:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
[    1.313651] amdgpu 0000:b1:00.0: amdgpu: AGP: 267878400M 0x0000008800000000 - 0x0000FFFFFFFFFFFF
[    1.313663] [drm] Detected VRAM RAM=20464M, BAR=32768M
[    1.313664] [drm] RAM width 320bits GDDR6
[    1.313789] [drm] amdgpu: 20464M of VRAM memory ready
[    1.313791] [drm] amdgpu: 95972M of GTT memory ready.
[    1.313808] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    1.313860] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
[    1.314248] [drm] Loading DMUB firmware via PSP: version=0x07001900
[    1.315053] [drm] Found VCN firmware Version ENC: 1.11 DEC: 5 VEP: 0 Revision: 12
[    1.315064] amdgpu 0000:b1:00.0: amdgpu: Will use PSP to load VCN firmware
[    1.439856] [drm] reserve 0x1300000 from 0x84fc000000 for PSP TMR
[    1.566749] amdgpu 0000:b1:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    1.566754] amdgpu 0000:b1:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    1.566783] amdgpu 0000:b1:00.0: amdgpu: smu driver if version = 0x0000003d, smu fw if version = 0x0000003b, smu fw program = 0, smu fw version = 0x004e5500 (78.85.0)
[    1.566792] amdgpu 0000:b1:00.0: amdgpu: SMU driver if version not matched
[    1.729641] amdgpu 0000:b1:00.0: amdgpu: SMU is initialized successfully!
[    1.730044] [drm] Display Core v3.2.247 initialized on DCN 3.2
[    1.730046] [drm] DP-HDMI FRL PCON supported
[    1.731900] [drm] DMUB hardware initialized: version=0x07001900
[    1.905275] tsc: Refined TSC clocksource calibration: 2499.999 MHz
[    1.905311] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240938fe3e8, max_idle_ns: 440795307177 ns
[    1.905417] clocksource: Switched to clocksource tsc
[    2.289869] [drm] kiq ring mec 3 pipe 1 q 0
[    2.296491] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[    2.296639] amdgpu 0000:b1:00.0: [drm:jpeg_v4_0_hw_init] JPEG decode initialized successfully.
[    2.299432] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.299449] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    2.299484] amdgpu: Virtual CRAT table created for GPU
[    2.299703] amdgpu: Topology: Add dGPU node [0x744c:0x1002]
[    2.299705] kfd kfd: amdgpu: added device 1002:744c
[    2.299717] amdgpu 0000:b1:00.0: amdgpu: SE 6, SH per SE 2, CU per SH 8, active_cu_number 84
[    2.299926] amdgpu 0000:b1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.299929] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.299930] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.299932] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.299933] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.299934] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.299936] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.299937] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.299939] amdgpu 0000:b1:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.299940] amdgpu 0000:b1:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
[    2.299941] amdgpu 0000:b1:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
[    2.299943] amdgpu 0000:b1:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.299944] amdgpu 0000:b1:00.0: amdgpu: ring vcn_unified_1 uses VM inv eng 1 on hub 8
[    2.299945] amdgpu 0000:b1:00.0: amdgpu: ring jpeg_dec uses VM inv eng 4 on hub 8
[    2.299946] amdgpu 0000:b1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 14 on hub 0
[    2.300767] [drm] ring gfx_32768.1.1 was added
[    2.301186] [drm] ring compute_32768.2.2 was added
[    2.301539] [drm] ring sdma_32768.3.3 was added
[    2.301594] [drm] ring gfx_32768.1.1 ib test pass
[    2.301644] [drm] ring compute_32768.2.2 ib test pass
[    2.301668] [drm] ring sdma_32768.3.3 ib test pass
[    2.302615] amdgpu 0000:b1:00.0: amdgpu: Using BACO for runtime pm
[    2.302921] [drm] Initialized amdgpu 3.54.0 20150101 for 0000:b1:00.0 on minor 0
[    2.326309] fbcon: amdgpudrmfb (fb0) is primary device
[    2.326857] [drm] DSC precompute is not needed.
[    2.677706] Console: switching to colour frame buffer device 240x75
[    2.712900] amdgpu 0000:b1:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    2.724072] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 1
[    2.724085] usbcore: registered new interface driver udl
[    2.729610] loop: module loaded
[    2.729780] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
[    2.729787] lpc_ich 0000:00:1f.0: No MFD cells added
[    2.730547] SCSI Media Changer driver v0.25 
[    2.731088] nvme nvme1: pci function 0000:87:00.0
[    2.731106] nvme nvme2: pci function 0000:3c:00.0
[    2.731166] nvme nvme3: pci function 0000:3d:00.0
[    2.731673] nvme nvme0: pci function 0000:3b:00.0
[    2.731845] nvme nvme4: pci function 0000:3e:00.0
[    2.732007] nvme nvme5: pci function 0000:5e:00.0
[    2.732183] nvme nvme6: pci function 0000:5f:00.0
[    2.732354] nvme nvme7: pci function 0000:60:00.0
[    2.732469] ahci 0000:00:11.5: version 3.0
[    2.732647] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.732651] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    2.735584] nvme nvme1: Shutdown timeout set to 10 seconds
[    2.737153] nvme nvme1: 4/0/4 default/read/poll queues
[    2.737503] nvme nvme3: missing or invalid SUBNQN field.
[    2.737671] nvme nvme3: Shutdown timeout set to 8 seconds
[    2.737701] nvme nvme4: missing or invalid SUBNQN field.
[    2.737857] nvme nvme4: Shutdown timeout set to 8 seconds
[    2.738493] nvme nvme1: Ignoring bogus Namespace Identifiers
[    2.738504] nvme nvme7: missing or invalid SUBNQN field.
[    2.738673] nvme nvme7: Shutdown timeout set to 8 seconds
[    2.740079]  nvme1n1: p1 p2 p3
[    2.740171] nvme nvme5: 40/0/4 default/read/poll queues
[    2.741563] nvme nvme2: missing or invalid SUBNQN field.
[    2.741747] nvme nvme2: Shutdown timeout set to 8 seconds
[    2.742166] nvme nvme0: 12/0/4 default/read/poll queues
[    2.748873] nvme nvme6: 40/0/4 default/read/poll queues
[    2.752592] scsi host0: ahci
[    2.752736] scsi host1: ahci
[    2.752891] scsi host2: ahci
[    2.753001] scsi host3: ahci
[    2.753143] scsi host4: ahci
[    2.753285] scsi host5: ahci
[    2.753321] ata1: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280100 irq 89
[    2.753324] ata2: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280180 irq 89
[    2.753326] ata3: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280200 irq 89
[    2.753327] ata4: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280280 irq 89
[    2.753329] ata5: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280300 irq 89
[    2.753331] ata6: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280380 irq 89
[    2.768236] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    2.768241] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    2.769920] nvme nvme4: 28/0/4 default/read/poll queues
[    2.773919] nvme nvme3: 28/0/4 default/read/poll queues
[    2.775272] nvme nvme7: 28/0/4 default/read/poll queues
[    2.776369] nvme nvme2: 28/0/4 default/read/poll queues
[    2.788721]  nvme7n1: p1 p2 p3
[    2.795056] scsi host6: ahci
[    2.795190] scsi host7: ahci
[    2.795343] scsi host8: ahci
[    2.795447] scsi host9: ahci
[    2.795595] scsi host10: ahci
[    2.795736] scsi host11: ahci
[    2.795841] scsi host12: ahci
[    2.795949] scsi host13: ahci
[    2.795987] ata7: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200100 irq 306
[    2.795990] ata8: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200180 irq 306
[    2.795992] ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200200 irq 306
[    2.795994] ata10: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200280 irq 306
[    2.795995] ata11: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200300 irq 306
[    2.795997] ata12: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200380 irq 306
[    2.795999] ata13: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 306
[    2.796000] ata14: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200480 irq 306
[    2.796457] e1000e: Intel(R) PRO/1000 Network Driver
[    2.796460] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.796599] igb: Intel(R) Gigabit Ethernet Network Driver
[    2.796601] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.796657] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    2.796658] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.796689] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    2.796690] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    3.062923] ata1: SATA link down (SStatus 0 SControl 300)
[    3.063495] ata4: SATA link down (SStatus 0 SControl 300)
[    3.063516] ata2: SATA link down (SStatus 0 SControl 300)
[    3.063534] ata3: SATA link down (SStatus 0 SControl 300)
[    3.063555] ata5: SATA link down (SStatus 0 SControl 300)
[    3.063590] ata6: SATA link down (SStatus 0 SControl 300)
[    3.064218] ixgbe 0000:18:00.0: Multiqueue Enabled: Rx Queue count = 40, Tx Queue count = 40 XDP Queue count = 0
[    3.103735] ata11: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103762] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103787] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103812] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103837] ata13: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103862] ata14: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103884] ata12: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.103904] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.104262] ata13.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    3.104283] ata14.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    3.105289] ata11.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.105324] ata10.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.105394] ata12.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    3.105526] ata11.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.105571] ata10.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.105631] ata12.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.105651] ata8.00: supports DRM functions and may not be fully accessible
[    3.105655] ata8.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    3.105833] ata9.00: supports DRM functions and may not be fully accessible
[    3.105839] ata9.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    3.106328] ata7.00: supports DRM functions and may not be fully accessible
[    3.106346] ata7.00: ATA-11: Samsung SSD 860 PRO 4TB, RVM01B6Q, max UDMA/133
[    3.107099] ata7.00: 8001573552 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.107218] ata11.00: configured for UDMA/133
[    3.107249] ata10.00: configured for UDMA/133
[    3.107312] ata12.00: configured for UDMA/133
[    3.110365] ata8.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.110510] ata7.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.110628] ata9.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.110937] ata7.00: supports DRM functions and may not be fully accessible
[    3.112351] ata14.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.112356] ata14.00: Features: NCQ-sndrcv NCQ-prio
[    3.112943] ata13.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.112950] ata13.00: Features: NCQ-sndrcv NCQ-prio
[    3.115335] ata7.00: configured for UDMA/133
[    3.115620] scsi 6:0:0:0: Direct-Access     ATA      Samsung SSD 860  1B6Q PQ: 0 ANSI: 5
[    3.115987] ata7.00: Enabling discard_zeroes_data
[    3.116006] sd 6:0:0:0: [sda] 8001573552 512-byte logical blocks: (4.10 TB/3.73 TiB)
[    3.116010] sd 6:0:0:0: Attached scsi generic sg0 type 0
[    3.116021] sd 6:0:0:0: [sda] Write Protect is off
[    3.116025] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.116044] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.116092] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.116373] ata7.00: Enabling discard_zeroes_data
[    3.117625] sd 6:0:0:0: [sda] supports TCG Opal
[    3.117631] sd 6:0:0:0: [sda] Attached SCSI disk
[    3.119841] ata8.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.120016] ata8.00: supports DRM functions and may not be fully accessible
[    3.120204] ata9.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    3.120388] ata9.00: supports DRM functions and may not be fully accessible
[    3.123875] ata14.00: configured for UDMA/133
[    3.125714] ata13.00: configured for UDMA/133
[    3.134298] ata8.00: configured for UDMA/133
[    3.134412] scsi 7:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    3.134564] sd 7:0:0:0: Attached scsi generic sg1 type 0
[    3.134595] ata9.00: configured for UDMA/133
[    3.134631] sd 7:0:0:0: [sdb] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    3.134645] sd 7:0:0:0: [sdb] Write Protect is off
[    3.134648] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.134666] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.134707] sd 7:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    3.134737] scsi 8:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    3.134942] sd 8:0:0:0: Attached scsi generic sg2 type 0
[    3.135002] sd 8:0:0:0: [sdc] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    3.135009] sd 8:0:0:0: [sdc] Write Protect is off
[    3.135011] sd 8:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.135019] sd 8:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.135035] sd 8:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[    3.135110] scsi 9:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.135365] sd 9:0:0:0: Attached scsi generic sg3 type 0
[    3.135418] sd 9:0:0:0: [sdd] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.135422] sd 9:0:0:0: [sdd] 4096-byte physical blocks
[    3.135433] sd 9:0:0:0: [sdd] Write Protect is off
[    3.135433] sd 7:0:0:0: [sdb] supports TCG Opal
[    3.135435] sd 7:0:0:0: [sdb] Attached SCSI disk
[    3.135436] sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    3.135455] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.135475] scsi 10:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.135479] sd 9:0:0:0: [sdd] Preferred minimum I/O size 4096 bytes
[    3.135678] sd 10:0:0:0: Attached scsi generic sg4 type 0
[    3.135704] sd 10:0:0:0: [sde] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.135707] sd 10:0:0:0: [sde] 4096-byte physical blocks
[    3.135712] sd 10:0:0:0: [sde] Write Protect is off
[    3.135713] sd 10:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    3.135721] sd 10:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.135731] sd 8:0:0:0: [sdc] supports TCG Opal
[    3.135734] sd 8:0:0:0: [sdc] Attached SCSI disk
[    3.135738] sd 10:0:0:0: [sde] Preferred minimum I/O size 4096 bytes
[    3.135794] scsi 11:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    3.135981] sd 11:0:0:0: Attached scsi generic sg5 type 0
[    3.136038] sd 11:0:0:0: [sdf] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.136042] sd 11:0:0:0: [sdf] 4096-byte physical blocks
[    3.136052] sd 11:0:0:0: [sdf] Write Protect is off
[    3.136055] sd 11:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    3.136073] sd 11:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.136098] sd 11:0:0:0: [sdf] Preferred minimum I/O size 4096 bytes
[    3.136109] scsi 12:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    3.136309] sd 12:0:0:0: Attached scsi generic sg6 type 0
[    3.136355] sd 12:0:0:0: [sdg] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.136361] sd 12:0:0:0: [sdg] Write Protect is off
[    3.136362] sd 12:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[    3.136371] sd 12:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.136383] sd 12:0:0:0: [sdg] Preferred minimum I/O size 512 bytes
[    3.136416] scsi 13:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    3.136616] sd 13:0:0:0: Attached scsi generic sg7 type 0
[    3.136671] sd 13:0:0:0: [sdh] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.136683] sd 13:0:0:0: [sdh] Write Protect is off
[    3.136685] sd 13:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[    3.136701] sd 13:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.136724] sd 13:0:0:0: [sdh] Preferred minimum I/O size 512 bytes
[    3.143121] sd 9:0:0:0: [sdd] Attached SCSI disk
[    3.148345] ixgbe 0000:18:00.0: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
[    3.155005] sd 11:0:0:0: [sdf] Attached SCSI disk
[    3.157410] sd 10:0:0:0: [sde] Attached SCSI disk
[    3.178099]  sdg: sdg1
[    3.178206] sd 12:0:0:0: [sdg] Attached SCSI disk
[    3.178661]  sdh: sdh1
[    3.178729] sd 13:0:0:0: [sdh] Attached SCSI disk
[    3.245553] ixgbe 0000:18:00.0: MAC: 3, PHY: 0, PBA No: G54042-008
[    3.245561] ixgbe 0000:18:00.0: 00:1b:21:e2:59:80
[    3.394929] ixgbe 0000:18:00.0: Intel(R) 10 Gigabit Network Connection
[    3.395163] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    3.395166] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    3.408732] i40e 0000:63:00.0: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[    3.412959] i40e 0000:63:00.0: MAC address: 00:25:90:be:7e:20
[    3.413289] i40e 0000:63:00.0: FW LLDP is enabled
[    3.420583] i40e 0000:63:00.0 eth1: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[    3.421067] i40e 0000:63:00.0: Added LAN device PF0 bus=0x63 dev=0x00 func=0x00
[    3.421958] i40e 0000:63:00.0: Features: PF-id[0] VFs: 32 VSIs: 34 QP: 40 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[    3.437204] i40e 0000:63:00.1: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[    3.441016] i40e 0000:63:00.1: MAC address: 00:25:90:be:7e:21
[    3.441326] i40e 0000:63:00.1: FW LLDP is enabled
[    3.448843] i40e 0000:63:00.1 eth2: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[    3.449341] i40e 0000:63:00.1: Added LAN device PF1 bus=0x63 dev=0x00 func=0x01
[    3.450253] i40e 0000:63:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 40 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[    3.450601] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.450639] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.451720] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    3.452088] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.452112] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.452114] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    3.452150] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    3.452153] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.452155] usb usb1: Product: xHCI Host Controller
[    3.452157] usb usb1: Manufacturer: Linux 6.6.0-andres-00003-g31255e072b2e xhci-hcd
[    3.452158] usb usb1: SerialNumber: 0000:00:14.0
[    3.452297] hub 1-0:1.0: USB hub found
[    3.452316] hub 1-0:1.0: 16 ports detected
[    3.453668] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    3.453671] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.453673] usb usb2: Product: xHCI Host Controller
[    3.453674] usb usb2: Manufacturer: Linux 6.6.0-andres-00003-g31255e072b2e xhci-hcd
[    3.453676] usb usb2: SerialNumber: 0000:00:14.0
[    3.453746] hub 2-0:1.0: USB hub found
[    3.453763] hub 2-0:1.0: 10 ports detected
[    3.454435] usb: port power management may be unreliable
[    3.454704] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    3.454736] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
[    3.509518] xhci_hcd 0000:02:00.0: hcc params 0x0200ef80 hci version 0x110 quirks 0x0000000000800010
[    3.509893] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    3.509919] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
[    3.509921] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    3.509960] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    3.509963] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.509965] usb usb3: Product: xHCI Host Controller
[    3.509966] usb usb3: Manufacturer: Linux 6.6.0-andres-00003-g31255e072b2e xhci-hcd
[    3.509968] usb usb3: SerialNumber: 0000:02:00.0
[    3.510035] hub 3-0:1.0: USB hub found
[    3.510041] hub 3-0:1.0: 2 ports detected
[    3.510112] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.510126] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    3.510128] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.510130] usb usb4: Product: xHCI Host Controller
[    3.510131] usb usb4: Manufacturer: Linux 6.6.0-andres-00003-g31255e072b2e xhci-hcd
[    3.510132] usb usb4: SerialNumber: 0000:02:00.0
[    3.510189] hub 4-0:1.0: USB hub found
[    3.510200] hub 4-0:1.0: 2 ports detected
[    3.510345] usbcore: registered new interface driver usb-storage
[    3.510382] i8042: PNP: No PS/2 controller found.
[    3.510490] mousedev: PS/2 mouse device common for all mice
[    3.510574] usbcore: registered new interface driver synaptics_usb
[    3.510629] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    3.510829] rtc_cmos 00:00: RTC can wake from S4
[    3.511247] rtc_cmos 00:00: registered as rtc0
[    3.511319] rtc_cmos 00:00: setting system clock to 2023-12-06T05:54:21 UTC (1701842061)
[    3.511345] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
[    3.511365] i2c_dev: i2c /dev entries driver
[    3.511668] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.511689] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.511728] pci 0000:00:1f.1: [8086:a1a0] type 00 class 0x058000
[    3.511765] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
[    3.511982] pci 0000:00:1f.1: Adding to iommu group 243
[    3.514129] i2c i2c-8: 12/16 memory slots populated (from DMI)
[    3.514132] i2c i2c-8: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    3.691295] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    3.809292] usb 3-2: new high-speed USB device number 2 using xhci_hcd
[    3.818218] usb 1-1: New USB device found, idVendor=1397, idProduct=0509, bcdDevice= 1.12
[    3.818222] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=0
[    3.818224] usb 1-1: Product: UMC404HD 192k
[    3.818226] usb 1-1: Manufacturer: BEHRINGER
[    3.933303] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    4.021092] usb 3-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.01
[    4.021102] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.021107] usb 3-2: Product: USB2.1 Hub
[    4.021110] usb 3-2: Manufacturer: Generic
[    4.026669] hub 3-2:1.0: USB hub found
[    4.028228] hub 3-2:1.0: 4 ports detected
[    4.059878] usb 1-7: New USB device found, idVendor=0557, idProduct=7000, bcdDevice= 0.00
[    4.059888] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.060777] hub 1-7:1.0: USB hub found
[    4.060967] hub 1-7:1.0: 4 ports detected
[    4.124639] usb 4-2: new SuperSpeed USB device number 2 using xhci_hcd
[    4.163554] usb 4-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.01
[    4.163565] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.163571] usb 4-2: Product: USB3.2 Hub
[    4.163574] usb 4-2: Manufacturer: Generic
[    4.169830] hub 4-2:1.0: USB hub found
[    4.173040] hub 4-2:1.0: 4 ports detected
[    4.326276] usb 3-2.2: new low-speed USB device number 3 using xhci_hcd
[    4.349299] usb 1-7.1: new low-speed USB device number 4 using xhci_hcd
[    4.438646] usb 1-7.1: New USB device found, idVendor=0557, idProduct=2419, bcdDevice= 1.00
[    4.438656] usb 1-7.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.513232] usb 3-2.2: New USB device found, idVendor=17ef, idProduct=6009, bcdDevice= 1.27
[    4.513242] usb 3-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.513247] usb 3-2.2: Product: ThinkPad USB Keyboard with TrackPoint
[    4.513251] usb 3-2.2: Manufacturer: Lite-On Technology Corp.
[    4.553319] power_meter ACPI000D:00: Found ACPI power meter.
[    4.553359] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    4.580825] usb 4-2.4: new SuperSpeed USB device number 3 using xhci_hcd
[    4.615699] usb 4-2.4: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.01
[    4.615703] usb 4-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.615705] usb 4-2.4: Product: USB3.2 Hub
[    4.615707] usb 4-2.4: Manufacturer: Generic
[    4.623287] hub 4-2.4:1.0: USB hub found
[    4.625791] hub 4-2.4:1.0: 4 ports detected
[    4.669471] i2c i2c-0: adapter quirk: no zero length (addr 0x0018, size 0, write)
[    4.678203] i2c i2c-0: adapter quirk: no zero length (addr 0x0019, size 0, write)
[    4.680239] usb 3-2.3: new high-speed USB device number 4 using xhci_hcd
[    4.686407] i2c i2c-0: adapter quirk: no zero length (addr 0x001a, size 0, write)
[    4.694600] i2c i2c-0: adapter quirk: no zero length (addr 0x001b, size 0, write)
[    4.702791] i2c i2c-0: adapter quirk: no zero length (addr 0x001c, size 0, write)
[    4.710977] i2c i2c-0: adapter quirk: no zero length (addr 0x001d, size 0, write)
[    4.719162] i2c i2c-0: adapter quirk: no zero length (addr 0x001e, size 0, write)
[    4.727349] i2c i2c-0: adapter quirk: no zero length (addr 0x001f, size 0, write)
[    4.735534] i2c i2c-1: adapter quirk: no zero length (addr 0x0018, size 0, write)
[    4.743725] i2c i2c-1: adapter quirk: no zero length (addr 0x0019, size 0, write)
[    4.757055] iTCO_wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[    4.757069] iTCO_vendor_support: vendor-support=0
[    4.757170] device-mapper: uevent: version 1.0.3
[    4.757253] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    4.757270] usbcore: registered new interface driver btusb
[    4.757435] EDAC igen6: v2.5.1
[    4.758346] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
[    4.758382] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
[    4.758416] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
[    4.758451] EDAC MC3: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
[    4.758455] intel_pstate: Intel P-state driver initializing
[    4.760405] intel_pstate: HWP enabled
[    4.760735] ledtrig-cpu: registered to indicate activity on CPUs
[    4.760942] pstore: backend 'erst' already in use: ignoring 'efi_pstore'
[    4.760963] hid: raw HID events driver (C) Jiri Kosina
[    4.762133] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.0/0003:0557:2419.0001/input/input2
[    4.775308] usb 3-2.3: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    4.775319] usb 3-2.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.781942] hub 3-2.3:1.0: USB hub found
[    4.781978] hub 3-2.3:1.0: 4 ports detected
[    4.813570] hid-generic 0003:0557:2419.0001: input,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-7.1/input0
[    4.814605] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.1/0003:0557:2419.0002/input/input3
[    4.814668] hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-7.1/input1
[    4.817693] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.0/0003:17EF:6009.0003/input/input4
[    4.867282] usb 3-2.4: new high-speed USB device number 5 using xhci_hcd
[    4.869531] hid-generic 0003:17EF:6009.0003: input,hidraw2: USB HID v1.10 Keyboard [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:02:00.0-2.2/input0
[    4.876346] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint Mouse as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input5
[    4.876412] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint System Control as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input6
[    4.928450] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint Consumer Control as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:17EF:6009.0004/input/input7
[    4.928662] hid-generic 0003:17EF:6009.0004: input,hiddev0,hidraw3: USB HID v1.10 Mouse [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:02:00.0-2.2/input1
[    4.928717] usbcore: registered new interface driver usbhid
[    4.928720] usbhid: USB HID core driver
[    4.931365] intel_rapl_common: Found RAPL domain package
[    4.931371] intel_rapl_common: Found RAPL domain dram
[    4.931377] intel_rapl_common: package-0:dram:long_term locked by BIOS
[    4.931696] intel_rapl_common: Found RAPL domain package
[    4.931714] intel_rapl_common: Found RAPL domain dram
[    4.931726] intel_rapl_common: package-1:dram:long_term locked by BIOS
[    4.934007] GACT probability on
[    4.934012] Mirror/redirect action on
[    4.934016] Simple TC action Loaded
[    4.934122] netem: version 1.3
[    4.934130] u32 classifier
[    4.934131]     Performance counters on
[    4.934131]     input device check on
[    4.934132]     Actions configured
[    4.959875] NET: Registered PF_INET6 protocol family
[    4.967240] Segment Routing with IPv6
[    4.967242] RPL Segment Routing with IPv6
[    4.967250] In-situ OAM (IOAM) with IPv6
[    4.967272] mip6: Mobile IPv6
[    4.967293] NET: Registered PF_PACKET protocol family
[    4.967295] NET: Registered PF_KEY protocol family
[    4.967301] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    4.967375] Bluetooth: RFCOMM TTY layer initialized
[    4.967378] Bluetooth: RFCOMM socket layer initialized
[    4.967382] Bluetooth: RFCOMM ver 1.11
[    4.967384] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.967385] Bluetooth: BNEP filters: protocol multicast
[    4.967387] Bluetooth: BNEP socket layer initialized
[    4.967388] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    4.967390] Bluetooth: HIDP socket layer initialized
[    4.967482] 8021q: 802.1Q VLAN Support v1.8
[    4.967540] Key type dns_resolver registered
[    4.971711] microcode: Microcode Update Driver: v2.2.
[    4.972603] resctrl: MB allocation detected
[    4.972607] resctrl: L3 monitoring detected
[    4.972617] IPI shorthand broadcast: enabled
[    4.972627] AVX2 version of gcm_enc/dec engaged.
[    4.972795] AES CTR mode by8 optimization enabled
[    4.978407] sched_clock: Marking stable (4976001174, 2190663)->(5054600809, -76408972)
[    4.978586] registered taskstats version 1
[    4.979116] Loading compiled-in X.509 certificates
[    4.980543] Key type .fscrypt registered
[    4.980544] Key type fscrypt-provisioning registered
[    4.980834] Btrfs loaded, zoned=yes, fsverity=no
[    4.980850] Key type big_key registered
[    4.982978] usb 3-2.4: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.01
[    4.982983] usb 3-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.982985] usb 3-2.4: Product: USB2.1 Hub
[    4.982987] usb 3-2.4: Manufacturer: Generic
[    4.983919] Key type encrypted registered
[    4.984408] printk: console [netcon0] enabled
[    4.984410] netconsole: network logging started
[    4.984989] RAS: Correctable Errors collector initialized.
[    4.985069] clk: Disabling unused clocks
[    4.985070] ALSA device list:
[    4.985072]   #0: Loopback 1
[    4.985073]   #1: Virtual MIDI Card 1
[    4.986115] Freeing unused kernel image (initmem) memory: 2812K
[    4.990443] hub 3-2.4:1.0: USB hub found
[    4.992162] hub 3-2.4:1.0: 4 ports detected
[    5.007390] Write protecting the kernel read-only data: 51200k
[    5.008136] Freeing unused kernel image (rodata/data gap) memory: 1740K
[    5.021959] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.021965] Run /init as init process
[    5.021967]   with arguments:
[    5.021968]     /init
[    5.021969]   with environment:
[    5.021970]     HOME=/
[    5.021970]     TERM=linux
[    5.021971]     BOOT_IMAGE=/vmlinuz-6.6.0-andres-00003-g31255e072b2e
[    5.021972]     apparmor=0
[    5.080201] usb 3-2.3.4: new full-speed USB device number 6 using xhci_hcd
[    5.209230] ixgbe 0000:18:00.0 en10gbe: renamed from eth0
[    5.228043] i40e 0000:63:00.1 enipmi: renamed from eth2
[    5.246542] i40e 0000:63:00.0 en1gbe: renamed from eth1
[    5.284559] md127: detected capacity change from 0 to 23441316864
[    5.346275] usb 3-2.4.1: new high-speed USB device number 7 using xhci_hcd
[    5.354276] usb 3-2.3.4: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=88.91
[    5.354287] usb 3-2.3.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    5.354293] usb 3-2.3.4: Product: CSR8510 A10
[    5.379615] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=6 rev=22bb
[    5.379620] Bluetooth: hci0: LMP ver=6 subver=22bb; manufacturer=10
[    5.434845] md0: detected capacity change from 0 to 15627538432
[    5.445166] usb 3-2.4.1: New USB device found, idVendor=046d, idProduct=085e, bcdDevice= 0.17
[    5.445177] usb 3-2.4.1: New USB device strings: Mfr=0, Product=2, SerialNumber=3
[    5.445183] usb 3-2.4.1: Product: Logitech BRIO
[    5.445187] usb 3-2.4.1: SerialNumber: 3852FD74
[    5.455947] power_meter ACPI000D:00: Found ACPI power meter.
[    5.455967] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[    5.531294] usb 3-2.4.3: new full-speed USB device number 8 using xhci_hcd
[    5.625334] 8021q: adding VLAN 0 to HW filter on device enipmi
[    5.792351] usb 3-2.4.3: New USB device found, idVendor=1050, idProduct=0407, bcdDevice= 5.12
[    5.792363] usb 3-2.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.792368] usb 3-2.4.3: Product: YubiKey OTP+FIDO+CCID
[    5.792372] usb 3-2.4.3: Manufacturer: Yubico
[    5.806188] pps pps0: new PPS source ptp2
[    5.806242] ixgbe 0000:18:00.0: registered PHC device on en10gbe
[    5.837350] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.4/3-2.4.3/3-2.4.3:1.0/0003:1050:0407.0005/input/input8
[    5.889653] hid-generic 0003:1050:0407.0005: input,hidraw4: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:02:00.0-2.4.3/input0
[    5.890315] hid-generic 0003:1050:0407.0006: hiddev1,hidraw5: USB HID v1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:02:00.0-2.4.3/input1
[    5.941830] 8021q: adding VLAN 0 to HW filter on device en10gbe
[    5.951770] 8021q: adding VLAN 0 to HW filter on device en1gbe
[    5.968288] usb 3-2.4.4: new full-speed USB device number 9 using xhci_hcd
[    6.230396] usb 3-2.4.4: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=24.11
[    6.230408] usb 3-2.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.230414] usb 3-2.4.4: Product: USB Receiver
[    6.230418] usb 3-2.4.4: Manufacturer: Logitech
[    6.267751] logitech-djreceiver 0003:046D:C52B.0009: hiddev2,hidraw6: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:02:00.0-2.4.4/input2
[    6.381966] input: Logitech MX Master 3 as /devices/pci0000:00/0000:00:1c.2/0000:02:00.0/usb3/3-2/3-2.4/3-2.4.4/3-2.4.4:1.2/0003:046D:C52B.0009/0003:046D:4082.000A/input/input9
[    6.382325] logitech-hidpp-device 0003:046D:4082.000A: input,hidraw7: USB HID v1.11 Keyboard [Logitech MX Master 3] on usb-0000:02:00.0-2.4.4/input2:1
[   10.569764] ixgbe 0000:18:00.0 en10gbe: NIC Link is Up 10 Gbps, Flow Control: None
[   57.889810] PM: Image not found (code -22)
[   57.920798] EXT4-fs (dm-3): mounted filesystem 0140b8fa-fc6e-444b-ba96-4449f7320b34 ro with writeback data mode. Quota mode: none.
[   57.938615] ixgbe 0000:18:00.0: removed PHC on en10gbe
[   58.515706] systemd[1]: systemd 255~rc4-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)

--mv2j6utfjb65nsuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.6.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (Debian 13.2.0-8) 13.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=130200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24150
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24150
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=124
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_WERROR=y
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION="-andres"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="error"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_SIG is not set
CONFIG_KEXEC_JUMP=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y
CONFIG_CRASH_MAX_MEMORY_RANGES=8192
# end of Kexec and crash features
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
# CONFIG_X86_USER_SHADOW_STACK is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SELECTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_PHYSICAL_START=0x200000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_ADDRESS_MASKING=y
CONFIG_HOTPLUG_CPU=y
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
# CONFIG_RETHUNK is not set
# CONFIG_CPU_IBPB_ENTRY is not set
# CONFIG_CPU_IBRS_ENTRY is not set
# CONFIG_SLS is not set
# CONFIG_GDS_FORCE_MITIGATION is not set
CONFIG_ARCH_HAS_ADD_PAGES=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=y
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=y
CONFIG_ACPI_ADXL=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_BXT_WC_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_WRUSS=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_PMD_MKWRITE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULE_COMPRESS_ZSTD=y
CONFIG_MODULE_DECOMPRESS=y
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB_DEPRECATED is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_RANDOM_KMALLOC_CACHES is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_HMM_MIRROR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_XGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=y
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=y
CONFIG_NF_CT_NETLINK_TIMEOUT=y
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_IPVS is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_TWOS=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_MQPRIO_LIB=y
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_FQ_PIE=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=y
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=y
CONFIG_NET_EMATCH_TEXT=y
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=y
CONFIG_NET_IFE_SKBMARK=y
CONFIG_NET_IFE_SKBPRIO=y
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
CONFIG_BT_AOSPEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_RTL=y
CONFIG_BT_QCA=m
CONFIG_BT_MTK=y
CONFIG_BT_HCIBTUSB=y
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_POLL_SYNC=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
CONFIG_BT_HCIUART_RTL=y
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
# CONFIG_BT_VIRTIO is not set
# CONFIG_BT_NXPUART is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=m
CONFIG_NET_9P_FD=m
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCIE_DW_PLAT_EP is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=m
# CONFIG_EFI_TEST is not set
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=y
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=y
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=3
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_BITMAP_FILE=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
CONFIG_DM_ERA=m
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
CONFIG_DM_DUST=m
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
# CONFIG_VXLAN is not set
CONFIG_GENEVE=m
# CONFIG_BAREUDP is not set
CONFIG_GTP=m
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
# CONFIG_NETCONSOLE_EXTENDED_LOG is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ASIX is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_CX_ECAT is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_DAVICOM is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
CONFIG_IGBVF=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_ADI is not set
# CONFIG_NET_VENDOR_LITEX is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WANGXUN is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88Q2XXX_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=m
# CONFIG_USB_NET_AX8817X is not set
# CONFIG_USB_NET_AX88179_178A is not set
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
CONFIG_USB_NET_AQC111=m
CONFIG_USB_RTL8153_ECM=m
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IBM_PANEL is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LEGACY_TIOCSTI is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_PERICOM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PCI1XXXX=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PCI=m
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_MOCK is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# CONFIG_GPIO_WHISKEY_COVE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_HS3001 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_MAX31827 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
# CONFIG_SENSORS_HP_WMI is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_WDAT_WDT=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CS42L43_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=y
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77541 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AW37503 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77857 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_RAA215300 is not set
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4803 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_RTQ2208 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
# CONFIG_CEC_GPIO is not set
CONFIG_CEC_SECO=m
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_S2255 is not set
# CONFIG_VIDEO_USBTV is not set
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
CONFIG_USB_MSI2500=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_INTEL_VSC is not set
# CONFIG_IPU_BRIDGE is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_UVC_COMMON=m
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_CAMERA_SENSOR=y
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV01A10 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8858 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9719 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Video and audio decoders
#

#
# Video serializers and deserializers
#
# end of Video serializers and deserializers

#
# SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_EXEC=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SUBALLOC_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_FP=y
CONFIG_DRM_AMD_SECURE_DISPLAY=y
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_LOONGSON is not set
# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DEVICE=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_UMP=m
# CONFIG_SND_UMP_LEGACY_RAWMIDI is not set
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_SEQ_UMP=y
CONFIG_SND_SEQ_UMP_CLIENT=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=y
# CONFIG_SND_PCMTEST is not set
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=10
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_MIDI_V2=y
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_SND_VIRTIO is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_STADIA_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_NVIDIA_SHIELD is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

CONFIG_I2C_HID=y
CONFIG_I2C_HID_ACPI=m
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_TCPCI_MAXIM=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_ANX7411=m
CONFIG_TYPEC_RT1719=m
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_WUSB3801=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=m
CONFIG_TYPEC_MUX_NB7VPQ904M=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AW200XX is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_PCA995X is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I7CORE=y
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_EDAC_SBRIDGE=y
CONFIG_EDAC_SKX=y
CONFIG_EDAC_I10NM=y
CONFIG_EDAC_PND2=y
CONFIG_EDAC_IGEN6=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_RP5C01 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IDXD_BUS=y
CONFIG_INTEL_IDXD=y
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=y
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=y
# CONFIG_UIO is not set
CONFIG_VFIO=m
# CONFIG_VFIO_DEVICE_CDEV is not set
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_VIRQFD=y

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
# end of VFIO support for PCI devices

CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=y
CONFIG_VIRTIO_PMEM=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VDPA=y
# CONFIG_VDPA_USER is not set
CONFIG_IFCVF=y
# CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
CONFIG_VP_VDPA=m
# CONFIG_ALIBABA_ENI_VDPA is not set
# CONFIG_SNET_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST_VDPA=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_LENOVO_YMC is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_TPMI=m
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TELEMETRY=m
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=m
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_INTEL_ISHTP_ECLITE=m
CONFIG_INTEL_MRFLD_PWRBTN=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SDSI is not set
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_TPMI=m
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_VSEC=m
# CONFIG_MSI_EC is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_SERIAL_MULTI_INSTANTIATE=m
# CONFIG_MLX_PLATFORM is not set
# CONFIG_X86_ANDROID_TABLETS is not set
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=m
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_SEL3350_PLATFORM is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_INTEL_MRFLD is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=m
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_INTEL_RAPL_TPMI=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_SCRUB_STATS=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set
# CONFIG_OVERLAY_FS_DEBUG is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
# CONFIG_TMPFS_QUOTA is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=y
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=m
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
# CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Hardening of kernel data structures
#
# CONFIG_LIST_HARDENED is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_JITTERENTROPY_TESTINTERFACE is not set
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
CONFIG_CRYPTO_STATS=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_4XXX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_SWIOTLB_DYNAMIC is not set
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_COMPRESSED_ZSTD is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_WQ_CPU_INTENSIVE_REPORT=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_FUNCTION_GRAPH_RETVAL=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_FPROBE_EVENTS=y
CONFIG_PROBE_EVENTS_BTF_ARGS=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_USER_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--mv2j6utfjb65nsuh--

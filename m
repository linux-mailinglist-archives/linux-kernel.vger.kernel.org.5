Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11068119B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379080AbjLMQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjLMQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:40:41 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761FDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:40:46 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:34198)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDSHq-000F5P-IN; Wed, 13 Dec 2023 09:40:42 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57650 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDSHp-007ayE-7B; Wed, 13 Dec 2023 09:40:42 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     James Gowans <jgowans@amazon.com>
Cc:     "Sean Christopherson" <seanjc@google.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Pavel Machek" <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexander Graf <graf@amazon.de>,
        "Jan H . Schoenherr" <jschoenh@amazon.de>
References: <20231213064004.2419447-1-jgowans@amazon.com>
Date:   Wed, 13 Dec 2023 10:39:52 -0600
In-Reply-To: <20231213064004.2419447-1-jgowans@amazon.com> (James Gowans's
        message of "Wed, 13 Dec 2023 08:40:04 +0200")
Message-ID: <874jgm9huv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rDSHp-007ayE-7B;;;mid=<874jgm9huv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+gZJHyqWjEBJwoHvIZu/SXC+PpnQcK/vQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;James Gowans <jgowans@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 786 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.1%), b_tie_ro: 8 (1.0%), parse: 1.37 (0.2%),
        extract_message_metadata: 51 (6.5%), get_uri_detail_list: 7 (0.8%),
        tests_pri_-2000: 79 (10.1%), tests_pri_-1000: 5.0 (0.6%),
        tests_pri_-950: 1.65 (0.2%), tests_pri_-900: 1.33 (0.2%),
        tests_pri_-90: 183 (23.3%), check_bayes: 172 (21.9%), b_tokenize: 22
        (2.8%), b_tok_get_all: 14 (1.8%), b_comp_prob: 6 (0.7%),
        b_tok_touch_all: 126 (16.0%), b_finish: 1.09 (0.1%), tests_pri_0: 436
        (55.5%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.5
        (0.3%), poll_dns_idle: 0.48 (0.1%), tests_pri_10: 2.8 (0.4%),
        tests_pri_500: 10 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Gowans <jgowans@amazon.com> writes:

> syscore_shutdown() runs driver and module callbacks to get the system
> into a state where it can be correctly shut down. In commit
> 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> syscore_shutdown() was removed from kernel_restart_prepare() and hence
> got (incorrectly?) removed from the kexec flow. This was innocuous until
> commit 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> changed the way that KVM registered its shutdown callbacks, switching from
> reboot notifiers to syscore_ops.shutdown. As syscore_shutdown() is
> missing from kexec, KVM's shutdown hook is not run and virtualisation is
> left enabled on the boot CPU which results in triple faults when
> switching to the new kernel on Intel x86 VT-x with VMXE enabled.
>
> Fix this by adding syscore_shutdown() to the kexec sequence. In terms of
> where to add it, it is being added after migrating the kexec task to the
> boot CPU, but before APs are shut down. It is not totally clear if this
> is the best place: in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> it is stated that "syscore_ops operations should be carried with one
> CPU on-line and interrupts disabled." APs are only offlined later in
> machine_shutdown(), so this syscore_shutdown() is being run while APs
> are still online. This seems to be the correct place as it matches where
> syscore_shutdown() is run in the reboot and halt flows - they also run
> it before APs are shut down. The assumption is that the commit message
> in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> is no longer valid.
>
> KVM has been discussed here as it is what broke loudly by not having
> syscore_shutdown() in kexec, but this change impacts more than just KVM;
> all drivers/modules which register a syscore_ops.shutdown callback will
> now be invoked in the kexec flow. Looking at some of them like x86 MCE
> it is probably more correct to also shut these down during kexec.
> Maintainers of all drivers which use syscore_ops.shutdown are added on
> CC for visibility. They are:
>
> arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
> arch/x86/kernel/cpu/mce/core.c	        .shutdown = mce_syscore_shutdown,
> arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
> drivers/irqchip/irq-i8259.c	        .shutdown = i8259A_shutdown,
> drivers/irqchip/irq-sun6i-r.c	        .shutdown = sun6i_r_intc_shutdown,
> drivers/leds/trigger/ledtrig-cpu.c	.shutdown = ledtrig_cpu_syscore_shutdown,
> drivers/power/reset/sc27xx-poweroff.c	.shutdown = sc27xx_poweroff_shutdown,
> kernel/irq/generic-chip.c	        .shutdown = irq_gc_shutdown,
> virt/kvm/kvm_main.c	                .shutdown = kvm_shutdown,
>
> This has been tested by doing a kexec on x86_64 and aarch64.

From the 10,000 foot perspective:
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric

> Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
>
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Alexander Graf <graf@amazon.de>
> Cc: Jan H. Schoenherr <jschoenh@amazon.de>
> ---
>  kernel/kexec_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..b926c4db8a91 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1254,6 +1254,7 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> +		syscore_shutdown();
>  
>  		/*
>  		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that

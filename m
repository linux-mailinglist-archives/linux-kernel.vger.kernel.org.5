Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C387CD04F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjJQXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:20:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79AFC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:20:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406402933edso60704905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697584799; x=1698189599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9pyZVaXRqwpqT4EHL+t2VBTLWYs4FebCCpvED/uf38=;
        b=cCyn5lJiMgbqbVTJ8+etzigz8yhgpRvj+6bYvP+mVrm7D17Rf/fC8b2zrjj8QhCR53
         IMfNhBMnGyRq+oj82TD/nfveqX9KikGFWqxLAfvbdbvP97rWCRLMAkQ8X2U2AQGFnJZ/
         IlNrEk9TJjQmpsJpJR6ETGKZ5epWhWFbK1qns1796o207YWoW97BZFhdBqPNuCtvMM5P
         mKl/jozsKfI3rMeM6U8myLHs85o2UrTrFBgle3rRExz6aU5j4ABWwGDHJa7P0VaLu+dD
         KGIyYn366XARDBeq63LFh8ON55jDR7ux2Y5JZ6fXiUGnq4k2JDzp7FT22oA0m3F55pbj
         YRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584799; x=1698189599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9pyZVaXRqwpqT4EHL+t2VBTLWYs4FebCCpvED/uf38=;
        b=jScwUxxxmERpW6+DE6HtOlhkh+tysJEcYRsymKHSh2CInh5Hw5HYhN5/AK6e5Q+ddm
         RxLk7fwZwerFK+aVjIWek+YeH2uZRV1HLiYf1u0chkphhD6zSXrnl0pam8XakLjibSEz
         cX+HUsWuI7AYP9ZdwWK3aLHMg4U8Ovc34+bTuYSoF5VB9nDgHJ4Ln7fkYp6gni+/yX78
         UdlTrFBNIFqzLv5HOm76UEycePWxTNIh8DJw2ulYKSmtStwmyLuuZ64qHfFbZdPajtAK
         RQa5AnKPHsUm3E0mwt1rsnZPbP23SQkdTAPQU4GohuAVmM7aAVZnwf2OLPNP7TLO8wHF
         TjVg==
X-Gm-Message-State: AOJu0YyjV3mNpTZxC/G/97ZXiRDzJ3Ry9caEHfagfZVvHAiMTozP7OvU
        Tgnx1EyQmtaYsNHX6Un2AOsiLw==
X-Google-Smtp-Source: AGHT+IFgtxHqfa3MfT53ir6NDVEURGNyLb9Mdt/B6aJHd8Qts5+X+pCfKl/8ANCZ8Ar0jGaC5mv2jg==
X-Received: by 2002:adf:f449:0:b0:32d:a98c:aa20 with SMTP id f9-20020adff449000000b0032da98caa20mr2505156wrp.59.1697584799023;
        Tue, 17 Oct 2023 16:19:59 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b0032d8034724esm734566wrx.94.2023.10.17.16.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 16:19:58 -0700 (PDT)
Message-ID: <bd0e29db-c8dd-4d1a-a898-69e0b8e6dc54@arista.com>
Date:   Wed, 18 Oct 2023 00:19:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>
References: <202310171606.30e15ebe-oliver.sang@intel.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <202310171606.30e15ebe-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 09:37, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c" on:
> 
> commit: df13d11e6a2a3cc5f973aca36f68f880fa42d55f ("[PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets")
> url: https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/net-tcp-Prepare-tcp_md5sig_pool-for-TCP-AO/20231010-071412
> patch link: https://lore.kernel.org/all/20231009230722.76268-9-dima@arista.com/
> patch subject: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-02
> 	nr_groups: 5
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310171606.30e15ebe-oliver.sang@intel.com
> 
> 
> [  221.348247][ T7133] BUG: sleeping function called from invalid context at net/core/sock.c:2978
> [  221.349875][ T7133] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 7133, name: trinity-c4
> [  221.351666][ T7133] preempt_count: 0, expected: 0
> [  221.352614][ T7133] RCU nest depth: 1, expected: 0
> [  221.353518][ T7133] 2 locks held by trinity-c4/7133:
> [ 221.354530][ T7133] #0: ed8b5660 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg (net/ipv4/tcp.c:1336) 
> [ 221.374314][ T7133] #1: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
> [  221.375906][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1

Quite puzzling. It doesn't seem that it can happen to inet6_csk_xmit():

:	rcu_read_lock();
:	skb_dst_set_noref(skb, dst);
:
:	/* Restore final destination back after routing done */
:	fl6.daddr = sk->sk_v6_daddr;
:
:	res = ip6_xmit(sk, skb, &fl6, sk->sk_mark, rcu_dereference(np->opt),
:		       np->tclass,  sk->sk_priority);
:	rcu_read_unlock();

So, I presumed the calltrace was for nested rcu_read_lock() case.
Then I've looked at all return/goto cases, I couldn't find any
unbalanced rcu_read_{,un}lock().

Is this reproducible by any chance?


> [  221.377820][ T7133] Call Trace:
> [ 221.378447][ T7133] dump_stack_lvl (lib/dump_stack.c:107) 
> [ 221.379373][ T7133] dump_stack (lib/dump_stack.c:114) 
> [ 221.380186][ T7133] __might_resched (kernel/sched/core.c:10188) 
> [ 221.381100][ T7133] __release_sock (include/linux/sched.h:2097 net/core/sock.c:2978) 
> [ 221.381960][ T7133] release_sock (net/core/sock.c:3520) 
> [ 221.382784][ T7133] inet_wait_for_connect (net/ipv4/af_inet.c:609) 
> [ 221.383763][ T7133] ? autoremove_wake_function (kernel/sched/wait.c:479) 
> [ 221.384757][ T7133] __inet_stream_connect (net/ipv4/af_inet.c:701 (discriminator 1)) 
> [ 221.385741][ T7133] ? kmalloc_node_trace (mm/slab_common.c:1133) 
> [ 221.386702][ T7133] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1026) 
> [ 221.387685][ T7133] tcp_sendmsg_locked (net/ipv4/tcp.c:1073) 
> [ 221.388642][ T7133] ? find_held_lock (kernel/locking/lockdep.c:5243) 
> [ 221.389536][ T7133] ? mark_held_locks (kernel/locking/lockdep.c:4273) 
> [ 221.390437][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
> [ 221.391359][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
> [ 221.392335][ T7133] tcp_sendmsg (net/ipv4/tcp.c:1336) 
> [ 221.393153][ T7133] inet6_sendmsg (net/ipv6/af_inet6.c:658 (discriminator 2)) 
> [ 221.394010][ T7133] ____sys_sendmsg (net/socket.c:730 net/socket.c:745 net/socket.c:2558) 
> [ 221.394927][ T7133] ___sys_sendmsg (net/socket.c:2612) 
> [ 221.395844][ T7133] __sys_sendmsg (net/socket.c:2641) 
> [ 221.396671][ T7133] __ia32_sys_sendmsg (net/socket.c:2648) 
> [ 221.397562][ T7133] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
> [ 221.398485][ T7133] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
> [ 221.399401][ T7133] do_SYSENTER_32 (arch/x86/entry/common.c:247) 
> [ 221.404363][ T7133] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
> [  221.405255][ T7133] EIP: 0xb7f59579
> [ 221.405931][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> All code
> ========
>    0:	b8 01 10 06 03       	mov    $0x3061001,%eax
>    5:	74 b4                	je     0xffffffffffffffbb
>    7:	01 10                	add    %edx,(%rax)
>    9:	07                   	(bad)
>    a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    e:	10 08                	adc    %cl,(%rax)
>   10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
>   2a:	5d                   	pop    %rbp
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	8d 76 00             	lea    0x0(%rsi),%esi
>   35:	58                   	pop    %rax
>   36:	b8 77 00 00 00       	mov    $0x77,%eax
>   3b:	cd 80                	int    $0x80
>   3d:	90                   	nop
>   3e:	8d                   	.byte 0x8d
>   3f:	76                   	.byte 0x76
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	ret
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	8d 76 00             	lea    0x0(%rsi),%esi
>    b:	58                   	pop    %rax
>    c:	b8 77 00 00 00       	mov    $0x77,%eax
>   11:	cd 80                	int    $0x80
>   13:	90                   	nop
>   14:	8d                   	.byte 0x8d
>   15:	76                   	.byte 0x76
> [  221.409527][ T7133] EAX: ffffffda EBX: 00000137 ECX: 01ce1580 EDX: 240449b4
> [  221.410805][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
> [  221.412147][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [  221.481648][ T7133]
> [  221.482194][ T7133] ================================================
> [  221.483377][ T7133] WARNING: lock held when returning to user space!
> [  221.484574][ T7133] 6.6.0-rc4-01105-gdf13d11e6a2a #1 Tainted: G        W       TN
> [  221.485904][ T7133] ------------------------------------------------
> [  221.487044][ T7133] trinity-c4/7133 is leaving the kernel with locks still held!
> [  221.488448][ T7133] 1 lock held by trinity-c4/7133:
> [ 221.489401][ T7133] #0: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
> [  221.491125][ T7133] ------------[ cut here ]------------
> [  221.501170][ T7133] Voluntary context switch within RCU read-side critical section!
> [ 221.501214][ T7133] WARNING: CPU: 1 PID: 7133 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [  221.504458][ T7133] Modules linked in: ipmi_msghandler uio_pdrv_genirq uio rtc_cmos processor fuse drm drm_panel_orientation_quirks configfs
> [  221.506701][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
> [ 221.508634][ T7133] EIP: rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [ 221.509684][ T7133] Code: e9 87 fe ff ff 8d 74 26 00 8b 41 2c 89 45 ec e9 16 ff ff ff 8d 74 26 00 90 c6 05 09 88 94 c2 01 68 04 84 32 c2 e8 47 14 f5 ff <0f> 0b 5a e9 b0 fd ff ff 8d b4 26 00 00 00 00 81 e2 ff ff ff 7f 0f
> All code
> ========
>    0:	e9 87 fe ff ff       	jmp    0xfffffffffffffe8c
>    5:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>    9:	8b 41 2c             	mov    0x2c(%rcx),%eax
>    c:	89 45 ec             	mov    %eax,-0x14(%rbp)
>    f:	e9 16 ff ff ff       	jmp    0xffffffffffffff2a
>   14:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   18:	90                   	nop
>   19:	c6 05 09 88 94 c2 01 	movb   $0x1,-0x3d6b77f7(%rip)        # 0xffffffffc2948829
>   20:	68 04 84 32 c2       	push   $0xffffffffc2328404
>   25:	e8 47 14 f5 ff       	call   0xfffffffffff51471
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	5a                   	pop    %rdx
>   2d:	e9 b0 fd ff ff       	jmp    0xfffffffffffffde2
>   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   39:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
>   3f:	0f                   	.byte 0xf
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	5a                   	pop    %rdx
>    3:	e9 b0 fd ff ff       	jmp    0xfffffffffffffdb8
>    8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    f:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
>   15:	0f                   	.byte 0xf
> [  221.513148][ T7133] EAX: 00000000 EBX: e52d7c40 ECX: 00000000 EDX: 00000000
> [  221.514443][ T7133] ESI: 00000000 EDI: eadb5640 EBP: ead7df28 ESP: ead7df10
> [  221.515747][ T7133] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> [  221.517184][ T7133] CR0: 80050033 CR2: 01ce68cc CR3: 2ae6f000 CR4: 00000690
> [  221.518449][ T7133] Call Trace:
> [ 221.519074][ T7133] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
> [ 221.519826][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [ 221.520887][ T7133] ? __warn (kernel/panic.c:673) 
> [ 221.521663][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [ 221.522722][ T7133] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> [ 221.523615][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 221.524517][ T7133] ? handle_bug (arch/x86/kernel/traps.c:216) 
> [ 221.525240][ T7133] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
> [ 221.526115][ T7133] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
> [ 221.527035][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 221.527882][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [ 221.528945][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 221.529743][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> [ 221.530784][ T7133] __schedule (arch/x86/include/asm/preempt.h:80 (discriminator 3) kernel/sched/core.c:556 (discriminator 3) kernel/sched/sched.h:1372 (discriminator 3) kernel/sched/sched.h:1681 (discriminator 3) kernel/sched/core.c:6612 (discriminator 3)) 
> [ 221.531573][ T7133] ? exit_to_user_mode_prepare (kernel/entry/common.c:158 kernel/entry/common.c:204) 
> [ 221.532627][ T7133] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6772 (discriminator 1)) 
> [ 221.533358][ T7133] exit_to_user_mode_prepare (kernel/entry/common.c:161 kernel/entry/common.c:204) 
> [ 221.534382][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
> [ 221.535255][ T7133] irqentry_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:311) 
> [ 221.536302][ T7133] irqentry_exit (kernel/entry/common.c:445) 
> [ 221.537101][ T7133] sysvec_reschedule_ipi (arch/x86/kernel/smp.c:269) 
> [ 221.538079][ T7133] handle_exception (arch/x86/entry/entry_32.S:1056) 
> [  221.538990][ T7133] EIP: 0xb7f59579
> [ 221.539674][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> All code
> ========
>    0:	b8 01 10 06 03       	mov    $0x3061001,%eax
>    5:	74 b4                	je     0xffffffffffffffbb
>    7:	01 10                	add    %edx,(%rax)
>    9:	07                   	(bad)
>    a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    e:	10 08                	adc    %cl,(%rax)
>   10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
>   2a:	5d                   	pop    %rbp
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	8d 76 00             	lea    0x0(%rsi),%esi
>   35:	58                   	pop    %rax
>   36:	b8 77 00 00 00       	mov    $0x77,%eax
>   3b:	cd 80                	int    $0x80
>   3d:	90                   	nop
>   3e:	8d                   	.byte 0x8d
>   3f:	76                   	.byte 0x76
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	ret
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	8d 76 00             	lea    0x0(%rsi),%esi
>    b:	58                   	pop    %rax
>    c:	b8 77 00 00 00       	mov    $0x77,%eax
>   11:	cd 80                	int    $0x80
>   13:	90                   	nop
>   14:	8d                   	.byte 0x8d
>   15:	76                   	.byte 0x76
> [  221.543249][ T7133] EAX: ffffff91 EBX: 00000137 ECX: bfc205fc EDX: b7f59579
> [  221.544585][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
> [  221.545872][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [ 221.547230][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
> [  221.548133][ T7133] irq event stamp: 10576
> [ 221.548909][ T7133] hardirqs last enabled at (10575): _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
> [ 221.550576][ T7133] hardirqs last disabled at (10576): exit_to_user_mode_prepare (include/linux/entry-common.h:191 kernel/entry/common.c:181 kernel/entry/common.c:204) 
> [ 221.552434][ T7133] softirqs last enabled at (10570): release_sock (net/core/sock.c:3528) 
> [ 221.553958][ T7133] softirqs last disabled at (10568): release_sock (net/core/sock.c:3517) 
> [  221.555538][ T7133] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231017/202310171606.30e15ebe-oliver.sang@intel.com
> 
> 
> 

Thanks,
             Dmitry


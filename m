Return-Path: <linux-kernel+bounces-102796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DF87B766
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1D7B20A84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB9C157;
	Thu, 14 Mar 2024 05:48:21 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6432DDA7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395301; cv=none; b=ecT/kRioe1wdSjUlZXC3R21JvzjXF4RCd57+53GErwBdhDZ7pKb/KkYv6vk48eKnngi9h4OrdzlAwHgW+SzLROA8PoB1tr8KAAq5LXKPTuWX6n2+8YKcoU2rdBwTtzNXnaptqQVpAPgizJtQ7jvVV3ioAl1l9rSdQLD2P5DK6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395301; c=relaxed/simple;
	bh=0ezp/7WdTENKpTy0Whv2aOHefOVuHs3x/Y2PMZuoSQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dy/Osb0gUKXyT9ErfIqz4IWpWrqdYeU5mV8bV8Z9L7+h8FusvrKhIua3QoRoedxKKI3++D+cDW8wZx+7+QUJL+i8YUHEB0B7AiWciAeL/fxYstgu5tk7wKYiMHss4NzrDiqFJQUux3IhJnSqgrJ90bT6JMl76DELznMHciDvHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp66t1710395257t795nqjw
X-QQ-Originating-IP: EtXU75Fm3LcUIiZJQd1ZpmT+4Ld5/cLVHkyLy7JTGMs=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Mar 2024 13:47:35 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 90EFqYDyPxDBW2LafaqRuqDBYWenM5Dowt+D8DWXg2/pxNXsxDf/1j3SO8Rh7
	Y+pqTYKJyTHjmhfyT899YuvNQGaR4oT7L9RQqkeYEr6ikz79J6DJJdw2j/zysK0qxyz1bGL
	ZK+04nwgYbMOjmybXyHeVGe/ZK6ZIQGt2D0A4qTcw/wRpzIkVbIjD1zV4fEL2Fo+qEtrFye
	8bQ0Y63BtsC6zCkKDjqG1DRN8zDxd0YsMglx9qvXLDO53i5ejlQd6t4PKOmCMCsu2emh36z
	XHY0GLRZs8iiU0jUX2MwbyFDeIxBNBYwApnfSImiTNqGaUa1F7UhI7kcIkeiWf50Az3h8YZ
	L4jvK0hiS2Kjr5aakiSKvn1PNQ5t9EW+ScPD/FnX9JurVj1qRQmRtOR511/fDKctAKV3hW+
	3pYcAZCiLLXpIOq8/TAFGPwwgUz5bZ8d
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3674010246827021712
Date: Thu, 14 Mar 2024 13:47:35 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: apatel@ventanamicro.com
Cc: tglx@linutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, maz@kernel.org, bjorn@kernel.org,
	atishp@atishpatra.org, ajones@ventanamicro.com,
	sunilvl@ventanamicro.com, saravanak@google.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn
Subject: Re: [PATCH v16 0/9] Linux RISC-V AIA Support
Message-ID: <343C92ABCFEE9906+ZfKPd/boCT8RAr3f@centos8>
Reply-To: 20240307140307.646078-1-apatel@ventanamicro.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Anup,

Thanks for the great work on AIA!

Firstly I must apologize for the top posting cuz I miss the series mail for
my inbox. And for the record, I am replying to [1].

After I checkout riscv_aia_v16 branch at https://github.com/avpatel/linux.git,
some call traces about spurious interrupt are screaming:

[    1.244292] irq 11: nobody cared (try booting with the "irqpoll" option)
[    1.244707] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc6-00055-gd7d4d086b79a #14
[    1.244932] Hardware name: riscv-virtio,qemu (DT)
[    1.245130] Call Trace:
[    1.245337] [<ffffffff80005f32>] dump_backtrace+0x1c/0x24
[    1.245559] [<ffffffff809023f4>] show_stack+0x2c/0x38
[    1.245761] [<ffffffff8090ec8c>] dump_stack_lvl+0x3c/0x54
[    1.245979] [<ffffffff8090ecb8>] dump_stack+0x14/0x1c
[    1.246116] [<ffffffff8090368c>] __report_bad_irq+0x3e/0xae
[    1.246276] [<ffffffff8006a938>] note_interrupt+0x1f4/0x23e
[    1.246382] [<ffffffff800679e2>] handle_irq_event_percpu+0x42/0x50
[    1.246508] [<ffffffff80067a2c>] handle_irq_event+0x3c/0x68
[    1.246628] [<ffffffff8006b7a4>] handle_fasteoi_irq+0xac/0x176
[    1.246788] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
[    1.246928] [<ffffffff80473f0e>] imsic_handle_irq+0x72/0x12a
[    1.247041] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
[    1.247165] [<ffffffff80472470>] riscv_intc_aia_irq+0x26/0x38
[    1.247291] [<ffffffff8090ed0a>] handle_riscv_irq+0x4a/0x74
[    1.247430] [<ffffffff80918af6>] call_on_irq_stack+0x32/0x40
[    1.247626] handlers:
[    1.247721] [<000000004ebb6fe3>] vm_interrupt
[    1.248314] Disabling IRQ #11
[    1.303510] irq 12: nobody cared (try booting with the "irqpoll" option)
[    1.303700] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc6-00055-gd7d4d086b79a #14
[    1.304768] Hardware name: riscv-virtio,qemu (DT)
[    1.305460] Call Trace:
[    1.305868] [<ffffffff80005f32>] dump_backtrace+0x1c/0x24
[    1.306621] [<ffffffff809023f4>] show_stack+0x2c/0x38
[    1.307295] [<ffffffff8090ec8c>] dump_stack_lvl+0x3c/0x54
[    1.308025] [<ffffffff8090ecb8>] dump_stack+0x14/0x1c
[    1.308698] [<ffffffff8090368c>] __report_bad_irq+0x3e/0xae
[    1.309698] [<ffffffff8006a938>] note_interrupt+0x1f4/0x23e
[    1.310568] [<ffffffff800679e2>] handle_irq_event_percpu+0x42/0x50
[    1.311542] [<ffffffff80067a2c>] handle_irq_event+0x3c/0x68
[    1.312298] [<ffffffff8006b7a4>] handle_fasteoi_irq+0xac/0x176
[    1.313127] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
[    1.315375] [<ffffffff80473f0e>] imsic_handle_irq+0x72/0x12a
[    1.316163] [<ffffffff80066c3c>] generic_handle_domain_irq+0x1c/0x2a
[    1.317078] [<ffffffff80472470>] riscv_intc_aia_irq+0x26/0x38
[    1.318036] [<ffffffff8090ed0a>] handle_riscv_irq+0x4a/0x74
[    1.318934] [<ffffffff8090f3e6>] do_irq+0x4a/0x4c
[    1.319831] [<ffffffff809189ac>] ret_from_exception+0x0/0x64
[    1.320860] [<ffffffff8091845c>] _raw_spin_unlock_irqrestore+0x1a/0x2e
[    1.321887] [<ffffffff80473d06>] imsic_local_timer_callback+0x50/0x5c
[    1.322957] [<ffffffff8008ade4>] call_timer_fn.isra.0+0x14/0x5e
[    1.323781] [<ffffffff8008b44a>] run_timer_softirq+0x388/0x3a8
[    1.324579] [<ffffffff80918c7e>] __do_softirq+0x100/0x252
[    1.325304] [<ffffffff80018464>] irq_exit_rcu+0x7c/0xa6
[    1.326126] [<ffffffff8090ed24>] handle_riscv_irq+0x64/0x74
[    1.327535] [<ffffffff80918af6>] call_on_irq_stack+0x32/0x40
[    1.328703] handlers:
[    1.330724] [<000000008b6c4f15>] serial8250_interrupt
[    1.331573] Disabling IRQ #12
[    1.350231] Run /sbin/init as init process

And I take a look on /proc/interrupts, spurious interrupts are happening:
~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12      CPU13      CPU14      CPU15
 10:         83        222        350        163         71        101        193         68         54         60        174         50         51         48         48         46  RISC-V INTC   5 Edge      riscv-timer
 11:     100001          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  APLIC-MSI-d000000.aplic   8 Level   -fasteoi   virtio0
 12:          0     100000          0          0          0          0          0          0          0          0          0          0          0          0          0          0  APLIC-MSI-d000000.aplic  10 Level   -fasteoi   ttyS0
 13:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  APLIC-MSI-d000000.aplic  11 Level   -fasteoi   101000.rtc
IPI0:         3          8          4          7          7          6          5          4          7          7          7          5          6         10          4          5  Rescheduling interrupts
IPI1:       727        517        431        448        497        456        514        476        488        466        455        456        443        443        439        433  Function call interrupts
IPI2:         0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  CPU stop interrupts
IPI3:         0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IRQ work interrupts
IPI5:         0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  Timer broadcast interrupts

But when I switched back to V15, everything is fine.

Here are some of info _maybe_ helpful:
kernel: d7d4d086b79a11ad8bbcaf732c7830faa3f3192f
qemu: e1007b6bab5cf97705bf4f2aaec1f607787355b8
qemu cmdline: qemu-system-riscv64 -M virt,aia=aplic-imsic -m 256M -nographic -kernel ~/src/linux/arch/riscv/boot/Image -drive file=rootfs.img,format=raw,id=hd0  -device virtio-blk-device,drive=hd0 -append "root=/dev/vda rw console=ttyS0" -smp 16
config: defconfig(make ARCH=riscv defconfig)

And I am happy to provide any extra info if needed.

After I take a git diff and check your changelog:
[Quoting from [1]]
 - Simplified aplic_msi_irq_eoi() in PATCH7 based on the section "4.9.2 Special
   consideration for level-sensitive interrupt sources"  of the RISC-V AIA
   specification and also provided handler name.

I apologize if I miss something.

[1] https://lore.kernel.org/lkml/20240307140307.646078-1-apatel@ventanamicro.com/

Thanks,

        Dawei



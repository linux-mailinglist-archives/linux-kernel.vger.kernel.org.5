Return-Path: <linux-kernel+bounces-125508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFF892793
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B631F26970
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B113E3F1;
	Fri, 29 Mar 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqkpPQyj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03124B21
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753539; cv=none; b=obEQ3CZeO6PPZcS5opMneYAyOimCuFB3vlnAnikeCIyJJyjb+3QaobCqNPARxK08dUpCusDigat+p8HDAKuDQzUvCYE8++LXxqsrPbHRipSAdSZ7fxUd0avQm/lDdJrlNSN0/ji4+Rapn75+fMv3d2BXWnWuOqC1KvthH8gYuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753539; c=relaxed/simple;
	bh=xr7aoD9BBAIrF7GHwgB3+voIIJ9KCgFWSVbUoDGSnbg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BsNgfwD/FYFJrhVG6v0Ge5tOjumSvHjHXzuWyvT7WEflvE/DyIsnpEwwwqaTC8/a5OwljXwtD4Q0ZQODfU4JfXuJ4CiuV2q+jscXbCU6g4mP1SDmrcfqtMXfpiC29iNz9P84mq3HLYIjSihI/8/kn64dGUWiQyqewqaj65/ME2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqkpPQyj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61452c774e9so7113647b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711753536; x=1712358336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MngTXZjwmq7Soz5FWqSkdNJGx4aonR+/4uz11tnmLZ0=;
        b=gqkpPQyjWsJ2PyR1wBtVTyDoVzgEARDj8joCa+VN/fz7mE/6OLxNbz3AIj/o21keyp
         VGOiPNMJOpFuplSmqCeHUESmJnRArMQcuQScbR+2kqhmvUiv+MbuQHK+RSmP7JMOTX4i
         NeoNS012z5NQus9Ven0zuDf22GfUuNtpb+TK3gyAYTi2N07ySiKdTCka5CWvY4zBQXi+
         bhLxj7hdyzMpnrG+Kx/2RzhrElAXcA5gxUXiuwL2k2xC+ebdglqRCTKeyZ3+3segAVZd
         ujueHUsoSc4QSjHU2AmeYsHXMebPbU8UfgxQn4t5FdlTKMoe+0Q+7ksu86sC5Z7n5NCx
         8upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711753536; x=1712358336;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MngTXZjwmq7Soz5FWqSkdNJGx4aonR+/4uz11tnmLZ0=;
        b=ms73rEKzgzmQiobOnZd9/u7DIyNc/NWfeYE3WBlF+EK0FG4vbbnrEZ99K15xz4r2C8
         73xcPLVtg11QpfNZXfERDHT6eMe2BsCT7Y5MN92FvuWhn8ipZXxZPfejfQvbyKc0VF6O
         o9cu0LAauUCUvlvjbs89f/nyg/n333Cc/8gYnqXWspCfhR0U4LZEWgyrnGCX+B9m5QdD
         S0Tv4a3buELt+NBJC5gRtTxE0NVMTQgyXRSiTf8WxLfkz3TQoI0txQLnm/+dk+tBfTe3
         FzkJC0JPhA43u+yar6dO3nCcm3lrNcuCyRChKaG/8b6xikZhbIPZ2rvwToZkxceDkEiz
         yh1g==
X-Gm-Message-State: AOJu0Yw3A3MOgTMt8RyD2Hq+zu1QbCZBQ1sYW977HZU1pdSwoqYVeiw3
	p0vkqLMqb2VOXP0jvs0XJs8yxe2JcCzLaBTm5gJinA1QPjoVbY/NMfnBxuoJ0AKK/p+LYJxP4GL
	cWXExs1y61GUDlyLvzPYpDJCyduw=
X-Google-Smtp-Source: AGHT+IGaWupsgeUVbejAgxll6e5k9vDiVOojEYv3f3jw1iqNcIthzJlX+A+YZcXg4RRR/vTkCr958AeubBnD0TkOrD0=
X-Received: by 2002:a25:28a:0:b0:dd1:398b:3f33 with SMTP id
 132-20020a25028a000000b00dd1398b3f33mr3356551ybc.16.1711753536288; Fri, 29
 Mar 2024 16:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Fri, 29 Mar 2024 18:05:00 -0500
Message-ID: <CALaQ_hqpbcaBhycO=+vC5k2LXFpzp=6VQFWx9EfP6HZM_jERkQ@mail.gmail.com>
Subject: Allmodconfig - logic_outb - Boot Panic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

*****
[  118.083889][    T1] ------------[ cut here ]------------
[  118.084765][    T1] ODEBUG: free active (active state 0) object:
(____ptrval____) object type: timer_list hint:
kobject_delayed_cleanup+0x0/0x2c0
[  118.090507][    T1] WARNING: CPU: 5 PID: 1 at
lib/debugobjects.c:517 __debug_check_no_obj_freed+0x370/0x484
[  118.091963][    T1] Modules linked in:
[  118.092729][    T1] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
W       T  6.8.1 #2 f0b7e13f202916e57e1ff5697596a7b6ecdce1cf
[  118.094563][    T1] Hardware name: radxa Radxa ROCK 5 Model B/Radxa
ROCK 5 Model B, BIOS 2024.04-rc5-ga5ec56ae 04/01/2024
[  118.096128][    T1] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[  118.097317][    T1] pc : __debug_check_no_obj_freed+0x370/0x484
[  118.098253][    T1] lr : __debug_check_no_obj_freed+0x370/0x484
[  118.099223][    T1] sp : ffff80008768b5f0
[  118.099895][    T1] x29: ffff80008768b610 x28: ffff8000875b11e0
x27: ffff800083749844
[  118.101155][    T1] x26: 0000000000000002 x25: dead000000000100
x24: ffff0000039618a8
[  118.102583][    T1] x23: 0000000000000000 x22: ffff80008386b0c0
x21: ffff000003962000
[  118.103959][    T1] x20: ffff000003961000 x19: ffff000003961800
x18: ffff8000876650b8
[  118.105224][    T1] x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000
[  118.106558][    T1] x14: 0000000000000000 x13: 0000000000000000
x12: 0000000000000000
[  118.107829][    T1] x11: 0000000000000000 x10: 0000000000000000 x9
: 0000000000000000
[  118.109242][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6
: 0000000000000000
[  118.110667][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3
: 0000000000000000
[  118.111980][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0
: 0000000000000000
[  118.113387][    T1] Call trace:
[  118.113902][    T1]  __debug_check_no_obj_freed+0x370/0x484
[  118.114815][    T1]  debug_check_no_obj_freed+0x4c/0x7c
[  118.115659][    T1]  slab_free+0xa8/0x1c4
[  118.116344][    T1]  kfree+0xbc/0x1bc
[  118.117015][    T1]  extcon_dev_free+0x38/0x80
[  118.117747][    T1]  devm_extcon_dev_release+0x40/0x80
[  118.118656][    T1]  devres_release_all+0x11c/0x1bc
[  118.119594][    T1]  really_probe+0x1c8/0xbc0
[  118.120300][    T1]  __driver_probe_device+0x1c4/0x304
[  118.121160][    T1]  driver_probe_device+0x9c/0x340
[  118.122046][    T1]  __driver_attach+0x354/0x580
[  118.122763][    T1]  bus_for_each_dev+0x1c0/0x280
[  118.123496][    T1]  driver_attach+0x50/0x80
[  118.124179][    T1]  bus_add_driver+0x2a8/0x4c0
[  118.124982][    T1]  driver_register+0x178/0x280
[  118.125822][    T1]  __platform_driver_register+0x64/0xc0
[  118.126755][    T1]  rockchip_usb2phy_driver_init+0x3c/0x80
[  118.127699][    T1]  do_one_initcall+0x1e0/0x900
[  118.128506][    T1]  do_initcall_level+0x118/0x204
[  118.129294][    T1]  do_initcalls+0xb4/0x180
[  118.130109][    T1]  do_basic_setup+0xa0/0xc0
[  118.130937][    T1]  kernel_init_freeable+0x2b0/0x500
[  118.131851][    T1]  kernel_init+0x3c/0x37c
[  118.132574][    T1]  ret_from_fork+0x10/0x40
[  118.133370][    T1] irq event stamp: 3447975
[  118.134074][    T1] hardirqs last  enabled at (3447974):
[<ffff8000802a872c>] console_unlock+0x168/0x480
[  118.135460][    T1] hardirqs last disabled at (3447975):
[<ffff8000837b05e4>] el1_dbg+0x24/0xc0
[  118.136921][    T1] softirqs last  enabled at (3447541):
[<ffff800080011bcc>] __do_softirq+0x5c8/0x67c
[  118.138284][    T1] softirqs last disabled at (3447534):
[<ffff80008001c0f0>] ____do_softirq+0x2c/0x80
[  118.139820][    T1] ---[ end trace 0000000000000000 ]---
[  118.171454][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.171656][    T1] kobject: 'phy' ((____ptrval____)):
kobject_release, parent 0000000000000000 (delayed 750)
[  118.174542][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.176133][    T1] kobject: 'phy-fee80000.phy.3'
((____ptrval____)): kobject_release, parent 0000000000000000 (delayed
1000)
[  118.310226][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.310440][    T1] kobject: 'bcm281xx-pinctrl' ((____ptrval____)):
kobject_release, parent (____ptrval____) (delayed 500)
[  118.462398][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.463966][    T1] kobject: 'armada-37xx-pinctrl'
((____ptrval____)): kobject_release, parent (____ptrval____) (delayed
500)
[  118.732685][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.732894][    T1] kobject: 'gpio_aspeed_sgpio'
((____ptrval____)): kobject_release, parent (____ptrval____) (delayed
1000)
[  118.783573][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.783727][    T1] kobject: 'gef-gpio' ((____ptrval____)):
kobject_release, parent (____ptrval____) (delayed 500)
[  118848329][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.848540][    T1] kobject: 'rda-gpio' ((____ptrval____)):
kobject_release, parent (____ptrval____) (delayed 500)
[  118.948097][    T1] random: get_random_u8 called from
kfence_guarded_alloc+0x5c/0xac4 with crng_init=0
[  118.956939][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  118.957088][    T1] kobject: 'stmpe-pwm' ((____ptrval____)):
kobject_release, parent (____ptrval____) (delayed 500)
[  118.970119][    T1] shpchp: Standard Hot Plug PCI Controller Driver
version: 0.4
[  119.165485][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  119.165645][    T1] kobject: 'layerscape-pcie-ep'
((____ptrval____)): kobject_release, parent (____ptrval____) (delayed
250)
[  119.270016][    T1] random: get_random_u8 called from
kobject_put+0x128/0x280 with crng_init=0
[  119.270165][    T1] kobject: 'layerscape-pcie-gen4'
((____ptrval____)): kobject_release, parent (____ptrval____) (delayed
750)
[  119.289787][    T2] random: get_random_u64 called from
dup_task_struct+0x42c/0x700 with crng_init=0
[  119.300973][    T1] EINJ: ACPI disabled.
[  119.305390][    T1] isapnp: Scanning for PnP cards...
[  119.306184][    T1] Unable to handle kernel paging request at
virtual address fffffbfffe800279
[  119.307746][    T1] Mem abort info:
[  119.308431][    T1]   ESR = 0x0000000096000046
[  119.309150][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
[  119.310390][    T1]   SET = 0, FnV = 0
[  119.311226][    T1]   EA = 0, S1PTW = 0
[  119.311893][    T1]   FSC = 0x06: level 2 translation fault
[  119.312883][    T1] Data abort info:
[  119.313516][    T1]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
[  119.314467][    T1]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  119.315553][    T1]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  119.316547][    T1] swapper pgtable: 4k pages, 48-bit VAs,
pgdp=00000000d6486000
[  119.317836][    T1] [fffffbfffe800279] pgd=00000000d7aee003,
p4d=00000000d7aee003, pud=00000000d7aed003, pmd=0000000000000000
[  119.435729][    T1] Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
[  119.436893][    T1] Modules linked in:
[  119.437507][    T1] CPU: 6 PID: 1 Comm: swapper/0 Tainted: G
W       T  6.8.1 #2 f0b7e13f202916e57e1ff5697596a7b6ecdce1cf
[  119.439232][    T1] Hardware name: radxa Radxa ROCK 5 Model B/Radxa
ROCK 5 Model B, BIOS 2024.04-rc5-ga5ec56ae 04/01/2024
[  119.440883][    T1] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[  119.442131][    T1] pc : logic_outb+0x6c/0x140
[  119.442998][    T1] lr : logic_outb+0x58/0x140
[  119.443740][    T1] sp : ffff80008768b920
[  119.444368][    T1] x29: ffff80008768b920 x28: 0000000000000000
x27: 0000000000000000
[  119.445693][    T1] x26: 0000000000000001 x25: 0000000000000001
x24: 0000000000000007
[  119.447087][    T1] x23: ffff8000859b7fa8 x22: 0000000000000040
x21: 0000000000ffbfff
[  119.448329][    T1] x20: 0000000000000002 x19: 0000000000000279
x18: ffff800087665058
[  119.449594][    T1] x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000
[  119.450817][    T1] x14: 0000000000000000 x13: 0000000000000000
x12: 0000000000000000
[  119.452093][    T1] x11: 0000000000000000 x10: 0000000000000000 x9
: 0000000000000000
[  119.453332][    T1] x8 : fffffbfffe800279 x7 : 0000000000000000 x6
: 0000000000000000
[  119.454536][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3
: 0000000000000000
[  119.455760][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0
: 0000000000000000
[  119.456901][    T1] Call trace:
[  119.457377][    T1]  logic_outb+0x6c/0x140
[  119.458155][    T1]  isapnp_wait+0x34/0x80
[  119.458849][    T1]  isapnp_isolate_rdp_select+0x38/0x240
[  119.459818][    T1]  isapnp_isolate+0x58/0x340
[  119.460567][    T1]  isapnp_init+0x1ec/0x480
[  119.461263][    T1]  do_one_initcall+0x1e0/0x900
[  119.462061][    T1]  do_initcall_level+0x118/0x204
[  119.462974][    T1]  do_initcalls+0xb4/0x180
[  119.463632][    T1]  do_basic_setup+0xa0/0xc0
[  119.464421][    T1]  kernel_init_freeable+0x2b0/0x500
[  119.465282][    T1]  kernel_init+0x3c/0x37c
[  119.466081][    T1]  ret_from_fork+0x10/0x40
[  119.466777][    T1] Code: d50332bf f2df7fe8 f2ffffe8 8b080268 (39000114)
[  119.467808][    T1] ---[ end trace 0000000000000000 ]---
[  119.468585][    T1] Kernel panic - not syncing: Oops: Fatal exception
[  119.469539][    T1] SMP: stopping secondary CPUs
[  119.470327][    T1] Kernel Offset: disabled
[  119.470991][    T1] CPU features: 0x0,c0000000,7002814a,2101720b
[  119.471862][    T1] Memory Limit: none
[  119.472529][    T1] ---[ end Kernel panic - not syncing: Oops:
Fatal exception ]---
*****

Possibly related:
https://lore.kernel.org/lkml/1560262374-67875-1-git-send-email-john.garry@huawei.com/T/
https://lore.kernel.org/linux-pci/1554393602-152448-1-git-send-email-john.garry@huawei.com/T/

"Why use 'allmodconfig'" you may ask? Answer: To have a build of
everything under the sun to base off of.
My intent was to get a working "tinyconfig" (which I did), but I also
wanted everything pulled from an "all*config" to compare system logs
for other stuff I may want/need.

I don't know if the "all*config"s are meant to work, or if this was
just a fools-errand, but I thought I'd check.

Also, this is actually the second error.
The first one was also a boot panic relating to "Testing tracer
function_graph" (http://codepad.org/5L4rocrP).
But I think that would warrant its own mail submission (which I'll
hold off on if using "allmodconfig" is indeed a fools-errand on my
part).
In the meantime, I just disabled "FUNCTION_GRAPH_TRACER" since it
looks like it'd be of no interest to what I'm looking for.

Also for good measure, I skipped using an initramfs and went straight
to booting root in case the initramfs was needing other modules
included for the boot tests. The error still occurred.


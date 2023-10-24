Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921417D4F72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJXMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjJXMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:07:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DBF9;
        Tue, 24 Oct 2023 05:07:19 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D102A1C007D; Tue, 24 Oct 2023 14:07:16 +0200 (CEST)
Date:   Tue, 24 Oct 2023 14:07:16 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Message-ID: <ZTezdLLXLjKihReb@duo.ucw.cz>
References: <20231024083326.219645073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DQjCDRFTAkxk+AsY"
Content-Disposition: inline
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DQjCDRFTAkxk+AsY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see failures on -rc2:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
047368849

[    2.622365] cpufreq: cpufreq_online: CPU2: Running at unlisted initial f=
requency: 1199999 KHz, changing to: 1200000 KHz
[    2.638013] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
[    2.638846] INFO: trying to register non-static key.
[    2.644192] ledtrig-cpu: registered to indicate activity on CPUs
[    2.649066] The code is fine but needs lockdep annotation, or maybe
[    2.649069] you didn't initialize this object before use?
[    2.649071] turning off the locking correctness validator.
[    2.649080] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64=
-renesas-ge31b6513c43d #1
[    2.649082] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
[    2.649086] Call trace:
[    2.655106] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    2.661354]  dump_backtrace+0x0/0x194
[    2.661361]  show_stack+0x14/0x20
[    2.667430] usbcore: registered new interface driver usbhid
[    2.672230]  dump_stack+0xe8/0x130
[    2.672238]  register_lock_class+0x480/0x514
[    2.672244]  __lock_acquire+0x74/0x20ec
[    2.681113] usbhid: USB HID core driver
[    2.687450]  lock_acquire+0x218/0x350
[    2.687456]  _raw_spin_lock+0x58/0x80
[    2.687464]  tmio_mmc_irq+0x410/0x9ac
[    2.688556] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x0000=
0000ee160000, max clock rate 200 MHz
[    2.744936]  __handle_irq_event_percpu+0xbc/0x340
[    2.749635]  handle_irq_event+0x60/0x100
[    2.753553]  handle_fasteoi_irq+0xa0/0x1ec
[    2.757644]  __handle_domain_irq+0x7c/0xdc
[    2.761736]  efi_header_end+0x4c/0xd0
[    2.765393]  el1_irq+0xcc/0x180
[    2.768530]  arch_cpu_idle+0x14/0x2c
[    2.772100]  default_idle_call+0x58/0xe4
[    2.776019]  do_idle+0x244/0x2c0
[    2.779242]  cpu_startup_entry+0x20/0x6c
[    2.783160]  rest_init+0x164/0x28c
[    2.786561]  arch_call_rest_init+0xc/0x14
[    2.790565]  start_kernel+0x4c4/0x4f8
[    2.794233] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000014
[    2.803011] Mem abort info:
[    2.805798]   ESR =3D 0x96000044
[    2.808848]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    2.814154]   SET =3D 0, FnV =3D 0
[    2.817201]   EA =3D 0, S1PTW =3D 0
[    2.820336] Data abort info:
[    2.823210]   ISV =3D 0, ISS =3D 0x00000044
[    2.827039]   CM =3D 0, WnR =3D 1
[    2.830001] [0000000000000014] user address but active_mm is swapper
[    2.836350] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
[    2.842616] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-arm64=
-renesas-ge31b6513c43d #1
[    2.851480] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
Matched prompt #5: Oops(?: -|:)
Setting prompt string to ['\\r', 'root@hihope-rzg2m', 'hihope-rzg2m login:'=
, 'Login incorrect']
Setting prompt string to ['-\\[ cut here \\]', 'Unhandled fault', 'BUG: KCS=
AN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', 'WARNING:', '(kernel B=
UG at|BUG:)', 'invalid opcode:', 'Kernel panic - not syncing', 'root@hihope=
-rzg2m', 'hihope-rzg2m login:', 'Login incorrect']
login-action: kernel 'oops'
[login-action] Waiting for messages, (timeout 00:04:08)
[    2.857829] pstate: a0000085 (NzCv daIf -PAN -UAO -TCO BTYPE=3D--)
[    2.863830] pc : tmio_mmc_irq+0x484/0x9ac
[    2.867833] lr : tmio_mmc_irq+0x410/0x9ac
[    2.871836] sp : ffff800011fbbe30
[    2.875145] x29: ffff800011fbbe30 x28: 0000000000012400=20
[    2.880456] x27: ffff8000114a0d30 x26: ffff8000114a0000=20
[    2.885766] x25: 00000000000000a4 x24: ffff800011fbbf34=20
[    2.891075] x23: ffff0005c09e1400 x22: ffff0005c2240b80=20
[    2.896384] x21: 0000000000000000 x20: 0000000020800705=20
[    2.901692] x19: ffff0005c2240900 x18: 0000000000000000=20
[    2.907001] x17: 0000000000000020 x16: ffff800010cd2a10=20
[    2.912310] x15: 0000000000000030 x14: ffffffffffffffff=20
[    2.917619] x13: ffff8000112f2fe8 x12: 0000000000000342=20
[    2.922928] x11: 0000000000000116 x10: ffff80001134afe8=20
[    2.928237] x9 : 00000000fffff000 x8 : ffff8000112f2fe8=20
[    2.933545] x7 : 0000000000000014 x6 : 000000000000000c=20
[    2.938853] x5 : 000000000000000e x4 : 0000000000000002=20
[    2.944162] x3 : 0000000000000000 x2 : 0000000000000000=20
[    2.949470] x1 : 0000000000000000 x0 : 0000000000000000=20
[    2.954778] Call trace:
[    2.957220]  tmio_mmc_irq+0x484/0x9ac
[    2.960877]  __handle_irq_event_percpu+0xbc/0x340
[    2.965576]  handle_irq_event+0x60/0x100
[    2.969493]  handle_fasteoi_irq+0xa0/0x1ec
[    2.973583]  __handle_domain_irq+0x7c/0xdc
[    2.977673]  efi_header_end+0x4c/0xd0
[    2.981328]  el1_irq+0xcc/0x180
[    2.984464]  arch_cpu_idle+0x14/0x2c
[    2.988034]  default_idle_call+0x58/0xe4
[    2.991950]  do_idle+0x244/0x2c0
[    2.995172]  cpu_startup_entry+0x20/0x6c
[    2.999089]  rest_init+0x164/0x28c
[    3.002485]  arch_call_rest_init+0xc/0x14
[    3.006489]  start_kernel+0x4c4/0x4f8
[    3.010149] Code: 92403c00 ca000000 b5000000 2a024060 (b82168e0)=20
[    3.016263] ---[ end trace 00b9f83d42f2bdaf ]---
[    3.020875] Kernel panic - not syncing: Oops: Fatal exception in interru=
pt
[    3.027746] SMP: stopping secondary CPUs
[    3.031670] Kernel Offset: disabled
Matched prompt #9: Kernel panic - not syncing
Setting prompt string to ['end Kernel panic[^\\r]*\\r', 'root@hihope-rzg2m'=
, 'hihope-rzg2m login:', 'Login incorrect']
[    3.035153] CPU features: 0x28200022,21002004
[    3.039503] Memory Limit: none
[    3.042558] ---[ end Kernel panic - not syncing: Oops: Fatal exception i=
n interrupt ]---

Different target, different failure:

[    2.153046] ThumbEE CPU extension supported.
[    2.157322] Registering SWP/SWPB emulation handler
[    2.162337] Loading compiled-in X.509 certificates
[    2.179136] 8<--- cut here ---
[    2.180156] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    2.182199] Unable to handle kernel NULL pointer dereference at virtual =
address 000000c0
[    2.191052] pwm-backlight backlight: supply power not found, using dummy=
 regulator
[    2.196886] pgd =3D (ptrval)
[    2.206777] panel-simple panel: Specify missing connector_type
[    2.207145] [000000c0] *pgd=3D00000000
[    2.213875] ehci-pci 0000:01:02.0: init 0000:01:02.0 fail, -517
[    2.216545] Internal error: Oops: 5 [#1] SMP ARM
Matched prompt #5: Oops(?: -|:)
Setting prompt string to ['\\r', 'cip-project#', 'ciphost login:', 'Login i=
ncorrect']
Setting prompt string to ['-\\[ cut here \\]', 'Unhandled fault', 'BUG: KCS=
AN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', 'WARNING:', '(kernel B=
UG at|BUG:)', 'invalid opcode:', 'Kernel panic - not syncing', 'cip-project=
#', 'ciphost login:', 'Login incorrect']
login-action: kernel 'oops'
[login-action] Waiting for messages, (timeout 00:03:49)
[    2.222596] ohci-pci 0000:01:01.0: init 0000:01:01.0 fail, -517
[    2.227061] Modules linked in:
[    2.235236] pwm-backlight backlight: supply power not found, using dummy=
 regulator
[    2.236024] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.199-rc2-ge31b=
6513c43d-dirty #1
[    2.245555] panel-simple panel: Specify missing connector_type
[    2.251743] Hardware name: Generic RZ/G1 (Flattened Device Tree)
[    2.251761] PC is at __queue_work+0x10/0x658
[    2.251769] LR is at call_timer_fn+0x3c/0x1a8
[    2.251773] pc : [<c0361e88>]    lr : [<c03c4524>]    psr: 60000193
[    2.251777] sp : c1901da8  ip : 0000002a  fp : 00000000
[    2.251785] r10: 00000001  r9 : 00200000  r8 : ffff8ba9
[    2.258367] ehci-pci 0000:01:02.0: init 0000:01:02.0 fail, -517
[    2.263602] r7 : 00000100  r6 : c03625ac  r5 : c2014abc  r4 : c2014aac
[    2.263606] r3 : c1900000  r2 : c2014aac  r1 : 00000000  r0 : 00000000
[    2.263612] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t none
[    2.263617] Control: 10c5387d  Table: 4020406a  DAC: 00000051

And third one:

[    2.066588] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    2.074551] sh_mobile_sdhi ee100000.mmc: mmc0 base at 0xee100000, max cl=
ock rate 195 MHz
[    2.085382] sh_mobile_sdhi ee140000.mmc: Got CD GPIO
[    2.090390] sh_mobile_sdhi ee140000.mmc: Got WP GPIO
[    2.095372] 8<--- cut here ---
[    2.095376] Unable to handle kernel NULL pointer dereference at virtual =
address 000000c0
[    2.095381] pgd =3D (ptrval)
[    2.095385] [000000c0] *pgd=3D00000000
[    2.095397] Internal error: Oops: 5 [#1] SMP ARM
[    2.095407] CPU: 0 PID: 117 Comm: kworker/u4:2 Not tainted 5.10.199-rc2-=
ge31b6513c43d #1
[    2.095410] Hardware name: Generic RZ/G1 (Flattened Device Tree)
[    2.095425] Workqueue: events_unbound async_run_entry_fn
[    2.095437] PC is at __queue_work+0xc/0x34c
Matched prompt #5: Oops(?: -|:)
Setting prompt string to ['\\r', 'cip-project#', 'ciphost login:', 'Login i=
ncorrect']
Setting prompt string to ['-\\[ cut here \\]', 'Unhandled fault', 'BUG: KCS=
AN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', 'WARNING:', '(kernel B=
UG at|BUG:)', 'invalid opcode:', 'Kernel panic - not syncing', 'cip-project=
#', 'ciphost login:', 'Login incorrect']
login-action: kernel 'oops'
[login-action] Waiting for messages, (timeout 00:04:10)
[    2.095447] LR is at call_timer_fn+0x64/0x124
[    2.095451] pc : [<c013268c>]    lr : [<c017f8f8>]    psr: 60000193
[    2.095455] sp : c1941af0  ip : 00000000  fp : 00000000
[    2.095459] r10: 00200000  r9 : c1941b4c  r8 : ffff8ba1
[    2.095464] r7 : 00000100  r6 : 00000000  r5 : 00000000  r4 : c19472b4
[    2.095468] r3 : c1940000  r2 : c19472a4  r1 : 00000000  r0 : 00000000
[    2.095474] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t none
[    2.095479] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[    2.095483] Process kworker/u4:2 (pid: 117, stack limit =3D 0x(ptrval))
[    2.095488] Stack: (0xc1941af0 to 0xc1942000)

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DQjCDRFTAkxk+AsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTezdAAKCRAw5/Bqldv6
8jNaAJ9cSyAjA36Hv4+fzA9RNnZLrGmCEACfSXvKvxVWDwgOLLkYHx2hdXGnox4=
=Hy8z
-----END PGP SIGNATURE-----

--DQjCDRFTAkxk+AsY--

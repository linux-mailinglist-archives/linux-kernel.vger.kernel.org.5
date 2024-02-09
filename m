Return-Path: <linux-kernel+bounces-59227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C384F378
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C6FB2252D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D720332;
	Fri,  9 Feb 2024 10:32:00 +0000 (UTC)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE9200AB;
	Fri,  9 Feb 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474719; cv=none; b=uXLyoooeHXqkBn4p2VlETNs01N9LW/tint+wQCvPU5a+lj/p+HoM2ixa7/V+QHmSVeLMXpnRiOeJo8xFiPi3YwIRoYM1E/9Pr2yQxNeYo28qAwiHyWLKd0xkRmCX/Mq8ub/DbeD3R+bY295MNkNlUGQOP6q/zpYFrcRyt0ymyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474719; c=relaxed/simple;
	bh=2Iy1rWyFlOEWMMSgN4IijxR7UVEK/FMOZ8r6wVZsIyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7p2xrIGg/J5GAHRwnQ+6TfGzBcRjtChiog3cUXNPJABSumjQ32oE/xrnnUtyg6hliOSNSsyEt9NnpkxlHMIV4Wg2zcUvoeSgzQ3dT7NrTg+OajwRQbxTP6yEsd6fAPG94fCpZSQb76Ko2YrKmqXIiZxxCN94ceOxeBRiEOtO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rYOAa-000000022R4-2PT5; Fri, 09 Feb 2024 11:31:44 +0100
Received: from dynamic-077-013-134-064.77.13.pool.telefonica.de ([77.13.134.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rYOAa-000000045fk-1SfT; Fri, 09 Feb 2024 11:31:44 +0100
Message-ID: <b77181b99fa3efb3fae66c39014d034001b3ab16.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: make intc_subsys const
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Christian
 Brauner <brauner@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 09 Feb 2024 11:31:43 +0100
In-Reply-To: <20240208-bus_cleanup-sh2-v1-1-729277400893@marliere.net>
References: <20240208-bus_cleanup-sh2-v1-1-729277400893@marliere.net>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ricardo,

On Thu, 2024-02-08 at 16:56 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the make intc_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> Built using sh-sh4 glibc stable toolchain from bootlin, with config:
>=20
> CONFIG_SH_INTC=3Dy
> CONFIG_INTC_USERIMASK=3Dy
> CONFIG_INTC_BALANCING=3Dy
>=20
> Yielded unrelated warnings:
>=20
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> arch/sh/kernel/cpu/sh4/fpu.c:389:6: warning: no previous prototype for 'f=
loat_raise' [-Wmissing-prototypes]
> arch/sh/kernel/cpu/sh4/fpu.c:394:5: warning: no previous prototype for 'f=
loat_rounding_mode' [-Wmissing-prototypes]
> arch/sh/mm/cache-sh4.c:384:13: warning: no previous prototype for 'sh4_ca=
che_init' [-Wmissing-prototypes]
> arch/sh/mm/flush-sh4.c:106:13: warning: no previous prototype for 'sh4__f=
lush_region_init' [-Wmissing-prototypes]
> arch/sh/mm/cache-shx3.c:18:13: warning: no previous prototype for 'shx3_c=
ache_init' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__ra=
w_spin_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__ra=
w_spin_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__ra=
w_spin_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__r=
aw_spin_lock_bh' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__ra=
w_read_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__ra=
w_read_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__ra=
w_read_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__r=
aw_read_lock_bh' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__ra=
w_write_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__ra=
w_write_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__ra=
w_write_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__r=
aw_write_lock_bh' [-Wmissing-prototypes]
> arch/sh/kernel/cpu/init.c:99:29: warning: no previous prototype for 'l2_c=
ache_init' [-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:10:6: warning: no previous prototype for 'pgd_ctor' =
[-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:32:8: warning: no previous prototype for 'pgd_alloc'=
 [-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:37:6: warning: no previous prototype for 'pgd_free' =
[-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:43:6: warning: no previous prototype for 'pud_popula=
te' [-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:48:8: warning: no previous prototype for 'pmd_alloc_=
one' [-Wmissing-prototypes]
> arch/sh/mm/pgtable.c:53:6: warning: no previous prototype for 'pmd_free' =
[-Wmissing-prototypes]
> arch/sh/mm/tlbex_32.c:22:1: warning: no previous prototype for 'handle_tl=
bmiss' [-Wmissing-prototypes]
> arch/sh/kernel/return_address.c:49:7: warning: no previous prototype for =
'return_address' [-Wmissing-prototypes]
> arch/sh/kernel/sys_sh.c:58:16: warning: no previous prototype for 'sys_ca=
cheflush' [-Wmissing-prototypes]
> arch/sh/kernel/traps_32.c:735:6: warning: no previous prototype for 'per_=
cpu_trap_init' [-Wmissing-prototypes]
> arch/sh/kernel/smp.c:173:17: warning: no previous prototype for 'start_se=
condary' [-Wmissing-prototypes]
> arch/sh/kernel/smp.c:324:5: warning: no previous prototype for 'setup_pro=
filing_timer' [-Wmissing-prototypes]
> arch/sh/kernel/kprobes.c:52:16: warning: no previous prototype for 'arch_=
copy_kprobe' [-Wmissing-prototypes]
> arch/sh/kernel/kprobes.c:304:15: warning: no previous prototype for 'tram=
poline_probe_handler' [-Wmissing-prototypes]
> arch/sh/kernel/hw_breakpoint.c:135:5: warning: no previous prototype for =
'arch_bp_generic_fields' [-Wmissing-prototypes]
> fs/ext4/readpage.c:392:1: warning: the frame size of 1124 bytes is larger=
 than 1024 bytes [-Wframe-larger-than=3D]
> arch/sh/boot/compressed/cache.c:2:5: warning: no previous prototype for '=
cache_control' [-Wmissing-prototypes]
> arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for =
'ftrace_stub' [-Wmissing-prototypes]
> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for =
'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
> arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for =
'decompress_kernel' [-Wmissing-prototypes]
> ---
>  drivers/sh/intc/core.c      | 2 +-
>  drivers/sh/intc/internals.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index ca4f4ca413f1..74350b5871dc 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -455,7 +455,7 @@ struct syscore_ops intc_syscore_ops =3D {
>  	.resume		=3D intc_resume,
>  };
> =20
> -struct bus_type intc_subsys =3D {
> +const struct bus_type intc_subsys =3D {
>  	.name		=3D "intc",
>  	.dev_name	=3D "intc",
>  };
> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
> index fa73c173b56a..9b6cd1bebb4e 100644
> --- a/drivers/sh/intc/internals.h
> +++ b/drivers/sh/intc/internals.h
> @@ -160,7 +160,7 @@ void _intc_enable(struct irq_data *data, unsigned lon=
g handle);
>  /* core.c */
>  extern struct list_head intc_list;
>  extern raw_spinlock_t intc_big_lock;
> -extern struct bus_type intc_subsys;
> +extern const struct bus_type intc_subsys;
> =20
>  unsigned int intc_get_dfl_prio_level(void);
>  unsigned int intc_get_prio_level(unsigned int irq);

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for your patch. I will merge it into my linux-sh this weekend
after not managing it last weekend due to lack of time.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


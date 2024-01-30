Return-Path: <linux-kernel+bounces-45012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6E842A71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6991F22CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FEE128395;
	Tue, 30 Jan 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/2PKqua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62812BF07;
	Tue, 30 Jan 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634359; cv=none; b=Ibg1tkBnHfi/EMTWGsVU7NuoovDqRMt5sseTQ0diC1ECf2Y3dI7WgkGyNatu7FqeYLhiLNFvID134oT7iiOVF4xOZUWnK1w00JpNPF6bXp4gECRgCiC7E0ui0Gfp3/HEL881nQ7w47wfTs3NNY6w0iQ+nCjsVAcfDtDqNwYbwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634359; c=relaxed/simple;
	bh=YwKCXYLf+oI3KPucxQe9UYg/ekKW8PxtDHHMETCQipI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIGU+wyqMNHKuKS7hzaLLehApjC3oPCQxqS+Io0LB57nFuYrJQ7pEgvY5GiSa/AZmJHk7urFVkqLPzqnpfMFZOzYQJai8EBhZSZbIGaKREK5VYuXL/c9wIHmTrPA6viSnWHXcjytA0BcESHfxqQtCb6ZVvxv46Xx/Ze5eUaRXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/2PKqua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3FCC433F1;
	Tue, 30 Jan 2024 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634358;
	bh=YwKCXYLf+oI3KPucxQe9UYg/ekKW8PxtDHHMETCQipI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/2PKquaNB5q1zeybIIzKWc3ZYj+ppS1R2KQa7GXJ0Uy3jN2G6pEbhE9mQhVugK4T
	 ZwEP6YTVTFw+7QZfFGibPBeOctcn6UQHMTGswAd1N08v98+jTkHFyaYJFPoJULvf/3
	 heDIAmiLLXh6ZtulbKqIeF0RhnS/l7J/Ah/f4MaNnbIonmXRs5/Qa6cSrJEcX/OiP4
	 UEHuOQ+3qrAsY7h672k0dfwvwcnuYNU+6y0FfxDflQbZp2BSqYV1MCwyKqhaQVGlUX
	 pR0125NQDQ/UKDS37c93hSxklf4JKWTdmlLON+mZ5xjoYxVnIMd/tYrZn//tHiHQyq
	 eUPssgUj7tpYQ==
Date: Tue, 30 Jan 2024 10:05:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Message-ID: <20240130170556.GA1125757@dev-arch.thelio-3990X>
References: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>

Hi Konrad,

On Mon, Jan 22, 2024 at 03:27:20PM +0100, Konrad Dybcio wrote:
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.
> 
> Remove the workarounds, as they are long obsolete.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Compile-tested only
> ---
>  drivers/tty/serial/amba-pl011.c | 82 -----------------------------------------
>  1 file changed, 82 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index fccec1698a54..c4df9cbc264b 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -152,23 +152,6 @@ static const struct vendor_data vendor_sbsa = {
>  	.fixed_options		= true,
>  };
>  
> -#ifdef CONFIG_ACPI_SPCR_TABLE
> -static const struct vendor_data vendor_qdt_qdf2400_e44 = {
> -	.reg_offset		= pl011_std_offsets,
> -	.fr_busy		= UART011_FR_TXFE,
> -	.fr_dsr			= UART01x_FR_DSR,
> -	.fr_cts			= UART01x_FR_CTS,
> -	.fr_ri			= UART011_FR_RI,
> -	.inv_fr			= UART011_FR_TXFE,
> -	.access_32b		= true,
> -	.oversampling		= false,
> -	.dma_threshold		= false,
> -	.cts_event_workaround	= false,
> -	.always_enabled		= true,
> -	.fixed_options		= true,
> -};
> -#endif
> -
>  static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
>  	[REG_DR] = UART01x_DR,
>  	[REG_ST_DMAWM] = ST_UART011_DMAWM,
> @@ -2468,15 +2451,6 @@ static int pl011_console_match(struct console *co, char *name, int idx,
>  	resource_size_t addr;
>  	int i;
>  
> -	/*
> -	 * Systems affected by the Qualcomm Technologies QDF2400 E44 erratum
> -	 * have a distinct console name, so make sure we check for that.
> -	 * The actual implementation of the erratum occurs in the probe
> -	 * function.
> -	 */
> -	if ((strcmp(name, "qdf2400_e44") != 0) && (strcmp(name, "pl011") != 0))
> -		return -ENODEV;
> -
>  	if (uart_parse_earlycon(options, &iotype, &addr, &options))
>  		return -ENODEV;
>  
> @@ -2517,22 +2491,6 @@ static struct console amba_console = {
>  
>  #define AMBA_CONSOLE	(&amba_console)
>  
> -static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
> -{
> -	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> -		cpu_relax();
> -	writel(c, port->membase + UART01x_DR);
> -	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
> -		cpu_relax();
> -}
> -
> -static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
> -{
> -	struct earlycon_device *dev = con->data;
> -
> -	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
> -}
> -
>  static void pl011_putc(struct uart_port *port, unsigned char c)
>  {
>  	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> @@ -2611,29 +2569,6 @@ OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>  
>  OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
>  
> -/*
> - * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
> - * Erratum 44, traditional earlycon can be enabled by specifying
> - * "earlycon=qdf2400_e44,<address>".  Any options are ignored.
> - *
> - * Alternatively, you can just specify "earlycon", and the early console
> - * will be enabled with the information from the SPCR table.  In this
> - * case, the SPCR code will detect the need for the E44 work-around,
> - * and set the console name to "qdf2400_e44".
> - */
> -static int __init
> -qdf2400_e44_early_console_setup(struct earlycon_device *device,
> -				const char *opt)
> -{
> -	if (!device->port.membase)
> -		return -ENODEV;
> -
> -	device->con->write = qdf2400_e44_early_write;
> -	return 0;
> -}
> -
> -EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
> -
>  #else
>  #define AMBA_CONSOLE	NULL
>  #endif
> @@ -2869,22 +2804,6 @@ static int pl011_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
>  
> -#ifdef CONFIG_ACPI_SPCR_TABLE
> -static void qpdf2400_erratum44_workaround(struct device *dev,
> -					  struct uart_amba_port *uap)
> -{
> -	if (!qdf2400_e44_present)
> -		return;
> -
> -	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
> -	uap->vendor = &vendor_qdt_qdf2400_e44;
> -}
> -#else
> -static void qpdf2400_erratum44_workaround(struct device *dev,
> -					  struct uart_amba_port *uap)
> -{ /* empty */ }
> -#endif
> -
>  static int sbsa_uart_probe(struct platform_device *pdev)
>  {
>  	struct uart_amba_port *uap;
> @@ -2921,7 +2840,6 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  	uap->port.irq	= ret;
>  
>  	uap->vendor = &vendor_sbsa;
> -	qpdf2400_erratum44_workaround(&pdev->dev, uap);
>  
>  	uap->reg_offset	= uap->vendor->reg_offset;
>  	uap->fifosize	= 32;
> 

I just bisected a crash that I see in -next to this change as commit
196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx workarounds"). I
see it when booting both ARCH=arm multi_v7_defconfig and ARCH=arm64
virtconfig.

$ qemu-system-aarch64 \
    -display none \
    -nodefaults \
    -cpu max,pauth-impdef=true \
    -machine virt,gic-version=max,virtualization=true \
    -append 'console=ttyAMA0 earlycon' \
    -kernel arch/arm64/boot/Image.gz \
    -initrd rootfs.cpio \
    -m 512m \
    -serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.8.0-rc1-00096-g196f34af2bf4 (nathan@dev-arch.thelio-3990X) (aarch64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT Tue Jan 30 09:42:53 MST 2024
..
[    0.210400] Serial: AMBA PL011 UART driver
[    0.245810] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 14, base_baud = 0) is a PL011 rev1
[    0.246789] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    0.247015] Mem abort info:
[    0.247090]   ESR = 0x0000000096000004
[    0.247204]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.247338]   SET = 0, FnV = 0
[    0.247423]   EA = 0, S1PTW = 0
[    0.247512]   FSC = 0x04: level 0 translation fault
[    0.247637] Data abort info:
[    0.247717]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.247849]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.247975]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.248135] [0000000000000000] user address but active_mm is swapper
[    0.248391] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.248651] Modules linked in:
[    0.249219] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1-00096-g196f34af2bf4 #1
[    0.249514] Hardware name: linux,dummy-virt (DT)
[    0.249757] pstate: 41400009 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    0.249985] pc : __pi_strncmp+0x20/0x1b4
[    0.250611] lr : uart_parse_earlycon+0x34/0x174
[    0.250765] sp : ffff80008000b780
[    0.250869] x29: ffff80008000b780 x28: ffff000001c07b10 x27: ffffd8d528b2bfb0
[    0.251188] x26: ffff000001d57850 x25: 0000000000000000 x24: ffff000001ea8100
[    0.251410] x23: ffff000001ed5800 x22: ffff80008000b7ef x21: ffff80008000b7f0
[    0.251636] x20: ffff80008000b7d8 x19: 0000000000000000 x18: 0000000000000006
[    0.251855] x17: 203d20647561625f x16: 65736162202c3431 x15: 203d207172692820
[    0.252074] x14: 3030303030303978 x13: 0000000000000000 x12: 00000000000001b9
[    0.252293] x11: 0101010101010101 x10: ffffd8d528f48770 x9 : ffffd8d528ef0770
[    0.252531] x8 : ffffd8d528ac3c80 x7 : ffffd8d528f48770 x6 : 0000000000000000
[    0.252750] x5 : ffff000001ed5480 x4 : ffffd8d5280f4184 x3 : ffff80008000b7d8
[    0.252968] x2 : 0000000000000005 x1 : ffffd8d528ac3c80 x0 : 0000000000000000
[    0.253257] Call trace:
[    0.253439]  __pi_strncmp+0x20/0x1b4
[    0.253642]  pl011_console_match+0x44/0xd4
[    0.253792]  try_enable_preferred_console+0x5c/0x10c
[    0.253940]  register_console+0x124/0x438
[    0.254062]  serial_core_register_port+0x618/0x654
[    0.254200]  serial_ctrl_register_port+0x10/0x1c
[    0.254334]  uart_add_one_port+0x10/0x1c
[    0.254452]  pl011_register_port+0x68/0x11c
[    0.254574]  pl011_probe+0x1a8/0x1dc
[    0.254682]  amba_probe+0x110/0x1c4
[    0.254791]  really_probe+0x148/0x2b0
[    0.254909]  __driver_probe_device+0x78/0x12c
[    0.255037]  driver_probe_device+0x3c/0x15c
[    0.255160]  __device_attach_driver+0xb8/0x134
[    0.255289]  bus_for_each_drv+0x84/0xe0
[    0.255404]  __device_attach+0x9c/0x188
[    0.255519]  device_initial_probe+0x14/0x20
[    0.255644]  bus_probe_device+0xac/0xb0
[    0.255762]  device_add+0x600/0x7b8
[    0.255868]  amba_device_add+0x4c/0xb8
[    0.255981]  of_platform_bus_create+0x2bc/0x37c
[    0.256116]  of_platform_populate+0x50/0xfc
[    0.256240]  of_platform_default_populate_init+0xe0/0x100
[    0.256395]  do_one_initcall+0x7c/0x1c0
[    0.256511]  kernel_init_freeable+0x1c0/0x288
[    0.256642]  kernel_init+0x24/0x1dc
[    0.256754]  ret_from_fork+0x10/0x20
[    0.257091] Code: f240091f 9240080d 540004c1 b500030d (f8408403)
[    0.257519] ---[ end trace 0000000000000000 ]---
[    0.258252] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.258698] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

If there is any more information I can provide or patches I can test,
please let me know.

Cheers,
Nathan

# bad: [41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52] Add linux-next specific files for 20240130
# good: [41bccc98fb7931d63d03f326a746ac4d429c1dd3] Linux 6.8-rc2
git bisect start '41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52' '41bccc98fb7931d63d03f326a746ac4d429c1dd3'
# good: [f3f89885646036e16b325aea597fc9f375f1a56a] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good f3f89885646036e16b325aea597fc9f375f1a56a
# good: [8042d32dd6c3730b0b4c8c9c811e204ed9f5f829] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 8042d32dd6c3730b0b4c8c9c811e204ed9f5f829
# bad: [f0edba72fe5ae932877f49796aaef8adf1a2eb8c] Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect bad f0edba72fe5ae932877f49796aaef8adf1a2eb8c
# good: [549632942a27cc3987473f8a8629200bc2ab0734] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect good 549632942a27cc3987473f8a8629200bc2ab0734
# good: [92e32ed303a6c4dc5a5ad9ec54785a6245bcd8fa] tty: serial: samsung: change return type for s3c24xx_serial_rx_fifocnt()
git bisect good 92e32ed303a6c4dc5a5ad9ec54785a6245bcd8fa
# good: [41b5684e58b1286ae0fa180bc50b661a27efee33] dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 family
git bisect good 41b5684e58b1286ae0fa180bc50b661a27efee33
# bad: [098396f23ede72c3140a5ba33db38b130385a5fd] Merge branch 'habanalabs-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
git bisect bad 098396f23ede72c3140a5ba33db38b130385a5fd
# bad: [fccc9d9233f918ee50cf2955ae7134a7f3418351] tty: serial: uartps: Add rs485 support to uartps driver
git bisect bad fccc9d9233f918ee50cf2955ae7134a7f3418351
# bad: [59fdea965eee9908d904b94828c69f641f1e92fa] serial: txx9: Add missing #include <asm/txx9/generic.h>
git bisect bad 59fdea965eee9908d904b94828c69f641f1e92fa
# good: [79821c8a45807655c25d6bae2b13a3f98a5c01cd] tty: serial: samsung: shrink memory footprint of ``struct s3c24xx_uart_info``
git bisect good 79821c8a45807655c25d6bae2b13a3f98a5c01cd
# bad: [196f34af2bf4c87ac4299a9775503d81b446980c] tty: serial: amba-pl011: Remove QDF2xxx workarounds
git bisect bad 196f34af2bf4c87ac4299a9775503d81b446980c
# good: [09aec324b60f4309eeba8d2d5c897e882cce23bc] dt-bindings: serial: fsl-lpuart: support i.MX95
git bisect good 09aec324b60f4309eeba8d2d5c897e882cce23bc
# first bad commit: [196f34af2bf4c87ac4299a9775503d81b446980c] tty: serial: amba-pl011: Remove QDF2xxx workarounds


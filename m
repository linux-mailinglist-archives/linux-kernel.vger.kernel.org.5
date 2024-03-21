Return-Path: <linux-kernel+bounces-110064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D2885983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D976F1F22846
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853A83CDC;
	Thu, 21 Mar 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sy85bfn6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1383CCA;
	Thu, 21 Mar 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026072; cv=none; b=IP0yvpO9Ffrx+1fD1lRY7bzada3EW5jlZHERkPM3D4s9vm+Yy9hgP0ufSAyRxNy+bPaC7XUE9gp5XP+NWBddXvT1eEhu25MuYfiurxe0CNPGL54+AyxBPzWPA8vTXHgRQeOocOQrfUHq23DovL1HImRDPXgMxbV3MiBZUkBTbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026072; c=relaxed/simple;
	bh=DMNcy+4dJPc2vMcIkgY+wjPiBUBSyob8twZu77W9TXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WO8yhBwN7i8CYwU+tCSyUS4OEx9Be9UPKGb8jJtHkZ8AVQ2D6Wpdpr7p0u89MlcFALlk73yze07GYQdYGZCPJFZrgZOLpbQ6DdcuqIvpWcY0E6mmGP6FUKFnK/NBo0RvzBaaeIj6A3b4TnkytGx3AhccPCIZBGtrPtTXS5GEUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sy85bfn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B669C433F1;
	Thu, 21 Mar 2024 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711026072;
	bh=DMNcy+4dJPc2vMcIkgY+wjPiBUBSyob8twZu77W9TXY=;
	h=Date:From:To:Cc:Subject:From;
	b=Sy85bfn6JhHuE5XqUMHtLmMuuTO8fmi9q139bj7kJOtVD3HDyv9Z1j5il/s7Y7KJW
	 5Nswot3kCwmsb75PgqFO+OMjsQfJgxJv3W7FrKHQnwGeBPxfm1+p577AN30u5ptQ29
	 zbpUVFEpLWACzASd7iDHmFkgL2VlXebYNWyd8s+E=
Date: Thu, 21 Mar 2024 14:01:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.9-rc1
Message-ID: <ZfwvlME6MKUHhQde@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc1

for you to fetch changes up to d6c0d892b44cd16e0421909cf7f2883b9e625e4a:

  dt-bindings: serial: stm32: add power-domains property (2024-03-07 21:44:12 +0000)

----------------------------------------------------------------
TTY/Serial driver update for 6.9-rc1

Here is the big set of TTY/Serial driver updates and cleanups for
6.9-rc1.  Included in here are:
  - more tty cleanups from Jiri
  - loads of 8250 driver cleanups from Andy
  - max310x driver updates
  - samsung serial driver updates
  - uart_prepare_sysrq_char() updates for many drivers
  - platform driver remove callback void cleanups
  - stm32 driver updates
  - other small tty/serial driver updates

All of these have been in linux-next for a long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (26):
      serial: 8250_pci1xxxx: Don't use "proxy" headers
      serial: 8250_bcm7271: Replace custom unit definitions
      serial: 8250_of: Drop quirk fot NPCM from 8250_port
      serial: 8250_exar: Don't remove GPIO device on suspend
      serial: 8250_exar: Use dev_get_drvdata() directly in PM callbacks
      serial: 8250_exar: Clear interrupts before registering handler
      serial: 8250_exar: Use generic function to set firmware node
      serial: 8250_exar: switch to DEFINE_SIMPLE_DEV_PM_OPS()
      serial: 8250_exar: Use 8250 PCI library to map and assign resources
      serial: 8250_exar: Don't use "proxy" headers
      serial: 8250_pci1xxxx: Drop quirk from 8250_port
      serial: core: Move struct uart_port::quirks closer to possible values
      serial: core: Add UPIO_UNKNOWN constant for unknown port type
      serial: port: Introduce a common helper to read properties
      serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
      serial: 8250_bcm2835aux: Switch to use uart_read_port_properties()
      serial: 8250_bcm7271: Switch to use uart_read_port_properties()
      serial: 8250_dw: Switch to use uart_read_port_properties()
      serial: 8250_ingenic: Switch to use uart_read_port_properties()
      serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
      serial: 8250_of: Switch to use uart_read_port_properties()
      serial: 8250_omap: Switch to use uart_read_port_properties()
      serial: 8250_pxa: Switch to use uart_read_port_properties()
      serial: 8250_tegra: Switch to use uart_read_port_properties()
      serial: 8250_uniphier: Switch to use uart_read_port_properties()
      serial: 8250_dw: Replace ACPI device check by a quirk

Arnd Bergmann (1):
      tty: hvc-iucv: fix function pointer casts

Bartosz Golaszewski (1):
      serial: st-asc: don't get/put GPIOs in atomic context

Christoph Winklhofer (3):
      dt-bindings: serial: allow onewire as child node
      dt-bindings: w1: UART 1-Wire bus
      w1: add UART w1 bus driver

Colin Ian King (2):
      serial: lpc32xx_hs: remove redundant check and assignment of hsu_rate
      tty: jsm: Remove redundant assignment to variable linestatus

Douglas Anderson (2):
      soc: qcom: geni-se: Add M_TX_FIFO_NOT_EMPTY bit definition
      serial: qcom-geni: Don't cancel/abort if we can't get the port lock

Francesco Dolcini (1):
      treewide, serdev: change receive_buf() return type to size_t

Geert Uytterhoeven (3):
      serial: 8250: Move hp300_setup_serial_console() to <linux/serial_8250.h>
      serial: txx9: Add missing #include <asm/txx9/generic.h>
      serial: sh-sci: Call sci_serial_{in,out}() directly

Greg Kroah-Hartman (4):
      Merge 6.8-rc3 into tty-next
      Merge 6.8-rc5 into tty-next
      Merge 6.8-rc6 into tty-next
      Merge tag 'w1-drv-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into tty-next

Hugo Villeneuve (17):
      serial: max310x: fix NULL pointer dereference in I2C instantiation
      serial: max310x: add I2C device table for instantiation from userspace
      serial: max310x: use i2c_get_match_data()
      serial: max310x: use spi_get_device_match_data()
      serial: max310x: fix syntax error in IRQ error message
      serial: max310x: remove holes in struct max310x_devtype
      serial: max310x: add macro for max number of ports
      serial: max310x: use separate regmap name for each port
      serial: max310x: simplify probe() and remove() error handling
      serial: max310x: add explicit return for some switch default cases
      serial: max310x: use dev_err_probe() instead of dev_err()
      serial: max310x: replace hardcoded masks with preferred GENMASK()
      serial: max310x: use common detect function for all variants
      serial: max310x: use common power function for all variants
      serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
      serial: max310x: reformat and improve comments
      serial: max310x: fix indentation

Ilpo Järvinen (1):
      tty: Don't include tty_buffer.h in tty.h

Jiri Slaby (SUSE) (69):
      vgacon: inline vc_scrolldelta_helper() into vgacon_scrolldelta()
      fbcon: make display_desc a static array in fbcon_startup()
      tty: vt: fix 20 vs 0x20 typo in EScsiignore
      tty: vt: expect valid vc when in tty ops
      tty: vt: pass proper pointers from tioclinux()
      tty: vt: push console lock from tioclinux() down to 2 functions
      tty: vt: pass vc_resize_user as a parameter
      tty: vt: make vc_is_sel()'s vc const
      tty: vt: define an enum for CSI+m codes
      tty: vt: use case ranges for CSI+m fg/bg colors
      tty: vt: define an enum for CSI+J codes
      tty: vt: reflow csi_J()
      use clamp() for counts in csi_?() handlers
      don't pass vc->vc_par[0] to csi_?() handlers
      tty: vt: define an enum for CSI+K codes
      tty: vt: reflow csi_K()
      tty: vt: define an enum for ascii characters
      tty: vt: remove extern from functions in selection.h
      tty: vt: make consw::con_debug_*() return void
      tty: vt: make init parameter of consw::con_init() a bool
      tty: vt: sanitize arguments of consw::con_clear()
      tty: vt: remove checks for count in consw::con_clear() implementations
      tty: vt: add con_putc() helper
      tty: vt: eliminate unneeded consw::con_putc() implementations
      tty: vt: sanitize consw::con_putc() parameters
      tty: vt: sanitize consw::con_putcs() parameters
      consoles: use if instead of switch-case in consw::con_cursor()
      fbdev/core: simplify cursor_state setting in fbcon_ops::cursor()
      tty: vt: remove CM_* constants
      tty: vt: make consw::con_switch() return a bool
      tty: vt: stop using -1 for blank mode in consw::con_blank()
      tty: vt: define a common enum for VESA blanking constants
      tty: vt: use VESA blanking constants
      tty: vt: use enum constants for VESA blanking modes
      tty: vt: make types around consw::con_blank() bool
      tty: vt: make font of consw::con_font_set() const
      tty: vt: make consw::con_font_default()'s name const
      tty: vt: change consw::con_set_origin() return type
      fbcon: remove consw::con_screen_pos()
      tty: vt: remove consw::con_screen_pos()
      tty: vt: make types of screenpos() more consistent
      fbcon: remove fbcon_getxy()
      tty: vt: remove consw::con_getxy()
      tty: vt: remove unused consw::con_flush_scrollback()
      tty: vt: document the rest of struct consw
      tty: vt: fix up kernel-doc
      Documentation: add console.rst
      tty: vt: make rgb_from_256() slighly more comprehensible
      tty: vt: define enums for CSI+h/l codes
      tty: vt: rename set_mode() to csi_hl()
      tty: vt: split DEC CSI+h/l handling into csi_DEC_hl()
      tty: vt: remove unneeded assignment of EPecma to vc_priv
      tty: vt: move CSI+n handling along to other ECMA CSIs
      tty: vt: define an enum for CSI+] codes
      tty: vt: rename setterm_command() to csi_RSB()
      tty: vt: put cases on separate lines
      tty: vt: accept u8 in do_con_trol() and vc_setGx()
      tty: vt: extract ascii handling to handle_ascii()
      tty: vt: separate ESesc state handling into handle_esc()
      tty: vt: move CSI DEC handling to a separate function
      tty: vt: move CSI ECMA handling to a separate function
      tty: vt: name, reflow and document enum vc_ctl_state
      tty: vt: simplify ansi_control_string()
      tty: vt: handle CSI+[ inside preexisting switch-case
      tty: vt: add new helper for reseting vc parameters
      tty: vt: use switch+case in the ESnonstd case
      tty: vt: use switch+case in the ESgetpars case
      tty: vt: use ASCII enum constants in vt_console_print()
      tty: vt: decrypt magic constants in vc_is_control()

Jonas Gorski (1):
      serial: core: only stop transmit when HW fifo is empty

Konrad Dybcio (2):
      tty: serial: amba-pl011: Remove QDF2xxx workarounds
      Revert "tty: serial: amba-pl011: Remove QDF2xxx workarounds"

Lizhe (1):
      serial: linflexuart: Remove redundant uart type assignment

Lukas Bulwahn (1):
      vt: remove superfluous CONFIG_HW_CONSOLE

Manikanta Guntupalli (3):
      dt-bindings: Add reference to rs485.yaml
      tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
      tty: serial: uartps: Add rs485 support to uartps driver

Nghia Nguyen (1):
      dt-bindings: serial: renesas,hscif: Document r8a779h0 bindings

Peng Fan (1):
      dt-bindings: serial: fsl-lpuart: support i.MX95

Peter Collingbourne (1):
      serial: Lock console when calling into driver before registration

Raphael Gallais-Pou (1):
      dt-bindings: serial: convert st,asc to DT schema

Rengarajan S (2):
      8250: microchip: pci1xxxx: Add Burst mode transmission support in uart driver for reading from FIFO
      8250: microchip: Add 4 Mbps support in PCI1XXXX UART

Ricardo B. Marliere (3):
      serdev: make serdev_bus_type const
      serial: core: make serial_base_bus_type const
      w1: make w1_bus_type const

Roman Žilka (2):
      tty/vt: UTF-8 parsing update according to RFC 3629, modern Unicode
      tty/vt: Corrected doc of vc_sanitize_unicode(), vc_translate_unicode()

Sam Protsenko (1):
      tty: serial: samsung: Remove superfluous braces in macro

Sebastian Andrzej Siewior (18):
      serial: amba-pl011: Use uart_prepare_sysrq_char().
      serial: ar933x: Use uart_prepare_sysrq_char().
      serial: bcm63xx: Use uart_prepare_sysrq_char().
      serial: meson: Use uart_prepare_sysrq_char().
      serial: msm: Use uart_prepare_sysrq_char().
      serial: omap: Use uart_prepare_sysrq_char().
      serial: pxa: Use uart_prepare_sysrq_char().
      serial: sunplus: Use uart_prepare_sysrq_char().
      serial: lpc32xx_hs: Use uart_prepare_sysrq_char() to handle sysrq.
      serial: owl: Use uart_prepare_sysrq_char() to handle sysrq.
      serial: rda: Use uart_prepare_sysrq_char() to handle sysrq.
      serial: sifive: Use uart_prepare_sysrq_char() to handle sysrq.
      serial: pch: Invoke handle_rx_to() directly.
      serial: pch: Make push_rx() return void.
      serial: pch: Don't disable interrupts while acquiring lock in ISR.
      serial: pch: Don't initialize uart_port's spin_lock.
      serial: pch: Remove eg20t_port::lock.
      serial: pch: Use uart_prepare_sysrq_char().

Serge Semin (1):
      serial: 8250: Use serial8250_do_set_termios for uartclk updating

Tamseel Shams (1):
      serial: samsung: honor fifosize from dts at first

Thomas Huth (1):
      drivers/tty/serial: Remove unused function early_mcf_setup

Tudor Ambarus (19):
      tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
      dt-bindings: serial: samsung: do not allow reg-io-width for gs101
      tty: serial: samsung: prepare for different IO types
      tty: serial: samsung: set UPIO_MEM32 iotype for gs101
      tty: serial: samsung: add gs101 earlycon support
      tty: serial: samsung: sort headers alphabetically
      tty: serial: samsung: explicitly include <linux/types.h>
      tty: serial: samsung: use u32 for register interactions
      tty: serial: samsung: remove braces on single statement block
      tty: serial: samsung: move open brace '{' on the next line
      tty: serial: samsung: drop superfluous comment
      tty: serial: samsung: make max_count unsigned int
      tty: serial: samsung: don't compare with zero an if (bitwise expression)
      tty: serial: samsung: return bool for s3c24xx_serial_txempty_nofifo()
      tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
      tty: serial: samsung: change return type for s3c24xx_serial_rx_fifocnt()
      tty: serial: samsung: shrink the clock selection to 8 clocks
      tty: serial: samsung: change has_divslot type to bool
      tty: serial: samsung: shrink memory footprint of ``struct s3c24xx_uart_info``

Uwe Kleine-König (8):
      tty: amiserial: Convert to platform remove callback returning void
      tty: goldfish: Convert to platform remove callback returning void
      serial: pmac_zilog: Convert to platform remove callback returning void
      w1: mxc_w1: Convert to platform remove callback returning void
      w1: omap_hdq: Convert to platform remove callback returning void
      w1: sgi_w1: Convert to platform remove callback returning void
      w1: w1-gpio: Convert to platform remove callback returning void
      serial: 8250_dw: Emit an error message if getting the baudclk failed

Valentin Caron (5):
      serial: stm32: implement prescaler tuning to compute low baudrate
      serial: stm32: extend max number of U(S)ART to 9
      serial: stm32: change register's offset type from u8 to u16
      serial: stm32: get FIFO size from hwcfg register
      dt-bindings: serial: stm32: add power-domains property

 .../devicetree/bindings/serial/cdns,uart.yaml      |    1 +
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |    1 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |    1 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |    2 +
 .../devicetree/bindings/serial/serial.yaml         |    2 +-
 .../devicetree/bindings/serial/st,asc.yaml         |   55 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |    3 +
 .../devicetree/bindings/serial/st-asc.txt          |   18 -
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |   59 +
 Documentation/driver-api/tty/console.rst           |   45 +
 Documentation/driver-api/tty/index.rst             |    1 +
 Documentation/w1/masters/index.rst                 |    1 +
 Documentation/w1/masters/w1-uart.rst               |   54 +
 arch/m68k/amiga/config.c                           |    2 +-
 arch/m68k/hp300/config.c                           |    6 +-
 drivers/bluetooth/btmtkuart.c                      |    4 +-
 drivers/bluetooth/btnxpuart.c                      |    4 +-
 drivers/bluetooth/hci_serdev.c                     |    4 +-
 drivers/gnss/serial.c                              |    2 +-
 drivers/gnss/sirf.c                                |    2 +-
 drivers/greybus/gb-beagleplay.c                    |    6 +-
 drivers/iio/chemical/pms7003.c                     |    4 +-
 drivers/iio/chemical/scd30_serial.c                |    4 +-
 drivers/iio/chemical/sps30_serial.c                |    4 +-
 drivers/iio/imu/bno055/bno055_ser_core.c           |    4 +-
 drivers/input/keyboard/amikbd.c                    |    6 +-
 drivers/mfd/rave-sp.c                              |    4 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |    2 +-
 drivers/nfc/pn533/uart.c                           |    4 +-
 drivers/nfc/s3fwrn5/uart.c                         |    4 +-
 drivers/platform/chrome/cros_ec_uart.c             |    4 +-
 drivers/platform/surface/aggregator/core.c         |    4 +-
 drivers/tty/Kconfig                                |    7 +-
 drivers/tty/amiserial.c                            |    6 +-
 drivers/tty/goldfish.c                             |    5 +-
 drivers/tty/hvc/hvc_iucv.c                         |    6 +-
 drivers/tty/serdev/core.c                          |    2 +-
 drivers/tty/serdev/serdev-ttyport.c                |   10 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   50 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   92 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   73 +-
 drivers/tty/serial/8250/8250_dw.c                  |  121 +-
 drivers/tty/serial/8250/8250_exar.c                |   52 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   20 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   20 +-
 drivers/tty/serial/8250/8250_of.c                  |  149 +-
 drivers/tty/serial/8250/8250_omap.c                |   29 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            |  175 ++-
 drivers/tty/serial/8250/8250_port.c                |   50 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   22 +-
 drivers/tty/serial/8250/8250_tegra.c               |   26 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   17 +-
 drivers/tty/serial/8250/Kconfig                    |    1 +
 drivers/tty/serial/amba-pl011.c                    |   24 +-
 drivers/tty/serial/ar933x_uart.c                   |   18 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   24 +-
 drivers/tty/serial/fsl_linflexuart.c               |    1 -
 drivers/tty/serial/jsm/jsm_cls.c                   |    1 -
 drivers/tty/serial/lpc32xx_hs.c                    |   19 +-
 drivers/tty/serial/max310x.c                       |  327 ++---
 drivers/tty/serial/mcf.c                           |   27 -
 drivers/tty/serial/meson_uart.c                    |   22 +-
 drivers/tty/serial/msm_serial.c                    |   33 +-
 drivers/tty/serial/omap-serial.c                   |   16 +-
 drivers/tty/serial/owl-uart.c                      |   30 +-
 drivers/tty/serial/pch_uart.c                      |   70 +-
 drivers/tty/serial/pmac_zilog.c                    |    9 +-
 drivers/tty/serial/pxa.c                           |   17 +-
 drivers/tty/serial/qcom_geni_serial.c              |   27 +-
 drivers/tty/serial/rda-uart.c                      |   28 +-
 drivers/tty/serial/samsung_tty.c                   |  276 ++--
 drivers/tty/serial/serial_base_bus.c               |    2 +-
 drivers/tty/serial/serial_core.c                   |   12 +
 drivers/tty/serial/serial_port.c                   |  145 ++
 drivers/tty/serial/serial_txx9.c                   |    3 +-
 drivers/tty/serial/sh-sci.c                        |  245 ++--
 drivers/tty/serial/sifive.c                        |   17 +-
 drivers/tty/serial/st-asc.c                        |   40 +-
 drivers/tty/serial/stm32-usart.c                   |  223 +--
 drivers/tty/serial/stm32-usart.h                   |   38 +-
 drivers/tty/serial/sunplus-uart.c                  |   18 +-
 drivers/tty/serial/xilinx_uartps.c                 |  236 ++-
 drivers/tty/tty_buffer.c                           |    1 +
 drivers/tty/vt/Makefile                            |    4 +-
 drivers/tty/vt/selection.c                         |   43 +-
 drivers/tty/vt/vt.c                                | 1531 +++++++++++---------
 drivers/tty/vt/vt_ioctl.c                          |    6 +-
 drivers/video/console/dummycon.c                   |   38 +-
 drivers/video/console/mdacon.c                     |   43 +-
 drivers/video/console/newport_con.c                |   69 +-
 drivers/video/console/sticon.c                     |   79 +-
 drivers/video/console/vgacon.c                     |  152 +-
 drivers/video/fbdev/core/bitblit.c                 |   13 +-
 drivers/video/fbdev/core/fbcon.c                   |  123 +-
 drivers/video/fbdev/core/fbcon.h                   |    4 +-
 drivers/video/fbdev/core/fbcon_ccw.c               |   13 +-
 drivers/video/fbdev/core/fbcon_cw.c                |   13 +-
 drivers/video/fbdev/core/fbcon_ud.c                |   13 +-
 drivers/video/fbdev/core/tileblit.c                |    4 +-
 drivers/video/fbdev/tgafb.c                        |    2 +-
 drivers/w1/masters/Kconfig                         |   10 +
 drivers/w1/masters/Makefile                        |    1 +
 drivers/w1/masters/mxc_w1.c                        |    6 +-
 drivers/w1/masters/omap_hdq.c                      |    6 +-
 drivers/w1/masters/sgi_w1.c                        |    6 +-
 drivers/w1/masters/w1-gpio.c                       |    6 +-
 drivers/w1/masters/w1-uart.c                       |  415 ++++++
 drivers/w1/w1.c                                    |    2 +-
 include/linux/console.h                            |  126 +-
 include/linux/console_struct.h                     |    1 -
 include/linux/selection.h                          |   48 +-
 include/linux/serdev.h                             |    8 +-
 include/linux/serial_8250.h                        |    6 +
 include/linux/serial_core.h                        |   14 +-
 include/linux/soc/qcom/geni-se.h                   |    1 +
 include/linux/tty.h                                |    1 -
 include/linux/vt_kern.h                            |   12 +-
 include/uapi/linux/fb.h                            |    8 +-
 include/uapi/linux/vesa.h                          |   18 +
 kernel/printk/printk.c                             |   21 +-
 lib/Kconfig.kgdb                                   |    2 +-
 sound/drivers/serial-generic.c                     |    4 +-
 122 files changed, 3546 insertions(+), 2525 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st-asc.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/driver-api/tty/console.rst
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c
 create mode 100644 include/uapi/linux/vesa.h


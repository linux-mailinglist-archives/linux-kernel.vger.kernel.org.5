Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056778FFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbjIAPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbjIAPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D269210E5;
        Fri,  1 Sep 2023 08:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB4A61503;
        Fri,  1 Sep 2023 15:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A59CC433C8;
        Fri,  1 Sep 2023 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693581565;
        bh=bvVIhG6C9gwInm5Ew9R+Mu+moLulpYp+vGLCzqjeR0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=t/ZUfdPbOiIpQExNGaGaxj2wRBzoGoP5y1X6qKupL09PUYcLY2BUr0uYqtmndxHzG
         KqzGJ5Ddb3UqAzOV5IZRHtGymz6Ek63rcgKvKfUULxTV1FaYL7mrYZJmp0H/fnQ3zO
         2tL8PY6od896Xtbd4FvaC3L4fQ1ir+U/7hsQZxQA=
Date:   Fri, 1 Sep 2023 17:19:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt / PHY driver updates for 6.6-rc1
Message-ID: <ZPIA-hKjQRX1le-b@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc1

for you to fetch changes up to 895ed7eb263d7ce2d2592fdd3e211464a556084a:

  Merge tag 'usb-serial-6.6-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next (2023-08-27 13:11:05 +0200)

----------------------------------------------------------------
USB / Thunderbolt / PHY driver update for 6.6-rc1

Here is the big set of USB, Thunderbolt, and PHY driver updates for
6.6-rc1.  Included in here are:
  - PHY driver additions and cleanups
  - Thunderbolt minor additions and fixes
  - USB MIDI 2 gadget support added
  - dwc3 driver updates and additions
  - Removal of some old USB wireless code that was missed when that
    codebase was originally removed a few years ago, cleaning up some
    core USB code paths
  - USB core potential use-after-free fixes that syzbot from different
    people/groups keeps tripping over
  - typec updates and additions
  - gadget fixes and cleanups
  - loads of smaller USB core and driver cleanups all over the place

Full details are in the shortlog.  All of these have been in linux-next
for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (9):
      USB: core: Unite old scheme and new scheme descriptor reads
      USB: core: Change usb_get_device_descriptor() API
      USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()
      USB: Remove remnants of Wireless USB and UWB
      USB: Remove Wireless USB and UWB documentation
      USB: core: Fix unused variable warning in usb_alloc_dev()
      USB: core: Fix oversight in SuperSpeed initialization
      USB: gadget: core: Add missing kerneldoc for vbus_work
      USB: gadget: f_mass_storage: Fix unused variable warning

Anand Moon (1):
      usb: misc: onboard_usb_hub: add Genesys Logic GL3523 hub support

Andy Shevchenko (1):
      usb: musb: Use read_poll_timeout()

Badhri Jagan Sridharan (1):
      tcpm: Avoid soft reset when partner does not support get_status

Benjamin Bara (3):
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

Dan Drown (2):
      usb: cdc-acm: add PPS support
      usb: cdc-acm: move ldisc dcd notification outside of acm's read lock

Dmitry Baryshkov (3):
      usb: typec: qcom: properly detect Audio Accessory mode peripherals
      usb: typec: altmodes/displayport: add support for embedded DP cases
      usb: typec: qcom-pmic-typec: register drm_bridge

Fabio Estevam (2):
      dt-bindings: usb: ci-hdrc-usb2: Add the "fsl,imx35-usb" entry
      dt-bindings: usb: ci-hdrc-usb2: Fix clocks/clock-names maxItems

Greg Kroah-Hartman (4):
      Merge 6.5-rc4 into usb-next
      Merge 6.5-rc6 into usb-next
      Merge tag 'thunderbolt-for-v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.6-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Haotien Hsu (1):
      usb: xhci: tegra: Add shutdown callback for Tegra XUSB

Ivan Orlov (1):
      USB: make usb class a const structure

Jarkko Sonninen (1):
      USB: serial: xr: add TIOCGRS485 and TIOCSRS485 ioctls

Krzysztof Kozlowski (3):
      dt-bindings: usb: qcom,dwc3: drop assigned-clocks
      dt-bindings: usb: qcom,dwc3: correct SDM660 clocks
      dt-bindings: usb: samsung,exynos-dwc3: fix order of clocks on Exynos5433

Kyle Tso (1):
      usb: typec: tcpm: Refactor the PPS APDO selection

Ladislav Michl (9):
      usb: dwc3-am62: Rename private data
      usb: dwc3: dwc3-octeon: Convert to glue driver
      usb: dwc3: dwc3-octeon: Use _ULL bitfields defines
      usb: dwc3: dwc3-octeon: Pass dwc3_octeon to setup functions
      usb: dwc3: dwc3-octeon: Avoid half-initialized controller state
      usb: dwc3: dwc3-octeon: Move node parsing into driver probe
      usb: dwc3: dwc3-octeon: Dump control register on clock init failure
      usb: dwc3: dwc3-octeon: Add SPDX header and copyright
      usb: dwc3: dwc3-octeon: Verify clock divider

Li Zetao (2):
      usb: gadget: udc: Remove redundant initialization for udc_driver
      usb: core: Use module_led_trigger macro to simplify the code

Linyu Yuan (7):
      usb: gadget: use working speed to calcaulate network bitrate and qlen
      usb: gadget: add a inline function gether_bitrate()
      usb: gadget: f_uvc: change endpoint allocation in uvc_function_bind()
      usb: gadget: unconditionally allocate hs/ss descriptor in bind operation
      usb: gadget: config: remove max speed check in usb_assign_descriptors()
      usb: gadget: composite: cleanup function config_ep_by_speed_and_alt()
      usb: gadget: remove max support speed info in bind operation

Luke Lu (1):
      usb: dwc3: meson-g12a: do post init to fix broken usb after resumption

Ma Ke (1):
      usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Madhu M (1):
      usb: typec: intel_pmc_mux: Add new ACPI ID for Lunar Lake IOM device

Marco Felsch (2):
      dt-bindings: usb: Add binding for Genesys Logic GL3523 hub
      usb: typec: tcpci: clear the fault status bit

Martin Kohn (1):
      USB: serial: option: add Quectel EM05G variant (0x030e)

Mika Westerberg (3):
      thunderbolt: Log a warning if device links are not found
      thunderbolt: Check Intel vendor ID in tb_switch_get_generation()
      Documentation/ABI: thunderbolt: Replace 01.org in contact

Minda Chen (1):
      usb: cdns3: Add PHY mode switch to usb2 PHY

Oliver Neukum (2):
      USB: document ioctl USBDEVFS_GET_SPEED
      USB: dwc2: hande irq on dead controller correctly

Piyush Mehta (3):
      usb: gadget: udc-xilinx: fix restricted __le16 degrades to integer warning
      usb: gadget: udc-xilinx: fix cast from restricted __le16 warning
      usb: gadget: udc-xilinx: fix incorrect type in assignment warning

RD Babiera (2):
      usb: typec: bus: verify partner exists in typec_altmode_attention
      usb: typec: tcpm: set initial svdm version based on pd revision

Rob Herring (1):
      usb: Explicitly include correct DT includes

Ruan Jinjie (9):
      USB: cytherm: Correct the code style issue of redundant spaces
      usb: host: Do not check for 0 return after calling platform_get_irq()
      usb: gadget: udc: Remove unnecessary NULL values
      USB: misc: Remove unnecessary NULL values
      usb: chipidea: udc: Remove an unnecessary NULL value
      usb: musb: Remove an unnecessary NULL value
      USB: usbip: Remove an unnecessary NULL value
      USB: usbip: Remove an unnecessary goto
      usb: gadget/snps_udc_plat: Remove redundant of_match_ptr()

Sam Protsenko (3):
      dt-bindings: usb: samsung,exynos-dwc3: Fix Exynos5433 compatible
      usb: dwc3: exynos: Add support for Exynos850 variant
      dt-bindings: usb: samsung,exynos-dwc3: Add Exynos850 support

Saranya Gopal (1):
      usb: typec: ucsi: Add debugfs for ucsi commands

Simon Arlott (1):
      USB: cdc-acm: support flushing write buffers (TCOFLUSH)

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

Stanley Chang (7):
      usb: phy: add usb phy notify port status API
      phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
      phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY
      dt-bindings: phy: realtek: Add Realtek DHC RTD SoC USB 2.0 PHY
      dt-bindings: phy: realtek: Add Realtek DHC RTD SoC USB 3.0 PHY
      phy: realtek: usb: phy-rtk-usb2 and phy-rtk-usb3 needs USB_COMMON
      phy: realtek: usb: add the error handler for nvmem_cell_read

Takashi Iwai (7):
      usb: gadget: Add support for USB MIDI 2.0 function driver
      usb: gadget: midi2: Add configfs support
      usb: gadget: midi2: Dynamically create MIDI 1.0 altset descriptors
      usb: gadget: midi2: MIDI 1.0 interface (altset 0) support
      usb: gadget: midi2: Add testing documentation
      usb: gadget: midi2: Add "Operation Mode" control
      usb: gadget: midi2: More flexible MIDI 1.0 configuration

Tom Rix (1):
      thunderbolt: Set variable tmu_params storage class specifier to static

Utkarsh Patel (2):
      usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type
      platform/chrome: cros_ec_typec: Configure Retimer cable type

Uwe Kleine-König (2):
      usb: typec: nb7vpq904m: Switch back to use struct i2c_driver::probe
      usb: cdns3: starfive: Convert to platform remove callback returning void

Varadarajan Narayanan (1):
      dt-bindings: usb: dwc3: Add IPQ5332 compatible

Varshini Rajendran (1):
      dt-bindings: usb: ehci: Add atmel at91sam9g45-ehci compatible

Xiaolei Wang (1):
      usb: cdns3: Put the cdns set active part outside the spin lock

Xu Yang (11):
      usb: chipidea: imx: improve logic if samsung,picophy-* parameter is 0
      dt-bindings: usb: ci-hdrc-usb2: add fsl,picophy-rise-fall-time-adjust property
      usb: chipidea: imx: add one fsl picophy parameter tuning implementation
      usb: chipidea: add USB PHY event
      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()
      usb: phy: mxs: disconnect line when USB charger is attached
      usb: typec: tcpm: not sink vbus if operational current is 0mA
      usb: ehci: add workaround for chipidea PORTSC.PEC bug
      usb: chipidea: add workaround for chipidea PEC bug
      usb: host: ehci-sched: try to turn on io watchdog as long as periodic_count > 0
      usb: typec: tcpm: reset counter when enter into unattached state after try role

Yang Yingliang (3):
      usb: gadget: midi2: fix missing unlock in f_midi2_block_opts_create()
      USB: ohci-sm501: remove unnecessary check of mem
      usb: dwc3: remove unnecessary platform_set_drvdata()

Yangtao Li (30):
      usb: ehci-npcm7xx: fix typo in npcm7xx_ehci_hcd_drv_probe()
      usb: chipidea/core: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-at91: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-at91: Remove redundant msg at probe time
      usb: gadget: udc: udc-xilinx: Use devm_platform_get_and_ioremap_resource()
      usb: gadget: aspeed: Use devm_platform_get_and_ioremap_resource()
      usb: gadget/snps_udc_plat: Use devm_platform_get_and_ioremap_resource()
      usb: gadget/atmel_usba_udc: Use devm_platform_get_and_ioremap_resource()
      usb: gadget: aspeed_udc: Convert to devm_platform_ioremap_resource()
      usb: ehci-atmel: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-platform: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-spear: Use devm_platform_get_and_ioremap_resource()
      usb: isp1362-hcd: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-da8xx: Use devm_platform_get_and_ioremap_resource()
      usb: host: ohci-platform: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-sh: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-exynos: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-npcm7xx: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-nxp: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-orion: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-fsl: Use devm_platform_get_and_ioremap_resource()
      usb: oxu210hp-hcd: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-pxa27x: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-omap: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-spear: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-mv: Use devm_platform_get_and_ioremap_resource()
      usb: uhci-platform: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-st: Use devm_platform_get_and_ioremap_resource()
      usb: ehci-exynos: Use devm_platform_get_and_ioremap_resource()
      usb: ohci-st: Use devm_platform_get_and_ioremap_resource()

Yinbo Zhu (1):
      usb: dwc2: add pci_device_id driver_data parse support

Yue Haibing (3):
      usb: musb: Remove unused function declarations
      USB: misc: Remove unused include file usb_u132.h
      usb: gadget: function: Remove unused declarations

Zhu Wang (3):
      usb: musb: Fix deferred probing
      usb: typec: tcpci_mt6370: remove redundant dev_err_probe()
      usb: gadget: udc: gr_udc: Fix deferred probing

 CREDITS                                            |   11 -
 .../ABI/testing/configfs-usb-gadget-midi2          |   54 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   38 +-
 Documentation/ABI/testing/sysfs-bus-umc            |   28 -
 Documentation/ABI/testing/sysfs-bus-usb            |   34 -
 Documentation/ABI/testing/sysfs-class-uwb_rc       |  156 --
 .../ABI/testing/sysfs-class-uwb_rc-wusbhc          |   57 -
 Documentation/ABI/testing/sysfs-wusb_cbaf          |  101 -
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 .../devicetree/bindings/phy/realtek,usb2phy.yaml   |  175 ++
 .../devicetree/bindings/phy/realtek,usb3phy.yaml   |  107 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |   17 +-
 .../devicetree/bindings/usb/cypress,hx3.yaml       |   77 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    1 +
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |    1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   36 +-
 .../bindings/usb/samsung,exynos-dwc3.yaml          |   20 +-
 Documentation/driver-api/usb/usb.rst               |    9 +-
 Documentation/usb/authorization.rst                |    9 +-
 Documentation/usb/gadget-testing.rst               |  154 ++
 arch/mips/cavium-octeon/Makefile                   |    1 -
 arch/mips/cavium-octeon/octeon-platform.c          |    1 -
 drivers/net/wireless/mediatek/mt76/usb.c           |    3 +-
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/realtek/Kconfig                        |   27 +
 drivers/phy/realtek/Makefile                       |    3 +
 drivers/phy/realtek/phy-rtk-usb2.c                 | 1331 +++++++++
 drivers/phy/realtek/phy-rtk-usb3.c                 |  767 ++++++
 drivers/platform/chrome/cros_ec_typec.c            |   28 +-
 drivers/thunderbolt/acpi.c                         |   18 +-
 drivers/thunderbolt/switch.c                       |   73 +-
 drivers/thunderbolt/tb.c                           |   24 +-
 drivers/thunderbolt/tb.h                           |    4 +-
 drivers/thunderbolt/tmu.c                          |    2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |    1 +
 drivers/usb/cdns3/cdns3-plat.c                     |    4 +-
 drivers/usb/cdns3/cdns3-starfive.c                 |    6 +-
 drivers/usb/cdns3/cdns3-ti.c                       |    1 +
 drivers/usb/cdns3/cdnsp-pci.c                      |    3 +-
 drivers/usb/cdns3/core.c                           |   16 +-
 drivers/usb/cdns3/core.h                           |    7 +-
 drivers/usb/cdns3/drd.c                            |    4 +
 drivers/usb/chipidea/ci.h                          |   19 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   18 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c               |    3 +-
 drivers/usb/chipidea/core.c                        |    5 +-
 drivers/usb/chipidea/host.c                        |    1 +
 drivers/usb/chipidea/udc.c                         |   12 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |   18 +-
 drivers/usb/class/cdc-acm.c                        |   25 +
 drivers/usb/common/common.c                        |    1 +
 drivers/usb/core/config.c                          |    3 -
 drivers/usb/core/devices.c                         |    1 -
 drivers/usb/core/file.c                            |   68 +-
 drivers/usb/core/hcd.c                             |   50 +-
 drivers/usb/core/hub.c                             |  513 ++--
 drivers/usb/core/ledtrig-usbport.c                 |   13 +-
 drivers/usb/core/message.c                         |   30 +-
 drivers/usb/core/of.c                              |    1 -
 drivers/usb/core/sysfs.c                           |    3 -
 drivers/usb/core/urb.c                             |   27 +-
 drivers/usb/core/usb.c                             |   20 +-
 drivers/usb/core/usb.h                             |    5 +-
 drivers/usb/dwc2/core.h                            |    1 +
 drivers/usb/dwc2/gadget.c                          |    1 -
 drivers/usb/dwc2/hcd_intr.c                        |    4 +-
 drivers/usb/dwc2/params.c                          |   39 +-
 drivers/usb/dwc2/pci.c                             |   14 +-
 drivers/usb/dwc2/platform.c                        |    2 +-
 drivers/usb/dwc3/Kconfig                           |   10 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/dwc3-am62.c                       |   96 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |    9 +
 drivers/usb/dwc3/dwc3-imx8mp.c                     |    2 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |    3 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |    6 +
 .../octeon-usb.c => drivers/usb/dwc3/dwc3-octeon.c |  434 ++-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    1 -
 drivers/usb/gadget/Kconfig                         |   18 +
 drivers/usb/gadget/composite.c                     |   34 +-
 drivers/usb/gadget/config.c                        |    8 +-
 drivers/usb/gadget/function/Makefile               |    2 +
 drivers/usb/gadget/function/f_acm.c                |    4 +-
 drivers/usb/gadget/function/f_ecm.c                |   19 +-
 drivers/usb/gadget/function/f_eem.c                |    4 +-
 drivers/usb/gadget/function/f_loopback.c           |    4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |    2 +-
 drivers/usb/gadget/function/f_midi.c               |   56 +-
 drivers/usb/gadget/function/f_midi2.c              | 2871 ++++++++++++++++++++
 drivers/usb/gadget/function/f_ncm.c                |   23 +-
 drivers/usb/gadget/function/f_obex.c               |    3 +-
 drivers/usb/gadget/function/f_rndis.c              |   19 +-
 drivers/usb/gadget/function/f_serial.c             |    4 +-
 drivers/usb/gadget/function/f_sourcesink.c         |    4 +-
 drivers/usb/gadget/function/f_subset.c             |    4 +-
 drivers/usb/gadget/function/f_uvc.c                |   36 +-
 drivers/usb/gadget/function/u_ether.c              |    5 +-
 drivers/usb/gadget/function/u_ether.h              |   13 +
 drivers/usb/gadget/function/u_midi2.h              |   81 +
 drivers/usb/gadget/function/u_phonet.h             |    1 -
 drivers/usb/gadget/function/u_serial.h             |    4 -
 drivers/usb/gadget/function/uvc.h                  |    2 -
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |    3 +-
 drivers/usb/gadget/udc/aspeed_udc.c                |    4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    6 +-
 drivers/usb/gadget/udc/core.c                      |    1 +
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    2 +
 drivers/usb/gadget/udc/fsl_udc_core.c              |    3 +-
 drivers/usb/gadget/udc/gr_udc.c                    |   13 +-
 drivers/usb/gadget/udc/max3420_udc.c               |    4 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |    4 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |    2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |    2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |    2 +-
 drivers/usb/gadget/udc/renesas_usbf.c              |    6 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |    7 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    1 -
 drivers/usb/gadget/udc/udc-xilinx.c                |   35 +-
 drivers/usb/host/ehci-atmel.c                      |    7 +-
 drivers/usb/host/ehci-brcm.c                       |    4 +-
 drivers/usb/host/ehci-exynos.c                     |    3 +-
 drivers/usb/host/ehci-fsl.c                        |    5 +-
 drivers/usb/host/ehci-hcd.c                        |    8 +-
 drivers/usb/host/ehci-hub.c                        |   10 +-
 drivers/usb/host/ehci-mv.c                         |    3 +-
 drivers/usb/host/ehci-npcm7xx.c                    |    5 +-
 drivers/usb/host/ehci-omap.c                       |    3 +-
 drivers/usb/host/ehci-orion.c                      |    9 +-
 drivers/usb/host/ehci-platform.c                   |    3 +-
 drivers/usb/host/ehci-sched.c                      |    3 +-
 drivers/usb/host/ehci-sh.c                         |    7 +-
 drivers/usb/host/ehci-spear.c                      |    3 +-
 drivers/usb/host/ehci-st.c                         |   12 +-
 drivers/usb/host/ehci.h                            |   10 +
 drivers/usb/host/fhci-hcd.c                        |    3 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |    3 +-
 drivers/usb/host/isp1362-hcd.c                     |    3 +-
 drivers/usb/host/ohci-at91.c                       |    9 +-
 drivers/usb/host/ohci-da8xx.c                      |    4 +-
 drivers/usb/host/ohci-exynos.c                     |    3 +-
 drivers/usb/host/ohci-nxp.c                        |    3 +-
 drivers/usb/host/ohci-platform.c                   |    3 +-
 drivers/usb/host/ohci-ppc-of.c                     |    3 +-
 drivers/usb/host/ohci-pxa27x.c                     |    3 +-
 drivers/usb/host/ohci-sm501.c                      |    3 +-
 drivers/usb/host/ohci-spear.c                      |    3 +-
 drivers/usb/host/ohci-st.c                         |   14 +-
 drivers/usb/host/oxu210hp-hcd.c                    |    3 +-
 drivers/usb/host/uhci-platform.c                   |    3 +-
 drivers/usb/host/xhci-mem.c                        |    3 -
 drivers/usb/host/xhci-plat.c                       |    1 -
 drivers/usb/host/xhci-rcar.c                       |    1 -
 drivers/usb/host/xhci-tegra.c                      |   30 +-
 drivers/usb/host/xhci.c                            |   11 +-
 drivers/usb/misc/cypress_cy7c63.c                  |    2 +-
 drivers/usb/misc/cytherm.c                         |   12 +-
 drivers/usb/misc/onboard_usb_hub.c                 |   41 +-
 drivers/usb/misc/onboard_usb_hub.h                 |   15 +
 drivers/usb/misc/usb251xb.c                        |    2 +-
 drivers/usb/misc/usb_u132.h                        |   97 -
 drivers/usb/misc/usbsevseg.c                       |    2 +-
 drivers/usb/mtu3/mtu3.h                            |    1 +
 drivers/usb/mtu3/mtu3_host.c                       |    1 +
 drivers/usb/musb/cppi_dma.h                        |    3 -
 drivers/usb/musb/jz4740.c                          |    2 +-
 drivers/usb/musb/mediatek.c                        |    1 +
 drivers/usb/musb/mpfs.c                            |    1 +
 drivers/usb/musb/musb_core.c                       |    4 +-
 drivers/usb/musb/musb_dma.h                        |    4 -
 drivers/usb/musb/musb_dsps.c                       |    2 -
 drivers/usb/musb/musb_gadget.c                     |    2 +-
 drivers/usb/musb/sunxi.c                           |    1 -
 drivers/usb/musb/tusb6010.c                        |   17 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   16 +-
 drivers/usb/phy/phy-tegra-usb.c                    |    2 +-
 drivers/usb/renesas_usbhs/common.c                 |    2 +-
 drivers/usb/renesas_usbhs/rza.c                    |    2 +-
 drivers/usb/renesas_usbhs/rza2.c                   |    1 -
 drivers/usb/serial/option.c                        |    7 +
 drivers/usb/serial/xr_serial.c                     |   89 +-
 drivers/usb/typec/altmodes/displayport.c           |    5 +-
 drivers/usb/typec/bus.c                            |   12 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   53 +-
 drivers/usb/typec/mux/nb7vpq904m.c                 |    2 +-
 drivers/usb/typec/tcpm/Kconfig                     |    1 +
 drivers/usb/typec/tcpm/fusb302.c                   |    2 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |   39 +-
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |    2 -
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c |    6 +-
 drivers/usb/typec/tcpm/tcpci.c                     |    4 +
 drivers/usb/typec/tcpm/tcpci_mt6370.c              |    2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  175 +-
 drivers/usb/typec/ucsi/Kconfig                     |    1 +
 drivers/usb/typec/ucsi/Makefile                    |    2 +
 drivers/usb/typec/ucsi/debugfs.c                   |   99 +
 drivers/usb/typec/ucsi/ucsi.c                      |   15 +
 drivers/usb/typec/ucsi/ucsi.h                      |   24 +
 drivers/usb/typec/ucsi/ucsi_glink.c                |    1 -
 drivers/usb/usbip/vudc_dev.c                       |    5 +-
 include/linux/usb.h                                |   12 -
 include/linux/usb/ch9.h                            |    5 +-
 include/linux/usb/chipidea.h                       |    1 +
 include/linux/usb/composite.h                      |   23 -
 include/linux/usb/hcd.h                            |    2 -
 include/linux/usb/phy.h                            |   13 +
 include/linux/usb/tcpci.h                          |    1 +
 include/linux/usb/typec_altmode.h                  |    2 +-
 include/uapi/linux/usb/ch11.h                      |    6 +-
 include/uapi/linux/usb/ch9.h                       |    5 +-
 211 files changed, 7352 insertions(+), 1890 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-usb-gadget-midi2
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-umc
 delete mode 100644 Documentation/ABI/testing/sysfs-class-uwb_rc
 delete mode 100644 Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
 delete mode 100644 Documentation/ABI/testing/sysfs-wusb_cbaf
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/cypress,hx3.yaml
 create mode 100644 drivers/phy/realtek/Kconfig
 create mode 100644 drivers/phy/realtek/Makefile
 create mode 100644 drivers/phy/realtek/phy-rtk-usb2.c
 create mode 100644 drivers/phy/realtek/phy-rtk-usb3.c
 rename arch/mips/cavium-octeon/octeon-usb.c => drivers/usb/dwc3/dwc3-octeon.c (61%)
 create mode 100644 drivers/usb/gadget/function/f_midi2.c
 create mode 100644 drivers/usb/gadget/function/u_midi2.h
 delete mode 100644 drivers/usb/misc/usb_u132.h
 create mode 100644 drivers/usb/typec/ucsi/debugfs.c

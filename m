Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE87E028D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbjKCMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346626AbjKCMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:07:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD87D5E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:06:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9036C433C9;
        Fri,  3 Nov 2023 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699013217;
        bh=ir8l389zyYQLoUQ0dWIlMhYFobJSLYmg5ixV+pK99zQ=;
        h=Date:From:To:Cc:Subject:From;
        b=k1Nql0QKnMjmFTeKUojKUAIf5UYz4BPJr+9tyrzrYmFN5WFxK2iK7Ti6/qGG3morx
         dgdQCGxCuYQkqJZg2TfMm7cSCC8WHkARCOIyS4J3oxCM65635PIpujTC6RaQfXgq38
         yIBMvmLDbPMSsSU3TlxytEL422AYW11QnlIYZ+Z4=
Date:   Fri, 3 Nov 2023 13:06:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt changes for 6.7-rc1
Message-ID: <ZUTiWrNrErlNa4Hk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc1

for you to fetch changes up to c70793fb7632a153862ee9060e6d48131469a29c:

  usb: gadget: uvc: Add missing initialization of ssp config descriptor (2023-10-28 12:25:19 +0200)

----------------------------------------------------------------
USB/Thunderbolt changes for 6.7-rc1

Here is the "big" set of USB and Thunderbolt changes for 6.7-rc1.
Nothing really major in here, just lots of constant development for new
hardware.  Included in here are:
  - Thunderbolt (i.e. USB4) fixes for reported issues and support for
    new hardware types and devices
  - USB typec additions of new drivers and cleanups for some existing
    ones
  - xhci cleanups and expanded tracing support and some platform
    specific updates
  - USB "La Jolla Cove Adapter (LJCA)" support added, and the gpio, spi,
    and i2c drivers for that type of device (all acked by the respective
    subsystem maintainers.)
  - lots of USB gadget driver updates and cleanups
  - new USB dwc3 platforms supported, as well as other dwc3 fixes and
    cleanups
  - USB chipidea driver updates
  - other smaller driver cleanups and additions, full details in the
    shortlog

All of these have been in the linux-next tree for a while with no
reported problems, EXCEPT for some merge conflicts that you will run
into in your tree.  2 of them are in device-tree files, which will be
trivial to resolve (accept both sides), and the last in the
drivers/gpio/gpio-ljca.c file, in the remove callback, resolution should
be pretty trivial (take the version in this branch), see here:
	https://lore.kernel.org/all/20231016134159.11d8f849@canb.auug.org.au/
for details, or I can provide a resolved merge point if needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdel Alkuor (9):
      dt-bindings: usb: tps6598x: Add tps25750
      USB: typec: tsp6598x: Add cmd timeout and response delay
      USB: typec: tps6598x: Add patch mode to tps6598x
      USB: typec: tps6598x: Refactor tps6598x port registration
      USB: typec: tps6598x: Add device data to of_device_id
      USB: typec: tps6598x: Add TPS25750 support
      USB: typec: tps6598x: Add trace for tps25750 irq
      USB: typec: tps6598x: Add power status trace for tps25750
      USB: typec: tps6598x: Add status trace for tps25750

Andrey Konovalov (6):
      usb: gadget: clarify usage of USB_GADGET_DELAYED_STATUS
      usb: raw-gadget: return USB_GADGET_DELAYED_STATUS from setup()
      usb: gadgetfs: return USB_GADGET_DELAYED_STATUS from setup()
      usb: raw-gadget: properly handle interrupted requests
      usb: raw-gadget: don't disable device if usb_ep_queue fails
      usb: raw-gadget: report suspend, resume, reset, and disconnect events

Andy Shevchenko (1):
      usbip: Use platform_device_register_full()

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Add additional checks for contaminant

Basavaraj Natikar (2):
      xhci: Loosen RPM as default policy to cover for AMD xHC 1.1
      xhci: Enable RPM on controllers that support low-power states

Biju Das (5):
      usb: typec: tcpci_rt1711h: Remove trailing comma in the terminator entry for OF table
      usb: typec: tcpci_rt1711h: Convert enum->pointer for data in the match tables
      usb: typec: tcpci_rt1711h: Add rxdz_sel variable to struct rt1711h_chip_info
      usb: typec: tcpci_rt1711h: Add enable_pd30_extended_message variable to struct rt1711h_chip_info
      usb: typec: tcpci_rt1711h: Drop CONFIG_OF ifdeffery

Chunfeng Yun (2):
      usb: xhci-mtk: add a bandwidth budget table
      usb: xhci-mtk: improve split scheduling by separate IN/OUT budget

Dan Carpenter (1):
      usb: usbtest: fix a type promotion bug

Fabio Estevam (3):
      dt-bindings: usb: ci-hdrc-usb2: Allow "fsl,imx27-usb" to be passed alone
      dt-bindings: usb: gpio-sbu-mux: Add an entry for CBDTU02043
      dt-bindings: usb: gpio-sbu-mux: Make 'mode-switch' not required

Gil Fine (10):
      thunderbolt: Fix debug log when DisplayPort adapter not available for pairing
      thunderbolt: Fix typo of HPD bit for Hot Plug Detect
      thunderbolt: Log NVM version of routers and retimers
      thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs
      thunderbolt: Add DP IN added last in the head of the list of DP resources
      thunderbolt: Make is_gen4_link() available to the rest of the driver
      thunderbolt: Change bandwidth reservations to comply USB4 v2
      thunderbolt: Introduce tb_port_path_direction_downstream()
      thunderbolt: Add support for asymmetric link
      thunderbolt: Configure asymmetric link if needed and bandwidth allows

Grant B Adams (2):
      power: supply: Fix tps65217-charger vs vbus irq conflict
      usb: musb: dsps: Fix vbus vs tps65217-charger irq conflict

Greg Kroah-Hartman (8):
      Revert "phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support"
      Revert "usb: gadget: uvc: rework pump worker to avoid while loop"
      Revert "usb: gadget: uvc: cleanup request when not in correct state"
      Revert "usb: gadget: uvc: stop pump thread on video disable"
      Merge 6.6-rc6 into usb-next
      Revert "dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport"
      Revert "dt-bindings: usb: Add bindings for multiport properties on DWC3 controller"
      Merge tag 'thunderbolt-for-v6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next

Hardik Gajjar (2):
      usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
      usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Heikki Krogerus (3):
      usb: pd: Exposing the Peak Current value of Fixed Supplies to user space
      usb: typec: Link enumerated USB devices with Type-C partner
      usb: Inform the USB Type-C class about enumerated devices

Heiner Kallweit (1):
      usb: core: Remove duplicated check in usb_hub_create_port_device

Hongren Zheng (1):
      usb/usbip: fix wrong data added to platform device

James Gruber (1):
      usb: gadget: f_uac2: allow changing terminal types through configfs

Jerome Brunet (2):
      dt-bindings: usb: add device for Genesys Logic hub gl3510
      usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support

Jia-Ju Bai (1):
      usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Jimmy Hu (1):
      usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Jinjie Ruan (1):
      usbmon: Use list_for_each_entry() helper

Jisheng Zhang (1):
      dt-bindings: usb: vialab,vl817: remove reset-gpios from required list

Jonas Blixt (1):
      USB: usbip: fix stub_dev hub disconnect

Jonathan Bell (1):
      xhci: Use more than one Event Ring segment

Krishna Kurapati (4):
      dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
      dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
      usb: xhci: Move extcaps related macros to respective header file
      usb: gadget: udc: Handle gadget_connect failure during bind operation

LihaSika (1):
      usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Luca Weiss (5):
      dt-bindings: usb: add NXP PTN36502 Type-C redriver bindings
      usb: typec: add support for PTN36502 redriver
      dt-bindings: usb: fsa4480: Add data-lanes property to endpoint
      usb: typec: fsa4480: Add support to swap SBU orientation
      dt-bindings: usb: fsa4480: Add compatible for OCP96011

Lukas Wunner (7):
      xhci: Set DESI bits in ERDP register correctly
      xhci: Adjust segment numbers after ring expansion
      xhci: Update last segment pointer after Event Ring expansion
      xhci: Expose segment numbers in debugfs
      xhci: Clean up ERST_PTR_MASK inversion
      xhci: Clean up stale comment on ERST_SIZE macro
      xhci: Clean up xhci_{alloc,free}_erst() declarations

Mathias Nyman (6):
      xhci: pass port structure to tracing instead of port number
      xhci: Add busnumber to port tracing
      xhci: expand next_trb() helper to support more ring types
      xhci: simplify event ring dequeue tracking for transfer events
      xhci: Simplify event ring dequeue pointer update for port change events
      xhci: split free interrupter into separate remove and free parts

Michael Grzeschik (3):
      usb: gadget: uvc: stop pump thread on video disable
      usb: gadget: uvc: cleanup request when not in correct state
      usb: gadget: uvc: rework pump worker to avoid while loop

Michael Wu (1):
      usb:typec:tcpm:support double Rp to Vbus cable as sink

Michał Mirosław (3):
      usb: chipidea: Fix DMA overwrite for Tegra
      usb: chipidea: Simplify Tegra DMA alignment code
      usb: chipidea: tegra: Consistently use dev_err_probe()

Mika Westerberg (14):
      thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager
      thunderbolt: dma_test: Use enum tb_link_width
      thunderbolt: Get rid of usb4_usb3_port_actual_link_rate()
      thunderbolt: Make tb_switch_clx_is_supported() static
      thunderbolt: Check for unplugged router in tb_switch_clx_disable()
      thunderbolt: Fix typo in enum tb_link_width kernel-doc
      thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
      thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the driver
      thunderbolt: Use tb_tunnel_xxx() log macros in tb.c
      thunderbolt: Use constants for path weight and priority
      thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
      thunderbolt: Set path power management packet support bit for USB4 v2 routers
      thunderbolt: Introduce tb_for_each_upstream_port_on_path()
      thunderbolt: Introduce tb_switch_depth()

Milan Broz (2):
      usb-storage: remove UNUSUAL_VENDOR_INTF macro
      usb-storage,uas: make internal quirks flags 64bit

Neil Armstrong (4):
      dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio used to determine the Type-C port plug orientation
      usb: ucsi: glink: use the connector orientation GPIO to provide switch events
      arm64: dts: qcom: sm8550-mtp: add orientation gpio
      arm64: dts: qcom: sm8550-qrd: add orientation gpio

Niklas Schnelle (3):
      usb: pci-quirks: group AMD specific quirk code together
      usb: pci-quirks: handle HAS_IOPORT dependency for AMD quirk
      usb: pci-quirks: handle HAS_IOPORT dependency for UHCI handoff

Nitheesh Sekar (1):
      dt-bindings: usb: dwc3: Add IPQ5018 compatible

Pawel Laszczak (1):
      usb:cdnsp: remove TRB_FLUSH_ENDPOINT command

Piyush Mehta (1):
      usb: dwc3: xilinx: add reset-controller support

Randy Li (2):
      USB: dma: remove unused function prototype
      docs: driver-api: usb: update dma info

Rob Herring (3):
      usb: musb: Add missing of.h include
      usb: Use device_get_match_data()
      usb: chipidea: Fix unused ci_hdrc_usb2_of_match warning for !CONFIG_OF

Rohit Agarwal (5):
      dt-bindings: phy: qcom,snps-eusb2-phy: Add compatible for SDX75
      dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
      dt-bindings: usb: qcom,dwc3: Fix SDX65 clocks
      dt-bindings: usb: dwc3: Add SDX75 compatible
      phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support

Sebastian Reichel (3):
      dt-bindings: usb: add rk3588 compatible to rockchip,dwc3
      usb: dwc3: add optional PHY interface clocks
      arm64: dts: rockchip: rk3588s: Add USB3 host controller

Sergey Shtylyov (1):
      usb: host: xhci-plat: fix possible kernel oops while resuming

Shuzhen Wang (1):
      usb: gadget: uvc: Add missing initialization of ssp config descriptor

Stanley Chang (4):
      usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
      dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC DWC3 USB
      usb: dwc3: core: configure TX/RX threshold for DWC3_IP
      dt-bindings: usb: dwc3: Add DWC_usb3 TX/RX threshold configurable

Swarup Laxman Kotiaklapudi (1):
      usb: dwc3: document gfladj_refclk_lpm_sel field

Tomer Maimon (3):
      usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
      dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
      usb: chipidea: Add support for NPCM

Uday M Bhat (1):
      usb: typec: intel_pmc_mux: enable sysfs usb role access

Udipto Goswami (1):
      usb: xhci: Implement xhci_handshake_check_state() helper

Utkarsh Patel (5):
      usb: typec: Add Displayport Alternate Mode 2.1 Support
      usb: typec: Add Active or Passive cable defination to cable discover mode VDO
      usb: pd: Add helper macro to get Type C cable speed
      platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1 Support
      usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1

Uwe Kleine-König (8):
      usb: gadget: at91-udc: Convert to use module_platform_driver()
      usb: gadget: fsl-udc: Convert to use module_platform_driver()
      usb: gadget: fusb300-udc: Convert to use module_platform_driver()
      usb: gadget: lpc32xx-udc: Convert to use module_platform_driver()
      usb: gadget: m66592-udc: Convert to use module_platform_driver()
      usb: gadget: r8a66597-udc: Convert to use module_platform_driver()
      usb: mtu3: Convert to platform remove callback returning void
      usb: gadget: aspeed_udc: Convert to platform remove callback returning void

Wentong Wu (4):
      usb: Add support for Intel LJCA device
      i2c: Add support for Intel LJCA USB I2C driver
      spi: Add support for Intel LJCA USB SPI driver
      gpio: update Intel LJCA USB GPIO driver

Wesley Cheng (1):
      usb: host: xhci: Avoid XHCI resume delay if SSUSB device is not present

Wolfram Sang (2):
      usb: typec: drop check because i2c_unregister_device() is NULL safe
      usb: renesas_usbhs: remove boilerplate from header file

Yang Li (1):
      thunderbolt: Fix one kernel-doc comment

Yue Haibing (1):
      USB: c67x00: Remove unused declaration c67x00_hcd_msg_received()

 Documentation/ABI/testing/configfs-usb-gadget-uac2 |   2 +
 Documentation/ABI/testing/sysfs-bus-usb            |   9 +
 .../ABI/testing/sysfs-class-usb_power_delivery     |   7 +
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |   2 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |   7 +-
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  19 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |   7 +
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |  43 +-
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |   3 +-
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |   2 +-
 .../devicetree/bindings/usb/nxp,ptn36502.yaml      |  94 +++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   7 +
 .../devicetree/bindings/usb/realtek,rtd-dwc3.yaml  |  80 ++
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |  60 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  56 ++
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |  81 +-
 .../devicetree/bindings/usb/vialab,vl817.yaml      |   1 -
 Documentation/driver-api/usb/dma.rst               |  48 +-
 Documentation/usb/gadget-testing.rst               |   2 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |  21 +
 drivers/gpio/Kconfig                               |   4 +-
 drivers/gpio/gpio-ljca.c                           | 244 +++---
 drivers/i2c/busses/Kconfig                         |  11 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-ljca.c                      | 343 ++++++++
 drivers/platform/chrome/cros_ec_typec.c            |  28 +
 drivers/power/supply/tps65217_charger.c            |   2 +-
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-ljca.c                             | 297 +++++++
 drivers/thunderbolt/clx.c                          |  47 +-
 drivers/thunderbolt/dma_test.c                     |  14 +-
 drivers/thunderbolt/path.c                         |   7 +-
 drivers/thunderbolt/quirks.c                       |   3 +
 drivers/thunderbolt/retimer.c                      |   1 +
 drivers/thunderbolt/switch.c                       | 337 ++++++--
 drivers/thunderbolt/tb.c                           | 802 ++++++++++++++----
 drivers/thunderbolt/tb.h                           |  60 +-
 drivers/thunderbolt/tb_regs.h                      |  19 +-
 drivers/thunderbolt/tunnel.c                       | 263 +++---
 drivers/thunderbolt/tunnel.h                       |  26 +-
 drivers/thunderbolt/usb4.c                         | 135 ++-
 drivers/usb/Kconfig                                |  10 +
 drivers/usb/c67x00/c67x00-hcd.h                    |   1 -
 drivers/usb/cdns3/cdnsp-debug.h                    |   3 -
 drivers/usb/cdns3/cdnsp-gadget.c                   |   6 +-
 drivers/usb/cdns3/cdnsp-gadget.h                   |   5 -
 drivers/usb/cdns3/cdnsp-ring.c                     |  24 -
 drivers/usb/chipidea/Kconfig                       |   4 +
 drivers/usb/chipidea/Makefile                      |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c                | 114 +++
 drivers/usb/chipidea/ci_hdrc_tegra.c               |  16 +-
 drivers/usb/chipidea/ci_hdrc_usb2.c                |  13 +-
 drivers/usb/chipidea/host.c                        |  48 +-
 drivers/usb/chipidea/otg.c                         |   5 +-
 drivers/usb/core/hcd-pci.c                         |   3 +-
 drivers/usb/core/hub.c                             |   4 +
 drivers/usb/core/hub.h                             |   3 +
 drivers/usb/core/port.c                            |  22 +-
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/dwc2/params.c                          |  21 +-
 drivers/usb/dwc3/Kconfig                           |  11 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            | 188 ++++-
 drivers/usb/dwc3/core.h                            |  19 +
 drivers/usb/dwc3/dwc3-rtk.c                        | 475 +++++++++++
 drivers/usb/dwc3/dwc3-xilinx.c                     |  14 +-
 drivers/usb/gadget/function/f_ncm.c                |  27 +-
 drivers/usb/gadget/function/f_uac2.c               |  16 +-
 drivers/usb/gadget/function/f_uvc.c                |  14 +-
 drivers/usb/gadget/function/u_ether.c              |   2 +-
 drivers/usb/gadget/function/u_uac2.h               |   8 +
 drivers/usb/gadget/legacy/inode.c                  |  17 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  91 ++-
 drivers/usb/gadget/udc/aspeed_udc.c                |  19 +-
 drivers/usb/gadget/udc/at91_udc.c                  |   3 +-
 drivers/usb/gadget/udc/core.c                      |  19 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |  10 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   3 +-
 drivers/usb/gadget/udc/fusb300_udc.c               |   7 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   3 +-
 drivers/usb/gadget/udc/m66592-udc.c                |   3 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |   3 +-
 drivers/usb/host/pci-quirks.c                      | 144 ++--
 drivers/usb/host/pci-quirks.h                      |  34 +-
 drivers/usb/host/xhci-debugfs.c                    |   2 +-
 drivers/usb/host/xhci-ext-caps.h                   |  27 +
 drivers/usb/host/xhci-hub.c                        |   4 +-
 drivers/usb/host/xhci-mem.c                        |  96 ++-
 drivers/usb/host/xhci-mtk-sch.c                    | 418 ++++++++--
 drivers/usb/host/xhci-mtk.h                        |  17 +-
 drivers/usb/host/xhci-pci.c                        |   6 +-
 drivers/usb/host/xhci-plat.c                       |  23 +-
 drivers/usb/host/xhci-ring.c                       |  38 +-
 drivers/usb/host/xhci-trace.h                      |  23 +-
 drivers/usb/host/xhci.c                            |  40 +-
 drivers/usb/host/xhci.h                            |  45 +-
 drivers/usb/misc/Kconfig                           |  13 +
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/onboard_usb_hub.c                 |   7 +-
 drivers/usb/misc/onboard_usb_hub.h                 |   1 +
 drivers/usb/misc/usb-ljca.c                        | 902 +++++++++++++++++++++
 drivers/usb/misc/usbtest.c                         |   2 +-
 drivers/usb/mon/mon_main.c                         |  23 +-
 drivers/usb/mtu3/mtu3_plat.c                       |  18 +-
 drivers/usb/musb/da8xx.c                           |   1 +
 drivers/usb/musb/musb_dsps.c                       |   2 +-
 drivers/usb/storage/uas-detect.h                   |   4 +-
 drivers/usb/storage/uas.c                          |   4 +-
 drivers/usb/storage/unusual_cypress.h              |   2 +-
 drivers/usb/storage/usb.c                          |  20 +-
 drivers/usb/storage/usb.h                          |   4 +-
 drivers/usb/storage/usual-tables.c                 |  17 +-
 drivers/usb/typec/altmodes/displayport.c           |   5 +-
 drivers/usb/typec/anx7411.c                        |   3 +-
 drivers/usb/typec/class.c                          | 108 ++-
 drivers/usb/typec/class.h                          |  16 +
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/fsa4480.c                    |  71 ++
 drivers/usb/typec/mux/intel_pmc_mux.c              |  25 +
 drivers/usb/typec/mux/ptn36502.c                   | 444 ++++++++++
 drivers/usb/typec/pd.c                             |  10 +-
 drivers/usb/typec/port-mapper.c                    |   9 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |  46 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   9 +-
 drivers/usb/typec/tipd/core.c                      | 694 +++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h                  |  36 +
 drivers/usb/typec/tipd/trace.h                     |  92 +++
 drivers/usb/typec/ucsi/displayport.c               |   2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   4 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |  54 +-
 drivers/usb/usbip/stub_dev.c                       |   9 +-
 drivers/usb/usbip/vhci_hcd.c                       |  44 +-
 include/linux/thunderbolt.h                        |   2 +-
 include/linux/usb.h                                |  16 -
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/composite.h                      |   8 +
 include/linux/usb/gadget.h                         |   9 +
 include/linux/usb/hcd.h                            |  17 +
 include/linux/usb/ljca.h                           | 145 ++++
 include/linux/usb/pd.h                             |   1 +
 include/linux/usb/pd_vdo.h                         |   1 +
 include/linux/usb/renesas_usbhs.h                  |  10 -
 include/linux/usb/typec.h                          |  37 +
 include/linux/usb/typec_dp.h                       |  28 +-
 include/linux/usb/typec_tbt.h                      |   1 +
 include/uapi/linux/usb/raw_gadget.h                |  14 +-
 150 files changed, 7060 insertions(+), 1327 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nxp,ptn36502.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
 create mode 100644 drivers/i2c/busses/i2c-ljca.c
 create mode 100644 drivers/spi/spi-ljca.c
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c
 create mode 100644 drivers/usb/dwc3/dwc3-rtk.c
 create mode 100644 drivers/usb/misc/usb-ljca.c
 create mode 100644 drivers/usb/typec/mux/ptn36502.c
 create mode 100644 include/linux/usb/ljca.h

Return-Path: <linux-kernel+bounces-28898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636E830458
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619A1B2407F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D71DDDA;
	Wed, 17 Jan 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6sQbTqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB31CD3C;
	Wed, 17 Jan 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490102; cv=none; b=C1xXiSQmGpVRNZN05PiZN5Z2j2xQ4YvE75F3ld54LSN7N1Koc4sHyYcHJyePPRhiM4dj44nsYgjrzbN09zAEtj4x6hjshOJ7uuxJmbaXutjzYfoo4ZR1/ym+FKd2JxXnka4Eru4+QpGZf+LFDLJWP1L1NRlIBUOHqCRtQhRy46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490102; c=relaxed/simple;
	bh=Jo3cZYS9ZoCvg8NLvrL8giPLaPWqzGYMweHmWuYBNFU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding; b=tV6EtM5tWHVgc8+h9fr/PvVTBZJcSB2HE7Onl+kxOnFCMZ0e9EudTOhj7LiSfp6aKN1k1AgjeMLFKo2m7nT9wmvGAEiziQ21Gk4dVrv1pt2WuuGJfjtrujstmhhwHcLfEzhv6cWoVtk+iuLG5jAWy7vtScARxGRt0NfUVxlWOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6sQbTqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18518C433C7;
	Wed, 17 Jan 2024 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705490102;
	bh=Jo3cZYS9ZoCvg8NLvrL8giPLaPWqzGYMweHmWuYBNFU=;
	h=Date:From:To:Cc:Subject:From;
	b=s6sQbTqCteuiK2z7Gqfiwby5A8PsGckJ8woJxpZfU0ieoBKwpSAK7YNawuPSA0bKg
	 Ecs+L8c0CDBNUxPSCHy7dui8HbhtLMRmfHv6fgeBMVILae9VD+NRPBi0UMmCdPue+H
	 k0pYuP+K8EKfUCiRPJ+5mutUV7V2qv7Gyio6wibI=
Date: Wed, 17 Jan 2024 12:14:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt changes for 6.8-rc1
Message-ID: <Zae2swRz7N7Em5-v@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc1

for you to fetch changes up to 933bb7b878ddd0f8c094db45551a7daddf806e00:

  usb: typec: tipd: fix use of device-specific init function (2024-01-05 13:52:53 +0100)

----------------------------------------------------------------
USB / Thunderbolt changes for 6.8-rc1

Here is the big set of USB and Thunderbolt changes for 6.8-rc1.
Included in here are the following:
  - Thunderbolt subsystem and driver updates for USB 4 hardware and
    issues reported by real devices
  - xhci driver updates
  - dwc3 driver updates
  - uvc_video gadget driver updates
  - typec driver updates
  - gadget string functions cleaned up
  - other small changes

All of these have been in the linux-next tree for a while with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: usb: qcom,dwc3: Add X1E80100 binding

Alexander Stein (1):
      usb: cdns3: Use dev_err_probe

Andrey Konovalov (1):
      usb: raw-gadget: update documentation

Andrzej Pietrasiewicz (1):
      usb: gadget: webcam: Make g_webcam loadable again

Andy Shevchenko (10):
      xhci: dbc: Drop duplicate checks for dma_free_coherent()
      xhci: dbc: Convert to use sysfs_streq()
      xhci: dbc: Use sysfs_emit() to instead of scnprintf()
      xhci: dbc: Use ATTRIBUTE_GROUPS()
      xhci: dbc: Check for errors first in xhci_dbc_stop()
      xhci: dbc: Don't shadow error codes in store() functions
      xhci: dbc: Replace custom return value with proper Linux error code
      xhci: dbc: Use sizeof_field() where it makes sense
      xhci: dbc: Use sizeof(*pointer) instead of sizeof(type)
      xhci: dbc: Add missing headers

Avichal Rakesh (6):
      usb: gadget: uvc: prevent use of disabled endpoint
      usb: gadget: uvc: Allocate uvc_requests one at a time
      usb: gadget: uvc: move video disable logic to its own function
      usb: gadget: uvc: Fix use-after-free for inflight usb_requests
      usb: gadget: uvc: Fix use are free during STREAMOFF
      usb: gadget: uvc: Remove nested locking

Chen Ni (1):
      usb: misc: eud: Add IRQ check for platform_get_irq()

Christophe JAILLET (2):
      usb: chipidea: Remove usage of the deprecated ida_simple_xx() API
      usb: typec: Remove usage of the deprecated ida_simple_xx() API

Chunfeng Yun (3):
      dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
      usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer
      arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth' for cherry

Colin Ian King (2):
      thunderbolt: Remove duplicated re-assignment of pointer 'out'
      USB: misc: iowarrior: remove redundant assignment to variable io_res

Dmitry Antipov (1):
      usb: gadget: f_fs: fix fortify warning

Dmitry Baryshkov (5):
      dt-bindings: connector: usb: add altmodes description
      usb: typec: change altmode SVID to u16 entry
      arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid
      dt-bindings: connector: usb: add accessory mode description
      usb: typec: tcpm: Parse Accessory Mode information

Douglas Anderson (4):
      usb: core: Don't force USB generic_subclass drivers to define probe()
      usb: core: Allow subclassed USB drivers to override usb_choose_configuration()
      r8152: Choose our USB config with choose_configuration() rather than probe()
      usb: core: Fix crash w/ usb_choose_configuration() if no driver

Fabio Estevam (2):
      dt-bindings: usb: genesys,gl850g: Document 'peer-hub'
      dt-bindings: usb: nxp,ptn5110: Fix typos in the title

Frank Li (5):
      usb: cdns3: skip set TRB_IOC when usb_request: no_interrupt is true
      usb: cdns3: fix uvc failure work since sg support enabled
      usb: cdns3: fix iso transfer error when mult is not zero
      usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled
      Revert "usb: gadget: f_uvc: change endpoint allocation in uvc_function_bind()"

Frank Wang (1):
      usb: dwc3: set pm runtime active before resume common

Frieder Schrempf (3):
      usb: misc: onboard_usb_hub: Print symbolic error names
      usb: misc: onboard_usb_hub: Add support for clock input
      usb: misc: onboard_usb_hub: Add support for Cypress CY7C6563x

Ghanshyam Agrawal (1):
      usb: typec: fixed a typo

Gil Fine (8):
      thunderbolt: Handle lane bonding of Gen 4 XDomain links properly
      thunderbolt: Move width_name() helper to tb.h
      thunderbolt: Log XDomain link speed and width
      thunderbolt: Transition link to asymmetric only when both sides support it
      thunderbolt: Improve logging when DisplayPort resource is added due to hotplug
      thunderbolt: Make PCIe tunnel setup and teardown follow CM guide
      thunderbolt: Disable PCIe extended encapsulation upon teardown properly
      thunderbolt: Keep link as asymmetric if preferred by hardware

Greg Kroah-Hartman (4):
      Merge 6.7-rc3 into usb-next
      Merge 6.7-rc5 into usb-next
      thunderbolt: make tb_bus_type const
      Merge tag 'thunderbolt-for-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into char-misc-next

Guan-Yu Lin (1):
      usb: typec: tcpm: skip checking port->send_discover in PD3.0

Gui-Dong Han (1):
      usb: mon: Fix atomicity violation in mon_bin_vma_fault

Hardik Gajjar (4):
      usb: xhci: Add timeout argument in address_device USB HCD callback
      usb: new quirk to reduce the SET_ADDRESS request timeout
      usb: hub: Replace hardcoded quirk value with BIT() macro
      usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

Heikki Krogerus (1):
      Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

Himanshu Bhavani (1):
      usb: dwc3: imx8mp: Fix smatch warning

Jai Luthra (1):
      usb: typec: tipd: Separate reset for TPS6598x

Javier Carrasco (7):
      usb: typec: tps6598x: add reset gpio support
      dt-bindings: usb: tps6598x: add reset-gpios property
      usb: typec: tipd: add init and reset functions to tipd_data
      usb: typec: tipd: add function to request firmware
      usb: typec: tipd: declare in_data in as const in exec_cmd functions
      usb: typec: tipd: add patch update support for tps6598x
      usb: typec: tipd: fix use of device-specific init function

Jayant Chowdhary (1):
      usb:gadget:uvc Do not use worker thread to pump isoc usb requests

Kees Cook (1):
      usb: gadget: f_midi: Replace strlcpy() with strscpy()

Kevin Hao (1):
      usb: ueagle-atm: Use wait_event_freezable_timeout() in uea_wait()

Konrad Dybcio (9):
      dt-bindings: usb: qcom,dwc3: Fix SDM660 clock description
      arm64: dts: qcom: msm8916: Drop RPM bus clocks
      arm64: dts: qcom: msm8996: Drop RPM bus clocks
      arm64: dts: qcom: qcs404: Drop RPM bus clocks
      arm64: dts: qcom: sdm630: Drop RPM bus clocks
      arm64: dts: qcom: msm8939: Drop RPM bus clocks
      arm64: dts: qcom: msm8998: Remove AGGRE2 clock from SLPI
      arm64: dts: qcom: msm8996: Remove AGGRE2 clock from SLPI
      arm64: dts: qcom: msm8996: Remove PNoC clock from MSS

Krishna Kurapati (4):
      usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
      usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs
      dt-bindings: usb: dwc3: Clean up hs_phy_irq in binding
      usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq

Krzysztof Kozlowski (1):
      dt-bindings: usb: qcom,dwc3: adjust number of interrupts on SM6125

Kyle Tso (3):
      usb: typec: tcpm: Query Source partner for FRS capability only if it is DRP
      dt-bindings: connector: Add child nodes for multiple PD capabilities
      usb: typec: tcpm: Support multiple capabilities

Lad Prabhakar (1):
      dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC

Lee Jones (17):
      usb: atm: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      usb: cdnsp: Replace snprintf() with the safer scnprintf() variant
      usb: fotg210-hcd: Replace snprintf() with the safer scnprintf() variant
      usb: gadget: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      usb: gadget: f_tcm: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      usb: gadget: configfs: Replace snprintf() with the safer scnprintf() variant
      usb: gadget: f_uac1: Replace snprintf() with the safer scnprintf() variant
      usb: gadget: f_uac2: Replace snprintf() with the safer scnprintf() variant
      usb: gadget: uvc: Replace snprintf() with the safer scnprintf() variant
      usb: gadget: udc: atmel: Replace snprintf() with the safer scnprintf() variant
      usb: cdns2: Replace snprintf() with the safer scnprintf() variant
      usb: host: max3421-hcd: Replace snprintf() with the safer scnprintf() variant
      usb: yurex: Replace snprintf() with the safer scnprintf() variant
      usb: mon_stat: Replace snprintf() with the safer scnprintf() variant
      usb: mon_text: Replace snprintf() with the safer scnprintf() variant
      usb: phy: twl6030: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      usb: storage: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()

Manan Aurora (1):
      usb: dwc3: Support EBC feature of DWC_usb31

Mathias Nyman (4):
      xhci: Reconfigure endpoint 0 max packet size only during endpoint reset
      xhci: fix possible null pointer deref during xhci urb enqueue
      xhci: Fix null pointer dereference during S4 resume when resetting ep0
      xhci: add support to allocate several interrupters

Mika Westerberg (4):
      thunderbolt: Unwind TMU configuration if tb_switch_set_tmu_mode_params() fails
      thunderbolt: Disable CL states only when actually needed
      thunderbolt: Use tb_dp_read_cap() to read DP_COMMON_CAP as well
      thunderbolt: Add support for Intel Lunar Lake

Neil Armstrong (3):
      dt-bindings: usb: qcom,dwc3: document the SM8560 SuperSpeed DWC3 USB controller
      dt-bindings: usb: Document WCD939x USB SubSystem Altmode/Analog Audio Switch
      usb: typec: mux: add Qualcomm WCD939X USB SubSystem Altmode Mux driver

Niklas Neronin (7):
      xhci: check if legacy irq is available before using it as fallback
      xhci: add handler for only one interrupt line
      xhci: refactor static MSI-X function
      xhci: refactor static MSI function
      xhci: change 'msix_count' to encompass MSI or MSI-X vectors
      xhci: rework 'xhci_try_enable_msi()' MSI and MSI-X setup code
      xhci: minor coding style cleanup in 'xhci_try_enable_msi()'

Oliver Neukum (1):
      usb: cdc-acm: return correct error code on unsupported break

Perr Zhang (1):
      usb: f_uac1: adds support for SS and SSP

Piyush Mehta (2):
      usb: chipidea: udc: Add revision check of 2.20[CI_REVISION_22]
      usb: dwc3: xilinx: improve error handling for PM APIs

RD Babiera (3):
      usb: typec: tcpm: add tcpm_port_error_recovery symbol
      usb: typec: tcpci: add vconn over current fault handling to maxim_core
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Randy Dunlap (3):
      usb: cdns3: starfive: don't misuse /** comment
      usb: fotg210-udc: fix function kernel-doc comments
      usb: linux/usb.h: fix Excess kernel-doc description warning

Richard Acayan (1):
      usb: gadget: u_ether: Re-attach netif device to mirror detachment

Stefan Eichenberger (1):
      usb: phy: generic: add suspend support for regulator

Stefan Wahren (3):
      dt-bindings: usb: xhci: Add support for BCM2711
      usb: xhci: xhci-plat: Add support for BCM2711
      ARM: dts: bcm2711: Add BCM2711 xHCI support

Thinh Nguyen (2):
      Revert "usb: dwc3: Soft reset phy on probe for host"
      Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"

Uttkarsh Aggarwal (1):
      usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart

Uwe Kleine-König (6):
      USB: usbip: vudc: Convert to platform remove callback returning void
      usb: gadget: at91_udc: Convert to platform remove callback returning void
      usb: gadget: fsl_udc: Convert to platform remove callback returning void
      usb: gadget: gr_udc: Convert to platform remove callback returning void
      usb: gadget: lpc32xx_udc: Convert to platform remove callback returning void
      usb: gadget: pxa25x_udc: Convert to platform remove callback returning void

Werner Sembach (1):
      thunderbolt: Reduce retry timeout to speed up boot for some devices

Wesley Cheng (4):
      usb: dwc3: gadget: Handle EP0 request dequeuing properly
      usb: dwc3: gadget: Queue PM runtime idle on disconnect event
      dt-bindings: usb: xhci: Add num-hc-interrupters definition
      dt-bindings: usb: dwc3: Limit num-hc-interrupters definition

William Wu (1):
      usb: dwc2: Disable clock gating feature on Rockchip SoCs

Xu Yang (3):
      usb: chipidea: ci_hdrc_imx: add wakeup clock and keep it always on
      usb: chipidea: wait controller resume finished for wakeup irq
      usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_host()

Yajun Deng (1):
      USB: core: Use device_driver directly in struct usb_driver and usb_device_driver

Yinbo Zhu (1):
      usb: xhci-plat: fix usb disconnect issue after s4

liyouhong (1):
      drivers/usb/gadget/udc: Fix spelling typo in comments(reqest->request)

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 .../bindings/connector/usb-connector.yaml          | 124 +++-
 .../devicetree/bindings/usb/generic-xhci.yaml      |  25 +-
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |   5 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |  11 +
 .../devicetree/bindings/usb/nxp,ptn5110.yaml       |   2 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 217 +++---
 .../bindings/usb/qcom,wcd939x-usbss.yaml           | 102 +++
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   2 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   4 +
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |   6 +
 .../devicetree/bindings/usb/usb-xhci.yaml          |   6 +
 Documentation/usb/gadget-testing.rst               |  20 +-
 Documentation/usb/raw-gadget.rst                   |   3 -
 arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi        |   5 +
 arch/arm/boot/dts/broadcom/bcm2711.dtsi            |  14 +
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   9 -
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  12 -
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  43 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   5 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   9 -
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  53 +-
 drivers/bluetooth/btusb.c                          |   6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   2 +-
 drivers/net/usb/r8152.c                            |  16 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |   2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c         |   2 +-
 drivers/thunderbolt/domain.c                       |   2 +-
 drivers/thunderbolt/icm.c                          |   2 +-
 drivers/thunderbolt/nhi.c                          |   4 +
 drivers/thunderbolt/nhi.h                          |   2 +
 drivers/thunderbolt/switch.c                       |  33 +-
 drivers/thunderbolt/tb.c                           |  74 +-
 drivers/thunderbolt/tb.h                           |  18 +
 drivers/thunderbolt/tmu.c                          |   2 +-
 drivers/thunderbolt/tunnel.c                       |  46 +-
 drivers/thunderbolt/xdomain.c                      |  54 +-
 drivers/tty/tty_io.c                               |   3 +
 drivers/usb/atm/ueagle-atm.c                       |  19 +-
 drivers/usb/cdns3/cdns3-gadget.c                   | 149 +++-
 drivers/usb/cdns3/cdns3-gadget.h                   |   3 +
 drivers/usb/cdns3/cdns3-plat.c                     |  16 +-
 drivers/usb/cdns3/cdns3-starfive.c                 |   2 +-
 drivers/usb/cdns3/cdnsp-debug.h                    | 354 +++++-----
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  17 +-
 drivers/usb/chipidea/core.c                        |  13 +-
 drivers/usb/chipidea/udc.c                         |   3 +-
 drivers/usb/class/cdc-acm.c                        |   3 +
 drivers/usb/core/driver.c                          |  64 +-
 drivers/usb/core/generic.c                         |  16 +
 drivers/usb/core/hub.c                             |  48 +-
 drivers/usb/core/quirks.c                          |   7 +
 drivers/usb/core/usb.c                             |   2 +-
 drivers/usb/core/usb.h                             |   8 +-
 drivers/usb/dwc2/params.c                          |   1 +
 drivers/usb/dwc3/core.c                            |  62 +-
 drivers/usb/dwc3/core.h                            |   6 +
 drivers/usb/dwc3/dwc3-imx8mp.c                     |   4 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  22 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |  13 +-
 drivers/usb/dwc3/ep0.c                             |   5 +-
 drivers/usb/dwc3/gadget.c                          |  25 +-
 drivers/usb/dwc3/gadget.h                          |   2 +
 drivers/usb/fotg210/fotg210-hcd.c                  |  12 +-
 drivers/usb/fotg210/fotg210-udc.c                  |   6 +-
 drivers/usb/gadget/configfs.c                      |  13 +-
 drivers/usb/gadget/function/f_fs.c                 |   5 +-
 drivers/usb/gadget/function/f_midi.c               |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |  69 +-
 drivers/usb/gadget/function/f_tcm.c                |   4 +-
 drivers/usb/gadget/function/f_uac1.c               |  83 ++-
 drivers/usb/gadget/function/f_uac2.c               |   6 +-
 drivers/usb/gadget/function/f_uvc.c                |  68 +-
 drivers/usb/gadget/function/f_uvc.h                |   2 +-
 drivers/usb/gadget/function/u_ether.c              |   2 +
 drivers/usb/gadget/function/u_ncm.h                |   2 +
 drivers/usb/gadget/function/u_uvc.h                |   6 +
 drivers/usb/gadget/function/uvc.h                  |  14 +-
 drivers/usb/gadget/function/uvc_configfs.c         |   2 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |  16 +-
 drivers/usb/gadget/function/uvc_video.c            | 449 +++++++++---
 drivers/usb/gadget/function/uvc_video.h            |   3 +-
 drivers/usb/gadget/legacy/webcam.c                 | 333 ++++++---
 drivers/usb/gadget/udc/at91_udc.c                  |  13 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   3 +-
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h         | 138 ++--
 drivers/usb/gadget/udc/fsl_udc_core.c              |  15 +-
 drivers/usb/gadget/udc/gr_udc.c                    |  13 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |  13 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |   2 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |  12 +-
 drivers/usb/host/max3421-hcd.c                     |  18 +-
 drivers/usb/host/xhci-dbgcap.c                     | 132 ++--
 drivers/usb/host/xhci-dbgcap.h                     |   1 +
 drivers/usb/host/xhci-debugfs.c                    |   2 +-
 drivers/usb/host/xhci-mem.c                        | 110 ++-
 drivers/usb/host/xhci-mtk.c                        |  40 +-
 drivers/usb/host/xhci-mtk.h                        |   2 +
 drivers/usb/host/xhci-pci.c                        | 140 ++--
 drivers/usb/host/xhci-plat.c                       |  26 +-
 drivers/usb/host/xhci-ring.c                       |  13 +-
 drivers/usb/host/xhci.c                            | 213 +++---
 drivers/usb/host/xhci.h                            |  19 +-
 drivers/usb/misc/iowarrior.c                       |   1 -
 drivers/usb/misc/onboard_usb_hub.c                 |  26 +-
 drivers/usb/misc/onboard_usb_hub.h                 |   6 +
 drivers/usb/misc/qcom_eud.c                        |   3 +
 drivers/usb/misc/yurex.c                           |  14 +-
 drivers/usb/mon/mon_bin.c                          |   7 +-
 drivers/usb/mon/mon_stat.c                         |   6 +-
 drivers/usb/mon/mon_text.c                         |  28 +-
 drivers/usb/phy/phy-generic.c                      |  14 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   3 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   8 +-
 drivers/usb/serial/bus.c                           |   2 +-
 drivers/usb/serial/usb-serial.c                    |   2 +-
 drivers/usb/storage/sierra_ms.c                    |  16 +-
 drivers/usb/storage/uas.c                          |   2 +-
 drivers/usb/typec/class.c                          |  17 +-
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/wcd939x-usbss.c              | 779 +++++++++++++++++++++
 drivers/usb/typec/pd.c                             |   6 +-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  20 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 417 ++++++++---
 drivers/usb/typec/tipd/core.c                      | 177 ++++-
 drivers/usb/typec/tipd/tps6598x.h                  |  18 +
 drivers/usb/usbip/stub_main.c                      |   8 +-
 drivers/usb/usbip/vudc.h                           |   2 +-
 drivers/usb/usbip/vudc_dev.c                       |   3 +-
 drivers/usb/usbip/vudc_main.c                      |   2 +-
 include/linux/thunderbolt.h                        |   2 +-
 include/linux/usb.h                                |  31 +-
 include/linux/usb/gadget.h                         |   1 +
 include/linux/usb/hcd.h                            |   5 +-
 include/linux/usb/quirks.h                         |   3 +
 include/linux/usb/tcpci.h                          |   5 +-
 include/linux/usb/tcpm.h                           |   1 +
 include/uapi/linux/usb/functionfs.h                |   6 +-
 142 files changed, 3945 insertions(+), 1549 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
 create mode 100644 drivers/usb/typec/mux/wcd939x-usbss.c


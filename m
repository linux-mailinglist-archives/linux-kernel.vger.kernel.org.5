Return-Path: <linux-kernel+bounces-110063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07FB885981
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E631F23AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2B83CD9;
	Thu, 21 Mar 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H75o1tJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BF74E05;
	Thu, 21 Mar 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026055; cv=none; b=GE3bpYBhi1y0An72IFkeRPUYxSYGZH7zmyUVB74csNEFzWDL8yK5kYcXjekTbVhz3n+WwTsKA0drNr/OFKhAZ1KmHzK0509x8siKVcgkCArDaLb8K9juNf/NE9ot5zKOr4WrHHIJq2+M8aBRVNdTGl8frU5wuHhxr9srmRLQ8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026055; c=relaxed/simple;
	bh=i/OKgn5SBxTaMojTVr/mBi7+R1aeO0M8cUX78u9UuKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r5Zg89ya7Zuwo5717ZLoIPpB37J4/1xfV5pIhIJ0QXS7C5Kzt6duqEPUyGsHfSS9uspcFBY93G1NHpiaxsPhsrGuz2jw0MAyXOuDtDW0I+QVlFgNxTWWq6LTrbrqZQi5adsfw2DPSpUZ2OhOjksixEurBvpGyht9ksrE9+MsWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H75o1tJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D64C433F1;
	Thu, 21 Mar 2024 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711026054;
	bh=i/OKgn5SBxTaMojTVr/mBi7+R1aeO0M8cUX78u9UuKw=;
	h=Date:From:To:Cc:Subject:From;
	b=H75o1tJM4/bJsQy3VaXQ7zwu8/+ns4mGa0FuzPt+dnh0RjOtYaycc9V3HE+2Ze5wa
	 OgIjjZWyfAnFXnQ1a3W/xp/EjH5tE2EAlUXsuzaTg2KN6S1hMsxcqn8ARLeKm4tswe
	 GbN6VvbZ4UyYr4LXbiWjsX5EZx+yl+K3qHguM2s8=
Date: Thu, 21 Mar 2024 14:00:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver changes for 6.9-rc1
Message-ID: <Zfwvg03C-ptMQKVk@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc1

for you to fetch changes up to a788e53c05aee6e3d60792a59e10c0fac56b5086:

  usb: usb-acpi: Fix oops due to freeing uninitialized pld pointer (2024-03-19 13:07:35 +0100)

----------------------------------------------------------------
USB/Thunderbolt changes for 6.9-rc1

Here is the big set of USB and Thunderbolt changes for 6.9-rc1.  Lots of
tiny changes and forward progress to support new hardware and better
support for existing devices.  Included in here are:
  - Thunderbolt (i.e. USB4) updates for newer hardware and uses as more
    people start to use the hardware
  - default USB authentication mode Kconfig and documentation update to
    make it more obvious what is going on
  - USB typec updates and enhancements
  - usual dwc3 driver updates
  - usual xhci driver updates
  - function USB (i.e. gadget) driver updates and additions
  - new device ids for lots of drivers
  - loads of other small updates, full details in the shortlog

All of these, including a "last minute regression fix" have been in
linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhishek Pandit-Subedi (3):
      usb: typec: ucsi: Limit read size on v1.2
      usb: typec: ucsi: Update connector cap and status
      usb: typec: ucsi: Get PD revision for partner

Alexander Tsoy (1):
      usb: audio-v2: Correct comments for struct uac_clock_selector_descriptor

Andy Shevchenko (3):
      usb: ohci-pxa27x: Remove unused of_gpio.h
      usb: gadget/snps_udc_plat: Remove unused of_gpio.h
      USB: gadget: pxa27x_udc: Remove unused of_gpio.h

AngeloGioacchino Del Regno (4):
      dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
      usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver
      dt-bindings: usb: mtu3: Add MT8195 MTU3 ip-sleep support
      usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup support

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Basavaraj Natikar (1):
      xhci: Allow RPM on the USB controller (1022:43f7) by default

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Chengming Zhou (1):
      usb: isp1760: remove SLAB_MEM_SPREAD flag usage

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christophe JAILLET (1):
      thunderbolt: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (10):
      usb: dwc3: gadget: Remove redundant assignment to pointer trb
      usb: storage: freecom: Remove redundant assignment to variable offset
      usb: image: mdc800: Remove redundant assignment to variable retval
      usb: cdns3: Fix spelling mistake "supporte" -> "supported"
      USB: serial: oti6858: remove redundant assignment to variable divisor
      USB: serial: ftdi_sio: remove redundant assignment to variable cflag
      USB: serial: keyspan: remove redundant assignment to pointer data
      usb: musb: remove unused variable 'count'
      usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
      usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin

Dan Carpenter (1):
      usb: dwc3: Fix an IS_ERR() vs NULL check in dwc3_power_off_all_roothub_ports()

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Danila Tikhonov (2):
      dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
      arm64: dts: qcom: pm6150: define USB-C related blocks

Dmitry Baryshkov (7):
      usb: typec: qcom-pmic-typec: fix arguments of qcom_pmic_typec_pdphy_set_roles
      usb: typec: qcom-pmic-typec: allow different implementations for the PD PHY
      usb: typec: qcom-pmic-typec: allow different implementations for the port backend
      dt-bindings: regulator: qcom,usb-vbus-regulator: add support for PMI632
      dt-bindings: usb: qcom,pmic-typec: add support for the PMI632 block
      usb: typec: qcom-pmic-typec: add support for PMI632 PMIC
      dt-bindings: usb: qcom,pmic-typec: add support for the PM4125 block

Elad Nachman (2):
      dt-bindings: usb: Add Marvell ac5
      usb: host: Add ac5 to EHCI Orion

Elbert Mai (2):
      usb: Export BOS descriptor to sysfs
      usb: Clarify expected behavior of dev_bin_attrs_are_visible()

Frank Li (3):
      XHCI: Separate PORT and CAPs macros into dedicated file
      dt-bindings: usb: dwc3: drop 'snps,host-vbus-glitches-quirk'
      usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally

Gabor Juhos (1):
      dt-bindings: usb: qcom,dwc3: fix a typo in interrupts' description

Gil Fine (3):
      thunderbolt: Calculate DisplayPort tunnel bandwidth after DPRX capabilities read
      thunderbolt: Improve DisplayPort tunnel setup process to be more robust
      thunderbolt: Add trace events support for the control channel

Greg Kroah-Hartman (6):
      Merge 6.8-rc3 into usb-next
      Merge 6.8-rc5 into usb-next
      Revert "xhci: add helper to stop endpoint and wait for completion"
      Merge v6.8-rc6 into usb-next
      Merge tag 'thunderbolt-for-v6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.9-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guan-Yu Lin (1):
      usb: sysfs: use kstrtobool() if possible

Haotien Hsu (1):
      ucsi_ccg: Refine the UCSI Interrupt handling

Heikki Krogerus (2):
      usb: roles: Link the switch to its connector
      platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD

Jameson Thies (4):
      usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
      usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
      usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
      usb: typec: ucsi: Register SOP' alternate modes with cable plug

Javier Carrasco (1):
      usb: misc: onboard_hub: use pointer consistently in the probe function

Karina Yankevich (1):
      usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()

Krishna Kurapati (1):
      usb: dwc3: qcom: Remove ACPI support from glue driver

Krzysztof Kozlowski (3):
      dt-bindings: usb: add common Type-C USB Switch schema
      ASoC: Revert "ASoC: dt-bindings: Update example for enabling USB offload on SM8250"
      dt-bindings: usb: analogix,anx7411: drop redundant connector properties

Luca Weiss (3):
      dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 compatible
      usb: typec: ucsi: Add qcm6490-pmic-glink as needing PDOS quirk
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMIC GLINK

Macpaul Lin (2):
      dt-bindings: usb: Add binding for TI USB8020B hub controller
      usb: misc: onboard_usb_hub: Add support for TI TUSB8020B

Marco Felsch (3):
      dt-bindings: usb: typec-tcpci: add tcpci fallback binding
      usb: typec: tcpci: add generic tcpci fallback compatible
      usb: typec: tcpm: add support to set tcpc connector orientatition

Mathias Nyman (13):
      xhci: Add interrupt pending autoclear flag to each interrupter
      xhci: Add helper to set an interrupters interrupt moderation interval
      xhci: make isoc_bei_interval variable interrupter specific.
      xhci: remove unnecessary event_ring_deq parameter from xhci_handle_event()
      xhci: update event ring dequeue pointer position to controller correctly
      xhci: move event processing for one interrupter to a separate function
      xhci: add helper that checks for unhandled events on a event ring
      xhci: Don't check if the event ring is valid before every event TRB
      xhci: Decouple handling an event from checking for unhandled events
      xhci: add helper to stop endpoint and wait for completion
      xhci: dbc: poll at different rate depending on data transfer activity
      usb: usb-acpi: Set port connect type of not connectable ports correctly
      usb: usb-acpi: Fix oops due to freeing uninitialized pld pointer

Michael Grzeschik (5):
      usb: gadget: uvc: drop unnecessary check for always set req
      usb: gadget: uvc: refactor the check for a valid buffer in the pump worker
      usb: gadget: uvc: rework complete handler
      usb: gadget: uvc: dont drop frames if zero length packages are late
      usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR

Michal Pecio (3):
      xhci: fix matching completion events with TDs
      xhci: retry Stop Endpoint on buggy NEC controllers
      USB: document some API requirements on disconnection

Mika Westerberg (12):
      thunderbolt: Reset only non-USB4 host routers in resume
      thunderbolt: Skip discovery also in USB4 v2 host
      thunderbolt: Correct typo in host_reset parameter
      thunderbolt: Use DP_LOCAL_CAP for maximum bandwidth calculation
      thunderbolt: Re-calculate estimated bandwidth when allocation mode is enabled
      thunderbolt: Handle bandwidth allocation mode disable request
      thunderbolt: Log an error if DPTX request is not cleared
      thunderbolt: Fail the failed bandwidth request properly
      thunderbolt: Re-order bandwidth group functions
      thunderbolt: Introduce tb_tunnel_direction_downstream()
      thunderbolt: Reserve released DisplayPort bandwidth for a group for 10 seconds
      thunderbolt: Keep the domain powered when USB4 port is in redrive mode

Mohammad Rahimi (2):
      thunderbolt: Fix XDomain rx_lanes_show and tx_lanes_show
      thunderbolt: Fix rollback in tb_port_lane_bonding_enable() for lane 1

Niklas Neronin (5):
      xhci: rework how real & fake ports are found
      xhci: replace real & fake port with pointer to root hub port
      xhci: save slot ID in struct 'xhci_port'
      usb: xhci: remove duplicate code from 'xhci_clear_command_ring()'
      usb: xhci: utilize 'xhci_free_segments_for_ring()' for freeing segments

Niko Mauno (3):
      usb: core: Amend initial authorized_default value
      usb: core: Make default authorization mode configurable
      usb: core: Kconfig: Improve USB authorization mode help

Nícolas F. R. A. Prado (3):
      kselftest: Add test to verify probe of devices from discoverable buses
      kselftest: devices: Add sample board file for google,spherion
      kselftest: devices: Add sample board file for XPS 13 9300

Oliver Neukum (4):
      USB: uapi: OTG 3.0
      usb: usb_autopm_get_interface use modern helper
      USB: typec: no opencoding FIELD_GET
      usb: typec: pd: no opencoding of FIELD_GET

Paul Cercueil (4):
      usb: gadget: Support already-mapped DMA SGs
      usb: gadget: functionfs: Factorize wait-for-endpoint code
      usb: gadget: functionfs: Add DMABUF import interface
      Documentation: usb: Document FunctionFS DMABUF API

Peter Korsgaard (1):
      usb: gadget: f_fs: expose ready state in configfs

Philipp Zabel (1):
      usb: dwc3-of-simple: Stop using of_reset_control_array_get() directly

Prashanth K (1):
      usb: xhci: Add error handling in xhci_map_urb_for_dma

RD Babiera (14):
      usb: typec: altmodes: add typec_cable_ops to typec_altmode
      usb: typec: altmodes: add svdm version info for typec cables
      usb: typec: tcpci: add cable_comm_capable attribute
      usb: typec: tcpci: add tcpm_transmit_type to tcpm_pd_receive
      usb: typec: tcpm: process receive and transmission of sop' messages
      usb: typec: tcpm: add control message support to sop'
      usb: typec: tcpci: add attempt_vconn_swap_discovery callback
      usb: typec: tcpm: add discover identity support for SOP'
      usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST
      usb: typec: tcpm: add discover svids and discover modes support for sop'
      usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'
      usb: typec: altmodes/displayport: add SOP' support
      usb: typec: tcpm: fix SOP' sequences in tcpm_pd_svdm
      usb: typec: altmodes/displayport: send configure message on sop'

Ran Wang (2):
      dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
      usb: dwc3: Add workaround for host mode VBUS glitch when boot

Ricardo B. Marliere (6):
      usb: typec: constify the struct device_type usage
      usb: phy: constify the struct device_type usage
      usb: gadget: constify the struct device_type usage
      usb: core: constify the struct device_type usage
      thunderbolt: Constify the struct device_type usage
      usb: typec: constify struct class usage

Rob Herring (1):
      dt-bindings: usb: Clean-up "usb-phy" constraints

Roger Quadros (5):
      dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
      usb: dwc3-am62: fix module unload/reload behavior
      usb: dwc3-am62: Disable wakeup at remove
      usb: dwc3-am62: Fix PHY core voltage selection
      usb: dwc3-am62: add workaround for Errata i2409

Sanath S (4):
      thunderbolt: Introduce tb_port_reset()
      thunderbolt: Introduce tb_path_deactivate_hop()
      thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3 and USB4 routers
      thunderbolt: Reset topology created by the boot firmware

Sean Anderson (4):
      dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
      usb: phy: generic: Get the vbus supply
      usb: phy: generic: Implement otg->set_vbus
      usb: phy: generic: Disable vbus on removal

Serge Semin (1):
      powerpc: dts: akebono: Harmonize EHCI/OHCI DT nodes name

Stanley Chang (4):
      phy: core: add notify_connect and notify_disconnect callback
      phy: realtek: usb: add new driver for the Realtek RTD SoC USB 2.0 PHY
      phy: realtek: usb: add new driver for the Realtek RTD SoC USB 3.0 PHY
      usb: core: add phy notify connect and disconnect

Stefan Eichenberger (1):
      dt-bindings: usb: microchip,usb5744: Remove peer-hub as requirement

Stephen Boyd (2):
      dt-bindings: usb: Add downstream facing ports to realtek binding
      usb: core: Set connect_type of ports based on DT node

Thinh Nguyen (1):
      usb: dwc3: gadget: Rewrite endpoint allocation flow

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Uwe Kleine-König (3):
      usb: gadget: fsl-udc: Replace custom log wrappers by dev_{err,warn,dbg,vdbg}
      usb: gadget: fsl: Add of device table to enable module autoloading
      usb: gadget: fsl: Increase size of name buffer for endpoints

Wayne Chang (2):
      phy: tegra: xusb: Add API to retrieve the port number of phy
      usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Wesley Cheng (3):
      ASoC: dt-bindings: Add Q6USB backend
      ASoC: dt-bindings: Update example for enabling USB offload on SM8250
      usb: dwc3: core: Add DWC31 version 2.00a controller

Yang Xiwen (2):
      dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
      usb: dwc3: of-simple: Add compatible for hi3798mv200 DWC3 controller

 Documentation/ABI/testing/configfs-usb-gadget-ffs  |   12 +-
 Documentation/ABI/testing/sysfs-bus-usb            |   10 +
 Documentation/ABI/testing/sysfs-class-usb_role     |    6 +
 .../regulator/qcom,usb-vbus-regulator.yaml         |    9 +-
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |    1 +
 .../devicetree/bindings/sound/qcom,q6usb.yaml      |   55 +
 .../devicetree/bindings/usb/analogix,anx7411.yaml  |   13 -
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |    2 +-
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |   12 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |    1 +
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |   12 +-
 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   |   99 ++
 .../devicetree/bindings/usb/ite,it5205.yaml        |   72 ++
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |    5 +-
 .../devicetree/bindings/usb/microchip,usb5744.yaml |    2 -
 .../devicetree/bindings/usb/nxp,ptn36502.yaml      |   12 +-
 .../devicetree/bindings/usb/nxp,ptn5110.yaml       |    6 +-
 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   |   13 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    2 +-
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   |   46 +-
 .../bindings/usb/qcom,wcd939x-usbss.yaml           |   12 +-
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   55 +
 .../devicetree/bindings/usb/ti,am62-usb.yaml       |    8 +-
 .../devicetree/bindings/usb/ti,usb8020b.yaml       |   69 +
 .../devicetree/bindings/usb/usb-nop-xceiv.yaml     |   11 +-
 .../devicetree/bindings/usb/usb-switch.yaml        |   67 +
 Documentation/devicetree/bindings/usb/usb.yaml     |    2 +
 Documentation/driver-api/usb/callbacks.rst         |    6 +-
 Documentation/usb/functionfs.rst                   |   36 +
 Documentation/usb/gadget-testing.rst               |    8 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |   46 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |   46 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   19 +
 arch/powerpc/boot/dts/akebono.dts                  |    6 +-
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-core.c                             |   47 +
 drivers/phy/realtek/Kconfig                        |   32 +
 drivers/phy/realtek/Makefile                       |    3 +
 drivers/phy/realtek/phy-rtk-usb2.c                 | 1312 ++++++++++++++++++++
 drivers/phy/realtek/phy-rtk-usb3.c                 |  748 +++++++++++
 drivers/phy/tegra/xusb.c                           |   13 +
 drivers/platform/chrome/cros_ec_typec.c            |   19 +
 drivers/thunderbolt/Makefile                       |    1 +
 drivers/thunderbolt/ctl.c                          |   19 +-
 drivers/thunderbolt/ctl.h                          |    4 +-
 drivers/thunderbolt/domain.c                       |   19 +-
 drivers/thunderbolt/icm.c                          |    2 +-
 drivers/thunderbolt/lc.c                           |   45 +
 drivers/thunderbolt/nhi.c                          |   11 +-
 drivers/thunderbolt/nvm.c                          |    4 +-
 drivers/thunderbolt/path.c                         |   13 +
 drivers/thunderbolt/quirks.c                       |   14 +
 drivers/thunderbolt/retimer.c                      |    2 +-
 drivers/thunderbolt/switch.c                       |  140 ++-
 drivers/thunderbolt/tb.c                           |  904 +++++++++-----
 drivers/thunderbolt/tb.h                           |   29 +-
 drivers/thunderbolt/tb_regs.h                      |    6 +
 drivers/thunderbolt/trace.h                        |  188 +++
 drivers/thunderbolt/tunnel.c                       |   96 +-
 drivers/thunderbolt/tunnel.h                       |    6 +
 drivers/thunderbolt/usb4.c                         |   43 +-
 drivers/thunderbolt/usb4_port.c                    |    2 +-
 drivers/thunderbolt/xdomain.c                      |   16 +-
 drivers/usb/cdns3/drd.c                            |    2 +-
 drivers/usb/core/Kconfig                           |   27 +
 drivers/usb/core/driver.c                          |    8 +-
 drivers/usb/core/endpoint.c                        |    2 +-
 drivers/usb/core/hcd.c                             |   20 +-
 drivers/usb/core/hub.c                             |   29 +
 drivers/usb/core/message.c                         |    7 +-
 drivers/usb/core/of.c                              |   71 ++
 drivers/usb/core/phy.c                             |  120 ++
 drivers/usb/core/phy.h                             |    3 +
 drivers/usb/core/port.c                            |    4 +-
 drivers/usb/core/sysfs.c                           |  103 +-
 drivers/usb/core/usb-acpi.c                        |   46 +-
 drivers/usb/core/usb.c                             |    2 +-
 drivers/usb/core/usb.h                             |    8 +-
 drivers/usb/dwc3/Kconfig                           |    2 +-
 drivers/usb/dwc3/core.h                            |    2 +
 drivers/usb/dwc3/dwc3-am62.c                       |   42 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    4 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  276 +---
 drivers/usb/dwc3/ep0.c                             |    1 +
 drivers/usb/dwc3/gadget.c                          |   91 +-
 drivers/usb/dwc3/gadget.h                          |    1 +
 drivers/usb/dwc3/host.c                            |   50 +
 drivers/usb/gadget/Kconfig                         |    1 +
 drivers/usb/gadget/function/f_fs.c                 |  533 +++++++-
 drivers/usb/gadget/function/u_ether.c              |    2 +-
 drivers/usb/gadget/function/uvc_video.c            |  123 +-
 drivers/usb/gadget/udc/core.c                      |    7 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |  127 +-
 drivers/usb/gadget/udc/fsl_usb2_udc.h              |   47 -
 drivers/usb/gadget/udc/net2272.c                   |    2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |    1 -
 drivers/usb/gadget/udc/snps_udc_plat.c             |    1 -
 drivers/usb/gadget/udc/tegra-xudc.c                |   39 +-
 drivers/usb/host/ehci-orion.c                      |   18 +-
 drivers/usb/host/ohci-pxa27x.c                     |    1 -
 drivers/usb/host/sl811-hcd.c                       |    2 +
 drivers/usb/host/xhci-caps.h                       |   85 ++
 drivers/usb/host/xhci-dbgcap.c                     |   13 +-
 drivers/usb/host/xhci-dbgcap.h                     |    2 +
 drivers/usb/host/xhci-hub.c                        |   69 +-
 drivers/usb/host/xhci-mem.c                        |   95 +-
 drivers/usb/host/xhci-mtk-sch.c                    |   14 +-
 drivers/usb/host/xhci-pci.c                        |   15 +-
 drivers/usb/host/xhci-port.h                       |  176 +++
 drivers/usb/host/xhci-ring.c                       |  227 ++--
 drivers/usb/host/xhci-trace.h                      |   12 +-
 drivers/usb/host/xhci.c                            |   56 +-
 drivers/usb/host/xhci.h                            |  272 +---
 drivers/usb/image/mdc800.c                         |    1 -
 drivers/usb/isp1760/isp1760-hcd.c                  |    8 +-
 drivers/usb/misc/onboard_usb_hub.c                 |    4 +-
 drivers/usb/misc/onboard_usb_hub.h                 |    7 +
 drivers/usb/mtu3/mtu3_host.c                       |   30 +
 drivers/usb/musb/musb_gadget.c                     |    4 -
 drivers/usb/phy/phy-generic.c                      |   55 +-
 drivers/usb/phy/phy.c                              |    2 +-
 drivers/usb/roles/class.c                          |   43 +-
 drivers/usb/serial/cp210x.c                        |    4 +
 drivers/usb/serial/ftdi_sio.c                      |    4 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/keyspan.c                       |    1 -
 drivers/usb/serial/option.c                        |    6 +
 drivers/usb/serial/oti6858.c                       |    1 -
 drivers/usb/storage/freecom.c                      |    1 -
 drivers/usb/storage/sddr55.c                       |    4 +-
 drivers/usb/typec/altmodes/displayport.c           |  165 ++-
 drivers/usb/typec/bus.c                            |  102 ++
 drivers/usb/typec/class.c                          |   61 +-
 drivers/usb/typec/class.h                          |    7 +-
 drivers/usb/typec/mux.c                            |    2 +-
 drivers/usb/typec/mux/Kconfig                      |   10 +
 drivers/usb/typec/mux/Makefile                     |    1 +
 drivers/usb/typec/mux/it5205.c                     |  294 +++++
 drivers/usb/typec/pd.c                             |   30 +-
 drivers/usb/typec/retimer.c                        |    2 +-
 drivers/usb/typec/tcpm/fusb302.c                   |    2 +-
 drivers/usb/typec/tcpm/qcom/Makefile               |    3 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |  256 +---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.h      |   27 +
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |  159 ++-
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h    |   94 +-
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c   |   80 ++
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c |  290 ++++-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.h |  172 +--
 drivers/usb/typec/tcpm/tcpci.c                     |   27 +-
 drivers/usb/typec/tcpm/tcpci_maxim.h               |    1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |   38 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 1050 +++++++++++++---
 drivers/usb/typec/tcpm/wcove.c                     |    2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  294 ++++-
 drivers/usb/typec/ucsi/ucsi.h                      |  107 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   92 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |    1 +
 include/linux/phy/phy.h                            |   21 +
 include/linux/phy/tegra/xusb.h                     |    1 +
 include/linux/thunderbolt.h                        |    4 +-
 include/linux/usb/audio-v2.h                       |    4 +-
 include/linux/usb/gadget.h                         |    2 +
 include/linux/usb/of.h                             |    7 +
 include/linux/usb/pd.h                             |    1 +
 include/linux/usb/pd_vdo.h                         |   13 +-
 include/linux/usb/tcpci.h                          |   13 +
 include/linux/usb/tcpm.h                           |   18 +-
 include/linux/usb/typec.h                          |    7 +
 include/linux/usb/typec_altmode.h                  |   30 +
 include/linux/usb/typec_dp.h                       |   11 +-
 include/linux/usb/typec_tbt.h                      |    9 +-
 include/uapi/linux/usb/ch9.h                       |    2 +
 include/uapi/linux/usb/functionfs.h                |   41 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/devices/Makefile           |    4 +
 .../devices/boards/Dell Inc.,XPS 13 9300.yaml      |   40 +
 .../selftests/devices/boards/google,spherion.yaml  |   50 +
 tools/testing/selftests/devices/ksft.py            |   90 ++
 .../selftests/devices/test_discoverable_devices.py |  318 +++++
 181 files changed, 9164 insertions(+), 2455 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/usb-switch.yaml
 create mode 100644 drivers/phy/realtek/Kconfig
 create mode 100644 drivers/phy/realtek/Makefile
 create mode 100644 drivers/phy/realtek/phy-rtk-usb2.c
 create mode 100644 drivers/phy/realtek/phy-rtk-usb3.c
 create mode 100644 drivers/thunderbolt/trace.h
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h
 create mode 100644 drivers/usb/typec/mux/it5205.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.h
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion.yaml
 create mode 100644 tools/testing/selftests/devices/ksft.py
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.py


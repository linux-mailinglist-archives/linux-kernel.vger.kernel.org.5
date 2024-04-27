Return-Path: <linux-kernel+bounces-161092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CF8B46EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0B91C21070
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13B182DA;
	Sat, 27 Apr 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fw6fS6/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327451755B;
	Sat, 27 Apr 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233302; cv=none; b=QMjeEG6oHu4nG2EMsaVWvn9BZboN1WKfUyCxXH6hb7x6VRtvyyA/hQJUfe06GTlw2cnvGfcm+VMZ9KZ1c0m+guoARmT68leCB9XvGDIGoWa0+bDdr6LJo6PJh0bnBmAs1dLxg4wl76ly3pw8y75V/SZZ7irIA092E8otJgI1Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233302; c=relaxed/simple;
	bh=yIU7g+ZX1XV5MkL5OQgYGIB3rlsDRCu5whODg7+v9O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajRRbbQSG0Bpov+jRcqlVbebXAMth0iKlCP/EUR1Onzu46LzFtfwpCS45tDBA1c5JlFrFEl6uSrGqo2S2OSZuxdyY8sN++KkLsf9VhknkYpsgMxsgj/+i9DH0zrXqqyMcWBqnaGYvpQUPfR+2p6IW3C0P2YF4ekqBZ6G4cKfMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fw6fS6/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A637AC2BD10;
	Sat, 27 Apr 2024 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233302;
	bh=yIU7g+ZX1XV5MkL5OQgYGIB3rlsDRCu5whODg7+v9O4=;
	h=From:To:Cc:Subject:Date:From;
	b=fw6fS6/WnmO1vBWJAazBNallmW+xnqYWGwAYCKbcvHjbyNuaUqNLW9g0ReWdLWZca
	 qyGcjX8UJaUigKdscSzsiNZSOA/wGmNVNFj+DrYptWeb2FxEYhcYXUfGUUsN2FXdfs
	 ajHni4zmvMLekc7zFUq2q8h6RSoN4CPVb23ggzSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.88
Date: Sat, 27 Apr 2024 17:54:54 +0200
Message-ID: <2024042754-surrender-exclaim-79bb@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.88 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                 |    3 
 MAINTAINERS                                                     |    2 
 Makefile                                                        |    2 
 arch/arm/mach-omap2/board-n8x0.c                                |    5 
 arch/arm/mach-omap2/common-board-devices.h                      |    2 
 arch/arm/mach-omap2/pdata-quirks.c                              |   11 
 arch/arm64/mm/pageattr.c                                        |    3 
 arch/x86/boot/Makefile                                          |    2 
 arch/x86/boot/compressed/Makefile                               |    2 
 arch/x86/boot/compressed/misc.c                                 |    1 
 arch/x86/boot/compressed/sev.c                                  |    3 
 arch/x86/boot/compressed/vmlinux.lds.S                          |    6 
 arch/x86/boot/header.S                                          |  211 
 arch/x86/boot/setup.ld                                          |   14 
 arch/x86/boot/tools/build.c                                     |  273 
 arch/x86/include/asm/boot.h                                     |    1 
 arch/x86/include/asm/init.h                                     |    2 
 arch/x86/include/asm/kvm_host.h                                 |    1 
 arch/x86/include/asm/mem_encrypt.h                              |    8 
 arch/x86/include/asm/page_types.h                               |   12 
 arch/x86/include/asm/sev.h                                      |   10 
 arch/x86/kernel/amd_gart_64.c                                   |    2 
 arch/x86/kernel/cpu/bugs.c                                      |   11 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 arch/x86/kernel/head64.c                                        |    7 
 arch/x86/kernel/platform-quirks.c                               |    1 
 arch/x86/kernel/sev-shared.c                                    |   23 
 arch/x86/kernel/sev.c                                           |   11 
 arch/x86/kvm/cpuid.c                                            |    1 
 arch/x86/kvm/cpuid.h                                            |   10 
 arch/x86/kvm/lapic.c                                            |    3 
 arch/x86/kvm/mmu/mmu.c                                          |    2 
 arch/x86/kvm/vmx/vmx.c                                          |   24 
 arch/x86/kvm/x86.c                                              |    2 
 arch/x86/mm/mem_encrypt_boot.S                                  |    4 
 arch/x86/mm/mem_encrypt_identity.c                              |   58 
 arch/x86/mm/pat/set_memory.c                                    |    6 
 arch/x86/mm/pti.c                                               |    2 
 drivers/accessibility/speakup/main.c                            |    2 
 drivers/android/binder.c                                        |    4 
 drivers/char/random.c                                           |   10 
 drivers/clk/clk.c                                               |  201 
 drivers/clk/mediatek/clk-gate.c                                 |   23 
 drivers/clk/mediatek/clk-gate.h                                 |    7 
 drivers/clk/mediatek/clk-mt2701-aud.c                           |    4 
 drivers/clk/mediatek/clk-mt2701-eth.c                           |    4 
 drivers/clk/mediatek/clk-mt2701-g3d.c                           |    2 
 drivers/clk/mediatek/clk-mt2701-hif.c                           |    4 
 drivers/clk/mediatek/clk-mt2701-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt2701.c                               |   22 
 drivers/clk/mediatek/clk-mt2712-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt2712.c                               |   24 
 drivers/clk/mediatek/clk-mt6765.c                               |   13 
 drivers/clk/mediatek/clk-mt6779-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt6779.c                               |   21 
 drivers/clk/mediatek/clk-mt6795-infracfg.c                      |    3 
 drivers/clk/mediatek/clk-mt6795-mm.c                            |    3 
 drivers/clk/mediatek/clk-mt6795-pericfg.c                       |    6 
 drivers/clk/mediatek/clk-mt6795-topckgen.c                      |    6 
 drivers/clk/mediatek/clk-mt6797-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt6797.c                               |    7 
 drivers/clk/mediatek/clk-mt7622-aud.c                           |    4 
 drivers/clk/mediatek/clk-mt7622-eth.c                           |    8 
 drivers/clk/mediatek/clk-mt7622-hif.c                           |    8 
 drivers/clk/mediatek/clk-mt7622.c                               |   22 
 drivers/clk/mediatek/clk-mt7629-eth.c                           |    7 
 drivers/clk/mediatek/clk-mt7629-hif.c                           |    8 
 drivers/clk/mediatek/clk-mt7629.c                               |   18 
 drivers/clk/mediatek/clk-mt7986-eth.c                           |   10 
 drivers/clk/mediatek/clk-mt7986-infracfg.c                      |    7 
 drivers/clk/mediatek/clk-mt7986-topckgen.c                      |    3 
 drivers/clk/mediatek/clk-mt8135.c                               |   18 
 drivers/clk/mediatek/clk-mt8167-aud.c                           |    2 
 drivers/clk/mediatek/clk-mt8167-img.c                           |    2 
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c                        |    2 
 drivers/clk/mediatek/clk-mt8167-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt8167-vdec.c                          |    3 
 drivers/clk/mediatek/clk-mt8167.c                               |   12 
 drivers/clk/mediatek/clk-mt8173-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt8173.c                               |   34 
 drivers/clk/mediatek/clk-mt8183-audio.c                         |    4 
 drivers/clk/mediatek/clk-mt8183-mm.c                            |    4 
 drivers/clk/mediatek/clk-mt8183.c                               |   36 
 drivers/clk/mediatek/clk-mt8186-mcu.c                           |    3 
 drivers/clk/mediatek/clk-mt8186-mm.c                            |    3 
 drivers/clk/mediatek/clk-mt8186-topckgen.c                      |    9 
 drivers/clk/mediatek/clk-mt8192-aud.c                           |    3 
 drivers/clk/mediatek/clk-mt8192-mm.c                            |    3 
 drivers/clk/mediatek/clk-mt8192.c                               |   90 
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c                    |    3 
 drivers/clk/mediatek/clk-mt8195-topckgen.c                      |    9 
 drivers/clk/mediatek/clk-mt8195-vdo0.c                          |    3 
 drivers/clk/mediatek/clk-mt8195-vdo1.c                          |    3 
 drivers/clk/mediatek/clk-mt8365-mm.c                            |    5 
 drivers/clk/mediatek/clk-mt8365.c                               |   14 
 drivers/clk/mediatek/clk-mt8516-aud.c                           |    2 
 drivers/clk/mediatek/clk-mt8516.c                               |   12 
 drivers/clk/mediatek/clk-mtk.c                                  |  127 
 drivers/clk/mediatek/clk-mtk.h                                  |   13 
 drivers/clk/mediatek/clk-mux.c                                  |   14 
 drivers/clk/mediatek/clk-mux.h                                  |    3 
 drivers/comedi/drivers/vmk80xx.c                                |   35 
 drivers/firmware/efi/libstub/Makefile                           |    7 
 drivers/firmware/efi/libstub/x86-stub.c                         |   58 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   72 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                          |   78 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c               |    3 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                  |    6 
 drivers/gpu/drm/i915/i915_vma.c                                 |   42 
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                  |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |   11 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                             |   11 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                             |    4 
 drivers/hid/hid-ids.h                                           |    2 
 drivers/hid/hid-kye.c                                           |   62 
 drivers/hid/hid-quirks.c                                        |    6 
 drivers/infiniband/core/cm.c                                    |   11 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/net/dsa/mt7530.c                                        |   58 
 drivers/net/dsa/mt7530.h                                        |    6 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   27 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c               |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                        |   18 
 drivers/net/tun.c                                               |   18 
 drivers/net/usb/ax88179_178a.c                                  |    4 
 drivers/pci/bus.c                                               |   49 
 drivers/pci/pci.c                                               |   78 
 drivers/pci/pci.h                                               |    4 
 drivers/pci/pcie/aspm.c                                         |   21 
 drivers/pci/pcie/dpc.c                                          |    5 
 drivers/pci/quirks.c                                            |   68 
 drivers/pci/switch/switchtec.c                                  |  158 
 drivers/s390/cio/device.c                                       |   13 
 drivers/s390/cio/qdio_main.c                                    |   28 
 drivers/thunderbolt/quirks.c                                    |    2 
 drivers/thunderbolt/switch.c                                    |   48 
 drivers/thunderbolt/tb.c                                        |    4 
 drivers/thunderbolt/tb.h                                        |    3 
 drivers/thunderbolt/usb4.c                                      |   13 
 drivers/tty/serial/mxs-auart.c                                  |    8 
 drivers/tty/serial/pmac_zilog.c                                 |   14 
 drivers/tty/serial/stm32-usart.c                                |   13 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/hub.c                                          |   15 
 drivers/usb/core/port.c                                         |    4 
 drivers/usb/core/quirks.c                                       |    7 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                             |    4 
 drivers/usb/host/pci-quirks.c                                   |    4 
 drivers/usb/host/xhci-mem.c                                     |    2 
 drivers/usb/host/xhci-ring.c                                    |   11 
 drivers/usb/host/xhci.c                                         |   23 
 drivers/usb/host/xhci.h                                         |    9 
 drivers/usb/serial/option.c                                     |   40 
 fs/nilfs2/dir.c                                                 |    2 
 fs/smb/common/smb2pdu.h                                         |    2 
 fs/smb/server/server.c                                          |   13 
 fs/smb/server/smb2pdu.c                                         |    4 
 fs/smb/server/vfs.c                                             |    5 
 fs/sysfs/file.c                                                 |    2 
 include/linux/bootconfig.h                                      |    7 
 include/linux/pci.h                                             |    5 
 include/linux/pci_ids.h                                         |    2 
 include/linux/switchtec.h                                       |    1 
 include/linux/usb/hcd.h                                         |    5 
 include/linux/usb/quirks.h                                      |    3 
 include/net/dsa.h                                               |    8 
 include/net/netfilter/nf_flow_table.h                           |   12 
 include/trace/events/rpcgss.h                                   |    4 
 include/uapi/linux/pci_regs.h                                   |    1 
 init/main.c                                                     |    2 
 io_uring/io_uring.c                                             |   16 
 lib/bootconfig.c                                                |   19 
 mm/memory-failure.c                                             |   18 
 net/bridge/br_input.c                                           |   15 
 net/bridge/br_netfilter_hooks.c                                 |    6 
 net/bridge/br_private.h                                         |    1 
 net/bridge/netfilter/nf_conntrack_bridge.c                      |   14 
 net/dsa/dsa2.c                                                  |   24 
 net/netfilter/nf_flow_table_inet.c                              |    3 
 net/netfilter/nf_flow_table_ip.c                                |   10 
 net/netfilter/nf_tables_api.c                                   |   16 
 net/netfilter/nft_set_pipapo.c                                  |   14 
 net/unix/af_unix.c                                              |   12 
 sound/pci/hda/patch_realtek.c                                   |    1 
 sound/soc/ti/omap3pandora.c                                     |   63 
 sound/usb/Makefile                                              |    2 
 sound/usb/mixer_quirks.c                                        |    9 
 sound/usb/mixer_scarlett2.c                                     | 4391 ++++++++++
 sound/usb/mixer_scarlett2.h                                     |    7 
 sound/usb/mixer_scarlett_gen2.c                                 | 4274 ---------
 sound/usb/mixer_scarlett_gen2.h                                 |    7 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 198 files changed, 6276 insertions(+), 5630 deletions(-)

Ai Chao (1):
      ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

Alexey Izbyshev (1):
      io_uring: Fix io_cqring_wait() not restoring sigmask on get_timespec64() failure

Alvaro Karsz (1):
      PCI: Avoid FLR for SolidRun SNET DPU rev 1

AngeloGioacchino Del Regno (6):
      clk: mediatek: mt8192: Correctly unregister and free clocks on failure
      clk: mediatek: mt8192: Propagate struct device for gate clocks
      clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()
      clk: mediatek: clk-mtk: Propagate struct device for composites
      clk: mediatek: clk-mux: Propagate struct device for mtk-mux
      clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()

Ard Biesheuvel (20):
      x86/efi: Drop EFI stub .bss from .data section
      x86/efi: Disregard setup header of loaded image
      x86/efistub: Reinstate soft limit for initrd loading
      x86/efi: Drop alignment flags from PE section headers
      x86/boot: Remove the 'bugger off' message
      x86/boot: Omit compression buffer from PE/COFF image memory footprint
      x86/boot: Drop redundant code setting the root device
      x86/boot: Drop references to startup_64
      x86/boot: Grab kernel_info offset from zoffset header directly
      x86/boot: Set EFI handover offset directly in header asm
      x86/boot: Define setup size in linker script
      x86/boot: Derive file size from _edata symbol
      x86/boot: Construct PE/COFF .text section from assembler
      x86/boot: Drop PE/COFF .reloc section
      x86/boot: Split off PE/COFF .data section
      x86/boot: Increase section and file alignment to 4k/512
      x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section
      x86/sme: Move early SME kernel encryption handling into .head.text
      x86/sev: Move early startup code into .head.text section
      x86/efistub: Remap kernel text read-only before dropping NX attribute

Arnd Bergmann (1):
      x86/quirks: Include linux/pnp.h for arch_pnpbios_disabled()

Arınç ÜNAL (4):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Bjorn Helgaas (1):
      PCI/DPC: Use FIELD_GET()

Brenton Simpson (1):
      drm: panel-orientation-quirks: Add quirk for Lenovo Legion Go

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Carolina Jubran (1):
      net/mlx5e: Prevent deadlock while disabling aRFS

Christophe JAILLET (1):
      usb: pci-quirks: Reduce the length of a spinlock section in usb_amd_find_chipset_info()

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Yang (1):
      HID: kye: Sort kye devices

Dillon Varone (1):
      drm/amd/display: Do not recursively call manual trigger programming

Dmitry Baryshkov (1):
      drm/panel: visionox-rm69299: don't unregister DSI device

Dmitry Torokhov (1):
      ARM: omap2: n8x0: stop instantiating codec platform data

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Geoffrey D. Bennett (7):
      ALSA: scarlett2: Move USB IDs out from device_info struct
      ALSA: scarlett2: Add support for Clarett 8Pre USB
      ALSA: scarlett2: Default mixer driver to enabled
      ALSA: scarlett2: Add correct product series name to messages
      ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre support
      ALSA: scarlett2: Add Focusrite Clarett 2Pre and 4Pre USB support
      ALSA: scarlett2: Rename scarlett_gen2 to scarlett2

Gil Fine (2):
      thunderbolt: Avoid notify PM core about runtime PM resume
      thunderbolt: Fix wake configurations after device unplug

Greg Kroah-Hartman (2):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Linux 6.1.88

Hardik Gajjar (2):
      usb: xhci: Add timeout argument in address_device USB HCD callback
      usb: new quirk to reduce the SET_ADDRESS request timeout

Hawking Zhang (1):
      drm/amdgpu: fix incorrect active rb bitmap for gfx11

Hou Wenlong (2):
      x86/head/64: Add missing __head annotation to startup_64_load_idt()
      x86/head/64: Move the __head definition to <asm/init.h>

Ilpo Järvinen (1):
      PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()

Janusz Krzysztofik (1):
      drm/i915/vma: Fix UAF on destroy against retire race

Jason A. Donenfeld (1):
      random: handle creditable entropy from atomic process context

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Johan Hovold (1):
      PCI/ASPM: Fix deadlock when enabling ASPM

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid writing the mac address before first reading

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Kelvin Cao (2):
      PCI: switchtec: Use normal comment style
      PCI: switchtec: Add support for PCIe Gen5 devices

Konrad Dybcio (1):
      clk: Print an info line before disabling unused clocks

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
      af_unix: Don't peek OOB data without MSG_OOB.

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Linus Walleij (1):
      ASoC: ti: Convert Pandora ASoC to GPIO descriptors

Maciej W. Rozycki (1):
      PCI: Execute quirk_enable_clear_retrain_link() earlier

Marios Makassikis (1):
      ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Miaohe Lin (1):
      mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Michal Swiatkowski (1):
      ice: tc: allow zero flags in parsing tc flower

Mika Westerberg (2):
      thunderbolt: Log function name of the called quirk
      thunderbolt: Add debug log for link controller power quirk

Mike Pastore (1):
      PCI: Delay after FLR of Solidigm P44 Pro NVMe

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Namjae Jeon (3):
      ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf
      ksmbd: validate request buffer size in smb2_allocate_rsp_buf()
      ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Pablo Neira Ayuso (3):
      netfilter: br_netfilter: skip conntrack input hook for promisc packets
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple

Pasha Tatashin (1):
      x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

Peter Oberparleiter (2):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing

Pin-yen Lin (1):
      clk: mediatek: Do a runtime PM get on controllers during probe

Qiang Zhang (1):
      bootconfig: use memblock_free_late to free xbc memory to buddy

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Sandipan Das (1):
      KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson (2):
      KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible
      KVM: x86/pmu: Disable support for adaptive PEBS

Shay Drory (1):
      net/mlx5: Lag, restore buckets number to default after hash LAG deactivation

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Stephen Boyd (4):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused
      clk: Get runtime PM before walking tree for clk_summary

Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Tim Huang (1):
      drm/amdgpu: fix incorrect number of active RBs for gfx11

Uwe Kleine-König (2):
      serial: stm32: Return IRQ_NONE in the ISR if no handling happend
      serial: stm32: Reset .throttled state in .startup()

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Vishal Badole (1):
      clk: Show active consumers of clocks in debugfs

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

Yaxiong Tian (1):
      arm64: hibernate: Fix level3 translation fault in swsusp_save()

Yu Zhe (1):
      clk: remove unnecessary (void*) conversions

Yuanhe Shu (1):
      selftests/ftrace: Limit length in subsystem-enable tests

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

Zack Rusin (3):
      drm/vmwgfx: Enable DMA mappings with SEV
      drm/vmwgfx: Sort primary plane formats by order of preference
      drm/vmwgfx: Fix crtc's atomic check conditional

Ziyang Xuan (2):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
      netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more clearly



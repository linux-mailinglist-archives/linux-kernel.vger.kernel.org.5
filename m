Return-Path: <linux-kernel+bounces-94119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1C873A39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A4D1F2743C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C8135415;
	Wed,  6 Mar 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WON0dvIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D719135411;
	Wed,  6 Mar 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737552; cv=none; b=fzDnJuOaf42Qa6rc3sMWwTRH0Msrl5xbzv6555ZAD0cMgDjeIAxFH6MRkDkazX4VC+Ms/3Un+4+RV60Qod4W+4bqrWS2SA6TYgIdNbk8hR6CntpqmnwxWuaoz9q+clMNWb2A0cMfBBPDtWtk67oEeX8RfFgcvNy/3QfbY4fwFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737552; c=relaxed/simple;
	bh=NThGk24k0zMBIMctcdaT5G1sDqv+s6HlZC7pd2CZwp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hrdi6/un7LD4o69AkruFZk+l+bAiiCGtdzup2ARCfHZ5qxuqRldP2sKp5vOQXtIF0qh0tuNMU2YpuD2WRy+Xo6C2C4Uiec3UW9CoUE8PW07FxEElkGjNpcJEEcdJ+aws28OdxDv9jXoRNdwNkltLv2Q06WJBm3M6nOEGeblPTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WON0dvIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A4C433F1;
	Wed,  6 Mar 2024 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737551;
	bh=NThGk24k0zMBIMctcdaT5G1sDqv+s6HlZC7pd2CZwp0=;
	h=From:To:Cc:Subject:Date:From;
	b=WON0dvIyCKJ3dbtwE7J2O+ZUCyidhfQVWi7yuRz+qsUmF2vk4pujnZx8KtgmnUDym
	 W3RPEBBFfqqh1MNORAxLu4KYOb6FP7wj8NOCgHWp65CaLCq8aE/qzZkH/bp6yZiMLf
	 aWEUVTzphSuTOP3zG4jwZT5ykVptOjSXKUoY73j8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.81
Date: Wed,  6 Mar 2024 15:05:48 +0000
Message-ID: <2024030648-blinks-embellish-f782@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.81 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/x86/boot.rst                              |    2 
 Documentation/x86/mds.rst                               |   38 
 MAINTAINERS                                             |    7 
 Makefile                                                |    2 
 arch/arm/boot/dts/imx23.dtsi                            |    2 
 arch/arm/boot/dts/imx28.dtsi                            |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                          |    2 
 arch/arm/boot/dts/imx6sx.dtsi                           |    2 
 arch/arm/boot/dts/imx6ul.dtsi                           |    2 
 arch/arm/boot/dts/imx7s.dtsi                            |    3 
 arch/arm64/crypto/aes-neonbs-glue.c                     |   11 
 arch/arm64/include/asm/efi.h                            |    1 
 arch/powerpc/platforms/pseries/iommu.c                  |  156 ++-
 arch/riscv/include/asm/ftrace.h                         |    5 
 arch/riscv/include/asm/pgtable.h                        |    2 
 arch/riscv/kernel/Makefile                              |    2 
 arch/riscv/kernel/return_address.c                      |   48 
 arch/x86/Kconfig                                        |   17 
 arch/x86/boot/compressed/Makefile                       |   13 
 arch/x86/boot/compressed/acpi.c                         |   14 
 arch/x86/boot/compressed/cmdline.c                      |    4 
 arch/x86/boot/compressed/efi_mixed.S                    |  328 ++++++
 arch/x86/boot/compressed/efi_thunk_64.S                 |  195 ----
 arch/x86/boot/compressed/head_32.S                      |   38 
 arch/x86/boot/compressed/head_64.S                      |  593 ++----------
 arch/x86/boot/compressed/ident_map_64.c                 |    7 
 arch/x86/boot/compressed/kaslr.c                        |   26 
 arch/x86/boot/compressed/mem_encrypt.S                  |  152 ++-
 arch/x86/boot/compressed/misc.c                         |   85 +
 arch/x86/boot/compressed/misc.h                         |    3 
 arch/x86/boot/compressed/pgtable.h                      |   10 
 arch/x86/boot/compressed/pgtable_64.c                   |   94 -
 arch/x86/boot/compressed/sev.c                          |  114 +-
 arch/x86/boot/header.S                                  |    2 
 arch/x86/boot/tools/build.c                             |    2 
 arch/x86/entry/entry.S                                  |   23 
 arch/x86/entry/entry_32.S                               |    3 
 arch/x86/entry/entry_64.S                               |   11 
 arch/x86/entry/entry_64_compat.S                        |    1 
 arch/x86/include/asm/boot.h                             |   10 
 arch/x86/include/asm/cpufeatures.h                      |    2 
 arch/x86/include/asm/efi.h                              |   14 
 arch/x86/include/asm/entry-common.h                     |    1 
 arch/x86/include/asm/nospec-branch.h                    |   27 
 arch/x86/include/asm/sev.h                              |    7 
 arch/x86/kernel/cpu/bugs.c                              |   15 
 arch/x86/kernel/cpu/intel.c                             |  178 +--
 arch/x86/kernel/e820.c                                  |    8 
 arch/x86/kernel/nmi.c                                   |    3 
 arch/x86/kvm/vmx/run_flags.h                            |    7 
 arch/x86/kvm/vmx/vmenter.S                              |    9 
 arch/x86/kvm/vmx/vmx.c                                  |   12 
 drivers/bluetooth/btqca.c                               |  104 +-
 drivers/bluetooth/btqca.h                               |   23 
 drivers/bluetooth/hci_qca.c                             |  310 +++++-
 drivers/clk/tegra/clk-tegra20.c                         |   28 
 drivers/cpufreq/intel_pstate.c                          |    3 
 drivers/dma/fsl-qdma.c                                  |   21 
 drivers/dma/ptdma/ptdma-dmaengine.c                     |    2 
 drivers/firmware/efi/capsule-loader.c                   |    2 
 drivers/firmware/efi/efi.c                              |   22 
 drivers/firmware/efi/libstub/Makefile                   |    1 
 drivers/firmware/efi/libstub/alignedmem.c               |    7 
 drivers/firmware/efi/libstub/arm64-stub.c               |   11 
 drivers/firmware/efi/libstub/efi-stub-helper.c          |    2 
 drivers/firmware/efi/libstub/efistub.h                  |   32 
 drivers/firmware/efi/libstub/mem.c                      |    5 
 drivers/firmware/efi/libstub/randomalloc.c              |   17 
 drivers/firmware/efi/libstub/x86-5lvl.c                 |   95 +
 drivers/firmware/efi/libstub/x86-stub.c                 |  315 +++---
 drivers/firmware/efi/libstub/x86-stub.h                 |   17 
 drivers/firmware/efi/vars.c                             |   13 
 drivers/gpio/gpio-74x164.c                              |    4 
 drivers/gpio/gpiolib.c                                  |   10 
 drivers/gpu/drm/amd/display/dc/dml/Makefile             |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c              |   29 
 drivers/gpu/drm/drm_buddy.c                             |   10 
 drivers/gpu/drm/meson/meson_drv.c                       |   23 
 drivers/gpu/drm/meson/meson_encoder_cvbs.c              |    1 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c              |    1 
 drivers/gpu/drm/tegra/drm.c                             |   23 
 drivers/infiniband/core/cm_trace.h                      |    2 
 drivers/infiniband/core/cma.c                           |  255 ++---
 drivers/infiniband/core/cma_trace.h                     |    2 
 drivers/infiniband/core/user_mad.c                      |   23 
 drivers/input/joystick/xpad.c                           |    5 
 drivers/interconnect/core.c                             |   18 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c             |   19 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c              |   16 
 drivers/iommu/sprd-iommu.c                              |   29 
 drivers/mmc/core/mmc.c                                  |    2 
 drivers/mmc/host/mmci_stm32_sdmmc.c                     |   24 
 drivers/mmc/host/sdhci-xenon-phy.c                      |   48 
 drivers/mtd/nand/spi/gigadevice.c                       |    6 
 drivers/net/ethernet/Kconfig                            |    2 
 drivers/net/ethernet/intel/igb/igb_ptp.c                |    5 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       |    4 
 drivers/net/gtp.c                                       |   12 
 drivers/net/tun.c                                       |    1 
 drivers/net/usb/dm9601.c                                |    2 
 drivers/net/usb/lan78xx.c                               |    5 
 drivers/net/veth.c                                      |   40 
 drivers/of/overlay.c                                    |    2 
 drivers/of/property.c                                   |    2 
 drivers/pci/controller/dwc/pci-layerscape-ep.c          |  119 ++
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c          |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c              |    4 
 drivers/scsi/scsi_lib.c                                 |   52 -
 drivers/scsi/sd.c                                       |   26 
 drivers/soc/qcom/rpmhpd.c                               |    7 
 drivers/usb/gadget/composite.c                          |   18 
 drivers/usb/gadget/configfs.c                           |    3 
 drivers/usb/gadget/udc/core.c                           |   27 
 drivers/usb/gadget/udc/trace.h                          |    5 
 drivers/usb/storage/scsiglue.c                          |    7 
 drivers/usb/storage/uas.c                               |    7 
 drivers/video/fbdev/core/fbcon.c                        |    8 
 drivers/xen/events/events_base.c                        |    5 
 fs/afs/dir.c                                            |    4 
 fs/btrfs/dev-replace.c                                  |   24 
 fs/btrfs/disk-io.c                                      |   22 
 fs/btrfs/disk-io.h                                      |    2 
 fs/btrfs/ioctl.c                                        |    2 
 fs/btrfs/send.c                                         |   17 
 fs/btrfs/transaction.c                                  |    2 
 fs/efivarfs/vars.c                                      |   17 
 fs/exportfs/expfs.c                                     |    8 
 fs/lockd/svc4proc.c                                     |    1 
 fs/lockd/svclock.c                                      |   17 
 fs/lockd/svcproc.c                                      |    1 
 fs/lockd/svcsubs.c                                      |    4 
 fs/locks.c                                              |   24 
 fs/nfs/nfs4trace.h                                      |    6 
 fs/nfs/nfstrace.h                                       |    6 
 fs/nfs/write.c                                          |    4 
 fs/nfsd/Kconfig                                         |   19 
 fs/nfsd/Makefile                                        |    5 
 fs/nfsd/blocklayout.c                                   |    1 
 fs/nfsd/blocklayoutxdr.c                                |    1 
 fs/nfsd/export.h                                        |    1 
 fs/nfsd/filecache.c                                     |   39 
 fs/nfsd/flexfilelayout.c                                |    1 
 fs/nfsd/netns.h                                         |    2 
 fs/nfsd/nfs4callback.c                                  |   72 +
 fs/nfsd/nfs4idmap.c                                     |    1 
 fs/nfsd/nfs4proc.c                                      |   31 
 fs/nfsd/nfs4state.c                                     |  312 ++++--
 fs/nfsd/nfs4xdr.c                                       |  771 ++++++++--------
 fs/nfsd/nfsctl.c                                        |   13 
 fs/nfsd/nfsd.h                                          |    9 
 fs/nfsd/nfsfh.h                                         |   10 
 fs/nfsd/nfsproc.c                                       |   66 -
 fs/nfsd/nfssvc.c                                        |    8 
 fs/nfsd/state.h                                         |   11 
 fs/nfsd/trace.h                                         |  106 ++
 fs/nfsd/vfs.c                                           |   64 +
 fs/nfsd/vfs.h                                           |    1 
 fs/nfsd/xdr4.h                                          |    5 
 fs/nfsd/xdr4cb.h                                        |    6 
 fs/ntfs3/frecord.c                                      |    5 
 fs/ntfs3/fsntfs.c                                       |    1 
 fs/ntfs3/index.c                                        |   11 
 include/linux/bvec.h                                    |    2 
 include/linux/decompress/mm.h                           |    2 
 include/linux/efi.h                                     |    1 
 include/linux/fs.h                                      |   14 
 include/linux/netfilter.h                               |    4 
 include/linux/nfs4.h                                    |   13 
 include/linux/usb/composite.h                           |    2 
 include/linux/usb/gadget.h                              |    8 
 include/net/ipv6_stubs.h                                |    5 
 include/net/mctp.h                                      |    1 
 include/net/netfilter/nf_conntrack.h                    |    8 
 include/scsi/scsi_device.h                              |   52 -
 include/trace/events/fs.h                               |  122 --
 include/trace/events/nfs.h                              |  375 -------
 include/trace/events/rdma.h                             |  168 ---
 include/trace/events/rpcgss.h                           |    2 
 include/trace/events/rpcrdma.h                          |    4 
 include/trace/events/sunrpc.h                           |    2 
 include/trace/events/sunrpc_base.h                      |   18 
 include/trace/misc/fs.h                                 |  122 ++
 include/trace/misc/nfs.h                                |  387 ++++++++
 include/trace/misc/rdma.h                               |  168 +++
 include/trace/misc/sunrpc.h                             |   18 
 include/uapi/linux/bpf.h                                |   31 
 include/uapi/linux/in6.h                                |    2 
 lib/nlattr.c                                            |    4 
 mm/huge_memory.c                                        |    4 
 net/bluetooth/hci_core.c                                |    7 
 net/bluetooth/hci_event.c                               |   13 
 net/bluetooth/hci_sync.c                                |    7 
 net/bluetooth/l2cap_core.c                              |    8 
 net/bridge/br_netfilter_hooks.c                         |   96 +
 net/bridge/netfilter/nf_conntrack_bridge.c              |   30 
 net/core/filter.c                                       |   30 
 net/core/rtnetlink.c                                    |   11 
 net/hsr/hsr_forward.c                                   |    2 
 net/ipv4/ip_tunnel.c                                    |   28 
 net/ipv4/netfilter/nf_reject_ipv4.c                     |    1 
 net/ipv6/addrconf.c                                     |    7 
 net/ipv6/af_inet6.c                                     |    1 
 net/ipv6/netfilter/nf_reject_ipv6.c                     |    1 
 net/mctp/route.c                                        |   10 
 net/mptcp/diag.c                                        |    5 
 net/mptcp/pm_netlink.c                                  |   48 
 net/mptcp/pm_userspace.c                                |   12 
 net/mptcp/protocol.c                                    |   56 +
 net/mptcp/protocol.h                                    |   13 
 net/mptcp/subflow.c                                     |   15 
 net/netfilter/core.c                                    |   16 
 net/netfilter/nf_conntrack_core.c                       |   13 
 net/netfilter/nf_conntrack_proto_tcp.c                  |   35 
 net/netfilter/nf_tables_api.c                           |    7 
 net/netfilter/nft_compat.c                              |   20 
 net/netlink/af_netlink.c                                |    2 
 net/tls/tls_sw.c                                        |   11 
 net/unix/garbage.c                                      |   21 
 net/wireless/nl80211.c                                  |    2 
 security/landlock/fs.c                                  |    4 
 security/tomoyo/common.c                                |    3 
 sound/core/Makefile                                     |    1 
 sound/firewire/amdtp-stream.c                           |    2 
 sound/pci/hda/patch_realtek.c                           |    3 
 tools/include/uapi/linux/bpf.h                          |   31 
 tools/testing/selftests/net/mptcp/mptcp_join.sh         |    5 
 227 files changed, 5027 insertions(+), 3096 deletions(-)

Abdun Nihaal (1):
      fs/ntfs3: Fix NULL dereference in ni_write_inode

Alex Deucher (2):
      Revert "drm/amd/pm: resolve reboot exception for si oland"
      drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml

Alexander Lobakin (1):
      x86/boot: Robustify calling startup_{32,64}() from the decompressor code

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Alexander Stein (1):
      phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Andy Shevchenko (1):
      gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Anna Schumaker (1):
      NFSD: Simplify READ_PLUS

Ard Biesheuvel (49):
      crypto: arm64/neonbs - fix out-of-bounds access on short input
      efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
      x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
      x86/boot/compressed: Move 32-bit entrypoint code into .text section
      x86/boot/compressed: Move bootargs parsing out of 32-bit startup code
      x86/boot/compressed: Move efi32_pe_entry into .text section
      x86/boot/compressed: Move efi32_entry out of head_64.S
      x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
      x86/boot/compressed, efi: Merge multiple definitions of image_offset into one
      x86/boot/compressed: Simplify IDT/GDT preserve/restore in the EFI thunk
      x86/boot/compressed: Avoid touching ECX in startup32_set_idt_entry()
      x86/boot/compressed: Pull global variable reference into startup32_load_idt()
      x86/boot/compressed: Move startup32_load_idt() into .text section
      x86/boot/compressed: Move startup32_load_idt() out of head_64.S
      x86/boot/compressed: Move startup32_check_sev_cbit() into .text
      x86/boot/compressed: Move startup32_check_sev_cbit() out of head_64.S
      x86/boot/compressed: Adhere to calling convention in get_sev_encryption_bit()
      x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
      x86/efi: Make the deprecated EFI handover protocol optional
      x86/efistub: Branch straight to kernel entry point from C code
      x86/decompressor: Store boot_params pointer in callee save register
      x86/decompressor: Assign paging related global variables earlier
      x86/decompressor: Call trampoline as a normal function
      x86/decompressor: Use standard calling convention for trampoline
      x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
      x86/decompressor: Call trampoline directly from C code
      x86/decompressor: Only call the trampoline when changing paging levels
      x86/decompressor: Pass pgtable address to trampoline directly
      x86/decompressor: Merge trampoline cleanup with switching code
      x86/decompressor: Move global symbol references to C code
      decompress: Use 8 byte alignment
      arm64: efi: Limit allocations to 48-bit addressable physical region
      efi: efivars: prevent double registration
      x86/efistub: Simplify and clean up handover entry code
      x86/decompressor: Avoid magic offsets for EFI handover entrypoint
      x86/efistub: Clear BSS in EFI handover protocol entrypoint
      efi/libstub: Add memory attribute protocol definitions
      efi/libstub: Add limit argument to efi_random_alloc()
      x86/efistub: Perform 4/5 level paging switch from the stub
      x86/decompressor: Factor out kernel decompression and relocation
      x86/efistub: Prefer EFI memory attributes protocol over DXE services
      x86/efistub: Perform SNP feature test while running in the firmware
      x86/efistub: Avoid legacy decompressor when doing EFI boot
      efi/x86: Avoid physical KASLR on older Dell systems
      x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
      x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'
      x86/boot: efistub: Assign global boot_params variable
      efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags
      x86/efistub: Give up if memory attribute protocol returns an error

Arnd Bergmann (2):
      clk: tegra20: fix gcc-7 constant overflow warning
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Bartosz Golaszewski (1):
      gpio: fix resource unwinding order in error path

Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Bjorn Helgaas (1):
      net: restore alpha order to Ethernet devices in config

Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Chuck Lever (15):
      NFSD: Flesh out a documenting comment for filecache.c
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace stateids returned via DELEGRETURN
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a nfsd4_file_hash_remove() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Fix licensing header in filecache.c
      trace: Relocate event helper files
      NFSD: Use only RQ_DROPME to signal the need to drop a reply
      NFSD: Use set_bit(RQ_DROPME)

Chunyan Zhang (1):
      iommu/sprd: Release dma buffer to avoid memory leak

Colin Ian King (1):
      NFSD: Remove redundant assignment to variable host_err

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

Dai Ngo (6):
      NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
      NFSD: add support for sending CB_RECALL_ANY
      NFSD: add delegation reaper to react to low memory condition
      NFSD: add CB_RECALL_ANY tracepoints
      NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time
      NFSD: replace delayed_work with work_struct for nfsd_client_shrinker

David Disseldorp (1):
      exportfs: use pr_debug for unreachable debug statements

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Doug Smythies (1):
      cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Edward Lo (1):
      fs/ntfs3: Add length check in indx_get_root

Elad Nachman (2):
      mmc: sdhci-xenon: add timeout for PHY init complete
      mmc: sdhci-xenon: fix PHY init clock stability

Elson Roy Serrao (1):
      usb: gadget: Properly configure the device for remote wakeup

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Eric Dumazet (1):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Filipe Manana (2):
      btrfs: fix double free of anonymous device after snapshot creation failure
      btrfs: send: don't issue unnecessary zero writes for trailing hole

Florian Westphal (4):
      netlink: add nla be16/32 types to minlen array
      net: ip_tunnel: prevent perpetual headroom growth
      netfilter: let reset rules clean out conntrack entries
      netfilter: bridge: confirm multicast packets before passing them up the stack

Frank Li (1):
      PCI: layerscape: Add the endpoint linkup notifier support

Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV

Geert Uytterhoeven (1):
      of: overlay: Reorder struct fragment fields kerneldoc

Geliang Tang (2):
      mptcp: map v4 address to v6 when destroying subflow
      selftests: mptcp: join: add ss mptcp support check

Greg Kroah-Hartman (3):
      Revert "interconnect: Fix locking for runpm vs reclaim"
      Revert "interconnect: Teach lockdep about icc_bw_lock order"
      Linux 6.1.81

Gustavo A. R. Silva (1):
      RDMA/core: Fix multiple -Warray-bounds warnings

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Hans Peter (1):
      ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Ido Schimmel (2):
      mlxsw: spectrum_acl_tcam: Make fini symmetric to init
      mlxsw: spectrum_acl_tcam: Add missing mutex_destroy()

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Jakub Kicinski (2):
      net: veth: clear GRO when clearing XDP even when down
      veth: try harder when allocating queue memory

Jakub Raczynski (1):
      stmmac: Clear variable when destroying workqueue

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jeff Layton (11):
      nfsd: ignore requests to disable unsupported versions
      nfsd: move nfserrno() to vfs.c
      nfsd: allow disabling NFSv2 at compile time
      filelock: add a new locks_inode_context accessor function
      lockd: use locks_inode_context helper
      nfsd: use locks_inode_context helper
      nfsd: fix up the filecache laundrette scheduling
      lockd: set missing fl_flags field when retrieving args
      lockd: ensure we use the correct file descriptor when unlocking
      lockd: fix file selection in nlmsvc_cancel_blocked
      nfsd: don't destroy global nfs4_file table in per-net shutdown

Jeremy Kerr (1):
      net: mctp: take ownership of skb in mctp_local_output

Jia-Ju Bai (1):
      fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Jiri Bohac (1):
      x86/e820: Don't reserve SETUP_RNG_SEED in e820

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Johan Hovold (1):
      efi: verify that variable services are supported

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Jonas Dreßler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Justin Iurman (1):
      uapi: in6: replace temporary label with rfc9486

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Kees Cook (1):
      NFSD: Avoid clashing function prototypes

Krzysztof Kozlowski (1):
      Bluetooth: hci_qca: mark OF related data as maybe unused

Kuniyuki Iwashima (2):
      af_unix: Fix task hung while purging oob_skb in GC.
      af_unix: Drop oob_skb ref before purging queue in GC.

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Louis DeLosSantos (1):
      bpf: Add table ID to bpf_fib_lookup BPF helper

Luca Weiss (1):
      Bluetooth: btqca: Add WCN3988 support

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Lukasz Majewski (1):
      net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Marek Vasut (1):
      ARM: dts: imx7s: Drop dma-apb interrupt-names

Martin Blumenstingl (1):
      drm/meson: Don't remove bridges which are created by other drivers

Martin K. Petersen (1):
      scsi: sd: usb_storage: uas: Access media prior to querying device properties

Martynas Pumputis (1):
      bpf: Derive source IP addr via bpf_*_fib_lookup()

Matthew Auld (1):
      drm/buddy: fix range bias

Matthieu Baerts (NGI0) (1):
      mptcp: continue marking the first subflow as UNCONNECTED

Maximilian Heyne (1):
      xen/events: close evtchn after mapping cleanup

Mickaël Salaün (1):
      landlock: Fix asymmetric private inodes referring

Mike Christie (1):
      scsi: core: Add struct for args to execution functions

Min-Hua Chen (1):
      Bluetooth: btqca: use le32_to_cpu for ver.soc_id

Ming Lei (1):
      block: define bvec_iter as __packed __aligned(4)

Neil Armstrong (3):
      drm/meson: fix unbind path if HDMI fails to bind
      Bluetooth: qca: use switch case for soc type behavior
      Bluetooth: qca: add support for WCN7850

NeilBrown (1):
      NFS: Fix data corruption caused by congestion.

Oleksij Rempel (3):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
      net: lan78xx: fix "softirq work is pending" error
      igb: extend PTP timestamp adjustments to i211

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow timeout for anonymous sets

Paolo Abeni (6):
      mptcp: fix data races on local_id
      mptcp: fix data races on remote_id
      mptcp: fix duplicate subflow creation
      mptcp: push at DSS boundaries
      mptcp: fix snd_wnd initialization for passive socket
      mptcp: fix possible deadlock in subflow diag

Paolo Bonzini (1):
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Patrisious Haddad (1):
      RDMA/core: Refactor rdma_bind_addr

Pawan Gupta (6):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Sabrina Dubroca (2):
      tls: decrement decrypt_pending if no async completion will be called
      tls: fix peeking with sync+async decryption

Saravana Kannan (1):
      of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

Shiraz Saleem (1):
      RDMA/core: Update CMA destination address on rdma_resolve_addr

Steev Klimaszewski (1):
      Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855

Stefan Wahren (1):
      ARM: dts: imx: Adjust dma-apbh node name

Tadeusz Struk (1):
      dmaengine: ptdma: use consistent DMA masks

Takashi Iwai (1):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa (1):
      tomoyo: fix UAF write bug in tomoyo_write_control()

Thierry Reding (1):
      drm/tegra: Remove existing framebuffer only if we support display

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Vicki Pfau (1):
      Input: xpad - add constants for GIP interface numbers

Xiaowei Bao (1):
      PCI: layerscape: Add workaround for lost link capabilities during reset

Xiu Jianfeng (1):
      NFSD: Use struct_size() helper in alloc_session()

Yang Shi (1):
      mm: huge_memory: don't force huge page alignment on 32 bit

Ye Bin (1):
      fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Zijun Hu (2):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command

Zong Li (1):
      riscv: add CALLER_ADDRx support



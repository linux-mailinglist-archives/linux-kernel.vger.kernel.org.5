Return-Path: <linux-kernel+bounces-77979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3F860DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8141C21203
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465F25565;
	Fri, 23 Feb 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hBr6EXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F222616;
	Fri, 23 Feb 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679441; cv=none; b=AdPGdTjmwf93OrQcAE31WoReAWziWIqrWRRmvITqe0TRc3uhJYYHuFuLctuVpfd7522MX94gJ9UbNKGasaMjx8dP+Yf9MIVy7a9VUUmaJPqc3Fl74druTkdObzY35qn6Z/23XsFHTLqFYACUAaogh7ul5Hr3LHNrcZuy+PcJLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679441; c=relaxed/simple;
	bh=2WrEHiohSCfG72FDv9s6tCu6TkL4qi3USZf5ua15+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fthECKPx1PlLWSLkv+T19S7XGwQLEOAsLl02B4JMWLWPUo6UTXSwL4d8is6dQfI2bEVu6504uDbiYXp0pwZEWnQFQTagWDo0jj8Hv8Zr+6j0EveUlmyDPCyI01ZFWuICQqrpOeXCsLWUAjvo+/Yy7V7TL9fmpe2vzHZT4UtQlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hBr6EXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBCCC43394;
	Fri, 23 Feb 2024 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708679440;
	bh=2WrEHiohSCfG72FDv9s6tCu6TkL4qi3USZf5ua15+Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=1hBr6EXp4jqXy7RyxKl4uobMEFtCXon/Tsg/C+awNmo2eoK7tfLvzBh/b/W7nYbWO
	 6qzkmVHP7Ja9Vu0gT2Reo86s6A1iTm/fxe1hxAwThM9juaOBH7y3MPirQ+6YO1BO7k
	 sGOhJYMVo5YLOS55XTsR01pqOWZzNTfJcEqVFAkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.6
Date: Fri, 23 Feb 2024 10:10:32 +0100
Message-ID: <2024022333-tripod-amiss-74cb@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.6 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-statistics             |   48 
 Documentation/arch/arm64/silicon-errata.rst                      |    7 
 Documentation/netlink/specs/dpll.yaml                            |    4 
 Documentation/networking/devlink/devlink-port.rst                |    2 
 Documentation/sphinx/kernel_feat.py                              |    2 
 Makefile                                                         |    2 
 arch/Kconfig                                                     |    1 
 arch/arc/include/asm/jump_label.h                                |    4 
 arch/arm/include/asm/jump_label.h                                |    4 
 arch/arm64/include/asm/alternative-macros.h                      |    4 
 arch/arm64/include/asm/cputype.h                                 |    4 
 arch/arm64/include/asm/jump_label.h                              |    4 
 arch/arm64/kernel/cpu_errata.c                                   |    3 
 arch/arm64/kernel/fpsimd.c                                       |    2 
 arch/arm64/kernel/signal.c                                       |    4 
 arch/arm64/kvm/pkvm.c                                            |   27 
 arch/csky/include/asm/jump_label.h                               |    4 
 arch/loongarch/include/asm/jump_label.h                          |    4 
 arch/loongarch/mm/kasan_init.c                                   |    3 
 arch/mips/include/asm/checksum.h                                 |    3 
 arch/mips/include/asm/jump_label.h                               |    4 
 arch/mips/include/asm/ptrace.h                                   |    2 
 arch/mips/kernel/ptrace.c                                        |    7 
 arch/parisc/Kconfig                                              |    1 
 arch/parisc/include/asm/assembly.h                               |    1 
 arch/parisc/include/asm/extable.h                                |   64 
 arch/parisc/include/asm/jump_label.h                             |    4 
 arch/parisc/include/asm/special_insns.h                          |    6 
 arch/parisc/include/asm/uaccess.h                                |   48 
 arch/parisc/kernel/cache.c                                       |    6 
 arch/parisc/kernel/drivers.c                                     |    3 
 arch/parisc/kernel/unaligned.c                                   |   44 
 arch/parisc/mm/fault.c                                           |   11 
 arch/powerpc/include/asm/jump_label.h                            |    4 
 arch/powerpc/include/asm/reg.h                                   |    2 
 arch/powerpc/include/asm/thread_info.h                           |    2 
 arch/powerpc/include/asm/uaccess.h                               |   12 
 arch/powerpc/kernel/cpu_setup_6xx.S                              |   20 
 arch/powerpc/kernel/cpu_specs_e500mc.h                           |    3 
 arch/powerpc/kernel/interrupt_64.S                               |    4 
 arch/powerpc/kernel/iommu.c                                      |    4 
 arch/powerpc/kernel/irq_64.c                                     |    2 
 arch/powerpc/mm/kasan/init_32.c                                  |    1 
 arch/powerpc/platforms/pseries/lpar.c                            |    8 
 arch/riscv/include/asm/bitops.h                                  |    8 
 arch/riscv/include/asm/cpufeature.h                              |    4 
 arch/riscv/include/asm/jump_label.h                              |    4 
 arch/s390/include/asm/jump_label.h                               |    4 
 arch/s390/kvm/vsie.c                                             |    1 
 arch/s390/mm/gmap.c                                              |    1 
 arch/sparc/include/asm/jump_label.h                              |    4 
 arch/um/Makefile                                                 |    4 
 arch/um/include/asm/cpufeature.h                                 |    2 
 arch/x86/Kconfig.cpu                                             |    2 
 arch/x86/include/asm/barrier.h                                   |   18 
 arch/x86/include/asm/cpufeature.h                                |    2 
 arch/x86/include/asm/cpufeatures.h                               |    2 
 arch/x86/include/asm/jump_label.h                                |    6 
 arch/x86/include/asm/processor.h                                 |   18 
 arch/x86/include/asm/rmwcc.h                                     |    2 
 arch/x86/include/asm/special_insns.h                             |    2 
 arch/x86/include/asm/uaccess.h                                   |   10 
 arch/x86/kernel/cpu/amd.c                                        |    3 
 arch/x86/kernel/cpu/common.c                                     |    7 
 arch/x86/kernel/cpu/hygon.c                                      |    3 
 arch/x86/kernel/fpu/signal.c                                     |   13 
 arch/x86/kvm/svm/svm_ops.h                                       |    6 
 arch/x86/kvm/vmx/pmu_intel.c                                     |    2 
 arch/x86/kvm/vmx/vmx.c                                           |    4 
 arch/x86/kvm/vmx/vmx_ops.h                                       |    6 
 arch/x86/kvm/x86.c                                               |    3 
 arch/x86/mm/ident_map.c                                          |   23 
 arch/xtensa/include/asm/jump_label.h                             |    4 
 block/blk-mq.c                                                   |    9 
 block/blk-wbt.c                                                  |    4 
 crypto/algif_hash.c                                              |    5 
 drivers/android/binder.c                                         |   10 
 drivers/base/core.c                                              |   15 
 drivers/base/power/domain.c                                      |    2 
 drivers/connector/cn_proc.c                                      |    5 
 drivers/crypto/ccp/sev-dev.c                                     |   10 
 drivers/dpll/dpll_netlink.c                                      |   20 
 drivers/dpll/dpll_nl.c                                           |    4 
 drivers/dpll/dpll_nl.h                                           |    2 
 drivers/firewire/core-device.c                                   |    7 
 drivers/firmware/efi/libstub/Makefile                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                          |    9 
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                              |    6 
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c                          |    5 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c                             |    7 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/si_ih.c                               |    6 
 drivers/gpu/drm/amd/amdgpu/soc21.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                           |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   14 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c     |   15 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                      |    6 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c             |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c    |   29 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                  |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c |    5 
 drivers/gpu/drm/drm_buddy.c                                      |    6 
 drivers/gpu/drm/drm_prime.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                          |    3 
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h                   |    4 
 drivers/gpu/drm/msm/msm_gem_prime.c                              |    4 
 drivers/gpu/drm/msm/msm_gpu.c                                    |   11 
 drivers/gpu/drm/msm/msm_iommu.c                                  |   32 
 drivers/gpu/drm/msm/msm_ringbuffer.c                             |    7 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h                |    2 
 drivers/gpu/drm/nouveau/nouveau_fence.c                          |   24 
 drivers/gpu/drm/nouveau/nouveau_fence.h                          |    1 
 drivers/gpu/drm/nouveau/nouveau_svm.c                            |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                   |   61 
 drivers/gpu/drm/virtio/virtgpu_drv.c                             |    1 
 drivers/hid/bpf/hid_bpf_dispatch.c                               |   83 -
 drivers/hid/bpf/hid_bpf_dispatch.h                               |    4 
 drivers/hid/bpf/hid_bpf_jmp_table.c                              |   40 
 drivers/hid/i2c-hid/i2c-hid-of.c                                 |    1 
 drivers/hid/wacom_sys.c                                          |   63 
 drivers/hid/wacom_wac.c                                          |    9 
 drivers/i2c/busses/Makefile                                      |    6 
 drivers/i2c/busses/i2c-i801.c                                    |    4 
 drivers/i2c/busses/i2c-pasemi-core.c                             |    6 
 drivers/i2c/busses/i2c-qcom-geni.c                               |   14 
 drivers/iio/accel/Kconfig                                        |    2 
 drivers/iio/adc/ad4130.c                                         |   12 
 drivers/iio/imu/bno055/Kconfig                                   |    1 
 drivers/iio/industrialio-core.c                                  |    5 
 drivers/iio/light/hid-sensor-als.c                               |    1 
 drivers/iio/magnetometer/rm3100-core.c                           |   10 
 drivers/iio/pressure/bmp280-spi.c                                |    1 
 drivers/interconnect/qcom/sc8180x.c                              |    1 
 drivers/interconnect/qcom/sm8550.c                               |    1 
 drivers/irqchip/irq-brcmstb-l2.c                                 |    5 
 drivers/irqchip/irq-gic-v3-its.c                                 |   62 
 drivers/irqchip/irq-loongson-eiointc.c                           |    2 
 drivers/md/dm-core.h                                             |    2 
 drivers/md/dm-crypt.c                                            |   38 
 drivers/md/dm-ioctl.c                                            |    3 
 drivers/md/dm-table.c                                            |    9 
 drivers/md/dm-verity-target.c                                    |   26 
 drivers/md/dm-verity.h                                           |    1 
 drivers/md/md.c                                                  |    7 
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c              |    2 
 drivers/media/rc/bpf-lirc.c                                      |    6 
 drivers/media/rc/ir_toy.c                                        |    2 
 drivers/media/rc/lirc_dev.c                                      |    5 
 drivers/media/rc/rc-core-priv.h                                  |    2 
 drivers/misc/fastrpc.c                                           |    2 
 drivers/mmc/core/slot-gpio.c                                     |    6 
 drivers/mmc/host/sdhci-pci-o2micro.c                             |   30 
 drivers/net/bonding/bond_main.c                                  |    5 
 drivers/net/can/dev/netlink.c                                    |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                 |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                      |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c               |   38 
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c                   |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_lag.c             |    9 
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c            |   46 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c          |    2 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c              |    1 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c        |    6 
 drivers/net/ethernet/stmicro/stmmac/common.h                     |   56 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c                |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                 |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c                  |   15 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c               |   15 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c             |  129 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                |  136 -
 drivers/net/ethernet/ti/cpsw.c                                   |    2 
 drivers/net/ethernet/ti/cpsw_new.c                               |    3 
 drivers/net/hyperv/netvsc.c                                      |    5 
 drivers/net/hyperv/netvsc_drv.c                                  |   82 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                     |   15 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                     |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                    |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c              |    3 
 drivers/net/xen-netback/netback.c                                |   84 -
 drivers/of/property.c                                            |   65 
 drivers/of/unittest.c                                            |   12 
 drivers/pci/controller/dwc/pcie-designware-ep.c                  |    3 
 drivers/pci/pci.c                                                |   37 
 drivers/perf/cxl_pmu.c                                           |    2 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                       |   15 
 drivers/pmdomain/renesas/r8a77980-sysc.c                         |    3 
 drivers/s390/net/qeth_l3_main.c                                  |    9 
 drivers/scsi/fcoe/fcoe_ctlr.c                                    |   20 
 drivers/scsi/storvsc_drv.c                                       |   12 
 drivers/spi/spi-imx.c                                            |    9 
 drivers/spi/spi-omap2-mcspi.c                                    |  137 -
 drivers/spi/spi-ppc4xx.c                                         |    5 
 drivers/staging/iio/impedance-analyzer/ad5933.c                  |    2 
 drivers/thunderbolt/tb_regs.h                                    |    2 
 drivers/thunderbolt/usb4.c                                       |    2 
 drivers/tty/serial/max310x.c                                     |   53 
 drivers/tty/serial/mxs-auart.c                                   |    5 
 drivers/tty/serial/serial_core.c                                 |    2 
 drivers/usb/chipidea/ci.h                                        |    2 
 drivers/usb/chipidea/core.c                                      |   44 
 drivers/usb/common/ulpi.c                                        |    2 
 drivers/usb/core/hub.c                                           |   46 
 drivers/usb/dwc3/gadget.c                                        |    6 
 drivers/usb/gadget/function/f_mass_storage.c                     |   20 
 drivers/usb/typec/tcpm/tcpm.c                                    |    3 
 drivers/usb/typec/ucsi/ucsi.c                                    |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                               |   17 
 drivers/xen/events/events_base.c                                 |    8 
 fs/btrfs/block-group.c                                           |   80 
 fs/btrfs/block-group.h                                           |    7 
 fs/btrfs/delalloc-space.c                                        |   29 
 fs/btrfs/disk-io.c                                               |   13 
 fs/btrfs/inode.c                                                 |   26 
 fs/btrfs/ioctl.c                                                 |    5 
 fs/btrfs/qgroup.c                                                |   14 
 fs/btrfs/send.c                                                  |    2 
 fs/btrfs/transaction.c                                           |   38 
 fs/ceph/caps.c                                                   |    3 
 fs/ext4/mballoc.c                                                |   39 
 fs/ext4/move_extent.c                                            |    6 
 fs/hugetlbfs/inode.c                                             |   21 
 fs/namespace.c                                                   |   11 
 fs/nfsd/nfs4state.c                                              |   11 
 fs/nilfs2/file.c                                                 |    8 
 fs/nilfs2/recovery.c                                             |    7 
 fs/nilfs2/segment.c                                              |    8 
 fs/proc/array.c                                                  |   66 
 fs/smb/client/connect.c                                          |   14 
 fs/smb/client/fs_context.c                                       |   11 
 fs/smb/client/namespace.c                                        |   16 
 fs/smb/client/smb2ops.c                                          |    2 
 fs/smb/server/smb2pdu.c                                          |    8 
 fs/tracefs/event_inode.c                                         |  808 ++--------
 fs/tracefs/inode.c                                               |  102 -
 fs/tracefs/internal.h                                            |   44 
 fs/zonefs/file.c                                                 |   42 
 fs/zonefs/super.c                                                |   66 
 include/linux/backing-dev-defs.h                                 |    7 
 include/linux/compiler-gcc.h                                     |   20 
 include/linux/compiler_types.h                                   |   11 
 include/linux/gpio/driver.h                                      |   12 
 include/linux/iio/adc/ad_sigma_delta.h                           |    4 
 include/linux/iio/common/st_sensors.h                            |    4 
 include/linux/iio/imu/adis.h                                     |    3 
 include/linux/lsm_hook_defs.h                                    |    4 
 include/linux/mman.h                                             |    1 
 include/linux/netfilter/ipset/ip_set.h                           |    4 
 include/linux/ptrace.h                                           |    4 
 include/linux/serial_core.h                                      |   32 
 include/net/tls.h                                                |    5 
 include/sound/tas2781.h                                          |    1 
 init/Kconfig                                                     |    9 
 io_uring/net.c                                                   |    5 
 kernel/sched/membarrier.c                                        |    6 
 kernel/sys.c                                                     |   50 
 kernel/trace/ftrace.c                                            |   10 
 kernel/trace/ring_buffer.c                                       |    2 
 kernel/trace/trace.c                                             |   78 
 kernel/trace/trace_btf.c                                         |    4 
 kernel/trace/trace_events_synth.c                                |    3 
 kernel/trace/trace_events_trigger.c                              |    6 
 kernel/trace/trace_osnoise.c                                     |    6 
 kernel/trace/trace_probe.c                                       |   32 
 kernel/trace/trace_probe.h                                       |    3 
 kernel/workqueue.c                                               |    8 
 lib/kobject.c                                                    |   24 
 mm/backing-dev.c                                                 |    2 
 mm/damon/sysfs-schemes.c                                         |    2 
 mm/huge_memory.c                                                 |   14 
 mm/memory-failure.c                                              |    2 
 mm/memory.c                                                      |    4 
 mm/mmap.c                                                        |    6 
 mm/page-writeback.c                                              |    4 
 mm/userfaultfd.c                                                 |   15 
 net/can/j1939/j1939-priv.h                                       |    3 
 net/can/j1939/main.c                                             |    2 
 net/can/j1939/socket.c                                           |   46 
 net/handshake/handshake-test.c                                   |    5 
 net/hsr/hsr_device.c                                             |    4 
 net/mac80211/tx.c                                                |    5 
 net/mptcp/pm_userspace.c                                         |   13 
 net/mptcp/protocol.c                                             |   25 
 net/mptcp/protocol.h                                             |    7 
 net/mptcp/subflow.c                                              |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                          |   14 
 net/netfilter/ipset/ip_set_core.c                                |   39 
 net/netfilter/ipset/ip_set_hash_gen.h                            |   19 
 net/netfilter/ipset/ip_set_list_set.c                            |   13 
 net/netfilter/nft_set_pipapo_avx2.c                              |    2 
 net/nfc/nci/core.c                                               |    4 
 net/openvswitch/flow_netlink.c                                   |   49 
 net/tls/tls_sw.c                                                 |  135 -
 net/wireless/core.c                                              |    3 
 samples/bpf/asm_goto_workaround.h                                |    8 
 scripts/link-vmlinux.sh                                          |    9 
 scripts/mksysmap                                                 |   13 
 scripts/mod/modpost.c                                            |    3 
 scripts/mod/sumversion.c                                         |    7 
 security/security.c                                              |   45 
 sound/pci/hda/Kconfig                                            |    4 
 sound/pci/hda/patch_conexant.c                                   |   18 
 sound/pci/hda/patch_cs8409.c                                     |    1 
 sound/pci/hda/patch_realtek.c                                    |   20 
 sound/pci/hda/tas2781_hda_i2c.c                                  |    2 
 sound/soc/amd/yc/acp6x-mach.c                                    |   14 
 sound/soc/codecs/rt5645.c                                        |    1 
 sound/soc/codecs/tas2781-comlib.c                                |    3 
 sound/soc/codecs/tas2781-i2c.c                                   |    2 
 sound/soc/codecs/wcd938x.c                                       |    2 
 sound/soc/intel/avs/core.c                                       |    3 
 sound/soc/intel/avs/topology.c                                   |    2 
 sound/soc/sof/ipc3-topology.c                                    |   55 
 sound/soc/sof/ipc3.c                                             |    2 
 tools/arch/x86/include/asm/rmwcc.h                               |    2 
 tools/include/linux/compiler_types.h                             |    4 
 tools/testing/selftests/dt/test_unprobed_devices.sh              |   13 
 tools/testing/selftests/landlock/common.h                        |   48 
 tools/testing/selftests/landlock/fs_test.c                       |   11 
 tools/testing/selftests/landlock/net_test.c                      |   13 
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh            |    2 
 tools/testing/selftests/mm/ksm_tests.c                           |    2 
 tools/testing/selftests/mm/map_hugetlb.c                         |    7 
 tools/testing/selftests/mm/va_high_addr_switch.sh                |    6 
 tools/testing/selftests/mm/write_hugetlb_memory.sh               |    2 
 tools/testing/selftests/net/forwarding/bridge_locked_port.sh     |    4 
 tools/testing/selftests/net/forwarding/bridge_mdb.sh             |   14 
 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh      |    8 
 tools/testing/selftests/net/mptcp/config                         |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   10 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                   |   11 
 tools/testing/selftests/net/mptcp/settings                       |    2 
 tools/testing/selftests/net/mptcp/userspace_pm.sh                |   31 
 tools/testing/selftests/net/test_bridge_backup_port.sh           |  394 ++--
 tools/tracing/rtla/Makefile                                      |    7 
 tools/tracing/rtla/src/osnoise_hist.c                            |    9 
 tools/tracing/rtla/src/osnoise_top.c                             |    6 
 tools/tracing/rtla/src/timerlat_hist.c                           |    9 
 tools/tracing/rtla/src/timerlat_top.c                            |    6 
 tools/tracing/rtla/src/utils.c                                   |   14 
 tools/tracing/rtla/src/utils.h                                   |    2 
 tools/verification/rv/Makefile                                   |    7 
 tools/verification/rv/src/in_kernel.c                            |    2 
 350 files changed, 3331 insertions(+), 2533 deletions(-)

Aaron Conole (1):
      net: openvswitch: limit the number of recursions from action sets

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alex Williamson (1):
      PCI: Fix active state requirement in PME polling

Alexander Stein (1):
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix dynamic port assignment when TDM is set

Andrei Vagin (1):
      x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Arnd Bergmann (3):
      nouveau/svm: fix kvcalloc() argument order
      i2c: pasemi: split driver into two separate modules
      kallsyms: ignore ARMv4 thunks along with others

Arunpravin Paneer Selvam (1):
      drm/buddy: Fix alloc_range() error handling code

Audra Mitchell (1):
      selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag

Baokun Li (2):
      ext4: fix double-free of blocks due to wrong extents moved_len
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Benjamin Tissoires (2):
      HID: bpf: remove double fdget()
      HID: bpf: actually free hdev memory after attaching a HID-BPF program

Bibo Mao (1):
      irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Borislav Petkov (AMD) (1):
      x86/barrier: Do not serialize MSR accesses on AMD

Breno Leitao (1):
      net: sysfs: Fix /sys/class/net/<iface> path for statistics

Carlos Llamas (1):
      binder: signal epoll threads of self-work

Carlos Song (1):
      spi: imx: fix the burst length at DMA mode and CPU mode

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix pci_probe() error path

Christian A. Ehrhardt (3):
      of: unittest: Fix compile in the non-dynamic case
      usb: ucsi: Add missing ppm_lock
      usb: ucsi_acpi: Fix command completion handling

Christian Borntraeger (1):
      KVM: s390: vsie: fix race during shadow creation

Christian Brauner (1):
      fs: relax mount_setattr() permission checks

Chuck Lever (1):
      net/handshake: Fix handshake_req_destroy_test1

Cosmin Tanislav (2):
      iio: adc: ad4130: zero-initialize clock init data
      iio: adc: ad4130: only set GPIO_CTRL if pin is unused

Curtis Malainey (1):
      ASoC: SOF: IPC3: fix message bounds on ipc ops

Damien Le Moal (2):
      zonefs: Improve error handling
      block: fix partial zone append completion handling in req_bio_endio()

Dan Carpenter (4):
      wifi: iwlwifi: Fix some error codes
      wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()
      cifs: fix underflow in parse_server_interfaces()
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel Bristot de Oliveira (7):
      tracing/timerlat: Move hrtimer_init to timerlat_fd open()
      tools/rv: Fix curr_reactor uninitialized variable
      tools/rv: Fix Makefile compiler options for clang
      tools/rtla: Remove unused sched_getattr() function
      tools/rtla: Fix clang warning about mount_point var size
      tools/rtla: Fix uninitialized bucket/data->bucket_size warning
      tools/rtla: Fix Makefile compiler options for clang

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

Dave Airlie (2):
      nouveau: offload fence uevents work to workqueue
      nouveau/gsp: use correct size for registry rpc.

David Engraf (1):
      powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

David McFarland (1):
      drm/amd: Don't init MEC2 firmware when it fails to load

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

David Sterba (1):
      btrfs: send: return EOPNOTSUPP on unknown flags

Dinghao Liu (1):
      iio: core: fix memleak in iio_device_register_sysfs

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Ekansh Gupta (1):
      misc: fastrpc: Mark all sessions as invalid in cb_remove

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a crash when we run out of stations

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Erick Archer (1):
      eventfs: Use kcalloc() instead of kzalloc()

Esben Haabendal (1):
      net: stmmac: do not clear TBS enable bit on link up/down

Eugen Hristev (1):
      pmdomain: mediatek: fix race conditions with genpd

Fangzhi Zuo (2):
      drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue
      drm/amd/display: Fix MST Null Ptr for RV

Fedor Pchelkin (2):
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup
      ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Filipe Manana (6):
      btrfs: add and use helper to check if block group is used
      btrfs: do not delete unused block group if it may be used soon
      btrfs: add new unused block groups to the list of unused block groups
      btrfs: don't refill whole delayed refs block reserve when starting transaction
      btrfs: don't reserve space for checksums when writing to nocow files
      btrfs: reject encoded write if inode has nodatasum flag set

Fred Ai (1):
      mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS

Friedrich Vock (1):
      drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Gaurav Batra (1):
      powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Geliang Tang (2):
      selftests: mptcp: add mptcp_lib_kill_wait
      mptcp: check addrs list in userspace_pm_get_local_id

Gergo Koteles (1):
      ASoC: tas2781: add module parameter to tascodec_init()

Greg Kroah-Hartman (2):
      Revert "kobject: Remove redundant checks for whether ktype is NULL"
      Linux 6.7.6

Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Gui-Dong Han (1):
      serial: core: Fix atomicity violation in uart_tiocmget

Hangbin Liu (1):
      selftests/net: convert test_bridge_backup_port.sh to run it in unique namespace

Helge Deller (3):
      parisc: Prevent hung tasks when printing inventory on serial console
      parisc: Fix random data corruption from exception handler
      parisc: BTLB: Fix crash when setting up BTLB at CPU bringup

Herbert Xu (1):
      crypto: algif_hash - Remove bogus SGL free on zero-length error path

Hojin Nam (1):
      perf: CXL: fix mismatched cpmu event opcode

Horatiu Vultur (1):
      lan966x: Fix crash when adding interface under a lag

Hu Yadi (2):
      selftests/landlock: Fix net_test build with old libc
      selftests/landlock: Fix fs_test build with old libc

Huacai Chen (1):
      LoongArch: Fix earlycon parameter if KASAN enabled

Hugo Villeneuve (4):
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection
      serial: max310x: fail probe if clock crystal is unstable
      serial: max310x: prevent infinite while() loop in port startup

Hui Zhou (2):
      nfp: flower: add hardware offload check for post ct entry
      nfp: flower: fix hardware offload for the transfer layer port

Ido Schimmel (5):
      selftests: net: Fix bridge backup port test flakiness
      selftests: forwarding: Fix layer 2 miss test flakiness
      selftests: forwarding: Fix bridge MDB test flakiness
      selftests: forwarding: Suppress grep warnings
      selftests: forwarding: Fix bridge locked port test flakiness

Ivan Vecera (2):
      i40e: Do not allow untrusted VF to remove administratively set MAC
      i40e: Fix waiting for queues of all VSIs to be disabled

Jakub Kicinski (5):
      net: tls: factor out tls_*crypt_async_wait()
      tls: fix race between async notify and socket close
      tls: fix race between tx work scheduling and socket close
      net: tls: handle backlogging of crypto requests
      net: tls: fix returned read length with async decrypt

James Hershaw (1):
      nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jan Kara (1):
      blk-wbt: Fix detection of dirty-throttled tasks

Jan Kiszka (1):
      riscv/efistub: Ensure GP-relative addressing is not used

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jens Axboe (1):
      io_uring/net: fix multishot accept overflow handling

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Jiaxun Yang (2):
      ptrace: Introduce exception_ip arch hook
      mm/memory: Use exception ip to search exception tables

Jiri Pirko (2):
      dpll: fix possible deadlock during netlink dump operation
      net/mlx5: DPLL, Fix possible use after free after delayed work timer triggers

Jiri Slaby (SUSE) (2):
      serial: core: introduce uart_port_tx_flags()
      serial: mxs-auart: fix tx

Johan Hovold (1):
      HID: i2c-hid-of: fix NULL-deref on failed power up

Johannes Berg (3):
      wifi: iwlwifi: fix double-free bug
      wifi: cfg80211: fix wiphy delayed work queueing
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

John Kacur (1):
      tools/rtla: Exit with EXIT_SUCCESS when help is invoked

Josef Bacik (1):
      btrfs: don't drop extent_map for free space inode on write error

José Relvas (1):
      ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 thinkpads

Jozsef Kadlecsik (2):
      netfilter: ipset: fix performance regression in swap operation
      netfilter: ipset: Missing gc cancellations fixed

Junxiao Bi (1):
      md: bypass block throttle for superblock update

Kailang Yang (1):
      ALSA: hda/realtek - Add speaker pin verbtable for Dell dual speaker platform

Keqi Wang (1):
      connector/cn_proc: revert "connector: Fix proc_event_num_listeners count not cleared"

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Konrad Dybcio (3):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      interconnect: qcom: sm8550: Enable sync_state
      pmdomain: core: Move the unused cleanup to a _sync initcall

Krzysztof Kozlowski (3):
      ASoC: codecs: wcd938x: handle deferred probe
      gpiolib: add gpio_device_get_base() stub for !GPIOLIB
      gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB

Lee Duncan (1):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Lijo Lazar (1):
      drm/amdgpu: Avoid fetching VRAM vendor info

Linus Torvalds (9):
      work around gcc bugs with 'asm goto' with outputs
      update workarounds for gcc "asm goto" issue
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts
      sched/membarrier: reduce the ability to hammer on sys_membarrier

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Lukas Bulwahn (1):
      ALSA: hda/cs35l56: select intended config FW_CS_DSP

Magnus Karlsson (1):
      bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY

Manasi Navare (1):
      drm/i915/dsc: Fix the macro that calculates DSCC_/DSCA_ PPS reg address

Marc Zyngier (3):
      irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
      irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Mario Limonciello (3):
      Revert "drm/amd: flush any delayed gfxoff on suspend entry"
      iio: accel: bma400: Fix a compilation problem
      ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8

Mark Brown (2):
      arm64/signal: Don't assume that TIF_SVE means we saved SVE state
      usb: typec: tpcm: Fix issues with power being removed during reset

Masami Hiramatsu (Google) (5):
      tracing/trigger: Fix to return error if failed to alloc snapshot
      tracing/probes: Fix to show a parse error for bad type for $comm
      tracing/probes: Fix to set arg size and fmt after setting type from BTF
      tracing/probes: Fix to search structure fields correctly
      ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default

Matthias Schiffer (1):
      powerpc/6xx: set High BAT Enable flag on G2_LE cores

Matthieu Baerts (NGI0) (5):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min
      selftests: mptcp: allow changing subtests prefix

Maxime Jayat (1):
      can: netlink: Fix TDCO calculation using the old data bittiming

Maximilian Heyne (1):
      xen/events: close evtchn after mapping cleanup

Michael Ellerman (2):
      powerpc/kasan: Limit KASAN thread size increase to 32KB
      Revert "powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add"

Michael Kelley (1):
      scsi: storvsc: Fix ring buffer size calculation

Mickaël Salaün (1):
      selftests/landlock: Fix capability for net_test

Mikulas Patocka (2):
      dm-crypt, dm-verity: disable tasklets
      dm: limit the number of targets and parameter size area

Mingwei Zhang (1):
      KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl

Miri Korenblit (1):
      wifi: iwlwifi: clear link_id in time_event

Mohammad Rahimi (1):
      thunderbolt: Fix setting the CNS bit in ROUTER_CS_5

Muhammad Usama Anjum (1):
      selftests/mm: switch to bash from sh

Nathan Chancellor (4):
      kbuild: Fix changing ELF file type for output of gen_btf for big endian
      um: Fix adding '-no-pie' for clang
      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
      drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Naveen N Rao (1):
      powerpc/64: Set task pt_regs->link to the LR value on scv entry

NeilBrown (1):
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Nuno Sa (4):
      iio: commom: st_sensors: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      iio: imu: adis: ensure proper DMA alignment
      of: property: fix typo in io-channels

Nícolas F. R. A. Prado (1):
      kselftest: dt: Stop relying on dirname to improve performance

Oleg Nesterov (4):
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use sig->stats_lock rather than lock_task_sighand()
      fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Ondrej Mosnacek (2):
      lsm: fix default return value of the socket_getpeersec_*() hooks
      lsm: fix the logic in security_inode_getsecctx()

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Paolo Abeni (4):
      mptcp: fix data re-injection from stale subflow
      mptcp: drop the push_pending field
      mptcp: fix rcv space initialization
      mptcp: really cope with fastopen race

Parav Pandit (1):
      devlink: Fix command annotation documentation

Paulo Alcantara (1):
      smb: client: set correct id, uid and cruid for multiuser automounts

Petr Pavlu (1):
      tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef

Petr Tesarik (1):
      net: stmmac: protect updates of 64-bit statistics counters

Philip Yang (1):
      drm/prime: Support page array >= 4GB

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Prasad Pandit (1):
      KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu

Qu Wenruo (1):
      btrfs: do not ASSERT() if the newly created subvolume already got read

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Randy Dunlap (1):
      iio: imu: bno055: serdev requires REGMAP

Ranjani Sridharan (1):
      ASoC: SOF: ipc3-topology: Fix pipeline tear down logic

Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Rob Clark (3):
      drm/msm/gem: Fix double resv lock aquire
      Revert "drm/msm/gpu: Push gpu lock down past runpm"
      drm/msm: Wire up tlb ops

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Ryan Roberts (2):
      mm: thp_get_unmapped_area must honour topdown preference
      selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory

Ryusuke Konishi (3):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write

Sabrina Dubroca (1):
      net: tls: fix use-after-free with partial reads and async decrypt

Sam Protsenko (1):
      iio: pressure: bmp280: Add missing bmp085 to SPI id table

Samuel Holland (1):
      scs: add CONFIG_MMU dependency for vfree_atomic()

Saravana Kannan (5):
      driver core: Fix device_link_flag_is_sync_state_only()
      of: property: Improve finding the consumer of a remote-endpoint property
      of: property: Improve finding the supplier of a remote-endpoint property
      driver core: fw_devlink: Improve detection of overlapping cycles
      of: property: Add in-ports/out-ports support to of_graph_get_port_parent()

Sean Anderson (1):
      usb: ulpi: Fix debugfs directory leak

Sean Young (1):
      media: rc: bpf attach/detach requires write permission

Sebastian Ene (1):
      KVM: arm64: Fix circular locking dependency

Sebastian Ott (1):
      drm/virtio: Set segment size for virtio_gpu device

SeongJae Park (1):
      mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout setup

Shivaprasad G Bhat (1):
      powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Shrikanth Hegde (1):
      powerpc/pseries: fix accuracy of stolen time

Shuming Fan (1):
      ALSA: hda/realtek: add IDs for Dell dual spk platform

Sidhartha Kumar (1):
      fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs hwpoison handling

Sinthu Raja (2):
      net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio
      net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Steve French (1):
      smb: Fix regression in writes when non-standard maximum write size negotiated

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (Google) (16):
      tracing: Fix wasted memory in saved_cmdlines logic
      eventfs: Remove "lookup" parameter from create_dir/file_dentry()
      eventfs: Stop using dcache_readdir() for getdents()
      eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set
      eventfs: Do ctx->pos update for all iterations in eventfs_iterate()
      eventfs: Read ei->entries before ei->children in eventfs_iterate()
      eventfs: Shortcut eventfs_iterate() by skipping entries already read
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Do not create dentries nor inodes in iterate_shared
      eventfs: Save directory inodes in the eventfs_inode structure
      tracefs: Zero out the tracefs_inode when allocating it
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1
      tracing: Inform kmemleak of saved_cmdlines allocation

Takashi Sakamoto (1):
      firewire: core: correct documentation of fw_csr_string() kernel API

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Techno Mooney (1):
      ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Tejun Heo (1):
      Revert "workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()"

Thong (1):
      drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution

Thorsten Blum (1):
      tracing/synthetic: Fix trace_string() return value

Timur Tabi (1):
      drm/nouveau: fix several DMA buffer leaks

Tom Chung (1):
      drm/amd/display: Preserve original aspect ratio in create stream

Tomi Valkeinen (1):
      media: Revert "media: rkisp1: Drop IRQF_SHARED"

Udipto Goswami (1):
      usb: core: Prevent null pointer dereference in update_port_device_state

Uttkarsh Aggarwal (1):
      usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

Uwe Kleine-König (1):
      spi: ppc4xx: Drop write-only variable

Vaishnav Achath (1):
      spi: omap2-mcspi: Revert FIFO support without DMA

Vegard Nossum (1):
      docs: kernel_feat.py: fix build error for missing files

Viken Dadhaniya (1):
      i2c: qcom-geni: Correct I2C TRE sequence

Ville Syrjälä (1):
      drm/i915/dp: Limit SST link rate to <=8.1Gbps

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

Vitaly Rodionov (1):
      ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Wenjing Liu (1):
      drm/amd/display: fix incorrect mpc_combine array size

Xu Yang (1):
      usb: chipidea: core: handle power lost in workqueue

Yang Shi (2):
      mm: huge_memory: don't force huge page alignment on 32 bit
      mm: mmap: map MAP_STACK to VM_NOHUGEPAGE

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Zhikai Zhai (1):
      drm/amd/display: Add align done check

Zhipeng Lu (1):
      media: ir_toy: fix a memleak in irtoy_tx

Ziqi Zhao (1):
      can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bo liu (1):
      ALSA: hda/conexant: Add quirk for SWS JS201D

limingming3 (1):
      tools/rtla: Replace setting prio with nice for SCHED_OTHER

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC



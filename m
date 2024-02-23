Return-Path: <linux-kernel+bounces-77951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D60860D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1948B2858C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56531B59F;
	Fri, 23 Feb 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DoUuJVdj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B8199B9;
	Fri, 23 Feb 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678361; cv=none; b=HYi7V3JCRiNTTNv3MplqWGq5+7jyJmMzL8ejf1k3bnamrpRtozCDA1z4RofX+scexMVqLpzvAWevzR83/fJVNfl6+tajVOCxizXq1NbopYq2/QgPvBSPJ/RVYVikvfphj+oAdqJVrtSfoaV4LpsgnGDvuvQcmWXmMncqdt7TYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678361; c=relaxed/simple;
	bh=K1l/1eEOobiKEsrMAwsn89lrr0CXx1SkF0g6V/VehE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abc1cftiKUwi/ARh4U56y/oxCS9H4ELqc2p5kMLk7O+qIZOBEQg5slK80c0rsTkoiMTVC0bknVA1mnmpMWLbyaVhfOuROcHcU4DlaOc955fWaz9jl6kSkAAn/6K3lLY9uCBqgfulrtkbGsDYFL92ws5XF9gih323pJPL9+LQivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DoUuJVdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB0C433C7;
	Fri, 23 Feb 2024 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708678361;
	bh=K1l/1eEOobiKEsrMAwsn89lrr0CXx1SkF0g6V/VehE0=;
	h=From:To:Cc:Subject:Date:From;
	b=DoUuJVdj6Ud/tCM1DNA2g69ev6Bfo1M11mmW94hdcGVQnAtQbL/96B3jom55A3bco
	 +0jH8K7x7jmTnHkwBYc1lbjHZNrwaVGRiGr5ASSpW/cpMFzv81rFneyCFYB6HVDFWO
	 2AxqZnnSOEz+tkgzWC1AcrIT3ExCYAidr8y2nCD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.79
Date: Fri, 23 Feb 2024 09:52:36 +0100
Message-ID: <2024022336-tacking-quantum-a38e@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.79 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-statistics              |   48 +-
 Documentation/arm64/silicon-errata.rst                            |    7 
 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt   |    4 
 Makefile                                                          |    8 
 arch/Kconfig                                                      |    1 
 arch/arc/include/asm/jump_label.h                                 |    4 
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts                     |    2 
 arch/arm/include/asm/jump_label.h                                 |    4 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                          |    4 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                              |    4 
 arch/arm64/include/asm/alternative-macros.h                       |    4 
 arch/arm64/include/asm/cputype.h                                  |    4 
 arch/arm64/include/asm/jump_label.h                               |    4 
 arch/arm64/kernel/cpu_errata.c                                    |    3 
 arch/arm64/kernel/vdso32/Makefile                                 |    2 
 arch/csky/include/asm/jump_label.h                                |    4 
 arch/mips/include/asm/checksum.h                                  |    3 
 arch/mips/include/asm/jump_label.h                                |    4 
 arch/parisc/Kconfig                                               |    1 
 arch/parisc/include/asm/assembly.h                                |    1 
 arch/parisc/include/asm/extable.h                                 |   64 ++
 arch/parisc/include/asm/jump_label.h                              |    4 
 arch/parisc/include/asm/special_insns.h                           |    6 
 arch/parisc/include/asm/uaccess.h                                 |   48 --
 arch/parisc/kernel/drivers.c                                      |    3 
 arch/parisc/kernel/unaligned.c                                    |   44 -
 arch/parisc/mm/fault.c                                            |   11 
 arch/powerpc/include/asm/bug.h                                    |    2 
 arch/powerpc/include/asm/jump_label.h                             |    4 
 arch/powerpc/include/asm/thread_info.h                            |    2 
 arch/powerpc/include/asm/uaccess.h                                |    8 
 arch/powerpc/kernel/cpu_specs_e500mc.h                            |    3 
 arch/powerpc/kernel/interrupt_64.S                                |    4 
 arch/powerpc/kernel/irq_64.c                                      |    2 
 arch/powerpc/mm/kasan/init_32.c                                   |    1 
 arch/powerpc/platforms/pseries/lpar.c                             |    8 
 arch/riscv/include/asm/jump_label.h                               |    4 
 arch/s390/include/asm/jump_label.h                                |    4 
 arch/sparc/include/asm/jump_label.h                               |    4 
 arch/um/Makefile                                                  |    4 
 arch/um/include/asm/cpufeature.h                                  |    2 
 arch/x86/Kconfig.cpu                                              |    2 
 arch/x86/include/asm/cpufeature.h                                 |    2 
 arch/x86/include/asm/jump_label.h                                 |    6 
 arch/x86/include/asm/rmwcc.h                                      |    2 
 arch/x86/include/asm/uaccess.h                                    |   10 
 arch/x86/include/asm/virtext.h                                    |   12 
 arch/x86/kernel/fpu/signal.c                                      |   13 
 arch/x86/kvm/svm/svm_ops.h                                        |    6 
 arch/x86/kvm/vmx/pmu_intel.c                                      |    2 
 arch/x86/kvm/vmx/vmx.c                                            |    8 
 arch/x86/kvm/vmx/vmx_ops.h                                        |    6 
 arch/x86/mm/ident_map.c                                           |   23 -
 arch/xtensa/include/asm/jump_label.h                              |    4 
 block/blk-mq.c                                                    |    9 
 drivers/android/binder.c                                          |   10 
 drivers/base/core.c                                               |   15 
 drivers/base/power/domain.c                                       |    2 
 drivers/bus/moxtet.c                                              |    7 
 drivers/crypto/ccp/sev-dev.c                                      |   10 
 drivers/dma/ioat/dma.c                                            |   12 
 drivers/firewire/core-device.c                                    |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                           |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                       |    6 
 drivers/gpu/drm/drm_prime.c                                       |    2 
 drivers/gpu/drm/msm/msm_iommu.c                                   |   32 +
 drivers/gpu/drm/nouveau/nouveau_svm.c                             |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.c                              |    1 
 drivers/hid/i2c-hid/i2c-hid-of.c                                  |    1 
 drivers/hid/wacom_sys.c                                           |   63 +-
 drivers/hid/wacom_wac.c                                           |    9 
 drivers/i2c/busses/Makefile                                       |    6 
 drivers/i2c/busses/i2c-i801.c                                     |    4 
 drivers/i2c/busses/i2c-pasemi-core.c                              |    5 
 drivers/i2c/busses/i2c-qcom-geni.c                                |   14 
 drivers/iio/accel/Kconfig                                         |    2 
 drivers/iio/imu/bno055/Kconfig                                    |    1 
 drivers/iio/industrialio-core.c                                   |    5 
 drivers/iio/light/hid-sensor-als.c                                |    1 
 drivers/iio/magnetometer/rm3100-core.c                            |   10 
 drivers/infiniband/hw/irdma/verbs.c                               |    7 
 drivers/interconnect/qcom/sc8180x.c                               |    1 
 drivers/irqchip/irq-brcmstb-l2.c                                  |    5 
 drivers/irqchip/irq-gic-v3-its.c                                  |   22 
 drivers/irqchip/irq-loongson-eiointc.c                            |    2 
 drivers/md/dm-core.h                                              |    2 
 drivers/md/dm-crypt.c                                             |   37 -
 drivers/md/dm-ioctl.c                                             |    3 
 drivers/md/dm-table.c                                             |    9 
 drivers/md/dm-verity-target.c                                     |   26 -
 drivers/md/dm-verity.h                                            |    1 
 drivers/md/md.c                                                   |    7 
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c               |    2 
 drivers/media/rc/bpf-lirc.c                                       |    6 
 drivers/media/rc/ir_toy.c                                         |    2 
 drivers/media/rc/lirc_dev.c                                       |    5 
 drivers/media/rc/rc-core-priv.h                                   |    2 
 drivers/misc/fastrpc.c                                            |    2 
 drivers/mmc/core/slot-gpio.c                                      |    6 
 drivers/mmc/host/sdhci-pci-o2micro.c                              |   30 +
 drivers/net/can/dev/netlink.c                                     |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                       |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |   38 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c           |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_lag.c              |    9 
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c             |   24 -
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c           |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c         |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |    3 
 drivers/net/ethernet/ti/cpsw.c                                    |    2 
 drivers/net/ethernet/ti/cpsw_new.c                                |    3 
 drivers/net/hyperv/netvsc.c                                       |    5 
 drivers/net/hyperv/netvsc_drv.c                                   |   82 ++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                      |   15 
 drivers/net/wireless/marvell/mwifiex/Kconfig                      |    5 
 drivers/net/wireless/marvell/mwifiex/sdio.c                       |   46 +-
 drivers/net/wireless/marvell/mwifiex/sdio.h                       |    3 
 drivers/net/xen-netback/netback.c                                 |   84 +--
 drivers/of/property.c                                             |   18 
 drivers/of/unittest.c                                             |   12 
 drivers/s390/net/qeth_l3_main.c                                   |    9 
 drivers/scsi/fcoe/fcoe_ctlr.c                                     |   20 
 drivers/scsi/storvsc_drv.c                                        |   12 
 drivers/spi/spi-ppc4xx.c                                          |    5 
 drivers/staging/iio/impedance-analyzer/ad5933.c                   |    2 
 drivers/tty/serial/max310x.c                                      |   53 +-
 drivers/usb/common/ulpi.c                                         |    2 
 drivers/usb/core/hub.c                                            |   30 -
 drivers/usb/dwc3/gadget.c                                         |    6 
 drivers/usb/gadget/function/f_mass_storage.c                      |   20 
 drivers/usb/typec/ucsi/ucsi.c                                     |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                |   17 
 fs/btrfs/block-group.c                                            |   49 ++
 fs/btrfs/block-group.h                                            |    7 
 fs/btrfs/delalloc-space.c                                         |   29 -
 fs/btrfs/disk-io.c                                                |   13 
 fs/btrfs/inode.c                                                  |   26 +
 fs/btrfs/ioctl.c                                                  |    5 
 fs/btrfs/qgroup.c                                                 |   14 
 fs/btrfs/send.c                                                   |    2 
 fs/ceph/caps.c                                                    |    3 
 fs/ext4/mballoc.c                                                 |   39 -
 fs/ext4/move_extent.c                                             |    6 
 fs/hugetlbfs/inode.c                                              |   19 
 fs/namespace.c                                                    |   11 
 fs/nfsd/nfs4state.c                                               |   37 -
 fs/nilfs2/dat.c                                                   |   27 -
 fs/nilfs2/file.c                                                  |    8 
 fs/nilfs2/recovery.c                                              |    7 
 fs/nilfs2/segment.c                                               |    8 
 fs/ntfs3/fsntfs.c                                                 |   16 
 fs/ntfs3/index.c                                                  |    3 
 fs/proc/array.c                                                   |   10 
 fs/smb/client/cached_dir.c                                        |    8 
 fs/smb/client/smb2ops.c                                           |    2 
 fs/smb/client/smb2pdu.c                                           |   93 ++--
 fs/smb/client/smb2proto.h                                         |   12 
 fs/smb/server/smb2pdu.c                                           |    8 
 fs/zonefs/file.c                                                  |   42 +
 fs/zonefs/super.c                                                 |   66 +-
 include/asm-generic/vmlinux.lds.h                                 |    6 
 include/linux/bpf.h                                               |   12 
 include/linux/cleanup.h                                           |  171 +++++++
 include/linux/compiler-clang.h                                    |    9 
 include/linux/compiler-gcc.h                                      |   20 
 include/linux/compiler_attributes.h                               |    6 
 include/linux/compiler_types.h                                    |   11 
 include/linux/device.h                                            |    7 
 include/linux/file.h                                              |    6 
 include/linux/iio/adc/ad_sigma_delta.h                            |    4 
 include/linux/iio/common/st_sensors.h                             |    4 
 include/linux/iio/imu/adis.h                                      |    3 
 include/linux/init.h                                              |    3 
 include/linux/irqflags.h                                          |    7 
 include/linux/mmc/sdio_ids.h                                      |    1 
 include/linux/mutex.h                                             |    4 
 include/linux/netfilter/ipset/ip_set.h                            |    4 
 include/linux/percpu.h                                            |    4 
 include/linux/preempt.h                                           |    5 
 include/linux/rcupdate.h                                          |    3 
 include/linux/rwsem.h                                             |    8 
 include/linux/sched/task.h                                        |    2 
 include/linux/slab.h                                              |    3 
 include/linux/spinlock.h                                          |   31 +
 include/linux/srcu.h                                              |    5 
 include/net/tls.h                                                 |    5 
 init/Kconfig                                                      |    9 
 io_uring/net.c                                                    |    5 
 kernel/bpf/helpers.c                                              |   67 +-
 kernel/bpf/verifier.c                                             |    3 
 kernel/sched/membarrier.c                                         |    6 
 kernel/time/hrtimer.c                                             |   14 
 kernel/trace/bpf_trace.c                                          |   56 +-
 kernel/trace/ring_buffer.c                                        |    2 
 kernel/trace/trace.c                                              |   78 +--
 kernel/trace/trace_events_trigger.c                               |    6 
 lib/mpi/ec.c                                                      |    3 
 mm/page-writeback.c                                               |    2 
 mm/userfaultfd.c                                                  |   15 
 net/can/j1939/j1939-priv.h                                        |    3 
 net/can/j1939/main.c                                              |    2 
 net/can/j1939/socket.c                                            |   46 +-
 net/core/skbuff.c                                                 |    3 
 net/hsr/hsr_device.c                                              |    4 
 net/mac80211/tx.c                                                 |    5 
 net/mptcp/pm_userspace.c                                          |   13 
 net/mptcp/protocol.c                                              |   24 -
 net/mptcp/protocol.h                                              |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                           |   14 
 net/netfilter/ipset/ip_set_core.c                                 |   39 +
 net/netfilter/ipset/ip_set_hash_gen.h                             |   19 
 net/netfilter/ipset/ip_set_list_set.c                             |   13 
 net/netfilter/nft_set_pipapo_avx2.c                               |    2 
 net/nfc/nci/core.c                                                |    4 
 net/openvswitch/flow_netlink.c                                    |   49 +-
 net/tls/tls.h                                                     |    1 
 net/tls/tls_main.c                                                |    2 
 net/tls/tls_sw.c                                                  |  226 ++++++----
 net/wireless/core.c                                               |    1 
 net/xfrm/xfrm_input.c                                             |   77 +--
 net/xfrm/xfrm_output.c                                            |   33 -
 samples/bpf/asm_goto_workaround.h                                 |    8 
 scripts/Makefile.modpost                                          |    1 
 scripts/checkpatch.pl                                             |    2 
 scripts/link-vmlinux.sh                                           |    9 
 scripts/mod/modpost.c                                             |   43 +
 scripts/mod/sumversion.c                                          |    7 
 security/apparmor/include/lib.h                                   |    6 
 security/security.c                                               |   14 
 sound/pci/hda/patch_conexant.c                                    |   18 
 sound/pci/hda/patch_cs8409.c                                      |    1 
 sound/pci/hda/patch_realtek.c                                     |   11 
 sound/soc/amd/yc/acp6x-mach.c                                     |   14 
 sound/soc/codecs/rt5645.c                                         |    1 
 sound/soc/codecs/wcd938x.c                                        |    2 
 tools/arch/x86/include/asm/rmwcc.h                                |    2 
 tools/include/linux/compiler_types.h                              |    4 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh |   56 ++
 tools/testing/selftests/kvm/dirty_log_test.c                      |   77 +--
 tools/testing/selftests/net/mptcp/config                          |    3 
 tools/testing/selftests/net/mptcp/settings                        |    2 
 tools/testing/selftests/vm/ksm_tests.c                            |    2 
 tools/testing/selftests/vm/va_128TBswitch.sh                      |    6 
 tools/tracing/rtla/Makefile                                       |    7 
 tools/tracing/rtla/src/osnoise_hist.c                             |    9 
 tools/tracing/rtla/src/osnoise_top.c                              |    6 
 tools/tracing/rtla/src/timerlat_hist.c                            |    9 
 tools/tracing/rtla/src/timerlat_top.c                             |    6 
 tools/tracing/rtla/src/utils.c                                    |   12 
 tools/tracing/rtla/src/utils.h                                    |    2 
 254 files changed, 2393 insertions(+), 1127 deletions(-)

Aaron Conole (1):
      net: openvswitch: limit the number of recursions from action sets

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alexander Stein (1):
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Andrei Vagin (1):
      x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Andrejs Cainikovs (1):
      ARM: dts: imx6q-apalis: add can power-up delay on ixora board

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Arnd Bergmann (2):
      nouveau/svm: fix kvcalloc() argument order
      i2c: pasemi: split driver into two separate modules

Audra Mitchell (1):
      selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag

Baokun Li (2):
      ext4: fix double-free of blocks due to wrong extents moved_len
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Bibo Mao (1):
      irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Breno Leitao (1):
      net: sysfs: Fix /sys/class/net/<iface> path for statistics

Carlos Llamas (1):
      binder: signal epoll threads of self-work

Christian A. Ehrhardt (3):
      of: unittest: Fix compile in the non-dynamic case
      usb: ucsi: Add missing ppm_lock
      usb: ucsi_acpi: Fix command completion handling

Christian Brauner (1):
      fs: relax mount_setattr() permission checks

Damien Le Moal (2):
      zonefs: Improve error handling
      block: fix partial zone append completion handling in req_bio_endio()

Dan Carpenter (3):
      wifi: iwlwifi: Fix some error codes
      wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()
      cifs: fix underflow in parse_server_interfaces()

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel Bristot de Oliveira (3):
      tools/rtla: Remove unused sched_getattr() function
      tools/rtla: Fix uninitialized bucket/data->bucket_size warning
      tools/rtla: Fix Makefile compiler options for clang

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

David Engraf (1):
      powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

David Howells (1):
      tls/sw: Use splice_eof() to flush

David Lin (2):
      wifi: mwifiex: add extra delay for firmware ready
      wifi: mwifiex: fix uninitialized firmware_stat

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

David Sterba (1):
      btrfs: send: return EOPNOTSUPP on unknown flags

Davidlohr Bueso (1):
      hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

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

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Eric Dumazet (1):
      net: prevent mss overflow in skb_segment()

Esben Haabendal (1):
      net: stmmac: do not clear TBS enable bit on link up/down

Fedor Pchelkin (2):
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup
      ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Filipe Manana (4):
      btrfs: add and use helper to check if block group is used
      btrfs: do not delete unused block group if it may be used soon
      btrfs: don't reserve space for checksums when writing to nocow files
      btrfs: reject encoded write if inode has nodatasum flag set

Fred Ai (1):
      mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS

Gavin Shan (1):
      KVM: selftests: Clear dirty ring states between two modes in dirty_log_test

Geliang Tang (1):
      mptcp: check addrs list in userspace_pm_get_local_id

Greg Kroah-Hartman (1):
      Linux 6.1.79

Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Helge Deller (2):
      parisc: Prevent hung tasks when printing inventory on serial console
      parisc: Fix random data corruption from exception handler

Herbert Xu (4):
      xfrm: Remove inner/outer modes from output path
      xfrm: Remove inner/outer modes from input path
      xfrm: Use xfrm_state selector for BEET input
      xfrm: Silence warnings triggerable by bad packets

Horatiu Vultur (1):
      lan966x: Fix crash when adding interface under a lag

Hugo Villeneuve (4):
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection
      serial: max310x: fail probe if clock crystal is unstable
      serial: max310x: prevent infinite while() loop in port startup

Hui Zhou (1):
      nfp: flower: fix hardware offload for the transfer layer port

Ido Schimmel (1):
      mlxsw: spectrum_acl_tcam: Fix stack corruption

Ivan Vecera (2):
      i40e: Do not allow untrusted VF to remove administratively set MAC
      i40e: Fix waiting for queues of all VSIs to be disabled

Jakub Kicinski (3):
      net: tls: factor out tls_*crypt_async_wait()
      tls: fix race between async notify and socket close
      net: tls: fix returned read length with async decrypt

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jann Horn (1):
      tls: fix NULL deref on tls_sw_splice_eof() with empty record

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jens Axboe (1):
      io_uring/net: fix multishot accept overflow handling

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Jiri Olsa (3):
      bpf: Add struct for bin_args arg in bpf_bprintf_prepare
      bpf: Do cleanup in bpf_bprintf_cleanup only when needed
      bpf: Remove trace_printk_lock

Johan Hovold (3):
      HID: i2c-hid-of: fix NULL-deref on failed power up
      arm64: dts: qcom: sdm845: fix USB SS wakeup
      arm64: dts: qcom: sm8150: fix USB SS wakeup

Johannes Berg (2):
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

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Konrad Dybcio (2):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      pmdomain: core: Move the unused cleanup to a _sync initcall

Konstantin Komarov (1):
      fs/ntfs3: Add null pointer checks

Krzysztof Kozlowski (1):
      ASoC: codecs: wcd938x: handle deferred probe

Lee Duncan (1):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Linus Torvalds (3):
      work around gcc bugs with 'asm goto' with outputs
      update workarounds for gcc "asm goto" issue
      sched/membarrier: reduce the ability to hammer on sys_membarrier

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Lukas Wunner (1):
      wifi: mwifiex: Support SD8978 chipset

Marc Zyngier (1):
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Mario Limonciello (3):
      Revert "drm/amd: flush any delayed gfxoff on suspend entry"
      iio: accel: bma400: Fix a compilation problem
      ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8

Masahiro Yamada (2):
      modpost: propagate W=1 build option to modpost
      linux/init: remove __memexit* annotations

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min

Maxime Jayat (1):
      can: netlink: Fix TDCO calculation using the old data bittiming

Michael Ellerman (1):
      powerpc/kasan: Limit KASAN thread size increase to 32KB

Michael Kelley (1):
      scsi: storvsc: Fix ring buffer size calculation

Mike Marciniszyn (1):
      RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned

Mikulas Patocka (2):
      dm-crypt, dm-verity: disable tasklets
      dm: limit the number of targets and parameter size area

Mingwei Zhang (1):
      KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl

Nathan Chancellor (5):
      kbuild: Fix changing ELF file type for output of gen_btf for big endian
      modpost: Include '.text.*' in TEXT_SECTIONS
      um: Fix adding '-no-pie' for clang
      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
      drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Naveen N Rao (1):
      powerpc/64: Set task pt_regs->link to the LR value on scv entry

NeilBrown (2):
      nfsd: fix RELEASE_LOCKOWNER
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Nuno Sa (4):
      iio: commom: st_sensors: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      iio: imu: adis: ensure proper DMA alignment
      of: property: fix typo in io-channels

Oleg Nesterov (1):
      fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Ondrej Mosnacek (1):
      lsm: fix the logic in security_inode_getsecctx()

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Paolo Abeni (3):
      mptcp: get rid of msk->subflow
      mptcp: fix data re-injection from stale subflow
      mptcp: drop the push_pending field

Paulo Alcantara (2):
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix parsing of SMB3.1.1 POSIX create context

Peter Zijlstra (4):
      dmaengine: ioat: Free up __cleanup() name
      apparmor: Free up __cleanup() name
      locking: Introduce __cleanup() based infrastructure
      kbuild: Drop -Wdeclaration-after-statement

Philip Yang (1):
      drm/prime: Support page array >= 4GB

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Qu Wenruo (1):
      btrfs: do not ASSERT() if the newly created subvolume already got read

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Randy Dunlap (1):
      iio: imu: bno055: serdev requires REGMAP

Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Rob Clark (1):
      drm/msm: Wire up tlb ops

Ryan Roberts (1):
      selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory

Ryusuke Konishi (4):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Sabrina Dubroca (2):
      tls: extract context alloc/initialization out of tls_set_sw_offload
      net: tls: fix use-after-free with partial reads and async decrypt

Samuel Holland (1):
      scs: add CONFIG_MMU dependency for vfree_atomic()

Saravana Kannan (4):
      driver core: Fix device_link_flag_is_sync_state_only()
      of: property: Improve finding the supplier of a remote-endpoint property
      driver core: fw_devlink: Improve detection of overlapping cycles
      of: property: Add in-ports/out-ports support to of_graph_get_port_parent()

Sean Anderson (1):
      usb: ulpi: Fix debugfs directory leak

Sean Christopherson (1):
      KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test

Sean Young (1):
      media: rc: bpf attach/detach requires write permission

Sebastian Ott (1):
      drm/virtio: Set segment size for virtio_gpu device

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Shrikanth Hegde (1):
      powerpc/pseries: fix accuracy of stolen time

Sinthu Raja (2):
      net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio
      net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Sjoerd Simons (1):
      bus: moxtet: Add spi device table

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Stephan Gerhold (2):
      arm64: dts: qcom: msm8916: Enable blsp_dma by default
      arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (Google) (2):
      tracing: Fix wasted memory in saved_cmdlines logic
      tracing: Inform kmemleak of saved_cmdlines allocation

Takashi Sakamoto (1):
      firewire: core: correct documentation of fw_csr_string() kernel API

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Techno Mooney (1):
      ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Tianjia Zhang (1):
      crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Tom Chung (1):
      drm/amd/display: Preserve original aspect ratio in create stream

Tomi Valkeinen (1):
      media: Revert "media: rkisp1: Drop IRQF_SHARED"

Uttkarsh Aggarwal (1):
      usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

Uwe Kleine-König (2):
      spi: ppc4xx: Drop write-only variable
      modpost: Don't let "driver"s reference .exit.*

Viken Dadhaniya (1):
      i2c: qcom-geni: Correct I2C TRE sequence

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

Vitaly Rodionov (1):
      ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

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



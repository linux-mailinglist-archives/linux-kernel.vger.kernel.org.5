Return-Path: <linux-kernel+bounces-138830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA389FAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCE1C22DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A8171095;
	Wed, 10 Apr 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWKbE/Ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976B16F82D;
	Wed, 10 Apr 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761065; cv=none; b=gZmgE6UM9ko8oME9k84kq8rK99eOROH+zht1cWNIFuwmoxF0kIUB72LZgLiX/fiUbJB9i/brLMA8nrVQlUhIGnv6DAOBaM9ew7Pxos4knDQB2ODqe4ULvPKmlQcAtoiOm0/rb3qih0/pmmj5Ekyg/mHmwOfXWsZ/XTe8CLY57I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761065; c=relaxed/simple;
	bh=AO+iqOgvTOerh9yBspEqCrWZV9S0rNmfpGfQRV/+goQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHPJBLqCvHwjnDOEfaq3TTVu4bD/PE9VE9/XOkpkCkaLMotHadpkGETJhGL5ygHbzzpl9DHozHeGTXxKt/VHOigM86G+8llsVuJbqb92fQ0xr+uJ3Ehpc6bliqvjA5wz0XiZF7Lyo+G/9TNpH5oGr0PE8vibSiYFMpLCvxCJNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWKbE/Ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F37C43394;
	Wed, 10 Apr 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712761064;
	bh=AO+iqOgvTOerh9yBspEqCrWZV9S0rNmfpGfQRV/+goQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rWKbE/Ml0dufhK31sLMK/GcKqMn1hGK6C5b5iy182KBVBDdaP50YK1jqeMREoI1Lk
	 JOgXfdvkNTRNR2ElSEYLr0gJIEXrrgilxrs8iVmpDXVadJn6SUZg7LwHnGGXyhqyOk
	 SXFIZpjwA6vXianYQ2+zi3aOjw1qVysmfZKRu/s8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.26
Date: Wed, 10 Apr 2024 16:57:25 +0200
Message-ID: <2024041026-diameter-suction-bf6e@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.26 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                          |   48 -
 Documentation/admin-guide/kernel-parameters.txt                        |   12 
 Makefile                                                               |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                           |    2 
 arch/arm64/kernel/ptrace.c                                             |    5 
 arch/arm64/kvm/hyp/pgtable.c                                           |   11 
 arch/arm64/net/bpf_jit_comp.c                                          |    4 
 arch/powerpc/mm/book3s64/pgtable.c                                     |    2 
 arch/riscv/include/asm/uaccess.h                                       |    4 
 arch/riscv/include/uapi/asm/auxvec.h                                   |    2 
 arch/riscv/kernel/patch.c                                              |    8 
 arch/riscv/kernel/process.c                                            |    3 
 arch/riscv/kvm/aia_aplic.c                                             |   37 
 arch/s390/boot/vmem.c                                                  |    2 
 arch/s390/include/asm/pgtable.h                                        |    4 
 arch/s390/kernel/entry.S                                               |    1 
 arch/s390/mm/gmap.c                                                    |    2 
 arch/s390/mm/hugetlbpage.c                                             |    4 
 arch/s390/mm/pageattr.c                                                |    2 
 arch/s390/mm/pgtable.c                                                 |    2 
 arch/s390/mm/vmem.c                                                    |    6 
 arch/s390/net/bpf_jit_comp.c                                           |   46 -
 arch/sparc/mm/init_64.c                                                |    2 
 arch/x86/Kconfig                                                       |   25 
 arch/x86/boot/compressed/Makefile                                      |    2 
 arch/x86/boot/compressed/misc.c                                        |   16 
 arch/x86/boot/compressed/sev.c                                         |    3 
 arch/x86/coco/core.c                                                   |   41 
 arch/x86/entry/common.c                                                |   10 
 arch/x86/entry/entry_64.S                                              |   61 +
 arch/x86/entry/entry_64_compat.S                                       |   16 
 arch/x86/entry/syscall_32.c                                            |   21 
 arch/x86/entry/syscall_64.c                                            |   19 
 arch/x86/entry/syscall_x32.c                                           |   10 
 arch/x86/events/amd/core.c                                             |   24 
 arch/x86/events/amd/lbr.c                                              |   16 
 arch/x86/events/intel/ds.c                                             |    8 
 arch/x86/include/asm/asm-prototypes.h                                  |    1 
 arch/x86/include/asm/boot.h                                            |    1 
 arch/x86/include/asm/coco.h                                            |    2 
 arch/x86/include/asm/cpufeature.h                                      |    8 
 arch/x86/include/asm/cpufeatures.h                                     |   21 
 arch/x86/include/asm/disabled-features.h                               |    3 
 arch/x86/include/asm/init.h                                            |    2 
 arch/x86/include/asm/mem_encrypt.h                                     |    8 
 arch/x86/include/asm/msr-index.h                                       |    9 
 arch/x86/include/asm/nospec-branch.h                                   |   88 +-
 arch/x86/include/asm/required-features.h                               |    3 
 arch/x86/include/asm/sev.h                                             |   10 
 arch/x86/include/asm/syscall.h                                         |   11 
 arch/x86/include/uapi/asm/bootparam.h                                  |    1 
 arch/x86/kernel/cpu/amd.c                                              |  129 ++-
 arch/x86/kernel/cpu/bugs.c                                             |  126 ++
 arch/x86/kernel/cpu/common.c                                           |   24 
 arch/x86/kernel/cpu/mce/core.c                                         |    4 
 arch/x86/kernel/cpu/scattered.c                                        |    2 
 arch/x86/kernel/head64.c                                               |    3 
 arch/x86/kernel/mpparse.c                                              |   10 
 arch/x86/kernel/setup.c                                                |    2 
 arch/x86/kernel/sev-shared.c                                           |   23 
 arch/x86/kernel/sev.c                                                  |   14 
 arch/x86/kernel/vmlinux.lds.S                                          |    7 
 arch/x86/kvm/mmu/mmu.c                                                 |    2 
 arch/x86/kvm/reverse_cpuid.h                                           |    5 
 arch/x86/kvm/svm/sev.c                                                 |   45 -
 arch/x86/kvm/trace.h                                                   |   10 
 arch/x86/kvm/vmx/vmenter.S                                             |    2 
 arch/x86/kvm/x86.c                                                     |    2 
 arch/x86/lib/Makefile                                                  |   13 
 arch/x86/lib/retpoline.S                                               |  165 ++-
 arch/x86/mm/fault.c                                                    |    4 
 arch/x86/mm/ident_map.c                                                |   23 
 arch/x86/mm/init_64.c                                                  |    4 
 arch/x86/mm/kasan_init_64.c                                            |    2 
 arch/x86/mm/mem_encrypt_identity.c                                     |   76 -
 arch/x86/mm/pat/memtype.c                                              |   49 -
 arch/x86/mm/pat/set_memory.c                                           |    6 
 arch/x86/mm/pgtable.c                                                  |    2 
 arch/x86/mm/pti.c                                                      |    2 
 arch/x86/net/bpf_jit_comp.c                                            |    2 
 arch/x86/power/hibernate.c                                             |    2 
 arch/x86/xen/mmu_pv.c                                                  |    4 
 drivers/acpi/acpica/dbnames.c                                          |    8 
 drivers/ata/sata_mv.c                                                  |   63 -
 drivers/ata/sata_sx4.c                                                 |    6 
 drivers/base/core.c                                                    |   26 
 drivers/base/regmap/regcache-maple.c                                   |    6 
 drivers/bluetooth/btqca.c                                              |    8 
 drivers/bluetooth/hci_qca.c                                            |   19 
 drivers/dma-buf/st-dma-fence-chain.c                                   |    6 
 drivers/firmware/efi/libstub/efi-stub-helper.c                         |    8 
 drivers/firmware/efi/libstub/efistub.h                                 |    2 
 drivers/firmware/efi/libstub/x86-stub.c                                |   14 
 drivers/gpio/gpiolib-cdev.c                                            |   58 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |   43 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                |   10 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c            |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                     |   11 
 drivers/gpu/drm/amd/include/amd_shared.h                               |    1 
 drivers/gpu/drm/drm_prime.c                                            |    7 
 drivers/gpu/drm/i915/Makefile                                          |    1 
 drivers/gpu/drm/i915/display/intel_cursor.c                            |    6 
 drivers/gpu/drm/i915/display/intel_display_types.h                     |    1 
 drivers/gpu/drm/i915/display/intel_fb_pin.c                            |   10 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                     |    5 
 drivers/gpu/drm/i915/gem/i915_gem_create.c                             |    4 
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c                               |   10 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                              |   21 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                              |    2 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c                   |    4 
 drivers/gpu/drm/i915/gt/intel_gt.h                                     |   31 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c                            |   39 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h                            |   13 
 drivers/gpu/drm/i915/gt/intel_gt_mcr.c                                 |    7 
 drivers/gpu/drm/i915/gt/intel_gt_regs.h                                |    6 
 drivers/gpu/drm/i915/gt/intel_lrc.c                                    |   38 
 drivers/gpu/drm/i915/gt/intel_mocs.c                                   |   23 
 drivers/gpu/drm/i915/gt/intel_rc6.c                                    |    6 
 drivers/gpu/drm/i915/gt/intel_reset.c                                  |   20 
 drivers/gpu/drm/i915/gt/intel_reset.h                                  |    2 
 drivers/gpu/drm/i915/gt/intel_rps.c                                    |    2 
 drivers/gpu/drm/i915/gt/intel_workarounds.c                            |  422 +++-------
 drivers/gpu/drm/i915/gt/uc/intel_guc.c                                 |   26 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                      |    6 
 drivers/gpu/drm/i915/i915_debugfs.c                                    |    2 
 drivers/gpu/drm/i915/i915_drv.h                                        |    4 
 drivers/gpu/drm/i915/i915_perf.c                                       |   11 
 drivers/gpu/drm/i915/intel_clock_gating.c                              |    8 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                 |    6 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                                |    6 
 drivers/md/dm-integrity.c                                              |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                       |    6 
 drivers/net/dsa/sja1105/sja1105_mdio.c                                 |    2 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                       |   28 
 drivers/net/ethernet/freescale/fec_main.c                              |   11 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                     |   19 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                |    4 
 drivers/net/ethernet/intel/e1000/e1000_hw.c                            |   46 -
 drivers/net/ethernet/intel/e1000e/80003es2lan.c                        |    3 
 drivers/net/ethernet/intel/e1000e/82571.c                              |    3 
 drivers/net/ethernet/intel/e1000e/ethtool.c                            |    7 
 drivers/net/ethernet/intel/e1000e/hw.h                                 |    2 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                            |   56 -
 drivers/net/ethernet/intel/e1000e/mac.c                                |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                             |   35 
 drivers/net/ethernet/intel/e1000e/phy.c                                |  191 ++--
 drivers/net/ethernet/intel/e1000e/phy.h                                |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                            |    4 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                            |   10 
 drivers/net/ethernet/intel/i40e/i40e.h                                 |   59 -
 drivers/net/ethernet/intel/i40e/i40e_adminq.c                          |    8 
 drivers/net/ethernet/intel/i40e/i40e_adminq.h                          |    3 
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h                      |    2 
 drivers/net/ethernet/intel/i40e/i40e_alloc.h                           |   24 
 drivers/net/ethernet/intel/i40e/i40e_client.c                          |    1 
 drivers/net/ethernet/intel/i40e/i40e_common.c                          |   12 
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                             |    4 
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c                          |    2 
 drivers/net/ethernet/intel/i40e/i40e_ddp.c                             |    2 
 drivers/net/ethernet/intel/i40e/i40e_debug.h                           |   47 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                         |    3 
 drivers/net/ethernet/intel/i40e/i40e_diag.h                            |    5 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                         |    3 
 drivers/net/ethernet/intel/i40e/i40e_hmc.c                             |   16 
 drivers/net/ethernet/intel/i40e/i40e_hmc.h                             |    4 
 drivers/net/ethernet/intel/i40e/i40e_io.h                              |   16 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c                         |    9 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h                         |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |   70 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                             |    3 
 drivers/net/ethernet/intel/i40e/i40e_osdep.h                           |   59 -
 drivers/net/ethernet/intel/i40e/i40e_prototype.h                       |    4 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                             |    9 
 drivers/net/ethernet/intel/i40e/i40e_register.h                        |    5 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                            |   89 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                            |    6 
 drivers/net/ethernet/intel/i40e/i40e_txrx_common.h                     |    2 
 drivers/net/ethernet/intel/i40e/i40e_type.h                            |   56 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                     |   47 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                     |    4 
 drivers/net/ethernet/intel/i40e/i40e_xsk.c                             |    4 
 drivers/net/ethernet/intel/i40e/i40e_xsk.h                             |    4 
 drivers/net/ethernet/intel/iavf/iavf_common.c                          |    3 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                         |    5 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                            |    1 
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                            |    1 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                        |    3 
 drivers/net/ethernet/intel/ice/ice_lag.c                               |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                               |   74 +
 drivers/net/ethernet/intel/ice/ice_switch.c                            |   24 
 drivers/net/ethernet/intel/ice/ice_switch.h                            |    4 
 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c                   |   18 
 drivers/net/ethernet/intel/igb/e1000_82575.c                           |   29 
 drivers/net/ethernet/intel/igb/e1000_i210.c                            |   19 
 drivers/net/ethernet/intel/igb/e1000_mac.c                             |    2 
 drivers/net/ethernet/intel/igb/e1000_nvm.c                             |   18 
 drivers/net/ethernet/intel/igb/e1000_phy.c                             |   13 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                           |    8 
 drivers/net/ethernet/intel/igb/igb_main.c                              |    4 
 drivers/net/ethernet/intel/igbvf/mbx.c                                 |    1 
 drivers/net/ethernet/intel/igbvf/netdev.c                              |   33 
 drivers/net/ethernet/intel/igc/igc_i225.c                              |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                              |    4 
 drivers/net/ethernet/intel/igc/igc_phy.c                               |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                        |   30 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                         |   16 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                          |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                           |    8 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                         |    8 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                          |    8 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                          |   19 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                        |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                    |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                    |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                   |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c             |   31 
 drivers/net/ethernet/microchip/lan743x_main.c                          |   18 
 drivers/net/ethernet/microchip/lan743x_main.h                          |    4 
 drivers/net/ethernet/microsoft/mana/mana_en.c                          |    2 
 drivers/net/ethernet/realtek/r8169_main.c                              |   40 
 drivers/net/ethernet/renesas/ravb_main.c                               |   33 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                      |   40 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                    |   38 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                         |    8 
 drivers/net/phy/micrel.c                                               |   31 
 drivers/net/usb/ax88179_178a.c                                         |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                         |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                      |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c                           |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                          |   31 
 drivers/net/wwan/t7xx/t7xx_cldma.c                                     |    4 
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c                                 |    9 
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c                                  |    8 
 drivers/net/xen-netfront.c                                             |    1 
 drivers/of/dynamic.c                                                   |   12 
 drivers/of/module.c                                                    |    8 
 drivers/perf/riscv_pmu.c                                               |    4 
 drivers/s390/net/qeth_core_main.c                                      |   38 
 drivers/scsi/myrb.c                                                    |   20 
 drivers/scsi/myrs.c                                                    |   24 
 drivers/scsi/sd.c                                                      |    2 
 drivers/spi/spi-pci1xxxx.c                                             |    2 
 drivers/spi/spi-s3c64xx.c                                              |   80 +
 drivers/usb/typec/ucsi/ucsi_glink.c                                    |   14 
 fs/btrfs/extent_io.c                                                   |  208 +++-
 fs/btrfs/inode.c                                                       |   22 
 fs/nfsd/nfs4state.c                                                    |    7 
 fs/pipe.c                                                              |   17 
 fs/smb/client/cached_dir.c                                             |    6 
 fs/smb/client/cifs_debug.c                                             |    6 
 fs/smb/client/cifsfs.c                                                 |   11 
 fs/smb/client/cifsglob.h                                               |   17 
 fs/smb/client/connect.c                                                |   45 +
 fs/smb/client/dir.c                                                    |   15 
 fs/smb/client/file.c                                                   |  111 ++
 fs/smb/client/fs_context.c                                             |    6 
 fs/smb/client/fs_context.h                                             |   12 
 fs/smb/client/fscache.c                                                |   16 
 fs/smb/client/fscache.h                                                |    6 
 fs/smb/client/inode.c                                                  |    2 
 fs/smb/client/ioctl.c                                                  |    6 
 fs/smb/client/misc.c                                                   |    2 
 fs/smb/client/smb1ops.c                                                |    4 
 fs/smb/client/smb2misc.c                                               |    4 
 fs/smb/client/smb2ops.c                                                |   11 
 fs/smb/client/smb2pdu.c                                                |    2 
 fs/smb/server/ksmbd_netlink.h                                          |    3 
 fs/smb/server/mgmt/share_config.c                                      |    7 
 fs/smb/server/smb2ops.c                                                |   10 
 fs/smb/server/smb2pdu.c                                                |    3 
 fs/smb/server/transport_ipc.c                                          |   37 
 fs/vboxsf/super.c                                                      |    3 
 include/kvm/arm_pmu.h                                                  |    2 
 include/linux/avf/virtchnl.h                                           |    5 
 include/linux/bpf.h                                                    |   16 
 include/linux/device.h                                                 |    1 
 include/linux/io_uring_types.h                                         |    1 
 include/linux/secretmem.h                                              |    4 
 include/linux/skbuff.h                                                 |    7 
 include/linux/udp.h                                                    |   28 
 include/net/bluetooth/hci.h                                            |    9 
 include/net/inet_connection_sock.h                                     |    1 
 include/net/mana/mana.h                                                |    1 
 include/net/sock.h                                                     |    7 
 io_uring/io_uring.c                                                    |   18 
 io_uring/kbuf.c                                                        |  118 --
 io_uring/kbuf.h                                                        |    8 
 kernel/bpf/syscall.c                                                   |   35 
 kernel/bpf/verifier.c                                                  |    5 
 kernel/trace/bpf_trace.c                                               |   10 
 mm/memory.c                                                            |    4 
 net/9p/client.c                                                        |   10 
 net/ax25/ax25_dev.c                                                    |    2 
 net/bluetooth/hci_debugfs.c                                            |   48 -
 net/bluetooth/hci_event.c                                              |   25 
 net/bluetooth/hci_sync.c                                               |    5 
 net/bridge/netfilter/ebtables.c                                        |    6 
 net/core/gro.c                                                         |    3 
 net/core/sock_map.c                                                    |    6 
 net/hsr/hsr_slave.c                                                    |    3 
 net/ipv4/inet_connection_sock.c                                        |   33 
 net/ipv4/inet_fragment.c                                               |   70 +
 net/ipv4/ip_fragment.c                                                 |    2 
 net/ipv4/ip_gre.c                                                      |    5 
 net/ipv4/netfilter/arp_tables.c                                        |    4 
 net/ipv4/netfilter/ip_tables.c                                         |    4 
 net/ipv4/tcp.c                                                         |    2 
 net/ipv4/udp.c                                                         |    7 
 net/ipv4/udp_offload.c                                                 |   23 
 net/ipv6/ip6_fib.c                                                     |   14 
 net/ipv6/ip6_gre.c                                                     |    3 
 net/ipv6/netfilter/ip6_tables.c                                        |    4 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                |    2 
 net/ipv6/udp.c                                                         |    2 
 net/ipv6/udp_offload.c                                                 |    8 
 net/mptcp/protocol.c                                                   |  106 --
 net/mptcp/subflow.c                                                    |    2 
 net/netfilter/nf_tables_api.c                                          |   92 +-
 net/nfc/nci/core.c                                                     |    5 
 net/rds/rdma.c                                                         |    2 
 net/sched/act_skbmod.c                                                 |   10 
 net/sched/sch_api.c                                                    |    2 
 net/sunrpc/svcsock.c                                                   |   10 
 net/tls/tls_sw.c                                                       |    7 
 net/vmw_vsock/virtio_transport.c                                       |    3 
 scripts/bpf_doc.py                                                     |    4 
 scripts/mod/Makefile                                                   |    4 
 scripts/mod/modpost.c                                                  |   73 -
 scripts/mod/modpost.h                                                  |   25 
 scripts/mod/symsearch.c                                                |  199 ++++
 security/selinux/selinuxfs.c                                           |   12 
 sound/pci/emu10k1/emu10k1_callback.c                                   |    7 
 sound/pci/hda/cs35l56_hda.c                                            |    4 
 sound/pci/hda/cs35l56_hda_i2c.c                                        |   13 
 sound/pci/hda/cs35l56_hda_spi.c                                        |   13 
 sound/pci/hda/patch_realtek.c                                          |    3 
 sound/soc/amd/acp/acp-pci.c                                            |    5 
 sound/soc/codecs/rt5682-sdw.c                                          |    4 
 sound/soc/codecs/rt711-sdca-sdw.c                                      |    4 
 sound/soc/codecs/rt711-sdw.c                                           |    4 
 sound/soc/codecs/rt712-sdca-sdw.c                                      |    5 
 sound/soc/codecs/rt722-sdca-sdw.c                                      |    4 
 sound/soc/codecs/wm_adsp.c                                             |    3 
 sound/soc/soc-ops.c                                                    |    2 
 sound/soc/sof/amd/acp.c                                                |    8 
 tools/arch/x86/include/asm/cpufeatures.h                               |    2 
 tools/net/ynl/ynl-gen-c.py                                             |    7 
 tools/testing/selftests/mm/vm_util.h                                   |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                     |   85 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh                        |    4 
 tools/testing/selftests/net/reuseaddr_conflict.c                       |    2 
 tools/testing/selftests/net/test_vxlan_mdb.sh                          |  205 +++-
 tools/testing/selftests/net/udpgro_fwd.sh                              |   10 
 355 files changed, 4153 insertions(+), 2335 deletions(-)

Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Aleksandr Mishin (2):
      net: phy: micrel: Fix potential null pointer dereference
      octeontx2-af: Add array index check

Alexandra Winter (1):
      s390/qeth: handle deferred cc1

Alexandre Ghiti (1):
      riscv: Disable preemption when using patch_map()

Andi Shyti (3):
      drm/i915/gt: Disable HW load balancing for CCS
      drm/i915/gt: Do not generate the command streamer for all the CCS
      drm/i915/gt: Enable only one CCS for compute workload

Andrei Matei (1):
      bpf: Protect against int overflow for stack access size

Andrii Nakryiko (2):
      bpf: put uprobe link's path and task in release callback
      bpf: support deferring bpf_link dealloc to after RCU grace period

Antoine Tenart (5):
      selftests: net: gro fwd: update vxlan GRO test expectations
      gro: fix ownership transfer
      udp: do not accept non-tunnel GSO skbs landing in a tunnel
      udp: do not transition UDP GRO fraglist partial checksums to unnecessary
      udp: prevent local UDP tunnel packets from being GROed

Anup Patel (2):
      RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
      RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

Ard Biesheuvel (5):
      efi/libstub: Add generic support for parsing mem_encrypt=
      x86/sme: Move early SME kernel encryption handling into .head.text
      x86/sev: Move early startup code into .head.text section
      x86/efistub: Remap kernel text read-only before dropping NX attribute
      x86/boot: Move mem_encrypt= parsing to the decompressor

Arnd Bergmann (4):
      dm integrity: fix out-of-range warning
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      ata: sata_mv: Fix PCI device ID table declaration compilation warning

Artem Savkov (1):
      arm64: bpf: fix 32bit unconditional bswap

Ashish Kalra (1):
      KVM: SVM: Add support for allowing zero SEV ASIDs

Atlas Yu (1):
      r8169: skip DASH fw status checks when DASH is disabled

Bartosz Golaszewski (2):
      gpio: cdev: sanitize the label before requesting the interrupt
      gpio: cdev: check for NULL labels when sanitizing them for irqs

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Benjamin Berg (1):
      wifi: iwlwifi: mvm: include link ID when releasing frames

Bjørn Mork (1):
      net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Borislav Petkov (AMD) (11):
      x86/CPU/AMD: Add ZenX generations flags
      x86/CPU/AMD: Carve out the erratum 1386 fix
      x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
      x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
      x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function
      x86/CPU/AMD: Get rid of amd_erratum_1054[]
      x86/CPU/AMD: Add X86_FEATURE_ZEN1
      x86/bugs: Fix the SRSO mitigation on Zen3/4
      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO
      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Chris Park (1):
      drm/amd/display: Prevent crash when disable stream

Christian Göttsche (1):
      selinux: avoid dereference of garbage after mount failure

Christian Hewitt (1):
      drm/panfrost: fix power transition timeout warnings

Christoffer Sandberg (1):
      ALSA: hda/realtek - Fix inactive headset mic jack

Christophe JAILLET (2):
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails
      net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()

Chuck Lever (1):
      SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP

Claudiu Beznea (1):
      net: ravb: Let IP-specific receive function to interrogate descriptors

Daniel Sneddon (2):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S
      KVM: x86: Add BHI_NO

Dave Airlie (1):
      nouveau/uvmm: fix addr/range calcs for remap operations

David Hildenbrand (2):
      x86/mm/pat: fix VM_PAT handling in COW mappings
      mm/secretmem: fix GUP-fast succeeding on secretmem folios

David Howells (2):
      cifs: Fix duplicate fscache cookie warnings
      cifs: Fix caching to try to do open O_WRONLY as rdwr on server

David Thompson (3):
      mlxbf_gige: stop PHY during open() error paths
      mlxbf_gige: call request_irq() after NAPI initialized
      mlxbf_gige: stop interface during shutdown

Davide Caratti (2):
      mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Dmytro Laktyushkin (1):
      drm/amd/display: Fix DPSTREAM CLK on and off sequence

Dominique Martinet (1):
      9p: Fix read/write debug statements to report server reply

Duanqiang Wen (1):
      net: txgbe: fix i2c dev name cannot match clkdev

Duoming Zhou (1):
      ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Edward Liaw (1):
      selftests/mm: include strings.h for ffsl

Emmanuel Grumbach (1):
      wifi: iwlwifi: disable multi rx queue for 9000

Eric Dumazet (5):
      tcp: properly terminate timers for kernel sockets
      netfilter: validate user input for expected length
      net/sched: act_skbmod: prevent kernel-infoleak
      net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
      erspan: make sure erspan_base_hdr is present in skb->head

Filipe Manana (2):
      btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
      btrfs: fix race when detecting delalloc ranges during fiemap

Florian Westphal (1):
      inet: inet_defrag: prevent sk release while still in use

Geliang Tang (1):
      selftests: mptcp: join: fix dev in check_endpoint

Greg Kroah-Hartman (3):
      Revert "x86/mpparse: Register APIC address only once"
      x86: set SPECTRE_BHI_ON as default
      Linux 6.6.26

Haiyang Zhang (1):
      net: mana: Fix Rx DMA datasize and skb_over_panic

Hangbin Liu (1):
      scripts/bpf_doc: Use silent mode when exec make cmd

Hariprasad Kelam (2):
      Octeontx2-af: fix pause frame configuration in GMP mode
      octeontx2-af: Fix issue with loading coalesced KPU profiles

Heiner Kallweit (1):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Horatiu Vultur (1):
      net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Hou Wenlong (1):
      x86/head/64: Move the __head definition to <asm/init.h>

Huai-Yuan Liu (1):
      spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Ido Schimmel (1):
      selftests: vxlan_mdb: Fix failures with old libnet

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_plt pointer arithmetic

Ingo Molnar (1):
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Ivan Vecera (10):
      i40e: Fix VF MAC filter removal
      i40e: Remove _t suffix from enum type names
      i40e: Enforce software interrupt during busy-poll exit
      i40e: Remove back pointer from i40e_hw structure
      i40e: Refactor I40E_MDIO_CLAUSE* macros
      virtchnl: Add header dependencies
      i40e: Simplify memory allocation functions
      i40e: Move memory allocation structures to i40e_alloc.h
      i40e: Split i40e_osdep.h
      i40e: Remove circular header dependencies and fix headers

Jack Brennen (1):
      modpost: Optimize symbol search from linear to binary search

Jaewon Kim (1):
      spi: s3c64xx: Use DMA mode from fifo size

Jakub Kicinski (2):
      tools: ynl: fix setting presence bits in simple nests
      selftests: reuseaddr_conflict: add missing new line at the end of the output

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jann Horn (1):
      fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Jason A. Donenfeld (1):
      x86/coco: Require seeding RNG with RDRAND on CoCo systems

Jeff Layton (1):
      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Jens Axboe (5):
      io_uring/kbuf: get rid of lower BGID lists
      io_uring/kbuf: get rid of bl->is_ready
      io_uring/kbuf: protect io_buffer_list teardown with a reference
      io_uring: use private workqueue for exit work
      io_uring/kbuf: hold io_buffer_list reference over mmap

Jesper Dangaard Brouer (1):
      xen-netfront: Add missing skb_mark_for_recycle

Jesse Brandeburg (4):
      ice: fix memory corruption bug with suspend and rebuild
      intel: add bit macro includes where needed
      intel: legacy: field get conversion
      ice: fix typo in assignment

Jian Shen (1):
      net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
      net: hns3: fix index limit to support all queue stats

Johan Hovold (4):
      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
      Bluetooth: qca: fix device-address endianness
      Bluetooth: add quirk for broken address properties

Johannes Berg (1):
      wifi: iwlwifi: mvm: rfi: fix potential response leaks

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid the interface always configured as random address

Josh Poimboeuf (4):
      x86/srso: Improve i-cache locality for alias mitigation
      x86/srso: Disentangle rethunk-dependent options
      x86/nospec: Refactor UNTRAIN_RET[_*]
      x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file

Justin Chen (1):
      net: bcmasp: Bring up unimac after PHY link up

Kan Liang (1):
      perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

Kent Gibson (1):
      gpio: cdev: fix missed label sanitizing in debounce_setup()

Krishna Kurapati (1):
      usb: typec: ucsi: Fix race between typec_switch and role_switch

Kuniyuki Iwashima (2):
      tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.
      ipv6: Fix infinite recursion in fib6_dump_done().

Kurt Kanzenbach (1):
      igc: Remove stale comment about Tx timestamping

Li Nan (1):
      scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

Linus Torvalds (1):
      x86/syscall: Don't force use of indirect calls for system calls

Maarten Lankhorst (1):
      drm/i915/display: Use i915_gem_object_get_dma_address to get dma address

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marco Pinna (1):
      vsock/virtio: fix packet delivery to tap device

Mario Limonciello (3):
      drm/amd: Evict resources during PM ops prepare() callback
      drm/amd: Add concept of running prepare_suspend() sequence for IP blocks
      drm/amd: Flush GFXOFF requests in prepare stage

Mark Brown (1):
      arm64/ptrace: Use saved floating point state type to determine SVE layout

Masahiro Yamada (1):
      modpost: do not make find_tosym() return NULL

Matt Roper (7):
      drm/i915/dg2: Drop pre-production GT workarounds
      drm/i915: Tidy workaround definitions
      drm/i915: Consolidate condition for Wa_22011802037
      drm/i915/xelpg: Call Xe_LPG workaround functions based on IP version
      drm/i915: Eliminate IS_MTL_GRAPHICS_STEP
      drm/i915: Replace several IS_METEORLAKE with proper IP version checks
      drm/i915/xelpg: Extend some workarounds/tuning to gfx version 12.74

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: connect: fix shellcheck warnings

Michael Krummsdorf (1):
      net: dsa: mv88e6xxx: fix usable ports on 88e6020

Michal Swiatkowski (1):
      ice: realloc VSI stats arrays

Namjae Jeon (3):
      ksmbd: don't send oplock break if rename fails
      ksmbd: validate payload size in ipc response
      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Oliver Upton (1):
      KVM: arm64: Fix host-programmed guest events in nVHE

Oswald Buddenhagen (1):
      Revert "ALSA: emu10k1: fix synthesizer sample playback position and caching"

Pablo Neira Ayuso (8):
      netfilter: nf_tables: reject destroy command to remove basechain hooks
      netfilter: nf_tables: reject table flag and netdev basechain updates
      netfilter: nf_tables: skip netdev hook unregistration if table is dormant
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: flush pending destroy work before exit_net release
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Paul Barker (2):
      net: ravb: Always process TX descriptor ring
      net: ravb: Always update error counters

Paulo Alcantara (11):
      smb: client: handle DFS tcons in cifs_construct_tcon()
      smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex
      smb: client: fix potential UAF in cifs_debug_files_proc_show()
      smb: client: fix potential UAF in cifs_stats_proc_write()
      smb: client: fix potential UAF in cifs_stats_proc_show()
      smb: client: fix potential UAF in cifs_dump_full_key()
      smb: client: fix potential UAF in smb2_is_valid_oplock_break()
      smb: client: fix potential UAF in smb2_is_valid_lease_break()
      smb: client: fix potential UAF in is_valid_oplock_break()
      smb: client: fix potential UAF in smb2_is_network_name_deleted()
      smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()

Pavel Sakharov (1):
      dma-buf: Fix NULL pointer dereference in sanitycheck()

Pawan Gupta (4):
      x86/bhi: Add support for clearing branch history at syscall entry
      x86/bhi: Enumerate Branch History Injection (BHI) bug
      x86/bhi: Add BHI mitigation knob
      x86/bhi: Mitigate KVM by default

Peter Xu (1):
      mm/treewide: replace pud_large() with pud_leaf()

Petr Oros (1):
      ice: fix enabling RX VLAN filtering

Pierre-Louis Bossart (5):
      ASoC: rt5682-sdw: fix locking sequence
      ASoC: rt711-sdca: fix locking sequence
      ASoC: rt711-sdw: fix locking sequence
      ASoC: rt712-sdca-sdw: fix locking sequence
      ASoC: rt722-sdca-sdw: fix locking sequence

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Pu Lehui (1):
      drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Puranjay Mohan (1):
      bpf, arm64: fix bug in BPF_LDX_MEMSX

Raju Lakkaraju (1):
      net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Ravi Gunasekaran (1):
      net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Richard Fitzgerald (3):
      ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
      regmap: maple: Fix cache corruption in regcache_maple_drop()
      regmap: maple: Fix uninitialized symbol 'ret' warnings

Ritvik Budhiraja (1):
      smb3: retrying on failed server close

Rob Clark (1):
      drm/prime: Unbreak virtgpu dma-buf export

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Sabrina Dubroca (3):
      tls: recv: process_rx_list shouldn't use an offset with kvec
      tls: adjust recv return with async crypto and failed copy to userspace
      tls: get psock ref after taking rxlock to avoid leak

Sam Protsenko (1):
      spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro

Samuel Holland (1):
      riscv: Fix spurious errors from __get/put_kernel_nofault

Sandipan Das (3):
      perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later
      x86/cpufeatures: Add new word for scattered features
      perf/x86/amd/lbr: Use freeze based on availability

Sean Christopherson (2):
      x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word
      KVM: SVM: Use unsigned integers when dealing with ASIDs

Sergey Shtylyov (1):
      of: module: prevent NULL pointer dereference in vsnprintf()

Simon Trimmer (2):
      ALSA: hda: cs35l56: Set the init_done flag before component_add()
      ALSA: hda: cs35l56: Add ACPI device match tables

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Steven Zou (1):
      ice: Refactor FW data type and fix bitmap casting issue

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Tejas Upadhyay (2):
      drm/i915/mtl: Update workaround 14016712196
      drm/i915/mtl: Update workaround 14018575942

Tudor Ambarus (6):
      spi: s3c64xx: sort headers alphabetically
      spi: s3c64xx: explicitly include <linux/bits.h>
      spi: s3c64xx: remove else after return
      spi: s3c64xx: define a magic value
      spi: s3c64xx: allow full FIFO masks
      spi: s3c64xx: determine the fifo depth only once

Uros Bizjak (1):
      x86/bpf: Fix IP after emitting call depth accounting

Victor Isaev (1):
      RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ

Vijendar Mukunda (2):
      ASoC: amd: acp: fix for acp_init function error handling
      ASoC: SOF: amd: fix for false dsp interrupts

Ville Syrjälä (1):
      drm/i915: Pre-populate the cursor physical dma address

Vitaly Lifshits (3):
      e1000e: Workaround for sporadic MDI error on Meteor Lake systems
      e1000e: Minor flow correction in e1000_shutdown function
      e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue

Wei Fang (1):
      net: fec: Set mac_managed_pm during probe

Will Deacon (1):
      KVM: arm64: Ensure target address is granule-aligned for range TLBI

Yonglong Liu (1):
      net: hns3: fix kernel crash when devlink reload during pf initialization

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()



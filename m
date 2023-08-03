Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20D576E579
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjHCKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjHCKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C04422C;
        Thu,  3 Aug 2023 03:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C2561D0C;
        Thu,  3 Aug 2023 10:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69471C433C7;
        Thu,  3 Aug 2023 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691057985;
        bh=0gjby1d/0pb/cnoAqYAZMRDp3yOfMDD9RPCCZ3KI5HY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ij+dDMrOGl9NJc9ZdzDlv3H7PWtHp4G9lR+X9tih+SEv1EaXPgWxANxtTWEcmiym5
         LuNA+pY9H7h9RWGHhNA5x+kk+zvmoZTUCJ3DRy6vdM6xGGXOYIvrJb2YU/lYdHgON4
         I04kMysRTACF8quLERtMoe2DxaKbAEP+7q6M57oU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.124
Date:   Thu,  3 Aug 2023 12:19:40 +0200
Message-ID: <2023080341-curliness-salary-4158@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.124 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/security-bugs.rst                |   39 
 Documentation/trace/kprobetrace.rst                        |    8 
 MAINTAINERS                                                |    1 
 Makefile                                                   |    2 
 arch/s390/mm/gmap.c                                        |    1 
 arch/x86/include/asm/kvm-x86-ops.h                         |    1 
 arch/x86/include/asm/kvm_host.h                            |    3 
 arch/x86/kvm/svm/svm.c                                     |    6 
 arch/x86/kvm/vmx/vmx.c                                     |   41 
 arch/x86/kvm/x86.c                                         |   34 
 drivers/acpi/processor_perflib.c                           |   38 
 drivers/ata/pata_ns87415.c                                 |    2 
 drivers/block/rbd.c                                        |  124 
 drivers/char/tpm/tpm_tis_core.c                            |   10 
 drivers/cpufreq/intel_pstate.c                             |   14 
 drivers/gpio/gpio-mvebu.c                                  |   26 
 drivers/gpio/gpio-tps68470.c                               |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                   |   45 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h                   |    5 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                      |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h              |   13 
 drivers/gpu/drm/ttm/ttm_bo.c                               |   25 
 drivers/hwmon/k10temp.c                                    |   17 
 drivers/hwmon/nct7802.c                                    |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                           |    4 
 drivers/i2c/busses/i2c-nomadik.c                           |   42 
 drivers/i2c/busses/i2c-sh7760.c                            |    3 
 drivers/i2c/busses/i2c-tiny-usb.c                          |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                   |   12 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                   |   18 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                   |    1 
 drivers/infiniband/hw/irdma/ctrl.c                         |   31 
 drivers/infiniband/hw/irdma/defs.h                         |   46 
 drivers/infiniband/hw/irdma/hw.c                           |    3 
 drivers/infiniband/hw/irdma/main.h                         |    2 
 drivers/infiniband/hw/irdma/puda.c                         |    6 
 drivers/infiniband/hw/irdma/type.h                         |    2 
 drivers/infiniband/hw/irdma/uk.c                           |    3 
 drivers/infiniband/hw/irdma/utils.c                        |    8 
 drivers/infiniband/hw/mlx4/qp.c                            |   18 
 drivers/infiniband/hw/mthca/mthca_qp.c                     |    2 
 drivers/irqchip/irq-bcm6345-l1.c                           |   14 
 drivers/irqchip/irq-gic-v3-its.c                           |   75 
 drivers/md/dm-cache-policy-smq.c                           |   28 
 drivers/md/dm-raid.c                                       |   20 
 drivers/md/md.c                                            |    2 
 drivers/net/Makefile                                       |    2 
 drivers/net/bonding/bond_main.c                            |    5 
 drivers/net/can/usb/gs_usb.c                               |    2 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c            |    7 
 drivers/net/ethernet/emulex/benet/be_main.c                |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c     |   17 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c      |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c             |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                |   11 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c          |   26 
 drivers/net/ethernet/intel/igc/igc_main.c                  |   40 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c           |    4 
 drivers/net/phy/marvell10g.c                               |    7 
 drivers/net/team/team.c                                    |    9 
 drivers/net/virtio_net.c                                   |    4 
 drivers/net/vxlan.c                                        | 4834 -------------
 drivers/net/vxlan/Makefile                                 |    7 
 drivers/net/vxlan/vxlan_core.c                             | 4831 ++++++++++++
 drivers/pci/controller/pcie-rockchip-ep.c                  |  156 
 drivers/pci/controller/pcie-rockchip.h                     |   40 
 drivers/pci/pcie/aspm.c                                    |   55 
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                 |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c              |   86 
 drivers/platform/x86/msi-laptop.c                          |    8 
 drivers/pwm/pwm-meson.c                                    |   25 
 drivers/s390/block/dasd_ioctl.c                            |    1 
 drivers/scsi/qla2xxx/qla_attr.c                            |    3 
 drivers/scsi/qla2xxx/qla_def.h                             |   27 
 drivers/scsi/qla2xxx/qla_gbl.h                             |   14 
 drivers/scsi/qla2xxx/qla_init.c                            |  256 
 drivers/scsi/qla2xxx/qla_iocb.c                            |   33 
 drivers/scsi/qla2xxx/qla_isr.c                             |   26 
 drivers/scsi/qla2xxx/qla_target.h                          |    2 
 drivers/soundwire/qcom.c                                   |    2 
 drivers/staging/ks7010/ks_wlan_net.c                       |    6 
 drivers/staging/media/atomisp/Kconfig                      |    1 
 drivers/staging/rtl8712/rtl871x_xmit.c                     |   43 
 drivers/staging/rtl8712/xmit_linux.c                       |    6 
 drivers/tty/n_gsm.c                                        |    4 
 drivers/tty/n_tty.c                                        |   29 
 drivers/tty/serial/8250/8250_dwlib.c                       |    6 
 drivers/tty/serial/qcom_geni_serial.c                      |    7 
 drivers/tty/serial/sifive.c                                |    2 
 drivers/usb/cdns3/cdns3-gadget.c                           |    4 
 drivers/usb/core/quirks.c                                  |    4 
 drivers/usb/dwc3/core.c                                    |   20 
 drivers/usb/dwc3/core.h                                    |    3 
 drivers/usb/dwc3/dwc3-pci.c                                |    6 
 drivers/usb/gadget/composite.c                             |    4 
 drivers/usb/gadget/legacy/raw_gadget.c                     |   10 
 drivers/usb/gadget/udc/tegra-xudc.c                        |    8 
 drivers/usb/host/ohci-at91.c                               |    8 
 drivers/usb/host/xhci-mtk.c                                |    1 
 drivers/usb/host/xhci-pci.c                                |    4 
 drivers/usb/host/xhci-ring.c                               |   25 
 drivers/usb/host/xhci-tegra.c                              |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/usb-serial-simple.c                     |   73 
 fs/btrfs/qgroup.c                                          |   18 
 fs/btrfs/transaction.c                                     |   10 
 fs/ceph/metric.c                                           |    2 
 fs/cifs/cifs_dfs_ref.c                                     |  100 
 fs/cifs/file.c                                             |    4 
 fs/dlm/plock.c                                             |  100 
 fs/file.c                                                  |    6 
 fs/internal.h                                              |    2 
 fs/jbd2/checkpoint.c                                       |   32 
 fs/ksmbd/vfs.c                                             |    2 
 fs/nfsd/nfs4state.c                                        |    2 
 include/linux/namei.h                                      |    2 
 include/linux/pwm.h                                        |    5 
 include/net/ipv6.h                                         |    8 
 include/net/vxlan.h                                        |   13 
 include/uapi/linux/blkzoned.h                              |   10 
 io_uring/io_uring.c                                        |   10 
 kernel/locking/rtmutex.c                                   |  170 
 kernel/locking/rtmutex_api.c                               |    2 
 kernel/locking/rtmutex_common.h                            |   47 
 kernel/locking/ww_mutex.h                                  |   12 
 kernel/trace/ring_buffer.c                                 |   22 
 kernel/trace/trace.c                                       |    2 
 kernel/trace/trace.h                                       |    6 
 kernel/trace/trace_events.c                                |   14 
 kernel/trace/trace_events_hist.c                           |    7 
 kernel/trace/trace_events_synth.c                          |   80 
 kernel/trace/trace_probe.c                                 |   46 
 kernel/trace/trace_probe.h                                 |   16 
 kernel/trace/trace_probe_kernel.h                          |   30 
 kernel/trace/trace_probe_tmpl.h                            |   59 
 kernel/trace/trace_synth.h                                 |    1 
 kernel/trace/trace_uprobe.c                                |    3 
 net/ceph/messenger.c                                       |    1 
 net/ipv6/addrconf.c                                        |   14 
 net/netfilter/nf_tables_api.c                              |    5 
 net/netfilter/nft_immediate.c                              |   27 
 net/netfilter/nft_set_rbtree.c                             |   20 
 net/sched/sch_mqprio.c                                     |  144 
 net/tipc/crypto.c                                          |    3 
 net/tipc/node.c                                            |    2 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/soc/codecs/cs42l51-i2c.c                             |    6 
 sound/soc/codecs/cs42l51.c                                 |    7 
 sound/soc/codecs/cs42l51.h                                 |    1 
 sound/soc/codecs/wm8904.c                                  |    3 
 sound/soc/fsl/fsl_spdif.c                                  |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh            |    5 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh         |   20 
 virt/kvm/kvm_main.c                                        |   24 
 158 files changed, 6849 insertions(+), 5939 deletions(-)

Adrien Thierry (2):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend
      phy: qcom-snps-femto-v2: properly enable ref clock

Alexander Aring (3):
      dlm: cleanup plock_op vs plock_xop
      dlm: rearrange async condition return
      fs: dlm: interrupt posix locks only when process is killed

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Andi Shyti (2):
      i2c: nomadik: Remove unnecessary goto label
      i2c: nomadik: Use devm_clk_get_enabled()

Andy Shevchenko (1):
      pwm: Add a stub for devm_pwmchip_add()

Arnd Bergmann (1):
      ata: pata_ns87415: mark ns87560_tf_read static

Arun Easi (1):
      scsi: qla2xxx: Add debug prints in the device remove path

Bart Van Assche (1):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h

Bartosz Golaszewski (1):
      gpio: mvebu: fix irq domain leak

Baskaran Kannan (1):
      hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Bharath SM (1):
      cifs: if deferred close is disabled then close files immediately

Bjorn Helgaas (1):
      PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Chaoyuan Peng (1):
      tty: n_gsm: fix UAF in gsm_cleanup_mux

Christian Brauner (1):
      file: always lock position for FMODE_ATOMIC_POS

Christian König (1):
      drm/ttm: never consider pinned BOs for eviction&swap

Christophe JAILLET (1):
      i2c: nomadik: Remove a useless call in the remove function

Claudio Imbrenda (1):
      KVM: s390: pv: fix index value of replaced ASCE

Dan Carpenter (3):
      RDMA/mlx4: Make check for invalid flags stricter
      Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"
      Revert "usb: xhci: tegra: Fix error check"

Dmitry Baryshkov (1):
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Fedor Pchelkin (1):
      tipc: stop tipc crypto on failure in tipc_node_create

Filipe Manana (3):
      btrfs: fix race between quota disable and relocation
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()

Flora Cui (1):
      drm/amdgpu: fix vkms crtc settings

Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Frank Li (2):
      usb: gadget: call usb_gadget_check_config() to verify UDC capability
      usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config

Gaosheng Cui (2):
      scsi: qla2xxx: Remove unused declarations for qla2xxx
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (3):
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Linux 5.15.124

Guchun Chen (1):
      drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Heiner Kallweit (1):
      pwm: meson: fix handling of period/duty if greater than UINT_MAX

Hui Li (1):
      tty: fix hang on tty device with no_room set

Ilpo Järvinen (3):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race
      n_tty: Rename tail to old_tail in n_tty_read()

Ilya Dryomov (3):
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: harden get_lock_owner_info() a bit
      rbd: retrieve and check lock owner twice before blocklisting

Jacob Keller (2):
      iavf: fix potential deadlock on allocation failure
      iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jens Axboe (1):
      io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jijie Shao (2):
      net: hns3: fix wrong tc bandwidth weight data issue
      net: hns3: fix wrong bw weight of disabled tc issue

Jiri Benc (1):
      vxlan: calculate correct header length for GPE

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-only

Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Johan Hovold (2):
      serial: qcom-geni: drop bogus runtime pm state update
      USB: serial: simple: sort driver entries

Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Kashyap Desai (1):
      RDMA/bnxt_re: Prevent handling any completions after qp destroy

Krzysztof Kozlowski (1):
      phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Larry Finger (1):
      staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Lin Ma (1):
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Mario Limonciello (1):
      drm/amd: Fix an error handling mistake in psp_sw_init()

Mark Brown (1):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Markus Elfring (2):
      i2c: Delete error messages for failed memory allocations
      i2c: Improve size determinations

Masami Hiramatsu (Google) (4):
      tracing/probes: Add symstr type for dynamic events
      tracing/probes: Fix to avoid double count of the string length on the array
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

Matthieu Baerts (2):
      selftests: mptcp: sockopt: use 'iptables-legacy' if available
      selftests: mptcp: join: only check for ip6tables if needed

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Muhammad Husaini Zulkifli (1):
      igc: Fix Kernel Panic during ndo_tx_timeout callback

Namjae Jeon (1):
      ksmbd: remove internal.h include

Oliver Neukum (2):
      USB: serial: simple: add Kaufmann RKS+CAN VCP
      Revert "xhci: add quirk for host controllers that don't update endpoint DCS"

Ondrej Mosnacek (1):
      io_uring: don't audit the capability check in io_uring_create()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Paulo Alcantara (1):
      cifs: use fs_context for automounts

Peter Zijlstra (1):
      locking/rtmutex: Fix task->pi_waiters integrity

Quinn Tran (4):
      scsi: qla2xxx: Multi-que support for TMF
      scsi: qla2xxx: Fix task management cmd failure
      scsi: qla2xxx: Fix task management cmd fail due to unavailable resource
      scsi: qla2xxx: Fix hang in task management

Rafael J. Wysocki (3):
      ACPI: processor: perflib: Use the "no limit" frequency QoS
      ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
      cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rick Wertenbroek (3):
      PCI: rockchip: Remove writes to unused registers
      PCI: rockchip: Fix window mapping and address translation for endpoint
      PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

Rob Clark (1):
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Roopa Prabhu (1):
      vxlan: move to its own directory

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Sakari Ailus (1):
      media: staging: atomisp: select V4L2_FWNODE

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Sean Christopherson (3):
      KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
      KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
      KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid

Shiraz Saleem (3):
      RDMA/irdma: Add missing read barriers
      RDMA/irdma: Fix data race on CQP completion stats
      RDMA/irdma: Fix data race on CQP request done

Sindhu Devale (1):
      RDMA/irdma: Report correct WC error

Srinivas Kandagatla (1):
      soundwire: qcom: update status correctly with mask

Stefan Haberland (1):
      s390/dasd: fix hanging device after quiesce/resume

Steve French (1):
      cifs: missing directory in MAINTAINERS file

Steven Rostedt (Google) (2):
      tracing: Allow synthetic events to pass around stacktraces
      tracing: Fix trace_event_raw_event_synth() if else statement

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

Thomas Hellström (2):
      drm/ttm: Don't print error message if eviction was interrupted
      drm/ttm: Don't leak a resource on eviction error

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Uwe Kleine-König (2):
      gpio: mvebu: Make use of devm_pwmchip_add
      pwm: meson: Simplify duplicated per-channel tracking

Vincent Whitchurch (1):
      net: stmmac: Apply redundant write work around on 4.xx too

Vladimir Oltean (2):
      net/sched: mqprio: refactor nlattr parsing to a separate function
      net/sched: mqprio: add extack to mqprio_parse_nlattr()

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Xiubo Li (1):
      ceph: never send metrics if disable_send_metrics is set

Yu Kuai (3):
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
      dm raid: clean up four equivalent goto tags in raid_ctr()
      dm raid: protect md_stop() with 'reconfig_mutex'

Yuan Can (1):
      phy: qcom-snps: Use dev_err_probe() to simplify code

Yuanjun Gong (3):
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      tipc: check return value of pskb_trim()

Zhang Shurong (1):
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhihao Cheng (1):
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett


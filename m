Return-Path: <linux-kernel+bounces-138826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38189FACE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B32282F62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D116EC15;
	Wed, 10 Apr 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rD/W1DnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306516E886;
	Wed, 10 Apr 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761044; cv=none; b=PrKYv+vPQffhJrff0Dfb4Bwyrc99XumKbNPLtCZUK6N/O+4mNUqjNApU/Wj5Tq/Ynzjdi2o9qJ3RZwkOGALNcT7P8m/4Kq/G8yrraPiazon+JuZvwwrpg0aOzi7uQrNKj9tTA7UjE1s8YmCiFoYwLTzzUOQ7Z1jqwsDSzNlpMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761044; c=relaxed/simple;
	bh=tFvApzuAPAwV1Yz3WAkgB9/yiS9GM2xyDEbFgOrISic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FahW+xD2jM74UTIUQ+3kztrKw29gA1WnFDLwMjp6KpSqkLTwZZHy0q0H4HGL9i9EpPhXLzOFUvvOyc7uh7vqIIroIzk8Uh4Y85DUyP29ok1RzEY3IfIeD2Ar0UI74ujclWc4ArZbOCFKxg105CWROCpeb+u9wAJ3MnFq4xRaTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rD/W1DnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549DEC433C7;
	Wed, 10 Apr 2024 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712761043;
	bh=tFvApzuAPAwV1Yz3WAkgB9/yiS9GM2xyDEbFgOrISic=;
	h=From:To:Cc:Subject:Date:From;
	b=rD/W1DnMRT3SwQhtTzZ2oDMHKD93Zu4lxHIJel/MTVn04mGBhgX/dhN1m0S2xumtg
	 saT8Z5zcSHapzkevwsiYWsvwrAjPFife3AQffl9D00hioZwUuxoYPaHOIOs0/CmF9B
	 B15Uas4wDYP39Oy4eUHkNqnSxGUSQOdpszlH7JGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.85
Date: Wed, 10 Apr 2024 16:57:14 +0200
Message-ID: <2024041015-spotlight-unselect-d4a5@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.85 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                          |   48 +++
 Documentation/admin-guide/kernel-parameters.txt                        |   12 
 Makefile                                                               |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                           |    2 
 arch/riscv/include/asm/uaccess.h                                       |    4 
 arch/riscv/kernel/process.c                                            |    3 
 arch/s390/kernel/entry.S                                               |    1 
 arch/x86/Kconfig                                                       |   25 +
 arch/x86/coco/core.c                                                   |   41 +++
 arch/x86/entry/common.c                                                |   10 
 arch/x86/entry/entry_64.S                                              |   61 ++++
 arch/x86/entry/entry_64_compat.S                                       |   16 +
 arch/x86/entry/syscall_32.c                                            |   21 +
 arch/x86/entry/syscall_64.c                                            |   19 +
 arch/x86/entry/syscall_x32.c                                           |   10 
 arch/x86/events/amd/core.c                                             |    4 
 arch/x86/events/amd/lbr.c                                              |   16 -
 arch/x86/include/asm/asm-prototypes.h                                  |    1 
 arch/x86/include/asm/coco.h                                            |    2 
 arch/x86/include/asm/cpufeature.h                                      |    8 
 arch/x86/include/asm/cpufeatures.h                                     |   15 +
 arch/x86/include/asm/disabled-features.h                               |    3 
 arch/x86/include/asm/msr-index.h                                       |    9 
 arch/x86/include/asm/nospec-branch.h                                   |   37 ++
 arch/x86/include/asm/required-features.h                               |    3 
 arch/x86/include/asm/syscall.h                                         |   11 
 arch/x86/kernel/cpu/bugs.c                                             |  121 ++++++++-
 arch/x86/kernel/cpu/common.c                                           |   24 +
 arch/x86/kernel/cpu/mce/core.c                                         |    4 
 arch/x86/kernel/cpu/scattered.c                                        |    2 
 arch/x86/kernel/setup.c                                                |    2 
 arch/x86/kvm/reverse_cpuid.h                                           |    5 
 arch/x86/kvm/svm/sev.c                                                 |   60 ++--
 arch/x86/kvm/trace.h                                                   |   10 
 arch/x86/kvm/vmx/vmenter.S                                             |    2 
 arch/x86/kvm/x86.c                                                     |    2 
 arch/x86/lib/retpoline.S                                               |    6 
 arch/x86/mm/ident_map.c                                                |   23 -
 arch/x86/mm/pat/memtype.c                                              |   49 ++-
 drivers/acpi/acpica/dbnames.c                                          |    8 
 drivers/ata/sata_mv.c                                                  |   63 ++--
 drivers/ata/sata_sx4.c                                                 |    6 
 drivers/base/core.c                                                    |   26 +
 drivers/bluetooth/btqca.c                                              |    8 
 drivers/bluetooth/hci_qca.c                                            |   19 -
 drivers/dma-buf/st-dma-fence-chain.c                                   |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |   38 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                |   10 
 drivers/gpu/drm/amd/include/amd_shared.h                               |    1 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                                |    6 
 drivers/md/dm-integrity.c                                              |    2 
 drivers/net/ethernet/freescale/fec_main.c                              |   11 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                     |   19 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                |    4 
 drivers/net/ethernet/intel/i40e/i40e.h                                 |    6 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |   14 -
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                             |    6 
 drivers/net/ethernet/intel/i40e/i40e_register.h                        |    3 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                            |   82 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                            |    5 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                     |   45 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                         |   16 -
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                        |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                    |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                    |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                   |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c             |   31 +-
 drivers/net/ethernet/microchip/lan743x_main.c                          |   18 +
 drivers/net/ethernet/microchip/lan743x_main.h                          |    4 
 drivers/net/ethernet/realtek/r8169_main.c                              |  131 ++++++++--
 drivers/net/ethernet/renesas/ravb_main.c                               |   33 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                      |   40 ++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                    |   38 ++
 drivers/net/phy/micrel.c                                               |   31 +-
 drivers/net/usb/asix_devices.c                                         |    4 
 drivers/net/usb/ax88179_178a.c                                         |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c                           |    8 
 drivers/net/wwan/t7xx/t7xx_cldma.c                                     |    4 
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c                                 |    9 
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c                                  |    8 
 drivers/net/xen-netfront.c                                             |    1 
 drivers/nvme/host/core.c                                               |    4 
 drivers/nvme/host/ioctl.c                                              |    3 
 drivers/nvme/host/nvme.h                                               |    2 
 drivers/nvme/target/passthru.c                                         |    3 
 drivers/of/dynamic.c                                                   |   12 
 drivers/perf/riscv_pmu.c                                               |    4 
 drivers/s390/net/qeth_core_main.c                                      |   38 ++
 drivers/scsi/myrb.c                                                    |   20 -
 drivers/scsi/myrs.c                                                    |   24 -
 drivers/scsi/sd.c                                                      |    2 
 fs/nfsd/nfs4state.c                                                    |    7 
 fs/pipe.c                                                              |   17 -
 fs/smb/client/cached_dir.c                                             |    6 
 fs/smb/client/cifs_debug.c                                             |    6 
 fs/smb/client/cifsfs.c                                                 |   11 
 fs/smb/client/cifsglob.h                                               |   17 +
 fs/smb/client/connect.c                                                |    2 
 fs/smb/client/dir.c                                                    |   15 +
 fs/smb/client/file.c                                                   |  111 +++++++-
 fs/smb/client/fscache.c                                                |   16 +
 fs/smb/client/fscache.h                                                |    6 
 fs/smb/client/inode.c                                                  |    2 
 fs/smb/client/misc.c                                                   |    2 
 fs/smb/client/smb1ops.c                                                |    4 
 fs/smb/client/smb2misc.c                                               |    4 
 fs/smb/client/smb2ops.c                                                |   11 
 fs/smb/client/smb2pdu.c                                                |    2 
 fs/smb/server/ksmbd_netlink.h                                          |    3 
 fs/smb/server/mgmt/share_config.c                                      |    7 
 fs/smb/server/smb2ops.c                                                |   10 
 fs/smb/server/smb2pdu.c                                                |    3 
 fs/smb/server/transport_ipc.c                                          |   37 ++
 fs/vboxsf/super.c                                                      |    3 
 include/kvm/arm_pmu.h                                                  |    2 
 include/linux/device.h                                                 |    1 
 include/linux/secretmem.h                                              |    4 
 include/linux/skbuff.h                                                 |    7 
 include/linux/udp.h                                                    |   28 ++
 include/net/bluetooth/hci.h                                            |    9 
 include/net/inet_connection_sock.h                                     |    1 
 include/net/sock.h                                                     |    7 
 kernel/bpf/verifier.c                                                  |    5 
 mm/memory.c                                                            |    4 
 net/9p/client.c                                                        |   10 
 net/bluetooth/hci_debugfs.c                                            |   48 ++-
 net/bluetooth/hci_event.c                                              |   25 +
 net/bluetooth/hci_sync.c                                               |    5 
 net/bridge/netfilter/ebtables.c                                        |    6 
 net/core/gro.c                                                         |    3 
 net/core/sock_map.c                                                    |    6 
 net/ipv4/inet_connection_sock.c                                        |   33 +-
 net/ipv4/inet_fragment.c                                               |   70 ++++-
 net/ipv4/ip_fragment.c                                                 |    2 
 net/ipv4/ip_gre.c                                                      |    5 
 net/ipv4/netfilter/arp_tables.c                                        |    4 
 net/ipv4/netfilter/ip_tables.c                                         |    4 
 net/ipv4/tcp.c                                                         |    2 
 net/ipv4/udp.c                                                         |    7 
 net/ipv4/udp_offload.c                                                 |   23 -
 net/ipv6/ip6_fib.c                                                     |   14 -
 net/ipv6/ip6_gre.c                                                     |    3 
 net/ipv6/netfilter/ip6_tables.c                                        |    4 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                |    2 
 net/ipv6/udp.c                                                         |    2 
 net/ipv6/udp_offload.c                                                 |    8 
 net/mptcp/protocol.c                                                   |    3 
 net/mptcp/subflow.c                                                    |    2 
 net/netfilter/nf_tables_api.c                                          |   13 
 net/nfc/nci/core.c                                                     |    5 
 net/rds/rdma.c                                                         |    2 
 net/sched/act_skbmod.c                                                 |   10 
 net/sched/sch_api.c                                                    |    2 
 net/tls/tls_sw.c                                                       |    7 
 net/vmw_vsock/virtio_transport.c                                       |    3 
 scripts/bpf_doc.py                                                     |    4 
 sound/pci/hda/patch_realtek.c                                          |    3 
 sound/soc/codecs/rt5682-sdw.c                                          |    4 
 sound/soc/codecs/rt711-sdca-sdw.c                                      |    4 
 sound/soc/codecs/rt711-sdw.c                                           |    4 
 sound/soc/soc-ops.c                                                    |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                     |    7 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                        |    7 
 tools/testing/selftests/net/reuseaddr_conflict.c                       |    2 
 tools/testing/selftests/net/udpgro_fwd.sh                              |   10 
 167 files changed, 1790 insertions(+), 546 deletions(-)

Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Aleksandr Mishin (2):
      net: phy: micrel: Fix potential null pointer dereference
      octeontx2-af: Add array index check

Alexander Mikhalitsyn (1):
      KVM: SVM: enhance info printk's in SEV init

Alexandra Winter (1):
      s390/qeth: handle deferred cc1

Andrei Matei (1):
      bpf: Protect against int overflow for stack access size

Antoine Tenart (5):
      selftests: net: gro fwd: update vxlan GRO test expectations
      gro: fix ownership transfer
      udp: do not accept non-tunnel GSO skbs landing in a tunnel
      udp: do not transition UDP GRO fraglist partial checksums to unnecessary
      udp: prevent local UDP tunnel packets from being GROed

Arnd Bergmann (4):
      dm integrity: fix out-of-range warning
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      ata: sata_mv: Fix PCI device ID table declaration compilation warning

Ashish Kalra (1):
      KVM: SVM: Add support for allowing zero SEV ASIDs

Atlas Yu (1):
      r8169: skip DASH fw status checks when DASH is disabled

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Bjørn Mork (1):
      net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Borislav Petkov (AMD) (4):
      x86/bugs: Fix the SRSO mitigation on Zen3/4
      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO
      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Christian Hewitt (1):
      drm/panfrost: fix power transition timeout warnings

Christoffer Sandberg (1):
      ALSA: hda/realtek - Fix inactive headset mic jack

Christophe JAILLET (1):
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Claudiu Beznea (1):
      net: ravb: Let IP-specific receive function to interrogate descriptors

Daniel Sneddon (2):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S
      KVM: x86: Add BHI_NO

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

Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Denis Kirjanov (1):
      drivers: net: convert to boolean for the mac_managed_pm flag

Dominique Martinet (1):
      9p: Fix read/write debug statements to report server reply

Eric Dumazet (5):
      tcp: properly terminate timers for kernel sockets
      netfilter: validate user input for expected length
      net/sched: act_skbmod: prevent kernel-infoleak
      net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
      erspan: make sure erspan_base_hdr is present in skb->head

Florian Westphal (1):
      inet: inet_defrag: prevent sk release while still in use

Geliang Tang (2):
      selftests: mptcp: join: fix dev in check_endpoint
      selftests: mptcp: display simult in extra_msg

Greg Kroah-Hartman (2):
      x86: set SPECTRE_BHI_ON as default
      Linux 6.1.85

Hangbin Liu (1):
      scripts/bpf_doc: Use silent mode when exec make cmd

Hariprasad Kelam (2):
      Octeontx2-af: fix pause frame configuration in GMP mode
      octeontx2-af: Fix issue with loading coalesced KPU profiles

Heiner Kallweit (4):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d
      r8169: use spinlock to protect mac ocp register access
      r8169: use spinlock to protect access to registers Config2 and Config5
      r8169: prepare rtl_hw_aspm_clkreq_enable for usage in atomic context

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Horatiu Vultur (1):
      net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Ingo Molnar (1):
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Ivan Vecera (3):
      i40e: Fix VF MAC filter removal
      i40e: Remove _t suffix from enum type names
      i40e: Enforce software interrupt during busy-poll exit

Jakub Kicinski (1):
      selftests: reuseaddr_conflict: add missing new line at the end of the output

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jann Horn (1):
      fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Jason A. Donenfeld (1):
      x86/coco: Require seeding RNG with RDRAND on CoCo systems

Jeff Layton (1):
      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Jesper Dangaard Brouer (1):
      xen-netfront: Add missing skb_mark_for_recycle

Jian Shen (1):
      net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
      net: hns3: fix index limit to support all queue stats

Joe Damato (1):
      i40e: Store the irq number in i40e_q_vector

Johan Hovold (4):
      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
      Bluetooth: qca: fix device-address endianness
      Bluetooth: add quirk for broken address properties

Johannes Berg (1):
      wifi: iwlwifi: mvm: rfi: fix potential response leaks

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid the interface always configured as random address

Josh Poimboeuf (1):
      x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file

Kuniyuki Iwashima (2):
      ipv6: Fix infinite recursion in fib6_dump_done().
      tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.

Li Nan (1):
      scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

Linus Torvalds (1):
      x86/syscall: Don't force use of indirect calls for system calls

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marco Pinna (1):
      vsock/virtio: fix packet delivery to tap device

Mario Limonciello (3):
      drm/amd: Evict resources during PM ops prepare() callback
      drm/amd: Add concept of running prepare_suspend() sequence for IP blocks
      drm/amd: Flush GFXOFF requests in prepare stage

Namjae Jeon (3):
      ksmbd: don't send oplock break if rename fails
      ksmbd: validate payload size in ipc response
      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Oliver Upton (1):
      KVM: arm64: Fix host-programmed guest events in nVHE

Pablo Neira Ayuso (2):
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: flush pending destroy work before exit_net release

Paul Barker (2):
      net: ravb: Always process TX descriptor ring
      net: ravb: Always update error counters

Paulo Alcantara (8):
      smb: client: fix potential UAF in cifs_debug_files_proc_show()
      smb: client: fix potential UAF in cifs_stats_proc_write()
      smb: client: fix potential UAF in cifs_stats_proc_show()
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

Pierre-Louis Bossart (3):
      ASoC: rt5682-sdw: fix locking sequence
      ASoC: rt711-sdca: fix locking sequence
      ASoC: rt711-sdw: fix locking sequence

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Pu Lehui (1):
      drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Raju Lakkaraju (1):
      net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Ritvik Budhiraja (1):
      smb3: retrying on failed server close

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Sabrina Dubroca (3):
      tls: recv: process_rx_list shouldn't use an offset with kvec
      tls: adjust recv return with async crypto and failed copy to userspace
      tls: get psock ref after taking rxlock to avoid leak

Samuel Holland (1):
      riscv: Fix spurious errors from __get/put_kernel_nofault

Sandipan Das (2):
      x86/cpufeatures: Add new word for scattered features
      perf/x86/amd/lbr: Use freeze based on availability

Sean Christopherson (3):
      x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word
      KVM: SVM: WARN, but continue, if misc_cg_set_capacity() fails
      KVM: SVM: Use unsigned integers when dealing with ASIDs

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Wei Fang (1):
      net: fec: Set mac_managed_pm during probe

Yonglong Liu (1):
      net: hns3: fix kernel crash when devlink reload during pf initialization

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

min15.li (1):
      nvme: fix miss command type check



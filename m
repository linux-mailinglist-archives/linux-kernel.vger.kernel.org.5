Return-Path: <linux-kernel+bounces-161090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3228B46E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1911C20E53
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018017BA1;
	Sat, 27 Apr 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUSwOFZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7314F7A;
	Sat, 27 Apr 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233293; cv=none; b=RCTED2L/1BY9gXVL8A/4xsDZFDVbZvweMgofnCU5IKxMAnN4ceu3FPggXoCji97LuOyI+eGwtjUiccvE2JYPR8RmjcOn/1cx8THfY8Y/LRyOIpaEYcvRu9+C4bJIEUd6AvTXYxeCrjts78Mx4AYSUmy2xN2ThYKfh31TO+J1ptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233293; c=relaxed/simple;
	bh=yDlcF6hK57Y+s8ZLN+ihrBhXqAIWrrkoElf6Ktatzz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcftSLlnhtr/j+ZsB5iPncZ3VHOl0OSj5gwqKb1UP8xHLTRC3XheY8v/ffWWo5Qrcp9Vi6C0UA1pBF+vpXSy6pdFlNFLF0xINS7oi0oY3R4NcwvZi3pN2A1uxFuqibeIMUZtrl1t0AEarukmgasVoKezUFvLqpeGVo9D5xoVep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WUSwOFZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8ACC113CE;
	Sat, 27 Apr 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233292;
	bh=yDlcF6hK57Y+s8ZLN+ihrBhXqAIWrrkoElf6Ktatzz8=;
	h=From:To:Cc:Subject:Date:From;
	b=WUSwOFZr89XkqUiDascIBl3xze9pxx9kgz+muRQ07DiyJeCryIedGLry7lx5lFDSF
	 k7cLblAOlUJALPYxWGKIeTQm7mhKMT7+HCJGNbOdSiqcMcXgONTpbz/oEKktys5kOw
	 NAL8qs3YsD9KmWjx/UCJnBVqAnRzdZ5WHMuoB/Zc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.157
Date: Sat, 27 Apr 2024 17:54:47 +0200
Message-ID: <2024042748-unleaded-fracture-1ab8@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.157 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/nfs/exporting.rst                     |    7 
 Makefile                                                        |    2 
 arch/arm64/mm/pageattr.c                                        |    3 
 arch/x86/include/asm/kvm_host.h                                 |    1 
 arch/x86/kernel/cpu/bugs.c                                      |   11 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 arch/x86/kvm/cpuid.c                                            |    1 
 arch/x86/kvm/cpuid.h                                            |   10 
 arch/x86/kvm/lapic.c                                            |    3 
 arch/x86/kvm/mmu/mmu.c                                          |    2 
 arch/x86/kvm/x86.c                                              |    2 
 drivers/accessibility/speakup/main.c                            |    2 
 drivers/android/binder.c                                        |    4 
 drivers/clk/clk.c                                               |  154 +++++++---
 drivers/comedi/drivers/vmk80xx.c                                |   35 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   72 ++--
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                  |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                             |    4 
 drivers/infiniband/core/cm.c                                    |   11 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/net/dsa/mt7530.c                                        |   60 ++-
 drivers/net/dsa/mt7530.h                                        |    6 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                        |   18 +
 drivers/net/tun.c                                               |   18 -
 drivers/s390/cio/device.c                                       |   13 
 drivers/s390/cio/qdio_main.c                                    |   28 +
 drivers/thunderbolt/switch.c                                    |   48 ++-
 drivers/thunderbolt/tb.c                                        |    4 
 drivers/thunderbolt/tb.h                                        |    3 
 drivers/thunderbolt/usb4.c                                      |   13 
 drivers/tty/serial/pmac_zilog.c                                 |   14 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/port.c                                         |    4 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                             |    4 
 drivers/usb/serial/option.c                                     |   40 ++
 fs/btrfs/delayed-inode.c                                        |    3 
 fs/ksmbd/ksmbd_netlink.h                                        |    3 
 fs/ksmbd/mgmt/share_config.c                                    |    7 
 fs/ksmbd/smb2ops.c                                              |   10 
 fs/ksmbd/smb2pdu.c                                              |    3 
 fs/ksmbd/transport_ipc.c                                        |   37 ++
 fs/lockd/svclock.c                                              |    4 
 fs/nfsd/nfs4state.c                                             |   10 
 fs/nilfs2/dir.c                                                 |    2 
 fs/sysfs/file.c                                                 |    2 
 include/linux/bpf.h                                             |    9 
 include/linux/bpf_verifier.h                                    |    4 
 include/linux/exportfs.h                                        |   14 
 include/net/dsa.h                                               |    8 
 include/net/net_namespace.h                                     |    6 
 include/net/netfilter/nf_flow_table.h                           |   33 ++
 include/net/netns/flow_table.h                                  |   14 
 include/trace/events/rpcgss.h                                   |    4 
 init/main.c                                                     |    2 
 kernel/bpf/btf.c                                                |   93 ++++--
 kernel/bpf/verifier.c                                           |   66 +++-
 kernel/kprobes.c                                                |   18 -
 kernel/trace/trace_events_trigger.c                             |    6 
 net/bridge/br_input.c                                           |   15 
 net/bridge/br_netfilter_hooks.c                                 |    6 
 net/bridge/br_private.h                                         |    1 
 net/bridge/netfilter/nf_conntrack_bridge.c                      |   14 
 net/dsa/dsa2.c                                                  |   24 +
 net/netfilter/Kconfig                                           |    9 
 net/netfilter/Makefile                                          |    1 
 net/netfilter/nf_flow_table_core.c                              |   62 +++-
 net/netfilter/nf_flow_table_inet.c                              |    3 
 net/netfilter/nf_flow_table_ip.c                                |   10 
 net/netfilter/nf_flow_table_offload.c                           |   17 -
 net/netfilter/nf_flow_table_procfs.c                            |   80 +++++
 net/netfilter/nf_tables_api.c                                   |   16 -
 net/netfilter/nft_set_pipapo.c                                  |   14 
 net/unix/af_unix.c                                              |   12 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 79 files changed, 971 insertions(+), 319 deletions(-)

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

Arınç ÜNAL (4):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Boris Burkov (1):
      btrfs: record delayed inode root in transaction

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Chuck Lever (1):
      Revert "lockd: introduce safe async lock op"

Claudiu Beznea (1):
      clk: remove extra empty line

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniel Borkmann (4):
      bpf: Generalize check_ctx_reg for reuse with other types
      bpf: Generally fix helper register offset check
      bpf: Fix out of bounds access for ringbuf helpers
      bpf: Fix ringbuf memory type confusion when passing to helpers

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

Dmitry Baryshkov (1):
      drm/panel: visionox-rm69299: don't unregister DSI device

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Gil Fine (2):
      thunderbolt: Avoid notify PM core about runtime PM resume
      thunderbolt: Fix wake configurations after device unplug

Greg Kroah-Hartman (2):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Linux 5.15.157

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Konrad Dybcio (1):
      clk: Print an info line before disabling unused clocks

Kumar Kartikeya Dwivedi (1):
      bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
      af_unix: Don't peek OOB data without MSG_OOB.

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Namjae Jeon (3):
      ksmbd: don't send oplock break if rename fails
      ksmbd: validate payload size in ipc response
      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Pablo Neira Ayuso (3):
      netfilter: br_netfilter: skip conntrack input hook for promisc packets
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple

Peter Oberparleiter (2):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Sandipan Das (1):
      KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson (1):
      KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible

Siddh Raman Pant (1):
      Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Stephen Boyd (4):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Mark 'all_lists' as const
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused

Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Vlad Buslov (1):
      netfilter: nf_flow_table: count pending offload workqueue tasks

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

Yaxiong Tian (1):
      arm64: hibernate: Fix level3 translation fault in swsusp_save()

Yuanhe Shu (1):
      selftests/ftrace: Limit length in subsystem-enable tests

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

Zack Rusin (1):
      drm/vmwgfx: Sort primary plane formats by order of preference

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

Ziyang Xuan (2):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
      netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more clearly



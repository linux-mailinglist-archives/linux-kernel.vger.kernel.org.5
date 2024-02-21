Return-Path: <linux-kernel+bounces-74757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588485D8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9151B1F243E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ECD69D2F;
	Wed, 21 Feb 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kqACK7Ms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2B3EA71;
	Wed, 21 Feb 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521080; cv=none; b=lGRABOlKFualatihAlCbqHWTP8Ey6r5MQlqSMtDHjLCyDTq/YDIOD5xM9j3EHW67ZrwHt4yawJUjt+YBxqsfZSthtQMWDpcTxfIPH4dvrh/j2vRQN9lGBfpz7AUaOYcXwlRtT132KhyVVhjWMFYLHByt9Ki4NIKVA7b5VVYXpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521080; c=relaxed/simple;
	bh=ZGIZyYClf9ciWJdodoEyZtNw9pNGBIkAOB5kzrD+5uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHl9shVh5ede25YiKA6c0V/l3fLNmXr0yqq2dfy+YbRzyLcLL7i7ENqnh8lF1A1KBYHbWX8HWoXUwDnokjOQMGsX4urSCLQiQL6YGKr7a3HCO2dxeKqdM8/IyV8bdJeS6uoF/YYb4RiH66FNVESXokjstpXlSMqnIkEdcKKUJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kqACK7Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F3CC433F1;
	Wed, 21 Feb 2024 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521080;
	bh=ZGIZyYClf9ciWJdodoEyZtNw9pNGBIkAOB5kzrD+5uM=;
	h=From:To:Cc:Subject:Date:From;
	b=kqACK7Ms/ND5flwQwppsa+VlaXGWvwpoqyNjcRP28gN0hy3kkv6ayHUyvoljLeIxS
	 QbaaDEg4QvbtcQVyR3FI+gmrSKixJl+FLvVaIPMTTIWLYQ0P3TXB12WHsZIz8zyegu
	 VBq8Z4oZ/WYOyNLH2kfVmiB++RUKal6W0AInTnAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 4.19 000/202] 4.19.307-rc1 review
Date: Wed, 21 Feb 2024 14:05:01 +0100
Message-ID: <20240221125931.742034354@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.307-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.307-rc1
X-KernelTest-Deadline: 2024-02-23T12:59+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.307 release.
There are 202 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.307-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.307-rc1

Dan Carpenter <dan.carpenter@linaro.org>
    netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Daniel Basilio <daniel.basilio@corigine.com>
    nfp: use correct macro for LengthSelect in BAR config

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix data corruption in dsync block recovery for small block sizes

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Add quirk for SWS JS201D

Steve Wahl <steve.wahl@hpe.com>
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Aleksander Mazur <deweloper@wp.pl>
    x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: improve crystal stable clock detection

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: set default value when reading clock ready bit

Vincent Donnefort <vdonnefort@google.com>
    ring-buffer: Clean ring_buffer_poll_wait() error return

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

yuan linyu <yuanlinyu@hihonor.com>
    usb: f_mass_storage: forbid async queue when shutdown happen

Oliver Neukum <oneukum@suse.com>
    USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Do not register input devices until after hid_hw_start

Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
    HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Zach O'Keefe <zokeefe@google.com>
    mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/trigger: Fix to return error if failed to alloc snapshot

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix waiting for queues of all VSIs to be disabled

Guenter Roeck <linux@roeck-us.net>
    MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path for statistics

Julian Wiedmann <jwi@linux.ibm.com>
    Documentation: net-sysfs: describe missing statistics

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Prathu Baronia <prathubaronia2011@gmail.com>
    vhost: use kzalloc() instead of kmalloc() followed by memset()

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Leonard Dallmayr <leonard.dallmayr@mailbox.org>
    USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom FM101-GL variant

JackBB Wu <wojackbb@gmail.com>
    USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Julian Wiedmann <jwi@linux.ibm.com>
    net/af_iucv: clean up a try_then_request_module()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: restrict match/target protocol to u16

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: reject unused compat flag

Eric Dumazet <edumazet@google.com>
    ppp_async: limit MRU to 64K

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

David Howells <dhowells@redhat.com>
    rxrpc: Fix response to PING RESPONSE ACKs to a dead call

Eric Dumazet <edumazet@google.com>
    inet: read sk->sk_family once in inet_recv_error()

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix out-of-bounds memory access

Loic Prylli <lprylli@netflix.com>
    hwmon: (aspeed-pwm-tacho) mutex for tach reading

Zhipeng Lu <alexious@zju.edu.cn>
    atm: idt77252: fix a memleak in open_card_ubr0

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: remove print in bond_verify_device_path

Benjamin Berg <bberg@redhat.com>
    HID: apple: Add 2021 magic keyboard FN key mapping

free5lot <mail@free5lot.com>
    HID: apple: Swap the Fn and Left Control keys on Apple keyboards

Alex Henrie <alexhenrie24@gmail.com>
    HID: apple: Add support for the 2021 Magic Keyboard

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path

Eric Dumazet <edumazet@google.com>
    af_unix: fix lockdep positive in sk_diag_dump_icons()

Zhipeng Lu <alexious@zju.edu.cn>
    net: ipv4: fix a memleak in ip_setup_cork

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger

Eric Dumazet <edumazet@google.com>
    llc: call sock_orphan() at release time

Helge Deller <deller@kernel.org>
    ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor overtemp event handling

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor returning internal error codes

Piotr Skajewski <piotrx.skajewski@intel.com>
    ixgbe: Remove non-inclusive language

Tom Rix <trix@redhat.com>
    net: remove unneeded break

Su Hui <suhui@nfschina.com>
    scsi: isci: Fix an error code problem in isci_io_request_build()

Edward Adam Davis <eadavis@qq.com>
    wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Xiubo Li <xiubli@redhat.com>
    ceph: fix deadlock or deadcode of misusing dget()

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix IO hang from sbitmap wakeup race

Zhu Yanjun <yanjun.zhu@linux.dev>
    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Ian Rogers <irogers@google.com>
    libsubcmd: Fix memory leak in uniq()

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Replace hardcoded quirk value with BIT() macro

Guilherme G. Piccoli <gpiccoli@igalia.com>
    PCI: Only override AMD USB controller if required

Peter Robinson <pbrobinson@gmail.com>
    mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Nathan Chancellor <nathan@kernel.org>
    um: net: Fix return type of uml_net_start_xmit()

Benjamin Berg <benjamin@sipsolutions.net>
    um: Don't use vfprintf() for os_info()

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Fix naming clash between UML and scheduler

Heiner Kallweit <hkallweit1@gmail.com>
    leds: trigger: panic: Don't register panic notifier if creating the trigger failed

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Let KFD sync with VM fences

Josip Pavic <josip.pavic@amd.com>
    drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()

Rob Clark <robdclark@chromium.org>
    drm/msm/dpu: Ratelimit framedone timeout msgs

Su Hui <suhui@nfschina.com>
    media: ddbridge: fix an error code problem in ddb_probe

Daniel Vacek <neelx@redhat.com>
    IB/ipoib: Fix mcast list locking

Douglas Anderson <dianders@chromium.org>
    drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: Intel: add HDA_ARL PCI ID support

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    PCI: add INTEL_HDA_ARL to pci_ids.h

Michael Tretter <m.tretter@pengutronix.de>
    media: rockchip: rga: fix swizzling for RGB formats

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    media: stk1160: Fixed high volume of stk1160_dbg messages

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/mipi-dsi: Fix detach call without attach

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/framebuffer: Fix use of uninitialized variable

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/drm_file: fix use of uninitialized variable

Jack Wang <jinpu.wang@ionos.com>
    RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Al Viro <viro@zeniv.linux.org.uk>
    fast_dput(): handle underflows gracefully

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of f2fs_reserve_new_block()

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: free beacon_ies when overridden from hidden BSS

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Zenm Chen <zenmchen@gmail.com>
    wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Alex Lyakas <alex.lyakas@zadara.com>
    md: Whenassemble the array, consult the superblock of the freshest device

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23/28: Fix the DMA controller node name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23-sansa: Use preferred i2c-gpios properties

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27-apf27dev: Fix LED name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx1: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx: Use flash@0,0 pattern

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27-eukrea: Fix RTC node name

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk3036 hdmi ports node

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Don't schedule abort twice

Hou Tao <houtao1@huawei.com>
    bpf: Add map and need_defer parameters to .map_fd_put_ptr()

Minsuk Kang <linuxlovemin@yonsei.ac.kr>
    wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix nand-controller #size-cells

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix lcdif compatible

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk

Ido Schimmel <idosch@nvidia.com>
    PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible file string name overflow when updating firmware

Baokun Li <libaokun1@huawei.com>
    ext4: avoid online resizing failures due to oversized flex bg

Baokun Li <libaokun1@huawei.com>
    ext4: remove unnecessary check from alloc_flex_gd()

Baokun Li <libaokun1@huawei.com>
    ext4: unify the type of flexbg_size to unsigned int

Ye Bin <yebin10@huawei.com>
    ext4: fix inconsistent between segment fstrim and full fstrim

Anna Schumaker <Anna.Schumaker@Netapp.com>
    SUNRPC: Fix a suspicious RCU usage warning

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix setting of fpc register

Heiko Carstens <hca@linux.ibm.com>
    s390/ptrace: handle setting of fpc register correctly

Edward Adam Davis <eadavis@qq.com>
    jfs: fix array-index-out-of-bounds in diNewExt

Oleg Nesterov <oleg@redhat.com>
    rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32/crc32 - fix parsing list of devices

Weichen Chen <weichen.chen@mediatek.com>
    pstore/ram: Fix crash when setting number of cpus to an odd number

Edward Adam Davis <eadavis@qq.com>
    jfs: fix uaf in jfs_evict_inode

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbAdjTree

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix slab-out-of-bounds Read in dtSearch

Osama Muhammad <osmtendev@gmail.com>
    UBSAN: array-index-out-of-bounds in dtSplitRoot

Osama Muhammad <osmtendev@gmail.com>
    FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree

Prarit Bhargava <prarit@redhat.com>
    ACPI: extlog: fix NULL pointer dereference check

Dmitry Antipov <dmantipov@yandex.ru>
    PNP: ACPI: fix fortify warning

Yuluo Qiu <qyl27@outlook.com>
    ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Chris Riches <chris.riches@nutanix.com>
    audit: Send netlink ACK before setting connection in auditd_set

Naveen N Rao <naveen@kernel.org>
    powerpc/lib: Validate size for vector operations

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix build error due to is_valid_bugaddr()

Kunwu Chan <chentao@kylinos.cn>
    powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    net/sched: cbs: Fix not adding cbs instance to list

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: simplify some error checking

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm: Don't unref the same fb many times by mistake due to deadlock handling

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Qu Wenruo <wqu@suse.com>
    btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

David Sterba <dsterba@suse.com>
    btrfs: don't warn if discard range is not aligned to sector

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Denis Efremov <efremov@linux.com>
    net/mlx5: Use kfree(ft->g) in arfs_create_groups()

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

Salvatore Dipietro <dipiets@amazon.com>
    tcp: Add memory barrier to tcp_push()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Ensure visibility when inserting an element into tracing_map

Sharath Srinivasan <sharath.srinivasan@oracle.com>
    net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Drop support for ETH_P_TR_802_2.

Eric Dumazet <edumazet@google.com>
    llc: make llc_ui_sendmsg() more robust against bonding changes

Lin Ma <linma@zju.edu.cn>
    vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix illegal rmb_desc access in SMC-D connection dump

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    drivers: core: fix kernel-doc markup for dev_err_probe()

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    driver code: print symbolic error code

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "driver core: Annotate dev_err_probe() with __must_check"

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    driver core: Annotate dev_err_probe() with __must_check

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    x86/CPU/AMD: Fix disabling XSAVES on AMD family 0x17 due to erratum

Nathan Chancellor <nathan@kernel.org>
    powerpc: Use always instead of always-y in for crtsavres.o

Matthew Wilcox (Oracle) <willy@infradead.org>
    block: Remove special-casing of compound pages

Dave Airlie <airlied@redhat.com>
    nouveau/vmm: don't set addr on the fail path to avoid warning

Helge Deller <deller@gmx.de>
    parisc/firmware: Fix F-extend for PDC addresses

Xiaolei Wang <xiaolei.wang@windriver.com>
    rpmsg: virtio: Free driver_override when rpmsg_remove()

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Hongchen Zhang <zhanghongchen@loongson.cn>
    PM: hibernate: Enforce ordering during image compression/decompression

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Disallow identical driver names

Suraj Jitindar Singh <surajjs@amazon.com>
    ext4: allow for the last group to be marked as trimmed

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: add check for unsupported SPI modes during probe

Oleksij Rempel <o.rempel@pengutronix.de>
    spi: introduce SPI_MODE_X_MASK macro

Andrzej Hajda <a.hajda@samsung.com>
    driver core: add device probe log helper

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: set safe default SPI clock frequency

Daniel Lezcano <daniel.lezcano@linaro.org>
    units: add the HZ macros

Daniel Lezcano <daniel.lezcano@linaro.org>
    units: change from 'L' to 'UL'

Daniel Lezcano <daniel.lezcano@linaro.org>
    units: Add Watt units

Akinobu Mita <akinobu.mita@gmail.com>
    include/linux/units.h: add helpers for kelvin to/from Celsius conversion

qizhong cheng <qizhong.cheng@mediatek.com>
    PCI: mediatek: Clear interrupt status before dispatching handler


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +--
 .../ABI/testing/sysfs-class-net-statistics         |  60 ++++---
 Documentation/sound/soc/dapm.rst                   |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   2 +-
 arch/arm/boot/dts/imx1.dtsi                        |   5 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |  12 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   4 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       |   3 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   4 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  14 +-
 arch/mips/include/asm/checksum.h                   |   3 +-
 arch/mips/kernel/elf.c                             |   6 +
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/include/asm/mmu.h                     |   4 +
 arch/powerpc/include/asm/mmzone.h                  |   3 -
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/lib/Makefile                          |   4 +-
 arch/powerpc/lib/sstep.c                           |  10 ++
 arch/powerpc/mm/init-common.c                      |   5 +-
 arch/s390/kernel/ptrace.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |   5 -
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/include/shared/kern_util.h                 |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/os-Linux/helper.c                          |   6 +-
 arch/um/os-Linux/util.c                            |  19 ++-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/include/asm/syscall_wrapper.h             |  25 ++-
 arch/x86/kernel/cpu/amd.c                          |  20 +--
 arch/x86/mm/ident_map.c                            |  23 ++-
 block/bio.c                                        |   5 +-
 block/blk-mq.c                                     |  16 ++
 crypto/algapi.c                                    |   1 +
 drivers/acpi/acpi_extlog.c                         |   5 +-
 drivers/acpi/acpi_video.c                          |   9 ++
 drivers/android/binder.c                           |  10 ++
 drivers/atm/idt77252.c                             |   2 +
 drivers/base/core.c                                |  44 +++++
 drivers/base/power/domain.c                        |   2 +-
 drivers/char/hw_random/core.c                      |  36 +++--
 drivers/clk/hisilicon/clk-hi3620.c                 |   4 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   3 +
 drivers/crypto/stm32/stm32_crc32.c                 |   2 +-
 drivers/firewire/core-device.c                     |   7 +-
 drivers/gpio/gpio-eic-sprd.c                       |  32 +++-
 drivers/gpio/gpiolib-acpi.c                        |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   6 +-
 drivers/gpu/drm/drm_file.c                         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |  17 +-
 drivers/gpu/drm/drm_plane.c                        |   1 +
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  11 ++
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/hid/hid-apple.c                            |  63 +++++++-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/wacom_sys.c                            |  63 +++++---
 drivers/hid/wacom_wac.c                            |   9 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 +
 drivers/hwmon/coretemp.c                           |  40 ++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   7 +-
 drivers/input/keyboard/atkbd.c                     |  13 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   3 +
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/md/md.c                                    |  54 +++++--
 drivers/md/raid5.c                                 |  12 --
 drivers/media/pci/ddbridge/ddbridge-main.c         |   2 +-
 drivers/media/platform/rockchip/rga/rga.c          |  15 +-
 drivers/media/usb/stk1160/stk1160-video.c          |   5 +-
 drivers/mfd/Kconfig                                |   1 +
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 +
 drivers/net/bonding/bond_alb.c                     |   3 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   1 -
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   1 -
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  36 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  61 ++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 177 ++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  44 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 105 ++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  51 +-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |  45 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 149 ++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 +--
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/fjes/fjes_hw.c                         |  37 ++++-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wan/lmc/lmc_proto.c                    |   4 -
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  12 ++
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   4 +-
 drivers/net/xen-netback/netback.c                  | 100 ++++++------
 drivers/pci/controller/pcie-mediatek.c             |  10 +-
 drivers/pci/quirks.c                               |  24 ++-
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +--
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/libfc/fc_fcp.c                        |  18 ++-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/spi/spi-ppc4xx.c                           |   5 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/tty/serial/max310x.c                       |  21 ++-
 drivers/tty/serial/sc16is7xx.c                     |   8 +-
 drivers/usb/core/hub.c                             |  34 ++--
 drivers/usb/gadget/function/f_mass_storage.c       |  20 ++-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/vhost/vhost.c                              |   5 +-
 fs/afs/server.c                                    |   7 +-
 fs/btrfs/extent-tree.c                             |   3 +-
 fs/btrfs/ioctl.c                                   |   9 ++
 fs/btrfs/send.c                                    |   2 +-
 fs/ceph/caps.c                                     |   9 +-
 fs/compat_ioctl.c                                  |   3 +-
 fs/dcache.c                                        |   7 +-
 fs/ext4/mballoc.c                                  |  26 ++-
 fs/ext4/move_extent.c                              |   6 +-
 fs/ext4/resize.c                                   |  37 +++--
 fs/f2fs/recovery.c                                 |  23 ++-
 fs/jfs/jfs_dmap.c                                  |  57 ++++---
 fs/jfs/jfs_dtree.c                                 |   7 +-
 fs/jfs/jfs_imap.c                                  |   3 +
 fs/jfs/jfs_mount.c                                 |   6 +-
 fs/nilfs2/dat.c                                    |  27 ++--
 fs/nilfs2/file.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   7 +-
 fs/nilfs2/segment.c                                |   8 +-
 fs/pstore/ram.c                                    |   1 +
 include/drm/drm_mipi_dsi.h                         |   2 +
 include/linux/bpf.h                                |   6 +-
 include/linux/device.h                             |   3 +
 include/linux/dmaengine.h                          |   3 +-
 include/linux/hrtimer.h                            |   4 +-
 include/linux/lsm_hooks.h                          |   9 ++
 include/linux/pci_ids.h                            |   1 +
 include/linux/security.h                           |   9 ++
 include/linux/spi/spi.h                            |   1 +
 include/linux/syscalls.h                           |   1 +
 include/linux/units.h                              |  92 +++++++++++
 include/net/af_unix.h                              |  20 ++-
 include/net/llc_pdu.h                              |   6 +-
 include/uapi/linux/btrfs.h                         |   3 +
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 kernel/audit.c                                     |  31 +++-
 kernel/bpf/arraymap.c                              |  12 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/map_in_map.c                            |   2 +-
 kernel/bpf/map_in_map.h                            |   2 +-
 kernel/power/swap.c                                |  38 ++---
 kernel/sched/membarrier.c                          |   6 +
 kernel/time/hrtimer.c                              |   3 +
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/tracing_map.c                         |   7 +-
 mm/page-writeback.c                                |   2 +-
 net/8021q/vlan_netlink.c                           |   4 +
 net/ipv4/af_inet.c                                 |   6 +-
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/tcp.c                                     |   1 +
 net/ipv6/addrconf_core.c                           |  21 ++-
 net/iucv/af_iucv.c                                 |  14 +-
 net/llc/af_llc.c                                   |  26 ++-
 net/llc/llc_core.c                                 |   7 -
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  20 +--
 net/netfilter/nft_byteorder.c                      |   5 +-
 net/netfilter/nft_compat.c                         |  11 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/nfc/nci/core.c                                 |   4 +
 net/rds/af_rds.c                                   |   2 +-
 net/rxrpc/conn_event.c                             |   8 +
 net/rxrpc/conn_service.c                           |   3 +-
 net/sched/sch_cbs.c                                |  30 ++--
 net/smc/smc_diag.c                                 |   2 +-
 net/sunrpc/xprtmultipath.c                         |  17 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 net/wireless/scan.c                                |   4 +
 security/security.c                                |  17 ++
 security/selinux/hooks.c                           |  28 ++++
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_conexant.c                     |  18 +++
 sound/soc/codecs/rt5645.c                          |   1 +
 tools/lib/subcmd/help.c                            |  18 ++-
 214 files changed, 1810 insertions(+), 1019 deletions(-)




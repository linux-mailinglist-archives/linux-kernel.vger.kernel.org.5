Return-Path: <linux-kernel+bounces-74875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47085DE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1C2856C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1878B73;
	Wed, 21 Feb 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2wjMfaqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8F7C6E9;
	Wed, 21 Feb 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524961; cv=none; b=gTkvTn4k8F/3lDWrcShMyZ5IkyZ6xxTR9MS97BAKIPitaG/NRX1kBJDzr+w3GzSJBoO53OsqOk/UziYkR/SrpTazIQ1diug1hSFxUstVbmaV2214K8OWsfkHt2BzgUIf8dTWzbDes/odfkR/d4tpJ9Vogr/qb7TsPPIB23y5OLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524961; c=relaxed/simple;
	bh=IXrhwkJRn4p0NgmIPr+C6RQf8PwPtY722DWuSPGjQuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SO3vlhzVuR0bfdfYYolGvF3Ph5mrTVLSo2QhLBo8QiiRgc5vZ3tl6cvgR49gEy4YjSWr53BrUmf66fkRvryuDz3DjVqzb87X22IcxR8o7v/j3kdrexrLrXXaIztDjz9GvOMCAvC4bn2RY/DpslAVBJBzS/buLO1srKhMac0Y1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2wjMfaqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F4CC433C7;
	Wed, 21 Feb 2024 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524960;
	bh=IXrhwkJRn4p0NgmIPr+C6RQf8PwPtY722DWuSPGjQuw=;
	h=From:To:Cc:Subject:Date:From;
	b=2wjMfaqMm0lHXWEGdKJTx1P2Higsuega6K0jUgRU8Y7QocVD2+WbPSfDl+Bc2o0et
	 ASGXOU5WaZiE4ztwNPC1rsl18QSU92Ix0HJF+k+Ih20r21Qco12Am4YqXvnhrW1p74
	 qOWamC4Ku5KNDuNjC9gkhb2WgzTzjvW+EUwYHBY8=
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
Subject: [PATCH 5.4 000/267] 5.4.269-rc1 review
Date: Wed, 21 Feb 2024 14:05:41 +0100
Message-ID: <20240221125940.058369148@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.269-rc1
X-KernelTest-Deadline: 2024-02-23T12:59+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.269 release.
There are 267 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.269-rc1

Frank Rowand <frank.rowand@sony.com>
    of: gpio unittest kfree() wrong object

Frank Rowand <frank.rowand@sony.com>
    of: unittest: fix EXPECT text for gpio hog errors

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Fix EEE implementation

Max Krummenacher <max.krummenacher@toradex.com>
    Revert "Revert "mtd: rawnand: gpmi: Fix setting busy timeout setting""

Dan Carpenter <dan.carpenter@linaro.org>
    netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dsi: Enable runtime PM

Douglas Anderson <dianders@chromium.org>
    PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    PM: runtime: add devm_pm_runtime_enable helper

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Missing gc cancellations fixed

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix max_mapnr being uninitialized on early stages

Mike Rapoport <rppt@linux.ibm.com>
    arch, mm: remove stale mentions of DISCONIGMEM

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Inform kmemleak of saved_cmdlines allocation

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Daniel de Villiers <daniel.devilliers@corigine.com>
    nfp: flower: prevent re-adding mac index for bonded port

Daniel Basilio <daniel.basilio@corigine.com>
    nfp: use correct macro for LengthSelect in BAR config

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix data corruption in dsync block recovery for small block sizes

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Add quirk for SWS JS201D

Alexander Stein <alexander.stein@ew.tq-group.com>
    mmc: slot-gpio: Allow non-sleeping GPIO ro

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

zhili.liu <zhili.liu@ucas.com.cn>
    iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix wasted memory in saved_cmdlines logic

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Mark all sessions as invalid in cb_remove

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Fix changing ELF file type for output of gen_btf for big endian

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Fix block process call transactions

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Remove i801_set_block_buffer_mode

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

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

Christian A. Ehrhardt <lk@c--e.de>
    of: unittest: Fix compile in the non-dynamic case

Frank Rowand <frank.rowand@sony.com>
    of: unittest: add overlay gpio test to catch gpio hog problem

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid deleting live subvol qgroup

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: skip end interval element from gc

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Simon Horman <horms@kernel.org>
    net: stmmac: xgmac: use #define for string constants

Prathu Baronia <prathubaronia2011@gmail.com>
    vhost: use kzalloc() instead of kmalloc() followed by memset()

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Leonard Dallmayr <leonard.dallmayr@mailbox.org>
    USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom FM101-GL variant

JackBB Wu <wojackbb@gmail.com>
    USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Julian Wiedmann <jwi@linux.ibm.com>
    net/af_iucv: clean up a try_then_request_module()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: reject direction for ct id

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

Paolo Abeni <pabeni@redhat.com>
    selftests: net: avoid just another constant wait

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA

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
    netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

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

Peter Zijlstra <peterz@infradead.org>
    perf: Fix the nr_addr_filters fix

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

Bjorn Helgaas <bhelgaas@google.com>
    PCI/AER: Decode Requester ID when no error info found

Max Kellermann <max.kellermann@ionos.com>
    fs/kernfs/dir: obey S_ISGID

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Replace hardcoded quirk value with BIT() macro

Daniel Stodden <dns@arista.com>
    PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Guilherme G. Piccoli <gpiccoli@igalia.com>
    PCI: Only override AMD USB controller if required

Peter Robinson <pbrobinson@gmail.com>
    mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Harshit Shah <harshitshah.opendev@gmail.com>
    i3c: master: cdns: Update maximum prescaler value for i2c clock

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

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property

Alex Lyakas <alex.lyakas@zadara.com>
    md: Whenassemble the array, consult the superblock of the freshest device

Christoph Hellwig <hch@lst.de>
    block: prevent an integer overflow in bvec_try_merge_hw_page

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23/28: Fix the DMA controller node name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23-sansa: Use preferred i2c-gpios properties

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27-apf27dev: Fix LED name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27: Pass timing0

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

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7d: Fix coresight funnel ports

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk

Ido Schimmel <idosch@nvidia.com>
    PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible file string name overflow when updating firmware

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix pyperf180 compilation failure with clang18

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: satisfy compiler by having explicit return in btf test

Shiji Yang <yangshiji66@outlook.com>
    wifi: rt2x00: restart beacon queue when hardware reset

Baokun Li <libaokun1@huawei.com>
    ext4: avoid online resizing failures due to oversized flex bg

Baokun Li <libaokun1@huawei.com>
    ext4: remove unnecessary check from alloc_flex_gd()

Baokun Li <libaokun1@huawei.com>
    ext4: unify the type of flexbg_size to unsigned int

Ye Bin <yebin10@huawei.com>
    ext4: fix inconsistent between segment fstrim and full fstrim

Gabriel Krisman Bertazi <krisman@suse.de>
    ecryptfs: Reject casefold directory inodes

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

Rui Zhang <zr.zhang@vivo.com>
    regulator: core: Only increment use_count when enable_count changes

Greg KH <gregkh@linuxfoundation.org>
    perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Zhiquan Li <zhiquan1.li@intel.com>
    x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Naveen N Rao <naveen@kernel.org>
    powerpc/lib: Validate size for vector operations

Stephen Rothwell <sfr@canb.auug.org.au>
    powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix build error due to is_valid_bugaddr()

Kunwu Chan <chentao@kylinos.cn>
    powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Kamal Dasu <kamal.dasu@broadcom.com>
    spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add documenting comment for nfsd4_release_lockowner()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Modernize nfsd4_release_lockowner()

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

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't move requests to the running list on errors

Qu Wenruo <wqu@suse.com>
    btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

David Sterba <dsterba@suse.com>
    btrfs: don't warn if discard range is not aligned to sector

Chung-Chiang Cheng <cccheng@synology.com>
    btrfs: tree-checker: fix inline ref size in error messages

Fedor Pchelkin <pchelkin@ispras.ru>
    btrfs: ref-verify: free ref cache before clearing mount opt

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFPROTO_* family

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Denis Efremov <efremov@linux.com>
    net/mlx5: Use kfree(ft->g) in arfs_create_groups()

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Use the right GVMI number for drop action

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

Salvatore Dipietro <dipiets@amazon.com>
    tcp: Add memory barrier to tcp_push()

David Howells <dhowells@redhat.com>
    afs: Hide silly-rename files from userspace

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

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    x86/CPU/AMD: Fix disabling XSAVES on AMD family 0x17 due to erratum

Nathan Chancellor <nathan@kernel.org>
    powerpc: Use always instead of always-y in for crtsavres.o

Yang Xu <xuyang2018.jy@fujitsu.com>
    fs: move S_ISGID stripping into the vfs_*() helpers

Yang Xu <xuyang2018.jy@fujitsu.com>
    fs: add mode_strip_sgid() helper

JaimeLiao <jaimeliao@mxic.com.tw>
    mtd: spinand: macronix: Fix MX35LFxGE4AD page size

Matthew Wilcox (Oracle) <willy@infradead.org>
    block: Remove special-casing of compound pages

Al Viro <viro@zeniv.linux.org.uk>
    rename(): fix the locking of subdirectories

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Dave Airlie <airlied@redhat.com>
    nouveau/vmm: don't set addr on the fail path to avoid warning

Avri Altman <avri.altman@wdc.com>
    mmc: core: Use mrq.sbc in close-ended ffu

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

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

Oleksij Rempel <linux@rempel-privat.de>
    spi: introduce SPI_MODE_X_MASK macro

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

 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +-
 Documentation/filesystems/directory-locking.rst    |  25 +-
 Documentation/filesystems/locking.rst              |   5 +-
 Documentation/filesystems/porting.rst              |  18 ++
 Documentation/sound/soc/dapm.rst                   |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   2 +-
 arch/arm/boot/dts/imx1.dtsi                        |   5 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |  12 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   4 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   4 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       |   3 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   3 -
 arch/arm/boot/dts/imx7s.dtsi                       |  10 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  14 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  21 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  32 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   8 +-
 arch/ia64/kernel/topology.c                        |   5 +-
 arch/ia64/mm/numa.c                                |   5 +-
 arch/mips/include/asm/checksum.h                   |   3 +-
 arch/mips/include/asm/mmzone.h                     |   6 -
 arch/mips/kernel/elf.c                             |   6 +
 arch/mips/mm/init.c                                |  15 +-
 arch/nds32/include/asm/memory.h                    |   6 -
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/include/asm/mmu.h                     |   4 +
 arch/powerpc/include/asm/mmzone.h                  |   3 -
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/lib/Makefile                          |   4 +-
 arch/powerpc/lib/sstep.c                           |  10 +
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +
 arch/powerpc/mm/init-common.c                      |   5 +-
 arch/s390/kernel/ptrace.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |   5 -
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/include/shared/kern_util.h                 |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/os-Linux/helper.c                          |   6 +-
 arch/um/os-Linux/util.c                            |  19 +-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/include/asm/syscall_wrapper.h             |  25 +-
 arch/x86/kernel/cpu/amd.c                          |  20 +-
 arch/x86/kernel/cpu/mce/core.c                     |  16 ++
 arch/x86/mm/ident_map.c                            |  23 +-
 arch/xtensa/include/asm/page.h                     |   4 -
 block/bio.c                                        |   9 +-
 block/blk-mq.c                                     |  16 ++
 crypto/algapi.c                                    |   1 +
 drivers/acpi/acpi_extlog.c                         |   5 +-
 drivers/acpi/acpi_video.c                          |   9 +
 drivers/android/binder.c                           |  10 +
 drivers/atm/idt77252.c                             |   2 +
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/power/runtime.c                       |  22 ++
 drivers/block/rbd.c                                |  22 +-
 drivers/bus/moxtet.c                               |   7 +
 drivers/char/hw_random/core.c                      |  36 +--
 drivers/clk/hisilicon/clk-hi3620.c                 |   4 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   3 +
 drivers/crypto/stm32/stm32-crc32.c                 |   2 +-
 drivers/dma/fsl-qdma.c                             |  27 +--
 drivers/firewire/core-device.c                     |   7 +-
 drivers/gpio/gpio-eic-sprd.c                       |  32 ++-
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
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  11 +
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/hid/hid-apple.c                            |  63 ++++-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/wacom_sys.c                            |  63 +++--
 drivers/hid/wacom_wac.c                            |   9 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 +
 drivers/hwmon/coretemp.c                           |  40 ++--
 drivers/i2c/busses/i2c-i801.c                      |  19 +-
 drivers/i3c/master/i3c-master-cdns.c               |   7 +-
 drivers/iio/magnetometer/rm3100-core.c             |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   7 +-
 drivers/input/keyboard/atkbd.c                     |  13 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +-
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/md/md.c                                    |  54 ++++-
 drivers/md/raid5.c                                 |  12 -
 drivers/media/pci/ddbridge/ddbridge-main.c         |   2 +-
 drivers/media/platform/rockchip/rga/rga.c          |  15 +-
 drivers/media/usb/stk1160/stk1160-video.c          |   5 +-
 drivers/mfd/Kconfig                                |   1 +
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 +
 drivers/mmc/core/block.c                           |  46 +++-
 drivers/mmc/core/slot-gpio.c                       |   6 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |   2 +-
 drivers/mtd/nand/spi/macronix.c                    |   2 +-
 drivers/net/bonding/bond_alb.c                     |   3 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   1 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  22 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   6 +
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   1 -
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  36 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  61 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 177 +++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  44 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 105 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  51 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |  45 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 149 ++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |   1 +
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  58 ++++-
 drivers/net/fjes/fjes_hw.c                         |  37 ++-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wan/lmc/lmc_proto.c                    |   4 -
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  11 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  12 +
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   4 +-
 drivers/net/xen-netback/netback.c                  | 100 ++++----
 drivers/of/unittest-data/Makefile                  |   8 +-
 drivers/of/unittest-data/overlay_gpio_01.dts       |  23 ++
 drivers/of/unittest-data/overlay_gpio_02a.dts      |  16 ++
 drivers/of/unittest-data/overlay_gpio_02b.dts      |  16 ++
 drivers/of/unittest-data/overlay_gpio_03.dts       |  23 ++
 drivers/of/unittest-data/overlay_gpio_04a.dts      |  16 ++
 drivers/of/unittest-data/overlay_gpio_04b.dts      |  16 ++
 drivers/of/unittest.c                              | 265 ++++++++++++++++++++-
 drivers/pci/controller/pcie-mediatek.c             |  10 +-
 drivers/pci/pcie/aer.c                             |   9 +-
 drivers/pci/quirks.c                               |  24 +-
 drivers/pci/switch/switchtec.c                     |  25 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/regulator/core.c                           |  52 ++--
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/libfc/fc_fcp.c                        |  18 +-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-ppc4xx.c                           |   5 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/tty/serial/max310x.c                       |  21 +-
 drivers/tty/serial/sc16is7xx.c                     |   8 +-
 drivers/usb/core/hub.c                             |  34 ++-
 drivers/usb/gadget/function/f_mass_storage.c       |  20 +-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/vhost/vhost.c                              |   5 +-
 fs/afs/dir.c                                       |   8 +
 fs/afs/server.c                                    |   7 +-
 fs/btrfs/extent-tree.c                             |   3 +-
 fs/btrfs/ioctl.c                                   |   9 +
 fs/btrfs/qgroup.c                                  |  14 ++
 fs/btrfs/ref-verify.c                              |   6 +-
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/ceph/caps.c                                     |   9 +-
 fs/compat_ioctl.c                                  |   3 +-
 fs/dcache.c                                        |   7 +-
 fs/ecryptfs/inode.c                                |   8 +
 fs/ext4/mballoc.c                                  |  26 +-
 fs/ext4/move_extent.c                              |   6 +-
 fs/ext4/resize.c                                   |  37 +--
 fs/f2fs/recovery.c                                 |  23 +-
 fs/inode.c                                         |  32 ++-
 fs/jfs/jfs_dmap.c                                  |  57 +++--
 fs/jfs/jfs_dtree.c                                 |   7 +-
 fs/jfs/jfs_imap.c                                  |   3 +
 fs/jfs/jfs_mount.c                                 |   6 +-
 fs/kernfs/dir.c                                    |  12 +
 fs/namei.c                                         | 144 ++++++++---
 fs/nfsd/nfs4state.c                                |  61 ++---
 fs/nilfs2/dat.c                                    |  27 ++-
 fs/nilfs2/file.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   7 +-
 fs/nilfs2/segment.c                                |   8 +-
 fs/ocfs2/namei.c                                   |   1 +
 fs/pstore/ram.c                                    |   1 +
 fs/ubifs/dir.c                                     |   2 +
 include/drm/drm_mipi_dsi.h                         |   2 +
 include/linux/bpf.h                                |   6 +-
 include/linux/dmaengine.h                          |   3 +-
 include/linux/fs.h                                 |   1 +
 include/linux/gfp.h                                |   4 +-
 include/linux/hrtimer.h                            |   4 +-
 include/linux/lsm_hooks.h                          |   9 +
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/linux/pci_ids.h                            |   1 +
 include/linux/pm_runtime.h                         |   9 +
 include/linux/security.h                           |   9 +
 include/linux/spi/spi.h                            |   1 +
 include/linux/syscalls.h                           |   1 +
 include/linux/units.h                              |  92 +++++++
 include/net/af_unix.h                              |  20 +-
 include/net/llc_pdu.h                              |   6 +-
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/uapi/linux/btrfs.h                         |   3 +
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 kernel/audit.c                                     |  31 ++-
 kernel/bpf/arraymap.c                              |  12 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/map_in_map.c                            |   2 +-
 kernel/bpf/map_in_map.h                            |   2 +-
 kernel/events/core.c                               |  38 ++-
 kernel/power/swap.c                                |  38 +--
 kernel/sched/membarrier.c                          |   9 +
 kernel/time/hrtimer.c                              |   3 +
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               |  78 +++---
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/tracing_map.c                         |   7 +-
 mm/page-writeback.c                                |   2 +-
 net/8021q/vlan_netlink.c                           |   4 +
 net/can/j1939/j1939-priv.h                         |   1 +
 net/can/j1939/socket.c                             |  22 +-
 net/core/skbuff.c                                  |   3 +-
 net/ipv4/af_inet.c                                 |   6 +-
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/tcp.c                                     |   1 +
 net/ipv6/addrconf_core.c                           |  21 +-
 net/iucv/af_iucv.c                                 |  14 +-
 net/llc/af_llc.c                                   |  26 +-
 net/llc/llc_core.c                                 |   7 -
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  39 ++-
 net/netfilter/ipset/ip_set_hash_gen.h              |  19 +-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  20 +-
 net/netfilter/nft_byteorder.c                      |   5 +-
 net/netfilter/nft_compat.c                         |  23 +-
 net/netfilter/nft_ct.c                             |  27 +++
 net/netfilter/nft_flow_offload.c                   |   5 +
 net/netfilter/nft_meta.c                           |   2 +-
 net/netfilter/nft_nat.c                            |   5 +
 net/netfilter/nft_rt.c                             |   5 +
 net/netfilter/nft_set_rbtree.c                     |   7 +-
 net/netfilter/nft_socket.c                         |   5 +
 net/netfilter/nft_synproxy.c                       |   7 +-
 net/netfilter/nft_tproxy.c                         |   5 +
 net/netfilter/nft_xfrm.c                           |   5 +
 net/netlink/af_netlink.c                           |   2 +-
 net/nfc/nci/core.c                                 |   4 +
 net/rds/af_rds.c                                   |   2 +-
 net/rxrpc/conn_event.c                             |   8 +
 net/rxrpc/conn_service.c                           |   3 +-
 net/smc/smc_diag.c                                 |   2 +-
 net/sunrpc/xprtmultipath.c                         |  17 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 net/wireless/scan.c                                |   4 +
 scripts/link-vmlinux.sh                            |   9 +-
 security/security.c                                |  17 ++
 security/selinux/hooks.c                           |  28 +++
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_conexant.c                     |  18 ++
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/rt5645.c                          |   1 +
 tools/lib/subcmd/help.c                            |  18 +-
 tools/testing/selftests/bpf/progs/pyperf180.c      |  22 ++
 tools/testing/selftests/bpf/test_btf.c             |   1 +
 tools/testing/selftests/net/pmtu.sh                |  18 +-
 virt/kvm/arm/vgic/vgic-its.c                       |   5 +
 311 files changed, 3010 insertions(+), 1335 deletions(-)




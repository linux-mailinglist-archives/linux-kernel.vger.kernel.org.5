Return-Path: <linux-kernel+bounces-30018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FCF8317B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8DA1C20AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BA23775;
	Thu, 18 Jan 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqlopR4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F1200AA;
	Thu, 18 Jan 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575594; cv=none; b=CEY5Flkke66nNXzlSlhBZC38/OJLND9PA2aJNq6wVFQZS09Y3SlSP2XSX7/fhPq7Y+YW8yj2+xl7oX0QYJKnlsKCXcl+2ZxmtJaXr2hyvILZw5vOq7r0OhspNP4tXossSq0adiVJYc+cSyswldJbHwAzeEJ4STV3zY9i0lSSe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575594; c=relaxed/simple;
	bh=kN3SU48rPOR3FxWNlBTIr7OXcSIkpGvcl6Wo/73IAVs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:User-Agent:X-stable:X-Patchwork-Hint:
	 X-KernelTest-Patch:X-KernelTest-Tree:X-KernelTest-Branch:
	 X-KernelTest-Patches:X-KernelTest-Version:X-KernelTest-Deadline:
	 Content-Type:Content-Transfer-Encoding; b=ZZbXbiYNYy1WoUonFdNzGFsmIPVRfZUX737eA7IyGrURZYPTKKcRJnFwQAhUQCE7aM758Y0FIa9uWRcAQzyfUyls9QENfBCGGspvymmpsM4Fpy64kxLKaT7z3zAL3DMPbMDrdgFYC8q0kNENObNQvexf/cfKLGbPY43f0aCLT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqlopR4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F73C433C7;
	Thu, 18 Jan 2024 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575594;
	bh=kN3SU48rPOR3FxWNlBTIr7OXcSIkpGvcl6Wo/73IAVs=;
	h=From:To:Cc:Subject:Date:From;
	b=cqlopR4TI3hXuLsCTzy6GURcdxpPiAxDYrAqcac+zkknRMeH7EKygNEpICDh2Q9J+
	 mNQBfTl4ZTK2gktiLpgW44HcgFjMEbTmjnnZMcrHj0HZjOEkavO+qgkXkpF1q7Ya1q
	 7nOiJCjRyh5pIpvoR2ZlsKGJ+5SMAytlIjVhOhB0=
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
Subject: [PATCH 6.1 000/100] 6.1.74-rc1 review
Date: Thu, 18 Jan 2024 11:48:08 +0100
Message-ID: <20240118104310.892180084@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.74-rc1
X-KernelTest-Deadline: 2024-01-20T10:43+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.74 release.
There are 100 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.74-rc1

Carlos Llamas <cmllamas@google.com>
    scripts/decode_stacktrace.sh: optionally use LLVM utilities

James Clark <james.clark@arm.com>
    coresight: etm4x: Fix width of CCITMIN field

LeoLiuoc <LeoLiu-oc@zhaoxin.com>
    PCI: Add ACS quirk for more Zhaoxin Root Ports

Florian Eckert <fe@dev.tdt.de>
    leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes device IDs and geometry

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes BAR details

Guanghui Feng <guanghuifeng@linux.alibaba.com>
    uio: Fix use-after-free in uio_open

Carlos Llamas <cmllamas@google.com>
    binder: fix comment on binder_alloc_new_buf() return value

Carlos Llamas <cmllamas@google.com>
    binder: fix trivial typo of binder_free_buf_locked()

Carlos Llamas <cmllamas@google.com>
    binder: fix use-after-free in shinker's callback

Carlos Llamas <cmllamas@google.com>
    binder: use EPOLLERR from eventpoll.h

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free ppace array on error in parse_dacl

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't allow O_TRUNC open on read-only share

Alan Maguire <alan.maguire@oracle.com>
    bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25

Martin Rodriguez Reboredo <yakoyoku@gmail.com>
    btf, scripts: Exclude Rust CUs with pahole

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Tom Jason Schwanke <tom@catboys.cloud>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Jani Nikula <jani.nikula@intel.com>
    drm/crtc: fix uninitialized variable use

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: fix return code check of of_property_match_string

Sarannya S <quic_sarannya@quicinc.com>
    net: qrtr: ns: Return 0 if server port is not present

Stefan Hajnoczi <stefanha@redhat.com>
    virtio_blk: fix snprintf truncation compiler warning

Matthew Wilcox (Oracle) <willy@infradead.org>
    ida: Fix crash in ida_free when the bitmap is empty

Patrick Rudolph <patrick.rudolph@9elements.com>
    pinctrl: cy8c95x0: Fix get_pincfg

Patrick Rudolph <patrick.rudolph@9elements.com>
    pinctrl: cy8c95x0: Fix typo

Charlene Liu <charlene.liu@amd.com>
    drm/amd/display: get dprefclk ss info from integration info table

Jensen Huang <jensenhuang@friendlyarm.com>
    i2c: rk3x: fix potential spinlock recursion on poll

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOB in smb2_dump_detail()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    HID: nintendo: Prevent divide-by-zero on code

Mike Snitzer <snitzer@kernel.org>
    dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346

Vishnu Sankar <vishnuocv@gmail.com>
    platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems

Ryan McClelland <rymcclel@gmail.com>
    HID: nintendo: fix initializer element is not constant error

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    kselftest: alsa: fixed a print formatting warning

Luca Weiss <luca@z3ntu.xyz>
    Input: xpad - add Razer Wolverine V2 support

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Vineet Gupta <vgupta@kernel.org>
    ARC: fix spare error

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/scm: fix virtual vs physical address confusion

Esther Shimanovich <eshimanovich@chromium.org>
    Input: i8042 - add nomux quirk for Acer P459-G2-M

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_GETID in translated mode

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

José Pekkarinen <jose.pekkarinen@foxhound.fi>
    Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix uaf issue when open the hist or hist_debug file

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    MIPS: dts: loongson: drop incorrect dwmac fallback compatible

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    stmmac: dwmac-loongson: drop useless check for compatible fallback

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Add size check when printing trace_marker output

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing

Ye Bin <yebin10@huawei.com>
    jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel-vbtn: Fix missing tablet-mode-switch events

Judy Hsiao <judyhsiao@chromium.org>
    neighbour: Don't let neigh_forced_gc() disable preemption for long

Ziqi Zhao <astrajoan@yahoo.com>
    drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

Zhang Yi <yi.zhang@huawei.com>
    jbd2: increase the journal IO's priority

Zhang Yi <yi.zhang@huawei.com>
    jbd2: correct the printing of write_flags in jbd2_write_superblock()

Weihao Li <cn.liweihao@gmail.com>
    clk: rockchip: rk3128: Fix HCLK_OTG gate register

Chris Morgan <macromorgan@hotmail.com>
    clk: rockchip: rk3568: Add PLL rate for 292.5MHz

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: Preserve syscall nr across execve()

Armin Wolf <W_Armin@gmx.de>
    hwmon: (corsair-psu) Fix probe when built-in

Inki Dae <inki.dae@samsung.com>
    drm/exynos: fix a wrong error checking

Xiang Yang <xiangyang3@huawei.com>
    drm/exynos: fix a potential error pointer dereference

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Add NULL checks for function pointers

Stefan Wiehler <stefan.wiehler@nokia.com>
    mips/smp: Call rcutree_report_cpu_starting() earlier

Rob Herring <robh@kernel.org>
    arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Nitesh Shetty <nj.shetty@samsung.com>
    nvme: prevent potential spectre v1 gadget

Keith Busch <kbusch@kernel.org>
    nvme: introduce helper function to get ctrl state

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: ops: add correct range check for limiting volume

David Rau <David.Rau.opensource@dm.renesas.com>
    ASoC: da7219: Support low DC impedance headset

Thinh Tran <thinhtr@linux.vnet.ibm.com>
    net/tg3: fix race condition in tg3_reset_task()

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: hdac_hda: Conditionally register dais for HDMI and Analog

Jeremy Soller <jeremy@system76.com>
    ASoC: amd: yc: Add DMI entry to support System76 Pangolin 13

Dave Airlie <airlied@redhat.com>
    nouveau/tu102: flush all pdbs on vmm flush

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5650: add mutex to avoid the jack detection failure

Maciej Strozek <mstrozek@opensource.cirrus.com>
    ASoC: cs43130: Fix incorrect frame delay configuration

Maciej Strozek <mstrozek@opensource.cirrus.com>
    ASoC: cs43130: Fix the position of const qualifier

Kamil Duljas <kamil.duljas@gmail.com>
    ASoC: Intel: Skylake: mem leak in skl register function

David Lin <CTLIN0@nuvoton.com>
    ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16

Kamil Duljas <kamil.duljas@gmail.com>
    ASoC: Intel: Skylake: Fix mem leak in few functions

Heiko Stuebner <heiko@sntech.de>
    arm64: dts: rockchip: fix rk356x pcie msg interrupt name

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: wm8974: Correct boost mixer inputs

Yicong Yang <yangyicong@hisilicon.com>
    hwtracing: hisi_ptt: Don't try to attach a task

Yicong Yang <yangyicong@hisilicon.com>
    hwtracing: hisi_ptt: Handle the interrupt in hardirq context

Keith Busch <kbusch@kernel.org>
    nvme-core: check for too small lba shift

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't count completed flush data request as inflight in case of quiesce

Dmitry Antipov <dmantipov@yandex.ru>
    smb: client, common: fix fortify warnings

Lu Yao <yaolu@kylinos.cn>
    drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer

Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
    drm/amd/display: update dcn315 lpddr pstate latency

Maurizio Lombardi <mlombard@redhat.com>
    nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps format

Johannes Berg <johannes.berg@intel.com>
    debugfs: fix automount d_fsdata usage

Ben Greear <greearb@candelatech.com>
    wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Michael-CY Lee <michael-cy.lee@mediatek.com>
    wifi: avoid offset calculation on NULL pointer

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: lock wiphy mutex for rfkill poll

Edward Adam Davis <eadavis@qq.com>
    mptcp: fix uninit-value in mptcp_incoming_options

Vasiliy Kovalev <kovalev@altlinux.org>
    ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro

Charles Keepax <ckeepax@opensource.cirrus.com>
    pinctrl: lochnagar: Don't build on MIPS

Eric Biggers <ebiggers@google.com>
    f2fs: explicitly null-terminate the xattr list


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/kernel/signal.c                           |  6 +-
 arch/arm/mach-sunxi/mc_smp.c                       |  4 +-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  3 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts  |  4 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |  2 +-
 arch/loongarch/include/asm/elf.h                   |  2 +-
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |  3 +-
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |  3 +-
 arch/mips/kernel/smp.c                             |  4 +-
 block/blk-mq.c                                     | 14 +++-
 drivers/acpi/resource.c                            |  7 ++
 drivers/android/binder.c                           |  2 +-
 drivers/android/binder_alloc.c                     | 10 ++-
 drivers/block/virtio_blk.c                         |  8 +-
 drivers/clk/rockchip/clk-rk3128.c                  |  2 +-
 drivers/clk/rockchip/clk-rk3568.c                  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c                 | 12 ++-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 19 +++--
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |  8 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |  2 +
 drivers/gpu/drm/drm_crtc.c                         |  8 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |  8 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |  2 +-
 drivers/hid/hid-nintendo.c                         | 71 +++++++++-------
 drivers/hwmon/corsair-psu.c                        | 18 +++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |  9 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 13 ++-
 drivers/input/joystick/xpad.c                      |  1 +
 drivers/input/keyboard/atkbd.c                     | 46 +++++++++-
 drivers/input/mouse/synaptics.c                    |  1 +
 drivers/input/serio/i8042-acpipnpio.h              |  8 ++
 drivers/leds/trigger/ledtrig-tty.c                 |  4 +
 drivers/md/Kconfig                                 |  1 +
 drivers/md/raid5.c                                 | 12 ---
 drivers/net/ethernet/broadcom/tg3.c                | 11 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  5 --
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/nvme/host/core.c                           | 12 ++-
 drivers/nvme/host/nvme.h                           |  5 ++
 drivers/nvme/target/configfs.c                     |  3 +
 drivers/parport/parport_serial.c                   | 64 ++++++++++++++
 drivers/pci/quirks.c                               |  8 +-
 drivers/pinctrl/cirrus/Kconfig                     |  3 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  4 +-
 drivers/platform/x86/intel/vbtn.c                  | 19 ++++-
 drivers/platform/x86/thinkpad_acpi.c               | 98 +++++++++++++++++++---
 drivers/reset/hisilicon/hi6220_reset.c             |  2 +-
 drivers/s390/block/scm_blk.c                       |  7 +-
 drivers/uio/uio.c                                  |  7 +-
 fs/debugfs/file.c                                  |  8 ++
 fs/debugfs/inode.c                                 | 27 ++++--
 fs/debugfs/internal.h                              | 10 ++-
 fs/f2fs/xattr.c                                    |  6 ++
 fs/jbd2/commit.c                                   | 10 ++-
 fs/jbd2/journal.c                                  | 24 +++---
 fs/smb/client/cifspdu.h                            | 24 +++---
 fs/smb/client/cifssmb.c                            |  6 +-
 fs/smb/client/smb2misc.c                           | 30 +++----
 fs/smb/client/smb2ops.c                            |  6 +-
 fs/smb/client/smb2pdu.c                            |  8 +-
 fs/smb/client/smb2pdu.h                            | 16 ++--
 fs/smb/common/smb2pdu.h                            | 17 ++--
 fs/smb/server/smb2pdu.c                            | 23 ++---
 fs/smb/server/smbacl.c                             | 11 ++-
 include/linux/ieee80211.h                          |  4 +-
 include/linux/jbd2.h                               |  3 +
 init/Kconfig                                       |  2 +-
 kernel/trace/ring_buffer.c                         |  6 ++
 kernel/trace/trace.c                               | 12 ++-
 kernel/trace/trace.h                               |  1 +
 kernel/trace/trace_events_hist.c                   | 12 ++-
 kernel/trace/trace_output.c                        |  6 +-
 lib/Kconfig.debug                                  |  9 ++
 lib/idr.c                                          |  2 +-
 lib/test_ida.c                                     | 40 +++++++++
 net/core/neighbour.c                               |  9 +-
 net/mac80211/ht.c                                  |  1 +
 net/mptcp/options.c                                |  1 +
 net/qrtr/ns.c                                      |  4 +-
 net/wireless/core.c                                |  2 +
 scripts/decode_stacktrace.sh                       | 19 ++++-
 scripts/pahole-flags.sh                            |  7 ++
 sound/hda/intel-nhlt.c                             | 33 +++++++-
 sound/pci/hda/patch_realtek.c                      | 16 +++-
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++
 sound/soc/codecs/cs43130.c                         |  6 +-
 sound/soc/codecs/da7219-aad.c                      |  2 +-
 sound/soc/codecs/hdac_hda.c                        | 23 ++++-
 sound/soc/codecs/nau8822.c                         |  9 +-
 sound/soc/codecs/rt5645.c                          | 10 ++-
 sound/soc/codecs/wm8974.c                          |  6 +-
 sound/soc/intel/boards/bytcr_rt5640.c              | 31 +++++--
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |  2 +
 sound/soc/intel/skylake/skl-pcm.c                  |  9 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |  4 +-
 sound/soc/soc-ops.c                                |  2 +-
 sound/soc/sof/intel/hda-codec.c                    | 18 ++--
 tools/testing/selftests/alsa/mixer-test.c          |  2 +-
 103 files changed, 843 insertions(+), 286 deletions(-)




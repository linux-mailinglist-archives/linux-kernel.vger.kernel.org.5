Return-Path: <linux-kernel+bounces-155937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A68AFA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD771C22ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C7143C46;
	Tue, 23 Apr 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gl+geBcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FD1420BE;
	Tue, 23 Apr 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908683; cv=none; b=N9YBf76tmvcCuF5iTjIMfRO5QMIpy6TIisDtlYc8z85wozIC997GaqbtyAldMFqj+cz4oNjg3ZWm3IoWaJuhi13zfwQgPrQjFezp8kHca/OBp15x+N04qr8c+GYkbn73lua008gdiYP3xUQZb7ujxV75q1+fVwrRV94g5irSPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908683; c=relaxed/simple;
	bh=AIvTOi+1zbBQwKQZZi9mhHfuVm1rlPDrwIwbQNsO+RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVMpfX6EBqWDLParGoQgHs80jSItGy6BC1X0DKzAHHdINoDmh1PsfTfoEq6vuGb6N1EZOdvLIA8ZtIxr6hSrkorPdS3NaD17/R8iSyar02qOMs6BcH/tlHyFE7Hz+CAUWQfb9mZWsf2LtbV6h2NFRe+Q2vvBgTAq2UDBrzQVMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gl+geBcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F23DC116B1;
	Tue, 23 Apr 2024 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908683;
	bh=AIvTOi+1zbBQwKQZZi9mhHfuVm1rlPDrwIwbQNsO+RU=;
	h=From:To:Cc:Subject:Date:From;
	b=Gl+geBcP77tvfB5xq3xBbC4WV2vk0I4sLcmQRpK/z6ZB9lgnBNZEklbzwSpCLK9eM
	 P6aJh7g/YMhhcvxlMQOR5Z1pt22rGTEpG8j3RhEhdpN+4AIXNocBuwA2P3vT51+93V
	 8tpGnbnc4CLyhxyg6cPHlvVtruCdAGNaYNllSOxQ=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.1 000/141] 6.1.88-rc1 review
Date: Tue, 23 Apr 2024 14:37:48 -0700
Message-ID: <20240423213853.356988651@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.88-rc1
X-KernelTest-Deadline: 2024-04-25T21:38+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.88 release.
There are 141 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.88-rc1

Johan Hovold <johan+linaro@kernel.org>
    PCI/ASPM: Fix deadlock when enabling ASPM

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate request buffer size in smb2_allocate_rsp_buf()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530

Vladimir Oltean <olteanv@gmail.com>
    net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP

Jeongjun Park <aha310510@gmail.com>
    nilfs2: fix OOB in nilfs_set_de_type

Qiang Zhang <qiang4.zhang@intel.com>
    bootconfig: use memblock_free_late to free xbc memory to buddy

Dave Airlie <airlied@redhat.com>
    nouveau: fix instmem race condition around ptr stores

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix crtc's atomic check conditional

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Sort primary plane formats by order of preference

xinhui pan <xinhui.pan@amd.com>
    drm/amdgpu: validate the parameters of bo mapping operations more clearly

Miaohe Lin <linmiaohe@huawei.com>
    mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled

Yuntao Wang <ytcoode@gmail.com>
    init/main.c: Fix potential static_command_line memory overflow

Yaxiong Tian <tianyaxiong@kylinos.cn>
    arm64: hibernate: Fix level3 translation fault in swsusp_save()

Sandipan Das <sandipan.das@amd.com>
    KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson <seanjc@google.com>
    KVM: x86/pmu: Disable support for adaptive PEBS

Sean Christopherson <seanjc@google.com>
    KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible

Alan Stern <stern@rowland.harvard.edu>
    fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Avoid crash on very long word

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: disable RPL-S on SPS and IGN firmwares

Norihiko Hama <Norihiko.Hama@alpsalpine.com>
    usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Kai-Heng Feng <kai.heng.feng@canonical.com>
    usb: Disable USB3 LPM at shutdown

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "usb: cdc-wdm: close race between read and workqueue"

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit FN920C04 rmnet compositions

Vanillan Wang <vanillanwang@163.com>
    USB: serial: option: add Rolling RW101-GL and RW135-GL support

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: support Quectel EM060K sub-models

Coia Prant <coiaprant@gmail.com>
    USB: serial: option: add Lonsung U8300/U9300 product

Chuanhong Guo <gch981213@gmail.com>
    USB: serial: option: add support for Fibocom FM650/FG650

bolan wang <bolan.wang@fibocom.com>
    USB: serial: option: add Fibocom FM135-GL variants

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Reset .throttled state in .startup()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Return IRQ_NONE in the ISR if no handling happend

Finn Thain <fthain@linux-m68k.org>
    serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Emil Kronborg <emil.kronborg@protonmail.com>
    serial: mxs-auart: add spinlock around changing cts state

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    comedi: vmk80xx: fix incomplete endpoint checking

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix wake configurations after device unplug

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Avoid notify PM core about runtime PM resume

Carlos Llamas <cmllamas@google.com>
    binder: check offset alignment in binder_get_object()

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC

Eric Biggers <ebiggers@google.com>
    x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI retpoline check

Pin-yen Lin <treapking@chromium.org>
    clk: mediatek: Do a runtime PM get on controllers during probe

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mux: Propagate struct device for mtk-mux

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mtk: Propagate struct device for composites

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: mt8192: Propagate struct device for gate clocks

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: mt8192: Correctly unregister and free clocks on failure

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree for clk_summary

Vishal Badole <badolevishal1116@gmail.com>
    clk: Show active consumers of clocks in debugfs

Yu Zhe <yuzhe@nfschina.com>
    clk: remove unnecessary (void*) conversions

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree during disable_unused

Stephen Boyd <sboyd@kernel.org>
    clk: Initialize struct clk_core kref earlier

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: Print an info line before disabling unused clocks

Stephen Boyd <sboyd@kernel.org>
    clk: Remove prepare_lock hold assertion in __clk_release()

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: new quirk to reduce the SET_ADDRESS request timeout

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: xhci: Add timeout argument in address_device USB HCD callback

Brenton Simpson <appsforartists@google.com>
    drm: panel-orientation-quirks: Add quirk for Lenovo Legion Go

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Rename scarlett_gen2 to scarlett2

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()

Bjorn Helgaas <bhelgaas@google.com>
    PCI/DPC: Use FIELD_GET()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add Focusrite Clarett 2Pre and 4Pre USB support

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre support

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add correct product series name to messages

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Default mixer driver to enabled

Niklas Schnelle <schnelle@linux.ibm.com>
    usb: pci-quirks: group AMD specific quirk code together

Linus Walleij <linus.walleij@linaro.org>
    ASoC: ti: Convert Pandora ASoC to GPIO descriptors

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add support for Clarett 8Pre USB

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Move USB IDs out from device_info struct

Rob Herring <robh@kernel.org>
    ARM: davinci: Drop unused includes

Kelvin Cao <kelvin.cao@microchip.com>
    PCI: switchtec: Add support for PCIe Gen5 devices

Kelvin Cao <kelvin.cao@microchip.com>
    PCI: switchtec: Use normal comment style

Niklas Schnelle <schnelle@linux.ibm.com>
    PCI: Make quirk using inw() depend on HAS_IOPORT

Maciej W. Rozycki <macro@orcam.me.uk>
    PCI: Execute quirk_enable_clear_retrain_link() earlier

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Add debug log for link controller power quirk

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Log function name of the called quirk

Arnd Bergmann <arnd@arndb.de>
    x86/quirks: Include linux/pnp.h for arch_pnpbios_disabled()

Mike Pastore <mike@oobak.org>
    PCI: Delay after FLR of Solidigm P44 Pro NVMe

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: pci-quirks: Reduce the length of a spinlock section in usb_amd_find_chipset_info()

David Yang <mmyangfl@gmail.com>
    HID: kye: Sort kye devices

Alvaro Karsz <alvaro.karsz@solid-run.com>
    PCI: Avoid FLR for SolidRun SNET DPU rev 1

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    ARM: OMAP2+: pdata-quirks: stop including wl12xx.h

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    ARM: omap2: n8x0: stop instantiating codec platform data

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: visionox-rm69299: don't unregister DSI device

Mikhail Kobuk <m.kobuk@ispras.ru>
    drm: nv04: Fix out of bounds access

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix race condition during online processing

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/qdio: handle deferred cc1

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Print the old state when cm_destroy_id gets timeout

Yanjun.Zhu <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the problem "mutex_destroy missing"

Siddharth Vadapalli <s-vadapalli@ti.com>
    net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix mirroring frames received on local port

Lei Chen <lei.chen@smartx.com>
    tun: limit printing rate when illegal packet received by tun dev

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: tc: allow zero flags in parsing tc flower

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: Prevent deadlock while disabling aRFS

Shay Drory <shayd@nvidia.com>
    net/mlx5: Lag, restore buckets number to default after hash LAG deactivation

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Don't peek OOB data without MSG_OOB.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Call manage_oob() for every skb in unix_stream_read_generic().

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: incorrect pppoe tuple

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: validate pppoe header

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: do not free live element

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: br_netfilter: skip conntrack input hook for promisc packets

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Remap kernel text read-only before dropping NX attribute

Ard Biesheuvel <ardb@kernel.org>
    x86/sev: Move early startup code into .head.text section

Ard Biesheuvel <ardb@kernel.org>
    x86/sme: Move early SME kernel encryption handling into .head.text

Hou Wenlong <houwenlong.hwl@antgroup.com>
    x86/head/64: Move the __head definition to <asm/init.h>

Hou Wenlong <houwenlong.hwl@antgroup.com>
    x86/head/64: Add missing __head annotation to startup_64_load_idt()

Pasha Tatashin <pasha.tatashin@soleen.com>
    x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Increase section and file alignment to 4k/512

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Split off PE/COFF .data section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop PE/COFF .reloc section

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Construct PE/COFF .text section from assembler

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Derive file size from _edata symbol

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Define setup size in linker script

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Set EFI handover offset directly in header asm

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Grab kernel_info offset from zoffset header directly

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop references to startup_64

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Drop redundant code setting the root device

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Omit compression buffer from PE/COFF image memory footprint

Ard Biesheuvel <ardb@kernel.org>
    x86/boot: Remove the 'bugger off' message

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Drop alignment flags from PE section headers

Ard Biesheuvel <ardb@kernel.org>
    x86/efistub: Reinstate soft limit for initrd loading

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Disregard setup header of loaded image

Ard Biesheuvel <ardb@kernel.org>
    x86/efi: Drop EFI stub .bss from .data section

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/i915/vma: Fix UAF on destroy against retire race

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid writing the mac address before first reading

Jason A. Donenfeld <Jason@zx2c4.com>
    random: handle creditable entropy from atomic process context

Yuanhe Shu <xiangzao@linux.alibaba.com>
    selftests/ftrace: Limit length in subsystem-enable tests

Steven Rostedt (Google) <rostedt@goodmis.org>
    SUNRPC: Fix rpcgss_context trace event acceptor field

Alexey Izbyshev <izbyshev@ispras.ru>
    io_uring: Fix io_cqring_wait() not restoring sigmask on get_timespec64() failure

Dillon Varone <dillon.varone@amd.com>
    drm/amd/display: Do not recursively call manual trigger programming

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix incorrect number of active RBs for gfx11

Hawking Zhang <Hawking.Zhang@amd.com>
    drm/amdgpu: fix incorrect active rb bitmap for gfx11

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Enable DMA mappings with SEV


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 MAINTAINERS                                        |   2 +-
 Makefile                                           |   4 +-
 arch/arm/mach-davinci/pdata-quirks.c               |   2 +-
 arch/arm/mach-omap2/board-n8x0.c                   |   5 -
 arch/arm/mach-omap2/common-board-devices.h         |   2 -
 arch/arm/mach-omap2/pdata-quirks.c                 |  12 +-
 arch/arm64/mm/pageattr.c                           |   3 -
 arch/x86/boot/Makefile                             |   2 +-
 arch/x86/boot/compressed/Makefile                  |   2 +-
 arch/x86/boot/compressed/misc.c                    |   1 +
 arch/x86/boot/compressed/sev.c                     |   3 +
 arch/x86/boot/compressed/vmlinux.lds.S             |   6 +-
 arch/x86/boot/header.S                             | 211 +++++++---------
 arch/x86/boot/setup.ld                             |  14 +-
 arch/x86/boot/tools/build.c                        | 273 +--------------------
 arch/x86/include/asm/boot.h                        |   1 +
 arch/x86/include/asm/init.h                        |   2 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/mem_encrypt.h                 |   8 +-
 arch/x86/include/asm/page_types.h                  |  12 +-
 arch/x86/include/asm/sev.h                         |  10 +-
 arch/x86/kernel/amd_gart_64.c                      |   2 +-
 arch/x86/kernel/cpu/bugs.c                         |  11 +-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   6 +-
 arch/x86/kernel/head64.c                           |   7 +-
 arch/x86/kernel/platform-quirks.c                  |   1 +
 arch/x86/kernel/sev-shared.c                       |  23 +-
 arch/x86/kernel/sev.c                              |  11 +-
 arch/x86/kvm/cpuid.c                               |   1 +
 arch/x86/kvm/cpuid.h                               |  10 +
 arch/x86/kvm/lapic.c                               |   3 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/vmx/vmx.c                             |  24 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 arch/x86/mm/mem_encrypt_boot.S                     |   4 +-
 arch/x86/mm/mem_encrypt_identity.c                 |  58 ++---
 arch/x86/mm/pat/set_memory.c                       |   6 +-
 arch/x86/mm/pti.c                                  |   2 +-
 drivers/accessibility/speakup/main.c               |   2 +-
 drivers/android/binder.c                           |   4 +-
 drivers/char/random.c                              |  10 +-
 drivers/clk/clk.c                                  | 201 +++++++++++----
 drivers/clk/mediatek/clk-gate.c                    |  23 +-
 drivers/clk/mediatek/clk-gate.h                    |   7 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |   4 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |   4 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |   2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |   4 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt2701.c                  |  22 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt2712.c                  |  24 +-
 drivers/clk/mediatek/clk-mt6765.c                  |  13 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt6779.c                  |  21 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c         |   3 +-
 drivers/clk/mediatek/clk-mt6795-mm.c               |   3 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c          |   6 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |   6 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt6797.c                  |   7 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |   4 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |   8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |   8 +-
 drivers/clk/mediatek/clk-mt7622.c                  |  22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |   7 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |   8 +-
 drivers/clk/mediatek/clk-mt7629.c                  |  18 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |  10 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |   7 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |   3 +-
 drivers/clk/mediatek/clk-mt8135.c                  |  18 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |   2 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |   2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |   2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |   3 +-
 drivers/clk/mediatek/clk-mt8167.c                  |  12 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt8173.c                  |  34 +--
 drivers/clk/mediatek/clk-mt8183-audio.c            |   4 +-
 drivers/clk/mediatek/clk-mt8183-mm.c               |   4 +-
 drivers/clk/mediatek/clk-mt8183.c                  |  36 +--
 drivers/clk/mediatek/clk-mt8186-mcu.c              |   3 +-
 drivers/clk/mediatek/clk-mt8186-mm.c               |   3 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |   9 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |   3 +-
 drivers/clk/mediatek/clk-mt8192-mm.c               |   3 +-
 drivers/clk/mediatek/clk-mt8192.c                  |  88 +++++--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |   3 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   9 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |   3 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |   3 +-
 drivers/clk/mediatek/clk-mt8365-mm.c               |   5 +-
 drivers/clk/mediatek/clk-mt8365.c                  |  14 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |   2 +-
 drivers/clk/mediatek/clk-mt8516.c                  |  12 +-
 drivers/clk/mediatek/clk-mtk.c                     | 127 +++++++++-
 drivers/clk/mediatek/clk-mtk.h                     |  13 +-
 drivers/clk/mediatek/clk-mux.c                     |  14 +-
 drivers/clk/mediatek/clk-mux.h                     |   3 +-
 drivers/comedi/drivers/vmk80xx.c                   |  35 +--
 drivers/firmware/efi/libstub/Makefile              |   7 -
 drivers/firmware/efi/libstub/x86-stub.c            |  58 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  72 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  80 ++++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   3 -
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/i915/i915_vma.c                    |  42 +++-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |  13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   7 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   4 +-
 drivers/hid/hid-ids.h                              |   2 +-
 drivers/hid/hid-kye.c                              |  66 ++---
 drivers/hid/hid-quirks.c                           |   6 +-
 drivers/infiniband/core/cm.c                       |  11 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +-
 drivers/net/dsa/mt7530.c                           |  58 +++--
 drivers/net/dsa/mt7530.h                           |   6 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   4 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  18 ++
 drivers/net/tun.c                                  |  18 +-
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/pci/bus.c                                  |  49 ++--
 drivers/pci/pci.c                                  |  78 ++++--
 drivers/pci/pci.h                                  |   4 +-
 drivers/pci/pcie/aspm.c                            |  21 +-
 drivers/pci/pcie/dpc.c                             |   5 +-
 drivers/pci/quirks.c                               |  70 +++++-
 drivers/pci/switch/switchtec.c                     | 158 +++++++-----
 drivers/s390/cio/device.c                          |  13 +-
 drivers/s390/cio/qdio_main.c                       |  28 ++-
 drivers/thunderbolt/quirks.c                       |   2 +
 drivers/thunderbolt/switch.c                       |  50 +++-
 drivers/thunderbolt/tb.c                           |   4 +-
 drivers/thunderbolt/tb.h                           |   3 +-
 drivers/thunderbolt/usb4.c                         |  13 +-
 drivers/tty/serial/mxs-auart.c                     |   8 +-
 drivers/tty/serial/pmac_zilog.c                    |  14 --
 drivers/tty/serial/stm32-usart.c                   |  13 +-
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/hub.c                             |  15 +-
 drivers/usb/core/port.c                            |   4 +-
 drivers/usb/core/quirks.c                          |   7 +
 drivers/usb/dwc2/hcd_ddma.c                        |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |   4 +-
 drivers/usb/host/pci-quirks.c                      | 123 +++++-----
 drivers/usb/host/pci-quirks.h                      |  14 +-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci-ring.c                       |  11 +-
 drivers/usb/host/xhci.c                            |  23 +-
 drivers/usb/host/xhci.h                            |   9 +-
 drivers/usb/serial/option.c                        |  40 +++
 fs/nilfs2/dir.c                                    |   2 +-
 fs/smb/common/smb2pdu.h                            |   2 +-
 fs/smb/server/server.c                             |  13 +-
 fs/smb/server/smb2pdu.c                            |   4 +
 fs/smb/server/vfs.c                                |   5 +
 fs/sysfs/file.c                                    |   2 +
 include/linux/bootconfig.h                         |   7 +-
 include/linux/pci.h                                |   5 +
 include/linux/pci_ids.h                            |   2 +
 include/linux/switchtec.h                          |   1 +
 include/linux/usb/hcd.h                            |   5 +-
 include/linux/usb/quirks.h                         |   3 +
 include/net/dsa.h                                  |   8 +
 include/net/netfilter/nf_flow_table.h              |  12 +-
 include/trace/events/rpcgss.h                      |   4 +-
 include/uapi/linux/pci_regs.h                      |   1 +
 init/main.c                                        |   2 +
 io_uring/io_uring.c                                |  16 +-
 lib/bootconfig.c                                   |  19 +-
 mm/memory-failure.c                                |  18 +-
 net/bridge/br_input.c                              |  15 +-
 net/bridge/br_netfilter_hooks.c                    |   6 +
 net/bridge/br_private.h                            |   1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |  14 +-
 net/dsa/dsa2.c                                     |  24 +-
 net/netfilter/nf_flow_table_inet.c                 |   3 +-
 net/netfilter/nf_flow_table_ip.c                   |  10 +-
 net/netfilter/nf_tables_api.c                      |  16 +-
 net/netfilter/nft_set_pipapo.c                     |  14 +-
 net/unix/af_unix.c                                 |  12 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/ti/omap3pandora.c                        |  63 ++---
 sound/usb/Makefile                                 |   2 +-
 sound/usb/mixer_quirks.c                           |   9 +-
 .../{mixer_scarlett_gen2.c => mixer_scarlett2.c}   | 257 +++++++++++++------
 sound/usb/mixer_scarlett2.h                        |   7 +
 sound/usb/mixer_scarlett_gen2.h                    |   7 -
 .../ftrace/test.d/event/subsystem-enable.tc        |   6 +-
 199 files changed, 2147 insertions(+), 1497 deletions(-)




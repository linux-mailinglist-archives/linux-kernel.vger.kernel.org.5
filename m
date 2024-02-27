Return-Path: <linux-kernel+bounces-83365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C9869581
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FE28E5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751413B2B8;
	Tue, 27 Feb 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUoLsY/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D478B61;
	Tue, 27 Feb 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042545; cv=none; b=C/BqrfPF+DZzx2kbjlA5lymZQAQVDzcKLHfrRnrn5S42IIIM1OpvpBBVb0BPAUGgk2W8kyLKQ2avH8RI1ij0Sz1bjnz1e1zrvCBzofHm1zYBDATZ8jdb+DflGh+bMbjaTb/8JfcBzjxGFI9nBl8Far8LN5p8GTnuuKgmwhY4FfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042545; c=relaxed/simple;
	bh=HNuQUvNJ+PqAWpIrB65rEkVDQt4fkFyOBYZseIgKEfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqzCrwqoCFcKSLQgsxaI8OQKWD0v+Bg+ySMkO8K6ExUrKNlkAYQXd+ACx7E2qN/i4q3yikKa1SkBnDLVj2PsQ2oSuDsdaJBZP6BIwljam7R965m66qYFTSsIcnNO2o/UeWsbvQzyGEPh4QgJ1Dyr/PUPSYTRJQtPIXpAhdEqQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUoLsY/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5A8C433F1;
	Tue, 27 Feb 2024 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042544;
	bh=HNuQUvNJ+PqAWpIrB65rEkVDQt4fkFyOBYZseIgKEfE=;
	h=From:To:Cc:Subject:Date:From;
	b=eUoLsY/N8ZWEyXTFCYwAgZXP+HLeQugv2ZjEG6R2yW7BlaBFE74m1BFLHTlPgvZnw
	 iro7x979M50ZJ1dqp/2AVFsGD9DK7MptzDlOH6xa2XuUBIhhhgHIzYEh77M3b31BVM
	 Yy2U9VvfSSrnN2CmTCAzJc9kTUssDNGBdYlSkrz8=
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
Subject: [PATCH 5.15 000/245] 5.15.150-rc1 review
Date: Tue, 27 Feb 2024 14:23:08 +0100
Message-ID: <20240227131615.098467438@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.150-rc1
X-KernelTest-Deadline: 2024-02-29T13:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.150 release.
There are 245 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.150-rc1

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: can't schedule in nft_chain_validate

Baokun Li <libaokun1@huawei.com>
    ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Baokun Li <libaokun1@huawei.com>
    ext4: regenerate buddy after block freeing failed if under fc replay

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix scheduling-while-atomic splat

Kuniyuki Iwashima <kuniyu@amazon.com>
    arp: Prevent overflow in arp_req_get().

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Shyam Prasad N <nspmangalore@gmail.com>
    cifs: fix mid leak during reconnection after timeout threshold

Corey Minyard <minyard@acm.org>
    i2c: imx: when being a target, mark the last read as processed

Corey Minyard <minyard@acm.org>
    i2c: imx: Add timer for handling the stop condition

Armin Wolf <W_Armin@gmx.de>
    drm/amd/display: Fix memory leak in dm_sw_fini()

Erik Kurzinger <ekurzinger@nvidia.com>
    drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_flow_offload: release dst in case direct xmit path is used

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_flow_offload: reset dst in route object after setting up flow

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: simplify route logic

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: set dormant flag on hook register failure

Sabrina Dubroca <sd@queasysnail.net>
    tls: stop recv() if initial process_rx_list gave us non-DATA

Jakub Kicinski <kuba@kernel.org>
    tls: rx: drop pointless else after goto

Jakub Kicinski <kuba@kernel.org>
    tls: rx: jump to a more appropriate label

Jason Gunthorpe <jgg@ziepe.ca>
    s390: use the correct count for __iowrite64_copy()

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-af: Consider the action set by PF

Guo Zhengkui <guozhengkui@vivo.com>
    drm/nouveau/instmem: fix uninitialized_var.cocci warning

Kees Cook <keescook@chromium.org>
    net: dev: Convert sa_data to flexible array in struct sockaddr

Wolfram Sang <wsa+renesas@sang-engineering.com>
    packet: move from strlcpy with unused retval to strscpy

Vasiliy Kovalev <kovalev@altlinux.org>
    ipv6: sr: fix possible use-after-free and null-ptr-deref

Daniil Dulov <d.dulov@aladdin.ru>
    afs: Increase buffer size in afs_update_volume_status()

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
    ata: ahci_ceva: fix error handling for Xilinx GT PHY support

Serge Semin <Sergey.Semin@baikalelectronics.ru>
    ata: libahci_platform: Introduce reset assertion/deassertion methods

Serge Semin <Sergey.Semin@baikalelectronics.ru>
    ata: libahci_platform: Convert to using devm bulk clocks API

Eric Dumazet <edumazet@google.com>
    ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Eric Dumazet <edumazet@google.com>
    ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid

Pavel Sakharov <p.sakharov@ispras.ru>
    net: stmmac: Fix incorrect dereference in interrupt handlers

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warnings

Randy Dunlap <rdunlap@infradead.org>
    scsi: jazz_esp: Only build if SCSI core is builtin

Gianmarco Lusvardi <glusvardi@posteo.net>
    bpf, scripts: Correct GPL license name

Arnd Bergmann <arnd@arndb.de>
    RDMA/srpt: fix function pointer cast warnings

Heiko Stuebner <heiko.stuebner@cherry.de>
    arm64: dts: rockchip: set num-cs property for spi on px30

Kamal Heib <kheib@redhat.com>
    RDMA/qedr: Fix qedr_create_user_qp error flow

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Support specifying the srpt_service_guid parameter

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Add AE for too many RNRS

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Set the CQ read threshold for GEN 1

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Validate max_send_wr and max_recv_wr

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Fix KASAN issue with tasklet

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return error for SRQ resize

Zhipeng Lu <alexious@zju.edu.cn>
    IB/hfi1: Fix a memleak in init_credit_return

Shyam Prasad N <sprasad@microsoft.com>
    cifs: add a warning when the in-flight count goes negative

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: track port suspend state correctly in unsuccessful resume cases

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: decouple usb2 port resume and get_port_status request handling

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: clear usb2 resume related variables in one place.

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: rename resume_done to resume_timestamp

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: move port specific items such as state completions to port structure

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: cleanup xhci_hub_control port references

Paul Menzel <pmenzel@molgen.mpg.de>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA

Tamim Khan <tamim@fusetak.com>
    ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks

Tamim Khan <tamim@fusetak.com>
    ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA

Kellen Renshaw <kellen.renshaw@canonical.com>
    ACPI: resource: Add ASUS model S5402ZA to quirks

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch

Alex Bee <knaerzche@gmail.com>
    arm64: dts: rockchip: add SPDIF node for ROCK Pi 4

Alex Bee <knaerzche@gmail.com>
    arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4

FUKAUMI Naoki <naoki@radxa.com>
    arm64: dts: rockchip: fix regulator name on rk3399-rock-4

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: support dynamic allocate bh for exfat_entry_set_cache

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: avoid baid size integer overflow

Ying Hsu <yinghsu@chromium.org>
    igb: Fix igb_down hung on surprise removal

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Petr Oros <poros@redhat.com>
    devlink: report devlink_port_type_warn source device

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Address KCSAN report on bpf_lru_list

Maxime Bizon <mbizon@freebox.fr>
    wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Yicong Yang <yangyicong@hisilicon.com>
    sched/fair: Don't balance task to its current running CPU

Mark Rutland <mark.rutland@arm.com>
    arm64: mm: fix VA-range sanity check

Youngmin Nam <youngmin.nam@samsung.com>
    arm64: set __exception_irq_entry with __irq_entry as a default

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3

Hans de Goede <hdegoede@redhat.com>
    ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A

David Sterba <dsterba@suse.com>
    btrfs: add xxhash to fast checksum implementations

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Ensure timer ID search-loop limit is valid

Yu Kuai <yukuai3@huawei.com>
    md/raid10: prevent soft lockup while flush writes

Yu Kuai <yukuai3@huawei.com>
    md: fix data corruption for raid456 when reshape restart while grow up

Zhong Jinghua <zhongjinghua@huawei.com>
    nbd: Add the maximum limit of allocated index in nbd_dev_add

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    debugobjects: Recheck debug_objects_enabled before reporting

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: add rescheduling points during loop detection walks

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs

Jeff LaBundy <jeff@labundy.com>
    Input: iqs269a - do not poll during ATI

Jeff LaBundy <jeff@labundy.com>
    Input: iqs269a - do not poll during suspend or resume

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Input: iqs269a - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()

Paul Cercueil <paul@crapouillou.net>
    PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro

Paul Cercueil <paul@crapouillou.net>
    mmc: mxc: Use the new PM macros

Paul Cercueil <paul@crapouillou.net>
    mmc: jz4740: Use the new PM macros

Paul Cercueil <paul@crapouillou.net>
    PM: core: Add new *_PM_OPS macros, deprecate old ones

Paul Cercueil <paul@crapouillou.net>
    PM: core: Redefine pm_ptr() macro

Ganesh Goudar <ganeshgr@linux.ibm.com>
    powerpc/eeh: Set channel state after notifying the drivers

Daniel Axtens <dja@axtens.net>
    powerpc/eeh: Small refactor of eeh_handle_normal_event()

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas: ensure 4KB alignment for rtas_data_buf

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas: make all exports GPL

Wang Qing <wangqing@vivo.com>
    net: ethernet: ti: add missing of_node_put before return

Li Jun <jun.li@nxp.com>
    dt-bindings: clocks: imx8mp: Add ID for usb suspend clock

Lucas Stach <l.stach@pengutronix.de>
    clk: imx8mp: add clkout1/2 support

Marek Vasut <marex@denx.de>
    clk: imx8mp: Add DISP2 pixel clock

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Remove serial_rs485 sanitization from em485

Enzo Matsumiya <ematsumiya@suse.de>
    cifs: remove useless parameter 'is_fsctl' from SMB2_ioctl()

Hui Su <suhui_kernel@163.com>
    kernel/sched: Remove dl_boosted flag comment

Chuansheng Liu <chuansheng.liu@intel.com>
    drm/i915/dg1: Update DMC_DEBUG3 register

Byungki Lee <dominicus79@gmail.com>
    f2fs: write checkpoint during FG_GC

Chao Yu <chao@kernel.org>
    f2fs: don't set GC_FAILURE_PIN for background GC

Yifan Zhang <yifan1.zhang@amd.com>
    drm/amdgpu: init iommu after amdkfd device init

Stefano Garzarella <sgarzare@redhat.com>
    tools/virtio: fix build

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf beauty: Update copy of linux/socket.h with the kernel sources

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools headers UAPI: Sync linux/fscrypt.h with the kernel sources

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger

Sakari Ailus <sakari.ailus@linux.intel.com>
    acpi: property: Let args be NULL in __acpi_node_get_property_reference

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute

Randy Dunlap <rdunlap@infradead.org>
    clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Correct wrong debug message

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Balance the reference of cep->kref in the error path

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent #usb-cells

Magali Lemes <magali.lemes@canonical.com>
    selftests: net: vrf-xfrm-tests: change authentication and encryption algos

Eli Cohen <elic@nvidia.com>
    vdpa/mlx5: Don't clear mr struct on destroy MR

Randy Dunlap <rdunlap@infradead.org>
    MIPS: vpe-mt: drop physical_memsize

Randy Dunlap <rdunlap@infradead.org>
    MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not set

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/pseries/lpar: add missing RTAS retry status handling

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/perf/hv-24x7: add missing RTAS retry status handling

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/pseries/lparcfg: add missing RTAS retry status handling

Chen-Yu Tsai <wenst@chromium.org>
    clk: Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gpucc-sdm845: fix clk_dis_wait being programmed for CX GDSC

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gpucc-sc7180: fix clk_dis_wait being programmed for CX GDSC

Frederic Barrat <fbarrat@linux.ibm.com>
    powerpc/powernv/ioda: Skip unallocated resources when mapping to PE

Luca Ellero <l.ellero@asem.it>
    Input: ads7846 - don't check penirq immediately for 7845

Luca Ellero <l.ellero@asem.it>
    Input: ads7846 - always set last command to PWRDOWN

Peng Fan <peng.fan@nxp.com>
    clk: imx: avoid memory leak

Geert Uytterhoeven <geert+renesas@glider.be>
    clk: renesas: cpg-mssr: Remove superfluous check in resume code

Luca Ellero <l.ellero@asem.it>
    Input: ads7846 - don't report pressure for ads7845

Alexey Khoroshilov <khoroshilov@ispras.ru>
    clk: renesas: cpg-mssr: Fix use after free if cpg_mssr_common_init() failed

Jeff LaBundy <jeff@labundy.com>
    Input: iqs269a - increase interrupt handler return delay

Jeff LaBundy <jeff@labundy.com>
    Input: iqs269a - configure device with a single block write

Jeff LaBundy <jeff@labundy.com>
    Input: iqs269a - drop unused device node references

Heiko Stuebner <heiko.stuebner@vrull.eu>
    RISC-V: fix funct4 definition for c.jalr in parse_asm.h

Samuel Holland <samuel@sholland.org>
    mtd: rawnand: sunxi: Fix the size of the last OOB region

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-qcs404: fix names of the DSI clocks used as parents

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-qcs404: disable gpll[04]_out_aux parents

Li Jun <jun.li@nxp.com>
    clk: imx: imx8mp: add shared clk gate for usb suspend clk

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix lockless access in subflow ULP diag

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: don't get/set_role() when usb_role_switch is unregistered

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: fix NULL pointer issue when put module's reference

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix memory double free when handle zero packet

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: blocked some cdns3 specific code

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Don't disconnect if not started

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: amba-pl011: Fix DMA transmission in RS485 mode

Peter Zijlstra <peterz@infradead.org>
    x86/alternative: Make custom return thunk unconditional

Borislav Petkov (AMD) <bp@alien8.de>
    Revert "x86/alternative: Make custom return thunk unconditional"

Peter Zijlstra <peterz@infradead.org>
    x86/returnthunk: Allow different return thunks

Peter Zijlstra <peterz@infradead.org>
    x86/ftrace: Use alternative RET encoding

Peter Zijlstra <peterz@infradead.org>
    x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()

Peter Zijlstra <peterz@infradead.org>
    x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR

Borislav Petkov (AMD) <bp@alien8.de>
    Revert "x86/ftrace: Use alternative RET encoding"

Nikita Shubin <nikita.shubin@maquefel.me>
    ARM: ep93xx: Add terminator to gpiod_lookup_table

Tom Parkin <tparkin@katalix.com>
    l2tp: pass correct message length to ip6_append_data

Vidya Sagar <vidyas@nvidia.com>
    PCI/MSI: Prevent MSI hardware interrupt number truncation

Vasiliy Kovalev <kovalev@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: don't modify the data when using authenticated encryption

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Fix an invalid freeing on already freed page in error path

Daniel Vacek <neelx@redhat.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: fix lz4 inplace decompression

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Eugen Hristev <eugen.hristev@collabora.com>
    pmdomain: mediatek: fix race conditions with genpd

Yi Sun <yi.sun@unisoc.com>
    virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: reset gpu for s3 suspend abort case

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: skip to program GFXDEC registers for suspend abort

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: send bus reset promptly on gap count error

Hannes Reinecke <hare@suse.de>
    scsi: lpfc: Use unsigned type for num_sge

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Enlarge per package core count limit

Andrew Bresticker <abrestic@rivosinc.com>
    efi: Don't add memblocks for soft-reserved memory

Andrew Bresticker <abrestic@rivosinc.com>
    efi: runtime: Fix potential overflow of soft-reserved region size

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: adding missing drv_mgd_complete_tx() call

Edward Adam Davis <eadavis@qq.com>
    fs/ntfs3: Fix oob in ntfs_listxattr

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Update inode->i_size after success write into compressed file

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Correct function is_rst_area_valid

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Prevent generic message "attempt to access beyond end of device"

Ism Hong <ism.hong@gmail.com>
    fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Disable ATTR_LIST_ENTRY size check

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Print warning while fixing hard links count

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Correct hard links updating when dealing with DOS names

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Improve ntfs_dir_count

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Modified fix directory element type detection

Szilard Fabian <szfabian@bluemarch.art>
    Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the hole length returned by ext4_map_blocks()

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: take ref count on tgtport before delete assoc

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: avoid deadlock on delete association path

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: abort command when there is no binding

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: hold reference on hostport match

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: defer cleanup using RCU properly

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: release reference on target port

Daniel Wagner <dwagner@suse.de>
    nvmet-fcloop: swap the list_add_tail arguments

Daniel Wagner <dwagner@suse.de>
    nvme-fc: do not wait in vain when unloading module

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Ignore clock selector errors for single connection

Xin Long <lucien.xin@gmail.com>
    netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Brenton Simpson <appsforartists@google.com>
    Input: xpad - add Lenovo Legion Go controllers

Wolfram Sang <wsa+renesas@sang-engineering.com>
    spi: sh-msiof: avoid integer overflow in constants

Chen-Yu Tsai <wens@csie.org>
    ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Check presence of valid altsetting control

Guixin Liu <kanie@linux.alibaba.com>
    nvmet-tcp: fix nvme tcp ida memory leak

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Kunwu Chan <chentao@kylinos.cn>
    dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt

Phoenix Chen <asbeltogf@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet

Huang Pei <huangpei@loongson.cn>
    MIPS: reserve exception vector space ONLY ONCE

Lennert Buytenhek <kernel@wantstofly.org>
    ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1166: correct count of reported ports

Devyn Liu <liudingyuan@huawei.com>
    spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Fullway Wang <fullwaywang@outlook.com>
    fbdev: sis: Error out if pixclock equals zero

Fullway Wang <fullwaywang@outlook.com>
    fbdev: savage: Error out if pixclock equals zero

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: fix race condition on enabling fast-xmit

Michal Kazior <michal@plume.com>
    wifi: cfg80211: fix missing interfaces when dumping

Vinod Koul <vkoul@kernel.org>
    dmaengine: fsl-qdma: increase size of 'irq_name'

Vinod Koul <vkoul@kernel.org>
    dmaengine: shdma: increase size of 'dev_id'

Dmitry Bogdanov <d.bogdanov@yadro.com>
    scsi: target: core: Add TMF to tmr_list handling

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Disallow writing invalid values to sched_rt_period_us

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Fix sysctl_sched_rr_timeslice intial value

Andrei Vagin <avagin@google.com>
    x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Damien Le Moal <dlemoal@kernel.org>
    zonefs: Improve error handling

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Jiri Olsa <jolsa@kernel.org>
    bpf: Remove trace_printk_lock

Jiri Olsa <jolsa@kernel.org>
    bpf: Do cleanup in bpf_bprintf_cleanup only when needed

Jiri Olsa <jolsa@kernel.org>
    bpf: Add struct for bin_args arg in bpf_bprintf_prepare

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Merge printk and seq_printf VARARG max macros

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix parsing of SMB3.1.1 POSIX create context

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOBs in smb2_parse_contexts()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in receive_encrypted_standard()

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire dsmark qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire ATM qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire CBQ qdisc


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-platform-asus-wmi  |    9 +
 Makefile                                           |    4 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |    1 -
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |    2 -
 arch/arm/boot/dts/bcm53573.dtsi                    |   20 +-
 arch/arm/mach-ep93xx/core.c                        |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |    2 +
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   79 +-
 arch/arm64/include/asm/exception.h                 |    5 -
 arch/arm64/kvm/vgic/vgic-its.c                     |    5 +
 arch/arm64/mm/mmu.c                                |    4 +-
 arch/mips/include/asm/vpe.h                        |    1 -
 arch/mips/kernel/smp-cps.c                         |    8 +-
 arch/mips/kernel/traps.c                           |    8 +-
 arch/mips/kernel/vpe-mt.c                          |    7 +-
 arch/mips/lantiq/prom.c                            |    6 -
 arch/powerpc/kernel/eeh_driver.c                   |   71 +-
 arch/powerpc/kernel/rtas.c                         |   24 +-
 arch/powerpc/perf/hv-24x7.c                        |   42 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    3 +-
 arch/powerpc/platforms/pseries/lpar.c              |   20 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   20 +-
 arch/riscv/include/asm/parse_asm.h                 |    2 +-
 arch/s390/pci/pci.c                                |    2 +-
 arch/x86/include/asm/nospec-branch.h               |    2 +
 arch/x86/include/asm/text-patching.h               |   46 +-
 arch/x86/kernel/alternative.c                      |   13 +-
 arch/x86/kernel/fpu/signal.c                       |   12 +-
 arch/x86/kernel/ftrace.c                           |    4 +-
 arch/x86/kernel/paravirt.c                         |   23 +-
 arch/x86/kernel/static_call.c                      |    2 +-
 arch/x86/net/bpf_jit_comp.c                        |    2 +-
 drivers/acpi/button.c                              |    9 +
 drivers/acpi/property.c                            |    4 +
 drivers/acpi/resource.c                            |   35 +
 drivers/acpi/video_detect.c                        |   34 +
 drivers/ata/ahci.c                                 |   34 +-
 drivers/ata/ahci.h                                 |    6 +-
 drivers/ata/ahci_ceva.c                            |  125 +-
 drivers/ata/ahci_da850.c                           |   45 +-
 drivers/ata/ahci_dm816.c                           |    4 +-
 drivers/ata/libahci_platform.c                     |  135 +-
 drivers/block/nbd.c                                |    3 +-
 drivers/block/virtio_blk.c                         |    7 +-
 drivers/clk/clk.c                                  |   11 +
 drivers/clk/imx/clk-imx8mp.c                       |   23 +-
 drivers/clk/imx/clk.c                              |    3 +-
 drivers/clk/qcom/gcc-qcs404.c                      |   24 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |    7 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |    7 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    8 +-
 drivers/dma/fsl-qdma.c                             |    2 +-
 drivers/dma/sh/shdma.h                             |    2 +-
 drivers/dma/ti/edma.c                              |   10 +
 drivers/firewire/core-card.c                       |   18 +-
 drivers/firmware/efi/arm-runtime.c                 |    2 +-
 drivers/firmware/efi/efi-init.c                    |   19 +-
 drivers/firmware/efi/riscv-runtime.c               |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    8 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   22 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    1 +
 drivers/gpu/drm/drm_syncobj.c                      |    6 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |    4 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |    8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |    2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |    2 +-
 drivers/hwmon/coretemp.c                           |    2 +-
 drivers/i2c/busses/i2c-imx.c                       |   97 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    5 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    6 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    2 +-
 drivers/infiniband/hw/irdma/defs.h                 |    1 +
 drivers/infiniband/hw/irdma/hw.c                   |    8 +
 drivers/infiniband/hw/irdma/verbs.c                |    9 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   11 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |    1 -
 drivers/infiniband/sw/siw/siw_verbs.c              |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   17 +-
 drivers/input/joystick/xpad.c                      |    2 +
 drivers/input/misc/iqs269a.c                       |  335 ++--
 drivers/input/serio/i8042-acpipnpio.h              |    8 +
 drivers/input/touchscreen/ads7846.c                |   23 +-
 drivers/md/dm-crypt.c                              |    6 +
 drivers/md/md.c                                    |   14 +-
 drivers/md/raid10.c                                |    2 +
 drivers/mmc/host/jz4740_mmc.c                      |   10 +-
 drivers/mmc/host/mxcmmc.c                          |    6 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   20 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   29 +-
 drivers/net/gtp.c                                  |   10 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    2 +-
 drivers/nvme/host/fc.c                             |   47 +-
 drivers/nvme/target/fc.c                           |  131 +-
 drivers/nvme/target/fcloop.c                       |    6 +-
 drivers/nvme/target/tcp.c                          |    1 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    3 +-
 drivers/pci/msi.c                                  |    2 +-
 drivers/platform/x86/intel/vbtn.c                  |    3 -
 drivers/platform/x86/touchscreen_dmi.c             |   39 +-
 drivers/regulator/pwm-regulator.c                  |    3 +
 drivers/scsi/Kconfig                               |    2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |   12 +-
 drivers/soc/mediatek/mtk-pm-domains.c              |   15 +-
 drivers/soc/renesas/r8a77980-sysc.c                |    3 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |    5 +
 drivers/spi/spi-sh-msiof.c                         |   16 +-
 drivers/target/target_core_device.c                |    5 -
 drivers/target/target_core_transport.c             |    4 +
 drivers/tty/serial/8250/8250_port.c                |   18 +-
 drivers/tty/serial/amba-pl011.c                    |   60 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |    8 +-
 drivers/usb/cdns3/core.c                           |    1 -
 drivers/usb/cdns3/drd.c                            |   13 +-
 drivers/usb/cdns3/drd.h                            |    6 +-
 drivers/usb/cdns3/host.c                           |   16 +-
 drivers/usb/dwc3/gadget.c                          |    5 +
 drivers/usb/gadget/function/f_ncm.c                |   10 +-
 drivers/usb/host/xhci-hub.c                        |  228 +--
 drivers/usb/host/xhci-mem.c                        |   10 +-
 drivers/usb/host/xhci-ring.c                       |   13 +-
 drivers/usb/host/xhci.h                            |    9 +-
 drivers/usb/roles/class.c                          |   29 +-
 drivers/vdpa/mlx5/core/mr.c                        |    1 -
 drivers/video/fbdev/savage/savagefb_driver.c       |    3 +
 drivers/video/fbdev/sis/sis_main.c                 |    2 +
 fs/afs/volume.c                                    |    4 +-
 fs/aio.c                                           |    9 +-
 fs/btrfs/disk-io.c                                 |    3 +
 fs/cifs/connect.c                                  |   19 +-
 fs/cifs/smb2file.c                                 |    1 -
 fs/cifs/smb2ops.c                                  |   54 +-
 fs/cifs/smb2pdu.c                                  |  115 +-
 fs/cifs/smb2proto.h                                |   16 +-
 fs/erofs/decompressor.c                            |   34 +-
 fs/exfat/dir.c                                     |   15 +
 fs/exfat/exfat_fs.h                                |    5 +-
 fs/ext4/extents.c                                  |  111 +-
 fs/ext4/mballoc.c                                  |   70 +-
 fs/f2fs/gc.c                                       |   39 +-
 fs/ksmbd/smb2pdu.c                                 |    8 +-
 fs/ntfs3/attrib.c                                  |   20 +-
 fs/ntfs3/attrlist.c                                |    8 +-
 fs/ntfs3/dir.c                                     |   40 +-
 fs/ntfs3/file.c                                    |    2 +
 fs/ntfs3/fslog.c                                   |   14 +-
 fs/ntfs3/fsntfs.c                                  |   24 +
 fs/ntfs3/inode.c                                   |    2 +-
 fs/ntfs3/ntfs.h                                    |    4 +-
 fs/ntfs3/ntfs_fs.h                                 |   14 +-
 fs/ntfs3/record.c                                  |   16 +-
 fs/ntfs3/xattr.c                                   |    3 +
 fs/zonefs/super.c                                  |   68 +-
 include/dt-bindings/clock/imx8mp-clock.h           |   10 +-
 include/linux/ahci_platform.h                      |    5 +-
 include/linux/bpf.h                                |   14 +-
 include/linux/clk-provider.h                       |   15 +-
 include/linux/fs.h                                 |    2 +
 include/linux/pm.h                                 |   80 +-
 include/linux/sched.h                              |    4 -
 include/linux/sched/signal.h                       |    2 +-
 include/linux/socket.h                             |    5 +-
 include/net/netfilter/nf_flow_table.h              |    4 +-
 include/net/tcp.h                                  |    2 +-
 kernel/bpf/bpf_lru_list.c                          |   21 +-
 kernel/bpf/bpf_lru_list.h                          |    7 +-
 kernel/bpf/helpers.c                               |   76 +-
 kernel/bpf/verifier.c                              |    3 +-
 kernel/sched/fair.c                                |    2 +-
 kernel/sched/rt.c                                  |   10 +-
 kernel/sysctl.c                                    |    4 +
 kernel/time/posix-timers.c                         |   31 +-
 kernel/trace/bpf_trace.c                           |   39 +-
 lib/debugobjects.c                                 |    9 +
 mm/userfaultfd.c                                   |   14 +-
 net/core/dev.c                                     |    2 +-
 net/core/dev_ioctl.c                               |    2 +-
 net/core/devlink.c                                 |    5 +-
 net/ipv4/arp.c                                     |    3 +-
 net/ipv4/devinet.c                                 |   21 +-
 net/ipv6/addrconf.c                                |   21 +-
 net/ipv6/seg6.c                                    |   20 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/mac80211/mlme.c                                |    1 +
 net/mac80211/sta_info.c                            |    2 +
 net/mac80211/tx.c                                  |    2 +-
 net/mptcp/diag.c                                   |    6 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |    2 +-
 net/netfilter/nf_flow_table_core.c                 |   41 +-
 net/netfilter/nf_tables_api.c                      |    3 +
 net/netfilter/nft_flow_offload.c                   |   14 +-
 net/packet/af_packet.c                             |   12 +-
 net/sched/Kconfig                                  |   42 -
 net/sched/Makefile                                 |    3 -
 net/sched/sch_api.c                                |   20 +-
 net/sched/sch_atm.c                                |  710 --------
 net/sched/sch_cbq.c                                | 1817 --------------------
 net/sched/sch_dsmark.c                             |  522 ------
 net/tls/tls_main.c                                 |    2 +-
 net/tls/tls_sw.c                                   |   12 +-
 net/wireless/nl80211.c                             |    1 +
 net/wireless/wext-core.c                           |    6 +
 scripts/bpf_doc.py                                 |    2 +-
 sound/soc/sunxi/sun4i-spdif.c                      |    5 +
 sound/usb/clock.c                                  |   10 +-
 sound/usb/format.c                                 |   20 +
 tools/include/uapi/linux/fscrypt.h                 |    3 +-
 tools/perf/trace/beauty/include/linux/socket.h     |    2 +
 tools/testing/selftests/net/vrf-xfrm-tests.sh      |   32 +-
 tools/virtio/linux/kernel.h                        |    2 +-
 tools/virtio/linux/vringh.h                        |    1 +
 218 files changed, 2296 insertions(+), 4619 deletions(-)




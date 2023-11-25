Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF177F8E29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjKYTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjKYTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:45:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A319D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:45:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149D8C433C8;
        Sat, 25 Nov 2023 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700941523;
        bh=Viz8eVeP5krC2qVw3tGylJrZq33qOHpXpoBGJCze1mM=;
        h=From:To:Cc:Subject:Date:From;
        b=SQzrI9XNjAmXWyiv0WKpnmKLGwVG0LWk58ax9lVc2IKk2dP2M/fdAJgM2DYQXSdJJ
         ejGsb7P4XpXekFIybTQh6NsqgxWdUcnEjumoRJUpUanx4t1VvnRhB/bkZkCsquUg66
         73lp5MrKSve7VpSt1pVbSeT49DmLz3fQfGqCrEpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 6.1 000/368] 6.1.64-rc3 review
Date:   Sat, 25 Nov 2023 19:45:20 +0000
Message-ID: <20231125194359.201910779@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc3.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.64-rc3
X-KernelTest-Deadline: 2023-11-27T19:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.64 release.
There are 368 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc3.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.64-rc3

Victor Shih <victor.shih@genesyslogic.com.tw>
    mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER

Vicki Pfau <vi@endrift.com>
    Input: xpad - add VID for Turtle Beach controllers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have trace_event_file have ref counters

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Fix fortify source warnings in opal-prd.c

Lewis Huang <lewis.huang@amd.com>
    drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox

Tianci Yin <tianci.yin@amd.com>
    drm/amd/display: Enable fast plane updates on DCN3.2 and above

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer()

Christian König <christian.koenig@amd.com>
    drm/amdgpu: lower CS errors to debug severity

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: don't use ATRM for external devices

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: don't use pci_is_thunderbolt_attached()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/smu13: drop compute workload workaround

Ma Jun <Jun.Ma2@amd.com>
    drm/amd/pm: Fix error of MACO flag setting code

Kunwu Chan <chentao@kylinos.cn>
    drm/i915: Fix potential spectre vulnerability

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Bump GLK CDCLK frequency when driving multiple pipes

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amd/pm: Handle non-terminated overdrive commands.

Jan Kara <jack@suse.cz>
    ext4: properly sync file size update after O_SYNC direct IO

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: add missed brelse in update_backups

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the start block of counting reserved clusters

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct return value of ext4_convert_meta_bg

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: mark buffer new if it is unwritten to avoid stale data exposure

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct offset of gdb backup in non meta_bg group to update_backups

Max Kellermann <max.kellermann@ionos.com>
    ext4: apply umask if ACL support is disabled

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Andrey Konovalov <andrey.konovalov@linaro.org>
    media: qcom: camss: Fix csid-gen2 for test pattern generator

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix invalid clock enable bit disjunction

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix missing vfe_lite clocks check

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix VFE-480 vfe_disable_output()

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix VFE-17x vfe_disable_output()

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix vfe_get() error jump

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix pm_domain_on sequence in probe

Victor Shih <victor.shih@genesyslogic.com.tw>
    mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER

ChunHao Lin <hau@realtek.com>
    r8169: add handling DASH when DASH is disabled

ChunHao Lin <hau@realtek.com>
    r8169: fix network lost after resume on DASH systems

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix setsockopt(IP_TOS) subflow locking

Geliang Tang <geliang.tang@suse.com>
    mptcp: add validity check for sending RM_ADDR

Paolo Abeni <pabeni@redhat.com>
    mptcp: deal with large GSO size

Roman Gushchin <roman.gushchin@linux.dev>
    mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Stefan Roesch <shr@devkernel.io>
    mm: fix for negative counter: nr_file_hugepages

Victor Shih <victor.shih@genesyslogic.com.tw>
    mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2

Nam Cao <namcaov@gmail.com>
    riscv: kprobes: allow writing to x0

Song Shuai <suagrfillet@gmail.com>
    riscv: correct pt_level name via pgtable_l5/4_enabled

Song Shuai <suagrfillet@gmail.com>
    riscv: mm: Update the comment of CONFIG_PAGE_OFFSET

Nathan Chancellor <nathan@kernel.org>
    LoongArch: Mark __percpu functions as always inline

Mahmoud Adam <mngyadam@amazon.com>
    nfsd: fix file memleak on client_opens_release

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: don't use blocking calls from tasklets

Jani Nikula <jani.nikula@intel.com>
    drm/mediatek/dp: fix memory leak on ->get_edid callback error path

Jani Nikula <jani.nikula@intel.com>
    drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ccs: Correctly initialise try compose rectangle

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to handle capabilities from firmware

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: fix the check to handle session buffer requirement

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi_parser: Add check to keep the number of codecs within range

Sean Young <sean@mess.org>
    media: sharp: fix sharp encoding

Sean Young <sean@mess.org>
    media: lirc: drop trailing space from scancode transmit

Su Hui <suhui@nfschina.com>
    f2fs: avoid format-overflow warning

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: do not return EFSCORRUPTED, but try to run online repair

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: fix potential race in i801_block_transaction_byte_by_byte

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: phylink: initialize carrier state at creation

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: consequently nested-lock physical MDIO

Andrew Lunn <andrew@lunn.ch>
    net: ethtool: Fix documentation of ethtool_sprintf()

Harald Freudenberger <freude@linux.ibm.com>
    s390/ap: fix AP bus crash on early config change callback invocation

Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
    i2c: designware: Disable TX_EMPTY irq while waiting for block length byte

Darren Hart <darren@os.amperecomputing.com>
    sbsa_gwdt: Calculate timeout with 64-bit math

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix default return value for inode_getsecctx

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix default return value for vm_enough_memory

Robert Marko <robert.marko@sartura.hr>
    Revert "i2c: pxa: move to generic GPIO recovery"

Johnathan Mantey <johnathanx.mantey@intel.com>
    Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Jim Harris <jim.harris@samsung.com>
    cxl/region: Fix x1 root-decoder granularity calculations

Dan Williams <dan.j.williams@intel.com>
    tools/testing/cxl: Define a fixed volatile configuration to parse

Dan Williams <dan.j.williams@intel.com>
    cxl/mem: Move devm_cxl_add_endpoint() from cxl_core to cxl_mem

Robert Richter <rrichter@amd.com>
    cxl: Unify debug messages when calling devm_cxl_add_port()

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix random hot join failure since timeout error

Clark Wang <xiaoning.wang@nxp.com>
    i3c: master: svc: add NACK check after start byte sent

Jim Harris <jim.harris@samsung.com>
    cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Move region-position validation to a helper

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Cleanup target list on attach error

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Validate region mode vs decoder mode

Muhammad Ahmed <ahmed.ahmed@amd.com>
    drm/amd/display: enable dsc_clk even if dsc_pg disabled

Guan Wentao <guanwentao@uniontech.com>
    Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Masum Reza <masumrezarock100@gmail.com>
    Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 13d3:3571 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 0bda:887b to device tables

Artem Lukyanov <dukzcry@ya.ru>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Gustavo A. R. Silva <gustavoars@kernel.org>
    clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    clk: visconti: remove unused visconti_pll_provider::regmap

Christian Marangi <ansuelsmth@gmail.com>
    cpufreq: stats: Fix buffer overflow detection in trans_stats()

Pengfei Li <pengfei.li_1@nxp.com>
    pmdomain: imx: Make imx pgc power domain also set the fwnode

Maíra Canal <mcanal@igalia.com>
    pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirks for HP Laptops

Matus Malych <matus@malych.org>
    ALSA: hda/realtek: Enable Mute LED on HP 255 G10

Chandradeep Dey <codesigning@chandradeepdey.com>
    ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add Dell ALC295 to pin fall back table

Eymen Yigit <eymenyg01@gmail.com>
    ALSA: hda/realtek: Enable Mute LED on HP 255 G8

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix potential deadlock at disconnection

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: wait for data BG to be finished on direct IO allocation

Dave Chinner <dchinner@redhat.com>
    xfs: recovery should not clear di_flushiter unconditionally

Shyam Prasad N <sprasad@microsoft.com>
    cifs: do not reset chan_max if multichannel is not supported at mount

Shyam Prasad N <sprasad@microsoft.com>
    cifs: force interface update before a fresh session setup

Shyam Prasad N <sprasad@microsoft.com>
    cifs: reconnect helper should set reconnect for the right channel

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential deadlock when releasing mids

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix use-after-free bug in cifs_debug_data_proc_show()

Steve French <stfrench@microsoft.com>
    smb3: fix caching of ctime on setxattr

Steve French <stfrench@microsoft.com>
    smb3: fix touch -h of symlink

Steve French <stfrench@microsoft.com>
    smb3: fix creating FIFOs when mounting with "sfu" mount option

Jeff Layton <jlayton@kernel.org>
    fs: add ctime accessors infrastructure

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    xhci: Enable RPM on controllers that support low-power states

Helge Deller <deller@gmx.de>
    parisc/power: Fix power soft-off when running on qemu

Helge Deller <deller@gmx.de>
    parisc/pgtable: Do not drop upper 5 address bits of physical address

Helge Deller <deller@gmx.de>
    parisc: Prevent booting 64-bit kernels on PA1.x machines

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix check wrong status register in irq handler

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix ibi may not return mandatory data byte

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix wrong data return when IBI happen during start frame

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix race condition in ibi work thread

Joshua Yeong <joshua.yeong@starfivetech.com>
    i3c: master: cdns: Fix reading status register

Linus Walleij <linus.walleij@linaro.org>
    mtd: cfi_cmdset_0001: Byte swap OTP info

Zi Yan <ziy@nvidia.com>
    mm/memory_hotplug: use pfn math in place of direct struct page manipulation

Zi Yan <ziy@nvidia.com>
    mm/cma: use nth_page() in place of direct struct page manipulation

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix detection of DAT pages

Alain Volmat <alain.volmat@foss.st.com>
    dmaengine: stm32-mdma: correct desc prep when channel running

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    mcb: fix error handling for different scenarios when parsing

Saravana Kannan <saravanak@google.com>
    driver core: Release all resources during unbind before updating device links

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have the user copy of synthetic event address use correct context

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Run atomic i2c xfer when !preemptible

Benjamin Bara <benjamin.bara@skidata.com>
    kernel/reboot: emergency_restart: Set correct system_state

Eric Biggers <ebiggers@google.com>
    quota: explicitly forbid quota files from being encrypted

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix

Jamie Lentin <jm@lentin.co.uk>
    hid: lenovo: Resend all settings on reset_resume for compact keyboards

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Move _GNU_SOURCE define into Makefile

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Remove duplicate feature check from CMT test

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: split async and sync catchall in two functions

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: remove catchall element in GC sync path

Mimi Zohar <zohar@linux.ibm.com>
    ima: detect changes to the backing overlay file

Amir Goldstein <amir73il@gmail.com>
    ima: annotate iint mutex to avoid lockdep false positive warnings

Johan Hovold <johan+linaro@kernel.org>
    mfd: qcom-spmi-pmic: Fix revid implementation

Johan Hovold <johan+linaro@kernel.org>
    mfd: qcom-spmi-pmic: Fix reference leaks in revid helper

Vignesh Viswanathan <quic_viswanat@quicinc.com>
    arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

Vasily Khoruzhick <anarsoul@gmail.com>
    ACPI: FPDT: properly handle invalid FPDT subtables

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit

Vignesh Viswanathan <quic_viswanat@quicinc.com>
    arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't arbitrarily slow down delalloc if we're committing

Catalin Marinas <catalin.marinas@arm.com>
    rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Use __get_safe_page() rather than touching the list

Vignesh Viswanathan <quic_viswanat@quicinc.com>
    arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM

Joel Fernandes (Google) <joel@joelfernandes.org>
    rcu/tree: Defer setting of jiffies during stall reset

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Drop connection after an RDMA Read error

Ajay Singh <ajay.kathat@microchip.com>
    wifi: wilc1000: use vmm_table as array in wilc struct

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: exynos: Don't discard .remove() callback

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: kirin: Don't discard .remove() callback

Heiner Kallweit <hkallweit1@gmail.com>
    PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()

Bean Huo <beanhuo@micron.com>
    mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A

Nitin Yadav <n-yadav@ti.com>
    mmc: sdhci_am654: fix start loop index for TAP value parsing

Dan Carpenter <dan.carpenter@linaro.org>
    mmc: vub300: fix an error code

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab out of bounds write in smb_inherit_dacl()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: handle malformed smb1 message

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Gustavo A. R. Silva <gustavoars@kernel.org>
    clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data

Helge Deller <deller@gmx.de>
    parisc/power: Add power soft-off when running on qemu

Helge Deller <deller@gmx.de>
    parisc/pdc: Add width field to struct pdc_model

Nathan Chancellor <nathan@kernel.org>
    arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .probe() callback

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .remove() callback

Jarkko Sakkinen <jarkko@kernel.org>
    KEYS: trusted: Rollback init_trusted() consistently

Sumit Garg <sumit.garg@linaro.org>
    KEYS: trusted: tee: Refactor register SHM usage

Herve Codina <herve.codina@bootlin.com>
    genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Rong Chen <rong.chen@amlogic.com>
    mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix gtk offload status event locking

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix htt pktlog locking

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix dfs radar event locking

Johan Hovold <johan+linaro@kernel.org>
    wifi: ath11k: fix temperature event locking

Mark Brown <broonie@kernel.org>
    regmap: Ensure range selector registers are updated after cache sync

Werner Sembach <wse@tuxedocomputers.com>
    ACPI: resource: Do IRQ override on TongFang GMxXGxx

SeongJae Park <sj@kernel.org>
    mm/damon/sysfs: check error from damon_sysfs_update_target()

SeongJae Park <sj@kernel.org>
    mm/damon: implement a function for max nr_accesses safe calculation

SeongJae Park <sj@kernel.org>
    mm/damon/ops-common: avoid divide-by-zero during region hotness calculation

SeongJae Park <sj@kernel.org>
    mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation

Krister Johansen <kjlx@templeofstupid.com>
    watchdog: move softlockup_panic back to early_param

SeongJae Park <sj@kernel.org>
    mm/damon/sysfs: update monitoring target regions for online input commit

SeongJae Park <sj@kernel.org>
    mm/damon/sysfs: remove requested targets when online-commit inputs

Lukas Wunner <lukas@wunner.de>
    PCI/sysfs: Protect driver's D3cold preference from user space

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix event channel handling for secondary consoles

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix error path in xen_hvc_init() to always register frontend driver

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix console unplug

Pavel Krasavin <pkrasavin@imaqliq.com>
    tty: serial: meson: fix hard LOCKUP on crtscts mode

Muhammad Usama Anjum <usama.anjum@collabora.com>
    tty/sysrq: replace smp_processor_id() with get_cpu()

Krister Johansen <kjlx@templeofstupid.com>
    proc: sysctl: prevent aliased sysctls from getting passed to init

Paul Moore <paul@paul-moore.com>
    audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Paul Moore <paul@paul-moore.com>
    audit: don't take task_lock() in audit_exe_compare() code path

Tao Su <tao1.su@linux.intel.com>
    KVM: x86: Clear bit12 of ICR after APIC-write VM-exit

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    KVM: x86: Ignore MSR_AMD64_TW_CFG access

Nicolas Saenz Julienne <nsaenz@amazon.com>
    KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Pu Wen <puwen@hygon.cn>
    x86/cpu/hygon: Fix the CPU topology evaluation for real

Roxana Nicolescu <roxana.nicolescu@canonical.com>
    crypto: x86/sha - load modules based on CPU features

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix system crash due to bad pointer access

Chandrakanth patil <chandrakanth.patil@broadcom.com>
    scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Ranjan Kumar <ranjan.kumar@broadcom.com>
    scsi: mpt3sas: Fix loop logic

Shung-Hsi Yu <shung-hsi.yu@suse.com>
    bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END

Hao Sun <sunhao.th@gmail.com>
    bpf: Fix check_stack_write_fixed_off() to correctly spill imm

Kees Cook <keescook@chromium.org>
    randstruct: Fix gcc-plugin performance mode to stay in group

Nicholas Piggin <npiggin@gmail.com>
    powerpc/perf: Fix disabling BHRB and instruction sampling

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix async branch flags

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to perform sanity on queue pointers

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    i915/perf: Fix NULL deref bugs with drm_dbg() calls

Ekaterina Esina <eesina@astralinux.ru>
    cifs: fix check of rc in function generate_smb3signingkey

Anastasia Belova <abelova@astralinux.ru>
    cifs: spnego: add ';' in HOST_KEY_LEN

Chen Yu <yu.c.chen@intel.com>
    tools/power/turbostat: Enable the C-state Pre-wake printing

Zhang Rui <rui.zhang@intel.com>
    tools/power/turbostat: Fix a knl bug

Vlad Buslov <vladbu@nvidia.com>
    macvlan: Don't propagate promisc change to lower dev in passthru

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Check return value of snprintf writing to fw_version buffer

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5e: Reduce the size of icosq_str

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Fix pedit endianness

Gavin Li <gavinl@nvidia.com>
    net/mlx5e: fix double free of encap_header in update funcs

Dust Li <dust.li@linux.alibaba.com>
    net/mlx5e: fix double free of encap_header

Baruch Siach <baruch@tkos.co.il>
    net: stmmac: avoid rx queue overrun

Baruch Siach <baruch@tkos.co.il>
    net: stmmac: fix rx budget limit check

Dan Carpenter <dan.carpenter@linaro.org>
    netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Linkui Xiao <xiaolinkui@kylinos.cn>
    netfilter: nf_conntrack_bridge: initialize err to 0

Eric Dumazet <edumazet@google.com>
    af_unix: fix use-after-free in unix_stream_read_actor()

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix MTU max setting

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Handle large frames

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix max RX frame define

Eric Dumazet <edumazet@google.com>
    bonding: stop the device in bond_setup_by_slave()

Eric Dumazet <edumazet@google.com>
    ptp: annotate data-race around q->head and q->tail

Juergen Gross <jgross@suse.com>
    xen/events: fix delayed eoi list handling

Willem de Bruijn <willemb@google.com>
    ppp: limit MRU to 64K

Sven Auhagen <sven.auhagen@voleatech.de>
    net: mvneta: fix calls to page_pool_get_stats

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Fix kernel-infoleak due to uninitialized TLV value

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix VF wrong speed and duplex issue

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix VF reset fail issue

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs

Jian Shen <shenjian15@huawei.com>
    net: hns3: fix incorrect capability bit display for copper port

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: add barrier in vf mailbox reply process

Jian Shen <shenjian15@huawei.com>
    net: hns3: fix add VLAN fail issue

Shigeru Yoshida <syoshida@redhat.com>
    tty: Fix uninit-value access in ppp_sync_receive()

Eric Dumazet <edumazet@google.com>
    ipvlan: add ipvlan_route_v6_outbound() helper

Stanislav Fomichev <sdf@google.com>
    net: set SOCK_RCU_FREE before inserting socket into hashtable

Dan Carpenter <dan.carpenter@linaro.org>
    vhost-vdpa: fix use after free in vhost_vdpa_probe()

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

felix <fuzhen5@huawei.com>
    SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Dan Carpenter <dan.carpenter@linaro.org>
    SUNRPC: Add an IS_ERR() check back to where it was

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix handling NFS4ERR_DELAY when testing for session trunking

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: meson: check return value of devm_kasprintf()

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: intel: check return value of devm_kasprintf()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: ECONNRESET might require a rebind

Finn Thain <fthain@linux-m68k.org>
    sched/core: Optimize in_task() and in_interrupt() a bit

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: Use FW rate for non-data frames

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: tegra: add missing check for platform_get_irq()

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: Fix double shift bug

Vitaly Prosyak <vitaly.prosyak@amd.com>
    drm/amdgpu: fix software pci_unplug on some chips

Alex Spataru <alex_spataru@outlook.com>
    ALSA: hda/realtek: Add quirk for ASUS UX7602ZM

Zongmin Zhou <zhouzongmin@kylinos.cn>
    drm/qxl: prevent memory leak

Tony Lindgren <tony@atomide.com>
    ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Philipp Stanner <pstanner@redhat.com>
    i2c: dev: copy userspace array safely

Douglas Anderson <dianders@chromium.org>
    kgdb: Flush console before entering kgdb on panic

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Avoid NULL dereference of timing generator

Takashi Iwai <tiwai@suse.de>
    media: imon: fix access to invalid resource for the second interface

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ccs: Fix driver quirk struct documentation

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    media: cobalt: Use FIELD_GET() to extract Link Width

Al Viro <viro@zeniv.linux.org.uk>
    gfs2: fix an oops in gfs2_permission

Bob Peterson <rpeterso@redhat.com>
    gfs2: ignore negated quota changes

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: avoid integer overflow

Rajeshwar R Shinde <coolrrsh@gmail.com>
    media: gspca: cpia1: shift-out-of-bounds in set_flicker

Billy Tsai <billy_tsai@aspeedtech.com>
    i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.

zhenwei pi <pizhenwei@bytedance.com>
    virtio-blk: fix implicit overflow on virtio_max_dma_size

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: fix memleak in i2c_new_client_device()

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler

Dominique Martinet <asmadeus@codewreck.org>
    9p: v9fs_listxattr: fix %s null argument warning

Marco Elver <elver@google.com>
    9p/trans_fd: Annotate data-racy writes to file::f_flags

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Zhiguo Niu <zhiguo.niu@unisoc.com>
    f2fs: fix error handling of __get_node_page

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: dmi-quirks: update HP Omen match

Stanley Chang <stanley_chang@realtek.com>
    usb: dwc3: core: configure TX/RX threshold for DWC3_IP

Yi Yang <yiyang13@huawei.com>
    tty: vcc: Add check for kstrdup() in vcc_probe()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager

Zhang Shurong <zhang_shurong@foxmail.com>
    iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: support handle zero-size directory

Jiri Kosina <jkosina@suse.cz>
    HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Longfang Liu <liulongfang@huawei.com>
    crypto: hisilicon/qm - prevent soft lockup in receive loop

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: soc-acpi-cht: Add Lenovo Yoga Tab 3 Pro YT3-X90 quirk

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Disable ATS for specific Intel IPU E2000 devices

Bartosz Pawlowski <bartosz.pawlowski@intel.com>
    PCI: Extract ATS disabling to a helper function

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Use FIELD_GET() to extract Link Width

Wenchao Hao <haowenchao2@huawei.com>
    scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Do error check on own line to split long "if" conditions

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    atm: iphase: Do PCI error checks on own line

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: mvebu: Use FIELD_PREP() with Link Width

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields

Cezary Rojewski <cezary.rojewski@intel.com>
    ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Vincent Whitchurch <vincent.whitchurch@axis.com>
    ARM: 9320/1: fix stack depot IRQ stack filter

Mikhail Khvainitski <me@khvoinitsky.org>
    HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in diAlloc

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbFindLeaf

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add validity check for db_maxag and db_agpref

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add check for negative db_l2nbperpage

Tyrel Datwyler <tyreld@linux.ibm.com>
    scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    RDMA/hfi1: Use FIELD_GET() to extract Link Width

Rander Wang <rander.wang@intel.com>
    ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware

Lu Jialin <lujialin4@huawei.com>
    crypto: pcrypt - Fix hungtask for PADATA_RESET

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: SOF: Pass PCI SSID to machine driver

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: soc-card: Add storage for PCI SSID

zhujun2 <zhujun2@cmss.chinamobile.com>
    selftests/efivarfs: create-read: fix a resource leak

Laurentiu Tudor <laurentiu.tudor@nxp.com>
    arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size

Qu Huang <qu.huang@linux.dev>
    drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Jesse Zhang <jesse.zhang@amd.com>
    drm/amdkfd: Fix shift out-of-bounds issue

Ondrej Jirman <megi@xff.cz>
    drm/panel: st7703: Pick different reset sequence

Ma Ke <make_ruc2021@163.com>
    drm/amdgpu/vkms: fix a possible null pointer dereference

Ma Ke <make_ruc2021@163.com>
    drm/radeon: fix a possible null pointer dereference

Ma Ke <make_ruc2021@163.com>
    drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference

Ma Ke <make_ruc2021@163.com>
    drm/panel: fix a possible null pointer dereference

Stanley.Yang <Stanley.Yang@amd.com>
    drm/amdgpu: Fix potential null pointer derefernce

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

Jani Nikula <jani.nikula@intel.com>
    drm/msm/dp: skip validity check for DP CTS EDID checksum

Philipp Stanner <pstanner@redhat.com>
    drm: vmwgfx_surface.c: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    drm_lease.c: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    kernel: watch_queue: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    kernel: kexec: copy user-array safely

Philipp Stanner <pstanner@redhat.com>
    string.h: add array-wrappers for (v)memdup_user()

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: use full update for clip size increase of large plane source

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Update `update_pcie_parameters` functions to use uint8_t arguments

Xiaogang Chen <xiaogang.chen@amd.com>
    drm/amdkfd: Fix a race condition of vram buffer unref in svm code

David (Ming Qiang) Wu <David.Wu3@amd.com>
    drm/amdgpu: not to save bo in the case of RAS err_event_athub

baozhu.liu <lucas.liu@siengine.com>
    drm/komeda: drop all currently held locks if deadlock happens

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/gma500: Fix call trace when psb_gem_mm_init() fails

Olli Asikainen <olli.asikainen@gmail.com>
    platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

Tzung-Bi Shih <tzungbi@kernel.org>
    platform/chrome: kunit: initialize lock for fake ec_dev

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix tsnep_request_irq() format-overflow warning

Jonathan Denose <jdenose@chromium.org>
    ACPI: EC: Add quirk for HP 250 G7 Notebook PC

ZhengHan Wang <wzhmmmmm@gmail.com>
    Bluetooth: Fix double free in hci_conn_cleanup

youwan Wang <wangyouwan@126.com>
    Bluetooth: btusb: Add date->evt_skb is NULL check

Andrii Nakryiko <andrii@kernel.org>
    bpf: Ensure proper register state printing for cond jumps

Arseniy Krasnov <avkrasnov@salutedevices.com>
    vsock: read from socket's error queue

Douglas Anderson <dianders@chromium.org>
    wifi: ath10k: Don't touch the CE interrupt registers after power up

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_dst_pending_confirm

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_tx_queue_mapping

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath10k: fix clang-specific fortify warning

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix clang-specific fortify warnings

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Detect IP == ksym.end as part of BPF program

Sieng-Piaw Liew <liew.s.piaw@gmail.com>
    atl1c: Work around the DMA RX overflow issue

Ping-Ke Shih <pkshih@realtek.com>
    wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211_hwsim: fix clang-specific fortify warning

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: plfxlc: fix clang-specific fortify warning

Mike Rapoport (IBM) <rppt@kernel.org>
    x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Frederic Weisbecker <frederic@kernel.org>
    workqueue: Provide one lock class key per work_on_cpu() callsite

Ran Xiaokai <ran.xiaokai@zte.com.cn>
    cpu/hotplug: Don't offline the last non-isolated CPU

Rik van Riel <riel@surriel.com>
    smp,csd: Throw an error if a CSD lock is stuck for too long

Ronald Wahl <ronald.wahl@raritan.com>
    clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Jacky Bai <ping.bai@nxp.com>
    clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config

Denis Arefev <arefev@swemel.ru>
    srcu: Fix srcu_struct node grpmask overflow on 64-bit systems

Shuai Xue <xueshuai@linux.alibaba.com>
    perf/core: Bail out early if the request AUX area is out of bound

Kent Overstreet <kent.overstreet@gmail.com>
    lib/generic-radix-tree.c: Don't overflow in peek()

John Stultz <jstultz@google.com>
    locking/ww_mutex/test: Fix potential workqueue corruption


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 Makefile                                           |   4 +-
 arch/arm/include/asm/exception.h                   |   4 -
 arch/arm64/Kconfig                                 |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  46 +++---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   2 +-
 arch/loongarch/include/asm/percpu.h                |  10 +-
 arch/parisc/include/uapi/asm/pdc.h                 |   1 +
 arch/parisc/kernel/entry.S                         |   7 +-
 arch/parisc/kernel/head.S                          |   5 +-
 arch/powerpc/perf/core-book3s.c                    |   5 +-
 arch/powerpc/platforms/powernv/opal-prd.c          |  17 ++-
 arch/powerpc/platforms/pseries/iommu.c             |   8 +-
 arch/riscv/include/asm/page.h                      |   4 +-
 arch/riscv/kernel/probes/simulate-insn.c           |   2 +-
 arch/riscv/mm/ptdump.c                             |   3 +
 arch/s390/mm/page-states.c                         |  12 +-
 arch/x86/crypto/sha1_ssse3_glue.c                  |  12 ++
 arch/x86/crypto/sha256_ssse3_glue.c                |  12 ++
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/include/asm/numa.h                        |   7 -
 arch/x86/kernel/cpu/hygon.c                        |   8 +-
 arch/x86/kvm/hyperv.c                              |  10 +-
 arch/x86/kvm/lapic.c                               |  26 ++--
 arch/x86/kvm/x86.c                                 |   2 +
 arch/x86/mm/numa.c                                 |   7 -
 crypto/pcrypt.c                                    |   4 +
 drivers/acpi/acpi_fpdt.c                           |  45 ++++--
 drivers/acpi/ec.c                                  |  10 ++
 drivers/acpi/resource.c                            |  12 ++
 drivers/atm/iphase.c                               |  20 +--
 drivers/base/dd.c                                  |   2 +-
 drivers/base/regmap/regcache.c                     |  30 ++++
 drivers/block/virtio_blk.c                         |   4 +-
 drivers/bluetooth/btusb.c                          |  15 ++
 drivers/clk/qcom/gcc-ipq6018.c                     |   6 -
 drivers/clk/qcom/gcc-ipq8074.c                     |   6 -
 drivers/clk/socfpga/stratix10-clk.h                |   4 +-
 drivers/clk/visconti/pll.h                         |   5 +-
 drivers/clocksource/timer-atmel-tcb.c              |   1 +
 drivers/clocksource/timer-imx-gpt.c                |  18 ++-
 drivers/cpufreq/cpufreq_stats.c                    |  14 +-
 drivers/crypto/hisilicon/qm.c                      |   2 +
 drivers/cxl/acpi.c                                 |   2 -
 drivers/cxl/core/core.h                            |  11 --
 drivers/cxl/core/hdm.c                             |   3 +-
 drivers/cxl/core/port.c                            |  92 ++++++------
 drivers/cxl/core/region.c                          | 134 +++++++++++------
 drivers/cxl/cxl.h                                  |   4 +-
 drivers/cxl/cxlmem.h                               |  12 ++
 drivers/cxl/mem.c                                  |  38 +++++
 drivers/dma/stm32-mdma.c                           |   4 +-
 drivers/firmware/qcom_scm.c                        |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   2 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  20 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   5 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |  22 +--
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  32 +++--
 drivers/gpu/drm/amd/include/pptable.h              |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   8 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h  |  16 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   4 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  40 +-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   9 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   9 +-
 drivers/gpu/drm/drm_lease.c                        |   4 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |   1 +
 drivers/gpu/drm/gma500/psb_irq.c                   |   5 +
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  12 ++
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   1 +
 drivers/gpu/drm/i915/i915_perf.c                   |  15 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   6 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  21 +--
 drivers/gpu/drm/panel/panel-arm-versatile.c        |   2 +
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |  25 ++--
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   2 +
 drivers/gpu/drm/qxl/qxl_display.c                  |   3 +
 drivers/gpu/drm/radeon/radeon_connectors.c         |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   4 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-lenovo.c                           | 118 ++++++++++-----
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/i2c/busses/i2c-designware-master.c         |  19 ++-
 drivers/i2c/busses/i2c-i801.c                      |  19 ++-
 drivers/i2c/busses/i2c-pxa.c                       |  76 ++++++++--
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |   5 +
 drivers/i2c/i2c-core-base.c                        |  13 +-
 drivers/i2c/i2c-core.h                             |   2 +-
 drivers/i2c/i2c-dev.c                              |   4 +-
 drivers/i3c/master/i3c-master-cdns.c               |   6 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c           |  29 ++--
 drivers/i3c/master/mipi-i3c-hci/dma.c              |   2 +-
 drivers/i3c/master/svc-i3c-master.c                |  60 +++++++-
 drivers/iio/adc/stm32-adc-core.c                   |   9 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |   9 +-
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/mcb/mcb-core.c                             |   1 +
 drivers/mcb/mcb-parse.c                            |   2 +-
 drivers/md/dm-verity-fec.c                         |   4 +-
 drivers/md/dm-verity-target.c                      |  23 +--
 drivers/md/dm-verity.h                             |   2 +-
 drivers/media/i2c/ccs/ccs-core.c                   |   2 +-
 drivers/media/i2c/ccs/ccs-quirk.h                  |   4 +-
 drivers/media/pci/cobalt/cobalt-driver.c           |  11 +-
 .../media/platform/qcom/camss/camss-csid-gen2.c    |   9 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |  22 +--
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |  22 +--
 drivers/media/platform/qcom/camss/camss-vfe.c      |   5 +-
 drivers/media/platform/qcom/camss/camss.c          |  12 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |   2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c     |  15 ++
 drivers/media/platform/qcom/venus/hfi_venus.c      |  10 ++
 drivers/media/rc/imon.c                            |   6 +
 drivers/media/rc/ir-sharp-decoder.c                |   8 +-
 drivers/media/rc/lirc_dev.c                        |   6 +-
 drivers/media/test-drivers/vivid/vivid-rds-gen.c   |   2 +-
 drivers/media/usb/gspca/cpia1.c                    |   3 +
 drivers/mfd/intel-lpss-pci.c                       |  13 ++
 drivers/mfd/qcom-spmi-pmic.c                       | 101 +++++++++----
 drivers/misc/pci_endpoint_test.c                   |   4 +
 drivers/mmc/core/block.c                           |   4 +-
 drivers/mmc/core/card.h                            |   4 +
 drivers/mmc/core/mmc.c                             |   8 +-
 drivers/mmc/core/quirks.h                          |   7 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   1 -
 drivers/mmc/host/sdhci-pci-gli.c                   |  30 ++++
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/vub300.c                          |   1 +
 drivers/mtd/chips/cfi_cmdset_0001.c                |  20 ++-
 drivers/mtd/nand/raw/intel-nand-controller.c       |  10 ++
 drivers/mtd/nand/raw/meson_nand.c                  |   3 +
 drivers/mtd/nand/raw/tegra_nand.c                  |   4 +
 drivers/net/bonding/bond_main.c                    |   6 +
 drivers/net/dsa/lan9303_mdio.c                     |   4 +-
 drivers/net/ethernet/atheros/atl1c/atl1c.h         |   3 -
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  67 +++------
 drivers/net/ethernet/cortina/gemini.c              |  45 +++---
 drivers/net/ethernet/cortina/gemini.h              |   4 +-
 drivers/net/ethernet/engleder/tsnep.h              |   2 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |  12 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   9 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  33 +++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  25 +++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   7 +
 drivers/net/ethernet/marvell/mvneta.c              |  28 ++--
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 ++--
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  60 ++++----
 drivers/net/ethernet/realtek/r8169_main.c          |  46 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  41 +++---
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/phy/phylink.c                          |   1 +
 drivers/net/ppp/ppp_synctty.c                      |   6 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |  18 ++-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   8 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  19 ++-
 drivers/net/wireless/ath/ath9k/debug.c             |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  14 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |   2 +-
 drivers/parisc/power.c                             |  16 ++-
 drivers/pci/controller/dwc/pci-exynos.c            |   4 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci-sysfs.c                            |  10 +-
 drivers/pci/pci.c                                  |  22 +--
 drivers/pci/pcie/aspm.c                            |   2 +
 drivers/pci/probe.c                                |   6 +-
 drivers/pci/quirks.c                               |  41 ++++--
 drivers/platform/chrome/cros_ec_proto_test.c       |   1 +
 drivers/platform/x86/thinkpad_acpi.c               |   1 +
 drivers/ptp/ptp_chardev.c                          |   3 +-
 drivers/ptp/ptp_clock.c                            |   5 +-
 drivers/ptp/ptp_private.h                          |   8 +-
 drivers/ptp/ptp_sysfs.c                            |   3 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  13 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     | 124 +++++++++++++++-
 drivers/scsi/libfc/fc_lport.c                      |   6 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   4 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  12 +-
 drivers/soc/bcm/bcm2835-power.c                    |   2 +-
 drivers/soc/imx/gpc.c                              |   1 +
 drivers/soundwire/dmi-quirks.c                     |   2 +-
 drivers/thunderbolt/quirks.c                       |   3 +
 drivers/tty/hvc/hvc_xen.c                          |  39 +++--
 drivers/tty/serial/meson_uart.c                    |  14 +-
 drivers/tty/sysrq.c                                |   3 +-
 drivers/tty/vcc.c                                  |  16 ++-
 drivers/usb/dwc3/core.c                            | 160 ++++++++++++++++-----
 drivers/usb/dwc3/core.h                            |  13 ++
 drivers/usb/gadget/function/f_ncm.c                |  27 ++--
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/vhost/vdpa.c                               |   1 -
 drivers/watchdog/sbsa_gwdt.c                       |   4 +-
 drivers/xen/events/events_base.c                   |   4 +-
 fs/9p/xattr.c                                      |   5 +-
 fs/btrfs/delalloc-space.c                          |   3 -
 fs/btrfs/inode.c                                   |   7 +
 fs/exfat/namei.c                                   |  29 +++-
 fs/ext4/acl.h                                      |   5 +
 fs/ext4/extents_status.c                           |   4 +-
 fs/ext4/file.c                                     | 153 +++++++++-----------
 fs/ext4/inode.c                                    |  14 +-
 fs/ext4/resize.c                                   |  23 ++-
 fs/f2fs/compress.c                                 |   2 +-
 fs/f2fs/node.c                                     |   7 +-
 fs/f2fs/xattr.c                                    |  20 ++-
 fs/gfs2/inode.c                                    |  14 +-
 fs/gfs2/quota.c                                    |  11 ++
 fs/gfs2/super.c                                    |   2 +-
 fs/inode.c                                         |  16 +++
 fs/jbd2/recovery.c                                 |   8 ++
 fs/jfs/jfs_dmap.c                                  |  23 ++-
 fs/jfs/jfs_imap.c                                  |   5 +-
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/nfsd/nfs4state.c                                |   2 +-
 fs/overlayfs/super.c                               |   2 +-
 fs/proc/proc_sysctl.c                              |   8 +-
 fs/quota/dquot.c                                   |  14 ++
 fs/smb/client/cifs_debug.c                         |   6 +
 fs/smb/client/cifs_spnego.c                        |   4 +-
 fs/smb/client/cifsfs.c                             |   1 +
 fs/smb/client/cifspdu.h                            |   2 +-
 fs/smb/client/cifsproto.h                          |   7 +-
 fs/smb/client/connect.c                            |  15 +-
 fs/smb/client/inode.c                              |   4 +
 fs/smb/client/sess.c                               |   1 -
 fs/smb/client/smb2misc.c                           |   2 +-
 fs/smb/client/smb2ops.c                            |   8 +-
 fs/smb/client/smb2transport.c                      |   5 +-
 fs/smb/client/transport.c                          |  11 +-
 fs/smb/client/xattr.c                              |   5 +-
 fs/smb/server/smb_common.c                         |  11 ++
 fs/smb/server/smbacl.c                             |  29 +++-
 fs/xfs/xfs_inode_item_recover.c                    |  32 +++--
 include/linux/damon.h                              |   7 +
 include/linux/ethtool.h                            |   4 +-
 include/linux/fs.h                                 |  45 +++++-
 include/linux/generic-radix-tree.h                 |   7 +
 include/linux/lsm_hook_defs.h                      |   4 +-
 include/linux/mmc/card.h                           |   2 +
 include/linux/preempt.h                            |  15 +-
 include/linux/pwm.h                                |   4 +-
 include/linux/socket.h                             |   1 +
 include/linux/string.h                             |  40 ++++++
 include/linux/sunrpc/clnt.h                        |   1 +
 include/linux/sysctl.h                             |   6 +
 include/linux/trace_events.h                       |   4 +
 include/linux/workqueue.h                          |  46 +++++-
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/net/sock.h                                 |  26 +++-
 include/sound/soc-acpi.h                           |   7 +
 include/sound/soc-card.h                           |  37 +++++
 include/sound/soc.h                                |  11 ++
 include/sound/sof.h                                |   8 ++
 include/uapi/linux/vm_sockets.h                    |  17 +++
 init/main.c                                        |   4 +
 kernel/audit_watch.c                               |   9 +-
 kernel/bpf/core.c                                  |   6 +-
 kernel/bpf/verifier.c                              |  16 ++-
 kernel/cpu.c                                       |  11 +-
 kernel/debug/debug_core.c                          |   3 +
 kernel/events/ring_buffer.c                        |   6 +
 kernel/irq/generic-chip.c                          |  25 +++-
 kernel/kexec.c                                     |   2 +-
 kernel/locking/test-ww_mutex.c                     |  20 +--
 kernel/padata.c                                    |   2 +-
 kernel/power/snapshot.c                            |  16 +--
 kernel/rcu/srcutree.c                              |   4 +-
 kernel/rcu/tree.c                                  |  21 +++
 kernel/rcu/tree.h                                  |   4 +
 kernel/rcu/tree_stall.h                            |  20 ++-
 kernel/reboot.c                                    |   1 +
 kernel/smp.c                                       |  13 +-
 kernel/trace/trace.c                               |  15 ++
 kernel/trace/trace.h                               |   3 +
 kernel/trace/trace_events.c                        |  43 ++++--
 kernel/trace/trace_events_filter.c                 |   3 +
 kernel/trace/trace_events_synth.c                  |   2 +-
 kernel/watch_queue.c                               |   2 +-
 kernel/watchdog.c                                  |   7 +
 kernel/workqueue.c                                 |  20 +--
 lib/generic-radix-tree.c                           |  17 ++-
 mm/cma.c                                           |   2 +-
 mm/damon/lru_sort.c                                |   4 +-
 mm/damon/ops-common.c                              |   5 +-
 mm/damon/sysfs.c                                   |  87 ++++++-----
 mm/huge_memory.c                                   |  16 ++-
 mm/memcontrol.c                                    |   3 +-
 mm/memory_hotplug.c                                |   2 +-
 net/9p/client.c                                    |   2 +-
 net/9p/trans_fd.c                                  |  13 +-
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_sysfs.c                          |  23 +--
 net/bridge/netfilter/nf_conntrack_bridge.c         |   2 +-
 net/core/sock.c                                    |   2 +-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/mac80211/cfg.c                                 |   4 +
 net/mptcp/pm_netlink.c                             |   5 +-
 net/mptcp/protocol.c                               |   4 +
 net/mptcp/sockopt.c                                |   3 +
 net/ncsi/ncsi-aen.c                                |   5 -
 net/netfilter/nf_tables_api.c                      |  53 ++++---
 net/netfilter/nft_byteorder.c                      |   5 +-
 net/netfilter/nft_meta.c                           |   2 +-
 net/sunrpc/clnt.c                                  |   7 +-
 net/sunrpc/rpcb_clnt.c                             |   4 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   3 +-
 net/tipc/netlink_compat.c                          |   1 +
 net/unix/af_unix.c                                 |   9 +-
 net/vmw_vsock/af_vsock.c                           |   6 +
 scripts/gcc-plugins/randomize_layout_plugin.c      |  11 +-
 security/integrity/iint.c                          |  48 +++++--
 security/integrity/ima/ima_api.c                   |   5 +
 security/integrity/ima/ima_main.c                  |  16 ++-
 security/integrity/integrity.h                     |   2 +
 security/keys/trusted-keys/trusted_core.c          |  20 +--
 security/keys/trusted-keys/trusted_tee.c           |  64 +++------
 sound/core/info.c                                  |  21 +--
 sound/hda/hdac_stream.c                            |   6 +-
 sound/pci/hda/patch_realtek.c                      |  26 ++--
 sound/soc/codecs/lpass-wsa-macro.c                 |   3 +
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |  43 ++++++
 sound/soc/sof/ipc4.c                               |   3 +
 sound/soc/sof/sof-audio.c                          |   7 +
 sound/soc/sof/sof-pci-dev.c                        |   8 ++
 sound/soc/ti/omap-mcbsp.c                          |   6 +-
 tools/perf/util/intel-pt.c                         |   2 +
 tools/power/x86/turbostat/turbostat.c              |   3 +-
 tools/testing/cxl/test/cxl.c                       | 147 +++++++++++++++++--
 tools/testing/selftests/efivarfs/create-read.c     |   2 +
 tools/testing/selftests/lkdtm/config               |   1 -
 tools/testing/selftests/lkdtm/tests.txt            |   2 +-
 tools/testing/selftests/resctrl/Makefile           |   2 +-
 tools/testing/selftests/resctrl/cmt_test.c         |   3 -
 tools/testing/selftests/resctrl/mba_test.c         |   2 +-
 tools/testing/selftests/resctrl/mbm_test.c         |   2 +-
 tools/testing/selftests/resctrl/resctrl.h          |   1 -
 371 files changed, 3401 insertions(+), 1480 deletions(-)



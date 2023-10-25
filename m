Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF17D5FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjJYCUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJYCUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:20:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6F10EF;
        Tue, 24 Oct 2023 19:20:45 -0700 (PDT)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SFXdW1tLKz15Nsg;
        Wed, 25 Oct 2023 10:17:51 +0800 (CST)
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 10:20:42 +0800
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
References: <20231024083326.219645073@linuxfoundation.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <ec34fd09-5012-5087-9823-ffcad87f2dea@huawei.com>
Date:   Wed, 25 Oct 2023 10:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on arm64 and x86 for 5.10.199-rc2,

Kernel 
repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-5.10.y
Version: 5.10.199-rc2
Commit: e31b6513c43d7f4efa2c5913dd7d4fbef162e736
Compiler: gcc version 7.3.0 (GCC)

arm64:
--------------------------------------------------------------------
Testcase Result Summary:
total: 9023
passed: 9023
failed: 0
timeout: 0
--------------------------------------------------------------------

x86:
--------------------------------------------------------------------
Testcase Result Summary:
total: 9023
passed: 9023
failed: 0
timeout: 0
--------------------------------------------------------------------
Tested-by: Hulk Robot <hulkrobot@huawei.com>

在 2023/10/24 16:36, Greg Kroah-Hartman 写道:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 5.10.199-rc2
> 
> Zhang Changzhong <zhangchangzhong@huawei.com>
>      xfrm6: fix inet6_dev refcount underflow problem
> 
> Kees Cook <keescook@chromium.org>
>      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
> 
> Edward AD <twuufnxlz@gmail.com>
>      Bluetooth: hci_sock: fix slab oob read in create_monitor_event
> 
> Tony Lindgren <tony@atomide.com>
>      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins
> 
> Tony Lindgren <tony@atomide.com>
>      phy: mapphone-mdm6600: Fix runtime PM for remove
> 
> Tony Lindgren <tony@atomide.com>
>      phy: mapphone-mdm6600: Fix runtime disable on probe
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      ASoC: pxa: fix a memory leak in probe()
> 
> Haibo Chen <haibo.chen@nxp.com>
>      gpio: vf610: set value before the direction to avoid a glitch
> 
> Hans de Goede <hdegoede@redhat.com>
>      platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events
> 
> Hans de Goede <hdegoede@redhat.com>
>      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
> 
> Niklas Schnelle <schnelle@linux.ibm.com>
>      s390/pci: fix iommu bitmap allocation
> 
> Peter Zijlstra <peterz@infradead.org>
>      perf: Disallow mis-matched inherited group reads
> 
> Puliang Lu <puliang.lu@fibocom.com>
>      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL
> 
> Benoît Monin <benoit.monin@gmx.fr>
>      USB: serial: option: add entry for Sierra EM9191 with new firmware
> 
> Fabio Porcedda <fabio.porcedda@gmail.com>
>      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition
> 
> Maurizio Lombardi <mlombard@redhat.com>
>      nvme-rdma: do not try to stop unallocated queues
> 
> Keith Busch <kbusch@kernel.org>
>      nvme-pci: add BOGUS_NID for Intel 0a54 device
> 
> Sunil V L <sunilvl@ventanamicro.com>
>      ACPI: irq: Fix incorrect return value in acpi_register_gsi()
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      pNFS: Fix a hang in nfs4_evict_inode()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
> 
> Avri Altman <avri.altman@wdc.com>
>      mmc: core: Capture correct oemid-bits for eMMC cards
> 
> Haibo Chen <haibo.chen@nxp.com>
>      mmc: core: sdio: hold retuning if sdio in 1-bit mode
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      mtd: physmap-core: Restore map_rom fallback
> 
> Martin Kurbanov <mmkurbanov@sberdevices.ru>
>      mtd: spinand: micron: correct bitmask for ecc status
> 
> Miquel Raynal <miquel.raynal@bootlin.com>
>      mtd: rawnand: arasan: Ensure program page operations are successful
> 
> Miquel Raynal <miquel.raynal@bootlin.com>
>      mtd: rawnand: marvell: Ensure program page operations are successful
> 
> Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>      mtd: rawnand: qcom: Unmap the right resource upon probe failure
> 
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>      Bluetooth: hci_event: Fix using memcmp when comparing keys
> 
> Maher Sanalla <msanalla@nvidia.com>
>      net/mlx5: Handle fw tracer change ownership event based on MTRC
> 
> Renan Guilherme Lebre Ramos <japareaggae@gmail.com>
>      platform/x86: touchscreen_dmi: Add info for the Positivo C4128B
> 
> Rahul Rameshbabu <sergeantsagara@protonmail.com>
>      HID: multitouch: Add required quirk for Synaptics 0xcd7e device
> 
> Josef Bacik <josef@toxicpanda.com>
>      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c
> 
> Kai Uwe Broulik <foss-linux@broulik.de>
>      drm: panel-orientation-quirks: Add quirk for One Mix 2S
> 
> Hangbin Liu <liuhangbin@gmail.com>
>      ipv4/fib: send notify when delete source address routes
> 
> Kees Cook <keescook@chromium.org>
>      sky2: Make sure there is at least one frag_addr available
> 
> Michał Mirosław <mirq-linux@rere.qmqm.pl>
>      regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"
> 
> Benjamin Berg <benjamin.berg@intel.com>
>      wifi: cfg80211: avoid leaking stack data into trace
> 
> Wen Gong <quic_wgong@quicinc.com>
>      wifi: mac80211: allow transmitting EAPOL frames with tainted key
> 
> Ilan Peer <ilan.peer@intel.com>
>      wifi: cfg80211: Fix 6GHz scan configuration
> 
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>      Bluetooth: hci_core: Fix build warnings
> 
> Ying Hsu <yinghsu@chromium.org>
>      Bluetooth: Avoid redundant authentication
> 
> Ma Ke <make_ruc2021@163.com>
>      HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event
> 
> Clément Léger <cleger@rivosinc.com>
>      tracing: relax trace_event_eval_update() execution with cond_resched()
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: libata-eh: Fix compilation warning in ata_eh_link_report()
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      gpio: timberdale: Fix potential deadlock on &tgpio->lock
> 
> Jeff Layton <jlayton@kernel.org>
>      overlayfs: set ctime when setting mtime and atime
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter
> 
> Josef Bacik <josef@toxicpanda.com>
>      btrfs: initialize start_slot in btrfs_log_prealloc_extents
> 
> Filipe Manana <fdmanana@suse.com>
>      btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
> 
> Tony Lindgren <tony@atomide.com>
>      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
> 
> RD Babiera <rdbabiera@google.com>
>      usb: typec: altmodes/displayport: Signal hpd low when exiting mode
> 
> Hans de Goede <hdegoede@redhat.com>
>      usb: typec: altmodes/displayport: Notify drm subsys of hotplug events
> 
> Hans de Goede <hdegoede@redhat.com>
>      drm/connector: Add support for out-of-band hotplug notification (v3)
> 
> Hans de Goede <hdegoede@redhat.com>
>      drm/connector: Add drm_connector_find_by_fwnode() function (v3)
> 
> Hans de Goede <hdegoede@redhat.com>
>      drm/connector: Add a fwnode pointer to drm_connector and register with ACPI (v2)
> 
> Hans de Goede <hdegoede@redhat.com>
>      drm/connector: Give connector sysfs devices there own device_type
> 
> Daniel Miess <daniel.miess@amd.com>
>      drm/amd/display: Don't set dpms_off for seamless boot
> 
> Yongqiang Sun <yongqiang.sun@amd.com>
>      drm/amd/display: only check available pipe to disable vbios mode.
> 
> Tony Lindgren <tony@atomide.com>
>      serial: 8250_omap: Fix errors with no_console_suspend
> 
> Tony Lindgren <tony@atomide.com>
>      serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: track port suspend state correctly in unsuccessful resume cases
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: decouple usb2 port resume and get_port_status request handling
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: clear usb2 resume related variables in one place.
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: rename resume_done to resume_timestamp
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: move port specific items such as state completions to port structure
> 
> Mathias Nyman <mathias.nyman@linux.intel.com>
>      xhci: cleanup xhci_hub_control port references
> 
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>      usb: core: Track SuperSpeed Plus GenXxY
> 
> Juntong Deng <juntong.deng@outlook.com>
>      selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error
> 
> Waiman Long <longman@redhat.com>
>      selftests/vm: make charge_reserved_hugetlb.sh work with existing cgroup setting
> 
> Hans de Goede <hdegoede@redhat.com>
>      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
> 
> Paul Menzel <pmenzel@molgen.mpg.de>
>      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA
> 
> Tamim Khan <tamim@fusetak.com>
>      ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA
> 
> Hans de Goede <hdegoede@redhat.com>
>      ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
> 
> Tamim Khan <tamim@fusetak.com>
>      ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA
> 
> Kellen Renshaw <kellen.renshaw@canonical.com>
>      ACPI: resource: Add ASUS model S5402ZA to quirks
> 
> Tamim Khan <tamim@fusetak.com>
>      ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA
> 
> Hui Wang <hui.wang@canonical.com>
>      ACPI: resources: Add DMI-based legacy IRQ override quirk
> 
> John Garry <john.garry@huawei.com>
>      ACPI: Drop acpi_dev_irqresource_disabled()
> 
> John Garry <john.garry@huawei.com>
>      resource: Add irqresource_disabled()
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>      thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
> 
> Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
>      net: pktgen: Fix interface flags printing
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nft_set_rbtree: .deactivate fails if element has expired
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
> 
> Pedro Tammela <pctammela@mojatatu.com>
>      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>      net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()
> 
> Michal Schmidt <mschmidt@redhat.com>
>      i40e: prevent crash on probe if hw registers have invalid values
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
> 
> Eric Dumazet <edumazet@google.com>
>      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr
> 
> Eric Dumazet <edumazet@google.com>
>      tun: prevent negative ifindex
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
> 
> Neal Cardwell <ncardwell@google.com>
>      tcp: fix excessive TLP and RACK timeouts from HZ rounding
> 
> Josua Mayer <josua@solid-run.com>
>      net: rfkill: gpio: prevent value glitch during probe
> 
> Ma Ke <make_ruc2021@163.com>
>      net: ipv6: fix return value check in esp_remove_trailer
> 
> Ma Ke <make_ruc2021@163.com>
>      net: ipv4: fix return value check in esp_remove_trailer
> 
> Eric Dumazet <edumazet@google.com>
>      xfrm: interface: use DEV_STATS_INC()
> 
> Eric Dumazet <edumazet@google.com>
>      xfrm: fix a data-race in xfrm_gen_index()
> 
> Manish Chopra <manishc@marvell.com>
>      qed: fix LL2 RX buffer allocation
> 
> Ville Syrjälä <ville.syrjala@linux.intel.com>
>      drm/i915: Retry gtt fault when out of fence registers
> 
> Sagi Grimberg <sagi@grimberg.me>
>      nvmet-tcp: Fix a possible UAF in queue intialization setup
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nft_payload: fix wrong mac header matching
> 
> Paolo Abeni <pabeni@redhat.com>
>      tcp: check mptcp-level constraints for backlog coalescing
> 
> Joerg Roedel <jroedel@suse.de>
>      x86/sev: Check for user-space IOIO pointing to kernel space
> 
> Joerg Roedel <jroedel@suse.de>
>      x86/sev: Check IOBM for IOIO exceptions from user-space
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>      x86/sev: Disable MMIO emulation from user mode
> 
> Jim Mattson <jmattson@google.com>
>      KVM: x86: Mask LVTPC when handling a PMI
> 
> Johan Hovold <johan+linaro@kernel.org>
>      regmap: fix NULL deref on lookup
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
> 
> Jesse Brandeburg <jesse.brandeburg@intel.com>
>      ice: reset first in crash dump kernels
> 
> Jesse Brandeburg <jesse.brandeburg@intel.com>
>      ice: fix over-shifted variable
> 
> Arnd Bergmann <arnd@arndb.de>
>      Bluetooth: avoid memcmp() out of bounds warning
> 
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>      Bluetooth: hci_event: Fix coding style
> 
> Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
>      Bluetooth: vhci: Fix race when opening vhci device
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>      Bluetooth: Fix a refcnt underflow problem for hci_conn
> 
> Lee, Chun-Yi <jlee@suse.com>
>      Bluetooth: Reject connection with the device which has same BD_ADDR
> 
> Lee, Chun-Yi <jlee@suse.com>
>      Bluetooth: hci_event: Ignore NULL link key
> 
> Ricardo Cañuelo <ricardo.canuelo@collabora.com>
>      usb: hub: Guard against accesses to uninitialized BOS descriptors
> 
> Bagas Sanjaya <bagasdotme@gmail.com>
>      Documentation: sysctl: align cells in second content column
> 
> Liam Mark <lmark@codeaurora.org>
>      mm/memory_hotplug: rate limit page migration warnings
> 
> Hyeonggon Yoo <42.hyeyoo@gmail.com>
>      lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default
> 
> Nicolas Dichtel <nicolas.dichtel@6wind.com>
>      dev_forward_skb: do not scrub skb mark within the same name space
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>      ravb: Fix use-after-free issue in ravb_tx_timeout_work()
> 
> Bart Van Assche <bvanassche@acm.org>
>      RDMA/srp: Fix srp_abort()
> 
> yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
>      RDMA/srp: Set scmnd->result only when scmnd is not NULL
> 
> Ren Zhijie <renzhijie2@huawei.com>
>      arm64: armv8_deprecated: fix unused-function error
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: armv8_deprecated: rework deprected instruction handling
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: armv8_deprecated: move aarch32 helper earlier
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: armv8_deprecated move emulation functions
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: armv8_deprecated: fold ops into insn_emulation
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: rework EL0 MRS emulation
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: factor insn read out of call_undef_hook()
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: factor out EL1 SSBS emulation hook
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: split EL0/EL1 UNDEF handlers
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: allow kprobes on EL0 handlers
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: rework BTI exception handling
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: rework FPAC exception handling
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: consistently pass ESR_ELx to die()
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: die(): pass 'err' as long
> 
> Mark Rutland <mark.rutland@arm.com>
>      arm64: report EL1 UNDEFs better
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>      x86/alternatives: Disable KASAN in apply_alternatives()
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>      powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
> 
> Duoming Zhou <duoming@zju.edu.cn>
>      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()
> 
> Krishna Kurapati <quic_kriskura@quicinc.com>
>      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call
> 
> Piyush Mehta <piyush.mehta@amd.com>
>      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
> 
> Dharma Balasubiramani <dharma.b@microchip.com>
>      counter: microchip-tcb-capture: Fix the use of internal GCLK logic
> 
> Dmitry Torokhov <dmitry.torokhov@gmail.com>
>      pinctrl: avoid unsafe code pattern in find_pinctrl()
> 
> Michal Koutný <mkoutny@suse.com>
>      cgroup: Remove duplicates in cgroup v1 tasks file
> 
> Rijo Thomas <Rijo-john.Thomas@amd.com>
>      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
> 
> Hans de Goede <hdegoede@redhat.com>
>      Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case
> 
> Szilard Fabian <szfabian@bluemarch.art>
>      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table
> 
> Matthias Berndt <matthias_berndt@gmx.de>
>      Input: xpad - add PXN V900 support
> 
> Jeffery Miller <jefferymiller@google.com>
>      Input: psmouse - fix fast_reconnect function for PS/2 mode
> 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>      Input: powermate - fix use-after-free in powermate_config_complete
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      ceph: fix type promotion bug on 32bit systems
> 
> Xiubo Li <xiubli@redhat.com>
>      ceph: fix incorrect revoked caps assert in ceph_fill_file_size()
> 
> Jordan Rife <jrife@google.com>
>      libceph: use kernel_connect()
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
> 
> Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
>      mcb: remove is_added flag from mcb_device struct
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
> 
> Alexander Zangerl <az@breathe-safe.com>
>      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug
> 
> Lakshmi Yadlapati <lakshmiy@us.ibm.com>
>      iio: pressure: dps310: Adjust Timeout Settings
> 
> Phil Elwell <phil@raspberrypi.com>
>      iio: pressure: bmp280: Fix NULL pointer exception
> 
> Xingxing Luo <xingxing.luo@unisoc.com>
>      usb: musb: Modify the "HWVers" register address
> 
> Xingxing Luo <xingxing.luo@unisoc.com>
>      usb: musb: Get the musb_qh poniter after musb_giveback
> 
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>      usb: dwc3: Soft reset phy on probe for host
> 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
> 
> Wesley Cheng <quic_wcheng@quicinc.com>
>      usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer
> 
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>      dmaengine: stm32-mdma: abort resume if no ongoing transfer
> 
> Zheng Wang <zyytlz.wz@163.com>
>      media: mtk-jpeg: Fix use after free bug due to uncanceled work
> 
> Patrick Rohr <prohr@google.com>
>      net: release reference to inet6_dev pointer
> 
> Patrick Rohr <prohr@google.com>
>      net: change accept_ra_min_rtr_lft to affect all RA lifetimes
> 
> Patrick Rohr <prohr@google.com>
>      net: add sysctl accept_ra_min_rtr_lft
> 
> Sasha Levin <sashal@kernel.org>
>      Revert "spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe"
> 
> Sasha Levin <sashal@kernel.org>
>      Revert "spi: zynqmp-gqspi: fix clock imbalance on probe failure"
> 
> Waiman Long <longman@redhat.com>
>      workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()
> 
> Jeremy Cline <jeremy@jcline.org>
>      nfc: nci: assert requested protocol is valid
> 
> Ralph Siemsen <ralph.siemsen@linaro.org>
>      pinctrl: renesas: rzn1: Enable missing PINMUX
> 
> Eric Dumazet <edumazet@google.com>
>      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      ixgbe: fix crash with empty VF macvlan list
> 
> Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>      net: phy: mscc: macsec: reject PN update requests
> 
> Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>      net: macsec: indicate next pn update when offloading
> 
> Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>      drm/vmwgfx: fix typo of sizeof argument
> 
> Björn Töpel <bjorn@rivosinc.com>
>      riscv, bpf: Sign-extend return values
> 
> Pu Lehui <pulehui@huawei.com>
>      riscv, bpf: Factor out emit_call for kernel and bpf context
> 
> Roger Pau Monne <roger.pau@citrix.com>
>      xen-netback: use default TX queue size for vifs
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
> 
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>      ieee802154: ca8210: Fix a potential UAF in ca8210_probe
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>      ravb: Fix up dma_free_coherent() call in ravb_remove()
> 
> Abhinav Kumar <quic_abhinavk@quicinc.com>
>      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
> 
> Abhinav Kumar <quic_abhinavk@quicinc.com>
>      drm/msm/dsi: skip the wait for video mode done if not applicable
> 
> Kuogee Hsieh <quic_khsieh@quicinc.com>
>      drm/msm/dp: do not reinitialize phy unless retry during link training
> 
> Jordan Rife <jrife@google.com>
>      net: prevent address rewrite in kernel_bind()
> 
> Jan Kara <jack@suse.cz>
>      quota: Fix slow quotaoff
> 
> Hans de Goede <hdegoede@redhat.com>
>      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      lib/test_meminit: fix off-by-one error in test_pages()
> 
> Jing Zhang <renyu.zj@linux.alibaba.com>
>      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7
> 
> Artem Chernyshev <artem.chernyshev@red-soft.ru>
>      RDMA/cxgb4: Check skb value for failure to allocate
> 
> Bart Van Assche <bvanassche@acm.org>
>      RDMA/srp: Do not call scsi_done() from srp_abort()
> 
> Bart Van Assche <bvanassche@acm.org>
>      RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent
> 
> 
> -------------
> 
> Diffstat:
> 
>   Documentation/admin-guide/sysctl/net.rst           |  18 +-
>   Documentation/networking/ip-sysctl.rst             |   8 +
>   Makefile                                           |   4 +-
>   arch/arm/boot/dts/motorola-mapphone-common.dtsi    |   1 +
>   arch/arm64/include/asm/cpufeature.h                |   3 +-
>   arch/arm64/include/asm/exception.h                 |  13 +-
>   arch/arm64/include/asm/spectre.h                   |   2 +
>   arch/arm64/include/asm/system_misc.h               |   2 +-
>   arch/arm64/include/asm/traps.h                     |  19 +-
>   arch/arm64/kernel/armv8_deprecated.c               | 572 ++++++++++-----------
>   arch/arm64/kernel/cpufeature.c                     |  23 +-
>   arch/arm64/kernel/entry-common.c                   |  36 +-
>   arch/arm64/kernel/proton-pack.c                    |  26 +-
>   arch/arm64/kernel/traps.c                          | 125 ++---
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   7 +
>   arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 +-
>   arch/powerpc/include/asm/nohash/pgtable.h          |   2 +
>   arch/riscv/net/bpf_jit_comp64.c                    |  33 +-
>   arch/s390/pci/pci_dma.c                            |  15 +-
>   arch/x86/boot/compressed/sev-es.c                  |  10 +
>   arch/x86/include/asm/msr-index.h                   |   9 +-
>   arch/x86/kernel/alternative.c                      |  13 +
>   arch/x86/kernel/cpu/amd.c                          |   8 +
>   arch/x86/kernel/sev-es-shared.c                    |  53 +-
>   arch/x86/kernel/sev-es.c                           |  30 ++
>   arch/x86/kvm/lapic.c                               |   8 +-
>   drivers/acpi/irq.c                                 |   7 +-
>   drivers/acpi/resource.c                            | 121 ++++-
>   drivers/ata/libata-eh.c                            |   2 +-
>   drivers/base/regmap/regmap.c                       |   2 +-
>   drivers/bluetooth/hci_vhci.c                       |   3 +
>   drivers/counter/microchip-tcb-capture.c            |   2 +-
>   drivers/dma/mediatek/mtk-uart-apdma.c              |   3 +-
>   drivers/dma/stm32-mdma.c                           |   4 +
>   drivers/gpio/gpio-timberdale.c                     |   5 +-
>   drivers/gpio/gpio-vf610.c                          |   4 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c           |   9 +-
>   drivers/gpu/drm/drm_connector.c                    |  79 +++
>   drivers/gpu/drm/drm_crtc_internal.h                |   2 +
>   drivers/gpu/drm/drm_panel_orientation_quirks.c     |  16 +
>   drivers/gpu/drm/drm_sysfs.c                        |  87 +++-
>   drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  12 +-
>   drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  13 +-
>   drivers/gpu/drm/msm/dsi/dsi_host.c                 |  12 +
>   drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   2 +-
>   drivers/hid/hid-holtek-kbd.c                       |   4 +
>   drivers/hid/hid-logitech-hidpp.c                   |   3 +-
>   drivers/hid/hid-multitouch.c                       |   4 +
>   drivers/i2c/i2c-mux.c                              |   2 +-
>   drivers/iio/pressure/bmp280-core.c                 |   2 +-
>   drivers/iio/pressure/dps310.c                      |   8 +-
>   drivers/iio/pressure/ms5611_core.c                 |   2 +-
>   drivers/infiniband/hw/cxgb4/cm.c                   |   3 +
>   drivers/infiniband/ulp/srp/ib_srp.c                | 172 +++----
>   drivers/infiniband/ulp/srp/ib_srp.h                |   2 -
>   drivers/input/joystick/xpad.c                      |   2 +
>   drivers/input/misc/powermate.c                     |   1 +
>   drivers/input/mouse/elantech.c                     |   1 +
>   drivers/input/mouse/synaptics.c                    |   1 +
>   drivers/input/serio/i8042-acpipnpio.h              |   8 +
>   drivers/input/touchscreen/goodix.c                 |  19 +
>   drivers/mcb/mcb-core.c                             |  10 +-
>   drivers/mcb/mcb-parse.c                            |   2 -
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |   1 +
>   drivers/mmc/core/mmc.c                             |   2 +-
>   drivers/mmc/core/sdio.c                            |   8 +-
>   drivers/mtd/maps/physmap-core.c                    |  11 +
>   drivers/mtd/nand/raw/arasan-nand-controller.c      |  16 +-
>   drivers/mtd/nand/raw/marvell_nand.c                |  23 +-
>   drivers/mtd/nand/raw/qcom_nandc.c                  |   2 +-
>   drivers/mtd/nand/spi/micron.c                      |   2 +-
>   drivers/net/dsa/bcm_sf2.c                          |  24 +-
>   drivers/net/ethernet/intel/i40e/i40e_common.c      |   4 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c           |   3 +-
>   drivers/net/ethernet/intel/ice/ice_main.c          |  15 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   5 +-
>   drivers/net/ethernet/marvell/sky2.h                |   2 +-
>   .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
>   .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   4 +-
>   drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   7 +-
>   drivers/net/ethernet/renesas/ravb_main.c           |   6 +-
>   drivers/net/ieee802154/ca8210.c                    |  17 +-
>   drivers/net/macsec.c                               |   2 +
>   drivers/net/phy/mscc/mscc_macsec.c                 |   6 +
>   drivers/net/tun.c                                  |   7 +-
>   drivers/net/usb/dm9601.c                           |   7 +-
>   drivers/net/usb/smsc95xx.c                         |   2 +-
>   drivers/net/xen-netback/interface.c                |   3 -
>   drivers/nvme/host/pci.c                            |   3 +-
>   drivers/nvme/host/rdma.c                           |   3 +
>   drivers/nvme/target/tcp.c                          |   7 +-
>   drivers/perf/arm-cmn.c                             |   2 +-
>   drivers/phy/motorola/phy-mapphone-mdm6600.c        |  38 +-
>   drivers/pinctrl/renesas/Kconfig                    |   1 +
>   drivers/platform/x86/asus-nb-wmi.c                 |   3 +
>   drivers/platform/x86/asus-wmi.h                    |   2 +-
>   drivers/platform/x86/touchscreen_dmi.c             |  23 +
>   drivers/regulator/core.c                           |   6 +-
>   drivers/spi/spi-zynqmp-gqspi.c                     |  24 +-
>   drivers/tee/amdtee/core.c                          |  10 +-
>   drivers/thunderbolt/icm.c                          |  38 +-
>   drivers/thunderbolt/switch.c                       |   7 +
>   drivers/tty/serial/8250/8250_omap.c                |  93 ++--
>   drivers/usb/core/hcd.c                             |   6 +-
>   drivers/usb/core/hub.c                             | 106 +++-
>   drivers/usb/core/hub.h                             |   2 +-
>   drivers/usb/dwc3/core.c                            |  39 +-
>   drivers/usb/gadget/function/f_ncm.c                |  26 +-
>   drivers/usb/gadget/udc/udc-xilinx.c                |  20 +-
>   drivers/usb/host/xhci-hub.c                        | 228 ++++----
>   drivers/usb/host/xhci-mem.c                        |  10 +-
>   drivers/usb/host/xhci-ring.c                       |  17 +-
>   drivers/usb/host/xhci.h                            |   9 +-
>   drivers/usb/musb/musb_debugfs.c                    |   2 +-
>   drivers/usb/musb/musb_host.c                       |   9 +-
>   drivers/usb/serial/option.c                        |   7 +
>   drivers/usb/typec/altmodes/Kconfig                 |   1 +
>   drivers/usb/typec/altmodes/displayport.c           |  28 +
>   fs/btrfs/extent-tree.c                             |   6 +-
>   fs/btrfs/ioctl.c                                   |   4 +-
>   fs/btrfs/tree-log.c                                |   2 +-
>   fs/ceph/file.c                                     |   2 +-
>   fs/ceph/inode.c                                    |   4 +-
>   fs/nfs/pnfs.c                                      |  33 +-
>   fs/overlayfs/copy_up.c                             |   2 +-
>   fs/quota/dquot.c                                   |  66 ++-
>   include/drm/drm_connector.h                        |  25 +
>   include/linux/ioport.h                             |   7 +
>   include/linux/ipv6.h                               |   1 +
>   include/linux/mcb.h                                |   1 -
>   include/linux/netdevice.h                          |   2 +-
>   include/linux/perf_event.h                         |   1 +
>   include/linux/quota.h                              |   4 +-
>   include/linux/quotaops.h                           |   2 +-
>   include/linux/usb.h                                |   2 +
>   include/net/bluetooth/hci_core.h                   |   2 +-
>   include/net/bluetooth/hci_mon.h                    |   2 +-
>   include/net/ip_fib.h                               |   1 +
>   include/net/macsec.h                               |   1 +
>   include/net/netns/xfrm.h                           |   1 +
>   include/net/tcp.h                                  |   3 +
>   include/trace/events/neigh.h                       |   4 +-
>   include/uapi/linux/ipv6.h                          |   7 +
>   kernel/cgroup/cgroup-v1.c                          |   5 +-
>   kernel/events/core.c                               |  39 +-
>   kernel/trace/trace_events.c                        |   1 +
>   kernel/workqueue.c                                 |   8 +-
>   lib/Kconfig.debug                                  |   5 +-
>   lib/test_meminit.c                                 |   2 +-
>   mm/memory_hotplug.c                                |  16 +-
>   net/bluetooth/hci_conn.c                           |  72 ++-
>   net/bluetooth/hci_core.c                           |   8 +-
>   net/bluetooth/hci_event.c                          |  33 +-
>   net/bluetooth/hci_sock.c                           |   3 +-
>   net/ceph/messenger.c                               |   4 +-
>   net/core/pktgen.c                                  |  14 +-
>   net/ipv4/esp4.c                                    |   4 +-
>   net/ipv4/fib_semantics.c                           |  15 +-
>   net/ipv4/fib_trie.c                                |   4 +
>   net/ipv4/tcp_ipv4.c                                |   1 +
>   net/ipv4/tcp_output.c                              |  25 +-
>   net/ipv4/tcp_recovery.c                            |   2 +-
>   net/ipv6/addrconf.c                                |  13 +
>   net/ipv6/esp6.c                                    |   4 +-
>   net/ipv6/ndisc.c                                   |  13 +-
>   net/ipv6/xfrm6_policy.c                            |   4 +-
>   net/mac80211/tx.c                                  |   3 +-
>   net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
>   net/netfilter/nft_payload.c                        |   2 +-
>   net/netfilter/nft_set_rbtree.c                     |   2 +
>   net/nfc/llcp_core.c                                |  30 +-
>   net/nfc/nci/core.c                                 |   5 +
>   net/nfc/nci/spi.c                                  |   2 +
>   net/rds/tcp_connect.c                              |   2 +-
>   net/rds/tcp_listen.c                               |   2 +-
>   net/rfkill/rfkill-gpio.c                           |   4 +-
>   net/sched/sch_hfsc.c                               |  18 +-
>   net/socket.c                                       |   6 +-
>   net/wireless/nl80211.c                             |   2 +-
>   net/wireless/scan.c                                |   4 +
>   net/xfrm/xfrm_interface_core.c                     |  22 +-
>   net/xfrm/xfrm_policy.c                             |   6 +-
>   sound/soc/pxa/pxa-ssp.c                            |   2 +-
>   .../selftests/vm/charge_reserved_hugetlb.sh        |  34 +-
>   .../selftests/vm/hugetlb_reparenting_test.sh       |  21 +-
>   tools/testing/selftests/vm/write_hugetlb_memory.sh |   2 +-
>   187 files changed, 2095 insertions(+), 1183 deletions(-)
> 
> 
> .
> 

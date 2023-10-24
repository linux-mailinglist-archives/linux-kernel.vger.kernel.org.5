Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B823F7D4A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjJXIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjJXIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:37:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBAD1706;
        Tue, 24 Oct 2023 01:36:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB7C433C8;
        Tue, 24 Oct 2023 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698136614;
        bh=YdHURWSTwpg0lpeMFPomRuF7/Znm6L96MS5LFG+IXys=;
        h=From:To:Cc:Subject:Date:From;
        b=dOxiz3DEB3Bw2lKNT6RqHxUM/jydPdvP2fzziQm7Nk/lO5kBRQRTkejN8kffVu9mH
         MZlLnSpVUdEo7+TNTLd9rB7le6go61nHB7fQ1tfUOC4xOrcYq16GjSYXJZ3p0zzyAt
         kNGrbvijCbqNBqF83NXxMY6k3o3TTt+ikVhaTNB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/135] 5.15.137-rc2 review
Date:   Tue, 24 Oct 2023 10:36:50 +0200
Message-ID: <20231024083327.980887231@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.137-rc2
X-KernelTest-Deadline: 2023-10-26T08:33+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.137 release.
There are 135 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.137-rc2

Zhang Changzhong <zhangchangzhong@huawei.com>
    xfrm6: fix inet6_dev refcount underflow problem

Kees Cook <keescook@chromium.org>
    Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Edward AD <twuufnxlz@gmail.com>
    Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix runtime PM for remove

Tony Lindgren <tony@atomide.com>
    phy: mapphone-mdm6600: Fix runtime disable on probe

Geert Uytterhoeven <geert@linux-m68k.org>
    serial: 8250: omap: Move uart_write() inside PM section

Dan Carpenter <dan.carpenter@linaro.org>
    ASoC: pxa: fix a memory leak in probe()

Haibo Chen <haibo.chen@nxp.com>
    gpio: vf610: set value before the direction to avoid a glitch

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e

Armin Wolf <W_Armin@gmx.de>
    platform/surface: platform_profile: Propagate error if profile registration fails

Dinghao Liu <dinghao.liu@zju.edu.cn>
    s390/cio: fix a memleak in css_alloc_subchannel

Francis Laniel <flaniel@linux.microsoft.com>
    selftests/ftrace: Add new test case which checks non unique symbol

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: fix iommu bitmap allocation

Peter Zijlstra <peterz@infradead.org>
    perf: Disallow mis-matched inherited group reads

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Benoît Monin <benoit.monin@gmx.fr>
    USB: serial: option: add entry for Sierra EM9191 with new firmware

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Maurizio Lombardi <mlombard@redhat.com>
    nvme-rdma: do not try to stop unallocated queues

Keith Busch <kbusch@kernel.org>
    nvme-pci: add BOGUS_NID for Intel 0a54 device

Sunil V L <sunilvl@ventanamicro.com>
    ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Trond Myklebust <trond.myklebust@hammerspace.com>
    pNFS: Fix a hang in nfs4_evict_inode()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"

Avri Altman <avri.altman@wdc.com>
    mmc: core: Capture correct oemid-bits for eMMC cards

Haibo Chen <haibo.chen@nxp.com>
    mmc: core: sdio: hold retuning if sdio in 1-bit mode

Pablo Sun <pablo.sun@mediatek.com>
    mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Geert Uytterhoeven <geert+renesas@glider.be>
    mtd: physmap-core: Restore map_rom fallback

Martin Kurbanov <mmkurbanov@sberdevices.ru>
    mtd: spinand: micron: correct bitmask for ecc status

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: arasan: Ensure program page operations are successful

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: Ensure program page operations are successful

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: pl353: Ensure program page operations are successful

Bibek Kumar Patro <quic_bibekkum@quicinc.com>
    mtd: rawnand: qcom: Unmap the right resource upon probe failure

Jakub Kicinski <kuba@kernel.org>
    net: fix ifname in netlink ntf during netns move

Wolfram Sang <wsa+renesas@sang-engineering.com>
    net: move from strlcpy with unused retval to strscpy

Antoine Tenart <atenart@kernel.org>
    net: introduce a function to check if a netdev name is in use

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix using memcmp when comparing keys

Maher Sanalla <msanalla@nvidia.com>
    net/mlx5: Handle fw tracer change ownership event based on MTRC

Renan Guilherme Lebre Ramos <japareaggae@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Positivo C4128B

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Filipe Manana <fdmanana@suse.com>
    btrfs: error out when reallocating block for defrag using a stale transaction

Filipe Manana <fdmanana@suse.com>
    btrfs: error when COWing block from a root that is being deleted

Filipe Manana <fdmanana@suse.com>
    btrfs: error out when COWing block using a stale transaction

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Kai Uwe Broulik <foss-linux@broulik.de>
    drm: panel-orientation-quirks: Add quirk for One Mix 2S

Hangbin Liu <liuhangbin@gmail.com>
    ipv4/fib: send notify when delete source address routes

Kees Cook <keescook@chromium.org>
    sky2: Make sure there is at least one frag_addr available

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: avoid leaking stack data into trace

Wen Gong <quic_wgong@quicinc.com>
    wifi: mac80211: allow transmitting EAPOL frames with tainted key

Ilan Peer <ilan.peer@intel.com>
    wifi: cfg80211: Fix 6GHz scan configuration

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_core: Fix build warnings

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid redundant authentication

Rocky Liao <quic_rjliao@quicinc.com>
    Bluetooth: btusb: add shutdown function for QCA6174

Ma Ke <make_ruc2021@163.com>
    HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Ben Greear <greearb@candelatech.com>
    wifi: iwlwifi: Ensure ack flag is properly cleared.

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

Clément Léger <cleger@rivosinc.com>
    tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Fix compilation warning in ata_dev_config_ncq()

Chengfeng Ye <dg573847474@gmail.com>
    gpio: timberdale: Fix potential deadlock on &tgpio->lock

Jeff Layton <jlayton@kernel.org>
    overlayfs: set ctime when setting mtime and atime

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Josef Bacik <josef@toxicpanda.com>
    btrfs: initialize start_slot in btrfs_log_prealloc_extents

Filipe Manana <fdmanana@suse.com>
    btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1

Chunhai Guo <guochunhai@vivo.com>
    fs-writeback: do not requeue a clean inode having skipped pages

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: not allow to open file if delelete on close bit is set

Yanguo Li <yanguo.li@corigine.com>
    nfp: flower: avoid rmmod nfp crash issues

Jeremy Kerr <jk@codeconstruct.com.au>
    mctp: perform route lookups under a RCU read-side lock

Jeremy Kerr <jk@codeconstruct.com.au>
    mctp: Allow local delivery to the null EID

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/47x: Fix 47x syscall return crash

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/32s: Remove capability to disable KUEP at boottime

Simon Ser <contact@emersion.fr>
    drm/atomic-helper: relax unregistered connector check

JP Kobryn <inwardvessel@gmail.com>
    perf/x86/lbr: Filter vsyscall addresses

Sandipan Das <sandipan.das@amd.com>
    perf/x86: Move branch classifier

Anshuman Khandual <anshuman.khandual@arm.com>
    perf: Add irq and exception return branch types

Alisa-Dariana Roman <alisa.roman@analog.com>
    iio: adc: ad7192: Correct reference voltage

Tzung-Bi Shih <tzungbi@kernel.org>
    iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

Nuno Sá <nuno.sa@analog.com>
    iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs

Miquel Raynal <miquel.raynal@bootlin.com>
    iio: core: Hide read accesses to iio_dev->currentmode

Miquel Raynal <miquel.raynal@bootlin.com>
    iio: Un-inline iio_buffer_enabled()

Tony Lindgren <tony@atomide.com>
    serial: 8250_omap: Fix errors with no_console_suspend

Tony Lindgren <tony@atomide.com>
    serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()

Juntong Deng <juntong.deng@outlook.com>
    selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    net: pktgen: Fix interface flags printing

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not remove elements if set backend implements .abort

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: .deactivate fails if element has expired

Geert Uytterhoeven <geert+renesas@glider.be>
    neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Jiri Wiesner <jwiesner@suse.de>
    bonding: Return pointer to data after pull on skb

Jinjie Ruan <ruanjinjie@huawei.com>
    net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()

Michal Schmidt <mschmidt@redhat.com>
    i40e: prevent crash on probe if hw registers have invalid values

Dan Carpenter <dan.carpenter@linaro.org>
    net: usb: smsc95xx: Fix an error code in smsc95xx_reset()

Eric Dumazet <edumazet@google.com>
    ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Eric Dumazet <edumazet@google.com>
    tun: prevent negative ifindex

Eric Dumazet <edumazet@google.com>
    tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb

Neal Cardwell <ncardwell@google.com>
    tcp: fix excessive TLP and RACK timeouts from HZ rounding

Josua Mayer <josua@solid-run.com>
    net: rfkill: gpio: prevent value glitch during probe

Ma Ke <make_ruc2021@163.com>
    net: ipv6: fix return value check in esp_remove_trailer

Ma Ke <make_ruc2021@163.com>
    net: ipv4: fix return value check in esp_remove_trailer

Eric Dumazet <edumazet@google.com>
    xfrm: interface: use DEV_STATS_INC()

Eric Dumazet <edumazet@google.com>
    xfrm: fix a data-race in xfrm_gen_index()

Manish Chopra <manishc@marvell.com>
    qed: fix LL2 RX buffer allocation

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix unbind tear down order

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: drop bogus bind error handling

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Retry gtt fault when out of fence registers

Sagi Grimberg <sagi@grimberg.me>
    nvmet-tcp: Fix a possible UAF in queue intialization setup

Florian Westphal <fw@strlen.de>
    netfilter: nft_payload: fix wrong mac header matching

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: fix deadlock in mark_as_free_ex

Zeng Heng <zengheng4@huawei.com>
    fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Ziqi Zhao <astrajoan@yahoo.com>
    fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

Paolo Abeni <pabeni@redhat.com>
    tcp: check mptcp-level constraints for backlog coalescing

Joerg Roedel <jroedel@suse.de>
    x86/sev: Check for user-space IOIO pointing to kernel space

Joerg Roedel <jroedel@suse.de>
    x86/sev: Check IOBM for IOIO exceptions from user-space

Borislav Petkov (AMD) <bp@alien8.de>
    x86/sev: Disable MMIO emulation from user mode

Jim Mattson <jmattson@google.com>
    KVM: x86: Mask LVTPC when handling a PMI

Johan Hovold <johan+linaro@kernel.org>
    regmap: fix NULL deref on lookup

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: reset first in crash dump kernels

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix over-shifted variable

Arnd Bergmann <arnd@arndb.de>
    Bluetooth: avoid memcmp() out of bounds warning

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix coding style

Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
    Bluetooth: vhci: Fix race when opening vhci device

Ziyang Xuan <william.xuanziyang@huawei.com>
    Bluetooth: Fix a refcnt underflow problem for hci_conn

Lee, Chun-Yi <jlee@suse.com>
    Bluetooth: Reject connection with the device which has same BD_ADDR

Lee, Chun-Yi <jlee@suse.com>
    Bluetooth: hci_event: Ignore NULL link key

Darrick J. Wong <djwong@kernel.org>
    xfs: don't expose internal symlink metadata buffers to the vfs

Bagas Sanjaya <bagasdotme@gmail.com>
    Documentation: sysctl: align cells in second content column

Hyeonggon Yoo <42.hyeyoo@gmail.com>
    lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default


-------------

Diffstat:

 Documentation/admin-guide/sysctl/net.rst           |  18 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/motorola-mapphone-common.dtsi    |   1 +
 arch/powerpc/include/asm/book3s/32/kup.h           |  37 +--
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |  77 +++++-
 arch/powerpc/include/asm/interrupt.h               |   6 +-
 arch/powerpc/include/asm/kup.h                     |   5 -
 arch/powerpc/kernel/entry_32.S                     |  39 ++-
 arch/powerpc/kernel/head_32.h                      |   6 +
 arch/powerpc/kernel/head_book3s_32.S               |   4 +
 arch/powerpc/kernel/interrupt.c                    |   3 -
 arch/powerpc/mm/book3s32/kuep.c                    |  10 +-
 arch/s390/pci/pci_dma.c                            |  15 +-
 arch/x86/boot/compressed/sev.c                     |  10 +
 arch/x86/events/Makefile                           |   2 +-
 arch/x86/events/intel/lbr.c                        | 273 ---------------------
 arch/x86/events/perf_event.h                       |  62 +++++
 arch/x86/events/utils.c                            | 217 ++++++++++++++++
 arch/x86/kernel/sev-shared.c                       |  53 +++-
 arch/x86/kernel/sev.c                              |  30 +++
 arch/x86/kvm/lapic.c                               |   8 +-
 drivers/acpi/irq.c                                 |   7 +-
 drivers/ata/libata-core.c                          |   2 +-
 drivers/ata/libata-eh.c                            |   2 +-
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/bluetooth/hci_vhci.c                       |   3 +
 drivers/gpio/gpio-timberdale.c                     |   5 +-
 drivers/gpio/gpio-vf610.c                          |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  17 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  16 ++
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   1 +
 drivers/hid/hid-holtek-kbd.c                       |   4 +
 drivers/hid/hid-multitouch.c                       |   4 +
 drivers/i2c/i2c-mux.c                              |   2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   4 +-
 drivers/iio/adc/ad7192.c                           |  29 ++-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   4 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   6 +-
 drivers/iio/industrialio-core.c                    |  61 +++++
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/sdio.c                            |   8 +-
 drivers/mmc/host/mtk-sd.c                          |   6 +-
 drivers/mtd/maps/physmap-core.c                    |  11 +
 drivers/mtd/nand/raw/arasan-nand-controller.c      |  16 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  23 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c       |   9 +
 drivers/mtd/nand/raw/qcom_nandc.c                  |   2 +-
 drivers/mtd/nand/spi/micron.c                      |   2 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/dsa/bcm_sf2.c                          |  24 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  15 ++
 drivers/net/ethernet/marvell/sky2.h                |   2 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |  10 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  19 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +
 .../net/ethernet/netronome/nfp/flower/metadata.c   |   2 +
 .../net/ethernet/netronome/nfp/flower/offload.c    |  24 +-
 .../net/ethernet/netronome/nfp/flower/qos_conf.c   |  20 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   7 +-
 drivers/net/tun.c                                  |   7 +-
 drivers/net/usb/smsc95xx.c                         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   3 +
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  16 ++
 drivers/nvme/host/pci.c                            |   3 +-
 drivers/nvme/host/rdma.c                           |   3 +
 drivers/nvme/target/tcp.c                          |   7 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  38 ++-
 drivers/pinctrl/core.c                             |  16 +-
 .../platform/surface/surface_platform_profile.c    |   3 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   3 +
 drivers/platform/x86/asus-wmi.h                    |   2 +-
 drivers/platform/x86/touchscreen_dmi.c             |  23 ++
 drivers/regulator/core.c                           |   6 +-
 drivers/s390/cio/css.c                             |   6 +-
 drivers/tty/serial/8250/8250_omap.c                |  93 +++----
 drivers/usb/serial/option.c                        |   7 +
 fs/btrfs/ctree.c                                   |  52 +++-
 fs/btrfs/extent-tree.c                             |   6 +-
 fs/btrfs/ioctl.c                                   |   4 +-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/fs-writeback.c                                  |  11 +-
 fs/ksmbd/vfs_cache.c                               |   4 +-
 fs/nfs/nfs4proc.c                                  |   2 -
 fs/nfs/pnfs.c                                      |  33 ++-
 fs/ntfs3/fsntfs.c                                  |   6 +-
 fs/ntfs3/index.c                                   |   3 +
 fs/ntfs3/xattr.c                                   |   7 +-
 fs/overlayfs/copy_up.c                             |   2 +-
 fs/xfs/xfs_iops.c                                  |  34 +--
 fs/xfs/xfs_symlink.c                               |  29 ++-
 include/linux/iio/iio.h                            |  14 +-
 include/linux/netdevice.h                          |   1 +
 include/linux/perf_event.h                         |   1 +
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/bluetooth/hci_mon.h                    |   2 +-
 include/net/ip_fib.h                               |   1 +
 include/net/netns/xfrm.h                           |   1 +
 include/net/tcp.h                                  |   3 +
 include/trace/events/neigh.h                       |   4 +-
 include/uapi/linux/perf_event.h                    |   2 +
 kernel/events/core.c                               |  39 ++-
 kernel/trace/trace_events.c                        |   1 +
 lib/Kconfig.debug                                  |   5 +-
 net/bluetooth/hci_conn.c                           |  72 +++---
 net/bluetooth/hci_core.c                           |   8 +-
 net/bluetooth/hci_event.c                          |  33 ++-
 net/bluetooth/hci_sock.c                           |   3 +-
 net/core/dev.c                                     |  58 +++--
 net/core/drop_monitor.c                            |   2 +-
 net/core/netpoll.c                                 |   4 +-
 net/core/pktgen.c                                  |  14 +-
 net/ipv4/esp4.c                                    |   4 +-
 net/ipv4/fib_semantics.c                           |  15 +-
 net/ipv4/fib_trie.c                                |   4 +
 net/ipv4/tcp_ipv4.c                                |   1 +
 net/ipv4/tcp_output.c                              |  25 +-
 net/ipv4/tcp_recovery.c                            |   2 +-
 net/ipv6/esp6.c                                    |   4 +-
 net/ipv6/xfrm6_policy.c                            |   4 +-
 net/mac80211/tx.c                                  |   3 +-
 net/mctp/route.c                                   |  33 +++
 net/netfilter/nft_payload.c                        |   2 +-
 net/netfilter/nft_set_rbtree.c                     |   2 +
 net/nfc/nci/spi.c                                  |   2 +
 net/rfkill/rfkill-gpio.c                           |   4 +-
 net/sched/sch_hfsc.c                               |  18 +-
 net/wireless/nl80211.c                             |   2 +-
 net/wireless/scan.c                                |   4 +
 net/xfrm/xfrm_interface_core.c                     |  22 +-
 net/xfrm/xfrm_policy.c                             |   6 +-
 sound/soc/codecs/wcd938x-sdw.c                     |  27 +-
 sound/soc/codecs/wcd938x.c                         |   6 +-
 sound/soc/pxa/pxa-ssp.c                            |   2 +-
 tools/include/uapi/linux/perf_event.h              |   2 +
 tools/perf/util/branch.c                           |   4 +-
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |  13 +
 .../selftests/vm/charge_reserved_hugetlb.sh        |   4 +-
 .../selftests/vm/hugetlb_reparenting_test.sh       |   4 +-
 142 files changed, 1444 insertions(+), 747 deletions(-)



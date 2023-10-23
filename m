Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB5E7D335B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjJWL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjJWL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8407FD;
        Mon, 23 Oct 2023 04:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADD1C433C7;
        Mon, 23 Oct 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060558;
        bh=GIjJ81RijLgw0iAQ+XioElH9N5d+RlHnuuCo4+JiGs8=;
        h=From:To:Cc:Subject:Date:From;
        b=UocyAZ7TW/v0zMoA94YtAwhReEf3Jn+4r4UsHy2TeZ1Y2LM++524Ys4/AGWb4J9zx
         YyRY/S81QKcwdJprYKAMJPHHS3EzVBe8+xMJ93qw2v/FRmWmUJM0YWFqh2B5piZkMv
         SzwYbF7mov67u4LPyGniXilt7o/MyjLME+Q6OATk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/123] 5.4.259-rc1 review
Date:   Mon, 23 Oct 2023 12:55:58 +0200
Message-ID: <20231023104817.691299567@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.259-rc1
X-KernelTest-Deadline: 2023-10-25T10:48+00:00
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

This is the start of the stable review cycle for the 5.4.259 release.
There are 123 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.259-rc1

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

Haibo Chen <haibo.chen@nxp.com>
    gpio: vf610: mask the gpio irq in system suspend and support wakeup

Alexander Stein <alexander.stein@ew.tq-group.com>
    gpio: vf610: make irq_chip immutable

Dan Carpenter <dan.carpenter@linaro.org>
    ASoC: pxa: fix a memory leak in probe()

Haibo Chen <haibo.chen@nxp.com>
    gpio: vf610: set value before the direction to avoid a glitch

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

Sunil V L <sunilvl@ventanamicro.com>
    ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"

Avri Altman <avri.altman@wdc.com>
    mmc: core: Capture correct oemid-bits for eMMC cards

Haibo Chen <haibo.chen@nxp.com>
    mmc: core: sdio: hold retuning if sdio in 1-bit mode

Geert Uytterhoeven <geert+renesas@glider.be>
    mtd: physmap-core: Restore map_rom fallback

Martin Kurbanov <mmkurbanov@sberdevices.ru>
    mtd: spinand: micron: correct bitmask for ecc status

Bibek Kumar Patro <quic_bibekkum@quicinc.com>
    mtd: rawnand: qcom: Unmap the right resource upon probe failure

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix using memcmp when comparing keys

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Kai Uwe Broulik <foss-linux@broulik.de>
    drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kees Cook <keescook@chromium.org>
    sky2: Make sure there is at least one frag_addr available

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: avoid leaking stack data into trace

Wen Gong <quic_wgong@quicinc.com>
    wifi: mac80211: allow transmitting EAPOL frames with tainted key

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_core: Fix build warnings

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid redundant authentication

Ma Ke <make_ruc2021@163.com>
    HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Clément Léger <cleger@rivosinc.com>
    tracing: relax trace_event_eval_update() execution with cond_resched()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-eh: Fix compilation warning in ata_eh_link_report()

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

Tony Lindgren <tony@atomide.com>
    ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA

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

Tamim Khan <tamim@fusetak.com>
    ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA

Hui Wang <hui.wang@canonical.com>
    ACPI: resources: Add DMI-based legacy IRQ override quirk

John Garry <john.garry@huawei.com>
    ACPI: Drop acpi_dev_irqresource_disabled()

John Garry <john.garry@huawei.com>
    resource: Add irqresource_disabled()

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    net: pktgen: Fix interface flags printing

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: .deactivate fails if element has expired

Geert Uytterhoeven <geert+renesas@glider.be>
    neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

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

Florian Westphal <fw@strlen.de>
    netfilter: nft_payload: fix wrong mac header matching

Jim Mattson <jmattson@google.com>
    KVM: x86: Mask LVTPC when handling a PMI

Johan Hovold <johan+linaro@kernel.org>
    regmap: fix NULL deref on lookup

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

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

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    usb: hub: Guard against accesses to uninitialized BOS descriptors

Bagas Sanjaya <bagasdotme@gmail.com>
    Documentation: sysctl: align cells in second content column

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    dev_forward_skb: do not scrub skb mark within the same name space

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE

Duoming Zhou <duoming@zju.edu.cn>
    dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Piyush Mehta <piyush.mehta@amd.com>
    usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    pinctrl: avoid unsafe code pattern in find_pinctrl()

Michal Koutný <mkoutny@suse.com>
    cgroup: Remove duplicates in cgroup v1 tasks file

Matthias Berndt <matthias_berndt@gmx.de>
    Input: xpad - add PXN V900 support

Jeffery Miller <jefferymiller@google.com>
    Input: psmouse - fix fast_reconnect function for PS/2 mode

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    Input: powermate - fix use-after-free in powermate_config_complete

Xiubo Li <xiubli@redhat.com>
    ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

Jordan Rife <jrife@google.com>
    libceph: use kernel_connect()

Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
    mcb: remove is_added flag from mcb_device struct

Alexander Zangerl <az@breathe-safe.com>
    iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Lakshmi Yadlapati <lakshmiy@us.ibm.com>
    iio: pressure: dps310: Adjust Timeout Settings

Phil Elwell <phil@raspberrypi.com>
    iio: pressure: bmp280: Fix NULL pointer exception

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Modify the "HWVers" register address

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Get the musb_qh poniter after musb_giveback

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Soft reset phy on probe for host

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-mdma: abort resume if no ongoing transfer

Waiman Long <longman@redhat.com>
    workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Jeremy Cline <jeremy@jcline.org>
    nfc: nci: assert requested protocol is valid

Eric Dumazet <edumazet@google.com>
    net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Dan Carpenter <dan.carpenter@linaro.org>
    ixgbe: fix crash with empty VF macvlan list

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/vmwgfx: fix typo of sizeof argument

Roger Pau Monne <roger.pau@citrix.com>
    xen-netback: use default TX queue size for vifs

Dan Carpenter <dan.carpenter@linaro.org>
    mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix up dma_free_coherent() call in ravb_remove()

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dsi: skip the wait for video mode done if not applicable

Martin Fuzzey <martin.fuzzey@flowbird.group>
    drm: etvnaviv: fix bad backport leading to warning

Jordan Rife <jrife@google.com>
    net: prevent address rewrite in kernel_bind()

Jan Kara <jack@suse.cz>
    quota: Fix slow quotaoff

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: hibvt: Explicitly set .polarity in .get_state()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    lib/test_meminit: fix off-by-one error in test_pages()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    RDMA/cxgb4: Check skb value for failure to allocate


-------------

Diffstat:

 Documentation/admin-guide/sysctl/net.rst           |  18 +--
 Makefile                                           |   4 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   1 +
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   7 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   2 +
 arch/s390/pci/pci_dma.c                            |  15 ++-
 arch/x86/include/asm/msr-index.h                   |   4 +
 arch/x86/kernel/cpu/amd.c                          |   8 ++
 arch/x86/kvm/lapic.c                               |   8 +-
 drivers/acpi/irq.c                                 |   7 +-
 drivers/acpi/resource.c                            | 121 +++++++++++++++++++--
 drivers/ata/libata-eh.c                            |   2 +-
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/bluetooth/hci_vhci.c                       |   3 +
 drivers/dma/mediatek/mtk-uart-apdma.c              |   3 +-
 drivers/dma/stm32-mdma.c                           |   4 +
 drivers/gpio/gpio-timberdale.c                     |   5 +-
 drivers/gpio/gpio-vf610.c                          |  46 ++++----
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  16 +++
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |   2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  12 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   2 +-
 drivers/hid/hid-holtek-kbd.c                       |   4 +
 drivers/hid/hid-logitech-hidpp.c                   |   3 +-
 drivers/hid/hid-multitouch.c                       |   4 +
 drivers/i2c/i2c-mux.c                              |   2 +-
 drivers/iio/pressure/bmp280-core.c                 |   2 +-
 drivers/iio/pressure/dps310.c                      |   8 +-
 drivers/iio/pressure/ms5611_core.c                 |   2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   3 +
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/input/misc/powermate.c                     |   1 +
 drivers/input/mouse/elantech.c                     |   1 +
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/mcb/mcb-core.c                             |  10 +-
 drivers/mcb/mcb-parse.c                            |   2 -
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/sdio.c                            |   8 +-
 drivers/mtd/maps/physmap-core.c                    |  11 ++
 drivers/mtd/nand/raw/qcom_nandc.c                  |   2 +-
 drivers/mtd/nand/spi/micron.c                      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   5 +-
 drivers/net/ethernet/marvell/sky2.h                |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   7 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   6 +-
 drivers/net/ieee802154/ca8210.c                    |  17 +--
 drivers/net/tun.c                                  |   7 +-
 drivers/net/usb/dm9601.c                           |   7 +-
 drivers/net/usb/smsc95xx.c                         |   2 +-
 drivers/net/xen-netback/interface.c                |   3 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  38 +++----
 drivers/platform/x86/hp-wmi.c                      |   8 +-
 drivers/pwm/pwm-hibvt.c                            |   1 +
 drivers/regulator/core.c                           |   6 +-
 drivers/usb/core/hub.c                             |  28 ++++-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/dwc3/core.c                            |  39 ++++++-
 drivers/usb/gadget/function/f_ncm.c                |  26 +++--
 drivers/usb/gadget/udc/udc-xilinx.c                |  20 ++--
 drivers/usb/host/xhci-ring.c                       |   4 +-
 drivers/usb/musb/musb_debugfs.c                    |   2 +-
 drivers/usb/musb/musb_host.c                       |   9 +-
 drivers/usb/serial/option.c                        |   7 ++
 fs/btrfs/extent-tree.c                             |   6 +-
 fs/btrfs/ioctl.c                                   |   4 +-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/ceph/inode.c                                    |   4 +-
 fs/overlayfs/copy_up.c                             |   2 +-
 fs/quota/dquot.c                                   |  66 ++++++-----
 include/linux/ioport.h                             |   7 ++
 include/linux/mcb.h                                |   1 -
 include/linux/netdevice.h                          |   2 +-
 include/linux/perf_event.h                         |   1 +
 include/linux/quota.h                              |   4 +-
 include/linux/quotaops.h                           |   2 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/bluetooth/hci_mon.h                    |   2 +-
 include/net/netns/xfrm.h                           |   1 +
 include/net/tcp.h                                  |   3 +
 include/trace/events/neigh.h                       |   4 +-
 kernel/cgroup/cgroup-v1.c                          |   5 +-
 kernel/events/core.c                               |  39 ++++++-
 kernel/trace/trace_events.c                        |   1 +
 kernel/workqueue.c                                 |   8 +-
 lib/test_meminit.c                                 |   2 +-
 net/bluetooth/hci_conn.c                           |  72 +++++++-----
 net/bluetooth/hci_core.c                           |   8 +-
 net/bluetooth/hci_event.c                          |  33 +++++-
 net/bluetooth/hci_sock.c                           |   3 +-
 net/ceph/messenger.c                               |   4 +-
 net/core/pktgen.c                                  |  14 +--
 net/ipv4/esp4.c                                    |   4 +-
 net/ipv4/fib_semantics.c                           |  14 ++-
 net/ipv4/tcp_output.c                              |  25 ++++-
 net/ipv4/tcp_recovery.c                            |   2 +-
 net/ipv6/esp6.c                                    |   4 +-
 net/ipv6/xfrm6_policy.c                            |   4 +-
 net/mac80211/tx.c                                  |   3 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nft_payload.c                        |   2 +-
 net/netfilter/nft_set_rbtree.c                     |   2 +
 net/nfc/llcp_core.c                                |  30 ++---
 net/nfc/nci/core.c                                 |   5 +
 net/nfc/nci/spi.c                                  |   2 +
 net/rds/tcp_connect.c                              |   2 +-
 net/rds/tcp_listen.c                               |   2 +-
 net/rfkill/rfkill-gpio.c                           |   4 +-
 net/sched/sch_hfsc.c                               |  18 ++-
 net/socket.c                                       |   6 +-
 net/wireless/nl80211.c                             |   2 +-
 net/xfrm/xfrm_interface_core.c                     |  22 ++--
 net/xfrm/xfrm_policy.c                             |   6 +-
 sound/soc/pxa/pxa-ssp.c                            |   2 +-
 117 files changed, 757 insertions(+), 331 deletions(-)



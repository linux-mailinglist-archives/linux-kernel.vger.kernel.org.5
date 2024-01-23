Return-Path: <linux-kernel+bounces-35803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831638396C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8C71F256EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE18003C;
	Tue, 23 Jan 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+RHoEs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE6811F1;
	Tue, 23 Jan 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032012; cv=none; b=UrAnQloCBoTt43rduCz4mlEQMAbkjIK1BoLsOGowF7G1ROIi+w4veNwsn8pqihbpGzBG1snrTza/aLid7QMg9KfJ79h9AgOm96YKQZnHRttSWyEBHfBpfeyHBW0KSumuM3k+ME6YTfk4F8n9xIkhVMhsPHrA0hs5JfUz2ojjLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032012; c=relaxed/simple;
	bh=ZHJP0JRozgv9uSEY/5vICeUGtsYJN8u9vUnVXOAiBxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJwn72bFJboGxBRpcsg8JppQgb4ZKtH6IB3wFAqZJ/d9bjbMOFOmdI7+6Vy0KkrrBxSTzlv3jOolzkKXLrJfbjVF+6Ie4V/fesdRAKSh0xwvqvdbdHJZzcUWFuK9Cx7f3z6CLlMj9mvZcgE3d5x5PjBZEQXzuduXS9QTi3wE2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+RHoEs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8067C433C7;
	Tue, 23 Jan 2024 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706032011;
	bh=ZHJP0JRozgv9uSEY/5vICeUGtsYJN8u9vUnVXOAiBxo=;
	h=From:To:Cc:Subject:Date:From;
	b=C+RHoEs0ekBwpU+6wIaKp4KDIvQvn3No4HFoRXcAE4/FaBDJyjPk1CJggkQTx2NmA
	 sDboDCRQDB+m5idBcYavSJc5saWzmH6EICIBUiwu6t16UsUVV6Alo1mplSgi101CQb
	 lbj2mW1wmcuOi2/gECr6oG06VSDTRO6YaLUV8pvA=
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
Subject: [PATCH 5.15 000/371] 5.15.148-rc2 review
Date: Tue, 23 Jan 2024 09:46:45 -0800
Message-ID: <20240123174500.819179356@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.148-rc2
X-KernelTest-Deadline: 2024-01-25T17:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.148 release.
There are 371 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.148-rc2

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_quota: copy content when cloning expression

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_last: copy content when cloning expression

Phil Sutter <phil@nwl.cc>
    netfilter: nft_limit: Clone packet limits' cost value

Florian Westphal <fw@strlen.de>
    netfilter: nft_limit: fix stateful object memory leak

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_connlimit: memleak if nf_ct_netns_get() fails

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: typo NULL check in _clone() function

Matthew Wilcox (Oracle) <willy@infradead.org>
    block: Remove special-casing of compound pages

Marek Szyprowski <m.szyprowski@samsung.com>
    i2c: s3c24xx: fix transferring more than one message in polling mode

Marek Szyprowski <m.szyprowski@samsung.com>
    i2c: s3c24xx: fix read transfers in polling mode

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work

Amit Cohen <amcohen@nvidia.com>
    selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix stack corruption

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Reorder functions to avoid forward declarations

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Make fini symmetric to init

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Add missing mutex_destroy()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mlxsw: spectrum: Use 'bitmap_zalloc()' when applicable

Amit Cohen <amcohen@nvidia.com>
    mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure

Ludvig Pärsson <ludvig.parsson@axis.com>
    ethtool: netlink: Add missing ethnl_ops_begin/complete

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    kdb: Fix a potential buffer overflow in kdb_local()

Fedor Pchelkin <pchelkin@ispras.ru>
    ipvs: avoid stat macros calls from preemptible context

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject NFT_SET_CONCAT with not field length description

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip dead set elements in netlink dump

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not allow mismatch field size and set key length

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_limit: do not ignore unsupported flags

Vasily Averin <vasily.averin@linux.dev>
    netfilter: nf_tables: memcg accounting for dynamically allocated objects

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_limit: move stateful fields out of expression data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_limit: rename stateful structure

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_quota: move stateful fields out of expression data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_last: move stateful fields out of expression data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_connlimit: move stateful fields out of expression data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject invalid set policy

Kunwu Chan <chentao@kylinos.cn>
    net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Hao Sun <sunhao.th@gmail.com>
    bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS

Qiang Ma <maqianga@uniontech.com>
    net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    net: ravb: Fix dma_addr_t truncation in error case

Eric Dumazet <edumazet@google.com>
    mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()

Eric Dumazet <edumazet@google.com>
    mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()

Eric Dumazet <edumazet@google.com>
    mptcp: strict validation before using mp_opt->hmac

Geliang Tang <geliang.tang@suse.com>
    mptcp: drop unused sk in mptcp_get_options

Eric Dumazet <edumazet@google.com>
    mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: phy: micrel: populate .soft_reset for KSZ9131

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames

Lin Ma <linma@zju.edu.cn>
    net: qualcomm: rmnet: fix global oob in rmnet_policy

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: fix max size calculation in zpci_memcpy_toio()

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: keystone: Fix race condition when initializing PHYs

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: Fix the H2C expected PDU len calculation

Arnd Bergmann <arnd@arndb.de>
    nvmet: re-fix tracing strncpy() warning

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    serial: imx: Correct clock error message in function probe()

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer

Fedor Pchelkin <pchelkin@ispras.ru>
    apparmor: avoid crash when parsed profile name is empty

Ian Rogers <irogers@google.com>
    perf env: Avoid recursively taking env->bpf_progs.lock

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: fix a crash in nvmet_req_complete()

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length

Oliver Neukum <oneukum@suse.com>
    usb: cdc-acm: return correct error code on unsupported break

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    tty: use 'if' in send_break() instead of 'goto'

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    tty: don't check for signal_pending() in send_break()

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    tty: change tty_write_lock()'s ndelay parameter to bool

Namhyung Kim <namhyung@kernel.org>
    perf genelf: Set ELF program header addresses properly

Nuno Sa <nuno.sa@analog.com>
    iio: adc: ad9467: fix scale setting

Nuno Sa <nuno.sa@analog.com>
    iio: adc: ad9467: don't ignore error codes

Nuno Sa <nuno.sa@analog.com>
    iio: adc: ad9467: fix reset gpio handling

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    iio: adc: ad9467: Benefit from devm_clk_get_enabled() to simplify

Zhao Mengmeng <zhaomengmeng@kylinos.cn>
    selftests/sgx: Skip non X86_64 platform

Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
    selftests/sgx: Fix uninitialized pointer dereference in error path

Paul Geurts <paul_geurts@live.nl>
    serial: imx: fix tx statemachine deadlock

Sakari Ailus <sakari.ailus@linux.intel.com>
    software node: Let args be NULL in software_node_get_reference_args

Arnaldo Carvalho de Melo <acme@redhat.com>
    libapi: Add missing linux/types.h header to get the __u64 type on io.h

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed

Su Hui <suhui@nfschina.com>
    power: supply: bq256xx: fix some problem in bq256xx_hw_init

Jan Palus <jpalus@fastmail.com>
    power: supply: cw2015: correct time_to_empty units in sysfs

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix module_alloc() that did not reset the linear mapping permissions

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Check if the code to patch lies in the exit section

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix incorrect max_low_pfn adjustment

Serge Semin <fancer.lancer@gmail.com>
    mips: dmi: Fix early remap on MIPS32

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mfd: intel-lpss: Fix the fractional clock divider flags

Dang Huynh <danct12@riseup.net>
    leds: aw2013: Select missing dependency REGMAP_I2C

Kunwu Chan <chentao@kylinos.cn>
    mfd: syscon: Fix null pointer dereference in of_syscon_register()

Randy Dunlap <rdunlap@infradead.org>
    ARM: 9330/1: davinci: also select PINCTRL

Isaac J. Manjarres <isaacmanjarres@google.com>
    iommu/dma: Trace bounce buffer usage when mapping buffers

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: set safe default SPI clock frequency

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: add check for unsupported SPI modes during probe

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Correct behavior when processing some confidence == false touches

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Pass iio_dev to event handler

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic-v4: Restore pending state on host userspace write

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/kvm: Do not try to disable kvmclock if it was not enabled

qizhong cheng <qizhong.cheng@mediatek.com>
    PCI: mediatek: Clear interrupt status before dispatching handler

Niklas Cassel <niklas.cassel@wdc.com>
    PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: configure BSSID consistently when starting AP

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code

Christian Marangi <ansuelsmth@gmail.com>
    wifi: mt76: fix broken precal loading from MTD for mt7915

Rob Clark <robdclark@chromium.org>
    iommu/arm-smmu-qcom: Add missing GMU entry to match table

Jiri Olsa <olsajiri@gmail.com>
    bpf: Fix re-attachment branch in bpf_tracing_prog_attach

Gui-Dong Han <2045gemini@gmail.com>
    Bluetooth: Fix atomicity violation in {min,max}_key_size_set

Stefan Berger <stefanb@linux.ibm.com>
    rootfs: Fix support for rootfstype= when root= is given

Jens Axboe <axboe@kernel.dk>
    io_uring/rw: ensure io->bytes_done is always initialized

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: jz4740: Don't use dev_err_probe() in .request()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: check if catch-all set element is active in next generation

Min Li <min15.li@samsung.com>
    block: add check that partition length needs to be aligned with block size

Chandrakanth patil <chandrakanth.patil@broadcom.com>
    scsi: mpi3mr: Refresh sdev queue depth after controller reset

Nam Cao <namcao@linutronix.de>
    fbdev: flush deferred work in fb_deferred_io_fsync()

Çağhan Demir <caghandemir@marun.edu.tr>
    ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx

Takashi Iwai <tiwai@suse.de>
    ALSA: oxygen: Fix right channel of capture volume mixer

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    serial: imx: Ensure that imx_uart_rs485_config() is called with enabled clock

Gui-Dong Han <2045gemini@gmail.com>
    usb: mon: Fix atomicity violation in mon_bin_vma_fault

RD Babiera <rdbabiera@google.com>
    usb: typec: class: fix typec_altmode_put_partner to put plugs

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix iso transfer error when mult is not zero

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix uvc failure work since sg support enabled

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: wait controller resume finished for wakeup irq

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    Revert "usb: dwc3: Soft reset phy on probe for host"

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart

Xu Yang <xu.yang_2@nxp.com>
    usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_host()

Heiko Carstens <hca@linux.ibm.com>
    tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

Carlos Llamas <cmllamas@google.com>
    binder: fix race between mmput() and do_exit()

Jan Beulich <jbeulich@suse.com>
    xen-netback: don't produce zero-size SKB frags

Wei Yongjun <weiyongjun1@huawei.com>
    virtio-crypto: fix memory leak in virtio_crypto_alg_skcipher_close_session()

Ren Zhijie <renzhijie2@huawei.com>
    dma-mapping: Fix build error unused-value

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - use ab83 as id when skipping the getid command

Carlos Llamas <cmllamas@google.com>
    binder: fix unused alloc->free_async_space

Carlos Llamas <cmllamas@google.com>
    binder: fix async space check for 0-sized buffers

David Howells <dhowells@redhat.com>
    keys, dns: Fix size check of V1 server-list header

Jordan Rome <linux@jordanrome.com>
    selftests/bpf: Add assert for user stacks in test_task_stack

Geert Uytterhoeven <geert+renesas@glider.be>
    of: unittest: Fix of_count_phandle_with_args() expected value message

Christian A. Ehrhardt <lk@c--e.de>
    of: Fix double free in of_parse_phandle_with_args_map

Li Nan <linan122@huawei.com>
    ksmbd: validate the zero field of packet header

Zhipeng Lu <alexious@zju.edu.cn>
    drm/amd/pm/smu7: fix a memleak in smu7_hwmgr_backend_init

Sergey Gorenko <sergeygo@nvidia.com>
    IB/iser: Prevent invalidating wrong MR

Peter Robinson <pbrobinson@gmail.com>
    mmc: sdhci_omap: Fix TI SoC dependencies

Peter Robinson <pbrobinson@gmail.com>
    mmc: sdhci_am654: Fix TI SoC dependencies

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add clamp() in scarlett2_mixer_ctl_put()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add missing error checks to *_ctl_get()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Allow passing any output to line_out_remap()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add missing error check to scarlett2_usb_set_config()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add missing error check to scarlett2_config_save()

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5645: Drop double EF20 entry from dmi_platform_data[]

Philipp Zabel <p.zabel@pengutronix.de>
    pwm: stm32: Fix enable count for clk in .probe()

Philipp Zabel <p.zabel@pengutronix.de>
    pwm: stm32: Use hweight32 in stm32_pwm_detect_channels

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable

Théo Lebrun <theo.lebrun@bootlin.com>
    clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_hw

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: fixed-rate: add devm_clk_hw_register_fixed_rate

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: asm9260: use parent index to link the reference clock

Su Hui <suhui@nfschina.com>
    clk: si5341: fix an error code problem in si5341_output_clk_set_rate

Vignesh Raghavendra <vigneshr@ti.com>
    watchdog: rti_wdt: Drop runtime pm reference count when watchdog is unused

Stefan Wahren <wahrenst@gmx.net>
    watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO

Curtis Klein <curtis.klein@hpe.com>
    watchdog: set cdev owner before adding

Jay Buddhabhatti <jay.buddhabhatti@amd.com>
    drivers: clk: zynqmp: update divider round rate logic

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    clk: zynqmp: Add a check for NULL pointer

Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
    clk: zynqmp: make bestdiv unsigned

Jay Buddhabhatti <jay.buddhabhatti@amd.com>
    drivers: clk: zynqmp: calculate closest mux rate

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: videocc-sm8150: Add missing PLL config property

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: videocc-sm8150: Update the videocc resets

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    dt-bindings: clock: Update the videocc resets for sm8150

Zhipeng Lu <alexious@zju.edu.cn>
    gpu/drm/radeon: fix two memleaks in radeon_vm_init

Zhipeng Lu <alexious@zju.edu.cn>
    drivers/amd/pm: fix a use-after-free in kv_parse_power_table

Zhipeng Lu <alexious@zju.edu.cn>
    drm/amd/pm: fix a double-free in si_dpm_init

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/debugfs: fix error code when smc register accessors are NULL

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: dvb-frontends: m88ds3103: Fix a memory leak in an error handling path of m88ds3103_probe()

Dan Carpenter <dan.carpenter@linaro.org>
    media: dvbdev: drop refcount on error path in dvb_device_open()

Eric Biggers <ebiggers@google.com>
    f2fs: fix the f2fs_file_write_iter tracepoint

Chao Yu <chao@kernel.org>
    f2fs: fix to update iostat correctly in f2fs_filemap_fault()

Chao Yu <chao@kernel.org>
    f2fs: fix to check compress file in f2fs_move_file_range()

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: rkisp1: Disable runtime PM in probe error path

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config

Zhipeng Lu <alexious@zju.edu.cn>
    media: cx231xx: fix a memleak in cx231xx_init_isoc

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358767: Fix return value on error case

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: cdns-mhdp8546: Fix use of uninitialized variable

Zhipeng Lu <alexious@zju.edu.cn>
    drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table

Zhipeng Lu <alexious@zju.edu.cn>
    drm/radeon/dpm: fix a memleak in sumo_parse_power_table

Yang Yingliang <yangyingliang@huawei.com>
    drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/drv: propagate errors from drm_modeset_register_all()

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/mdp4: flush vblank event on disable

Linus Walleij <linus.walleij@linaro.org>
    ASoC: cs35l34: Fix GPIO name and drop legacy include

Linus Walleij <linus.walleij@linaro.org>
    ASoC: cs35l33: Fix GPIO name and drop legacy include

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: check return value of radeon_ring_lock()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid dirent corruption

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/bridge: Fix typo in post_disable() description

Ricardo B. Marliere <ricardo@marliere.net>
    media: pvrusb2: fix use after free on context disconnection

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tilcdc: Fix irq free on unload

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    drm/bridge: tpd12s015: Drop buggy __exit annotation for remove function

Abhinav Singh <singhabhinav9051571833@gmail.com>
    drm/nouveau/fence:: fix warning directly dereferencing a rcu pointer

Chris Morgan <macromorgan@hotmail.com>
    drm/panel-elida-kd35t133: hold panel in reset for unprepare

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix inappropriate err code for unsupported operations

Leon Romanovsky <leon@kernel.org>
    RDMA/usnic: Silence uninitialized symbol smatch warnings

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    Revert "drm/omapdrm: Annotate dma-fence critical section in commit path"

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    Revert "drm/tidss: Annotate dma-fence critical section in commit path"

Arnd Bergmann <arnd@arndb.de>
    ARM: davinci: always select CONFIG_CPU_ARM926T

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()

Asmaa Mnebhi <asmaa@nvidia.com>
    mlxbf_gige: Enable the GigE port in mlxbf_gige_open

Asmaa Mnebhi <asmaa@nvidia.com>
    net: mellanox: mlxbf_gige: Replace non-standard interrupt handling

Asmaa Mnebhi <asmaa@nvidia.com>
    mlxbf_gige: Fix intermittent no ip issue

Tao Liu <taoliu828@163.com>
    net/sched: act_ct: fix skb leak and crash on ooo frags

Christoph Hellwig <hch@lst.de>
    null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS

Keith Busch <kbusch@kernel.org>
    block: make BLK_DEF_MAX_SECTORS unsigned

Francesco Dolcini <francesco.dolcini@toradex.com>
    Bluetooth: btmtkuart: fix recv_buf() return value

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: mark newset as dead on transaction abort

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: send TX path flush in rfkill

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192se: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192de: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192c: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: add calculate_bit_shift()

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent

Li Nan <linan122@huawei.com>
    block: add check of 'minors' and 'first_minor' in device_add_disk()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8150-hdk: fix SS USB regulators

Atul Dhudase <quic_adhudase@quicinc.com>
    soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration

Joakim Zhang <joakim.zhang@cixtech.com>
    dma-mapping: clear dev->dma_mem to NULL after freeing it

Mark-PK Tsai <mark-pk.tsai@mediatek.com>
    dma-mapping: Add dma_release_coherent_memory to DMA API

Arseniy Krasnov <avkrasnov@salutedevices.com>
    virtio/vsock: fix logic which reduces credit update messages

Hangbin Liu <liuhangbin@gmail.com>
    selftests/net: fix grep checking for fib_nexthop_multiprefix

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Correct the number of global debugfs registers

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Rollback some operations if FLR failed

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Replace with standard error code return value

Qi Liu <liuqi115@huawei.com>
    scsi: hisi_sas: Prevent parallel FLR and controller reset

Luo Jiaxing <luojiaxing@huawei.com>
    scsi: hisi_sas: Rename HISI_SAS_{RESET -> RESETTING}_BIT

Li Nan <linan122@huawei.com>
    block: Set memalloc_noio to false on device_add_disk() error path

Andrei Matei <andreimatei1@gmail.com>
    bpf: Fix verification of indirect var-off stack access

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845-db845c: correct LED panic indicator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    scsi: fnic: Return error if vmalloc() failed

Andrii Nakryiko <andrii@kernel.org>
    bpf: fix check for attempt to corrupt spilled pointer

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: sdx65: correct SPMI node name

Andrii Nakryiko <andrii@kernel.org>
    bpf: enforce precision of R0 on callback return

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior

Dmitry Rokosov <ddrokosov@sberdevices.ru>
    firmware: meson_sm: populate platform devices from sm device tree data

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()

Peter Delevoryas <peter@pjd.dev>
    net/ncsi: Fix netlink major/minor version numbers

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: apq8064: correct XOADC register address

Arnd Bergmann <arnd@arndb.de>
    wifi: libertas: stop selecting wext

Luca Weiss <luca.weiss@fairphone.com>
    wifi: ath11k: Defer on rproc_get failure

Jordan Rome <jordalgo@meta.com>
    bpf: Add crosstask check to __bpf_get_stack

Florian Lehner <dev@der-flo.net>
    bpf, lpm: Fix check prefixlen before walking trie

Chih-Kang Chang <gary.chang@realtek.com>
    wifi: rtw88: fix RX filter in FIF_ALLMULTI flag

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT

Benjamin Coddington <bcodding@redhat.com>
    blocklayoutdriver: Fix reference leak of pnfs_device_node

Chengming Zhou <zhouchengming@bytedance.com>
    crypto: scomp - fix req->dst buffer overflow

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - do not resize req->src when doing hash operations

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix processing hash requests with req->nbytes < sg->length

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - improve error handling in sahara_sha_process()

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix wait_for_completion_timeout() error handling

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix ahash reqsize

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - handle zero-length aes requests

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - avoid skcipher fallback code duplication

wangyangxin <wangyangxin1@huawei.com>
    crypto: virtio - Wait for tasklet to complete on device remove

Osama Muhammad <osmtendev@gmail.com>
    gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Christian Brauner <brauner@kernel.org>
    fs: indicate request originates from old mount API

Sergey Shtylyov <s.shtylyov@omp.ru>
    pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix error handling in sahara_hw_descriptor_create()

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix processing requests with cryptlen < sg->length

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix ahash selftest failure

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix cbc selftest failure

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - remove FLAGS_NEW_KEY logic

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: af_alg - Disallow multiple in-flight AIO requests

Dinghao Liu <dinghao.liu@zju.edu.cn>
    crypto: ccp - fix memleak in ccp_init_dm_workarea

Chen Ni <nichen@iscas.ac.cn>
    crypto: sa2ul - Return crypto_aead_setkey to transfer the error

Gonglei (Arei) <arei.gonglei@huawei.com>
    crypto: virtio - Handle dataq logic with tasklet

Mickaël Salaün <mic@digikod.net>
    selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

ZhaoLong Wang <wangzhaolong1@huawei.com>
    mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Richard Fitzgerald <rf@opensource.cirrus.com>
    kunit: debugfs: Fix unchecked dereference in debugfs_print_results()

Tony Luck <tony.luck@intel.com>
    ACPI: extlog: Clear Extended Error Log status when RAS_CEC handled the error

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI: LPSS: Fix the fractional clock divider flags

Wolfram Sang <wsa+renesas@sang-engineering.com>
    spi: sh-msiof: Enforce fixed DTDL for R-Car H3

Ilias Apalodimas <ilias.apalodimas@linaro.org>
    efivarfs: force RO when remounting if SetVariable is not supported

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    calipso: fix memory leak in netlbl_calipso_add_pass()

Alexandra Diupina <adiupina@astralinux.ru>
    cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()

Rob Herring <robh@kernel.org>
    cpufreq: Use of_property_present() for testing DT property presence

Rob Herring <robh@kernel.org>
    of: Add of_property_present() helper

Michael Walle <michael@walle.cc>
    of: property: define of_property_read_u{8,16,32,64}_array() unconditionally

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPI: LPIT: Avoid u32 multiplication overflow

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPI: video: check for error while searching for backlight device parent

Ronald Monthero <debug.penguin32@gmail.com>
    mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
    spi: spi-zynqmp-gqspi: fix driver kconfig dependencies

Kunwu Chan <chentao@kylinos.cn>
    powerpc/imc-pmu: Add a null pointer check in update_events_in_group()

Kunwu Chan <chentao@kylinos.cn>
    powerpc/powernv: Add a null pointer check in opal_powercap_init()

Kunwu Chan <chentao@kylinos.cn>
    powerpc/powernv: Add a null pointer check in opal_event_init()

Kunwu Chan <chentao@kylinos.cn>
    powerpc/powernv: Add a null pointer check to scom_debug_init_one()

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Fix error handling in FPU/VMX preemption tests

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/pseries/memhp: Fix access beyond end of drmem array

Randy Dunlap <rdunlap@infradead.org>
    powerpc/44x: select I2C for CURRITUCK

Masahiro Yamada <masahiroy@kernel.org>
    powerpc: add crtsavres.o to always-y instead of extra-y

Masahiro Yamada <masahiroy@kernel.org>
    powerpc: remove checks for binutils older than 2.25

Alan Modra <amodra@au1.ibm.com>
    powerpc/toc: Future proof kernel toc

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc: Mark .opd section read-only

Arnd Bergmann <arnd@arndb.de>
    EDAC/thunderx: Fix possible out-of-bounds string access

Colin Ian King <colin.i.king@gmail.com>
    x86/lib: Fix overflow when counting digits

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

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    kprobes: Fix to handle forcibly unoptimized kprobes on freeing_list

Alan Maguire <alan.maguire@oracle.com>
    bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek"

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Jani Nikula <jani.nikula@intel.com>
    drm/crtc: fix uninitialized variable use

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: fix return code check of of_property_match_string

Sarannya S <quic_sarannya@quicinc.com>
    net: qrtr: ns: Return 0 if server port is not present

Matthew Wilcox (Oracle) <willy@infradead.org>
    ida: Fix crash in ida_free when the bitmap is empty

Jensen Huang <jensenhuang@friendlyarm.com>
    i2c: rk3x: fix potential spinlock recursion on poll

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346

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
    jbd2: correct the printing of write_flags in jbd2_write_superblock()

Weihao Li <cn.liweihao@gmail.com>
    clk: rockchip: rk3128: Fix HCLK_OTG gate register

Armin Wolf <W_Armin@gmx.de>
    hwmon: (corsair-psu) Fix probe when built-in

Inki Dae <inki.dae@samsung.com>
    drm/exynos: fix a wrong error checking

Xiang Yang <xiangyang3@huawei.com>
    drm/exynos: fix a potential error pointer dereference

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Add NULL checks for function pointers

Keith Busch <kbusch@kernel.org>
    nvme: introduce helper function to get ctrl state

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: ops: add correct range check for limiting volume

David Rau <David.Rau.opensource@dm.renesas.com>
    ASoC: da7219: Support low DC impedance headset

Thinh Tran <thinhtr@linux.vnet.ibm.com>
    net/tg3: fix race condition in tg3_reset_task()

Dave Airlie <airlied@redhat.com>
    nouveau/tu102: flush all pdbs on vmm flush

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

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: wm8974: Correct boost mixer inputs

Keith Busch <kbusch@kernel.org>
    nvme-core: check for too small lba shift

Lu Yao <yaolu@kylinos.cn>
    drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer

Johannes Berg <johannes.berg@intel.com>
    debugfs: fix automount d_fsdata usage

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

 Makefile                                           |   4 +-
 arch/arc/kernel/signal.c                           |   6 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |   2 +-
 arch/arm/mach-davinci/Kconfig                      |   2 +
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |  12 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   2 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   5 +
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  27 +-
 arch/mips/alchemy/devboards/db1200.c               |   2 +-
 arch/mips/alchemy/devboards/db1550.c               |   2 +-
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |   3 +-
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |   3 +-
 arch/mips/include/asm/dmi.h                        |   2 +-
 arch/mips/kernel/setup.c                           |   4 +-
 arch/powerpc/Makefile                              |  16 +-
 arch/powerpc/boot/crt0.S                           |   2 +-
 arch/powerpc/boot/zImage.lds.S                     |   7 +-
 arch/powerpc/include/asm/sections.h                |  16 +-
 arch/powerpc/kernel/head_64.S                      |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |  20 +-
 arch/powerpc/lib/Makefile                          |   4 +-
 arch/powerpc/perf/imc-pmu.c                        |   6 +
 arch/powerpc/platforms/44x/Kconfig                 |   1 +
 arch/powerpc/platforms/powernv/opal-irqchip.c      |   2 +
 arch/powerpc/platforms/powernv/opal-powercap.c     |   6 +
 arch/powerpc/platforms/powernv/opal-xscom.c        |   5 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   9 +-
 arch/riscv/include/asm/sections.h                  |   1 +
 arch/riscv/kernel/module.c                         |   3 +-
 arch/riscv/kernel/patch.c                          |  11 +-
 arch/riscv/kernel/vmlinux-xip.lds.S                |   2 +
 arch/riscv/kernel/vmlinux.lds.S                    |   2 +
 arch/s390/include/asm/pci_io.h                     |  32 ++-
 arch/s390/pci/pci_mmio.c                           |  12 +-
 arch/x86/kernel/kvmclock.c                         |  12 +-
 arch/x86/lib/misc.c                                |   2 +-
 block/bio.c                                        |   7 +-
 block/blk-settings.c                               |   2 +-
 block/genhd.c                                      |   5 +-
 block/ioctl.c                                      |  11 +-
 crypto/af_alg.c                                    |  14 +-
 crypto/scompress.c                                 |   6 +
 drivers/acpi/acpi_extlog.c                         |   7 +-
 drivers/acpi/acpi_lpit.c                           |   2 +-
 drivers/acpi/acpi_lpss.c                           |   3 +-
 drivers/acpi/acpi_video.c                          |  12 +-
 drivers/acpi/resource.c                            |   7 +
 drivers/android/binder.c                           |   2 +-
 drivers/android/binder_alloc.c                     |  32 +--
 drivers/base/swnode.c                              |   3 +
 drivers/block/null_blk/main.c                      |  13 +-
 drivers/bluetooth/btmtkuart.c                      |  11 +-
 drivers/clk/clk-asm9260.c                          |  29 +-
 drivers/clk/clk-fixed-rate.c                       |  28 +-
 drivers/clk/clk-si5341.c                           |   4 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |   4 +-
 drivers/clk/qcom/videocc-sm8150.c                  |   5 +
 drivers/clk/rockchip/clk-rk3128.c                  |   2 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |   2 +-
 drivers/clk/zynqmp/divider.c                       |  63 +----
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   4 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   7 +-
 drivers/cpufreq/tegra20-cpufreq.c                  |   2 +-
 drivers/crypto/ccp/ccp-ops.c                       |   5 +-
 drivers/crypto/sa2ul.c                             |   3 +-
 drivers/crypto/sahara.c                            | 248 ++++++++----------
 drivers/crypto/virtio/virtio_crypto_algs.c         |   2 +-
 drivers/crypto/virtio/virtio_crypto_common.h       |   2 +
 drivers/crypto/virtio/virtio_crypto_core.c         |  26 +-
 drivers/edac/thunderx_edac.c                       |  10 +-
 drivers/firmware/meson/meson_sm.c                  |   5 +-
 drivers/firmware/ti_sci.c                          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  12 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   6 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c          |   4 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          |   5 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    |   3 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |   4 +-
 drivers/gpu/drm/drm_crtc.c                         |   8 +-
 drivers/gpu/drm/drm_drv.c                          |  10 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   8 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   9 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +-
 drivers/gpu/drm/nouveau/nv04_fence.c               |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |   2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   9 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |   2 +
 drivers/gpu/drm/radeon/r100.c                      |   4 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |   4 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   7 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |   8 +-
 drivers/gpu/drm/radeon/si.c                        |   4 +
 drivers/gpu/drm/radeon/sumo_dpm.c                  |   4 +-
 drivers/gpu/drm/radeon/trinity_dpm.c               |   4 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   4 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   2 +-
 drivers/hid/wacom_wac.c                            |  32 +--
 drivers/hwmon/corsair-psu.c                        |  18 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 +-
 drivers/i2c/busses/i2c-rk3x.c                      |  13 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |  40 +--
 drivers/iio/adc/ad7091r-base.c                     |   6 +-
 drivers/iio/adc/ad9467.c                           | 114 +++++---
 drivers/iio/adc/adi-axi-adc.c                      |  74 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   2 +-
 drivers/infiniband/hw/mthca/mthca_cmd.c            |   4 +-
 drivers/infiniband/hw/mthca/mthca_main.c           |   2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |   2 -
 drivers/infiniband/ulp/iser/iser_initiator.c       |   5 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |   8 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |   1 -
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/input/keyboard/atkbd.c                     |  50 +++-
 drivers/input/serio/i8042-acpipnpio.h              |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 drivers/iommu/dma-iommu.c                          |   3 +
 drivers/leds/Kconfig                               |   1 +
 drivers/leds/trigger/ledtrig-tty.c                 |   4 +
 drivers/md/raid5.c                                 |  12 -
 drivers/media/dvb-core/dvbdev.c                    |   2 +
 drivers/media/dvb-frontends/m88ds3103.c            |   7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   3 +-
 drivers/media/usb/cx231xx/cx231xx-core.c           |   2 +
 drivers/media/usb/pvrusb2/pvrusb2-context.c        |   3 +-
 drivers/mfd/intel-lpss.c                           |   2 +-
 drivers/mfd/syscon.c                               |   4 +
 drivers/mmc/host/Kconfig                           |  10 +-
 drivers/mtd/mtd_blkdevs.c                          |   4 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   2 +
 drivers/net/ethernet/broadcom/tg3.c                |  11 +-
 drivers/net/ethernet/mellanox/mlxbf_gige/Makefile  |   1 -
 .../net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h  |  12 -
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c | 212 ---------------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  48 ++--
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   6 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_atcam.c   |   8 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |   8 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    | 131 +++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c |   9 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  11 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   5 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   5 +-
 drivers/net/phy/micrel.c                           |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  11 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +-
 drivers/net/wireless/marvell/libertas/Kconfig      |   2 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |   1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |   1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |   8 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  79 ++----
 drivers/net/wireless/realtek/rtlwifi/pci.h         |   5 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |  14 +-
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |  12 +-
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.h |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h   |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  15 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |  16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |  15 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   5 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   7 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   4 +-
 drivers/net/xen-netback/netback.c                  |  44 +++-
 drivers/nvme/host/core.c                           |   5 +-
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/target/tcp.c                          |  20 +-
 drivers/nvme/target/trace.h                        |   3 +-
 drivers/of/base.c                                  |   1 +
 drivers/of/unittest-data/tests-phandle.dtsi        |  10 +-
 drivers/of/unittest.c                              |  74 +++---
 drivers/parport/parport_serial.c                   |  64 +++++
 drivers/pci/controller/dwc/pci-keystone.c          |   9 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   1 +
 drivers/pci/controller/pcie-mediatek.c             |  10 +-
 drivers/pci/quirks.c                               |   8 +-
 drivers/pinctrl/cirrus/Kconfig                     |   3 +-
 drivers/platform/x86/intel/vbtn.c                  |  19 +-
 drivers/power/supply/bq256xx_charger.c             |   5 +-
 drivers/power/supply/cw2015_battery.c              |   2 +-
 drivers/pwm/pwm-jz4740.c                           |   7 +-
 drivers/pwm/pwm-stm32.c                            |  63 ++---
 drivers/reset/hisilicon/hi6220_reset.c             |   2 +-
 drivers/s390/block/scm_blk.c                       |   7 +-
 drivers/scsi/fnic/fnic_debugfs.c                   |   3 +-
 drivers/scsi/hisi_sas/hisi_sas.h                   |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |  22 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  20 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  10 +-
 drivers/soc/qcom/llcc-qcom.c                       |   8 +-
 drivers/spi/Kconfig                                |   3 +-
 drivers/spi/spi-sh-msiof.c                         |  17 ++
 drivers/tty/serial/8250/8250_omap.c                |   2 +-
 drivers/tty/serial/imx.c                           |  29 +-
 drivers/tty/serial/sc16is7xx.c                     |   8 +-
 drivers/tty/tty.h                                  |   2 +-
 drivers/tty/tty_io.c                               |  35 +--
 drivers/tty/tty_ioctl.c                            |   2 +-
 drivers/uio/uio.c                                  |   7 +-
 drivers/usb/cdns3/cdns3-gadget.c                   | 142 +++++++---
 drivers/usb/cdns3/cdns3-gadget.h                   |   3 +
 drivers/usb/chipidea/core.c                        |   7 +
 drivers/usb/class/cdc-acm.c                        |   3 +
 drivers/usb/dwc3/core.c                            |  39 +--
 drivers/usb/dwc3/ep0.c                             |   5 +-
 drivers/usb/host/xhci-mtk.c                        |  40 ++-
 drivers/usb/host/xhci-mtk.h                        |   2 +
 drivers/usb/mon/mon_bin.c                          |   7 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   3 +-
 drivers/usb/typec/class.c                          |   4 +-
 drivers/video/fbdev/core/fb_defio.c                |   6 +-
 drivers/watchdog/bcm2835_wdt.c                     |   3 +-
 drivers/watchdog/hpwdt.c                           |   2 +-
 drivers/watchdog/rti_wdt.c                         |  13 +-
 drivers/watchdog/watchdog_dev.c                    |   3 +-
 fs/debugfs/file.c                                  |   8 +
 fs/debugfs/inode.c                                 |  27 +-
 fs/debugfs/internal.h                              |  10 +-
 fs/efivarfs/super.c                                |  12 +
 fs/f2fs/file.c                                     |  12 +-
 fs/f2fs/namei.c                                    |   2 +-
 fs/f2fs/xattr.c                                    |   6 +
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/jbd2/commit.c                                   |   1 +
 fs/jbd2/journal.c                                  |   4 +-
 fs/ksmbd/smb_common.c                              |   6 +-
 fs/namespace.c                                     |  11 +
 fs/nfs/blocklayout/blocklayout.c                   |   2 +
 fs/nfs/nfs4proc.c                                  |   3 +
 fs/pstore/ram_core.c                               |   2 +-
 include/crypto/if_alg.h                            |   3 +
 include/drm/drm_bridge.h                           |   2 +-
 include/dt-bindings/clock/qcom,videocc-sm8150.h    |   4 +
 include/linux/blkdev.h                             |   3 +-
 include/linux/clk-provider.h                       |  52 +++-
 include/linux/dma-map-ops.h                        |   3 +
 include/linux/iio/adc/adi-axi-adc.h                |   4 +
 include/linux/of.h                                 | 291 ++++++++++-----------
 include/net/bluetooth/hci_core.h                   |   1 -
 include/trace/events/f2fs.h                        |  12 +-
 include/uapi/linux/bpf.h                           |   3 +
 init/do_mounts.c                                   |   9 +-
 io_uring/io_uring.c                                |   9 +-
 kernel/bpf/lpm_trie.c                              |   3 +
 kernel/bpf/stackmap.c                              |  11 +-
 kernel/bpf/syscall.c                               |   9 +
 kernel/bpf/verifier.c                              |  27 +-
 kernel/debug/kdb/kdb_main.c                        |   2 -
 kernel/dma/coherent.c                              |  12 +-
 kernel/kprobes.c                                   |  23 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   6 +
 kernel/trace/trace.c                               |  12 +-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events_hist.c                   |  12 +-
 kernel/trace/trace_output.c                        |   6 +-
 lib/idr.c                                          |   2 +-
 lib/kunit/debugfs.c                                |   4 +-
 lib/test_ida.c                                     |  40 +++
 net/bluetooth/hci_conn.c                           |   8 +-
 net/bluetooth/hci_debugfs.c                        |  12 +-
 net/bluetooth/hci_event.c                          |  11 +-
 net/core/neighbour.c                               |   9 +-
 net/dns_resolver/dns_key.c                         |   2 +-
 net/ethtool/features.c                             |   9 +-
 net/ipv6/ip6_tunnel.c                              |  26 +-
 net/ipv6/mcast.c                                   |   4 +
 net/mptcp/options.c                                |  12 +-
 net/mptcp/protocol.h                               |   3 +-
 net/mptcp/subflow.c                                |  18 +-
 net/ncsi/internal.h                                |   7 +-
 net/ncsi/ncsi-netlink.c                            |   4 +-
 net/ncsi/ncsi-pkt.h                                |   7 +-
 net/ncsi/ncsi-rsp.c                                |  26 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   4 +-
 net/netfilter/nf_tables_api.c                      |  29 +-
 net/netfilter/nft_connlimit.c                      |  37 ++-
 net/netfilter/nft_counter.c                        |   2 +-
 net/netfilter/nft_last.c                           |  73 ++++--
 net/netfilter/nft_limit.c                          | 199 ++++++++++----
 net/netfilter/nft_quota.c                          |  56 +++-
 net/netlabel/netlabel_calipso.c                    |  49 ++--
 net/qrtr/ns.c                                      |   4 +-
 net/sched/act_ct.c                                 |  12 +-
 net/vmw_vsock/virtio_transport_common.c            |  13 +-
 net/wireless/core.c                                |   2 +
 scripts/Makefile.compiler                          |   4 -
 scripts/pahole-flags.sh                            |   3 +
 security/apparmor/policy_unpack.c                  |   4 +
 security/selinux/hooks.c                           |   7 +
 sound/pci/hda/patch_realtek.c                      |  11 +
 sound/pci/oxygen/oxygen_mixer.c                    |   2 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |  61 +++++
 sound/soc/codecs/cs35l33.c                         |   4 +-
 sound/soc/codecs/cs35l34.c                         |   4 +-
 sound/soc/codecs/cs43130.c                         |   6 +-
 sound/soc/codecs/da7219-aad.c                      |   2 +-
 sound/soc/codecs/nau8822.c                         |   9 +-
 sound/soc/codecs/rt5645.c                          |  18 +-
 sound/soc/codecs/wm8974.c                          |   6 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  12 +
 sound/soc/intel/skylake/skl-pcm.c                  |   9 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   4 +-
 sound/soc/soc-ops.c                                |   2 +-
 sound/usb/mixer_scarlett_gen2.c                    | 223 ++++++++++------
 tools/include/uapi/linux/bpf.h                     |   3 +
 tools/lib/api/io.h                                 |   1 +
 tools/perf/util/bpf-event.c                        |   8 +-
 tools/perf/util/bpf-event.h                        |  12 +-
 tools/perf/util/env.c                              |  50 ++--
 tools/perf/util/env.h                              |   4 +
 tools/perf/util/genelf.c                           |   6 +-
 tools/perf/util/header.c                           |   8 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   2 +
 .../selftests/bpf/progs/bpf_iter_task_stack.c      |   5 +
 .../testing/selftests/drivers/net/mlxsw/qos_pfc.sh |  18 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      | 106 +++++++-
 .../selftests/net/fib_nexthop_multiprefix.sh       |   4 +-
 tools/testing/selftests/powerpc/math/fpu_preempt.c |   9 +-
 tools/testing/selftests/powerpc/math/vmx_preempt.c |  10 +-
 tools/testing/selftests/sgx/Makefile               |   2 +-
 tools/testing/selftests/sgx/sigstruct.c            |   5 +-
 349 files changed, 2951 insertions(+), 1999 deletions(-)




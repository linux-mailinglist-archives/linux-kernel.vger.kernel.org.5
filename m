Return-Path: <linux-kernel+bounces-35801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A851D8396C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F73B22D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610881218;
	Tue, 23 Jan 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dg9KvyOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C477F7DC;
	Tue, 23 Jan 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031991; cv=none; b=DVxsGeuaZLDSeJrq3xl1uOq/V8TBryQnXHqbliWF4ecsrxaYNUqwAmgV5bjiAYEsbGRQIVQABHRvXLjaETxpYCyLVIJB/vat8ONk8ciP8R/K3FhhiC5FrWX5ZegO4ArmBEH5Vl69U0cqZjw4fHtvIfc/vPSSZfqRyIf/UaoY7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031991; c=relaxed/simple;
	bh=V9JikhLSmlUW4Ou0M3e/Uw6kU9W5S6nSdIrEuxN7mq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZaeHM4wc/LXITnlx4P1I98wq2wFMwJPLEAL/M9fms5cz5A8FEYEznXsEtZhuyA4UlFND0ir9xonY6de/q3pNZZpVMpeR6tI4JDiNMo7TiSV9njSdRtdpmJQvYR942pyRpAispR1WsdTRpkJjNGyOzFBfDWn3uPv9t9iglXJw/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dg9KvyOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3101DC43390;
	Tue, 23 Jan 2024 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706031991;
	bh=V9JikhLSmlUW4Ou0M3e/Uw6kU9W5S6nSdIrEuxN7mq0=;
	h=From:To:Cc:Subject:Date:From;
	b=dg9KvyOiGPgCl6HBTjdTxvP89o/EKosXZRtyAFu/58uNeRWE5BbKMu13VbKSMtC2e
	 EZs4tWwyl77K5SfNGGQlcK8esjGzGkuAGUPsFRMJZHosG992a0auuCXVNobg7YcMne
	 /R0+f5z6XBDKFYvmZBkxhis3KeCNC362NfkVA+zY=
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
Subject: [PATCH 5.4 000/193] 5.4.268-rc2 review
Date: Tue, 23 Jan 2024 09:46:22 -0800
Message-ID: <20240123174434.819712739@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.268-rc2
X-KernelTest-Deadline: 2024-01-25T17:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.268 release.
There are 193 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Jan 2024 17:44:10 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.268-rc2

Tiezhu Yang <yangtiezhu@loongson.cn>
    perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set

Marek Szyprowski <m.szyprowski@samsung.com>
    i2c: s3c24xx: fix transferring more than one message in polling mode

Marek Szyprowski <m.szyprowski@samsung.com>
    i2c: s3c24xx: fix read transfers in polling mode

Amit Cohen <amcohen@nvidia.com>
    mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    kdb: Fix a potential buffer overflow in kdb_local()

Daniel Thompson <daniel.thompson@linaro.org>
    kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ

Fedor Pchelkin <pchelkin@ispras.ru>
    ipvs: avoid stat macros calls from preemptible context

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip dead set elements in netlink dump

Kunwu Chan <chentao@kylinos.cn>
    net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    net: ravb: Fix dma_addr_t truncation in error case

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: phy: micrel: populate .soft_reset for KSZ9131

Lin Ma <linma@zju.edu.cn>
    net: qualcomm: rmnet: fix global oob in rmnet_policy

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: fix max size calculation in zpci_memcpy_toio()

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: keystone: Fix race condition when initializing PHYs

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: Fix the H2C expected PDU len calculation

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    serial: imx: Correct clock error message in function probe()

Fedor Pchelkin <pchelkin@ispras.ru>
    apparmor: avoid crash when parsed profile name is empty

Ian Rogers <irogers@google.com>
    perf env: Avoid recursively taking env->bpf_progs.lock

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bpf: Decouple creating the evlist from adding the SB event

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf top: Move sb_evlist to 'struct perf_top'

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf record: Move sb_evlist to 'struct record'

Jiri Olsa <jolsa@kernel.org>
    perf env: Add perf_env__numa_node()

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: fix a crash in nvmet_req_complete()

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length

Namhyung Kim <namhyung@kernel.org>
    perf genelf: Set ELF program header addresses properly

Sakari Ailus <sakari.ailus@linux.intel.com>
    software node: Let args be NULL in software_node_get_reference_args

Sakari Ailus <sakari.ailus@linux.intel.com>
    acpi: property: Let args be NULL in __acpi_node_get_property_reference

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix incorrect max_low_pfn adjustment

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Correct behavior when processing some confidence == false touches

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/kvm: Do not try to disable kvmclock if it was not enabled

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: configure BSSID consistently when starting AP

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code

Stefan Berger <stefanb@linux.ibm.com>
    rootfs: Fix support for rootfstype= when root= is given

Nam Cao <namcao@linutronix.de>
    fbdev: flush deferred work in fb_deferred_io_fsync()

Takashi Iwai <tiwai@suse.de>
    ALSA: oxygen: Fix right channel of capture volume mixer

Gui-Dong Han <2045gemini@gmail.com>
    usb: mon: Fix atomicity violation in mon_bin_vma_fault

RD Babiera <rdbabiera@google.com>
    usb: typec: class: fix typec_altmode_put_partner to put plugs

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

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
    binder: fix unused alloc->free_async_space

Carlos Llamas <cmllamas@google.com>
    binder: fix race between mmput() and do_exit()

Jan Beulich <jbeulich@suse.com>
    xen-netback: don't produce zero-size SKB frags

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek"

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - use ab83 as id when skipping the getid command

Carlos Llamas <cmllamas@google.com>
    binder: fix use-after-free in shinker's callback

Carlos Llamas <cmllamas@google.com>
    binder: fix async space check for 0-sized buffers

Geert Uytterhoeven <geert+renesas@glider.be>
    of: unittest: Fix of_count_phandle_with_args() expected value message

Christian A. Ehrhardt <lk@c--e.de>
    of: Fix double free in of_parse_phandle_with_args_map

Peter Robinson <pbrobinson@gmail.com>
    mmc: sdhci_omap: Fix TI SoC dependencies

Su Hui <suhui@nfschina.com>
    clk: si5341: fix an error code problem in si5341_output_clk_set_rate

Stefan Wahren <wahrenst@gmx.net>
    watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO

Curtis Klein <curtis.klein@hpe.com>
    watchdog: set cdev owner before adding

Jay Buddhabhatti <jay.buddhabhatti@amd.com>
    drivers: clk: zynqmp: calculate closest mux rate

Zhipeng Lu <alexious@zju.edu.cn>
    gpu/drm/radeon: fix two memleaks in radeon_vm_init

Zhipeng Lu <alexious@zju.edu.cn>
    drivers/amd/pm: fix a use-after-free in kv_parse_power_table

Zhipeng Lu <alexious@zju.edu.cn>
    drm/amd/pm: fix a double-free in si_dpm_init

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/debugfs: fix error code when smc register accessors are NULL

Dan Carpenter <dan.carpenter@linaro.org>
    media: dvbdev: drop refcount on error path in dvb_device_open()

Zhipeng Lu <alexious@zju.edu.cn>
    media: cx231xx: fix a memleak in cx231xx_init_isoc

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358767: Fix return value on error case

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

Leon Romanovsky <leonro@nvidia.com>
    RDMA/usnic: Silence uninitialized symbol smatch warnings

Arnd Bergmann <arnd@arndb.de>
    ARM: davinci: always select CONFIG_CPU_ARM926T

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()

Francesco Dolcini <francesco.dolcini@toradex.com>
    Bluetooth: btmtkuart: fix recv_buf() return value

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: mark newset as dead on transaction abort

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192se: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8192de: using calculate_bit_shift()

Colin Ian King <colin.king@canonical.com>
    rtlwifi: rtl8192de: make arrays static const, makes object smaller

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

Joakim Zhang <joakim.zhang@cixtech.com>
    dma-mapping: clear dev->dma_mem to NULL after freeing it

Arseniy Krasnov <avkrasnov@salutedevices.com>
    virtio/vsock: fix logic which reduces credit update messages

Hangbin Liu <liuhangbin@gmail.com>
    selftests/net: fix grep checking for fib_nexthop_multiprefix

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Replace with standard error code return value

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845-db845c: correct LED panic indicator

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    scsi: fnic: Return error if vmalloc() failed

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior

Joe Perches <joe@perches.com>
    rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()

Peter Delevoryas <peter@pjd.dev>
    net/ncsi: Fix netlink major/minor version numbers

Bhaskar Chowdhury <unixbhaskar@gmail.com>
    ncsi: internal.h: Fix a spello

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: apq8064: correct XOADC register address

Arnd Bergmann <arnd@arndb.de>
    wifi: libertas: stop selecting wext

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

wangyangxin <wangyangxin1@huawei.com>
    crypto: virtio - Wait for tasklet to complete on device remove

Osama Muhammad <osmtendev@gmail.com>
    gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Sergey Shtylyov <s.shtylyov@omp.ru>
    pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix error handling in sahara_hw_descriptor_create()

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix processing requests with cryptlen < sg->length

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - fix ahash selftest failure

Ovidiu Panait <ovidiu.panait@windriver.com>
    crypto: sahara - remove FLAGS_NEW_KEY logic

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: af_alg - Disallow multiple in-flight AIO requests

Dinghao Liu <dinghao.liu@zju.edu.cn>
    crypto: ccp - fix memleak in ccp_init_dm_workarea

zhenwei pi <pizhenwei@bytedance.com>
    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC

Ram Muthiah <rammuthiah@google.com>
    crypto: virtio - don't use 'default m'

Gonglei (Arei) <arei.gonglei@huawei.com>
    crypto: virtio - Handle dataq logic with tasklet

Mickaël Salaün <mic@digikod.net>
    selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

ZhaoLong Wang <wangzhaolong1@huawei.com>
    mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Wolfram Sang <wsa+renesas@sang-engineering.com>
    spi: sh-msiof: Enforce fixed DTDL for R-Car H3

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    calipso: fix memory leak in netlbl_calipso_add_pass()

Zheng Yejian <zhengyejian1@huawei.com>
    netlabel: remove unused parameter in netlbl_netlink_auditinfo()

Andrew Lunn <andrew@lunn.ch>
    net: netlabel: Fix kerneldoc warnings

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPI: LPIT: Avoid u32 multiplication overflow

Nikita Kiryushin <kiryushin@ancud.ru>
    ACPI: video: check for error while searching for backlight device parent

Ronald Monthero <debug.penguin32@gmail.com>
    mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

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

Laurent Dufour <ldufour@linux.ibm.com>
    powerpc/pseries/memhotplug: Quieten some DLPAR operations

Randy Dunlap <rdunlap@infradead.org>
    powerpc/44x: select I2C for CURRITUCK

Masahiro Yamada <masahiroy@kernel.org>
    powerpc: add crtsavres.o to always-y instead of extra-y

Arnd Bergmann <arnd@arndb.de>
    EDAC/thunderx: Fix possible out-of-bounds string access

Colin Ian King <colin.i.king@gmail.com>
    x86/lib: Fix overflow when counting digits

James Clark <james.clark@arm.com>
    coresight: etm4x: Fix width of CCITMIN field

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
    binder: use EPOLLERR from eventpoll.h

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Jani Nikula <jani.nikula@intel.com>
    drm/crtc: fix uninitialized variable use

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: fix return code check of of_property_match_string

Matthew Wilcox (Oracle) <willy@infradead.org>
    ida: Fix crash in ida_free when the bitmap is empty

Luca Weiss <luca@z3ntu.xyz>
    Input: xpad - add Razer Wolverine V2 support

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

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Add size check when printing trace_marker output

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing

Judy Hsiao <judyhsiao@chromium.org>
    neighbour: Don't let neigh_forced_gc() disable preemption for long

Ziqi Zhao <astrajoan@yahoo.com>
    drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

Zhang Yi <yi.zhang@huawei.com>
    jbd2: correct the printing of write_flags in jbd2_write_superblock()

Weihao Li <cn.liweihao@gmail.com>
    clk: rockchip: rk3128: Fix HCLK_OTG gate register

Inki Dae <inki.dae@samsung.com>
    drm/exynos: fix a wrong error checking

Xiang Yang <xiangyang3@huawei.com>
    drm/exynos: fix a potential error pointer dereference

Keith Busch <kbusch@kernel.org>
    nvme: introduce helper function to get ctrl state

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
 arch/arm/mach-davinci/Kconfig                      |   1 +
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   2 +-
 arch/mips/alchemy/devboards/db1200.c               |   2 +-
 arch/mips/alchemy/devboards/db1550.c               |   2 +-
 arch/mips/kernel/setup.c                           |   4 +-
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/powerpc/perf/imc-pmu.c                        |   6 +
 arch/powerpc/platforms/44x/Kconfig                 |   1 +
 arch/powerpc/platforms/powernv/opal-irqchip.c      |   2 +
 arch/powerpc/platforms/powernv/opal-powercap.c     |   6 +
 arch/powerpc/platforms/powernv/opal-xscom.c        |   5 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  21 ++--
 arch/s390/include/asm/pci_io.h                     |  32 +++---
 arch/s390/pci/pci_mmio.c                           |  12 +-
 arch/x86/kernel/kvmclock.c                         |  12 +-
 arch/x86/lib/misc.c                                |   2 +-
 crypto/af_alg.c                                    |  14 ++-
 crypto/scompress.c                                 |   6 +
 drivers/acpi/acpi_lpit.c                           |   2 +-
 drivers/acpi/acpi_video.c                          |  12 +-
 drivers/acpi/property.c                            |   4 +
 drivers/acpi/resource.c                            |   7 ++
 drivers/android/binder.c                           |   2 +-
 drivers/android/binder_alloc.c                     |  29 ++---
 drivers/base/swnode.c                              |   3 +
 drivers/bluetooth/btmtkuart.c                      |  11 +-
 drivers/clk/clk-si5341.c                           |   4 +-
 drivers/clk/rockchip/clk-rk3128.c                  |   2 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |   2 +-
 drivers/crypto/ccp/ccp-ops.c                       |   5 +-
 drivers/crypto/sahara.c                            | 127 ++++++++-------------
 drivers/crypto/virtio/Kconfig                      |   1 -
 drivers/crypto/virtio/virtio_crypto_common.h       |   2 +
 drivers/crypto/virtio/virtio_crypto_core.c         |  26 +++--
 drivers/edac/thunderx_edac.c                       |  10 +-
 drivers/firmware/ti_sci.c                          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   5 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/drm_crtc.c                         |   8 +-
 drivers/gpu/drm/drm_drv.c                          |  10 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   8 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   9 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |   2 +-
 drivers/gpu/drm/radeon/r100.c                      |   4 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |   4 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   7 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |   8 +-
 drivers/gpu/drm/radeon/si.c                        |   4 +
 drivers/gpu/drm/radeon/sumo_dpm.c                  |   4 +-
 drivers/gpu/drm/radeon/trinity_dpm.c               |   4 +-
 drivers/hid/wacom_wac.c                            |  32 +-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |  40 ++++---
 drivers/infiniband/hw/mthca/mthca_cmd.c            |   4 +-
 drivers/infiniband/hw/mthca/mthca_main.c           |   2 +-
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/input/keyboard/atkbd.c                     |  50 +++++++-
 drivers/input/serio/i8042-x86ia64io.h              |   8 ++
 drivers/media/dvb-core/dvbdev.c                    |   2 +
 drivers/media/usb/cx231xx/cx231xx-core.c           |   2 +
 drivers/media/usb/pvrusb2/pvrusb2-context.c        |   3 +-
 drivers/mmc/host/Kconfig                           |   5 +-
 drivers/mtd/mtd_blkdevs.c                          |   4 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   2 +
 drivers/net/ethernet/broadcom/tg3.c                |  11 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |   8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/phy/micrel.c                           |   1 +
 drivers/net/wireless/marvell/libertas/Kconfig      |   2 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |   1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |   1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |   8 ++
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  79 +++----------
 drivers/net/wireless/realtek/rtlwifi/pci.h         |   5 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |  20 +---
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |  16 +--
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.h |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h   |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  66 ++++-------
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |  20 +---
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |  20 +---
 .../realtek/rtlwifi/rtl8723com/phy_common.c        |   8 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |  19 ++-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   7 ++
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   4 +-
 drivers/net/xen-netback/netback.c                  |  44 ++++++-
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/target/tcp.c                          |  20 +++-
 drivers/of/base.c                                  |   1 +
 drivers/of/unittest-data/tests-phandle.dtsi        |  10 +-
 drivers/of/unittest.c                              |  74 +++++++-----
 drivers/parport/parport_serial.c                   |  64 +++++++++++
 drivers/pci/controller/dwc/pci-keystone.c          |   9 ++
 drivers/pinctrl/cirrus/Kconfig                     |   3 +-
 drivers/reset/hisilicon/hi6220_reset.c             |   2 +-
 drivers/s390/block/scm_blk.c                       |   7 +-
 drivers/scsi/fnic/fnic_debugfs.c                   |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   2 +-
 drivers/spi/spi-sh-msiof.c                         |  17 +++
 drivers/tty/serial/8250/8250_omap.c                |   2 +-
 drivers/tty/serial/imx.c                           |   2 +-
 drivers/uio/uio.c                                  |   7 +-
 drivers/usb/chipidea/core.c                        |   7 ++
 drivers/usb/dwc3/core.c                            |  39 +------
 drivers/usb/dwc3/ep0.c                             |   5 +-
 drivers/usb/mon/mon_bin.c                          |   7 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   3 +-
 drivers/usb/typec/class.c                          |   4 +-
 drivers/video/fbdev/core/fb_defio.c                |   6 +-
 drivers/watchdog/bcm2835_wdt.c                     |   3 +-
 drivers/watchdog/hpwdt.c                           |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   3 +-
 fs/f2fs/namei.c                                    |   2 +-
 fs/f2fs/xattr.c                                    |   6 +
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/jbd2/journal.c                                  |   4 +-
 fs/nfs/blocklayout/blocklayout.c                   |   2 +
 fs/nfs/nfs4proc.c                                  |   3 +
 fs/pstore/ram_core.c                               |   2 +-
 include/crypto/if_alg.h                            |   3 +
 include/drm/drm_bridge.h                           |   2 +-
 include/net/bluetooth/hci_core.h                   |   1 -
 include/uapi/linux/virtio_crypto.h                 |   1 +
 init/do_mounts.c                                   |   9 +-
 kernel/bpf/lpm_trie.c                              |   3 +
 kernel/debug/kdb/kdb_main.c                        |  14 ++-
 kernel/dma/coherent.c                              |   4 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   6 +
 kernel/trace/trace.c                               |   6 +-
 kernel/trace/trace_output.c                        |   6 +-
 lib/idr.c                                          |   2 +-
 lib/test_ida.c                                     |  40 +++++++
 net/bluetooth/hci_conn.c                           |   8 +-
 net/bluetooth/hci_event.c                          |  11 +-
 net/core/neighbour.c                               |   9 +-
 net/ipv6/ip6_tunnel.c                              |  26 ++---
 net/ncsi/internal.h                                |   9 +-
 net/ncsi/ncsi-netlink.c                            |   4 +-
 net/ncsi/ncsi-pkt.h                                |   7 +-
 net/ncsi/ncsi-rsp.c                                |  26 ++++-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   4 +-
 net/netfilter/nf_tables_api.c                      |   3 +-
 net/netlabel/netlabel_calipso.c                    |  52 +++++----
 net/netlabel/netlabel_cipso_v4.c                   |   4 +-
 net/netlabel/netlabel_mgmt.c                       |   8 +-
 net/netlabel/netlabel_unlabeled.c                  |  10 +-
 net/netlabel/netlabel_user.h                       |   4 +-
 net/vmw_vsock/virtio_transport_common.c            |  13 ++-
 security/apparmor/policy_unpack.c                  |   4 +
 security/selinux/hooks.c                           |   7 ++
 sound/pci/hda/patch_realtek.c                      |  10 ++
 sound/pci/oxygen/oxygen_mixer.c                    |   2 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |  61 ++++++++++
 sound/soc/codecs/cs35l33.c                         |   4 +-
 sound/soc/codecs/cs35l34.c                         |   4 +-
 sound/soc/codecs/cs43130.c                         |   6 +-
 sound/soc/codecs/da7219-aad.c                      |   2 +-
 sound/soc/codecs/nau8822.c                         |   9 +-
 sound/soc/codecs/rt5645.c                          |  10 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   9 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   4 +-
 tools/perf/builtin-record.c                        |  23 +++-
 tools/perf/builtin-top.c                           |  22 +++-
 tools/perf/util/bpf-event.c                        |  11 +-
 tools/perf/util/bpf-event.h                        |  19 ++-
 tools/perf/util/env.c                              |  90 ++++++++++++---
 tools/perf/util/env.h                              |  10 ++
 tools/perf/util/evlist.c                           |  21 +---
 tools/perf/util/evlist.h                           |   2 +-
 tools/perf/util/genelf.c                           |   6 +-
 tools/perf/util/header.c                           |   8 +-
 tools/perf/util/top.h                              |   2 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      |  52 ++++++++-
 .../selftests/net/fib_nexthop_multiprefix.sh       |   4 +-
 tools/testing/selftests/powerpc/math/fpu_preempt.c |   9 +-
 tools/testing/selftests/powerpc/math/vmx_preempt.c |  10 +-
 191 files changed, 1277 insertions(+), 795 deletions(-)




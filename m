Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626C7C58B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbjJKP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJKP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:59:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8F8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so90830671fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697039940; x=1697644740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltjn3Lt7EQV82BDqOEJlo7CnaGvG5JyJ+R7vxVqiBw8=;
        b=ai7HISSjZ3TP3+Lg1rfxEZWtdt3m3H1J9x+A51qnblYSDkjEc1Jtci4a+GvPuECPCv
         jTJRbYvtf2YTQCDp56zQqRDTtj12fSkgWPs7QMweuvJw4Kc6bmEFM8aHBdmdeVOENoUJ
         FWlz6LgsNkp6TV+I5jLQ16enYzLvksI3sp+vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039940; x=1697644740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ltjn3Lt7EQV82BDqOEJlo7CnaGvG5JyJ+R7vxVqiBw8=;
        b=ThNwECeDH+thriOzmZoShHif0L3/pNmUiXbz3K23CQzBd+tBjsZnYGkSiOlMqLjb/q
         aSl4oxUUHzp7fbsfkCPdPBSJqO/pcGWkFoyvnNU473IrwoNKUsDc9ejreHtewV9c6r2T
         uIeDBgQBeoDk8Y6lBamRjmkSkF9rQr9ojyFWMcQZsb4RKAzjJnv9CdyExRw1GiuK/xii
         TcpeiSNAQEQzj0R/NvJPgdgUoaw4D6SV66kz0UzMqNYE8YLhKBQa478A1SDIZs1tNNfY
         LVytLWzp5M7HQMUbW51SXRvgHKPvHgOZE61Au/7kaGsuoS3uF7xOn6zxIr3NsoY1UvS5
         AujQ==
X-Gm-Message-State: AOJu0YyE+0eJaF7ObrULvFfwdrpAj4RdM1iCjaYlzzsB4eCwSWy6IMmY
        MtR9pwkhIxfSzxCkutWNtm/sLKLupjt7MWyUVPo7TRP3sfF9MKx5
X-Google-Smtp-Source: AGHT+IHNPjuPcuxjT4Qml0K2N91UMEeXR060F2+kbM8BYfusaO9pIba+8NviynqmkiYuseewLFinxNSsOl7klIou9Ws=
X-Received: by 2002:a2e:9cd3:0:b0:2bc:cee6:4342 with SMTP id
 g19-20020a2e9cd3000000b002bccee64342mr18386043ljj.13.1697039940106; Wed, 11
 Oct 2023 08:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175203.943277832@linuxfoundation.org>
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Oct 2023 11:58:49 -0400
Message-ID: <CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Sat, Oct 7, 2023 at 9:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.134-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
[...]
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     kernel/sched: Modify initial boot task idle setup
>

Let us drop this patch because it caused new tasks-RCU warnings (both
normal and rude tasks RCU) in my stable test rig. We are discussing
the "right fix" and at that time a backport can be done.

Hope Liam is also Ok with that. I am happy to do that future backport if ne=
eded.

Thanks,

 - Joel


> Heiner Kallweit <hkallweit1@gmail.com>
>     i2c: i801: unregister tco_pdev in i801_probe() error path
>
> Niklas Cassel <niklas.cassel@wdc.com>
>     ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION=
 CODES
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCe=
ntre M70q
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: disallow rule removal from chain binding
>
> Pan Bian <bianpan2016@163.com>
>     nilfs2: fix potential use after free in nilfs_gccache_submit_read_dat=
a()
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     serial: 8250_port: Check IRQ data before use
>
> Daniel Starke <daniel.starke@siemens.com>
>     Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"
>
> Ricky WU <ricky_wu@realtek.com>
>     misc: rtsx: Fix some platforms can not boot and move the l1ss judgmen=
t to probe
>
> Pu Wen <puwen@hygon.cn>
>     x86/srso: Add SRSO mitigation for Hygon processors
>
> Nicolin Chen <nicolinc@nvidia.com>
>     iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidat=
e_range
>
> Vishal Goel <vishal.goel@samsung.com>
>     Smack:- Use overlay inode label in smack_inode_copy_up()
>
> Roberto Sassu <roberto.sassu@huawei.com>
>     smack: Retrieve transmuting information in smack_inode_getsecurity()
>
> Roberto Sassu <roberto.sassu@huawei.com>
>     smack: Record transmuting in smk_transmuted
>
> Irvin Cote <irvin.cote@insa-lyon.fr>
>     nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev
>
> Gleb Chesnokov <gleb.chesnokov@scst.dev>
>     scsi: qla2xxx: Fix NULL pointer dereference in target mode
>
> Ian Rogers <irogers@google.com>
>     perf metric: Return early if no CPU PMU table exists
>
> Andrii Staikov <andrii.staikov@intel.com>
>     i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vs=
i_filters()
>
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already runn=
ing
>
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     watchdog: iTCO_wdt: No need to stop the timer in probe
>
> Pratyush Yadav <ptyadav@amazon.de>
>     nvme-pci: do not set the NUMA node of device if it has none
>
> Christoph Hellwig <hch@lst.de>
>     nvme-pci: factor out a nvme_pci_alloc_dev helper
>
> Christoph Hellwig <hch@lst.de>
>     nvme-pci: factor the iod mempool creation into a helper
>
> Chengming Zhou <zhouchengming@bytedance.com>
>     cgroup: Fix suspicious rcu_dereference_check() usage warning
>
> Chengming Zhou <zhouchengming@bytedance.com>
>     sched/cpuacct: Optimize away RCU read lock
>
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     perf build: Define YYNOMEM as YYNOABORT for bison < 3.81
>
> Thomas Zimmermann <tzimmermann@suse.de>
>     fbdev/sh7760fb: Depend on FB=3Dy
>
> Johnathan Mantey <johnathanx.mantey@intel.com>
>     ncsi: Propagate carrier gain/loss events to the NCSI controller
>
> Benjamin Gray <bgray@linux.ibm.com>
>     powerpc/watchpoints: Annotate atomic context in more places
>
> Benjamin Gray <bgray@linux.ibm.com>
>     powerpc/watchpoint: Disable pagefaults when getting user instruction
>
> Benjamin Gray <bgray@linux.ibm.com>
>     powerpc/watchpoints: Disable preemption in thread_change_pc()
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: vb2: frame_vector.c: replace WARN_ONCE with a comment
>
> Chancel Liu <chancel.liu@nxp.com>
>     ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link
>
> Stanislav Fomichev <sdf@google.com>
>     bpf: Clarify error expectations from bpf_clone_redirect
>
> Shengjiu Wang <shengjiu.wang@nxp.com>
>     ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag
>
> Valentin Caron <valentin.caron@foss.st.com>
>     spi: stm32: add a delay before SPI disable
>
> Han Xu <han.xu@nxp.com>
>     spi: nxp-fspi: reset the FLSHxCR1 registers
>
> Niklas Cassel <niklas.cassel@wdc.com>
>     ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
>
> Steve French <stfrench@microsoft.com>
>     smb3: correct places where ENOTSUPP is used instead of preferred EOPN=
OTSUPP
>
> Michal Grzedzicki <mge@meta.com>
>     scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLL=
ER_CONFIG command
>
> Michal Grzedzicki <mge@meta.com>
>     scsi: pm80xx: Use phy-specific SAS address when sending PHY_START com=
mand
>
> David Francis <David.Francis@amd.com>
>     drm/amdgpu: Handle null atom context in VBIOS info ioctl
>
> Swapnil Patel <swapnil.patel@amd.com>
>     drm/amd/display: Don't check registers, if using AUX BL control
>
> David Thompson <davthompson@nvidia.com>
>     platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     ring-buffer: Do not attempt to read past "commit"
>
> Ricardo B. Marliere <rbmarliere@gmail.com>
>     selftests: fix dependency checker script
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: improve error message after failure to add delayed dir index i=
tem
>
> Zheng Yejian <zhengyejian1@huawei.com>
>     ring-buffer: Avoid softlockup in ring_buffer_resize()
>
> Zheng Yejian <zhengyejian1@huawei.com>
>     selftests/ftrace: Correctly enable event in instance-event.tc
>
> Kiwoong Kim <kwmad.kim@samsung.com>
>     scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock
>
> Javed Hasan <jhasan@marvell.com>
>     scsi: qedf: Add synchronization between I/O completions and abort
>
> Helge Deller <deller@gmx.de>
>     parisc: irq: Make irq_stack_union static to avoid sparse warning
>
> Helge Deller <deller@gmx.de>
>     parisc: drivers: Fix sparse warning
>
> Helge Deller <deller@gmx.de>
>     parisc: iosapic.c: Fix sparse warnings
>
> Helge Deller <deller@gmx.de>
>     parisc: sba: Fix compile warning wrt list of SBA devices
>
> Tobias Schramm <t.schramm@manjaro.org>
>     spi: sun6i: fix race between DMA RX transfer completion and RX FIFO d=
rain
>
> Tobias Schramm <t.schramm@manjaro.org>
>     spi: sun6i: reduce DMA RX transfer width to single byte
>
> Sergey Senozhatsky <senozhatsky@chromium.org>
>     dma-debug: don't call __dma_entry_alloc_check_leak() under free_entri=
es_lock
>
> William A. Kennington III <william@wkennington.com>
>     i2c: npcm7xx: Fix callback completion ordering
>
> Wenhua Lin <Wenhua.Lin@unisoc.com>
>     gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip
>
> Nathan Rossi <nathan.rossi@digi.com>
>     soc: imx8m: Enable OCOTP clock for imx8mm before reading registers
>
> Max Filippov <jcmvbkbc@gmail.com>
>     xtensa: boot/lib: fix function prototypes
>
> Randy Dunlap <rdunlap@infradead.org>
>     xtensa: boot: don't add include-dirs
>
> Randy Dunlap <rdunlap@infradead.org>
>     xtensa: iss/network: make functions static
>
> Max Filippov <jcmvbkbc@gmail.com>
>     xtensa: add default definition for XCHAL_HAVE_DIV32
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channe=
ls()
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     power: supply: ucs1002: fix error code in ucs1002_get_property()
>
> Tony Lindgren <tony@atomide.com>
>     bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-u=
p
>
> Tony Lindgren <tony@atomide.com>
>     ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boo=
t
>
> Tony Lindgren <tony@atomide.com>
>     ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: omap: correct indentation
>
> Thomas Gleixner <tglx@linutronix.de>
>     treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.=
RULE (part 1)
>
> Timo Alho <talho@nvidia.com>
>     clk: tegra: fix error return case for recalc_rate
>
> Adam Ford <aford173@gmail.com>
>     bus: ti-sysc: Fix missing AM35xx SoC matching
>
> Julien Panis <jpanis@baylibre.com>
>     bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
>
> Marek Vasut <marex@denx.de>
>     drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA and EOT packet
>
> Christoph Hellwig <hch@lst.de>
>     MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
>
> Qu Wenruo <wqu@suse.com>
>     btrfs: reset destination buffer when read_extent_buffer() gets invali=
d range
>
> Nilesh Javali <njavali@marvell.com>
>     scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id=
()
>
> Shreyas Deodhar <sdeodhar@marvell.com>
>     scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets ca=
lled
>
> Werner Fischer <devlists@wefi.net>
>     ata: ahci: Add Elkhart Lake AHCI controller
>
> Mario Limonciello <mario.limonciello@amd.com>
>     ata: ahci: Rename board_ahci_mobile
>
> Paul Menzel <pmenzel@molgen.mpg.de>
>     ata: ahci: Add support for AMD A85 FCH (Hudson D4)
>
> Paul Menzel <pmenzel@molgen.mpg.de>
>     ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
>
> Xiao Liang <shaw.leon@gmail.com>
>     netfilter: nft_exthdr: Fix non-linear header modification
>
> Florian Westphal <fw@strlen.de>
>     netfilter: exthdr: add support for tcp option removal
>
> Namhyung Kim <namhyung@kernel.org>
>     perf build: Update build rule for generated files
>
> Ian Rogers <rogers.email@gmail.com>
>     perf jevents: Switch build to use jevents.py
>
> Werner Sembach <wse@tuxedocomputers.com>
>     Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN
>
> Huacai Chen <chenhuacai@kernel.org>
>     Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: fix xfs_inodegc_stop racing with mod_delayed_work
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: disable reaping in fscounters scrub
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: check that per-cpu inodegc workers actually run on that cpu
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: explicitly specify cpu when forcing inodegc delayed work to run =
immediately
>
> Dave Chinner <dchinner@redhat.com>
>     xfs: introduce xfs_inodegc_push()
>
> Dave Chinner <dchinner@redhat.com>
>     xfs: bound maximum wait time for inodegc work
>
> Liang He <windhl@126.com>
>     i2c: mux: gpio: Add missing fwnode_handle_put()
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     i2c: mux: gpio: Replace custom acpi_get_local_address()
>
> Xiaoke Wang <xkernel.wang@foxmail.com>
>     i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
>
> Sasha Levin <sashal@kernel.org>
>     Fix up backport of 136191703038 ("interconnect: Teach lockdep about i=
cc_bw_lock order")
>
> Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>     igc: Expose tx-usecs coalesce setting to user
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     net: ena: Flush XDP packets on error.
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     locking/seqlock: Do the lockdep annotation before locking in do_write=
_seqcount_begin_nested()
>
> Jozsef Kadlecsik <kadlec@netfilter.org>
>     netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWA=
P
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: disable toggling dormant table state more than =
once
>
> Artem Chernyshev <artem.chernyshev@red-soft.ru>
>     net: rds: Fix possible NULL-pointer dereference
>
> Ziyang Xuan <william.xuanziyang@huawei.com>
>     team: fix null-ptr-deref when team device type is changed
>
> Eric Dumazet <edumazet@google.com>
>     net: bridge: use DEV_STATS_INC()
>
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: add 5ms delay before clear firmware reset irq source
>
> Jijie Shao <shaojijie@huawei.com>
>     net: hns3: fix fail to delete tc flower rules during reset issue
>
> Jian Shen <shenjian15@huawei.com>
>     net: hns3: only enable unicast promisc when mac table full
>
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: fix GRE checksum offload issue
>
> Josh Poimboeuf <jpoimboe@kernel.org>
>     x86/srso: Fix SBPB enablement for spec_rstack_overflow=3Doff
>
> Josh Poimboeuf <jpoimboe@kernel.org>
>     x86/srso: Fix srso_show_state() side effect
>
> Stephen Boyd <swboyd@chromium.org>
>     platform/x86: intel_scu_ipc: Fail IPC send if still busy
>
> Stephen Boyd <swboyd@chromium.org>
>     platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_=
simple_command()
>
> Stephen Boyd <swboyd@chromium.org>
>     platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_fo=
r_interrupt()
>
> Stephen Boyd <swboyd@chromium.org>
>     platform/x86: intel_scu_ipc: Check status after timeout in busy_loop(=
)
>
> Eric Dumazet <edumazet@google.com>
>     dccp: fix dccp_v4_err()/dccp_v6_err() again
>
> Kajol Jain <kjain@linux.ibm.com>
>     powerpc/perf/hv-24x7: Update domain value check
>
> Kyle Zeng <zengyhkyle@gmail.com>
>     ipv4: fix null-deref in ipv4_link_failure
>
> Vinicius Costa Gomes <vinicius.gomes@intel.com>
>     igc: Fix infinite initialization loop with early XDP redirect
>
> David Christensen <drc@linux.vnet.ibm.com>
>     ionic: fix 16bit math issue when PAGE_SIZE >=3D 64KB
>
> Ivan Vecera <ivecera@redhat.com>
>     i40e: Fix VF VLAN offloading when port VLAN is configured
>
> Mateusz Palczewski <mateusz.palczewski@intel.com>
>     i40e: Add VF VLAN pruning
>
> Radoslaw Tyl <radoslawx.tyl@intel.com>
>     iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set
>
> Shengjiu Wang <shengjiu.wang@nxp.com>
>     ASoC: imx-audmix: Fix return error with devm_clk_get()
>
> Sasha Neftin <sasha.neftin@intel.com>
>     net/core: Fix ETH_P_1588 flow dissector
>
> Sabrina Dubroca <sd@queasysnail.net>
>     selftests: tls: swap the TX and RX sockets in some tests
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>     bpf: Avoid deadlock when using queue and stack maps from NMI
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: disallow element removal on anonymous sets
>
> Jerome Brunet <jbrunet@baylibre.com>
>     ASoC: meson: spdifin: start hw on dai probe
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix memleak when more than 255 elements expired
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_pipapo: stop GC iteration if GC transaction alloca=
tion fails
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall=
 GC
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_rbtree: use read spinlock to avoid datapath conten=
tion
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_rbtree: skip sync GC for new elements in this tran=
saction
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: defer gc run if previous batch is still pending
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: use correct lock to protect gc_list
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction race with abort path
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction race with netns dismantle
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: fix GC transaction races with netns and netlink=
 event exit path
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: don't fail inserts if duplicate has expired
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: remove busy mark and gc batch API
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_hash: mark set element as dead when deleting from =
packet path
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: adapt set backend to use GC transaction API
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction API to avoid race with control p=
lane
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: don't skip expired elements during walk
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Have event inject files inc the trace array ref count
>
> Jan Kara <jack@suse.cz>
>     ext4: do not let fstrim block system suspend
>
> Jan Kara <jack@suse.cz>
>     ext4: move setting of trimmed bit into ext4_try_to_trim_range()
>
> Kemeng Shi <shikemeng@huaweicloud.com>
>     ext4: replace the traditional ternary conditional operator with with =
max()/min()
>
> Lukas Czerner <lczerner@redhat.com>
>     ext4: change s_last_trim_minblks type to unsigned long
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com>
>     ext4: scope ret locally in ext4_try_to_trim_range()
>
> Szuying Chen <chensiying21@gmail.com>
>     ata: libahci: clear pending interrupt status
>
> Hannes Reinecke <hare@suse.de>
>     ata: ahci: Drop pointless VPRINTK() calls and convert the remaining o=
nes
>
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Increase trace array ref count on enable and filter files
>
> John Keeping <john@metanate.com>
>     tracing: Make trace_marker{,_raw} stream-like
>
> Olga Kornievskaia <kolga@netapp.com>
>     NFSv4.1: fix pnfs MDS=3DDS session trunking
>
> Olga Kornievskaia <kolga@netapp.com>
>     NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     SUNRPC: Mark the cred for revalidation if the server rejects it
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS/pNFS: Report EINVAL errors from connect() to the server
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS: More fixes for nfs_direct_write_reschedule_io()
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS: Use the correct commit info in nfs_join_page_group()
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/am33xx.dtsi                      |   5 +-
>  arch/arm/boot/dts/am3517.dtsi                      |   5 +-
>  arch/arm/boot/dts/am4372.dtsi                      |   5 +-
>  arch/arm/boot/dts/artpec6-devboard.dts             |   9 +-
>  arch/arm/boot/dts/dm814x.dtsi                      |   6 +-
>  arch/arm/boot/dts/dm816x.dtsi                      |   6 +-
>  arch/arm/boot/dts/dra62x.dtsi                      |   6 +-
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi         |   5 +-
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi            |   5 +-
>  arch/arm/boot/dts/imx6q-gk802.dts                  |   9 +-
>  arch/arm/boot/dts/motorola-mapphone-common.dtsi    |   4 +-
>  arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi          |   6 +-
>  arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |   6 +-
>  arch/arm/boot/dts/omap2.dtsi                       |   5 +-
>  arch/arm/boot/dts/omap2420.dtsi                    |   5 +-
>  arch/arm/boot/dts/omap2430.dtsi                    |   5 +-
>  arch/arm/boot/dts/omap3-cm-t3517.dts               |  12 +-
>  arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |   8 +-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 |   6 +-
>  arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
>  arch/arm/boot/dts/omap3-n900.dts                   |  38 +-
>  arch/arm/boot/dts/omap3-zoom3.dts                  |  44 +--
>  arch/arm/boot/dts/omap3.dtsi                       |   5 +-
>  arch/arm/boot/dts/omap34xx.dtsi                    |   5 +-
>  arch/arm/boot/dts/omap36xx.dtsi                    |   5 +-
>  arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  34 +-
>  arch/arm/boot/dts/omap443x.dtsi                    |   6 +-
>  arch/arm/boot/dts/omap4460.dtsi                    |   6 +-
>  arch/arm/boot/dts/omap5-cm-t54.dts                 |  56 +--
>  arch/arm/boot/dts/omap5-core-thermal.dtsi          |   5 +-
>  arch/arm/boot/dts/omap5-gpu-thermal.dtsi           |   5 +-
>  arch/arm/boot/dts/orion5x-lacie-d2-network.dts     |   5 +-
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |   9 +-
>  .../boot/dts/orion5x-maxtor-shared-storage-2.dts   |   5 +-
>  arch/arm/boot/dts/orion5x-mv88f5181.dtsi           |   9 +-
>  arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |   9 +-
>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      |   9 +-
>  arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        |   9 +-
>  arch/arm/boot/dts/orion5x.dtsi                     |   9 +-
>  arch/arm/include/asm/hardware/cache-aurora-l2.h    |   5 +-
>  arch/arm/include/asm/hardware/cache-feroceon-l2.h  |   6 +-
>  arch/arm/include/asm/hardware/cache-tauros2.h      |   5 +-
>  arch/arm/mach-davinci/board-da830-evm.c            |   6 +-
>  arch/arm/mach-davinci/board-da850-evm.c            |   6 +-
>  arch/arm/mach-davinci/board-dm355-evm.c            |   6 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c        |   5 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c           |   6 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c           |   7 +-
>  arch/arm/mach-davinci/board-mityomapl138.c         |   5 +-
>  arch/arm/mach-davinci/board-neuros-osd2.c          |   5 +-
>  arch/arm/mach-davinci/board-omapl138-hawk.c        |   5 +-
>  arch/arm/mach-davinci/common.c                     |   6 +-
>  arch/arm/mach-davinci/cpuidle.h                    |   5 +-
>  arch/arm/mach-davinci/da830.c                      |   6 +-
>  arch/arm/mach-davinci/da850.c                      |   6 +-
>  arch/arm/mach-davinci/dm355.c                      |   6 +-
>  arch/arm/mach-davinci/dm644x.c                     |   6 +-
>  arch/arm/mach-davinci/dm646x.c                     |   6 +-
>  arch/arm/mach-davinci/include/mach/common.h        |   6 +-
>  arch/arm/mach-davinci/include/mach/cputype.h       |   6 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h         |   6 +-
>  arch/arm/mach-davinci/include/mach/hardware.h      |   6 +-
>  arch/arm/mach-davinci/include/mach/serial.h        |   6 +-
>  arch/arm/mach-davinci/mux.c                        |   6 +-
>  arch/arm/mach-davinci/mux.h                        |   6 +-
>  arch/arm/mach-davinci/pm_domain.c                  |   5 +-
>  arch/arm/mach-dove/bridge-regs.h                   |   9 +-
>  arch/arm/mach-dove/cm-a510.c                       |   5 +-
>  arch/arm/mach-dove/common.c                        |   5 +-
>  arch/arm/mach-dove/common.h                        |   5 +-
>  arch/arm/mach-dove/dove-db-setup.c                 |   5 +-
>  arch/arm/mach-dove/dove.h                          |   9 +-
>  arch/arm/mach-dove/irq.c                           |   5 +-
>  arch/arm/mach-dove/irqs.h                          |   9 +-
>  arch/arm/mach-dove/mpp.c                           |   5 +-
>  arch/arm/mach-dove/pcie.c                          |   5 +-
>  arch/arm/mach-dove/pm.h                            |   6 +-
>  arch/arm/mach-lpc18xx/board-dt.c                   |   5 +-
>  arch/arm/mach-lpc32xx/pm.c                         |   6 +-
>  arch/arm/mach-lpc32xx/suspend.S                    |   6 +-
>  arch/arm/mach-mv78xx0/bridge-regs.h                |   6 +-
>  arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |   5 +-
>  arch/arm/mach-mv78xx0/common.c                     |   5 +-
>  arch/arm/mach-mv78xx0/common.h                     |   5 +-
>  arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |   5 +-
>  arch/arm/mach-mv78xx0/irq.c                        |   5 +-
>  arch/arm/mach-mv78xx0/irqs.h                       |   9 +-
>  arch/arm/mach-mv78xx0/mpp.c                        |   5 +-
>  arch/arm/mach-mv78xx0/mpp.h                        |   6 +-
>  arch/arm/mach-mv78xx0/mv78xx0.h                    |   5 +-
>  arch/arm/mach-mv78xx0/pcie.c                       |   5 +-
>  arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |   5 +-
>  arch/arm/mach-mvebu/armada-370-xp.h                |   5 +-
>  arch/arm/mach-mvebu/board-v7.c                     |   5 +-
>  arch/arm/mach-mvebu/coherency.c                    |   5 +-
>  arch/arm/mach-mvebu/coherency.h                    |   6 +-
>  arch/arm/mach-mvebu/coherency_ll.S                 |   5 +-
>  arch/arm/mach-mvebu/common.h                       |   5 +-
>  arch/arm/mach-mvebu/cpu-reset.c                    |   5 +-
>  arch/arm/mach-mvebu/dove.c                         |   5 +-
>  arch/arm/mach-mvebu/headsmp-a9.S                   |   5 +-
>  arch/arm/mach-mvebu/headsmp.S                      |   5 +-
>  arch/arm/mach-mvebu/kirkwood.c                     |   5 +-
>  arch/arm/mach-mvebu/kirkwood.h                     |   5 +-
>  arch/arm/mach-mvebu/mvebu-soc-id.c                 |   5 +-
>  arch/arm/mach-mvebu/mvebu-soc-id.h                 |   5 +-
>  arch/arm/mach-mvebu/platsmp-a9.c                   |   5 +-
>  arch/arm/mach-mvebu/platsmp.c                      |   5 +-
>  arch/arm/mach-mvebu/pm-board.c                     |   5 +-
>  arch/arm/mach-mvebu/pm.c                           |   5 +-
>  arch/arm/mach-mvebu/pmsu.c                         |   5 +-
>  arch/arm/mach-mvebu/pmsu.h                         |   5 +-
>  arch/arm/mach-mvebu/pmsu_ll.S                      |   5 +-
>  arch/arm/mach-mvebu/system-controller.c            |   5 +-
>  arch/arm/mach-omap1/include/mach/mtd-xip.h         |   6 +-
>  arch/arm/mach-omap1/pm_bus.c                       |   6 +-
>  arch/arm/mach-omap2/prcm43xx.h                     |   5 +-
>  arch/arm/mach-omap2/vc.c                           |   6 +-
>  arch/arm/mach-orion5x/board-d2net.c                |   5 +-
>  arch/arm/mach-orion5x/board-dt.c                   |   5 +-
>  arch/arm/mach-orion5x/board-rd88f5182.c            |   5 +-
>  arch/arm/mach-orion5x/bridge-regs.h                |   9 +-
>  arch/arm/mach-orion5x/common.c                     |   5 +-
>  arch/arm/mach-orion5x/db88f5281-setup.c            |   5 +-
>  arch/arm/mach-orion5x/irq.c                        |   5 +-
>  arch/arm/mach-orion5x/irqs.h                       |   5 +-
>  arch/arm/mach-orion5x/kurobox_pro-setup.c          |   5 +-
>  arch/arm/mach-orion5x/ls_hgl-setup.c               |   5 +-
>  arch/arm/mach-orion5x/mpp.c                        |   5 +-
>  arch/arm/mach-orion5x/net2big-setup.c              |   6 +-
>  arch/arm/mach-orion5x/orion5x.h                    |   5 +-
>  arch/arm/mach-orion5x/pci.c                        |   5 +-
>  arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |   5 +-
>  arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |   5 +-
>  arch/arm/mach-orion5x/rd88f5182-setup.c            |   5 +-
>  arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |   5 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c               |   5 +-
>  arch/arm/mach-orion5x/wnr854t-setup.c              |   9 +-
>  arch/arm/mach-orion5x/wrt350n-v2-setup.c           |   9 +-
>  arch/arm/mach-pxa/eseries.c                        |   7 +-
>  arch/arm/mach-pxa/standby.S                        |   6 +-
>  arch/arm/mach-spear/generic.h                      |   5 +-
>  arch/arm/mach-spear/include/mach/misc_regs.h       |   5 +-
>  arch/arm/mach-spear/include/mach/spear.h           |   5 +-
>  arch/arm/mach-spear/pl080.c                        |   5 +-
>  arch/arm/mach-spear/pl080.h                        |   5 +-
>  arch/arm/mach-spear/restart.c                      |   5 +-
>  arch/arm/mach-spear/spear1310.c                    |   5 +-
>  arch/arm/mach-spear/spear1340.c                    |   5 +-
>  arch/arm/mach-spear/spear13xx.c                    |   5 +-
>  arch/arm/mach-spear/spear300.c                     |   5 +-
>  arch/arm/mach-spear/spear310.c                     |   5 +-
>  arch/arm/mach-spear/spear320.c                     |   5 +-
>  arch/arm/mach-spear/spear3xx.c                     |   5 +-
>  arch/arm/mach-spear/spear6xx.c                     |   5 +-
>  arch/arm/mach-spear/time.c                         |   5 +-
>  arch/arm/mm/cache-feroceon-l2.c                    |   5 +-
>  arch/arm/mm/cache-tauros2.c                        |   5 +-
>  arch/mips/alchemy/devboards/db1000.c               |   4 +
>  arch/mips/alchemy/devboards/db1200.c               |   6 +
>  arch/mips/alchemy/devboards/db1300.c               |   4 +
>  arch/parisc/include/asm/ropes.h                    |   3 +
>  arch/parisc/kernel/drivers.c                       |   2 +-
>  arch/parisc/kernel/irq.c                           |   2 +-
>  arch/powerpc/kernel/hw_breakpoint.c                |  16 +-
>  arch/powerpc/kernel/hw_breakpoint_constraints.c    |   7 +-
>  arch/powerpc/perf/hv-24x7.c                        |   2 +-
>  arch/x86/kernel/cpu/bugs.c                         |   4 +-
>  arch/x86/kernel/cpu/common.c                       |   2 +-
>  arch/xtensa/boot/Makefile                          |   3 +-
>  arch/xtensa/boot/lib/zmem.c                        |   5 +-
>  arch/xtensa/include/asm/core.h                     |   4 +
>  arch/xtensa/platforms/iss/network.c                |   4 +-
>  drivers/ata/ahci.c                                 | 111 +++---
>  drivers/ata/ahci_brcm.c                            |   2 +-
>  drivers/ata/ahci_xgene.c                           |   4 -
>  drivers/ata/libahci.c                              |  49 +--
>  drivers/ata/libata-core.c                          |  47 ++-
>  drivers/ata/libata-eh.c                            |  13 +-
>  drivers/ata/libata-sata.c                          |   2 +-
>  drivers/ata/libata-scsi.c                          |   2 +-
>  drivers/ata/libata-transport.c                     |   9 +-
>  drivers/ata/libata.h                               |   2 +
>  drivers/bus/ti-sysc.c                              |  31 +-
>  drivers/char/agp/parisc-agp.c                      |   2 -
>  drivers/clk/tegra/clk-bpmp.c                       |   2 +-
>  drivers/firmware/imx/imx-dsp.c                     |   1 +
>  drivers/gpio/gpio-pmic-eic-sprd.c                  |   1 +
>  drivers/gpio/gpio-tb10x.c                          |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  17 +-
>  .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   4 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   4 +-
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   2 +
>  drivers/i2c/busses/i2c-i801.c                      |   1 +
>  drivers/i2c/busses/i2c-npcm7xx.c                   |  17 +-
>  drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
>  drivers/i2c/muxes/i2c-mux-gpio.c                   |  47 +--
>  .../serio/{i8042-x86ia64io.h =3D> i8042-acpipnpio.h} |  13 +-
>  drivers/input/serio/i8042.h                        |   2 +-
>  drivers/interconnect/core.c                        |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  27 +-
>  drivers/media/common/videobuf2/frame_vector.c      |   6 +-
>  drivers/misc/cardreader/rts5227.c                  |  55 +--
>  drivers/misc/cardreader/rts5228.c                  |  57 +--
>  drivers/misc/cardreader/rts5249.c                  |  56 +--
>  drivers/misc/cardreader/rts5260.c                  |  43 +--
>  drivers/misc/cardreader/rts5261.c                  |  52 +--
>  drivers/misc/cardreader/rtsx_pcr.c                 |  51 ++-
>  drivers/net/ethernet/amazon/ena/ena_netdev.c       |   3 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   9 +
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  13 +-
>  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   9 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 138 ++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  16 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c        |   3 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c       |  31 +-
>  drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
>  drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
>  drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  10 +-
>  drivers/net/team/team.c                            |  10 +-
>  drivers/net/thunderbolt.c                          |   3 +-
>  drivers/nvme/host/pci.c                            | 121 ++++---
>  drivers/parisc/iosapic.c                           |   4 +-
>  drivers/parisc/iosapic_private.h                   |   4 +-
>  drivers/platform/mellanox/Kconfig                  |   1 +
>  drivers/platform/x86/intel_scu_ipc.c               |  66 ++--
>  drivers/power/supply/ucs1002_power.c               |   3 +-
>  drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c                   |   4 +-
>  drivers/scsi/qedf/qedf_io.c                        |  10 +-
>  drivers/scsi/qedf/qedf_main.c                      |   7 +-
>  drivers/scsi/qla2xxx/qla_def.h                     |   3 +
>  drivers/scsi/qla2xxx/qla_init.c                    |   5 +-
>  drivers/scsi/qla2xxx/qla_inline.h                  |  58 +++
>  drivers/scsi/qla2xxx/qla_isr.c                     |  12 +-
>  drivers/scsi/qla2xxx/qla_nvme.c                    |   4 +
>  drivers/scsi/qla2xxx/qla_os.c                      |   6 +
>  drivers/scsi/qla2xxx/qla_target.c                  |   3 +-
>  drivers/scsi/qla2xxx/tcm_qla2xxx.c                 |   4 +-
>  drivers/scsi/ufs/ufshcd.c                          |   6 +-
>  drivers/soc/imx/soc-imx8m.c                        |  10 +
>  drivers/spi/spi-nxp-fspi.c                         |   7 +
>  drivers/spi/spi-stm32.c                            |   8 +
>  drivers/spi/spi-sun6i.c                            |  31 +-
>  drivers/tty/n_gsm.c                                |   4 +-
>  drivers/tty/serial/8250/8250_port.c                |   5 +-
>  drivers/video/fbdev/Kconfig                        |   2 +-
>  drivers/watchdog/iTCO_wdt.c                        |  26 +-
>  fs/binfmt_elf_fdpic.c                              |   5 +-
>  fs/btrfs/delayed-inode.c                           |   7 +-
>  fs/btrfs/extent_io.c                               |   8 +-
>  fs/btrfs/super.c                                   |   2 +-
>  fs/cifs/inode.c                                    |   2 +-
>  fs/cifs/smb2ops.c                                  |   6 +-
>  fs/ext4/ext4.h                                     |   2 +-
>  fs/ext4/mballoc.c                                  |  67 ++--
>  fs/nfs/direct.c                                    |  25 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
>  fs/nfs/nfs4client.c                                |   9 +-
>  fs/nfs/nfs4proc.c                                  |   4 +
>  fs/nfs/write.c                                     |  23 +-
>  fs/nilfs2/gcinode.c                                |   6 +-
>  fs/proc/task_nommu.c                               |  27 +-
>  fs/xfs/scrub/common.c                              |  25 --
>  fs/xfs/scrub/common.h                              |   2 -
>  fs/xfs/scrub/fscounters.c                          |  13 +-
>  fs/xfs/scrub/scrub.c                               |   2 -
>  fs/xfs/scrub/scrub.h                               |   1 -
>  fs/xfs/xfs_icache.c                                |  92 +++--
>  fs/xfs/xfs_icache.h                                |   1 +
>  fs/xfs/xfs_mount.h                                 |   5 +-
>  fs/xfs/xfs_qm_syscalls.c                           |   9 +-
>  fs/xfs/xfs_super.c                                 |  12 +-
>  fs/xfs/xfs_trace.h                                 |   1 +
>  include/linux/btf_ids.h                            |   2 +-
>  include/linux/cgroup.h                             |   3 +-
>  include/linux/if_team.h                            |   2 +
>  include/linux/libata.h                             |   4 +-
>  include/linux/nfs_fs_sb.h                          |   1 +
>  include/linux/nfs_page.h                           |   4 +-
>  include/linux/seqlock.h                            |   2 +-
>  include/net/netfilter/nf_tables.h                  | 127 +++----
>  include/uapi/linux/bpf.h                           |   4 +-
>  io_uring/io_uring.c                                |   2 +-
>  kernel/bpf/queue_stack_maps.c                      |  21 +-
>  kernel/dma/debug.c                                 |  20 +-
>  kernel/sched/core.c                                |   2 +-
>  kernel/sched/cpuacct.c                             |   4 +-
>  kernel/sched/cpupri.c                              |   1 +
>  kernel/sched/idle.c                                |   1 +
>  kernel/trace/ring_buffer.c                         |  10 +
>  kernel/trace/trace.c                               |  45 ++-
>  kernel/trace/trace.h                               |   2 +
>  kernel/trace/trace_events.c                        |   6 +-
>  kernel/trace/trace_events_inject.c                 |   3 +-
>  net/bridge/br_forward.c                            |   4 +-
>  net/bridge/br_input.c                              |   4 +-
>  net/core/flow_dissector.c                          |   2 +-
>  net/dccp/ipv4.c                                    |   9 +-
>  net/dccp/ipv6.c                                    |   9 +-
>  net/ipv4/route.c                                   |   4 +-
>  net/ncsi/ncsi-aen.c                                |   5 +
>  net/netfilter/ipset/ip_set_core.c                  |  12 +-
>  net/netfilter/nf_tables_api.c                      | 400 +++++++++++++++=
++----
>  net/netfilter/nft_exthdr.c                         | 110 +++++-
>  net/netfilter/nft_set_hash.c                       |  87 +++--
>  net/netfilter/nft_set_pipapo.c                     |  71 ++--
>  net/netfilter/nft_set_rbtree.c                     | 161 +++++----
>  net/rds/rdma_transport.c                           |  12 +-
>  net/sunrpc/clnt.c                                  |  15 +-
>  security/smack/smack.h                             |   1 +
>  security/smack/smack_lsm.c                         |  65 +++-
>  sound/pci/hda/hda_intel.c                          |   1 +
>  sound/soc/fsl/imx-audmix.c                         |   2 +-
>  sound/soc/fsl/imx-pcm-rpmsg.c                      |   1 +
>  sound/soc/fsl/imx-rpmsg.c                          |   8 +
>  sound/soc/meson/axg-spdifin.c                      |  49 +--
>  tools/build/Makefile.build                         |  10 +
>  tools/include/linux/btf_ids.h                      |   2 +-
>  tools/include/uapi/linux/bpf.h                     |   4 +-
>  tools/perf/Makefile.config                         |  19 +
>  tools/perf/Makefile.perf                           |   1 +
>  tools/perf/pmu-events/Build                        |  19 +-
>  tools/perf/pmu-events/empty-pmu-events.c           | 158 ++++++++
>  tools/perf/util/Build                              |   6 +
>  tools/perf/util/metricgroup.c                      |   3 +
>  .../ftrace/test.d/instances/instance-event.tc      |   2 +-
>  tools/testing/selftests/kselftest_deps.sh          |  77 +++-
>  tools/testing/selftests/net/tls.c                  |   8 +-
>  332 files changed, 2602 insertions(+), 1896 deletions(-)
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDE7AA1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjIUVLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjIUVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:10:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F892400F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:38:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76f18e09716so76488385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695328722; x=1695933522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b7i6UMMxwZfWHwvDyfjybZADih7AY1uhQu8NdSwR27Y=;
        b=qWVQYG0BhQKT3Mc0uJ2zXuXMsB+7d5oKFqKqooF0zeZYp3NhpJNqkvGk7E/8pQiT3Y
         +GiCFtIyWolMe71eEikDrHbNusgrBiqUbqymgIkvEG+cuWANl7gHVkGAHziIdVnH46E9
         OK9SaLCc2dpzaSxa2RshpXU0sL58Q/uxFZ/kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328722; x=1695933522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7i6UMMxwZfWHwvDyfjybZADih7AY1uhQu8NdSwR27Y=;
        b=F1TUdMjpPEssg7jOprkjQGAwmk8CPAWEXSxcL51VP0+X2EYhLbjso7YQi2RP+9Vy4T
         a7P1V2CrZXdlgt54DdH2PJhrdFDxSG3sxIP8/z6jMCtcnmC95K/QZyhmwjRV5Qt7PbIY
         um0RSZaXTquDEjkXeLOhqSqaCVQhmZsRz7fczsLcoLUmQje2x9c2xNIY/2xUm0KokF/i
         alFzJpQTvsE3W7zdHa4F090spKa6RfqStGCzIlsbKp+id2ejs1tBUcth8Rio6H9ANPg/
         G0GwUPdG/BQpeg6HuF+WnfrHiQuTNSBJT3428InIkb1jPeNY4r2kQUQgjZtoKEUKXc4/
         XtPQ==
X-Gm-Message-State: AOJu0Yy4l4Ep/LKHUNSQ1atqTB4X27skTwYiHQh1WbGc0gvdWNKa2nep
        +cijyU8ToAUGgA1rD7uTzKRyYA==
X-Google-Smtp-Source: AGHT+IHUGbJwAXW+dp+z4r4kpL1oGMARdiRDB2O3kaFQDBfo9XxPu9GDCIAcFaZAyqR+fP9LAhRsNQ==
X-Received: by 2002:a05:620a:4408:b0:773:e380:b38d with SMTP id v8-20020a05620a440800b00773e380b38dmr8497854qkp.55.1695328721729;
        Thu, 21 Sep 2023 13:38:41 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a056d00b007740c0e52edsm712819qkp.89.2023.09.21.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 13:38:41 -0700 (PDT)
Date:   Thu, 21 Sep 2023 16:38:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Message-ID: <20230921203840.GB1211221@joelbox>
References: <20230920112830.377666128@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:30:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

For RCU,
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.15.133-rc1
> 
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma
> 
> Jamal Hadi Salim <jhs@mojatatu.com>
>     net/sched: Retire rsvp classifier
> 
> Christian König <christian.koenig@amd.com>
>     drm/amdgpu: fix amdgpu_cs_p1_user_fence
> 
> Yifan Zhang <yifan1.zhang@amd.com>
>     drm/amd/display: fix the white screen issue when >= 64GB DRAM
> 
> Shida Zhang <zhangshida@kylinos.cn>
>     ext4: fix rec_len verify error
> 
> Damien Le Moal <dlemoal@kernel.org>
>     scsi: pm8001: Setup IRQs on resume
> 
> Junxiao Bi <junxiao.bi@oracle.com>
>     scsi: megaraid_sas: Fix deadlock on firmware crashdump
> 
> Niklas Cassel <niklas.cassel@wdc.com>
>     ata: libata: disallow dev-initiated LPM transitions to unsupported states
> 
> Tommy Huang <tommy_huang@aspeedtech.com>
>     i2c: aspeed: Reset the i2c controller when timeout occurs
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracefs: Add missing lockdown check to tracefs_create_dir()
> 
> Jeff Layton <jlayton@kernel.org>
>     nfsd: fix change_info in NFSv4 RENAME replies
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Have option files inc the trace array ref count
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Have current_trace inc the trace array ref count
> 
> Steven Rostedt (Google) <rostedt@goodmis.org>
>     tracing: Have tracing_max_latency inc the trace array ref count
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: release path before inode lookup during the ino lookup ioctl
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix lockdep splat and potential deadlock after failure running delayed items
> 
> Amir Goldstein <amir73il@gmail.com>
>     ovl: fix incorrect fdput() on aio completion
> 
> Amir Goldstein <amir73il@gmail.com>
>     ovl: fix failed copyup of fileattr on a symlink
> 
> Christian Brauner <brauner@kernel.org>
>     attr: block mode changes of symlinks
> 
> Nigel Croxon <ncroxon@redhat.com>
>     md/raid1: fix error: ISO C90 forbids mixed declarations
> 
> Arnd Bergmann <arnd@arndb.de>
>     samples/hw_breakpoint: fix building without module unloading
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction race with netns dismantle
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix kdoc warnings after gc rework
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: remove busy mark and gc batch API
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_hash: mark set element as dead when deleting from packet path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: adapt set backend to use GC transaction API
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction API to avoid race with control plane
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: make validation state per table
> 
> Song Liu <song@kernel.org>
>     x86/purgatory: Remove LTO flags
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/boot/compressed: Reserve more memory for page tables
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>     scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     selftests: tracing: Fix to unmount tracefs for recovering environment
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>     scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>     drm: gm12u320: Fix the timeout usage for usb_bulk_msg()
> 
> Anand Jain <anand.jain@oracle.com>
>     btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super
> 
> Anand Jain <anand.jain@oracle.com>
>     btrfs: add a helper to read the superblock metadata_uuid
> 
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
> 
> Namhyung Kim <namhyung@kernel.org>
>     perf test shell stat_bpf_counters: Fix test on Intel
> 
> James Clark <james.clark@arm.com>
>     perf test: Remove bash construct from stat_bpf_counters.sh test
> 
> Namhyung Kim <namhyung@kernel.org>
>     perf build: Update build rule for generated files
> 
> Ian Rogers <rogers.email@gmail.com>
>     perf jevents: Switch build to use jevents.py
> 
> Tiezhu Yang <yangtiezhu@loongson.cn>
>     MIPS: Use "grep -E" instead of "egrep"
> 
> William Zhang <william.zhang@broadcom.com>
>     mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
> 
> Florian Fainelli <f.fainelli@gmail.com>
>     mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
> 
> Zhang Yi <yi.zhang@huawei.com>
>     jbd2: correct the end of the journal recovery scan range
> 
> Jan Kara <jack@suse.cz>
>     jbd2: rename jbd_debug() to jbd2_debug()
> 
> Ritesh Harjani <riteshh@linux.ibm.com>
>     jbd2: kill t_handle_lock transaction spinlock
> 
> Ritesh Harjani <riteshh@linux.ibm.com>
>     jbd2: fix use-after-free of transaction_t race
> 
> Ritesh Harjani <riteshh@linux.ibm.com>
>     jbd2: refactor wait logic for transaction updates into a common function
> 
> John Ogness <john.ogness@linutronix.de>
>     printk: Consolidate console deferred printing
> 
> Rob Clark <robdclark@chromium.org>
>     interconnect: Fix locking for runpm vs reclaim
> 
> Zhen Lei <thunder.leizhen@huawei.com>
>     kobject: Add sanity check for kset->kobj.ktype in kset_register()
> 
> Sakari Ailus <sakari.ailus@linux.intel.com>
>     media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning
> 
> Xu Yang <xu.yang_2@nxp.com>
>     usb: ehci: add workaround for chipidea PORTSC.PEC bug
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     serial: cpm_uart: Avoid suspicious locking
> 
> Konstantin Shelekhin <k.shelekhin@yadro.com>
>     scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()
> 
> Chenyuan Mi <michenyuan@huawei.com>
>     tools: iio: iio_generic_buffer: Fix some integer type and calculation
> 
> Ma Ke <make_ruc2021@163.com>
>     usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
> 
> Xiaolei Wang <xiaolei.wang@windriver.com>
>     usb: cdns3: Put the cdns set active part outside the spin lock
> 
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: pci: cx23885: replace BUG with error return
> 
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: tuners: qt1010: replace BUG_ON with a regular error
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: anysee: fix null-ptr-deref in anysee_master_xfer
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
> 
> Yong-Xuan Wang <yongxuan.wang@sifive.com>
>     PCI: fu740: Set the number of MSI vectors
> 
> ruanjinjie <ruanjinjie@huawei.com>
>     powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
> 
> Mårten Lindahl <marten.lindahl@axis.com>
>     ARM: 9317/1: kexec: Make smp stop calls asynchronous
> 
> Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>
>     jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount
> 
> Andrew Kanner <andrew.kanner@gmail.com>
>     fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()
> 
> Georg Ottinger <g.ottinger@gmx.at>
>     ext2: fix datatype of block number in ext2_xattr_set2()
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     md: raid1: fix potential OOB in raid1_remove_disk()
> 
> Tony Lindgren <tony@atomide.com>
>     bus: ti-sysc: Configure uart quirks for k3 SoC
> 
> Tuo Li <islituo@gmail.com>
>     drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()
> 
> Leo Chen <sancchen@amd.com>
>     drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
> 
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>     ALSA: hda: intel-dsp-cfg: add LunarLake support
> 
> Rong Tao <rongtao@cestc.cn>
>     samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8250-edo: correct ramoops pmsg-size
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size
> 
> Marek Vasut <marex@denx.de>
>     drm/bridge: tc358762: Instruct DSI host to generate HSE packets
> 
> Hao Luo <haoluo@google.com>
>     libbpf: Free btf_vmlinux when closing bpf_object
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211_hwsim: drop short frames
> 
> GONG, Ruiqi <gongruiqi1@huawei.com>
>     netfilter: ebtables: fix fortify warnings in size_entry_mwt()
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: check S1G action frame size
> 
> GONG, Ruiqi <gongruiqi1@huawei.com>
>     alx: fix OOB-read compiler warning
> 
> Giulio Benetti <giulio.benetti@benettiengineering.com>
>     mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
> 
> Alexander Steffen <Alexander.Steffen@infineon.com>
>     tpm_tis: Resend command to recover from data transfer errors
> 
> Mark O'Donovan <shiftee@posteo.net>
>     crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>     wifi: wil6210: fix fortify warnings
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>     wifi: mwifiex: fix fortify warning
> 
> Dongliang Mu <dzm91@hust.edu.cn>
>     wifi: ath9k: fix printk specifier
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>     wifi: ath9k: fix fortify warnings
> 
> Azeem Shaikh <azeemshaikh38@gmail.com>
>     crypto: lrw,xts - Replace strlcpy with strscpy
> 
> Jiri Pirko <jiri@nvidia.com>
>     devlink: remove reload failed checks in params get/set callbacks
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
> 
> Tomislav Novak <tnovak@meta.com>
>     hw_breakpoint: fix single-stepping when using bpf_overflow_handler
> 
> Xu Yang <xu.yang_2@nxp.com>
>     perf/imx_ddr: speed up overflow frequency of cycle
> 
> Yicong Yang <yangyicong@hisilicon.com>
>     perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
> 
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
> 
> Paul E. McKenney <paulmck@kernel.org>
>     scftorture: Forgive memory-allocation failure if KASAN
> 
> Zqiang <qiang.zhang1211@gmail.com>
>     rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()
> 
> Wander Lairson Costa <wander@redhat.com>
>     kernel/fork: beware of __put_task_struct() calling context
> 
> Abhishek Mainkar <abmainkar@nvidia.com>
>     ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer
> 
> Will Shiu <Will.Shiu@mediatek.com>
>     locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock
> 
> Qu Wenruo <wqu@suse.com>
>     btrfs: output extra debug info if we failed to find an inline backref
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     autofs: fix memory leak of waitqueues in autofs_catatonic_mode
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/arm64/silicon-errata.rst             |   3 +
>  Makefile                                           |   4 +-
>  arch/arm/kernel/hw_breakpoint.c                    |   8 +-
>  arch/arm/kernel/machine_kexec.c                    |  14 +-
>  .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |   2 +-
>  .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   |   2 +-
>  .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   2 +-
>  arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
>  arch/mips/Makefile                                 |   2 +-
>  arch/mips/vdso/Makefile                            |   2 +-
>  arch/powerpc/platforms/pseries/ibmebus.c           |   1 +
>  arch/x86/boot/compressed/ident_map_64.c            |   8 +
>  arch/x86/include/asm/boot.h                        |  45 +-
>  arch/x86/purgatory/Makefile                        |   4 +
>  crypto/lrw.c                                       |   6 +-
>  crypto/xts.c                                       |   6 +-
>  drivers/acpi/acpica/psopcode.c                     |   2 +-
>  drivers/acpi/arm64/iort.c                          |   5 +-
>  drivers/acpi/video_detect.c                        |   9 +
>  drivers/acpi/x86/s2idle.c                          |   6 +
>  drivers/ata/ahci.c                                 |   9 +
>  drivers/ata/libata-sata.c                          |  19 +-
>  drivers/bus/ti-sysc.c                              |   2 +
>  drivers/char/tpm/tpm_tis_core.c                    |  15 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  18 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  21 +-
>  .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |   4 +-
>  drivers/gpu/drm/bridge/tc358762.c                  |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_crtc.c           |   5 +-
>  drivers/gpu/drm/tiny/gm12u320.c                    |  10 +-
>  drivers/i2c/busses/i2c-aspeed.c                    |   7 +-
>  drivers/interconnect/core.c                        |   8 +-
>  drivers/md/raid1.c                                 |   3 +
>  drivers/media/pci/cx23885/cx23885-video.c          |   2 +-
>  drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   2 +-
>  drivers/media/tuners/qt1010.c                      |  11 +-
>  drivers/media/usb/dvb-usb-v2/af9035.c              |  14 +-
>  drivers/media/usb/dvb-usb-v2/anysee.c              |   2 +-
>  drivers/media/usb/dvb-usb-v2/az6007.c              |   8 +
>  drivers/media/usb/dvb-usb-v2/gl861.c               |   2 +-
>  drivers/media/usb/dvb-usb/af9005.c                 |   5 +
>  drivers/media/usb/dvb-usb/dw2102.c                 |  24 +
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |   7 +-
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c           | 102 ++-
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h           |  29 +
>  drivers/net/ethernet/atheros/alx/ethtool.c         |   5 +-
>  drivers/net/wireless/ath/ath9k/ahb.c               |   4 +-
>  drivers/net/wireless/ath/ath9k/mac.h               |   6 +-
>  drivers/net/wireless/ath/ath9k/pci.c               |   4 +-
>  drivers/net/wireless/ath/ath9k/xmit.c              |   4 +-
>  drivers/net/wireless/ath/wil6210/txrx.c            |   2 +-
>  drivers/net/wireless/ath/wil6210/txrx.h            |   6 +-
>  drivers/net/wireless/ath/wil6210/txrx_edma.c       |   2 +-
>  drivers/net/wireless/ath/wil6210/txrx_edma.h       |   6 +-
>  drivers/net/wireless/mac80211_hwsim.c              |   7 +-
>  drivers/net/wireless/marvell/mwifiex/tdls.c        |   9 +-
>  drivers/pci/controller/dwc/pcie-fu740.c            |   1 +
>  drivers/perf/arm_smmuv3_pmu.c                      |  46 +-
>  drivers/perf/fsl_imx8_ddr_perf.c                   |  21 +
>  drivers/scsi/lpfc/lpfc_debugfs.c                   |  14 +-
>  drivers/scsi/megaraid/megaraid_sas.h               |   2 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c          |  21 +-
>  drivers/scsi/pm8001/pm8001_init.c                  |  51 +-
>  drivers/scsi/qla2xxx/qla_dfs.c                     |   6 +-
>  drivers/target/iscsi/iscsi_target_configfs.c       |  54 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  13 +-
>  drivers/usb/cdns3/cdns3-plat.c                     |   3 +-
>  drivers/usb/cdns3/cdnsp-pci.c                      |   3 +-
>  drivers/usb/cdns3/core.c                           |  15 +-
>  drivers/usb/cdns3/core.h                           |   7 +-
>  drivers/usb/gadget/udc/fsl_qe_udc.c                |   2 +
>  drivers/usb/host/ehci-hcd.c                        |   8 +-
>  drivers/usb/host/ehci-hub.c                        |  10 +-
>  drivers/usb/host/ehci.h                            |  10 +
>  fs/attr.c                                          |  20 +-
>  fs/autofs/waitq.c                                  |   3 +-
>  fs/btrfs/ctree.h                                   |   2 -
>  fs/btrfs/delayed-inode.c                           |  19 +-
>  fs/btrfs/disk-io.c                                 |   8 +-
>  fs/btrfs/extent-tree.c                             |   5 +
>  fs/btrfs/ioctl.c                                   |   8 +-
>  fs/btrfs/volumes.c                                 |   8 +
>  fs/btrfs/volumes.h                                 |   3 +
>  fs/ext2/xattr.c                                    |   4 +-
>  fs/ext4/namei.c                                    |  26 +-
>  fs/jbd2/checkpoint.c                               |   6 +-
>  fs/jbd2/commit.c                                   |  49 +-
>  fs/jbd2/journal.c                                  |  34 +-
>  fs/jbd2/recovery.c                                 |  42 +-
>  fs/jbd2/revoke.c                                   |   8 +-
>  fs/jbd2/transaction.c                              | 114 +--
>  fs/jfs/jfs_dmap.c                                  |   1 +
>  fs/jfs/jfs_imap.c                                  |   1 +
>  fs/locks.c                                         |   2 +-
>  fs/nfsd/nfs4proc.c                                 |   4 +-
>  fs/overlayfs/copy_up.c                             |   3 +-
>  fs/overlayfs/file.c                                |   9 +-
>  fs/tracefs/inode.c                                 |   3 +
>  include/linux/acpi_iort.h                          |   1 +
>  include/linux/jbd2.h                               |  11 +-
>  include/linux/libata.h                             |   4 +
>  include/linux/perf_event.h                         |  22 +-
>  include/linux/sched/task.h                         |  28 +-
>  include/net/netfilter/nf_tables.h                  | 124 ++--
>  include/uapi/linux/netfilter_bridge/ebtables.h     |  14 +-
>  kernel/fork.c                                      |   8 +
>  kernel/printk/printk.c                             |  35 +-
>  kernel/printk/printk_safe.c                        |   9 +-
>  kernel/rcu/rcuscale.c                              |   2 +-
>  kernel/scftorture.c                                |   6 +-
>  kernel/trace/trace.c                               |  41 +-
>  lib/kobject.c                                      |   5 +
>  lib/mpi/mpi-cmp.c                                  |   8 +-
>  net/bridge/netfilter/ebtables.c                    |   3 +-
>  net/core/devlink.c                                 |   4 +-
>  net/mac80211/rx.c                                  |   4 +
>  net/netfilter/nf_tables_api.c                      | 374 +++++++---
>  net/netfilter/nft_set_hash.c                       |  83 ++-
>  net/netfilter/nft_set_pipapo.c                     |  50 +-
>  net/netfilter/nft_set_rbtree.c                     | 144 ++--
>  net/sched/Kconfig                                  |  28 -
>  net/sched/Makefile                                 |   2 -
>  net/sched/cls_rsvp.c                               |  24 -
>  net/sched/cls_rsvp.h                               | 776 ---------------------
>  net/sched/cls_rsvp6.c                              |  24 -
>  samples/hw_breakpoint/data_breakpoint.c            |   4 +-
>  sound/hda/intel-dsp-config.c                       |   8 +
>  tools/build/Makefile.build                         |  10 +
>  tools/iio/iio_generic_buffer.c                     |  17 +-
>  tools/lib/bpf/libbpf.c                             |   1 +
>  tools/perf/Makefile.config                         |  19 +
>  tools/perf/Makefile.perf                           |   1 +
>  tools/perf/pmu-events/Build                        |  19 +-
>  tools/perf/pmu-events/empty-pmu-events.c           | 158 +++++
>  tools/perf/tests/shell/stat_bpf_counters.sh        |   6 +-
>  tools/testing/selftests/ftrace/ftracetest          |   8 +
>  136 files changed, 1680 insertions(+), 1595 deletions(-)
> 
> 

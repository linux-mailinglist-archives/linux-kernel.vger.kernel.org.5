Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB8787DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjHYCjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbjHYCis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:38:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0D2682
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:38:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79264ca4b34so16623139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692931089; x=1693535889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6YKsZnIkqDJzzxQuj8Ik0d2OAb9MIxOwGcixB99dvQ=;
        b=vzWE0jpmyANJS+5CI5oESq9fDhlJVMSL9zIt0lgLAaB0kqTflGdAiNUjdcku5a7tIT
         ujTzGMO1Rs9cdzGX5sSLtVu+AyCnCZAKzdC/3L21hMsfsjppfQYEoWM77OKbBD1gGu1B
         l2/H3jNTlJSTM5N8rKkhV1SWbR2I5YfL13WGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931089; x=1693535889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6YKsZnIkqDJzzxQuj8Ik0d2OAb9MIxOwGcixB99dvQ=;
        b=bLtKTSgckarpVm4ZWWnYI47cXRGJ0r0DECpmxjOECp8UXVt8gp8pLHXxlactIv6KPa
         cpnHWhq1wbGJqkwq2eywOJ0cS0YKPQZBSlTkjE/A7RHsTY0HkoDWS3LyGlXaoeOQ+ehb
         3g8cvXBh1AKtkU3O1V41uyxWlGO3za0D9TiEf1E1BNjEnzvhU2jSrt13/Hjn+J1YVt6r
         MnQFbtQFmE4FqeOho8I3ajrY85u6jJT8xPBYzIMA85huUii4vIAS7pvOEfxehKPrOwXa
         BL+l23GT1Qdc1oczZQF+tfqrVhRvmKQSIXao4LWQCHfhuk5oZQtiaMo/pIu8pCtuqFFn
         x6zA==
X-Gm-Message-State: AOJu0YxBmDUrXMG2W+r54dOQGz5JcNdu4WPCnKoc0kK+LOruXcygpDvz
        T7+eWdhz/LiankcKEgKTATAVQs6BrSjQgFcIlGM=
X-Google-Smtp-Source: AGHT+IGImQ1U7U77QkDssjvgQiQPqdaegEWvdrxRgwWbFy0A21y1w5MM/y1LSC6uBMXwQ51q6nyz1g==
X-Received: by 2002:a6b:6514:0:b0:791:7e14:4347 with SMTP id z20-20020a6b6514000000b007917e144347mr8077869iob.13.1692931089178;
        Thu, 24 Aug 2023 19:38:09 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id l11-20020a02a88b000000b0042b5423f021sm240758jam.54.2023.08.24.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:38:08 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:38:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <20230825023807.GA4008060@google.com>
References: <20230824170617.074557800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.192-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
>     Linux 5.10.192-rc1
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Correct the mitigation status when SMT is disabled
> 
> Peter Zijlstra <peterz@infradead.org>
>     objtool/x86: Fixup frame-pointer vs rethunk
> 
> Petr Pavlu <petr.pavlu@suse.com>
>     x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Disable the mitigation on unaffected configurations
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/CPU/AMD: Fix the DIV(0) initial fix attempt
> 
> Sean Christopherson <seanjc@google.com>
>     x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/static_call: Fix __static_call_fixup()
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Explain the untraining sequences a bit more
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Cleanup the untrain mess
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename original retbleed methods
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Clean up SRSO return thunk mess
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/ibt: Add ANNOTATE_NOENDBR
> 
> Josh Poimboeuf <jpoimboe@redhat.com>
>     objtool: Add frame-pointer-specific function ignore
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/alternative: Make custom return thunk unconditional
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix __x86_return_thunk symbol type
> 
> Yangtao Li <frank.li@vivo.com>
>     mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
> 
> Jason Xing <kernelxing@tencent.com>
>     net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
> 
> Jason Wang <jasowang@redhat.com>
>     virtio-net: set queues after driver_ok
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     af_unix: Fix null-ptr-deref in unix_stream_sendpage().
> 
> Xin Long <lucien.xin@gmail.com>
>     netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
> 
> Yibin Ding <yibin.ding@unisoc.com>
>     mmc: block: Fix in_flight[issue_type] value error
> 
> Yang Yingliang <yangyingliang@huawei.com>
>     mmc: wbsd: fix double mmc_free_host() in wbsd_init()
> 
> Russell Harmon via samba-technical <samba-technical@lists.samba.org>
>     cifs: Release folio lock on fscache read hit.
> 
> dengxiang <dengxiang@nfschina.com>
>     ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.
> 
> Tony Lindgren <tony@atomide.com>
>     serial: 8250: Fix oops for port->pm on uart_change_pm()
> 
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: uaccess: Return the number of bytes effectively not copied
> 
> Chen Lifu <chenlifu@huawei.com>
>     riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
> 
> Jisheng Zhang <jszhang@kernel.org>
>     riscv: lib: uaccess: fold fixups into body
> 
> Akira Tsukamoto <akira.tsukamoto@gmail.com>
>     riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
> 
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - Remodified 3k pull low procedure
> 
> Jerome Brunet <jbrunet@baylibre.com>
>     ASoC: meson: axg-tdm-formatter: fix channel slot allocation
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     ASoC: rt5665: add missed regulator_bulk_disable
> 
> Christopher Obbard <chris.obbard@collabora.com>
>     arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> 
> FUKAUMI Naoki <naoki@radxa.com>
>     arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4
> 
> FUKAUMI Naoki <naoki@radxa.com>
>     arm64: dts: rockchip: fix regulator name on rk3399-rock-4
> 
> Alex Bee <knaerzche@gmail.com>
>     arm64: dts: rockchip: add SPDIF node for ROCK Pi 4
> 
> Alex Bee <knaerzche@gmail.com>
>     arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
> 
> Vicente Bergas <vicencb@gmail.com>
>     arm64: dts: rockchip: use USB host by default on rk3399-rock-pi-4
> 
> Vicente Bergas <vicencb@gmail.com>
>     arm64: dts: rockchip: fix supplies on rk3399-rock-pi-4
> 
> Tony Lindgren <tony@atomide.com>
>     bus: ti-sysc: Flush posted write on enable before reset
> 
> Eric Dumazet <edumazet@google.com>
>     net: do not allow gso_size to be set to GSO_BY_FRAGS
> 
> Abel Wu <wuyun.abel@bytedance.com>
>     sock: Fix misuse of sk_under_memory_pressure()
> 
> Alfred Lee <l00g33k@gmail.com>
>     net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
> 
> Andrii Staikov <andrii.staikov@intel.com>
>     i40e: fix misleading debug logs
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>     team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
> 
> Justin Chen <justin.chen@broadcom.com>
>     net: phy: broadcom: stub c45 read/write for 54810
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_dynset: disallow object maps
> 
> Sishuai Gong <sishuai.system@gmail.com>
>     ipvs: fix racy memcpy in proc_do_sync_threshold
> 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
>     drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs
> 
> Petr Machata <petrm@nvidia.com>
>     selftests: mirror_gre_changes: Tighten up the TTL test match
> 
> Lin Ma <linma@zju.edu.cn>
>     xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
> 
> Lin Ma <linma@zju.edu.cn>
>     xfrm: add NULL check in xfrm_update_ae_params
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>     ip_vti: fix potential slab-use-after-free in decode_session6
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>     ip6_vti: fix slab-use-after-free in decode_session6
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>     xfrm: fix slab-use-after-free in decode_session6
> 
> Lin Ma <linma@zju.edu.cn>
>     net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
> 
> Lin Ma <linma@zju.edu.cn>
>     net: af_key: fix sadb_x_filter validation
> 
> Lin Ma <linma@zju.edu.cn>
>     net: xfrm: Fix xfrm_address_filter OOB read
> 
> Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
>     i2c: designware: Handle invalid SMBus block data response length value
> 
> xiaoshoukui <xiaoshoukui@gmail.com>
>     btrfs: fix BUG_ON condition in btrfs_cancel_balance
> 
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
> 
> Yi Yang <yiyang13@huawei.com>
>     tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux
> 
> Nathan Lynch <nathanl@linux.ibm.com>
>     powerpc/rtas_flash: allow user copy to flash block cache objects
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     fbdev: mmp: fix value check in mmphw_probe()
> 
> Chengfeng Ye <dg573847474@gmail.com>
>     i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     virtio-mmio: don't break lifecycle of vm_dev
> 
> Tang Bin <tangbin@cmss.chinamobile.com>
>     virtio-mmio: Use to_virtio_mmio_device() to simply code
> 
> Ivan Mikhaylov <fr0st61te@gmail.com>
>     net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing/probes: Fix to update dynamic data counter if fetcharg uses it
> 
> Steven Rostedt (VMware) <rostedt@goodmis.org>
>     tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     mmc: meson-gx: fix deferred probing
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>     mmc: meson-gx: use devm_mmc_alloc_host
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>     mmc: core: add devm_mmc_alloc_host
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     mmc: sunxi: fix deferred probing
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     mmc: bcm2835: fix deferred probing
> 
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix NULL-deref on suspend
> 
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM
> 
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: allocate TX FIFO size according to composite EP number
> 
> Wesley Cheng <wcheng@codeaurora.org>
>     usb: gadget: udc: core: Introduce check_config to verify USB configuration
> 
> Pawel Laszczak <pawell@cadence.com>
>     usb: cdnsp: Device side header file for CDNSP driver
> 
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>     irqchip/mips-gic: Use raw spinlock for gic_lock
> 
> Marc Zyngier <maz@kernel.org>
>     irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()
> 
> Jeffrey Hugo <quic_jhugo@quicinc.com>
>     bus: mhi: host: Range check CHDBOFF and ERDBOFF
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>     bus: mhi: Move host MHI code to "host" directory
> 
> Bhaumik Bhatt <bbhatt@codeaurora.org>
>     bus: mhi: Add MMIO region length to controller structure
> 
> Loic Poulain <loic.poulain@linaro.org>
>     bus: mhi: Add MHI PCI support for WWAN modems
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: addac: stx104: Fix race condition when converting analog-to-digital
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: addac: stx104: Fix race condition for stx104_write_raw()
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: adc: stx104: Implement and utilize register structures
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: adc: stx104: Utilize iomap interface
> 
> Cosmin Tanislav <demonsingur@gmail.com>
>     dt-bindings: iio: add AD74413R
> 
> Cosmin Tanislav <demonsingur@gmail.com>
>     iio: add addac subdirectory
> 
> Randy Dunlap <rdunlap@infradead.org>
>     IMA: allow/fix UML builds
> 
> Chen Lin <chen.lin5@zte.com.cn>
>     ring-buffer: Do not swap cpu_buffer during resize process
> 
> Benjamin Gray <bgray@linux.ibm.com>
>     powerpc/kasan: Disable KCOV in KASAN code
> 
> Tuo Li <islituo@gmail.com>
>     ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()
> 
> dengxiang <dengxiang@nfschina.com>
>     ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
> 
> shanzhulig <shanzhulig@gmail.com>
>     drm/amdgpu: Fix potential fence use-after-free v2
> 
> Matthew Anderson <ruinairas1992@gmail.com>
>     Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
> 
> Zhengping Jiang <jiangzp@google.com>
>     Bluetooth: L2CAP: Fix use-after-free
> 
> Armin Wolf <W_Armin@gmx.de>
>     pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()
> 
> Tuo Li <islituo@gmail.com>
>     gfs2: Fix possible data races in gfs2_show_options()
> 
> Xu Yang <xu.yang_2@nxp.com>
>     usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
> 
> Xu Yang <xu.yang_2@nxp.com>
>     usb: chipidea: imx: don't request QoS for imx8ulp
> 
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: platform: mediatek: vpu: fix NULL ptr dereference
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
> 
> Yunfei Dong <yunfei.dong@mediatek.com>
>     media: v4l2-mem2mem: add lock to protect parameter num_rdy
> 
> Immad Mir <mirimmad17@gmail.com>
>     FS: JFS: Check for read-only mounted filesystem in txBegin
> 
> Immad Mir <mirimmad17@gmail.com>
>     FS: JFS: Fix null-ptr-deref Read in txBegin
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>     MIPS: dec: prom: Address -Warray-bounds warning
> 
> Yogesh <yogi.kernel@gmail.com>
>     fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev
> 
> Jan Kara <jack@suse.cz>
>     udf: Fix uninitialized array access for some pathnames
> 
> Christian Brauner <brauner@kernel.org>
>     ovl: check type and offset of struct vfsmount in ovl_entry
> 
> Patrisious Haddad <phaddad@nvidia.com>
>     RDMA/mlx5: Return the firmware result upon destroying QP/RQ
> 
> Marco Morandini <marco.morandini@polimi.it>
>     HID: add quirk for 03f0:464a HP Elite Presenter Mouse
> 
> Lang Yu <Lang.Yu@amd.com>
>     drm/amdgpu: install stub fence into potential unused fence pointers
> 
> gaoxu <gaoxu2@hihonor.com>
>     dma-remap: use kvmalloc_array/kvfree for larger dma memory remap
> 
> Ye Bin <yebin10@huawei.com>
>     quota: fix warning in dqgrab()
> 
> Jan Kara <jack@suse.cz>
>     quota: Properly disable quotas when add_dquot_ref() fails
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     iopoll: Call cpu_relax() in busy loops
> 
> Uday M Bhat <uday.m.bhat@intel.com>
>     ASoC: Intel: sof_sdw: Add support for Rex soundwire
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
> 
> Sumit Gupta <sumitg@nvidia.com>
>     PCI: tegra194: Fix possible array out of bounds access
> 
> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>     ASoC: Intel: sof_sdw: add quirk for LNL RVP
> 
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: Intel: sof_sdw: add quirk for MTL RVP
> 
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>     ALSA: emu10k1: roll up loops in DSP setup code for Audigy
> 
> hackyzh002 <hackyzh002@gmail.com>
>     drm/radeon: Fix integer overflow in radeon_cs_parser_init
> 
> Moshe Shemesh <moshe@nvidia.com>
>     net/mlx5: Skip clock update work when device is in error state
> 
> Eran Ben Elisha <eranbe@mellanox.com>
>     net/mlx5: Move all internal timer metadata into a dedicated struct
> 
> Eran Ben Elisha <eranbe@mellanox.com>
>     net/mlx5: Refactor init clock function
> 
> Eric Dumazet <edumazet@google.com>
>     macsec: use DEV_STATS_INC()
> 
> Clayton Yager <Clayton_Yager@selinc.com>
>     macsec: Fix traffic counters/statistics
> 
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>     mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/admin-guide/hw-vuln/srso.rst         |    4 +-
>  .../bindings/iio/addac/adi,ad74413r.yaml           |  158 +++
>  Makefile                                           |    4 +-
>  arch/arm/boot/dts/imx6dl-prtrvt.dts                |    4 +
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi              |   11 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  207 +--
>  arch/mips/include/asm/dec/prom.h                   |    2 +-
>  arch/powerpc/kernel/rtas_flash.c                   |    6 +-
>  arch/powerpc/mm/kasan/Makefile                     |    1 +
>  arch/riscv/lib/uaccess.S                           |  212 ++-
>  arch/x86/include/asm/entry-common.h                |    1 +
>  arch/x86/include/asm/nospec-branch.h               |   28 +-
>  arch/x86/kernel/cpu/amd.c                          |    1 +
>  arch/x86/kernel/cpu/bugs.c                         |   28 +-
>  arch/x86/kernel/static_call.c                      |   13 +
>  arch/x86/kernel/traps.c                            |    2 -
>  arch/x86/kernel/vmlinux.lds.S                      |   18 +-
>  arch/x86/kvm/svm/svm.c                             |    1 +
>  arch/x86/lib/retpoline.S                           |  141 +-
>  drivers/bluetooth/btusb.c                          |    3 +
>  drivers/bus/Makefile                               |    2 +-
>  drivers/bus/mhi/Kconfig                            |   18 +-
>  drivers/bus/mhi/Makefile                           |    4 +-
>  drivers/bus/mhi/host/Kconfig                       |   31 +
>  drivers/bus/mhi/{core => host}/Makefile            |    4 +-
>  drivers/bus/mhi/{core => host}/boot.c              |    0
>  drivers/bus/mhi/{core => host}/debugfs.c           |    0
>  drivers/bus/mhi/{core => host}/init.c              |   12 +
>  drivers/bus/mhi/{core => host}/internal.h          |    0
>  drivers/bus/mhi/{core => host}/main.c              |    0
>  drivers/bus/mhi/host/pci_generic.c                 |  345 +++++
>  drivers/bus/mhi/{core => host}/pm.c                |    0
>  drivers/bus/ti-sysc.c                              |    2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    6 +-
>  drivers/gpu/drm/panel/panel-simple.c               |   24 +-
>  drivers/gpu/drm/radeon/radeon_cs.c                 |    3 +-
>  drivers/hid/hid-ids.h                              |    1 +
>  drivers/hid/hid-quirks.c                           |    1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 |   11 +-
>  drivers/i2c/busses/i2c-designware-master.c         |   15 +-
>  drivers/iio/Kconfig                                |    1 +
>  drivers/iio/Makefile                               |    1 +
>  drivers/iio/adc/stx104.c                           |   98 +-
>  drivers/iio/addac/Kconfig                          |    8 +
>  drivers/iio/addac/Makefile                         |    6 +
>  drivers/infiniband/hw/mlx5/qpc.c                   |   10 +-
>  drivers/irqchip/irq-mips-gic.c                     |   63 +-
>  drivers/media/platform/mtk-vpu/mtk_vpu.c           |    6 +-
>  drivers/mmc/core/block.c                           |    7 +-
>  drivers/mmc/core/host.c                            |   26 +
>  drivers/mmc/host/bcm2835.c                         |    4 +-
>  drivers/mmc/host/meson-gx-mmc.c                    |   52 +-
>  drivers/mmc/host/sdhci_f_sdh30.c                   |   66 +-
>  drivers/mmc/host/sunxi-mmc.c                       |    4 +-
>  drivers/mmc/host/wbsd.c                            |    2 -
>  drivers/net/dsa/mv88e6xxx/chip.c                   |    8 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   16 +-
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |  166 ++-
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |    3 +-
>  drivers/net/macsec.c                               |   70 +-
>  drivers/net/phy/broadcom.c                         |   13 +
>  drivers/net/team/team.c                            |    4 +-
>  drivers/net/virtio_net.c                           |    4 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c         |   13 +-
>  drivers/pcmcia/rsrc_nonstatic.c                    |    2 +
>  drivers/tty/n_gsm.c                                |    3 +-
>  drivers/tty/serial/8250/8250_port.c                |    1 +
>  drivers/tty/serial/fsl_lpuart.c                    |    4 +-
>  drivers/usb/cdns3/cdnsp-gadget.h                   | 1463 ++++++++++++++++++++
>  drivers/usb/cdns3/gadget.c                         |   60 +-
>  drivers/usb/cdns3/gadget.h                         |    9 +-
>  drivers/usb/chipidea/ci_hdrc_imx.c                 |    5 +
>  drivers/usb/chipidea/usbmisc_imx.c                 |    2 +-
>  drivers/usb/dwc3/dwc3-qcom.c                       |   11 +-
>  drivers/usb/gadget/function/u_serial.c             |    3 +
>  drivers/usb/gadget/udc/core.c                      |   19 +
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |    4 +-
>  drivers/virtio/virtio_mmio.c                       |    8 +-
>  fs/btrfs/volumes.c                                 |    3 +-
>  fs/cifs/file.c                                     |    2 +-
>  fs/gfs2/super.c                                    |   26 +-
>  fs/jfs/jfs_dmap.c                                  |    3 +
>  fs/jfs/jfs_txnmgr.c                                |    5 +
>  fs/jfs/namei.c                                     |    5 +
>  fs/overlayfs/ovl_entry.h                           |    9 +
>  fs/quota/dquot.c                                   |    5 +-
>  fs/udf/unicode.c                                   |    2 +-
>  include/dt-bindings/iio/addac/adi,ad74413r.h       |   21 +
>  include/linux/iopoll.h                             |    2 +
>  include/linux/mhi.h                                |    2 +
>  include/linux/mlx5/driver.h                        |   12 +-
>  include/linux/mmc/host.h                           |    1 +
>  include/linux/objtool.h                            |   28 +
>  include/linux/usb/gadget.h                         |    4 +
>  include/linux/virtio_net.h                         |    4 +
>  include/media/v4l2-mem2mem.h                       |   18 +-
>  include/net/sock.h                                 |    6 +
>  kernel/dma/remap.c                                 |    4 +-
>  kernel/trace/ring_buffer.c                         |   14 +-
>  kernel/trace/trace.c                               |    3 +-
>  kernel/trace/trace_kprobe.c                        |    3 +-
>  kernel/trace/trace_probe_tmpl.h                    |   18 +-
>  kernel/trace/trace_uprobe.c                        |    3 +-
>  net/bluetooth/l2cap_core.c                         |    5 +
>  net/core/sock.c                                    |    2 +-
>  net/ipv4/ip_vti.c                                  |    4 +-
>  net/ipv4/tcp_timer.c                               |    4 +-
>  net/ipv6/ip6_vti.c                                 |    4 +-
>  net/key/af_key.c                                   |    4 +-
>  net/ncsi/ncsi-rsp.c                                |    5 +-
>  net/netfilter/ipvs/ip_vs_ctl.c                     |    4 +
>  net/netfilter/nf_conntrack_proto_sctp.c            |    6 +-
>  net/netfilter/nft_dynset.c                         |    3 +
>  net/unix/af_unix.c                                 |    9 +-
>  net/xfrm/xfrm_compat.c                             |    2 +-
>  net/xfrm/xfrm_interface_core.c                     |    4 +-
>  net/xfrm/xfrm_user.c                               |   14 +-
>  security/integrity/ima/Kconfig                     |    2 +-
>  sound/hda/hdac_regmap.c                            |    7 +-
>  sound/pci/emu10k1/emufx.c                          |  112 +-
>  sound/pci/hda/patch_realtek.c                      |   16 +-
>  sound/soc/codecs/rt5665.c                          |    2 +
>  sound/soc/intel/boards/sof_sdw.c                   |   25 +
>  sound/soc/meson/axg-tdm-formatter.c                |   42 +-
>  sound/usb/quirks-table.h                           |   29 +
>  tools/include/linux/objtool.h                      |   28 +
>  tools/objtool/arch/x86/decode.c                    |    2 +-
>  tools/objtool/check.c                              |   21 +-
>  .../selftests/net/forwarding/mirror_gre_changes.sh |    3 +-
>  130 files changed, 3442 insertions(+), 695 deletions(-)
> 
> 

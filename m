Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8236A787DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjHYCkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHYCkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D11FD0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:21 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso17011039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692931220; x=1693536020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxUTq8IprJHLgCxuWuKCqSn/kRAbYbpJqNpDrKaN3PE=;
        b=fW6K272mqFwaeUm7fDqWf7fUFT6F5uFrseTOY+x9V3+NEiEGnHCwY6L9SpZo95BEub
         f6OVjCkW5JyYW61/RItjKSiG84aCFGF7fUoNEOphifKCuU7yUcViMjXlmR+Iy8avU/pV
         +T7ltSGkMVun8ohLNmufIUs5PWCGvEaOWfyYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931220; x=1693536020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxUTq8IprJHLgCxuWuKCqSn/kRAbYbpJqNpDrKaN3PE=;
        b=EEt3W0NN10nQg7hqlF4sszu09Ie07i6jNWRNGLKjqTKBoyeqIKLoY+vmJOZw0tomjI
         3tx5ePS/K7/4J6AmX/RnCeqv0ubi+1fCAiiMeXwqsYWlM3V2keLsl3zrZi3pM0XQtp9T
         3SOEN9pKDVyiTLGaKuJwd0qqCkQF0zABYNhRc8hxRABLDMfD3m0ysD4QgKNMMkkjDHIP
         KRAqn99m9MNF9aLVw4gF93qyHbWOCWhejmJvdQBdbMQYL2NN2z+o249Eq8aCAiYpaDMB
         0zXQCQEzGvdqeGnCvrguFTR2Ucx/MZrrLZze03pLVcqimb8pkGzfUSrUamViknbqbuVb
         g01w==
X-Gm-Message-State: AOJu0Yw9o0/R6rneKvaqJ5hd3+TUdXUvFUlo08l6jfR4/aMg7Pgg85gb
        CvNi4XJX3dnpur2gyhKpiLj8fQ==
X-Google-Smtp-Source: AGHT+IEO1ftEn3tEP91i+weB3Bwo54Fh+XNh9oE+PtvAlNvigsA7z0jzUV90jGEGLat3Cp5JK+w8Cw==
X-Received: by 2002:a6b:620d:0:b0:786:f4a0:d37e with SMTP id f13-20020a6b620d000000b00786f4a0d37emr7523790iog.4.1692931220374;
        Thu, 24 Aug 2023 19:40:20 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id s21-20020a02cf35000000b0042b394eb984sm236116jar.105.2023.08.24.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:40:19 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:40:19 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
Message-ID: <20230825024019.GC4008060@google.com>
References: <20230824145023.559380953@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:48:43PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
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
>     Linux 5.15.128-rc1
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
> Christopher Obbard <chris.obbard@collabora.com>
>     arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> 
> Namjae Jeon <linkinjeon@kernel.org>
>     exfat: check if filename entries exceeds max filename length
> 
> Xin Long <lucien.xin@gmail.com>
>     netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: flush any delayed gfxoff on suspend entry
> 
> Wander Lairson Costa <wander@redhat.com>
>     drm/qxl: fix UAF on handle creation
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
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - Remodified 3k pull low procedure
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     soc: aspeed: socinfo: Add kfree for kstrdup
> 
> Jerome Brunet <jbrunet@baylibre.com>
>     ASoC: meson: axg-tdm-formatter: fix channel slot allocation
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     ASoC: rt5665: add missed regulator_bulk_disable
> 
> Xiaolei Wang <xiaolei.wang@windriver.com>
>     ARM: dts: imx: Set default tuning step for imx6sx usdhc
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict
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
> Piotr Gardocki <piotrx.gardocki@intel.com>
>     iavf: fix FDIR rule fields masks validation
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
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: deactivate catchall elements in next generation
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix false-positive lockdep splat
> 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
>     drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs
> 
> Petr Machata <petrm@nvidia.com>
>     selftests: mirror_gre_changes: Tighten up the TTL test match
> 
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>     net: phy: fix IRQ-based wake-on-lan over hibernate / power off
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
> Quan Nguyen <quan@os.amperecomputing.com>
>     i2c: designware: Correct length byte validation logic
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
> Yicong Yang <yangyicong@hisilicon.com>
>     i2c: hisi: Only handle the interrupt of the driver's transfer
> 
> Chengfeng Ye <dg573847474@gmail.com>
>     i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue
> 
> Steve French <stfrench@microsoft.com>
>     cifs: fix potential oops in cifs_oplock_break
> 
> Maxime Coquelin <maxime.coquelin@redhat.com>
>     vduse: Use proper spinlock for IRQ injection
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     virtio-mmio: don't break lifecycle of vm_dev
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: move out now unused BG from the reclaim list
> 
> Xu Yang <xu.yang_2@nxp.com>
>     ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node
> 
> Andreas Kemnade <andreas@kemnade.info>
>     ARM: dts: imx6sll: fixup of operating points
> 
> Ivan Mikhaylov <fr0st61te@gmail.com>
>     net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     mmc: sunxi: fix deferred probing
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     mmc: bcm2835: fix deferred probing
> 
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: fix use-after-free on core driver unbind
> 
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix NULL-deref on suspend
> 
> Robert Hodaszi <robert.hodaszi@digi.com>
>     tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A
> 
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms
> 
> Jesse Taube <mr.bossman075@gmail.com>
>     tty: serial: fsl_lpuart: Add i.MXRT1050 support
> 
> Roger Quadros <rogerq@kernel.org>
>     usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
> 
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: gadget: drop dead hibernation code
> 
> Kushagra Verma <kushagra765@outlook.com>
>     usb: dwc3: Fix typos in gadget.c
> 
> Wesley Cheng <quic_wcheng@quicinc.com>
>     usb: dwc3: Remove DWC3 locking during gadget suspend/resume
> 
> Wesley Cheng <quic_wcheng@quicinc.com>
>     usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
> 
> Hersen Wu <hersenxs.wu@amd.com>
>     drm/amd/display: fix access hdcp_workqueue assert
> 
> hersen wu <hersenxs.wu@amd.com>
>     drm/amd/display: phase3 mst hdcp for multiple displays
> 
> hersen wu <hersenxs.wu@amd.com>
>     drm/amd/display: save restore hdcp state when display is unplugged from mst hub
> 
> Zev Weiss <zev@bewilderbeest.net>
>     ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks
> 
> Song Yoong Siang <yoong.siang.song@intel.com>
>     igc: read before write to SRRCTL register
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: addac: stx104: Fix race condition when converting analog-to-digital
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: addac: stx104: Fix race condition for stx104_write_raw()
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: stx104: Move to addac subdirectory
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: adc: stx104: Implement and utilize register structures
> 
> William Breathitt Gray <william.gray@linaro.org>
>     iio: adc: stx104: Utilize iomap interface
> 
> Cosmin Tanislav <demonsingur@gmail.com>
>     iio: add addac subdirectory
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
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted
> 
> Jia-Ju Bai <baijiaju@buaa.edu.cn>
>     fs: ntfs3: Fix possible null-pointer dereferences in mi_read()
> 
> Edward Lo <loyuantsung@gmail.com>
>     fs/ntfs3: Enhance sanity check while generating attr_list
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
> Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>     watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     firewire: net: fix use after free in fwnet_finish_incoming_packet()
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
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
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
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: fix warning in cifs_smb3_do_mount()
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
> stuarthayhurst <stuart.a.hayhurst@gmail.com>
>     HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
> 
> gaoxu <gaoxu2@hihonor.com>
>     dma-remap: use kvmalloc_array/kvfree for larger dma memory remap
> 
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>     ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     iopoll: Call cpu_relax() in busy loops
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
> 
> Sumit Gupta <sumitg@nvidia.com>
>     PCI: tegra194: Fix possible array out of bounds access
> 
> Jakub Kicinski <kuba@kernel.org>
>     net: tls: avoid discarding data on record close
> 
> Tariq Toukan <tariqt@nvidia.com>
>     net/tls: Multi-threaded calls to TX tls_dev_del
> 
> Tariq Toukan <tariqt@nvidia.com>
>     net/tls: Perform immediate device ctx cleanup when possible
> 
> Eric Dumazet <edumazet@google.com>
>     macsec: use DEV_STATS_INC()
> 
> Clayton Yager <Clayton_Yager@selinc.com>
>     macsec: Fix traffic counters/statistics
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: tc_actions: Use ncat instead of nc
> 
> Davide Caratti <dcaratti@redhat.com>
>     selftests: forwarding: tc_actions: cleanup temporary files when test is aborted
> 
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>     mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/admin-guide/hw-vuln/srso.rst         |   4 +-
>  MAINTAINERS                                        |   2 +-
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |   2 +-
>  arch/arm/boot/dts/imx6dl-prtrvt.dts                |   4 +
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi              |  11 +-
>  arch/arm/boot/dts/imx6sll.dtsi                     |  24 ++-
>  arch/arm/boot/dts/imx6sx.dtsi                      |   6 +
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   4 +-
>  arch/powerpc/kernel/rtas_flash.c                   |   6 +-
>  arch/powerpc/mm/kasan/Makefile                     |   1 +
>  arch/riscv/lib/uaccess.S                           |  11 +-
>  arch/x86/include/asm/entry-common.h                |   1 +
>  arch/x86/include/asm/nospec-branch.h               |  28 +--
>  arch/x86/kernel/cpu/amd.c                          |   1 +
>  arch/x86/kernel/cpu/bugs.c                         |  28 ++-
>  arch/x86/kernel/static_call.c                      |  13 ++
>  arch/x86/kernel/traps.c                            |   2 -
>  arch/x86/kernel/vmlinux.lds.S                      |  20 +-
>  arch/x86/kvm/svm/svm.c                             |   2 +
>  arch/x86/lib/retpoline.S                           | 141 +++++++++-----
>  drivers/bluetooth/btusb.c                          |   3 +
>  drivers/bus/ti-sysc.c                              |   2 +
>  drivers/firewire/net.c                             |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   9 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   6 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 211 +++++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |  14 ++
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  30 +++
>  drivers/gpu/drm/panel/panel-simple.c               |  24 +--
>  drivers/gpu/drm/qxl/qxl_drv.h                      |   2 +-
>  drivers/gpu/drm/qxl/qxl_dumb.c                     |   5 +-
>  drivers/gpu/drm/qxl/qxl_gem.c                      |  25 ++-
>  drivers/gpu/drm/qxl/qxl_ioctl.c                    |   6 +-
>  drivers/hid/hid-ids.h                              |   1 +
>  drivers/hid/hid-logitech-hidpp.c                   |   4 +
>  drivers/hid/hid-quirks.c                           |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 |  11 +-
>  drivers/i2c/busses/i2c-designware-master.c         |  16 +-
>  drivers/i2c/busses/i2c-hisi.c                      |   8 +
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/adc/Kconfig                            |  16 --
>  drivers/iio/adc/Makefile                           |   1 -
>  drivers/iio/addac/Kconfig                          |  24 +++
>  drivers/iio/addac/Makefile                         |   7 +
>  drivers/iio/{adc => addac}/stx104.c                |  98 +++++++---
>  drivers/infiniband/hw/mlx5/qpc.c                   |  10 +-
>  drivers/media/platform/mtk-vpu/mtk_vpu.c           |   6 +-
>  drivers/mmc/core/block.c                           |   7 +-
>  drivers/mmc/host/bcm2835.c                         |   4 +-
>  drivers/mmc/host/sdhci_f_sdh30.c                   |  66 +++----
>  drivers/mmc/host/sunxi-mmc.c                       |   4 +-
>  drivers/mmc/host/wbsd.c                            |   2 -
>  drivers/net/dsa/mv88e6xxx/chip.c                   |   8 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  16 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  10 +
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  77 +++++++-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h        |   2 +
>  drivers/net/ethernet/intel/igc/igc_base.h          |  11 +-
>  drivers/net/ethernet/intel/igc/igc_main.c          |   7 +-
>  drivers/net/macsec.c                               |  70 +++++--
>  drivers/net/phy/broadcom.c                         |  13 ++
>  drivers/net/phy/phy_device.c                       |  13 +-
>  drivers/net/team/team.c                            |   4 +-
>  drivers/net/virtio_net.c                           |   4 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c         |  13 +-
>  drivers/pcmcia/rsrc_nonstatic.c                    |   2 +
>  drivers/soc/aspeed/aspeed-socinfo.c                |   1 +
>  drivers/thunderbolt/retimer.c                      |  29 ++-
>  drivers/tty/n_gsm.c                                |   3 +-
>  drivers/tty/serial/8250/8250_port.c                |   1 +
>  drivers/tty/serial/fsl_lpuart.c                    |  26 ++-
>  drivers/usb/chipidea/ci_hdrc_imx.c                 |   5 +
>  drivers/usb/chipidea/usbmisc_imx.c                 |   2 +-
>  drivers/usb/dwc3/core.c                            |   9 +-
>  drivers/usb/dwc3/dwc3-qcom.c                       |  11 +-
>  drivers/usb/dwc3/gadget.c                          | 116 +++++------
>  drivers/usb/gadget/function/u_serial.c             |   3 +
>  drivers/vdpa/vdpa_user/vduse_dev.c                 |   8 +-
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   4 +-
>  drivers/virtio/virtio_mmio.c                       |   5 +-
>  drivers/watchdog/sp5100_tco.c                      |   4 +-
>  fs/btrfs/block-group.c                             |   5 +-
>  fs/btrfs/volumes.c                                 |   3 +-
>  fs/cifs/cifsfs.c                                   |  28 +--
>  fs/cifs/file.c                                     |  25 ++-
>  fs/exfat/dir.c                                     |   9 +-
>  fs/gfs2/super.c                                    |  26 +--
>  fs/ntfs3/frecord.c                                 |  16 +-
>  fs/ntfs3/fsntfs.c                                  |   2 +-
>  fs/ntfs3/index.c                                   |   6 +
>  fs/ntfs3/ntfs_fs.h                                 |   2 +
>  fs/ntfs3/record.c                                  |  10 +-
>  fs/overlayfs/ovl_entry.h                           |   9 +
>  include/linux/iopoll.h                             |   2 +
>  include/linux/objtool.h                            |  28 +++
>  include/linux/virtio_net.h                         |   4 +
>  include/media/v4l2-mem2mem.h                       |  18 +-
>  include/net/sock.h                                 |   6 +
>  include/net/tls.h                                  |   2 +
>  kernel/dma/remap.c                                 |   4 +-
>  kernel/trace/ring_buffer.c                         |  14 +-
>  kernel/trace/trace.c                               |   3 +-
>  net/bluetooth/l2cap_core.c                         |   5 +
>  net/core/sock.c                                    |   2 +-
>  net/ipv4/ip_vti.c                                  |   4 +-
>  net/ipv4/tcp_timer.c                               |   4 +-
>  net/ipv6/ip6_vti.c                                 |   4 +-
>  net/key/af_key.c                                   |   4 +-
>  net/ncsi/ncsi-rsp.c                                |   5 +-
>  net/netfilter/ipvs/ip_vs_ctl.c                     |   4 +
>  net/netfilter/nf_conntrack_proto_sctp.c            |   6 +-
>  net/netfilter/nf_tables_api.c                      |   1 +
>  net/netfilter/nft_dynset.c                         |   3 +
>  net/netfilter/nft_set_pipapo.c                     |  13 +-
>  net/tls/tls_device.c                               | 137 +++++++------
>  net/unix/af_unix.c                                 |   9 +-
>  net/xfrm/xfrm_compat.c                             |   2 +-
>  net/xfrm/xfrm_interface_core.c                     |   4 +-
>  net/xfrm/xfrm_user.c                               |  14 +-
>  sound/hda/hdac_regmap.c                            |   7 +-
>  sound/pci/hda/patch_realtek.c                      |  16 +-
>  sound/soc/codecs/rt5665.c                          |   2 +
>  sound/soc/meson/axg-tdm-formatter.c                |  42 ++--
>  sound/soc/sof/intel/hda.c                          |  12 +-
>  sound/usb/quirks-table.h                           |  29 +++
>  tools/include/linux/objtool.h                      |  28 +++
>  tools/objtool/arch/x86/decode.c                    |   2 +-
>  tools/objtool/check.c                              |  21 +-
>  .../selftests/net/forwarding/mirror_gre_changes.sh |   3 +-
>  .../testing/selftests/net/forwarding/tc_actions.sh |  18 +-
>  135 files changed, 1437 insertions(+), 618 deletions(-)
> 
> 

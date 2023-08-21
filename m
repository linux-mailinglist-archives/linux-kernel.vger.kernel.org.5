Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00480783607
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjHUW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHUW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:58:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE4129
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:58:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7922c7967d4so61148739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692658735; x=1693263535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xgwi5XJoNER0RK6GKy94XHBNpcZ+1nQtxyuzRD5m7z4=;
        b=rM1ABx2WigSH8/Z0oEWHiAjdsRCUNbzxQZgXv9Vb/nh+HNT5OsBq0VOLhoz3bgsvpY
         1RlTTUtNbVwMHHARFo5eGiaLRfBplmq9NYdAa3E56G6O8I89HSvL7OB68BvmWy37bQ1k
         Xaig06MkZKiwr1mHTG/OuhM2V4OhAMirDHmoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658735; x=1693263535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgwi5XJoNER0RK6GKy94XHBNpcZ+1nQtxyuzRD5m7z4=;
        b=C2EB7xvQa0zWvPIlcNsMHAqWyDatYOqqOw9mLLUoanTEY6SfJ/RcDTbkotcyd44zqU
         O8j/yADUZjiDXGFsUR65xXAQaHC0faRYIr8a9QLkeQ3ASGNWnjhi/WZe24kG1ap+cMUo
         oLCOUwcV5g9hXDdlYe7M7s1VdGZ6zBz58RQbPeOCsQ1FdffzqrYLptPKVXo7/2QCdzRU
         HT5RKEROG1fh6r82Ap7fUPobmwouQEQk4gJXGmKSiA98B3/sC/nHUi+1gYr2o7FQ9YfH
         6jJqyjolZi4QhvCCuUOo85f05aXWshS7iZDIDuEqUdj/kQDM44dSJ+4Kv030rTTCVYBf
         sFig==
X-Gm-Message-State: AOJu0YwTuss2L2eNt85eUKd+FjUTMgIC/bRlthaQ2xqiPPs+co/gPTvg
        6M0VrE78xvz0to765Mb2IuLgrg==
X-Google-Smtp-Source: AGHT+IFF7BmKrnfzlMPt97IXrYrLmJzyZ5/KaSGqqwbMWJW+2vIeWWt7dEk05pOExy7WuTXGJ6+QGw==
X-Received: by 2002:a92:cb44:0:b0:34b:aa34:a5ca with SMTP id f4-20020a92cb44000000b0034baa34a5camr8881229ilq.4.1692658734921;
        Mon, 21 Aug 2023 15:58:54 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b13-20020a920b0d000000b00348880831fdsm1140890ilf.58.2023.08.21.15.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:58:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 22:58:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <20230821225853.GB651285@google.com>
References: <20230821194122.695845670@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

For RCU,
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.47-rc1
> 
> Yangtao Li <frank.li@vivo.com>
>     mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
> 
> Jason Xing <kernelxing@tencent.com>
>     net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     af_unix: Fix null-ptr-deref in unix_stream_sendpage().
> 
> Guchun Chen <guchun.chen@amd.com>
>     drm/amdgpu: keep irq count in amdgpu_irq_disable_all
> 
> Tim Huang <Tim.Huang@amd.com>
>     drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU v13.0.4/11
> 
> Mark Brown <broonie@kernel.org>
>     arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
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
>     x86/alternative: Make custom return thunk unconditional
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix __x86_return_thunk symbol type
> 
> Xin Long <lucien.xin@gmail.com>
>     netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
> 
> Mike Kravetz <mike.kravetz@oracle.com>
>     hugetlb: do not clear hugetlb dtor until allocating vmemmap
> 
> Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
>     drm/amd/display: Implement workaround for writing to OTG_PIXEL_RATE_DIV register
> 
> Vincent Guittot <vincent.guittot@linaro.org>
>     sched/fair: Remove capacity inversion detection
> 
> Vincent Guittot <vincent.guittot@linaro.org>
>     sched/fair: unlink misfit task from cpu overutilized
> 
> Sergey Senozhatsky <senozhatsky@chromium.org>
>     zsmalloc: allow only one active pool compaction context
> 
> Daniel Miess <daniel.miess@amd.com>
>     drm/amd/display: disable RCO for DCN314
> 
> Arnd Bergmann <arnd@arndb.de>
>     ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
> 
> Umio Yasuno <coelacanth_dream@protonmail.com>
>     drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7
> 
> Tim Huang <Tim.Huang@amd.com>
>     drm/amdgpu: skip fence GFX interrupts disable/enable for S0ix
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: flush any delayed gfxoff on suspend entry
> 
> Jani Nikula <jani.nikula@intel.com>
>     drm/i915/sdvo: fix panel_type initialization
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
> Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>     blk-crypto: dynamically allocate fallback profile
> 
> Yogesh Hegde <yogi.kernel@gmail.com>
>     arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
> 
> Hawkins Jiawei <yin31149@gmail.com>
>     virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
> 
> Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>     riscv: Handle zicsr/zifencei issue between gcc and binutils
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
> Zev Weiss <zev@bewilderbeest.net>
>     soc: aspeed: uart-routing: Use __sysfs_match_string
> 
> Stefan Binding <sbinding@opensource.cirrus.com>
>     ALSA: hda/realtek: Add quirks for HP G11 Laptops
> 
> Jerome Brunet <jbrunet@baylibre.com>
>     ASoC: meson: axg-tdm-formatter: fix channel slot allocation
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     ASoC: rt5665: add missed regulator_bulk_disable
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     arm64: dts: imx93: Fix anatop node size
> 
> Xiaolei Wang <xiaolei.wang@windriver.com>
>     ARM: dts: imx: Set default tuning step for imx6sx usdhc
> 
> Fabio Estevam <festevam@denx.de>
>     arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration
> 
> Andrej Picej <andrej.picej@norik.com>
>     ARM: dts: imx6: phytec: fix RTC interrupt level
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: imx: align LED node names with dtschema
> 
> Christopher Obbard <chris.obbard@collabora.com>
>     arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
> 
> Christopher Obbard <chris.obbard@collabora.com>
>     arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict
> 
> Tony Lindgren <tony@atomide.com>
>     bus: ti-sysc: Flush posted write on enable before reset
> 
> Marcin Szycik <marcin.szycik@linux.intel.com>
>     ice: Block switchdev mode when ADQ is active and vice versa
> 
> Manish Chopra <manishc@marvell.com>
>     qede: fix firmware halt over suspend and resume
> 
> Eric Dumazet <edumazet@google.com>
>     net: do not allow gso_size to be set to GSO_BY_FRAGS
> 
> Abel Wu <wuyun.abel@bytedance.com>
>     sock: Fix misuse of sk_under_memory_pressure()
> 
> Edward Cree <ecree.xilinx@gmail.com>
>     sfc: don't unregister flow_indr if it was never registered
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
> Jakub Kicinski <kuba@kernel.org>
>     net: openvswitch: reject negative ifindex
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
> Michal Schmidt <mschmidt@redhat.com>
>     octeon_ep: cancel tx_timeout_task later in remove sequence
> 
> Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>     net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source
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
> Xiang Yang <xiangyang3@huawei.com>
>     net: pcs: Add missing put_device call in miic_create
> 
> Jason Wang <jasowang@redhat.com>
>     virtio-net: set queues after driver_ok
> 
> Laurent Vivier <lvivier@redhat.com>
>     virtio_net: notify MAC address change on device initialization
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
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: fix incorrect splitting in btrfs_drop_extent_map_range
> 
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
> 
> Yi Yang <yiyang13@huawei.com>
>     tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux
> 
> Dragos Tatulea <dtatulea@nvidia.com>
>     vdpa: Enable strict validation for netlinks ops
> 
> Lin Ma <linma@zju.edu.cn>
>     vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
> 
> Lin Ma <linma@zju.edu.cn>
>     vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
> 
> Lin Ma <linma@zju.edu.cn>
>     vdpa: Add features attr to vdpa_nl_policy for nlattr length check
> 
> Nathan Lynch <nathanl@linux.ibm.com>
>     powerpc/rtas_flash: allow user copy to flash block cache objects
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     fbdev: mmp: fix value check in mmphw_probe()
> 
> Parker Newman <pnewman@connecttech.com>
>     i2c: tegra: Fix i2c-tegra DMA config option processing
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
> Eugenio Pérez <eperezma@redhat.com>
>     vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
> 
> Dragos Tatulea <dtatulea@nvidia.com>
>     vdpa/mlx5: Fix mr->initialized semantics
> 
> Maxime Coquelin <maxime.coquelin@redhat.com>
>     vduse: Use proper spinlock for IRQ injection
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     virtio-mmio: don't break lifecycle of vm_dev
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix use-after-free of new block group that became unused
> 
> David Sterba <dsterba@suse.com>
>     btrfs: convert btrfs_block_group::seq_zone to runtime flag
> 
> David Sterba <dsterba@suse.com>
>     btrfs: convert btrfs_block_group::needs_free_space to runtime flag
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: move out now unused BG from the reclaim list
> 
> Daniel Vetter <daniel.vetter@ffwll.ch>
>     video/aperture: Only remove sysfb on the default vga pci device
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>     fbdev/hyperv-fb: Do not set struct fb_info.apertures
> 
> Xu Yang <xu.yang_2@nxp.com>
>     ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node
> 
> Marc Zyngier <maz@kernel.org>
>     KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
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
> Song Yoong Siang <yoong.siang.song@intel.com>
>     igc: read before write to SRRCTL register
> 
> Chen Lin <chen.lin5@zte.com.cn>
>     ring-buffer: Do not swap cpu_buffer during resize process
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Bluetooth: MGMT: Use correct address for memcpy()
> 
> Benjamin Gray <bgray@linux.ibm.com>
>     powerpc/kasan: Disable KCOV in KASAN code
> 
> Luke D. Jones <luke@ljones.dev>
>     ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V
> 
> Luke D. Jones <luke@ljones.dev>
>     ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
> 
> Luke D. Jones <luke@ljones.dev>
>     ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
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
> Xiubo Li <xiubli@redhat.com>
>     ceph: try to dump the msgs when decoding fails
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
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Limit Intel Barlow Ridge USB3 bandwidth
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Add Intel Barlow Ridge PCI ID
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
> Avichal Rakesh <arakesh@google.com>
>     usb: gadget: uvc: queue empty isoc requests if no video buffer is available
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
> 
> Andrey Konovalov <andrey.konovalov@linaro.org>
>     media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250
> 
> Yunfei Dong <yunfei.dong@mediatek.com>
>     media: v4l2-mem2mem: add lock to protect parameter num_rdy
> 
> Lu Hongfei <luhongfei@vivo.com>
>     led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     serial: stm32: Ignore return value of uart_remove_one_port() in .remove()
> 
> Winston Wen <wentao@uniontech.com>
>     cifs: fix session state check in reconnect to avoid use-after-free issue
> 
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: fix warning in cifs_smb3_do_mount()
> 
> Matthew Anderson <ruinairas1992@gmail.com>
>     ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio
> 
> Even Xu <even.xu@intel.com>
>     HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID
> 
> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>     ASoC: SOF: core: Free the firmware trace before calling snd_sof_shutdown()
> 
> Daniel Miess <daniel.miess@amd.com>
>     drm/amd/display: Enable dcn314 DPP RCO
> 
> Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>     drm/amd/display: Skip DPP DTO update if root clock is gated
> 
> Patrisious Haddad <phaddad@nvidia.com>
>     RDMA/mlx5: Return the firmware result upon destroying QP/RQ
> 
> Alvin Lee <alvin.lee2@amd.com>
>     drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz
> 
> Lang Yu <Lang.Yu@amd.com>
>     drm/amdgpu: install stub fence into potential unused fence pointers
> 
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>     iommu/amd: Introduce Disable IRTE Caching Support
> 
> stuarthayhurst <stuart.a.hayhurst@gmail.com>
>     HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
> 
> Ofir Bitton <obitton@habana.ai>
>     accel/habanalabs: add pci health check during heartbeat
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
> Uday M Bhat <uday.m.bhat@intel.com>
>     ASoC: Intel: sof_sdw: Add support for Rex soundwire
> 
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: Intel: sof_sdw_rt_sdca_jack_common: test SOF_JACK_JDSRC in _exit
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
> 
> Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>     ASoC: amd: vangogh: Add check for acp config flags in vangogh platform
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     drm: rcar-du: remove R-Car H3 ES1.* workarounds
> 
> Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>     drm/stm: ltdc: fix late dereference check
> 
> Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>     ASoC: SOF: amd: Add pci revision id check
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
> Jack Xiao <Jack.Xiao@amd.com>
>     drm/amdgpu: fix memory leak in mes self test
> 
> hackyzh002 <hackyzh002@gmail.com>
>     drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
> 
> Longlong Yao <Longlong.Yao@amd.com>
>     drm/amdgpu: fix calltrace warning in amddrm_buddy_fini
> 
> Li Yang <leoyang.li@nxp.com>
>     net: phy: at803x: fix the wol setting functions
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     net: phy: at803x: Use devm_regulator_get_enable_optional()
> 
> Gerd Bayer <gbayer@linux.ibm.com>
>     net/smc: Fix setsockopt and sysctl to specify same buffer size again
> 
> D. Wythe <alibuda@linux.alibaba.com>
>     net/smc: replace mutex rmbs_lock and sndbufs_lock with rw_semaphore
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: tc_actions: Use ncat instead of nc
> 
> Davide Caratti <dcaratti@redhat.com>
>     selftests: forwarding: tc_actions: cleanup temporary files when test is aborted
> 
> Andrew Yang <andrew.yang@mediatek.com>
>     zsmalloc: fix races between modifications of fullness and isolated
> 
> Nhat Pham <nphamcs@gmail.com>
>     zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks
> 
> Maulik Shah <quic_mkshah@quicinc.com>
>     cpuidle: psci: Move enabling OSI mode after power domains creation
> 
> Ulf Hansson <ulf.hansson@linaro.org>
>     cpuidle: psci: Extend information in log about OSI/PC mode
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
>  Documentation/admin-guide/kernel-parameters.txt    |   1 +
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/imx50-kobo-aura.dts              |   2 +-
>  arch/arm/boot/dts/imx53-cx9020.dts                 |  10 +-
>  arch/arm/boot/dts/imx53-m53evk.dts                 |   4 +-
>  arch/arm/boot/dts/imx53-m53menlo.dts               |   6 +-
>  arch/arm/boot/dts/imx53-tx53.dtsi                  |   2 +-
>  arch/arm/boot/dts/imx53-usbarmory.dts              |   2 +-
>  arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6dl-prtrvt.dts                |   4 +
>  arch/arm/boot/dts/imx6dl-riotboard.dts             |   4 +-
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         |   6 +-
>  arch/arm/boot/dts/imx6q-gw5400-a.dts               |   6 +-
>  arch/arm/boot/dts/imx6q-h100.dts                   |   6 +-
>  arch/arm/boot/dts/imx6q-kp.dtsi                    |   4 +-
>  arch/arm/boot/dts/imx6q-marsboard.dts              |   4 +-
>  arch/arm/boot/dts/imx6q-tbs2910.dts                |   2 +-
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi               |   4 +-
>  arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   4 +-
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |   4 +-
>  arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw5903.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw5907.dtsi              |   4 +-
>  arch/arm/boot/dts/imx6qdl-gw5910.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw5912.dtsi              |   6 +-
>  arch/arm/boot/dts/imx6qdl-gw5913.dtsi              |   4 +-
>  arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  10 +-
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   4 +-
>  arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi         |   8 +-
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   4 +-
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi              |  11 +-
>  arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   2 +-
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   2 +-
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   2 +-
>  arch/arm/boot/dts/imx6qdl-ts7970.dtsi              |   4 +-
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   2 +-
>  arch/arm/boot/dts/imx6sl-evk.dts                   |   2 +-
>  arch/arm/boot/dts/imx6sll-evk.dts                  |   2 +-
>  arch/arm/boot/dts/imx6sll.dtsi                     |   2 +-
>  arch/arm/boot/dts/imx6sx-sabreauto.dts             |   2 +-
>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             |   4 +-
>  arch/arm/boot/dts/imx6sx.dtsi                      |   6 +
>  arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi   |   2 +-
>  arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   2 +-
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   7 +-
>  arch/arm64/boot/dts/freescale/imx93.dtsi           |   2 +-
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
>  .../boot/dts/rockchip/rk3399-rock-4c-plus.dts      |   3 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   6 +-
>  arch/arm64/include/asm/fpsimd.h                    |   4 +-
>  arch/arm64/include/asm/kvm_host.h                  |   2 +
>  arch/arm64/kernel/fpsimd.c                         |   6 +-
>  arch/arm64/kernel/ptrace.c                         |   9 +-
>  arch/arm64/kernel/signal.c                         |   2 +-
>  arch/arm64/kvm/arm.c                               |   6 +-
>  arch/arm64/kvm/vgic/vgic-v3.c                      |   2 +-
>  arch/arm64/kvm/vgic/vgic-v4.c                      |   7 +-
>  arch/powerpc/kernel/rtas_flash.c                   |   6 +-
>  arch/powerpc/mm/kasan/Makefile                     |   1 +
>  arch/riscv/Kconfig                                 |  28 +--
>  arch/riscv/kernel/compat_vdso/Makefile             |   8 +-
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
>  block/blk-crypto-fallback.c                        |  36 ++--
>  drivers/bluetooth/btusb.c                          |   3 +
>  drivers/bus/ti-sysc.c                              |   2 +
>  drivers/cpuidle/cpuidle-psci-domain.c              |  42 ++--
>  drivers/firewire/net.c                             |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  41 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   9 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   6 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 211 +++++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |  14 ++
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  30 +++
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |   3 +-
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c  |   8 +
>  .../gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c    |   5 +
>  .../drm/amd/display/dc/dcn314/dcn314_resource.c    |  20 ++
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c  |  22 +++
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h  |   3 +-
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   2 +-
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h  |   3 +-
>  .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |   4 +-
>  .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |   2 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   4 +-
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  14 +-
>  drivers/gpu/drm/i915/display/intel_sdvo.c          |   2 +-
>  drivers/gpu/drm/nouveau/nouveau_connector.c        |   8 +-
>  drivers/gpu/drm/panel/panel-simple.c               |  24 +--
>  drivers/gpu/drm/qxl/qxl_drv.h                      |   2 +-
>  drivers/gpu/drm/qxl/qxl_dumb.c                     |   5 +-
>  drivers/gpu/drm/qxl/qxl_gem.c                      |  25 ++-
>  drivers/gpu/drm/qxl/qxl_ioctl.c                    |   6 +-
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |  37 +---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  48 -----
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   2 -
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h             |   3 +-
>  drivers/gpu/drm/stm/ltdc.c                         |   4 +-
>  drivers/hid/hid-logitech-hidpp.c                   |   4 +
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 |  11 +-
>  drivers/i2c/busses/i2c-designware-master.c         |  16 +-
>  drivers/i2c/busses/i2c-hisi.c                      |   8 +
>  drivers/i2c/busses/i2c-tegra.c                     |   2 +-
>  drivers/infiniband/hw/mlx5/qpc.c                   |  10 +-
>  drivers/iommu/amd/amd_iommu_types.h                |   4 +
>  drivers/iommu/amd/init.c                           |  36 ++++
>  drivers/leds/rgb/leds-qcom-lpg.c                   |   8 +-
>  drivers/media/platform/mediatek/vpu/mtk_vpu.c      |   6 +-
>  drivers/media/platform/qcom/camss/camss-vfe.c      |   6 +-
>  drivers/misc/habanalabs/common/device.c            |  15 +-
>  drivers/misc/habanalabs/common/habanalabs.h        |   2 +
>  drivers/misc/habanalabs/common/habanalabs_drv.c    |   2 -
>  drivers/mmc/core/block.c                           |   7 +-
>  drivers/mmc/host/sdhci_f_sdh30.c                   |  66 +++----
>  drivers/mmc/host/wbsd.c                            |   2 -
>  drivers/net/dsa/mv88e6xxx/chip.c                   |   8 +
>  drivers/net/ethernet/cadence/macb_main.c           |   9 +-
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  16 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  10 +
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  77 +++++++-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h        |   2 +
>  drivers/net/ethernet/intel/ice/ice_eswitch.c       |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c          |   5 +
>  drivers/net/ethernet/intel/igc/igc_base.h          |  11 +-
>  drivers/net/ethernet/intel/igc/igc_main.c          |   7 +-
>  .../net/ethernet/marvell/octeon_ep/octep_main.c    |   2 +-
>  drivers/net/ethernet/qlogic/qede/qede_main.c       |  10 +
>  drivers/net/ethernet/sfc/tc.c                      |   2 +-
>  drivers/net/pcs/pcs-rzn1-miic.c                    |  10 +-
>  drivers/net/phy/at803x.c                           |  89 ++++-----
>  drivers/net/phy/broadcom.c                         |  13 ++
>  drivers/net/phy/phy_device.c                       |  13 +-
>  drivers/net/team/team.c                            |   4 +-
>  drivers/net/virtio_net.c                           |  26 ++-
>  drivers/pci/controller/dwc/pcie-tegra194.c         |  13 +-
>  drivers/pcmcia/rsrc_nonstatic.c                    |   2 +
>  drivers/soc/aspeed/aspeed-socinfo.c                |   1 +
>  drivers/soc/aspeed/aspeed-uart-routing.c           |   2 +-
>  drivers/thunderbolt/nhi.c                          |   2 +
>  drivers/thunderbolt/nhi.h                          |   4 +
>  drivers/thunderbolt/quirks.c                       |   8 +
>  drivers/thunderbolt/retimer.c                      |  29 ++-
>  drivers/tty/n_gsm.c                                |   3 +-
>  drivers/tty/serial/8250/8250_port.c                |   1 +
>  drivers/tty/serial/fsl_lpuart.c                    |   4 +-
>  drivers/tty/serial/stm32-usart.c                   |   5 +-
>  drivers/usb/chipidea/ci_hdrc_imx.c                 |   5 +
>  drivers/usb/chipidea/usbmisc_imx.c                 |   2 +-
>  drivers/usb/gadget/function/u_serial.c             |   3 +
>  drivers/usb/gadget/function/uvc_video.c            |  32 +++-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h                 |   2 +
>  drivers/vdpa/mlx5/core/mr.c                        | 105 +++++++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   4 +-
>  drivers/vdpa/vdpa.c                                |   9 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c                 |   8 +-
>  drivers/video/aperture.c                           |   7 +-
>  drivers/video/fbdev/hyperv_fb.c                    |  17 +-
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   4 +-
>  drivers/virtio/virtio_mmio.c                       |   5 +-
>  drivers/watchdog/sp5100_tco.c                      |   4 +-
>  fs/btrfs/block-group.c                             |  14 +-
>  fs/btrfs/block-group.h                             |  18 +-
>  fs/btrfs/extent_map.c                              |   6 +-
>  fs/btrfs/free-space-tree.c                         |  10 +-
>  fs/btrfs/tests/free-space-tree-tests.c             |   2 +-
>  fs/btrfs/volumes.c                                 |   3 +-
>  fs/btrfs/zoned.c                                   |   7 +-
>  fs/ceph/mds_client.c                               |   4 +
>  fs/gfs2/super.c                                    |  26 +--
>  fs/ntfs3/frecord.c                                 |  16 +-
>  fs/ntfs3/fsntfs.c                                  |   2 +-
>  fs/ntfs3/index.c                                   |   6 +
>  fs/ntfs3/ntfs_fs.h                                 |   2 +
>  fs/ntfs3/record.c                                  |  10 +-
>  fs/smb/client/cifsfs.c                             |  28 +--
>  fs/smb/client/file.c                               |  25 ++-
>  fs/smb/client/smb2pdu.c                            |   6 +
>  include/kvm/arm_vgic.h                             |   2 +-
>  include/linux/iopoll.h                             |   2 +
>  include/linux/virtio_net.h                         |   4 +
>  include/media/v4l2-mem2mem.h                       |  18 +-
>  include/net/sock.h                                 |   6 +
>  kernel/dma/remap.c                                 |   4 +-
>  kernel/sched/fair.c                                | 193 +++++++++----------
>  kernel/sched/sched.h                               |  19 --
>  kernel/trace/ring_buffer.c                         |  14 +-
>  kernel/trace/trace.c                               |   3 +-
>  mm/hugetlb.c                                       |  75 +++++---
>  mm/zsmalloc.c                                      | 113 +++++------
>  net/bluetooth/l2cap_core.c                         |   5 +
>  net/bluetooth/mgmt.c                               |   2 +-
>  net/core/sock.c                                    |   2 +-
>  net/ipv4/ip_vti.c                                  |   4 +-
>  net/ipv4/tcp_timer.c                               |   4 +-
>  net/ipv6/ip6_vti.c                                 |   4 +-
>  net/key/af_key.c                                   |   4 +-
>  net/netfilter/ipvs/ip_vs_ctl.c                     |   4 +
>  net/netfilter/nf_conntrack_proto_sctp.c            |   6 +-
>  net/netfilter/nf_tables_api.c                      |   1 +
>  net/netfilter/nft_dynset.c                         |   3 +
>  net/netfilter/nft_set_pipapo.c                     |  13 +-
>  net/openvswitch/datapath.c                         |   8 +-
>  net/smc/af_smc.c                                   |   4 +-
>  net/smc/smc.h                                      |   2 +-
>  net/smc/smc_clc.c                                  |   4 +-
>  net/smc/smc_core.c                                 |  80 ++++----
>  net/smc/smc_core.h                                 |   4 +-
>  net/smc/smc_llc.c                                  |  16 +-
>  net/smc/smc_sysctl.c                               |  10 +-
>  net/unix/af_unix.c                                 |   9 +-
>  net/xfrm/xfrm_compat.c                             |   2 +-
>  net/xfrm/xfrm_interface_core.c                     |   4 +-
>  net/xfrm/xfrm_user.c                               |  14 +-
>  sound/hda/hdac_regmap.c                            |   7 +-
>  sound/pci/hda/patch_realtek.c                      |  91 ++++++++-
>  sound/soc/amd/Kconfig                              |   1 +
>  sound/soc/amd/vangogh/acp5x.h                      |   2 +
>  sound/soc/amd/vangogh/pci-acp5x.c                  |   7 +-
>  sound/soc/codecs/rt5665.c                          |   2 +
>  sound/soc/intel/boards/sof_sdw.c                   |  25 +++
>  sound/soc/intel/boards/sof_sdw_rt711_sdca.c        |   3 +
>  sound/soc/meson/axg-tdm-formatter.c                |  42 ++--
>  sound/soc/sof/amd/acp.h                            |   3 +
>  sound/soc/sof/amd/pci-rmb.c                        |   3 +
>  sound/soc/sof/amd/pci-rn.c                         |   3 +
>  sound/soc/sof/core.c                               |   4 +-
>  sound/soc/sof/intel/hda.c                          |  12 +-
>  sound/usb/quirks-table.h                           |  29 +++
>  tools/objtool/arch/x86/decode.c                    |   2 +-
>  tools/objtool/check.c                              |  21 +-
>  .../selftests/net/forwarding/mirror_gre_changes.sh |   3 +-
>  .../testing/selftests/net/forwarding/tc_actions.sh |  18 +-
>  255 files changed, 2074 insertions(+), 1100 deletions(-)
> 
> 

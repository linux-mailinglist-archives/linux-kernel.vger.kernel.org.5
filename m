Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E826771733
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHFWXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHFWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 18:23:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63382118
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 15:23:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so62750071fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691360625; x=1691965425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQYs8vcb6+K5XoF7470UFhBfKdvRbT31FkxAf7oRoWk=;
        b=Xdu/R6vUsUXU8EyrdOyavbkQ0pj7+79gn/G8L1adjOIR+fvQFfLGsvJxinhYiFmNOy
         64gBTDJU1vS8KQorPKjBYa6O//NOur8P49sq7qBdP6N7ASiNuUI9et6FOXZpgZkKOcWN
         8MFXZFL64tragBL2Z9XusH0R2ngP20EZp9OJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691360625; x=1691965425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQYs8vcb6+K5XoF7470UFhBfKdvRbT31FkxAf7oRoWk=;
        b=GqA15YWp5vngS/z7dy+VivbmwNZuYIrcbvpHcCsShGnSPn0+yxhShnr6NHpOyiGtQS
         Z0l0miEd0tFcpgbae0IkqwLI94eV1WAaarvQL36Ae/NYPasonbmCBdBoT4k15Cfxi91X
         zkQjz1SK3HcMfjLu+4sTfUthtp2T4meO5uyH+xvnO2utcu6ddVRvI5qICXQY22Lumaaa
         nFr02/5YlbR0Be5w6VYf3TLiGADvdmDdznlUXa3vpcfNrWxbCpopYIARjGy2LdYjgG2P
         GFmk6BjOxO0VSYRPq+VIh9iI60rMfUc8tumoRLWk/H6yoevgXZNDeF0j5yC5/B3q3+LO
         E9Lg==
X-Gm-Message-State: AOJu0YzhVA8t++DokwSuREqb0S9Y4LazdcGTvcDknpyceyuVNCqLa7JL
        AaNvLmeYSvNw87Nj7GffPaLDiehnGIovkTuSKDnsNOuF
X-Google-Smtp-Source: AGHT+IH8zjRvaOOzMA9Qbo2htP+OFmgALN+eWVmvXtIGxOD5DN7Z5jQwCqQfFzAWT+AOvtFgV8CGqQ==
X-Received: by 2002:a05:6512:3b8f:b0:4f9:56a9:b98e with SMTP id g15-20020a0565123b8f00b004f956a9b98emr6188969lfv.58.1691360624920;
        Sun, 06 Aug 2023 15:23:44 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id z3-20020aa7d403000000b0052307b349d5sm4358900edq.3.2023.08.06.15.23.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 15:23:44 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso5248747a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 15:23:44 -0700 (PDT)
X-Received: by 2002:a05:6402:54:b0:522:30cc:a1f0 with SMTP id
 f20-20020a056402005400b0052230cca1f0mr6662678edu.14.1691360623776; Sun, 06
 Aug 2023 15:23:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Aug 2023 15:23:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaG-mWjWphLJ6C-fGU9gRHLpMrTt2caCcjX4nDpQA6vg@mail.gmail.com>
Message-ID: <CAHk-=whaG-mWjWphLJ6C-fGU9gRHLpMrTt2caCcjX4nDpQA6vg@mail.gmail.com>
Subject: Linux 6.5-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look pretty normal. Not a huge number of commits,
and most of the ones here are tiny.

The biggest patches tend to be soem of the continuing data-race
annotations in networking, and a couple of network drivers with
slightly bigger patches, but nothing that looks all that scary. And a
lot of the patches here are trivial one- and few-liners.

The biggest hiccup last week was that I had correctable ECC memory
errors in my machine and had to replace my DIMMs once again. But at
least this time I got nice warnings about how my memory was going bad,
so it was only a fleeting annoyance.

So go test. We still have a few regressions that are being chased, but
it's only rc5 and things look like they are under control.

            Linus

---

Aleksa Sarai (1):
      open: make RESOLVE_CACHED correctly test for O_TMPFILE

Alexander Stein (1):
      drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning

Alexandra Winter (1):
      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Alexandre Ghiti (1):
      selftests: riscv: Fix compilation error with vstate_exec_nolibc.c

Alice Ryhl (1):
      rust: delete `ForeignOwnable::borrow_mut`

Amir Tzin (1):
      net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is =
set

Andi Shyti (5):
      drm/i915/gt: Cleanup aux invalidation registers
      drm/i915: Add the gen12_needs_ccs_aux_inv helper
      drm/i915/gt: Rename flags with bit_group_X according to the datasheet
      drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the =
CS
      drm/i915/gt: Support aux invalidation on all engines

Andrea Righi (1):
      rust: fix bindgen build error with UBSAN_BOUNDS_STRICT

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Ani Sinha (1):
      vmbus_testing: fix wrong python syntax for integer value comparison

Arnd Bergmann (3):
      backlight: corgi_lcd: fix missing prototype
      mtd: spi-nor: avoid holes in struct spi_mem_op
      parport: gsc: remove DMA leftover code

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Athira Rajeev (1):
      perf callchain powerpc: Fix addr location init during
arch_skip_callchain_idx function

Baoquan He (1):
      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM

Benjamin Gaignard (1):
      arm64: dts: freescale: Fix VPU G2 clock

Benjamin Gray (1):
      powerpc/powermac: Use early_* IO variants in via_calibrate_decr()

Benjamin Poirier (1):
      vxlan: Fix nexthop hash size

Biju Das (1):
      arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names
for MTU3 channels

Boqun Feng (1):
      rust: allocator: Prevent mis-aligned allocation

Brian Norris (1):
      MAINTAINERS: Update mwifiex maintainer list

Chen-Yu Tsai (1):
      clk: mediatek: mt8183: Add back SSPM related clocks

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Chris Mi (2):
      net/mlx5e: Don't hold encap tbl lock if there is no encap action
      net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supporte=
d

Christian Brauner (1):
      fs: rely on ->iterate_shared to determine f_pos locking

Christophe JAILLET (1):
      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Cristian Marussi (1):
      firmware: arm_scmi: Fix chan_free cleanup on SMC

Damien Le Moal (1):
      ata,scsi: do not issue START STOP UNIT on resume

Dan Carpenter (1):
      net: ll_temac: fix error checking of irq_of_parse_and_map()

David Howells (2):
      nfsd: Fix reading via splice
      udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES

Davidlohr Bueso (3):
      cxl/memdev: Improve sanitize ABI descriptions
      cxl/memdev: Document security state in kern-doc
      cxl/memdev: Only show sanitize sysfs files when supported

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Dmitry Baryshkov (1):
      ARM: dts: nxp/imx: limit sk-imx53 supported frequencies

Dmitry Rokosov (1):
      clk: meson: change usleep_range() to udelay() for atomic context

Dragos Tatulea (2):
      net/mlx5e: xsk: Fix invalid buffer access for legacy rq
      net/mlx5e: xsk: Fix crash on regular rq reactivation

Duoming Zhou (1):
      net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs

Durai Manickam KR (2):
      ARM: dts: at91: sam9x60: fix the SOC detection
      dt-bindings: serial: atmel,at91-usart: update compatible for sam9x60

Edward Cree (1):
      sfc: fix field-spanning memcpy in selftest

Eric Dumazet (18):
      net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
      net: annotate data-races around sk->sk_reserved_mem
      net: annotate data-race around sk->sk_txrehash
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: annotate data-races around sk->sk_{rcv|snd}timeo
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: annotate data-races around sk->sk_mark
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      net: annotate data-races around sk->sk_priority
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Eugen Hristev (1):
      dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
defaults/range in schema

Gao Xiang (2):
      erofs: fix wrong primary bvec selection on deduplicated extents
      erofs: drop unnecessary WARN_ON() in erofs_kill_sb()

Geert Uytterhoeven (1):
      clk: imx93: Propagate correct error in imx93_clocks_probe()

Georg M=C3=BCller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Guchun Chen (1):
      drm/ttm: check null pointer before accessing when swapping

Haixin Yu (1):
      perf pmu arm64: Fix reading the PMU cpu slots in sysfs

Hans de Goede (1):
      wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v=
1()

Heiko Carstens (3):
      s390: update defconfigs
      KVM: s390: fix sthyi error handling
      s390/ptrace: add missing linux/const.h include

Hou Tao (2):
      bpf, cpumap: Make sure kthread is running before map update returns
      bpf, cpumap: Handle skb as well when clean up ptr_ring

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY
reset pinmux

Ian Rogers (5):
      perf parse-events: Extra care around force grouped events
      perf parse-events: When fixing group leaders always set the leader
      perf parse-events: Only move force grouped evsels when sorting
      perf pmus: Create placholder regardless of scanning core_only
      perf test parse-events: Test complex name has required event format

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Ilya Dryomov (2):
      rbd: prevent busy loop when requesting exclusive lock
      libceph: fix potential hang in ceph_osdc_notify()

Jakub Kicinski (3):
      MAINTAINERS: stmmac: retire Giuseppe Cavallaro
      bnxt: don't handle XDP in netpoll
      MAINTAINERS: update TUN/TAP maintainers

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Janusz Krzysztofik (1):
      drm/i915: Fix premature release of request's reusable memory

Jianbo Liu (4):
      net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
      net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink r=
eload
      net/mlx5: fs_core: Make find_closest_ft more generic
      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_pr=
io

Jiri Olsa (2):
      bpf: Disable preemption in bpf_perf_event_output
      bpf: Disable preemption in bpf_event_output

Johan Jonker (2):
      mtd: rawnand: rockchip: fix oobfree offset and description
      mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

John Hubbard (1):
      selftests/riscv: fix potential build failure during the "emit_tests" =
step

Jonas Gorski (1):
      prestera: fix fallback to previous version on same major version

Jonathan Cavitt (2):
      drm/i915/gt: Ensure memory quiesced before invalidation
      drm/i915/gt: Poll aux invalidation register bit on invalidation

Kalle Valo (12):
      Revert "wifi: ath11k: Enable threaded NAPI"
      Revert "wifi: ath6k: silence false positive
-Wno-dangling-pointer warning on GCC 12"
      MAINTAINERS: wifi: rtw88: change Ping as the maintainer
      MAINTAINERS: wifi: atmel: mark as orphan
      MAINTAINERS: wifi: mark cw1200 as orphan
      MAINTAINERS: wifi: mark ar5523 as orphan
      MAINTAINERS: wifi: mark rndis_wlan as orphan
      MAINTAINERS: wifi: mark wl3501 as orphan
      MAINTAINERS: wifi: mark zd1211rw as orphan
      MAINTAINERS: wifi: mark b43 as orphan
      MAINTAINERS: wifi: mark mlw8k as orphan
      MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

Kameron Carr (1):
      Drivers: hv: Change hv_free_hyperv_page() to take void * argument

Kees Cook (1):
      wifi: ray_cs: Replace 1-element array with flexible array

Konstantin Khorenko (1):
      qed: Fix scheduling in a tasklet while getting stats

Krzysztof Kozlowski (1):
      firmware: arm_scmi: Drop OF node reference in the transport channel s=
etup

Kuniyuki Iwashima (2):
      net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
      selftest: net: Assert on a proper value in so_incoming_cpu.c.

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Leon Romanovsky (1):
      net/mlx5e: Set proper IPsec source port in L4 selector

Lin Ma (3):
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Linus Torvalds (4):
      file: reinstate f_pos locking optimization for regular files
      proc: fix missing conversion to 'iterate_shared'
      vfs: get rid of old '->iterate' directory operation
      Linux 6.5-rc5

Lucas Stach (1):
      soc: imx: imx8mp-blk-ctrl: register HSIO PLL clock as bus_power_dev c=
hild

Lukasz Majewski (1):
      net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit
boundaries

Mark Brown (6):
      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
      arm64/fpsimd: Clear SME state in the target task when setting the VL
      arm64/ptrace: Flush FP state when setting ZT0
      arm64/ptrace: Don't enable SVE when setting streaming SVE
      arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
      arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE

Martin Kohn (1):
      net: usb: qmi_wwan: add Quectel EM05GV2

Michael Chan (1):
      bnxt_en: Fix max_mtu setting for multi-buf XDP

Michael Ellerman (1):
      powerpc/64e: Fix secondary thread bringup for ELFv2 kernels

Michael Kelley (2):
      scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
      x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction

Michal Schmidt (1):
      octeon_ep: initialize mbox mutexes

Mike Rapoport (IBM) (1):
      parisc/mm: preallocate fixmap page tables at init

Namjae Jeon (1):
      exfat: check if filename entries exceeds max filename length

Naveen N Rao (1):
      powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Nikita Travkin (1):
      drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE

Nischala Yelchuri (1):
      x86/hyperv: Improve code for referencing hyperv_pcpu_input_arg

Olivier Maignial (2):
      mtd: spinand: toshiba: Fix ecc_get_status
      mtd: spinand: winbond: Fix ecc_get_status

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (D=
BDC)

Paulo Alcantara (1):
      smb: client: fix dfs link mount against w2k8

Petr Tesarik (1):
      parisc: pci-dma: remove unused and dead EISA code and comment

Punit Agrawal (1):
      firmware: smccc: Fix use of uninitialised results structure

Rafal Rogalski (1):
      ice: Fix RDMA VSI removal during queue rebuild

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: net: mediatek,net: fixup MAC binding

Randy Dunlap (1):
      cpumask: eliminate kernel-doc warnings

Richard Gobert (1):
      net: gro: fix misuse of CB in udp socket lookup

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Russell King (Oracle) (1):
      net: dsa: fix older DSA drivers using phylink

Saurabh Sengar (1):
      x86/hyperv: add noop functions to x86_init mpparse functions

Shay Drory (3):
      net/mlx5: Honor user input for migratable port fn attr
      net/mlx5: DR, Fix peer domain namespace setting
      net/mlx5: Unregister devlink params in case interface is down

Somnath Kotur (1):
      bnxt_en: Fix page pool logic for page size >=3D 64K

Song Shuai (2):
      riscv: Export va_kernel_pa_offset in vmcoreinfo
      Documentation: kdump: Add va_kernel_pa_offset for RISCV64

Stefano Garzarella (1):
      test/vsock: remove vsock_perf executable on `make clean`

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Sudeep Holla (2):
      arm64: dts: arm: Remove the dangling vexpress-v2m-rs1.dtsi symlink
      ARM: dts: nspire: Fix arm primecell compatible string

Sukrut Bellary (1):
      firmware: arm_scmi: Fix signed error return values handling

Sumit Gupta (1):
      memory: tegra: make icc_set_bw return zero if BWMGR not supported

Sungjong Seo (1):
      exfat: release s_lock before calling dir_emit()

Sunil V L (1):
      RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address

Sven Schnelle (1):
      s390/vmem: split pages when debug pagealloc is enabled

Thierry Reding (2):
      memory: tegra: Add dummy implementation on Tegra194
      net: stmmac: tegra: Properly allocate clock bulk data

Tim Harvey (2):
      arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl
      arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Tudor Ambarus (1):
      MAINTAINERS: Add myself as reviewer for HYPERBUS

Vlad Buslov (1):
      net/mlx5: Bridge, set debugfs access right to root-only

Xiubo Li (1):
      ceph: defer stopping mdsc delayed_work

Xu Yang (1):
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yan Zhao (1):
      drm/i915/gvt: Fix bug in getting msg length in AUX CH registers handl=
er

Yang Yingliang (1):
      scsi: pm80xx: Fix error return code in pm8001_pci_probe()

Yashwanth Varakala (2):
      arm64: dts: phycore-imx8mm: Label typo-fix of VPU
      arm64: dts: phycore-imx8mm: Correction in gpio-line-names

Yuanjun Gong (3):
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
      net: dsa: fix value check in bcm_sf2_sw_probe()
      net: korina: handle clk prepare error in korina_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

YueHaibing (1):
      Drivers: hv: vmbus: Remove unused extern declaration vmbus_ontimer()

Yury Norov (1):
      lib/bitmap: workaround const_eval test build failure

Zhang Rui (1):
      powercap: intel_rapl: Fix a sparse warning in TPMI interface

Zhengchao Shao (3):
      net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
      net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

ZhiHu (1):
      x86/hyperv: fix a warning in mshyperv.h

gaoming (1):
      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

hanyu001@208suo.com (1):
      parisc: unaligned: Add required spaces after ','

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless
of endianness

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid
use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid
use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to
avoid use-after-free

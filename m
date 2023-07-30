Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3F76880A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjG3Uij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG3Uih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:38:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62A10F0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:38:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso5034879a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690749505; x=1691354305;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4UpHpBlMDoSZ1gpjuLmid/vDJQX5EFRNU80nBkWxmM=;
        b=V82C4rsu44SCV2KUAj/A/vt+wGxPT4r44kT+WkoPPRvHgJR6CnkW3Ea9EKFmgu1pLb
         Vnz5GQ9Tqj8a4MxbOOIBONNkQOc64/x6ks7OXowcIomcmQwF0wqnsYvKt85o3lpyY7++
         KS/p0XoRHWBvfd6FSiqgHRWLQaac2/3qoa2V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690749505; x=1691354305;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4UpHpBlMDoSZ1gpjuLmid/vDJQX5EFRNU80nBkWxmM=;
        b=L4M5mX1lV92nH89hUDAGtLJQkxowtHArXI38QAzhUtF+is44+bqEOMAYByj3WkM3Rz
         /6gDhdOB+n86Kcr0uI6/3f5XhD3hZs9HHj2OHPkOhDdXC66EbOO1N8BPoOKcOBete2H+
         o6Xh1ffILHFsOKxO7T0KV7rR2QOsccMrsTbbbz7d/ET6knRd9bgeCT5T6ZY1+d82DbRi
         N9dux7u3ahkYnuENoZvdMQ3+MnuaxzWsfKkCEwBTI0vzlDVdJucsCM2/Du0eT5s908sW
         vptbK8LOPL4v4RN5Io6CTbLTyQcGetexuqguI+b6VQn4pgR1G605p3RxGq0aDAnSMzuN
         VKUg==
X-Gm-Message-State: ABy/qLawdJjyaihlki6LHAFpnClAV0syvy8mP7HAXdufp8fUocmjf8Ke
        336YOKGtV3tjkUc9TwfVdx3ixw2GyZdXe26GLqqrHw==
X-Google-Smtp-Source: APBJJlFuWOBLQFXXNIdMMcxX6GOb2YWhRzMy8YAO7rPeWDWGUkMSssHJ/P3/cBZcmy7T2eoAv7Xehg==
X-Received: by 2002:a17:906:32cb:b0:99c:3b4:940f with SMTP id k11-20020a17090632cb00b0099c03b4940fmr3603074ejk.27.1690749504612;
        Sun, 30 Jul 2023 13:38:24 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170907989600b00991bba473e1sm5161462ejc.3.2023.07.30.13.38.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 13:38:24 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso5048448a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:38:24 -0700 (PDT)
X-Received: by 2002:a05:6402:12da:b0:521:d23d:6850 with SMTP id
 k26-20020a05640212da00b00521d23d6850mr5950458edx.21.1690749503471; Sun, 30
 Jul 2023 13:38:23 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Jul 2023 13:38:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik9NO9Un-OU0rVeo1+dp=6vj=s=K0T=uBVEa+Aqkj66w@mail.gmail.com>
Message-ID: <CAHk-=wik9NO9Un-OU0rVeo1+dp=6vj=s=K0T=uBVEa+Aqkj66w@mail.gmail.com>
Subject: Linux 6.5-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, and the 6.5 release cycle continues to look entirely normal=
.

In fact, it's *so* normal that we have hit on a very particular (and
peculiar) pattern with the rc4 releases: we have had *exacty* 328
non-merge commits in rc4 in 6.2, 6.3 and now 6.5. Weird coincidence.

And honestly, that weird numerological coincidence is just about the
most interesting thing here. Because rc5 looks like the usual thing:
driver updates (perhaps a bit more spread out than usual, but that's
because of pulls from all of Greg's trees), arch updates, and random
fixes elsewhere (filesystems, rtmutex, kvm selftests, documentation
etc).

Details in the appended shortlog for people who want to scan through it.

I'm not complaining. Boring release candidates is exactly what I want.
Keep the testing and the boring pulls coming,

               Linus

---

Adrien Thierry (3):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime susp=
end
      phy: qcom-snps-femto-v2: properly enable ref clock
      phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error cod=
e

Ahmad Fatoum (2):
      thermal: core: constify params in thermal_zone_device_register
      thermal: of: fix double-free on unregistration

Ahmad Khalifa (2):
      hwmon: (nct6775) Fix register for nct6799
      hwmon: (nct6775) Fix IN scaling factors for 6798/6799

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout

Alex Elder (1):
      net: ipa: only reset hashed tables when supported

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Alexander Stein (1):
      media: amphion: use dev_err_probe

Alvin Lee (1):
      drm/amd/display: Don't apply FIFO resync W/A if rdivider =3D 0

Andy Shevchenko (1):
      Revert "um: Use swap() to make code cleaner"

Arkadiusz Kubalewski (2):
      tools: ynl-gen: fix enum index in _decode_enum(..)
      tools: ynl-gen: fix parse multi-attr enum attribute

Arnd Bergmann (5):
      media: mtk_jpeg_core: avoid unused-variable warning
      media: verisilicon: fix excessive stack usage
      media: verisilicon: change confusingly named relaxed register access
      cxl: fix CONFIG_FW_LOADER dependency
      ata: pata_ns87415: mark ns87560_tf_read static

Bart Van Assche (1):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h

Baskaran Kannan (1):
      hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Ben Hutchings (1):
      m68k: Fix invalid .section syntax

Biju Das (1):
      tty: serial: sh-sci: Fix sleeping in atomic context

Bjorn Andersson (1):
      mailmap: update remaining active codeaurora.org email addresses

Borislav Petkov (AMD) (2):
      x86/cpu/amd: Move the errata checking functionality up
      x86/cpu/amd: Add a Zenbleed fix

Breno Leitao (2):
      cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()
      cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()

Chaoyuan Peng (1):
      tty: n_gsm: fix UAF in gsm_cleanup_mux

Chen-Yu Tsai (2):
      regulator: mt6358: Sync VCN33_* enable status after checking ID
      regulator: mt6358: Fix incorrect VCN33 sync error message

Chenguang Zhao (1):
      LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch

Christian Brauner (1):
      file: always lock position for FMODE_ATOMIC_POS

Christian G=C3=B6ttsche (1):
      security: keys: perform capable check only on privileged operations

Christian Marangi (4):
      net: dsa: qca8k: enable use_single_write for qca8xxx
      net: dsa: qca8k: fix search_and_insert wrong handling of new rule
      net: dsa: qca8k: fix broken search_and_del
      net: dsa: qca8k: fix mdb add/del case with 0 VID

Christophe JAILLET (3):
      fs/9p: Fix a datatype used with V9FS_DIRECT_IO
      RDMA/rxe: Fix an error handling path in rxe_bind_mw()
      drm/i915: Fix an error handling path in igt_write_huge()

Dan Carpenter (8):
      RDMA/mlx4: Make check for invalid flags stricter
      phy: phy-mtk-dp: Fix an error code in probe()
      soundwire: amd: Fix a check for errors in probe()
      cxl/mem: Fix a double shift bug
      Revert "usb: xhci: tegra: Fix error check"
      Revert "usb: gadget: tegra-xudc: Fix error check in
tegra_xudc_powerdomain_init()"
      drm/amd/display: Unlock on error path in
dm_handle_mst_sideband_msg_ready_event()
      proc/vmcore: fix signedness bug in read_from_oldmem()

Dan Williams (1):
      cxl: Update MAINTAINERS

David Xu (1):
      platform/x86: serial-multi-instantiate: Auto detect IRQ resource
for CSC3551

Demi Marie Obenour (1):
      xen: speed up grant-table reclaim

Dmitry Antipov (1):
      media: pulse8-cec: handle possible ping error

Dmitry Baryshkov (2):
      drm/msm/mdss: correct UBWC programming for SM8550
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dmytro Maluka (2):
      ASoC: da7219: Flush pending AAD IRQ when suspending
      ASoC: da7219: Check for failure reading AAD IRQ events

Dominique Martinet (5):
      9p: fix ignored return value in v9fs_dir_release
      9p: virtio: fix unlikely null pointer deref in handle_rerror
      9p: virtio: make sure 'offs' is initialized in zc_request
      9p: virtio: skip incrementing unused variable
      9p: remove dead stores (variable set again without being read)

Douglas Anderson (2):
      spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't
multiples of 4 bytes
      spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads

Drew Fustini (1):
      scripts/spelling.txt: remove 'thead' as a typo

Edgar (1):
      ASoc: codecs: ES8316: Fix DMIC config

Edson Juliano Drosdeck (1):
      ASoC: nau8821: Add DMI quirk mechanism for active-high jack-detect

Eric Dumazet (1):
      can: raw: fix lockdep issue in raw_release()

Eric Snowberg (1):
      ovl: Always reevaluate the file signature for IMA

Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

Fedor Pchelkin (1):
      tipc: stop tipc crypto on failure in tipc_node_create

Feng Tang (1):
      mm/damon/core-test: initialise context before test in
damon_test_set_attrs()

Filipe Manana (4):
      btrfs: account block group tree when calculating global reserve size
      btrfs: remove BUG_ON()'s in add_new_free_space()
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit(=
)
      btrfs: check for commit error at btrfs_attach_transaction_barrier()

Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Frank Li (2):
      usb: gadget: call usb_gadget_check_config() to verify UDC capability
      usb: cdns3: fix incorrect calculation of ep_buf_size when more
than one config

Gaosheng Cui (5):
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()
      ring-buffer: Fix kernel-doc warnings in ring_buffer.c
      tracing/synthetic: Fix kernel-doc warnings in trace_events_synth.c
      tracing: Fix kernel-doc warnings in trace_events_trigger.c
      tracing: Fix kernel-doc warnings in trace_seq.c

George Shen (1):
      drm/amd/display: Guard DCN31 PHYD32CLK logic against chip family

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabl=
ed

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (4):
      Documentation: security-bugs.rst: update preferences when
dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Documentation: embargoed-hardware-issues.rst: clean out empty
and unused entries
      Documentation: embargoed-hardware-issues.rst: add AMD to the list

Guanghui Feng (1):
      ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info(=
)

Guenter Roeck (1):
      hwmon: (pmbus_core) Fix Deadlock in pmbus_regulator_get_status

Guillaume Ranquet (1):
      phy: mediatek: hdmi: mt8195: fix prediv bad upper limit test

Guiting Shen (2):
      ASoC: atmel: Fix the 8K sample parameter in I2SC master
      usb: ohci-at91: Fix the unhandle interrupt when resume

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (2):
      platform/x86/amd: pmc: Use release_mem_region() to undo
request_mem_region_muxed()
      platform/x86: intel: hid: Always call BTNL ACPI method

Hao Lan (2):
      net: hns3: fix the imp capability bit cannot exceed 32 bits issue
      net: hns3: add tm flush when setting tm

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Huacai Chen (3):
      LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'
      LoongArch: Fix module relocation error with binutils 2.41
      LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_*

Hugh Dickins (3):
      tmpfs: fix Documentation of noswap and huge mount options
      shmem: minor fixes to splice-read implementation
      mm/pagewalk: fix EFI_PGT_DUMP of espfix area

Ilya Dryomov (3):
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: harden get_lock_owner_info() a bit
      rbd: retrieve and check lock owner twice before blocklisting

Jacob Keller (2):
      iavf: fix potential deadlock on allocation failure
      iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jakub Kicinski (1):
      docs: net: clarify the NAPI rules around XDP Tx

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jan Stancek (1):
      splice, net: Fix splice_to_socket() for O_NONBLOCK socket

Jane Jian (1):
      drm/amd/smu: use AverageGfxclkFrequency* to replace previous GFX
Curr Clock

Jann Horn (4):
      mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
      mm: fix memory ordering for mm_lock_seq and vm_lock_seq
      mm: lock VMA in dup_anon_vma() before setting ->anon_vma
      mm/mempolicy: Take VMA lock before replacing policy

Jason Gunthorpe (2):
      iommufd: IOMMUFD_DESTROY should not increase the refcount
      iommufd: Set end correctly when doing batch carry

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jens Axboe (1):
      io_uring: gate iowait schedule on having pending requests

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jijie Shao (2):
      net: hns3: fix wrong tc bandwidth weight data issue
      net: hns3: fix wrong bw weight of disabled tc issue

Jiri Benc (3):
      vxlan: calculate correct header length for GPE
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
      vxlan: fix GRO with VXLAN-GPE

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-onl=
y

Joaqu=C3=ADn Ignacio Aramend=C3=ADa (1):
      hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups

Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progres=
s

Johan Hovold (5):
      soundwire: fix enumeration completion
      USB: serial: simple: sort driver entries
      PM: sleep: wakeirq: fix wake irq arming
      PM: sleep: wakeirq: drop unused enable helpers
      serial: qcom-geni: drop bogus runtime pm state update

Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Jonathan Kim (1):
      drm/amdkfd: fix trap handling work around for debugging

Jonathan Marek (1):
      drm/msm/dpu: add missing flush and fetch bits for DMA4/DMA5 planes

Jussi Laako (1):
      ALSA: usb-audio: Update for native DSD support quirks

Kashyap Desai (1):
      RDMA/bnxt_re: Prevent handling any completions after qp destroy

Kim Phillips (1):
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Kirill A. Shutemov (1):
      x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memor=
y

Konstantin Shelekhin (1):
      platform/x86: huawei-wmi: Silence ambient light sensor

Kristian Angelov (1):
      platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops

Kuniyuki Iwashima (3):
      af_unix: Fix fortify_panic() in unix_bind_bsd().
      af_packet: Fix warning of fortified memcpy() in packet_getname().
      af_unix: Terminate sun_path when bind()ing pathname socket.

Kyle Tso (3):
      usb: typec: Set port->pd before adding device for typec_port
      usb: typec: Iterate pds array when showing the pd list
      usb: typec: Use sysfs_emit_at when concatenating the string

Larry Finger (1):
      staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Leo Chen (1):
      drm/amd/display: Exit idle optimizations before attempt to access PHY

Lijo Lazar (1):
      drm/amdgpu: Restore HQD persistent state register

Like Xu (1):
      KVM: x86/irq: Conditionally register IRQ bypass consumer again

Lin Ma (2):
      macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Linus Torvalds (2):
      mm: suppress mm fault logging if fatal signal already pending
      Linux 6.5-rc4

Linus Walleij (1):
      misc/genalloc: Name subpools by of_node_full_name()

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Workaround for GIC-700 erratum 2941627

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Maciej =C5=BBenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a
new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to
CAN_STATE_STOPPED

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidat=
ion

Marijn Suijten (1):
      drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config

Mario Limonciello (1):
      drm/amd: Fix an error handling mistake in psp_sw_init()

Mark Brown (3):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register
      arm64/fpsimd: Don't flush SME register hardware state along with thre=
ad
      arm64/sme: Set new vector length before reallocating

Masami Hiramatsu (Google) (3):
      tracing/probes: Fix to add NULL check for BTF APIs
      selftests/ftrace: Fix to check fprobe event eneblement
      kprobes: Prohibit probing on CFI preamble symbol

Matthieu Baerts (1):
      selftests: mptcp: join: only check for ip6tables if needed

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Maxim Levitsky (3):
      KVM: x86: VMX: __kvm_apic_update_irr must update the IRR atomically
      KVM: x86: VMX: set irr_pending in kvm_apic_update_irr
      KVM: x86: check the kvm_cpu_get_interrupt result before using it

Maxim Mikityanskiy (2):
      platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Michael Grzeschik (1):
      usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activ=
ate

Mike Rapoport (IBM) (1):
      Revert "mm,memblock: reset memblock.reserved to system init
state to prevent UAF"

Mikulas Patocka (1):
      dm integrity: fix double free on memory allocation failure

Ming Lei (3):
      ublk: fail to start device if queue setup is interrupted
      ublk: fail to recover device if queue setup is interrupted
      ublk: return -EINTR if breaking from waiting for existed users in DEL=
_DEV

Ming Qian (1):
      media: imx-jpeg: Support to assign slot for encoder/decoder

Minjie Du (1):
      ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xf=
er()

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Muhammad Husaini Zulkifli (1):
      igc: Fix Kernel Panic during ndo_tx_timeout callback

Namjae Jeon (5):
      ksmbd: check if a mount point is crossed during path lookup
      ksmbd: fix out of bounds in smb3_decrypt_req()
      ksmbd: validate session id and tree id in compound request
      ksmbd: no response from compound read
      ksmbd: fix out of bounds in init_smb2_rsp_hdr()

Naohiro Aota (1):
      btrfs: zoned: do not enable async discard

Neil Armstrong (1):
      usb: typec: ucsi: move typec_set_mode(TYPEC_STATE_SAFE) to
ucsi_unregister_partner()

Nicolas Dufresne (1):
      media: amphion: Fix firmware path to match linux-firmware

Niklas Cassel (1):
      ata: libata-core: fix when to fetch sense data for successful command=
s

Nikolay Burykin (1):
      media: pci: cx23885: fix error handling for cx23885 ATSC boards

Oliver Neukum (2):
      USB: serial: simple: add Kaufmann RKS+CAN VCP
      Revert "xhci: add quirk for host controllers that don't update
endpoint DCS"

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via
NFTA_RULE_CHAIN_ID

Paolo Abeni (1):
      mptcp: more accurate NL event generation

Patrick Rudolph (2):
      hwmon: (pmbus_core) Fix pmbus_is_enabled()
      hwmon: (pmbus_core) Fix NULL pointer dereference

Pavel Asyutchenko (1):
      ALSA: hda/realtek: Support ASUS G713PV laptop

Peng Hao (1):
      KVM: X86: Use GFP_KERNEL_ACCOUNT for pid_table in ipiv

Peter Zijlstra (2):
      locking/rtmutex: Fix task->pi_waiters integrity
      x86: Fix kthread unwind

Radhakrishna Sripada (1):
      drm/i915/dpt: Use shmem for dpt objects

Rahul Singh (1):
      xen/evtchn: Introduce new IOCTL to bind static evtchn

Randy Dunlap (1):
      Documentation: devices.txt: reconcile serial/ucc_uart minor numers

Raphael Gallais-Pou (1):
      staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rik van Riel (1):
      mm,memblock: reset memblock.reserved to system init state to prevent =
UAF

Rob Clark (5):
      drm/msm/adreno: Fix warn splat for devices without revn
      drm/msm/a690: Remove revn and name
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size
      drm/msm: Fix hw_fence error path cleanup
      drm/msm: Disallow submit with fence id 0

Roger Quadros (1):
      MAINTAINERS: drop invalid usb/cdns3 Reviewer e-mail

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Sakari Ailus (2):
      media: tc358746: Address compiler warnings
      media: staging: atomisp: select V4L2_FWNODE

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Samuel Thibault (1):
      TIOCSTI: always enable for CAP_SYS_ADMIN

Sean Christopherson (16):
      KVM: VMX: Make VMREAD error path play nice with noinstr
      KVM: VMX: Use vmread_error() to report VM-Fail in "goto" path
      KVM: x86: Acquire SRCU read lock when handling fastpath MSR writes
      Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't va=
lid"
      selftests/rseq: Play nice with binaries statically linked
against glibc 2.35+
      KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
      KVM: selftests: Use pread() to read binary stats header
      KVM: selftests: Clean up stats fd in common stats_test() helper
      KVM: selftests: Explicitly free vcpus array in binary stats test
      KVM: selftests: Verify userspace can create "redundant" binary stats =
files
      KVM: selftests: Verify stats fd can be dup()'d and read
      KVM: selftests: Verify stats fd is usable after VM fd has been closed
      Revert "debugfs, coccinelle: check for obsolete
DEFINE_SIMPLE_ATTRIBUTE() usage"
      KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid
      KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
      KVM: selftests: Expand x86's sregs test to cover illegal CR0 values

Sebastian Reichel (1):
      irqchip/gic-v3: Enable Rockchip 3588001 erratum workaround for RK3588=
S

Selvin Xavier (1):
      RDMA/bnxt_re: Fix hang during driver unload

Shiraz Saleem (4):
      RDMA/irdma: Add missing read barriers
      RDMA/irdma: Fix data race on CQP completion stats
      RDMA/irdma: Fix data race on CQP request done
      RDMA/core: Update CMA destination address on rdma_resolve_addr

Shuming Fan (5):
      ASoC: rt5682-sdw: fix for JD event handling in ClockStop Mode0
      ASoC: rt712-sdca: fix for JD event handling in ClockStop Mode0
      ASoC: rt722-sdca: fix for JD event handling in ClockStop Mode0
      ASoC: rt711: fix for JD event handling in ClockStop Mode0
      ASoC: rt711-sdca: fix for JD event handling in ClockStop Mode0

Shyam Prasad N (1):
      cifs: add missing return value check for cifs_sb_tlink

Shyam Sundar S K (2):
      platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params
      platform/x86/amd/pmf: Notify OS power slider update

Sidhartha Kumar (1):
      mm/memory-failure: fix hardware poison check in unpoison_memory()

Sindhu Devale (2):
      RDMA/irdma: Fix op_type reporting in CQEs
      RDMA/irdma: Report correct WC error

Srinivas Kandagatla (1):
      soundwire: qcom: update status correctly with mask

Stefan Haberland (4):
      s390/dasd: fix hanging device after quiesce/resume
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue
      s390/dasd: print copy pair message only for the correct error

Stefano Stabellini (1):
      xenbus: check xen_domain in xenbus_probe_initcall

Steve French (1):
      smb3: do not set NTLMSSP_VERSION flag for negotiate not auth request

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Suman Ghosh (1):
      octeontx2-af: Fix hash extraction enable configuration

Sven Joachim (1):
      arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS

Takashi Iwai (1):
      ALSA: usb-audio: Add quirk for Microsoft Modern Wireless Headset

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

Thomas GENTY (1):
      platform/x86: touchscreen_dmi.c: small changes for Archos 101
Cesium Educ tablet

Tiezhu Yang (1):
      LoongArch: BPF: Fix check condition to call lu32id in move_imm()

Tony Lindgren (1):
      MAINTAINERS: Update TTY layer for lists and recently added files

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Uwe Kleine-K=C3=B6nig (1):
      tpm: Switch i2c drivers back to use .probe()

Victor Lu (1):
      drm/amdgpu: Fix infinite loop in gfxhub_v1_2_xcc_gart_enable (v2)

Vijaya Krishna Nivarthi (4):
      spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
      spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for descript=
or
      spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
      spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS

Vincent Whitchurch (1):
      net: stmmac: Apply redundant write work around on 4.xx too

WANG Rui (1):
      LoongArch: Fix return value underflow in exception path

Wang Ming (3):
      ksmbd: Fix unsigned expression compared with zero
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()
      platform/x86: think-lmi: Use kfree_sensitive instead of kfree

Wang Weiyang (1):
      ALSA: seq: remove redundant unsigned comparison to zero

Wei Fang (2):
      net: fec: avoid tx queue timeout when XDP is enabled
      net: fec: tx processing does not call XDP APIs if budget is 0

Winston Wen (2):
      fs/nls: make load_nls() take a const parameter
      cifs: fix charset issue in reconnection

Xiao Yang (1):
      tools/testing/cxl: Remove unused SZ_512G macro

Xiubo Li (1):
      ceph: never send metrics if disable_send_metrics is set

Xu Yang (1):
      usb: misc: ehset: fix wrong if condition

Yang Yingliang (2):
      usb: typec: qcom: fix return value check in qcom_pmic_typec_probe()
      ata: pata_octeon_cf: fix error return code in octeon_cf_probe()

Yazen Ghannam (1):
      x86/MCE/AMD: Decrement threshold_bank refcount when removing
threshold blocks

Yu Kuai (4):
      scsi: sg: Fix checking return value of blk_get_queue()
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
      dm raid: clean up four equivalent goto tags in raid_ctr()
      dm raid: protect md_stop() with 'reconfig_mutex'

Yuanjun Gong (5):
      ethernet: atheros: fix return value check in atl1c_tso_csum()
      atheros: fix return value check in atl1_tso()
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      tipc: check return value of pskb_trim()

YueHaibing (3):
      fs/9p: Remove unused extern declaration
      drm/fb-helper: Remove unused inline function drm_fb_helper_defio_init=
()
      ftrace: Remove unused extern declarations

Yunfei Dong (1):
      media: mediatek: vcodec: fix cancel_work_sync fail with fluster test

Zhang Shurong (1):
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext(=
)

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhihong Dong (1):
      LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handling

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

=C5=81ukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

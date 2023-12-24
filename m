Return-Path: <linux-kernel+bounces-10615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF681D76C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0871F21A02
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42D650;
	Sun, 24 Dec 2023 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QEE8i0Ve"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35936F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-554ae571341so336160a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703378594; x=1703983394; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1F8FcNlGfIvDc18VQYK7hCvWLeyGlbme2p7idUsI+xQ=;
        b=QEE8i0Vejy/gYrCJ22BEHeUwxH+3iV7E5457OGsgzD9H0J5/SdIuzecvz5aSBg7tJm
         y2+5WYRK3McLFJkVmCSGX71FPnytZ6pFyns0LEncc+il08Wyp8M3PVybvOCgir55/ndu
         Z0QZBTmQX4OpZF4nc6n1sODdnX1IYhebi0dnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703378594; x=1703983394;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F8FcNlGfIvDc18VQYK7hCvWLeyGlbme2p7idUsI+xQ=;
        b=nGw5ixFi0dXpf9iJY2/Zfa83pO3ApryiCTrOqVo0ke76v6HqvGVJaAuyYJFNxWYZNB
         alkvqWjjPhcomNdJ0S3srxfv1tMFJzt/K9jj9kXPrtZ013ULUrjg4pGdbBrzf7w4DsQi
         iy0wbFIWXRUXoHhTio9b4Lvlj96UnFz56IyRwivok9gTykK3vcr3wjtoMPYJtYpVzTr+
         JTQ+2sNsYVF5cTjWrGuf9OqCL4EkPVH10xy65BGD/5A8pOmwKyiQEONYSx6Eaamrj0b8
         EYadtVm/VPwiYj/egQxUHRBOBQRaGH3OAg9OKbjGVGvXirhMVUaQM/9P3eciCGPTJgJA
         R2gQ==
X-Gm-Message-State: AOJu0Yz4yXha84y7OYf6v0rvGMMpyeHE45SJtSB42LS8Q6wFOIVN0Lz/
	+rREVSy4pQe0otAWo6qZJygOAyooEFxoqJOeZ5/dHDZ7MfUUgg==
X-Google-Smtp-Source: AGHT+IFOB53zD2BaCj7txq2CeB30PVLQVPYqzx1JopC58V6jna9N24kvTJryf3ZosmB01DJKwzIKFg==
X-Received: by 2002:a17:906:1008:b0:a26:87e2:52 with SMTP id 8-20020a170906100800b00a2687e20052mr1556897ejm.20.1703378593862;
        Sat, 23 Dec 2023 16:43:13 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id dv1-20020a170906b80100b00a269357c2e7sm3476148ejb.36.2023.12.23.16.43.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 16:43:13 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d2376db79so25599575e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:43:13 -0800 (PST)
X-Received: by 2002:a05:600c:34c2:b0:40d:54e3:ee5f with SMTP id
 d2-20020a05600c34c200b0040d54e3ee5fmr24581wmq.58.1703378592708; Sat, 23 Dec
 2023 16:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Dec 2023 16:42:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDbR1oNZtqTNE4n8MHbzi028JFKSCvyW88hw+0GO=P+A@mail.gmail.com>
Message-ID: <CAHk-=wjDbR1oNZtqTNE4n8MHbzi028JFKSCvyW88hw+0GO=P+A@mail.gmail.com>
Subject: Linux 6.7-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Normally I do rc releases on a Sunday afternoon, but since tomorrow is
Xmas Eve, and the festivities will have started (or at least I'll be
driving to the store a few times for everything that we forgot - not a
year has passed without _some_ last-minute "Oh, we need ..."), I'm
doing rc7 on a Saturday instead.

As as I already mentioned in an earlier email or two, while things
look fine and we *could* release a final 6.7 next weekend as per the
usual schedule, I'm not going to do that. It's the holidays, lots of
people have already been off for a week or more, and plan on being off
for the upcoming week (or more).

So next weekend is going to be rc8, and I expect that it will be small
as nobody should be around.

And then we might get back to a more normal schedule the week after. Maybe.

Anyway, rc7 itself looks fairly normal. It's actually a bit bigger
than rc6 was, but not hugely so, and nothing in here looks at all
strange. Please do give it a whirl if you have the time and the
energy, but let's face it, I expect things to be very quiet and this
to be one of those "nothing happens" weeks. Because even if you aren't
celebrating this time of year, you might take advantage of the peace
and quiet.

              Linus

---

Alex Lu (1):
      Bluetooth: Add more enc key size check

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Alexis Lothor=C3=A9 (1):
      pinctrl: at91-pio4: use dedicated lock class for IRQ

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Alvin Lee (1):
      drm/amd/display: Revert " drm/amd/display: Use channel_width =3D 2
for vram table 3.0"

Amir Goldstein (1):
      ovl: fix dentry reference leak after changes to underlying layers

Andrew Davis (1):
      ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Andrew Jones (1):
      KVM: riscv: selftests: Fix get-reg-list print_reg defaults

Andy Gospodarek (1):
      bnxt_en: do not map packet buffers twice

Ankit Nautiyal (1):
      drm/i915/display: Get bigjoiner config before dsc config during reado=
ut

Arnd Bergmann (2):
      Bluetooth: hci_event: shut up a false-positive warning
      x86/xen: add CPU dependencies for 32-bit build

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Benjamin Bigler (1):
      spi: spi-imx: correctly configure burst length when using dma

Bjorn Andersson (1):
      interconnect: qcom: icc-rpm: Fix peak rate calculation

Can Guo (1):
      scsi: ufs: core: Let the sq_lock protect sq_tail_slot access

Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

ChanWoo Lee (1):
      scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in
ufs_qcom_clk_scale_notify()

Charlene Liu (1):
      drm/amd/display: get dprefclk ss info from integration info table

Charles Keepax (1):
      ASoC: cs42l43: Don't enable bias sense during type detect

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Chuck Lever (3):
      NFSD: Revert 6c41d9a9bd0298002805758216a9c44e38a8500d
      NFSD: Revert 738401a9bd1ac34ccd5723d69640a4adbb1a4bc0
      SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806

Chukun Pan (1):
      arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3

Cl=C3=A9ment Villeret (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GV302XA

Curtis Malainey (1):
      ASoC: SOF: mediatek: mt8186: Revert Add Google Steelix topology compa=
tible

Dan Carpenter (3):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()
      usb: fotg210-hcd: delete an incorrect bounds test

Dan Williams (1):
      driver core: Add a guard() definition for the device_lock()

Daniel Golle (1):
      net: phy: skip LED triggers on PHYs on SFP modules

Daniel Hill (1):
      bcachefs: improve modprobe support by providing softdeps

Dave Ertman (1):
      ice: alter feature support check for SRIOV and LAG

David Ahern (1):
      net/ipv6: Revert remove expired routes with a separated list of route=
s

David Howells (5):
      afs: Fix the dynamic root's d_delete to always delete unused dentries
      afs: Fix dynamic root lookup DNS check
      keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on e=
xpiry
      afs: Fix overwriting of result of DNS query
      afs: Fix use-after-free due to get/remove race in volume tree

David Lechner (1):
      iio: triggered-buffer: prevent possible freeing of wrong buffer

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Esther Shimanovich (1):
      Input: i8042 - add nomux quirk for Acer P459-G2-M

Fabio Estevam (1):
      dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Fr=C3=A9d=C3=A9ric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Geliang Tang (2):
      selftests: mptcp: join: fix subflow_send_ack lookup
      mailmap: add entries for Geliang Tang

George Stark (1):
      iio: adc: meson: add separate config for axg SoC family

Gergo Koteles (2):
      ALSA: hda/tas2781: select program 0, conf 0 by default
      ASoC: tas2781: check the validity of prm_no/cfg_no

Ghanshyam Agrawal (1):
      kselftest: alsa: fixed a print formatting warning

Gil Fine (1):
      thunderbolt: Fix minimum allocated USB 3.x and PCIe bandwidth

Guilherme G. Piccoli (1):
      HID: nintendo: Prevent divide-by-zero on code

Haibo Chen (1):
      iio: adc: imx93: add four channels for imx93 adc

Hamza Mahfooz (1):
      drm/amd/display: disable FPO and SubVP for older DMUB versions on DCN=
32x

Hangbin Liu (1):
      kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail

Hans de Goede (3):
      Input: atkbd - skip ATKBD_CMD_GETID in translated mode
      ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346
      ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (2):
      s390/vx: fix save/restore of fpu kernel context
      s390: update defconfigs

Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount =3D=3D 0

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Imre Deak (1):
      drm/i915/mtl: Fix HDMI/DP PLL clock selection

Ivan Vecera (1):
      i40e: Fix ST code value for Clause 45

JP Kobryn (1):
      9p: prevent read overrun in protocol dump tracepoint

Jacob Keller (1):
      ice: stop trashing VF VSI aggregator node ID information

Jan Kara (1):
      bcachefs: Fix determining required file handle length

Javier Carrasco (3):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion
time table
      iio: tmag5273: fix temperature offset
      iio: adc: MCP3564: fix calib_bias and calib_scale range checks

Jensen Huang (1):
      i2c: rk3x: fix potential spinlock recursion on poll

Jeremie Knuesel (1):
      ALSA: usb-audio: Increase delay in MOTU M quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Jijie Shao (1):
      net: hns3: add new maintainer for the HNS3 ethernet driver

Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

Johan Hovold (1):
      usb: typec: ucsi: fix gpio-based orientation detection

Johannes Berg (8):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order
      debugfs: initialize cancellations earlier

John Fastabend (2):
      bpf: syzkaller found null ptr deref in unix_bpf proto add
      bpf: sockmap, test for unconnected af_unix sock

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid failed operations when device is
disconnected

Josip Pavic (1):
      drm/amd/display: dereference variable before checking for zero

Jos=C3=A9 Pekkarinen (1):
      Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Karthik Poosa (1):
      drm/i915/hwmon: Fix static analysis tool reported issues

Keith Busch (1):
      Revert "nvme-fc: fix race between error recovery and creating associa=
tion"

Kent Gibson (1):
      gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Kent Overstreet (5):
      bcachefs: Fix nocow locks deadlock
      bcachefs: print explicit recovery pass message only once
      bcachefs: btree_node_u64s_with_format() takes nr keys
      bcachefs; guard against overflow in btree node split
      bcachefs: Fix bch2_alloc_sectors_start_trans() error handling

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Krzysztof Kozlowski (1):
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in
omap_soc_device_init

Lai Peter Jun Ann (1):
      net: stmmac: fix incorrect flag check in timestamp interrupt

Larysa Zaremba (1):
      ice: Fix PF with enabled XDP going no-carrier after reset

Linus Torvalds (2):
      posix-timers: Get rid of [COMPAT_]SYS_NI() uses
      Linux 6.7-rc7

Liu Jian (2):
      net: check vlan filter feature in vlan_vids_add_by_dev() and
vlan_vids_del_by_dev()
      selftests: add vlan hw filter tests

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix possible NULL pointer dereference in
mtk_wed_wo_queue_tx_clean()

Louis Chauvet (1):
      spi: atmel: Fix clock issue when using devices with different polarit=
ies

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sen=
t
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Macpaul Lin (1):
      arm64: dts: mediatek: mt8395-genio-1200-evk: add
interrupt-parent for mt6360

Marc Zyngier (5):
      KVM: arm64: vgic: Simplify kvm_vgic_destroy()
      KVM: arm64: vgic: Add a non-locking primitive for kvm_vgic_vcpu_destr=
oy()
      KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy
      KVM: arm64: vgic: Ensure that slots_lock is held in
vgic_register_all_redist_iodevs()
      KVM: Convert comment into an assertion in kvm_io_bus_register_dev()

Mario Limonciello (5):
      pinctrl: amd: Mask non-wake source pins with interrupt enabled at sus=
pend
      platform/x86/amd/pmc: Move platform defines to header
      platform/x86/amd/pmc: Only run IRQ1 firmware version check on Cezanne
      platform/x86/amd/pmc: Move keyboard wakeup disablement detection
to pmc-quirks
      platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13

Marius Cristea (1):
      iio: adc: MCP3564: fix hardware identification logic

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Martin K. Petersen (1):
      Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affin=
ity"

Matthew Wilcox (Oracle) (1):
      ida: Fix crash in ida_free when the bitmap is empty

Matthieu Baerts (1):
      mptcp: fill in missing MODULE_DESCRIPTION()

Matti Vaittinen (1):
      iio: kx022a: Fix acceleration value scaling

Maurizio Lombardi (1):
      nvme-pci: fix sleeping function called from interrupt context

Michael Roth (1):
      KVM: SEV: Do not intercept accesses to MSR_IA32_XSS for SEV-ES guests

Michal Schmidt (1):
      ice: fix theoretical out-of-bounds access in ethtool link modes

Mike Snitzer (2):
      dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM
      MAINTAINERS: remove stale info for DEVICE-MAPPER

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metad=
ata()

Miquel Raynal (3):
      spi: atmel: Do not cancel a transfer upon any signal
      spi: atmel: Drop unused defines
      spi: atmel: Prevent spi transfers from being killed

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Nam Cao (3):
      pinctrl: starfive: jh7110: ignore disabled device tree nodes
      pinctrl: starfive: jh7100: ignore disabled device tree nodes
      spi: cadence: revert "Add SPI transfer delays"

NeilBrown (2):
      nfsd: call nfsd_last_thread() before final nfsd_put()
      nfsd: hold nfsd_mutex across entire netlink operation

Nitin Rawat (1):
      scsi: ufs: core: Store min and max clk freq from OPP table

Nuno Sa (2):
      iio: imu: adis16475: add spi_device_id table
      iio: imu: adis16475: use bit numbers in assign_bit()

Oliver Upton (1):
      KVM: selftests: Ensure sysreg-defs.h is generated at the expected pat=
h

Paolo Abeni (1):
      mptcp: fix inconsistent state on fastopen race

Paolo Bonzini (1):
      KVM: selftests: Fix dynamic generation of configuration names

Patrick Rudolph (3):
      pinctrl: cy8c95x0: Fix typo
      pinctrl: cy8c95x0: Fix regression
      pinctrl: cy8c95x0: Fix get_pincfg

Paulo Alcantara (5):
      smb: client: fix OOB in cifsd when receiving compounded resps
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()
      smb: client: fix potential OOB in cifs_dump_detail()
      smb: client: fix potential OOB in smb2_dump_detail()

Pavel Kozlov (1):
      ARC: add hugetlb definitions

Philip Yang (1):
      drm/amdkfd: svm range always mapped flag not working on APU

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start
conditions.

Rafa=C5=82 Mi=C5=82ecki (1):
      nvmem: brcm_nvram: store a copy of NVRAM content

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version
buffer used by representors

Rajvi Jingar (1):
      platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()

Randy Dunlap (1):
      tracing/synthetic: fix kernel-doc warnings

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Ricardo Rivera-Matos (3):
      ASoC: cs35l45: Use modern pm_ops
      ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
      ASoC: cs35l45: Prevents spinning during runtime suspend

Richard Fitzgerald (1):
      ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56 prefixes to AMP=
n

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Ryan McClelland (1):
      HID: nintendo: fix initializer element is not constant error

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fa=
ils

Shyam Prasad N (2):
      cifs: fix a pending undercount of srv_count
      cifs: do not let cifs_chan_update_iface deallocate channels

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Srinivas Pandruvada (2):
      Revert "iio: hid-sensor-als: Add light chromaticity support"
      Revert "iio: hid-sensor-als: Add light color temperature support"

Stefan Binding (9):
      ALSA: hda: cs35l41: Add config table to support many laptops without =
_DSD
      ALSA: hda: cs35l41: Support additional ASUS ROG 2023 models
      ALSA: hda/realtek: Add quirks for ASUS ROG 2023 models
      ALSA: hda: cs35l41: Support additional ASUS Zenbook 2022 Models
      ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models
      ALSA: hda: cs35l41: Support additional ASUS Zenbook 2023 Models
      ALSA: hda/realtek: Add quirks for ASUS Zenbook 2023 Models
      ALSA: hda: cs35l41: Do not allow uninitialised variables to be freed
      ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel

Steven Rostedt (Google) (3):
      ring-buffer: Fix slowpath of interrupted event
      eventfs: Have event files and directories default to parent uid and g=
id
      tracing / synthetic: Disable events after testing in
synth_event_gen_test_init()

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_=
raw

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Tasos Sahanidis (1):
      usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G=
3

Thomas Bertschinger (1):
      bcachefs: fix invalid memory access in bch2_fs_alloc() error path

Thomas Gleixner (4):
      x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully
      x86/alternatives: Sync core before enabling interrupts
      x86/alternatives: Disable interrupts and sync when optimizing
NOPs in place
      x86/acpi: Handle bogus MADT APIC tables gracefully

Thomas Wei=C3=9Fschuh (1):
      net: avoid build bug in skb extension length calculation

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write only after srst_udelay
      ARM: dts: Fix occasional boot hang for am3 usb

Uwe Kleine-K=C3=B6nig (1):
      Input: amimouse - convert to platform remove callback returning void

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Reject async flips with bigjoiner
      drm/i915/dmc: Don't enable any pipe DMC events

Vineet Gupta (5):
      ARC: entry: SAVE_ABI_CALLEE_REG: ISA/ABI specific helper
      ARC: entry: move ARCompact specific bits out of entry.h
      ARC: mm: retire support for aliasing VIPT D$
      ARC: fix spare error
      ARC: fix smatch warning

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: fix for incorrect fan reporting on
some ThinkPad systems

Vlad Buslov (4):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5e: fix double free of encap_header
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Vladimir Oltean (2):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and abov=
e
      net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and abov=
e

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma(=
)

Wayne Lin (1):
      drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Yang Yingliang (1):
      i2c: qcom-geni: fix missing clk_disable_unprepare() and
geni_se_resources_off()

Yaxiong Tian (1):
      thunderbolt: Fix memory leak in margining_port_remove()

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yong-Xuan Wang (1):
      RISCV: KVM: update external interrupt atomically for IMSIC swfile

Yu Kuai (1):
      dm-raid: delay flushing event_work() after reconfig_mutex is released

Yury Norov (1):
      net: mana: select PAGE_POOL

ZhenGuo Yin (1):
      drm/amdgpu: re-create idle bo's PTE during VM state machine reset

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

Zizhi Wo (1):
      fs: cifs: Fix atime update check

duanqiangwen (1):
      net: libwx: fix memory leak on free page

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it


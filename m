Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426057A40DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbjIRGJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjIRGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:09:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6CC10A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:09:09 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3FB163F546
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695017348;
        bh=Wgoj75WmltWQ4EurBvfin7gk3XuAaajHdXNdRLJkhGs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=DZKl4++NMfjTw7cdqTBzNEmDc+CL/JZ6scUDv5g4HgksTwdO+oE0LNPOdQ5sKeSoI
         qR3DM8U3Hwl4hVarEi/hya+BOUOZ9ai4tzhFQ0cKnOEOmO0/haEDcez7PmX0MV3R4p
         s33UbVH8faBgnQ2AMvV73Zko/8sqQ4dJ7bMFrmEkgcXnxRgVV5jHElp0RAexc+YFES
         y49RjmZSfef6pIa0/2/zMTVMZ8/qenowUhqj2bZZ/HhZNCZtCad+KilhC2efNCnCvw
         IRfxtsPHry8Jea8watRC7ToAAY0sHTDZiH+6glME6wXthxDfzjTsg6wN2UpQVNmQio
         lAuDoWiv6insA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68fc99d05aeso4113443b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695017346; x=1695622146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgoj75WmltWQ4EurBvfin7gk3XuAaajHdXNdRLJkhGs=;
        b=DFp+5z84D9C0lo1acBUnoJWqyw/MdqgdSoLZ4r32OIIcSTWKIMPEDNk3wf1mo1CC1X
         jayo2rFyJx7nqcSYSfiWmKnmeo70OK/CulsSom7J7rVT490c/7GOMBAAv6vopAVzdQ/V
         /hrTB5DxnXOr3tnNSkM1gfGSlZi2ipmrWoDGhNZhQOBaojPZEAYrtz2iiq8O8yrl728B
         cXtOWzUomzWiAytlBflcVbLXNjTPkOxb8VfDbf2klvHjho7S1e3aPbxqGh0itRzMio5H
         +Jf6ivflbl891Orf+rTS6sKHFIcpQv/k8O/kIpNBgOcRaQ0IOvNceKkHOaETUnV1fqSl
         jL4w==
X-Gm-Message-State: AOJu0YyPzZ8yER/FY8ClA+y6KK5sDrp1b3R/70CsPxIzvWvbpjlqShNA
        UvnvDgTS8OaeHn80XoEwKwIoq+0fzdvqQfem1mddTWqi1pVF7A8Y+eTFXOCAxNZuQwuFiY+bB/7
        swZLU12xXG4BeUWbYFQjl3TOQYOM/i1j8O2SUvE7Ae0x1In7KYDorg2ysmw==
X-Received: by 2002:a05:6a00:24ca:b0:68e:2f6e:b4c0 with SMTP id d10-20020a056a0024ca00b0068e2f6eb4c0mr8637916pfv.28.1695017346635;
        Sun, 17 Sep 2023 23:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFgLoywcCrmqHzXC+lJIbQxOSRBEWnuQrri2loJ3K5psBozLhqtomxVvBvctUSEbx4hIR2Y9Jyk7/GYt6NKLQ=
X-Received: by 2002:a05:6a00:24ca:b0:68e:2f6e:b4c0 with SMTP id
 d10-20020a056a0024ca00b0068e2f6eb4c0mr8637902pfv.28.1695017346304; Sun, 17
 Sep 2023 23:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com> <CAAd53p4LVL3uuNDCHPxteqM+jYD8E4atVyQvkt-HRhGKBVMoFg@mail.gmail.com>
 <0c73b27b8b07408da1940421217304a5@realtek.com>
In-Reply-To: <0c73b27b8b07408da1940421217304a5@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 18 Sep 2023 14:08:52 +0800
Message-ID: <CAAd53p7YOFP7G0JxLi3uHu7Xb3p1+d0DyoFjpdWAcK99VxkFBg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricky,

On Fri, Sep 8, 2023 at 2:36=E2=80=AFPM Ricky WU <ricky_wu@realtek.com> wrot=
e:
>
> > Hi Ricky,
> >
> > On Wed, Sep 6, 2023 at 4:03=E2=80=AFPM Ricky WU <ricky_wu@realtek.com> =
wrote:
> > >
> > > an error occurs on insert SD7.0 card.
> > > The pci slot of rtsx_pci will Link Down when the SD7.0 card inserted,
> > > but the rtsx_pci not exit from runtime_idle at that time, then do the
> > > power_saving function to access the wrong resource
> >
> > Is it possible to attach full dmesg? Maybe the issue is coming from PCI=
 side?
> >
> > Kai-Heng
> >
>
> Dmesg as below....
> -------------------------------------------------------------------------=
-----------------------------------------
> [   60.748953] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [   60.748958] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [   60.884619] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
> [   60.884662] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
> [   60.884767] pci 0000:01:00.0: Upstream bridge's Max Payload Size set t=
o 128 (was 256, max 256)
> [   60.884778] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, ma=
x 128)
> [   60.884917] pci 0000:01:00.0: supports D1 D2
> [   60.884921] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
> [   60.885537] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b00f=
ff]
> [   60.885570] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
> [   60.885585] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
> [   60.885598] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa=
44fffff]
> [   60.885630] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa=
13fffff 64bit pref]
> [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   63.912118] BUG: unable to handle page fault for address: ffffb24d403e=
5010
> [   63.912122] #PF: supervisor read access in kernel mode
> [   63.912125] #PF: error_code(0x0000) - not-present page
> [   63.912126] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PT=
E 0
> [   63.912131] Oops: 0000 [#1] PREEMPT SMP PTI
> [   63.912134] CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> [   63.912137] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./H370M Pro4, BIOS P3.40 10/25/2018
> [   63.912138] Workqueue: pm pm_runtime_work
> [   63.912144] RIP: 0010:ioread32+0x2e/0x70
> [   63.912148] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d=
9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> [   63.912150] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> [   63.912152] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000=
000007f
> [   63.912153] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d4=
03e5010
> [   63.912155] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 000000000=
0000000
> [   63.912156] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000=
000007f
> [   63.912158] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 000000000=
0009003
> [   63.912159] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlG=
S:0000000000000000
> [   63.912161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   63.912162] CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 000000000=
03706e0
> [   63.912164] Call Trace:
> [   63.912165]  <TASK>
> [   63.912167]  ? show_regs+0x68/0x70
> [   63.912171]  ? __die_body+0x20/0x70
> [   63.912173]  ? __die+0x2b/0x40
> [   63.912175]  ? page_fault_oops+0x160/0x480
> [   63.912177]  ? search_bpf_extables+0x63/0x90
> [   63.912180]  ? ioread32+0x2e/0x70
> [   63.912183]  ? search_exception_tables+0x5f/0x70
> [   63.912186]  ? kernelmode_fixup_or_oops+0xa2/0x120
> [   63.912189]  ? __bad_area_nosemaphore+0x179/0x230
> [   63.912191]  ? bad_area_nosemaphore+0x16/0x20
> [   63.912193]  ? do_kern_addr_fault+0x8b/0xa0
> [   63.912195]  ? exc_page_fault+0xe5/0x180
> [   63.912198]  ? asm_exc_page_fault+0x27/0x30
> [   63.912203]  ? ioread32+0x2e/0x70
> [   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> [   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> [   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> [   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> [   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> [   63.912246]  pci_pm_runtime_idle+0x34/0x70
> [   63.912248]  rpm_idle+0xc4/0x2b0
> [   63.912251]  pm_runtime_work+0x93/0xc0
> [   63.912254]  process_one_work+0x21a/0x430
> [   63.912258]  worker_thread+0x4a/0x3c0
> [   63.912261]  ? __pfx_worker_thread+0x10/0x10
> [   63.912263]  kthread+0x106/0x140
> [   63.912266]  ? __pfx_kthread+0x10/0x10
> [   63.912268]  ret_from_fork+0x29/0x50
> [   63.912273]  </TASK>
> [   63.912274] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_s=
of_pci_intel_cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_cod=
ec_generic snd_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 sou=
ndwire_generic_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof=
_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext=
_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_=
compress ac97_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd=
_intel_sdw_acpi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core=
 x86_pkg_temp_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel=
 drm_buddy ttm mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_ev=
ent cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypt=
o_simd rc_core cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cst=
ate i2c_algo_bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_tim=
er sysfillrect input_leds snd ee1004 sysimgblt mei_me soundcore
> [   63.912324]  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_co=
del msr parport_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_=
tables x_tables autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul =
ahci e1000e i2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas v=
ideo wmi
> [   63.912346] CR2: ffffb24d403e5010
> [   63.912348] ---[ end trace 0000000000000000 ]---
> [   64.067753] RIP: 0010:ioread32+0x2e/0x70
> [   64.067762] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d=
9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> [   64.067764] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> [   64.067767] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000=
000007f
> [   64.067769] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d4=
03e5010
> [   64.067770] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 000000000=
0000000
> [   64.067772] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000=
000007f
> [   64.067773] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 000000000=
0009003
> [   64.067775] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlG=
S:0000000000000000
> [   64.067776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   64.067778] CR2: ffffb24d403e5010 CR3: 0000000119402003 CR4: 000000000=
03706e0
> [   64.067780] note: kworker/3:10[534] exited with irqs disabled
> -------------------------------------------------------------------------=
------------------------------------------
>

Does the following change work for you?

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..ef93364a4422 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -356,6 +356,7 @@ static int pciehp_disable_slot(struct controller
*ctrl, bool safe_removal)
        int ret;

        pm_runtime_get_sync(&ctrl->pcie->port->dev);
+       pm_runtime_barrier(&ctrl->pcie->port->dev);
        ret =3D __pciehp_disable_slot(ctrl, safe_removal);
        pm_runtime_put(&ctrl->pcie->port->dev);


Kai-Heng

>
> > >
> > > Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management
> > > flow")
> > > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > >  drivers/misc/cardreader/rtsx_pcr.c | 14 ++++++++------
> > > drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 +
> > >  include/linux/rtsx_pci.h           |  1 +
> > >  3 files changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > > b/drivers/misc/cardreader/rtsx_pcr.c
> > > index a3f4b52bb159..536a3681fd5e 100644
> > > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > > @@ -1526,6 +1526,7 @@ static int rtsx_pci_probe(struct pci_dev *pcide=
v,
> > >         pcr->host_sg_tbl_addr =3D pcr->rtsx_resv_buf_addr +
> > HOST_CMDS_BUF_LEN;
> > >         pcr->card_inserted =3D 0;
> > >         pcr->card_removed =3D 0;
> > > +       pcr->is_sd_express =3D false;
> > >         INIT_DELAYED_WORK(&pcr->carddet_work,
> > rtsx_pci_card_detect);
> > >
> > >         pcr->msi_en =3D msi_en;
> > > @@ -1735,12 +1736,13 @@ static int rtsx_pci_runtime_idle(struct devic=
e
> > > *device)
> > >
> > >         pcr->state =3D PDEV_STAT_IDLE;
> > >
> > > -       if (pcr->ops->disable_auto_blink)
> > > -               pcr->ops->disable_auto_blink(pcr);
> > > -       if (pcr->ops->turn_off_led)
> > > -               pcr->ops->turn_off_led(pcr);
> > > -
> > > -       rtsx_pm_power_saving(pcr);
> > > +       if (!pcr->is_sd_express) {
> > > +               if (pcr->ops->disable_auto_blink)
> > > +                       pcr->ops->disable_auto_blink(pcr);
> > > +               if (pcr->ops->turn_off_led)
> > > +                       pcr->ops->turn_off_led(pcr);
> > > +               rtsx_pm_power_saving(pcr);
> > > +       }
> > >
> > >         mutex_unlock(&pcr->pcr_mutex);
> > >
> > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > index 87d78432a1e0..80b2f2a31fdc 100644
> > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > @@ -1393,6 +1393,7 @@ static int sdmmc_init_sd_express(struct mmc_hos=
t
> > *mmc, struct mmc_ios *ios)
> > >                 RTS5261_MCU_BUS_SEL_MASK |
> > RTS5261_MCU_CLOCK_SEL_MASK
> > >                 | RTS5261_DRIVER_ENABLE_FW,
> > >                 RTS5261_MCU_CLOCK_SEL_16M |
> > RTS5261_DRIVER_ENABLE_FW);
> > > +       pcr->is_sd_express =3D true;
> > >         host->eject =3D true;
> > >         return 0;
> > >  }
> > > diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h inde=
x
> > > 534038d962e4..295e92224fd0 100644
> > > --- a/include/linux/rtsx_pci.h
> > > +++ b/include/linux/rtsx_pci.h
> > > @@ -1262,6 +1262,7 @@ struct rtsx_pcr {
> > >         u8                      ocp_stat;
> > >         u8                      ocp_stat2;
> > >         u8                      rtd3_en;
> > > +       bool                    is_sd_express;
> > >  };
> > >
> > >  #define PID_524A       0x524A
> > > --
> > > 2.25.1
> > >
> >
> > ------Please consider the environment before printing this e-mail.
>

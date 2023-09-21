Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9D7A9D85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjIUTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjIUTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:38:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082C98A68
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:56:51 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 625B13F65A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695276447;
        bh=dcZbIS3SCPizfsavnP9p9wJ2LqoEiuieySpIExpSNBw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rtCu+D9e3Lx00GQYN/yZJSSzwjBN0op4OJIHg9cp3jjP6UDZ2Y6RQPc9SabBfKGSF
         ARJXb8zzkbvDY7vS/ILrU7Za1XrncYdg31r6jLLsY6+kiRLl+iPu903XqVjkzYHAfV
         SRZmhhAVOSc3tP7n2CUAzSuhq0Y0GYE1jTDgXn0IFAWjRtph5w56pJEl8PmXg93rXv
         L03+TI/5S13JsTQiDvyNIuSjvjP66lCYXq9tY7Vx1VXhE9ffuuzxR+JRQUAZL6KAMp
         B4tXNNNUG7QpzyUScNDKTK2XAV7caQ/vTVSJBgeDRMtZqrkPXeANBpumo7Cmd8NuWo
         EL1zXiV21FgFQ==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68fe3d77ed8so580379b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695276446; x=1695881246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcZbIS3SCPizfsavnP9p9wJ2LqoEiuieySpIExpSNBw=;
        b=B+jPcBOz4xh6KWcM/CD5NAavlqtuBCQ1GMhf0yknGn2UfkkcSg2f3b8BYuIKBmcjtO
         OKn23Xh9yqNoS2gO0erfh0p3+5N29cBkHgDifIfcSfk7xSIBcOE3xlmcPjjXQSxmME50
         7aSyQLFOE7tGlXlefURnk1S+jXNXmv4gNfKAG20XedFTL61Y+6h6LPmjlJpHuuR5GDiT
         njlfnrqwXAVV9dIgmtrjmKsaI73yZVKRJ1HqvG9opQu9KHxjQK+0y0D1hPz9n6+bpcnW
         hegMSqA9na//fxbIcPE1NayRgDjOUBJeKvxev9fuFty+9+X+NQUBxxWOKgNqDA0pAccE
         Ikvg==
X-Gm-Message-State: AOJu0YyJYVWvmqPvvbhIUooKfZntTWoHFHAIcPQyENhh+LL4nsQboypk
        xuMpLT/NHPXD5v2YB9R3Pgv4gHKJyFibxDQFQSn00bUghYtG6/VB0M+u6USIQi0NG+GURcikI1N
        AEotPcxWtzPoRvnBu7fuxxeKomXwOr2uyI+yKE/1XcwzSIwuc/MXq/UlZOg==
X-Received: by 2002:a05:6a21:66c7:b0:13f:5234:24ce with SMTP id ze7-20020a056a2166c700b0013f523424cemr4025711pzb.28.1695276445829;
        Wed, 20 Sep 2023 23:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlaSz99pL0v/fkfVZaX1IewtyyYiEOwbYnG26drXlG1xbsVCgpIpIxT/bqZ3/n9fhFzbQOnQ8woGoDeLCfjhU=
X-Received: by 2002:a05:6a21:66c7:b0:13f:5234:24ce with SMTP id
 ze7-20020a056a2166c700b0013f523424cemr4025696pzb.28.1695276445473; Wed, 20
 Sep 2023 23:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com> <CAAd53p4LVL3uuNDCHPxteqM+jYD8E4atVyQvkt-HRhGKBVMoFg@mail.gmail.com>
 <0c73b27b8b07408da1940421217304a5@realtek.com> <CAAd53p7YOFP7G0JxLi3uHu7Xb3p1+d0DyoFjpdWAcK99VxkFBg@mail.gmail.com>
 <8850da0bfc6044599b999a80ee249b2a@realtek.com>
In-Reply-To: <8850da0bfc6044599b999a80ee249b2a@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Sep 2023 14:07:12 +0800
Message-ID: <CAAd53p4NQfALZ0p2vKFe=+KCByOQUMrOJddyLek0Y16Bx0x9TA@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ricky WU <ricky_wu@realtek.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Rafael, linux-pm]

On Mon, Sep 18, 2023 at 3:30=E2=80=AFPM Ricky WU <ricky_wu@realtek.com> wro=
te:
>
> Hi Kai-heng=EF=BC=8C
>
> It is not work, still get fail..
> Dmesg log as below
> ------------------------------------------------------------------
> [  122.214916] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [  122.227416] BUG: unable to handle page fault for address: ffff9fa18008=
9010
> [  122.227428] #PF: supervisor read access in kernel mode
> [  122.227430] #PF: error_code(0x0000) - not-present page
> [  122.227432] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 1001ff067 PT=
E 0
> [  122.227438] Oops: 0000 [#1] PREEMPT SMP PTI
> [  122.227441] CPU: 3 PID: 1956 Comm: kworker/3:11 Not tainted 6.4.0 #7
> [  122.227444] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./H370M Pro4, BIOS P3.40 10/25/2018
> [  122.227446] Workqueue: pm pm_runtime_work
> [  122.227452] RIP: 0010:ioread32+0x2e/0x70
> [  122.227456] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d=
9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f d5 a7 48
> [  122.227459] RSP: 0018:ffff9fa1836d7d78 EFLAGS: 00010296
> [  122.227461] RAX: ffff9fa180089000 RBX: 0000000000000310 RCX: 000000000=
000007f
> [  122.227462] RDX: 000000000000ff00 RSI: ffff9fa180089010 RDI: ffff9fa18=
0089010
> [  122.227464] RBP: ffff9fa1836d7d98 R08: ffff9fa180089010 R09: 000000000=
0000000
> [  122.227465] R10: ffff8ac55298deb4 R11: 0000000000000003 R12: 000000000=
000007f
> [  122.227466] R13: ffff8ac54022e000 R14: ffff8ac54022e100 R15: 000000000=
0009003
> [  122.227468] FS:  0000000000000000(0000) GS:ffff8ac5aa180000(0000) knlG=
S:0000000000000000
> [  122.227470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  122.227472] CR2: ffff9fa180089010 CR3: 0000000115a32006 CR4: 000000000=
03706e0
> [  122.227473] Call Trace:
> [  122.227475]  <TASK>
> [  122.227477]  ? show_regs+0x68/0x70
> [  122.227481]  ? __die_body+0x20/0x70
> [  122.227483]  ? __die+0x2b/0x40
> [  122.227485]  ? page_fault_oops+0x160/0x480
> [  122.227488]  ? search_bpf_extables+0x63/0x90
> [  122.227490]  ? ioread32+0x2e/0x70
> [  122.227493]  ? search_exception_tables+0x5f/0x70
> [  122.227497]  ? kernelmode_fixup_or_oops+0xa2/0x120
> [  122.227499]  ? __bad_area_nosemaphore+0x179/0x230
> [  122.227501]  ? bad_area_nosemaphore+0x16/0x20
> [  122.227503]  ? do_kern_addr_fault+0x8b/0xa0
> [  122.227505]  ? exc_page_fault+0xe5/0x180
> [  122.227509]  ? asm_exc_page_fault+0x27/0x30
> [  122.227514]  ? ioread32+0x2e/0x70
> [  122.227517]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> [  122.227527]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> [  122.227536]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> [  122.227545]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> [  122.227553]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> [  122.227557]  pci_pm_runtime_idle+0x34/0x70
> [  122.227559]  rpm_idle+0xc4/0x2b0
> [  122.227562]  pm_runtime_work+0x93/0xc0
> [  122.227565]  process_one_work+0x21a/0x430
> [  122.227569]  worker_thread+0x4a/0x3c0
> [  122.227572]  ? __pfx_worker_thread+0x10/0x10
> [  122.227574]  kthread+0x106/0x140
> [  122.227577]  ? __pfx_kthread+0x10/0x10
> [  122.227579]  ret_from_fork+0x29/0x50
> [  122.227585]  </TASK>
> [  122.227586] Modules linked in: nls_iso8859_1 snd_hda_codec_hdmi snd_hd=
a_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr intel_ra=
pl_common snd_sof_pci_intel_cnl snd_sof_intel_hda_common snd_soc_hdac_hda s=
oundwire_intel soundwire_generic_allocation soundwire_cadence snd_sof_intel=
_hda_mlink snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof=
_utils snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus=
 snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine x86_pkg_temp_thermal =
intel_powerclamp coretemp snd_hda_intel kvm_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi i915 kvm mei_hdcp crct10dif_pclmul snd_hda_codec ghash_clmulni_i=
ntel sha512_ssse3 aesni_intel binfmt_misc crypto_simd snd_hda_core cryptd s=
nd_hwdep snd_pcm input_leds drm_buddy snd_seq_midi rapl snd_seq_midi_event =
ttm joydev snd_rawmidi drm_display_helper ee1004 intel_cstate cec snd_seq w=
mi_bmof rc_core snd_seq_device snd_timer mei_me drm_kms_helper snd soundcor=
e mei intel_pch_thermal i2c_algo_bit syscopyarea sysfillrect
> [  122.227634]  sysimgblt mac_hid acpi_pad acpi_tad sch_fq_codel msr parp=
ort_pc ppdev lp drm parport ramoops reed_solomon efi_pstore ip_tables x_tab=
les autofs4 hid_generic usbhid hid rtsx_pci_sdmmc i2c_i801 e1000e ahci crc3=
2_pclmul xhci_pci i2c_smbus rtsx_pci libahci xhci_pci_renesas video wmi
> [  122.227656] CR2: ffff9fa180089010
> [  122.227658] ---[ end trace 0000000000000000 ]---
> [  122.384633] RIP: 0010:ioread32+0x2e/0x70
> [  122.384642] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d=
9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f d5 a7 48
> [  122.384644] RSP: 0018:ffff9fa1836d7d78 EFLAGS: 00010296
> [  122.384647] RAX: ffff9fa180089000 RBX: 0000000000000310 RCX: 000000000=
000007f
> [  122.384649] RDX: 000000000000ff00 RSI: ffff9fa180089010 RDI: ffff9fa18=
0089010
> [  122.384650] RBP: ffff9fa1836d7d98 R08: ffff9fa180089010 R09: 000000000=
0000000
> [  122.384652] R10: ffff8ac55298deb4 R11: 0000000000000003 R12: 000000000=
000007f
> [  122.384653] R13: ffff8ac54022e000 R14: ffff8ac54022e100 R15: 000000000=
0009003
> [  122.384654] FS:  0000000000000000(0000) GS:ffff8ac5aa180000(0000) knlG=
S:0000000000000000
> [  122.384656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  122.384658] CR2: ffff9fa180089010 CR3: 0000000119526001 CR4: 000000000=
03706e0
> [  122.384660] note: kworker/3:11[1956] exited with irqs disabled
> -------------------------------------------------------------------
>
[snipped]
> > Does the following change work for you?
> >
> > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> > b/drivers/pci/hotplug/pciehp_ctrl.c
> > index dcdbfcf404dd..ef93364a4422 100644
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -356,6 +356,7 @@ static int pciehp_disable_slot(struct controller *c=
trl,
> > bool safe_removal)
> >         int ret;
> >
> >         pm_runtime_get_sync(&ctrl->pcie->port->dev);
> > +       pm_runtime_barrier(&ctrl->pcie->port->dev);
> >         ret =3D __pciehp_disable_slot(ctrl, safe_removal);
> >         pm_runtime_put(&ctrl->pcie->port->dev);

The issue is that when the PCI cardreader gets hot unplugged,
rtsx_pci_runtime_idle still gets scheduled.
And using pm_runtime_barrier() is still not enough.

Is this something should be addressed by PM core?

Kai-Heng

> >
> >
> > Kai-Heng
> >
> > >
> > > > >
> > > > > Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management
> > > > > flow")
> > > > > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > > ---
> > > > >  drivers/misc/cardreader/rtsx_pcr.c | 14 ++++++++------
> > > > > drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 +
> > > > >  include/linux/rtsx_pci.h           |  1 +
> > > > >  3 files changed, 10 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > > > > b/drivers/misc/cardreader/rtsx_pcr.c
> > > > > index a3f4b52bb159..536a3681fd5e 100644
> > > > > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > > > > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > > > > @@ -1526,6 +1526,7 @@ static int rtsx_pci_probe(struct pci_dev
> > *pcidev,
> > > > >         pcr->host_sg_tbl_addr =3D pcr->rtsx_resv_buf_addr +
> > > > HOST_CMDS_BUF_LEN;
> > > > >         pcr->card_inserted =3D 0;
> > > > >         pcr->card_removed =3D 0;
> > > > > +       pcr->is_sd_express =3D false;
> > > > >         INIT_DELAYED_WORK(&pcr->carddet_work,
> > > > rtsx_pci_card_detect);
> > > > >
> > > > >         pcr->msi_en =3D msi_en;
> > > > > @@ -1735,12 +1736,13 @@ static int rtsx_pci_runtime_idle(struct
> > > > > device
> > > > > *device)
> > > > >
> > > > >         pcr->state =3D PDEV_STAT_IDLE;
> > > > >
> > > > > -       if (pcr->ops->disable_auto_blink)
> > > > > -               pcr->ops->disable_auto_blink(pcr);
> > > > > -       if (pcr->ops->turn_off_led)
> > > > > -               pcr->ops->turn_off_led(pcr);
> > > > > -
> > > > > -       rtsx_pm_power_saving(pcr);
> > > > > +       if (!pcr->is_sd_express) {
> > > > > +               if (pcr->ops->disable_auto_blink)
> > > > > +                       pcr->ops->disable_auto_blink(pcr);
> > > > > +               if (pcr->ops->turn_off_led)
> > > > > +                       pcr->ops->turn_off_led(pcr);
> > > > > +               rtsx_pm_power_saving(pcr);
> > > > > +       }
> > > > >
> > > > >         mutex_unlock(&pcr->pcr_mutex);
> > > > >
> > > > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > index 87d78432a1e0..80b2f2a31fdc 100644
> > > > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > @@ -1393,6 +1393,7 @@ static int sdmmc_init_sd_express(struct
> > > > > mmc_host
> > > > *mmc, struct mmc_ios *ios)
> > > > >                 RTS5261_MCU_BUS_SEL_MASK |
> > > > RTS5261_MCU_CLOCK_SEL_MASK
> > > > >                 | RTS5261_DRIVER_ENABLE_FW,
> > > > >                 RTS5261_MCU_CLOCK_SEL_16M |
> > > > RTS5261_DRIVER_ENABLE_FW);
> > > > > +       pcr->is_sd_express =3D true;
> > > > >         host->eject =3D true;
> > > > >         return 0;
> > > > >  }
> > > > > diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> > > > > index
> > > > > 534038d962e4..295e92224fd0 100644
> > > > > --- a/include/linux/rtsx_pci.h
> > > > > +++ b/include/linux/rtsx_pci.h
> > > > > @@ -1262,6 +1262,7 @@ struct rtsx_pcr {
> > > > >         u8                      ocp_stat;
> > > > >         u8                      ocp_stat2;
> > > > >         u8                      rtd3_en;
> > > > > +       bool                    is_sd_express;
> > > > >  };
> > > > >
> > > > >  #define PID_524A       0x524A
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > ------Please consider the environment before printing this e-mail.
> > >

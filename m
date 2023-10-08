Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C97BCF5E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjJHRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJHRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:19:33 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50EEA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:19:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b0dad1f98so25498906d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696785570; x=1697390370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7StzZSLpTG7RRDXeaH6+hKljRIb1+u44dx4+z2TGzs=;
        b=V9waQhM/0iV/FE4fBFG+mjy6HxpNyVqI93i88DvDiXBMzHkH/oPJ6k3VC/pa05CR3Y
         lcQMAE7RgOgOMZTxqZQ8lOgA07zDCmtrFsK7125EZHJDr3833qmUQrtx+FN6GGOVHpST
         mocUVnx4yJNJW6jas4MDDM5SRF33WDInzixVo+VXVytMck4nPT8aOWDCVLCmioNcwRsN
         3gmlohe2oBvVrd3+72CoBvVqdFheaGy5jnf0H+mPVQsYR9ga4kUXWOlX+mHWn1Kl1iaw
         l+XV5So8qMrLSDjjkL08lNncgab3BbospoeZeYF/DXtFoQBFcKZJAS3iC+Oql5IHvb6f
         57UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696785570; x=1697390370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7StzZSLpTG7RRDXeaH6+hKljRIb1+u44dx4+z2TGzs=;
        b=I7Mrjl71TqaBdQ6Vm3Mc3PsCRMSfCeZvHH4WG4jpU43cXmUfg1Fy5zr0t4ubnUekwI
         8w1f1t3Y+pXw/C3mWmrDfL5ZJj3g76IgeW47b9EkxtUrCDEtCiit+uLpjHxT0IYCmUKO
         CdMOuUwQZc0HMSRMc4A1tLp5ec4DtSNiAdGp0CvqwUbbgs6Ht9GUSd/jL+ko5WJ42SsT
         K/Vf4iEAahauq3RlAp/kXVEw2wR8Xd9J91FyaPcgX5e7cju1jKWligwd3qOtGOX09AO8
         RB1WBdCsWT8vLpF+F4cnrTd3RhqxSPpYQH3vFKzBDUY4YwUSodG7L5FA4tAV2/SCYBJ6
         BHhA==
X-Gm-Message-State: AOJu0YxCkr50tsJYT7g2U14588mCVsUuDG527yho0uNxm4pQU4UuN539
        87WIFsmaM+Fvvz9BzIV9abf3yKDfWaRTifkuc0A=
X-Google-Smtp-Source: AGHT+IEv6ba+cyvMPQmxAI9mB/bb2mB3gyvB/XS65RPHKnzR3s/nvaNUizbV9MjYN6KWtzRxGxRe/iTC+zFQp6wNokc=
X-Received: by 2002:a0c:dd87:0:b0:656:5199:77a9 with SMTP id
 v7-20020a0cdd87000000b00656519977a9mr13521078qvk.28.1696785569744; Sun, 08
 Oct 2023 10:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823011008.13146-1-luke@ljones.dev> <87v8d6cm30.wl-tiwai@suse.de>
 <R32UZR.6AQKQL1J6UQI3@ljones.dev> <87lee2ciqj.wl-tiwai@suse.de>
 <NN3UZR.VNYA824H66Q8@ljones.dev> <87il96cfnb.wl-tiwai@suse.de>
 <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com> <UB2VZR.B7HP6HUMGFA03@ljones.dev>
 <8OJY1S.X7HJ24U4D5AG2@ljones.dev> <3f3e554a-6551-e384-313d-77edf8ae316c@opensource.cirrus.com>
In-Reply-To: <3f3e554a-6551-e384-313d-77edf8ae316c@opensource.cirrus.com>
From:   Huayu Zhang <leviz.kernel.dev@gmail.com>
Date:   Mon, 9 Oct 2023 01:19:18 +0800
Message-ID: <CAE4DdFNy7QRtZrbbCFt+ptKGCFxY7p_qeODW7+jHmnqzzxifVA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Luke Jones <luke@ljones.dev>, Takashi Iwai <tiwai@suse.de>,
        tiwai@suse.com, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Jonathan LoBue <jlobue10@gmail.com>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan and all,

Thanks for examine my email. I'm just interesting in Linux kernel
development and met sound issue with my `21J8 Lenovo ThinkBook 16p Gen
4`.
Sorry for not familiar with the email process if any.

I wrote following changes based on some discovery and the downside
speakers (bass) seems begin to work. But the volumn keys actually
adjusting the frequence (I suppose). (Louder for high freq, and lower
volumn for low freq)

Wondering if any suggestions on the patch or any plan for officially
supporting of Lenovo ThinkBook 16p Gen 4. ^_^
I'll also provide the alsa-info and dmesg output below. Thanks a lot~

Patch:

From 124161547483109cbb491a8e39d1b5ef0973cd80 Mon Sep 17 00:00:00 2001
From: Huayu Zhang <zhanghuayu.dev@gmail.com>
Date: Mon, 9 Oct 2023 00:59:56 +0800
Subject: [PATCH] thinkbook 16p gen4 sound fix

---
sound/pci/hda/cs35l41_hda_property.c | 41 ++++++++++++++++++++++++++++
sound/pci/hda/patch_realtek.c | 1 +
2 files changed, 42 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c
b/sound/pci/hda/cs35l41_hda_property.c
index b62a4e6968e2..af359fbeb671 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -74,6 +74,46 @@ static int hp_vision_acpi_fix(struct cs35l41_hda
*cs35l41, struct device *physde
return 0;
}
+static int lenovo_thinkbook16pgen4_no_acpi(struct cs35l41_hda
*cs35l41, struct device *physdev, int id,
+ const char *hid)
+{
+ struct cs35l41_hw_cfg *hw_cfg =3D &cs35l41->hw_cfg;
+
+ dev_info(cs35l41->dev, "Adding DSD properties for %s\n",
cs35l41->acpi_subsystem_id);
+
+ printk("CSC3551: id =3D=3D 0x%x\n", id);
+
+ // cirrus,dev-index
+ cs35l41->index =3D id =3D=3D 0x40 ? 0 : 1;
+ cs35l41->channel_index =3D 0;
+
+ // cs35l41->reset_gpio =3D gpiod_get_index(physdev, NULL,
cs35l41->index, GPIOD_OUT_LOW);
+ cs35l41->reset_gpio =3D gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH)=
;
+ printk("CS3551: reset_gpio =3D=3D 0x%x\n", cs35l41->reset_gpio);
+
+ // cs35l41->speaker_id =3D cs35l41_get_speaker_id(physdev,
cs35l41->index, nval, -1);
+ cs35l41->speaker_id =3D cs35l41_get_speaker_id(physdev, 0, 0, 2);
+
+ // cirrus,speaker-position
+ hw_cfg->spk_pos =3D cs35l41->index;
+
+ // cirrus,gpio1-func
+ hw_cfg->gpio1.func =3D CS35l41_VSPK_SWITCH;
+ hw_cfg->gpio1.valid =3D true;
+
+ // cirrus,gpio2-func
+ hw_cfg->gpio2.func =3D CS35L41_INTERRUPT;
+ hw_cfg->gpio2.valid =3D true;
+
+ hw_cfg->bst_type =3D CS35L41_EXT_BOOST;
+ hw_cfg->valid =3D true;
+
+ put_device(physdev);
+ printk("CSC3551: Done.\n");
+
+ return 0;
+}
+
struct cs35l41_prop_model {
const char *hid;
const char *ssid;
@@ -85,6 +125,7 @@ static const struct cs35l41_prop_model
cs35l41_prop_model_table[] =3D {
{ "CLSA0100", NULL, lenovo_legion_no_acpi },
{ "CLSA0101", NULL, lenovo_legion_no_acpi },
{ "CSC3551", "103C89C6", hp_vision_acpi_fix },
+ { "CSC3551", "17AA38A9", lenovo_thinkbook16pgen4_no_acpi },
{}
};
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 751783f3a15c..fc884fdcec5f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10031,6 +10031,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C=
),
SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I=
2C),
+ SND_PCI_QUIRK(0x17aa, 0x38a9, "Lenovo ThinkBook 16p Gen 4",
ALC287_FIXUP_CS35L41_I2C_2),
SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC",
ALC287_FIXUP_TAS2781_I2C),
SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC",
ALC287_FIXUP_TAS2781_I2C),
SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual",
ALC287_FIXUP_TAS2781_I2C),
--=20
2.42.0



Here is also my alsa info output:
http://alsa-project.org/db/?f=3D1ad9f2709886f0ec5d2d87d5d8e59a0ac05384be

And the output of `dmesg | grep CSC` using the kernel with above patch:

[    4.509280] Serial bus multi instantiate pseudo device driver
CSC3551:00: Instantiated 2 I2C devices.
[    4.716009] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD
properties for 17AA38A9
[    4.716011] CSC3551: id =3D=3D 0x40
[    4.716728] CSC3551: Done.
[    4.716729] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra
_DSD properties, bypassing _DSD in ACPI
[    4.760514] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic
CS35L41 (35a40), Revision: B2
[    4.760776] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD
properties for 17AA38A9
[    4.760777] CSC3551: id =3D=3D 0x41
[    4.761107] CSC3551: Done.
[    4.761108] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra
_DSD properties, bypassing _DSD in ACPI
[    4.761108] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line
busy, assuming shared reset
[    4.802203] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cirrus Logic
CS35L41 (35a40), Revision: B2
[    5.041334] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Falling back
to default firmware.
[    5.041896] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1:
Firmware version: 3
[    5.041897] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1:
cirrus/cs35l41-dsp1-spk-prot.wmfw: Fri 24 Jun 2022 14:55:56 GMT
Daylight Time
[    5.501809] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1:
Firmware: 400a4 vendor: 0x2 v0.58.0, 2 algorithms
[    5.503073] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1:
cirrus/cs35l41-dsp1-spk-prot.bin: v0.58.0
[    5.503079] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1:
spk-prot: e:\workspace\workspace\tibranch_release_playback_6.76_2\ormis\sta=
ging\default_tunings\internal\CS35L53\Fixed_Attenuation_Mono_48000_29.78.0\=
full\Fixed_Attenuation_Mono_48000_29.78.0_full.bin
[    5.538264] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: CS35L41 Bound
- SSID: 17AA38A9, BST: 1, VSPK: 1, CH: L, FW EN: 1, SPKID: 0
[    5.538277] snd_hda_codec_realtek ehdaudio0D0: bound
i2c-CSC3551:00-cs35l41-hda.0 (ops cs35l41_hda_comp_ops
[snd_hda_scodec_cs35l41])
[    5.538545] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Falling back
to default firmware.
[    5.539404] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1:
Firmware version: 3
[    5.539409] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1:
cirrus/cs35l41-dsp1-spk-prot.wmfw: Fri 24 Jun 2022 14:55:56 GMT
Daylight Time
[    5.999448] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1:
Firmware: 400a4 vendor: 0x2 v0.58.0, 2 algorithms
[    6.000638] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1:
cirrus/cs35l41-dsp1-spk-prot.bin: v0.58.0
[    6.000640] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1:
spk-prot: e:\workspace\workspace\tibranch_release_playback_6.76_2\ormis\sta=
ging\default_tunings\internal\CS35L53\Fixed_Attenuation_Mono_48000_29.78.0\=
full\Fixed_Attenuation_Mono_48000_29.78.0_full.bin
[    6.031058] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: CS35L41 Bound
- SSID: 17AA38A9, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: 0
[    6.031062] snd_hda_codec_realtek ehdaudio0D0: bound
i2c-CSC3551:00-cs35l41-hda.1 (ops cs35l41_hda_comp_ops
[snd_hda_scodec_cs35l41])


Thanks again. Nice day~

Cheers,
Huayu

On Tue, Oct 3, 2023 at 11:07=E2=80=AFPM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
>
> On 03/10/2023 15:45, Luke Jones wrote:
> >
> >
> > On Thu, Aug 24 2023 at 08:31:06 AM +12:00:00, Luke Jones
> > <luke@ljones.dev> wrote:
> >>
> >>>
> >>> The second member variable in cs35l41_prop_model_table is the SSID to
> >>> match against.
> >>> The Lenovo laptops in the initial patch didn't have different SSIDs s=
o
> >>> the entry was set to NULL for those.
> >>> Future entries using CSC3551 MUST always have an accompanying SSID
> >>> with this entry.
> >>> Takashi was correct, the implementation is intended to also be used t=
o
> >>> patch incorrect DSD.
> >>>
> >>> We have a potential solution to workaround the SPI cs-gpios issue
> >>> inside here,
> >>> though the drawback for that is that it only works for laptops with 2
> >>> SPI amps.
> >>
> >> Can you provide me this so I can test? I have laptops with SPI 2 and
> >> 4 speaker setups.
> >
> > Hi Stefan,
> >
> > Do you have any further information about the status of this in
> > regards to the 2023 laptops?
>
> Hi,
>
> We are currently working on adding support for 2023 ASUS laptops without
> _DSD.
>
> >
> >>
> >>> I also took a look at the function for applying DSD properties for th=
e
> >>> 2023 ROG laptops.
> >>> Unfortunately the one-size-fits-all approach will not work, some of
> >>> these laptops are i2c
> >>> and some are SPI, meaning the GPIO indexes are different for differen=
t
> >>> laptops.
> >>
> >> Do you mean "spk-id-gpios"? For all the laptops I know of this seems
> >> to be
> >> Package () { "spk-id-gpios", Package () {
> >>    SPK1, 0x02, Zero, Zero,
> >>    SPK1, 0x02, Zero, Zero
> >> } },
> >>
> >> There is one laptop where it is One not 0x02 (the GA402N)
> >>
> >>> Some of the laptops do no have Speaker IDs.
> >>> Also, no laptop other than the 2 I added already should ever use
> >>> CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
> >>> are internal
> >>> boost anyway).
> >>
> >> Grazie.
> >>
> >>>
> >>> We are currently working internally on adding support for the 2023 RO=
G
> >>> laptops, so we
> >>> ask for you guys to hold off on trying to upstream support for these
> >>> laptops.
> >>
> >> Ah great. Thank you. I apologise for trying to rush things, but I do
> >> have a discord server of over 4000 people, many of whom have laptops
> >> with cirrus amps.
> >>
> >> For now I'm including a patch in my kernel builds with this mapping:
> >>
> >> const struct cs35l41_prop_model cs35l41_prop_model_table[] =3D {
> >>     { "CLSA0100", NULL, lenovo_legion_no_acpi },
> >>     { "CLSA0101", NULL, lenovo_legion_no_acpi },
> >>     { "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS GS650P
> >> - i2c
> >>     { "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS GA402X
> >> - i2c
> >>     { "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS GU604V
> >> - spi
> >>     { "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS GU603V
> >> - spi
> >>     { "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS GV601V
> >> - spi
> >>     { "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS GZ301V
> >> - spi
> >>     { "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG
> >> ALLY - i2c
> >>     { "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J -
> >> spi
> >>     { "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J -
> >> spi
> >>     { "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS G614JI
> >> -spi
> >>     { "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P -
> >> i2c
> >>     { "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS H7604JV
> >> - spi
> >>     {}
> >> };
> >>
> >> These are the machines I have verified the gpios and such for.
> >
> > I have a new version of this patch with all listed models confirmed as
> > working, and with slightly different settings for some. The only thing
> > missing in a solution to the gpio-cs issue.
> >
> > Can you please provide an update on where you are with ASUS support in
> > particular so that I may consider if it is worth my time submitting
> > the updated patch.
> We would prefer for you to wait, as we are looking to push up this
> support in the coming weeks.
> >
> >>
> >> Cheers,
> >> Luke.
> >>
> >>
> >
> >

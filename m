Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06D7B5855
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbjJBQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbjJBQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:52:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CBD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:52:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so144a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696265570; x=1696870370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igoBjAAAiCSsukRTgta1GLwRPFnj6RSNNecifLHOqA4=;
        b=AuCtTJLGVCRc0VMQHegGccabgYZKzqrsR05uvFECrN1fn+8qwR9VD1iuHmfC3eMQxo
         U+Ds+lCPzqHin/Mjs6S3PS5RPx+iKEnzyujviBLgfjO6mC5zsjYd6QpB0xq/+7ZP5v6n
         chzaVasrIaIi2WCk7SLmIwPtHTuhDvDRTgwLUNiMRVUdYISmUUXbqVLy2SAze4M2lw/u
         JT+lMk2qZMxwdYnFuX5HmF75npbarz3mjmpPnXbWcoeRORnZz0vyiOybRwq7kShaDs34
         gkNY7u9ypUfI07/vAHNukToYgZI47InpL4PDG2TtXgPLpPcPV0AWPMexhTQ4CF2Cab2c
         o5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265570; x=1696870370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igoBjAAAiCSsukRTgta1GLwRPFnj6RSNNecifLHOqA4=;
        b=SaeHAxuQHsXkP0l3oSdRa7mWhkIW9na4o96pOjWvAYVPo5FRJjDEZy/ysq3VB/cjHo
         mcAYJtTncC3PTZKL5iq2tVOQmnZMdSyxaNAgK03SWVazoe+cYi0VJ1LzV4NnfMd8tg9i
         RnQ+C4Xpg9zow+7a0PPemyAYhA+L+dAMWFvmWp96umE3xlnllf1c4ZpPV1KqYok8p0xy
         jPUtyMbUFMMfyCTSEIlX4VjRlhyWwj7a2bLIrd7VkVklUWXnWIbk9u/aWiC9XiBMuqPN
         C2zBGiVnjw4TqdXsjvqSsdhZV+3FCBxE+Je2hrG4O5GGdIYi9cr9VcxT4h7vKzZUpE/7
         nyFg==
X-Gm-Message-State: AOJu0Yy/EKs8y7gZABSeXQRYb8q8g8nSNJaSc+7E4JFFpOAEQU2tGYBg
        7pyS+jAGksfa1HtulrHmv4JaidhVAHouH7UQ6zoOlw==
X-Google-Smtp-Source: AGHT+IEDcd/akFxKXLV4v7AAEvHjgPo5rqcFY5wL3h7WBcwRtCbjUm4T3Gg8FZh2/3M9W0iz+0sXhB+XWfxCgD0J7EU=
X-Received: by 2002:a50:d5c5:0:b0:538:5f9e:f0fc with SMTP id
 g5-20020a50d5c5000000b005385f9ef0fcmr5386edj.0.1696265565270; Mon, 02 Oct
 2023 09:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info>
 <CAAzPG9NkoaUz_JRtZt_JomsYj-8ZPn4QH0w0eeR-oxd55-18Qg@mail.gmail.com>
 <CAAzPG9NWp8yPU52o7d2-jLjxjLodFOiE_AjoxmCAZ=MXtV__Aw@mail.gmail.com>
 <cf87d6a5-7ff3-4add-8c48-fd3447b32697@leemhuis.info> <1b3f8dd2-6364-4f00-a33e-8b15b8911dbf@leemhuis.info>
In-Reply-To: <1b3f8dd2-6364-4f00-a33e-8b15b8911dbf@leemhuis.info>
From:   Jeffery Miller <jefferymiller@google.com>
Date:   Mon, 2 Oct 2023 11:52:33 -0500
Message-ID: <CAAzPG9MD+UQb_RdiMkPkpQGYe-arD1nMKWngMj4P5s3_zJvphQ@mail.gmail.com>
Subject: Re: [regression] Resume broken on T14s Gen1 (AMD) due to "Input:
 psmouse - add delay when deactivating for SMBus mode"
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Andrew Duggan <aduggan@synaptics.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Sep 30, 2023 at 4:04=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> [FWIW, in case sending this in private happened accidentally, feel free
> to make this public again.]

This was unintentional. Replying back to the list.

> """
> > diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/=
psmouse-smbus.c
> > index 7b13de979908..fe12385bb856 100644
> > --- a/drivers/input/mouse/psmouse-smbus.c
> > +++ b/drivers/input/mouse/psmouse-smbus.c
> > @@ -121,11 +121,11 @@ static psmouse_ret_t psmouse_smbus_process_byte(s=
truct psmouse *psmouse)
> >
> >  static void psmouse_activate_smbus_mode(struct psmouse_smbus_dev *smbd=
ev)
> >  {
> > -       if (smbdev->need_deactivate) {
> > -               psmouse_deactivate(smbdev->psmouse);
> > -               /* Give the device time to switch into SMBus mode */
> > -               msleep(30);
> > -       }
> > +        if (smbdev->psmouse =3D=3D NULL) {
> > +           printk("XXX: smbdev->psmouse is null\n");
> > +        } else {
> > +           printk("XXX: smbdev->psmouse is set\n");
> > +        }
> >  }
> >
> >  static int psmouse_smbus_reconnect(struct psmouse *psmouse)
> """
>
> During boot this prints "XXX: smbdev->psmouse is set". But it helped, as
> the machine now resumes from s2idle again -- while printing "XXX:
> smbdev->psmouse is null". And that should not be the case I assume. Or
> did my brute force test go sideways due to my limited skills?

This was a good test. You've identified where it is crashing.

Maybe we could confirm that `psmouse->private` is not-NULL?:
```
diff --git a/drivers/input/mouse/psmouse-smbus.c
b/drivers/input/mouse/psmouse-smbus.c
index 7b13de979908..432615df9ae8 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -130,7 +130,10 @@ static void psmouse_activate_smbus_mode(struct
psmouse_smbus_dev *smbdev)

 static int psmouse_smbus_reconnect(struct psmouse *psmouse)
 {
-       psmouse_activate_smbus_mode(psmouse->private);
+       if (psmouse->private =3D=3D NULL) {
+               printk("XXX smbdev is null");
+       }
+       //psmouse_activate_smbus_mode(psmouse->private);
        return 0;
 }
```

Thanks,
Jeff

On Thu, Sep 28, 2023 at 4:08=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> On 27.09.23 19:23, Thorsten Leemhuis wrote:
> > On 27.09.23 17:55, Jeffery Miller wrote:
> >> On Wed, Sep 27, 2023 at 10:43=E2=80=AFAM Jeffery Miller
> >> <jefferymiller@google.com> wrote:
> >>> On Wed, Sep 27, 2023 at 3:54=E2=80=AFAM Thorsten Leemhuis <linux@leem=
huis.info> wrote:
> >>>>
> >>>> My dmesg from a kernel with the revert:
> >>>> https://www.leemhuis.info/files/misc/dmesg
> >
> > Thx for looking into this!
> >
> >>> In this dmesg output it shows that this is an elantech smbus device:
> >>> ```
> >>> [    4.260415] psmouse serio1: elantech: assuming hardware version 4 =
(with firmware version 0x7f3001)
> >>> [    4.279297] psmouse serio1: elantech: Synaptics capabilities query=
 result 0x90, 0x18, 0x0f.
> >>> [    4.292788] psmouse serio1: elantech: Elan sample query result 00,=
 80, c9
> >>> [    4.319184] psmouse serio1: elantech: Elan ic body: 0x10, current =
fw version: 0x3
> >>> ...
> >>> [    4.346951] psmouse serio1: elantech: Trying to set up SMBus acces=
s
> >>> [    4.346986] psmouse serio1: elantech: SMbus companion is not ready=
 yet
> >>> [    4.369993] input: ETPS/2 Elantech TrackPoint as /devices/platform=
/i8042/serio1/input/input7
> >>> [    4.376200] systemd[1]: bpf-lsm: LSM BPF program attached
> >>> [    4.385192] input: ETPS/2 Elantech Touchpad as /devices/platform/i=
8042/serio1/input/input5
> >>> ```
> >>> The change in 92e24e0e57f72e shouldn't affect the elantouch device as=
  elantech_setup_smbus
> >>> initializes `psmouse_smbus_init` with need_deactivate =3D false.
> >
> > Hmmm. Wondering if I should warm up the compiler again to recheck my
> > result one more time[1].
>
> Just did that. Ran "make clean" and compiled mainline as of now
> (633b47cb009d) and the machine does never resume from s2idle; then I
> reverted 92e24e0e57f7 and compiled again (for completeness: without
> running "make clean" beforehand) and with that kernel s2idle resume
> works perfectly fine.
>
> Wondering if I or the compiler is doing something stupid here -- or if
> we missed some small but important detail somewhere.
>
> Ciao, Thorsten
>
> >>> Did you store dmesg logs from boot without the applied patch?
> >> I intended to ask if you have logs from a boot without 92e24e0e57f72e =
reverted.
> >
> > https://www.leemhuis.info/files/misc/dmesg-6.6-rc3-vanilla
> >
> >>> If the delay was being applied the timestamps should show the 30ms de=
lay between
> >>> `psmouse serio1: elantech: Trying to set up SMBus access`
> >>> and
> >>> `psmouse serio1: elantech: SMbus companion is not ready yet`
> >
> > Unless I missed something there is not difference. :-/
> >
> > Ciao, Thorsten
> >
> > [1] FWIW, this is my bisect log
> >
> > """
> >> git bisect start
> >> # status: waiting for both good and bad commits
> >> # bad: [6465e260f48790807eef06b583b38ca9789b6072] Linux 6.6-rc3
> >> git bisect bad 6465e260f48790807eef06b583b38ca9789b6072
> >> # status: waiting for good commit(s), bad commit known
> >> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> >> git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> >> # good: [4fb0dacb78c6a041bbd38ddd998df806af5c2c69] Merge tag 'sound-6.=
6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> >> git bisect good 4fb0dacb78c6a041bbd38ddd998df806af5c2c69
> >> # good: [307d59039fb26212a84a9aa6a134a7d2bdea34ca] Merge tag 'media/v6=
.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> >> git bisect good 307d59039fb26212a84a9aa6a134a7d2bdea34ca
> >> # bad: [4a0fc73da97efd23a383ca839e6fe86410268f6b] Merge tag 's390-6.6-=
2' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> >> git bisect bad 4a0fc73da97efd23a383ca839e6fe86410268f6b
> >> # good: [e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> >> git bisect good e4f1b8202fb59c56a3de7642d50326923670513f
> >> # good: [5eea5820c7340d39e56e169e1b87199391105f6b] Merge tag 'mm-stabl=
e-2023-09-04-14-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/m=
m
> >> git bisect good 5eea5820c7340d39e56e169e1b87199391105f6b
> >> # good: [65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4] Merge tag 'gfs2-v6.=
5-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gf=
s2
> >> git bisect good 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
> >> # bad: [744a759492b5c57ff24a6e8aabe47b17ad8ee964] Merge tag 'input-for=
-v6.6-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> >> git bisect bad 744a759492b5c57ff24a6e8aabe47b17ad8ee964
> >> # good: [dbce1a7d5dce7318d8465b1e0d052ef1d2202237] Input: Explicitly i=
nclude correct DT includes
> >> git bisect good dbce1a7d5dce7318d8465b1e0d052ef1d2202237
> >> # good: [29057cc5bddc785ea0a11534d7ad2546fa0872d3] Merge tag 'linux-wa=
tchdog-6.6-rc1' of git://www.linux-watchdog.org/linux-watchdog
> >> git bisect good 29057cc5bddc785ea0a11534d7ad2546fa0872d3
> >> # bad: [3e4bb047b23375a34dbf5885709ac3729d9cfb22] Input: qt2160 - conv=
ert to use devm_* api
> >> git bisect bad 3e4bb047b23375a34dbf5885709ac3729d9cfb22
> >> # good: [e175eae16c1bf92062f1f431a95f476a61a77c48] Input: mcs-touchkey=
 - convert to use devm_* api
> >> git bisect good e175eae16c1bf92062f1f431a95f476a61a77c48
> >> # bad: [92e24e0e57f72e06c2df87116557331fd2d4dda2] Input: psmouse - add=
 delay when deactivating for SMBus mode
> >> git bisect bad 92e24e0e57f72e06c2df87116557331fd2d4dda2
> >> # good: [8362bf82fb5441613aac7c6c9dbb6b83def6ad3b] Input: mcs-touchkey=
 - fix uninitialized use of error in mcs_touchkey_probe()
> >> git bisect good 8362bf82fb5441613aac7c6c9dbb6b83def6ad3b
> >> # first bad commit: [92e24e0e57f72e06c2df87116557331fd2d4dda2] Input: =
psmouse - add delay when deactivating for SMBus mode
> > """
> >
> >

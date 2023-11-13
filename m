Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CF7E9FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:17:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968FD67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:17:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083740f92dso37019365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699888655; x=1700493455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHlIUDSBuR4QunFa52iUOiwsnqs+9AgyfIqX46v4C+0=;
        b=S1vqxlMx844PS8csrdsrsDAfDY83LTtr8/856ZuPQKxA002SUwT3v//9sni4SKCygS
         FJQWCn171rfuW8ZMpD9d4aWLvb/JyuAhAn030YwLz+EBxvTaFWnbcVi38oVNi93GimPF
         2vZ+s9NSCLFoByknFWCjBemDb45rE+KBzQlWnxLRlcgnTSyTR0Ch5K0kf7u2patAZuU7
         5JvEY0ZyxB7YkQk0DsmamRIcopg+Fr+QdYKjoPHGlDbNYz60D8QLr00Co8fBg+C4Tc2l
         AL4tDhySdKErfC1oryxkmYRhz0VbKRDOGS/z2QNK9bRO14B/afen2yC6iO3mC33mJk6n
         yh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888655; x=1700493455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHlIUDSBuR4QunFa52iUOiwsnqs+9AgyfIqX46v4C+0=;
        b=lmOiFmrd3gvYPsFk+3Iq+kB4mf6nT6gUHdgERIeahbcBFiSLGwbWJZ+WT/9LhevZNV
         l7NN5nOGtj78Hnuo7sJS4P3uVQxvQ/3U0TKSzZz7w7fjQcOPesBIuXYYPQSI8+UQfUAV
         2VpxBH+jodiufGS7jTokBOoeZGljYgV5RPhUurv7v+9xvtYxRb3OtnETy72GNIynFUmI
         82te1rX9xtL0syjBm7Pe/oaQIUiRVxDzyP9cEdOAvRT3h2zQbcxxIWXoDHQ38CFMXiEq
         DMSvYCsPr+DpTPJ+ToEGp+FH0raMNABVlsOhJaJ/zY1NrgW/Vy+WNKn2YT2lrvnQuk+0
         EAeg==
X-Gm-Message-State: AOJu0Yz0gjmUcqLeHOO2A9/ibPN4UKbo5hWl1LgPGkp+RHu9r4NeX7aH
        J1HGcCoV6Sg56vfHlIvqyvkyx94i05puMXuYx0k=
X-Google-Smtp-Source: AGHT+IHZMm6fJbUr4+M4cc3YppDWcjrBDicMMwlCTa1F961SpYEjyMZTDexX794tGBNc+f8kkm6d4wQlDb40CAO2JOY=
X-Received: by 2002:a5d:6809:0:b0:32f:7d70:529e with SMTP id
 w9-20020a5d6809000000b0032f7d70529emr5885518wru.63.1699888654444; Mon, 13 Nov
 2023 07:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20231113131634.614467-1-debug.penguin32@gmail.com> <20231113144441.6e798d8b@xps-13>
In-Reply-To: <20231113144441.6e798d8b@xps-13>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Tue, 14 Nov 2023 01:17:22 +1000
Message-ID: <CALk6UxoocrDjgtm+HgeixNiGEZ93J=DiKpwnpc1SvhiUu+RiAQ@mail.gmail.com>
Subject: Re: [PATCH] mtd:nand: Increment IFC_TIMEOUT_MSECS for nand controller response
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        andriy.shevchenko@linux.intel.com, jaimeliao.tw@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:44=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Ronald,
>
> Thanks for the patch, here are a couple of comments I'd like you to
> address before taking the fix.
>
> debug.penguin32@gmail.com wrote on Mon, 13 Nov 2023 23:16:28 +1000:
>
> The title prefix needs to be aligned with today's policy, you can check
> it with git log --oneline -- <your file>.
>
> > The nand controller not responding scenario occurs causing blocked task=
s
> > and rcu_prempt warnings of stall on cpus. Incrementing the
> > IFC_TIMEOUT_MSECS appears to solve the nand controller not responding
> > issue.
>
> I would rephrase a bit this paragraph with more confidence. Under heavy
> load it is likely that the controller is done with its own task but the
> thread unlocking the wait look is never scheduled (or not in time)
> resulting in such kind of error. Maybe there is something else wrong in
> the code which stalls the CPU in this case, (hence the first message).
>
> Enlarging the timeout to 1s in this case is fine, but maybe there is
> still something wrong aside.
>
> > ** ID_531 main/smrcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
> >         (detected by 1, t=3D2102 jiffies, g=3D12653, q=3D518)
> > task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x0000000=
0
> > [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> > [<8064bb01>] (schedule) from [<8064fa65>] (schedule_timeout+0x6d/0xa0)
> > [<8064fa65>] (schedule_timeout) from [<804ba353>] (fsl_ifc_run_command+=
0x6f/0x178)
> > [<804ba353>] (fsl_ifc_run_command) from [<804ba72f>] (fsl_ifc_cmdfunc+0=
x203/0x2b8)
> > [<804ba72f>] (fsl_ifc_cmdfunc) from [<804b135f>] (nand_status_op+0xaf/0=
xe0)
> > [<804b135f>] (nand_status_op) from [<804b13b3>] (nand_check_wp+0x23/0x4=
8)
> > [<804b13b3>] (nand_check_wp) from [<804b231d>] (nand_do_write_ops+0x99/=
0x2b8)
> > [<804b231d>] (nand_do_write_ops) from [<804b5355>] (nand_write_oob+0x3b=
/0x4a)
> > [<804b5355>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> > [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> > [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0=
x1d0)
> > [<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/=
0x90)
> > [<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x=
8c)
> > [<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_noloc=
k+0x10f/0x1a4)
> > [<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_upda=
te+0x1e9/0x36c)
> > [<8036c6dd>] (ubifs_jnl_update) from [<80370933>] (ubifs_create+0xb3/0x=
130)
> > [<80370933>] (ubifs_create) from [<802cf0c7>] (lookup_open+0x173/0x1c4)
> > [<802cf0c7>] (lookup_open) from [<802cf8a3>] (open_last_lookups+0xd7/0x=
16c)
> > [<802cf8a3>] (open_last_lookups) from [<802d08e5>] (path_openat+0x91/0x=
104)
> > [<802d08e5>] (path_openat) from [<802d0989>] (do_filp_open+0x31/0x74)
> > [<802d0989>] (do_filp_open) from [<802c4fb3>] (file_open_name+0x33/0x48=
)
> > [<802c4fb3>] (file_open_name) from [<802c4fe9>] (filp_open+0x21/0x2e)
> > [<802c4fe9>] (filp_open) from [<80490bd3>] (irq1_handler+0x53/0xa4)
> > [<80490bd3>] (irq1_handler) from [<80247dd7>] (irq_forced_thread_fn+0x1=
f/0x4c)
> > [<80247dd7>] (irq_forced_thread_fn) from [<80247cd9>] (irq_thread+0x89/=
0x114)
> > [<80247cd9>] (irq_thread) from [<8022ca67>] (kthread+0xcf/0xe4)
> > [<8022ca67>] (kthread) from [<80200149>] (ret_from_fork+0x11/0x28)
> > Exception stack(0x822bbfb0 to 0x822bbff8)
> > bfa0:                                     00000000 00000000 00000000 00=
000000
> > bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >
> > fsl,ifc-nand 7e800000.nand: Controller is not responding
> > ID_531 main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs:
> > rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
> >         (detected by 1, t=3D2102 jiffies, g=3D7729, q=3D754)
> > task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x0000000=
0
> > [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> > [<8064bb01>] (schedule) from [<8064dacd>] (rt_mutex_slowlock_block.con)
> > [<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>]
> > [<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>]
> > [<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>]
> > [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0=
x4a)
> > [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> > [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> > [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0=
x1d0)
> > [<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/=
0x90)
> > [<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x=
8c)
> > [<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_noloc=
k+0x10f/0x1a4)
> > [<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_upda=
te+0x1e9/0x36c)
>
> You can trim down the traces to only show the interesting part.
>
> Here you need a Fixes: and Cc: stable tag.
>
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
> >  drivers/mtd/nand/raw/nand_base.c    | 5 ++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw=
/fsl_ifc_nand.c
> > index 20bb1e0cb5eb..42f8ea46b6a8 100644
> > --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> > +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> > @@ -21,7 +21,7 @@
> >
> >  #define ERR_BYTE             0xFF /* Value returned for read
> >                                       bytes when read failed  */
> > -#define IFC_TIMEOUT_MSECS    500  /* Maximum number of mSecs to wait
> > +#define IFC_TIMEOUT_MSECS    1000  /* Maximum number of mSecs to wait
> >                                       for IFC NAND Machine    */
> >
> >  struct fsl_ifc_ctrl;
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index 9e24bedffd89..05b52ed41f4c 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -363,8 +363,11 @@ static int nand_check_wp(struct nand_chip *chip)
> >       int ret;
> >
> >       /* Broken xD cards report WP despite being writable */
> > -     if (chip->options & NAND_BROKEN_XD)
> > +     if (chip->options & NAND_BROKEN_XD) {
> > +             pr_info("nand_chip->options indicates NAND_BROKEN_XD %d\n=
",
> > +                     (chip->options & NAND_BROKEN_XD));
> >               return 0;
> > +     }
>
> This is an unrelated debug message and should be dropped.
>
> >
> >       /* Check the WP bit */
> >       ret =3D nand_status_op(chip, &status);
>
> Thanks,
> Miqu=C3=A8l

 Hi Miquel,
Thanks for the review and suggestions, I will send out a v2 patch shortly.
BR,
Ronald

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE9776366
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjHIPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHIPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:09:31 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E201999;
        Wed,  9 Aug 2023 08:09:30 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-791b8525b59so2506862241.1;
        Wed, 09 Aug 2023 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691593770; x=1692198570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OchhcoMIVpxOwIyBe3Afi6ZLts875kSp/oHXCF1Ax7c=;
        b=WXI4P7v0v61WiB+Y0X5Xq+YJVsDHTtwiRFujK/moZuRERokdLHb0WORUpFHaD7d21s
         e+7Jlqe5wcKMyrJ25iR67y7xjcVKmbzljPpK/eekgSPcg+HLl7C6kfe8SSEJzyR6Y1oP
         TYrLzg2E1BWLNffEbS5o4SesOk431oNY9DpTX8DacG/5RufPRP3ioJhp/AGIK+lfTrBc
         BL44M9H4wtVMOs9MDrdNtm8Qoo1LWwr1ZlhKlmcChUYOCAyRsUXDPj5rPSI0J1fLFubE
         S9ejbdSx0seZZSXXiMkXdOSa5U8876/KwjSBw34EP3tcQZFxR6XRIVETV9NNABVyQug1
         e1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593770; x=1692198570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OchhcoMIVpxOwIyBe3Afi6ZLts875kSp/oHXCF1Ax7c=;
        b=Iw9W9ca0erRpmHRw2zNbAlVF3N3SOYuqs80+ISLNym3jhh9QDRPCKQq+pUogiw93kp
         5UQClvYggDagYRSEL9kKUlEKcGYq9u9Vt/lODPSJt566DFVcXBmu5HLMMaxfEM9d4KZG
         ZWoKudSETFxz/4zVeffn6ED18cb9U+UHJUr42vleL/LNpEof4wFWpE94KCAF8svNP41T
         /K/3g0E1SMkgqqEVDEEWS1C3R+njidFdFhSTGFK+cl9Ar4HzRl38y5b1XMZT5NXg1AVi
         Qo5j/ihlCTx9UlaJ7Paze1vjavaR+o12ZPs3590QaTqyoYrA6UpXkb+ucS68m05YJo53
         sSng==
X-Gm-Message-State: AOJu0YzYo40tXTQV3LSY8nJyvhNuGL1jwSI5BCH2oK6SM0J6Zi1rfW+o
        hZgxY3xAvh0o1ATPxbpZsB63Gp046cOeGAGZ/CQ=
X-Google-Smtp-Source: AGHT+IHZdFd+Mf1WAPZLAk4zRSiN63Tm8P1FtZzy6Pv1mPkgZzJ0Ny/u3PrXl5iTmSOeGyfkimFxdTHPaRjepDJp6ok=
X-Received: by 2002:a05:6102:2455:b0:447:46e7:1348 with SMTP id
 g21-20020a056102245500b0044746e71348mr3537590vss.5.1691593769699; Wed, 09 Aug
 2023 08:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <20230721101349.12387-7-victorshihgli@gmail.com> <CAPDyKFoCXyHs4ujrQY3iphQG7GwkKLgAxEPPF6gAxoV7u2oxFQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoCXyHs4ujrQY3iphQG7GwkKLgAxEPPF6gAxoV7u2oxFQ@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 9 Aug 2023 23:09:32 +0800
Message-ID: <CAK00qKC2_ynLa6X2d6A7_hB33B9PX8AzK_b8mr9o_kOANZFx1Q@mail.gmail.com>
Subject: Re: [PATCH V9 06/23] mmc: core: Support UHS-II card control and access
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Tue, Aug 8, 2023 at 9:48=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Embed UHS-II access/control functionality into the MMC request
> > processing flow.
>
> This deserves to be extended a bit. There is quite some code being
> added in the $subject patch.
>
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V8:
> >  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >  - Modify return value in sd_uhs2_attach().
> >
> > Updates in V7:
> >  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
> >  - Drop uhs2_state in favor of ios->timing.
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/core/block.c   |   18 +-
> >  drivers/mmc/core/core.c    |    8 +
> >  drivers/mmc/core/mmc_ops.c |   25 +-
> >  drivers/mmc/core/mmc_ops.h |    1 +
> >  drivers/mmc/core/sd.c      |   13 +-
> >  drivers/mmc/core/sd.h      |    4 +
> >  drivers/mmc/core/sd_ops.c  |   11 +
> >  drivers/mmc/core/sd_ops.h  |   18 +
> >  drivers/mmc/core/sd_uhs2.c | 1137 +++++++++++++++++++++++++++++++++++-
> >  9 files changed, 1176 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index f701efb1fa78..6617ae9fc840 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -918,15 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *c=
ard, u32 *written_blocks)
> >
> >         struct scatterlist sg;
> >
> > -       cmd.opcode =3D MMC_APP_CMD;
> > -       cmd.arg =3D card->rca << 16;
> > -       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> > -
> > -       err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
> > -       if (err)
> > -               return err;
> > -       if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD)=
)
> > -               return -EIO;
> > +       err =3D mmc_app_cmd(card->host, card);
> > +               if (err)
> > +                       return err;
> >
> >         memset(&cmd, 0, sizeof(struct mmc_command));
>
> The entire chunk of change above deserves its own separate
> cleanup-patch. If you want to send it separately I can apply
> immediately - or if you decide to make it part of the series then it
> should precede the $subject patch.
>
> Note that, after the cleanup above, the call to memset() can be dropped t=
oo.
>

Hi, Ulf

     Which patch do you think would be the best if I decided to make
it part of the series?

Thanks, Victor Shih

> >
> > @@ -1612,6 +1606,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
>
> I commented on the changes in mmc_blk_rw_rq_prep() already in version
> 6 [1] - but it seems like you haven't addressed my comments yet.
>
> I have therefore copied the similar comment again, see below.
>
> >         struct request *req =3D mmc_queue_req_to_req(mqrq);
> >         struct mmc_blk_data *md =3D mq->blkdata;
> >         bool do_rel_wr, do_data_tag;
> > +       bool do_multi;
> > +
> > +       do_multi =3D (card->host->flags & MMC_UHS2_SD_TRAN) ? true : fa=
lse;
> >
> >         mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data=
_tag);
> >
> > @@ -1622,7 +1619,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> >                 brq->cmd.arg <<=3D 9;
> >         brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> >
> > -       if (brq->data.blocks > 1 || do_rel_wr) {
> > +       if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
>
> This looks wrong to me. UHS2 can use single block read/writes too. Right?
>
> >                 /* SPI multiblock writes terminate using a special
> >                  * token, not a STOP_TRANSMISSION request.
> >                  */
> > @@ -1635,6 +1632,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> >                 brq->mrq.stop =3D NULL;
> >                 readcmd =3D MMC_READ_SINGLE_BLOCK;
> >                 writecmd =3D MMC_WRITE_BLOCK;
> > +               brq->cmd.uhs2_tmode0_flag =3D 1;
> >         }
>
> As "do_multi" is always set for UHS2, setting this flag here seems to
> be wrong/redundant.
>
> Anyway, if I understand correctly, the flag is intended to be used to
> inform the host driver whether the so-called 2L_HD_mode (half-duplex
> or full-duplex) should be used for the I/O request or not. Did I
> understand this correctly?
>
> To fix the above behaviour, I suggest we try to move the entire
> control of the flag into mmc_uhs2_prepare_cmd(). It seems like we need
> the flag to be set for multi block read/writes (CMD18 and CMD25), but
> only if the host and card supports the 2L_HD_mode too, right?
>
> According to my earlier suggestions, we should also be able to check
> the 2L_HD_mode via the bits we have set in the ios->timing, no?
>
> Moreover, by making mmc_uhs2_prepare_cmd() responsible for setting the
> flag, we can move the definition of the flag into the struct
> uhs2_command instead. While at it, I suggest we also rename the flag
> into "tmode_half_duplex", to better describe its purpose. Note that,
> this also means the interpretation of the flag becomes inverted.
>
> >         brq->cmd.opcode =3D rq_data_dir(req) =3D=3D READ ? readcmd : wr=
itecmd;
> >
>
> Until we have agreed on how to move forward with the above, I am
> temporarily pausing further review.
>
> [...]
>
> Kind regards
> Uffe
>
> [1]
> https://lore.kernel.org/linux-mmc/CAPDyKFoV3Ch-xzXxiT2RnDeLvsO454Pwq1vQL_=
bdNLptM+amAg@mail.gmail.com/

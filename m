Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9776FE31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHDKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:11:18 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF749C6;
        Fri,  4 Aug 2023 03:11:13 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-794c5f5ae8aso609118241.3;
        Fri, 04 Aug 2023 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691143872; x=1691748672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O795bT5Eyf/lsWAZ3AaHRIOMHQ6qCiVHcMWVpUT8FpA=;
        b=kmd4ndKKw14A7uk4qLiufvrqsoSWYNgYbwWayJr5bbNKFNHqzLAQwVpCBlp5E4lC6q
         JDTdXt5PWxjJg3T5XwWf/vRegP8kpl2MAEaiJdljGXAZ+sCW2HynQO/lHb6jgX8dnTaB
         LjDb3Wfn/Ta/jT2jmbQ9tqItqqouFfZcMLiGlKiifNoIFnL6VoanLoUPgkIiGp8RXwaz
         W8K2tkIG7I5Oia5sc9/1sbmvnYaqJa/7cpTETEaPVLYGyVsAwfUs0qQChtQ7dB8kFmEd
         +bViMD/bL2yn2xSQqg11K8mpfDLVl4A/2l9Xr3GD9AGOwIzOgoPacaRGdaR3xGOQDXjW
         KwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143872; x=1691748672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O795bT5Eyf/lsWAZ3AaHRIOMHQ6qCiVHcMWVpUT8FpA=;
        b=iMRJifhOBfgmlH2nSVyenAAfZHR3+aQAxRzRtrPmyBLZcwN+4tEBVOkvFfT5B7DTRB
         f74pjgjsMhiBHAB/O5AgmWxB8OrV4GfFqADQREn03DCSuW5tp11dQkZdaOg57ywIQqZy
         Tv/5EhtsWC1Y3Od8Th5km1dCJ86R1T+9bqDIsLbsvwpeoVHfauAyqN4AEWwj53/K6Nx1
         c8xW/ec4Psn72hGRFeZB/fJJn1BLOj050LOtj/y6jIcF1MjIk55T8m5dZbrVlIK41uIv
         04cMp7V2sz/S1M6ZzWkxiGMP8x1k/+/wA7i3ulTwPt/1ETfKCWUr3aMEbWFjONkThi0A
         qteg==
X-Gm-Message-State: AOJu0Ywh0Axaa/HyqX4konX0SDa3B1JGW2CC8yW0rOmL6ayl7s0TMWtW
        qteTsEHRksmqwF/zGrgWSlsbYdXWoXEd7+PvUYA=
X-Google-Smtp-Source: AGHT+IEPZs8oKTetl9zmCuzuErBtsI1+zdTsuxd18Rv+Dk7eJxjD78CrmLWGK+2/QL6cOHD5tvWvq8bEQmsV8QWA1z0=
X-Received: by 2002:a67:f112:0:b0:443:7935:6eb5 with SMTP id
 n18-20020a67f112000000b0044379356eb5mr862015vsk.15.1691143871636; Fri, 04 Aug
 2023 03:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <20230721101349.12387-7-victorshihgli@gmail.com> <01ab3215-1c93-9bfc-6940-39b88788981c@intel.com>
In-Reply-To: <01ab3215-1c93-9bfc-6940-39b88788981c@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 4 Aug 2023 18:10:59 +0800
Message-ID: <CAK00qKCPayxyfSDst2RGpnR86CYa99=6ACC173g-5PLhkAV+FQ@mail.gmail.com>
Subject: Re: [PATCH V9 06/23] mmc: core: Support UHS-II card control and access
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
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

On Mon, Jul 31, 2023 at 11:29=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/07/23 13:13, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Embed UHS-II access/control functionality into the MMC request
> > processing flow.
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
> >       struct scatterlist sg;
> >
> > -     cmd.opcode =3D MMC_APP_CMD;
> > -     cmd.arg =3D card->rca << 16;
> > -     cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> > -
> > -     err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
> > -     if (err)
> > -             return err;
> > -     if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
> > -             return -EIO;
> > +     err =3D mmc_app_cmd(card->host, card);
> > +             if (err)
> > +                     return err;
> >
> >       memset(&cmd, 0, sizeof(struct mmc_command));
> >
> > @@ -1612,6 +1606,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> >       struct request *req =3D mmc_queue_req_to_req(mqrq);
> >       struct mmc_blk_data *md =3D mq->blkdata;
> >       bool do_rel_wr, do_data_tag;
> > +     bool do_multi;
> > +
> > +     do_multi =3D (card->host->flags & MMC_UHS2_SD_TRAN) ? true : fals=
e;
> >
> >       mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_t=
ag);
> >
> > @@ -1622,7 +1619,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> >               brq->cmd.arg <<=3D 9;
> >       brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> >
> > -     if (brq->data.blocks > 1 || do_rel_wr) {
> > +     if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
> >               /* SPI multiblock writes terminate using a special
> >                * token, not a STOP_TRANSMISSION request.
> >                */
> > @@ -1635,6 +1632,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> >               brq->mrq.stop =3D NULL;
> >               readcmd =3D MMC_READ_SINGLE_BLOCK;
> >               writecmd =3D MMC_WRITE_BLOCK;
> > +             brq->cmd.uhs2_tmode0_flag =3D 1;
> >       }
> >       brq->cmd.opcode =3D rq_data_dir(req) =3D=3D READ ? readcmd : writ=
ecmd;
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index ba8808cd9318..f5dc653eafb0 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, stru=
ct mmc_request *mrq)
> >
> >  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >  {
> > +     struct uhs2_command uhs2_cmd;
> > +     __be32 payload[4]; /* for maximum size */
> >       int err;
> >
> >       init_completion(&mrq->cmd_completion);
> > @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struct=
 mmc_request *mrq)
> >       if (err)
> >               return err;
> >
> > +     mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> > +
> >       led_trigger_event(host->led, LED_FULL);
> >       __mmc_start_request(host, mrq);
>
> Same comment as for V8:
>
> Refer:
> https://lore.kernel.org/linux-mmc/047c746f-0787-37ec-7989-cd932f288564@in=
tel.com/
>
>
> __mmc_start_request() is also called by mmc_wait_for_req_done()
> but uhs2_cmd is local to mmc_start_request(), so if mmc_wait_for_req_done=
()
> is ever called in UHS2 case with cmd->retries, it looks like
> host controller might try to access uhs2_cmd which is no
> longer valid?
>
> There is perhaps mmc_send_status() used in block.c ?
>
> Need to get Ulf's view, but putting "struct uhs2_command uhs2_cmd"
> and "__be32 payload[4]" in struct mmc_command or struct mmc_request
> would seem to be options.  If size is a concern, some optimization
> to reduce the size of struct uhs2_command looks possible, and is
> max payload len actually only 2 at the moment.
>

Hi, Ulf

      Could I get your opinion on this matter?
      Or maybe we could try the Adrian=E2=80=99s opinion first?

Thanks, Victor Shih

> >
> > @@ -430,6 +434,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
> >   */
> >  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> >  {
> > +     struct uhs2_command uhs2_cmd;
> > +     __be32 payload[4]; /* for maximum size */
> >       int err;
> >
> >       /*
> > @@ -450,6 +456,8 @@ int mmc_cqe_start_req(struct mmc_host *host, struct=
 mmc_request *mrq)
> >       if (err)
> >               goto out_err;
> >
> > +     mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> > +
> >       err =3D host->cqe_ops->cqe_request(host, mrq);
> >       if (err)
> >               goto out_err;
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index 3b3adbddf664..8ae205a07f9b 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
> >       return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> >  }
> >
> > +int __mmc_go_idle(struct mmc_host *host)
> > +{
> > +     struct mmc_command cmd =3D {};
> > +     int err;
> > +
> > +     cmd.opcode =3D MMC_GO_IDLE_STATE;
> > +     cmd.arg =3D 0;
> > +     cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     mmc_delay(1);
> > +
> > +     return err;
> > +}
> > +
> >  int mmc_go_idle(struct mmc_host *host)
> >  {
> >       int err;
> > -     struct mmc_command cmd =3D {};
> >
> >       /*
> >        * Non-SPI hosts need to prevent chipselect going active during
> > @@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
> >               mmc_delay(1);
> >       }
> >
> > -     cmd.opcode =3D MMC_GO_IDLE_STATE;
> > -     cmd.arg =3D 0;
> > -     cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> > -
> > -     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > -
> > -     mmc_delay(1);
> > +     err =3D __mmc_go_idle(host);
> >
> >       if (!mmc_host_is_spi(host)) {
> >               mmc_set_chip_select(host, MMC_CS_DONTCARE);
> > @@ -300,6 +308,7 @@ int mmc_send_adtc_data(struct mmc_card *card, struc=
t mmc_host *host, u32 opcode,
> >        * not R1 plus a data block.
> >        */
> >       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > +     cmd.uhs2_tmode0_flag =3D 1;
> >
> >       data.blksz =3D len;
> >       data.blocks =3D 1;
> > diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> > index 09ffbc00908b..abda7492d578 100644
> > --- a/drivers/mmc/core/mmc_ops.h
> > +++ b/drivers/mmc/core/mmc_ops.h
> > @@ -25,6 +25,7 @@ struct mmc_command;
> >  int mmc_select_card(struct mmc_card *card);
> >  int mmc_deselect_cards(struct mmc_host *host);
> >  int mmc_set_dsr(struct mmc_host *host);
> > +int __mmc_go_idle(struct mmc_host *host);
> >  int mmc_go_idle(struct mmc_host *host);
> >  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
> >  int mmc_set_relative_addr(struct mmc_card *card);
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 246ce027ae0a..15e465f0cc3f 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -207,7 +207,7 @@ static int mmc_decode_csd(struct mmc_card *card)
> >  /*
> >   * Given a 64-bit response, decode to our card SCR structure.
> >   */
> > -static int mmc_decode_scr(struct mmc_card *card)
> > +int mmc_decode_scr(struct mmc_card *card)
> >  {
> >       struct sd_scr *scr =3D &card->scr;
> >       unsigned int scr_struct;
> > @@ -904,7 +904,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
> >       return 0;
> >  }
> >
> > -static int mmc_sd_get_ro(struct mmc_host *host)
> > +int mmc_sd_get_ro(struct mmc_host *host)
> >  {
> >       int ro;
> >
> > @@ -1616,11 +1616,6 @@ static void mmc_sd_detect(struct mmc_host *host)
> >       }
> >  }
> >
> > -static int sd_can_poweroff_notify(struct mmc_card *card)
> > -{
> > -     return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
> > -}
> > -
> >  static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
> >  {
> >       struct sd_busy_data *data =3D cb_data;
> > @@ -1644,7 +1639,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_da=
ta, bool *busy)
> >       return 0;
> >  }
> >
> > -static int sd_poweroff_notify(struct mmc_card *card)
> > +int sd_poweroff_notify(struct mmc_card *card)
> >  {
> >       struct sd_busy_data cb_data;
> >       u8 *reg_buf;
> > @@ -1692,7 +1687,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
> >       if (mmc_card_suspended(card))
> >               goto out;
> >
> > -     if (sd_can_poweroff_notify(card))
> > +     if (mmc_sd_can_poweroff_notify(card))
> >               err =3D sd_poweroff_notify(card);
> >       else if (!mmc_host_is_spi(host))
> >               err =3D mmc_deselect_cards(host);
> > diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> > index 1af5a038bae9..d31259919ee5 100644
> > --- a/drivers/mmc/core/sd.h
> > +++ b/drivers/mmc/core/sd.h
> > @@ -11,10 +11,14 @@ struct mmc_card;
> >
> >  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr=
);
> >  int mmc_sd_get_csd(struct mmc_card *card);
> > +int mmc_sd_get_ro(struct mmc_host *host);
> >  void mmc_decode_cid(struct mmc_card *card);
> >  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
> >       bool reinit);
> >  unsigned mmc_sd_get_max_clock(struct mmc_card *card);
> >  int mmc_sd_switch_hs(struct mmc_card *card);
> >
> > +/* These call back functions were also used by UHS2 sd card */
> > +int sd_poweroff_notify(struct mmc_card *card);
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index ef8d1dce5af1..1f9580491ad0 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -27,6 +27,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_ca=
rd *card)
> >       if (WARN_ON(card && card->host !=3D host))
> >               return -EINVAL;
> >
> > +     /*
> > +      * UHS2 packet has APP bit so only set APP_CMD flag here.
> > +      * Will set the APP bit when assembling UHS2 packet.
> > +      */
> > +     if (host->flags & MMC_UHS2_SD_TRAN) {
> > +             host->uhs2_app_cmd =3D true;
> > +             return 0;
> > +     }
> > +
> >       cmd.opcode =3D MMC_APP_CMD;
> >
> >       if (card) {
> > @@ -281,6 +290,7 @@ int mmc_app_send_scr(struct mmc_card *card)
> >       cmd.opcode =3D SD_APP_SEND_SCR;
> >       cmd.arg =3D 0;
> >       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > +     cmd.uhs2_tmode0_flag =3D 1;
> >
> >       data.blksz =3D 8;
> >       data.blocks =3D 1;
> > @@ -344,6 +354,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *=
ssr)
> >       cmd.opcode =3D SD_APP_SD_STATUS;
> >       cmd.arg =3D 0;
> >       cmd.flags =3D MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > +     cmd.uhs2_tmode0_flag =3D 1;
> >
> >       data.blksz =3D 64;
> >       data.blocks =3D 1;
> > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > index 3ba7b3cf4652..8c2da57ca2c2 100644
> > --- a/drivers/mmc/core/sd_ops.h
> > +++ b/drivers/mmc/core/sd_ops.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/types.h>
> >
> >  struct mmc_card;
> > +struct mmc_command;
> >  struct mmc_host;
> >
> >  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> > @@ -19,10 +20,27 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr=
);
> >  int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
> >  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
> >  int mmc_app_send_scr(struct mmc_card *card);
> > +int mmc_decode_scr(struct mmc_card *card);
> >  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> >       u8 value, u8 *resp);
> >  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
> >  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> > +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *m=
rq);
> > +
> > +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, st=
ruct mmc_request *mrq,
> > +                                          struct uhs2_command uhs2_cmd=
, __be32 payload[4])
> > +{
> > +     if (host->flags & MMC_UHS2_SD_TRAN) {
> > +             uhs2_cmd.payload =3D payload;
> > +             mrq->cmd->uhs2_cmd =3D &uhs2_cmd;
> > +             mmc_uhs2_prepare_cmd(host, mrq);
> > +     }
> > +}
> > +
> > +static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> > +{
> > +     return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
> > +}
> >
> >  #endif
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 06b2aab52b93..0a1b00b59499 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -1,23 +1,51 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * Copyright (C) 2021 Linaro Ltd
> > - *
> >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> >   *
> > + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + * Author: Yi Sun <yi.y.sun@intel.com>
> > + *
> > + * Copyright (C) 2020 Genesys Logic, Inc.
> > + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *
> > + * Copyright (C) 2020 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + *
> > + * Copyright (C) 2022 Genesys Logic, Inc.
> > + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> > + *
> > + * Copyright (C) 2023 Genesys Logic, Inc.
> > + * Authors: Victor Shih <victor.shih@genesyslogic.com.tw>
> > + *
> >   * Support for SD UHS-II cards
> >   */
> >  #include <linux/err.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> > +#include "card.h"
> >  #include "core.h"
> >  #include "bus.h"
> >  #include "sd.h"
> > +#include "sd_ops.h"
> >  #include "mmc_ops.h"
> >
> > +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000) /* 1ms */
> > +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100        /* 100ms */
> > +
> >  static const unsigned int sd_uhs2_freqs[] =3D { 52000000, 26000000 };
> >
> > +struct sd_uhs2_wait_active_state_data {
> > +     struct mmc_host *host;
> > +     struct mmc_command *cmd;
> > +};
> > +
> >  static int sd_uhs2_power_up(struct mmc_host *host)
> >  {
> >       int err;
> > @@ -50,6 +78,43 @@ static int sd_uhs2_power_off(struct mmc_host *host)
> >       return host->ops->uhs2_control(host, UHS2_SET_IOS);
> >  }
> >
> > +/*
> > + * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is em=
bedded in
> > + *                          mmc_command structure
> > + * @cmd:     MMC command to executed
> > + * @uhs2_cmd:        UHS2 command corresponded to MMC command
> > + * @header:  Header field of UHS-II command cxpacket
> > + * @arg:     Argument field of UHS-II command packet
> > + * @payload: Payload field of UHS-II command packet
> > + * @plen:    Payload length
> > + * @resp:    Response buffer is allocated by caller and it is used to =
keep
> > + *              the response of CM-TRAN command. For SD-TRAN command, =
uhs2_resp
> > + *              should be null and SD-TRAN command response should be =
stored in
> > + *              resp of mmc_command.
> > + * @resp_len:        Response buffer length
> > + *
> > + * The uhs2_command structure contains message packets which are trans=
mited/
> > + * received on UHS-II bus. This function fills in the contents of uhs2=
_command
> > + * structure and embededs UHS2 command into mmc_command structure, whi=
ch is used
> > + * in legacy SD operation functions.
> > + *
> > + */
> > +static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
> > +                              struct uhs2_command *uhs2_cmd,
> > +                              u16 header, u16 arg, __be32 *payload,
> > +                              u8 plen, u8 *resp, u8 resp_len)
> > +{
> > +     uhs2_cmd->header =3D header;
> > +     uhs2_cmd->arg =3D arg;
> > +     uhs2_cmd->payload =3D payload;
> > +     uhs2_cmd->payload_len =3D plen * sizeof(u32);
> > +     uhs2_cmd->packet_len =3D uhs2_cmd->payload_len + 4;
> > +
> > +     cmd->uhs2_cmd =3D uhs2_cmd;
> > +     cmd->uhs2_resp =3D resp;
> > +     cmd->uhs2_resp_len =3D resp_len;
> > +}
> > +
> >  /*
> >   * Run the phy initialization sequence, which mainly relies on the UHS=
-II host
> >   * to check that we reach the expected electrical state, between the h=
ost and
> > @@ -57,7 +122,15 @@ static int sd_uhs2_power_off(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_phy_init(struct mmc_host *host)
> >  {
> > -     return 0;
> > +     int err =3D 0;
> > +
> > +     err =3D host->ops->uhs2_control(host, UHS2_PHY_INIT);
> > +     if (err) {
> > +             pr_err("%s: failed to initial phy for UHS-II!\n",
> > +                    mmc_hostname(host));
> > +     }
> > +
> > +     return err;
> >  }
> >
> >  /*
> > @@ -66,6 +139,82 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_dev_init(struct mmc_host *host)
> >  {
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u32 cnt;
> > +     u32 dap, gap, resp_gap;
> > +     u16 header, arg;
> > +     __be32 payload[UHS2_DEV_INIT_PAYLOAD_LEN];
> > +     u8 gd =3D 0;
> > +     u8 resp[UHS2_DEV_ENUM_RESP_LEN] =3D {0};
> > +     int err;
> > +
> > +     dap =3D host->uhs2_caps.dap;
> > +     gap =3D host->uhs2_caps.gap;
> > +
> > +     /*
> > +      * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVIC=
E_INIT CCMD format.
> > +      * Head:
> > +      *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> > +      *      - IOADR =3D CMD_BASE + 002h
> > +      * Payload:
> > +      *      - bit [3:0]  : GAP(Group Allocated Power)
> > +      *      - bit [7:4]  : GD(Group Descriptor)
> > +      *      - bit [11]   : Complete Flag
> > +      *      - bit [15:12]: DAP(Device Allocated Power)
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> > +     arg =3D ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_WRITE |
> > +            UHS2_NATIVE_CMD_PLEN_4B |
> > +            (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> > +
> > +     /*
> > +      * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> > +      * Max. time from DEVICE_INIT CCMD EOP reception on Device
> > +      * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> > +      * 1 second.
> > +      */
> > +     cmd.busy_timeout =3D 1000;
> > +
> > +     /*
> > +      * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> > +      * When the number of the DEVICE_INIT commands is reach to
> > +      * 30 tiems, Host shall stop issuing DEVICE_INIT command
> > +      * and regard it as an error.
> > +      */
> > +     for (cnt =3D 0; cnt < 30; cnt++) {
> > +             payload[0] =3D ((dap & 0xF) << 12) |
> > +                           UHS2_DEV_INIT_COMPLETE_FLAG |
> > +                           ((gd & 0xF) << 4) |
> > +                           (gap & 0xF);
> > +
> > +             sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> > +                                  payload, UHS2_DEV_INIT_PAYLOAD_LEN,
> > +                                  resp, UHS2_DEV_INIT_RESP_LEN);
> > +
> > +             err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +             if (err) {
> > +                     pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\=
n",
> > +                            mmc_hostname(host), __func__, err);
> > +                     return err;
> > +             }
> > +
> > +             if (resp[3] !=3D (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> > +                     pr_err("%s: DEVICE_INIT response is wrong!\n",
> > +                            mmc_hostname(host));
> > +                     return -EIO;
> > +             }
> > +
> > +             if (resp[5] & 0x8) {
> > +                     host->uhs2_caps.group_desc =3D gd;
> > +                     return 0;
> > +             }
> > +             resp_gap =3D resp[4] & 0x0F;
> > +             if (gap =3D=3D resp_gap)
> > +                     gd++;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -76,6 +225,52 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> >  {
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u16 header, arg;
> > +     __be32 payload[UHS2_DEV_ENUM_PAYLOAD_LEN];
> > +     u8 id_f =3D 0xF, id_l =3D 0x0;
> > +     u8 resp[UHS2_DEV_ENUM_RESP_LEN] =3D {0};
> > +     int err;
> > +
> > +     /*
> > +      * Refer to UHS-II Addendum Version 1.02 Figure 6-28 to see ENUME=
RATE CCMD format.
> > +      * Header:
> > +      *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> > +      *      - IOADR =3D CMD_BASE + 003h
> > +      * Payload:
> > +      *      - bit [3:0]: ID_L(Last Node ID)
> > +      *      - bit [7:4]: ID_F(First Node ID)
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> > +     arg =3D ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_WRITE |
> > +            UHS2_NATIVE_CMD_PLEN_4B |
> > +            (UHS2_DEV_CMD_ENUMERATE >> 8);
> > +
> > +     payload[0] =3D (id_f << 4) | id_l;
> > +     payload[0] =3D cpu_to_be32(payload[0]);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
DEV_ENUM_PAYLOAD_LEN,
> > +                          resp, UHS2_DEV_ENUM_RESP_LEN);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     if (resp[3] !=3D (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
> > +             pr_err("%s: ENUMERATE response is wrong!\n",
> > +                    mmc_hostname(host));
> > +             return -EIO;
> > +     }
> > +
> > +     id_f =3D (resp[4] >> 4) & 0xF;
> > +     id_l =3D resp[4] & 0xF;
> > +     *node_id =3D id_f;
> > +
> >       return 0;
> >  }
> >
> > @@ -86,6 +281,181 @@ static int sd_uhs2_enum(struct mmc_host *host, u32=
 *node_id)
> >   */
> >  static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card =
*card)
> >  {
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u16 header, arg;
> > +     u32 cap;
> > +     int err;
> > +
> > +     /*
> > +      * Use Control Read CCMD to read Generic Capability from Configur=
ation Register.
> > +      * - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> > +      * - IOADR =3D Generic Capability Register(CFG_BASE + 000h)
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs=
2_config.node_id;
> > +     arg =3D ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_READ |
> > +            UHS2_NATIVE_CMD_PLEN_4B |
> > +            (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> > +
> > +     /*
> > +      * There is no payload because per spec, there should be
> > +      * no payload field for read CCMD.
> > +      * Plen is set in arg. Per spec, plen for read CCMD
> > +      * represents the len of read data which is assigned in payload
> > +      * of following RES (p136).
> > +      */
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Generic Capability Register:
> > +      * bit [7:0]  : Reserved
> > +      * bit [13:8] : Device-Specific Number of Lanes and Functionality
> > +      *              bit 8: 2L-HD
> > +      *              bit 9: 2D-1U FD
> > +      *              bit 10: 1D-2U FD
> > +      *              bit 11: 2D-2U FD
> > +      *              Others: Reserved
> > +      * bit [14]   : DADR Length
> > +      *              0: 4 bytes
> > +      *              1: Reserved
> > +      * bit [23:16]: Application Type
> > +      *              bit 16: 0=3DNon-SD memory, 1=3DSD memory
> > +      *              bit 17: 0=3DNon-SDIO, 1=3DSDIO
> > +      *              bit 18: 0=3DCard, 1=3DEmbedded
> > +      * bit [63:24]: Reserved
> > +      */
> > +     cap =3D cmd.resp[0];
> > +     card->uhs2_config.n_lanes =3D
> > +                             (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
> > +                             UHS2_DEV_CONFIG_N_LANES_MASK;
> > +     card->uhs2_config.dadr_len =3D
> > +                             (cap >> UHS2_DEV_CONFIG_DADR_POS) &
> > +                             UHS2_DEV_CONFIG_DADR_MASK;
> > +     card->uhs2_config.app_type =3D
> > +                             (cap >> UHS2_DEV_CONFIG_APP_POS) &
> > +                             UHS2_DEV_CONFIG_APP_MASK;
> > +
> > +     /*
> > +      * Use Control Read CCMD to read PHY Capability from Configuratio=
n Register.
> > +      * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D PHY Capability Register(CFG_BASE + 002h)
> > +      */
> > +     arg =3D ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_READ |
> > +            UHS2_NATIVE_CMD_PLEN_8B |
> > +           (UHS2_DEV_CONFIG_PHY_CAPS >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * PHY Capability Register:
> > +      * bit [3:0]  : PHY Minor Revision
> > +      * bit [5:4]  : PHY Major Revision
> > +      * bit [15]   : Support Hibernate Mode
> > +      *              0: Not support Hibernate Mode
> > +      *              1: Support Hibernate Mode
> > +      * bit [31:16]: Reserved
> > +      * bit [35:32]: Device-Specific N_LSS_SYN
> > +      * bit [39:36]: Device-Specific N_LSS_DIR
> > +      * bit [63:40]: Reserved
> > +      */
> > +     cap =3D cmd.resp[0];
> > +     card->uhs2_config.phy_minor_rev =3D
> > +                             cap & UHS2_DEV_CONFIG_PHY_MINOR_MASK;
> > +     card->uhs2_config.phy_major_rev =3D
> > +                             (cap >> UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
> > +                              UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
> > +     card->uhs2_config.can_hibernate =3D
> > +                             (cap >> UHS2_DEV_CONFIG_CAN_HIBER_POS) &
> > +                              UHS2_DEV_CONFIG_CAN_HIBER_MASK;
> > +
> > +     cap =3D cmd.resp[1];
> > +     card->uhs2_config.n_lss_sync =3D
> > +                             cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> > +     card->uhs2_config.n_lss_dir =3D
> > +                             (cap >> UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
> > +                             UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> > +     if (card->uhs2_config.n_lss_sync =3D=3D 0)
> > +             card->uhs2_config.n_lss_sync =3D 16 << 2;
> > +     else
> > +             card->uhs2_config.n_lss_sync <<=3D 2;
> > +
> > +     if (card->uhs2_config.n_lss_dir =3D=3D 0)
> > +             card->uhs2_config.n_lss_dir =3D 16 << 3;
> > +     else
> > +             card->uhs2_config.n_lss_dir <<=3D 3;
> > +
> > +     /*
> > +      * Use Control Read CCMD to read LINK/TRAN Capability from Config=
uration Register.
> > +      * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D LINK/TRAN Capability Register(CFG_BASE + 004h)
> > +      */
> > +     arg =3D ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
> > +             UHS2_NATIVE_CMD_READ |
> > +             UHS2_NATIVE_CMD_PLEN_8B |
> > +             (UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * LINK/TRAN Capability Register:
> > +      * bit [3:0]  : LINK_TRAN Minor Revision
> > +      * bit [5:4]  : LINK/TRAN Major Revision
> > +      * bit [7:6]  : Reserved
> > +      * bit [15:8] : Device-Specific N_FCU
> > +      * bit [18:16]: Device Type
> > +      *              001b=3DHost
> > +      *              010b=3DDevice
> > +      *              011b=3DReserved for CMD issuable Device
> > +      * bit [19]   : Reserved
> > +      * bit [31:20]: Device-Specific MAX_BLKLEN
> > +      * bit [39:32]: Device-Specific N_DATA_GAP
> > +      * bit [63:40]: Reserved
> > +      */
> > +     cap =3D cmd.resp[0];
> > +     card->uhs2_config.link_minor_rev =3D
> > +                             cap & UHS2_DEV_CONFIG_LT_MINOR_MASK;
> > +     card->uhs2_config.link_major_rev =3D
> > +                             (cap >> UHS2_DEV_CONFIG_LT_MAJOR_POS) &
> > +                             UHS2_DEV_CONFIG_LT_MAJOR_MASK;
> > +     card->uhs2_config.n_fcu =3D
> > +                             (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
> > +                             UHS2_DEV_CONFIG_N_FCU_MASK;
> > +     card->uhs2_config.dev_type =3D
> > +                             (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
> > +                             UHS2_DEV_CONFIG_DEV_TYPE_MASK;
> > +     card->uhs2_config.maxblk_len =3D
> > +                             (cap >> UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) =
&
> > +                             UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
> > +
> > +     cap =3D cmd.resp[1];
> > +     card->uhs2_config.n_data_gap =3D
> > +                             cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
> > +     if (card->uhs2_config.n_fcu =3D=3D 0)
> > +             card->uhs2_config.n_fcu =3D 256;
> > +
> >       return 0;
> >  }
> >
> > @@ -100,26 +470,357 @@ static int sd_uhs2_config_read(struct mmc_host *=
host, struct mmc_card *card)
> >   */
> >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card=
 *card)
> >  {
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u16 header, arg;
> > +     __be32 payload[UHS2_CFG_WRITE_PAYLOAD_LEN];
> > +     u8 nMinDataGap;
> > +     int err;
> > +     u8 resp[5] =3D {0};
> > +
> > +     /*
> > +      * Use Control Write CCMD to set Generic Setting in Configuration=
 Register.
> > +      * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D Generic Setting Register(CFG_BASE + 008h)
> > +      * - Payload =3D New contents to be written to Generic Setting Re=
gister
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs=
2_config.node_id;
> > +     arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_WRITE |
> > +            UHS2_NATIVE_CMD_PLEN_8B |
> > +            (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > +
> > +     /*
> > +      * Most UHS-II cards only support FD and 2L-HD mode. Other lane n=
umbers
> > +      * defined in UHS-II addendem Ver1.01 are optional.
> > +      */
> > +     host->uhs2_caps.n_lanes_set =3D UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > +     card->uhs2_config.n_lanes_set =3D UHS2_DEV_CONFIG_GEN_SET_2L_FD_H=
D;
> > +
> > +     payload[0] =3D card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N=
_LANES_POS;
> > +     payload[1] =3D 0;
> > +     payload[0] =3D cpu_to_be32(payload[0]);
> > +     payload[1] =3D cpu_to_be32(payload[1]);
> > +
> > +     /*
> > +      * There is no payload because per spec, there should be
> > +      * no payload field for read CCMD.
> > +      * Plen is set in arg. Per spec, plen for read CCMD
> > +      * represents the len of read data which is assigned in payload
> > +      * of following RES (p136).
> > +      */
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> > +                          NULL, 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Use Control Write CCMD to set PHY Setting in Configuration Reg=
ister.
> > +      * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D PHY Setting Register(CFG_BASE + 00Ah)
> > +      * - Payload =3D New contents to be written to PHY Setting Regist=
er
> > +      */
> > +     arg =3D ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_WRITE |
> > +            UHS2_NATIVE_CMD_PLEN_8B |
> > +            (UHS2_DEV_CONFIG_PHY_SET >> 8);
> > +
> > +     if (host->uhs2_caps.speed_range =3D=3D UHS2_DEV_CONFIG_PHY_SET_SP=
EED_B) {
> > +             if (card->uhs2_config.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_H=
D_FD &&
> > +                 host->uhs2_caps.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_HD_=
FD) {
> > +                     /* Support HD */
> > +                     host->ios.timing =3D MMC_TIMING_UHS2_SPEED_B_HD;
> > +                     nMinDataGap =3D 1;
> > +             } else {
> > +                     /* Only support 2L-FD so far */
> > +                     host->ios.timing =3D MMC_TIMING_UHS2_SPEED_B;
> > +                     nMinDataGap =3D 3;
> > +             }
> > +             card->uhs2_config.speed_range_set =3D UHS2_DEV_CONFIG_PHY=
_SET_SPEED_B;
> > +     } else {
> > +             if (card->uhs2_config.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_H=
D_FD &&
> > +                 host->uhs2_caps.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_HD_=
FD) {
> > +                     /* Support HD */
> > +                     host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A_HD;
> > +                     nMinDataGap =3D 1;
> > +             } else {
> > +                     /* Only support 2L-FD so far */
> > +                     host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A;
> > +                     nMinDataGap =3D 3;
> > +             }
> > +             card->uhs2_config.speed_range_set =3D UHS2_DEV_CONFIG_PHY=
_SET_SPEED_A;
> > +     }
> > +
> > +     payload[0] =3D card->uhs2_config.speed_range_set << UHS2_DEV_CONF=
IG_PHY_SET_SPEED_POS;
> > +
> > +     card->uhs2_config.n_lss_sync_set =3D (max(card->uhs2_config.n_lss=
_sync,
> > +                                             host->uhs2_caps.n_lss_syn=
c) >> 2) &
> > +                                        UHS2_DEV_CONFIG_N_LSS_SYN_MASK=
;
> > +     host->uhs2_caps.n_lss_sync_set =3D card->uhs2_config.n_lss_sync_s=
et;
> > +
> > +     card->uhs2_config.n_lss_dir_set =3D (max(card->uhs2_config.n_lss_=
dir,
> > +                                            host->uhs2_caps.n_lss_dir)=
 >> 3) &
> > +                                       UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> > +     host->uhs2_caps.n_lss_dir_set =3D card->uhs2_config.n_lss_dir_set=
;
> > +
> > +     payload[1] =3D (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFI=
G_N_LSS_DIR_POS) |
> > +                  card->uhs2_config.n_lss_sync_set;
> > +     payload[0] =3D cpu_to_be32(payload[0]);
> > +     payload[1] =3D cpu_to_be32(payload[1]);
> > +
> > +     memset(resp, 0, sizeof(resp));
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> > +                          resp, UHS2_CFG_WRITE_PHY_SET_RESP_LEN);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     if ((resp[2] & 0x80)) {
> > +             pr_err("%s: %s: UHS2 CMD not accepted, resp=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, resp[2]);
> > +             return -EIO;
> > +     }
> > +
> > +     /*
> > +      * Use Control Write CCMD to set LINK/TRAN Setting in Configurati=
on Register.
> > +      * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D LINK/TRAN Setting Register(CFG_BASE + 00Ch)
> > +      * - Payload =3D New contents to be written to LINK/TRAN Setting =
Register
> > +      */
> > +     arg =3D ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
> > +             UHS2_NATIVE_CMD_WRITE |
> > +             UHS2_NATIVE_CMD_PLEN_8B |
> > +             (UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
> > +
> > +     if (card->uhs2_config.app_type =3D=3D UHS2_DEV_CONFIG_APP_SD_MEM)
> > +             card->uhs2_config.maxblk_len_set =3D UHS2_DEV_CONFIG_LT_S=
ET_MAX_BLK_LEN;
> > +     else
> > +             card->uhs2_config.maxblk_len_set =3D min(card->uhs2_confi=
g.maxblk_len,
> > +                                                    host->uhs2_caps.ma=
xblk_len);
> > +     host->uhs2_caps.maxblk_len_set =3D card->uhs2_config.maxblk_len_s=
et;
> > +
> > +     card->uhs2_config.n_fcu_set =3D min(card->uhs2_config.n_fcu, host=
->uhs2_caps.n_fcu);
> > +     host->uhs2_caps.n_fcu_set =3D card->uhs2_config.n_fcu_set;
> > +
> > +     card->uhs2_config.n_data_gap_set =3D max(nMinDataGap, card->uhs2_=
config.n_data_gap);
> > +     host->uhs2_caps.n_data_gap_set =3D card->uhs2_config.n_data_gap_s=
et;
> > +
> > +     host->uhs2_caps.max_retry_set =3D 3;
> > +     card->uhs2_config.max_retry_set =3D host->uhs2_caps.max_retry_set=
;
> > +
> > +     payload[0] =3D (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONF=
IG_MAX_BLK_LEN_POS) |
> > +                  (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_=
LT_SET_MAX_RETRY_POS) |
> > +                  (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FC=
U_POS);
> > +     payload[1] =3D card->uhs2_config.n_data_gap_set;
> > +     payload[0] =3D cpu_to_be32(payload[0]);
> > +     payload[1] =3D cpu_to_be32(payload[1]);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> > +                          NULL, 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Use Control Write CCMD to set Config Completion(payload bit 63=
) in Generic Setting
> > +      * Register.
> > +      * Header:
> > +      *      - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> > +      *      - IOADR =3D PGeneric Setting Register(CFG_BASE + 008h)
> > +      * Payload:
> > +      *      - bit [63]: Config Completion
> > +      *
> > +      * DLSM transits to Active state immediately when Config Completi=
on is set to 1.
> > +      */
> > +     arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +            UHS2_NATIVE_CMD_WRITE |
> > +            UHS2_NATIVE_CMD_PLEN_8B |
> > +            (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > +
> > +     payload[0] =3D 0;
> > +     payload[1] =3D UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> > +     payload[0] =3D cpu_to_be32(payload[0]);
> > +     payload[1] =3D cpu_to_be32(payload[1]);
> > +
> > +     memset(resp, 0, sizeof(resp));
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> > +                          resp, UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /* Set host Config Setting registers */
> > +     err =3D host->ops->uhs2_control(host, UHS2_SET_CONFIG);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(ho=
st), __func__);
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sd_uhs2_go_dormant(struct mmc_host *host, u32 node_id)
> > +{
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u16 header, arg;
> > +     __be32 payload[1];
> > +     int err;
> > +
> > +     /* Disable Normal INT */
> > +     err =3D host->ops->uhs2_control(host, UHS2_DISABLE_INT);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> > +                    mmc_hostname(host), __func__);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Refer to UHS-II Addendum Version 1.02 Figure 6-17 to see GO_DO=
RMANT_STATE CCMD format.
> > +      * Header:
> > +      *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> > +      *      - IOADR =3D CMD_BASE + 001h
> > +      * Payload:
> > +      *      - bit [7]: HBR(Entry to Hibernate Mode)
> > +      *                 1: Host intends to enter Hibernate mode during=
 Dormant state.
> > +      *                 The default setting is 0 because hibernate is =
currently not supported.
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> > +     arg =3D ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> > +             UHS2_NATIVE_CMD_WRITE |
> > +             UHS2_NATIVE_CMD_PLEN_4B |
> > +             (UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
GO_DORMANT_PAYLOAD_LEN,
> > +                          NULL, 0);
> > +
> > +     err =3D mmc_wait_for_cmd(host, &cmd, 0);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /* Check Dormant State in Present */
> > +     err =3D host->ops->uhs2_control(host, UHS2_CHECK_DORMANT);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Disable UHS2 card clock */
> > +     err =3D host->ops->uhs2_control(host, UHS2_DISABLE_CLK);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Restore sd clock */
> > +     mmc_delay(5);
> > +     err =3D host->ops->uhs2_control(host, UHS2_ENABLE_CLK);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Enable Normal INT */
> > +     err =3D host->ops->uhs2_control(host, UHS2_ENABLE_INT);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Detect UHS2 */
> > +     err =3D host->ops->uhs2_control(host, UHS2_PHY_INIT);
> > +     if (err)
> > +             return err;
> > +
> >       return 0;
> >  }
> >
> > -/*
> > - * Initialize the UHS-II card through the SD-TRAN transport layer. Thi=
s enables
> > - * commands/requests to be backwards compatible through the legacy SD =
protocol.
> > - * UHS-II cards has a specific power limit specified for VDD1/VDD2, th=
at should
> > - * be set through a legacy CMD6. Note that, the power limit that becom=
es set,
> > - * survives a soft reset through the GO_DORMANT_STATE command.
> > - */
> > -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card =
*card)
> > +static int __sd_uhs2_wait_active_state_cb(void *cb_data, bool *busy)
> >  {
> > +     struct sd_uhs2_wait_active_state_data *data =3D cb_data;
> > +     struct mmc_host *host =3D data->host;
> > +     struct mmc_command *cmd =3D data->cmd;
> > +     int err;
> > +
> > +     err =3D mmc_wait_for_cmd(host, cmd, 0);
> > +     if (err)
> > +             return err;
> > +
> > +     if (cmd->resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
> > +             *busy =3D false;
> > +     else
> > +             *busy =3D true;
> > +
> >       return 0;
> >  }
> >
> > +static int sd_uhs2_go_dormant_state(struct mmc_host *host, u32 node_id=
)
> > +{
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     u16 header, arg;
> > +     int err;
> > +     struct sd_uhs2_wait_active_state_data cb_data =3D {
> > +             .host =3D host,
> > +             .cmd =3D &cmd
> > +     };
> > +
> > +     err =3D sd_uhs2_go_dormant(host, node_id);
> > +     if (err) {
> > +             pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err=3D 0x%x!\=
n",
> > +                    mmc_hostname(host), __func__, err);
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Use Control Read CCMD to check Config Completion(bit 63) in Ge=
neric Setting Register.
> > +      * - Control Read(R/W=3D0) with 8-Byte payload(PLEN=3D10b).
> > +      * - IOADR =3D Generic Setting Register(CFG_BASE + 008h)
> > +      *
> > +      * When UHS-II card been switched to new speed mode, it will set =
Config Completion to 1.
> > +      */
> > +     header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> > +     arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +             UHS2_NATIVE_CMD_READ |
> > +             UHS2_NATIVE_CMD_PLEN_8B |
> > +             (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> > +     err =3D __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_U=
S,
> > +                               UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
> > +                               &__sd_uhs2_wait_active_state_cb, &cb_da=
ta);
> > +     if (err) {
> > +             pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_ho=
stname(host), __func__);
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void sd_uhs2_remove(struct mmc_host *host)
> > +{
> > +     mmc_remove_card(host->card);
> > +     host->card =3D NULL;
> > +}
> > +
> >  /*
> >   * Allocate the data structure for the mmc_card and run the UHS-II spe=
cific
> >   * initialization sequence.
> >   */
> > -static int sd_uhs2_init_card(struct mmc_host *host)
> > +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *o=
ldcard)
> >  {
> >       struct mmc_card *card;
> >       u32 node_id;
> > @@ -133,9 +834,14 @@ static int sd_uhs2_init_card(struct mmc_host *host=
)
> >       if (err)
> >               return err;
> >
> > -     card =3D mmc_alloc_card(host, &sd_type);
> > -     if (IS_ERR(card))
> > -             return PTR_ERR(card);
> > +     if (oldcard) {
> > +             card =3D oldcard;
> > +     } else {
> > +             card =3D mmc_alloc_card(host, &sd_type);
> > +             if (IS_ERR(card))
> > +                     return PTR_ERR(card);
> > +     }
> > +     host->card =3D card;
> >
> >       card->uhs2_config.node_id =3D node_id;
> >       card->type =3D MMC_TYPE_SD;
> > @@ -148,18 +854,226 @@ static int sd_uhs2_init_card(struct mmc_host *ho=
st)
> >       if (err)
> >               goto err;
> >
> > -     host->card =3D card;
> > +     /* If change speed to Range B, need to GO_DORMANT_STATE */
> > +     if (host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> > +             err =3D sd_uhs2_go_dormant_state(host, node_id);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     host->flags |=3D MMC_UHS2_SD_TRAN;
> > +
> >       return 0;
> >
> >  err:
> > -     mmc_remove_card(card);
> > +     sd_uhs2_remove(host);
> >       return err;
> >  }
> >
> > -static void sd_uhs2_remove(struct mmc_host *host)
> > +int sd_uhs2_reinit(struct mmc_host *host)
> >  {
> > -     mmc_remove_card(host->card);
> > -     host->card =3D NULL;
> > +     struct mmc_card *card =3D host->card;
> > +     int err;
> > +
> > +     sd_uhs2_power_up(host);
> > +     err =3D sd_uhs2_phy_init(host);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D sd_uhs2_init_card(host, card);
> > +     if (err)
> > +             return err;
> > +
> > +     mmc_card_set_present(card);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Mask off any voltages we don't support and select
> > + * the lowest voltage
> > + */
> > +u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)
> > +{
> > +     int bit;
> > +     int err;
> > +
> > +     /*
> > +      * Sanity check the voltages that the card claims to
> > +      * support.
> > +      */
> > +     if (ocr & 0x7F) {
> > +             dev_warn(mmc_dev(host), "card claims to support voltages =
below defined range\n");
> > +             ocr &=3D ~0x7F;
> > +     }
> > +
> > +     ocr &=3D host->ocr_avail;
> > +     if (!ocr) {
> > +             dev_warn(mmc_dev(host), "no support for card's volts\n");
> > +             return 0;
> > +     }
> > +
> > +     if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> > +             bit =3D ffs(ocr) - 1;
> > +             ocr &=3D 3 << bit;
> > +             /* Power cycle */
> > +             err =3D sd_uhs2_power_off(host);
> > +             if (err)
> > +                     return 0;
> > +             err =3D sd_uhs2_reinit(host);
> > +             if (err)
> > +                     return 0;
> > +     } else {
> > +             bit =3D fls(ocr) - 1;
> > +             ocr &=3D 3 << bit;
> > +             if (bit !=3D host->ios.vdd)
> > +                     dev_warn(mmc_dev(host), "exceeding card's volts\n=
");
> > +     }
> > +
> > +     return ocr;
> > +}
> > +
> > +/*
> > + * Initialize the UHS-II card through the SD-TRAN transport layer. Thi=
s enables
> > + * commands/requests to be backwards compatible through the legacy SD =
protocol.
> > + * UHS-II cards has a specific power limit specified for VDD1/VDD2, th=
at should
> > + * be set through a legacy CMD6. Note that, the power limit that becom=
es set,
> > + * survives a soft reset through the GO_DORMANT_STATE command.
> > + */
> > +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card =
*card)
> > +{
> > +     int err;
> > +     u32 cid[4];
> > +     u32 ocr;
> > +     u32 rocr;
> > +     u8  *status;
> > +     int ro;
> > +
> > +     /* Send CMD0 to reset SD card */
> > +     err =3D __mmc_go_idle(host);
> > +     if (err)
> > +             return err;
> > +
> > +     mmc_delay(1);
> > +
> > +     /* Send CMD8 to communicate SD interface operation condition */
> > +     err =3D mmc_send_if_cond(host, host->ocr_avail);
> > +     if (err) {
> > +             dev_warn(mmc_dev(host), "CMD8 error\n");
> > +             goto err;
> > +     }
> > +
> > +     /*
> > +      * Probe SD card working voltage.
> > +      */
> > +     err =3D mmc_send_app_op_cond(host, 0, &ocr);
> > +     if (err)
> > +             goto err;
> > +
> > +     card->ocr =3D ocr;
> > +
> > +     /*
> > +      * Some SD cards claims an out of spec VDD voltage range. Let's t=
reat
> > +      * these bits as being in-valid and especially also bit7.
> > +      */
> > +     ocr &=3D ~0x7FFF;
> > +     rocr =3D sd_uhs2_select_voltage(host, ocr);
> > +     /*
> > +      * Some cards have zero value of rocr in UHS-II mode. Assign host=
's
> > +      * ocr value to rocr.
> > +      */
> > +     if (!rocr)
> > +             rocr =3D host->ocr_avail;
> > +
> > +     rocr |=3D (SD_OCR_CCS | SD_OCR_XPC);
> > +
> > +     /* Wait SD power on ready */
> > +     ocr =3D rocr;
> > +
> > +     err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> > +     if (err)
> > +             goto err;
> > +
> > +     err =3D mmc_send_cid(host, cid);
> > +     if (err)
> > +             goto err;
> > +
> > +     memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> > +     mmc_decode_cid(card);
> > +
> > +     /*
> > +      * For native busses:  get card RCA and quit open drain mode.
> > +      */
> > +     err =3D mmc_send_relative_addr(host, &card->rca);
> > +     if (err)
> > +             goto err;
> > +
> > +     err =3D mmc_sd_get_csd(card);
> > +     if (err)
> > +             goto err;
> > +
> > +     /*
> > +      * Select card, as all following commands rely on that.
> > +      */
> > +     err =3D mmc_select_card(card);
> > +     if (err)
> > +             goto err;
> > +
> > +     /*
> > +      * Fetch SCR from card.
> > +      */
> > +     err =3D mmc_app_send_scr(card);
> > +     if (err)
> > +             goto err;
> > +
> > +     err =3D mmc_decode_scr(card);
> > +     if (err)
> > +             goto err;
> > +
> > +     /*
> > +      * Switch to high power consumption mode.
> > +      * Even switch failed, sd card can still work at lower power cons=
umption mode, but
> > +      * performance will be lower than high power consumption mode.
> > +      */
> > +     status =3D kmalloc(64, GFP_KERNEL);
> > +     if (!status)
> > +             return -ENOMEM;
> > +
> > +     if (!(card->csd.cmdclass & CCC_SWITCH)) {
> > +             pr_warn("%s: card lacks mandatory switch function, perfor=
mance might suffer\n",
> > +                     mmc_hostname(card->host));
> > +     } else {
> > +             /* send CMD6 to set Maximum Power Consumption to get bett=
er performance */
> > +             err =3D mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1_8=
0W, status);
> > +             if (!err)
> > +                     err =3D mmc_sd_switch(card, 1, 3, SD4_SET_POWER_L=
IMIT_1_80W, status);
> > +
> > +             err =3D 0;
> > +     }
> > +
> > +     /*
> > +      * Check if read-only switch is active.
> > +      */
> > +     ro =3D mmc_sd_get_ro(host);
> > +     if (ro < 0) {
> > +             pr_warn("%s: host does not support read-only switch, assu=
ming write-enable\n",
> > +                     mmc_hostname(host));
> > +     } else if (ro > 0) {
> > +             mmc_card_set_readonly(card);
> > +     }
> > +
> > +     /*
> > +      * NOTE:
> > +      * Should we read Externsion Register to check power notification=
 feature here?
> > +      */
> > +
> > +     kfree(status);
> > +
> > +     return 0;
> > +
> > +err:
> > +     sd_uhs2_remove(host);
> > +     return err;
> >  }
> >
> >  static int sd_uhs2_alive(struct mmc_host *host)
> > @@ -181,38 +1095,181 @@ static void sd_uhs2_detect(struct mmc_host *hos=
t)
> >               mmc_claim_host(host);
> >               mmc_detach_bus(host);
> >               sd_uhs2_power_off(host);
> > +             host->flags &=3D ~MMC_UHS2_SUPPORT;
> >               mmc_release_host(host);
> >       }
> >  }
> >
> > +static int _sd_uhs2_suspend(struct mmc_host *host)
> > +{
> > +     struct mmc_card *card =3D host->card;
> > +     int err =3D 0;
> > +
> > +     mmc_claim_host(host);
> > +
> > +     if (mmc_card_suspended(card))
> > +             goto out;
> > +
> > +     if (mmc_sd_can_poweroff_notify(card))
> > +             err =3D sd_poweroff_notify(card);
> > +
> > +     if (!err) {
> > +             sd_uhs2_power_off(host);
> > +             mmc_card_set_suspended(card);
> > +     }
> > +
> > +out:
> > +     mmc_release_host(host);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Callback for suspend
> > + */
> >  static int sd_uhs2_suspend(struct mmc_host *host)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     err =3D _sd_uhs2_suspend(host);
> > +     if (!err) {
> > +             pm_runtime_disable(&host->card->dev);
> > +             pm_runtime_set_suspended(&host->card->dev);
> > +     }
> > +
> > +     return err;
> >  }
> >
> > +/*
> > + * This function tries to determine if the same card is still present
> > + * and, if so, restore all state to it.
> > + */
> > +static int _mmc_sd_uhs2_resume(struct mmc_host *host)
> > +{
> > +     int err =3D 0;
> > +
> > +     mmc_claim_host(host);
> > +
> > +     if (!mmc_card_suspended(host->card))
> > +             goto out;
> > +
> > +     /* Power up UHS2 SD card and re-initialize it. */
> > +     err =3D sd_uhs2_reinit(host);
> > +     mmc_card_clr_suspended(host->card);
> > +
> > +out:
> > +     mmc_release_host(host);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Callback for resume
> > + */
> >  static int sd_uhs2_resume(struct mmc_host *host)
> >  {
> > +     pm_runtime_enable(&host->card->dev);
> >       return 0;
> >  }
> >
> > +/*
> > + * Callback for runtime_suspend.
> > + */
> >  static int sd_uhs2_runtime_suspend(struct mmc_host *host)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> > +             return 0;
> > +
> > +     err =3D _sd_uhs2_suspend(host);
> > +     if (err)
> > +             pr_err("%s: error %d doing aggressive suspend\n", mmc_hos=
tname(host), err);
> > +
> > +     return err;
> >  }
> >
> >  static int sd_uhs2_runtime_resume(struct mmc_host *host)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     err =3D _mmc_sd_uhs2_resume(host);
> > +     if (err && err !=3D -ENOMEDIUM)
> > +             pr_err("%s: error %d doing runtime resume\n", mmc_hostnam=
e(host), err);
> > +
> > +     return err;
> >  }
> >
> > -static int sd_uhs2_shutdown(struct mmc_host *host)
> > +static int sd_uhs2_hw_reset(struct mmc_host *host)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     sd_uhs2_power_off(host);
> > +     /* Wait at least 1 ms according to SD spec */
> > +     mmc_delay(1);
> > +     sd_uhs2_power_up(host);
> > +
> > +     err =3D sd_uhs2_reinit(host);
> > +
> > +     return err;
> >  }
> >
> > -static int sd_uhs2_hw_reset(struct mmc_host *host)
> > +/*
> > + * mmc_uhs2_prepare_cmd - prepare for SD command packet
> > + * @host:    MMC host
> > + * @mrq:     MMC request
> > + *
> > + * Initialize and fill in a header and a payload of SD command packet.
> > + * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
> > + * advance.
> > + *
> > + * Return:   0 on success, non-zero error on failure
> > + */
> > +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *m=
rq)
> >  {
> > -     return 0;
> > +     struct mmc_command *cmd;
> > +     struct uhs2_command *uhs2_cmd;
> > +     u16 header, arg;
> > +     __be32 *payload;
> > +     u8 plen;
> > +
> > +     cmd =3D mrq->cmd;
> > +     header =3D host->card->uhs2_config.node_id;
> > +     if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> > +             header |=3D UHS2_PACKET_TYPE_DCMD;
> > +     else
> > +             header |=3D UHS2_PACKET_TYPE_CCMD;
> > +
> > +     arg =3D cmd->opcode << UHS2_SD_CMD_INDEX_POS;
> > +     if (host->uhs2_app_cmd) {
> > +             arg |=3D UHS2_SD_CMD_APP;
> > +             host->uhs2_app_cmd =3D false;
> > +     }
> > +
> > +     uhs2_cmd =3D cmd->uhs2_cmd;
> > +     payload =3D uhs2_cmd->payload;
> > +     plen =3D 2; /* at the maximum */
> > +
> > +     if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC &&
> > +         !cmd->uhs2_tmode0_flag) {
> > +             if (mmc_card_uhs2_hd_mode(host))
> > +                     arg |=3D UHS2_DCMD_2L_HD_MODE;
> > +
> > +             arg |=3D UHS2_DCMD_LM_TLEN_EXIST;
> > +
> > +             if (cmd->data->blocks =3D=3D 1 &&
> > +                 cmd->data->blksz !=3D 512 &&
> > +                 cmd->opcode !=3D MMC_READ_SINGLE_BLOCK &&
> > +                 cmd->opcode !=3D MMC_WRITE_BLOCK) {
> > +                     arg |=3D UHS2_DCMD_TLUM_BYTE_MODE;
> > +                     payload[1] =3D cpu_to_be32(cmd->data->blksz);
> > +             } else {
> > +                     payload[1] =3D cpu_to_be32(cmd->data->blocks);
> > +             }
> > +     } else {
> > +             plen =3D 1;
> > +     }
> > +
> > +     payload[0] =3D cpu_to_be32(cmd->arg);
> > +     sd_uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, N=
ULL, 0);
> >  }
> >
> >  static const struct mmc_bus_ops sd_uhs2_ops =3D {
> > @@ -223,7 +1280,7 @@ static const struct mmc_bus_ops sd_uhs2_ops =3D {
> >       .resume =3D sd_uhs2_resume,
> >       .runtime_suspend =3D sd_uhs2_runtime_suspend,
> >       .runtime_resume =3D sd_uhs2_runtime_resume,
> > -     .shutdown =3D sd_uhs2_shutdown,
> > +     .shutdown =3D sd_uhs2_suspend,
> >       .hw_reset =3D sd_uhs2_hw_reset,
> >  };
> >
> > @@ -231,6 +1288,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >  {
> >       int err;
> >
> > +     host->flags |=3D MMC_UHS2_SUPPORT;
> > +
> >       err =3D sd_uhs2_power_up(host);
> >       if (err)
> >               goto err;
> > @@ -239,7 +1298,7 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >       if (err)
> >               goto err;
> >
> > -     err =3D sd_uhs2_init_card(host);
> > +     err =3D sd_uhs2_init_card(host, NULL);
> >       if (err)
> >               goto err;
> >
> > @@ -256,21 +1315,32 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >               goto remove_card;
> >
> >       mmc_claim_host(host);
> > +
> >       return 0;
> >
> >  remove_card:
> > -     mmc_remove_card(host->card);
> > -     host->card =3D NULL;
> > +     sd_uhs2_remove(host);
> >       mmc_claim_host(host);
> > -     mmc_detach_bus(host);
> > +
> >  err:
> > +     mmc_detach_bus(host);
> >       sd_uhs2_power_off(host);
> > +     host->flags &=3D ~MMC_UHS2_SUPPORT;
> >       return err;
> >  }
> >
> > +/**
> > + * mmc_attach_sd_uhs2 - select UHS2 interface
> > + * @host: MMC host
> > + *
> > + * Try to select UHS2 interface and initialize the bus for a given
> > + * frequency, @freq.
> > + *
> > + * Return:   0 on success, non-zero error on failure
> > + */
> >  int mmc_attach_sd_uhs2(struct mmc_host *host)
> >  {
> > -     int i, err =3D 0;
> > +     int i, err;
> >
> >       if (!(host->caps2 & MMC_CAP2_SD_UHS2))
> >               return -EOPNOTSUPP;
> > @@ -285,6 +1355,9 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
> >        */
> >       for (i =3D 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
> >               host->f_init =3D sd_uhs2_freqs[i];
> > +             pr_info("%s: %s: trying to init UHS-II card at %u Hz\n",
> > +                     mmc_hostname(host), __func__, host->f_init);
> > +
> >               err =3D sd_uhs2_attach(host);
> >               if (!err)
> >                       break;
>

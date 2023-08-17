Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAB77F8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351892AbjHQO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbjHQO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:28:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B930D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:28:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d71dd633f33so1550815276.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692282487; x=1692887287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NaupTWI/Oiy2eEHAZE/E9VQG8R3FhrXGlp5E0Y4f/nk=;
        b=c+gwiGRBhhnjSqGeVnjyJ4Rxa3GP9phSqYiZBO/1R2eq9o1RanaoTN36mfOpic2R/K
         SVMrxUvPBUkYcj7HG62U8rLHEwzNYqIKtO5br8uudx1vJi+7ABBMnphpeNuU7dH+6go1
         e7c8YNabo3HoDwLR1cJa9auhISxxHlyUrTvbuEG2zwjluLA9YUVFqUMMHXM3ky19LrXI
         bri5ERDGwvvMuhha9VBPNnxu49o1C8LzPNmFnMz/BMAevtz8M+Dbg8FOq9+EpK9tR9TS
         fmYwfjz7nIFmCo+G0l9x9SG03ewnxMfXiYImQyhUGZiGX/AtMrOLizX7cOdr1YBtRY1S
         F2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692282487; x=1692887287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaupTWI/Oiy2eEHAZE/E9VQG8R3FhrXGlp5E0Y4f/nk=;
        b=NxhnCXY40BnibS0ebHb7KJlAR3wnQMeru+hLQ5vckxsftaVwatzKc70SLyL7uN/LwI
         ziUHyKeS7vGJyiQug6YLJwrtntJpa7cp5/n159ktuaM6c/E+jj85NzUwA2SAf18vT9A6
         LtJlLTRgI2BccuMfvakgQVbGmvxesIZaTMEevwO2v7lASraTI5cSnGowZXyQ4milq6CY
         3g/Ya/oDedP3CqspmZFcOYtsw9aZFxzU9v3HBPJ+HqdBZrJBbzLDhQIxGu6j45rLybvO
         I7PW6df9nnxJYFd882N2E4mms4iVFz3ykaGYXQNgoZehAIB/1qoz/bhuyy4VBmNSb5G9
         YLiw==
X-Gm-Message-State: AOJu0Ywm6g/fK4AcDoIr4mP1SXELhXtcOrFX39/n9twLW349Pqp4/XON
        OTwFG69xI2M5ejoIPc+GHM7gBijT5WLOIUMHZ25uC+LZL7iVxR56r1k=
X-Google-Smtp-Source: AGHT+IHhBIJjYRhGfcsRwIvLRq/73N/Q49LKr3t8Gqnow2SPn60O83+zYF/dZvSPdFhNAzr60KfyCvBg1Uv9JEg3hKY=
X-Received: by 2002:a5b:e8f:0:b0:d49:bfe4:9c50 with SMTP id
 z15-20020a5b0e8f000000b00d49bfe49c50mr4878586ybr.18.1692282486439; Thu, 17
 Aug 2023 07:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230816114712.25093-1-ulf.hansson@linaro.org> <DM6PR04MB65759A72284F94585D19A3F5FC1AA@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65759A72284F94585D19A3F5FC1AA@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Aug 2023 16:27:30 +0200
Message-ID: <CAPDyKFoM3EsiYvhUkBA6c=K80UGUVL7J0qvNQ12C3_AckU-Pkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix error propagation for some ioctl commands
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 12:03, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > Userspace has currently has no way of checking the internal R1 response
> > error bits for some commands. This is a problem for some commands, like
> > RPMB for example. Typically, we may detect that the busy completion
> > successfully has ended, while in fact the card did not complete the
> > requested operation.
> >
> > To fix the problem, let's always poll with CDM13 for these commands and
> > during the polling aggregate the R1 response bits. Before completing the
> > ioctl request, let's propagate the R1 response bits too.
> >
> > Cc: Avri Altman <avri.altman@wdc.com>
> > Co-developed-by: Christian Loehle <CLoehle@hyperstone.com>
> > Signed-off-by: Christian Loehle <CLoehle@hyperstone.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks!

>
> See nit below.
> Thanks,
> Avri
>
> > ---
> >
> > Christian, I took the liberty of re-working your previous patch [1]. But rather
> > than keeping your authorship I added you as a co-developer. Please tell me
> > if you prefer differently.
> >
> > Kind regards
> > Uffe
> >
> > [1]
> > https://lore.kernel.org/all/26d178dcfc2f4b7d9010145d0c051394@hypersto
> > ne.com/
> >
> > ---
> >  drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > b6f4be25b31b..62a8aacc996c 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -179,6 +179,7 @@ static void mmc_blk_rw_rq_prep(struct
> > mmc_queue_req *mqrq,
> >                                struct mmc_queue *mq);  static void
> > mmc_blk_hsq_req_done(struct mmc_request *mrq);  static int
> > mmc_spi_err_check(struct mmc_card *card);
> > +static int mmc_blk_busy_cb(void *cb_data, bool *busy);
> >
> >  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)  { @@ -
> > 470,7 +471,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,
> > struct mmc_blk_data *md,
> >         struct mmc_data data = {};
> >         struct mmc_request mrq = {};
> >         struct scatterlist sg;
> > -       bool r1b_resp, use_r1b_resp = false;
> > +       bool r1b_resp;
> >         unsigned int busy_timeout_ms;
> >         int err;
> >         unsigned int target_part;
> > @@ -551,8 +552,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> >         busy_timeout_ms = idata->ic.cmd_timeout_ms ? :
> > MMC_BLK_TIMEOUT_MS;
> >         r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
> >         if (r1b_resp)
> > -               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> > -                                                   busy_timeout_ms);
> > +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
> >
> >         mmc_wait_for_req(card->host, &mrq);
> >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp)); @@ -605,19
> > +605,28 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > mmc_blk_data *md,
> >         if (idata->ic.postsleep_min_us)
> >                 usleep_range(idata->ic.postsleep_min_us, idata-
> > >ic.postsleep_max_us);
> >
> > -       /* No need to poll when using HW busy detection. */
> > -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
> > use_r1b_resp)
> > -               return 0;
> > -
> >         if (mmc_host_is_spi(card->host)) {
> >                 if (idata->ic.write_flag || r1b_resp || cmd.flags &
> > MMC_RSP_SPI_BUSY)
> >                         return mmc_spi_err_check(card);
> >                 return err;
> >         }
> > -       /* Ensure RPMB/R1B command has completed by polling with CMD13.
> > */
> > -       if (idata->rpmb || r1b_resp)
> > -               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> > -                                       MMC_BUSY_IO);
> > +
> > +       /*
> > +        * Ensure RPMB, writes and R1B responses are completed by polling
> > with
> > +        * CMD13. Note that, usually we don't need to poll when using HW busy
> > +        * detection, but here it's needed since some commands may indicate
> > the
> > +        * error through the R1 status bits.
> > +        */
> > +       if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
> > +               struct mmc_blk_busy_data cb_data;
> > +
> > +               cb_data.card = card;
> > +               cb_data.status = 0;
> > +               err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
> > +                                         &mmc_blk_busy_cb, &cb_data);
> Maybe we can pack those 3 lines in an inline handler - they seems to appear a couple of times more.

You have a point, but I suggest we consider that as a potential
clean-up on top. However, I should probably update the declaration of
the struct to:

struct mmc_blk_busy_data cb_data = {
     .card = card,
     .status = 0,
};

Maybe this is a sufficient improvement?

Kind regards
Uffe

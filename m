Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B791773D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjHHQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjHHQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:18:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A396E96
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:48:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f090310dso5775842b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509717; x=1692114517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGTcjaNgQeCn9VPexlocoRK+VXPMuKSU5jYkurM+34o=;
        b=hp3vmgXwDcJ4itOil3dqSFg7AAlFH/zJliOLeOhWteik8kf+D+EFsAM3CQOOF6Z12V
         bAGZvmcMvn7ca7Aybgbr5Hj7ejeHiyAJdkwoqBDBsmin8toJOcKd51sVPYUi7FjSOxQl
         pN+jAR8vF0z29YqSB6GKMjaLY4ClvgEC7VB5IAd2WTepYQbb6yU9pROBrPAovQ6ooV3O
         8ljmqUwIz+kOALNJazD90LDE2AXMs1hadcwG7cVGF6XWu3gv8LyMNI8nRbbvTUkK9X0c
         JxS4XfjNyruTVCTg4d7bfe1d5qKAMXZXlEaoVkS3R4DpVJn75B/JbmrKmkDVzRyhAZgc
         UqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509717; x=1692114517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGTcjaNgQeCn9VPexlocoRK+VXPMuKSU5jYkurM+34o=;
        b=HaftLor08FuizBA6piDW83RFsGd3y+QWQcF+DkrzS+9V+F8tXCVt/f9oQPSjOkGDGm
         Cx74WvaGNyaCh2MK0CkIC5ju3EvAOySy91+54x9XSLPtY2LX41Pe5Kl8TMt2J2emFVpT
         Auc6bfBfKQFnuzvoEXh9L17WYrOPhyepdsFCnI6Lj6wi8+jiXuhGvx0W3Imc+yinsr1N
         WIwQbYnN2k2cI0c0/IOiGKaxgLh9xT//3W44KL1l2wyABvnUYl/nETyX8BBgG/ewRgq0
         oxcbC3hE7KO1YTG++E2Rva5K+bHIKWOFp5OxoxdRryVjxw9kRaXJ5qNK7zzMbOoqRUki
         tbXQ==
X-Gm-Message-State: AOJu0YwRXKBdeN33+FRVAvLkq5uYCw5Q8nNb3ycOTh80x+rUV/FRz8bq
        JRzeIMuw3uRqtysIO2D+BXu4wTr+RDejhNab88dtKwTQaSzhB6qFkhw=
X-Google-Smtp-Source: AGHT+IGgI3ekSRcP/gEkmhv4tIppC5Z34hrN/37U/8yADt4ORB/JnQim1/yRu/2+2QA92n6LMekN+28s2hYwn5+JOnI=
X-Received: by 2002:a25:ce41:0:b0:d4b:2775:b0d6 with SMTP id
 x62-20020a25ce41000000b00d4b2775b0d6mr6954452ybe.4.1691502510333; Tue, 08 Aug
 2023 06:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-7-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-7-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 15:47:54 +0200
Message-ID: <CAPDyKFoCXyHs4ujrQY3iphQG7GwkKLgAxEPPF6gAxoV7u2oxFQ@mail.gmail.com>
Subject: Re: [PATCH V9 06/23] mmc: core: Support UHS-II card control and access
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Embed UHS-II access/control functionality into the MMC request
> processing flow.

This deserves to be extended a bit. There is quite some code being
added in the $subject patch.

>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V8:
>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>  - Modify return value in sd_uhs2_attach().
>
> Updates in V7:
>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
>  - Drop uhs2_state in favor of ios->timing.
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/core/block.c   |   18 +-
>  drivers/mmc/core/core.c    |    8 +
>  drivers/mmc/core/mmc_ops.c |   25 +-
>  drivers/mmc/core/mmc_ops.h |    1 +
>  drivers/mmc/core/sd.c      |   13 +-
>  drivers/mmc/core/sd.h      |    4 +
>  drivers/mmc/core/sd_ops.c  |   11 +
>  drivers/mmc/core/sd_ops.h  |   18 +
>  drivers/mmc/core/sd_uhs2.c | 1137 +++++++++++++++++++++++++++++++++++-
>  9 files changed, 1176 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..6617ae9fc840 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -918,15 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>
>         struct scatterlist sg;
>
> -       cmd.opcode = MMC_APP_CMD;
> -       cmd.arg = card->rca << 16;
> -       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> -
> -       err = mmc_wait_for_cmd(card->host, &cmd, 0);
> -       if (err)
> -               return err;
> -       if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
> -               return -EIO;
> +       err = mmc_app_cmd(card->host, card);
> +               if (err)
> +                       return err;
>
>         memset(&cmd, 0, sizeof(struct mmc_command));

The entire chunk of change above deserves its own separate
cleanup-patch. If you want to send it separately I can apply
immediately - or if you decide to make it part of the series then it
should precede the $subject patch.

Note that, after the cleanup above, the call to memset() can be dropped too.

>
> @@ -1612,6 +1606,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,

I commented on the changes in mmc_blk_rw_rq_prep() already in version
6 [1] - but it seems like you haven't addressed my comments yet.

I have therefore copied the similar comment again, see below.

>         struct request *req = mmc_queue_req_to_req(mqrq);
>         struct mmc_blk_data *md = mq->blkdata;
>         bool do_rel_wr, do_data_tag;
> +       bool do_multi;
> +
> +       do_multi = (card->host->flags & MMC_UHS2_SD_TRAN) ? true : false;
>
>         mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
>
> @@ -1622,7 +1619,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 brq->cmd.arg <<= 9;
>         brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>
> -       if (brq->data.blocks > 1 || do_rel_wr) {
> +       if (brq->data.blocks > 1 || do_rel_wr || do_multi) {

This looks wrong to me. UHS2 can use single block read/writes too. Right?

>                 /* SPI multiblock writes terminate using a special
>                  * token, not a STOP_TRANSMISSION request.
>                  */
> @@ -1635,6 +1632,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 brq->mrq.stop = NULL;
>                 readcmd = MMC_READ_SINGLE_BLOCK;
>                 writecmd = MMC_WRITE_BLOCK;
> +               brq->cmd.uhs2_tmode0_flag = 1;
>         }

As "do_multi" is always set for UHS2, setting this flag here seems to
be wrong/redundant.

Anyway, if I understand correctly, the flag is intended to be used to
inform the host driver whether the so-called 2L_HD_mode (half-duplex
or full-duplex) should be used for the I/O request or not. Did I
understand this correctly?

To fix the above behaviour, I suggest we try to move the entire
control of the flag into mmc_uhs2_prepare_cmd(). It seems like we need
the flag to be set for multi block read/writes (CMD18 and CMD25), but
only if the host and card supports the 2L_HD_mode too, right?

According to my earlier suggestions, we should also be able to check
the 2L_HD_mode via the bits we have set in the ios->timing, no?

Moreover, by making mmc_uhs2_prepare_cmd() responsible for setting the
flag, we can move the definition of the flag into the struct
uhs2_command instead. While at it, I suggest we also rename the flag
into "tmode_half_duplex", to better describe its purpose. Note that,
this also means the interpretation of the flag becomes inverted.

>         brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
>

Until we have agreed on how to move forward with the above, I am
temporarily pausing further review.

[...]

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-mmc/CAPDyKFoV3Ch-xzXxiT2RnDeLvsO454Pwq1vQL_bdNLptM+amAg@mail.gmail.com/

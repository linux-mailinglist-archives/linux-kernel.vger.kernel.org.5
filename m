Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0107BBCB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjJFQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJFQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:28:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE7B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:28:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8195078f69so2545962276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696609722; x=1697214522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh4GGedo7YojHSRu9rFDczOjBdHg0mdeUfOuTMsUVSs=;
        b=VBiUdPQgveXsHfovdt4H+RAGl7ZBZwT6ANQGwdGrb17kb1gI06DXjv0EWPvEXIXFiR
         Gb3U/nwwMdcyfDrqyqlMInYeBULet233hfKLrWFlNPUlJFHeAAOvLsl0eYVpqOY5fO0g
         Z6TuT32lk+KtTyw6Cd8e+ZpFjjYeYv0gPDk8pCZQdgtIVX6SbNE0QoHw4xMwNNtjQJNE
         u18rjjULntpjEi0oAJJxWL2yDeYJH6lqTrunoF7/EWc5tDICrUzjzs765QvUVY/Gwiqy
         kx8Tft6PbTKAEWcBnsBBL/a/fB55aM2kxkzFCpLv/n5w1+0qO8AxtLlGy00kOHpMHYwu
         dR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696609722; x=1697214522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh4GGedo7YojHSRu9rFDczOjBdHg0mdeUfOuTMsUVSs=;
        b=FW8Mmo6EgSXtcY1wIQUaLbccsSHtX6LulSQgCgOa6dqcEJejLmeoqqF/gE12U1EazH
         ZE1XtwbfZiaM/lZ3r1b3tN3RfKFSQr0zJ/CxK0/bal20M5H/QkKi/B/GJvQgMVEJpbnl
         irHWjTJGqaGE6ABNBcKeoBTldeVYsTMjMwjffjCWsVVPwsOU+vRoFDDY4FVCmRL3EyZw
         Id9P+n259B+ezF4mJlnctlu7Sg+nsnIdPPZSGsOsLERsxw8P+LKA+ZTtFzItIPS/G7JH
         fBfz16BMz4u5lRDrUrL9VmHgYxTSK95Gslq3zgxsnWDqqhhRJ6BIe1+xizkrafXZ17ZB
         siaw==
X-Gm-Message-State: AOJu0YzZfB0G2/sGDg2ACfJKzc7gkAWkwUaI6F3ByP50iL5NLFi2veQL
        39rVz38wFzz8d574D8bEbW3xF9JOSJKmqyXREfPv5g==
X-Google-Smtp-Source: AGHT+IEC7Z7wKjj1TRuMv4cPEDEKCmw5fJrgKUONzbWoh5pP+GharDKDw0Sq0b0PyCOD/+vO3WeonEirlbTmZv2SL7U=
X-Received: by 2002:a05:6902:1003:b0:d78:179a:eb33 with SMTP id
 w3-20020a056902100300b00d78179aeb33mr10030222ybt.17.1696609721889; Fri, 06
 Oct 2023 09:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-7-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-7-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Oct 2023 18:28:05 +0200
Message-ID: <CAPDyKFraAnOQ_u+a9gb7PKTqSnNnXkUz3xpcuHQmX3vY68O10A@mail.gmail.com>
Subject: Re: [PATCH V12 06/23] mmc: core: Support UHS-II card control and access
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Embed UHS-II access/control functionality into the MMC request
> processing flow.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V12:
>  - Use mmc_op_multi() to check DCMD which supports multi read/write
>    in mmc_uhs2_prepare_cmd().
>
> Updates in V10:
>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
>  - Drop do_multi in the mmc_blk_rw_rq_prep().
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
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
>  drivers/mmc/core/core.c    |    8 +
>  drivers/mmc/core/mmc_ops.c |   24 +-
>  drivers/mmc/core/mmc_ops.h |    1 +
>  drivers/mmc/core/sd.c      |   13 +-
>  drivers/mmc/core/sd.h      |    4 +
>  drivers/mmc/core/sd_ops.c  |    9 +
>  drivers/mmc/core/sd_ops.h  |   18 +
>  drivers/mmc/core/sd_uhs2.c | 1152 +++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/core.h   |   13 +
>  include/linux/mmc/host.h   |   18 +
>  10 files changed, 1211 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ba8808cd9318..f5dc653eafb0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>
>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         init_completion(&mrq->cmd_completion);
> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 return err;
>
> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
>
> @@ -430,6 +434,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>   */
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {

I think it's important to understand whether you actually tested this
for an hsq enabled host driver - or you just added this for
completeness? I believe I raised the similar question for some of the
sdhci patches too.

If the code is untested, we need to make a judgement if this is worth
carrying from a maintenance point of view.

> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         /*
> @@ -450,6 +456,8 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 goto out_err;
>
> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +
>         err = host->cqe_ops->cqe_request(host, mrq);
>         if (err)
>                 goto out_err;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..5c8e62e8f331 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
>         return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>  }
>
> +int __mmc_go_idle(struct mmc_host *host)
> +{
> +       struct mmc_command cmd = {};
> +       int err;
> +
> +       cmd.opcode = MMC_GO_IDLE_STATE;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       mmc_delay(1);
> +
> +       return err;
> +}
> +
>  int mmc_go_idle(struct mmc_host *host)
>  {
>         int err;
> -       struct mmc_command cmd = {};
>
>         /*
>          * Non-SPI hosts need to prevent chipselect going active during
> @@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
>                 mmc_delay(1);
>         }
>
> -       cmd.opcode = MMC_GO_IDLE_STATE;
> -       cmd.arg = 0;
> -       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> -
> -       err = mmc_wait_for_cmd(host, &cmd, 0);
> -
> -       mmc_delay(1);
> +       err = __mmc_go_idle(host);
>
>         if (!mmc_host_is_spi(host)) {
>                 mmc_set_chip_select(host, MMC_CS_DONTCARE);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 92d4194c7893..3eaefe989c80 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -25,6 +25,7 @@ struct mmc_command;
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_set_dsr(struct mmc_host *host);
> +int __mmc_go_idle(struct mmc_host *host);

The changes above for __mmc_go_idle() looks good to me.

However, I would prefer these and similar changes to be done as a
separate re-factoring patch, preceding $subject patch. Can you please
make that?

>  int mmc_go_idle(struct mmc_host *host);
>  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
>  int mmc_set_relative_addr(struct mmc_card *card);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c3e554344c99..8d2e739a7c5c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -207,7 +207,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>  /*
>   * Given a 64-bit response, decode to our card SCR structure.
>   */
> -static int mmc_decode_scr(struct mmc_card *card)
> +int mmc_decode_scr(struct mmc_card *card)
>  {
>         struct sd_scr *scr = &card->scr;
>         unsigned int scr_struct;
> @@ -904,7 +904,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
>         return 0;
>  }
>
> -static int mmc_sd_get_ro(struct mmc_host *host)
> +int mmc_sd_get_ro(struct mmc_host *host)
>  {
>         int ro;
>
> @@ -1630,11 +1630,6 @@ static void mmc_sd_detect(struct mmc_host *host)
>         }
>  }
>
> -static int sd_can_poweroff_notify(struct mmc_card *card)
> -{
> -       return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
> -}

I prefer if we can leave the implementation of the above function here
and please don't to rename it. Instead, just share it by adding a
declaration of it in sd.d, very similar to what is being done for the
below sd_poweroff_notify().

> -
>  static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
>  {
>         struct sd_busy_data *data = cb_data;
> @@ -1658,7 +1653,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
>         return 0;
>  }
>
> -static int sd_poweroff_notify(struct mmc_card *card)
> +int sd_poweroff_notify(struct mmc_card *card)
>  {
>         struct sd_busy_data cb_data;
>         u8 *reg_buf;
> @@ -1706,7 +1701,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
>         if (mmc_card_suspended(card))
>                 goto out;
>
> -       if (sd_can_poweroff_notify(card))
> +       if (mmc_sd_can_poweroff_notify(card))
>                 err = sd_poweroff_notify(card);
>         else if (!mmc_host_is_spi(host))
>                 err = mmc_deselect_cards(host);
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 1af5a038bae9..d31259919ee5 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -11,10 +11,14 @@ struct mmc_card;
>
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
>  int mmc_sd_get_csd(struct mmc_card *card);
> +int mmc_sd_get_ro(struct mmc_host *host);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit);
>  unsigned mmc_sd_get_max_clock(struct mmc_card *card);
>  int mmc_sd_switch_hs(struct mmc_card *card);
>
> +/* These call back functions were also used by UHS2 sd card */

I don't think the above comment adds much value. There are other
functions being used for uhs2 too, so please just drop it.

> +int sd_poweroff_notify(struct mmc_card *card);
> +
>  #endif
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index a59cd592f06e..b0cba0cd24a5 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -27,6 +27,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>         if (WARN_ON(card && card->host != host))
>                 return -EINVAL;
>
> +       /*
> +        * UHS2 packet has APP bit so only set APP_CMD flag here.
> +        * Will set the APP bit when assembling UHS2 packet.
> +        */
> +       if (host->flags & MMC_UHS2_SD_TRAN) {
> +               host->uhs2_app_cmd = true;
> +               return 0;
> +       }
> +
>         cmd.opcode = MMC_APP_CMD;
>
>         if (card) {
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..b8ff4713c914 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>
>  struct mmc_card;
> +struct mmc_command;
>  struct mmc_host;
>
>  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> @@ -19,8 +20,25 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
>  int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
>  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
> +int mmc_decode_scr(struct mmc_card *card);

I understand that it's not entirely obvious where we prefer this
declaration to be.

The general rule of thumb is that in sd.h we specify those functions
being implemented in sd.c. And vice verse for sd_ops.h|c. So, please
move the above change to sd.h.

>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
> +
> +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq,
> +                                            struct uhs2_command uhs2_cmd, __be32 payload[4])
> +{
> +       if (host->flags & MMC_UHS2_SD_TRAN) {

According to the discussion around patch10, it seems like the other
bit, MMC_UHS2_SUPPORT, can be removed, which leaves us with
MMC_UHS2_SD_TRAN only.

That said, please drop host->flags and MMC_UHS2_SD_TRAN. Let's instead
convert into using a bool variable in the struct mmc_host, perhaps
name it "uhs2_sd_tran".

> +               uhs2_cmd.payload = payload;
> +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> +               mmc_uhs2_prepare_cmd(host, mrq);
> +       }
> +}

There are no other callers of mmc_uhs2_prepare_cmd() but
mmc_uhs2_card_prepare_cmd().

Therefore let's just drop the inline function above and move the
corresponding additional code into the implementation of
mmc_uhs2_prepare_cmd(). Thus all callers of
mmc_uhs2_card_prepare_cmd() need to move to use mmc_uhs2_prepare_cmd()
instead.

> +
> +static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> +{
> +       return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
> +}
>
>  #endif
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index beb2541338ff..5578a820428a 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1,23 +1,51 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2021 Linaro Ltd
> - *
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
>   *
> + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + * Author: Yi Sun <yi.y.sun@intel.com>
> + *
> + * Copyright (C) 2020 Genesys Logic, Inc.
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * Copyright (C) 2022 Genesys Logic, Inc.
> + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2023 Genesys Logic, Inc.
> + * Authors: Victor Shih <victor.shih@genesyslogic.com.tw>
> + *
>   * Support for SD UHS-II cards
>   */
>  #include <linux/err.h>
> +#include <linux/pm_runtime.h>
>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sd_uhs2.h>
>
> +#include "card.h"
>  #include "core.h"
>  #include "bus.h"
>  #include "sd.h"
> +#include "sd_ops.h"
>  #include "mmc_ops.h"
>
> +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000) /* 1ms */
> +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100        /* 100ms */

Nitpick: The comments "1ms" and "100ms" are kind of superfluous, due
to the well chosen names for the defines. Perhaps drop them?

> +
>  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
>
> +struct sd_uhs2_wait_active_state_data {
> +       struct mmc_host *host;
> +       struct mmc_command *cmd;
> +};
> +
>  static int sd_uhs2_power_up(struct mmc_host *host)
>  {
>         int err;
> @@ -44,10 +72,49 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>         host->ios.clock = 0;
>         host->ios.timing = MMC_TIMING_LEGACY;
>         host->ios.power_mode = MMC_POWER_OFF;
> +       if (host->flags & MMC_UHS2_SD_TRAN)

There is no need to check that the flag/bit is set. Just clear it.

> +               host->flags &= ~MMC_UHS2_SD_TRAN;
>
>         return host->ops->uhs2_control(host, UHS2_SET_IOS);
>  }
>
> +/*
> + * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embedded in
> + *                          mmc_command structure
> + * @cmd:       MMC command to executed
> + * @uhs2_cmd:  UHS2 command corresponded to MMC command
> + * @header:    Header field of UHS-II command cxpacket
> + * @arg:       Argument field of UHS-II command packet
> + * @payload:   Payload field of UHS-II command packet
> + * @plen:      Payload length
> + * @resp:      Response buffer is allocated by caller and it is used to keep
> + *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
> + *              should be null and SD-TRAN command response should be stored in
> + *              resp of mmc_command.
> + * @resp_len:  Response buffer length
> + *
> + * The uhs2_command structure contains message packets which are transmited/
> + * received on UHS-II bus. This function fills in the contents of uhs2_command
> + * structure and embededs UHS2 command into mmc_command structure, which is used
> + * in legacy SD operation functions.
> + *
> + */
> +static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
> +                                struct uhs2_command *uhs2_cmd,
> +                                u16 header, u16 arg, __be32 *payload,
> +                                u8 plen, u8 *resp, u8 resp_len)
> +{
> +       uhs2_cmd->header = header;
> +       uhs2_cmd->arg = arg;
> +       uhs2_cmd->payload = payload;
> +       uhs2_cmd->payload_len = plen * sizeof(u32);
> +       uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
> +
> +       cmd->uhs2_cmd = uhs2_cmd;
> +       cmd->uhs2_resp = resp;
> +       cmd->uhs2_resp_len = resp_len;
> +}
> +
>  /*
>   * Run the phy initialization sequence, which mainly relies on the UHS-II host
>   * to check that we reach the expected electrical state, between the host and
> @@ -55,7 +122,15 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>   */
>  static int sd_uhs2_phy_init(struct mmc_host *host)
>  {
> -       return 0;
> +       int err = 0;

No need to assign err to 0.

> +
> +       err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +       if (err) {
> +               pr_err("%s: failed to initial phy for UHS-II!\n",
> +                      mmc_hostname(host));
> +       }
> +
> +       return err;
>  }
>
>  /*
> @@ -64,6 +139,82 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_dev_init(struct mmc_host *host)
>  {
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u32 cnt;
> +       u32 dap, gap, resp_gap;
> +       u16 header, arg;
> +       __be32 payload[UHS2_DEV_INIT_PAYLOAD_LEN];
> +       u8 gd = 0;
> +       u8 resp[UHS2_DEV_ENUM_RESP_LEN] = {0};
> +       int err;
> +
> +       dap = host->uhs2_caps.dap;
> +       gap = host->uhs2_caps.gap;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVICE_INIT CCMD format.
> +        * Head:
> +        *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +        *      - IOADR = CMD_BASE + 002h
> +        * Payload:
> +        *      - bit [3:0]  : GAP(Group Allocated Power)
> +        *      - bit [7:4]  : GD(Group Descriptor)
> +        *      - bit [11]   : Complete Flag
> +        *      - bit [15:12]: DAP(Device Allocated Power)
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +       arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_4B |
> +              (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> +        * Max. time from DEVICE_INIT CCMD EOP reception on Device
> +        * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> +        * 1 second.
> +        */
> +       cmd.busy_timeout = 1000;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> +        * When the number of the DEVICE_INIT commands is reach to
> +        * 30 tiems, Host shall stop issuing DEVICE_INIT command
> +        * and regard it as an error.

To clarify the above comment a bit, may I suggest we rephrase this into:

Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
Let's retry the DEVICE_INIT command no more than 30 times.

> +        */
> +       for (cnt = 0; cnt < 30; cnt++) {
> +               payload[0] = ((dap & 0xF) << 12) |
> +                             UHS2_DEV_INIT_COMPLETE_FLAG |
> +                             ((gd & 0xF) << 4) |
> +                             (gap & 0xF);
> +
> +               sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> +                                    payload, UHS2_DEV_INIT_PAYLOAD_LEN,
> +                                    resp, UHS2_DEV_INIT_RESP_LEN);
> +
> +               err = mmc_wait_for_cmd(host, &cmd, 0);
> +               if (err) {
> +                       pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                              mmc_hostname(host), __func__, err);
> +                       return err;
> +               }
> +
> +               if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> +                       pr_err("%s: DEVICE_INIT response is wrong!\n",
> +                              mmc_hostname(host));
> +                       return -EIO;
> +               }
> +
> +               if (resp[5] & 0x8) {
> +                       host->uhs2_caps.group_desc = gd;
> +                       return 0;
> +               }
> +               resp_gap = resp[4] & 0x0F;
> +               if (gap == resp_gap)
> +                       gd++;
> +       }
> +
>         return 0;
>  }
>

[...]

>
> -/*
> - * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> - * commands/requests to be backwards compatible through the legacy SD protocol.
> - * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
> - * be set through a legacy CMD6. Note that, the power limit that becomes set,
> - * survives a soft reset through the GO_DORMANT_STATE command.
> - */
> -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> +static int sd_uhs2_go_dormant(struct mmc_host *host, u32 node_id)
>  {
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u16 header, arg;
> +       __be32 payload[1];
> +       int err;
> +
> +       /* Disable Normal INT */
> +       err = host->ops->uhs2_control(host, UHS2_DISABLE_INT);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> +                      mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-17 to see GO_DORMANT_STATE CCMD format.
> +        * Header:
> +        *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +        *      - IOADR = CMD_BASE + 001h
> +        * Payload:
> +        *      - bit [7]: HBR(Entry to Hibernate Mode)
> +        *                 1: Host intends to enter Hibernate mode during Dormant state.
> +        *                 The default setting is 0 because hibernate is currently not supported.
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +       arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_WRITE |
> +               UHS2_NATIVE_CMD_PLEN_4B |
> +               (UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_GO_DORMANT_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* Check Dormant State in Present */
> +       err = host->ops->uhs2_control(host, UHS2_CHECK_DORMANT);
> +       if (err)
> +               return err;
> +
> +       /* Disable UHS2 card clock */
> +       err = host->ops->uhs2_control(host, UHS2_DISABLE_CLK);
> +       if (err)
> +               return err;
> +
> +       /* Restore sd clock */
> +       mmc_delay(5);
> +       err = host->ops->uhs2_control(host, UHS2_ENABLE_CLK);
> +       if (err)
> +               return err;
> +
> +       /* Enable Normal INT */
> +       err = host->ops->uhs2_control(host, UHS2_ENABLE_INT);
> +       if (err)
> +               return err;
> +
> +       /* Detect UHS2 */
> +       err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int __sd_uhs2_wait_active_state_cb(void *cb_data, bool *busy)

Please drop the "__" prefix for this function.

> +{
> +       struct sd_uhs2_wait_active_state_data *data = cb_data;
> +       struct mmc_host *host = data->host;
> +       struct mmc_command *cmd = data->cmd;
> +       int err;
> +
> +       err = mmc_wait_for_cmd(host, cmd, 0);
> +       if (err)
> +               return err;
> +
> +       if (cmd->resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
> +               *busy = false;
> +       else
> +               *busy = true;
> +
> +       return 0;
> +}
> +
> +static int sd_uhs2_go_dormant_state(struct mmc_host *host, u32 node_id)
> +{
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u16 header, arg;
> +       int err;
> +       struct sd_uhs2_wait_active_state_data cb_data = {
> +               .host = host,
> +               .cmd = &cmd
> +       };
> +
> +       err = sd_uhs2_go_dormant(host, node_id);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Read CCMD to check Config Completion(bit 63) in Generic Setting Register.
> +        * - Control Read(R/W=0) with 8-Byte payload(PLEN=10b).
> +        * - IOADR = Generic Setting Register(CFG_BASE + 008h)
> +        *
> +        * When UHS-II card been switched to new speed mode, it will set Config Completion to 1.
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_READ |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> +       err = __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_US,
> +                                 UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
> +                                 &__sd_uhs2_wait_active_state_cb, &cb_data);
> +       if (err) {
> +               pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
>         return 0;
>  }
>
> +static void sd_uhs2_remove(struct mmc_host *host)
> +{
> +       mmc_remove_card(host->card);
> +       host->card = NULL;
> +}
> +
>  /*
>   * Allocate the data structure for the mmc_card and run the UHS-II specific
>   * initialization sequence.
>   */
> -static int sd_uhs2_init_card(struct mmc_host *host)
> +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
>  {
>         struct mmc_card *card;
>         u32 node_id;
> @@ -131,9 +834,14 @@ static int sd_uhs2_init_card(struct mmc_host *host)
>         if (err)
>                 return err;
>
> -       card = mmc_alloc_card(host, &sd_type);
> -       if (IS_ERR(card))
> -               return PTR_ERR(card);
> +       if (oldcard) {
> +               card = oldcard;
> +       } else {
> +               card = mmc_alloc_card(host, &sd_type);
> +               if (IS_ERR(card))
> +                       return PTR_ERR(card);
> +       }
> +       host->card = card;

I think it would be better to leave the assignment of host->card until
a bit later in this function.

We don't want to make it look like we need the host->card to be
assigned to complete the initialization in this function. See more
about this below.

>
>         card->uhs2_config.node_id = node_id;
>         card->type = MMC_TYPE_SD;
> @@ -146,18 +854,226 @@ static int sd_uhs2_init_card(struct mmc_host *host)
>         if (err)
>                 goto err;
>
> -       host->card = card;
> +       /* If change speed to Range B, need to GO_DORMANT_STATE */
> +       if (host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +           host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
> +               err = sd_uhs2_go_dormant_state(host, node_id);
> +               if (err)
> +                       return err;

This is wrong, as we need to check if we should free the allocated
struct mmc_card too.

A "goto err;" should fix this.

> +       }
> +
> +       host->flags |= MMC_UHS2_SD_TRAN;
> +
>         return 0;
>
>  err:
> -       mmc_remove_card(card);
> +       sd_uhs2_remove(host);

If we have an "oldcard" we must not remove it in this path as it
simply doesn't work. In this case the removal is managed through the
mmc_rescan() work, when it calls the bus_ops->detect() callback
(sd_uhs2_detect()).

So we need to add a check for "!oldcard" and then we should call
mmc_remove_card() instead. That is also why it makes sense to assign
host->card as late as possible, just before returning 0 a few lines
above.

>         return err;
>  }
>
> -static void sd_uhs2_remove(struct mmc_host *host)
> +int sd_uhs2_reinit(struct mmc_host *host)
>  {
> -       mmc_remove_card(host->card);
> -       host->card = NULL;
> +       struct mmc_card *card = host->card;
> +       int err;
> +
> +       sd_uhs2_power_up(host);
> +       err = sd_uhs2_phy_init(host);
> +       if (err)
> +               return err;
> +
> +       err = sd_uhs2_init_card(host, card);
> +       if (err)
> +               return err;

By looking at the above there seems to be some pieces missing to make this work.

*) We need to re-initialize the card to work in SD_TRAN again, hence
we need to call sd_uhs2_legacy_init() and make it work for this case
too.

**) If the card gets removed and replaced by another card during
system suspend, we must make sure to drop the original allocated
struct mmc_card. For legacy SD cards we compare the cid register and
if there is no match, we return an error during system resume and
leave the card to be removed by mmc_rescan(). Perhaps we can use a
similar approach for uhs2 or maybe something more clever?

> +
> +       mmc_card_set_present(card);

No, this is wrong. This is already managed by mmc_add_card() that has
already been called for the card earlier.

> +       return err;
> +}
> +
> +/*
> + * Mask off any voltages we don't support and select
> + * the lowest voltage
> + */
> +u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)

As discussed earlier, it's better to use mmc_select_voltage() for uhs2
too. So, please drop this function altogether.

To make mmc_select_voltage() to work for uhs2, we should prevent the
path for MMC_CAP2_FULL_PWR_CYCLE. In other words something like the
below "diff" in mmc_select_voltage() should work, I think.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f5dc653eafb0..92a6e3c762af 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1135,7 +1135,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
                return 0;
        }

-       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
+       if (!mmc_card_uhs2(host) && host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
                bit = ffs(ocr) - 1;
                ocr &= 3 << bit;
                mmc_power_cycle(host, ocr);

> +{
> +       int bit;
> +       int err;
> +
> +       /*
> +        * Sanity check the voltages that the card claims to
> +        * support.
> +        */
> +       if (ocr & 0x7F) {
> +               dev_warn(mmc_dev(host), "card claims to support voltages below defined range\n");
> +               ocr &= ~0x7F;
> +       }
> +
> +       ocr &= host->ocr_avail;
> +       if (!ocr) {
> +               dev_warn(mmc_dev(host), "no support for card's volts\n");
> +               return 0;
> +       }
> +
> +       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> +               bit = ffs(ocr) - 1;
> +               ocr &= 3 << bit;
> +               /* Power cycle */
> +               err = sd_uhs2_power_off(host);
> +               if (err)
> +                       return 0;
> +               err = sd_uhs2_reinit(host);
> +               if (err)
> +                       return 0;
> +       } else {
> +               bit = fls(ocr) - 1;
> +               ocr &= 3 << bit;
> +               if (bit != host->ios.vdd)
> +                       dev_warn(mmc_dev(host), "exceeding card's volts\n");
> +       }
> +
> +       return ocr;
> +}
> +
> +/*
> + * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> + * commands/requests to be backwards compatible through the legacy SD protocol.
> + * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
> + * be set through a legacy CMD6. Note that, the power limit that becomes set,
> + * survives a soft reset through the GO_DORMANT_STATE command.
> + */
> +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> +{
> +       int err;
> +       u32 cid[4];
> +       u32 ocr;
> +       u32 rocr;
> +       u8  *status;
> +       int ro;
> +
> +       /* Send CMD0 to reset SD card */
> +       err = __mmc_go_idle(host);
> +       if (err)
> +               return err;
> +
> +       mmc_delay(1);
> +
> +       /* Send CMD8 to communicate SD interface operation condition */
> +       err = mmc_send_if_cond(host, host->ocr_avail);
> +       if (err) {
> +               dev_warn(mmc_dev(host), "CMD8 error\n");
> +               goto err;
> +       }
> +
> +       /*
> +        * Probe SD card working voltage.
> +        */
> +       err = mmc_send_app_op_cond(host, 0, &ocr);
> +       if (err)
> +               goto err;
> +
> +       card->ocr = ocr;

I don't think this is the ocr we should store in the card->ocr.
Instead it should be the ocr that has been negotiated through the
mmc_select_voltage().

> +
> +       /*
> +        * Some SD cards claims an out of spec VDD voltage range. Let's treat
> +        * these bits as being in-valid and especially also bit7.
> +        */
> +       ocr &= ~0x7FFF;
> +       rocr = sd_uhs2_select_voltage(host, ocr);
> +       /*
> +        * Some cards have zero value of rocr in UHS-II mode. Assign host's
> +        * ocr value to rocr.
> +        */

That sounds weird to me. What card did this happen for? Did you print
the ocr that you received from the card and compared it with
host->ocr_avail?

In any case, if I understand correctly, this will trigger
sd_uhs2_select_voltage() to print "no support for card's volts",
right?

If this is a common case for uhs2 cards, maybe we should teach
mmc_select_voltage() about this problem too. We don't want to print
error messages to the log to worry the user, unless it's really a
problem.

> +       if (!rocr)
> +               rocr = host->ocr_avail;
> +
> +       rocr |= (SD_OCR_CCS | SD_OCR_XPC);
> +
> +       /* Wait SD power on ready */
> +       ocr = rocr;
> +
> +       err = mmc_send_app_op_cond(host, ocr, &rocr);
> +       if (err)
> +               goto err;
> +
> +       err = mmc_send_cid(host, cid);
> +       if (err)
> +               goto err;
> +
> +       memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> +       mmc_decode_cid(card);
> +
> +       /*
> +        * For native busses:  get card RCA and quit open drain mode.
> +        */
> +       err = mmc_send_relative_addr(host, &card->rca);
> +       if (err)
> +               goto err;
> +
> +       err = mmc_sd_get_csd(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Select card, as all following commands rely on that.
> +        */
> +       err = mmc_select_card(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Fetch SCR from card.
> +        */
> +       err = mmc_app_send_scr(card);
> +       if (err)
> +               goto err;
> +
> +       err = mmc_decode_scr(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Switch to high power consumption mode.
> +        * Even switch failed, sd card can still work at lower power consumption mode, but
> +        * performance will be lower than high power consumption mode.
> +        */
> +       status = kmalloc(64, GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       if (!(card->csd.cmdclass & CCC_SWITCH)) {
> +               pr_warn("%s: card lacks mandatory switch function, performance might suffer\n",
> +                       mmc_hostname(card->host));
> +       } else {
> +               /* send CMD6 to set Maximum Power Consumption to get better performance */
> +               err = mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1_80W, status);
> +               if (!err)
> +                       err = mmc_sd_switch(card, 1, 3, SD4_SET_POWER_LIMIT_1_80W, status);
> +
> +               err = 0;
> +       }
> +
> +       /*
> +        * Check if read-only switch is active.
> +        */
> +       ro = mmc_sd_get_ro(host);
> +       if (ro < 0) {
> +               pr_warn("%s: host does not support read-only switch, assuming write-enable\n",
> +                       mmc_hostname(host));
> +       } else if (ro > 0) {
> +               mmc_card_set_readonly(card);
> +       }
> +
> +       /*
> +        * NOTE:
> +        * Should we read Externsion Register to check power notification feature here?
> +        */

Yes, that seems reasonable.

Although, I think it's a good idea to make the change as an
incremental patch on top of $subject patch. In fact, the whole system
wide suspend/resume and runtime PM support look far from ready to me.
Maybe I am wrong - or did you test those code paths too?

That said, as an option to more easily move things forward, may I
suggest that you move the implementation of the entire PM support into
incremental patches on top of $subject patch?

To make it clear, I am referring to sd_uhs2_runtime_suspend,
sd_uhs2_runtime_resume, sd_uhs2_shutdown, sd_uhs2_suspend,
sd_uhs2_resume, sd_uhs2_hw_reset, sd_uhs2_reinit.

In this way, we could perhaps get the foundation for UHS2 support in
place while we continue to work on the PM parts as improvements on
top. What do you think?

> +
> +       kfree(status);
> +
> +       return 0;
> +
> +err:
> +       sd_uhs2_remove(host);
> +       return err;
>  }
>
>  static int sd_uhs2_alive(struct mmc_host *host)
> @@ -179,38 +1095,194 @@ static void sd_uhs2_detect(struct mmc_host *host)
>                 mmc_claim_host(host);
>                 mmc_detach_bus(host);
>                 sd_uhs2_power_off(host);
> +               host->flags &= ~MMC_UHS2_SUPPORT;
>                 mmc_release_host(host);
>         }
>  }

[...]

> -static int sd_uhs2_shutdown(struct mmc_host *host)
> +static int sd_uhs2_hw_reset(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       sd_uhs2_power_off(host);
> +       /* Wait at least 1 ms according to SD spec */
> +       mmc_delay(1);
> +       sd_uhs2_power_up(host);
> +
> +       err = sd_uhs2_reinit(host);

Unless I am missing something, sd_uhs2_reinit() isn't sufficient to
re-initialize the card. We need to move to SD_TRAN too, right?

> +
> +       return err;
>  }
>
> -static int sd_uhs2_hw_reset(struct mmc_host *host)
> +/*
> + * mmc_uhs2_prepare_cmd - prepare for SD command packet
> + * @host:      MMC host
> + * @mrq:       MMC request
> + *
> + * Initialize and fill in a header and a payload of SD command packet.
> + * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
> + * advance.
> + *
> + * Return:     0 on success, non-zero error on failure
> + */
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -       return 0;
> +       struct mmc_command *cmd;
> +       struct uhs2_command *uhs2_cmd;
> +       u16 header, arg;
> +       __be32 *payload;
> +       u8 plen;
> +
> +       cmd = mrq->cmd;
> +       header = host->card->uhs2_config.node_id;
> +       if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +               header |= UHS2_PACKET_TYPE_DCMD;
> +       else
> +               header |= UHS2_PACKET_TYPE_CCMD;
> +
> +       arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
> +       if (host->uhs2_app_cmd) {
> +               arg |= UHS2_SD_CMD_APP;
> +               host->uhs2_app_cmd = false;
> +       }
> +
> +       /*
> +        * UHS-II Addendum 7.2.1.2
> +        * Host may set DM to 1 for DCMD which supports multi-block read/write regardless of
> +        * data transfer length (e.g., CMD18, CMD25). Otherwise, it shall not set DM to 1.
> +        * (e.g., CMD6, CMD17, CMD24). These rules are also applied to other multi-block read/write
> +        * commands defined in other Part of SD specifications (for example, Host may set DM to 1
> +        * for ACMD18 or ACMD25).
> +        */
> +       if (mmc_op_multi(cmd->opcode))
> +               cmd->uhs2_cmd->tmode_half_duplex = mmc_card_uhs2_hd_mode(host);
> +       else
> +               cmd->uhs2_cmd->tmode_half_duplex = 0;
> +
> +       uhs2_cmd = cmd->uhs2_cmd;
> +       payload = uhs2_cmd->payload;
> +       plen = 2; /* at the maximum */
> +
> +       if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
> +           cmd->uhs2_cmd->tmode_half_duplex) {
> +               if (mmc_card_uhs2_hd_mode(host))
> +                       arg |= UHS2_DCMD_2L_HD_MODE;
> +
> +               arg |= UHS2_DCMD_LM_TLEN_EXIST;
> +
> +               if (cmd->data->blocks == 1 &&
> +                   cmd->data->blksz != 512 &&
> +                   cmd->opcode != MMC_READ_SINGLE_BLOCK &&
> +                   cmd->opcode != MMC_WRITE_BLOCK) {
> +                       arg |= UHS2_DCMD_TLUM_BYTE_MODE;
> +                       payload[1] = cpu_to_be32(cmd->data->blksz);

This case isn't supported by the mmc block device driver.

Perhaps this is this needed to support the uhs2 card initialization
sequence? If not, I would prefer if we can drop this path/code.

> +               } else {
> +                       payload[1] = cpu_to_be32(cmd->data->blocks);
> +               }
> +       } else {
> +               plen = 1;
> +       }
> +
> +       payload[0] = cpu_to_be32(cmd->arg);
> +       sd_uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, NULL, 0);
>  }
>
>  static const struct mmc_bus_ops sd_uhs2_ops = {
> @@ -221,7 +1293,7 @@ static const struct mmc_bus_ops sd_uhs2_ops = {
>         .resume = sd_uhs2_resume,
>         .runtime_suspend = sd_uhs2_runtime_suspend,
>         .runtime_resume = sd_uhs2_runtime_resume,
> -       .shutdown = sd_uhs2_shutdown,
> +       .shutdown = sd_uhs2_suspend,
>         .hw_reset = sd_uhs2_hw_reset,
>  };
>
> @@ -229,6 +1301,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
>  {
>         int err;
>
> +       host->flags |= MMC_UHS2_SUPPORT;
> +
>         err = sd_uhs2_power_up(host);
>         if (err)
>                 goto err;
> @@ -237,7 +1311,7 @@ static int sd_uhs2_attach(struct mmc_host *host)
>         if (err)
>                 goto err;
>
> -       err = sd_uhs2_init_card(host);
> +       err = sd_uhs2_init_card(host, NULL);
>         if (err)
>                 goto err;
>
> @@ -254,21 +1328,32 @@ static int sd_uhs2_attach(struct mmc_host *host)
>                 goto remove_card;
>
>         mmc_claim_host(host);
> +
>         return 0;
>
>  remove_card:
> -       mmc_remove_card(host->card);
> -       host->card = NULL;
> +       sd_uhs2_remove(host);
>         mmc_claim_host(host);
> -       mmc_detach_bus(host);
> +
>  err:
> +       mmc_detach_bus(host);
>         sd_uhs2_power_off(host);
> +       host->flags &= ~MMC_UHS2_SUPPORT;
>         return err;
>  }
>
> +/**
> + * mmc_attach_sd_uhs2 - select UHS2 interface
> + * @host: MMC host
> + *
> + * Try to select UHS2 interface and initialize the bus for a given
> + * frequency, @freq.
> + *
> + * Return:     0 on success, non-zero error on failure
> + */
>  int mmc_attach_sd_uhs2(struct mmc_host *host)
>  {
> -       int i, err = 0;
> +       int i, err;
>
>         if (!(host->caps2 & MMC_CAP2_SD_UHS2))
>                 return -EOPNOTSUPP;
> @@ -283,6 +1368,9 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>          */
>         for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
>                 host->f_init = sd_uhs2_freqs[i];
> +               pr_info("%s: %s: trying to init UHS-II card at %u Hz\n",
> +                       mmc_hostname(host), __func__, host->f_init);
> +

Please move this to pr_dbg.

>                 err = sd_uhs2_attach(host);
>                 if (!err)
>                         break;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6efec0b9820c..4623651037dd 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -23,6 +23,15 @@ enum mmc_blk_status {
>         MMC_BLK_NEW_REQUEST,
>  };
>
> +struct uhs2_command {
> +       u16     header;
> +       u16     arg;
> +       __be32  *payload;
> +       u32     payload_len;
> +       u32     packet_len;
> +       u8      tmode_half_duplex;
> +};
> +
>  struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
> @@ -109,6 +118,10 @@ struct mmc_command {
>         unsigned int            busy_timeout;   /* busy detect timeout in ms */
>         struct mmc_data         *data;          /* data segment associated with cmd */
>         struct mmc_request      *mrq;           /* associated request */
> +
> +       struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> +       u8                      *uhs2_resp;     /* UHS2 native cmd resp */
> +       u8                      uhs2_resp_len;  /* UHS2 native cmd resp len */

I think it would be better to keep the responses (uhs2_resp,
uhs2_resp_len) into the struct uhs2_command too. In this way,
everything for uhs2 is kept behind one single pointer, the ->uhs2_cmd.

Would that work?

>  };
>
>  struct mmc_data {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0d1a3e9ad93c..6c8258310641 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -126,6 +126,13 @@ struct sd_uhs2_caps {
>  };
>
>  enum sd_uhs2_operation {
> +       UHS2_PHY_INIT = 0,
> +       UHS2_SET_CONFIG,
> +       UHS2_ENABLE_INT,
> +       UHS2_DISABLE_INT,
> +       UHS2_ENABLE_CLK,
> +       UHS2_DISABLE_CLK,
> +       UHS2_CHECK_DORMANT,
>         UHS2_SET_IOS,
>  };
>
> @@ -476,6 +483,11 @@ struct mmc_host {
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
>
> +       int flags;
> +#define MMC_UHS2_SUPPORT (1 << 0)
> +#define MMC_UHS2_SD_TRAN (1 << 1)
> +
> +       bool                    uhs2_app_cmd;   /* Host UHS-II APP Command */
>         struct sd_uhs2_caps     uhs2_caps;      /* Host UHS-II capabilities */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
> @@ -728,6 +740,12 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
>         host->err_stats[stat] += 1;
>  }
>
> +static inline int mmc_card_uhs2_hd_mode(struct mmc_host *host)
> +{
> +       return host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
> +}
> +
>  int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);
>  int mmc_send_status(struct mmc_card *card, u32 *status);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);

Kind regards
Uffe

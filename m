Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780487B68C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjJCMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJCMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:15:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9B0AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:15:42 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a2536adaf3so10268577b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696335341; x=1696940141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDVpSksuWR7AsHnYKiy6VQr580Esn9Zomwi8qvkWS/g=;
        b=zvADul/5c5pG0m1/UEIS9V7tCT4o0Kyk847/6YYGqzfCJFNdAMZ3uKhD6WP5nFV57x
         /uuvL8YM3jsOEIcyaxu9YaFI2VNFV5I7jVuixG3jyzF3wneheoiRGfatZuWxeojZH9TF
         n8blcBsZZrDAdApnTXj+DL+CltQSXaa8SwK5/G8uVwxdH/rTezREC8501zwPjik524Ui
         5N66RSWueAM+AP8zIRlecRKBVewULMLWuz0wgZUtcLU3rVZbXHnkF01+c8dBbmLDBqAx
         Y67H+nHNo8z9oMOH3aanVGy+qUTpy5OGnsYt/TLS+EBlltbFG1uTlgWNlGbfoF1YisVS
         obzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335341; x=1696940141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDVpSksuWR7AsHnYKiy6VQr580Esn9Zomwi8qvkWS/g=;
        b=g1hlsd6fUTGTLbLby4i+VQwXcCc03XjyK4dJjMAW1xceusjOlinP4EWs2JJZyuxJGV
         h3pui2vXkB4r2ZwT9U0eMKp9BlSilCU53Pjn9U634fgv7r4EcIH8YzYzSDHlG1xJw6LA
         Pols/4dZbDecA9OEbLP6ysMQzObDuPsTH9sBRHYWF9jLJ7AYYxCTkEcwj3MBcldfnNVG
         ifPTL012EFCivFBmPOHm+NTrUG5dL+9aelSd0+i8YZ+axBY2Cm/UjLPDUTxnZciioydR
         iTY2Z7CSSa2ECAvYLCyLCpbBtgiLiiA5DDYdLLOeW2ghzU/VM5xPvagpe5ORJJ+gy2lP
         89SQ==
X-Gm-Message-State: AOJu0YxgpDc6RvLGRF7JHYSvsW0KEJDChnPcfOS6gCUkhtNDt3NctAGD
        HPvtF48lwsFLLtD6KPh6WYw7oKggJ1uHi9/xm8HTUA==
X-Google-Smtp-Source: AGHT+IERnUEcqQgnhAOdB/R9TGzaBtJL6LVSF4qMYHTQGC5Uquy7PjxhWq5MUrvaZleYyHxubxovZM8XljrTVxuoDSk=
X-Received: by 2002:a25:aa93:0:b0:d78:ef4:76ae with SMTP id
 t19-20020a25aa93000000b00d780ef476aemr13144936ybi.33.1696335341408; Tue, 03
 Oct 2023 05:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-19-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-19-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 14:15:05 +0200
Message-ID: <CAPDyKFoiroN0XX0CLHGxZYHCZmWe11z5avH=KnS7qpkuNdwxiw@mail.gmail.com>
Subject: Re: [PATCH V12 18/23] mmc: sdhci-uhs2: add request() and others
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.

Okay, but again, please elaborate on why we need/want this.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V11:
>  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
>    in sdhci_uhs2_set_transfer_mode().
>
> Updates in V10:
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
>    in sdhci_uhs2_set_transfer_mode().
>
> Updates in V9:
>  - Modify the annotations in __sdhci_uhs2_send_command().
>
> Updates in V8:
>  - Adjust the position of matching brackets in
>    sdhci_uhs2_send_command_retry().
>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
>  - Modify error message in __sdhci_uhs2_finish_command().
>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
>    in sdhci_uhs2_request().
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
>  - Add forward declaration for sdhci_send_command().
>
> Updates in V7:
>  - Cancel export state of some functions.
>  - Remove unnecessary whitespace changes.
>
> Updates in V6:
>  - Add uhs2_dev_cmd() to simplify code.
>  - Remove unnecessary functions.
>  - Cancel export state of some functions.
>  - Drop use CONFIG_MMC_DEBUG().
>  - Wrap at 100 columns in some functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 412 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  49 ++--
>  drivers/mmc/host/sdhci.h      |   8 +
>  3 files changed, 454 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 09b86fec9f7b..1f8d527424fd 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c

[...]

> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +       int i, j;
> +       int cmd_reg;
> +
> +       i = 0;
> +       sdhci_writel(host,
> +                    ((u32)cmd->uhs2_cmd->arg << 16) |
> +                               (u32)cmd->uhs2_cmd->header,
> +                    SDHCI_UHS2_CMD_PACKET + i);
> +       i += 4;
> +
> +       /*
> +        * Per spec, payload (config) should be MSB before sending out.
> +        * But we don't need convert here because had set payload as
> +        * MSB when preparing config read/write commands.
> +        */
> +       for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> +               sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
> +               i += 4;
> +       }
> +
> +       for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
> +               sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +       DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
> +       for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
> +               DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
> +                   sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));

We are ignoring what we just read. Isn't there something we need to verify?

Moreover, the whole thing with i,j and the +4 thing above looks a bit
odd to me. I am not sure whether the above can be simplified, but I
leave that for you to have a second look at.

> +
> +       cmd_reg = FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cmd->packet_len);
> +       if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
> +               cmd_reg |= SDHCI_UHS2_CMD_DATA;
> +       if (cmd->opcode == MMC_STOP_TRANSMISSION)
> +               cmd_reg |= SDHCI_UHS2_CMD_CMD12;
> +
> +       /* UHS2 Native ABORT */
> +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +           (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT))
> +               cmd_reg |= SDHCI_UHS2_CMD_TRNS_ABORT;
> +
> +       /* UHS2 Native DORMANT */
> +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +           (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE))
> +               cmd_reg |= SDHCI_UHS2_CMD_DORMANT;
> +
> +       DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +       sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
> +}

[...]

> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +                                         struct mmc_command *cmd,
> +                                         unsigned long flags)
> +       __releases(host->lock)
> +       __acquires(host->lock)
> +{
> +       struct mmc_command *deferred_cmd = host->deferred_cmd;
> +       int timeout = 10; /* Approx. 10 ms */
> +       bool present;

Why do we need a retry mechanism at this level? The mmc core sometimes
retries commands when it seems reasonable, why isn't that sufficient?

> +
> +       while (!sdhci_uhs2_send_command(host, cmd)) {
> +               if (!timeout--) {
> +                       pr_err("%s: Controller never released inhibit bit(s).\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       cmd->error = -EIO;
> +                       return false;
> +               }
> +
> +               spin_unlock_irqrestore(&host->lock, flags);
> +
> +               usleep_range(1000, 1250);
> +
> +               present = host->mmc->ops->get_cd(host->mmc);
> +
> +               spin_lock_irqsave(&host->lock, flags);
> +
> +               /* A deferred command might disappear, handle that */
> +               if (cmd == deferred_cmd && cmd != host->deferred_cmd)
> +                       return true;
> +
> +               if (sdhci_present_error(host, cmd, present))
> +                       return false;
> +       }

If the retry is needed, would it be possible to convert into using
read_poll_timeout() for the above while loop instead? If so, please
make that conversion.

> +
> +       if (cmd == host->deferred_cmd)
> +               host->deferred_cmd = NULL;
> +
> +       return true;
> +}
> +
> +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +       struct mmc_command *cmd = host->cmd;
> +       u8 resp;
> +       u8 ecode;
> +       bool breada0 = 0;

Nitpick: Maybe find some better variable names. Like error_code...

> +       int i;
> +
> +       if (host->mmc->flags & MMC_UHS2_SD_TRAN) {
> +               resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +               if (resp & UHS2_RES_NACK_MASK) {
> +                       ecode = (resp >> UHS2_RES_ECODE_POS) & UHS2_RES_ECODE_MASK;
> +                       pr_err("%s: NACK response, ECODE=0x%x.\n", mmc_hostname(host->mmc), ecode);
> +               }
> +               breada0 = 1;
> +       }
> +
> +       if (cmd->uhs2_resp &&
> +           cmd->uhs2_resp_len && cmd->uhs2_resp_len <= 20) {
> +               /* Get whole response of some native CCMD, like
> +                * DEVICE_INIT, ENUMERATE.
> +                */
> +               for (i = 0; i < cmd->uhs2_resp_len; i++)
> +                       cmd->uhs2_resp[i] = sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
> +       } else {
> +               /* Get SD CMD response and Payload for some read
> +                * CCMD, like INQUIRY_CFG.
> +                */
> +               /* Per spec (p136), payload field is divided into
> +                * a unit of DWORD and transmission order within
> +                * a DWORD is big endian.
> +                */
> +               if (!breada0)
> +                       sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> +               for (i = 4; i < 20; i += 4) {

Again we do sdhci_readl above but just ignore the data. I assume
that's deliberate, as we are probably just interested in the remaining
pieces.

Moreover, the whole thing with +4 things continues to look a bit odd
to me. I am not sure whether it can be simplified, but I leave that
for you to have a second look at.

> +                       cmd->resp[i / 4 - 1] =
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i) << 24) |
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i + 1)
> +                                       << 16) |
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i + 2)
> +                                       << 8) |
> +                               sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
> +               }
> +       }
> +}

[...]

> +
> +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)

static void

> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct mmc_command *cmd;
> +       unsigned long flags;
> +       bool present;
> +
> +       if (!(sdhci_uhs2_mode(host))) {
> +               sdhci_request(mmc, mrq);
> +               return;
> +       }
> +
> +       mrq->stop = NULL;
> +       mrq->sbc = NULL;
> +       if (mrq->data)
> +               mrq->data->stop = NULL;
> +
> +       /* Firstly check card presence */
> +       present = mmc->ops->get_cd(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       if (sdhci_present_error(host, mrq->cmd, present))
> +               goto out_finish;
> +
> +       cmd = mrq->cmd;
> +
> +       if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
> +               goto out_finish;
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       return;
> +
> +out_finish:
> +       sdhci_finish_mrq(host, mrq);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request);

Drop this, it's not used outside this module.

> +
> +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)

This function is entirely unused. Did you actually test this with an
hsq enabled host? Or perhaps you have just added this for
completeness?

> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct mmc_command *cmd;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       if (!sdhci_uhs2_mode(host))
> +               return sdhci_request_atomic(mmc, mrq);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       if (sdhci_present_error(host, mrq->cmd, true)) {
> +               sdhci_finish_mrq(host, mrq);
> +               goto out_finish;
> +       }
> +
> +       cmd = mrq->cmd;
> +
> +       /*
> +        * The HSQ may send a command in interrupt context without polling
> +        * the busy signaling, which means we should return BUSY if controller
> +        * has not released inhibit bits to allow HSQ trying to send request
> +        * again in non-atomic context. So we should not finish this request
> +        * here.
> +        */
> +       if (!sdhci_uhs2_send_command(host, cmd))
> +               ret = -EBUSY;
> +
> +out_finish:
> +       spin_unlock_irqrestore(&host->lock, flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
> +

[...]

Kind regards
Uffe

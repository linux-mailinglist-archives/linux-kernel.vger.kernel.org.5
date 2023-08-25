Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEDC788434
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjHYKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbjHYKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:00:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B862107
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:00:19 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-592972da9a6so7546387b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692957619; x=1693562419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5UIQb/eeOE/85eBFbBN6HeTQWfUWEUKgLruaLwRSxTc=;
        b=TLWxRfXRDkr/vfHiMPaLwGEMzLb6ieehakvbzXnIqGNf3V6g0Ih9N7CRZlPg9WxEV5
         stDyFl50W4eo3GAGk0dIVfZYo9IeSpvxi7mgXLXWzlOTDS3GG7VABQdp/xKDkLlZ64eB
         uIPjAceyynwXOl9+NPZh0LYaIwrku9sLAgM3NLeM2ZVk8vdkNbXIH2ApcdDpZogloYrw
         HAJ8I1h7MlgpZT2lByDmAYqtWR8evg6e8WQF3VXXvHrLc0sd5EmcKlMUJqpgyj7snMZW
         /6BdDoi/ZfR/mAf9oM0zhxCjuauE1+vIoA9rsIrId1uvv/q7eNgicu6Y0HDVGuoazs3c
         ICeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692957619; x=1693562419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UIQb/eeOE/85eBFbBN6HeTQWfUWEUKgLruaLwRSxTc=;
        b=iIMMJlypUfT66O8Wl11tkS6DlPHz12teHQt+imHIfhxQFJzzGOj3QDDtpUKOqfGW28
         zWHOxjhINbZnXsgueHlv7lMzkOfJVQ2UY7mBDKRHDMOLEjmTGqZIipkDs7pIVjb5Itb7
         gUh+s8OKIV+6qNHER4EYO5tP5tAVDftWGtW40G4Z4yNHXLOSp3ExbER/bS4nwW+HW+G9
         eo4efLE0Z9L/1hQp/psCW4plszFs4mU4JbAbFWz4bBQqVYOGyb7J1YUQHWoM3MlmD0N7
         6rlSGtyT5ObzGQmdsIQsRynWcUlOaORhpc3FKx+ODMq+RKMfLvsSDbkg5tk1YBpE1ELR
         vZ9w==
X-Gm-Message-State: AOJu0Yxhvj5f2/uB9gnftpHBP4ASmdN1OR4TX22jRPOubuxz5xoh1ia6
        gbC+QoBszDJYiZkSmCO4gZNcxT1llENtfEMMmY0cCw==
X-Google-Smtp-Source: AGHT+IHWdBDNnJaCqx17itCTuTbzGUmGoy3wuFxLEPG7iF9R+hGAewU83apq7KbH5xTJJzHsrrUYc5Uf99bhG0tinps=
X-Received: by 2002:a25:7352:0:b0:d0e:8b3b:1e12 with SMTP id
 o79-20020a257352000000b00d0e8b3b1e12mr18053604ybc.38.1692957618790; Fri, 25
 Aug 2023 03:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091743.15613-1-wenchao.chen@unisoc.com> <20230825091743.15613-2-wenchao.chen@unisoc.com>
In-Reply-To: <20230825091743.15613-2-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 11:59:42 +0200
Message-ID: <CAPDyKFqj3f3sjfNsYEs8cuyqwirMN_vnKVnFWTBghifpEukOTA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] mmc: core: Add host specific tuning support for SD
 HS mode
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
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

On Fri, 25 Aug 2023 at 11:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Added .prepare_hs_tuning and .execute_hs_tuning host callbacks to
> support host-specific tuning for SD high speed mode. Howerver, these
> callbacks are optional, host specific - and that there is nothing
> in the SD spec that mentions this.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd.c     | 14 ++++++++++++++
>  drivers/mmc/core/sd_ops.c |  1 +
>  include/linux/mmc/host.h  |  8 ++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 246ce027ae0a..c3e554344c99 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1518,6 +1518,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                  */
>                 mmc_set_clock(host, mmc_sd_get_max_clock(card));
>
> +               if (host->ios.timing == MMC_TIMING_SD_HS &&
> +                       host->ops->prepare_sd_hs_tuning) {
> +                       err = host->ops->prepare_sd_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +
>                 /*
>                  * Switch to wider bus (if supported).
>                  */
> @@ -1529,6 +1536,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>
>                         mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>                 }
> +
> +               if (host->ios.timing == MMC_TIMING_SD_HS &&
> +                       host->ops->execute_sd_hs_tuning) {
> +                       err = host->ops->execute_sd_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
>         }
>  cont:
>         if (!oldcard) {
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index ef8d1dce5af1..a59cd592f06e 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -323,6 +323,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
>                                   64);
>  }
> +EXPORT_SYMBOL_GPL(mmc_sd_switch);
>
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr)
>  {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..62a6847a3b6f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -184,6 +184,12 @@ struct mmc_host_ops {
>         /* Execute HS400 tuning depending host driver */
>         int     (*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
>
> +       /* Optional callback to prepare for SD high-speed tuning */
> +       int     (*prepare_sd_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
> +
> +       /* Optional callback to execute SD high-speed tuning */
> +       int     (*execute_sd_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
> +
>         /* Prepare switch to DDR during the HS400 init sequence */
>         int     (*hs400_prepare_ddr)(struct mmc_host *host);
>
> @@ -665,6 +671,8 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
>         host->err_stats[stat] += 1;
>  }
>
> +int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);

We need to drop the corresponding declaration in drivers/mmc/core/sd_ops.h.

> +int mmc_send_status(struct mmc_card *card, u32 *status);

We need to drop the corresponding declaration in drivers/mmc/core/mmc_ops.h

>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> --
> 2.17.1
>

Other than the small thing above, this looks good to me!

Although, no need to resend, I will amend the patch when applying.

Kind regards
Uffe

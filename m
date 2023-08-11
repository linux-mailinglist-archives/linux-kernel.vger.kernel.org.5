Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF67778C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjHKKq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjHKKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:46:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3E18B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:46:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a751d2e6ecso1629168b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691750778; x=1692355578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qiK9QQkmWGibkXDupuX1/u2qOmOZsbLeQR1shFpbLw=;
        b=N8KQMpWUaBQoFASi1LrYMn01wqD5AzTzOt1sXSrT6FI4DBBUJJVewfHliIzgpUKz/M
         To/be8Z/aiy43kJPnDlEpj1T9R7GnmNoCgsS6Rc1RIJZ2aiW0IOEnj77NHwenhuTar+n
         SRoXK1npqZmq7aVkojzc4ffmWWwO89YxYb3V09fN5kNXBLoVv9s2ndZp86rchm1waNQN
         F7GUV+NzoAaHe5ypWeMc+N8C1Rlj/M+OGx7tGhEz4WUe+oN3Md37l8EuH5f4PteCwuE1
         OBvMWpnaJKf2jewHFyNKZIX4SmTIKGmfUvgVCjSlH5RNHXF8iyaaXWMDVnVxpveKRk7f
         HYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750778; x=1692355578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qiK9QQkmWGibkXDupuX1/u2qOmOZsbLeQR1shFpbLw=;
        b=AZykLnltczKtNEHAZIVLSW7RuSrwNbNi169R6u11JTpg9FIy9Zzt3dAfqDd6v+iUNP
         l4Vn7qvcMfc2ACwf41fxwhbM5+Qb+X4Jio+ZZ63zOrcsRhInEvp2+EKp2tcXY1UQbesU
         V9Z3gCUNUeSWwtnX6RsyH5HwVGu3xJTPLJZxWkeZvv10FDzTZT9KtfBNTux6+Szx8IzV
         TfObEpLpkUG/2eZFb2NsslI7LS7ObAiRiD5pYNbupntox3z8K7QHN36ZXTy58zliKQj7
         SIpTjI6+iOVTYr5F+12jFc85FAq9OIeUdf6sPtfhRkuG04tUt9y7Ytj++9aOaLfn5WnP
         NAeQ==
X-Gm-Message-State: AOJu0YxjRj9KsPojUwt6dvNEQDHE8jhY+e/uQDfDH4UWbJ9ND5oXIMUk
        0aRiwsBmA2nzcwjX3BLa5sLO7U8vHnJ9CZfzMkTHS1s8nelFn+pm
X-Google-Smtp-Source: AGHT+IFe/i5L5NvxoTbpB+1MM9NrtWX08M2yz/sA2CoxQuo7uMIN2bfeqZkvP9FofDet5W1M6/Oi+s9uPSCT+BYGPIU=
X-Received: by 2002:a05:6358:920f:b0:139:d4f2:b03e with SMTP id
 d15-20020a056358920f00b00139d4f2b03emr1684222rwb.6.1691750778606; Fri, 11 Aug
 2023 03:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230811101404.4463-1-victorshihgli@gmail.com>
In-Reply-To: <20230811101404.4463-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 12:45:42 +0200
Message-ID: <CAPDyKFrCObwmjnZP0Nc3FUfckvjSFMSM0dpfmp_2gPpgYdiRhg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Cleanup mmc_sd_num_wr_blocks function
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Use mmc_app_cmd function to simplify code in
> mmc_sd_num_wr_blocks function.
>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next (by amending a minor part, see below), thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..c665b25bffc3 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -918,17 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
> -
> -       memset(&cmd, 0, sizeof(struct mmc_command));
> +       err = mmc_app_cmd(card->host, card);
> +               if (err)

This is one more indentation than required. As I said above, I have
fixed it up before applying, no action from you needed this time.


> +                       return err;
>
>         cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
>         cmd.arg = 0;
> --
> 2.25.1
>

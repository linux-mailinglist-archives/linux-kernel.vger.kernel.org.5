Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62D7A1093
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjINWJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:09:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252D2120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:09:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ccc462deca6so1466199276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694729379; x=1695334179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=97JhCG6zT6B7+SMugkJ45haE3nskGaAz9YD6QLxdNWA=;
        b=zwB2xIEQDSN8CjpndNUnoA7xo3SMnHBbeYp4W/AvH5szeU5tj4Azz3ca8269glqJ/R
         sC4DEOFUSrhq8FaWA7oe+cAK1ANpxtKTCV7BrQr9bJxzjKYBrRcBVgTzA3viycvFuHJF
         9eGpAZyM2hgsUSrsNFaPZgQUZSKECjy7aVHz03V3asFd/z2WuTv+X6nLDzWewT5DLD2G
         sx7MWdlSb3mg0iLWT4zLujyDUxBLeGFo9mJ/Yns0o3fYQPYu05UjeJurBTdUjiUEtQvh
         5zELfUaYTssSfApYXdctMbrB4qaFkkKuNzwONunyty5y5gvSIbkdkUv+h7tBwfau9pR3
         WpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694729379; x=1695334179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97JhCG6zT6B7+SMugkJ45haE3nskGaAz9YD6QLxdNWA=;
        b=SKcQwaQ5duuYGFmWLKMWpihgrpX4ykpK+dUTMeATdud8sw+m2ZETTXkQsW+jL4/eFA
         miCTT1G36WFcYTAcnCbnZWcAgsubtpNQw11VemwcyunAdoU4RwzqzU0emLKx700JXjZw
         JYRQaez1xa27LOXWC5KkonqGu9UJN0a+Sfl6CpVkKq2nsHhjMlTUGc2QZ6c0EdTUQUGJ
         Ltp3SiXfvP4T7udCFaVjSkh5JbtRzocrvxjFMeUoyuPEMCCFBwSqjuDNTH1uTT9QxgZ/
         ceuaS0gR9ALc6CqPnhbj8NrD1QZ9lL4D/7kWQIWdBvHFDytX8K6ph/rJZ6AJLeYswsz0
         HYkg==
X-Gm-Message-State: AOJu0YyhvFrD7uzhbTkIRW/NsRtnC1XtHrufqLT71eDs9FjbixdWxZCD
        FCNRvWE+UtepUNUfOq8bERd1aGo3h4iXzXS0mqwZfA==
X-Google-Smtp-Source: AGHT+IEcbGqOpg5LJtzsNrqES8vQmdyxgmljQj8ZCrKtPz48cJO0h9zvdtNGsftBR/rQAtaxzYM27BNlLXN/d+TnDFQ=
X-Received: by 2002:a25:9d04:0:b0:d78:48b0:21d2 with SMTP id
 i4-20020a259d04000000b00d7848b021d2mr5894012ybp.3.1694729378893; Thu, 14 Sep
 2023 15:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230914202749.470100-1-beanhuo@iokpp.de>
In-Reply-To: <20230914202749.470100-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 00:09:02 +0200
Message-ID: <CAPDyKFruYooG4yQ4yqrwEcrvy4xe6hYByF2Q57eQ1g0tiUtcug@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 22:28, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.

For my information, more exactly, how can we trigger this problem?

>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
> Tested-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org
> ---
> Changelog:
>
> v1--v2:
>     1. Add Rafael's test-tag, and Co-developed-by.
>     2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
>
> ---
>  drivers/mmc/core/core.c   | 7 +++++++
>  drivers/mmc/core/mmc.c    | 5 +++++
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  4 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3d3e0ca52614..86a669b35b91 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -259,6 +259,13 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>                 host->cqe_ops->cqe_off(host);
>
>         host->ops->request(host, mrq);
> +
> +       if (host->card && host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&
> +           !host->card->written_flag) {
> +               if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +                   mrq->cmd->opcode == MMC_WRITE_BLOCK)
> +                       host->card->written_flag = true;
> +       }

I don't quite like that we are adding the above code here - as it's
used for *all* requests.

Seems like the flag is better set from the mmc block device driver
instead. Somewhere in the path when we serve I/O write requests.

>  }
>
>  static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..a2edd065fa1b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>         if (!oldcard)
>                 host->card = card;
>
> +       card->written_flag = false;
> +

According to your earlier reply, it sounds like the problem isn't
really about the card being re-initialized, but rather that we
actually need a write request to happen before a flush. No matter
what, no?

See more about this below.

>         return 0;
>
>  free_card:
> @@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH && !host->card->written_flag)
> +               return err;
> +

Could an option to the above, be to reset the flag here instead. After
a successful cache flush has been done.

>         if (_mmc_cache_enabled(host)) {
>                 err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..5e68c8b4cdca 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>
>         /*
> -        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> -        * support being used to offload WRITE_ZEROES.
> +        * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
> +        * WRITE_ZEROES offloading. It also supports caching, but the cache can
> +        * only be flushed after a write has occurred.
>          */
>         MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> -                 MMC_QUIRK_TRIM_BROKEN),
> +                 MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
>
>         /*
>          * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..7b12eebc5586 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -295,7 +295,9 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
> +#define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>
> +       bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
>         unsigned int            erase_size;     /* erase size in sectors */
> --
> 2.34.1
>

Kind regards
Uffe

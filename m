Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC027FECE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjK3Kev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Ket (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:34:49 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFEA10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:34:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da30fd994fdso1549972276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701340494; x=1701945294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j350QJDKEuHqSIhgnqrzjS7NiG3vRDy7K5wFB+bsbRE=;
        b=neGvdV0QQLiEVpfl0eQmDr6ELBYno7YaSQTuOBwf12qNB3IdA1/PxvfOtSGkl11UO5
         5lGGzMPGEuod6RqhbEICZ0Bjfp2oLnxkFQ4RKzKYacjJCOMQe/fEXs0EA0adW9ny+q1h
         5Y90gAwsV0YNuJHh3OYDlSVMVKr3bAHwQz9sic6hV/f1i5gNzBvs5Z6u4OuSoMIiPxbx
         wD70Ln/ecm9ts0DnrwziKZk4LKh8wXdquqIEIVWgd1FlD0BqFvxhObSXCUzeGE48SAdb
         ft77Uz693+1lYXBmjnJwS58S0MJVvt/1cGopsVR/ngWcRhBTii/4VNs9wOyRqX1Nnahx
         SDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340494; x=1701945294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j350QJDKEuHqSIhgnqrzjS7NiG3vRDy7K5wFB+bsbRE=;
        b=q/sYowgpxGwdjYvR3WlPWBjHniAdj9JkDwtRxzvZbPeiW0FmHO+MKJ6Z3IbGjs+Hea
         vNfZer6AlzEDlW62Etj3H6WafVOpHylC+IdqgU9iqcpNwA47Taz3chp52eiY34bbQHHR
         K+Ze38LoR4G6aLOgix72vBWiml8Ng4sGB55ELViK/LwAkGtFM0FeEvzKmNjm6Z/70vG0
         BA4F1oAcaoCl2tRYzC+8GYhYlCVte+QKzUALTOJMaO9zNpJmMai8X2CJeaotfTF9Y0Qj
         oOwtvfIJPjdMYpO+tmchZbryvJy6LG9lb2BxQVC0rMPXIhaWqPKtALitJuSWgR9W7S6w
         yuAQ==
X-Gm-Message-State: AOJu0YyMY99zEjasBrrbeAYB8dtKyp1IpbasKhjif+QC10IuViYc3hCw
        uVuYQJeKvriGsuuSGlFKAVokfQtOjRP7L/WJb2JjXQ==
X-Google-Smtp-Source: AGHT+IHIGd5TmO3x8SVxvdIBwlzRcFlSXh5JGmBGlxogwl199SBDEnpsMYwlXtjGSw6Qw2kKIimMEWvc8SIZXKYejaM=
X-Received: by 2002:a25:9708:0:b0:db4:354b:77b1 with SMTP id
 d8-20020a259708000000b00db4354b77b1mr16979757ybo.32.1701340494561; Thu, 30
 Nov 2023 02:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20231129160533.2827458-1-jorge@foundries.io>
In-Reply-To: <20231129160533.2827458-1-jorge@foundries.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Nov 2023 11:34:18 +0100
Message-ID: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     CLoehle@hyperstone.com, adrian.hunter@intel.com,
        jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com,
        yangyingliang@huawei.com, asuk4.q@gmail.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> re-tune before switching to the RPMB partition would randomly cause
> subsequent RPMB requests to fail with EILSEQ:
> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
>
> This commit skips the retune when switching to RPMB.
> Tested over several days with per minute RPMB reads.

This sounds weird to me and needs more testing/debugging in my
opinion, especially at the host driver level. Perhaps add some new
tests in mmc_test, that does a partition switch to/from any partition
and then run regular I/O again to see if the problem is easier to
reproduce?

The point is, I wonder what is so special with RPMB here? Note that,
it has been quite common that host drivers/controllers have had issues
with their tuning support, so I would not be surprised if that is the
case here too.  Certainly I would be surprised if the problem is at
the eMMC card side, but I may be wrong.

Kind regards
Uffe

>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  Fixes v1: kernel test robot identified typo causing build failure
>            CIF_MANFID_SANDISK_SD --> CID_MANFID_SANDISK_SD
>
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 7 +++++++
>  drivers/mmc/core/quirks.h | 7 +++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 152dfe593c43..9b7ba6562a3b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>                                 return ret;
>                 }
>                 mmc_retune_pause(card->host);
> +
> +               /* Do not force retune before RPMB switch */
> +               if (mmc_can_retune(card->host) &&
> +                   mmc_card_broken_rpmb_retune(card))
> +                       card->host->need_retune = 0;
>         }
>
>         return ret;
> @@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);
>
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
> -
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index b7754a1b8d97..1e1555a15de9 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -85,6 +85,7 @@ struct mmc_fixup {
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> +#define CID_MANFID_SANDISK2     0x45
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
>  #define CID_MANFID_KINGSTON_SD 0x9F
> @@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
>  {
>         return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
>  }
> +
> +static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..56c79b6b3537 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
>                   MMC_QUIRK_BROKEN_SD_DISCARD),
>
> +       /*
> +        * SanDisk iNAND 7250 DG4064, this quirk shall disable the retune
> +        * operation enforced by default when switching to RPMB.
> +        */
> +       MMC_FIXUP("DG4064", CID_MANFID_SANDISK2, 0x100, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_RPMB_RETUNE),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b12eebc5586..bd6986189e8b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -296,6 +296,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
> +#define MMC_QUIRK_BROKEN_RPMB_RETUNE   (1<<17) /* Don't force a retune before switching to RPMB */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1

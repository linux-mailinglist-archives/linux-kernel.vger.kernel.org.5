Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C89773F78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjHHQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjHHQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:47:47 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC5646FF4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7679ea01e16so466517185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510183; x=1692114983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvQJ94JUmNmfWnFUJ3zsqGbPSkM92W/OFcGzXCWoFs4=;
        b=ECQLYA1mUEIM62nkR5mxPlao6olDs68MaPebZhP1MWlp/JaK5h5RnDqO6mKXfK6i1l
         oYMZC05c11UKdTCtEKSSd4vttgVrbVQH8kCpDRLghzXk80OICSpTbREkl0thg3/mFRqj
         tiwCKyaT+JJT/Fm2gYEoF7ZfyJjP5iTMXuar7MHLpJ0bZxI0UCbA8tC1yoNITovOulES
         BYukbng0WA/c8FuySe36Q02ev/qqKkDCS85TUaUaosaTdU1zQE+XNFdMAGIWJu1jXk4Y
         bz37E4rlij0S5S82Wo9V8udJdqnd3H019zA4IZC/0mvGoesqicOXmdiMLnZSd1uxmlSy
         4DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510183; x=1692114983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvQJ94JUmNmfWnFUJ3zsqGbPSkM92W/OFcGzXCWoFs4=;
        b=Hr0Hj8q1hk05e94qGmfFpIKa4vIlH4R1tse0GPWBbewHKdhoCIgGmZxDljNkMoG6yR
         ukX9+wYE7xtjYrTHox912FpKLq52mLqeSpgU7Mm8pIx1id+MspERy8+A7ZaXXMtCT6Ef
         Izrh/znrskaH9e1RkuKLf6cHffrd1Lx/tl2Y6uZFlhSJr0vSpeiXUwxml17/eOZLGHiT
         mtWCl8BVUpu15U2S4yQWJ4WAs0uyfsw9LdEbuJUIiOmGSDsECbi5RooVjoI6Ih/0Dw2V
         i3xrx4NQK8/a2G2qvtCXLUoPPXwKxOGMfg2byRg7H8GyyoSzMBZ6WUbLDqeffHB3XXH3
         ag9w==
X-Gm-Message-State: AOJu0Yx/KMCsOKUwDbZ2MLxheB87+xjMBB1dkqjS1/1u/hqOpIH8xah6
        xLCRfEC0ejNSFyT6EX/PkXo7x6kdHPjPMlSit2Tzn/2CSrMoGEH/
X-Google-Smtp-Source: AGHT+IGcfGDHJOh3NFEhcurjPG+eORblU9sLlaVH023b0D+QUvpipgKZ7PJt4cDghdwhXu6F9+XQMTX5S+Eh8t4p7z0=
X-Received: by 2002:a25:690f:0:b0:d0e:9914:f5e1 with SMTP id
 e15-20020a25690f000000b00d0e9914f5e1mr9990126ybc.15.1691490316183; Tue, 08
 Aug 2023 03:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-4-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-4-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:24:40 +0200
Message-ID: <CAPDyKFqFbp-rbRBZ7eYtR1HXJfYuhiCLbFM8bSv1a-9gtZd6vg@mail.gmail.com>
Subject: Re: [PATCH V9 03/23] mmc: core: Announce successful insertion of an
 SD UHS-II card
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>

Authorship?

>
> Update in previous version:

Please, drop the above.

> To inform the users about SD UHS-II cards, let's extend the print at card
> insertion with a "UHS-II" substring. Within this change, it seems
> reasonable to convert from using "ultra high speed" into "UHS-I speed", for
> the UHS-I type, as it should makes it more clear.
>
> Note that, the new print for UHS-II cards doesn't include the actual
> selected speed mode. Instead, this is going to be added from subsequent
> change.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V7:
>  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
>    mmc_card_uhs2 function.
>
> Updates in V4:
>  - Make mmc_card_uhs2() take struct mmc_host* as in-param.
>
> ---
>
>  drivers/mmc/core/bus.c  | 4 +++-
>  drivers/mmc/core/host.h | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index cf32cf135781..d9a3b3d38d8b 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
>         if (mmc_card_hs(card))
>                 speed_mode = "high speed ";
>         else if (mmc_card_uhs(card))
> -               speed_mode = "ultra high speed ";
> +               speed_mode = "UHS-I speed ";
> +       else if (mmc_card_uhs2(card->host))
> +               speed_mode = "UHS-II speed ";
>         else if (mmc_card_ddr52(card))
>                 speed_mode = "high speed DDR ";
>         else if (mmc_card_hs200(card))
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 48c4952512a5..9f6e5e31dfea 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
>                 host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
>  }
>
> +static inline bool mmc_card_uhs2(struct mmc_host *host)
> +{
> +       return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
> +}
>  #endif
>

Kind regards
Uffe

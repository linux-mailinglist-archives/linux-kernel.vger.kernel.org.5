Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5E7E0224
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbjKCLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbjKCLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:17:16 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF524D69
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:17:01 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a82f176860so23427437b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010220; x=1699615020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWqvGHOpDjXeJF4gaG5FvSChunLowe+31JAI0Z5rk34=;
        b=aTAeo++ufcpuOK6ygynGRX8GpEjrCX4iIsxGeSzbXaI/UKqI822QKIIZ7KYNfbZL6W
         q7ZuC/BGDP7M7RxUi84roEW10U/GV3F1+ITWIErXRQD7d0j86xRq3eztwsU6C+B3NVki
         SUgg4HVAQX2aBtJmbJosEktwRXGkmr4D/HuzOB5Sc7MOUXRz8HZRPnFfLfCbGlWsJysp
         XZlmDIEfk4O228DHLlYe1dGixLQAYCmwmbvNEzQn+j6KRRaUUTEJwWxVJeR8agxVBhnS
         dVbfe993pSvGL8axGrZTLwphROUuFWh/dULncYfyOZRy0xo/WE6tvlqIMpA0iG042yZ8
         7K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010220; x=1699615020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWqvGHOpDjXeJF4gaG5FvSChunLowe+31JAI0Z5rk34=;
        b=g2oPNO2a3E27RG5kr18tbybREzA9WAnCU4BTl3ExuCHQSK4iFlTccuCGLJfswSuLlg
         7rac4swx/QnsfoYLeZr6qQY5EKFxd5IFl6uraM2XWZKq2OXjS3LEAHEydopaWT4V3S9O
         iCsrTpfYxdrhW20UTBrcIkdgc00eMQs9+Rv1Hr7B3HTk9sUlfpZmlWph5n7hz+paE+IN
         FToCm07WRiU8+HrGdge9m0n91TsPTgBE9qbvX8leQbUOzUMajBU+KStkKYJdZMxLAdBs
         FR0vX0Zf85svbjLx/+BUr6TCXmDBWCGBDM3Gkp8cQscYHy5h8fjG7ApyZC92vJU8xM7Q
         gIMw==
X-Gm-Message-State: AOJu0YyC5tHBEHKllkJN/Vlb3a0lHqn8+GtQqGo2TC8BoiEUql339RZ2
        x60kjzXPsL3VE1Yx5n5EYDx4ySawMkyPky/GrQeDXw==
X-Google-Smtp-Source: AGHT+IFLVZi6pW8xuPrCXex8Mha8wM8l8BM1AAWvvxpzrUbGuBa0q1spsqLLCOnrl8AxOXZ62UTRQpiJM5P5rka57OE=
X-Received: by 2002:a81:4f04:0:b0:5a7:e5b8:997a with SMTP id
 d4-20020a814f04000000b005a7e5b8997amr2573913ywb.10.1699010220701; Fri, 03 Nov
 2023 04:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231103004220.1666641-1-asmadeus@codewreck.org>
In-Reply-To: <20231103004220.1666641-1-asmadeus@codewreck.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:25 +0100
Message-ID: <CAPDyKFrPaScaQE340g8cD_xR+KoX=JuSc9xtCW=B+HZKYjf1aQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: Capture correct oemid-bits for eMMC cards"
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Alex Fetters <Alex.Fetters@garmin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 01:42, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> This reverts commit 84ee19bffc9306128cd0f1c650e89767079efeff.
>
> The commit above made quirks with an OEMID fail to be applied, as they
> were checking card->cid.oemid for the full 16 bits defined in MMC_FIXUP
> macros but the field would only contain the bottom 8 bits.
>
> eMMC v5.1A might have bogus values in OEMID's higher bits so another fix
> will be made, but it has been decided to revert this until that is ready.
>
> Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
> Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
> Link: https://lkml.kernel.org/r/CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: stable@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Alex Fetters <Alex.Fetters@garmin.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Here's the revert as discussed in "mmc: truncate quirks' oemid to 8
> bits"' patch thread.
> Feel free to ignore if you already have something, I just checked your
> -next branch quickly and might have missed it.
>
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4a4bab9aa726..89cd48fcec79 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>         case 3: /* MMC v3.1 - v3.3 */
>         case 4: /* MMC v4 */
>                 card->cid.manfid        = UNSTUFF_BITS(resp, 120, 8);
> -               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 8);
> +               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 16);
>                 card->cid.prod_name[0]  = UNSTUFF_BITS(resp, 96, 8);
>                 card->cid.prod_name[1]  = UNSTUFF_BITS(resp, 88, 8);
>                 card->cid.prod_name[2]  = UNSTUFF_BITS(resp, 80, 8);
> --
> 2.41.0
>

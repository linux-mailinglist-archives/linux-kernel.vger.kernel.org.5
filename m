Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30637A07CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbjINOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbjINOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF91212B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:48:27 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ccc462deca6so1071382276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702907; x=1695307707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHnyXM9iWun5gDg2V2UcdiXw8a0neXTJfRyHDyENrUw=;
        b=OJ+Dkgoq48x0rX0et23/2BxL55+cxwf939yZNbqYe0hN6w5JYD9RwkZpSB1aNL5dkd
         /QBclTmOfes2GdG497I/Jpw8A7kaG/u1T3VyDyc1nJO4qXDasQLYd+0kBhI/KyB7KhVz
         UyPNWYXWyhkPBkiFhN0jd5cqhG6VH1A8PoLrFAGR8H5tI0iGIAfMgM78U9rIjCapBkRZ
         RPqsHewH/Ru9tB69kVJaSPPlK9PRsH3cweZCfVT49lcp28k1wCOS3hkoJGNgMS8CkVvx
         T5fsYP6LDCYBB/T6oUMHVMUcdCZBNIJ/1nvibznP/MSo3H2wKCJTsWhYaAaKbjz+bWxp
         EVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702907; x=1695307707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHnyXM9iWun5gDg2V2UcdiXw8a0neXTJfRyHDyENrUw=;
        b=rc138lcebDkCrhXXbyr+spD2fOS83aZr+168zlQAFSvlCh9egYekc02GYVUZ2VA+v4
         wgMPJR0mIlnedIsptT2DjSvg4ziicSqIP5L6O7BNuag+wFLVvn4WqakyzBaCjaAfht6w
         d58EZbCVUbabDKA6cixRJaZT7pTAKtyGV6kxtJgVcbr1yqp7bcaQFY2BswZdF/32gbbr
         kcN9VQ7xhAOp9X3BsjkVkVDGXgo3XmGGQwetuSLawECQvS8jCmGdPEcoClURG8sLS4jz
         hlUweKaJ4bf3w8tLyKAv+NALx0SLXWgRqT3Zma4y7Q1LBvuYrND6u4amdvHoj1Ha7FOu
         grzw==
X-Gm-Message-State: AOJu0Yw/x1IpXI0U+k6ZWEM53gYerNHYYxmFfiWXBkBOxyZoWFrnwf0c
        hlRKYiMryRHc4+bBXsroDiWZ/bNbFItbrYx9M8mb2VSA9Aa4EBzxnes=
X-Google-Smtp-Source: AGHT+IFrBqJVFRhUjU+GOYR2KuKQmlRFYDg5GxyPhnCoeJo8mUD0Mo6bSjMZIABaCiOabng0W8DB1mJEYewu9KXfL7M=
X-Received: by 2002:a25:ca45:0:b0:d81:afb1:bf77 with SMTP id
 a66-20020a25ca45000000b00d81afb1bf77mr883782ybg.28.1694702907011; Thu, 14 Sep
 2023 07:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230911092540.76334-1-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230911092540.76334-1-balamanikandan.gunasundar@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:51 +0200
Message-ID: <CAPDyKFrGYiOUgfoHo1K2e+UyDmhVgyFX0xhr2mmmjiiBGhzx7A@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Add description for struct member
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        aubin.constans@microchip.com, alexandre.belloni@bootlin.com,
        hari.prasathge@microchip.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 11:26, Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:
>
> Add description for dma filtering function in struct
> mci_platform_data. Fixes the warning: Function parameter or member
> 'dma_filter' not described in 'mci_platform_data'.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309020937.C5S2sRnr-lkp@intel.com/
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 535783c43105..33d02a7e72fb 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -227,6 +227,7 @@ struct mci_slot_pdata {
>  /**
>   * struct mci_platform_data - board-specific MMC/SDcard configuration
>   * @dma_slave: DMA slave interface to use in data transfers.
> + * @dma_filter: Filtering function to filter the DMA channel
>   * @slot: Per-slot configuration data.
>   */
>  struct mci_platform_data {
> --
> 2.25.1
>

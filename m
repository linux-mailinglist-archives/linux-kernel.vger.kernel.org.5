Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C8775D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjHILea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjHILe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:34:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFE1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:34:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-585fd99ed8bso11502197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691580867; x=1692185667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zrCQCNTr7PmrFVQwXDBalv2S/rUXoounsLWJzHy5nZs=;
        b=MoHKr8BUDiCxVsI9iHGBgaZxbG8dCYCsEslVfJbIA3n1/7siRMzKno5Cc1zHSeSzad
         2ol9dYCh7bJj7YmpSthOWoqueqNbPgP/i146CnufGBj93bFfvCPNDVbxFVE04ga63NLD
         LlqGl68OCDz+JHbHYoAbRUPPemYYanf7+/XpgmMh0Ems9vkm1HG/3mV3LTL86iPcOski
         Bzo2z4PFJanjigjp9TPiDZetakq6wUCW7FS8AjmA9CuekSDfsJpUxqdQqtame9mFwA1m
         VFK/bJV5GhMP29twYqsdsuOPGWsTQYsvOKvnbjW/Go0+Jo8XqxNwIfPoc3KBIUb+VBhI
         EMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580867; x=1692185667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrCQCNTr7PmrFVQwXDBalv2S/rUXoounsLWJzHy5nZs=;
        b=RUISD6KBVGJBLQYjFLSArfzLMOKHh/NyfoYn/QTuY4On/XkqdA49roGQpO9SVVm7y6
         W4lrIbpkZFV6bLOyDEqxVLYC0JXb1pxowJFoVIfzO6TEbv5I532QJHDt1kOuyJCZ/LDS
         hTtRBe+i6SfUIMaff0KlqTcxv/ySYxqLX33dcywnlJPQ7mC8PLNeDEbaZ9zXEz5xHKEB
         SvT5EpXpQCBl1opXqCkXJCDHkUsSQUZRJ4u1CRb3bicmXfXt+Nl+Q7zOWc4jYU3QzHsw
         tj2BIy2XzuFoptJq4EhZfDnpRFunapM8hKmHQliY3Dp3w35gwtpqsGRTharx6hGZSKDn
         QrXA==
X-Gm-Message-State: AOJu0Yyy8sDLipyFScc2sVKMTjUPCQK8ri5tinRHbRGPjA2pu4duToAN
        7SvCv4nFQAFXfQ4y5jWDR5KVnsUmWIGZqnId6oA/uA==
X-Google-Smtp-Source: AGHT+IFBt+QKwu19ghXHub6TTlceqXVlnEQR3xuUMmLYBp9ZlvijQF3zUnRUNo5RnpNcOMkCVm3WNHD3MWIQBUJ2OWo=
X-Received: by 2002:a81:6c4f:0:b0:583:4f67:d5bd with SMTP id
 h76-20020a816c4f000000b005834f67d5bdmr2020845ywc.20.1691580867398; Wed, 09
 Aug 2023 04:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com> <20230809071812.547229-2-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230809071812.547229-2-harshit.m.mogalapalli@oracle.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 13:33:51 +0200
Message-ID: <CAPDyKFqHnHCpsi+GBAQ2vmESf17rDMGyUK+EtZbhJT5AngvmBg@mail.gmail.com>
Subject: Re: [PATCH next v2 2/2] mmc: sunplus: Fix platform_get_irq() error checking
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        dan.carpenter@linaro.org, arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        kernel-janitors@vger.kernel.org
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

On Wed, 9 Aug 2023 at 09:19, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> The platform_get_irq() function returns negative error codes on failure.
>
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v1->v2: Split into two patches as they are doing different things.
>
> This is based on static analysis with smatch, only compile tested.
> ---
>  drivers/mmc/host/sunplus-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index 2bdebeb1f8e4..e9cb1a57cb75 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -885,7 +885,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>                 return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
>
>         host->irq = platform_get_irq(pdev, 0);
> -       if (host->irq <= 0)
> +       if (host->irq < 0)
>                 return host->irq;
>
>         ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> --
> 2.39.3
>

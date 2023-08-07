Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7CF772972
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjHGPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjHGPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:39:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45290C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:39:27 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d16639e16e6so3808187276.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691422766; x=1692027566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IWD3pGTueUh+PIZSRWHAOQaLUA6J2+H+8YFL2MGqrk=;
        b=XEiArS8k7p93STALE3vkhUNd7KL37Q3hom0T6EG483c1Y3m+QCpd8qcEpRXCyxjSvm
         k5eRZBqhX99h9vKXswclIbeWBFjLbNB26fcp100ImVsHxBWdePfLg1GdZq525GlwDp2R
         7ioghDAMfIhA0oAa/F+tCOHicvFs887cNXZjM8TKe7H/F7UM4NkbV4N38gIPaDTxLXtl
         tueX2C5ZnYVPSomnaE3O9PM0MXnIVk86cukB4TZGhzRFk+uLCqaag170N5BERp6gCCRF
         TJoNWXZi94W0GYR8oqEaa48Fa4ofAR3cliiyWdnbQn/dY3wwqtfxImY7aXQM/60NILnO
         GAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422766; x=1692027566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IWD3pGTueUh+PIZSRWHAOQaLUA6J2+H+8YFL2MGqrk=;
        b=W2pe2IgnN/0otg5lRTOmIW2H8nGCji+T4fz9sREMsYlY+3GWMq/vOQZrCuYQCPidvt
         Oe6uKqJo+iMuwUaSGSSBHwD+qORqe48TW/1ToyPmPqqE1wkvFjwxCsx2uS2XgvFN1TN3
         lLc7T1lPjeII6xVMNvFMzvcRJtA1Hne/VwJ7iKuQv2Vs3kR3+kHc74oVWC1iLNUiaEsP
         jouW8V9e1JA4M1UjWhncFqDanl62k6wPll5oMYf1pdgUyRxHNERNUtXopE4+2cpVhDws
         ve6mNsrM9/JxynT7G2IkXFXwcXl8Z1VSnos/UA3PvjXVLTbVdrc8Izm4AMrrQdLX69AM
         wyow==
X-Gm-Message-State: AOJu0YwtkJQVW5Dw/RUif5hU5SY7ZD+0GkAWCUsNvH1ZQosHDTb/SCdi
        7a7Zi8rlcQx0rMZc7d/OMJdPC8JQQoNT9Tp0TV9ceg==
X-Google-Smtp-Source: AGHT+IH55cBXroMnkug7B8yokRxDhI21SRaFGqNv3UI8m7WIq9+urUS3XgO9QIkVXW6bXNlkI/aCeQDsnvU3Z4ldSfU=
X-Received: by 2002:a25:f81f:0:b0:d4f:f231:78be with SMTP id
 u31-20020a25f81f000000b00d4ff23178bemr3143171ybd.6.1691422766330; Mon, 07 Aug
 2023 08:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726115022.5403-1-machel@vivo.com>
In-Reply-To: <20230726115022.5403-1-machel@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 17:38:50 +0200
Message-ID: <CAPDyKFrE+u1Jzjf40MqGt_xT9vOyb9Z-+SemTWEi42MSV4H5gQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: Use dev_err_probe instead of dev_err
To:     Wang Ming <machel@vivo.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 13:50, Wang Ming <machel@vivo.com> wrote:
>
> It is possible that dma_request_chan will return EPROBE_DEFER,
> which means that host->dev is not ready yet. In this case,
> dev_err(host->dev), there will be no output. This patch fixes the bug.

More exactly, what do you mean by "host->dev is not ready yet"?

Did you really test this?

Kind regards
Uffe

>
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 829af2c98a44..5a3eefd86931 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -841,9 +841,9 @@ static int dw_mci_edmac_init(struct dw_mci *host)
>
>         host->dms->ch = dma_request_chan(host->dev, "rx-tx");
>         if (IS_ERR(host->dms->ch)) {
> -               int ret = PTR_ERR(host->dms->ch);
> +               int ret = dev_err_probe(host->dev, PTR_ERR(host->dms->ch),
> +                       "Failed to get external DMA channel.\n");
>
> -               dev_err(host->dev, "Failed to get external DMA channel.\n");
>                 kfree(host->dms);
>                 host->dms = NULL;
>                 return ret;
> --
> 2.25.1
>

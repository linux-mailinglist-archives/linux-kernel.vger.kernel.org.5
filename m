Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5B75F239
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGXKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjGXKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:10:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AE1703
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:03:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad9eede0so33498655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690192956; x=1690797756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WE9rEkcbzh5Fw9Q1I4BgqZgGk6+psCGFCc2Fncwx3/c=;
        b=H2RvjswH61MKOvocGZzoX0QeXbsXpeIziBxPIh8EOda3h1TjxRB19RHTq43dIHv17s
         g1Vk0DvqUxWxDLEsmYNP/ffoT/ZBG4tL9rjhoo0PQFbSd4w6FH9Y+WZ0zJYhwKX5qsmN
         NAjyN8pxoreejIy3CJsWDbTQHdvUnBxR3aa377pBrHpSMfBdym3Nwkuc5tBntK9xsTLl
         /OUe8YydQvcJ1LuP+5ljwh31a6irWtQjoY8o3W9uccZVu1l4qXtwoJ8iE46CAfWh9kyr
         +/gItGNlUCrdpdXuqd7MhOJNRxfqBMOsb7DKr0OBzxgNQ0+Fis8T4hJ3rFN39ZhbIY9V
         exDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192956; x=1690797756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE9rEkcbzh5Fw9Q1I4BgqZgGk6+psCGFCc2Fncwx3/c=;
        b=LDBPKnDDZnfNx5N0a2YD6/uFch/7yTwkazN2oRm66kF9mOSAyGYeBCpH6Wm8knhXAj
         YWsZq13vcNRGtBH90ucqwXdSovRJ7GZtflmZ7Md0AINbWXNbvffBHw1PIDSqFysBMJ5Y
         +w78Lvl6ebeYcbmidMrpqpujk/Dm/i2Gt80qjX39RJ8Mwrsi2LwGbAemROZw3u8dQlKZ
         vViGLbqDB9KSlaFW53YBLHz0uafL8seLV36gXlF5xqMpqvS3CqLXpFMTpekyzi+NqUGE
         0UQMMUV5MBbnVRWE4IStagpvzPAtoMiVLW+Cx3iQ/1Ai5X8aau/DNHBMVoYFimklRAZC
         E3VQ==
X-Gm-Message-State: ABy/qLbC0axKfd+q8YOGPpayzSHqVfN8u1CsPgTOn2pEGqhYg8xtIV/y
        8By5rZfpU9WQDWIMw8Q42DOo0w==
X-Google-Smtp-Source: APBJJlEX1p+zLs0da2G0nBp4M+F6YNNjIYrf8ff1X7iJMFgWdq0sCB+njPjs0tJgPU1SKNVK2NslhQ==
X-Received: by 2002:a17:902:d2c5:b0:1b8:4e00:96b with SMTP id n5-20020a170902d2c500b001b84e00096bmr13006261plc.9.1690192956009;
        Mon, 24 Jul 2023 03:02:36 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001ab18eaf90esm8517215plc.158.2023.07.24.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:02:35 -0700 (PDT)
Date:   Mon, 24 Jul 2023 15:32:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Viresh Kumar <vireshk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v4] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Message-ID: <20230724100233.zqvg6lbi7n6imobv@vireshk-i7>
References: <20230724095712.1541-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724095712.1541-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-23, 17:57, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> V1 - V4:
> Fix code format.
> ---
>  drivers/ata/pata_arasan_cf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322e79..b32d47112c0a 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
>  	/* dma_request_channel may sleep, so calling from process context */
>  	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>  	if (IS_ERR(acdev->dma_chan)) {
> -		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
> +					  "Unable to get dma_chan\n");
>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

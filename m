Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEA375F2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGXKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjGXKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:18:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB87298;
        Mon, 24 Jul 2023 03:10:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6246739e87.0;
        Mon, 24 Jul 2023 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690193440; x=1690798240;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo2Qa5BMxd8JLJzuCSBMM8surQP5qCeqLCrCIIqF/7Y=;
        b=EZbvuH8F927POoEtE5v4M7mqfDYVZzC9yXAqWPIeSMtZ3uQO2TYLkZKA+3+Rfm0+GD
         OJdJpxPTw3pS3HF5O/szgbcYqLEQ+h6BFkrjms4RUpb9Kxq+2Rj5HPqk/QEzHjbzct1k
         be+Ev0Cvychl2hXCKdzGFOm9Zn8KuxaSdosDDhoQNkwtB3A7cNM8R8Fk0a71b3wyJfox
         DEAG50zTOOnJIOaKTDfrQkVaKYw5em3IkH6wtF9x1v4r/SZpenoKe/zTnyfgoS8PHVc3
         AfiuUN+XSFpxr7hDtXEnQ9dtNRwi7/9eWEzOBfKYiEhqpUmAwJSxSqZobOSN58yE+9Vu
         W/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193440; x=1690798240;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo2Qa5BMxd8JLJzuCSBMM8surQP5qCeqLCrCIIqF/7Y=;
        b=lrYD2p2zcGMZ/E278l+yp0vn4kx+FM2mYIP9bblTYcAPwVtfgWxUlqCgTPRi4EAbTX
         HmWwGTEZWSpcw+jPQhmFb/IQFWBv4hZu0euIARo55O3HpU0DTbpN96SAAld6GD9uOjGH
         L/Ah8607NOUTXHonH1Ia6MnMeLaK/oHsPxFc/kRBq7HUdDvCHyMD98AOdER4oETd3qaR
         XxDH3CAg3BNRafVkp8VVYezV/hLZX5xNyyrRU7Y+Fc1hZtKUZ8rcSEdWXEa4jXhlBDfB
         Q+obPuXR4T8A4Q9S6iFTMTZgkRULlatE4BUJZrVtmPn/ckbW02sGLaUedl5AyzZayMfm
         G12A==
X-Gm-Message-State: ABy/qLZOAbiJua3CvzSTyuWD/bxiALzauMzivaEdrGDOSygP9LvJADxX
        W0+syFne30U6GMFQEHKniwY=
X-Google-Smtp-Source: APBJJlF4nVs+7zFRI7Y+/6nZOfH92J39zf6gb5++Ebvx9sJvzxWQm+2fOsYbOVzmfwM1GCUagdhuXQ==
X-Received: by 2002:a19:7708:0:b0:4fd:b223:92c with SMTP id s8-20020a197708000000b004fdb223092cmr4020217lfc.60.1690193439474;
        Mon, 24 Jul 2023 03:10:39 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.99])
        by smtp.gmail.com with ESMTPSA id w13-20020ac2598d000000b004fbac38b180sm2134745lfn.39.2023.07.24.03.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:10:39 -0700 (PDT)
Subject: Re: [PATCH v4] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
To:     Minjie Du <duminjie@vivo.com>, Viresh Kumar <vireshk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230724095712.1541-1-duminjie@vivo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <a0afb702-0537-89af-2667-92186d6d3649@gmail.com>
Date:   Mon, 24 Jul 2023 13:10:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230724095712.1541-1-duminjie@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 12:57 PM, Minjie Du wrote:

> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> V1 - V4:
> Fix code format.

   I'm not seeing any fixing in v4

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

			      "Unable to get dma_chan\n");

>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

   That's how the dev_err_probe() continuation line shouuld be
formatted...

MBR, Sergey

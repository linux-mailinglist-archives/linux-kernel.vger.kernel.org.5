Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB075EAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGXFcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXFco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:32:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC14109;
        Sun, 23 Jul 2023 22:32:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66869feb7d1so2205746b3a.3;
        Sun, 23 Jul 2023 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176762; x=1690781562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9I8o7ui699KPf1qkPwqntM7BfAFxPVv36DmC3afsxzw=;
        b=dlEExe2DT/Ks5BInMo/+rOPYOzDbq7d77fWeZCpd0iu0z6HhpmiDHGsnJYYCCLcEpR
         dlp87JZs/TnaD5ZoUMP4sSSW20V/3Dd78l9pyfsBErem2MeLq0vNbfIub8DDz2XisnD+
         zkn/4VyE5oWb6xfA9lHV5/IF+HV0QG6rA+15+wfe2Ifn2D8CKMpDNMJ0ES0uVMcvX/ki
         VA5MqG7129UUiMoszqIHWR1WmVK1+MyBKbUCkY89YlxebQUCas1lgFN2GPWHkXL3K4Db
         r6+ghq+cCAni5vMdFYtcbVKWyps2bNMu/udTtb7mlbh2NMWKJWCri9M/PmBmNa9Z5sLq
         M6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176762; x=1690781562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I8o7ui699KPf1qkPwqntM7BfAFxPVv36DmC3afsxzw=;
        b=ak/Sxspv6V5N4LPIj2bg17CpEs7vZdrp7JTP3+MzP78WDNxHm+6SlrRrlRd4Dk08eH
         P6PcskpMSWKNA6N5RVgtHQgy6GW90y8ziGY4D/TxWT5kK16ranEYLueh7QdigLdWgReC
         TIikN0aFh9L+fbGbiimSPPMtULqwFmKAxIgmPZ+8sByvt7JQnc8kS9hgJJWQdglwwEDn
         oEjqDWe8T+kfJeUY7EdGFgIMHkif6RPrrJLq3yUK30rwd+ZeiTw70hBdIsvjGTeYYr4u
         MNYj7910zPDqFn46R8/53vdU2J8fFOdmmz0CSHetKt+DfOvAL6C+/eNU6n3CbYde6H2v
         /cng==
X-Gm-Message-State: ABy/qLbKcQXYRrAt8G71E2Y1hKe97trrF7CANlSCDK8y+2uwV9pFDsHl
        7Z23GcZzsdkUoDrtaJOm1yQ=
X-Google-Smtp-Source: APBJJlEQ/XPLvNl2r4nNk6VwW+Z464N1FOXjJfmDCnSSBJSQOmBLQvT3cm3F01rzW9aYprrl1SbwkA==
X-Received: by 2002:a05:6a20:186:b0:137:7198:af9b with SMTP id 6-20020a056a20018600b001377198af9bmr7573651pzy.56.1690176762563;
        Sun, 23 Jul 2023 22:32:42 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001b8307c81c8sm7837884plq.121.2023.07.23.22.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:32:42 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:32:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Input: lm8333 - convert to use devm_* api
Message-ID: <ZL4M91WaOSfjjMqm@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Fri, Jul 14, 2023 at 04:06:04PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/input/keyboard/lm8333.c | 40 +++++++++------------------------
>  1 file changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index c9f05764e36d..41d088933e01 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -129,6 +129,7 @@ static int lm8333_probe(struct i2c_client *client)
>  {
>  	const struct lm8333_platform_data *pdata =
>  			dev_get_platdata(&client->dev);
> +	struct device *dev = &client->dev;

This temporary is used only in few places, while the rest are still
using &client->dev. I removed it, made a couple more changes and
applied, thank you.

-- 
Dmitry

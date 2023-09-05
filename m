Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E879300A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjIEUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjIEUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:31:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A55D1;
        Tue,  5 Sep 2023 13:31:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bd6611873aso45522781fa.1;
        Tue, 05 Sep 2023 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945913; x=1694550713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSIRkZLP2r98+S/KTJaR3X5dSfpjOPd3LH6308TZ6AQ=;
        b=sRvycMOp1IuEy3gEEP4xTB51JLLMuXbEgJKgxyWiqkNJ3P5A9OPHCkRnnWOtpDwZzO
         1oK+/VgsUgBqhmqmslW3ONyFK2CpYWGZlnywOSlx2knlecDoya8HhmRiFTcgT5NPzuRe
         k/Q33ea+1YD9SuZLbQNm7FqxM5qJJdexZKzk0ByUBGxfwrXLoFeOzO+v5RRT3sDF6gwl
         HVhI44ESkmofBACxGFZcUv0oyU2AEHwPAZ8xaCwmvK9v/gG5Z8D1qBgXph36d9gWqFI8
         Q60bIlii0NzIht15KHYS2Uj4xCB0pBU8exPb6FJe1AuKQyRahJSRKetexQRsKHGtoPEi
         Ze/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945913; x=1694550713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSIRkZLP2r98+S/KTJaR3X5dSfpjOPd3LH6308TZ6AQ=;
        b=PszHO1VRHcCUfqi/KEt80XEp0GvEYIYaWxTR1x6qQwWkATDlwYiKNjHB5yK3egfoYT
         /jbqsL638IzzpDr4/HSCvbZDjlXjeguxezgeyp0zehdHpzb2FfDt3QJbqxqjQUs2pLwu
         YfAmNLTI0/BiRa9Y88zwIBXLUiJH1mDwGIeOi7ZiiwtDtOyTSTMJReN8j55B4KkSdia9
         i5LNQwx+YcSB6w4oxOoiLUDf3rDF3Oge+DRDNfp5+ANEp34jJpqW/sugG5uOvMcy4AO3
         G5WrtIE4ujMze6ubElVS+NcF01hLoyStOI2ltgF43WP3OJIEsDwD7FvcWm2khRLmek/w
         AMDA==
X-Gm-Message-State: AOJu0Yyr6SCFWmoAzKfJx+wA832ZFmmVjAO+tC/VSapdS/VfoZnB7Kyb
        Kb4XLoq8fa84rfUeTknZwtU=
X-Google-Smtp-Source: AGHT+IGRiQnxA2kagic6BlwlDSOCf2zj++J7KnMXYuANN/hYDBSGhjckCc0Du4SATrbOA8P0pMRf0Q==
X-Received: by 2002:a2e:900b:0:b0:2bc:b0be:e76 with SMTP id h11-20020a2e900b000000b002bcb0be0e76mr639909ljg.37.1693945912994;
        Tue, 05 Sep 2023 13:31:52 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id yy10-20020a170906dc0a00b0099364d9f0e2sm8084213ejb.98.2023.09.05.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:31:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: sun6i: remove unnecessary message
Date:   Tue, 05 Sep 2023 22:31:51 +0200
Message-ID: <9160645.CDJkKcVGEf@archlinux>
In-Reply-To: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
References: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2023 12:16:40 AM CEST alexandre.belloni@bootlin.com 
wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The core already print a message once the rtc is successfully registered,
> it is not necessary to print an other one.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/rtc/rtc-sun6i.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 753a2d9c8a17..8e0c66906103 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -846,8 +846,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
> if (ret)
>  		return ret;
> 
> -	dev_info(&pdev->dev, "RTC enabled\n");
> -
>  	return 0;
>  }





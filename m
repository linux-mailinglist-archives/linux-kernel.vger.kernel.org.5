Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A337A406B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjIRFWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbjIRFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:22:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528911C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:22:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5031ccf004cso429370e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695014531; x=1695619331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xE3jrbcUNNXJHY0aoh5BT2j+82gLvN+aYglDsTpRCQ=;
        b=fEWFEyfZimdaQMegoDWP3LTxT/YrfH4bu4b2kJH1Su19nlp6pOqXrpzHt2oIDKt6aU
         j1X2Pm4jgQdz20hvTgpY4o8mlwVOb4SQK7Ya8i8hTytPwE/Q9tL2ewejrRYaabaklMdx
         4/KuBTUSB0eJL1uUmzlPwkAEuDTccsRp/Llx95YWAmOv9BKeo7xAEvt69I/iswI9Sbiw
         PT1Yxc6P9M9GzEpnFwn+DpC1eb1sgWzIOtGJly14EUJIuqjwEBYBT4m5l/Di/6bpn6Mp
         O77Dlz9R1/TTwaNnWAFUYvO6RmhDEVVqUD+XIEXyQl6eP6UXd/9hBzID/cAkVlOr0+H+
         mJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695014531; x=1695619331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xE3jrbcUNNXJHY0aoh5BT2j+82gLvN+aYglDsTpRCQ=;
        b=DGUNLN7O9zExInNCqbYHMXroP553erVxcsbRU1Hj/EMF49F85nuA837uxzftgV93Kt
         TgvWsX09Thki62RLSMACd1+exzJywTUBss7PrIpgiinQtJHhv1HL0YPAVLDD7YBal80t
         vmA/5j9GBAmSsSxQ9WELfVNYVc45dcH9BBgHjcvKoWimG0YjWD0NFqV4e5kqTt+D4w94
         LWEOmGtI5SqyDhJfYMAfYqhxcdM+p7vSWUIHg8ugOkEfiBY1TBNCgWqGEqHQ5DsOZZnJ
         Nnon0XOgv4Mrc0cZAzlme+eFXQVihWeDK3fwXOGayS1wVRKcVh8VNEa/BRtBE3WONw92
         P/Kg==
X-Gm-Message-State: AOJu0Yzjo99WIEr510QP27iNihnqBP3lJUzgSDOicHesCAcqQl3G/1Op
        CQM38lklUT7z5BCS+blMAV86k4eJY7yVura323o=
X-Google-Smtp-Source: AGHT+IEm0YC9QfvVPPEi5UDAGaF61jNVRufoiKL3DXuon+U6JOSwfO2SAxWy0VL1644C0fxbfdMY2w==
X-Received: by 2002:a19:6446:0:b0:500:b9e3:91bd with SMTP id b6-20020a196446000000b00500b9e391bdmr6252492lfj.41.1695014530768;
        Sun, 17 Sep 2023 22:22:10 -0700 (PDT)
Received: from [172.20.10.8] ([213.233.104.217])
        by smtp.gmail.com with ESMTPSA id cz20-20020a0564021cb400b00530c46e2b32sm2818400edb.34.2023.09.17.22.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:22:10 -0700 (PDT)
Message-ID: <4319a1e2-a8bf-bb53-fed7-d2cd0beb3458@linaro.org>
Date:   Mon, 18 Sep 2023 08:22:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 03/41] mtd: spi-nor: xilinx: use SPI_NOR_ID() in
 S3AN_INFO()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-3-e60548861b10@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-3-e60548861b10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.09.2023 13:16, Michael Walle wrote:
> In commit 59273180299a ("mtd: spi-nor: Create macros to define chip IDs
> and geometries") SPI_NOR_ID() were introduced, but it did only update
				^was. I will update when applying.

> the INFO() macro in core.h. Also use it in S3AN_INFO().
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/xilinx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index 00d53eae5ee8..de5189c38432 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -22,12 +22,7 @@
>  		   SPI_MEM_OP_DATA_IN(1, buf, 0))
>  
>  #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
> -		.id = {							\
> -			((_jedec_id) >> 16) & 0xff,			\
> -			((_jedec_id) >> 8) & 0xff,			\
> -			(_jedec_id) & 0xff				\
> -			},						\
> -		.id_len = 3,						\
> +		SPI_NOR_ID(_jedec_id, 0),				\
>  		.sector_size = (8 * (_page_size)),			\
>  		.n_sectors = (_n_sectors),				\
>  		.page_size = (_page_size),				\
> 

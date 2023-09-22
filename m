Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218E7AAE22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjIVJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjIVJch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:32:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDD195;
        Fri, 22 Sep 2023 02:31:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a76d882052so1220447b6e.0;
        Fri, 22 Sep 2023 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695375108; x=1695979908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byNWqpfCSFBatN+/XHuP3AQTcj9dJwp561+awvfzUsE=;
        b=T3PHD8cPJxSQ/p9K7c9ffrPQ4n2SLvzcUcLFh/76sKKQoyEaxwkZsXyIZEaJO3w0Gn
         M0IT1zvZypza4MAZHAbkHpvC+gsg8mD7bVBwcLiSq9pPuEFwMpQ9GsSEJoDtyOhnOalQ
         h51/xFnuGepsSBiM2j9P/G6DMgwUoVQ415TgXYOAK+EcrzHHzqldb2t9y69xsMMjjkWx
         97z90n7+lrAqI5/mRLuc57iFWKhIylVPIBfry+3OPxo13yL6lZlkn2C6lp6l5sdCyFHc
         bYGPH5z+EvxREh9X5piPhVBG2xRP4rMxJmolLeLV4mc+U/QQ2NMpq85kw/lntKiLRcRF
         BSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375108; x=1695979908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byNWqpfCSFBatN+/XHuP3AQTcj9dJwp561+awvfzUsE=;
        b=fJDuu12WdjonQQcxnrf7jhMQLJhXBHDUgLKFJkcp+8ku4dUZWjK9hxe4KjvI8jpQTN
         0r6xIDt9wu8hwviIJz5MrKewZT+pcECWZb1fqoHDqhiD9GdEqSWnfIgYysb0wOze7EE2
         fWBQ7DI2TJ7kvrlowDMv+VEHcquZkbDHOMFAJoccdKgn98Oq9obK7QTZPvI3Z2zp+KDo
         wqg5zLEWaH+hxeCWLp4kcT6RUnlL6E6coN6xa88nCT0qzscO0akBJMekCyFZ3lY6OjNK
         yhCxCf3Pbw3yjL6949UbqEtS8dpwVewdM/kxx56525u7DzHSOwnr4agHkYRwNs7lzdrD
         tHGg==
X-Gm-Message-State: AOJu0YxLT84vQt6sm0dcS8Tyjjva394yCEBYhB98PcyP0KYbC6EFy5bf
        4mRR3LxOFyFaKOsnIqZM1Fk=
X-Google-Smtp-Source: AGHT+IH7tWZMylz8azAetF3ai4HZJKBMuaTHqqoWwTfPu9gh3SICvwqlQM6AW1jjsA5N4CIkdbaXyg==
X-Received: by 2002:a05:6808:618f:b0:3a4:24aa:b556 with SMTP id dn15-20020a056808618f00b003a424aab556mr7148804oib.13.1695375107653;
        Fri, 22 Sep 2023 02:31:47 -0700 (PDT)
Received: from [192.168.31.134] ([122.172.81.240])
        by smtp.gmail.com with ESMTPSA id c198-20020a6335cf000000b00565d82769d1sm2731648pga.77.2023.09.22.02.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 02:31:47 -0700 (PDT)
Message-ID: <786d197a-a2b5-2507-f5d7-24e8224a3922@gmail.com>
Date:   Fri, 22 Sep 2023 15:01:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20230917083443.3220-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/09/23 14:04, Bragatheswaran Manickavel wrote:
> Added identifier names to respective definitions for fix
> warnings reported by checkpatch.pl
>
> WARNING: function definition argument 'void *' should also have an identifier name
> WARNING: function definition argument 'int *' should also have an identifier name
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   drivers/thermal/imx8mm_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index 14111ccf6e4c..5dc6c18f12df 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -78,7 +78,7 @@
>   struct thermal_soc_data {
>   	u32 num_sensors;
>   	u32 version;
> -	int (*get_temp)(void *, int *);
> +	int (*get_temp)(void *data, int *temp);
>   };
>   
>   struct tmu_sensor {

Hi Team, Could someone help in reviewing it.

Thanks,
Bragathe


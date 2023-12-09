Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9280B463
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjLIMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjLIMuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:50:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910AD1729
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:50:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso4088398a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 04:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702126226; x=1702731026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrIj9e9uqoOd1iDOvTbMSrIuE57nDpQN+X5Gg7BjFI0=;
        b=eCDfc9joUzQSK1CIL7tEoPlnAQysqzrLyvuCgEjQhqODbKcmK1xrnQ3KSoLe3KVxny
         zM+eJeU/MMicHylg3WxLf1cAbJmP3S7ZqggAKIwej8uIwDNjtUnir+HYfkJ8R9FTvJHv
         AXwB7vu2a1Y3SD7arlGqXubh652p6KwB8ZsvlT6VqK7JO6gexy+EX+9P7Q51+gGoXq5A
         6pBkrUjcZEpHqoiSYsuS0DIAyOgOdeyS0GJKjG1LRYSfJ/7Nv7UQzvFgyLBQxXD28Rxc
         1eUEQtE4yV9FAj6hEQM2lRCBFf1MQ8xAyCNbzfCRbvC+43/4ITr4tzwUiB5TS+HFu18d
         LSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702126226; x=1702731026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrIj9e9uqoOd1iDOvTbMSrIuE57nDpQN+X5Gg7BjFI0=;
        b=oX0qTI8Lq2XOCnSMra+mgI38tnYWunYGl8jPKri6SmRshvC1HJZQEmQjiG/PYaC+sQ
         RtHXRaNSDXnop+nV7xKz/IqHe/vaiVzI11sI8AqZ1izXqp1p8nmaIa+N3umUc2fx/dF2
         2U/sE+Cv4eTXm7XGrgNkBSi5Gq9/CoacXX29t4C2Y478G+lA/dQ2dmCr8AuDCZwL/qMm
         7Zw6ag3yJUehpTmr0M2tEgiezlF00dByX5TNoR9LKvbtEhw9hlhwxkQKSKkrG3MYAfnU
         KSx15EMmbJGLZF9k5dLo0iCSDUo94jzos2a33q4WPXTpmLIEsEgjUq2nfQCRX/JRDsMp
         nkPw==
X-Gm-Message-State: AOJu0Ywdh4el/AOnO9X4kC+l4jK7GCquuLNe5KaoTx4qdrd6Ty9hckhw
        /kQhpIaEFsfA81PF4dHsXW3KAw==
X-Google-Smtp-Source: AGHT+IEYyrmukzbccTc2RXgUzX/w2lPzGR06iu3VIh3Bw5dz4f/tU+btc/ERZJ+BS3SZuifdxyfQzg==
X-Received: by 2002:a50:85c6:0:b0:54c:8890:6ff2 with SMTP id q6-20020a5085c6000000b0054c88906ff2mr531914edh.13.1702126225714;
        Sat, 09 Dec 2023 04:50:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id u20-20020a50d514000000b0054ca3697e2csm1711912edi.25.2023.12.09.04.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 04:50:25 -0800 (PST)
Message-ID: <de0ddb41-8d78-45eb-bcb7-6d318bf154fd@tuxon.dev>
Date:   Sat, 9 Dec 2023 14:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: soc: atmel: Adjust defines to follow
 aphabetical order
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231208194532.579893-1-Ryan.Wanner@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231208194532.579893-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ryan,

On 08.12.2023 21:45, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Move the defines so that they are in aphabetical order based on SOC.

s/aphabetical/alphabetical but maybe alphanumerical a better term.

Could you please explain what level of alphabetical sort you wanted to
achieve? I see SAM9X60/SAMA7G5 b/w AT91SAM9X5_CIDR_MATCH and
AT91SAM9M11_EXID_MATCH or, e.g., AT91SAM9G35_EXID_MATCH after
AT91SAM9M10_EXID_MATCH.

> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> Changes from v1 -> v2:
> - Remove defines that are not yet in v6.7.
> 
>  drivers/soc/atmel/soc.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 7a9f47ce85fb..1f2af6f74160 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -39,10 +39,10 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9261_CIDR_MATCH		0x019703a0
>  #define AT91SAM9263_CIDR_MATCH		0x019607a0
>  #define AT91SAM9G20_CIDR_MATCH		0x019905a0
> -#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
>  #define AT91SAM9G45_CIDR_MATCH		0x019b05a0
> -#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
> +#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
> +#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define SAM9X60_CIDR_MATCH		0x019b35a0
>  #define SAMA7G5_CIDR_MATCH		0x00162100
>  
> @@ -61,23 +61,15 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9N12_EXID_MATCH		0x00000006
>  #define AT91SAM9CN11_EXID_MATCH		0x00000009
>  
> +#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
> +#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
> +#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
> +
>  #define SAM9X60_EXID_MATCH		0x00000000
>  #define SAM9X60_D5M_EXID_MATCH		0x00000001
>  #define SAM9X60_D1G_EXID_MATCH		0x00000010
>  #define SAM9X60_D6K_EXID_MATCH		0x00000011
>  
> -#define SAMA7G51_EXID_MATCH		0x3
> -#define SAMA7G52_EXID_MATCH		0x2
> -#define SAMA7G53_EXID_MATCH		0x1
> -#define SAMA7G54_EXID_MATCH		0x0
> -#define SAMA7G54_D1G_EXID_MATCH		0x00000018
> -#define SAMA7G54_D2G_EXID_MATCH		0x00000020
> -#define SAMA7G54_D4G_EXID_MATCH		0x00000028
> -
> -#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
> -#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
> -#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
> -
>  #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
>  #define SAMA5D21CU_EXID_MATCH		0x0000005a
>  #define SAMA5D225C_D1M_EXID_MATCH	0x00000053
> @@ -113,6 +105,14 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAMA5D43_EXID_MATCH		0x00000003
>  #define SAMA5D44_EXID_MATCH		0x00000004
>  
> +#define SAMA7G51_EXID_MATCH		0x3
> +#define SAMA7G52_EXID_MATCH		0x2
> +#define SAMA7G53_EXID_MATCH		0x1
> +#define SAMA7G54_EXID_MATCH		0x0
> +#define SAMA7G54_D1G_EXID_MATCH		0x00000018
> +#define SAMA7G54_D2G_EXID_MATCH		0x00000020
> +#define SAMA7G54_D4G_EXID_MATCH		0x00000028
> +
>  #define SAME70Q21_CIDR_MATCH		0x21020e00
>  #define SAME70Q21_EXID_MATCH		0x00000002
>  #define SAME70Q20_CIDR_MATCH		0x21020c00
> @@ -127,6 +127,11 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAMS70Q19_CIDR_MATCH		0x211d0a00
>  #define SAMS70Q19_EXID_MATCH		0x00000002
>  
> +#define SAMV70Q20_CIDR_MATCH		0x21320c00
> +#define SAMV70Q20_EXID_MATCH		0x00000002
> +#define SAMV70Q19_CIDR_MATCH		0x213d0a00
> +#define SAMV70Q19_EXID_MATCH		0x00000002
> +
>  #define SAMV71Q21_CIDR_MATCH		0x21220e00
>  #define SAMV71Q21_EXID_MATCH		0x00000002
>  #define SAMV71Q20_CIDR_MATCH		0x21220c00
> @@ -134,9 +139,4 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAMV71Q19_CIDR_MATCH		0x212d0a00
>  #define SAMV71Q19_EXID_MATCH		0x00000002
>  
> -#define SAMV70Q20_CIDR_MATCH		0x21320c00
> -#define SAMV70Q20_EXID_MATCH		0x00000002
> -#define SAMV70Q19_CIDR_MATCH		0x213d0a00
> -#define SAMV70Q19_EXID_MATCH		0x00000002
> -
>  #endif /* __AT91_SOC_H */

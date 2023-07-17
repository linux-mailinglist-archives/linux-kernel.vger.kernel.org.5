Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8566756C17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGQSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGQSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:30:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D510C7;
        Mon, 17 Jul 2023 11:30:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9891c73e0fbso994657566b.1;
        Mon, 17 Jul 2023 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689618596; x=1692210596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08uBZHXIdhjlp0+Qj1Di6AUCp530vcMachRRJ1XsitA=;
        b=SmdvYNoNo3D8UTVMRTKc+sDWMzKI7+7KCkfglMYlDcsBPEptU733kazmL6SaoPvmfT
         ItMUHAaTW3os4l0vvuXzHYSmwLV0YULPru8+Aec3a/j6od8kyaPjMFEY9RbJI9dd6cZp
         4aRgMrnhLkpt0rEgvSJQNP5P8HGXB5OdrXVRcjYL7rsEKtMS1KIyePeerxHALARmAfl1
         2dTlTSfAiIg48wYBMggAERiUINHjP9O5rO++iMd3jq0LvYSdxAC9BWMs9m11vJhUvqmZ
         7TJcAVmIDHNv3BSuurBEzIc2uByfxYB/2Za7SKAiBk9bC0fE1ZR/6UtBq7jKgLJqQpEU
         4XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689618596; x=1692210596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08uBZHXIdhjlp0+Qj1Di6AUCp530vcMachRRJ1XsitA=;
        b=aMBZXw/fBV+zXJH7N85vIVxk7gZDLDbj8pFNg9UhrXXNkMNxA6ew5fu/VxVc0IkGLg
         lcqSwX9fOjROZ7NNoAASlYYOaxeLjK09hrUy3lhH4rFcIh88L7iwyKLLTw0WQv3xiiIH
         ZwujiQfA9/Acw5wANmeSQ08YyThZRLoVksbWvozVlCfr7O3e4ZaSkKHY89Xu5RXK2CAs
         CgQujhkBSwy+KKJh9rcg1ROdLfd/7P+ddqOwEQRx6faVGHGDl6k/EPmryX/iPabnxwow
         jeawndwiXzPFDpNTSMojNQfORl4O0vDKJv7zinY8fGbk/gpvPZ1koO374P8C1a4e7Wqa
         qC9Q==
X-Gm-Message-State: ABy/qLb/yBuqpXqqNOfzahemc1ny2W25XIFx6DV/rP/Gl37rKLataEuS
        Z58bATw9dffQ6t6DarwOweg=
X-Google-Smtp-Source: APBJJlGp1ADzTqlcN7lvk0fzLk/VXkTHzaTvBAIV3UBrZNJI4lJ2DKgMpCVH+Cz45nRpUWJuoqjCog==
X-Received: by 2002:a17:907:97d5:b0:98e:1c4b:10e2 with SMTP id js21-20020a17090797d500b0098e1c4b10e2mr11123817ejc.20.1689618596206;
        Mon, 17 Jul 2023 11:29:56 -0700 (PDT)
Received: from [192.168.0.110] ([77.124.20.250])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7d902000000b0051e0eba608bsm10292767edr.19.2023.07.17.11.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:29:55 -0700 (PDT)
Message-ID: <20db661e-9006-afc8-fcba-ec9825ca8092@gmail.com>
Date:   Mon, 17 Jul 2023 21:29:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v1] net: ipv4: Use kfree_sensitive instead of kfree
To:     Wang Ming <machel@vivo.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Cc:     opensource.kernel@vivo.com
References: <20230717095932.18677-1-machel@vivo.com>
Content-Language: en-US
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230717095932.18677-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/2023 12:59, Wang Ming wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>   net/ipv4/esp4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index ba06ed42e428..2be2d4922557 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -1132,7 +1132,7 @@ static int esp_init_authenc(struct xfrm_state *x,
>   	err = crypto_aead_setkey(aead, key, keylen);
>   
>   free_key:
> -	kfree(key);
> +	kfree_sensitive(key);
>   
>   error:
>   	return err;

LGTM.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

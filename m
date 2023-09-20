Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15D7A8047
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjITMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjITMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:35:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C68E9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:35:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso915352566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695213312; x=1695818112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLTqYIzg+lzYdWxVhMCzWlzNaCtUEOxWm6ZlofL9b/k=;
        b=I+cPSUGb1xePAT25tlhq0vjw56sxYd1o9HyIWJWro1rQouVzNe8MYOCdFiHjGsPvic
         vRJbY2OtepC7s520ALHDcgKAPwCyUxiEiZvdqKBZ2PnQ/WauPVYbxItwFaBgU1bClJN0
         tnrunym4zhCXJ0+Sm7VCVN+b99CL298pVYCtR/xDJ22EUGQ6MwulO5xqzR6FjbaRxd2s
         YI4AP7ZbuYCpD5mlV8wnzeN61f71XkR9BQ2t2hRk5OPXAeqHetn9rDTLDzkRnaJtHw08
         vwFSNRzMyGgRh1HcDzoqrUawSq/2xN6uOBdi+iw6sRRiC3HEt3/E7aXU5C397daL6zCr
         Y9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213312; x=1695818112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLTqYIzg+lzYdWxVhMCzWlzNaCtUEOxWm6ZlofL9b/k=;
        b=v5n0wKO3oI7JQj/VectSzjSS1zztXiTVKfiCRKip3KPEMif0io2hk848mLSqV4tUN4
         ms5c/ta6ylzLyrBaDx3aS6xYzkkULsMNbh/QhHMtwUrC+cNWLmCrPn61bzkcBX9ReOio
         qElSRSQaKdQhJf3Czr6dHvpyx2Ku7bRU2vqn1q2zzLtrkeSK+KdeNy9VMpuNbAIq5LRO
         PfLT9omZUZY7IhiZPaCacl2Zr++Hv5P3kH1f8BWO629q2o/u32+qZqn4PsSzXwpVHfha
         +vWr1l7nHef4CBH33Q3OXvfnrf9w1PUhQY/tE9Cp6X1cRnd8UxMfrk8kBo1cKgdbKyWw
         13OA==
X-Gm-Message-State: AOJu0YzFcAvYI7PToK9DZ7wBVd4Gpdo9oeicnwDswmRGIv8eMjvGAL+9
        K82HlOAtqVpcm4zs9/3MdgLKAA==
X-Google-Smtp-Source: AGHT+IGwvU86FMvs+bljEO41B9RgRTmfnEPEA0QwaQ7OV1Kiu3h4DYuDlsLWhXSICh5oRzDAYMOvHg==
X-Received: by 2002:a17:907:2c62:b0:9ae:3e2d:e2e0 with SMTP id ib2-20020a1709072c6200b009ae3e2de2e0mr2040658ejc.71.1695213311891;
        Wed, 20 Sep 2023 05:35:11 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id sb4-20020a170906edc400b00992b8d56f3asm9271582ejb.105.2023.09.20.05.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:35:11 -0700 (PDT)
Message-ID: <97a04999-91d5-2f4b-3fc1-d9fecb89082c@linaro.org>
Date:   Wed, 20 Sep 2023 14:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: document esp32s3-acm
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
 <20230920022644.2712651-5-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920022644.2712651-5-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 04:26, Max Filippov wrote:
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +

Same comment here - missing $ref to serial.yaml. Sorry for no bringing
it up earlier.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF9C792D18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjIESJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjIESIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:08:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F82113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:05:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so42072581fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693937039; x=1694541839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITVqO5bicenhh3jxUPk7Zpl/DCHN9osVHVYICZSjhFw=;
        b=HIRhGiVtQ6mCE8e/2tU2SaQDmZ91+nDZVQCDo9hMbnRMMHZuFCuySiUcWwlYyPNnQt
         F0nVzA9JY3xC9WsI+65s93lKm9gjanSr1RxomkAXYncI6orts+IP50OLBJGO/SSgrTnk
         noQXzJp+eEX1GtQE1Z56d0JhOUxzJYB2HRNnXXD3ZjyzZaM0/y78lW6ZPi5xIPTKZsvr
         WyJgjfqlK8esDucAoyIYZ+rDQ1DQBbmr9RoLm3jlsddp1ED1JRidY0GfQAPVZNeBs3ln
         5nUw9sco+oqeRTdLZuxj+42cKLCaLiE0ofrdgP0dzbDVvzYoxSQQqMODl0JbhkOXRdnH
         ciWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937039; x=1694541839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITVqO5bicenhh3jxUPk7Zpl/DCHN9osVHVYICZSjhFw=;
        b=V6K/IiHa589kqe6DE0dZa0TkK+wKwwKV3EbXb1WJXr2mpB0Z1k0Xg/sZPffzyBgifC
         QNTD09MZIDBpaCwmg9nIks8vDRcf+kecEiECzN5uM1Uu4gerZ+Ra4uuHnMFht1yGuK2d
         B1QVlGaeFe+w0+7F5WavfR9OGTgY403M/A6E+jDR/3iDXhay6FAG8tHH3tRCVY24abuh
         lJmLMauD7iPcSbNK6GMWCFJGPRnG+4jN+TH1fqfF2p6i2dz9eri+9QhySYavkUaG0cCu
         0Vey2yYS3tnDO+vPgM2lcC1/cDNQ4f4Rtws6qBhv9RM5eTh5hyh9Gq1JaVfBu6fnAp5A
         HzfQ==
X-Gm-Message-State: AOJu0Yy0wd7SYupRWEDAmK6jstWd2Lc/HwcAddZz2PMjBCi5TJU42nEu
        0gAEGGXbGQ6yttlof91/9qhO8fJA41/uxevIDv4=
X-Google-Smtp-Source: AGHT+IFezyZ2iyzDBykWMivtiyqKBcnLI8r94bk/OvsGEvrihHti9Fz/5TMpZF4FUMogOwUT/65HTQ==
X-Received: by 2002:a17:907:a06b:b0:9a1:c00e:60cd with SMTP id ia11-20020a170907a06b00b009a1c00e60cdmr294105ejc.15.1693932355679;
        Tue, 05 Sep 2023 09:45:55 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090681c600b009828e26e519sm7740506ejx.122.2023.09.05.09.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:45:55 -0700 (PDT)
Message-ID: <39836874-e3c8-a09c-67ae-42dcb1b40644@linaro.org>
Date:   Tue, 5 Sep 2023 18:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf8523: Convert to YAML
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.or, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230905132324.3146722-1-festevam@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905132324.3146722-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 15:23, Fabio Estevam wrote:
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,pcf8523
> +
> +  reg:
> +    maxItems: 1
> +
> +  quartz-load-femtofarads:
> +    description:
> +      The capacitive load of the crystal, expressed in femto Farad (fF).
> +      Valid values are 7000 and 12500. The default value when this property
> +      is absent is 12500fF.
> +    enum: [ 7000, 12500 ]

default:
(original binding had it, wasn't it true?)

> +
> +  wakeup-source: true

If there is going to be new version:

You can drop it and switch to unevaluatedProperties: false later.


Best regards,
Krzysztof


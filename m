Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944078398F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjHVFyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjHVFyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:54:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D43186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:54:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bfcf4c814so538319366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692683673; x=1693288473;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TQX4y/uBks8nVow/iPGHdMMait3YhGPxYbRER/vAHI=;
        b=D2WKJgnPmiNc5DtPRLx3K/1bi+ALPO6Ox0BPf7MgWLCXGX+ugGmtbq6PTYiqkbsdXo
         pevGNinraFDgfmH0udKrxvA+87fIwn/o39IbxKDK2xuVdh69NujFmNtjV6Cq5YPe3Age
         Q6RtEx5OuvQRG7nuGwlY5HTkmtGbQbjM/IGdSlo/Mzlhiut4s3E5rxa726v6FRTlg5Oz
         hMkZ9FYIHP5yrD5OnYjsa1JLh6mAlcKh0DO0CakQeSXO6lVYNfvEd47N2rdrfhWQi8pl
         f6YhzJ6X+Re0bu/TQsYPyg6w1Wy5Az6uDAcKb+dcSpKEcX1OVcWO3AFd3nXE6gKAmToL
         lAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692683673; x=1693288473;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQX4y/uBks8nVow/iPGHdMMait3YhGPxYbRER/vAHI=;
        b=Sg/92/ylXFNbgcSxoBVhgYMUfLxG1Kwd+SPWw5B9bkK2xMgesQJ0s5FqifERjlCke9
         jDvnj/idi/qdE4Mt/JVa/Bwi+84QfT16AGUZKmlxScX670WEzDxrr4fPxYlMoL2KG71n
         0aUp7kgQ1qL/+vmg1sC6A65N59qReNoewm9po9AnWfhxTMxTeRyAfl3gPHnM/R9GEwbY
         Fadrv1CODwmqgEoqiwmKDcK4sRrQDIy1cnQsRrMIjM3wmWTG3z8sX5bLnkZUSWck87b0
         1s6GXQDnMWWO14uwMTsmXYupTSn7kFf9qGUEit7bbwfuZBNPlZPYNOQ89osrtNRfyXyy
         Oh0g==
X-Gm-Message-State: AOJu0Ywq7lG6jkQiF3fzQ91/ntwUpswRDrVE5wweQUNragyEUlgtd5xd
        sgL3DELnxm3YlA8nebinQGzIAw==
X-Google-Smtp-Source: AGHT+IEhDWurn+BYTTaGcgwpERqWG0ysoExljMCFTqgXhHbhp9OQXV6bd64JEdpjuDYl/Vu3vIfg7g==
X-Received: by 2002:a17:907:a076:b0:99b:d2a9:9a01 with SMTP id ia22-20020a170907a07600b0099bd2a99a01mr6856980ejc.0.1692683673252;
        Mon, 21 Aug 2023 22:54:33 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906368600b0099bc038eb2bsm7588168ejc.58.2023.08.21.22.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 22:54:32 -0700 (PDT)
Message-ID: <07c6a89b-f545-a49a-db21-ec361811e4be@linaro.org>
Date:   Tue, 22 Aug 2023 07:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/4] dt-bindings: touchscreen: neonode,zforce: Use
 standard properties
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        rydberg@bitmath.org, u.kleine-koenig@pengutronix.de,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230821171151.555091-1-andreas@kemnade.info>
 <20230821171151.555091-3-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230821171151.555091-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 19:11, Andreas Kemnade wrote:
> Enable touchscreen orientation to be specified by using standard
> properties.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Rob reviewed yesterday v1 (although adding 3rd party tags might not work
with some tools):

Reviewed-by: Rob Herring <robh@kernel.org>

Best regards,
Krzysztof


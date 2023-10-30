Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EC7DBF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJ3R7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjJ3R7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:59:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E35D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:59:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3c8adb27so716392966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698688778; x=1699293578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvSSz2b1QgB/AlYG4CXYHHHkCbHuZHM20Xi74wt8pqk=;
        b=CO2L3xwYFIz7UrYBy+XUS4muwKRKF/9LHLp8i55e4z+MKtxrFv6nrehZA4i5bJ5th9
         4iLIxoRGH938+tzjh2W6byYBD2YyBIYRLGoCRQSC0NxiYUTS4XETHGw5RUtt4VfOf6+c
         L/f/mXIcWu7lYYCORnlbiT2kp+zZZb0mCfLvkrZ0z7xeeFVqubmhLF7Xv6s1mc8mJD2H
         vjUnuB3/D95EyTK+PMBBVyueOhe1pcwlhWi9Zj9fFQeFoCTgWDn4ZgALW3YhnXGgc9Rt
         0NSB3SFLUER/vviPVUEDqbHonwFcCwksZ9eoFM8hAhr2ru6JOY0Wey9QhnosGsnEHq1I
         +V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698688778; x=1699293578;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvSSz2b1QgB/AlYG4CXYHHHkCbHuZHM20Xi74wt8pqk=;
        b=ZbK3Z7zVxW8KKfOHH/ZIo0X7GjtUaAAmHTXw/5+gG3ImySMiQLpeukQ2TIz4Nzc7ty
         1gW3pGkAiyB562IAWu6EeXDgUO2I8d4WQ76UaUu+omYYT7+mbOlb63m7FZ//0eChaF9j
         WcdQ2YcroFp6CmJBRarPS/WZSeAsyXFaucsutDVlrppBgvlb6Hu08tH6z9Gh+QF6L57d
         cWALITtX4ys6jEFfnHsxk1FdvWBZOJubvsu8QGXqgdfn+FdIfv7Ml0OTCYLnHsf69XgY
         V/8dwVFbSqu+oyrplEtiXBdU5fuZ+BCQ5j8HQw3FNwVZ+sfk0+xj0UM01UAPk91xXJi8
         JvLw==
X-Gm-Message-State: AOJu0YwIOVPprvHsIkUhk+FVf8PgJX523AwQ/bWnRWGVVMvXgaKqxGO4
        ZAliy4+QO+OkmcCOmaEgxErnyg==
X-Google-Smtp-Source: AGHT+IFVyWxtyQCSeBEnfoj5Z8tWNDXo57pKKBU7f0HXEpK3JkJsSltTriOVzuUJUdUXIsismU8/Gw==
X-Received: by 2002:a17:907:d387:b0:9d4:55b1:a45f with SMTP id vh7-20020a170907d38700b009d455b1a45fmr2251301ejc.43.1698688778376;
        Mon, 30 Oct 2023 10:59:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709063e0500b009b8a4f9f20esm6328003eji.102.2023.10.30.10.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:59:37 -0700 (PDT)
Message-ID: <03a555ea-9066-4366-b130-545aa5519b18@linaro.org>
Date:   Mon, 30 Oct 2023 18:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] Documentation/firmware: added imx/se-fw to
 other_interfaces
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
 <20231030095849.3456820-2-pankaj.gupta@nxp.com>
 <2a9a25db-7fd4-494b-975d-f2f012cf67f6@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2a9a25db-7fd4-494b-975d-f2f012cf67f6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 18:57, Krzysztof Kozlowski wrote:
> On 30/10/2023 10:58, Pankaj Gupta wrote:
>> Documented i.MX SoC's Service layer and C_DEV driver for SoC(s)
>> enabled with hardware IP for secure-enclaves like:
>> - edgelock enclave on i.MX93 & i.MX8ULP
>>
>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> 
> I asked to explain user-space tools as well. I don't see them
> mentioned/documented in none of the commits.

Hm, I lost somehow or I did not get your patch #7, so maybe that's the
place where they are mentioned.

Best regards,
Krzysztof


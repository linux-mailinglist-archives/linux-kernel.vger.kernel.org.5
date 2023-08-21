Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2D7830D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHUTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjHUTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:13:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637CE77
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:12:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-319e93a1594so3432441f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692645176; x=1693249976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1jfWqRFqEX/V4IMqa029q2gEFfs8XGqFtJjj4sRi5k=;
        b=uW5jyVF/yuXzGkSTxjiKp/5ntJBeHaOkd+4xfhAxDvHfn1yaHl0h+xNIrxwlBk81LH
         WaTJs8vU8iugxYsErSaowPzuwyU2QvUidPbf9IVaNP5CsXiDGVDorzM12UNCnXhq2cAl
         4CHCP/RMx1oaD+hbAA5KDF9tn0dVWKTx1c8XFRi6W+KcGsVju1TTXytDpTaG/86RyaQ3
         eSHuNUcPSmHsVvqLk1631SLwsTAsRlcHJJixFKirWXJ0WAVZwfAjr3mP2QmyN/6UhH7E
         Opz4LF+tCgOZwjs6JT0F573bY63qUoe2jR3fEUgSoYWc9webL5O6GKO2duye5ljEz69Q
         a1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645176; x=1693249976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1jfWqRFqEX/V4IMqa029q2gEFfs8XGqFtJjj4sRi5k=;
        b=WQ7V1VegSW5LoBRY0OK7aMZdaYfe9XRyTF6/maBcp08m3FKQPN7lCq/rI+Iyk68ot6
         d7vxkONQSbyzpBggVHq0TYbg+QUhMs8sWhVUDUQR+eMWjA4c6WJZ/t3BnD4zLMeW7sK/
         0GYcPpHlsFQv2WGm+y21uPGQWplxNyl3i/FVkVke5Oqdy4B3zwFcUmNC1eRTF8IrlGqB
         AQkCtDImrYwlCMg2qpHyPEL0CLLXnkOqMrqOOdKR9CYIj6mBuQ8UbDJTlXqyRjnnOVer
         kMmYL3kinR94TcjTRb5nDJP47S3txAUQ8HEe1J+IJ3PUx77l2RQwSzNX+JMCcZIxmrwR
         2J5Q==
X-Gm-Message-State: AOJu0YxIVbqIw8JgjYeVzFmwBrA1rbXlcMKZr5tSGbJJMNnGzn81MGhi
        iS3AcyCFO/wKegl0mEEd0V3qZT/0TzRdHWpHA3o=
X-Google-Smtp-Source: AGHT+IFGAXFhnHGo2FpM5aCmnviNTFRiZ/WCyyzjZnj8MJtw/TSwL8XbhsAY1GaPqh4Dk3AZ7uEsGg==
X-Received: by 2002:a17:907:2c6b:b0:988:9ec1:a8c5 with SMTP id ib11-20020a1709072c6b00b009889ec1a8c5mr5605427ejc.55.1692643304233;
        Mon, 21 Aug 2023 11:41:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906045000b0098dfec235ccsm6855882eja.47.2023.08.21.11.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 11:41:43 -0700 (PDT)
Message-ID: <8fd5b5e6-792c-3b7f-0828-5d647993ec7d@linaro.org>
Date:   Mon, 21 Aug 2023 20:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] drivers: regulator: Add MAX77503 regulator driver
Content-Language: en-US
To:     Gokhan Celik <gokhan.celik@analog.com>, outreachy@lists.linux.dev
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1692634090.git.gokhan.celik@analog.com>
 <b45b07c3bdbfac1608b171f96aa0ae4ca5a0dd82.1692634090.git.gokhan.celik@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b45b07c3bdbfac1608b171f96aa0ae4ca5a0dd82.1692634090.git.gokhan.celik@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 18:28, Gokhan Celik wrote:
> Add MAX77503 buck converter driver.
> 
> Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>
> ---

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

>  drivers/regulator/Kconfig              |  10 ++
>  drivers/regulator/Makefile             |   1 +
>  drivers/regulator/max77503-regulator.c | 137 +++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)


Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEB81345B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573699AbjLNPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjLNPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:14:00 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DBE1BF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:13:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso4253392a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566790; x=1703171590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etJ+/wYoAcvEaSoojHqnnim2gYjZh1zVJDqnc2kSXpQ=;
        b=QVOLhbu5Qr7LsTyMe6GposwU9a//7P8AI8YTz2gIDYOAzbBvHGBX4ILfoweHvJk4rV
         9HeeiUWpwpDgwlZEV7VfHFf4MSpgc5jQt4yISG48Qnn/wGouHI+JIZ60TLeO7SC8HYAl
         zn3gND+PF/S3Gq32PnP6Q4t/UjsZNizhxuFfoP5HddnbgHeGGOgwP16NJt5xOfliu5bp
         /KhHZK50OVgHv37IvobrrHNnCbfZrXaZMPLe7jdRkhMChG/4/wVPnBKU2ZXFd4MG1NZ1
         KunmMzEVO9wsXOnlo7kyW5xsaVx7uM2JySchWwaoyF31fiZlCBTyEzLcgYkUeYSjnJQa
         2jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566790; x=1703171590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etJ+/wYoAcvEaSoojHqnnim2gYjZh1zVJDqnc2kSXpQ=;
        b=eUBqz60ohu903KMtF0mXwKXqZgH7IQdhDEUSHs6g3WLcDsU6f0K5mOgozZzt4HkxeY
         OQTCRZIcLLy0PNok+hUZ2SmDo1U7Grr8NPrqyL02SQc45GOab7J3sbC10Utz5cDtT9MQ
         amPkAXHKB+7+7ACVZu/V8PWUyHyaSIEqoblc0wYAGGQPpmmXoRMRCpvVGWk3BRQpJF4M
         BSfHGPrwjFpr9ik5GEi+4Q6WxbwaYTue8MiUZXDphfmJu43CbDHpxSqqloHWH6fdXGp0
         RQJoSybjpDCg/os6Y2KvI6ObPwRidspLN41G4A8kPETIPtrFk8tUq7JfXXz2TS1hbgxP
         qDWw==
X-Gm-Message-State: AOJu0Ywuwi7AfyQ2Otubq3GdWfev7qG4QBSvh5vPM+UeoH7iF7Om8Jgb
        40rzx1Wmr/FLU93hZ5MUC8ylO1+y7E66tixC49e5oQ==
X-Google-Smtp-Source: AGHT+IEFL6tnUHSNVnMcU+kCLIcfGx/R1ZUOTFN7/bZVIiGtPzpJjiJX8aWhelM2KXu+zN0404N10HK44v1+/oTJCzM=
X-Received: by 2002:a17:90a:de94:b0:28b:1fbd:27de with SMTP id
 n20-20020a17090ade9400b0028b1fbd27demr197844pjv.29.1702566789746; Thu, 14 Dec
 2023 07:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-4-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-4-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:12:58 -0600
Message-ID: <CAPLW+4mBN1g0ojYiE_AVt7ZWO_1yEFpx58x4+1U9spxaS=abRA@mail.gmail.com>
Subject: Re: [PATCH 03/13] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Add google,gs101-hsi2c dedicated compatible for representing
> I2C of Google GS101 SoC.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Doc=
umentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> index df9c57bca2a8..cc8bba5537b9 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> @@ -33,6 +33,7 @@ properties:
>            - const: samsung,exynos7-hsi2c
>        - items:
>            - enum:
> +              - google,gs101-hsi2c
>                - samsung,exynos850-hsi2c
>            - const: samsung,exynosautov9-hsi2c
>        - const: samsung,exynos5-hsi2c    # Exynos5250 and Exynos5420
> --
> 2.43.0.472.g3155946c3a-goog
>

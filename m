Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1097C477B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbjJKBwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344546AbjJKBwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:52:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B659D;
        Tue, 10 Oct 2023 18:52:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9f139cd94so1051165166b.2;
        Tue, 10 Oct 2023 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696989118; x=1697593918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8jpVbTN8e1NFVPlrUmh8i2J9AzNXH5X36L3cIHXeoE=;
        b=Jft//ciIbIduQ5gKBjlFxeqE4Scdinro+u4RSwSOdj1DO0VZDGoaveEW4EeGGYTuFA
         WtTWipnYR0THfLbuvMvfBC2FGCIa4G8tbYCI7HdQooGSbmAryp2q0L1aHwauKlZY25Kz
         gscNQnnOPh0HGngH6MLI1ihyu/9qz0AuJPb+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696989118; x=1697593918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8jpVbTN8e1NFVPlrUmh8i2J9AzNXH5X36L3cIHXeoE=;
        b=DZIDSWRitu5XCquyH8QbetGckz1vZS1X655mg+kH/0vx3+pLdp5tFYSfdg4eMLE0yp
         qdsVOGQb26QllYsC5Nh1BjGkwRn7CF72jVMB8lCm07EFd+3l9deEuIvoeQrR8VjcYRKt
         9/LdtekYxtO/JbrSqqbEBCxrByC/P10/DR6ytiXeaLlvXibTCS50GcJ+cXzMewcDRnSN
         HkEB0DSytmJZ4BMVlhKuPsyYcmjW1wg9TQizEYXykpkRohyX4bzTGPm8NtYzGTNBY1CW
         hE1xq0oOLR0INByrNmtcJHKHVZDFK+uG7aV0Knqwd8SyuKalK6h0e+E8AkQNqPb0tPls
         Sa7g==
X-Gm-Message-State: AOJu0YydL1ysuXnV4vCVpOZCCh5z247Sj+auCi+gbRz3IwjLEcY82/BY
        FUZHqqxw37vZQ0sydOSm6OYg7oaK3LyBBcHbXpo=
X-Google-Smtp-Source: AGHT+IFCx+g9JHWDoLnMcozkiubkyTMt0hDKy7+W4kFVGz/dfkDSi66nrCqbpAmZXiZUa1jA01VOuaFCFh5GmHP1+8M=
X-Received: by 2002:a17:906:220f:b0:9a4:88af:b82 with SMTP id
 s15-20020a170906220f00b009a488af0b82mr15091743ejs.77.1696989118416; Tue, 10
 Oct 2023 18:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-7-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-7-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:21:47 +1030
Message-ID: <CACPK8Xfbh=jM0QRNYTQ-rjsyugzhoPxxMg+-1C+5g+uNtir+nw@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Mt.Mitchell DVT and later hardware do not use adc1. It only uses
> adc0 with channels 0, 1 and 2. This commit removes redundant ADC
> configurations.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index c676172f0dbf..eb8d5e367276 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -564,20 +564,7 @@
>
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> -               &pinctrl_adc2_default &pinctrl_adc3_default
> -               &pinctrl_adc4_default &pinctrl_adc5_default
> -               &pinctrl_adc6_default &pinctrl_adc7_default>;
> -};
> -
> -&adc1 {
> -       ref_voltage = <2500>;
> -       status = "okay";
> -
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> -               &pinctrl_adc10_default &pinctrl_adc11_default
> -               &pinctrl_adc12_default &pinctrl_adc13_default
> -               &pinctrl_adc14_default &pinctrl_adc15_default>;
> +               &pinctrl_adc2_default>;
>  };
>
>  &vhub {
> --
> 2.17.1
>

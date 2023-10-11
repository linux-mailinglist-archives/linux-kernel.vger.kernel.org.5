Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE187C4779
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjJKBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344679AbjJKBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:51:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D592;
        Tue, 10 Oct 2023 18:51:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so1061486666b.3;
        Tue, 10 Oct 2023 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696989081; x=1697593881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvEek/wu0ornX7TSQqFw+K8z0hBkSwQuqkpR0z0uE5k=;
        b=mNri+D2ECy215R5kqAHAs9xWWv0MzZNwW/IVCCjVxqTpKUmtBZXGOS6cetkT14JCZh
         YMH0BraqlB4A90nl+NSJVZcX0cJhQNpAcvTMUCYPI7RNl+MQUdp7lg8Z9r0K3jyzkRim
         UQ2avkdcXEC8LY6iyPlhsVQ7bQ3IMveo+2Ujc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696989081; x=1697593881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvEek/wu0ornX7TSQqFw+K8z0hBkSwQuqkpR0z0uE5k=;
        b=hyarK0bX3RNLJVKgGPIrolXAwKgQEItfASpac+xeKe+pKKoYr9+5PLQYCvTuc8WOfI
         dYx50gW+g0cbfZGVtY2aLGlKkwUDx80nN5bhftte4/kaGIAGwjKkQShd5zxLvN1vHEqK
         iYzFxRRnTNTdR7bj3APtYsbx9yq6OqotpFQpgC8wNcQ+neQZa7gU2neFJ5Z2lVUOzK5i
         r7wZu0uVZLdg6TFEhPTLJaanlkqIJbvZc2MHfuq1JbEGZQ4WTzjvCS5H5+ENJRqIXFU7
         kLR5MG/0SL6xBWKbopn86IQAr+PDDDORBNdyCMR+KwX+rwoVNexWB/eJkYWBdeUyTp6J
         X/Jw==
X-Gm-Message-State: AOJu0YxxXgvyJ+/EzeB58ggASFiIeEWo2Sgpl6s4RPO9Fn/uuWFSZcto
        PRZtMMN63VifZKUSz5HEUOve5CK2uqnL8qQ7XforZep5OmA=
X-Google-Smtp-Source: AGHT+IEJHgu6jOvC4sfayzAJpsh/xcXdz7gNPlaBSSuCWsWCemoWp8C2Kriej5Qo+yGFOjuOzBt2CEssbvsu5fd04Ok=
X-Received: by 2002:a17:907:762d:b0:9ba:4163:1807 with SMTP id
 jy13-20020a170907762d00b009ba41631807mr1896364ejc.2.1696989080445; Tue, 10
 Oct 2023 18:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-6-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-6-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:21:09 +1030
Message-ID: <CACPK8Xcs_4G0nSeKm2+hjSrp=SBb1MJrCob+EQ1emfVOijSOjw@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
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
> Add the inlet temperature at address 0x48, which is connected
> via BMC I2C8.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 88693c2b2dbe..c676172f0dbf 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -510,6 +510,11 @@
>  &i2c8 {
>         status = "okay";
>
> +       temperature-sensor@48 {
> +               compatible = "ti,tmp112";
> +               reg = <0x48>;
> +       };
> +
>         gpio@77 {
>                 compatible = "nxp,pca9539";
>                 reg = <0x77>;
> --
> 2.17.1
>

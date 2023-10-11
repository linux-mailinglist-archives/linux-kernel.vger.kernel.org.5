Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16A7C5DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjJKT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJKT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:29:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44590
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:29:52 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F3C63FA66
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697052586;
        bh=c9L/gsOrW6x7KgEWB0KPDKoh+ZY2YJ1yGC5weBaF9Kg=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Content-Type;
        b=b92dQYTSZp0at8d5TL38lQtCwPoPE1EDOWTH5QGlnwfxq8MUgfZjqgnHBKfWm7Knf
         baXpK+lXWCf9HuYE2ohF1iak42WTUY/0Ar21MTMzMZcLs3SdSm1HoO69xxFAaNuQmN
         uJeGisidho2moWq9j6Ash3HyrrFQGY0lJ2+mCX6LL43Pxez8vVRDBquggFIbtGVA2W
         e1R4xX9mflSPLszN+85FWG0RiZzkMcWZGnY7VqYckRxZHpAalMZVfK7nrzV7mEGwH9
         dogLDEJwwxVM0CDf+Sp1R+nHPfztByxOv2CeGjYlKfkkFm7T+RTNOhZwIT8C/btRgM
         mtjqF8Klc7lvg==
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c4ed6c64e2so261154a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052585; x=1697657385;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9L/gsOrW6x7KgEWB0KPDKoh+ZY2YJ1yGC5weBaF9Kg=;
        b=i5V5V6Pok2bJuSaznKJvM8MtF4zMMI3Xr5nawyW3dgfIN1JelsWpzYdS+CVwfFjEL5
         0ElhckmCOHK1qKvPzoxCEKwafktLuzUqWIPErxWq0kLTxqoJl4JlKkBL0zwWh4tjhyAc
         y8pBFCOIS93mvCMIOKfA/pEPizTioQjlpwcxFqMG/IxnneO1tvR2dO3Cs+HtlNd61Of2
         a3EmIpk/+56Q6OZ7P732Z9DVhgGZTxSTTvTGbqyNLknZx3/NL8unIcwwyyPax+bWurnM
         adatybYQW83jDywxNOUaSJM7T1YLktuzDHqdMim1ZpV+6mLyy6SMltKbDzs5wAeySVop
         08Tw==
X-Gm-Message-State: AOJu0YxV8obv8dmD2PB64Y+AJkQkNSOm2tndVPv4Lb33jxg+DV1H/Z1Q
        c4ksbFhMSXQe2EU8gJBlrGPXpKvkS9TVUd4HirWd9eKy5jP9DLiQDp7TReojYNAjsJJRya1GUcG
        h9BEXsLOqeX2QHSwCWm1xJmiKywKVALvJlX4fkOCgDj3TlJTzuikDZtglpw==
X-Received: by 2002:a05:6830:12d0:b0:6b9:8357:6150 with SMTP id a16-20020a05683012d000b006b983576150mr22651233otq.35.1697052585227;
        Wed, 11 Oct 2023 12:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCniG85JTchLTim5ooetQCv6XtCN2Hfw918Yim3tDO0dhAQSPYJeSPxd+7rlU/R7/wacdjyqykDfsDX6EHHOA=
X-Received: by 2002:a05:6830:12d0:b0:6b9:8357:6150 with SMTP id
 a16-20020a05683012d000b006b983576150mr22651223otq.35.1697052585025; Wed, 11
 Oct 2023 12:29:45 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Oct 2023 12:29:44 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231011161414.L6wXZVDb@linutronix.de>
References: <20231011161414.L6wXZVDb@linutronix.de>
Mime-Version: 1.0
Date:   Wed, 11 Oct 2023 12:29:44 -0700
Message-ID: <CAJM55Z-YoJnZi4CrwD66v1TaJoYz1jbX+QOFXUDjhm5C9tST0w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: visionfive 2: correct spi's ss pin
To:     Nam Cao <namcao@linuxtronix.de>, kernel@esmil.dk, conor@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, william.qiu@starfivetech.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nam Cao wrote:
> The ss pin of spi0 is the same as sck pin. According to the
> visionfive 2 documentation, it should be pin 49 instead of 48.

Thanks! As far as I can tell this should make the 40pin header match the
Raspberry Pi layout, so

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>
> Fixes: 74fb20c8f05d ("riscv: dts: starfive: Add spi node and pins configuration")
> Signed-off-by: Nam Cao <namcao@linuxtronix.de>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 12ebe9792356..2c02358abd71 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -431,7 +431,7 @@ GPOEN_ENABLE,
>  		};
>
>  		ss-pins {
> -			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_FSS,
> +			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
>  					      GPOEN_ENABLE,
>  					      GPI_SYS_SPI0_FSS)>;
>  			bias-disable;
> --
> 2.39.2
>

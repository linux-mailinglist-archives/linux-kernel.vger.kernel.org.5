Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D244777712
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjHJLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjHJLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:32:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385BE42
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:32:13 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C99E33F20F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691667132;
        bh=NZfJaleioIc/dNSS6llYa1dUh5p+WpAGVhsLf8ndx7w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jlWJKwKF1nhDjzkflti59fnvxrhIU03aZ4CyN2YjHO6DVNUqceGgtBhkvAYk+iHGw
         HCPPycHCPYJxw0MGC6NI+8QkNEbONb1xPsdIiUPMXAhoonxDw/EbHRPI1beQU69RZq
         /YzKJ1OwlrBx4nDF5uyvhqQqQYat7Iw/+0H77DZYR3yYUe+/1rbLlPmOKdXXqo2WUz
         tExHaJq9FybZZEWHnckmWkEAsKRJ8mSX3LmJeghZXyc10w3W9p8DgzJJHJOPbUL15V
         fyif9/HySS24U8+U4gPvEeHKR9OEJ0t09ay+6/w3llS/+C7TWLtXKdl6XubdCZBb3w
         LYvte5PSPY7cw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40ff829c836so6796731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667132; x=1692271932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZfJaleioIc/dNSS6llYa1dUh5p+WpAGVhsLf8ndx7w=;
        b=gM9L5xRwoHgsScxw2MQNXgmyNrQnSZsp8jhQEqc6xM/FoSfZ3bNoMwVjIpLTO3E5Xo
         MUNCaUrvFPEJwbkyZ9vtlNVSS6t5J6eAQp9NQDwW+saXN4L0aNAxOdam6/739l9OKQ2M
         iOYOdvl6r2y8IswMEkPfdX8UTSufpsB9nNLhv8k6GSk5MyEUTCbZ5sLuYUjMRmzKxSa8
         q4aMzvKEbB6UkNZcrlj53CfkXXRP/EYyt0WGI3k8uyDfnbqxeybi3rxFLwjQTbzs/NVz
         L1PSnuoMxAsS3U6HsbZmBJU9SY5tWCmoiMcDxfF3S5MY6Vs+M23/9VVwCLNjo3qQjLYU
         3ZOQ==
X-Gm-Message-State: AOJu0YwqoL8uc12ee17LSv6zVy/Y9E5n4V7mIYW90OP1ymXnToNLBFHH
        FlajMDrhL6/jmUivhWkzcg7SpVb99AbdJKLxtT6bg6mDVxvAoOCSwxY1+Aq0fAP6w8c8hDLCbUK
        qwrvQqLB9i3PLPu1uhTLVBrxocG/eY/5v5owlZ9Yd4jm+POYT6XsvPnAP1w==
X-Received: by 2002:a05:622a:1041:b0:403:b4d5:a5ec with SMTP id f1-20020a05622a104100b00403b4d5a5ecmr1788505qte.4.1691667131792;
        Thu, 10 Aug 2023 04:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyU7SG7jGlFoDlU/yvYZWOWhmpI50a0rec0itMvKayLP30Sx0QIY1LoEjWPmvVEawaNn3phHjhl1jxHReilFU=
X-Received: by 2002:a05:622a:1041:b0:403:b4d5:a5ec with SMTP id
 f1-20020a05622a104100b00403b4d5a5ecmr1788494qte.4.1691667131559; Thu, 10 Aug
 2023 04:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230809013917.81674-1-william.qiu@starfivetech.com> <20230809013917.81674-2-william.qiu@starfivetech.com>
In-Reply-To: <20230809013917.81674-2-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 10 Aug 2023 13:31:55 +0200
Message-ID: <CAJM55Z8EtUjfjF04jcNwdyPzx3VmEWZs14Fr-9PDiqXcHDOe9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 03:41, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Enable DCDC1 node for vmmc-supply and enable ALDO4 node for
> vqmmc-supply.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../starfive/jh7110-starfive-visionfive-2.dtsi   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index d2f3b9eb859b..d67e26b9c791 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -165,12 +165,28 @@ axp15060: pmic@36 {
>                 #interrupt-cells = <1>;
>
>                 regulators {
> +                       vcc_3v3: dcdc1 {
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc_3v3";
> +                       };
> +
>                         vdd_cpu: dcdc2 {
>                                 regulator-always-on;
>                                 regulator-min-microvolt = <500000>;
>                                 regulator-max-microvolt = <1540000>;
>                                 regulator-name = "vdd-cpu";
>                         };
> +
> +                       emmc_vdd: aldo4 {
> +                               regulator-boot-on;
> +                               regulator-always-on;

Hi William,

Just a question: You mark these regulators as always-on, so they'll
never be shut off even if the device is suspended. Is that because the
mmc driver can't deal with reinitializing the mmc/sd-card if the card
has been shut off while suspended or is there some other reason to
mark them always-on?

> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "emmc_vdd";
> +                       };
>                 };
>         };
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

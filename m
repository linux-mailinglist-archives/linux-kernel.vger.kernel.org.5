Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224AF806BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377357AbjLFKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377339AbjLFKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:24:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800E1B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:24:51 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 203BD44450
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701858289;
        bh=LIKhW4ss/YSZZ/5dNTu3+bUFxFWLLuAd/satadt/iyM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=s1dyQfezQGuGylOz1IYl0UfRkJNWl9DlxWq7y4/AMY2L/isWTrach9vlBK+S2Uo0A
         ZfHog0B2+kVmtEstUTeMgQmbhrJqfOdmGmyrK/jEgd11Kzo2s20n5YyEei6gPZ6Yat
         Yk99rAN6kcuDVQDJrrSwHWU20qYScJp/za5Kk+CpQtlyNKDY9q431i1tlhptPvmZK1
         fku2DE9N0+WDHHWsDXCKU9IJsp08zjKIUPGI0L+Fjm9fMzM0P52704FKdG3ut2d0m8
         VTmaDij1VUsNLbsd9fa8f5KIBr7nZhhEiglViuVB0x9F27LKsqMDmiYqiiOiyaczaJ
         IXdI+K7y/xIZg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca06829ad2so4384651fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858288; x=1702463088;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIKhW4ss/YSZZ/5dNTu3+bUFxFWLLuAd/satadt/iyM=;
        b=kgUaTibIMhrcKdlrvyMBU5M5nmUQR0a+Nzy7jFzMFATC+3UNgjr0MPlNIWlviIJTBB
         l8FogxNF8SinSkMUgB1woJy3+mkoLHfZ6dYfNNf5NqyTZjTpBWQ0DGhfDbvNuY23jNmw
         qTRu5GQfdhxqC3Rf9mLsyGSMCTSEWH4U3H36/zQaiUPySaCNyWbskCfOc4mEuw+SApvP
         Dl8tWea9SRLQiJsBNjCAJuDO9oGRHdT3G/nswefnQg1OgZCVWqsZubDCNNPqkZAuM9oy
         FPp599EWKo7BrxGaEN4kPpTb3qtOExPh7Qds2yajmFKQ3bjPu42ZUqyddJnJ2HhMg+zg
         NVAQ==
X-Gm-Message-State: AOJu0YzOMQZbAyeP+F/xHtjlN7B94Tcj9IO4mXH5xRpoXvixBfvDl5ig
        g08i4JnfhJs00v7Md+Z9lhNwq2Rz7cOC+ZEo5LW/1gQL8hOJZ4iIjuJ1d/abo2dyuWyXmrIj03w
        MzsSvPCeSUHwktA8A/0ZXOiHF8gN74l4I6tbd1ygPQ0u9JTbLxz2c/lAEqQ==
X-Received: by 2002:a2e:a30d:0:b0:2c9:f59d:36b8 with SMTP id l13-20020a2ea30d000000b002c9f59d36b8mr512524lje.8.1701858287655;
        Wed, 06 Dec 2023 02:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCeINFJy0uhVhrZBDH15wYnuutrQXQWc7tS3R3VsQ92NNxf1Fzl+nhQI6LO6WIc+v6/wFypP12KWEtfWYx+EA=
X-Received: by 2002:a2e:a30d:0:b0:2c9:f59d:36b8 with SMTP id
 l13-20020a2ea30d000000b002c9f59d36b8mr512512lje.8.1701858287360; Wed, 06 Dec
 2023 02:24:47 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Dec 2023 04:24:46 -0600
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <IA1PR20MB49532959D6D95B0D9D5E6A4ABB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <MA0P287MB03329157B1914F38A3485402FE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB49532959D6D95B0D9D5E6A4ABB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
Mime-Version: 1.0
Date:   Wed, 6 Dec 2023 04:24:46 -0600
Message-ID: <CAJM55Z9CCH3n5g4_cRid-inr0SU_Kk39AhbrCavGJKhOoz=asw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: sophgo: Add CV1800 series clock controller driver
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inochi Amaoto wrote:
> >
> >On 2023/12/5 19:55, Inochi Amaoto wrote:
> >> Add driver for CV1800 series clock controller.
> >Add more clarification on your changes. Seems you add several files with different names for different products, what's your design idea, please add some brief introduction.
>
> In fact, it just adds the driver for the whole CV18XX series. I do not
> think its clock controller has something different for different product.
> The CV181X does have more clock, but it shares the same driver code of
> CV180X. All the things just follow the manual and are for the hardware
> design. Anyway, I will have a try.
>
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV180X-Clock-v1.xlsx
> >> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> >> ---
> >> ......
> >> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
> >> new file mode 100644
> >> index 000000000000..243d58a30117
> >> --- /dev/null
> >> +++ b/drivers/clk/sophgo/Kconfig
> >> @@ -0,0 +1,7 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# common clock support for SOPHGO SoC family.
> >Drop this comment line, moving forward, this Kconfig file will be re-used for more different sophgo products.
>
> Why? I do not think this have some impact on reuse.
>
> >> +
> >> +config CLK_SOPHGO_CV1800
> >> +    tristate "Support for the Sophgo CV1800 series SoCs clock controller"
> >> +    default y
> >> +    depends on ARCH_SOPHGO || COMPILE_TEST
> >Suggest to add some help words for this config item.
> >
>
> There is no extra information other than this title.
> In fact, I think the description title is enough to describe this. Add
> a duplicate help is useless.

I'd also like to see some more information here. Eg. what are examples of SoC's
in the CV1800 series. checkpatch also complains:

WARNING: please write a help paragraph that fully describes the config symbol
#337: FILE: drivers/clk/sophgo/Kconfig:4:
+config CLK_SOPHGO_CV1800
+	tristate "Support for the Sophgo CV1800 series SoCs clock controller"
+	default y
+	depends on ARCH_SOPHGO || COMPILE_TEST


Also the driver says "tristate" here, but defaults to built-in. If it works as
a module it should be default m to not waste memory on systems not needing this.
If it can't work properly as a module then tristate should be bool and the
driver should be updated for that.

/Emil

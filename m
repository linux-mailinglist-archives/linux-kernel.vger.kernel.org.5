Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE8759E75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGSTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGSTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:22:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D421FE6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:22:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso2463751fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689794558; x=1692386558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ysNwjk8UXaejFC9LhYRBkCbtGa60gstdQxEPQxcWfg=;
        b=j+q/QsMtwtvtTkWHLIVFejo9gdEkiuiWj4pgcdAp0MOIrorwC65O0O1jDj9LOwn42y
         Ti2G3kXuXQao8oWPAjvuiQ28C89qlDFscBQ/WqSKDecM/R91WX4L8rw3WgjLtggyiFfn
         8+j0H0Z0x+jFE9BjbNh/Bjio2wyUnMnXZPEV+A8EKKKmyIsBvAsEUU8PNBo58Y5yy/Pn
         mcZkFz48mzBJRjwmSjrLPvPKt1IlTXGU3I4exHNPzGr8uaVBZE4I8IH/WhUC82kDmHbR
         tyvdYTYL+OIc+k0zwWF3z+RzT1O/OgzWe7RFSNTIfy8kg/k1s/OYb4o3M15VvuXwDelm
         ciog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794558; x=1692386558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ysNwjk8UXaejFC9LhYRBkCbtGa60gstdQxEPQxcWfg=;
        b=AK74YT92mfVEQDQHfp0nL1uJSqK0KT2C6AH1cUfjqnzny+d33MhUbX1oh/fwreCOB9
         /fuEI6NL//ERx2lYjUUhagpZGGkGSIDA+8mgXtwX++pcoMjfKXJt3JpBe6D5p0s0e6n6
         66ucj4yrI8J3gVgUnNdoZzaInHJDZf1hPaWRQFzqMVMw3Pu5BF3wtyiAkHJ0vPuT43P4
         4VEmMEvErLpiBGv5yiJbugTkkk8fM5Hr+aw+s4Km+Ja9LA75I8/C5VKvl5Kt4E9X5PyZ
         XXJFlxZbhoPUigPbGQxbxzzJFIhNnaOIXnSX89G9Hi4oafFLqQdrCxbiaVC5FUMfVPLH
         380Q==
X-Gm-Message-State: ABy/qLaTMzqJhIzIRr4dUvaKa1o/3tPvmDQ3O8evpuJ+k77UmgIXWpGs
        uY0tpu3BKGyt7Zc4seG6Kza5QQ==
X-Google-Smtp-Source: APBJJlE7TgekOShNU0sKY5OWC07ia1vTU2eUCl8ISkIQp3Qxe0zscLREml6szv3jGRvJ2YGFw4mopg==
X-Received: by 2002:a2e:9c82:0:b0:2b6:d2c5:4d54 with SMTP id x2-20020a2e9c82000000b002b6d2c54d54mr595213lji.18.1689794558386;
        Wed, 19 Jul 2023 12:22:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbb346279dsm2317242wmc.38.2023.07.19.12.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 12:22:37 -0700 (PDT)
Message-ID: <efda16fa-20f8-a3a5-203f-d1325dd00afd@linaro.org>
Date:   Wed, 19 Jul 2023 21:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
 <20230719160048.2737423-2-james.hilliard1@gmail.com>
 <15268646-a38f-f530-4c04-1164617d2b25@linaro.org>
 <CADvTj4oPjGZzjJzjRNXprF1Nz9Hmn=Qs+s=0cke5e3Lb27YLFA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADvTj4oPjGZzjJzjRNXprF1Nz9Hmn=Qs+s=0cke5e3Lb27YLFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 21:11, James Hilliard wrote:
> On Wed, Jul 19, 2023 at 11:18 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> +
>>> +&ldb {
>>> +     status = "okay";
>>> +
>>> +     lvds-channel@0 {
>>> +             fsl,data-mapping = "spwg";
>>> +             fsl,data-width = <24>;
>>> +             status = "okay";
>>
>> Again, why do you need it? Is it disabled?
> 
> I think so?
> https://github.com/torvalds/linux/blob/v6.5-rc2/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi#L87


Then it is okay. Usually nodes are extended via phandle/label.

Best regards,
Krzysztof


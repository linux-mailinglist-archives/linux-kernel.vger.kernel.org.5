Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5694D76EC87
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjHCOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHCOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:30:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECD1728
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:30:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so1356032a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691073010; x=1691677810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLGQIBcmnPlkP1H90L4arPiKiIXchPemEGcuJPAOma0=;
        b=V+wQrfpbow5/ttxZyUaV1RdKWQBC7AlUZ+3pcXXgdBtzPOqOmhWAJj48MQ2U9Uu1Uh
         0hnPC98eznmSl92mH0pwquOMr4wm2BVnKGHKU9b6cP2b9g0NzW5jsIZ9WigeqeG5wMpP
         WAKPsyO7mcI6WXaLmxpP13y2dwywJxIuOQbO7Voz9sPm7KK4bdzTpEhKCamLxREpsZDK
         u/s1C64p5ogdHE6+0YMBAlD+f1hiY6xh6x+Xg65Erhk9UkBCxZ+pqKQXXIjXy4r9pHOR
         XC/z3K4SP2DpXMumtmvd5xcVevAlg0cNvG7rQ2ljBVr6wsL9uq222QCYvEBiUnzG3gyA
         Xx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073010; x=1691677810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLGQIBcmnPlkP1H90L4arPiKiIXchPemEGcuJPAOma0=;
        b=DSJNdLLbeCzFeAycuOSk0pgMC8H0VU7kE36qZa21sSf+12TX6Qb7BCY+dyPwodvinh
         rReTdDHh9qVHWdyS8PSpA3Ib0CQSh0TeSQC6QKwIMnpuVFj6c0dh+EJjfyWoSrf10gSv
         H1ZY28P2k57jrcMiYN3hjQPgZxw6O4pLSJ5nTqg4pS0O5WtF1TSCeiK1r26EcqgvM9qB
         lEbmpMly38myEm1kEMV8as35gm35DLT036e/4Cq/puqO7RHsIogLrfz1a45Zc9TzDLko
         oEn5e6OMKYoSpRWfvbJmppHje7kaVpSeS6j8vSDGrnIP4JDlCgxAx02RDC/icyQWDZWw
         RXYQ==
X-Gm-Message-State: ABy/qLZdm4bpp+jMCQr1dyxZrJLv3d7hGVo1IlERDuh8fuCWZZjBlbsW
        X6XhpXrjQx+IUVyifbnnPsEvgw==
X-Google-Smtp-Source: APBJJlHOlI75QhDtYFAg9HERhBvyV2JLY/tIUjauBt+B1yJGtKwFW58txzygi3y9gEXeh2orqraKGw==
X-Received: by 2002:aa7:d705:0:b0:521:e502:baf8 with SMTP id t5-20020aa7d705000000b00521e502baf8mr7841254edq.11.1691073009875;
        Thu, 03 Aug 2023 07:30:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402078700b005221ce96801sm10344275edy.35.2023.08.03.07.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:30:09 -0700 (PDT)
Message-ID: <17dec3fb-1bce-77ff-9917-7f565049954d@linaro.org>
Date:   Thu, 3 Aug 2023 16:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 6/6] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
Content-Language: en-US
To:     Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <DFE9B2F1349F69AE+20230802220309.163804-7-martin@biqu3d.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DFE9B2F1349F69AE+20230802220309.163804-7-martin@biqu3d.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 00:02, Martin Botka wrote:
> The BigTreeTech Pi is an H616 based board based on CB1.
> Just in Rpi format board.
> 
> It features the same internals as BTT CB1 but adds:
>     - Fan port
>     - IR receiver
>     - 24V DC power supply via terminal plugs
>     - USB to CAN module connector (The actual USB to CAN happens on the external module)
> 
> List of currently working things is the same as BTT CB1.
> 
> Signed-off-by: Martin Botka <martin@biqu3d.com>
> ---
>  .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> new file mode 100644
> index 000000000000..05f39b3606ba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-bigtreetech-cb1.dtsi"

If this is using CB1 DTSI, does it mean it uses CB1 SoM? If so, I think
this should be reflected in the compatibles.

It's a bit confusing because in previous patch you call it "CB1 board"
but then with name "Manta"... So what is CB1?

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4337C7D38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJMFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJMFvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:51:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902EC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:51:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b974955474so264158466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1697176288; x=1697781088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAXPkFEVO9NEy1CgnJcKxdErF48Wzyp1pIE8KdvUE5o=;
        b=fDJq079Qcm6+VouFFteEdR81wVhKmMYv+DwLQVlUh/PIuuQ+5lsG68xiay0vQ9yGxC
         hu3eYKfrEgy+FafaqyS3II5Kql0PhwBcoJF2YWXAekviRo9C0qHckPA7aTLMIbzeIHlE
         1fsg/TwYjYDWLFq4wMvkhBy/P0C3oDA3azTYHSryWnpd4RACUUWVMAqiaSP5lkTl8nNJ
         sa0QgOsjrGy0TfFOInvBeLiJ6+tyoQ071WuzoFd2BpTVPoo6ZUZeFvs59WFl908XLlDt
         8aqPqfSwrFYtp7hJEsec9m1N7rNyw4aaPYdu/jMxMo3RsAYf6Unic8ppYu/HuYRM0Nc+
         t+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697176288; x=1697781088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAXPkFEVO9NEy1CgnJcKxdErF48Wzyp1pIE8KdvUE5o=;
        b=OWEzAqmFJ7tJtU1w3JY0HndR1YXVY0Ldq73wp75fpOReaXNJtxu+tnwXVFLC5nCaEF
         fngBcuVZMJ8ybbHPKs4VpJvZ0f00v0kkUfQdWXpZZEgNwh5qHK9z9Bh/n0rp9y9Sh5Uo
         CLhXq97RnrM5mSJ50PsvAnCp+aRsfHY2iwOWlBuucmbl9u/PXpf2uWncf3XLj+PO4QBx
         xNQIJ45+omSkYNd/8EVpD3RuKK3kI1U60wflMVpHZVSk8EYC/c5Hw+xL2ATJnptJRHrU
         14LPLlZjmFpuu97rTB+LCuTdsbzTSH5rcXSEBxCfyQXLOLXdAgAYvOIsODKZQE39H6yD
         uPzA==
X-Gm-Message-State: AOJu0Yw34hhnmThr9jS28yZ7vb69Zu2LEoYbj/xKfVf+qBvTMBbY77RS
        DEsHJDzNi3N9knTuavdqK/2f5A==
X-Google-Smtp-Source: AGHT+IHmc9LtDuylGDF0Uig4QbannJCtiHcJ/b42Sf8kD1VjI0wEyeEWOKYrTIT/FTWC9eedWAgM5A==
X-Received: by 2002:a17:906:3156:b0:9b2:b71f:83be with SMTP id e22-20020a170906315600b009b2b71f83bemr22216827eje.1.1697176288653;
        Thu, 12 Oct 2023 22:51:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.133])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0098d2d219649sm12086328ejq.174.2023.10.12.22.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 22:51:28 -0700 (PDT)
Message-ID: <e678ef3a-0f84-4ea2-9116-a661b91b2e32@tuxon.dev>
Date:   Fri, 13 Oct 2023 08:51:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com>
 <20231010132701.1658737-6-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdW+5MZXRbDtZtmrMkrCtwqqKUcW_W1_5U_2yO6w6aCa_w@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdW+5MZXRbDtZtmrMkrCtwqqKUcW_W1_5U_2yO6w6aCa_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.10.2023 17:44, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Oct 10, 2023 at 3:27 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add SDHI1 to RZ/G3S Smarc Carrier-II board. This is connected to a uSD
>> interface. Although Vccq doesn't cross the boundary of SoM it has
>> been added to RZ/G3S Smarc Carrier-II dtsi to have all the bits related to
>> SDHI1 in a single place. At the moment SoM is used only with RZ/G3S Smarc
>> Carrier-II board.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>> @@ -11,6 +11,27 @@
>>  / {
>>         aliases {
>>                 serial0 = &scif0;
>> +               mmc1 = &sdhi1;
>> +       };
>> +
>> +       /* Reserved regulators 0-9 for SoM. */
>> +       vcc_sdhi1: regulator10 {
> 
> You can use sensible names for the regulators to avoid conflicts.
> E.g. "regulator-vcc-sdhi1".

OK, I'm aware of that, I'll use it like this in the next version.

Thank you,
Claudiu Beznea

> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

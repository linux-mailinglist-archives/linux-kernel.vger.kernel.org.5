Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E57B7CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjJDKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjJDKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:07:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79C9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:07:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066692ad35so18402025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696414074; x=1697018874; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=MBKM8WudF4CqsEttpndJwRTdLPCz/dkPP0MH3GBVDlA=;
        b=kGnIldHkqjYF49qEzlOaehapPYwPRe1ID6FuSYDEUFaNzx3Y+ctrXpc4exGa41Frio
         N9EDm5ZXwyJbptHrgx7RTicg3plZpXCpbpcDI2/LS8UfQvPBCgOAwA6DKUTjxllDPffB
         wDWkVW5CjsojHDuTkzzaWAoL21P/Qs0N+NV9wxvZBw8o7vBOlxmKa0cWRJdiUpuuN04K
         aTK3Fpd6nu1RamQENtCxTwGvNVS+QnLvMX83l3qpu00VrSesuZ1Hg7grkSeRGPExouvL
         iHp2PgduiPHM5hq92dHlcofCnsy2HjSfNI7f1AnVpmc6TJSOnzCaZbKhT0SoIf/ho+Jh
         GVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696414074; x=1697018874;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBKM8WudF4CqsEttpndJwRTdLPCz/dkPP0MH3GBVDlA=;
        b=aOamE6Ofwp775kjzs5/GNjbKeZ5FHAw18S+tW+OAJm6ZWGwTslZiI6Ca578fsk0O4i
         7qFyUAoB4xw3O1d3oJT1Xqvo/b0H9OYvFjHKx/HNhhuo/n7VwS+vLBMUIOmN5+Uet/V1
         kacEYk68cSf38S6KXw0akS1G5fbJHGf0gvJOPJIvZkk4Ny1pWhbp+jCZ1AxdzOtTLRsJ
         89uXhJWQ2V0talkZduNGysZQhqL6W73BLIwj0Mxndp+debguLdFVEJKIROsDcA2BbdkA
         rLTcq6VEegurCatuX9XvFaSbJQfwOS1BKkW6kZuTJvTksoMVECZ4esh0Zx6pVHFb4hIK
         YypA==
X-Gm-Message-State: AOJu0Yx5V39xDkOcHv4aPGtMtSrouvFsvxfurJgxbh3J5HMZwHgF+GRx
        mK7T2Kf+uisjN/SWCP8I1H+5tw==
X-Google-Smtp-Source: AGHT+IHQs2OVv7qxHlgfeXUsFovafyJV0iId+qZZAuGf2Y7OewcW4WvIpw4kR8j5aS/my81AXiNOdA==
X-Received: by 2002:a7b:c8c8:0:b0:401:906b:7e9d with SMTP id f8-20020a7bc8c8000000b00401906b7e9dmr1729419wml.18.1696414073831;
        Wed, 04 Oct 2023 03:07:53 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d9fc:647c:aca8:fc21])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b00405442edc69sm1109745wmr.14.2023.10.04.03.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:07:53 -0700 (PDT)
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
 <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
 <CACdvmAgzBxja-oJkS9c88=P0Wmc1ptkJExz6YjaJUyyv6yxh0Q@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Da Xue <da@lessconfused.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Wed, 04 Oct 2023 12:03:40 +0200
In-reply-to: <CACdvmAgzBxja-oJkS9c88=P0Wmc1ptkJExz6YjaJUyyv6yxh0Q@mail.gmail.com>
Message-ID: <1jh6n6ya2v.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 03 Oct 2023 at 05:15, Da Xue <da@lessconfused.com> wrote:

>> >> +
>> >> +    leds-gpio {
>> >> +            compatible = "gpio-leds";
>> >> +
>> >> +            led-orange {
>> >> +                    color = <LED_COLOR_ID_AMBER>;
>
> Should this be LED_COLOR_ID_ORANGE?

It should (and initally was)
It was coming funny '(null)-standby' in sysfs and I did really checked
why

I can change it back, no problem

>
>> >> +                    function = LED_FUNCTION_STANDBY;
>> >> +                    gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> >> +            };
>> >> +    };
>> >> +

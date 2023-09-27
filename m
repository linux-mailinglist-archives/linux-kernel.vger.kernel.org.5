Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2767B023F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjI0Kye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0Kyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:54:31 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BCF3;
        Wed, 27 Sep 2023 03:54:30 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59f4bc88f9fso102587927b3.2;
        Wed, 27 Sep 2023 03:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812069; x=1696416869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3Muq474iQgcyKLGlerzfl9W5nE8h5TNCDY2DPjEIbk=;
        b=W3AFHC15Td2nrVAEHGYyfudmIykPUMaqpNXES7Cyrq/ZN3+T85MJTrPZhubI89IEhT
         K9N7otaKl9pZQ9gCvm53N98fJ0iYTgE6tXjO+YktnORZdeVN4FZaRf8gjIKBSSBZsSGW
         oFYEraLduvCP976Aeawm7Gbx/nBVWZVTy7B7vdHeewyoAea7bmHp7cGKSOpPUs1c17IO
         aQqm6Anga+sLLdwz91E31itoJHNCi7vZROxMg/uUPAh3Ho0oPSbE1cX0Vs/vRfk8HIKq
         9AqzqFl4Jk7UXHKmHJrGGIq+LKpkyCgmhAeDxqGutjgF/5iBeKz7trr51mW+v8/DJRke
         s4Gw==
X-Gm-Message-State: AOJu0YzFwMgJe7cqAvfSp1dCv7RmllLehnqR5S35EX9FiQCC/kiyTWrc
        ICfhEn9LbFuszZ/awiuollRWnxT+34MlzVVC
X-Google-Smtp-Source: AGHT+IGAs9fBWpUfCyhTwfRrA9uSDBBWKr5xBPlGMkJqZwl2IgEvckZhvuVwXiQqBwhVezRzSwkAHg==
X-Received: by 2002:a0d:d60f:0:b0:56d:3b91:7e78 with SMTP id y15-20020a0dd60f000000b0056d3b917e78mr1935374ywd.20.1695812069596;
        Wed, 27 Sep 2023 03:54:29 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id fu18-20020a05690c369200b0059f67a72276sm2037168ywb.17.2023.09.27.03.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:54:29 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d81f079fe73so12466978276.3;
        Wed, 27 Sep 2023 03:54:28 -0700 (PDT)
X-Received: by 2002:a25:3dc4:0:b0:d80:1bbf:fabf with SMTP id
 k187-20020a253dc4000000b00d801bbffabfmr1510285yba.2.1695812068696; Wed, 27
 Sep 2023 03:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230922094342.637251-1-huqiang.qin@amlogic.com>
 <20230922094342.637251-2-huqiang.qin@amlogic.com> <ff2c6d41-7c9a-4633-8343-eb94404de6e8@linux.com>
 <2d7eac30-480c-49a4-903c-d4f2b3cdfc8d@linaro.org>
In-Reply-To: <2d7eac30-480c-49a4-903c-d4f2b3cdfc8d@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Wed, 27 Sep 2023 11:54:17 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2vpMM78DA_Q1YLddwogW_vHLDLQbO_mnBk_zMNg7V8KA@mail.gmail.com>
Message-ID: <CAJX_Q+2vpMM78DA_Q1YLddwogW_vHLDLQbO_mnBk_zMNg7V8KA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: pinctrl: Add support for Amlogic T7 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Huqiang Qin <huqiang.qin@amlogic.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 8:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/09/2023 08:08, Lucas Tanure wrote:
> > On 22-09-2023 10:43, Huqiang Qin wrote:
> >> Add a new compatible name for Amlogic T7 pin controller, and add
> >> a new dt-binding header file which document the detail pin names.
> >>
> >> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>
> >> V1 -> V2: Rename amlogic-t7-gpio.h to amlogic,t7-periphs-pinctrl.h
> >>            Corrected indentation format.
> >> V2 -> V3: Updated subject.
> >>
> >>   .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |   1 +
> >>   .../gpio/amlogic,t7-periphs-pinctrl.h         | 179 ++++++++++++++++++
>
> ...
>
> >> +#define GPIOH_0             148
> >> +#define GPIOH_1             149
> >> +#define GPIOH_2             150
> >> +#define GPIOH_3             151
> >> +#define GPIOH_4             152
> >> +#define GPIOH_5             153
> >> +#define GPIOH_6             154
> >> +#define GPIOH_7             155
> >> +
> >> +#define GPIO_TEST_N 156
> >> +
> >> +#endif /* _DT_BINDINGS_AMLOGIC_T7_GPIO_H */
> > Tested-by: Lucas Tanure <tanure@linux.com>
>
> How can you test bindings?
>
> Best regards,
> Krzysztof
>
Sure!
make dt_binding_check  dtbs_check don't flag any issues with T7 bindings.

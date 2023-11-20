Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F417F0F40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjKTJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:41:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650EA7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:41:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b23aeb9d9so3959645e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700473301; x=1701078101; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=u4ulDi1zHXqoku3tvf/oqVF4mugJudCNC02l68RjBP8=;
        b=pHw/W39xVd3hrgEd1kBehowhl1F+WiDU3c4PJNJ8WRC16rtj+A8huty+ddBLJnT1Yd
         mtZyJp+5SeKceUt6Kfs2lLeLid9C2EyGw8N3s9blbd6Y+glp1Y8wpJq9yWqLdqwknqx+
         zhSJgDV3gWd3kkEP/egCY/ho2VVZVSCMMBxIr8rwuFEb5LaCFqFgCln5UEAzdliRyjOI
         pcZWNmSHKXT3J48/t+gCyYhT0403Hn7rAa5Kwo4/pbiPV+0JgBBdSTFxujNSDLbsc0F0
         D5nz0htDu4RJE5+iyBLIj3lSHFWkjmdqnxaQG4lYhat+jDfhudCR2FVgrjz7AUBpk1sz
         kSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473301; x=1701078101;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4ulDi1zHXqoku3tvf/oqVF4mugJudCNC02l68RjBP8=;
        b=Zzlyo4n7YNiDK3MTVzaxQhsHsIDjKanb6IGIchY0B/f1gceQZtqW/vkmaMO97scc2J
         WUmhV53anHGZX11bbVYEtTZ7/0zYDgVxT1pul3tqe3qK0kGKVHSS3SfzpWpWnJ/eo6ng
         2qBykUnvQmq5TayUU2KTxp0zLZE9w5vnJO9tYfnAM+DtuH2wFKfznltCBAB5G4DYYTn6
         T0Cw0FJdq9y3Af1UEzeAlp1uEmJJUo4HZQBRS9+NkMb0QkqP+mkKbvYW5JYf1NBtQNYG
         olKkMwPyZeJry5VqGttsHDNO8HtQC1ssX02+94DcZLE4i8B/njmiWIP+ZvA8IiQNu8Zu
         buBg==
X-Gm-Message-State: AOJu0YxfV0m0BcSpD8RNEfA1ZJQUMWbTJs58Jx1/724vd5shiqb5uzeG
        Y0Wdz7PjlakgkjDZvX0YQSbO4g==
X-Google-Smtp-Source: AGHT+IFWBpYs1rdj5ektHnIdcJ0DTx5BglePzoH5Vl8iaEVmWHT4d5KBd0tVA9bREgg+XhAIPJFg/A==
X-Received: by 2002:a05:600c:a07:b0:405:3955:5872 with SMTP id z7-20020a05600c0a0700b0040539555872mr6074687wmp.18.1700473301399;
        Mon, 20 Nov 2023 01:41:41 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:36e8:9c14:4901:7aca])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00401e32b25adsm12979612wms.4.2023.11.20.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:41:40 -0800 (PST)
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible
 for meson8 pwm type
Date:   Mon, 20 Nov 2023 10:18:49 +0100
In-reply-to: <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
Message-ID: <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 20 Nov 2023 at 09:27, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Rob,
>
> On 19/11/2023 17:05, Rob Herring wrote:
>> On Fri, 17 Nov 2023 13:59:12 +0100, Jerome Brunet wrote:
>>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>>>
>>> The previous clock bindings for these SoCs described the driver and not the
>>> HW itself. The clock provided was used to set the parent of the input clock
>>> mux among the possible parents hard-coded in the driver.
>>>
>>> The new bindings allows to describe the actual clock inputs of the PWM in
>>> DT, like most bindings do, instead of relying of hard-coded data.
>>>
>>> The new bindings make the old one deprecated.
>>>
>>> There is enough experience on this HW to know that the PWM is exactly the
>>> same all the supported SoCs. There is no need for a per-SoC compatible.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> 
>
> I'm puzzled, isn't it recommended to have a per-soc compatible now ?

I have specifically addressed this matter in the description,
haven't I ? What good would it do in this case ?

Plus the definition of a SoC is very vague. One could argue that
the content of the list bellow are vaguely defined families. Should we
add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
This list gets huge for no reason.

We know all existing PWM of this type are the same. We have been using
them for years. It is not a new support we know nothing about.

>
> I thought something like:
> - items:
>     - enum:
>         - amlogic,gxbb-pwm
>         - amlogic,axg-pwm
>         - amlogic,g12a-pwm
>     - const: amlogic,pwm-v1

I'm not sure I understand what you are suggesting here.
Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
has that and I'm working to remove this type, so I don't get the point.

>
> should be preferred instead of a single amlogic,meson8-pwm-v2 ?

This is named after the first SoC supporting the type.

Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
Plus the doc specifically advise against this type of names.

>
> Neil


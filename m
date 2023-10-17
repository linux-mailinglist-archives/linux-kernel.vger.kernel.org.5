Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25257CC620
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbjJQOpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbjJQOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:45:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0111B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:45:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d895584f1so4908536f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697553940; x=1698158740; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+DWlrz0x76UjYkaGdGnLZ2Rh1fZ6zXslYKfY1dC+IHA=;
        b=qMo6sN7cYVmS6jAa1w0Od1vvUvwGXAgoVLFkjEsaBT0TrKTNFHu+yAIbGOzn1SYw0i
         Z/doFIDljkUMcHhlvHaEKSvBom4kEb7SHF+KcGU72x5ApYcNs84+NPbEx1npVpbp9O1P
         Pm1ClnAbipPL/M3EFQMwh9iSNBPPa9VNAYU0biQKM3YGNso82ekvYnEibX62wFY0s34r
         G5ceVHqUcEZORd7FZB9KkIbfodKBlZOtxA2ZqOxxAIzheOTTmDKtg/UJ/emHpKLkQdja
         mVWAPkNyXTfF/+2smtTKomwZdZkV/wtaTm61ztd0ITbmfB/4DlMLA2Vq/uEkbq1N5yMP
         /vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553940; x=1698158740;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DWlrz0x76UjYkaGdGnLZ2Rh1fZ6zXslYKfY1dC+IHA=;
        b=GBLfyYzfHIkdmkZ9n9sY7TQYzkx+QEkMhAuSSuRKetdmKjkwKGBAk6aYGNbUj/8ttS
         xjZWSvbZ0HofycHurcCO8WIGPl3glIYQ+NnKMbEgVL4DDVF5eBK/t/mT3hwg8gkE7ifd
         lH0U0qkFCouJ4vcgzphdpgmg/Ds39bSlVX4+2i8VzBHfcQhiVBbgRXvc35J51b3UI1vx
         82vsJJrM7YxY/IlRIjCo6nyb0VfWLq8Isq8hj2gzCVhlbWmH8QY2qYw8+Z229aD4Rqpq
         sBBSmEPj2JHQgd4QZOQT1wcYX2Yp59MWparRc3RCf2BlzcyZU6Nl0o9imdG7Jp2hSCva
         iRtA==
X-Gm-Message-State: AOJu0Yw8tcwz8B3DTr2RICDT80Tq7+3dZhX1P0aQNDuTDC9yQwwJ+70S
        0yD03hjLuvOOm0mmVQ4hQb5RRA==
X-Google-Smtp-Source: AGHT+IHv4tMX6UOg3kp7PY1gGcIQM6g1TDAYAriGkQzPC8aBujNF8FwzAx86QVQ0PfLQQ8q7Fyek6A==
X-Received: by 2002:adf:f006:0:b0:32c:ea14:89e5 with SMTP id j6-20020adff006000000b0032cea1489e5mr2086062wro.39.1697553939617;
        Tue, 17 Oct 2023 07:45:39 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:93d3:2aab:95bb:3a09])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b0032da40fd7bdsm1836412wrp.24.2023.10.17.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:45:39 -0700 (PDT)
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-4-xianwei.zhao@amlogic.com>
 <1jil7ax64i.fsf@starbuckisacylon.baylibre.com>
 <3238e57a-1141-53ad-8170-c6ad9df03acb@amlogic.com>
 <1jfs29v0n3.fsf@starbuckisacylon.baylibre.com>
 <8011f0c0-0d21-447f-9a6b-07ede7db8713@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Chuan Liu <chuan.liu@amlogic.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
Date:   Tue, 17 Oct 2023 16:42:25 +0200
In-reply-to: <8011f0c0-0d21-447f-9a6b-07ede7db8713@amlogic.com>
Message-ID: <1j34y9ux2l.fsf@starbuckisacylon.baylibre.com>
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


On Tue 17 Oct 2023 at 22:39, Chuan Liu <chuan.liu@amlogic.com> wrote:


>>>>> +
>>>>> +static struct clk_fixed_factor fclk_div2p5_div = {
>>>>> +     .mult = 2,
>>>>> +     .div = 5,
>>>>> +     .hw.init = &(struct clk_init_data){
>>>>> +             .name = "fclk_div2p5_div",
>>>>> +             .ops = &clk_fixed_factor_ops,
>>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>>> +                     &fixed_pll.hw
>>>>> +             },
>>>>> +             .num_parents = 1,
>>>>> +     },
>>>>> +};
>>>> This one is wrong if I follow the doc.
>>>> It is supposed to be fixed 8 divider taking it's source directly from
>>>> the DCO, skipping the OD post divider ... assuming the doc is up to date.
>>>>
>>> No, C3 SoC div2p5 is not skipping the OD post divider.
>> I a bit surprised there would be a frequency multiplier considering the
>> complexity of it, when skiping a divider is possible HW wise. Are you
>> sure ?
> This part confirms with our chip design engineer that fclk_div2p5 here is
> actually a clock output by a divider with decimal (divider factor is
> 2.5). The divider factor in clk-divider.c is int, so this description is
> used in the software. Or what do you suggest would be a better way to
> describe this type of divider with decimals?

It's alright. keep it that way then.
Consider fixing the doc maybe.

>>>>> +
>>>>> +static struct clk_regmap fclk_div2p5 = {
>>>>> +     .data = &(struct clk_regmap_gate_data){
>>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>>> +             .bit_idx = 4,
>>>>> +     },
>>>>> +     .hw.init = &(struct clk_init_data) {
>>>>> +             .name = "fclk_div2p5",
>>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>>> +                     &fclk_div2p5_div.hw
>>>>> +             },
>>>>> +             .num_parents = 1,
>>>>> +     },
>>>>> +};
>>>>> +

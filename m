Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF717B3296
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjI2Mbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjI2Mbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:31:51 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829871AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:31:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59bc956b029so171029317b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990707; x=1696595507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08Bmlyyy2afgRFLgOmm2s4kS4kN9bybtesHt+WXogOI=;
        b=RN65EHvIuPxv1+qO/0nn8CrrQjwT4WaMHLZdfr9xBgl0RydOfyLDKDgqmr00ZtwUAY
         9IUm/gXmKyhMXm5XI+w8vaj4UzMqU7aq75gsq0OrWH8K0Tl7rh2jGYLP6N1eIOFnesf+
         3b8CmYqe7CE55sjtQsSCn/Ltj9yB9XIjOd7Rxv2n1kXZcPwFGMUOSpv1yOUd5cNwYjos
         jMVUSgo1d1xdYVkHvfRHp45XWsNUVxzMs3s8O9TvpY4ymEuKYtCBuQOq18ixWy/VRs84
         QIQw8SfHT+2Bkkvjrcorwjs0Lf4B3hM601n8PYO0Yzh2zUQY3z6uzwMEmRIPZ3QYlkDG
         qs3g==
X-Gm-Message-State: AOJu0Yy1xfwXXyLqpS0ldrtc+WwVyililu1Q9YcTmwOSjLFaLsmpC2ce
        vLEiE5qUgQqzMloqAz1Dk/tNf7PxSF71sw==
X-Google-Smtp-Source: AGHT+IE2KhXsxMa084HzjOFLmObmDggUdZ3+8JLGY4jinRuPUsM5bb0Xqkk4BKJQdmqnWGm/t9xqVA==
X-Received: by 2002:a81:5e0a:0:b0:59b:bed9:9a3a with SMTP id s10-20020a815e0a000000b0059bbed99a3amr3895877ywb.41.1695990707065;
        Fri, 29 Sep 2023 05:31:47 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id c188-20020a0df3c5000000b0059293c8d70csm5423860ywf.132.2023.09.29.05.31.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:31:46 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a229ac185aso18241067b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:31:46 -0700 (PDT)
X-Received: by 2002:a81:5246:0:b0:592:97c3:18d2 with SMTP id
 g67-20020a815246000000b0059297c318d2mr4290848ywb.15.1695990706223; Fri, 29
 Sep 2023 05:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230924094105.2361754-1-maz@kernel.org> <ZRXtYzIA5dK1iPVb@gmail.com>
In-Reply-To: <ZRXtYzIA5dK1iPVb@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Sep 2023 14:31:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7WuV6moiRWuChFzBr1n5pGxuEMeuoA1YWYw4v8QAN1w@mail.gmail.com>
Message-ID: <CAMuHMdU7WuV6moiRWuChFzBr1n5pGxuEMeuoA1YWYw4v8QAN1w@mail.gmail.com>
Subject: Re: [GIT PULL] irqchip fixes for 6.6, take #1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, Sep 28, 2023 at 11:17 PM Ingo Molnar <mingo@kernel.org> wrote:
> So the tags should be something like:
>
>   Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
>   Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>   Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>   Signed-off-by: Marc Zyngier <maz@kernel.org>
>   Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>   Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org
>
> Ie. we generally sort the tags not chronologically (or whatever the original idea
> was), but group them topically, sort the groups by importance, and only within
> the group is there chronological order.

The tags should represent the order of the hand-off chain:

https://elixir.bootlin.com/linux/v6.6-rc1/source/Documentation/process/submitting-patches.rst#L449

and chronological history:

https://elixir.bootlin.com/linux/v6.6-rc1/source/Documentation/process/submitting-patches.rst#L493

Although current b4 seems to move tags around sometimes...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

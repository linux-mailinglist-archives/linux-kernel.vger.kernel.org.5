Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03C7B8098
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbjJDNR2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjJDNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:17:24 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F6A1;
        Wed,  4 Oct 2023 06:17:16 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f6e6b7600so23836977b3.3;
        Wed, 04 Oct 2023 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425436; x=1697030236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGCiimfEoMn7BwF0dkBNPoxRRWXYUsk5xphqS0fx1Zs=;
        b=pmftTRs9yg13wYfqEi3xHf6r+HxRpGy4O5YVagFhg1i96J5qhh/6JcRtvn2LbxbIwN
         F+0P0hM0MTLXfIdhh+dLODJTc5FE0TO0NfhN9j+7ol1PsnoMOi++vK7DzkwnfGp8mXIJ
         RpJ4NKufDpKyncZnyBpRtyuEzoh3pxpD0gF46iFPRT5GeAtqbyscx9oXr5DcElRAanmI
         TiqXVohf/mYwKbzJc8TQOJhNjS1j3hPuD1xZhI3eX/GP+1MvKrZPQw/2hEai5QEiLyDg
         h+swYN2rYHjV+C2aC4wz9fZMzSSe8FR4JylJKsdP7jwe+EYI7XzqkoLVpfPNlENWb924
         tr7Q==
X-Gm-Message-State: AOJu0YwrVtryNR8U85OhsGlJvBW4kSghXUZL5xeOmrXb/eu/+0eNe+mJ
        yoXSQS+vhTqn4AfOaGP4BO+t3dI88w3y9Q==
X-Google-Smtp-Source: AGHT+IF1p/Zbf6Wq9uQaPabygz0Yf0ZM6sayx2JMhwEmXMGeuNjvphiSnLO+qJMk924f1uFnZcJpWA==
X-Received: by 2002:a0d:d482:0:b0:59b:5231:50d7 with SMTP id w124-20020a0dd482000000b0059b523150d7mr2442405ywd.10.1696425435724;
        Wed, 04 Oct 2023 06:17:15 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id y128-20020a0dd686000000b0057087e7691bsm1150942ywd.56.2023.10.04.06.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:17:15 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f7f46b326so24075247b3.0;
        Wed, 04 Oct 2023 06:17:15 -0700 (PDT)
X-Received: by 2002:a0d:e8c5:0:b0:56d:3b91:7e78 with SMTP id
 r188-20020a0de8c5000000b0056d3b917e78mr2377307ywe.20.1696425435071; Wed, 04
 Oct 2023 06:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-19-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-19-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:17:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQVtroKntVamANrWiheDYa6+=L8K53__1WUZg3bF8EFQ@mail.gmail.com>
Message-ID: <CAMuHMdWQVtroKntVamANrWiheDYa6+=L8K53__1WUZg3bF8EFQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] pinctrl: renesas: rzg2l: add support for
 different ds values on different groups
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S supports different drive strength values for different power sources
> and pin groups (A, B, C). On each group there could be up to 4 drive
> strength values per power source. Available power sources are 1v8, 2v5,
> 3v3. Drive strength values are fine tuned than what was previously
> available on the driver thus the necessity of having micro-amp support.
> As drive strength and power source values are linked together the
> hardware setup for these was moved at the end of
> rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
> values.
>
> The drive strength values are expected to be initialized though SoC
> specific hardware configuration data structure.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - s/strenght/strength, s/togheter/together in commit description
> - got rid of RZG2L_INVALID_IOLH_VAL macro and consider zero as invalid
>   value for entries in struct rzg2l_hwcfg::iolh_group[abc]_ua[] arrays
> - removed spinlock in rzg2l_[sg]et_power_source()
> - introduced caps_to_pwr_reg() and simplified the code in
>   rzg2l_[sg]et_power_source()
> - changed return type of rzg2l_iolh_ua_to_val() to int and return
>   -EINVAL on failure cases
> - s/rzg2l_ds_supported/rzg2l_ds_is_supported
> - inverted the logic in rzg2l_pinctrl_pinconf_set() when applying drive
>   strength and power source to hardware registers and thus simplified the
>   code
> - used devm_kcalloc() instead of devm_kzalloc()
> - adderessed the rest of the review comments

Thanks, will queue in renesas-pinctrl-for-v6.7, with Paul's comment
addresses.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

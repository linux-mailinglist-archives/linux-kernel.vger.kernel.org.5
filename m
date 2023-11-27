Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5849F7FA290
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjK0OYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 09:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjK0OX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:23:59 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F46198;
        Mon, 27 Nov 2023 06:22:03 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5cca68f6e01so42530557b3.2;
        Mon, 27 Nov 2023 06:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094922; x=1701699722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=834pVqsGyG/ThloFCq4Fg8uGigDw1US55aPZgUr69AE=;
        b=hZgxPAobZDD2wyA6PCv3abu3HYrdfeTdF3Y+Kjwkzx1BfAUIq0SXTU3FPSQoS5+G+s
         lPF8r9g3h07Rk9sret3Zs3/qhcPzZH8q0Swm2Ruves73yq0jxjWHiGBHmtzCXU4ySWS6
         hbBWIJAAKAqCAj66cq5Fs329tAxx9F1DCcdqg/qiHayf2LGenx5Yd2KG/H5oa2OXoJvK
         fWu9OdhBut4NGzU7RLwWQCNTFTzZHw1nY60O+xNn4NltRFP1rYZDjczI7+hlrL0sXv17
         9ao6uBHyxeeOFrFbRCl0oUudlihSIhgjlXcxuW5+CLC3Mmo9v4+R1YMLgsdjrrQ+i35w
         iNRQ==
X-Gm-Message-State: AOJu0YwT8soz50xGXB4jQ3HTJ0zUI8D9VpIWFvPZOHao3bFXqDbX3raY
        V5wdiTIyX+l5QfmeCwOjgy9DSnIk5Y8Fag==
X-Google-Smtp-Source: AGHT+IHIry33GnwZYxjABz1zje1OAyuJ5yzdqY1RHUsCssQtdGrmsmjetxCAOQFmRXv717eoprhxog==
X-Received: by 2002:a81:a507:0:b0:5cb:d645:8cdf with SMTP id u7-20020a81a507000000b005cbd6458cdfmr11688215ywg.48.1701094922153;
        Mon, 27 Nov 2023 06:22:02 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y66-20020a81a145000000b005b4501cb71csm3231244ywg.29.2023.11.27.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:22:01 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-daf26d84100so3819090276.3;
        Mon, 27 Nov 2023 06:22:01 -0800 (PST)
X-Received: by 2002:a25:6cc5:0:b0:d9a:6b1e:ef51 with SMTP id
 h188-20020a256cc5000000b00d9a6b1eef51mr10902367ybc.2.1701094921451; Mon, 27
 Nov 2023 06:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Nov 2023 15:21:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7cs_DCwkbD4FGy=OgxsfLe4poU0916dM1xUB62ahqqg@mail.gmail.com>
Message-ID: <CAMuHMdU7cs_DCwkbD4FGy=OgxsfLe4poU0916dM1xUB62ahqqg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:21 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Use only one and exactly one space around '=' in DTS example.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 6 +++---

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5327F6243
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345975AbjKWPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbjKWPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:02:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35545D50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:02:10 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b8382b8f5aso624506b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700751729; x=1701356529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEar30uGhaLDv42Tg2oK/HJ39S4ZlMcOxp8lB7y+TU4=;
        b=tjM/+7QHkQHxSS+7QWM/SyS2UD2UsZfYMW2+MTTG8vAPqHctw0kcurybYJLVN4rB8q
         Af2TK8hIJDtSgZPv6WQ6khWKlFTWqg5R59800A9cSGrG2nwd8RdAXKiC3pv2CEKIJyj1
         4CFDO+sCVpjM6os7WQeKUUVRX2JYQl+9k7c9REygCByUasup8JYd0MeUmOIzMobT7bBw
         kAQK+CRNdgArNAlM71DrFyF0ceKx/tBzrWA0v83NVDxIeL2ki2KLLeuRuZG8hdz8+OE8
         wrYafSgYDOw226nuVtzFnaT0Ywf7RX1p4tDLdUDey21JGzY2AeF+ufwDl7ct3yV/CLKE
         Tk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751729; x=1701356529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEar30uGhaLDv42Tg2oK/HJ39S4ZlMcOxp8lB7y+TU4=;
        b=J2x49aU8WfjaiSzYUfuRu36ndYsMSDn6xktr6eB1p8WgUDjmiUe0QtDhvWf3K2Wygm
         e/EuR/RqatLg609lgFISuqEutnsod+cmGA6oXABjxy/mybSd812J4h7k3kCBIm83De0h
         Lm6pVk0bYyptr/pBq0UqG46+jEMhsIo1AxkrWg3HcPa1R2a7jaWj1Kfe66l+4aVAbVTm
         JSOYojeF+tLi9Dr/rzm7/VxG8Zys4tr8bjGlTYVIhdnW1vWNrbcgNsqHKZwPgH2IOLd7
         p17RQoUH5e1CpDmUi2NvgnVaaRNGMkhlfTLAGq1Xi8KQNLeRVI2RF/cugY4RvzXjfEjF
         V45A==
X-Gm-Message-State: AOJu0Yy/sa83c95XJUfkG0ITCcs/+I9vk1ZbrLYyVikDsOS6d6wDI1xL
        7hNUBqePi7+fMDDlTnU6funmdRyx8NxYeiu+xbgGpA==
X-Google-Smtp-Source: AGHT+IEPs85TdkXFOx395LjHkoWLEotqTEDJgWg3E9vX18ND53JbjdHMu/2FDtEoR/uEbkEfShXDjs81ygSKZRO/XFs=
X-Received: by 2002:a05:6808:d48:b0:3b8:43b6:1e34 with SMTP id
 w8-20020a0568080d4800b003b843b61e34mr5319331oik.30.1700751729501; Thu, 23 Nov
 2023 07:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 16:01:58 +0100
Message-ID: <CACRpkdYr6+1hYnGUStTjG6BjEXXbtAAZMSkcOeuBZ3hF6Fn81w@mail.gmail.com>
Subject: Re: [PATCH 00/14] renesas: rzg3s: Add support for Ethernet
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, m.szyprowski@samsung.com,
        alexandre.torgue@foss.st.com, afd@ti.com, broonie@kernel.org,
        alexander.stein@ew.tq-group.com, eugen.hristev@collabora.com,
        sergei.shtylyov@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 8:00=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:

> Patches 5-8 are pinctrl specific.

I expect Geert to pick these once he's happy with them and merge them
into his tree for pull request to my pinctrl tree.

If you want some other merging approach then inform us!

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131475FED2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGXSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGXSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:09:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC1FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:09:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c84fd44593aso5043153276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690222185; x=1690826985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv32dzLI0S4Cbunmm3HM6sgTMma037t/aW6t7P4RPbY=;
        b=m9qM00AY4ZxOu6/glCrlngvO1uZkwJ9dILIjT/zcdXHELshmbaiO/Exh7UfIV/+5QP
         90akMVHwl+u6dBhx/FSJY9nWYBDKfK/ds1HbirPIzyZLOdxLyR3u3gQCReu/qn8q8NDm
         xdVKTL68bZe7H6YS6p+bsnklcP84kn3Vl3woxHQEskIU3TypCEapPd8kumLikO3n8Z4b
         FCqsnQjrRIK5ko9N4g3idYTH/HuyBydmio38Cula9dLsXEiUB3LKUvHmpQRP+nEQ1/Sl
         iOasgOTt7wzdNpngeg6F2WJ0bx46hKoZMwZ8qdiRFpJSznn5yobZdS3uIfECRVSRKGfi
         /y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690222185; x=1690826985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv32dzLI0S4Cbunmm3HM6sgTMma037t/aW6t7P4RPbY=;
        b=DBRhvvrshPmQ5nlLgHKauzpBu+/rKGD3gyfQT1KYC2bYgAl65RQYMTYkIuQpekckGR
         Jt58VEMTVjNh9Udpqj6NF+XpGo47TnFx0oOEX65KApsG1PKotInN9wju6JY8gXYaVHl/
         UveRqPveGR6oj2K8Lqy5fN8Nu4g5xJB3oU0mb2jFCWFpzBgvguhUM4tlOnN2wtn+OATx
         UxyVKIFAzMtB6FIadzRPSf1ad3+mN/f+0aBHDPQSt/XJHJifTZNhGnK6dOaooD3KTTq4
         209w2gL6Ois/vQZP7YjCLk5xlrsCofYFPLz391k6sklhaXPn0LHAkKuYrtovP6L94k8j
         Zd+A==
X-Gm-Message-State: ABy/qLa8n/4kG6/P31coZYPUYAzFAV4sGQncxAAUxmVXHbTO3H0FCQO0
        jOSUs/ic3S5Va3p27Orek0y69YAlLkaQysn6s8o1Mg==
X-Google-Smtp-Source: APBJJlFsPXLIqdE4FI2fEH9PF5W6wX0kB9Iu5IZ67bqIZrFvevztigHRLGRRgVz6eTQN6Okx3EPcfSB7Z3fPf63pUlo=
X-Received: by 2002:a25:a1ca:0:b0:cac:2767:2b8e with SMTP id
 a68-20020a25a1ca000000b00cac27672b8emr8296660ybi.60.1690222185691; Mon, 24
 Jul 2023 11:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org> <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Jul 2023 20:09:34 +0200
Message-ID: <CACRpkdbK7gU36nVOm0J+HbLk5JRKki+30=UaJ6hZjF1DiB4bBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 9:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
> driver is similar to SM8250 LPASS pin controller, with difference in one
> new pin (gpio14) belonging to swr_tx_data.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This sure looks good to me.

Krzystof, can you collect a branch with pin control changes for
Qualcomm chips that I can pull? If it's OK with Bjorn that is.

Yours,
Linus Walleij

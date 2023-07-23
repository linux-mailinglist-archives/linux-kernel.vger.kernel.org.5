Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B475E481
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGWTZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGWTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:25:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D8E5E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:25:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ccc462deca6so4172516276.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690140301; x=1690745101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl6HR544A3gxyqOWex4QhTxlPIhZO2gf7gaKJSLJd6o=;
        b=BljtUEH2/rh7Z9S+j8h8FwWtFrayDWC6LJ3H71w64lpsjdJx4R+kedh4bDnQKF/8uI
         e4+ljdATczEp82AZJb7MsvjUrB1pcO4LqhGMIIbEgfJ37pg344CauEMK3PN2Df3hIb2E
         RuZIJr4ctT9qNOx0fpulSl/LEF4cnzw45inDGISq0dUc649hHBDKqqlAPyYKtwuPb5Cu
         qlhU/u3RV1kum7qZnMFU9X3F67WamOjP8Ocs37+/5xH022YXCSqSlNXq+4HAOr8XdZmX
         l/KvTVgL3r4BIA6TqwaAxRT0cFo/9aFecBj5Nmxt7Lzcs8xUkluR4QQ7RZ58BjK91Z8S
         2ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690140301; x=1690745101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl6HR544A3gxyqOWex4QhTxlPIhZO2gf7gaKJSLJd6o=;
        b=XKFC2okRcw8d4lSikKwddxym3bx8FoHnuKdpLaTXRRfjULhrE1VUO+ZZ5Tt6OF4c3N
         8Nix6BYZmJPTqt9FAJeE52fWuDkCfLm82F+Y43FikeNlV9mkdQfJUK6Lb0GRab05jHmz
         GmB4htlX4EZP4ELMY6JdwVGYiN5t1I6cjZ5NL+ZfEiNIXvewfQ2v+3eGIirdTxQz1yLH
         bhE+mORdxoaMhQqmr5eWSTqed8EW31vWxyR7EAP5pOPwv0Owl2czGVSSwWN9Qa+c94XW
         7ImT+LTlHXz6j+DtGuQCgHb6BaFqeSow70js59+h89oQMUjhEIN2eV8jdzhZO+aXJZLw
         Djqg==
X-Gm-Message-State: ABy/qLY0NIXntymBr1/hfhegMf5miLRgbI5T9N0mMi9jv/3dKI++0bhU
        7NtFGBROvZnoazNL0CdmryKBOfXIwlzCroGRHLI+kA==
X-Google-Smtp-Source: APBJJlGDlegKPBYoGwW5osdb4ar+lLvJb0T8w52ymwKt8ifdKBRQzuQ8F+h4GTuQZehdTh+oc/WP6tGbLuAfrobDpEk=
X-Received: by 2002:a05:6902:1351:b0:d07:f1cc:c152 with SMTP id
 g17-20020a056902135100b00d07f1ccc152mr5236326ybu.36.1690140301620; Sun, 23
 Jul 2023 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230714122441.3098337-1-huqiang.qin@amlogic.com> <20230714122441.3098337-3-huqiang.qin@amlogic.com>
In-Reply-To: <20230714122441.3098337-3-huqiang.qin@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jul 2023 21:24:49 +0200
Message-ID: <CACRpkda8yg2b=Li3CdLTnVA_9QnGDHjY2rva=NjVHnyvKPJMTA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] pinctrl: Add driver support for Amlogic C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 14, 2023 at 2:25=E2=80=AFPM Huqiang Qin <huqiang.qin@amlogic.co=
m> wrote:

> Add a new pinctrl driver for Amlogic C3 SoCs which share
> the same register layout as the previous Amloigc S4.
>
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Patch applied, I also fixed up the commit message,
no need to resend.

Yours,
Linus Walleij

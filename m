Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0224475575C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGPVUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:20:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F86132
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:20:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57a551ce7e9so38575207b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689542418; x=1692134418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5jVNQL7Cqqr60okI8mc7o8ZzfhGkfsuMA8PNwkU7+4=;
        b=nZrzudf6xWNgDh9pI1qUJneWfZZ979ATLS6xoZ5hymfxndprmeWruOujesfVNEI09I
         imgYXL5vPi+KQbDW/5KpR+WqF2IbuLxDAoGRwDZOkCSomygdREedz7TIyvPhIW4T8HEQ
         Kt/oCml68TYo1IfQTRpYtbqyCrwWR/WX8oNl9zPPtMAWFuOH1jAK8a6w+ij5laChENWX
         dPuuWPHSgDQ2UUK9RqRGemmyAgLUjVEBUDoVX+9MkgSZm7F3SmnWtCCstm8nltqTK+NK
         gyVl/1WGHoIAqIanzO4RdVju//vpXy+qQfT65rYde56kb5xHqBtOWIiaWduXVrYpxINK
         xjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542418; x=1692134418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5jVNQL7Cqqr60okI8mc7o8ZzfhGkfsuMA8PNwkU7+4=;
        b=a0H6xQOfyI9kpug701DTijv3AQVLj7Adwru25J2Wr/Wv5mLMknJwzQr4X2E5weiBv2
         SDiROD0DjnG3dCYhLerwmxE8yeIRXrm44xAZPN8Plstw/wS4PgMCtM0eGHQRlrLBHV2j
         troPjiKYcM37omTPAVEAo8BWQW4XPYovnt1gAIZ21V7D0KD2YEhz7phz+H2jYDNn7A1l
         qG4zkg3IfzzO69VGM8Dn/jjUs0Sau+oxjQ795mMJn5SfyeSbisUlyfyUDD9SV7dgpfnY
         A+6+EWcQROp+eiwah0ZSgWSznu92SVPdCo9VWy/CHa40YgcinmprHNxzSu5xnoBjBkV5
         zmWQ==
X-Gm-Message-State: ABy/qLaGf9gPBvjVpSA96E6JfXWg0LrNBHYPbI16Djz9b6eUvb2X5r8U
        wh1R8AYqRf6/MQtew847XpRY14z4OZWbiBwjNLZ0qg==
X-Google-Smtp-Source: APBJJlHFulXWKieW8R5pU5+4sBV9kVYwKWI7RxXFv0PMRLSfeuSHf71kiTm/P4n/g1hxXDT2l3GQ0t6WmONXnWG1MKc=
X-Received: by 2002:a0d:cb4a:0:b0:56d:4b45:f9e1 with SMTP id
 n71-20020a0dcb4a000000b0056d4b45f9e1mr10803683ywd.3.1689542418359; Sun, 16
 Jul 2023 14:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230714122441.3098337-1-huqiang.qin@amlogic.com> <20230714122441.3098337-3-huqiang.qin@amlogic.com>
In-Reply-To: <20230714122441.3098337-3-huqiang.qin@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:20:07 +0200
Message-ID: <CACRpkdbbUga0biH=1tkCgRzUqNiDGdVf2woda5X2s43ct-na7Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huqiang,

thanks for your patch!

On Fri, Jul 14, 2023 at 2:25=E2=80=AFPM Huqiang Qin <huqiang.qin@amlogic.co=
m> wrote:

> Add a new pinctrl driver for Amlogic C3 SoCs which share
> the same register layout as the previous Amloigc S4.

How is the spelling of amlogic there in the end.

> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>
> V1 -> V2:
>   Added a comma to the last item of the array and a period to
>   the commit message.

Andy had more comments about the header inclusion. Please
include all used headers directly as requested, I think it's a good
idea and avoids confusing compile problems.

Yours,
Linus Walleij

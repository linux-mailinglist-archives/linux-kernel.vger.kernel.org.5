Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A894755757
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGPVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGPVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:15:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0010C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:15:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579de633419so33773167b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689542112; x=1692134112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syZ7bfmbG9hTUEEMD0N7OeMkyMv6b2GCywnkgDB26og=;
        b=sXL7NgE5tnn9Y0eWY08jOgmX0CpYug/RcZu2tI2IAIadZU2t2LxPm1pEZTl+3xKGqZ
         wvbD9aShgKnXj/nh+tY1sA1AAPSX/6SWkSy0YZHjbeW+aWwu2ZE42JTXzypBf3j8zF80
         VVVDN3tjOw6dl37NUp0rhIUEMihg/3YTqYlO1cGMzHZbRkbxKp7gERkD2P4cjwobQxz9
         t22D4KTMH60tH5sRn2mMjtNU+bRbdR8lnU2Q1PkvhTJeiiv0veV1TbEOvNgMY2CtqpiI
         dgWtNj0tKntU51hoJ+7/NSxNE/YTIsHnFP5ugTOg8M4yUkZaqRDyDcQDUzWfR2Sg2cJ6
         QxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542112; x=1692134112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syZ7bfmbG9hTUEEMD0N7OeMkyMv6b2GCywnkgDB26og=;
        b=kLHW7rE1Wm2H3eGUMwzpm5JgjKjQEe72ZVxwZsDcRQJaW5qTEU8OYgUCre7gh3o86x
         JLhQNefbgXKmw5SMmUptH2MnnhqAGRRMw/xIv4B20ttXMSgZ1LCbxnq5WYQG1J4rBfoS
         Usof8Cv0UwRMp1Hmwjj7QsiTnpxsaGOnY2JEWDaHKa9mXd3tXZGbDVJ9GucIy0lG5g8f
         JZjsq0UsfQw5h+G/ww1srG/C5+dUecOhDgThqgZ5x93FMrDIR3XkLPhT/j7+vWKDGHdL
         t8Q/BUN7JtE3qJDjjMIUK46Opj3Z6WC1aZf50z73Pv9ajklwlbXRnqzDK9gms/YnHGSW
         q7Pg==
X-Gm-Message-State: ABy/qLaS4mvmY+FBHKmKijqCzZgCVj8QqNXJZ3RI7+1fO2GBQ/a35fSS
        r72UxGvMR9COPCOG+lZmYxDoAIDlQFv/5jCJOHhIyA==
X-Google-Smtp-Source: APBJJlGyZnAGewtBuUF/Aql3jrigoDHvIMbIEpnRxYYShoyJ5AUs0mHl0XSztp5BEx545McQJfp3pSS4aLE/sSfxMQg=
X-Received: by 2002:a81:480e:0:b0:573:9747:9a0d with SMTP id
 v14-20020a81480e000000b0057397479a0dmr8625958ywa.41.1689542112298; Sun, 16
 Jul 2023 14:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
In-Reply-To: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:15:00 +0200
Message-ID: <CACRpkdY6LaLCh+n4rpD1Jewk+-GC6zPo-TQ75bg8qcym9wxTMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 add missing properties
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Fri, Jul 7, 2023 at 10:20=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

> The amlogic DT uses gpio-line-names and gpio-hog, add those
> to the yaml converted pinctrl bindings.
>
> This will fix the following dtschema check errors:
> arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb: pinctrl@40: bank@4=
0: Unevaluated properties are not allowed ('gpio-line-names', 'usb-hub-hog'=
 were unexpected)
> arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: pinctrl@4b0: bank@4=
b0: Unevaluated properties are not allowed ('gpio-line-names' was unexpecte=
d)

Patches applied, thanks for attention to detail!

Yours,
Linus Walleij

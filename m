Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8D7EB082
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjKNNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjKNNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:05:15 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFA1A3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:05:11 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso5653635276.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699967110; x=1700571910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3kLet+ZFc4FiXhXyJTUcUEX1JsMDtWsRFc0PYkqxJM=;
        b=nMk4bjzWl2OH2sgI2kginq+JqGE7cwEcr+JGDejTGiX2niImmLs4RpluHd3H9DmyOX
         39NxMktLxD0KR/1jO0DVPvee/GYRKvdT0NGDyOOY9mugEYri1z7tPGOuN1UaDnDslMPM
         07KVGoolts85BnWYiBEeoDTKbfNmDvu5SMcH8fkerB/VCr7HRL3nOmT0dMFAw6psXo7L
         PQ/yETAMDp42UEMSaZHW8fDmMccfGZ99jpCF2zkYMbjDRmxmbKkkPuIGDPaJjXwpkPJN
         6YRQJ9NnpBeWQwKLA6iHGmEX2qiNv1VB3X4ejZsla3zyizgE0zAnjBWzAhmBMv96hrt4
         Sceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967110; x=1700571910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3kLet+ZFc4FiXhXyJTUcUEX1JsMDtWsRFc0PYkqxJM=;
        b=qCPtrV/II7iyf9wCekQvxlAiMa0isGuhd/AWCvlQMP60XYYCur02eTlBSOODpukmDU
         OHsN9iMPXFlOouu/s7QBVWdpGpJZMicFhqayh+TCn8dAkKeESV5u4VenpStsYOYOyRZU
         XOm1RnXCEWsvYSgkf7wkDXueALHWLHA4QvbrRXRW7+KYRqxvtkvd0MbI8bnGZ/z+ztlp
         B0sBMu2nhvpwPGhvcYWIdOWrg0nR0LtVg07Y0/nUKqd+hQVX/LJNDo5x/6/mU4G8FjLa
         t2dGBmcSmxwivGeSYPOGrQRsBexchQpjkwvRQMLfzVQYevBnxkpenXd3Uok2tblTj34T
         P7OA==
X-Gm-Message-State: AOJu0YzmXp9jbRT84VFy07jMOMIINzVMTIPf9EpTVjEH4eNqNqoUTO+u
        uckAXbD/Uf8W6J5xmjuje5qMM/HAhazSdiOnzb/mNA==
X-Google-Smtp-Source: AGHT+IHU/EMXoR/AsvwDR5tVM/hTfhag7Py4pB8zx2h4lfdu8R1hVWGA8wCYGXEvgGG4RCO6d/pEhnbc29+P4adFbGc=
X-Received: by 2002:a25:35d6:0:b0:daf:66f9:cfab with SMTP id
 c205-20020a2535d6000000b00daf66f9cfabmr8292993yba.9.1699967110411; Tue, 14
 Nov 2023 05:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org> <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:04:59 +0100
Message-ID: <CACRpkdaSPTjjPA=TS-WbOb3E=TabtP6MFEx6Q+Dar-Mh=EtknQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] dt-bindings: pinctrl: samsung: add specific
 compatibles for existing SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 11:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This is more formally correct indeed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

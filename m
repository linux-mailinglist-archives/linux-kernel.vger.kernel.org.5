Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073E803020
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjLDKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjLDKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:24:14 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F21A1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:24:04 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3687a6574so40940507b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701685444; x=1702290244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9AgvcjFrIEfs+Le/LoTsEi6ZnDb0Ubd72oSh9eoTTQ=;
        b=LZdMi2pLwciZiSqQNC10SPvm54MHfbvDkdtl7nYufVYpkwTvhjhJox31kcg1iR8wfu
         tl6dchohY2CPdeRp0kBjhAwiMRZKqapT/BfWJ4vvzcmchqT7/VeWrYAOhegLgwgevIQg
         6B5pf8NqMeJlskIf2iL0q44XwgwVeqOCDhEAkpoLu6Yk+fnlx0MSV/OjXuiD4WTuuj4w
         kYQDp4qTTCfHoQQNWJTegcdDPGV37TLHJF604FBT9SiMoB4zxOyA/S5ND1KRbLyLfbWo
         COBmjdfRv7bahwJ7cEGMys0DiHN+8BfgnGLzLo6CMPVCI205OEicWA0R99JtwhTL2y85
         CkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685444; x=1702290244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9AgvcjFrIEfs+Le/LoTsEi6ZnDb0Ubd72oSh9eoTTQ=;
        b=RYzouyXMvxbCZB2TUTBnTJmT3BRssqT/3mW/LyRIbsAwY7UpS2o6UR9sghfl0KcziM
         1XgEsGAAJcqODCI0kVGSM0Pd47QUcZ8RV6Q1OpbTTBrHzd86M/E4GGtJRdO8La0oM2Kv
         YsmPHRURNkwfTDAb0MiX/oOd1wWPh90CJ1sKvVXR3ykQi8n87g+1JlBgDDHGdf0zX1xf
         1RWM4xiqi0xurKExxYbw9k+dPxeLS4VMv7FKVFWDBQuxGdUo6KMq7ldDat6sLUkv1SnI
         AjkNEvpiiOId6i34FP9+pvLu3A0fWScd19/TUw7ZxMJAMm/Not9tBHP5/hyISfEJ0Rq5
         +xrg==
X-Gm-Message-State: AOJu0YyD+PF9gi2rwCIi5M6b3ES5KZ4o2XLOk8NiTijntXZaIsUCB+sh
        8kbBEEWQxLvib5+RT/SjTwqaz+/M56/887Zfis+b0w==
X-Google-Smtp-Source: AGHT+IHHpmfGUb53KffFfRrngptg7rxDHFOScbgTQzl/r+YjOcVG4eW8jSkXI3Wt5YUMb5861m+jahvOS7+OrPRrQu8=
X-Received: by 2002:a81:a045:0:b0:5d6:c5e6:fa4d with SMTP id
 x66-20020a81a045000000b005d6c5e6fa4dmr2674125ywg.31.1701685443855; Mon, 04
 Dec 2023 02:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20231202222934.137191-1-david@ixit.cz> <20231202222934.137191-4-david@ixit.cz>
In-Reply-To: <20231202222934.137191-4-david@ixit.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:23:52 +0100
Message-ID: <CACRpkdYbOzqWqoGtGWDiaOE9-7wBW6mV6m9NtO4PydB-kQjBMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] ARM: dts: tegra30-ouya: make dts use gpio-fan
 matrix instead of array
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Thierry Reding <treding@nvidia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 11:30=E2=80=AFPM David Heidelberg <david@ixit.cz> wr=
ote:

> No functional changes.
>
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

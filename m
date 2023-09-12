Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7879D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjILNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjILNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:45:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEDF10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:45:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7b91422da8so4891252276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694526345; x=1695131145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edAT/GH43omVL1UuMQMjzc2LFcLi9s8ggYJhioq2FPs=;
        b=Ly8F6rqsZ2a/ErNhg3NQMZWYaGD0Agak2T0+J4VzKZwHG9M7brlS/uh5uGkqte86cg
         +y68uvKyW8L5/2tQdhoTtvy5iyUiTtPCOopfthH+7loeArwNWHC4fVVC/W+dNqdr7FUP
         fc71h42ECOy1+tcEexmvOZqWEq0wUFWMFkfKu9cJwf5y3GOBtkNo8KZSQ8TQDU3C2Bsy
         fHiQ3NyhjT/DL3SWmy7QngMllHo3og06F0phz7FTYzv2D6qb0LieA44eJnAn0oRZ0yJU
         rYfmGDNZcRSoNyhvG8SyLUJqpB59Hdds30Rmx5gkiJXKslMQX5fxMPLMD+ufQqJ9BLBW
         7TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526345; x=1695131145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edAT/GH43omVL1UuMQMjzc2LFcLi9s8ggYJhioq2FPs=;
        b=dTNOav/5h7s809RrRl7qVcWeBsk3v+c3ABT2AqOksmipm3r11rasanyKBv4FKknWwR
         mOo5DVrvv/dIjR6FDU/kZMnjZgALvUVSOb0WO8b/WwmE0L+RnkG1GXfVEARjtX6jKtEI
         gisKyH/yikAN33e3/4ljtdrBMGyMby8hc2afnGYz3QF8X2UCbsokq+QqxJ85c0psXQQO
         lTkNdTRDBnchy0sgb+VnwAM0KDrwDzdyPPCqpHHy9RPvEQbmlVV/6o5Rq2TBHF85W3zx
         vV2ywGZIHK02Y8amejkiU8QVTqkwD9l8dymIQ45oHKWf5qCxh9RMjNqsdGoOSHRYSwvd
         emkg==
X-Gm-Message-State: AOJu0YyHIWfy40VJC890KmXvG3VtBa14U7/eE0IIjB4n3CUI0NFxuwi5
        ZlH/azh4VeCnn/We74sjiJMm/LA0vZyV3VKf+bl7klwd1nYR1BWS
X-Google-Smtp-Source: AGHT+IGJI2UveXs72E5STp7ztC3GYt6jLOW7Z8QEofakoyL0YotL8uh8fujG1uiQtOK+mJyjU2+03A8pvZyjiJB/Mns=
X-Received: by 2002:a25:ce03:0:b0:d09:f934:f2fe with SMTP id
 x3-20020a25ce03000000b00d09f934f2femr10648800ybe.18.1694526345012; Tue, 12
 Sep 2023 06:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122850.164150-1-michael@walle.cc>
In-Reply-To: <20230912122850.164150-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 15:45:33 +0200
Message-ID: <CACRpkdYh1PN4mSmLQ-3SynhbjRs1Y_H=vaJHqv1ptf2UL_SQYg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: gpio-regmap: make myself a maintainer of it
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 2:29=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:

> When I've upstreamed the gpio-regmap driver, I didn't have that much
> experience with kernel maintenance, so I've just added myself as a
> reviewer. I've gained quite some experience, so I'd like to step up
> as a maintainer for it.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

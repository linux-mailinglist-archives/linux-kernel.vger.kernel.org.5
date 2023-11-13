Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA57E9E42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjKMOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKMOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:11:58 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB04D63
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:11:55 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso4374641276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699884714; x=1700489514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJr1OXkuxnT03SCv+djqBRWs+VoPNnRqt/gpqMoKcS4=;
        b=dPhazqou+ayKP4zGXmB+bzWYXpFj2na6UysngAOocfO76BBDDfHgFB+8GVn/2Lry4k
         l0qmn+GxKZyYwtqjvecGw+Ji6JZ0bXN3uxrtoznmnRbVVcrSHHxfOaJ5mQa7dIvEX0KC
         NDnFpoDTBJQdKiXKOKDJsAs1zzTN0pTT5XY8Cz3KT/faS2rTKgKlDUH61ntJFT8XJv8n
         BPsZETaP6WEwiYNoVtOkqT8bvsuAJhbD/yAuKf47ZEQrL04tn1wiI7mtyTpVJ+Rf8du/
         0HcLl2ZGTe48CmWBa/e7lFjIipbFxLT1c99vqSeo8Q+rA/oNBwelIwpkeURr68QYfBKa
         Hq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884714; x=1700489514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJr1OXkuxnT03SCv+djqBRWs+VoPNnRqt/gpqMoKcS4=;
        b=wYeTvrV8n71bQ1ogPZtdnWFDzxYFpz1JoCp+Zh+osM+Od7UNkfqyljl+KHHIzdoPcN
         u5BP7LsYHRMaP0bsgjy4MpR21rtsfgMfbIYOO9KzQuKafefhBkkmiklV0ICnGGYNj56p
         mogmShLecpznMJsq8wX5KCIU+gj75h6BXPkEAgNS51k1RcdbACkjxe7fgpCt8oa/q+P+
         a3lriC0kGCRynVz9DgHjzCmeER6ARgEhgMi4hMPqK4WUdKDv2G9z4jLBwJkOQ0b/TMbP
         /Mp/Fp7vfdvJPeqcAXbGFvhUCdzMjKMNmK+YHRKRMMX2PsZ0E1iGHgVpu1PvMl1pJywM
         CVQA==
X-Gm-Message-State: AOJu0Yw8Sl3PXoOIECFPTpLc1296VIdFKrnYqFOaxf+xKdBLnGt0b0rp
        NsI0PYPf0Qdd73J+zlCkzF9LMxuY6hkz7OMRH6DbTQ==
X-Google-Smtp-Source: AGHT+IHOnTJi2b1Q0iw6JudAumqU6ptqzEHKAsTPQMqY6ERd/tzWqcc2NMGHeiZAy1A323D3e8TLe3gaGaKgn7ddmRc=
X-Received: by 2002:a25:d196:0:b0:d9a:4bc3:226e with SMTP id
 i144-20020a25d196000000b00d9a4bc3226emr5511950ybg.37.1699884713789; Mon, 13
 Nov 2023 06:11:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98@epcas2p2.samsung.com>
 <20231031094852.118677-1-jaewon02.kim@samsung.com>
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 15:11:42 +0100
Message-ID: <CACRpkdZRMJgWkLwKstpN_9=VGutbE1wBv+X_a15RJ=7ddNtbHw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce ExynosAutov920 SoC and SADK board
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
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

Hi Jaewon,

thanks for your patches!

On Tue, Oct 31, 2023 at 10:50=E2=80=AFAM Jaewon Kim <jaewon02.kim@samsung.c=
om> wrote:

>   dt-bindings: pinctrl: samsung: add exynosautov920 pinctrl binding
>   pinctrl: samsung: add exynosautv920 pinctrl

It is best if I can apply these two separately once Krzysztof is happy
with them. I hope that would work? I don't see any specific dependencies.

Yours,
Linus Walleij

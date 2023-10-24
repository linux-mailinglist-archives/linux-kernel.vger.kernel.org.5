Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721F7D4BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjJXJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjJXJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:24:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B010C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:24:49 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da043b5b6c9so317347276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139488; x=1698744288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvtw3R4g4yrWaCPe3OnX3OGqAz4Ysoana75anOWAYR4=;
        b=dL1VnuvzBNr7p2VtGrgJ2YMxxalsZwAOP2rGfZWZbhmajLFcbZY3Lm89A6ef04MOw9
         2DhAdz4udDbvACievBwRk+rVJcccWi1Seh+ZM0dUMJBEdIjnLkk/0nJaqN8Rrs+6XB8J
         3xWsSTkXGOjD9o9mwZYwwHgASiNklO1XRN9d7WqOKVoVUFjUOs3OHfzfIDSlqJfMNYEo
         DbwX3KGlDXATrMnn7ckXB2tBUjcEYneEiTgsbt24HWfCN/GMuf0CYk3t2dGt5cX9ya2q
         5LY89XDHaIsj+x5tTJd0/WWzqz6kmOySBK7p1JC3kA6UCcGVCOsMi95AOwAGcoAmPQjR
         8/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139488; x=1698744288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvtw3R4g4yrWaCPe3OnX3OGqAz4Ysoana75anOWAYR4=;
        b=nqSmn4BWyL+E5q7vIdsST6JwNk+Oj2KowtvkchKSZg0Ggv4O7INX201UnAZQEkMKbW
         AN6TMnL4xz9/HP5x4gii9LOhXcm9Nb80qtNFzLfVZ8IUq3dIA928bOR1SG1ikKpFnar1
         OsLMgRV5g/KHS7kHKSjkR4m+KWb15dfLWfm9PJ4lsW9elA3PIM58xQxyWqNYcvGhe6Zg
         DfmV79g7S+CwRxyHq6U+s+1r4xjv2Pw7ASFixxb3tNvA0Qr0dFyVA7vMwao/2qsLr+JC
         RNiUSsuUrTjRxF8FLn/hIbRP4t8kQHmMu5hDV4bnAFk0iiPIje0HGOmsKDVZQEtShYH7
         z7cQ==
X-Gm-Message-State: AOJu0YyrA7NZby8qYut4r1gMI3ufklL0GxIoHkvXzuAIMptBl0elHHQx
        R4/3OOKn52ACysrXxw6dW3g2IMmlZ5hlMja+OV5inw==
X-Google-Smtp-Source: AGHT+IEjjXEh1q5UaxdtvCQj9zoNGBvaRwRDI5Q+oryObRZl50AcnXsTDbsRJJ5cG/pHer6xoQElF+sLHgofyO9u4cg=
X-Received: by 2002:a25:cf14:0:b0:d9b:f161:5fce with SMTP id
 f20-20020a25cf14000000b00d9bf1615fcemr11908547ybg.63.1698139488699; Tue, 24
 Oct 2023 02:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231024090631.3359592-1-jim.t90615@gmail.com> <20231024090631.3359592-2-jim.t90615@gmail.com>
In-Reply-To: <20231024090631.3359592-2-jim.t90615@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 11:24:36 +0200
Message-ID: <CACRpkdZ_Xkw-rRL4YPQxP8Wp00SL=k5W=S1X4bdEpfmMedeXdg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: gpio: add NPCM sgpio driver bindings
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:07=E2=80=AFAM Jim Liu <jim.t90615@gmail.com> wro=
te:


> Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver
>
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>

This looks fair to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

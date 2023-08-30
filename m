Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33BE78E19E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbjH3Vtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjH3Vtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:49:32 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980E12F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:48:59 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5739965a482so82664eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693432069; x=1694036869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwTlMHnpoQxXKu7GQhdvB2OBoERcC10phErlaDthfic=;
        b=mTSomWRdhCOOC61RFwLdwG8BCWHPDyEw0utcIvc4IVOPI6iZwIUNK/buPV1JZKGC12
         h+sJsZ+Q2nT4dcOVvyT/GMHdkMi7F25BonMJxCmcmWAAmeiGfx0Ma2lxai7OoncjRwzy
         daGPt1XHH8x0aPiaSVWPY16FAxyKwF41JQ63r9i+Hox07+20GjPvOMWmPogXkcj4se8S
         6lzQgq1im+ibXTZbDJU5O9G6l51Cr342/1i2SltuA9lHq21+ZJHvxDZvbp/qbAGKvjr4
         ALeeqtOncFLel0kPL3i1X6Q2TN3TpBTG3oQZgXC0eIOirHQWhpSqLwDKivhGNDTGeQGY
         mSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432069; x=1694036869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwTlMHnpoQxXKu7GQhdvB2OBoERcC10phErlaDthfic=;
        b=fjXUhgx404HqeV5ovqIk20afPDPgdeXltRupy0j3V5zgCnm8sb5okeUrVjsvlk1BoW
         A3MxkK4w4MoraGRy49Hwt9hraRv3hmCfATx7ICJ4O34O+t7+TatYCPu0dTSVlsHM7bYJ
         Gt8AvgBH5OTpZ6IbdJHFxvRRlfyXgVmIdctx1zrbiEN7n7tiiyw+hjqvPsUH2pgehsky
         ChM+AMLqH8S59lOlhJ/rvFMUbltcuO5o8VNSUm4fMBkD5sCvz8jwmL5epALoewVTJl3A
         x2pIvZFPm4JztllRT7RzeWXCdNQHXWmC6QuqmHU72JhgFwCKkAFJ5SafW2FN3sOColk1
         kckA==
X-Gm-Message-State: AOJu0YwaKvTJ9O+VMW5qvDfKIhAoo276tKSJQ+cotmWWSOTlXnN8ZuaO
        ew1mnJavgBNDhiH1vc0wjt7trxp9wipY1VbNayTKKxvPS638HjXw
X-Google-Smtp-Source: AGHT+IHHRbCO2NG6XFPILX+bMbHZwdLHJ4lj0szLA7z4dTcEOaX92f5uiw13Dj9i8r6tPm5FBwHFfI2oixbUXKm8XGc=
X-Received: by 2002:a25:d20d:0:b0:d07:b677:3349 with SMTP id
 j13-20020a25d20d000000b00d07b6773349mr727858ybg.25.1693430970191; Wed, 30 Aug
 2023 14:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
In-Reply-To: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Aug 2023 23:29:18 +0200
Message-ID: <CACRpkdY=ayaZpxSzHgutk8sPkcJeAjMh7yJcTP4AnUSQSaGw3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: stericsson,db8500-prcmu: Spelling
 s/Cortex A-/Cortex-A/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 30, 2023 at 4:53=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Fix a misspelling of "Cortex-A9".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

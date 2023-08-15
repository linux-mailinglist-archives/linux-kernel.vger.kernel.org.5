Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FEE77D473
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjHOUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbjHOUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:41:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C141FE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:41:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58c4e337357so19278917b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692132017; x=1692736817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXsmOTyr+79I8rXbzQv5wGp2o4iR7rx1QmUr+QsA0M4=;
        b=RO7V+ifyzjAS2mgXiLIZGA6FkNIgZi52PpyvpCcrTF9v9g3bYe3zG3CtQNNgXXppar
         SofqGjSHWpHFHFkBXcPRX3cyEJArW7n15as2nQQ4xpxXqd5NNWxU0iSMChpYzUpDre2A
         DWTEG7oMotVcPGljlhcikNT442/B27cMLO3H42/gvMJwRcmVvVN0b07PrcdYAMJ4FGET
         WWm/zE780O1GMVTgXE/bpIm0jylLSyts02rf1HQQCZQYOrH2JrV/QnG/Zeo6gQaSvN/J
         R/mH68onRwcmlIuHloy710/uYb6nNlDQN+qbupGOQKXRsNwiLrYYRwFNpr/pE1LzdWnL
         Tubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132017; x=1692736817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXsmOTyr+79I8rXbzQv5wGp2o4iR7rx1QmUr+QsA0M4=;
        b=fJoRYajJCv7JyibyT+3EeAUG/4ruN7JfmK7LsVDkZd7WuMXn1pWke4h5NTvGSg8jhE
         GCiFXeAM7ThnJijJMO5jmMpsQoFCpmvlescw/JfkCmwRqGUQhuWvuN692XkgcaEs1ZIg
         zE4buMuLnllCfXzyN2aJ6p4Ynfw5GjANGRLNDq53mWmxXV4Yi76ewi4fGHOiJuTVo20x
         SHjhu7fygMrIkFM/tQdfc0kOK5UTBf6/C7DVpvWU5lD2//U/L/ig54oXZcTcy/mcsxZK
         /HEMo0zBlSojsNAo027kG2ms7XEGpDgx/z3+N7m3FJ/Nrc1n0FcqDxnBe4ADWT7Y4rsT
         yeyg==
X-Gm-Message-State: AOJu0YwebZI6SJ1pW2JNKbuqgS+d7ZfnQGIGKvXuh8kFwFa5oG9hITpG
        6MBXfU2UJ7U3+US5J5ecOgDMHOwjyrw6dapalJCQeQ4D0wpqWf21
X-Google-Smtp-Source: AGHT+IFJG2IoPGrXynrvFvKDABXX0HAvu71gziRbOFLYALcXE9Ny9LHAxXrTkqnGGvOfS/0102FgZjzaWquD4DLGTjg=
X-Received: by 2002:a25:f85:0:b0:d4a:e40f:d446 with SMTP id
 127-20020a250f85000000b00d4ae40fd446mr12526107ybp.36.1692132017520; Tue, 15
 Aug 2023 13:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me> <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
 <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
 <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org> <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
In-Reply-To: <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 22:40:05 +0200
Message-ID: <CACRpkdYM11240R7XgypqVEgLNUi-KEn3Q59fwWR=TubDHQ7xng@mail.gmail.com>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:04=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> I really just want to merge the series before Nikita runs out
> of motivation to finish the work, after having done almost all
> of it.

I feel the same. At some point I think the SoC maintainers
need to ask the question "does the kernel look better after the
series than before" and if yes, merge it and propose a list
of improvements to come later. Given how persistent Nikita
has been already, I pretty much trust him to fix rough edges
later if need be.

I tend to agree that DT bindings must be "just right" though,
since once merged they cannot really change, that is a fair
point.

Yours,
Linus Walleij

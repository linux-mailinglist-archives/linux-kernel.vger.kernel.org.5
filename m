Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA86754DAA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGPHiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:38:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0291993
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:38:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57712d00cc1so36159247b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493084; x=1692085084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZZtnrhK5IcktWMV0LXWsExsbNpvJz7HVoSErboxnqE=;
        b=fg8pvT++8sfktwji6DueuZTXHHoomuijR9Qi/cDAdShspvjf/Sa9B4fhOHxCl4PxSH
         +5rm78WNx+iSvjERFjYuv0zUtxzMe9whCNLCSWpSdQFPHn5IXqJn+dyL4mGkdrkxfqW4
         cOo67bhPfPX0Af3OWfNTdrGaDnVaMCTvVTlh9OgTi1n4XjMyKSPcavNwHRqt/L6L+ZxS
         10Hry4EiWYfS4PbQZdDDj+n1EoGavznaRa3Yq3xmuKzcMJDRNCC9HZ1bNs/HnDA0B7Ow
         Ar3AGKpNGtNDISrfCz3fZ44dIcp5mN7iUnDeUOmtwF0srJFOo70uwybdmizWQfuaUBf0
         bE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493084; x=1692085084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZZtnrhK5IcktWMV0LXWsExsbNpvJz7HVoSErboxnqE=;
        b=JkoXqHhultdebzHovZXYmqU4zaSH2M1holOskrqq6b+UM1e+HMDWBrnUfb2xUt011s
         GiAwTDTuwOUYrBPbITWJLfKYtlaqbPUywlleF8ovl0OQgS9V42kpEDttfKa/7D+F9kuL
         WbfPutSAoXF3Zyarw12pX3N05/YgEBxZkob5nrn8OhmcYm0kOE+5H5bTwrH5bOVNOLlA
         YsSAhPa6j5alaYSvts0U9car4evPlscGZmyZldJTzbSzszqJn68SbERNq8+2ywREsfUF
         sKNeAEvW9c4VabRDoWf2ZL9pY3F0jjaTQTgxYiksAQ9LDkHQIJUq6Pcp3EYYpRWf2yUv
         UgbA==
X-Gm-Message-State: ABy/qLb/STsUeyLip2Dd7SDr+M7tEUGcjETrnEueuDxnT1nABso4C1Rf
        n9r5NP/lr20HpRsXmcCCS0ZxpVzwkxeWW4LLIPOexA==
X-Google-Smtp-Source: APBJJlGb5i+pBG2gTvRS0IwH689ZIYfyMJZ1vvYWUAAgWwRxkmV/eunY9C78J7OPPqzuPiEUw8MHDNNoLMB9CfcaMlA=
X-Received: by 2002:a0d:e306:0:b0:577:3666:bb4e with SMTP id
 m6-20020a0de306000000b005773666bb4emr13143755ywe.36.1689493084340; Sun, 16
 Jul 2023 00:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711142247.751857-1-ulf.hansson@linaro.org>
In-Reply-To: <20230711142247.751857-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:37:53 +0200
Message-ID: <CACRpkdZUpU0iM3F1FG+U=gtm-oQEZo7tzPrhnXa2KK=wDCKWNQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] ARM: ux500: Move power-domain driver to the
 genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jul 11, 2023 at 4:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> To simplify with maintenance let's move the ux500 power-domain driver to
> the new genpd directory. Going forward, patches are intended to be manage=
d
> through a separate git tree, according to MAINTAINERS.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

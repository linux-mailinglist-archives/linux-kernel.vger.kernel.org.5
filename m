Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558B754DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGPHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:37:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C07198A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:37:49 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57026f4bccaso36251627b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493068; x=1692085068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPFA2OhaMiUZPFyl6yQnfxgGXvN2ckaF3tAbSpyOZ+A=;
        b=xAEJhots0bQMhdiD/1XaqXhyLyN2ukAmENl3ByUptDtikyhB8/VYd2aDFFgWbL7BB0
         /tqTduvjKWy2m/Smh4lgfrzYFx7XxNCwcTzC92guCyjv4bNPHD0HQHUTuCk1+m3ruIqI
         Ku5wVJ+Q0whVsBh2S+eg04SJLV6bjapt6TJRjxMrB5MDipmd+6eaL90H28CNwj0Y0EJP
         0L5sKG35No7DsNLGY9n+ICTTdGdBjTpHaDHlKCMe2INC/FvTKupjlQjlqB8C4HcnLzTq
         zqLxIsO0rrGlD4r2wNzcU1sP96GuYZOfbjfvKv/uGmZLhhoKEQbX22iYyMwCguSOA+vi
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493068; x=1692085068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPFA2OhaMiUZPFyl6yQnfxgGXvN2ckaF3tAbSpyOZ+A=;
        b=DGhN11xPRf3LWJuLnYskXV4Bwf/Khnu2dpNnRThgURIUQ34gVjQjiBdL1tsrxLu6CU
         mxmk8ugHCJcUuWvcu0XzZ6cdZUkm3SR9OL2iCNkiQWWqM92F1Zbh8qKJj70F3wbZMkqx
         ByIAqWOw8LBND+MusemlubQmVRQ54pKQkIPSk6g0yglpWDd+XMIIhgg/CRr+qHaWYSd2
         cw7x0bWw93EUy/TA5jCkM5+JSS2IeF+H157myE+CYqG7YCpdy0ePGyqreNMRw4m+nvsv
         KhjvLnUv0frUx/Vv/aEUm60NWTGubkKUHEQotV/+qZxYhYrnsUkKY/p47B4DLl8olA5f
         dumQ==
X-Gm-Message-State: ABy/qLYgSezpyOpy0+GUIeWatYR/Yq0HjKrq7XCT05JfUNSOOcj45Ofx
        iGvlv6tJ386Mss7WwiLzO9Ow9iO6WiJvGXrnc0qHsNLciMsQYsqEx3w=
X-Google-Smtp-Source: APBJJlGsNzcnRphcCBRlqntr57jZ4UkA2ghCO25tzSVkBMTWNRooBzQs+rKTywXsjhCEgaGvKE3AvwK9ygAx9g90bUI=
X-Received: by 2002:a0d:e7c1:0:b0:565:9a3d:fb27 with SMTP id
 q184-20020a0de7c1000000b005659a3dfb27mr9990067ywe.35.1689493068571; Sun, 16
 Jul 2023 00:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230711142237.751837-1-ulf.hansson@linaro.org>
In-Reply-To: <20230711142237.751837-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:37:36 +0200
Message-ID: <CACRpkdbKHNjD4R41U-+tX689YHK-qbq4ZzRSfiCjHvHznARuJg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] ARM: ux500: Convert power-domain code into a
 regular platform driver
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

> To make the code more standalone and moveable, let's convert it into a
> platform driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

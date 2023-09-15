Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D57A1921
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjIOIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:46:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AC19A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso1125572276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767590; x=1695372390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7dFja858QAKd2jvGSHcGoeN85VFrdz3aCMi8eOpyFA=;
        b=Qv+lp2vaf5IgAttGkMjq1e0bRJcsp1hRfEahpLM4TZVNwdmueWhXD99JWBffKw0E1i
         NJ0AX5guWmNZ71ZFJL1K7cTnds73NNIa1CQmdYDMNgNxxvOns1+CGZxu0bGEBj1qnZLN
         cEtF2Qy9o7AWlQd76hmxa25b4ee8FTRWp7EM9LPVuBP3zEPTsjretOmoEn0yHRzZ3KBD
         VkehbrPfvY36ug+cwZ9GVWTkq60WAiztjExi0Mvg5Fg1ANBOSVne7Kj4mlCV3xJXRAX2
         m0r6PPgtJ6o+cz0eD+Kn5i8qsnpU2zNGEGz7LCmKhe9qBKeDCg1ylOv+G71JQ/pKGb33
         7DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767590; x=1695372390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7dFja858QAKd2jvGSHcGoeN85VFrdz3aCMi8eOpyFA=;
        b=VxajMUJnrcnPUBfiVRpmlaCIRrEyzkLEOq7JmUcofXQwAlichfMS9ZOJ+E60p89s/G
         ROdsdEFvqgznZp/wxHd3POAZNfoXjtnpcPFrTfu5Gk4Y6jMnXyB9aHlXEmgR73YI/cJG
         2Vvyjlq+Ap/0HnHuDUYXC860bun+eBnFuYRqWxK3KuyDoJ3jWDhGiFaFdPv/q7UjjEwP
         z/6z8g5KOtljwi0cyjcgoxbuCvVK2hc9oNzraqBoBptY0nHKXNWr9YEf0TfB5LqtB3so
         wHsZ6+R0WD3VWo98YwgZPnNYxJJUFqboifi0n0RD8AKN+kiasLCG7d+uYjWu2fjprcFn
         sx0w==
X-Gm-Message-State: AOJu0YystQSJeZDUhq05VmXM/vfmwdSa9Tkp7b3/gisOyCp8iCGkp3tD
        w1akCiTuEH3m3VjI60pwP2ygXH+5cSSkl+HxugKrYg==
X-Google-Smtp-Source: AGHT+IG6Q+IiSNhWJfwPx3EF9XH2lhzXIA3xdYaGMvC2dGwJ664Mu2IM0zshWn36EazY6A9blfT5yhH+scmlNrxCGug=
X-Received: by 2002:a25:b08a:0:b0:d81:c4d4:9e86 with SMTP id
 f10-20020a25b08a000000b00d81c4d49e86mr760227ybj.64.1694767590080; Fri, 15 Sep
 2023 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me> <20230915-ep93xx-v4-37-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-37-a1d779dcec10@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:46:18 +0200
Message-ID: <CACRpkdZeu6+839_E-yDH0yi9Ma6MzhjfXcvhXDjeLoFnH8TP5Q@mail.gmail.com>
Subject: Re: [PATCH v4 37/42] pwm: ep93xx: drop legacy pinctrl
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:12=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Drop legacy gpio request/free since we are using
> pinctrl for this now.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

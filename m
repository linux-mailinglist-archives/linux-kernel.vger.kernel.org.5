Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CD7BC232
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjJFWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjJFWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:22:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D301BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:22:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f7cc71e2eso33140157b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696630932; x=1697235732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIcxz4GiadHjd+WIPenFnmmxtkCaCE5uWGwu/Joc3Qw=;
        b=OBqbycb1tYPYo3L+ymjrU120d13Jtzcdsuwjdp+qUN8fqNl4CifrFeH6ayynaZBYxD
         tjQbldw4yyZaEHqzA9+0NQnrc5tK2LEDQ9F4MtHIG65Qa7bnuTtQMWP0LMoGQqVeSOLA
         1o1DtII9hrRlMJTO1j0WMgYnpABCrarXLa2p2p2mKLaqhDM5j3QWs/Lt9n6MkTj9zCoF
         Izzzw7pkKTNQ767HUx6gznKPvgPYTTfyidKTA9zqyQzWDY7BJLmtjoOIRBwQP6u9eaPn
         z4aaluvlDlKnlKcRblOtbRSSORR63lnpuJmHEhJemK4N/VOzdaGCQ1Q4AzwJmlJ0J9Zo
         /qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630932; x=1697235732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIcxz4GiadHjd+WIPenFnmmxtkCaCE5uWGwu/Joc3Qw=;
        b=SI0fJZqsxEmy+1tLx9BdRKBFUlvoW+j80/G1vfHvY5wtEIRj/eriCRg09CPlaQKIDJ
         IPWp3gPClmFA68sOjk3NKAgqu8RqOEFNKOvX90Y9zBFz7ovRH8rVU6B63vOiegL054v5
         kswO9mEfOS/d8HfoSOJslyBeNYyzNQMicXZGfrd2RDDN30rX+1MQIoB0HQNn1i0nKzSB
         7xA3GQ2AymY82VkIvb7PU8BomehlRTE1QHlu0BuARiCg6vFx7tz3sNxRwWd2Y80cu6oV
         4emwff5ROtyM5cVraEf0+1TgXw/ZvGmmC8zB3coU4aC3yXd4oVZHcJ1SUDvklEbrvr3K
         l1sQ==
X-Gm-Message-State: AOJu0YxtAz+e81xBNb7BBFuhk7sz1QSQFHsTdd8xQmYJkMezDxVdxzh0
        ThuHJMW9WbJ03lwGlaLMYiRBH6lNUzfp8hn+dAB6BQ==
X-Google-Smtp-Source: AGHT+IEeq1rx2bpqDd2eKq7pB2baH7l1tTHrNVJqZSUg7KwvYLLOzc8m8XsF4ry5o1P/TbX82T7siMt41Kdwy6U+Ym4=
X-Received: by 2002:a0d:e607:0:b0:5a1:c610:1154 with SMTP id
 p7-20020a0de607000000b005a1c6101154mr9794442ywe.10.1696630932606; Fri, 06 Oct
 2023 15:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl> <ZSAKdOXpo+xOI3sJ@smile.fi.intel.com>
 <CAMRc=MeYiiWaaqRtSjRBfaWGFtZCPWCjYk+ZrX5TwicNq9MQeA@mail.gmail.com>
In-Reply-To: <CAMRc=MeYiiWaaqRtSjRBfaWGFtZCPWCjYk+ZrX5TwicNq9MQeA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 7 Oct 2023 00:22:01 +0200
Message-ID: <CACRpkdaqPm9471q7Sg-cxcLTTE63=NuKuSUFiFtPsaUoRiB3jA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Fri, Oct 6, 2023 at 9:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> I don't see any good reason for it not having the fwnode assigned.
> User calling gpio_device_find() will have to jump through hoops in
> order to match the device by fwnode

Yeah I would add

struct fwnode_handle *gpiochip_get_fwnode(struct gpio_chip *gc)
{
   return dev_fwnode(&gc->gpiodev->dev);
}

so it's easy for external users to get the fwnode if they really need it.
This and a few more changes and we can drop gc->fwnode altogether
can't we?

Yours,
Linus Walleij

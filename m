Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E375B800
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGTTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGTTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:31:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0531724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:31:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-345e55a62d8so5973925ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689881489; x=1690486289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ0Vl7Rtd5mCZnuqCwqYc2saj+VRH99piewtntRthNM=;
        b=Wd5BI1IQviuTgH3SsvYTSArtoYoI1RkV0fFal+vtEEAm59NNnlECa1V3nw+Jq+lzP8
         0ZpGR5wF8aR7CEVofNkr4guKRufk9l58DHnCH0+GQi8gwEEsozxzpXwtTQ6P5TXABKWG
         uyQsewr9vuWC7lFVO3HIwwYDbZfEfpq9ZMJ4kvAr9e3sfLXqaQzehXWCXgQ55RUz63bM
         CpPzJ4G9Bm+IwuSdWtUy64T6Muz0s2P0Ppj40GHZmh6x/osAMWehfXRZKPXayggsiaIF
         UWhvpVhKxVrha3YYQKqMYlQpb3L0hWHDBbSbE9Grqv3iemdGi32cIfR7PcJWdUUDUsLY
         P9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881489; x=1690486289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQ0Vl7Rtd5mCZnuqCwqYc2saj+VRH99piewtntRthNM=;
        b=MREJ8W4zg9f8LNoZ/ss1rfBELqveOZKFyu0xKjkkiPTqGEz/fgu0908vIGnhHM5tAL
         4g8FyGsLL9KPGNLqXqnxA+bp/Ho/b2FbznTmt1dzWUsBEz0TazFC344UJFUHSnvPGskL
         GGIXjzwtzSz4wZs5qrwrwqTtIzdhVJWaAOu/sURy9Q78yvEGt45Lgb4O2LMJlpuZtAmV
         qoVpetu2WYAMUpBt+2XOrfb3C5kR0Ajr44vH9oNXZucz44ulbAGPPs3IkKbXDfiXYyWy
         HnU+H8EMtjeJKCWLHeEoMW0PTG41+eepzW89hasbTAvSq0ylJQOn2/zG06KIxBi9QKDU
         iJJw==
X-Gm-Message-State: ABy/qLYs4BIUY2NIkZEH2JysK//klmy9boqlnzLgIF4Jr3Cgij7fCdwJ
        KHKA2uJge2mGRpUuGQK3cw94DxiAEeKwgKpLs+HE1SNXgQaINUDG
X-Google-Smtp-Source: APBJJlE+Uq+usX/08SQnqLnNnE66u8s0NJxA/J2HIXiy4tmypIIgMdJrsyMw2+KgcFgzMnhae2C9+4WlMKVz36rf+DU=
X-Received: by 2002:a05:6e02:1153:b0:346:7502:aeaa with SMTP id
 o19-20020a056e02115300b003467502aeaamr2602159ill.18.1689881489379; Thu, 20
 Jul 2023 12:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230712095955.105716-1-brgl@bgdev.pl>
In-Reply-To: <20230712095955.105716-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Jul 2023 21:31:18 +0200
Message-ID: <CACRpkdbBTz8wD8jqKi9ZuU61kUrxRwirhLAcCj9UhXMy8ePzWQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: order includes alphabetically in gpiolib.h
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> After adding the missing notifier.h header, let's order all includes
> alphabetically.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

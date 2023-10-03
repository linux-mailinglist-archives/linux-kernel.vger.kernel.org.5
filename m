Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86E7B7373
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjJCVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjJCVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:39:57 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3730A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:39:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a21ea6baccso17944487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696369194; x=1696973994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkjSMGI08BUEZqbYCt/0/k2U8kkzN9nX03c/hR47kbY=;
        b=be8rYlhAn51kLN3thlSSL7w+HnHGTsxOaBsSI39kKtLy9CEn4t5HsKLDoL+KA5Vy+S
         jPjQfiKvOU15Esf7KTLQRh/gzpkZv5e+zBmqPdr7mnG9MDSjM/JbNJy6C2W0tn1/8p7Q
         k7sSLH2yr3pzW5un/bDrWQ7qu5wdwDCStuVpYmY/qqMrzW+dvPRozhAVldwwG+3Bp4Iv
         C+dd7K7nsyP9loZi3bpX8sA7esHj+5I8rzE8Kdl47YyRh0aWLGbnMg6N2RMIi2M0HDRa
         Zt0WO6Bw5ZytUuLj19mIbZsdd879tiZ1nTIFIr6u2KJPn+f6WbJ0fkENMWzFxbQa1UIF
         PkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369194; x=1696973994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkjSMGI08BUEZqbYCt/0/k2U8kkzN9nX03c/hR47kbY=;
        b=K7sB9EAoBJ4W3815F3rAtpX0nKVmQJDLdRvYvSCkMaR/1Wi5u7f7OJ1daSu4XwpLoW
         57+p1ZUj29fvi4WmIYhETXvQBwfmrSqonVJRlwzREDDrK85uUWsxP5Qfdiw1vBO3TbU1
         7fMNYRBmtwhLEIB4GBuJmBPrMIpIPmC0Fz7Z35o1bO/2V7K1Sby4UizCRxpXngMLV2KN
         jl+OSIMLiJGqG46EwC/LoxQWcTLYD6D7k2mM6DyHqfBce1yMscB0gqbvUaPrVJsBa7mj
         eYLeeN1yLj5/b5J6IQrtSnI9BYMPh3QvcR1DRLUbcBsWftsWAbRVFkClh5y/KSq4BFSL
         S4dw==
X-Gm-Message-State: AOJu0YxKjp30EkTnjaObBCPXtkfzgcKl/LtyZXwFxAKkv6280p60AWRw
        KW2OgbtKky+j/ssdmRSEq2mLiAMp2pYcZC274Y4kCg==
X-Google-Smtp-Source: AGHT+IHqAVaLO48AqCMkb0AjQp6j/V3JludUlVQMLk0WgqSkYVEpuXE31cZ+mfo1dRdT4U0PfilSjcftpCzeGCuqel8=
X-Received: by 2002:a0d:dec7:0:b0:59e:9a44:9db9 with SMTP id
 h190-20020a0ddec7000000b0059e9a449db9mr768129ywe.26.1696369193890; Tue, 03
 Oct 2023 14:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-2-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Oct 2023 23:39:42 +0200
Message-ID: <CACRpkdYe_9_SwZtupbicyj0+d=ns5TgLgPhdB+E_wZVSo-TAsA@mail.gmail.com>
Subject: Re: [PATCH 01/36] pinctrl: remove unneeded extern specifiers from consumer.h
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Tue, Oct 3, 2023 at 4:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The 'extern' specifiers are not needed for function declarations. Remove
> all of them from the pinctrl/consumer.h header.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

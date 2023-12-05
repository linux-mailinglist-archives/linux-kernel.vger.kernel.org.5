Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF42806222
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbjLEWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346511AbjLEWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:49:45 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFA4196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:49:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5c85e8fdd2dso69545957b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701816590; x=1702421390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrFaCxut1vMUHEQKCkObXuZTRmt2Q25+qM/Ls973otI=;
        b=dQZ3IFubH9gI2jg/gp8HqU98fc7aBOrxFTcjz4dnBQUqkese2qhIhh7Y3OrkDHYWue
         D92MYGMHfDqX+lEqf4cEBeqDBJ7iqjOBjzZ84vgwfJP3dFkZvXUpf4wu3M0gmy9Gd3H+
         OcQW4yE3CS8Am4IXUG+ZbcjTVZyGY4GDwiUG02FQu8uS5ry+DX6yR1GNwdl1DQWKmquF
         yhaeHQMZKOe1O+Os6kaR06a7jNXRehDVOPic99k3JNPdlY91NP6IZrV5gOV+INj4lRqR
         ilMKgqjSySnvotwzQm8zWpjHXpez+ZG3wQQJoVh8otuvIjDDJd+wNx0Z5GmkMf9EFG76
         1gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816590; x=1702421390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrFaCxut1vMUHEQKCkObXuZTRmt2Q25+qM/Ls973otI=;
        b=sfTjeEbVOep/8lxfJO4oQUa8t9u5cSoWSZPDsUOn5+1MRdNDBZa4nBY1nukQmKWo76
         m25WcCogDKBU7H5sOgn7I078wKHjmqnycYzjrFUMvxFb6Mrfz7JyosKPtq/KQAeSXCKC
         0NWtdZPEBa/5F0mMxPce0bl50rBGilcNqABYVynTzyBEZfoDAZP+hqg6ecdueuJ5hyio
         XS+FmaU4r10E5tHTJZrKH86UzRCn8zTldCF8GSp+EwmOgozCMjJ1/KaUDHWasq2J7UbT
         a1qKh2j6N7VuBrWtjGyvxmlQ2SGJN7TorOVt4zy8KTW1HJvYEX8MdHDcVh+joaX7ItSh
         Zdow==
X-Gm-Message-State: AOJu0YzKTvjq8WysLq0P50TcgqG0gkCa+ibSzNKF3bovY5jkmnq4ShPZ
        oXfl9ylWgCqpRFQiKz+aZkBbwy/XiRwouxs02ietTCZgVDWs3zhF
X-Google-Smtp-Source: AGHT+IFEmFb+hr6nRdjNrf1j/t6+1nDZojjY2YlEds/9G8SBs8lIXxIchM5+Ia+fLcw0ALQ/l3k+kJcKL5pmaaIPjXc=
X-Received: by 2002:a81:b622:0:b0:5d7:1940:dd63 with SMTP id
 u34-20020a81b622000000b005d71940dd63mr5381287ywh.57.1701816590707; Tue, 05
 Dec 2023 14:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20231204093509.19225-1-brgl@bgdev.pl>
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Dec 2023 23:49:38 +0100
Message-ID: <CACRpkdYn16SbWtS=hSx0r=pmNR9MKYTKd5q9Btr=wft8n8CRFw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpio/pinctrl: replace gpiochip_is_requested()
 with a safer interface
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

On Mon, Dec 4, 2023 at 10:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> While reworking the locking in GPIOLIB I realized that locking the
> descriptor with users still calling gpiochip_is_requested() will still
> be buggy as it returns a pointer to a string that can be freed whenever
> the descriptor is released. Let's provide a safer alternative in the
> form of a function that returns a copy of the label.
>
> Use it in all drivers and remove gpiochip_is_requested().

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> I plan to provide this series in an immutable branch for the pinctrl and
> baytrail trees to pull.

Nice! I'll pull it.

Yours,
Linus Walleij

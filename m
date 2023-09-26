Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683F77AF505
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjIZU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIZU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:26:26 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD484121
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:26:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f6767a15dso74159727b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695759979; x=1696364779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnOB3K0f9cHrRSnWRtiGjYWm00LiPVSnOp8cSSqH8vE=;
        b=NDf8wt6wIW6mR92yXBWOcWttW9JlSekUhXY+ts4dssjO40IUACXiOJP3uoqA9jQuLa
         vvYaPm/dY7U5daYT6T4Kbw8fUncqil+YSgM5se0D3M6/74j42DmoUm307qcX0zAiuTnj
         84UmmGZxduYPE0KT/0QFWSxMBd+OzG73UTat77DfwxXqRgfVe60C9gTMiRYU21/5RA9r
         2F2WovoOwSP35PlhABE9zksifvUQadRgI93139kYq7jC0QQ8L+WNySTyOcZOe0qfC+4K
         53arKDRg/oDwZoNXNUk1Zx4oJUDKIm1FOSP1g5rUuqCE/VgZNHIvoeYBR3qRibVHCUpf
         8Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695759979; x=1696364779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnOB3K0f9cHrRSnWRtiGjYWm00LiPVSnOp8cSSqH8vE=;
        b=wkSWOsuVrv8TdUhZSHIA6RfPnvqGzGk51GzeXJjeWBB9eb4tCC5iZ9tGjjuFuoCRXR
         Vjf/fWhbEgFgknEI+7546fevNB6P3HC9zw85i5+2VGcgy1J1sxYU/5h39Wv5XJLuolNn
         wI4H405//pwZOR1H0UDaeWV2rRpX8HFb/pLugfuNVawFM19tv8+V/HNJvgQLdvruJZvE
         j2NMm5k+dP0cOWmZIoFZhTFRAIl/DQoGux6R8tWUkixclZbMOtL0CWsOjlmpbRJKHIwx
         pI3T8mJLTPi3R4jVzkL5eBU6I1JEed1ISSdms6t+YKDq8dfLhZhNoPDkGaCKxuRbSJhg
         03uw==
X-Gm-Message-State: AOJu0Yy5/UfV/2NwM7jhlx5SJVHgTCeGIIdrVJj5GYnxZaGAoY8qQgpa
        kY0bMCbgkaTrqEE6VioDVAc/9rhgg2oWsbGiuAQM3A==
X-Google-Smtp-Source: AGHT+IEsy9t1hEO7v3SM1pskJBN73FuS5Gt7wFM4+MbPWOZJmWyf3z12DHn89mtRK2+gK+rYueOD1oY9YmBhF80eK3M=
X-Received: by 2002:a81:9c46:0:b0:56c:e480:2b2b with SMTP id
 n6-20020a819c46000000b0056ce4802b2bmr3123056ywa.12.1695759979036; Tue, 26 Sep
 2023 13:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr> <20230926-pxa-gpio-v2-4-984464d165dd@skole.hr>
In-Reply-To: <20230926-pxa-gpio-v2-4-984464d165dd@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 22:26:07 +0200
Message-ID: <CACRpkdbQD4mdWcGz7LcZdetZQUWHJvZK0ieHLzZYkVHicKGvYw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] ARM: pxa: Convert reset driver to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:46=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> The PXA reset driver still uses the legacy GPIO interface for
> configuring and asserting the reset pin.
>
> Convert it to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Looks OK to me, there are details I would do differently,
but hey: I'm just happy this gets done.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

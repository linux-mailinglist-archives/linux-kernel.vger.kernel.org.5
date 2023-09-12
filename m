Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8B79C874
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjILHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjILHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:45:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97340E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:45:13 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49032a0ff13so1859974e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694504712; x=1695109512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/xqKTGt9/2jwXBObaDDzQ25OZV7MH4LGyijIsI0iws=;
        b=JwEQOTcvn6CsobedRqjzF0+dldTcI+tAin+A2Y3keymR21hBcrvCoHzDqVn83gewVJ
         JltU0UTMy3bCwYC+CV1BAOQM+8kwPWrADCXQDaQaP4jP8uwQOVzB5ykWlPRxZD+/8UqG
         ZWfeuX+1o9LdcTCZ0ayad2nTJX+dCh4oH9TS40mvhJuHFsyE2uxq8YK3sD1agnEZ7w5o
         jTkIjglq5/qAUFjhAFDwrqTZ3s+se8i9PEHXb+Fc5oIfJXZY1K/Ua+kbLsNxCsrBtcmX
         9wFH4LoivNh4Y9jSSTVxCcf0faFuHpqxW2T4RP6pG8XMc/QRcDeCaXvIaqEG9T4/CExC
         7PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504712; x=1695109512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/xqKTGt9/2jwXBObaDDzQ25OZV7MH4LGyijIsI0iws=;
        b=TXh8zTPYQNzJRInt2Lbf2UiEJbDJnZnViKNotnCZ05maQBPPSQPTPQLO/Yd6xc4qG9
         3Q5SN3ETvwfQmZUq45fS4CRncqnjXpXQ+HXyMUaUigzlI+gyty030ps166ISmnsNWeVZ
         NB6aOf5pW7MqzffHmIC2zA315BQ4Aa29CKOz8VsPI1klKRcIgIom7SWig6UtY1bbPgqH
         aRgR8gQo5M6X46q4XDiMBE32s42xqdooH3yQaqjQ/aofazkYt1yCKuhOQ1fPbPqyZZhq
         kVYO24UrVQDUiMMMx/zGNA2l6r13edlyKOhi49GFIKMKqDBBijqzdkjzfNrb8WeZWQsK
         iXJA==
X-Gm-Message-State: AOJu0YzeT4jIKGMdNvnlSgU9RhgSaY1pt0Owmj94d1mWvPuYRie/0qYW
        +Ft7muHqdp5SEeh+8E6SLTYcvZ2ejZYhU2FGb3Sgmg==
X-Google-Smtp-Source: AGHT+IF8m9/dolIjze2DM/19manJbtvxU46XYYD/FPUgWfcyv/9Au2xW7fvpQiGn/pTlQ8Qm/S/sTFpl1d3TjulLc0g=
X-Received: by 2002:a05:6122:40e:b0:495:bd33:d1f8 with SMTP id
 e14-20020a056122040e00b00495bd33d1f8mr8834996vkd.13.1694504712752; Tue, 12
 Sep 2023 00:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230901112926.13216-1-brgl@bgdev.pl> <20230901112926.13216-2-brgl@bgdev.pl>
 <CACRpkdY4nqNv6Xt0hO13ohghWtxyTgUw7PNorDgfnye-CSmZ7g@mail.gmail.com>
In-Reply-To: <CACRpkdY4nqNv6Xt0hO13ohghWtxyTgUw7PNorDgfnye-CSmZ7g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 09:45:02 +0200
Message-ID: <CAMRc=McYrkeUWgMJgMA+BEHUeTDDASmYGTiGWz6_A_Tf8+CK4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: da9062: add missing include
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:30=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Fri, Sep 1, 2023 at 1:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiod_is_active_low() is defined in linux/gpio/consumer.h. It's only
> > because we're pulling in the gpiolib.h private header that we get this
> > declaration implicitly but let's fix it as that is going away soon.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> For allt three patches.
> Just apply them to the GPIO tree, that's easiest!
>
> Yours,
> Linus Walleij

Ok, queued, thanks!

Bart

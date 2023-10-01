Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E57B482A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjJAOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:50:59 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD5D8;
        Sun,  1 Oct 2023 07:50:57 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57b6a7e0deeso8144046eaf.2;
        Sun, 01 Oct 2023 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696171857; x=1696776657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe0jbcunYSeKWsSpE9zW95jRbab0GreNAdw5EllRLKU=;
        b=UzYgSDE9MDz5NRHYDMUKKS30zp94ArUsL3xAajY4kj37A1NntDY+Pp0xmbUoRxfKxV
         tnirXqPDdijoBIyHLlwSk5tAF+Z1QyrhEt6dSSKo+6BnWY5lIUYL9koLGddyjD3i/i/N
         PQNjHFIAoJeM2PYxLNeeLpIcYPrheQd+O64c1qcmWgr4yX3gB+NBPmA+9MyaUnsn1rDY
         NfoTmT2stvNcepqKid5qkFG3asYo+nZfVtA4CFlL4Fz4IeEVlGOWXYGKwtYg59z/omrp
         eKPRFU4Z5gVjQh7Vgk75y1daDaC0F0F3/j7sn0wvZVYWcsMDDIgS0QSCjR3lUF/lS6k5
         rlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171857; x=1696776657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe0jbcunYSeKWsSpE9zW95jRbab0GreNAdw5EllRLKU=;
        b=aSDNTa4zYXvqXxxam5K4+e7PP6Q+Th0OcLZjqj1w90AcBhrLA6aRUbeB5DqtL5uiv3
         hofCHUv0ZzfV61z5tlH3xsnm/mpLj1RLTgqlGtAJ51uFAGmn6FJl/XmdyPXK5f/3LAt6
         JU/YU35rzNwKJLSGxr7IjlfMt89fossCl0u9e6+FIUnQzKcIgDGklau+8WvS+AErKyyF
         A0kzteTuCLP1uyH/itXOODYoHsBpx9GGdsyKzSG+UdY5pAh38x9HU7ltqE0+QePE3QoR
         Tk0A7LIJqOPbJYUDRX2JGdmXrGkL+KvNq0ygUohkjPKM4BLW9a6sf5JLZd6QyXmEPT/r
         mFOQ==
X-Gm-Message-State: AOJu0YwLjPITuOK2wHNP4RgrfTbtuhNnxL1zlBdj0f9mzet3NSRRuLgy
        m9XRur+KCUNZcxg823yka0hmRg1FxbeP1fUqTW0=
X-Google-Smtp-Source: AGHT+IG7xN3/WZcneWR0S1D5iRSDAud9pCMgzQhsu8dnbGlcKGIsd1IyAnWAM2RlV+uAg/JO/HILAiuF7UG1bGjpmrI=
X-Received: by 2002:a4a:9b54:0:b0:57b:e5db:7a59 with SMTP id
 e20-20020a4a9b54000000b0057be5db7a59mr7802465ook.8.1696171856730; Sun, 01 Oct
 2023 07:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-4-0f3b975e6ed5@skole.hr>
 <CAHp75VcgajYz4XScSLTxYSKy6mbTjJ9mD7zF3j90d5+6V8NyZg@mail.gmail.com>
In-Reply-To: <CAHp75VcgajYz4XScSLTxYSKy6mbTjJ9mD7zF3j90d5+6V8NyZg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Oct 2023 17:50:20 +0300
Message-ID: <CAHp75VfFXYpN8K9WdbkHBy34J_L09UhkRU7h6==Mo7scQB+y0w@mail.gmail.com>
Subject: Re: [PATCH RFC v4 4/6] ARM: pxa: Convert reset driver to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 5:40=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Oct 1, 2023 at 5:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:

...

> TBH, I don't know how it is supposed to work with your current code
> and if Linus really was okay with this.

Okay, it seems I have to refresh my memories about GPIO lookup tables.
First of all, we indeed require a connection ID just to match and no
matter if it has or hasn't the suffix.Second, the key is a label of
the GPIO controller according to the device driver (device tree?) and
pxa-gpio is that one. Seems it should work.


--=20
With Best Regards,
Andy Shevchenko

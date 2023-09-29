Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8937B3C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjI2Vsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Vsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:48:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E027EB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:48:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f6041395dso137936117b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696024126; x=1696628926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Y2fSCkcD6jdRglS8aGJ3vVQKyE2EnbQ1TAFzAJFA4=;
        b=QnVibiDBsePGVHKmKJEmFcVrX/9y/tY775zcYtJVRPdepP4npvAhk9nyjVsoZFOHB9
         ms/5hacbxBgLjc/ajo9RRG/CcfC/O0riso3DthdwM2/DNT2yETDnO+g0HFbrM7Gk/jY/
         P3ncwe7r8OLzE/tCDhZmK6hUDcD3iF869OXuMe4ACXres0sbPf2Vok7gNMFvR48qdNBm
         ta7r3HOoP1q9qkraK9x90kEuEltcFD96g0wa73mqlk2n1pLPEVckLovIfEI5Y2B8LmVD
         zn3IoHXr+ftuYmRCu5zENLBSBuJVAZxJ2srJw7DC4qliaoQxkmxZZOu2Ceu5d6LuoY7o
         ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024126; x=1696628926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9Y2fSCkcD6jdRglS8aGJ3vVQKyE2EnbQ1TAFzAJFA4=;
        b=xBlRz1TPmIb5WrmmVeDSek3SGHmHoAxc1kCDbcTUcnwIXdGXYZp1jz9PqoyKwIN41L
         kd/CCZQmpIQZETfYaXUpz+KZiys75z4CiQzRYGVF5wDlQXPg7CTsudCus96DmbDYhe63
         COxhAB5a8VahKHPf6jMDdk5UZrJ8KwOH7exWUr8QpAKkZFb1MZqJLgkRLzaHUm9KXJ0Q
         6NhBJU+g2jrCAOIXpMalFNBYSiSbWoMwsni53m8+/nQQTe6aCq1k38d4QPbVYy7ILUnf
         bx2lemPfZJb2C6Z8U8TmFTvD88yqFuk3+BiR61kHwM8gIJGkl/JZpC9Abe2rPVcvFGi4
         SxLA==
X-Gm-Message-State: AOJu0Yxf6NK9AOiUa8scsxAkTCCmFHTp6bKZw9INW17/BJIMpXrehPe5
        HqI5w8R+LVeWSvdbO7B4SRDU1pHyNyKzD4XJzan3pw==
X-Google-Smtp-Source: AGHT+IGMuUapNs4yNU9a9tvc0M51D2PY6cv7TMVefM3fJUMhtTVk+rSQKUmHIfeHIdVCBINeGTuJAZ2WcPIL4LztSNU=
X-Received: by 2002:a0d:eacb:0:b0:586:b686:8234 with SMTP id
 t194-20020a0deacb000000b00586b6868234mr5805526ywe.8.1696024126383; Fri, 29
 Sep 2023 14:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr> <20230929-pxa-gpio-v3-6-af8d5e5d1f34@skole.hr>
In-Reply-To: <20230929-pxa-gpio-v3-6-af8d5e5d1f34@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Sep 2023 23:48:34 +0200
Message-ID: <CACRpkdZr4aRm6ru5FXa-s5Q0HbinTNU+HZd2ach-sUzNDQdyOg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
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

On Fri, Sep 29, 2023 at 3:15=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Gumstix still uses the legacy GPIO interface for resetting the Bluetooth
> device.
>
> Convert it to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

As far as I can tell the BT UART is registered before the
gpios are added and retrieved, and that should work so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

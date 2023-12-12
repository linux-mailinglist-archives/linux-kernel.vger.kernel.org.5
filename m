Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A080E6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbjLLIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbjLLIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:54:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D76FE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:54:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1915034144so711344966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702371276; x=1702976076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A//H89nLIqMq0iuRQhq0YsqOdT5hbunDdga9/SvX8lk=;
        b=KR6xLpGiMBAHNx2YT+hWUDR5kzvZa66xnIA/YkYly0O+6Di6pCvPrWIjRPrd4s9H6E
         dho6rTDCf6RBE3co8arbv+Etu10tfKzWx0mluZlLx+yNO5HuboS+Ou8RcBeewUA8fCcb
         BPXRm2kT+jReuBNP8dfhjK+c5h3/k46lIog58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702371276; x=1702976076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A//H89nLIqMq0iuRQhq0YsqOdT5hbunDdga9/SvX8lk=;
        b=LLNbti0DkAqEl8Tv0cqR4FCf775MCAXzoPWIkXXiuoCnk+pxPsBHLiyZESU/F53RYA
         jUgcc3TMBbF9fpb2OsgCmsA5gHJzSo4B1ZhKYgsFegq1qwxLAOK3PYzp6SXWijax8IYg
         XNXVEU3VQnvKOwYXyMkXvXKxtIB7soZExTS2imxNA7pc9Q6QIth2V68bj1UI45jQcLxI
         ouNwRE2MLQ9dJD/I4JaiSc62LJnOFFMGgc4Dk8adoaKi1v4mUVohLGzWyQxbWfOKHxSN
         o+ZX75PqyiQrt+EaWbI00QmAiq7qs3YegwS+b2Kj42JWvYzKO5jNDKH1C2PGj9s1hrDG
         ky0w==
X-Gm-Message-State: AOJu0YyvpNf94s/AfApCeZ3gCXk0VNqmRV9yx54/m76lNRU3fFGFTrfy
        GhLUu0ihfw/4JInvrDxK6c/rY00+ElXaJY5U9jsgyQ==
X-Google-Smtp-Source: AGHT+IFSJFHOOrQE3V04Fmu3oWSVJD1UkVU09R2ZY1uW85Gte5y23c9QiKs51LSszOA/s908I2zrbL+Lc7tT6S/fyMg=
X-Received: by 2002:a17:907:7d8c:b0:a1d:932f:9096 with SMTP id
 oz12-20020a1709077d8c00b00a1d932f9096mr3903932ejc.37.1702371276353; Tue, 12
 Dec 2023 00:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
 <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com> <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
In-Reply-To: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 12 Dec 2023 09:54:24 +0100
Message-ID: <CAOf5uw=6=zNmtVU7cOWv6xTaCghvX9j8pA9ijJxEqYpzikGdcg@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug

On Mon, Dec 11, 2023 at 11:00=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > > 1. init_kgdboc() runs and registers the singleton kgdb "platform driv=
er".
> > >
> > > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > > checks to see if the console is ready by looking at the return value
> > > of configure_kgdboc(). If it's ready then we're good to go. If it's
> > > not ready then we defer.
> > >
> > > So I think the bug here is that somehow the console looks "ready"
> > > (because tty_find_polling_driver() can find it) but it isn't actually
> > > ready yet (because it crashes). That's what you need to fix.
> > >
> >
> > The polling driver look for uart and uart8250_core is registered and 4 =
fake uart
> > are there but there are not still replaced by platform driver that can
> > come later.
> > The try_polling find it but it's the isa-8250 driver. It means that
> > add_uart 8250 is
> > not still happen
>
> The 8250 driver is always a maze, so you might need to do a bunch of
> digging. ...but it sure sounds like the console shouldn't be
> registered until the correct ops are in place. That either means
> getting the ops put in place earlier or deferring when the console is
> registered...
>

Your point is pretty clear and my initial idea was to find a real fix.
This come to avoid
breaking existing setup but anyway I will dig in it more

Michael

> -Doug



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

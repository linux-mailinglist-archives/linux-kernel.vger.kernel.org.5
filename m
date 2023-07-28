Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7B766937
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjG1JrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjG1JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:47:07 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44B2686
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:47:06 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56344354e2cso1316545eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690537625; x=1691142425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fQn/nkax78K0WoMWcF3QZWltL5QVXeLOWL6w4xEHaY=;
        b=AC6U0OizSAXw7OQjTsMZUreuJ7KP5FMUsobCOmdiamMmQLocwwlshCfqlrPnNfPdxX
         n1f+7KtTIAQgGKKPKPz+sYPudc9ygaqX7cmjdD1vvSMybNlQlGTDl7eum+Z38DM/2UOe
         wqLaR1oS9KDsJeTICOo+ojIl45BwgYaBRueYRhF7jOCKsS9dJb1h6oJYP+PaNQiPDk+D
         R/D7IEDV5q77SPIY8mfDZrl06HeKv8tAD6xYgt9Smqou3bwO0FHE/+/E9vi9IJQWiYbt
         kZX0PirRujtHk8aVce3QI2CAlbOwJRPaDLnWVmpiD7Ihc/DUwIU+OTHpY0WDlB2xMSRz
         3lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537625; x=1691142425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fQn/nkax78K0WoMWcF3QZWltL5QVXeLOWL6w4xEHaY=;
        b=ImNegX8nRMa//Y/HoJ8B9NfHCYQU1YrxsyRNyqnZja/pRPsQsAJX1nKzTHSwFlQ7vZ
         EINLcozlu4yjjT3gh6wAnsWO/ZonyxkU45FItYbIyshYKz+c1LNgk4h46Kdj1xMfZ1rH
         8qP3v6Cnw5TxAniJKAozT5D500kDHoAaGyQFB2V/jf8JxbSslGZ8nAN6kQFEZdAu70bq
         B2hZvlHjyBM6YgdDjjWaByfb2IZgxltG2t0KdkeBtCgEkHprfo1tr5TZmJYOT6A2WMJv
         ZAzFpJF4RtXjc+fuYbEX+OC+gp/O5FwOBXwArUPIDt9b5B9jIIyUxPEn4eG3hSzh2haW
         ojGg==
X-Gm-Message-State: ABy/qLbzF0KKkh5Hi7RTpdG9Ru0eFBXmgsGUX/vBkVu1phxsXnPVj4br
        J3oHgH/SoNIzYXDM06lq1pJ6jZ604YZORP32Mpt72ZZD/vo=
X-Google-Smtp-Source: APBJJlE3AudWhrlLQbXJxrKRnc8MJuJ5fBi9b7N0eP6XhYIVsqtpDA7ZWwrSHXcHA6972AEZgtA9zVDqCGbsgdJm+tU=
X-Received: by 2002:a4a:6519:0:b0:566:ed69:422d with SMTP id
 y25-20020a4a6519000000b00566ed69422dmr1746130ooc.7.1690537625341; Fri, 28 Jul
 2023 02:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me> <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
 <79619e92b70fdb4b324758ddb34f84b3b8963256.camel@maquefel.me>
In-Reply-To: <79619e92b70fdb4b324758ddb34f84b3b8963256.camel@maquefel.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jul 2023 12:46:28 +0300
Message-ID: <CAHp75VdSaxzU_7A7b=Htph29XA=ZbqUPJ6RJu+HtrSA2EbcXig@mail.gmail.com>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:28=E2=80=AFPM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
>
> Hello Andy!
>
> On Fri, 2023-07-21 at 17:13 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 20, 2023 at 02:29:07PM +0300, Nikita Shubin via B4 Relay
> > wrote:
> > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > > +       spin_lock_irqsave(&ep93xx_swlock, flags);
> > > +
> > > +       regmap_read(map, EP93XX_SYSCON_DEVCFG, &val);
> > > +       val &=3D ~clear_bits;
> > > +       val |=3D set_bits;
> > > +       regmap_write(map, EP93XX_SYSCON_SWLOCK,
> > > EP93XX_SWLOCK_MAGICK);
> > > +       regmap_write(map, EP93XX_SYSCON_DEVCFG, val);
> >
> > Is this sequence a must?
> > I.o.w. can you first supply magic and then update devcfg?
> >
>
> Unfortunately it is a must to write EP93XX_SYSCON_SWLOCK and only then
> the next write to swlocked registers will succeed.

This doesn't answer my question. Can you first write a magic and then
_update_ the other register (update means RMW op)?


--=20
With Best Regards,
Andy Shevchenko

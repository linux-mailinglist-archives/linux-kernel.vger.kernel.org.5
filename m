Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D537E6BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKIN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjKIN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:59:48 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1130D4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:59:46 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a8ee23f043so10461197b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699538386; x=1700143186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26RX/Gn3lPvFD6lB3x5mc07fH2M7bXA10h8bpCf8H9g=;
        b=K4abNo73qTzQw5+2U6aU5qedvmTpH44KiHVYT4VQ64/oj38kBfnSexiGjoQogdWger
         IwlTns+qK861CH+gxKn7EHkCxe9WW+CkRjjZ8q1MoNs+elsCyVG7YXGX7KJzzVoOKB+a
         gwlKZTo/2QCicd3ZGP0RytEecdgOY2WC5ELXqHg+r+/hBeHezYe+ynhJLc9fdaTc0iHP
         sfJTLKUPEGu3KNVBpws7UHkxtghghuGpmlxThZ++sErGXVBUsRJPehaTX7QwbB5cz8kH
         jf6YM0ZaK+14anLjkvlxQfvN0pQ8cFxZa5H/1DzGH28xdvygWk+RM07d1zTZEXEHdlB8
         EIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538386; x=1700143186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26RX/Gn3lPvFD6lB3x5mc07fH2M7bXA10h8bpCf8H9g=;
        b=B32W6TfJu4dgsevIzc3XiiDB1tCIHzXdfnSIIvJybi3E1fSmaEMJcZ2Yq7qQfSWNzq
         Wxyo2FB0tr9vQf2yZbx0ZutJZgPKoEkiqwwQXIyLuzbRL4Z9HWR4GgHG1S9jFhoicmWc
         XMFA0Sv89B+Wu0xODEKU6lwJetFU2ZHAcZ1r9sxOJf+Q+2Hu+zPVYVdb+YLpmmEgWGSw
         7bx8tdmj2RQBUCaTBHz1jG3dBUt6FWkUYJjYSlJ9SFbSFEKZ0v5ezl8rooNv5hnZiuPf
         KSmHFS8fQS/nJnAQrbx6q74QMNohFy4pgYcVzjDx0qpVnsYxdBqROokqGm0b29W5Fw1m
         H0+Q==
X-Gm-Message-State: AOJu0Yx73jJyOOTnUFW2XqPmVZHeRW4uhHdmrBNmn5y2lDX3DT/1tB48
        RMOw8tA3ElhkFMH2/pb9xtjjZxB9rsPvBIf4p20=
X-Google-Smtp-Source: AGHT+IGuKJ0r2icDGDgc44jaP3XgrjSwIEJmzX1gY6ajp7z8zQxHTORtb0BVo4vnAudTaqv6y58q/3TPc8TXuFnOASI=
X-Received: by 2002:a81:a0ce:0:b0:59f:687c:fb36 with SMTP id
 x197-20020a81a0ce000000b0059f687cfb36mr4951972ywg.45.1699538385791; Thu, 09
 Nov 2023 05:59:45 -0800 (PST)
MIME-Version: 1.0
References: <202311051347.7J6bthD7-lkp@intel.com> <CAHp75VfmUXgx3nkFR=dZqffOu-LSnU_9u9GRYy0bTPLcdYhHbg@mail.gmail.com>
 <ZUdFtJeXBtx/httL@rli9-mobl> <abdb00c4-c2f1-96e6-9731-5a1773099336@axentia.se>
 <CAHp75VeBgdSYE6=2q6kc+N6JDg_fy1Mc5DUJdJBmyZ8nnX8ywQ@mail.gmail.com> <c67a4871-a158-b7d0-42c5-cd8f31584ab4@axentia.se>
In-Reply-To: <c67a4871-a158-b7d0-42c5-cd8f31584ab4@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Nov 2023 15:59:09 +0200
Message-ID: <CAHp75Vepv3YOpPusPM98vxL38rqE0u-ixniKuziRxBjJKT67SA@mail.gmail.com>
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
To:     Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        oe-kbuild-all@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 11:39=E2=80=AFPM Peter Rosin <peda@axentia.se> wrote=
:
> 2023-11-07 at 20:59, Andy Shevchenko wrote:
> > On Mon, Nov 6, 2023 at 11:31=E2=80=AFPM Peter Rosin <peda@axentia.se> w=
rote:

...

> > The use of the of_match_ptr() is quite doubtful, no?
>
> I was trying to answer why the spi-mux addition was (wrongly) fingered as
> the first bad commit. I should have been clearer...
>
> I don't see what's wrong with using of_match_ptr() in this driver as
> CONFIG_OF is not required here. Why isn't the correct fix to instead
> put the definition of adg792a_of_match in an #ifdef CONFIG_OF block?

Because:
- it is prone to error (as evidence this report)
- it adds ugly ifdeffery and more LoCs in the code for no value
- it prevents driver to be used in ACPI

I found at least two of these arguments are serious enough to drop
that macro and not use it _at all_ generally speaking.

--=20
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAD7790E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjHKNjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjHKNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:39:20 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388EE5F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:39:20 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7996fe1c31bso678957241.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691761159; x=1692365959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeHwoCEK+7cj9BX9ReUEG0Ft3p6+TeN8j7iyEVURsIA=;
        b=uvwPWTe6rDvArjJRcc6FTO6B0AMc2VdBeLEZDuYnivc19B3isw+NYz3iLVM85AXT9l
         LEVbGQhp75yU4ahhjPRU4nU4t1KUCvA9FhJAlsho0v3bK29CxMJddD1e70LzXcmito9q
         1igfU70A3C03nBcevc6Iz1BZbWKlSaGzxTUYgSFehLf/vAepYOeDif+gxKUl5EUhXr6R
         oRpXJHgLamcuF7Npq6VgF7sqMDfRlvWL2ZypxRHonXDOycyv+KXBCDO0p7ZGsMhkij4n
         OrfYWwBEvkCGvFL3v/xTqjNyvJ8R5r+w3eNoY5uLvC6n83oQqFz9E5RPIdSoNa1x4FXa
         wZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691761159; x=1692365959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeHwoCEK+7cj9BX9ReUEG0Ft3p6+TeN8j7iyEVURsIA=;
        b=UFXgnxuiqr8iqFAnEsmkzPqVcrRsUVa71Fp+rQ/usxLEuwNXKlZ1s7aDIZuf1QGi75
         7EDbfrAlE0rVLbvriAwbsi382ZEsqk6VgHKxfHP5WVWJqSM/PzHWi7MeHMqiv8h7nPLx
         ZLsBQ962hag7vZ35XToAugNdYYnNPKTO2xNnkU72rrgxM+TMLoJvbRINn9PFK76ft4h1
         cmuDT6McbdAunJtwNc/RnfpgMjWYeipS64JMhHtQU/XxlSV0+aZdj3huLm65ls4K6hYg
         FwenDP7xhgqmvkZE/nQUznOpao1LE5Ryz3eQbH3aftzUzg7XD/Cmi8uCcfZrrJz5UMVw
         TjVw==
X-Gm-Message-State: AOJu0YwK5L7RFawPQhRqF12uirOKU2G/d14ITSKA3ult1302aHqZZizg
        +rKLU2BEXwvwVj6/AMwg0kDcaAAgwpvE1yTHE9xdaw==
X-Google-Smtp-Source: AGHT+IHeYwjB/KVsYSmrgMm68nduVLnMEL03nti3iUJJKxE4rBDzIfvW20wVlZN7VWG4Bh7NPzh2wuAa4QTakWf5z5A=
X-Received: by 2002:a67:ebd7:0:b0:447:ba64:7e40 with SMTP id
 y23-20020a67ebd7000000b00447ba647e40mr1704901vso.8.1691761159204; Fri, 11 Aug
 2023 06:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230808145605.16908-1-brgl@bgdev.pl> <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
 <CAMRc=Mf_BmhZLN1J2m4SnpmPJzZtYPcfdR54EfG9gR5Px_Ss-Q@mail.gmail.com> <ZNT546dM+7QX98pA@smile.fi.intel.com>
In-Reply-To: <ZNT546dM+7QX98pA@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 15:39:08 +0200
Message-ID: <CAMRc=MfzXbuJb1hYe57MeMXkNaXPg8_Ei0Y=JURyCCoXBffhtg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: consumer: new virtual driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

>
> > > This can be avoided by
> > >
> > >         key =3D kstrndup(skip_spaces(page), count, GFP_KERNEL);
> > >
> > > no?
> > >
> >
> > No, because we also want to remove the trailing spaces and newlines.
> > But if you have a different suggestion with existing helpers, let me
> > know. I didn't find any.
>
> kstrto*() are newline friendly. The rest as you noted can be covered with
> sysfs_streq() / sysfs_match_string().

It's a kstrndup() not a kstrtosomething(). It's not newline friendly.

Bart

[snip]

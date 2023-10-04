Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D27B803E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbjJDNKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:10:14 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584398;
        Wed,  4 Oct 2023 06:10:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65b0e623189so11624776d6.1;
        Wed, 04 Oct 2023 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425008; x=1697029808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asdaHQCAKRIWEz9CnctgMv3GKP9kjq8BnTwyAVU+fio=;
        b=Qa11NW/54TOKnk0Jb4tSizHMf7aNNA0o0PuMgZ2qrkYMVKuJSUxnIapluJ2oq58uhc
         eps7VunbTpGy8zazQqGu8fHWFGKo5dxBsN4a0GwPvnJ24tq8lw6pUdohurcvetulHtQC
         2owF+0tlw6t1X2Fo6rNpCgn3W/Ud70YvAHQhv53J5rMZcWX5sFCSC7bo/EcoA5+/TOnZ
         x9InXb5s1w8wbRuBmqlQ8qZL7tU0QeQssNndNAmW3+BvnvNCDkzW4acsDw/dKO9Bf3zn
         jIMGQ2ZM0TfCzyw8OOL7PTNN3be5kwxZyJM51XTk9J1KOzFyzjJFxqZDpf9qaq4QGhfT
         Lnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425008; x=1697029808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asdaHQCAKRIWEz9CnctgMv3GKP9kjq8BnTwyAVU+fio=;
        b=bK3hLgwq/jZbmmPENs3/Lxka68YOtvrgqmzAl9dcAoJ8sUadx4NZ1n1YrGRQe5ROSP
         PAsz1m9T5dswJPV1VuQnOF965tTyoOdnknCU03u2Rm8RwE2VqbE/sjX7DwTTTnNQ4eJK
         oy4aKu3LIQ/Ph0SeqGL804eQa5sZONMB0AbQRz9KszdL8ohgwL9b4ghsOXSRWZu7QHGd
         PtyMxqtX8tWJiEkcYnvzkashNOoqnrJoBWRyhqKJI+FEyCG7CLOzPHP4wcgm1omfAn/B
         k43wvLf6qeY1mNY6YmCCbAbpUIntT94h2/M4jFwel6Do0Gj5ZHs4qVSh7LsV8dPN2jab
         uQxg==
X-Gm-Message-State: AOJu0YzpjXuUQJNjtdAYRytE6dT6gtCyROllHOYniJs4GLK0wWGZ2f8p
        rPqKrU27YCYiGVxYjHVHK6d+oy+cuPrp0Dkf87eV6OFciYc=
X-Google-Smtp-Source: AGHT+IFMgcbtnGHOGQEnTV0fNuWMb2syIVJ41wSGPv8NVZe/+CZBISZ9FUJKCjvlImsjAVhn8IdBiSZ3INKYtXwMX78=
X-Received: by 2002:a05:6214:3381:b0:647:23b8:dac2 with SMTP id
 mv1-20020a056214338100b0064723b8dac2mr2261508qvb.58.1696425008344; Wed, 04
 Oct 2023 06:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com> <76d1e643-9b81-4c23-8f46-73fe59913600@kernel.org>
In-Reply-To: <76d1e643-9b81-4c23-8f46-73fe59913600@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Oct 2023 16:09:31 +0300
Message-ID: <CAHp75VdKF+QfSsUwVSrSEng_xY_2ZW_0t0kBuXYPPcBi3_6LxQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
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

On Wed, Oct 4, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 26/09/2023 21:08, Andy Shevchenko wrote:

...

> > +MODULE_ALIAS("platform:denverton-pinctrl");
>
> Why do you need the alias? It's the same as ID table. You most likely
> miss MODULE_DEVICE_TABLE() or your table is just wrong.

This is cargo cult from pinctrl-broxton.c. If we want to fix, we need
to fix both.
Care to send patches?

--=20
With Best Regards,
Andy Shevchenko

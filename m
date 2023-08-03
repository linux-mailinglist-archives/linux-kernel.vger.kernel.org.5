Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630E76F468
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHCVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:05:07 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE962D43;
        Thu,  3 Aug 2023 14:05:06 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56d2fe54863so726716eaf.0;
        Thu, 03 Aug 2023 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691096705; x=1691701505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iykb0ohtHUOxu1qS/h80/ncUZA75kT5+rr0gHB5Pw8=;
        b=bwIgCDVI7omgikbK2l7nU0xAW3OrLEslLM5tuHHsY/EsPY9eghaMPV3ZGjo9uUhbxN
         Mg3DDSXTrUvQStc4tDr3unTcJOGYDglijWZrLog5+cBPLIZ+D4QPSHAA6JsVcD9stqyQ
         lVGV4M5392N/TU9M/IGmkjTkuZE0hBXc12VE0d7Od1TjTPD8Th9rSJGBdDVsol6/kXpm
         31JWHY2joKtZhI/4ubmYU4+9hHPCdBn15t+Q+wmxMWRwfkLTglNb3htRJfE9QspTsUbK
         IxEk2RHTx6Gq5RdEmzVV99TSIY5QiqLdTTHRAzU8SwCxq8zjs26ORryAQ7cTnR1gR2c8
         hgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096705; x=1691701505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iykb0ohtHUOxu1qS/h80/ncUZA75kT5+rr0gHB5Pw8=;
        b=LMi4vhRKJQI60OV9BNQ+lkEDgAKk9d8BiILn6CIqDwt+YZ9CnCkTLQmaO65EV8wz/d
         hOkcSV1kzONqpTNSY4iSlUceFdHv5pP8UCbelfg4o7gxKSTssY5G2xhbYWeH2QA0MY/u
         HSA5762qYR8nG4Dsq9GILt1gdStZDqbdHvgZrweoM59TlUUj7bwRyQcOLM49d7p2Xls4
         Wve82ORUNpxgFvbTs/+pjnwaWR19iOF0lsGTAV9zOggJEUIi/JBgiru+aiAuqmAWqub4
         2cYcrzKqlcMJauHbtaeoE+UYS/IGAC3PIfhlhRlcaTtfvnthdyuRTVgNq8WRNN2mTSOX
         ML4g==
X-Gm-Message-State: ABy/qLb03MQS38FWwGqKwvuSGDco1c2v0zh3XFlvHcgLNxxM2rnk08m0
        Ncs0SfphnAfbafj2gx2DFUuYcgVkxIF8sPEe/zQ=
X-Google-Smtp-Source: APBJJlHWF19YdNlEw5neOPDLx2yKP0yQjc7UvVqD4DCZsuyVxs5cSaPp/BS7yKVMpY9D51X1ChhRRTjrKlyCkihMJaw=
X-Received: by 2002:a4a:928f:0:b0:564:e465:5d5c with SMTP id
 i15-20020a4a928f000000b00564e4655d5cmr14966931ooh.2.1691096705538; Thu, 03
 Aug 2023 14:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230725142343.1724130-1-hugo@hugovil.com> <20230725142343.1724130-7-hugo@hugovil.com>
 <2023073105-elevation-canister-2777@gregkh> <20230803101814.39a61229d81dcd3e96cbe8ee@hugovil.com>
In-Reply-To: <20230803101814.39a61229d81dcd3e96cbe8ee@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Aug 2023 00:04:29 +0300
Message-ID: <CAHp75VdCqqZfQXRRWUkbDTf_gd3T60Stp+m59Q34iWxddLiG5g@mail.gmail.com>
Subject: Re: [PATCH v9 06/10] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:18=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Mon, 31 Jul 2023 17:58:41 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jul 25, 2023 at 10:23:38AM -0400, Hugo Villeneuve wrote:

...

> > > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control li=
nes")
> > > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > Cc: <stable@vger.kernel.org> # 6.1.x: 95982fad dt-bindings: sc16is7xx=
: Add property to change GPIO function
> > > Cc: <stable@vger.kernel.org> # 6.1.x: 1584d572 serial: sc16is7xx: ref=
actor GPIO controller registration
> > > Cc: <stable@vger.kernel.org> # 6.1.x: ac2caa5a serial: sc16is7xx: rem=
ove obsolete out_thread label
> > > Cc: <stable@vger.kernel.org> # 6.1.x: d90961ad serial: sc16is7xx: mar=
k IOCONTROL register as volatile
> > > Cc: <stable@vger.kernel.org> # 6.1.x: 6dae3bad serial: sc16is7xx: fix=
 broken port 0 uart init
> >
> > Where are these git commit ids from?  I don't see them in Linus's tree,
> > how are they supposed to be picked up by the stable developers if they
> > are not valid ones?
> >
> > confused,

...

> I wrongly assumed that, for example, this patch had, as a prerequisite,
> all the patches before it in this series, and that is why I listed
> them.

The problem, as I understand it, is not that you listed them (how else
will the backporter know that this patch requires something else?) but
the format (you used wrong SHA-1 sums).

...

> So I will remove them all, since this patch doesn't have any other
> requisites other than the previous patches in this series.
>
> Maybe it would be good to add some notes about that in
> stable-kernel-rules.rst?

This probably is a good idea. Briefly looking at it I see no examples
like yours there.

--=20
With Best Regards,
Andy Shevchenko

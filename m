Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E387DF54F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjKBOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKBOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:52:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0A11B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:52:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7af52ee31so12278847b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698936749; x=1699541549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbLEZ3Dvy6vK8c71cfbvowkvFzjH6f30mEWwF7xpWnk=;
        b=IAPghaxPakTkeRKc0a8hHSHGrdyQTBCC1HXsGMy1RpMmyKowY1RdWXhSoW1Q2gHP6b
         Li/4kVvbg93bsUkSvp5EbSYKb9JdLUUd6pnRWY8EVdSRsS2JztFt8rF2M5SvJxHJRHPY
         +BLuuxgMq7zdikCJGs9lL1utzZg0slPx/IZn8UvxxJD29RXztci9P8TrEaUrU66/hMMb
         0h3q2mqhZ44RfZlLht292+1q2yR6PAvxvXKar5EJu65elARv3xWals5w1oktg8ZVspiD
         kFPiPQs832ri9ROO/2Vk7CtrIvV7eSeXROwCggzGWxDbOvCmbW8rvZrdMyZjRIUIEmXT
         xW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936749; x=1699541549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbLEZ3Dvy6vK8c71cfbvowkvFzjH6f30mEWwF7xpWnk=;
        b=WxdrK7bt9DuFeSIWcoLbZ9b4RSWjKBqyhf8m5quOkFd5OSEQ+x+qlF+tWQQKLx065i
         655tulw/eDSC8VKhBYpv7mYDsEvZ/Ugmc54fIgyPgrRpvnUxa0BeOuTzBdo7MqY3Bo13
         2XFxNTVmrojr3VskRgGV1tSLMXNNruB3wm5r9A/etuIO0BQD6Bihp+gMM2tJ28IyDYfi
         TCLGBY5AODoqiTdM2GgwNnIqJOCWjyvN3EaV/BMrsBTTxE7Ynz2P3sTmiN4Xuzm7sCsS
         ofX1GpKy0fryek6aI/DroLTmlNf0BBvlEsEg3QpM4bqF+qEhQFfjHyhSQUMpG9BriSMc
         0V4w==
X-Gm-Message-State: AOJu0YwZix9ncBawPLN2RcNKu7YCgkTScQDa4WiJ8RRpREhefka/G04y
        LkmLTW89YdMIkMyXZLKeH6BMjzvaYqk/Kf1oP9LLAA==
X-Google-Smtp-Source: AGHT+IEl7ofcy4D9X68NHHw7pUhvn8bxhJkochTuFAuTvhqv2XrX3jJ6UIKbAvIYl66RsjKik0g1glAWSst4hBH0Cf4=
X-Received: by 2002:a05:690c:ecd:b0:5b3:f5f8:c5bf with SMTP id
 cs13-20020a05690c0ecd00b005b3f5f8c5bfmr6756787ywb.9.1698936748715; Thu, 02
 Nov 2023 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231101025802.3744-1-tychang@realtek.com> <20231101025802.3744-2-tychang@realtek.com>
 <CACRpkdZiKCiVsmkPnJRW1c5SBfzNmBqCH9bS8XsgUszD6H=vPg@mail.gmail.com> <12ada22542cf4b2991da2e8c2858c5d7@realtek.com>
In-Reply-To: <12ada22542cf4b2991da2e8c2858c5d7@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 15:52:16 +0100
Message-ID: <CACRpkdYcK+sr5Ohh5su1cYv8R6BtKSxUUS-rAZP_iWmXbkL-Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
To:     =?UTF-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:40=E2=80=AFPM TY_Chang[=E5=BC=B5=E5=AD=90=E9=80=B8=
] <tychang@realtek.com> wrote:

> >On Wed, Nov 1, 2023 at 3:58=E2=80=AFAM Tzuyi Chang <tychang@realtek.com>=
 wrote:
> >> +static unsigned int rtd_gpio_deb_offset(struct rtd_gpio *data,
> >> +unsigned int offset) {
> >> +       return data->info->deb_offset[offset / 8]; }
> >
> >So this is clearly counted by the GPIO number offset and the GPIO number
> >determines how far into the array we can index.
> >
> >It looks a bit dangerous, it it possible to encode the array lengths bet=
ter?
>
> I think I can add array size members for each offset array within the
> rtd_gpio_info structure and utilize them to prevent accessing elements ou=
tside the array.

I don't know about that for constant arrays, if you look at recent commits
from Kees Cook you will find examples of how to use the compiler helpers
for dynamic arrays, e.g.

git log -p --author=3DKees

will find you things like this:

@@ -60,7 +60,7 @@ struct reset_control {
 struct reset_control_array {
        struct reset_control base;
        unsigned int num_rstcs;
-       struct reset_control *rstc[];
+       struct reset_control *rstc[] __counted_by(num_rstcs);
 };

So the compiler instruction __counted_by() is used pointing back to
the variable above to avoid outofbounds accesses.

BUT: those are *dynamic* arrays, placed *last* in the struct.

You have several *constant* arrays, in the same struct (and
C allows this).

I don't really know what is the best practice for constants, maybe Kees
has some pointers?

Maybe what you have is the best we can do.

Yours,
Linus Walleij

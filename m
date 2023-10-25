Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51347D7272
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjJYRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:37:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC9137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:37:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so9377013a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698255447; x=1698860247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl2dU+9nKTty0GF9smAcA+fSgOnuLvaP8a1ykaCWH2s=;
        b=RsURUyBR1U2/DG3GDqrlDTdQT1YYI0mA9M7+elplEivButN+59scNF4aNWwAaQsahp
         yk2sQFAcYGsLds/wnal8037gPaXFHvx25WyW0jjvak15a3yYUPZ5OA/oKevs9U+7bFyJ
         3di9bL0V+bM+i3Fvl3GOYbjh9GsUzDlnWbgIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255447; x=1698860247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl2dU+9nKTty0GF9smAcA+fSgOnuLvaP8a1ykaCWH2s=;
        b=Ncaa2hb0FHmx72XsB+W5o7u3pwk3k5pvc7/T5ybLmNTx2W5KOMu80DbQh7xgrDZevl
         dURz6Mu3q7SiLExpZL7Bn/B5GoqOcQUSzh4t3Spe0QxwGGW50U2xLI7QEhlWpnywsVSL
         uObXjb0Ee2u8t7bdac2JpfKIxbROxkdtp5g8abb0d3i6x4rRKaEkicEjPhb4f5yfEBn+
         c0thQZwRwc22owhWSmlMaPjZdpMKB65Z+rP0Lv5CqV4BSzZD5OekR4IvxEOHQ97LY/ZH
         j1qkqsVxv7w48fSDQal/foVXWkeTTIQevdlwBbb/zYnHItwFcST+cmS9g6nXgzgNoAUn
         KxHA==
X-Gm-Message-State: AOJu0Yx4vrUspDWWCIPTlxkHp0+CniLnM0vnoyqdtmubnFGRUmiDIh+S
        I4VNw/gFPb8Orv0awnMrxbZzKyhWXxjRJWwKmVH/pw==
X-Google-Smtp-Source: AGHT+IHMdooQ3RBIavzdHoptLpqPvI1P7b7j0nNdBaHPPuKkBftWHOM56fpPj60UiwbLGEfyewtirw==
X-Received: by 2002:a17:907:5cb:b0:9ae:4eb9:e09b with SMTP id wg11-20020a17090705cb00b009ae4eb9e09bmr13550599ejb.27.1698255447501;
        Wed, 25 Oct 2023 10:37:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060e4600b009b28ad521f4sm10162754eji.4.2023.10.25.10.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 10:37:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so5919666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:37:26 -0700 (PDT)
X-Received: by 2002:a17:906:c155:b0:9be:3c7e:7f38 with SMTP id
 dp21-20020a170906c15500b009be3c7e7f38mr12949467ejc.10.1698255446403; Wed, 25
 Oct 2023 10:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com> <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com> <7ba90240-33ba-4e08-af38-3ec2d40c3837@rasmusvillemoes.dk>
In-Reply-To: <7ba90240-33ba-4e08-af38-3ec2d40c3837@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Oct 2023 07:37:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wieb+dUFet+pNqB7MTy88iYQU3KtTK9V0JHnxwwKoMGpQ@mail.gmail.com>
Message-ID: <CAHk-=wieb+dUFet+pNqB7MTy88iYQU3KtTK9V0JHnxwwKoMGpQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 22:03, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> Both the existing and new implementation are simply wrong for negative
> n, because / doesn't do floor(), it does round-towards-0 (I do believe
> that's a bug in the C standard, but not much one can do about that).

Honestly, while I found several cases where the arithmetic was done
with a signed type, all the ones I looked at were purely about the
_type_, not the values.

Any actual negative values would have been too random before to make a
difference. In that patch, I tried to keep the signed type around
mainly to at least get *similar* values to the old code, but honestly,
it was all broken before already if the values were actually signed.

If it were to change the result and somebody would find a bug due to
that, that would be a good thing, in other words. The negative value
would need to be fixed anyway - as you say, integer division of signed
values is simply not rgeat in the first place.

Side note: if you dislike the "round towards zero" behavior, I can
tell you that it is better than the historical alternative, which was
"implementation defined".

IIRC, the rule used to be that signed division could either round down
or towards zero, and the only rule was that (a) it had to be
documented (ie "implementation defined" rather than "undefined") and
(b) the modulus had to follow the same rules, ie regardless of
rounding, you'd have

  (a/b)*b + a%b = a

That said:

> Preventing signed types from being used is probably too difficult.

It might not be. My horror with _Generic() is certainly not pretty,
but it *does* have the advantage that we could error out for signed
cases.

I did that initially, and it didn't look horrific, particularly if you
just accept signed positive constants as unsigned values (which
requires another bit of macro magic but is not conceptually hard).

The patch I sent out was not it, though - it was meant really as a
minimal "something like this" that still compiled my defconfig.

> Aside: I don't think uapi/ stuff can include non-uapi/ stuff.

Yeah, no, I left it in that uapi header just for the same reason I
didn't bother trying to fix any signed type cases - actively avoiding
changes *outside* the DIV_ROUND_UP() case itself.

In reality, I'd just make any users of __KERNEL_DIV_ROUND_UP include
<linux/div_round_up.h> and get rid of the crazy UAPI thing entirely.

So ignore that part.

> Aside2: do_div(n-1, d); probably doesn't compile :)

.. I did say it was untested and "might approach being correct".

That 32-bit ULL case should also have some attempt at checking that
the divisor really fits in 32 bits. Because I still refuse to believe
that the full 64-by-64 divisions are sane on a 32-bit machine, and
anybody who does that needs to go to extra lengths for them. No
"silently do them without telling the programmer they are doing
something horrendously bad".

                Linus

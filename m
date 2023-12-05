Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC12806114
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjLEVvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:51:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33F1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:51:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3333074512bso63080f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701813081; x=1702417881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWvJtgJjO5YUTGvzn9ntJuWrPBTqvXSdfxI0wQvK8zk=;
        b=4dC/J/EEUIFyO+S78o1CgIIqdN23rNQZmJfDXpqcAmevHvxjIN00i5dnwAKZCUfrf5
         bkjZCo50G8XVubwjmiSpR0vz6OxnrOLjdFN6XDMAXNhkgKi1VQTSgb8kL6DIf2QDETv7
         TEoNBqA6LObrJLfjZHzT24yPd2/ixKWwN1de1hVCryHUF/UE0Uv0oAtsCw2qxYkBf83B
         i64G/zqrjCTY0CNipb91VTP/e7NpvTtIdr0/lsMuSF4f6yBtJFc8g2EkPo3zi7GIO5YS
         9z22On/fgtz+LH5tT0X+bZQ9nekQBb2U7xkCTSakVErQRixhCs7ahVj8P0hGVNVmFsso
         95rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813081; x=1702417881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWvJtgJjO5YUTGvzn9ntJuWrPBTqvXSdfxI0wQvK8zk=;
        b=h4gB8+FasToNC6VVQhbh6oejynTtnjz90UawFkE0Zvqlj3CP11IgVZBPFsG9BF2pW3
         yOTi/l6LjO+23SLCR9WYKAjTFDbsIOUK1QyfRERsfyR0ECJ7vAHl6+Yx2MHQB2qsrzAk
         RjpKODHKRTrxqyCgX4y7bNbYCkkf8SxZh8ELgnbxXTpBfnUc8+fOS6Sca7TUKcdrI0vo
         GrD10s8WmLhSU/l+xnWYBiZg2WLXssN+oVSMKgi8Nm8jQh8CAx48zCxV1cIzjxEL9W/C
         85pt2alanHROD4jJg9Sd3UXWXY0XZNNBTld+huHz0/Xssw+uW8XB0t3+iIqivyKCnRCH
         76RQ==
X-Gm-Message-State: AOJu0YwzFGrAh7Hi6fYulIWXCQrQ0o/xko/JM0mArGcWmnmdEUjdVWNx
        u0lvudDMtENdK+bEsBRErKywt8hnbRCbkgTtIIg5BQ==
X-Google-Smtp-Source: AGHT+IGs2UEndv3/f7mB6cvBQmur2hbqR/xMSSml4pPkgEk/wNGLd9ptXPWGBBWLtc4XXc4eOOjkqQQUO/3CMlLuBE4=
X-Received: by 2002:a05:600c:1c01:b0:407:4126:f71c with SMTP id
 j1-20020a05600c1c0100b004074126f71cmr975537wms.6.1701813081506; Tue, 05 Dec
 2023 13:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com> <20231205213807.GE1674809@ZenIV>
In-Reply-To: <20231205213807.GE1674809@ZenIV>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 13:51:10 -0800
Message-ID: <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> > This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
> > the include list changing indirect includes to direct includes.
>
> How does it account for arch- and config-dependent indirect includes?
>
> In particular, on sh this patch breaks, since there word-at-a-time.h does=
 not
> contain an include of kernel.h, even though it uses REPEAT_BYTE.  This is
> a very simple case (they really ought to include kernel.h, same as all ot=
her
> instances of word-at-a-time.h), but I would expect arseloads of more subt=
le
> breakage in anything less trivial.
>
> And I'm not at all sure that there's no config-dependent breakage as well=
 -
> this had been caught by quick make allmodconfig + make lib/string.o on
> a bunch of architectures; the graph of indirects includes (as well as the
> set of symbols needed for given header) is very much config-dependent.

We're sending these to Kees to stage in branch flowing into linux-next
in order for the patches to get soak time in linux-next; it's not
possible to test every possible randconfig, but with enough soak time
and the bots chewing on linux-next, I think we can get to a certain
level of confidence.

We'll ramp up the amount of testing we're doing locally as well. (I
did quite a few randconfigs locally in a loop; didn't test all
architectures) We can probably fetch the kernel.org toolchains for
very extensive testing.
https://mirrors.edge.kernel.org/pub/tools/crosstool/

>
> > IWYU is implemented using the IWYUScripts github repository which is a =
tool that is
> > currently undergoing development. These changes seek to improve build t=
imes.
> >
> > This change to lib/string.c resulted in a preprocessed size of
> > lib/string.i from 26371 lines to 5232 lines (-80%).
>
> It also breeds includes of asm/*.h, by the look of the output, which is
> not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> outside of linux/uaccess.h is a bad idea.

It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
convention here that I'm missing?

>
> > If there are any problems with the output of the tool please raise an
> > issue on the github.
>
> Sorry, no.  Your tool, your workflow, of course, but I don't do github is=
sues.
> You are welcome to the contents of this reply, but I'm not using browser-=
based
> UI without very strong reasons; this one isn't.

No problem; Tanzir, please drop that part of the commit message in
future patches.
--=20
Thanks,
~Nick Desaulniers

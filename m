Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F07B2A40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjI2CII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjI2CIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:08:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B719F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:08:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b275afb6abso37170866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695953280; x=1696558080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpJvrW7U3xIffjqcwESsvsx+jvDlYI20BWsEDJIfKsE=;
        b=2mEH4vX2MW9Muivxe5HnYD0D9xKlG7iFWifZZmlmkg61RvoSAI7p1LzGG0z0NZbX59
         GhSigpX7EF2e6wrKBQBONwQtNBGW4a4IA5we4eeGeOI+bCcqEvOYbjOHChN8pSKOd2NJ
         OQbUWVE810bKYvKkUoQQw8Xb1Dfy1r125Z2BfZbzDi/Yqvrra4Xjx1LPqvVxTHl6xaNE
         2AAud50EfMp5Zaxq0ytKKqvL5oD9cOac1015NGFIGDwlz6XXN9FiVnhDOKvsD9bpgjFi
         WAhP/yFPdcrL/+1yFMiqTtBPZWjIyt1mCSl6tL88ZOz1cNtWWoBOBihys4V/31JrytO1
         YYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695953280; x=1696558080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpJvrW7U3xIffjqcwESsvsx+jvDlYI20BWsEDJIfKsE=;
        b=IAVObkAwENeVbRDUC5DWFxc2ya1jnOBICHdqHQLd9OnBAFZEIJB5dOCphTxP3aq3zG
         k9ZksCMqfe120wCEnSl2xGV4dLf2epN4T+byvZEwugt4o4SitYrqwPb+EfC2zT6ZejQq
         a65DOAnZdm+c2426vKkjyBwC2SB20CbnTi4TEu6T3UDv7sgHJHH6Bxo+bmTTCaYNikRI
         1X+YxjKOmLiFWjgf6Ugg3SjewUejnPs/tiEPml4biaadrLig7ygFJU3mRQJs1x1snraH
         0P098qxGIhZ6AdQJrPiW5MB44W64tozq7IQHxJPbpLAqcg9bEQ31bvw4nnIya3ua3w3v
         chow==
X-Gm-Message-State: AOJu0Yw1r1MouOrJEyT6x22RVm913/TdO9mmDpjIeTQLFdlcVSl1rvOr
        4ekAEB7atkdHU7nwS7pxoIBFSOOB8y6aY6siaIcBBg==
X-Google-Smtp-Source: AGHT+IFyoQ45G0/xSiJVIsjcy4eWKEwZ/2vhbS/D95tXQxzUqaJAJuRIh3RZM++LVJ05Ro/8eSB9olgdUNOmkr0SiWg=
X-Received: by 2002:a17:906:c146:b0:9a5:dc2b:6a5 with SMTP id
 dp6-20020a170906c14600b009a5dc2b06a5mr2604319ejc.35.1695953280532; Thu, 28
 Sep 2023 19:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
 <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
 <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com>
 <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com> <CAKwvOdnGzTvSXf7VeyG8tPEONpqSgkDiBTmgJbUUWsRHzbc5JQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnGzTvSXf7VeyG8tPEONpqSgkDiBTmgJbUUWsRHzbc5JQ@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 29 Sep 2023 11:07:48 +0900
Message-ID: <CAFhGd8rrHp1V4NpExpdNwWV4FAdLYhixLMB5HGygNSe7NKPUMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:52=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 11:09=E2=80=AFPM Joe Perches <joe@perches.com> wr=
ote:
> >
> > On Thu, 2023-09-28 at 14:31 +0900, Justin Stitt wrote:
> > > On Thu, Sep 28, 2023 at 2:01=E2=80=AFPM Joe Perches <joe@perches.com>=
 wrote:
> > > >
> > > > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > > > Changes in v2:
> > > > > - remove formatting pass (thanks Joe) (but seriously the formatti=
ng is
> > > > >   bad, is there opportunity to get a formatting pass in here at s=
ome
> > > > >   point?)
> > > >
> > > > Why?  What is it that makes you believe the formatting is bad?
> > > >
> > >
> > > Investigating further, it looked especially bad in my editor. There i=
s
> > > a mixture of
> > > tabs and spaces and my vim tabstop is set to 4 for pl files. Setting =
this to
> > > 8 is a whole lot better. But I still see some weird spacing
> > >
> >
> > Yes, it's a bit odd indentation.
> > It's emacs default perl format.
> > 4 space indent with 8 space tabs, maximal tab fill.
> >
>
> Oh! What?! That's the most surprising convention I've ever heard of
> (after the GNU C coding style).  Yet another thing to hold against
> perl I guess. :P
>
> I have my editor setup to highlight tabs vs spaces via visual cues, so
> that I don't mess up kernel coding style. (`git clang-format HEAD~`
> after a commit helps).  scripts/get_maintainer.pl has some serious
> inconsistencies to the point where I'm not sure what it should or was
> meant to be.  Now that you mention it, I see it, and it does seem
> consistent in that regard.
>
> Justin, is your formatter configurable to match that convention?
> Maybe it's still useful, as long as you configure it to stick to the
> pre-existing convention.

Negative, all the perl formatters I've tried will convert everything to spa=
ces.
The best I've seen is perltidy.

https://gist.github.com/JustinStitt/347385921c80a5212c2672075aa769b6

> --
> Thanks,
> ~Nick Desaulniers

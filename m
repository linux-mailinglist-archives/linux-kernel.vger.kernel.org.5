Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949817D003E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjJSRJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345115AbjJSRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:09:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CA12F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507c91582fdso2770460e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697735381; x=1698340181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIvaN4YFhkdJAaPBtj6YT8VODQjHAC9yTKDU89R4TS4=;
        b=grzDSijhT+PijJbVil8eybW7FPzT10FA0Po/1dpr+0oEcsqU6wnyCqtb561uospDAi
         2s7KMzC2KN90Mii1AP15hseJv+Ih2h6SehAyzFVLaqVl7WuSjBeSpeVcnQpk6d+WEp2f
         dJzvUC15nIHHQ5W6dDvOTHjsLqSWH8rpCzeeR+nbmFC4JcV2P0wdeJnigTwbrdFLj4HZ
         Vl2zEZBLs1WYEmLh1WzAznaNzBnbvtLAKEPvP8tsr9qteHb5pS0tfZpj5Hzq46qEIE5i
         m+EpLwFgqdSJUmMPuUgE5YrUa8ToQGj57HGTXHnKfqqBTFJ6dsi74KlKXd00XbHbW+ZV
         I3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735381; x=1698340181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIvaN4YFhkdJAaPBtj6YT8VODQjHAC9yTKDU89R4TS4=;
        b=pnekqtL45yATHGr4ZPxj3C0Ci8l+diG/bFWa3KXWHW0Jf3AUNI891hsRv1tUrLhEO4
         uXea5Kbrif9x2HyXuXPXHsw3icaSDVngAxif40k6OLSk75i2dsEDUw+baprmOf7586Bc
         s+IgXJT+WiGYnb2uQwGpZ0ZBOQFdR5GYJDkOVAe0d5kfYyYbQIt09Q6BTXhWoGvIIIPR
         mIWK3Tb96xibuuxl4K9nCG8lImERcwp6Eqy4g88o+q9uN+vbZ3tkiDN1gL5xRslvp8ap
         TKNpCArP/vV/MAH9QgE6KSm7pWPDUWGisRk9kRfCmw8tO5H70kbf8AJs4X3+GaUQLIUB
         qYiw==
X-Gm-Message-State: AOJu0YyouKQUZeaY9YtnVOAL5c/0qRyMYXlR7FiODk8b6EWnQTw4txCd
        +AeA2znn2v9dhrNnz98T6pqnGaiVFb/RzSmfVUmjjlN2TC//MS7jphqcJw==
X-Google-Smtp-Source: AGHT+IG4wvqBuNI1Fki3yDr0zNOMRB63Yc5M5IJNrnyKsI5TBC2AR32dFADI0SmnsXMNBbMU19rSjAgu5DcQwH2rhb0=
X-Received: by 2002:a19:4f04:0:b0:503:3447:b704 with SMTP id
 d4-20020a194f04000000b005033447b704mr1889332lfb.0.1697735380817; Thu, 19 Oct
 2023 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
 <ZTCLLinnaqIILXsJ@debian.me> <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
 <202310181929.BCC265C@keescook>
In-Reply-To: <202310181929.BCC265C@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 19 Oct 2023 10:09:28 -0700
Message-ID: <CAFhGd8q2TBO2eshYC2f8U5m-u2_H14efe7LVE5vEuS6RPUseSg@mail.gmail.com>
Subject: Re: Is strncpy really less secure than strscpy ?
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        James Dutton <james.dutton@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
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

On Wed, Oct 18, 2023 at 7:56=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Oct 18, 2023 at 07:27:20PM -0700, Randy Dunlap wrote:
> >
> >
> > On 10/18/23 18:49, Bagas Sanjaya wrote:
> > > [Disclaimer: I have little to no knowledge of C, so things may be wro=
ng.
> > >  Please correct me if it is the case. Also Cc: recent people who work=
 on
> > >  strscpy() conversion.]
>
> Here are the current docs on the deprecated use of strncpy:
> https://docs.kernel.org/process/deprecated.html#strncpy-on-nul-terminated=
-strings
> which could probably be improved.
>
> > Also Cc: the STRING maintainers.
> >
> > > On Thu, Oct 19, 2023 at 12:22:33AM +0100, James Dutton wrote:
> > >> Is strncpy really less secure than strscpy ?
>
> Very. :)
>
> > >> If one uses strncpy and thus put a limit on the buffer size during t=
he
> > >> copy, it is safe. There are no writes outside of the buffer.
> > >> If one uses strscpy and thus put a limit on the buffer size during t=
he
> > >> copy, it is safe. There are no writes outside of the buffer.
> > >
> > > Well, assuming that the string is NUL-terminated, the end result shou=
ld
> > > be the same.
>
> Note the use of "If" in the above sentences. :) This is what makes
> strncpy so dangerous -- it's only "correct" if the length argument is
> less than the size of the _source_ buffer. And by "correct", I mean
> that only then will strncpy produce a C-string. If not, it's a memcpy
> and leaves the buffer unterminated. This lack of %NUL-termination leads
> to all kinds of potential "downstream" problems with reading past the
> end of the buffer, etc.
>
> One of the easiest ways to avoid bugs is to remove ambiguity, and
> strncpy is full of it. :P
>
> Almost more important than the potential lack of %NUL-termination is
> the fact that strncpy() doesn't tell other maintainers _why_ it was used
> because it has several "effects" that aren't always intended:

THIS.

It is often very difficult and takes multiple minutes to figure out whether
a destination buffer used within strncpy() is expected to be NUL-terminated
or NUL-padded. The behavior and intention of other viable replacements
 (such as strscpy()) are immediately obvious to the reader.

>
> - is the destination supposed to be %NUL terminated? (We covered this)
> - is the destination supposed to be %NUL padded?
>
> strncpy pads the destination -- is this needed? Is it a waste of CPU
> time?
>
> > >
> > >> But, one can fit more characters in strncpy than strscpy because
> > >> strscpy enforces the final \0 on the end.
> > >> One could argue that strncpy is better because it might save the spa=
ce
> > >> of one char at the end of a string array.
>
> At the cost of creating non-C-strings. And this is a completely bonkers
> result for the "C String API" to produce. :P

But yeah, this is the kicker. C String API's should produce C strings.

>
> > >> There are cases where strncpy might be unsafe. For example copying
> > >> between arrays of different sizes, and that is a case where strscpy
> > >> might be safer, but strncpy can be made safe if one ensures that the
> > >> size used in strncpy is the smallest of the two different array size=
s.
>
> The CONFIG_FORTIFY_SOURCE option in the kernel adds a bunch of
> sanity-checking to the APIs (some of which can be determined at compile
> time), but it doesn't remove the ambiguity of using strncpy. We want the
> kernel to have maintainable code, and when it's not clear which of a
> handful of side-effects are _intended_ from an API, that's a bad API. :)
>
> > >
> > > Code example on both cases?
> > >
> > >>
> > >> If one blindly replaces strncpy with strscpy across all uses, one
> > >> could unintentionally be truncating the results and introduce new
> > >> bugs.
>
> Yes, of course. That's why we're not blindly replacing them. :) And the
> diagnostic criteria has been carefully described:
> https://github.com/KSPP/linux/issues/90
>
> -Kees
>
> --
> Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9941E79C19E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjILBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjILBYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:24:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B394686
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:40:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13055076a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694471976; x=1695076776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUI+yciS9U7o/XSp9QS87LTWNwGIJn99OxRUAsE808g=;
        b=qvAsU9519d26BbqnUcEOKkJ55o+8FyIIxUkDVhx5swhot4THail9d3eivHveLX5HA9
         76bz3Yr3CiT9Ag1j1kzi9iT7BLalrotckYCOwcIPeZ07qLpDohgxaXtSQSqniTHwxuev
         XczqfeVJegUOL/7jTVbqV2pA/Qybd/ZJkrb1Pj7DF6s4MZtnX/VPbHGqM0xlmWn0q/z+
         VfMAMShO8Pinp2NShfdZYFRD05tFOTy5uup/X3z/EC6WURw2c4KiPLTdP6FB7OCjl/Jm
         mE2cX+nCk5fSF2RcMm0s7IeFc0BHDdiDwwx+pN3BeIcKt77xd/WcFsItwWxKuQuCpDZF
         gyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694471976; x=1695076776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUI+yciS9U7o/XSp9QS87LTWNwGIJn99OxRUAsE808g=;
        b=LAIMThpxycwtxLf5r0x0AG3ik+kAmtjpLbK6lM+kcJglIF7AT0F4lPPm6P5hAZN4UJ
         dZhM5jUoP3Q+Cu9MNvVZuCqUYPTwUhCo7jI9/vI0vRKWPumrMmJ8YOsJED/KN00l6P8F
         OB0iYqSLUaXLvvZRetxRev7HvhylxglSUEF/0PhKvwpIzflt/i/nDLLRqBQDoySBFT4t
         SKNIxNwRD7zcyxRnw8bCDiIMBG14jsXqLt/ePw2S/lUKe2cJBWPf77v9wI1FaVcxtomc
         BzOp/acFSUzcgVC2vnvh7ONt08npG/a8ihMYgiPUoR236oAKnH8thYWBccIhrJKqTEuP
         3V3Q==
X-Gm-Message-State: AOJu0YyagaczTeTw+sdB7KYQVtrWFFqvRC9O6CFDoKxlIKW3Efr7o79I
        bxLdX44Tj1rK7plvRE6/nPD18CpEgkBMTXB/mNNacbPQi3OleSSRFMo=
X-Google-Smtp-Source: AGHT+IHaNLCNW4cCXydLmeSfIqjRZlpdje9Q9CqRKN7n2BIIz4uXg9TIClQFO/T8fGoiUiX1e8Hx8nBsO1IygogGXic=
X-Received: by 2002:a17:906:3006:b0:9ad:7f8b:2b0a with SMTP id
 6-20020a170906300600b009ad7f8b2b0amr768078ejz.22.1694469689026; Mon, 11 Sep
 2023 15:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <69643667-4564-0266-1b26-13833191842c@intel.com>
In-Reply-To: <69643667-4564-0266-1b26-13833191842c@intel.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Sep 2023 15:01:16 -0700
Message-ID: <CAFhGd8rohHPu+Zqr+w35=6=goUNC4ycvKk78N+7LSvNbnDnvuw@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Sep 11, 2023 at 11:51=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 9/11/23 11:27, Justin Stitt wrote:
> > `strncpy` is deprecated and we should prefer more robust string apis.
>
> I dunno.  It actually seems like a pretty good fit here.
>
> > In this case, `message.str` is not expected to be NUL-terminated as it
> > is simply a buffer of characters residing in a union which allows for
> > named fields representing 8 bytes each. There is only one caller of
> > `tdx_panic()` and they use a 59-length string for `msg`:
> > |     const char *msg =3D "TD misconfiguration: SEPT_VE_DISABLE attribu=
te must be set.";
>
> I'm not really following this logic.
>
> We need to do the following:
>
> 1. Make sure not to over write past the end of 'message'
> 2. Make sure not to over read past the end of 'msg'
> 3. Make sure not to leak stack data into the hypercall registers
>    in the case of short strings.
>
> strncpy() does #1, #2 and #3 just fine.

Right, to be clear, I do not suspect a bug in the current
implementation. Rather, let's move towards a less ambiguous interface
for maintainability's sake

>
> The resulting string does *NOT* need to be NULL-terminated.  See the
> comment:
>
>     /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
>
> Are there cases where strncpy() doesn't NULL-terminate the string other
> than when the buffer is full?
>
> I actually didn't realize that strncpy() pads its output up to the full
> size.  I wonder if Kirill used it intentionally or whether he got lucky
> here. :)

Big reason to use strtomem_pad as it is more obvious about what it does.

I'd love more thoughts/testing here.

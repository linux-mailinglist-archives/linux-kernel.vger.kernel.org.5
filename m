Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F37DB228
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJ3CxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3CxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:53:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C63BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:53:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso6355142a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698634381; x=1699239181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8i9IJ6qcHJ07vn+dkRJ2At4ErXDFAqXeJ+j8E+g0On8=;
        b=VHvNtscV34P8CeWr7PJA1WsbgB/r6E9hFeTDzCx/StdIRvP/mQOMWSfeSUPp0wvLOI
         /6iU0n+cKIErVmjEmX96O4arVxuLE9qC0kCiascOVFxP9A1upHXTdEWfNkqNNVUNDBux
         dJgrdbNwHrjnMo1Nubq3/Wr8KlJuFdc2XGzGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698634381; x=1699239181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i9IJ6qcHJ07vn+dkRJ2At4ErXDFAqXeJ+j8E+g0On8=;
        b=aB/qVZEkDY4czmu735m4omFvY+vobTpb7ca4QFwSwaiVSAXQhlECwGHxOCkIIpI1UA
         Q+b1mDJusRTERhzAcwZ+hJcxHNYNVW85B8Wr8vsLllyjiLnrVDz3kLRhkxmX/gs6Hbdt
         OraF0QQO138Uyq+kSJI6ZYKBLkiv+yxv0KSQcjojHWtKx9Lcst3U6rjR2CBGWGQJ787G
         N4rkqcB9PuIvwKbuDX063df3lMFjR2JLqNvwXrYphSbrYHUyFI8xjofiwNdnNKkV0BFI
         6uR8cCr3rWAuU0OlhO2sHKtxfxcGxFAqqEpDQMAmw5IzfLNXOHE17tPZwz1ijSGGjaOV
         1s6g==
X-Gm-Message-State: AOJu0YyIMld1ibXMMEG8Zz3eJxaIcC4D24mpURV6vtMGrbrmpdsBY4kl
        /qGtGpF4q7lk5tsLMcsiaCtHcWQUFEY450jMzAVFqw==
X-Google-Smtp-Source: AGHT+IGX7YJCSekUE90X58cNsWlVqYs/pB8c53/m9VZ2n7ux7C+0E9mOCSqNVvWg0F4Q9zCAPGBWYA==
X-Received: by 2002:a17:907:3f1f:b0:9ae:4878:1172 with SMTP id hq31-20020a1709073f1f00b009ae48781172mr7033351ejc.7.1698634381026;
        Sun, 29 Oct 2023 19:53:01 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id c16-20020a1709060fd000b0098ce63e36e9sm5281529ejk.16.2023.10.29.19.52.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 19:52:59 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso6390729a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:52:59 -0700 (PDT)
X-Received: by 2002:a17:906:dace:b0:9a1:680e:8c54 with SMTP id
 xi14-20020a170906dace00b009a1680e8c54mr7002213ejb.71.1698634379204; Sun, 29
 Oct 2023 19:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <169858752781.1095326.10615907253726224231@leemhuis.info>
 <CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com> <CAAhV-H4DXYm+nEV8zrfMMPvqstHV+FsQaFB8s1_rNu_ENC-q7g@mail.gmail.com>
In-Reply-To: <CAAhV-H4DXYm+nEV8zrfMMPvqstHV+FsQaFB8s1_rNu_ENC-q7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Oct 2023 16:52:42 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiX0j=8DB0EbCheAAfcx2z99QUZMTeJUxSBGpb0J5pjVg@mail.gmail.com>
Message-ID: <CAHk-=wiX0j=8DB0EbCheAAfcx2z99QUZMTeJUxSBGpb0J5pjVg@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-10-29]
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Sun, 29 Oct 2023 at 16:18, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> We are investigating and hope the simpledrm problem can be fixed in
> some days [1],

I don't understand your "some days".  The original report was two+
weeks ago, and the link you point to does not seem to have a suggested
patch for the problem either.

So where does the "some days" come from?

The WHOLE POINT of the "no regressions" rule - and the reason it came
to be in the first place - was that we used to have these endless "one
step forward, two steps back" things with suspend/resume in
particular, where people fixed one device, but then broke a random
number of other devices, and kept saying " but I fixed something".

No. If you broke something else, YOU DIDN'T FIX ANYTHING AT ALL.

This is literally why we have that "no regressions" rule. No amount of
"but it's a fix" is valid at all if something else breaks. And no
amount of "I will fix the thing I broke in the future"  is valid
either.

If you don't have a fix for it, it's broken. And I don't even see a
*suggested* fix for people to try out.

> and the blank screen seems not a very harmful problem
> (maybe I'm wrong but I think most of people are using GUI now). So,
> can we keep the commit 60aebc9559492c at this time?

At least the email from Evan Preston seems to imply it's a blank
screen that doesn't go away.

  "Upgrading from Linux 6.4.12 to 6.5 and later results in only a
blank screen after boot and a rapidly flashing device-access-status
indicator"

And no, "most people using GUI" doesn't matter. You are supposed to be
able to upgrade your working kernel, and it's supposed to keep
working. That's *important*, because it's really really important that
people *trust* that they can upgrade the kernel and not end up with
something non-working, because that's how people then dare do kernel
updates and dare test new kernels.

If people then stop testing new kernels because they think new kernels
might break their setup, we have lost something truly important.

And yes, there are always exceptions. At some point, devices are just
too old legacy and there is no way of testing. Or we've had some
interface that was *so* mis-designed that it was a fundamental
security issue or something like that.

But no, this does not seem to be one of those issues.

Now, I'm not going to revert it just before releasing v6.6 (which I
have locally tagged, but not pushed out yet). And I'll have the merge
window for 6.7 opening tomorrow. But if this is not fixed by -rc1,
we'll just revert it.

                    Linus

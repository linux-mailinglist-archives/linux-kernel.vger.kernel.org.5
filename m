Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3777F0204
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKRSkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:40:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F60F2;
        Sat, 18 Nov 2023 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700332809; x=1700937609; i=deller@gmx.de;
        bh=H1zbsRn5uAPqCcioQHkyw4K2MGeXASXOklHwGF80Qnc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=rCkxR6vD5mst3bjYx5rXWLbLnZaKaGzEFA6797pJc+RBsYAfI952EcVmTg2iJfzJ
         fCY8RPtNVWnsXKRHVyHOih/0ImppqY3FOtnIe6eq9BRl1bUp9HngTznew5aF0tt1y
         UYyikDC8FBdgKKI0BzATYQAkliRBkJ4YL46TeNVCNPxYdh/GVMSZ0SdfCdh8xDQ/K
         aqOzxGbb935WphlkGr8D0DJ+FvKICZhrEB1wsaUW+dlGwR3ymX1K7z9vPGL7YCdu+
         ANQvmS4CF2lCNPa7nSrCrn3Fk2gGWtlDTbWQ5MbFIXCj2YGkm1ZXU5hO/7kex2t7I
         4LXSaUyEZC5rpb4FNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1rKaZf32aY-00tmeq; Sat, 18
 Nov 2023 19:40:09 +0100
Message-ID: <0f492aac-9ba7-4bc6-95b2-6b1104a12244@gmx.de>
Date:   Sat, 18 Nov 2023 19:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Kees Cook <keescook@chromium.org>, Sam James <sam@gentoo.org>
References: <ZVjC9P0h5mw3ZbnD@p100>
 <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zlr9eDagj1n1tz2yMjrmqAQ79OfSCyoyVC/A0HThCCg9Y7AfXrL
 x+/Wp1kvRHu+T+XyvbdkA6G1ZYRcxA9gmmiriC3zEO4XtRSJ4lkLkOdE0jGoyumS2EkG8XV
 yL32yys3j2Jbd8/jAJsoSjpeh/T+7fy4b6BxZsreYyPNPkjX023+6sFqULQF3jodvbpz5zg
 HkHRs5kHiIZgOv6NqOMWQ==
UI-OutboundReport: notjunk:1;M01:P0:U4iXvIf+UoU=;6Hf5aGDtaWGrk4kFj25TMcejGTt
 e2R6iOP9sjiUTm2Gm7WsPIf2zi4Y/kG9UcwXy5S2OSwVpdYFhV7gRYyzO1SQ7rPlbwo2/5nd7
 tKmi+kR1RE8Dr6BfWejDXzo53OK5PH656XxT5Toz8SfdaMRUS8FEmolv+dSwlGkaIi8GbvpeZ
 W+dMKQyeAGPNc3kWzw7JxpteM1Z7jOx2x7JJYhymD7nXi9lxMiKe+8EeLM4jiPxwazVPX05f1
 8UWJML5OmWpkb3t6TGk75bT711EMCs+aHEvaIcxRLz9+5ZE+PPjq4NmtAV8lyfOTp/gryzErC
 ah1ZGYw+BJJb3tCITwk9CGjByqzOVDa6Ki9e76kKrkIGLUKdkb+6jbbRAXO3Wjwvgy/6vBH9k
 wxN3oUfb+SEGrR/vFQrYdxngsWoTjXOKJcX/XZjqMl960X16VPRo2+DIiDTnesaPBR+2xwolE
 8PptgrFEEHBqZJQnmYF1Zxkrr4c2xv1SiLM6uBwMuG9k9+FWrj3oI6pThK6F/P073Vuz0X1H9
 8Vb9bzpZouCG5sCbj67p+/pVC+FXSdbzWOJOELo2SwujiqfWnM81fwCD0Yp0WbXGt4lhhvYg9
 74W0Hm6XUaIrdWMd79xDG7Wv+UyWGSxZa8pNHAnH0LnsG3DOXuylFVsJGpI5F312k0KgjBAsc
 vLxyknAoTrYjsfnfpmyhOU+V09FvmBywQOvzvNpVhEizjNGOZtbF6fAsXLrdZR2sow9zW79zT
 BbswSj/valhCqvwc+pHu5OXjnYKh9z54RipBr+/0wow+OQV1TYkiYhm/QdeG0MrKiJE12edcw
 4/nuAq9iVHTC6zGgcUeaAgPBDWtdHPFzuQBUKOVqPHrqxnU+ZcaBnzKAYQ8J494VYQ1o8rNH5
 c6RcH/36kYP1LyvEpZlDFnNaVtsLJWPLxhqY5p/5MOmy8Ehv97/ZphHy7t0a8EPx6hQ7Ba14l
 nA30TgeQYxhDwcliYbruZOg+bwo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/23 18:36, Linus Torvalds wrote:
> On Sat, 18 Nov 2023 at 05:58, Helge Deller <deller@gmx.de> wrote:
>>
>> On parisc we still sometimes need writeable stacks, e.g. if programs ar=
en't
>> compiled with gcc-14. To avoid issues with the upcoming systemd-254 we
>> therefore have to disable prctl(PR_SET_MDWE) for now (for parisc only).
>
> Ugh.
>
> I pulled this, but I *really* cannot live with how ugly that is.
>
> Seriously, that code is just unacceptable. Doing something like
>
> +               if (IS_ENABLED(CONFIG_PARISC))
> +                       error =3D -EINVAL;
> +               else
> +                       error =3D prctl_set_mdwe(arg2, arg3, arg4, arg5)=
;
>
> in generic code with no comment is just truly crazy. If you have to go
> and do a "git blame -C" just to understand why the code exists, the
> code is a problem.
>
> But it goes beyond that. The code is just *ugly*, and it's done
> entirely in the wrong place.
>
> Things like "mdwe is special on parisc" should *NOT* be done in the
> generic "prctl()" function.  This issue is not specific to prctl() -
> it's very much specific to mdwe.
>
> So I think it would have been both much more legible, and *much* more
> appropriate, to do it in prctl_set_mdwe() itself, where it makes more
> sense, and where it matches all the *other* mdwe-specific checks the
> code does wrt arguments and existing state.
>
> And honestly, why wouldn't 'get_mdwe' work? So the *other* hunk in
> that patch (which isn't even mentioned in the commit message) that
> returns -EINVAL for get_mdwe makes no sense at all, and shouldn't have
> existed.
>
> End result: I think the code should have been something like this
> (whitespace-damaged) thing:
>
>    --- a/kernel/sys.c
>    +++ b/kernel/sys.c
>    @@ -2394,6 +2394,10 @@ static inline int prctl_set_mdwe(unsigned
> long bits,
>         if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GA=
IN))
>             return -EINVAL;
>
>    +    /* PARISC cannot allow mdwe as it needs writable stacks */
>    +    if (IS_ENABLED(CONFIG_PARISC))
>    +        return  -ENOSYS;
>    +
>         current_bits =3D get_current_mdwe();
>         if (current_bits && current_bits !=3D bits)
>             return -EPERM; /* Cannot unset the flags */

Ok.
My initial patch was actually doing exatly that, but somehow I finally dec=
ided
to add it to the switch() instead. Seems this was the wrong decision :-(

> where I also picked another error code, because it's not that the
> prctl value or the arguments are invalid, I think the error should
> show that there's something else going on.
>
> No, I don't think -ENOSYS is necessarily the best possible error
> value, but I think it at least conceptually matches the "this prctl
> doesn't exist on PARISC". Maybe
>
> Maybe ENOSYS should be avoided (prctl() obvious does exist), but I do
> think this should be a different error than the EINVAL that the
> generic checks do.

I agree that returning something else than EINVAL would be better.
I used ENODEV in an earlier patch (I didn't liked it either), but accordin=
g to
https://github.com/systemd/systemd/issues/29775#issuecomment-1809563365
EINVAL seems the best solution currently.

Just as a side-note: ENOSYS gives a checkpatch warning:
WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Would the patch below be OK? It's basically yours but with EINVAL.
(might be whitespace-scrambled!)

Helge

=2D--

From: Helge Deller <deller@gmx.de>
Subject: [PATCH] prctl: Disable prctl(PR_SET_MDWE) on parisc

systemd-254 tries to use prctl(PR_SET_MDWE) for it's MemoryDenyWriteExecut=
e
functionality, but fails on parisc which still needs executable stacks in
certain combinations of gcc/glibc/kernel.

Disable prctl(PR_SET_MDWE) by returning -EINVAL for now on parisc, until
userspace has catched up.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Sam James <sam@gentoo.org>
Closes: https://github.com/systemd/systemd/issues/29775
Tested-by: Sam James <sam@gentoo.org>
Link: https://lore.kernel.org/all/875y2jro9a.fsf@gentoo.org/
Cc: <stable@vger.kernel.org> # v6.3+

diff --git a/kernel/sys.c b/kernel/sys.c
index 420d9cb9cc8e..e219fcfa112d 100644
=2D-- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2394,6 +2394,10 @@ static inline int prctl_set_mdwe(unsigned long bits=
, unsigned long arg3,
         if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAI=
N))
                 return -EINVAL;

+       /* PARISC cannot allow mdwe as it needs writable stacks */
+       if (IS_ENABLED(CONFIG_PARISC))
+               return -EINVAL;
+
         current_bits =3D get_current_mdwe();
         if (current_bits && current_bits !=3D bits)
                 return -EPERM; /* Cannot unset the flags */

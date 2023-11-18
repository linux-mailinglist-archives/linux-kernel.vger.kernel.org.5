Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFF7F0152
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKRRgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjKRRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:36:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61300AF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:36:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so38002281fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700328992; x=1700933792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XdNJHQVOkcEDcIMedTCGqDVpo8YAzi1ivWNi4eRH88=;
        b=Fodt7/i/X2dhCyuY4Zaf8nIDsWXufqYR2nt+9vitB2qXZmnwALU9E7s1qqTOqPgsrw
         UAbqi1awJwJIxT73Osxh/9lWlOtyu1sZkUS989ne0LDqtHFuUrmBWvHqIKnDtqyozupT
         27X8x+acjm6O9Uw9A/8QwNv+VgM7l0esgDjqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700328992; x=1700933792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XdNJHQVOkcEDcIMedTCGqDVpo8YAzi1ivWNi4eRH88=;
        b=CmAA4r62p8Tu2M0EFLOymdOqS5024/UzA9o99BI7Rxsh7uCGB4+XiSfZw2yv01S0FO
         H/Xdtn25hMiqn0/u+BeNfVT80G6sqTwl4qBdaO6CANPE8g57DuboahF9LG0c4s4PZjjE
         WBOCAV/J3d/akeDCXgZI5II48boRG6MzRw0t0p1Fi9OPSRmgyn1RUwRW7wp2xvGSGHCn
         67Kr+cuywpFesGJh/CD4ayt63etlUlJne2CFpBoEyiVKuruE9r3axrgK+O36E1j2/8Rg
         ODTbOEGkzrbyjB4wir1NP3oPVEwgipvQEdHXIC8mh/FQVRzyA87vaZu374nBCkXIAME6
         8wmA==
X-Gm-Message-State: AOJu0YwEBRChRKE081pGR7d0LsXBWcaRKrA28HX9dVto+XiU3sVhozhd
        NOdoejU+C2RF20vwvAAwC1RE4qN5DusEm5SgZC0Whg==
X-Google-Smtp-Source: AGHT+IFbfAUGfaHBlVY4i9+FDdVOapQdEYhi63dHQauJg0C72MH4Eu0qb0Qy8+6Dab4rZBRKNlvzrA==
X-Received: by 2002:a2e:a268:0:b0:2c0:a0c:be7 with SMTP id k8-20020a2ea268000000b002c00a0c0be7mr1981500ljm.8.1700328992375;
        Sat, 18 Nov 2023 09:36:32 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l20-20020a2ea314000000b002bffb3f8cebsm558273lje.54.2023.11.18.09.36.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 09:36:31 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a62d4788so4381032e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:36:31 -0800 (PST)
X-Received: by 2002:a19:a418:0:b0:509:2b81:fc40 with SMTP id
 q24-20020a19a418000000b005092b81fc40mr2153660lfc.9.1700328991156; Sat, 18 Nov
 2023 09:36:31 -0800 (PST)
MIME-Version: 1.0
References: <ZVjC9P0h5mw3ZbnD@p100>
In-Reply-To: <ZVjC9P0h5mw3ZbnD@p100>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Nov 2023 09:36:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
Message-ID: <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 at 05:58, Helge Deller <deller@gmx.de> wrote:
>
> On parisc we still sometimes need writeable stacks, e.g. if programs aren't
> compiled with gcc-14. To avoid issues with the upcoming systemd-254 we
> therefore have to disable prctl(PR_SET_MDWE) for now (for parisc only).

Ugh.

I pulled this, but I *really* cannot live with how ugly that is.

Seriously, that code is just unacceptable. Doing something like

+               if (IS_ENABLED(CONFIG_PARISC))
+                       error = -EINVAL;
+               else
+                       error = prctl_set_mdwe(arg2, arg3, arg4, arg5);

in generic code with no comment is just truly crazy. If you have to go
and do a "git blame -C" just to understand why the code exists, the
code is a problem.

But it goes beyond that. The code is just *ugly*, and it's done
entirely in the wrong place.

Things like "mdwe is special on parisc" should *NOT* be done in the
generic "prctl()" function.  This issue is not specific to prctl() -
it's very much specific to mdwe.

So I think it would have been both much more legible, and *much* more
appropriate, to do it in prctl_set_mdwe() itself, where it makes more
sense, and where it matches all the *other* mdwe-specific checks the
code does wrt arguments and existing state.

And honestly, why wouldn't 'get_mdwe' work? So the *other* hunk in
that patch (which isn't even mentioned in the commit message) that
returns -EINVAL for get_mdwe makes no sense at all, and shouldn't have
existed.

End result: I think the code should have been something like this
(whitespace-damaged) thing:

  --- a/kernel/sys.c
  +++ b/kernel/sys.c
  @@ -2394,6 +2394,10 @@ static inline int prctl_set_mdwe(unsigned
long bits,
       if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
           return -EINVAL;

  +    /* PARISC cannot allow mdwe as it needs writable stacks */
  +    if (IS_ENABLED(CONFIG_PARISC))
  +        return  -ENOSYS;
  +
       current_bits = get_current_mdwe();
       if (current_bits && current_bits != bits)
           return -EPERM; /* Cannot unset the flags */

where I also picked another error code, because it's not that the
prctl value or the arguments are invalid, I think the error should
show that there's something else going on.

No, I don't think -ENOSYS is necessarily the best possible error
value, but I think it at least conceptually matches the "this prctl
doesn't exist on PARISC". Maybe

Maybe ENOSYS should be avoided (prctl() obvious does exist), but I do
think this should be a different error than the EINVAL that the
generic checks do.

End result: I really hated this change so much that I ended up
unpulling after doing the pull. This needs to be done right, or not at
all.

              Linus

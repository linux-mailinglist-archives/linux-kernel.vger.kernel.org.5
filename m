Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC57A9A34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjIUShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjIUSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7BDAFC7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so1470866a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695321132; x=1695925932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duasdIDps1Ar+JiX8MLjxGEHHubOxG32YmdpyidUjAA=;
        b=qFpG4RkEhgRgb2vau6Tpv6uWtagYsxHtB9cl4sw4vdMzsVh48WPJQZBcu1FG8Bkmkv
         5wLMa5BGUWNjz1Y8MSCRItgfaTDeyWt/eTf68t4WPIYqdvXSuedzXhi3CYqa4xyfdTk9
         Pm0p5pgWKp7TLtr44x/JvxkbcU3EamMCnwy+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321132; x=1695925932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duasdIDps1Ar+JiX8MLjxGEHHubOxG32YmdpyidUjAA=;
        b=pIlD96gNSeeC7s0neR/7xjhwaw9bBYoLwzcnbWCOw4pN+PiECkZdgWWila/vwWCbDV
         Lbswn7YITpFbU/8qc6IBihdjUu76ppzDUUuLROZxlqWhyB13plSW1wMGt1MACudBFVcf
         9t2auURNsOMQqFu94RmHbeUcDvLeSKXy73Mq4mb9Zs3ggA1wijtNTT/aLTt06FHHQwqf
         iUd2QvaO3KYBSIp0NPKJxAcXfDtfVAoTcPU4lhk3+8cYLUAn8EBqeTORmUAYQG/FwqgN
         sSEb2tU8arIUjLK7RZRnww82XunprHiPD+DxsZGX8WU3uG9yKIOD0qj78/ih5Ug0RuvA
         Z++Q==
X-Gm-Message-State: AOJu0YwB5ctaY1s4vQNZxOSJN95llmEbjh7fN3jOYkSsJIDYuEnRsMH7
        AsYfPF8vGsSAErsyhz0TtbuL0uRmGJoqbkFhIa0ABkjb2R5WO/gY3Lg=
X-Google-Smtp-Source: AGHT+IEMcpET+KyGeAflcKrt2Lb0K8gxzNygopNZCsI5AgwGZvckAbSqyadk7XQvFGprUQhpXBwpf5gUZkOt9LY6QjE=
X-Received: by 2002:a17:906:d3:b0:99e:1358:ffdf with SMTP id
 19-20020a17090600d300b0099e1358ffdfmr3894831eji.72.1695281665917; Thu, 21 Sep
 2023 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919212840.144314-1-mattlloydhouse@gmail.com> <CAJfpeguMf7ouiW79iey1i68kYnCcvcpEXLpUNf+CF=aNWxXO2Q@mail.gmail.com>
 <20230920132606.187860-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230920132606.187860-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Sep 2023 09:34:14 +0200
Message-ID: <CAJfpegvZ+4SNnkOEkS=7D44bZNQBovA7SU7etChN6Bh_B9f3dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 15:26, Matthew House <mattlloydhouse@gmail.com> wrote:

> The declared type of a variable *is* one of the different types, as far as
> the aliasing rules are concerned. In C17, section 6.5 ("Expressions"):
>
> > The *effective type* of an object for an access to its stored value is
> > the declared type of the object, if any. [More rules about objects with
> > no declared type, i.e., those created with malloc(3) or realloc(3)...]
> >
> > An object shall have its stored value accessed only by an lvalue
> > expression that has one of the following types:
> >
> > -- a type compatible with the effective type of the object,
> >
> > -- a qualified version of a type compatible with the effective type of
> >    the object,
> >
> > -- a type that is the signed or unsigned type corresponding to the
> >    effective type of the object,
> >
> > -- a type that is the signed or unsigned type corresponding to a
> >    qualified version of the effective type of the object,
> >
> > -- an aggregate or union type that includes one of the aforementioned
> >    types among its members (including, recursively, a member of a
> >    subaggregate or contained union), or
> >
> > -- a character type.
>
> In this case, buf is declared in the program as a char[10000] array, so the
> declared type of each element is char, and the effective type of each
> element is also char. If we want to access, say, st->mnt_id, the lvalue
> expression has type __u64, and it tries to access 8 of the char objects.
> However, the integer type that __u64 expands to doesn't meet any of those
> criteria, so the aliasing rules are violated and the behavior is undefined.

Some of the above is new information for me.

However for all practical purposes the code doesn't violate aliasing
rules.  Even the most aggressive "-Wstrict-aliasing=1" doesn't trigger
a warning.  I guess this is because gcc takes the definition to be
symmetric, i.e. anything may safely be aliased to a char pointer and a
char pointer may safely be aliased to anything.  I'm not saying that
that is what the language definition says, just that gcc interprets
the language definition that way.  Also plain "-Wstrict-aliasing"
doesn't trigger even if the type of the array is not char, because gcc
tries hard not to warn about cases where there's no dereference of the
aliased pointer.  This is consistent with what I said and what the gcc
manpage says:  only accesses count, declarations don't.

>
> I've always felt that capacity doubling is a bit wasteful, but it's
> definitely something I can live with, especially if providing size feedback
> is as complex as you suggest. Still, I'm not a big fan of single-buffer
> interfaces in general, with how poorly they tend to interact with C's
> aliasing rules. (Also, those kinds of interfaces also invite alignment
> errors: for instance, your snippet above is missing the necessary union to
> prevent the buffer from being misaligned, which would cause UB when you
> cast it to a struct statmnt *.)

Okay, alignment is a different story.   I'll note this in the man page.

Thanks,
Miklos

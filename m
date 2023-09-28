Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2E7B21C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjI1Pwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjI1Pwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:52:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F11A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:52:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so135087615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695916346; x=1696521146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foVf5TV1MmYsP7PedGF8V/NHFqHve2xNubfmQ3LV2g4=;
        b=tvWQEmqFxsVIS/BF4LzTeA7treVv5t5yHUyTzUkEeOrM3tFnq/GkYbgB+CX2NYjSik
         bO2hjgim4OaZ2hxJZFWReBkqr2pixgFlSYjpZrnm6rUodBXPrBulAgLWAImCe3+vxTCM
         CFHrhtW+UnncxkFXBa6QBkaaLvk92fVf1mIWYJAp3Wik/cRJeFSlwWqRPJOQ6jv+9qou
         btpfiyvf5NlXvlca+kOQHG4vnrGHUGuVWnOAtydmqpyaI+jWY0numxgAjW7YDM6+hgbd
         mRqTWtdY/hoc6Mbo/J1QN/FyL4LKcgW6eT9QPVRvibXWcfqKjo+aQkur9n6g53z0vPsp
         3WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695916346; x=1696521146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foVf5TV1MmYsP7PedGF8V/NHFqHve2xNubfmQ3LV2g4=;
        b=tQo1Jycz6UrG4RfCZxRNoIsxqyl2T2AXm9kp7jdBiJLQypS0c/FkkB2Abl6BALbHjs
         f+rjIVb+QMiSD03SA4GgQ//qsQjWU0OCDJcmBW6VI5gc2WZfIWHVssslILgL32L9EnTr
         KkmcR12tvYjVYiWPDxH4PDaFey4RM8qZ74gzBQvkKTBMlby4XKNKLXwL0WXMEUqBPCEr
         zdO7/yRV5/PTZD6IEYPTJYtPEqQT0Y1XYuyiVtPwqAbgTQMVi1xWqsKbZAopOkGKL6Uf
         dpQCaZfIzSrBp/C8+kkhq2N4g5cKmIxjJer/DvmiN1RAoqL+kJgzl2RE/7ZmCuMiG0Z9
         8Ofw==
X-Gm-Message-State: AOJu0YwNSFUPEKJV0zUb5uKrET11wEWgUib5M0KrQkleVAAmEyOGIC9I
        5qUy/oG/REjDW1JqmsaenWCPCLIbCm3aIpFGr45JVA==
X-Google-Smtp-Source: AGHT+IFZjhxkEjiaXp2zigCJ7tc2I6455jijXEKgoD9JgTP2Y0UEY5UScbCjY5Sj4DCn07iZsNn312ihcg5GHjZeZXE=
X-Received: by 2002:adf:f108:0:b0:313:f783:262b with SMTP id
 r8-20020adff108000000b00313f783262bmr1652155wro.26.1695916346402; Thu, 28 Sep
 2023 08:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
 <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
 <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com> <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com>
In-Reply-To: <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Sep 2023 08:52:15 -0700
Message-ID: <CAKwvOdnGzTvSXf7VeyG8tPEONpqSgkDiBTmgJbUUWsRHzbc5JQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
To:     Joe Perches <joe@perches.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:09=E2=80=AFPM Joe Perches <joe@perches.com> wrot=
e:
>
> On Thu, 2023-09-28 at 14:31 +0900, Justin Stitt wrote:
> > On Thu, Sep 28, 2023 at 2:01=E2=80=AFPM Joe Perches <joe@perches.com> w=
rote:
> > >
> > > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > > Changes in v2:
> > > > - remove formatting pass (thanks Joe) (but seriously the formatting=
 is
> > > >   bad, is there opportunity to get a formatting pass in here at som=
e
> > > >   point?)
> > >
> > > Why?  What is it that makes you believe the formatting is bad?
> > >
> >
> > Investigating further, it looked especially bad in my editor. There is
> > a mixture of
> > tabs and spaces and my vim tabstop is set to 4 for pl files. Setting th=
is to
> > 8 is a whole lot better. But I still see some weird spacing
> >
>
> Yes, it's a bit odd indentation.
> It's emacs default perl format.
> 4 space indent with 8 space tabs, maximal tab fill.
>

Oh! What?! That's the most surprising convention I've ever heard of
(after the GNU C coding style).  Yet another thing to hold against
perl I guess. :P

I have my editor setup to highlight tabs vs spaces via visual cues, so
that I don't mess up kernel coding style. (`git clang-format HEAD~`
after a commit helps).  scripts/get_maintainer.pl has some serious
inconsistencies to the point where I'm not sure what it should or was
meant to be.  Now that you mention it, I see it, and it does seem
consistent in that regard.

Justin, is your formatter configurable to match that convention?
Maybe it's still useful, as long as you configure it to stick to the
pre-existing convention.
--=20
Thanks,
~Nick Desaulniers

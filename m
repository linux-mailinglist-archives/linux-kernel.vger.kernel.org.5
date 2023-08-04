Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF8770797
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHDSJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjHDSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:09:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923074C27
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:09:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1717958e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691172528; x=1691777328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fsI9PvVRlWWAw6F53JK6JF21HssLhBf6Wzr398dkifg=;
        b=X23tQDKFZHZXw8vPF2onfJSiUk154utWV6xqv1kCTYlgpZUjj2KkNegETxF601fdJl
         dm76y8nVjeePT6jAyycp3SiPMxChFEicabp4u8TD9JeI3W6a6rpO3ZlaW3E3vq94Q+dv
         LWQocPYMMJy3D4WpvEKTD4ZKOlZ82sgBoGZFgOdmPo+tkJMxdIlUOCi5SSfDJpDRGxQi
         A8p+IdoK61KVNPKWg049Z+sXkrRoPFq0G1UJintkhqNdDNbBqGH53DDuNAoL0VO/pLdt
         SSQvOr4+k6UDpjEZMBERx82yG7cSmjPhdqT32mxaXm/q3NpJAeX7MwZIbVeMYvXnUMH6
         XGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172528; x=1691777328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsI9PvVRlWWAw6F53JK6JF21HssLhBf6Wzr398dkifg=;
        b=B3fVGDEW7fQEuZyI66um+hjHf8S7V3DpaA2nwOknks5zO32gXYsjt+HXWuIgv+FBXp
         lHBlOT09wtMnnjGQjUxNRDsTLho//AsMU9nUAl63gItweDyRqf0aHFrs2ZDEHn82klPa
         pE6NouSdXxy8pFSW9IG98omuMuRdoKjbsQYR3ne2au1pX0Tr3WtIjkQxzxsBMPb3DaJV
         ygqKXenoMxmfekd4y30Tc3NCzxbn5AwLPWtkvEb21LNZGv9BjZL8/HUSRsZpHMk9pPF+
         DpmBxbvTCX/ob3jPBC6HwGymICxbdQ5yTWxzyQGH01bEJ98F8dFAwtjSRT688U7KSBZX
         RCkg==
X-Gm-Message-State: AOJu0YyJ6bFvh5Y82CklyLAPVWturzyv64Scrp5JJyj/qjQqbcYQF1at
        N3yzcc7slE10LmKdebvFk4kgQWO641xu8EAM84zogQ==
X-Google-Smtp-Source: AGHT+IGyzN84161ZVHwtE2F/keTNz/u1GwxFBnzoFsr0eNmQ2zjl00SMrwlc9THZutNzTKjC7toTVi0zxPqJSe8t74o=
X-Received: by 2002:a05:6512:3297:b0:4fb:9446:598b with SMTP id
 p23-20020a056512329700b004fb9446598bmr1882858lfe.27.1691172528068; Fri, 04
 Aug 2023 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230804090621.400-1-elver@google.com> <20230804090621.400-2-elver@google.com>
 <20230804120308.253c5521@gandalf.local.home> <CANpmjNNN6b9L72DoLzu5usGGjLw5Li8rnfu0VuaCsL-p2iKTgg@mail.gmail.com>
 <20230804135757.400eab72@gandalf.local.home> <20230804135902.7925ebb6@gandalf.local.home>
In-Reply-To: <20230804135902.7925ebb6@gandalf.local.home>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Aug 2023 20:08:10 +0200
Message-ID: <CANpmjNPqfucNx7NdPOGSjjYgiZHntaBozGY1_rOSC4Wn4YCF1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list_debug: Introduce inline wrappers for debug checks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 4 Aug 2023 at 19:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 4 Aug 2023 13:57:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 4 Aug 2023 19:49:48 +0200
> > Marco Elver <elver@google.com> wrote:
> >
> > > > I've been guilty of this madness myself, but I have learned the errors of
> > > > my ways, and have been avoiding doing so in any new code I write.
> > >
> > > That's fair. We can call them __list_*_valid() (inline), and
> > > __list_*_valid_or_report() ?
> >
> > __list_*_valid_check() ?

Well, in patch 3/3, the inline function will also do a reduced set of
checking, so "valid_check" is also misleading because both will do
checks.

The key distinguishing thing between the inline and non-inline version
is that the non-inline version will check more things, and also
produce reports.

So I can see

 1. __list_*_valid_or_report()
 2. __list_*_full_valid()

To be appropriate. Preference?

> I have to admit, I think the main reason kernel developers default to using
> these useless underscores is because kernel developers are notoriously
> lousy at naming. ;-)

Heh, naming is hard. ;-)

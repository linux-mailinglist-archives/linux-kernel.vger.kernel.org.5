Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877047B7796
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJDGCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjJDGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:01:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326FB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:01:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-534659061afso2833026a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696399312; x=1697004112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcgFAmE5J8IBq+O2/YGxL5IIzFdEFgPNlcP5v4iMjjM=;
        b=hb+OEmHNeIVwsrfdtxv7KqI2oW1qtF0RwTpmRYQ/bM81oU8q4ceUq2v1f+/3WKZs3h
         yQenhrrpJ8buibea5ZDuSu07a0sE6T2Kishh0PTrw9RBokWS8Hq2pz+0wFTft6BOxZSr
         WbQCcDx9QrlXLPqlZWFtqyYeiceaZnw/TKgJV09/BPgKeP387kWwZxpxZ03Nc3MhkncT
         CAIuI45jvAOV/k157ELAtZRhlR5ZsYN7AGn/XJzS/iGCGNRb26AsAvrL3WyYAf2fVqAk
         ZRR2EoFXsSNg+xjBu/Qfgd3pJRWK6SVSJtNkKiQUEm+Rlt2vhGhLooBMDDhQcLQKUg0f
         POSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696399312; x=1697004112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcgFAmE5J8IBq+O2/YGxL5IIzFdEFgPNlcP5v4iMjjM=;
        b=eZOWRqzF2N84ywPboTsaltkmUqzvdOvsEVYyN3omIzHnCjKz910vRTs8mEpGQAIVNe
         g7sY+myQb5JzCL2xRBJZ8GL5YUI6Ste7idCSzOE7Lyh5K9QDyIcYeL2F+SKv+WJyQp/1
         URtTmCiq4XzZED6Vm2ilMZxDaeSTNpXp1LxiFkig1Nq3e+x3gFSx3ohsdBOFLxEOBJ5y
         hzMwp/xfleOTHPMgvZa6VHOOumbBlaph7DNrPeLMBkC7kKDb1PkEZSELgk50com3OGkQ
         kRK4jQWkzPYS4UlBd2/BdhZ3kJQ3H8S2C5kLcYgtyriu/gmKFgjF+w5LswkyRlGeIbCJ
         GWCg==
X-Gm-Message-State: AOJu0YwTD2aSILeaVYnZTkW0ay8jVivaPeUS5uVqkcT+vfzw62ZrzWNi
        6Us/v2TJCPWcqMIW3JywlO8a9ZOEf2CwXCH73quVPz+/Sb8=
X-Google-Smtp-Source: AGHT+IEZRWrxUwcqPhCVW2eBP7J/INXBKCbioce7btvllzvvOTYBXoLcNKwUX+b4Lj16kNYV74bDGeyEtIbAyKhGx7Q=
X-Received: by 2002:a05:6402:699:b0:522:3a89:a7bc with SMTP id
 f25-20020a056402069900b005223a89a7bcmr882223edy.42.1696399311379; Tue, 03 Oct
 2023 23:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
 <ZRrECdIoKCXALl39@gmail.com> <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
 <ZRwZOtANkcwtL+5B@gmail.com> <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
 <ZRxu9+ZJqjY/u8ku@gmail.com> <CAHk-=wg5kiiJ+LUChmw73mmi-=uyQrAO-fBTG6yr2ON_UnAoPg@mail.gmail.com>
In-Reply-To: <CAHk-=wg5kiiJ+LUChmw73mmi-=uyQrAO-fBTG6yr2ON_UnAoPg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 4 Oct 2023 08:01:41 +0200
Message-ID: <CAFULd4a6c7YMG=0KHGzKVZCzhqxDY13RTBJMprQ43tqve_FQxg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:44=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 3 Oct 2023 at 12:43, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > So we could do this: we let it live in -tip for a cycle, in a separate
> > branch, and observe what happens - it gets picked up by -next on
> > a daily basis and most x86 developers test it. It won't be merged by ot=
her
> > branches in -tip, it won't be pulled by others or relied on. If it
> > conflicts with other bits we rebase it cleanly, no questions asked.
>
> Sounds like a plan,

Thanks!

Will send a patchset with the config change later today.

Uros.

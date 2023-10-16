Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89A7CB3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJPUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:06:50 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8CB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0252578aso26321466d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697486808; x=1698091608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaHWZ++raSb5lyMsNQf39E3EcgWl93LaF644FrH4GdU=;
        b=BJqV1rUClDe+aofFvHAioq+//Y1fgchBk4LiaW5b75e+8tnrM7I3ZBQWQKVuOLiKUT
         rEAe/kvC+ssEsRmKIP3lsBhZ+mkOqvH7/bKnrt6PfMlYe/wsFAlS4dmMlZbV62GExexw
         u05H6nm8YSWDYhzfjrNKVpK1ALVV2Mapx1Lpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486808; x=1698091608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaHWZ++raSb5lyMsNQf39E3EcgWl93LaF644FrH4GdU=;
        b=Cj8OTRVKHkkEepkwG16KHBu7PBRFkwfMUFXUpOpCFPPP/huOWOk6BjdBmIj82TztOU
         OPw0U/tnFj41g1Ybdxh7sOYtTeVavM1/h/B7JxkJXXEfetaZ9+DiVNwO6QD5h6b+k+3g
         bBNGemjYt7Rc9UG0u30rTjqEpmfsMyShRUmCEmZ3IoqPqvJ7AQphg/RHrwxB0hoTvX6S
         al/e3cXl0e0IuNcE6hn/jQkPWdYfz42sRyn3zfxy75uqTKJgVQ3bjUf2GoSVHghLZWvT
         hAU7a6xThJjdEQ6PikEdx2FFSaaufnXWWrfWHEWfc7FnicsRayG8Ym8xScY7YoGXTRla
         7AGQ==
X-Gm-Message-State: AOJu0Yy43B/vc0KAI3MempJdm89soX1vyuqKjWgoVFYpptluEzwQ0ERy
        D7DAm9oHPeYKwEqnfSSbAwctAPhLvvgNouhAQ2A=
X-Google-Smtp-Source: AGHT+IEF4PIw5R5nlDEGb2mmQr4KXVMHrcObmYM+yG1w2MvoDb//pSJ6yu07IUZOo83lK1Jqy5XtQg==
X-Received: by 2002:ad4:5c63:0:b0:65b:21bf:8fc1 with SMTP id i3-20020ad45c63000000b0065b21bf8fc1mr535263qvh.42.1697486807701;
        Mon, 16 Oct 2023 13:06:47 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id cu16-20020a05621417d000b0066cfe6b078csm3719086qvb.15.2023.10.16.13.06.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:06:46 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4195fe5cf73so9381cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2c43:b0:418:1464:37bf with SMTP id
 kl3-20020a05622a2c4300b00418146437bfmr55093qtb.16.1697486805442; Mon, 16 Oct
 2023 13:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
 <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com> <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
In-Reply-To: <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 16 Oct 2023 13:06:31 -0700
X-Gmail-Original-Message-ID: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
Message-ID: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Li Nan <linan666@huaweicloud.com>,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 6:47=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/10/14 5:51, Khazhy Kumykov =E5=86=99=E9=81=93:
> > Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
> > overflow of the final result either, as far as I can tell. So while on
> > x86 we get a DE, on non-x86 we just get the wrong result.
> >
> > (Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
> > calculating wait time"), setting a very-high bps_limit would probably
> > also cause this crash, no?)
> >
> > Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
> > where if the result doesn't fit in u64, we indicate (and let the
> > caller choose what to do? Here we should just return U64_MAX)?
> >
> > Absent that, maybe we can take inspiration from the generic
> > mul_u64_u64_div_u64? (Forgive the paste)
> >
> >   static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy=
_elapsed)
> >   {
> > +       /* Final result probably won't fit in u64 */
> > +       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
>
> I'm not sure, but this condition looks necessary, but doesn't look
> sufficient, for example, jiffy_elapsed cound be greater than HZ, while
> ilog2(jiffy_elapsed) is equal to ilog2(HZ).
I believe 62 is correct, although admittedly it's less "intuitive"
than the check in mul_u64_u64_div_u64()....

The result overflows if log2(A * B / C) >=3D 64, so we want to ensure that:
log2(A) + log2(B) - log2(C) < 64

Given that:
ilog2(A) <=3D log2(A) < ilog2(A) + 1  // truncation defn
It follows that:
-log2(A) <=3D -ilog2(A)  // Inverse rule
log2(A) - 1 < ilog2(A)

Starting from:
ilog2(A) + ilog2(B) - ilog2(C) <=3D X

We can show:
(log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < ilog2(A) + ilog2(B) +
(-ilog2(C)) // strict inequality here since the substitutions for A
and B terms are strictly less
(log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < X
log2(A) + log2(B) - log2(C) < X + 2

So for X =3D 62, log2(A) + log2(B) - log2(C) < 64 must be true, and we
must be safe from overflow.

So... by converse, if ilog2(A) + ilog2(B) - ilog2(C) > 62, we cannot
guarantee that the result will not overflow - thus we bail out.

// end math

It /is/ less exact than your proposal (sufficient, but not necessary),
but saves an extra 128bit mul.

I mostly just want us to pick /something/, since 6.6-rc and the LTSs
with the patch in question are busted currently. :)



>
> Thanks,
> Kuai
>
> > +               return U64_MAX;
> >          return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64=
)HZ);
> >   }
> >
> > .
> >
>

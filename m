Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A204810848
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378282AbjLMCgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjLMCgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:36:00 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31CA1;
        Tue, 12 Dec 2023 18:36:06 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5d8a772157fso56587947b3.3;
        Tue, 12 Dec 2023 18:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702434965; x=1703039765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJCQcb7r494aGVz60o0o8lOol7lfH2OBzDJuV+HIrIs=;
        b=aBFPN/zPIPhezYfvxBP1sc6QWOXjVt3sWHr91leIxMSKbwJtuEDA88qbyHMEg40C3I
         +UfA8TBqvuMHAWKUZPvrjrBpSyWJ5rEIwGmbx2Wh1l32LMn2T0ztpYLF8WcynL2r4C+n
         WjsPntLaXxGUI3E5DSgqUCR1RtLRh2ampd5RC2ZUdRcsBQHiSswPUMNkIxbAPGW8VWYJ
         6pjT9qbF/D1283HdH2ud5H2TBP8yrQEritkPFW7xPZcn9DEezePaibW9YUcF0N0pTsue
         XGC0JIeNWM/jm2Rtj2D6v5eanCqhd+8WAK1CNgsN0G/X8S0jGMlzWiPwloXAMLG3jZkE
         7sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702434965; x=1703039765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJCQcb7r494aGVz60o0o8lOol7lfH2OBzDJuV+HIrIs=;
        b=FWE2biN+yNbA2s6nQ1pZDNZq+hIciUl0uWh84LPmlbzGU6Xf+KCN2PtJ/2u1HDkztg
         cUpNji+vFJ38L3j6UHJpoDwNIAbPdAZWB+Lm6fJfrbNewltVZ9iGI8DrP5zNk4E429TE
         VZdjVNd6aLkbLlQKtImhtyTfiiWWy7o6z/jq6OMSBYJElZHvyyv2eyWefIOosQpEU9mp
         ZGezSI1fQNyJQMFFJbMwQP9ZStnzuiH/zWt0n9vKPwmRr1oUeTJxH8rJjxIx2C4mFdmZ
         6TvhSagfdKZrmM4+YC0sndvHrKTHbhIvH8MSK3YOlyZBYn0bxPA9TIB1xPgAIG0I8yJu
         6cRw==
X-Gm-Message-State: AOJu0YzchfqKu9rsHh4ovgWQ1kOi3DZPbcodzrWqQ8kBjQ/pqWwKGqQZ
        NNo15PkttjMxwzCnqbtcC+c483RoN+1og1py9ik=
X-Google-Smtp-Source: AGHT+IGExh+LXLHKcZjoOkrvuGXryYNCk7SRjtX37wejssSN167lT12Y7mnTyKRoDddeChmH3/xUNSBlFtfMRPWYy5M=
X-Received: by 2002:a81:524f:0:b0:5e2:b0a0:d7e2 with SMTP id
 g76-20020a81524f000000b005e2b0a0d7e2mr201923ywb.41.1702434965401; Tue, 12 Dec
 2023 18:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
 <20231212131031.3088661-3-menglong8.dong@gmail.com> <8a9d03eb74918123615cc3579cefc484566cad5d.camel@gmail.com>
In-Reply-To: <8a9d03eb74918123615cc3579cefc484566cad5d.camel@gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 13 Dec 2023 10:35:53 +0800
Message-ID: <CADxym3a58ALYnJH5HdVZEfgBUeKH3+mH9mHGf6SijxCOzFjD3g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: activate the OP_NE login
 in range_cond()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 13, 2023 at 7:37=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-12 at 21:10 +0800, Menglong Dong wrote:
> > The edge range checking for the registers is supported by the verifier
> > now, so we can activate the extended login in
> > tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to tes=
t
> > such logic.
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 0c9abd279e18..49d8d4bafe99 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range =
x, struct range y,
> >               *newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b)=
);
> >               break;
> >       case OP_NE:
> > -             /* generic case, can't derive more information */
> > -             *newx =3D range(t, x.a, x.b);
> > -             *newy =3D range(t, y.a, y.b);
> > -             break;
> > -
> > -             /* below extended logic is not supported by verifier just=
 yet */
> > +             /* below logic is supported by the verifier now */
> >               if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
> >                       /* X is a constant matching left side of Y */
> >                       *newx =3D range(t, x.a, x.b);
>
> I think that some crafted tests have to be added.
> Note that reg_bounds only runs a subset of tests during CI
> (controlled by variable SLOW_TESTS).
> By default only randomized and crafted tests are run.
> It appears to me that probability of randomly generating specific
> ranges explored by this series is quite low.

You are right, I'll add some cases to the "crafted_cases" for
this logic.

Thanks!
Menglong Dong

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E848107F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378229AbjLMCF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjLMCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:05:57 -0500
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A6EAA;
        Tue, 12 Dec 2023 18:06:03 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5c85e8fdd2dso62557197b3.2;
        Tue, 12 Dec 2023 18:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702433163; x=1703037963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wre/byWt1ayktHNpAoL/v4hhza7PbfuLtf7/RBkwTuo=;
        b=YmBq69xjH2lvuyEz+yQQE9kEm8QH9zF11jrqLCDfX+UmJbFmtaRFzjluHfN6deHtx2
         gizrhMCGlOFExCzNRacGtaxV4PsIat3otgh5lN0YymLmw7nlxl82c+FV3NAZpmt897bQ
         NmNJSC2+tmxKQzvPjBn/E4HLFaQlZ/hBkVoj0sqUKSKD0QDnpld5exqWBzPlKlTsCQHe
         WyjmfMBf3u8rrZp7NkSIOxs4dcBYLXNWQRmxf++TOrxZRLr52c6Sp+hZaLicccDfefFV
         TlbGvy8XdJf3mRIOinWRPJfV/RQa2yWn0BEdqgCv4vNZQaiIR1DxEln19ZR/f8vnMmG3
         0DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702433163; x=1703037963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wre/byWt1ayktHNpAoL/v4hhza7PbfuLtf7/RBkwTuo=;
        b=qDpq/6jI8D7krQeg904Q+gjP2p64O+z9RMivOqcH+bHaLfaAM//MOlPWnnoCV5joKF
         2Apslmd6sOmjI56bDCD37XgEw7e2CTjNiEdRJ/KjhRtqcllwh8gN2pUw1SuvmwB3NwsV
         JLoisBVXFVJNt7gOnKwNZLO9knvhQADM4h9yOsP11Imjs+cawxfr8XcyJZrtUlfFn6lW
         8f+ZTLVMwwG81hutwNuQQS+8X7CzNzocbizUyHLToFvM8nhba7mJjdEJ3FadUFq/BuQ5
         H5gYFRhmYWhv79YUoFZtOz0QIg3Sz9XyUg/zJDi011OXFmH8ICmtFtaEKUYmMKOwW2gR
         iKLw==
X-Gm-Message-State: AOJu0Ywb3LhBJPokgSFtY344jj1IU9yvBm8MaG+uOOEbD8CExfubAslj
        lhbyq1QX3/5s2qUW3Pq0ZMJRNV7qqfGzCy2YQOQ=
X-Google-Smtp-Source: AGHT+IEGFnJQpcNXmXOrtocX0aqjnxWuz4DLGX2XXh5pckHNLlGHFXQY8eroAQE4bAWgzT4zGyTnpdLsz/M+sfMfMmU=
X-Received: by 2002:a5b:d44:0:b0:dbc:cc94:1dd7 with SMTP id
 f4-20020a5b0d44000000b00dbccc941dd7mr389999ybr.56.1702433162899; Tue, 12 Dec
 2023 18:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20231212131031.3088661-1-menglong8.dong@gmail.com> <CAEf4BzavDwxD3=c6Gxo6N9OjN95Bf0bKZ0xMPGCq=nCm8jPzGg@mail.gmail.com>
In-Reply-To: <CAEf4BzavDwxD3=c6Gxo6N9OjN95Bf0bKZ0xMPGCq=nCm8jPzGg@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 13 Dec 2023 10:05:51 +0800
Message-ID: <CADxym3bSfUCJNXHrDkQ1xq=8juxdkuyiAOasqo3FM0hqO1hxBA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] bpf: support to trace BPF_JNE
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Wed, Dec 13, 2023 at 8:00=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 5:15=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, the reg bounds is not handled for BPF_JNE case, which can caus=
e
> > the failure of following case:
> >
> >   /* The type of "a" is u16 */
> >   if (a > 0 && a < 100) {
> >     /* the range of the register for a is [0, 99], not [1, 99],
> >      * and will cause the following error:
> >      *
> >      *   invalid zero-sized read
> >      *
> >      * as a can be 0.
> >      */
> >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> >   }
> >
> > In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0".=
 In the
> > TRUE branch, the dst_reg will be marked as known to 0. However, in the
> > fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> > the [min, max] for a is [0, 99], not [1, 99].
> >
> > In the 1st patch, we reduce the range of the dst reg if the src reg is =
a
> > const and is exactly the edge of the dst reg For BPF_JNE.
> >
> > In the 2nd patch, we just activate the test case for this logic in
> > range_cond(), which is committed by Andrii in the
> > commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester")=
.
> >
> > Changes since v1:
> > - simplify the code in the 1st patch
> > - introduce the 2nd patch for the testing
> >
> > Menglong Dong (2):
> >   bpf: make the verifier trace the "not qeual" for regs
> >   selftests/bpf: activate the OP_NE login in range_cond()
> >
> >  kernel/bpf/verifier.c                         | 29 ++++++++++++++++++-
> >  .../selftests/bpf/prog_tests/reg_bounds.c     |  7 +----
> >  2 files changed, 29 insertions(+), 7 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> +1 to all the feedback from Eduard. Besides that, please target
> bpf-next tree (so, [PATH bpf-next] for subject prefix), thanks!
>

Opps, sorry that I offered a wrong tag......:/

> Also, instead of "verifier traces", I think "verifier tracks" is less
> confusing wording. Tracing within the BPF ecosystem is usually used
> for a completely different meaning.
>

Yeah, sounds better.

> Oh, and just to keep feedback in one place. In patch #2 you have a
> typo in the subject "not qeual" -> "not equal".

Ok, I'll fix it in the next version.

Thanks!
Menglong Dong

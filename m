Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7080FBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377621AbjLMAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377520AbjLMAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:00:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37612BE;
        Tue, 12 Dec 2023 16:00:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso988639966b.1;
        Tue, 12 Dec 2023 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702425650; x=1703030450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaKGNb1VRd5VrDyxiTt9RbEg148bOMoqEkF4ucEMcYQ=;
        b=S9ivD7ZXIqANASyAZdAcw38OJxzPLwjVns1W12tepRBvx1QXzD1KBn5E4VPjIuy6a1
         CgCDXiUjNnq9igmTIyQ6mWdBOdleK1Zt1H/rYbFMD52P4RuRWQ5zzCbExp1oNNONNBDG
         zVgJol/ddV51NZQVXLK+MGMVU1G1yypdZxSmj1jR5b4kh132RcPftwEsu8+gg8HEMgLA
         /YkBKucoCmjArSqps+dNSdg4IkOtwaCEBWeg4aKII8xaIgviSJ3e+9wJRv5ixqCC64dJ
         rYDQ8LU57Nc9h7hbpklLNik1e6DcjGk6VC/vXWOrNG5KemRWCpdB9kFdOnAwoDeGPhi/
         4mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425650; x=1703030450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaKGNb1VRd5VrDyxiTt9RbEg148bOMoqEkF4ucEMcYQ=;
        b=JBt+l9gmXpAFeQ5L2mxN6Tk8VNuOlut9RbG/OZ2qflkzKSqWQlgkxhdlP7PMfFJJXr
         UTqeLlpFa+wVeMJIB7YljMAiZ1PhtzWAxYFv2l4zj2ziSp+4JoaRwNYa87iIL0eu5wzf
         fnntVD3sXJJkHlUr3ZOJuMcYR+SxKPzwT5ZHzp3oRZst/WHPZVjSWtokEhpNKPkO4ye2
         93wsL47f5QxWPiQ2rW/JpaES0fekEL+B7F3YBr6i7vZ3VGF/IJ8nUjcxNUDed/K0l4OT
         MIsU4Pra51q8MVhSCAe5/uKgICb9XDHiQZwFPrK1/gVm3yIgDLrmZuughBWaU+3tlABN
         oQAw==
X-Gm-Message-State: AOJu0Yxp2jz+3EgK01gCjWOr86HQdra1Kj+eNgoeIvnInaiLr1Y6X49p
        vZOQzIwtE4ebE19KN3JMVA3vGIxW3QXJLL+P3s0EIA8rZdk=
X-Google-Smtp-Source: AGHT+IGYW7xzpOkLwqBUER6EDcHRX9iNES/kCZd6cZhJDe/FEx9mz+yAG28v2vFhNXHxL0DlY9zccc8Lg4UK5reXTnI=
X-Received: by 2002:a17:906:101e:b0:a01:ae9a:c1d3 with SMTP id
 30-20020a170906101e00b00a01ae9ac1d3mr7424415ejm.11.1702425650293; Tue, 12 Dec
 2023 16:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
In-Reply-To: <20231212131031.3088661-1-menglong8.dong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Dec 2023 16:00:38 -0800
Message-ID: <CAEf4BzavDwxD3=c6Gxo6N9OjN95Bf0bKZ0xMPGCq=nCm8jPzGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] bpf: support to trace BPF_JNE
To:     Menglong Dong <menglong8.dong@gmail.com>
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

On Tue, Dec 12, 2023 at 5:15=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the reg bounds is not handled for BPF_JNE case, which can cause
> the failure of following case:
>
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
>
> In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0". I=
n the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> In the 1st patch, we reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg For BPF_JNE.
>
> In the 2nd patch, we just activate the test case for this logic in
> range_cond(), which is committed by Andrii in the
> commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").
>
> Changes since v1:
> - simplify the code in the 1st patch
> - introduce the 2nd patch for the testing
>
> Menglong Dong (2):
>   bpf: make the verifier trace the "not qeual" for regs
>   selftests/bpf: activate the OP_NE login in range_cond()
>
>  kernel/bpf/verifier.c                         | 29 ++++++++++++++++++-
>  .../selftests/bpf/prog_tests/reg_bounds.c     |  7 +----
>  2 files changed, 29 insertions(+), 7 deletions(-)
>
> --
> 2.39.2
>

+1 to all the feedback from Eduard. Besides that, please target
bpf-next tree (so, [PATH bpf-next] for subject prefix), thanks!

Also, instead of "verifier traces", I think "verifier tracks" is less
confusing wording. Tracing within the BPF ecosystem is usually used
for a completely different meaning.

Oh, and just to keep feedback in one place. In patch #2 you have a
typo in the subject "not qeual" -> "not equal".

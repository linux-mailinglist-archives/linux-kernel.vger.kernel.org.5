Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684D7CD589
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjJRHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjJRHgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:36:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297BB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:36:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6888a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697614599; x=1698219399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGOiDLW3VFWC4Xzw5e30qGjpOZq8+DCZmmCyhCT1Mvw=;
        b=BnqNpjmOEZKG2f4XAsNgxxiTO4BLx3610gdXCF7jSJUZco/X6Xs8pWx3OVhuzaXJdo
         7S6QvwVUlxjgxwrg3LK9Q/kYEpgpdmA707SNPQKHK5664ee0lB1C+RJbP9DZYSRF0SSh
         0VeWRGeh4tfY2wsEa76dxTmqXO0XGKGP4VeRys0f0BQDNopvppqbSobu+oq0k6ErCGMZ
         yRcfpteVxNwhJ/EtW2i3vs7pq0p0ta6Vr2KvGT3epucKWuRkxYkeWiJjWvnavXDsnofZ
         qhlPr0WlZSgCn1kkDAie+KgXT4rFD2rbREOEVoEd+p+xsmxrMgWBkKdRtNK1j+cVR90Y
         NAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697614599; x=1698219399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGOiDLW3VFWC4Xzw5e30qGjpOZq8+DCZmmCyhCT1Mvw=;
        b=mj4n9LUVq+/xV4nnrK153WsOwOuODG9xHA5yyAQ+o5Ey6YsPqPqjOwpx1IajM+kZMt
         HXUGWVWepp0CMR5GS0VMewvHXc5RFrNbyfUB/tlFKrKXRXFldvUDttQxXQ3EqGf9+N80
         qZmlJq8jVKbIePXLHjlXdKmuYHKyG6VvwOe+ZNDby+Y0lEhodtR1GPW6wOzkj7OgRyIV
         X/36A+1bL693vq33B1advrJ5r5OdIPTBmFe+e2Arbfi2o7gvFEWCmCfY5MF0pfY1qUJV
         5vq3/4mWigD2qfUzDpqspaOMDvvXKK3dQdJfHS5tTsgcgKxRhG1JIZtc5OeTVCWbj7ks
         VGww==
X-Gm-Message-State: AOJu0YwbsMX2fJyYXhJ+tRDahZWp2IPle+JPk1kh+8/veReoy9rE1MHZ
        B7CJU68A+UnEIK9KrcB8PR5OKXErJTsvK9aEcfZk1g==
X-Google-Smtp-Source: AGHT+IFCKidBrEFBgMj08XYuJB9JxEKO4e5KN5VS9O2ntGRCtjIYxb34QimHqbtPRV8+ifUSa/W9VeGmk4HnFSqWWP0=
X-Received: by 2002:a50:ab17:0:b0:53f:2694:c3d4 with SMTP id
 s23-20020a50ab17000000b0053f2694c3d4mr85600edc.4.1697614599277; Wed, 18 Oct
 2023 00:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 18 Oct 2023 09:36:25 +0200
Message-ID: <CANn89iLSKJroojadGD2hvec8EyeUA5TPMKd=PmBzCJ7h2HF0zA@mail.gmail.com>
Subject: Re: [PATCH] amd64: Fix csum_partial_copy_generic()
To:     gus Gusenleitner Klaus <gus@keba.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 18, 2023 at 8:18=E2=80=AFAM gus Gusenleitner Klaus <gus@keba.co=
m> wrote:
>
> The checksum calculation is wrong in case of an source buffer
> containing zero bytes only. The expected return value is 0, the
> actual return value is 0xfffffff.
>
> This problem occurs when a ICMP echo reply is sent that has set
> zero identifier, sequence number and data.
>
> Signed-off-by: Klaus Gusenleitner <gus@keba.com>
> ---
>  arch/x86/lib/csum-copy_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
> index d9e16a2cf285..c8391b4f3dea 100644
> --- a/arch/x86/lib/csum-copy_64.S
> +++ b/arch/x86/lib/csum-copy_64.S
> @@ -44,7 +44,7 @@ SYM_FUNC_START()
>         movq  %r13, 3*8(%rsp)
>         movq  %r15, 4*8(%rsp)
>
> -       movl  $-1, %eax
> +       movl  $0, %eax
>         xorl  %r9d, %r9d
>         movl  %edx, %ecx
>         cmpl  $8, %ecx
> --
> 2.30.2
>

Lets CC Noah Goldstein <goldstein.w.n@gmail.com> (I thought Noah wrote
some kunit tests, maybe I am wrong)

When was this bug added ?

A Fixes: tag is very much needed, and would be a needed step to CC the
original author.

Thanks.

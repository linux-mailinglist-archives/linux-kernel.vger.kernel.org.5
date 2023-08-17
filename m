Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD077EFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbjHQDsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347903AbjHQDsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:48:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26943103;
        Wed, 16 Aug 2023 20:48:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9a2033978so110260531fa.0;
        Wed, 16 Aug 2023 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692244107; x=1692848907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3w6+ValknIZL5F9vEmecXcGoDK6EBlpFUwRFiDyGM0=;
        b=PeGO8Az9u4nPdFtI95aulIUFWaVYVWEkF8cL/dgVQKd6XVONfJ+m9ObksF7hLdYD7w
         UY9JFmS4UFXbHwkMZxI83XW9MszaY98l8u2unq+FJaFM/BS9LEVMPmgoF0M69bOeung9
         z5qR4K+47vH5cDdZLpwUKk/y0k+j8gdcEq9tdT910FgaYIDq53Xc+ntW7fPDCTfM+DHx
         FBagcg6ZeaJd1gn0S2KHLXApjwBAwsUQXzXPNgXvHD/ALj2B380bEXWOnIGZTgurABdD
         V8+rnk5UagN9jw/4Sfaz6ocskmweocXondmDKUpOQ8Wvv4udoPkhhwN/vDKYw9pC9wYN
         uYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692244107; x=1692848907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3w6+ValknIZL5F9vEmecXcGoDK6EBlpFUwRFiDyGM0=;
        b=EVB94PPtEAsrXO2ngvyWBbm6QyDmlSytlEUh2KmKuZBLOcgw6PsD8JyZj43u03Ns5O
         W5JxjFXbQG8tPdcaFMZIqraaKhfDayjtC3BmCCRdN2gzKBUjRlNKgfS7jCPRnWFr1L5H
         prbG1kw7//zJUQC5rncU8h9TnHc1TeFbmhfifPbiuBiMnZ/lJH92LlVK/aoFm8dRR5Be
         A5O9vYVrbhObN4aAJR3UhVuPqkqmMqYOalE0gEsSWvt1YfkyppBeH8SAH0ATOFCKy2hd
         U3ey6FRRKqhvjNzhdC3fd0rkamWRRcuHVYOdO3+gKk7CqG851q+8m6dOtVQzI+Mnh/8K
         wcTA==
X-Gm-Message-State: AOJu0YwGSgBSYy9KuXaxNoM9BOH9XoKeeDuYdcJGNYXrg76Ftk6aEMVH
        iVMjMyQzGYrBTv5yBsEBYQWuay4J4Uoq55jJWHE=
X-Google-Smtp-Source: AGHT+IFHV377ryqduaCsrWxJK5JovByUd2R0rY7H9fKsuYhumQ2znajlM0VmXLcvd6LqALxiECWvWqTCRWPD4+DMTKQ=
X-Received: by 2002:a2e:b609:0:b0:2b6:cff1:cd1c with SMTP id
 r9-20020a2eb609000000b002b6cff1cd1cmr3046851ljn.34.1692244107236; Wed, 16 Aug
 2023 20:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230816150634.1162838-1-void@manifault.com> <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
In-Reply-To: <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Aug 2023 20:48:16 -0700
Message-ID: <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        kernel test robot <lkp@intel.com>
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

On Wed, Aug 16, 2023 at 8:38=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/16/23 8:06 AM, David Vernet wrote:
> > We recently got an lkp warning about missing declarations, as in e.g.
> > [0]. This warning is largely redundant with -Wmissing-prototypes, which
> > we already disable for kfuncs that have global linkage and are meant to
> > be exported in BTF, and called from BPF programs. Let's also disable
> > -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able t=
o
> > reproduce the warning even on W <=3D 3, so I can't actually be 100% sur=
e
> > this fixes the issue.
> >
> > [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/
>
> Okay, I just got a similar email to [0] which complains
>    bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
> missing declarations.
>
> In the email, the used compiler is
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>
> Unfortunately, I did not have gcc-7 to verify this.
> Also, what is the minimum gcc version kernel supports? 5.1?

pahole and BTF might be broken in such old GCC too.
Maybe we should add:
config BPF_SYSCALL
        depends on GCC_VERSION >=3D 90000 || CLANG_VERSION >=3D 130000

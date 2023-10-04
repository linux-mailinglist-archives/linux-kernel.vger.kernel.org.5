Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1821B7B96B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjJDV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjJDV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:56:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BDC6;
        Wed,  4 Oct 2023 14:56:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533df112914so453176a12.0;
        Wed, 04 Oct 2023 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696456592; x=1697061392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/0i1/S5DFSndM3ejN3HqZTrstM7oItSFDz5mhrpE48=;
        b=N9LQFIOkAz0h1JuV9+/UUkvvvy446tZ1rms3tXaVYk0rCA2tySP+VV/6sHjcAFpeES
         7p5/fiQCF2zuq5K+z7M/FlG0Fac58Ej2GTJXPHulvJYj+djU4ro6jKySAz15lpObFAJj
         B4NH5XGYajwtFqG6esYsWchETh55Zk1dt6BVcGOF7MvbinTZ9gO8vJXDG3a2q22l/pEJ
         Rc2XOFkbssxX+XIh0fneSoauimsvxqluOXL8xP+uPg7+8FESqpm7vedh82TpcKOe3hZk
         8HeNlJe7FCPGNZ6tje5BF+wVuhyhXKIs+et7WF1BV72rcBzdmRCHISsbPSum884rGGql
         4D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456592; x=1697061392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/0i1/S5DFSndM3ejN3HqZTrstM7oItSFDz5mhrpE48=;
        b=TldeKvlpEKxdmY+80O6m0eRHJudFql1HxsJns5JNhDddG0E5rZOkumvgHGE8BNhiXu
         gVxalpe9f2Ym9UpwxbYx6GJc2oopd1lGyxw/M8700fxb8MA91MdyH3xuonBlLam2J/DK
         D9ewalkDxZvCZa+Vdy2d2jj8ooXlhl2d+8MGT1k8xQVv/t+W8/VUId2xQ1/7Tup3qtgj
         0I7DLhGy4euZ/+XdsDSgei3oO6vuYETbRqC6SVKvT0niLzatoyFPCmDBfrGi42S8fyEo
         LYTiOUchfE3iQ8jId9Nrkscad/Ogshsz4VMzMLbUYWrKeSyuHpxZEkCTRBAvN+PFh8Wx
         pY2Q==
X-Gm-Message-State: AOJu0YyYjrKD4unpy02pNcidcYIRUirPXMlEvjrGXn0/n8jSIQkUVNfA
        KpCfPYc1rW4IGcq+FC/WJuHm3dBtFtCvWEA1inY=
X-Google-Smtp-Source: AGHT+IFjGd3skafgmsG5968gKGrOoI9IXfhV1Yn4E6WqvADApLDzxQxdRo7aB3GV6KWyqAGCNV1Lk4nFpBah41MVDJg=
X-Received: by 2002:aa7:c607:0:b0:530:7abf:3a84 with SMTP id
 h7-20020aa7c607000000b005307abf3a84mr3026502edq.25.1696456592398; Wed, 04 Oct
 2023 14:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231004204334.3465116-1-irogers@google.com>
In-Reply-To: <20231004204334.3465116-1-irogers@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Oct 2023 14:56:20 -0700
Message-ID: <CAEf4BzaftfOjHCy_tOnXeX7_ZioBwZtKfT-3yvcQ2M9XfzRM-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Align output skeleton ELF code
To:     Ian Rogers <irogers@google.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 1:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
>
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skel=
eton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/gen.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>

CI is not happy still, see [0]

  [0] https://github.com/kernel-patches/bpf/actions/runs/6411371996/job/174=
06696212

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 2883660d6b67..b8ebcee9bc56 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
>         codegen("\
>                 \n\
>                                                                          =
   \n\
> -                       s->data =3D (void *)%2$s__elf_bytes(&s->data_sz);=
     \n\
> +                       s->data =3D (void *)%1$s__elf_bytes(&s->data_sz);=
     \n\
>                                                                          =
   \n\
>                         obj->skeleton =3D s;                             =
     \n\
>                         return 0;                                        =
   \n\
> @@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
>                         return err;                                      =
   \n\
>                 }                                                        =
   \n\
>                                                                          =
   \n\
> -               static inline const void *%2$s__elf_bytes(size_t *sz)    =
   \n\
> +               static inline const void *%1$s__elf_bytes(size_t *sz)    =
   \n\
>                 {                                                        =
   \n\
> -                       *sz =3D %1$d;                                    =
     \n\
> -                       return (const void *)\"\\                        =
   \n\
> -               "
> -               , file_sz, obj_name);
> +                       static const char data[] __attribute__((__aligned=
__(8))) =3D \"\\\n\
> +               ",
> +               obj_name
> +       );
>
>         /* embed contents of BPF object file */
>         print_hex(obj_data, file_sz);
> @@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
>         codegen("\
>                 \n\
>                 \";                                                      =
   \n\
> +                                                                        =
   \n\
> +                       *sz =3D sizeof(data) - 1;                        =
     \n\
> +                       return (const void *)data;                       =
   \n\
>                 }                                                        =
   \n\
>                                                                          =
   \n\
>                 #ifdef __cplusplus                                       =
   \n\
> --
> 2.42.0.609.gbb76f46606-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294FD7B5FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbjJCE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjJCE3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:29:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78588AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:29:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50348c54439so1973e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696307382; x=1696912182; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y9Js+pAcFfNUWfPPAIRNP6iI7Eb6pjWxsOR6R2pNEU=;
        b=ROpCwvPGOGudhTANCiLhdAUpk8nZRHfl+NBWikVrjvdUb7SCCNq8I5/jr2+xGovNj7
         L6aCyW6MdbP0WNTHFRFJXd2p4kDWUjDY6vPwgLq+ksmAH/YJeAX5gq9AvasvW87icf5w
         /Do5YKcSJualnYS6rZIqFSFIw+ZB7/JvVQabbwbH5vX6f+6nba0AK0tKDOJUpyDy/mHF
         6uTESAlLyinoRvrWINXiA+v+39EanWD6uS6rQbbjNxNbPTQsGUDNmUI/QFmNyi7Nc8KH
         s06qOtW1V1nIip5rcUzBZP1+HJx6AtctOVpTnYPre1hUWt28czoaLdcxLlQOQychU5vL
         Inhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307382; x=1696912182;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y9Js+pAcFfNUWfPPAIRNP6iI7Eb6pjWxsOR6R2pNEU=;
        b=iGp26Bi7nFF2bukepkoSW4j21MCHF4Cg9EXFDEBxLhiqeX7fupFKszLT+SVIIZgz9k
         L2fRJyXORqw0SJZi9nwDZFXAaVzuaJzjj+eKaVDq70f67A1oVTcQgZPtJcTOACQ3n8nq
         UF1S9VWyD68UuFH69E+XabJ8TM9pYHrRtXNdR7uYZmFGI6p6DVb9O/3UkKresxn98G/T
         NV1dHr+fPYRCXoa9d2qnFRPo0YtT8rswcuRp9oiw+XYPwyBFoQr6OEWb/q2wSRtrEJ2N
         tWIjmlgnc5oLR85UwLYxq79WI1m5DohOF7KoA8RIVG4lZh0XSF0LqQADkSjqlLNMmnCj
         kEvw==
X-Gm-Message-State: AOJu0Yz9bHeJGoVdJZwzEKIjAnPmY/FHcvQaq9/3f+YTzhFTg/7POMDC
        2lQJoHipOwSFMrNf0mCtYWgd3Nm9yMvmwqThPNpbdw==
X-Google-Smtp-Source: AGHT+IF2l/kPSCizOfppxnDy2kjAdT9nG3HM0xcm3P3O5GuGnoP6CwxyNXsUeLNb19p+Ixj6ayjU3LNyhj9UGML3LJc=
X-Received: by 2002:ac2:4e6c:0:b0:501:a2b4:8ff5 with SMTP id
 y12-20020ac24e6c000000b00501a2b48ff5mr29738lfs.7.1696307381734; Mon, 02 Oct
 2023 21:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231002223219.2966816-1-irogers@google.com>
In-Reply-To: <20231002223219.2966816-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 Oct 2023 21:29:29 -0700
Message-ID: <CAP-5=fWmxKHLGnQqBjUb8MZFak6YaKMPGKKWwBiCc6XWZbVPDw@mail.gmail.com>
Subject: Re: [PATCH v1] bpftool: Align output skeleton ELF code
To:     Quentin Monnet <quentin@isovalent.com>,
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 3:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array, use sizeof
> on the array, less one for the \0 terminator.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Perhaps this could have a fixes tag:
Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog
load" and "gen skeleton" command.")

The unaligned problem was seen in perf's offcpu code as well as bcc's
libbpf_tools. I didn't see problems with map data and opts data, but
inspection of the code shows they likely have the same issue. I was
testing with -fsanitize=3Dalignment and
-fsanitize-undefined-trap-on-error.

Thanks,
Ian

>  tools/bpf/bpftool/gen.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
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
> 2.42.0.582.g8ccd20d70d-goog
>

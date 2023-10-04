Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E17B7614
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjJDBEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDBEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:04:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250CA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:04:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50348c54439so1424e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696381474; x=1696986274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDROeYS7kKQ9JBkO/Lcgw1FtJFr3f8I5Bb8UdoQeU9E=;
        b=4iNDhCJXerx0tDlyemthkgWRxboelcftjUXqifWJEw9a11Kix612e7SkmzKpFylv6e
         x6EUvAZGrP/FjAAwtU0FKXeVHP5i+FZVDgt5SURini50IC/rFwcI5v2y4FS0TrO6DJSm
         Ebbp4FlFbdg05hOtmkLd4M49lpr2snvpi59ABpAkJt/JoSQu+KhcGXzff8PqRv3mO/oj
         MCbgP36uIozbZzsjnf1L1LHH0TpRrrklRkSmNw/yTAaoocIQZrnb78fePsKtzRggln+/
         Pk/D/laQF2+LkGQuY84ObuLU5skAbneRS7gDtIis8A927kKVFlG+g2ULz5EKlxCLFvxR
         z6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381474; x=1696986274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDROeYS7kKQ9JBkO/Lcgw1FtJFr3f8I5Bb8UdoQeU9E=;
        b=BBZGbQR2IHszZ5X2vie/pI0ewpfmKcyYmeXYI0Ws0yfhXaWNRW3upysKDYgWRRBkZz
         qkxtsu5tLY0CVecVZKRYoMKVfXWcZ+F44G3wBjgdKzKqVhnrYzEj7O7uZ/fpKsfLeYNU
         aAlfFCo2ZPhdoUSK0P1noKPAAPDgZ4vbiD+AHkIt6glAhGC9hBvlvFIbrO670ExPbaHZ
         qTmjU+8d0DlkDl2IkCIbuG+oSxIEV+CFE6zpvsbTEjsaK6ArVrDWnaCcklfCH/Z0964j
         GKzqbdTTkuzEfbUHqGsR8kimw+e2/Yujr0PwonakMKNsa/BNByW3gDt+vaC7HB/jThq5
         O2EA==
X-Gm-Message-State: AOJu0Yw3+EoO6N8pNobS/goMv5m9H8pfWEK+fKokVMu1G2w6uAM9sMre
        kKV8c4tp7MfRf335fJf52FLMqYin8+OJ4nzop40g+A==
X-Google-Smtp-Source: AGHT+IFuf7Tmw3woGvoApNA+OPt8erI0o1qzHN6zXADXVzDaRrfxrRqUc0JVHyx1dBdDnEk0rOqIl/3eM0GTqkcWZQI=
X-Received: by 2002:ac2:44d1:0:b0:505:6e12:9e70 with SMTP id
 d17-20020ac244d1000000b005056e129e70mr32852lfm.6.1696381473439; Tue, 03 Oct
 2023 18:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231003191412.3171385-1-irogers@google.com> <CAEf4BzYiayepsmABmVjhCgYoy4VZMFya6vYOhWQqx4Zt5+w+Sg@mail.gmail.com>
In-Reply-To: <CAEf4BzYiayepsmABmVjhCgYoy4VZMFya6vYOhWQqx4Zt5+w+Sg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 Oct 2023 18:04:22 -0700
Message-ID: <CAP-5=fWh+_be34JpaLYFTHwHOp67ttQh3TtWEjZ-JyKRdSwHpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpftool: Align output skeleton ELF code
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Tue, Oct 3, 2023 at 5:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 3, 2023 at 12:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > libbpf accesses the ELF data requiring at least 8 byte alignment,
> > however, the data is generated into a C string that doesn't guarantee
> > alignment. Fix this by assigning to an aligned char array. Use sizeof
> > on the array, less one for the \0 terminator, rather than generating a
> > constant.
> >
> > Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing sk=
eleton's embedded ELF data")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
>
> See CI failures ([0]). You messed up tabs somewhere.
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/6397510833/job/1=
7365616392?pr=3D5756

Thanks, I messed up (also) somewhere else in patch 2/2 as I broke some
Google code. Working on a v3.

Ian

>
> >  tools/bpf/bpftool/gen.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 2883660d6b67..b8ebcee9bc56 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
> >         codegen("\
> >                 \n\
> >                                                                        =
     \n\
> > -                       s->data =3D (void *)%2$s__elf_bytes(&s->data_sz=
);     \n\
> > +                       s->data =3D (void *)%1$s__elf_bytes(&s->data_sz=
);     \n\
> >                                                                        =
     \n\
> >                         obj->skeleton =3D s;                           =
       \n\
> >                         return 0;                                      =
     \n\
> > @@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
> >                         return err;                                    =
     \n\
> >                 }                                                      =
     \n\
> >                                                                        =
     \n\
> > -               static inline const void *%2$s__elf_bytes(size_t *sz)  =
     \n\
> > +               static inline const void *%1$s__elf_bytes(size_t *sz)  =
     \n\
> >                 {                                                      =
     \n\
> > -                       *sz =3D %1$d;                                  =
       \n\
> > -                       return (const void *)\"\\                      =
     \n\
> > -               "
> > -               , file_sz, obj_name);
> > +                       static const char data[] __attribute__((__align=
ed__(8))) =3D \"\\\n\
> > +               ",
> > +               obj_name
> > +       );
> >
> >         /* embed contents of BPF object file */
> >         print_hex(obj_data, file_sz);
> > @@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
> >         codegen("\
> >                 \n\
> >                 \";                                                    =
     \n\
> > +                                                                      =
     \n\
> > +                       *sz =3D sizeof(data) - 1;                      =
       \n\
> > +                       return (const void *)data;                     =
     \n\
> >                 }                                                      =
     \n\
> >                                                                        =
     \n\
> >                 #ifdef __cplusplus                                     =
     \n\
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >

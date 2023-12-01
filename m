Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2A801811
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjLAXuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLAXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24810D54;
        Fri,  1 Dec 2023 15:50:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00f67f120aso381293666b.2;
        Fri, 01 Dec 2023 15:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701474618; x=1702079418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFUGo0PQsn1/kJSh+5sohX4OjpVDcSqvtXQ5CgJtBJw=;
        b=ZT5HGoF83VgZbKieavGgTdXpWm401aNpXPNi+5e8P5bzNCsOxSemq4jMIwrxNKOIB8
         0IbxDYfIAfXFlFajqSQ9BIT1YdwINASXAJbIv/4y4RI7MdBYpq4tf6emEm1GwI/rJ+M8
         zVSrXW8/b/q4xjpKTTZBnMKuNv1zKDfCxmh6gJ+qHvW54zwLyvedqF2tAj8mcy0SRrNP
         B7/3RVzw/6/Ka1lNSJhNCE3P9Zc3GEJDLSVPl4FKXrOK+MzjxjU4ssWObxveNHhV5rEn
         k+fHFRL9SJcJaooRoYVUuxm2b9C1YA6HuhlbAAeMdMIJ1/UEwrPVWpLZUrmxu6R8FETl
         InSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474618; x=1702079418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFUGo0PQsn1/kJSh+5sohX4OjpVDcSqvtXQ5CgJtBJw=;
        b=PbjbKKvjvKR9n9O9wMca+FWo4mg61todiMqLkW/iitzWhdXLawHrIwC77Ykb3xUXaX
         JddY/U1LR9M3hvy2F/HnzNBATV7Ch2Lb0ahP5HaoVSva/JpoHOaxCShoxmFfAQ3GqH19
         jYIDqpKpc3UXq1RS7oX5UT2H7snhF3eLl0GmH1HjeGUZMgFDCRn8Xp7S+ax2ZK6QImMU
         EIg661mhztFx0H7u03Xb/Q4FAHMFJxXPGboS+pd+uP/iPpaHc7z4WWsdp5D++h3+WHN/
         MnU52giiRFSLAnKnkdwxxnXOARgCGSzDLAKPfJYMfkMvAguE9zfC82zkZWOWyhLMbvVA
         MauQ==
X-Gm-Message-State: AOJu0YyAO/qDzieHajtfvSIeaRasIi5t5sT/Pfcn56EyNlq6Zwl+vRSU
        JIaFdokSfJykzHPrCBUsN0Ig442COcLSlniIyic=
X-Google-Smtp-Source: AGHT+IF4xrsSNbZaNj/H+0+WreINN4EYpqXyPlVf9bDtdHDmq2SLULkZhcpPM0wXDLY6D6hFaLMIfbZSF2D3iQpj3TM=
X-Received: by 2002:a17:907:3dac:b0:a03:a857:c6e0 with SMTP id
 he44-20020a1709073dac00b00a03a857c6e0mr1865751ejc.77.1701474618457; Fri, 01
 Dec 2023 15:50:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701462010.git.dxu@dxuuu.xyz> <68419933c552bd30e92d432e287ce91deb3ed52e.1701462010.git.dxu@dxuuu.xyz>
In-Reply-To: <68419933c552bd30e92d432e287ce91deb3ed52e.1701462010.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Dec 2023 15:50:06 -0800
Message-ID: <CAEf4Bzasuzsb_5ShPoZaDwPn5yvArD5Rj9j5W7GoRSK+=xkrfQ@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v3 4/9] bpf: selftests: test_loader: Support
 __btf_path() annotation
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        andrii@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
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

On Fri, Dec 1, 2023 at 12:24=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds support for per-prog btf_custom_path. This is necessary
> for testing CO-RE relocations on non-vmlinux types using test_loader
> infrastructure.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
>  tools/testing/selftests/bpf/test_loader.c    | 7 +++++++
>  2 files changed, 8 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 799fff4995d8..2fd59970c43a 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -71,6 +71,7 @@
>  #define __retval_unpriv(val)   __attribute__((btf_decl_tag("comment:test=
_retval_unpriv=3D"#val)))
>  #define __auxiliary            __attribute__((btf_decl_tag("comment:test=
_auxiliary")))
>  #define __auxiliary_unpriv     __attribute__((btf_decl_tag("comment:test=
_auxiliary_unpriv")))
> +#define __btf_path(path)       __attribute__((btf_decl_tag("comment:test=
_btf_path=3D" path)))
>
>  /* Convenience macro for use with 'asm volatile' blocks */
>  #define __naked __attribute__((naked))
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index a350ecdfba4a..74ceb7877ae2 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -27,6 +27,7 @@
>  #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv=3D"
>  #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
>  #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
> +#define TEST_BTF_PATH "comment:test_btf_path=3D"
>
>  /* Warning: duplicated in bpf_misc.h */
>  #define POINTER_VALUE  0xcafe4all
> @@ -58,6 +59,7 @@ struct test_spec {
>         const char *prog_name;
>         struct test_subspec priv;
>         struct test_subspec unpriv;
> +       const char *btf_custom_path;
>         int log_level;
>         int prog_flags;
>         int mode_mask;
> @@ -288,6 +290,8 @@ static int parse_test_spec(struct test_loader *tester=
,
>                                         goto cleanup;
>                                 update_flags(&spec->prog_flags, flags, cl=
ear);
>                         }
> +               } else if (str_has_pfx(s, TEST_BTF_PATH)) {
> +                       spec->btf_custom_path =3D s + sizeof(TEST_BTF_PAT=
H) - 1;
>                 }
>         }
>
> @@ -578,6 +582,9 @@ void run_subtest(struct test_loader *tester,
>                 }
>         }
>
> +       /* Implicitly reset to NULL if next test case doesn't specify */
> +       open_opts->btf_custom_path =3D spec->btf_custom_path;
> +
>         tobj =3D bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts)=
;
>         if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
>                 goto subtest_cleanup;
> --
> 2.42.1
>

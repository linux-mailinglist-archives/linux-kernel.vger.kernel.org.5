Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A27571DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGRCkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRCk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:40:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B9189;
        Mon, 17 Jul 2023 19:40:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so8360208e87.3;
        Mon, 17 Jul 2023 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689648026; x=1692240026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cran8qgdQ9kbuzPnsHeCd+k7q1iRuxP3B3YP8nMjL34=;
        b=U/kWRP5EPDxi3j6sixpCB8+OuOPpd9nWrMYLmj9PwHbkg+iahW80idm3Ga5IgyP5t1
         S+YjKI3tcP4ByLSaXlDPN4Z/hY+yfT8F4zVsI7xTrbiAE8M7ELEBT9Ur8Zix9BlqanRj
         Z2lKwQKNr9UXTEXmVQadJb9iAwJ9wi8PBk53lXkklL3dHFlJRmRxMxw6j/6wB3yzPQJY
         VSTpoKccWdU3kKv3a2u/DaLs01aaGHiHsJ0rPJjWIMNe2GVIJWj4P1911ZHhfyrTY/Xx
         Xw6PHRYmef3lIhSQQpcWYHun8CzMc4+gztbVP8b7L9WBByFbX0GIpYc8CA8xXh2Pn88B
         wzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689648026; x=1692240026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cran8qgdQ9kbuzPnsHeCd+k7q1iRuxP3B3YP8nMjL34=;
        b=R+glik5MxoPB9ZNGqAgy2WPn4myu11zJdwmsBjoDpVTq41gTLnRtj0kHvm711WEGHp
         2YoccWwKupm66Y5PLmOH1xZzr7aLUeXqr1V+K49MP0fTmd68amQZ7Uz9qXbyPU/hhua/
         uj2+hbxU207InFNECMHiuopPCzqanUjiflHNFeWm+ag7PGkoJ0uCXcFsST4RVau4Kktd
         5vmuiNobZk23eRZSVhSeZpj9StpViaNLcM+1Cj67EmYkh/xEi4FXnTETeFFaTTT/zpyG
         f15Z789v88ET6rjvWs6dDSPrflu17PmJlcafKq3MZ/DCAoEgMBfgcHUDYRFaqWBVGVx7
         SAYw==
X-Gm-Message-State: ABy/qLa2AY1znxgmN4tSLHBcgHAni4OGUmMqwET7Ftne6T+KT+4qsD7D
        mnz4s4lqI3hywh7YsrImteDkPsUVI47I/ngqEjs=
X-Google-Smtp-Source: APBJJlGdZyV3Emffg0WnmEtnrU4uNkwMNeHhptUht0XrvrI3U4XBTQBd9vciTXhRsDxjLQXolD8bGNjqkf+TMbIGXl0=
X-Received: by 2002:a05:6512:234a:b0:4fb:8b2a:5e09 with SMTP id
 p10-20020a056512234a00b004fb8b2a5e09mr9821535lfu.43.1689648025397; Mon, 17
 Jul 2023 19:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <168960739768.34107.15145201749042174448.stgit@devnote2> <168960741686.34107.6330273416064011062.stgit@devnote2>
In-Reply-To: <168960741686.34107.6330273416064011062.stgit@devnote2>
From:   Donglin Peng <dolinux.peng@gmail.com>
Date:   Tue, 18 Jul 2023 10:40:09 +0800
Message-ID: <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
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

On Mon, Jul 17, 2023 at 11:24=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Move generic function-proto find API and getting function parameter API
> to BTF library code from trace_probe.c. This will avoid redundant efforts
> on different feature.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/btf.h        |    4 ++++
>  kernel/bpf/btf.c           |   45 ++++++++++++++++++++++++++++++++++++++=
++
>  kernel/trace/trace_probe.c |   50 +++++++++++++-------------------------=
------
>  3 files changed, 64 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cac9f304e27a..98fbbcdd72ec 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -221,6 +221,10 @@ const struct btf_type *
>  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>                  u32 *type_size);
>  const char *btf_type_str(const struct btf_type *t);
> +const struct btf_type *btf_find_func_proto(struct btf *btf,
> +                                          const char *func_name);
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_p=
roto,
> +                                          s32 *nr);
>
>  #define for_each_member(i, struct_type, member)                        \
>         for (i =3D 0, member =3D btf_type_member(struct_type);      \
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..e015b52956cb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1947,6 +1947,51 @@ btf_resolve_size(const struct btf *btf, const stru=
ct btf_type *type,
>         return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL,=
 NULL);
>  }
>
> +/*
> + * Find a functio proto type by name, and return it.
> + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> + */
> +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *=
func_name)
> +{
> +       const struct btf_type *t;
> +       s32 id;
> +
> +       if (!btf || !func_name)
> +               return ERR_PTR(-EINVAL);
> +
> +       id =3D btf_find_by_name_kind(btf, func_name, BTF_KIND_FUNC);
> +       if (id <=3D 0)
> +               return NULL;
> +
> +       /* Get BTF_KIND_FUNC type */
> +       t =3D btf_type_by_id(btf, id);
> +       if (!t || !btf_type_is_func(t))
> +               return NULL;
> +
> +       /* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +       t =3D btf_type_by_id(btf, t->type);
> +       if (!t || !btf_type_is_func_proto(t))
> +               return NULL;
> +
> +       return t;
> +}
> +
> +/*
> + * Get function parameter with the number of parameters.
> + * This can return NULL if the function has no parameters.
> + */
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_p=
roto, s32 *nr)
> +{
> +       if (!func_proto || !nr)
> +               return ERR_PTR(-EINVAL);
> +
> +       *nr =3D btf_type_vlen(func_proto);
> +       if (*nr > 0)
> +               return (const struct btf_param *)(func_proto + 1);
> +       else
> +               return NULL;
> +}
> +
>  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
>  {
>         while (type_id < btf->start_id)
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c68a72707852..cd89fc1ebb42 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -371,47 +371,23 @@ static const char *type_from_btf_id(struct btf *btf=
, s32 id)
>         return NULL;
>  }
>
> -static const struct btf_type *find_btf_func_proto(const char *funcname)
> -{
> -       struct btf *btf =3D traceprobe_get_btf();
> -       const struct btf_type *t;
> -       s32 id;
> -
> -       if (!btf || !funcname)
> -               return ERR_PTR(-EINVAL);
> -
> -       id =3D btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> -       if (id <=3D 0)
> -               return ERR_PTR(-ENOENT);
> -
> -       /* Get BTF_KIND_FUNC type */
> -       t =3D btf_type_by_id(btf, id);
> -       if (!t || !btf_type_is_func(t))
> -               return ERR_PTR(-ENOENT);
> -
> -       /* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> -       t =3D btf_type_by_id(btf, t->type);
> -       if (!t || !btf_type_is_func_proto(t))
> -               return ERR_PTR(-ENOENT);
> -
> -       return t;
> -}
> -
>  static const struct btf_param *find_btf_func_param(const char *funcname,=
 s32 *nr,
>                                                    bool tracepoint)
>  {
> +       struct btf *btf =3D traceprobe_get_btf();

I found that traceprobe_get_btf() only returns the vmlinux's btf. But
if the function is
defined in a kernel module, we should get the module's btf.

-- Donglin

>         const struct btf_param *param;
>         const struct btf_type *t;
>
> -       if (!funcname || !nr)
> +       if (!funcname || !nr || !btf)
>                 return ERR_PTR(-EINVAL);
>
> -       t =3D find_btf_func_proto(funcname);
> -       if (IS_ERR(t))
> +       t =3D btf_find_func_proto(btf, funcname);
> +       if (IS_ERR_OR_NULL(t))
>                 return (const struct btf_param *)t;
>
> -       *nr =3D btf_type_vlen(t);
> -       param =3D (const struct btf_param *)(t + 1);
> +       param =3D btf_get_func_param(t, nr);
> +       if (IS_ERR_OR_NULL(param))
> +               return param;
>
>         /* Hide the first 'data' argument of tracepoint */
>         if (tracepoint) {
> @@ -490,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type=
(
>         const struct btf_type *t;
>
>         if (btf && ctx->funcname) {
> -               t =3D find_btf_func_proto(ctx->funcname);
> -               if (!IS_ERR(t))
> +               t =3D btf_find_func_proto(btf, ctx->funcname);
> +               if (!IS_ERR_OR_NULL(t))
>                         typestr =3D type_from_btf_id(btf, t->type);
>         }
>
> @@ -500,10 +476,14 @@ static const struct fetch_type *parse_btf_retval_ty=
pe(
>
>  static bool is_btf_retval_void(const char *funcname)
>  {
> +       struct btf *btf =3D traceprobe_get_btf();
>         const struct btf_type *t;
>
> -       t =3D find_btf_func_proto(funcname);
> -       if (IS_ERR(t))
> +       if (!btf)
> +               return false;
> +
> +       t =3D btf_find_func_proto(btf, funcname);
> +       if (IS_ERR_OR_NULL(t))
>                 return false;
>
>         return t->type =3D=3D 0;
>
>

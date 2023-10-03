Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15757B747F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJCXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:06:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02CAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:06:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c136ee106so268182466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696374401; x=1696979201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BED3t2aRrxtx0D0q4ZEBs+ApkSmWh8HJDsZNXZO2H1E=;
        b=TJhdldhY/lq5NAoTeyNdXfSWa2OwK0PBlKYQII4OhYv7/eTz26t8J7BnCKJSEH40JC
         +BpPvq7HOxdk3r3JFa17jtKJPJ1ZfLa+FWbBrO6pHWiH4UsLrP/KH6t5xbzPEQtgVHTR
         Tj2nxh+2AtYbqzcAlpUM6LJBBDFwet6JXVB1WfrQ9N0rO6oUPIPqsIllni53MFANCRMq
         FfU7UKZfAs4EWCv5uOISuUtguyUISA/C9JPm5SnKjkbFGUmYYAHESoxyhhZCxjl/ZwDz
         cVAGW7c4uS9XDYb4NsdexcnD1lxc6r8BYsVQNhMr4aBsAYoBGAJXKrgNATKVcZGfflbu
         HcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374401; x=1696979201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BED3t2aRrxtx0D0q4ZEBs+ApkSmWh8HJDsZNXZO2H1E=;
        b=ruIUQbMtwXPcdCFQs59bMc1m33AojBLkUBrM+J9aTm26c3C5QFXWmJKi/geUmPrWw3
         HUjSvR6x5IPYxLfSXX3mzGKzwx6r7V/kcR1vX7as+EB+zfMB158k9ap2jJwzAbq/73+N
         yTazfajWqtq42RwvQmDrgqHhGeNUgYr7g+xW2kXY7fJK8+3Y3ps2Dn4V66jSW1qSjIB6
         q4mhpc+n4tzDmGdkA8R7C/GHhRct1ByjB2iVyiz03/vDWKUEi6buUiFz9qRybaMrSIe5
         AAzLGEvNmR5XSIUNEn6cxPOrCLqGbvIbItfk1DeVIXVgr/1CuA1lmYk7Af2IpKeFq9x/
         C6bw==
X-Gm-Message-State: AOJu0YwcvUd48aiypEcwA80bavCEjMF3/vwdMW8VgzUs9Z8QSPFC0oqR
        nwZu8PdP37EMFlAAdrMDYAVZx1D8ftiuaSnfHjYejQ==
X-Google-Smtp-Source: AGHT+IHB2pzA3bg1Fesj416efcT1N1xTYVtbEVVGRJW14+RdrX8v8VDBTH1EuOSCUOzjyMf3H2XQMrs2+N3Lkip4XW8=
X-Received: by 2002:a17:906:74cc:b0:99b:ead0:2733 with SMTP id
 z12-20020a17090674cc00b0099bead02733mr593265ejl.72.1696374400964; Tue, 03 Oct
 2023 16:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230929180611.work.870-kees@kernel.org> <20230929180746.3005922-5-keescook@chromium.org>
In-Reply-To: <20230929180746.3005922-5-keescook@chromium.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 16:06:28 -0700
Message-ID: <CAFhGd8pCJa=qevxwhtQDvXMwdhF-33fV87m90GGaUFkOa6eRuA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mlxsw: spectrum_span: Annotate struct mlxsw_sp_span
 with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Sep 29, 2023 at 11:08=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_span.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Great patch!

Crucially, span->entries_count is assigned before any flexible array
accesses.

        span->entries_count =3D entries_count;
        ...
        for (i =3D 0; i < mlxsw_sp->span->entries_count; i++)
                mlxsw_sp->span->entries[i].id =3D i;


Reviewed-by: Justin Stitt <justinstitt@google.com>

>  drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/driver=
s/net/ethernet/mellanox/mlxsw/spectrum_span.c
> index b3472fb94617..af50ff9e5f26 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> @@ -31,7 +31,7 @@ struct mlxsw_sp_span {
>         refcount_t policer_id_base_ref_count;
>         atomic_t active_entries_count;
>         int entries_count;
> -       struct mlxsw_sp_span_entry entries[];
> +       struct mlxsw_sp_span_entry entries[] __counted_by(entries_count);
>  };
>
>  struct mlxsw_sp_span_analyzed_port {
> --
> 2.34.1
>
>
Thanks
Justin

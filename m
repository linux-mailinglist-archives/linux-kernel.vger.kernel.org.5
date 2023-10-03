Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4117B7487
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJCXNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:12:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA32AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:12:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b281a2aa94so267345466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696374775; x=1696979575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaFpiEY5JH4xoOaWyLud8W3R/SAnqW0FuICHPBykSfM=;
        b=RS7hKJEP6pS2DPmYR+PYIf76iLY/l1jcZLAVMMKX1ld9HBXOjQaFMOgKbki/hJGMaq
         15DAR6wTs7VpZVG1jDCEvwLbKNHKfYXzeDw58AlhgXbodM26FU77UPATIFub97um+WPE
         UDYCFGp3MsSytxBx5sCFdBYLQzo9TlAkrMHKUjm2ti8w+B9PXgBQz9+4Eo/qScylulPx
         vyU0WxaIJ0eMYlYpZJ0V0oo0gGzRe0Tccae1Gk1L+MMYMYXvTNgceTW4aRWiOYNYTrbH
         SRMrTndo7QPYBHRc0kMBMCGm6cLFOu4qgRkGQYbl/Xx5FWbvNw/hVLKq+tGGvVxRZwlH
         VzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374775; x=1696979575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaFpiEY5JH4xoOaWyLud8W3R/SAnqW0FuICHPBykSfM=;
        b=t0IXvNpWZwx8vQ7I6CBpk8JPNl/gz1QgqGzawzqj45iFF57ZgjNc6kxXAAKcJtUsDN
         FtjE45fS/xsoT6jgtvtoterbN5WEeDDXuxXWGAsaFcnksjzh+rquEjl5XuBqnYNyXsYQ
         WcWI2GIMvCWlG0N/oKbS/gYCLfUkiKZhL0jMvU7h9BtkGcNm8uVecdb1PMUj1pZUhAdo
         ylpuTT18K0uUyfv+DdQl/RH7le59NZEKUP6mErRRTrke06NnhmyMRrwbB6PV7dLUKo9s
         QkbC8kMJ/c7prCACpRkRKhHTqMIneDipZmZ+St+LNZLIXNMbxw8T8p2kf4UPizns6H9X
         aWzg==
X-Gm-Message-State: AOJu0YyCfPKwYV6GZHYPYYVEDwLdbL8wtUqWfnrlQ9rQhJmA+b/4QA5O
        mSQMx8RXox9v6M5RRMYbHfx78EXRTJBiHbcBnMIGhQ==
X-Google-Smtp-Source: AGHT+IGIAv1B8l7PPJwCoeN7f0g0yeR5LZROzHms5LHhhlU7a5bSwRk1Gpmtk7Zd8a8qWTdhzqWf4oRXEPk/0ORHwv0=
X-Received: by 2002:a17:906:76cf:b0:9b2:a7e5:c47 with SMTP id
 q15-20020a17090676cf00b009b2a7e50c47mr577019ejn.9.1696374774622; Tue, 03 Oct
 2023 16:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230929180611.work.870-kees@kernel.org> <20230929180746.3005922-4-keescook@chromium.org>
In-Reply-To: <20230929180746.3005922-4-keescook@chromium.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 16:12:42 -0700
Message-ID: <CAFhGd8oKZEhWhv=C3FZHH3D3DLevKONV+VdVLLpS1U8JFF3bvg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mlxsw: spectrum_router: Annotate struct
 mlxsw_sp_nexthop_group_info with __counted_by
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
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_nexthop=
_group_info.
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

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/driv=
ers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index debd2c466f11..82a95125d9ca 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -3107,7 +3107,7 @@ struct mlxsw_sp_nexthop_group_info {
>            gateway:1, /* routes using the group use a gateway */
>            is_resilient:1;
>         struct list_head list; /* member in nh_res_grp_list */
> -       struct mlxsw_sp_nexthop nexthops[];
> +       struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
>  };
>
>  static struct mlxsw_sp_rif *
> --
> 2.34.1
>
>
Thanks
Justin

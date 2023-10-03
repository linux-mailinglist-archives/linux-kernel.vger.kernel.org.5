Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94FA7B74C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjJCXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJCXVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:21:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513C3B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:21:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso2570774a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375278; x=1696980078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NEDkCvEYEdfp18YGZL4PXY8c/uK5lT9K+U1l2rQw9o=;
        b=KwtW/htcSF8wCE1h1q9KJuNnION/f7zBC5ccXE8vL6QPJ5nnQICxb9+2b0a3tinhmF
         kwJXD7NdV4pnskp8PpnlUbaojPNdi/wZQtz0o02DaGyd5wnmc4lhkmUj9X1Ou3yktij+
         qIOoMehggHBFBiUshyuh1jbFaZ6K3Y8esKhKvBYDXyuL1QyF0IJtVXiviJ3+qE2rGb3x
         PpQ+eV36T/POgtKQK7r3mXgUTqT8HsQv2RInH3VjF3G+KDd1lBj04nF9acIt3V8cOhGS
         +6VYUI7xVuTOJILbCyL1jxI4xCB26dClhtwqVI/Qx07ZDOx2W4Q1edjzgG/kiptL3ETp
         aWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375278; x=1696980078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NEDkCvEYEdfp18YGZL4PXY8c/uK5lT9K+U1l2rQw9o=;
        b=QFZgaw7Lu2y4JbibgPry6f0Ktxj916GwUXOZngs+hnhiMPdbA61e5ePMCfP6Xs9cxq
         +RNpM2OthAce7W6cJI9bKd+wSZKoR+OA36eksXObUsRHBTXk7jTbAnnhrtkVLHtqbTev
         eCV3o0uBsihFKRflBzr2c7lIqHpE5Mj6PDgPC3003sPLthq8yhEp3V3IfSpHwxgh/pd5
         wDZRA/nuOB7LYx8o2PouDOfzDOMN5OzYdzLjQsWJZQ58tw6OPUDnLBJDKGN3iQ7SLY32
         8xHuW5PRvRPskvHpP9taCT88LXp1XMSvYHdtiJrrMOGLxtu9MaFRaxvdnwe0oOTYLW8y
         1xpA==
X-Gm-Message-State: AOJu0Yym/c3mvPpUd/4EMUOWexjhbCsejHit2xHJmCi4bXxCtR8FNkod
        RBrmyqhLWeYUkYKrLbh4n9jLFMvHGOr+bc5I+wgf4A==
X-Google-Smtp-Source: AGHT+IG0gPECXGw9A/gIAqloUi1ngSn5XzFSHXVfzJRfB8/udSmpuXSq+v3fUnb1mtCR9QBgn9maksQ6/PKW4YpLkUs=
X-Received: by 2002:a17:906:3ca1:b0:9ae:55f5:180a with SMTP id
 b1-20020a1709063ca100b009ae55f5180amr594658ejh.9.1696375277697; Tue, 03 Oct
 2023 16:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231003231718.work.679-kees@kernel.org>
In-Reply-To: <20231003231718.work.679-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 16:21:05 -0700
Message-ID: <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 4:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> index 17fe30a4c06c..0c26d707eed2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> @@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
>         u32 base_id;
>         int bulk_len;
>         unsigned long *bitmask;
> -       struct mlx5_fc fcs[];
> +       struct mlx5_fc fcs[] __counted_by(bulk_len);
>  };

This looks good.

`bulk->bulk_len` is assigned before flexible array member `fcs` is accessed=
.

        bulk->bulk_len =3D bulk_len;
        for (i =3D 0; i < bulk_len; i++) {
                mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
                set_bit(i, bulk->bitmask);
        }

Reviewed-by: Justin Stitt <justinstitt@google.com>
>
>  static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *b=
ulk,
> --
> 2.34.1
>
>
Thanks
Justin

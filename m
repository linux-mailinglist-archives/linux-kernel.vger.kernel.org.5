Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A977FFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355216AbjHQVVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355253AbjHQVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:21:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7A136
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:21:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso3542971fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692307282; x=1692912082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeALbQx5LxBzM1MS6Rc6ll0OcowbkB9LP6Bj9ouPlmM=;
        b=r2BSbs41E3psTG4zlT/6L4I1b03YBb00iebZ40WnpKqoJsQeLxPfPQILffi9Isyt5e
         DIAVRDMitsROKjFFg3zhKIC+75cxN7MgdkMHAYGTrmznmd8R9V1sCiqNtee8tSYUfeSl
         4hKjJOjZEuseG3873Mdya5l9Gp+7HLExt39/BpyyUJW1zPbOpY3gKT8d7WqGKybcnRJs
         1uV0k7CPsgeOlVT6rg1yHqnyvtLLIoKU8/rWyCAs2KW/5dTrSBdx9Ketg27aOdMT/b+0
         M/OJMmfqEyolSVetziGgawKhRc2djgMRUPxbYf3jNXN+mfm3IZJOpYUdwyfLi7tWGbtx
         NeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307282; x=1692912082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeALbQx5LxBzM1MS6Rc6ll0OcowbkB9LP6Bj9ouPlmM=;
        b=FS9majtbLDWNRsE2hQAnH30Ews6wnTvCvTVF6bJg0DJ3A/cB7u2RE8kPev++pU/7ji
         0AqcpQ0/hSe2a5t8glwryD8Idpr8QHM3vrBfW/ZmuuGvULp6Ijp4+beAW4PNzXToN9Zt
         2iLzc1RSnHqkeFAxnJFrvE+5dNLcSawEvwn2phaWkm4Kl26J7u9ngUMKW8k21tYFxqkG
         tG7soWCYixTtihBA/fAvv05Y+kFJiJggsZ12sFwp8QeVnipce+dl1tF2Z6pfw3PaUypu
         BqCDFYJngBVfl59y3j7tXz9xWCs9mH83Hei2HplqgBVCka446zG00R2vz5FQUM1lNd+V
         tNqw==
X-Gm-Message-State: AOJu0YzfcMG71Dk4V2gEumbnZ8s3VeEE6R/1KyXoFO1eK31XVN5ZIVpf
        MNfTqVewxwTkM5OGBfvknwCguWZj+qzeUqBy9TMbUw==
X-Google-Smtp-Source: AGHT+IF/wiTT9wIP3+3ZHZmD8p/Ah3L5qulD8+FJwJ+Q2KQcVBd0I/M4ovMbQFsOqVAG3uMWNbarBRjmU6goY9fjd54=
X-Received: by 2002:ac2:5226:0:b0:4ff:8aa7:185c with SMTP id
 i6-20020ac25226000000b004ff8aa7185cmr347546lfl.7.1692307281523; Thu, 17 Aug
 2023 14:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230817211114.never.208-kees@kernel.org> <20230817211531.4193219-1-keescook@chromium.org>
In-Reply-To: <20230817211531.4193219-1-keescook@chromium.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 17 Aug 2023 14:21:10 -0700
Message-ID: <CAFhGd8ra6vpUvLc_Z7zRA8kVOzu7=o6b6vFL+QvcGi34-nVmFg@mail.gmail.com>
Subject: Re: [PATCH 1/7] wifi: cfg80211: Annotate struct cfg80211_acl_data
 with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Thu, Aug 17, 2023 at 2:16=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct cfg80211_acl_dat=
a.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/net/cfg80211.h | 2 +-
>  net/wireless/nl80211.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..eb73b5af5d04 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1282,7 +1282,7 @@ struct cfg80211_acl_data {
>         int n_acl_entries;
>
>         /* Keep it last */
> -       struct mac_address mac_addrs[];
> +       struct mac_address mac_addrs[] __counted_by(n_acl_entries);
>  };
>
>  /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 8bcf8e293308..80633e815311 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4889,13 +4889,12 @@ static struct cfg80211_acl_data *parse_acl_data(s=
truct wiphy *wiphy,
>         acl =3D kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNE=
L);
>         if (!acl)
>                 return ERR_PTR(-ENOMEM);
> +       acl->n_acl_entries =3D n_entries;
>
>         nla_for_each_nested(attr, info->attrs[NL80211_ATTR_MAC_ADDRS], tm=
p) {
>                 memcpy(acl->mac_addrs[i].addr, nla_data(attr), ETH_ALEN);
>                 i++;
>         }
> -
> -       acl->n_acl_entries =3D n_entries;
>         acl->acl_policy =3D acl_policy;
>
>         return acl;
> --
> 2.34.1
>

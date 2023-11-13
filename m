Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12F27E9696
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKMGFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjKMGFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:05:48 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A045171C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 22:05:45 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45d955fcabdso1167564137.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 22:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699855544; x=1700460344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O4c7eDef50yyoJSsJxpIFGb81PUKkG+p7ugALAq5oE=;
        b=alD1CbcfNklR2Y1bKOHRgTcq78zMhmatAMwwRl905bGP/73+ZEtpFjkrbxzrGeoRSt
         FqKk4KMcqKbRVfdEZnU1dlLJfV+F2w32rVS/e4tRyLS7gK8SszsQ3qKkaTqg2KtyS+DM
         rT0NWRkrHqlo2IykDMpHTk1Q/XqL+FhFgUx5QEFlmjuXTKSF7dYW5QnAaAJO6ePYvEhv
         uER+wzVw+kDe1AD4ZRIZcBaeeIAm1YaMn0Ef/6RcSIiw3+z/sl2WiPHq4kgWuCnkAzeP
         8yJOp5xUbXvL3jYeh3j/r9XBoCYQYBPgf0wgPLBVrqGCIVaFHj5ueLrVFUOHq17eYCeT
         hd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699855544; x=1700460344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O4c7eDef50yyoJSsJxpIFGb81PUKkG+p7ugALAq5oE=;
        b=mrZqmq58fJhQGXZU/1nANTY/u3WkNFUgVL/Tt1rqEm9iGDyb9/fyvcMB0qiu6BX9Fh
         PtOg3ViG+a4XDkEKTsVKqZ5dpbf8S2B0jNygaymCDH5DsSjVKFqUyBwOVLkGB1SDr7wA
         /GvhiCtBYdIqg0WB72tbaVLkqc0r+aMM2qlSBt3FDCgpl+3QqZ3zjI+SSXdBvif7tGF3
         Z8fuQHvpO2aGyL5zUFH1i73UTQG3tyfPI2xl+oDDof4DKsKlQtNBwrx1C+9h/FNurAgu
         VaJQhdVCyLPJjeZRuxnAYN3HG3HuwnHDCTX+pjlYV8uQqarIX+fNgA+kGhEpidxjHYWZ
         nAMA==
X-Gm-Message-State: AOJu0Yxc2JHOFANQ+1sAeNhQJ6FwRV3q10TLpJFuWxbtAHStKJqS1KzA
        Zy44UjYxZhFO1L+obmT1tjsCcCpitEK3ydWqRe7axg==
X-Google-Smtp-Source: AGHT+IEzmDvkwRkaQiM0DAzYdV0kX0ZDqS9InenhAVr/MpvpHQQqRmx4Go8bctNEzwdfIOZ4RbhEG1ddlIqUfdGfcuo=
X-Received: by 2002:a05:6102:2c04:b0:45e:f8af:79c1 with SMTP id
 ie4-20020a0561022c0400b0045ef8af79c1mr2667348vsb.31.1699855544082; Sun, 12
 Nov 2023 22:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com> <20231110151935.0859fd7a@kernel.org>
In-Reply-To: <20231110151935.0859fd7a@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 12 Nov 2023 22:05:30 -0800
Message-ID: <CAHS8izN7MydkJPaHfj7Pw0V+xoDBkCmEVTc1TH24=hjXm98xnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:07 -0800 Mina Almasry wrote:
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> > +#include <net/page_pool/types.h>
> > +#include <net/page_pool/helpers.h>
>
> >  /**
> >   * DOC: skb checksums
> > @@ -3402,15 +3404,38 @@ static inline void skb_frag_off_copy(skb_frag_t=
 *fragto,
> >       fragto->bv_offset =3D fragfrom->bv_offset;
> >  }
> >
> > +/* Returns true if the skb_frag contains a page_pool_iov. */
> > +static inline bool skb_frag_is_page_pool_iov(const skb_frag_t *frag)
> > +{
> > +     return page_is_page_pool_iov(frag->bv_page);
> > +}
>
> Maybe we can create a new header? For skb + page pool.
>
> skbuff.h is included by 1/4th of the kernel objects, we should not
> be adding dependencies to this header, it really slows down incremental
> builds.
>

My issue here is that all these skb helpers call each other so I end
up having to move a lot of the unrelated skb helpers to this new
header (maybe that is acceptable but it feels weird).

What I could do here is move all the page_pool_page|iov_* helpers to a
minimal header, and include only that one from skbuff.h, rather than
including all of net/page_pool/helpers.h

--=20
Thanks,
Mina

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6F7E965B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjKMEyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMEye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:54:34 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E75173E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:54:30 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b9dc928868so903745241.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699851269; x=1700456069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulZUsxBjy/DYiq3mQzgGs9wuxEBLqLXZ1LrWDxA7qvo=;
        b=EpHpwcNa5850JC9ptPMc0rHEkmfFb//UmLZu6w4Zq62rCeX7YhQRh6151JLwbnNaqW
         FUBdTkFdrs8j+xIk1QpbfS95rXXzKa9Y8Su+L+EVSoep1a6MzC8GhTz1OJKX16uNIkoU
         oGxtrVmrXKfPnD/eXZmdQgK053n9cA07QVfIwiFQrqK0rr2N9sO1xKWjL09OxX74whju
         /y3ixDqG9xME0+Jh4drr1niRwhUJMsr3IZa4+IgCm36lSaMnsA5ZdU7wepg4/84iSmtq
         KWpRNM4BpAg6x+GqqgTmaxwvbUYTxUGr/Fqv9+HSFryVJX3oTVR8tvI8JNRLEmbo4JBh
         HUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699851269; x=1700456069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulZUsxBjy/DYiq3mQzgGs9wuxEBLqLXZ1LrWDxA7qvo=;
        b=iOe9PETX/ztnK4aRQDD++e0+GVlY6WrhbTnSXRe4QQ3K3KUgob+Xh3aYYboib+qaqZ
         6NKDj8yn9wgasOjiu03eziUF6rIGpYpABjbWxKp1ZV6vth91JzRzxZmuhGPh8YcbvmFH
         mdnE96p3PMZfEyC4kYHiNfqDnx5d0LlR/12z6Sq/AfNXNDllSHkWb6xU2uh9phnI1duO
         v3xvrqew750GtDTf7NBzjiU5s7bEHEZ7jJMntQ5XNYfs9Vl+DaX5pPli9rLURh7Mo1vN
         pdTyBG5xG4b2nzZHiKF9z3EwdcoAdw4aUtn6YX21IfMlLWUKYzq4Q1UInSVKBKqhcymr
         CSkg==
X-Gm-Message-State: AOJu0YxABLPsLb006j9NH1UIGwtD52Cb59OLzHOAvFtLqdtOassoTjNK
        DplLnbAThieb7Ff+i6CQmRdRkeuly0XR4f8tJXK6SA==
X-Google-Smtp-Source: AGHT+IGBugYmcwQCmYo3XhrW53vx7SnsNtkGBEWopCzRD+dofX6GN+L1OxYsj2HtZsztRRSBDJnHEIwyfhi7gc94JeA=
X-Received: by 2002:a67:ab0d:0:b0:45f:4e67:4420 with SMTP id
 u13-20020a67ab0d000000b0045f4e674420mr2062262vse.2.1699851269262; Sun, 12 Nov
 2023 20:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-7-almasrymina@google.com> <20231110151622.2f45f618@kernel.org>
In-Reply-To: <20231110151622.2f45f618@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 12 Nov 2023 20:54:18 -0800
Message-ID: <CAHS8izMGNLM18TF1RCDBfdOXXpqseePA4_27qmQt-FsrFzGfdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
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
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:05 -0800 Mina Almasry wrote:
> > +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> > +{
> > +     struct netdev_dmabuf_binding *binding =3D pool->mp_priv;
> > +
> > +     if (!binding)
> > +             return -EINVAL;
> > +
> > +     if (pool->p.flags & PP_FLAG_DMA_MAP ||
> > +         pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> > +             return -EOPNOTSUPP;
>
> This looks backwards, we should _force_ the driver to use the dma
> mapping built into the page pool APIs, to isolate the driver from
> how the DMA addr actually gets obtained. Right?
>
> Maybe seeing driver patches would illuminate.

The full tree with driver patches is here:

https://github.com/torvalds/linux/compare/master...mina:linux:tcpdevmem-v3

This is probably the most relevant patch, it implements POC page-pool
support into GVE + devmem support:

https://github.com/torvalds/linux/commit/3c27aa21eb3374f2f1677ece6258f046da=
234443

But, to answer your question, yes, this is a mistake. devmem doesn't
need to be mapped, which is why I disabled the flag. Actually what
should happen is like you said, we should enforce that PP_FLAG_DMA_MAP
is on, and have it be a no-op, so the driver doesn't try to map the
devmem on its own.

--=20
Thanks,
Mina

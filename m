Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792EA80AD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574677AbjLHTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:31:10 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01B1712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:31:16 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c82eb9e95aso480583241.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702063875; x=1702668675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWu+J+wzMOcih150vf6YNmhjcZNaZMBMCrHoJTVq0Uw=;
        b=AA19aOJzqgtW3RV80AFQwVMChqnhyx3dotQVTb0hrBmAlbNUmsuBTJtMrljDDTaPE4
         UT2XZXwwEhyL6RvaC5iWygV0PrrojOamdQDwSsldkfSAMM7VJCtSIzBuUePJhJzEMdpX
         CPGh4gECrlJoIIISE5H4oez9KZbbP2rZerJwxtlHukbw8x1DHD6xfCD40QWJNSF2TTZv
         jyd/PaV6H4EEWDsI8Bemrygg75E84QrYgetKO+iTPy9VQtZwScDXn3sfczLGri9aGHpp
         7vil7CrYcYmsqEFV7IMvKlG6rg+3CTnia8RBmcwiGoSy+xuGXcA38kRCZHFSMQWuS23S
         tl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063875; x=1702668675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWu+J+wzMOcih150vf6YNmhjcZNaZMBMCrHoJTVq0Uw=;
        b=KQY81VobONsz7tv0nkIHXplEemcueDS5es1vQenLE+BBhFeB1icHyeBbV5i70mN+a3
         ReZR0g55B1x2AOq05LDFtag2jQskfNtV/oI8N+QR5y83qHlyll1eIGnxUvn+B04zrNyy
         F0Bo2sszhBJk9pvCQSG5u0WCVW+JiNMPuqyI/GuNqDWiCNZCckAob+vymZZ4s9gw19H8
         8NcoVLck9CLxRaqd/e3tFNAhScMvnGrqk+wxF7fLOgYmMK3/AdfUY7Nhs8V/wd95eh3N
         U8Czff3ADQnO7giaqcEIMJzpi9vi/vVPk0bZAHuTVLUmI+u0onZ3PUJ2iPstrrzmnksP
         yduA==
X-Gm-Message-State: AOJu0Yz3GZpwI4ClV1Llly/rc6xL8MS3BUOqzcq1lWJ3Dla/vPw+3TN1
        urFnH/wqpf4wNkJmElVzbnQRlQjmlMsRIjaHtLQnoA==
X-Google-Smtp-Source: AGHT+IEWy2ZoASGB97Xf4UzepNASdfhsiRufEtATUoKuaLdGqOq89E4y/cKAIuTMSGCSkffzh0Lc4oz7kiKBOoq4yro=
X-Received: by 2002:a05:6102:3ec4:b0:464:40b2:e59f with SMTP id
 n4-20020a0561023ec400b0046440b2e59fmr628329vsv.32.1702063875124; Fri, 08 Dec
 2023 11:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com> <3fea9ae9-e9e6-4ba5-812b-2775a6ed9e6a@kernel.org>
In-Reply-To: <3fea9ae9-e9e6-4ba5-812b-2775a6ed9e6a@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 8 Dec 2023 11:31:01 -0800
Message-ID: <CAHS8izOc05jQEhU+s6FZtBN4fynUwVPrKsXBtjYo-X8fHQXOjg@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To:     David Ahern <dsahern@kernel.org>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 9:57=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/7/23 5:52 PM, Mina Almasry wrote:
> > Major changes in v1:
> > --------------
> >
> > 1. Implemented MVP queue API ndos to remove the userspace-visible
> >    driver reset.
> >
> > 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
> >
> > 3. Removed RFC tag.
> >
> > Many smaller addressed comments across all the patches (patches have
> > individual change log).
> >
> > Full tree including the rest of the GVE driver changes:
> > https://github.com/mina/linux/commits/tcpdevmem-v1
> >
>
> Still a lot of DEVMEM references (e.g., socket API). Any reason not to
> move those to DMABUF?
>

In my mind the naming (maybe too silly/complicated, feel free to correct) i=
s:

The feature is devmem TCP because we really care about TCPing into
device memory. So the uapi/feature name retains devmem.

dmabuf is the abstraction for devmem that we use. In theory someone
can come up with a driver that doesn't like dmabuf and uses something
else instead, and the devmem TCP support can be extended to support
that something else. Functions that handle specifically dmabuf and are
not generic to support general devmem are named accordingly
(netdev_alloc_dmabuf/netdev_free_dmabuf)

page_pool_iov is a generic type to support generic non-paged memory,
functions that are supposed to handle any generic non-paged memory and
named accordingly (page_pool_iov_get_many).


--=20
Thanks,
Mina

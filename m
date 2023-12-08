Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D780ACE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjLHTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574687AbjLHTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:23:11 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3E1998
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:23:16 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7cac4a9c5b5so142869241.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702063396; x=1702668196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNuhxRDBfdQenk+uC5+I+2o2Yad/2wCHUso1pH85sfo=;
        b=puGdxYqAoQo3bHG294LrXUJmKf0r2uufNMehZOj/ib8lgIMoVsopaKC4B4b6fUFyya
         +B9rAwaP7t2N4ealA6hhXjhKtZfHcQqR6mND4Wm8Bn+OcwAWZPIz8cpOBRc9eMDbClhr
         m0HzrbjSOx0Odg45PVXWbTCRw/nXU3Cn7nmp3mL+o1poKncrgSXhF/YFLuLQHGoSStQf
         RrJGwyuzvUNDUEsmKjSD2uxYZ/BCYB8G86AaueFaliWGMcb/21OR7QeKm0LdzJc1VKhI
         29fSLZU9MNVBk7gsWs++emPmOErx0U5NoIpQDDk2xKmI0xt174+doddUkTq2O/QdtbwO
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063396; x=1702668196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNuhxRDBfdQenk+uC5+I+2o2Yad/2wCHUso1pH85sfo=;
        b=fTXQF+y2dOV1LYC/syRfXbtA1raEeYFFJvmoT4PLroPXcC9Mn8NIGOdsN5JOelZi7C
         tsg6pRq8XUQhoEOM70bCEozJh0YnrTU0jXiUlVtFT9Te7CRXj/0qeIbsUGngrYoXO/lR
         fxxFRRdB+0DHOF/meANYrN2zOXDYH+5hzlIN4/edtbCkToqgXJa9tdxnIZEIFu3ALGpA
         8dZqtHltZJklJFzcJRuUdZoje5ezpLc67Acr12nE45LmtEbpu6OlzYmx2vDrnt3DdNSF
         VgX1iB165yyKl3eMPt7wrZuH8UslHhSjKuDs5/G3O2kANgvhORLdC6ajMkXzFif9FLJ/
         i26g==
X-Gm-Message-State: AOJu0Yz2sxJSAlt7J4f2HqRG/fA95rx9t6H/q/48u2uxr2O8olJGBCiN
        SpGhEI10mcP+zRYcMa2MYK4b/objJU8BZ4DnHAAiVA==
X-Google-Smtp-Source: AGHT+IHb22ZjibDls1yBkhF7QNEaIMpgDSaJZ0OHWa3jb0vnzr6qisUp6akF/Nl59oBqhH37DmVgAI0o7BDgdz/1wpc=
X-Received: by 2002:a05:6102:38ce:b0:465:e3df:13a with SMTP id
 k14-20020a05610238ce00b00465e3df013amr837357vst.9.1702063395773; Fri, 08 Dec
 2023 11:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-14-almasrymina@google.com> <dd47a2a4-cb80-4164-8855-045999931a8e@kernel.org>
In-Reply-To: <dd47a2a4-cb80-4164-8855-045999931a8e@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 8 Dec 2023 11:23:04 -0800
Message-ID: <CAHS8izPwkARkYjPYPY2t-5H=XFTdn=NcWk0EwiCycThR5xFmtg@mail.gmail.com>
Subject: Re: [net-next v1 13/16] tcp: RX path for devmem TCP
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
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
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

On Fri, Dec 8, 2023 at 9:55=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/7/23 5:52 PM, Mina Almasry wrote:
> > In tcp_recvmsg_locked(), detect if the skb being received by the user
> > is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVME=
M
> > flag - pass it to tcp_recvmsg_devmem() for custom handling.
> >
> > tcp_recvmsg_devmem() copies any data in the skb header to the linear
> > buffer, and returns a cmsg to the user indicating the number of bytes
> > returned in the linear buffer.
> >
> > tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> > and returns to the user a cmsg_devmem indicating the location of the
> > data in the dmabuf device memory. cmsg_devmem contains this information=
:
> >
> > 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> > 2. the size of the frag. 'frag_size'.
> > 3. an opaque token 'frag_token' to return to the kernel when the buffer
> > is to be released.
> >
> > The pages awaiting freeing are stored in the newly added
> > sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> > This reference is dropped once the userspace indicates that it is
> > done reading this page.  All pages are released when the socket is
> > destroyed.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v1:
> > - Added dmabuf_id to dmabuf_cmsg (David/Stan).
> > - Devmem -> dmabuf (David).
> > - Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
> > - Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).
> >
> > RFC v3:
> > - Fixed issue with put_cmsg() failing silently.
> >
>
> What happens if a retransmitted packet is received or an rx window is
> closed and a probe is received where the kernel drops the skb - is the
> iov reference(s) in the skb returned to the pool by the stack and ready
> for use again?

When an skb is dropped, skb_frag_unref() is called on the frags, which
calls napi_pp_put_page(), drops the references, and the iov is
recycled, yes.

--=20
Thanks,
Mina

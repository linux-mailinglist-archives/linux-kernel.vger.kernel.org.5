Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D622F763314
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGZKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjGZKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE9DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690365761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDfW0dmn1wBVyEER/+9+5+Wl00jeHHLFDEF6erd932c=;
        b=G+gp26ZLTw8PFZJNH+MLmO5BSxPucbuWe0Pb5l+YI8AfnhyclHJ+U5AiKRBFS4PmuDBYgA
        6FHS9RXCr23UpoFW87rHjXfoId+Df6IOKMpHrE83YfavqevUC5Xnqsk5DbbwlNG7F5guCT
        aDFwoTHalLP8uRMsTERe/lnMrhBD+nI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-1rUVqYpbMc2hCszCV5PfWA-1; Wed, 26 Jul 2023 06:02:40 -0400
X-MC-Unique: 1rUVqYpbMc2hCszCV5PfWA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-997d069a914so435247466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365759; x=1690970559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDfW0dmn1wBVyEER/+9+5+Wl00jeHHLFDEF6erd932c=;
        b=gCiWaqdwv6/iJzMwfrtkSggLysz75rF//JyFfYcr/7oUbsITIM1GBn6H9YbOATt1Dz
         ARTNA+o3CJwPU55Iqt3iIFBeOeCD/IWkbFaeXNLe3Rr+Y2vtO8FFD3eYkyOQfO1rP1JS
         MqksuNi8r3td7IOcQ+9hK4Ir0YNxBzR8yuHlLxu9K0B+Ry+ULtHdH/5wyR6Pd4aK0AUv
         AArxo2TjRJvNQG24xACruadRQ68XE8Ys5qOGHDZWN0xdpy7huSa9wrUEuDQ11SE3bcCV
         /Ri4sH69w5LtPve5PqJFcEGF1W9ypBsBnBO/980X+X55rPI9X9a/jCDMZjHYv4g8UsJH
         JmbQ==
X-Gm-Message-State: ABy/qLbL8zuBd7EC05jKqatcarwpILA/wYb6ouPiLjprnncEJx5q0MBd
        fWoITWWKN4pRt1eQwJ1t9szifq4WwNZG3skgQ8/Ak9X/R8zVIy3xHKuQEsY+Ab3uHxugyCd/rqL
        2TOiMBMaepO7wQ4Wxwfc/sPeF
X-Received: by 2002:a17:907:a056:b0:994:19:133b with SMTP id gz22-20020a170907a05600b009940019133bmr1122946ejc.14.1690365759246;
        Wed, 26 Jul 2023 03:02:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBSi7S84npQ6k3cQ5CS4OeynkocAoq83S5js72Husbbhk2ptQBqCWgr4yvb/+hN+aI97TDLw==
X-Received: by 2002:a17:907:a056:b0:994:19:133b with SMTP id gz22-20020a170907a05600b009940019133bmr1122930ejc.14.1690365758856;
        Wed, 26 Jul 2023 03:02:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b0098e34446464sm9349068ejx.25.2023.07.26.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:02:37 -0700 (PDT)
Date:   Wed, 26 Jul 2023 06:02:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 0/4] virtio/vsock: some updates for MSG_PEEK
 flag
Message-ID: <20230726060150-mutt-send-email-mst@kernel.org>
References: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:29:08PM +0300, Arseniy Krasnov wrote:
> Hello,
> 
> This patchset does several things around MSG_PEEK flag support. In
> general words it reworks MSG_PEEK test and adds support for this flag
> in SOCK_SEQPACKET logic. Here is per-patch description:
> 
> 1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>    1) I think there is no need of "safe" mode walk here as there is no
>       "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>       queue).
>    2) Nested while loop is removed: in case of MSG_PEEK we just walk
>       over skbs and copy data from each one. I guess this nested loop
>       even didn't behave as loop - it always executed just for single
>       iteration.
> 
> 2) This adds MSG_PEEK support for SOCK_SEQPACKET. It could be implemented
>    be reworking MSG_PEEK callback for SOCK_STREAM to support SOCK_SEQPACKET
>    also, but I think it will be more simple and clear from potential
>    bugs to implemented it as separate function thus not mixing logics
>    for both types of socket. So I've added it as dedicated function.
> 
> 3) This is reworked MSG_PEEK test for SOCK_STREAM. Previous version just
>    sent single byte, then tried to read it with MSG_PEEK flag, then read
>    it in normal way. New version is more complex: now sender uses buffer
>    instead of single byte and this buffer is initialized with random
>    values. Receiver tests several things:
>    1) Read empty socket with MSG_PEEK flag.
>    2) Read part of buffer with MSG_PEEK flag.
>    3) Read whole buffer with MSG_PEEK flag, then checks that it is same
>       as buffer from 2) (limited by size of buffer from 2) of course).
>    4) Read whole buffer without any flags, then checks that it is same
>       as buffer from 3).
> 
> 4) This is MSG_PEEK test for SOCK_SEQPACKET. It works in the same way
>    as for SOCK_STREAM, except it also checks combination of MSG_TRUNC
>    and MSG_PEEK.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Head is:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a5a91f546444940f3d75e2edf3c53b4d235f0557
> 
> Link to v1:
> https://lore.kernel.org/netdev/20230618062451.79980-1-AVKrasnov@sberdevices.ru/
> Link to v2:
> https://lore.kernel.org/netdev/20230719192708.1775162-1-AVKrasnov@sberdevices.ru/
> 
> Changelog:
>  v1 -> v2:
>  * Patchset is rebased on the new HEAD of net-next.
>  * 0001: R-b tag added.
>  * 0003: check return value of 'send()' call. 
>  v2 -> v3:
>  * Patchset is rebased (and tested) on the new HEAD of net-next.
>  * 'RFC' tag is replaced with 'net-next'.
>  * Small refactoring in 0004:
>    '__test_msg_peek_client()' -> 'test_msg_peek_client()'.
>    '__test_msg_peek_server()' -> 'test_msg_peek_server()'.
> 
> Arseniy Krasnov (4):
>   virtio/vsock: rework MSG_PEEK for SOCK_STREAM
>   virtio/vsock: support MSG_PEEK for SOCK_SEQPACKET
>   vsock/test: rework MSG_PEEK test for SOCK_STREAM
>   vsock/test: MSG_PEEK test for SOCK_SEQPACKET
> 
>  net/vmw_vsock/virtio_transport_common.c | 104 +++++++++++++-----
>  tools/testing/vsock/vsock_test.c        | 136 ++++++++++++++++++++++--
>  2 files changed, 208 insertions(+), 32 deletions(-)
> 
> -- 
> 2.25.1


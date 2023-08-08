Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC60774660
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHHSzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHHSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15565F87D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691514542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
        b=avwz/xZMkjdLbjhGmTA4m/bbUD6FSABrHrPpr1qJwl91lhReX4yIkgoG8k4OXfCuxKv81x
        pT+vvDC847wEfN9vSslLj2ETskkSi70Qsmya4lrJ0vBbI/jGvgo2MO2BLiobc7yGXjk7rU
        dbwfqkG6zGEyi+twya95HnWWAiOrakY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-7ZqijftWMCWuDAdQWtcejg-1; Tue, 08 Aug 2023 08:01:08 -0400
X-MC-Unique: 7ZqijftWMCWuDAdQWtcejg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c0fb2d4b0so418895166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691496068; x=1692100868;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
        b=hchMAPQ0xECIpEwvq19xL7Wkl8Y/o7VMutmvWM8b3MzxtxAiojqQ7s7ISg5d1bXfaJ
         WZY1tyrlOQUSa7h8o7Bc5nIAsnDyUy9Sa8NxOr70udoEStsMZsTWeYKHWLf6MuRIlCf9
         6CZrWNFk8kcmNWvrA0o5OaipTN1qb8YNcCOhhFFb3YGJEdgPIKHCPwWhw3buQJ7+1+9m
         L7WG64PeJzY8t0epDB0bVyEziqjeXeK3MD3/fTfji2ynJXiN3kDni9/Wz/oOTq5aRfdD
         qUjyEPAMcvkrW67PQ1MC5xzzTIdO+2KGNxtguEjP/EUqeeyhGT1wzgIGNJxG95ViQfk0
         s87g==
X-Gm-Message-State: AOJu0Yz9gqI/GZpXtQXrEJR6f5LoLzthunNZ0nmjaDsQBnbVI6Ex9+PD
        8tginieFxLqBDclKc12BwnL9twL9dEMGBUQ6ztoGR8oZHy2knABvoHk5J7FIqFO3Ub7lg55bTI/
        EWGozsPLng174GwC/Zh8hcfWL
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542750ejv.40.1691496067598;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExprTRWssJI7svYIKpAk9QD7eZgNMMaCHszU1opQzSkcMk4JdoidE7FYhHnoUzGicOwYlHMA==
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542716ejv.40.1691496067077;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm6538145ejb.97.2023.08.08.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:01:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9617D255EA; Tue,  8 Aug 2023 14:01:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC v3 Optimizing veth xsk performance 0/9]
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Aug 2023 14:01:04 +0200
Message-ID: <87v8dpbv5r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Huang <huangjie.albert@bytedance.com> writes:

> AF_XDP is a kernel bypass technology that can greatly improve performance.
> However,for virtual devices like veth,even with the use of AF_XDP sockets,
> there are still many additional software paths that consume CPU resources. 
> This patch series focuses on optimizing the performance of AF_XDP sockets 
> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
> Patch 5 introduces tx queue and tx napi for packet transmission, while 
> patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
> add support for AF_XDP tx need_wakup feature. These optimizations significantly
> reduce the software path and support checksum offload.
>
> I tested those feature with
> A typical topology is shown below:
> client(send):                                        server:(recv)
> veth<-->veth-peer                                    veth1-peer<--->veth1
>   1       |                                                  |   7
>           |2                                                6|
>           |                                                  |
>         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>                   3                    4                 5    
>              (machine1)                              (machine2)    

I definitely applaud the effort to improve the performance of af_xdp
over veth, this is something we have flagged as in need of improvement
as well.

However, looking through your patch series, I am less sure that the
approach you're taking here is the right one.

AFAIU (speaking about the TX side here), the main difference between
AF_XDP ZC and the regular transmit mode is that in the regular TX mode
the stack will allocate an skb to hold the frame and push that down the
stack. Whereas in ZC mode, there's a driver NDO that gets called
directly, bypassing the skb allocation entirely.

In this series, you're implementing the ZC mode for veth, but the driver
code ends up allocating an skb anyway. Which seems to be a bit of a
weird midpoint between the two modes, and adds a lot of complexity to
the driver that (at least conceptually) is mostly just a
reimplementation of what the stack does in non-ZC mode (allocate an skb
and push it through the stack).

So my question is, why not optimise the non-zc path in the stack instead
of implementing the zc logic for veth? It seems to me that it would be
quite feasible to apply the same optimisations (bulking, and even GRO)
to that path and achieve the same benefits, without having to add all
this complexity to the veth driver?

-Toke


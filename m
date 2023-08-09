Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCE7753E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjHIHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHIHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:14:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A702D210E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:14:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so77058581fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691565239; x=1692170039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJc4D+pWFIMKl1qw8oGjynYOM6/qtbfYWHBOBDcE408=;
        b=F6l1lQMO2CuYyzSt7qfaHFoNCWlWGk+xh4H8Z0whKt8T+fBaENkv+d/rgaMfAWfDo0
         U1YdBws1rKhASov+2t65UG0XCkCtMWkjlkmmzS67JEHFpS1g7JeczPKzd400jgnQN1sq
         otvVjxp/93WT5lV9GwBZYDjz2zFpVuDapEJRaUX7gHs8v93Mr2r9aiqJ+pgQyvp2fPEC
         RpjCQTU0rbQLZjE3lBAa5duiUFGlZXYysa3nrS9DTIl0q41gH09EdurJjlC50WnfnPYz
         Wv/yoMEI1lY4CDAG0UI/L5RXmzw87GCjgjmWPKPKZd2s1ch9vaVpYqSvP6/0YypQ8nfw
         DZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691565239; x=1692170039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJc4D+pWFIMKl1qw8oGjynYOM6/qtbfYWHBOBDcE408=;
        b=Rt735bMZVUhwsJTc8nF4fwgvL0QvSHl+1QfCABZSuJhMxqXBCwhG0eSclc00phGxGk
         NQ9U7/abviU8l3JIw5WxITMo4gFMABjvLjxQUSXQHskaycY3KWx25JASOdt3l46RAuKA
         tihM726U/emdUv3CMscciTsbZqNPNhtJL5uo6DZ/+vSrvUW/zPaqD3oo+ZhNhID2n6gW
         rS2MGFyC3RX47YMcGPAkgMxlywfrg2OV8MDvnOGR7xDRLgqw0tI7HTerfQmJgU+CIndZ
         Y6JS+qX54KFP909VjssYBvWCyG8j0Gb4h34DqihGP9LHr4pot/1UYTZFNV3Wl2YbKvQw
         NiOQ==
X-Gm-Message-State: AOJu0YzfWQ1+KJFCLt5uUEMUCL1YGoxDcJVJZYiUBQt2bglnhBSH4iJv
        /cX9o/MQPKL31X8qGYS09rtH2D4hqqAOZd2qX5x1Ww==
X-Google-Smtp-Source: AGHT+IFgkLvwE4GsGCl1KzMvK4DkC6XWt66M+02fwT/7gz6iD9x0GSKTwJEpSerIySpR0e/pAVc4azWFRj4AGFoac2U=
X-Received: by 2002:a2e:83c8:0:b0:2b9:cdbf:5c15 with SMTP id
 s8-20020a2e83c8000000b002b9cdbf5c15mr1104297ljh.51.1691565238877; Wed, 09 Aug
 2023 00:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031913.46965-1-huangjie.albert@bytedance.com> <87v8dpbv5r.fsf@toke.dk>
In-Reply-To: <87v8dpbv5r.fsf@toke.dk>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Wed, 9 Aug 2023 15:13:47 +0800
Message-ID: <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
Subject: Re: Re: [RFC v3 Optimizing veth xsk performance 0/9]
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 20:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Albert Huang <huangjie.albert@bytedance.com> writes:
>
> > AF_XDP is a kernel bypass technology that can greatly improve performan=
ce.
> > However,for virtual devices like veth,even with the use of AF_XDP socke=
ts,
> > there are still many additional software paths that consume CPU resourc=
es.
> > This patch series focuses on optimizing the performance of AF_XDP socke=
ts
> > for veth virtual devices. Patches 1 to 4 mainly involve preparatory wor=
k.
> > Patch 5 introduces tx queue and tx napi for packet transmission, while
> > patch 8 primarily implements batch sending for IPv4 UDP packets, and pa=
tch 9
> > add support for AF_XDP tx need_wakup feature. These optimizations signi=
ficantly
> > reduce the software path and support checksum offload.
> >
> > I tested those feature with
> > A typical topology is shown below:
> > client(send):                                        server:(recv)
> > veth<-->veth-peer                                    veth1-peer<--->vet=
h1
> >   1       |                                                  |   7
> >           |2                                                6|
> >           |                                                  |
> >         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
> >                   3                    4                 5
> >              (machine1)                              (machine2)
>
> I definitely applaud the effort to improve the performance of af_xdp
> over veth, this is something we have flagged as in need of improvement
> as well.
>
> However, looking through your patch series, I am less sure that the
> approach you're taking here is the right one.
>
> AFAIU (speaking about the TX side here), the main difference between
> AF_XDP ZC and the regular transmit mode is that in the regular TX mode
> the stack will allocate an skb to hold the frame and push that down the
> stack. Whereas in ZC mode, there's a driver NDO that gets called
> directly, bypassing the skb allocation entirely.
>
> In this series, you're implementing the ZC mode for veth, but the driver
> code ends up allocating an skb anyway. Which seems to be a bit of a
> weird midpoint between the two modes, and adds a lot of complexity to
> the driver that (at least conceptually) is mostly just a
> reimplementation of what the stack does in non-ZC mode (allocate an skb
> and push it through the stack).
>
> So my question is, why not optimise the non-zc path in the stack instead
> of implementing the zc logic for veth? It seems to me that it would be
> quite feasible to apply the same optimisations (bulking, and even GRO)
> to that path and achieve the same benefits, without having to add all
> this complexity to the veth driver?
>
> -Toke
>
thanks!
This idea is really good indeed. You've reminded me, and that's
something I overlooked. I will now consider implementing the solution
you've proposed and test the performance enhancement.

Albert.

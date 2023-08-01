Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029176B598
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjHANOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjHANOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:14:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868C1710;
        Tue,  1 Aug 2023 06:14:09 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d30554eefso34140966d6.3;
        Tue, 01 Aug 2023 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895649; x=1691500449;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD75GHEjjxp2EayID2Ba49tkGed5r1NYxU4UNRy0C84=;
        b=enukBQT0Tu2iPvAAnDJps+HeB9ZMHtJBxAfuQYTHiq5unU5LIfCNIe8WBtb3uX0JEl
         EPoJfKBqJhYRFjVDuLhO7caZ7DCfhhtVzNQIFqFaWJn2l1vsNfugeQi2V5u+msuSYQGo
         KtSa7Ww9I0UL1bUT6FxfxbiWNWHCdQMR5keXUXofr2KNynqd2a5TlXgajX4Y1BH3MG2O
         gwEEnsl911KaR3DuQoR8+ZiL+t3OQw6ZIUw0qo79FcMOF4A2JqykRKEfozoqfZVslEMu
         PHaFpubZHUNsb7L5FaCWMbL8/n88mPQpgoajGHjqEeoVjWU9R5tEBMO1pQouPxI2At7/
         Pfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895649; x=1691500449;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RD75GHEjjxp2EayID2Ba49tkGed5r1NYxU4UNRy0C84=;
        b=SnTxQxpUE+CgXTI4wu+j5WxI4F2dEnqCbS/uoQLB/hz/tedyFXPB2TOGgNDW3sEsoZ
         KO+SllouHa/9v2oHW79Xr0A3AegXap5Fnxw2sexI55Hc6+KZcZlrd6LqrYXeblyCI94R
         z8qYfldIdiol4GYS4lpIqkoQONHXfPAIbDOY8AtZNzlqqwaOqB/DBXhcSM0Be/hbsz3d
         SvaKwrW9HtmTcmD05tmBKdia2Tgu147qXbfV5Ngag3Pm4sbcXRCmGcLuk1vfXe4NV8nb
         JaBnMDVOeYdOFMWO4EDCPqvZs1x/A/uN2pOjzrMWvAlag9vPa0nni7HPPX/wH01nld6p
         FpMQ==
X-Gm-Message-State: ABy/qLad3j4F905NSeKYXVtBSQN0xI8lmFBfQlIfCd4rACQalHwM+AZy
        LrAVhV43sJ9ns40Qjq7bPjs=
X-Google-Smtp-Source: APBJJlGO6jL4D5nDwhZQ/4ZdkvjfbhOzUmhZYl8aVta+BWXmzjWSuLB/yUavCI/+ryB4vP6nsLOVog==
X-Received: by 2002:a0c:b3d0:0:b0:63d:3ab9:d9a0 with SMTP id b16-20020a0cb3d0000000b0063d3ab9d9a0mr10770898qvf.52.1690895649020;
        Tue, 01 Aug 2023 06:14:09 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id o26-20020a05620a111a00b007675bef6b0dsm4147100qkk.118.2023.08.01.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:14:08 -0700 (PDT)
Date:   Tue, 01 Aug 2023 09:14:08 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Eric Dumazet <edumazet@google.com>,
        Tahsin Erdogan <trdgn@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <64c905205b2f4_1b41af2947@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
References: <20230731230736.109216-1-trdgn@amazon.com>
 <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
 <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet
 header
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Tue, Aug 1, 2023 at 11:37=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Tue, Aug 1, 2023 at 1:07=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.c=
om> wrote:
> > >
> > > When GSO is not enabled and a packet is transmitted via writev(), a=
ll
> > > payload is treated as header which requires a contiguous memory all=
ocation.
> > > This allocation request is harder to satisfy, and may even fail if =
there is
> > > enough fragmentation.
> > >
> > > Note that sendmsg() code path limits the linear copy length, so thi=
s change
> > > makes writev() and sendmsg() more consistent.
> > >
> > > Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> > > ---
> >
> > I will have to tweak one existing packetdrill test, nothing major.
> >
> > Tested-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> =

> I have to take this back, sorry.
> =

> We need to change alloc_skb_with_frags() and tun.c to attempt
> high-order allocations,
> otherwise tun users sending very large buffers will regress.
> (Even if this _could_ fail as you pointed out if memory is tight/fragme=
nted)
> =

> I am working to make the change in alloc_skb_with_frags() and in tun,
> we can apply your patch after this prereq.

This exactly same allocation logic also exists in packet_alloc_skb and
tap_alloc_skb. If changing one of them, perhaps should address convert
all at the same time, to keep behavior consistent.=

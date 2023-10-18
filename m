Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B077CD20F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJRB6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRB6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:58:13 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DACF7;
        Tue, 17 Oct 2023 18:58:11 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so2818112e0c.0;
        Tue, 17 Oct 2023 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697594290; x=1698199090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrBkKk/OhaMOdfc+Pvuh6DSNNjTaKia2Rbq4gj7RLNE=;
        b=B4Y++f7HPiQ/pzsHFl13dkAWhjJ8WLl1d6pY1o5TaSvConj1+cyvRTAagxRE6chPQb
         XBcmEEeDrIlrrKBf3TEQFiYgkDCJfkpkhOsPvqbBU5OniIvlhUdzBtLy5RjXETFGKwnA
         2egdHVVC/rpuxCTftTBw1jMkr6UHi6521Cl2p6pXKA8ZhxwSuqcM7yEbmt5yVW+2vQB6
         PK2sWFD4WWMYMlRSiYBREL3owbKzLn7jR8XBzEAvDPgB2d8n+ec3XoeZLXNVHYZWjqxD
         QehyCpSufKNpD9L1ot0ukTNB7ZT6PwOUJsDKe44Aomsa1FvVEhI4Or6N3mc7CtJxmHLh
         MXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697594290; x=1698199090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrBkKk/OhaMOdfc+Pvuh6DSNNjTaKia2Rbq4gj7RLNE=;
        b=mOdqK7Ax/5n2oCTPvkKoryYD5363uDlXkUV1JQi/c5mbUeRKci2OAFwMsGRs3m+lHR
         svqbEFkIftr9yWeK9mXKlgm/MkmjmVkERgZDGmORjP+oMX8QBqhxWoWJ/OhlLRx9FJwI
         rkeYG/8CK1H5BJCub8ijmu+JNlUONAOvd/ZAdyyDCNxnzFNPj1cnaRtPsDx/DNOVUSLx
         wHpWejrjcCJ+hwRJ+F4meWfqaftfIhJdECOIhZ+Rk5lr0SUKMIMBQYm0hp/jWu9R6Jwf
         /vMAVvwx8X3eNudYWotuExOQ+HAEEk8iQpNkis4anDGuDsYoCZ/2oFhQu1c6LXoPzTed
         d5MQ==
X-Gm-Message-State: AOJu0YwBigmoELb5RdUcWHlw+5cnk+/XOjRSOeubig9bnzGtZb4k9RAW
        bviIWaHqyK+XgJKd0zobVuP6YOCTVLMKK/WCY0w=
X-Google-Smtp-Source: AGHT+IE7orZ60FrzBq0xgMmGzpIm0rBysB9wYcBW5L3/ndTzQkWYVFrjnTfVXz7u261rosYUhC4Rg5ZpGcWmXQESlmQ=
X-Received: by 2002:a1f:abc1:0:b0:49d:d3dd:fa40 with SMTP id
 u184-20020a1fabc1000000b0049dd3ddfa40mr3724461vke.5.1697594290608; Tue, 17
 Oct 2023 18:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian> <20231017200207.GA5770@breakpoint.cc>
 <CAO3-Pbod3qc7rdg0bN0z5TjeoxO-SAADEwPZm6jcT42Gya8s=g@mail.gmail.com>
In-Reply-To: <CAO3-Pbod3qc7rdg0bN0z5TjeoxO-SAADEwPZm6jcT42Gya8s=g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 17 Oct 2023 21:57:34 -0400
Message-ID: <CAF=yD-K7SbUkeVkTcZyR_x-+fgtpcBr0R6e75J=C_Af54J+zew@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:42=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Tue, Oct 17, 2023 at 3:02=E2=80=AFPM Florian Westphal <fw@strlen.de> w=
rote:
> >
> > Yan Zhai <yan@cloudflare.com> wrote:
> > > Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> > > processing. It mirrors __ip_finish_output logic now. Add an extra che=
ck
> > > in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> > > check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> > > sending PTB packets for MTU < 1280").
> >
> >
> > > -     if ((skb->len > mtu && !skb_is_gso(skb)) ||
> > > -         dst_allfrag(skb_dst(skb)) ||
> >
> > My preference is to first remove dst_allfrag, i.e. do this in
> > a separate change.
>
> You mean completely removing all dst_allfrag references and related
> stuff such like IP cork flags/socket flags? I was debating, it might
> be cleaner that way but it does not fit so well with the subject of
> this patch. I can open a new patchset to clean that up separately. For
> this one, I guess I can keep dst_allfrag for now and come back with a
> V3. Does that sound good to you?

The second paragraph in the commit message really makes
clear that this combines three changes in one patch. Of which
the largest one in terms of code churn is supposed to be a
NOOP.

Separating into three patches will make all three more clear.
They can be pushed as one series, conceivably.

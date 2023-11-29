Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3067FE17C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjK2VBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjK2VBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:01:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21264D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:01:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so1444a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701291699; x=1701896499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5HUSLBxeP3j9q8/FZBezUiFiD8GXZfLQKXZ2leGr4A=;
        b=FVTE6yyQPocjL3JKbIlCivLYXJcQcH+vbSZWRQnRWpiqAVeFUepU6SWUaLoDk/P2gs
         TNpSD9WT7ktGAxWrX3piOCO9UOVbGutfn6O5f48slsntkx4hvqn2QkVC0u3HTdyxBTyA
         OD2AQkF0V4rqlaZNkPHAlepPbHVWY1v+jI29yJBqnu5Gj84WYkVyzqxsdq+wVnfG8zYN
         VJ1RJ7lZh1wyq4Kqb5X7JOBKhvE9S5OBEG9XM4TLXC8r90KFBQcGub6vp/OzRubR9uzy
         x6W8XXtCB5nY4F46y46857+xOG6S1aGMRyME3bMAa711yC+GBHHczQe3nOmmGDtkUT11
         RSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291699; x=1701896499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5HUSLBxeP3j9q8/FZBezUiFiD8GXZfLQKXZ2leGr4A=;
        b=qhVgHnoU2n0kV7KsCDbKI/F8dRnf1YNG8XNvyPVjGOmTGPIK3SDlJlE/421c5ofINz
         yS72yQ4opcc7fGac03w4XsMsFZDoIiTF9ub5re99U+0Ckx4qhLRx6lyTFU5lJafObbEO
         TQlLoVhpe6I4FaLSdPmAvuU1zg14SSQ8dIr3aNQ0ba4KfDu4b49jo9QAThcOHT2Q7U3a
         y1qkKtVSYbp2c7TZjcN8gnqwGs8D2yHCAdwttJ7DfRZX7Zi2Af25hyu6HZqM9lQcAuAb
         yCpggZZkvYgx8Wx7qlaP2pna/8tCPP2P9x61civ4aJg+mdrdREiJFLZmehWA3W/dy2n4
         wrAQ==
X-Gm-Message-State: AOJu0YzybALaU4fpAYMkNteV8+YrxN/95oRW6PFBRWtjma/D2rmk+6tL
        yKnvTn+dfFDvKQ+EmYBXuUJ+Yu8roL5cC41PprsN9g==
X-Google-Smtp-Source: AGHT+IFBxw/0xrfHIb0Q9N9llhrx5bsGDNUUDI8eCEJbdMiKcKk9baVfrCtO0cVNJDfb9QSAtt5b2Wc+v6ptx3s9kM4=
X-Received: by 2002:a50:9e62:0:b0:54b:321:ef1a with SMTP id
 z89-20020a509e62000000b0054b0321ef1amr41083ede.6.1701291699354; Wed, 29 Nov
 2023 13:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-7-dima@arista.com>
 <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
 <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com> <CANn89iLZx-SiV0BqHkEt9vS4LZzDxW2omvfOvNX6XWSRPFs7sw@mail.gmail.com>
 <137ab4f7-80af-4e00-a5bb-b1d4f4c75a67@arista.com>
In-Reply-To: <137ab4f7-80af-4e00-a5bb-b1d4f4c75a67@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 22:01:25 +0100
Message-ID: <CANn89iLfvOp+xpoFzsKojQs2SuCy+qL6PANj8Z04MwYaH31moA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
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

On Wed, Nov 29, 2023 at 8:58=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> On 11/29/23 18:34, Eric Dumazet wrote:
> > On Wed, Nov 29, 2023 at 7:14=E2=80=AFPM Dmitry Safonov <dima@arista.com=
> wrote:
> >>
> >> On 11/29/23 18:09, Eric Dumazet wrote:
> >>> On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.c=
om> wrote:
> >>>>
> >>>> RFC 5925 (6.2):
> >>>>> TCP-AO emulates a 64-bit sequence number space by inferring when to
> >>>>> increment the high-order 32-bit portion (the SNE) based on
> >>>>> transitions in the low-order portion (the TCP sequence number).
> >>>>
> >>>> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> >>>> Unfortunately, reading two 4-bytes pointers can't be performed
> >>>> atomically (without synchronization).
> >>>>
> >>>> In order to avoid locks on TCP fastpath, let's just double-account f=
or
> >>>> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sn=
e.
> >>>>
> >>>
> >>> This will not work on 32bit kernels ?
> >>
> >> Yeah, unsure if there's someone who wants to run BGP on 32bit box, so =
at
> >> this moment it's already limited:
> >>
> >> config TCP_AO
> >>         bool "TCP: Authentication Option (RFC5925)"
> >>         select CRYPTO
> >>         select TCP_SIGPOOL
> >>         depends on 64BIT && IPV6 !=3D m # seq-number extension needs W=
RITE_ONCE(u64)
> >>
> >
> > Oh well, this seems quite strange to have such a limitation.
>
> I guess so. On the other side, it seems that there aren't many
> non-hobbyist 32bit platforms: ia32 compatible layer will even be limited
> with a boot parameter/compile option. Maybe I'm not aware of, but it
> seems that arm64/ppc64/risc-v/x86_64 are the ones everyone interested in
> these days.
>
> >
> >> Probably, if there will be a person who is interested in this, it can
> >> get a spinlock for !CONFIG_64BIT.
> >
> >
> >>
> >>> Unless ao->snd_sne and ao->rcv_sneare only read/written under the
> >>> socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
> >>> necessary)
> >>
> >
> > You have not commented on where these are read without the socket lock =
held ?
>
> Sorry for missing this, the SNEs are used with this helper
> tcp_ao_compute_sne(), so these places are (in square brackets AFAICS,
> there is a chance that I miss something obvious from your message):
>
> - tcp_v4_send_reset() =3D> tcp_ao_prepare_reset() [rcu_read_lock()]
> - __tcp_transmit_skb() =3D> tcp_ao_transmit_skb() [TX softirq]
> - tcp_v4_rcv() =3D> tcp_inbound_ao_hash() [RX softirq]

All these should/must have the socket lock held !

Or reading tcp_sk(sk)->rcv_nxt would be racy anyway (note the lack of
READ_ONCE() on it)

I think you need more work to make sure this is done correctly.

ie tcp_inbound_hash() should be called from tcp_v4_do_rcv() after the
bh_lock_sock_nested() and sock_owned_by_user() checks.



>
>
> > tcp_ao_get_repair() can lock the socket.
>
> It can, sure.
>
> > In TW state, I guess these values can not be changed ?
>
> Currently, they are considered constant on TW. The incoming segments are
> not verified on twsk (so no need for SNEs). And from ACK side not
> expecting SEQ roll-over (tcp_ao_compute_sne() is not called) - this may
> change, but not quite critical it seems.
>
> If we go with this patch in question, I'll have to update this:
> :               key.sne =3D READ_ONCE(ao_info->snd_sne);
> (didn't adjust it for higher-bytes shift)
>
> > I think you can remove all these READ_ONCE()/WRITE_ONCE() which are not=
 needed,
> > or please add a comment if they really are.
>
> Not sure if I answered above..
>
> > Then, you might be able to remove the 64BIT dependency ...
>
> At this moment I fail to imagine anyone running BGP + TCP-AO on 32bit
> kernel. I may be wrong, for sure.

I fail to see anyone using TCP-AO today. (up to linux-6.6), regardless
of the architecture.

Would that be a reason for not supporting it in the future ?

32bit or 64bit should not be in the picture, especially if done for
the wrong reasons.

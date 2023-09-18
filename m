Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21217A4D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIRPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIRPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:53:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF5173D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:52:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34f1ffda46fso313225ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695052060; x=1695656860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvV317n6yyGUg56R/7pdLcqCtdADu2ogATpf8Oy64Nk=;
        b=ssBsfFlkBcWmKH1Gng1juSZnLRvr7D2rKBG9Nz3JRiABpRTdRL04/wSie7IcL/v3TS
         JF6Inpet9jk6aXvf+JTl0w4Jh4d+PtpaKaWNZ2SJly5d+uNjONnH11c1Af/1/MG0k/r/
         TivRuuFP+z9cROsXK5N2+4Pt1t+BwlQWWM6pwTY9wHXWvtkn9gMSlgpYQXISqKGMpAtL
         gkOXT/et0pEiHD2A/tkC9J5ashpaJYFXVrzwlD57MGNUYZMv97hVMjHVg0cXlvtHeTzH
         dvIY0Djox6fc0HYtkJD3BzljSyEkBfBee1mZbZF/NlafvQquh+pe56c1k6QhfipL5IQ/
         Srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052060; x=1695656860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvV317n6yyGUg56R/7pdLcqCtdADu2ogATpf8Oy64Nk=;
        b=nU7B1dQehK7L2AF+iRDHBbX7jK6nGzgoX0XFN43WLO1XWMmGlO8ID3CIsMDd6WcWpY
         msJ9ICOjuACXiS4criGlLYR/Zwb1Ug1hspBCCE3Y3WHJ++swTGw/i7qczyIiqi2exmx+
         zSq5wdxlFJdUCfOQ0TnVwsGha7ZC9Va4OX4OrHSwVwGaGXWZMOsUrpCzkhEJMva1knPz
         LxHsT3F3SwIuzUotAN8UuAa60MTNzDg2OXZdA0LcAU6BMa2Lwmboftb171/zeGXyWvdy
         ptloRWcPVRwzej31UxB+2inNyNkMbVdVyGuL6MEdrq3ctYJfKh5QANNjrRd4DojoOMm4
         VqUw==
X-Gm-Message-State: AOJu0YziA98srU0nd/ccrcXC5ZDKW+y6//SJfeHB4NxfjVBKpmVLKOy2
        S4x4N/jNWDvucE11JnhdTEgB/X62MzJvRaxCQpCnXZl/FPW2E7DAKurE7A==
X-Google-Smtp-Source: AGHT+IG9qqBMe+choJ4leMLCkiIje8FUPx8O31NwXMKGaaM7qF1rlAYaYJnEXhRPBK/ZOM1AGuaJPBQA0/aP9CZaDVI=
X-Received: by 2002:ac8:5ac2:0:b0:417:944a:bcb2 with SMTP id
 d2-20020ac85ac2000000b00417944abcb2mr385498qtd.13.1695045901037; Mon, 18 Sep
 2023 07:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <3793723.1694795079@warthog.procyon.org.uk> <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
 <0000000000001c12b30605378ce8@google.com> <3905046.1695031382@warthog.procyon.org.uk>
 <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 18 Sep 2023 16:04:49 +0200
Message-ID: <CANn89iJ39Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 3:58=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> David Howells wrote:
> > David Howells <dhowells@redhat.com> wrote:
> >
> > > I think the attached is probably an equivalent cleaned up reproducer.=
  Note
> > > that if the length given to sendfile() is less than 65536, it fails w=
ith
> > > EINVAL before it gets into __ip6_append_data().
> >
> > Actually, it only fails with EINVAL if the size is not a multiple of th=
e block
> > size of the source file because it's open O_DIRECT so, say, 65536-512 i=
s fine
> > (and works).
> >
> > But thinking more on this further, is this even a bug in my code, I won=
der?
> > The length passed is 65536 - but a UDP packet can't carry that, so it
> > shouldn't it have errored out before getting that far?  (which is what =
it
> > seems to do when I try it).
> >
> > I don't see how we get past the length check in ip6_append_data() with =
the
> > reproducer we're given unless the MTU is somewhat bigger than 65536 (is=
 that
> > even possible?)
>
> An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 + 40
> sounds correct. But payload length passed of 65536 is not (ignoring ipv6
> jumbograms). So that should probably trigger an EINVAL -- if that is inde=
ed
> what the repro does.

l2tp_ip6_sendmsg() claims ip6_append_data() can make better checks,
but what about simply replacing INT_MAX by 65535 ?

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 44cfb72bbd18a34e83e50bebca09729c55df524f..ab57a134923bfc8040dba0d8fb7=
02551ff265184
100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -502,10 +502,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk,
struct msghdr *msg, size_t len)
        int ulen;
        int err;

-       /* Rough check on arithmetic overflow,
-        * better check is made in ip6_append_data().
-        */
-       if (len > INT_MAX - transhdrlen)
+       if (len > 65535 - transhdrlen)
                return -EMSGSIZE;
        ulen =3D len + transhdrlen;

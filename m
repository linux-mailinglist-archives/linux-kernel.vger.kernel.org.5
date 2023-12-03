Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7244B80229A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjLCLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:03:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD7FA2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:03:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so34725e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701601402; x=1702206202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCN0TPEmvd7kz6bn2yXvkGu2UfPcBGCxL6UVnP3vpy8=;
        b=o9cUoLd7MO5O5rbJ9tUNfdXVMWL3FZWkNZVsp6WhPX85pcCMMTFBLhWPNzUl9gumDl
         pCxLK9xZAHgkEDfgnQg2z08jUlc/XBCy1d4U4u5cpjSa+3daEEZAaGCdb7ZPJc41dpX4
         EhrfGaAKAnaE0uiEg/LZnGVng12WB9fc5scWIiNbwXgETSVJgX0qUK18Rc8hdLeUl/hF
         0BrlriZQ5Znuh2KBUCZ+f/SC8AvYVfQ8ECfL47/LimF70OcWniahiOKzbr3QtRk7mvzh
         cRinldanYOIinS7ii9KKwaTmvZc0d0kSyK5oIxGS07h4/RqShhNMehI+Fhime+osFhms
         mawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701601402; x=1702206202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCN0TPEmvd7kz6bn2yXvkGu2UfPcBGCxL6UVnP3vpy8=;
        b=nEGbDflS3aNfaJ5LxWnKXPH99ufH6E1YM4mK0ChyHuegm2hRJilBGsgmi5W2jqf6GH
         r+QaGS6h6UK2HWHcLIvnkBf3T2AhAeSN6L8iHSCijjVfbJrPK/YK9MhKHLYro2wDlm4s
         YsXMVhcsHfjQOwtV4lOZJzr/AWrVcO5qcW6ef2bPcOHpnOH/mnIgg8c8iWSucW7a9R6t
         2Y12eHYaGQf6l+FJU5qr0n5NbmppasNFpGC+w0WX8baK5l73OJ6riVKsFiDydtguoJou
         YQpIlLbRSKBcZ7l7ScvdhUXqAv5179WQrqjs5jAuhp294QHlliZlO3Mhsn+meP/UV1QC
         Z24g==
X-Gm-Message-State: AOJu0Yw8pv74cnVlsA8MH9iEZFuqK4q40Tr/eoW6UZpZN/xEnj7FNnfr
        Wen4vlUnEn2+AuTJh15e6avbdyOsxkuldNl7bqOYXw==
X-Google-Smtp-Source: AGHT+IE0KN4b9aaj2wD7bazxbAvpF1Tq2GT2htP8uJF2FlWkS0/LH9Tyg9iBYM/JWXLWrAZFQzYXC3RCTk2hVy7qttw=
X-Received: by 2002:a05:600c:54e7:b0:3f7:3e85:36a with SMTP id
 jb7-20020a05600c54e700b003f73e85036amr301125wmb.7.1701601401537; Sun, 03 Dec
 2023 03:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20231202161441.221135-1-syoshida@redhat.com> <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 3 Dec 2023 12:03:07 +0100
Message-ID: <CANn89iLaCrBGdtVSPZMLM7tnixFfy3wF98aojxkcoXoXEit6og@mail.gmail.com>
Subject: Re: [EXT] [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
To:     Suman Ghosh <sumang@marvell.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 7:58=E2=80=AFAM Suman Ghosh <sumang@marvell.com> wro=
te:
>
> Hi Shigeru,
>
> >diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c index
> >22a26d1d29a0..5169c3c72cff 100644
> >--- a/net/ipv4/ip_gre.c
> >+++ b/net/ipv4/ip_gre.c
> >@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
> >       }
> >
> >       if (dev->header_ops) {
> >+              int pull_len =3D tunnel->hlen + sizeof(struct iphdr);
> >+
> >               if (skb_cow_head(skb, 0))
> >                       goto free_skb;
> >
> >               tnl_params =3D (const struct iphdr *)skb->data;
> >
> >-              /* Pull skb since ip_tunnel_xmit() needs skb->data pointi=
ng
> >-               * to gre header.
> >-               */
> >-              skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> >+              if (!pskb_network_may_pull(skb, pull_len))
> [Suman] Since this is transmit path, should we add unlikely() here?

Adding unlikely() is not needed, it is already done generically from
the inline helpers.

Reviewed-by: Eric Dumazet <edumazet@google.com>

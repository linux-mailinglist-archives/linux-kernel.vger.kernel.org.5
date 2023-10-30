Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494467DC218
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjJ3Vuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3Vut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:50:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC4F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:50:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5af5b532d8fso42411647b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698702643; x=1699307443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niDN24Fg/PuyXgPOwyMMJfQf0J5VnyR/odMo+tCbwS4=;
        b=p23vkwZ5WdA14p7xhsgeCNykNLusz/euHtEHK3zZ/qsyLGt91XxDnR7t4C8Q0Wzaj8
         t5hfdeuWa33VJGKmcHAbKiSQ20c8mHyRZiInpF8nf0X7kMIZYLo5Hh4m4S1t2rpMm4Un
         /lfFf2mj6rAq+ZA0ZJ4VtsKWIZ5ttxLcSEuuBUi7ynVJC0GL09pfJZBLRfqi+GLLyeZ+
         yTYlIr3ulW6azfnyjoHdumsKQ4+p9dm8WsLIhoXugT9OcJGJFa/fDzVihjHlop3aJqSS
         iYuS55LPMZ9CS0lgI9negO1E1YAJXEStKhZYxB05tP2SKSq4f0N0wQVImQGi6hShbLfv
         RS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702643; x=1699307443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niDN24Fg/PuyXgPOwyMMJfQf0J5VnyR/odMo+tCbwS4=;
        b=EDYtKZtdBeOrLwBjsLMMVxWMYxytlgpYwlqhO4GkMYvQ/naokX3uyAd3q1GS19gnOs
         njICNU/KkmSWeMa4UBdq/zzgu6LYf3aXm5LuXsP5gNdl2FwLeK7eAEG87BFI5TA+UVbn
         oWZhCRtGuZHUcYQlHuzLpARLiBkUL4yB1crEG07gQBt1rVRlbvCiLSFyuv61LwDxwLDs
         ly83MEBOQKMX1kDmVzOvyMaKjb5t12sNg7YmIC0s9PIlPCZYmkrQ7vx7RHWwa83SlKtW
         eMzru8Yf3sG8AJVDHJ1v0dsePg6UG43rTrKDl1Y6N8Tig78vVW0vWBjRqUqpRwwOOdMz
         0E8Q==
X-Gm-Message-State: AOJu0YzbceR6q78eNCvMkAAzy7Iii2blFf1j44BptdT+p9D7rFY0erAY
        5UCPRJ06WOEIalIri/DSeCdaHmeoTlqxc2OaL+pQBA==
X-Google-Smtp-Source: AGHT+IHETvp3ka4K2AK9N3TEG8BYpyVa5ASsI4zyEOnk9YKJgwo/uAXGwKTWQmzBGHWSFGdmyOo8EFkII11lBrQDNC8=
X-Received: by 2002:a81:aa46:0:b0:5ad:716b:ead3 with SMTP id
 z6-20020a81aa46000000b005ad716bead3mr10420573ywk.28.1698702643460; Mon, 30
 Oct 2023 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org> <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
In-Reply-To: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Oct 2023 22:50:31 +0100
Message-ID: <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 3:16=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> which means that here, skb->len will be 1522, if it was originally 1496.
> So the code adds 26 extra octets, and only 4 of those are legitimate (a t=
ag).

Yeah I know :/

> The rest is absolutely unexplained, which means that until there is a
> valid explanation for them:
>
> pw-bot: cr
>
> (sorry, but if it works and we don't know why it works, then at some
> point it will break and we won't know why it stopped working)

Yeah it broke now and we don't know why...

> you said that what increments is Dot1dTpPortInDiscards. 802.1Q-2018 says
> about it: "Count of received valid frames that were discarded (i.e.,
> filtered) by the Forwarding Process." which is odd enough to me, since
> packets sent by rtl4a_tag_xmit() should *not* be processed by the forward=
ing
> layer of the switch, but rather, force-delivered to the specified egress
> port.

No this was a coincidence, we can rule this out. There are always
a few (2-3) Dot1dTpPortInDiscards on the switch port when it
is connected, sorry for getting this wrong :/

What happens is way more disturbing: packets are dropped
*silently* if not padded.

I added the following patch:

@@ -37,6 +37,8 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb=
,
                                      struct net_device *dev)
 {
        struct dsa_port *dp =3D dsa_slave_to_port(dev);
+       static u16 mask =3D BIT(6);
+       static int cnt =3D 0;
        __be16 *p;
        u8 *tag;
        u16 out;
@@ -60,6 +62,19 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *sk=
b,
        /* The lower bits indicate the port number */
        out |=3D BIT(dp->index);

+       if (skb->len >=3D (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+               /* Test bits... */
+               out |=3D mask;
+               netdev_info(dev, "add mask %04x to big package\n", mask);
+               cnt ++;
+               if (cnt =3D=3D 10) {
+                       cnt =3D 0;
+                       mask <<=3D 1;
+                       if (mask =3D=3D BIT(15))
+                               mask =3D BIT(6);
+               }
+       }
+
        p =3D (__be16 *)(tag + 2);
        *p =3D htons(out);

This loops over all the bits not used by the port mask and test them
one by one to see if any of them help.

Then ran a few rounds of ping -s 1472 and ping -s 1470.

There are console prints:

realtek-smi switch lan0: add mask 0040 to big package
realtek-smi switch lan0: add mask 0040 to big package
realtek-smi switch lan0: add mask 0040 to big package
(...)

Then bits 6,7,8,9,10,11,12,13,14 and 15 are tested in succession.

No error counters increase in ethtool -S lan0.

I can see the big packets leave the eth0 interface
(from ethtool -S eth0)

     p05_EtherStatsPkts1024to1518Octe: 370

But they do not appear in the targeted switch port stats:

     EtherStatsPkts1024to1518Octets: 22

(these 22 are some unrelated -s 1400 packets I sent to test)

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4E7DC2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjJ3W5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJ3W5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:57:49 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7053ADD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:57:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a82c2eb50cso41878487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698706665; x=1699311465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOqpJwapvpRYXVNPTTKOLnjojsLqC4JocbtWhR4syPY=;
        b=ui07+5Qnn11jUW7iw8DX6C2Sl0WCdv7TQtNg8elsBjFWioSv2tmLFY4jHYqC7n1y+G
         YbRcEFkyElwmZPFzVSzVPrh/1xSd03krVZrA0j7J+vOeLlN0xeSQP3tMpTP5a6qXqnBD
         Zg1tbCBKbImExbW3g9Vz8jOblAAB+nVIvSl7n+4LhAPpw5+W80vsIxvpOSIycew4nOgV
         96gqtEQrSICD36I0rXYGq+EFQBel09i+kuvaKJRHwtcqd196z3oBmT4S/cgHJRl3bHIv
         na2zdZteWN3Gy/n3FpRMbwmKmOXQ4OAWv2qNkc5bYP+gP2OdsMK434I0CUn1XKpVDUri
         Cb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698706665; x=1699311465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOqpJwapvpRYXVNPTTKOLnjojsLqC4JocbtWhR4syPY=;
        b=JO/S5aiscoGCqVYy5wg85JQ8FJWMEnSr/bASXIe90n1xoTffV6uuFJqI1xu3wTj4xF
         Lqr1zDWrsU4Hg3B43gFap6iN+mXeRYfgojVQ7RbMK3Gili5d3+7/aaTBRDfDZRpuA7bZ
         SPqSZUIoBoS6i2vR7mcYe6vE06KT3WDBcBLw+cI1CIoxraXW419b/qGXD/hJw8ji+eMF
         wXGcfCsyIR2M+/1DFqMSt4KiDtyEZXTsqj67D2fOi+t4FCNW9TY1N2oa7/t403u4cl7U
         Z+ETovTz7vgYIt5m3EAaFOsqKTO4iz1yn+eJoPkOYsrTpk1EEHqRRTz1D3HnrhQD6Njt
         k7Ow==
X-Gm-Message-State: AOJu0Ywx1FZgrxP68iJvUkwhGDsEnBP4QCA0NOCCCDY6+oJCro8spWXi
        kuqqh08ZFCE4WKMDIH6nnLidZ2noNXLYFcdzFe/hng==
X-Google-Smtp-Source: AGHT+IHHNd6xOi3tS5B9+YYG7Jz7GgDIxjgIhWzquOcABcL8hJSbxW/ZS0Ej1cU7ZBO0Cx0JuFY9j3Eo+5gTwJG5y2A=
X-Received: by 2002:a81:ca08:0:b0:5a8:1924:b7e7 with SMTP id
 p8-20020a81ca08000000b005a81924b7e7mr8194231ywi.27.1698706665480; Mon, 30 Oct
 2023 15:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
In-Reply-To: <20231030222035.oqos7v7sdq5u6mti@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Oct 2023 23:57:33 +0100
Message-ID: <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
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

On Mon, Oct 30, 2023 at 11:20=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:

> I see commit 86dd9868b878 ("net: dsa: tag_rtl4_a: Support also egress tag=
s")
> also mentions: "Qingfang came up with the solution: we need to pad the
> ethernet frame to 60 bytes using eth_skb_pad(), then the switch will
> happily accept frames with custom tags.". So the __skb_put_padto() was
> something very empirical in the first place.
>
> Since it's all problematic, would you mind removing the __skb_put_padto()
> altogether from rtl4a_tag_xmit(), and let me know what is the output for
> the following sweep through packet sizes? I truly wonder if it's just
> for small and large packets that we see packet drops, or if it's somethin=
g
> repetitive throughout the range as well.
>
> for size in $(seq 0 1476); do if ping 10.0.0.56 -s $size -W 1 -c 1 -q >/d=
ev/null; then echo "$((size + 42)): OK"; else echo "$((size + 42)): NOK"; f=
i; done

The weird thing is that if I remove the __skb_put_padto()
call, ping doesn't work at all. Somehow the packets are
corrupted, because they sure get out of the switch and I
can see them arriving with tcpdump on the host.

root@OpenWrt:/# for size in $(seq 0 1476); do if ping 192.168.1.137 -s $siz=
e -W
1 -c 1 -q >/dev/null; then echo "$((size + 42)): OK"; else echo "$((size + =
42)):
 NOK"; fi; done
42: NOK
43: NOK
44: NOK
45: NOK
46: NOK
47: NOK
48: NOK
49: NOK
50: NOK
51: NOK
(...)
1509: NOK
1510: NOK
1511: NOK
1512: NOK
1513: NOK
1514: NOK
1515: NOK
1516: NOK
1517: NOK
1518: NOK

This of course make no sense, since the padding function should do nothing
when the packet is bigger than 60 bytes.

So what we are seeing is some kind of side effect from the usage of
__skb_put_padto() I suppose? But I have no idea what that is, I looked
at the function and what it calls down to __skb_pad().

I'm testing skb_linearize(), which seems to be called on this path...

TCPdump on the host looks like this:
# tcpdump -i enp7s0
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp7s0, link-type EN10MB (Ethernet), snapshot length 262144 by=
tes
23:28:55.184019 IP _gateway > fedora: ICMP echo request, id 2461, seq
0, length 27
23:28:56.205294 IP _gateway > fedora: ICMP echo request, id 2462, seq
0, length 28
23:28:57.226495 IP _gateway > fedora: ICMP echo request, id 2463, seq
0, length 29
23:28:58.248013 IP _gateway > fedora: ICMP echo request, id 2464, seq
0, length 30
23:28:59.269157 IP _gateway > fedora: ICMP echo request, id 2465, seq
0, length 31
23:29:00.290443 IP _gateway > fedora: ICMP echo request, id 2466, seq
0, length 32
23:29:01.698700 IP _gateway > fedora: ICMP echo request, id 2467, seq
0, length 33
23:29:02.332131 IP _gateway > fedora: ICMP echo request, id 2468, seq
0, length 34
23:29:03.352442 IP _gateway > fedora: ICMP echo request, id 2469, seq
0, length 35
(...)
23:53:33.834706 IP _gateway > fedora: ICMP echo request, id 4000, seq
0, length 1475
23:53:34.854946 IP _gateway > fedora: ICMP echo request, id 4001, seq
0, length 1476
23:53:36.258777 IP truncated-ip - 1 bytes missing! _gateway > fedora:
ICMP echo request, id 4002, seq 0, length 1477
23:53:36.896654 IP truncated-ip - 2 bytes missing! _gateway > fedora:
ICMP echo request, id 4003, seq 0, length 1478
23:53:37.918022 IP truncated-ip - 3 bytes missing! _gateway > fedora:
ICMP echo request, id 4004, seq 0, length 1479
23:53:38.938355 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4005, seq 0, length 1480
23:53:39.958451 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4006, seq 0, length 1480
23:53:40.978598 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4007, seq 0, length 1480
23:53:41.998991 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4008, seq 0, length 1480
23:53:43.020309 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4010, seq 0, length 1480

Here you can incidentally also see what happens if we don't pad the big pac=
kets:
the packet gets truncated.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB77DD7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbjJaVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:22:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D1B4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:22:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a8ada42c2aso61794707b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698787338; x=1699392138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4LrpsRV8LqgOH/k11ky5xw4VxQr9Kt5ptUpPAKGLd4=;
        b=VFXVbVmtEsAduIFm3C29S4LWKF0Zzc/9w1eewDJR5FUooAQ97/+HYMmj+DjFAgKmra
         oyYmj4MHlTeuW4I4IjJ+YYth+Vz9JIuoKfGK6qBTD/W2CegX+aZ2LZTZJwkKHu/KcxDr
         qR/O1ySVIS2FVcE79M9baNFnSoly3Ko1SJw9rhtChiYliKGSNvpHxdoiJ9c4FzENqBAL
         09H+D5O2HotBad004luMTw6yStgkL+Zge4c8PaDEjwRCqr8tl3qHvzzjnd1B7mMnTAn4
         n9/c16oLwQ0fMzAT5tJmW+5BS/G7kNwQNWNZ6flH4rpOZbXzPnbVjIm2Ly/FPHQr757c
         1PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698787338; x=1699392138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4LrpsRV8LqgOH/k11ky5xw4VxQr9Kt5ptUpPAKGLd4=;
        b=xJnvgPp0tkbKMluFzk1wwu+IWTQLWA2gBMpg/dhbqgfrv75rmd2uLvhT4+C4fc+kls
         R5v4ms2pMn0Zq44fSKvauV3ApI+t6IPUnDx+NFo0YUtgA8RdBq5oxeAKAvbnY/FwNznB
         m0cSGBCuy/tDCaJvqmLHKjS2DpNiVfUt+na697McHAq2njLDzYtkRrizKU/Wmstnq2Hg
         5WrgLY0Jsji5KxDkbksmqi9vOa8cYAJMpJUzQyN0AF3wqb6Qb4lsVSyCJpCHCnv24LfD
         pmwJZ79WXKStU+drSmN9b/CXpY3BbYUh1HCSWIYcj62Md4qtlNkv4lNGZFZYlSGCJNaL
         iwTQ==
X-Gm-Message-State: AOJu0Yys7OZIxzy7U5ffPQq2wkIsoP5L/2B/bpUIX55SfJQZIGC9h6+P
        JvrDJ8MZMFGGNoawuHYEDABd6VHLM1TeA6eE7ORrMw==
X-Google-Smtp-Source: AGHT+IFhjnINENOgvp+ur30oT8VgLRv2hYfVUqrUhgFZgkSxPiCmNSWtakRC0Zalo4j5RQG35LKTIklZoKg45DaBXrc=
X-Received: by 2002:a81:c704:0:b0:5a7:b81a:7f5d with SMTP id
 m4-20020a81c704000000b005a7b81a7f5dmr13974357ywi.18.1698787338056; Tue, 31
 Oct 2023 14:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
 <20231030152325.qdpvv4nbczhal35c@skbuf> <20231030153057.3ofydbzh7q2um3os@skbuf>
In-Reply-To: <20231030153057.3ofydbzh7q2um3os@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 22:22:05 +0100
Message-ID: <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

I got around to testing this too:

On Mon, Oct 30, 2023 at 4:31=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Could you please place these skb_dump() calls before and after the magic
> __skb_put_padto() call, for us to see if anything unexpected changes?
> Maybe the socket buffers have some unusual geometry which the conduit
> interface doesn't like, for some reason.
>
> The number of skb dumps that you provide back should be even, and
> ideally the first one should be the unaltered packet, to avoid confusion =
:)

I did a variant to just get one SKB dump and not tons of them;

@@ -37,22 +37,35 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *s=
kb,
                                      struct net_device *dev)
 {
        struct dsa_port *dp =3D dsa_slave_to_port(dev);
+       static int cnt =3D 0;
        __be16 *p;
        u8 *tag;
        u16 out;

-       /* Pad out to at least 60 bytes */
-       if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
-               return NULL;
-
        /* Packets over 1496 bytes get dropped unless they get padded
         * out to 1518 bytes. 1496 is ETH_DATA_LEN - tag which is hardly
         * a coinicidence, and 1518 is ETH_FRAME_LEN + FCS so we define
         * the threshold size and padding like this.
         */
        if (skb->len >=3D (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+               cnt++;
+
+               if (cnt =3D=3D 1) {
+                       pr_info("SKB before padding:\n");
+                       skb_dump(KERN_INFO, skb, true);
+               }
+
                if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN +
ETH_FCS_LEN, false)))
                        return NULL;
+
+               if (cnt =3D=3D 1) {
+                       pr_info("SKB after padding:\n");
+                       skb_dump(KERN_INFO, skb, true);
+               }
+       } else {
+               /* Pad out to at least 60 bytes */
+               if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+                       return NULL;
        }

# ping -s 1472 192.168.1.137

The result:

SKB before padding:
37 (192.168.1.13skb len=3D1514 headroom=3D18 headlen=3D1514 tailroom=3D260
mac=3D(18,14) net=3D(32,20) trans=3D52
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0xd4ef2b1 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
7): 1472 data bydev name=3Dlan0 feat=3D0x0002000000005020
tes
sk family=3D2 type=3D3 proto=3D1
skb headroom: 00000000: 00 02 00 01 00 00 00 00 00 00 03 78 02 00 bc ae
skb headroom: 00000010: 00 00
skb linear:   00000000: bc ae c5 6b a8 3d c2 2f 0b dc cc b4 08 00 45 00
skb linear:   00000010: 05 dc 3b de 40 00 40 01 75 68 c0 a8 01 01 c0 a8
skb linear:   00000020: 01 89 08 00 16 d2 09 54 00 00 8a cc 4d 0d 00 00
skb linear:   00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005e0: 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000100: 00 00 00 00

SKB after padding:
skb len=3D1518 headroom=3D18 headlen=3D1518 tailroom=3D256
mac=3D(18,14) net=3D(32,20) trans=3D52
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0xd4ef2b1 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
dev name=3Dlan0 feat=3D0x0002000000005020
sk family=3D2 type=3D3 proto=3D1
skb headroom: 00000000: 00 02 00 01 00 00 00 00 00 00 03 78 02 00 bc ae
skb headroom: 00000010: 00 00
skb linear:   00000000: bc ae c5 6b a8 3d c2 2f 0b dc cc b4 08 00 45 00
skb linear:   00000010: 05 dc 3b de 40 00 40 01 75 68 c0 a8 01 01 c0 a8
skb linear:   00000020: 01 89 08 00 16 d2 09 54 00 00 8a cc 4d 0d 00 00
skb linear:   00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

As expected the linear SKB is 4 bytes longer in this case.

Yours,
Linus Walleij

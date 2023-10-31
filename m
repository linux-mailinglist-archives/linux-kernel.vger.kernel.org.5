Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BC7DD6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjJaT1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:27:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2008DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:27:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5b31c5143a0so14078537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698780455; x=1699385255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgTgTKvE0/LmQ0UUACnDmBGwKLa/huixJLu9yRIa1F8=;
        b=Y9NkdNF4XAvRrtpq9suMkYZCI+J39LWfu7lo9Rjwak+6iDLPIrvffo9urFBXAaimTw
         qAQrrfi6pCuEqufuf4fRN37/19CwB5fDJHCgMg1Rk58S2VYlzhJ8i9yo8lMjognD6HJn
         A9gTOU6EobaCkKHVFSETnSvwOc405+ap1PfZ5WGQaCeQHvlM8oFOmtXBXQsfkie/jSoq
         qAJZq2PG/IseCZd88KiHoSkuv7HcpHG5+GxGuVGl9RYSwRgpI6vI96hgl09CEW+enMUf
         bDJaZ+Wj10d/W5aycrotQKOaTUJoQ+2zpn2dVwWWUNuL9PT6vmMH9pMYnNWnWWASl7nB
         KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780455; x=1699385255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgTgTKvE0/LmQ0UUACnDmBGwKLa/huixJLu9yRIa1F8=;
        b=Nt+Kk5JmacV5UM9akR41ba33vDsaIgVff6qpMOd1hamUqi9DOb41uhMNVxUB9jBYTQ
         JLW5ZdO+tASQ0J4v0aCFMVIT3XgkTII29WXti8zDZaxNpLjTykjes4XvEffXbQ9awKeL
         TaI5VHU7Q90VpiFTWF/ZFWtbrnGJ09l4q7y0HEOBNmtr3wKIFKOWH2lcX+ahNGwnKxdz
         0t0tVpKExdLs9McfXTFdxdfD7v/vpyLAWiSVdk7LpyBGz3TPpOrs53MlhRRBwEcGv7yx
         MQHAQX2P8cdCuBe1+syFPNpMMmv4DZXv32dPPyJkEv7ioJA5tnm7NtJ38P8E8d/jY1kZ
         2v/g==
X-Gm-Message-State: AOJu0YzUk2GxqmQ67ayD5SdVq9LfuPxznHh0Ws8Q+zKODnh0q+3NmDW+
        PoWnPMjyGr5RkVc5vun/8w7OGwkCBtxjDJhS0fONGQ==
X-Google-Smtp-Source: AGHT+IG66fduY86n48AWpX5L97lmRXb8vy/r6q2nf+6ervn5ys90qiYepzmZ5jvGaySDmnGn3l7ay7dvG7mhXw389RA=
X-Received: by 2002:a81:ed07:0:b0:5a7:ba09:e58b with SMTP id
 k7-20020a81ed07000000b005a7ba09e58bmr13510373ywm.14.1698780455136; Tue, 31
 Oct 2023 12:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
In-Reply-To: <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 20:27:23 +0100
Message-ID: <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:18=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > I don't have any other RTL8366RB systems than the D-Link DIR-685.
> >
> > I however have several systems with the same backing ethernet controlle=
r
> > connected directly to a PHY and they all work fine.
>
> Hi Linus,
>
> I ported TL-WR1043nd to DSA using RTL8366RB on OpenWrt main. Do you
> need some help testing the switch?

Yes!

> I just need to test ping with different sizes?

Yes try to ping the host from the router:

ping -s 1472 192.168.1.1 or so to send a 1500 byte ping packet,
which will be padded up to a 1518 byte ethernet frame and
1522 bytes from the conduit interface.

Then if it doesn't work, see if this patch solves the issue!

Yours,
Linus Walleij

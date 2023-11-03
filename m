Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620787E072B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376531AbjKCRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbjKCRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:05:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71A1BF;
        Fri,  3 Nov 2023 10:05:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5094cb3a036so2456260e87.2;
        Fri, 03 Nov 2023 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699031126; x=1699635926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ra48a/diU9zU4ICxF1SoHC79GMLCW1QW6hYOR1nW/k8=;
        b=UCKKREozCId+2rb1w4LEl0RuFDQq7/5c0r51wj2TbmAkv0C+uHtYqbF8aJoZreAI+b
         Mavbh4vwZS0d7dHw1SWDTxkdJE5K9ATQNWxLS/Y3txLQuXNuQ7Rps786hkkl/GbVKwN+
         KXav4Glv6TFo2j5bGzs4k8oz98/VCmsyjX/Lutl7RmDd1LxX+rv3XhHCnbG1BX/IZeJo
         zR9QUBf50NWYG0HAFFuSAQ3IPavAFGa3oewBYS+drTXVsHUvg5Uz3j5Hby3nbrle1JZo
         JTeE4+0C0dBKgYZGoKVieGjTWYwn29xrQvWGarQpAnabApKW4Kl8+itxYMa4nn0JsWIM
         lmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699031126; x=1699635926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ra48a/diU9zU4ICxF1SoHC79GMLCW1QW6hYOR1nW/k8=;
        b=jmZXuLCDw/PrwT/YC5/dD4cyi16RsPbd9AJMmk49+KnQUwQ4wWWYJIr8j2x14xj0SP
         dvRTJ1s8MCArPOz7XtYrcEn3I4Fs1718VRjAX90gGb+DhsaQPRWHh6Md4UvYXNQZGwTQ
         QnuT677HKMW034LY5330P2lQdIrdT5Xc49j3nO+d4BLIjNwqlvo/IhxsN36y016Ofkgx
         QTeuJiWOdFYGRZSRWRvUoz5KOK05u049QQMiyxP4lrUB184IIRSN0IbcQY/AoffFKEE5
         nCg7BngSBUGH8YUf0ci0WeZ50CHaFJ7h8Ic6g3BOjQLIer1lY8maIpqil5fFsLTZJe7O
         rBbw==
X-Gm-Message-State: AOJu0YwkOS4sjaaIG6LPJevoioKdwLSSmH7xuUkUJzZcP5qsBKmHHfvD
        o1EdxxfyOFZP8f8Qa8HOcByuBxhm1cazvdPGCQE=
X-Google-Smtp-Source: AGHT+IF7SywHLKeV2yNChg8/96UC4L44wmo1ar+oTLz/4SylqZQZ0qPk6t4P3rh05RvrE+cGXMZChl7IB03gIFPQkqk=
X-Received: by 2002:ac2:4d93:0:b0:507:b074:ecd4 with SMTP id
 g19-20020ac24d93000000b00507b074ecd4mr16171692lfe.7.1699031125964; Fri, 03
 Nov 2023 10:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com> <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
In-Reply-To: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date:   Fri, 3 Nov 2023 14:05:14 -0300
Message-ID: <CAJq09z58A1ZkRfESHU4-Ouv9JYCfDctJ7L7TS2rGRkpDChLbxA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > [    3.967086] realtek-smi switch: set MAC: 42:E4:F5:XX:XX:XX
>
> Unrelated: I have seen other DSA switches "inherit" the MAC of the
> conduit interface (BRCM). I wonder if we could do that too instead
> of this random MAC number. Usually the conduit interface has a
> properly configured MAC.
>
> > [    3.976779] realtek-smi switch: missing child interrupt-controller node
> > [    3.983455] realtek-smi switch: no interrupt support
> > [    4.158891] realtek-smi switch: no LED for port 5
>
> Are the LEDs working? My device has no LEDs so I have never
> tested it, despite I coded it. (Also these days we can actually
> support each LED individually configured from device tree using
> the LED API, but that would be quite a bit of code, so only some
> fun for the aspiring developer...)

No at all. LEDs sometimes change state all together but they normally
are just kept on.

My device is not funny to play with. It has only 32MB of RAM and it
frequently OOM. Even flashing a new image requires some sokoban,
unloading all possible kernel modules. It is not usable anymore in the
real world but I might take a look at LEDs just for fun. The LEDs in
the old swconfig driver do work and I can compare the code.

> > Maybe the ag71xx driver is doing something differently.
>
> I'll look at it!
>
> Thanks a lot Luiz,

I'm glad to help.

Regards,

Luiz

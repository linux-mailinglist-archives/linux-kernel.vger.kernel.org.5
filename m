Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF817DD88F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjJaWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJaWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:45:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E991BED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:45:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7b91faf40so61521737b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698792310; x=1699397110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKvWTyDCWBL9OQU/8hWPAY1ypzqmRlRhrzmC//TK/0=;
        b=PMXvc1HGovDdOgdkRz1v4Q3k6/CIteWWFtrKVjAqOHlXJiwbUEq8fyEWOXKZJy/7t/
         atC/W06dSLAtMne9lxd8OBUdP+AVt+lQygPzuEKAA4FjfKACY0V6ZwdsTPCC78O7mv86
         j3ZhjKpWbtzYylbkQ+J44kh7/d1/4mAUtJx6zzSQA6dFyi/51GKKrWL8BDVjQrJI2V4D
         l5uC2lbUq2dfOpvBuyXrFgO+qUzSTbNu7IC0qVPOr+nBicFam8UHMwzKkOV4LNIUW4oR
         mHFDG9fLXynwFKGsOCl297SngxJESWWhCgrHoFH7wnWVLyeJ7ZANUjwo8kDJ5XTIhkrY
         RkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792310; x=1699397110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKvWTyDCWBL9OQU/8hWPAY1ypzqmRlRhrzmC//TK/0=;
        b=jTDV6vfh3jiqhA7fTAwijRMMMl2hX893aYk7i+Xfr1LbioxQbeVNSVZbVkb3+fn/b4
         rgtpWKqZC9rgJcz8TqBFoJPLFxOUIozEpmsHVnTTZUMxW5m/TyVyYOQA4Ge+tB5b5lme
         1IzYGatGT03iZjMnlDCOG/raRFWmZd4Djfl6Z/XUGbdK8adCUq5jqBd+XUMQXfiRzSAH
         XeNTzyF+ccbEI991S0FfN56ty7TUtGALe3WqBKeiyZBEO7bEg6S4q2vwchnqGmi1F2zj
         dcSQnHS5OMbv/gMo5u80E42WrtVY7dBzjdyOWeWs5oLtulHkh/jJDUt73lyP7od0OJn7
         WdEg==
X-Gm-Message-State: AOJu0YwkcBjVQkdZ6s7vfp8G0EZHZPO6wRqh/RnNkZBEdCmhAqqoetwk
        VZ9jZ/LOruK3AsMo5fc0VO4VxHtO80tCdEBzVz4CTw==
X-Google-Smtp-Source: AGHT+IEVhT08slaD0cviprClJ11oBBkTF7KarPEXR1oQtHOzYSbbVOhednfPakavUA9zUqbBJmyVFLCqc9EqXQvgNk0=
X-Received: by 2002:a81:b668:0:b0:5a8:8330:6f20 with SMTP id
 h40-20020a81b668000000b005a883306f20mr14934750ywk.23.1698792310074; Tue, 31
 Oct 2023 15:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org> <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
In-Reply-To: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 23:44:58 +0100
Message-ID: <CACRpkdZUYg6APYU4vz5XRUDSp8P0jndgZH-J_q27MUsmZkQODw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 3:16=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

>         if (skb->len >=3D 1496)
>                 __skb_put_padto(skb, 1518, false);
>
>         (...)
>
>         skb_push(skb, 4);
>
> which means that here, skb->len will be 1522, if it was originally 1496.
> So the code adds 26 extra octets, and only 4 of those are legitimate (a t=
ag).
> The rest is absolutely unexplained, which means that until there is a
> valid explanation for them:

Indeed only 4 of them are needed, I tested to add 4 bytes on the tail
for > 1496 and it works.

I'll send a new version.

However that its "tag" is bogus since the extra tail isn't needed before
the paket becomes 1496 bytes, i.e. 1500 bytes including the tag.
It has a logic to it but ... yeah. All I can think of is bad VHDL in the
switch.

Yours,
Linus Walleij

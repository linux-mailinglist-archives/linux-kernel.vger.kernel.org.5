Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B47D75E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjJYUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:39:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5355136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:39:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b4145e887bso69304b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698266343; x=1698871143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6khk/5saRJ5wqqk5EGjL6JypeKXNJsBDKUmUNtNfB6U=;
        b=pnQz7nldP3CvSiz3y3q9b2E9Fvds8IGmkjpONP8Lvg52VcrjFKivWPY9z/SSAadrfM
         FcOQhGkOtCU47FVjofOIQRbYPC70K2uxNtMPldouKQIA/Z2NsrQL2/oUawC34Uuw277X
         FIA8i0VPYGPj/6oaWQBjJZfFLzAXdWxRxkP+oS9UxyGKP2PcMyk+dUwGDa7CrELYBS9V
         4Qe3+xwBWugLMr/16E6grLoDqAxSiozeYEtZnmSJCV0B4MD7v8KoqLFlVicQf0onFTgj
         lyt140Kk/WJhEB75HssRBFS7bo/ADMHCmeTJhh75ti9yul105axQV4G+4Gm1DpRopSsr
         SVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266343; x=1698871143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6khk/5saRJ5wqqk5EGjL6JypeKXNJsBDKUmUNtNfB6U=;
        b=ZgjALxb+ZZN5S8L/h4E2hwMZRtIedkJGhSnvkZfFfeRRoxriMzZtR2vCPqftSPLiC2
         XBrxm5Xa8xc/qZsr5zYgtxO9uGfbXC5dXenIRpQdbPdpTMa8ih4gHKm0PsOL2Pf024kb
         agSOaUkF9VFjcMWD0wdqd+sc692DklB/TUmfIi12WnOHkGSr2qbXKGlGCvXnqgFwZDyR
         20XIDFz96cMgZXKrXFL9Ntg4YGdLJ4o8GJ3HYDA8XVSYfslY7Vn/pFxkQpaIOJnomo0j
         8X1ssJHJ01WDvR/7Cu81LQUijNoET3ooGX0qG2IwP2JvGexq0GBaM/Qi3fTtUnplWpjp
         Cc4g==
X-Gm-Message-State: AOJu0Yx0LpPrNXtqCkT+8fX1zav2ruYr5/yKjD4wjBy+/kewjEJqk3uM
        OMuCCm3uXB4TPdzXIknRMGwdP0OlF8Ihpm3qoluW9MxnUSpBLaqN
X-Google-Smtp-Source: AGHT+IGREe0uQGqyfG23kicSwvwK4dDtMAqN6R5iQBzlVa/gRHPbGYMD4dpmT7V4Kupo3PvpH+/9VzgtRxdVQGk5XbA=
X-Received: by 2002:a05:6808:d4f:b0:3a9:cfb5:4641 with SMTP id
 w15-20020a0568080d4f00b003a9cfb54641mr18694195oik.48.1698266343061; Wed, 25
 Oct 2023 13:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
 <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org>
 <169815156038.3447619.17571704457000261488.robh@kernel.org>
 <CACRpkdZMSfKYaXR9NWpvca094=Prc6N8ZfR+QMcfS6VQ-prQRA@mail.gmail.com> <20231024201024.6cyoqy5vbctbgtfe@skbuf>
In-Reply-To: <20231024201024.6cyoqy5vbctbgtfe@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Oct 2023 22:38:50 +0200
Message-ID: <CACRpkdb2TRa4v9Phv0Qf3oDz8hAiwsmnSq7oU2dXarHoYZVyVA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>
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

On Tue, Oct 24, 2023 at 10:10=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:

> FWIW, we have a rule in Documentation/process/maintainer-netdev.rst to
> not repost more frequently than once every 24 hours. Unfortunately I
> don't have a huge review capacity right now, so in my case it could
> probably take even a bit more than that. But it's a bit unpleasant that
> I left some feedback on v4, you posted v5 yesterday and since then we're
> now at v7, only for me to find that I need to repeat my v4 feedback.

I'm sorry, too enthusiastic.
I'll try to pace it down, the patches will not be for v6.7 anyway.

Yours,
Linus Walleij

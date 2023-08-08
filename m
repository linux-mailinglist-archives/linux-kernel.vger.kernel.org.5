Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B094774738
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHHTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHHTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:11:29 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90D31018
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:33:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bb07d274feso4825148a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691512364; x=1692117164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFaCPHe174CVGEE8zH9Ahbm1V8fDZn/hHt9ByI29bII=;
        b=xpxuUzoNiwS4nE334fmSiwp7P75jSG9xDNu5MfxY+1Q5ohkvkrOYHvj5b0SsKqYSuo
         lg25mZqZB8X3BZ6CZfz0AWg0Oi/F6VQj9n9Dzf8ILOgTiKmaxXdia19fQuFAy+LoBxLF
         OCO9aEvfSPY2+lhkrBkv9+TzcSIFo6vb44jB2W1wH3sInPbxEznQ0KqZKqaD3NEwrHej
         aV+0fIwg6SiNqqstHNtItYIi8NL2WF/K0rwvZfGg9Xy8e1NAi04zqKhbKk82R/pvjrOe
         GBXSNdy1himxSJCBE1fGlr6ACQNitZI0NHHqMcX1YzfCBf1Hxb5GgfUfEiPYBdwacWBQ
         866g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512364; x=1692117164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFaCPHe174CVGEE8zH9Ahbm1V8fDZn/hHt9ByI29bII=;
        b=BaeEDJJAT3Wdn0m0jaxMnjjB3oxRN6qf+LqRdF81UicNsu8ckrjye3hJ3s6732U3wk
         VbRpC5xHi0pwzTOrh5OIZgC1Gj4BnvdDx7QrXlMGTAUt5scqIkAyLu/1GRlLv4GKD5R/
         OJ9jz527sB52H/WVwI0AsoxLaLlkRh/uum64/qPWl6zbYRuiwu58icovM1aH92R14YBY
         cBKomORcxTbYpyuNhSFNgRfJWtCxNCuqLRck39b17k3XuCLtKRpf0e0B02+o1XiaenBT
         9abBZv6LqUqaCTdUgiP/8YOea0FgcSE0lSvNPqLpp8IE2oRFIgRojUi/TIi4gRxRP2iC
         7Mgg==
X-Gm-Message-State: AOJu0YyXbrzFNvL9XRLH2tYIdsg+/XNyDNqUzjG8DduHjGmysEHbgEtL
        QGH1MAWX/uNs+U8QFWVNVaZ2hzBoPeWVxvL983wNVLOlTFMwBPyq7jR1Kw==
X-Google-Smtp-Source: AGHT+IHJBjMCQdov9YPeDDL3pj/hzheBYljv6pXkkWjpc+VqMX3zeR6MAG9XffwSYmTvNmQRvGVPCfEVk5oblz/k9hQ=
X-Received: by 2002:a67:d095:0:b0:444:e9a0:13f7 with SMTP id
 s21-20020a67d095000000b00444e9a013f7mr5544633vsi.5.1691482400513; Tue, 08 Aug
 2023 01:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
In-Reply-To: <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Aug 2023 10:13:09 +0200
Message-ID: <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 9:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 07, 2023 at 09:31:00PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Two MACs may share MDIO lines to the PHYs. Let's allow that in the
> > stmmac driver by providing a new device-tree property allowing one MAC
> > node to reference the MDIO bus defined on a second MAC node.
>
> I don't understand why this is needed. phy-handle can point to a phy
> on any MDIO bus. So it is no problem for one MAC to point to the other
> MACs MDIO bus as is.
>
> You do sometimes get into ordering problems, especially if MAC0 is
> pointing to a PHY on MAC1 MDIO bus. But MAC0 should get a
> -EPROBE_DEFER, MAC1 then probes, creating its MDIO bus and the two
> PHYs on it, and then later MAC0 is probes again and is successful.
>
>      Andrew

Ok so upon some further investigation, the actual culprit is in stmmac
platform code - it always tries to register an MDIO bus - independent
of whether there is an actual mdio child node - unless the MAC is
marked explicitly as having a fixed-link.

When I fixed that, MAC1's probe is correctly deferred until MAC0 has
created the MDIO bus.

Even so, isn't it useful to actually reference the shared MDIO bus in some =
way?

If the schematics look something like this:

--------           -------
| MAC0 |--MDIO-----| PHY |
-------- |     |   -------
         |     |
-------- |     |   -------
| MAC1 |--     ----| PHY |
--------           -------

Then it would make sense to model it on the device tree?

Anyway, this can be discussed later, I will drop this for now and send
a fix for stmmac mdio code instead to get this upstream.

Bart

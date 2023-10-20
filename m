Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49C7D0F29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbjJTLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377257AbjJTLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:53:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4349F0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:41:39 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a8628e54d4so6421107b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697802095; x=1698406895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9bFjh5A1TAJojJW7zz66RNNSkHFaHMwwCUObsG9YEY=;
        b=JUeISjOp5CJHSK1LLZ3b/u3mYHgZxPngvU03BRjZmiFfCPp6/xz+gLqFakwrBql5Za
         020cR5pMnki2DOfExiPXmpv3lv8HSVYiwi2E9eLlzkec4HsNE8fU1xl+ZWpu5sKG0BLq
         bbzD4fhC20QOC77PiZGXqaTKnBomR6PyQFHcWZ8sAx9J7AZTg0tEKve1VJJmWyErG/7r
         6tTNiiI0MNDwLXVdt787JgD6SN4P7kFbKCY54330XpOhxvfC9iGWeaK1A32QiMEYXdlf
         oISaiyG7M4YFqa46ykaCjXmgWCjGTgspaWcd7uQAcik+NiUqbWwFnwqI9XwpDgtPSfZ7
         uOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802095; x=1698406895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9bFjh5A1TAJojJW7zz66RNNSkHFaHMwwCUObsG9YEY=;
        b=HeUEWPBypINoI4X1CCL4fpynch90oqJuPPOpUIemsbZfK+MNl9H6Zu5j6h7PiIkm9M
         qmwqLt63UXKNAwv/BVI3JbfW+2gH8GZQTDfz9eUybcqZykeBiH9jIHThbnnX5vJ8lDS/
         MVyy3t8OQb0S/hOCCZGOJ9xhpF1hUsNQ7iiXG3eVc6XBmocUZr+Siqm+TGCL20XCCnIm
         KvUho09ToWotCziiVweXXEhBtD4wWHHwc9N94q2IOYVCA+Css3XYjF54yv3yap8x2K1T
         eWjEu5J3vFubYQOzyEtFh6ZfjHROy+EBk3n5ZUVJmppAcnrWCjz+BTd3GZZJfXIgu+1j
         QOWw==
X-Gm-Message-State: AOJu0Yxh/NY5A7tRZYnHg1FepFPZ8DoGw3qrO800BbT/88EEMIPjmhy9
        6ms5E+la2rYeJsXjPzjqBW1Z7lHHm8lyQEICeJBs7A==
X-Google-Smtp-Source: AGHT+IHyOEVIA5SJ7Y199R5jt+d5f7KKXk70NiIvNCL1uO+i83Ow7XGvhR98WYwCuuNubMD7tt45A0AuyLyah3Upinw=
X-Received: by 2002:a05:690c:dcb:b0:5a7:cb5f:ee0a with SMTP id
 db11-20020a05690c0dcb00b005a7cb5fee0amr1391397ywb.17.1697802094778; Fri, 20
 Oct 2023 04:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org> <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org>
In-Reply-To: <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Oct 2023 13:41:22 +0200
Message-ID: <CACRpkdbKxmMk+-OcB6zgH7Nf_jL-AV7H_S4eEcjjjywK0xCJ4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 18/10/2023 13:11, Linus Walleij wrote:
> > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> >> On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:


> >> yamllint warnings/errors:
> >> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] w=
rong indentation: expected 8 but found 6 (indentation)
> >> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] w=
rong indentation: expected 8 but found 6 (indentation)
> >
> > Really?
> >
> > +  oneOf:
> > +    - required:
> > +      - ports
>
> .........^ here
>
> > +    - required:
> > +      - ethernet-ports
> >
> > Two spaces after the oneOf, 2 spaces after a required as usual.
> > I don't get it.
>
> Although YAML accepts your indentation, yamllint does not and we always,
> always, expected yamllint flavor of syntax.

That's chill, however I can't reproduce this, make dt_bindings_check in the
mainline kernel does not yield this warning (after pip install
--upgrade --user dtschema
and yamllint is installed and all), so right now my only way of testing thi=
s
patch is to mail it to the mailing list and have it tested by Rob's bot.

I just don't understand what I'm supposed to do... drop the dash-space "- "=
 in
front of "- ports"? Then the bot will be happy?

(This patch was added in response to Rob's comments
"this should probably be in dsa.yaml".)

We can also just drop the patch if this whole thing upsets the tooling, it'=
s
just intended as a generalization of this requirement as can be seen in
Documentation/devicetree/bindings/net/dsa/qca8k.yaml
which in turn can do that because it is not using the generic def.

Yours,
Linus Walleij

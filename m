Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F57D5141
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjJXNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjJXNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:18:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C52E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:18:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7b91faf40so44454487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698153504; x=1698758304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK4tlfB40aqyIbGfcZKKtFRCSp8E1XW/N6tHWlAqgFs=;
        b=pdum9Tot8y7I0KBpyt/DHom/G4gWQavA3NQm/z4lf57FC3hgzzk/0n/Y3TWCrFcRo5
         1ZjCRVSC6YdjpMWmOplkz7DnJ/Y0O6E1VjI2UyB0hKjB+jjUSRoXalkLZlmblX/5fGuN
         Pf4fMYHJZzxWrU1H8tPel4uZr1fF0L4It7kOhi/yREHtEuCTegxveVZGt0o86Z+xw/Af
         nmIag8FspgsueQm+rkNTIdGBaMOVl3aO8B8/K8Q5E4lWmRmi3w9VD0PElzkPtod4BRm4
         fUOlqaA06dWis8I3JedDhuWtPbRZSMiSzM3QHj3lZtUfVnuxd3dQEIDJ70XV2+0hN+i0
         p6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153504; x=1698758304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK4tlfB40aqyIbGfcZKKtFRCSp8E1XW/N6tHWlAqgFs=;
        b=kFU06L//FNVZWSiVA6Hd7ocs+SxLtFKnqxUVDwNmZLbROMsQcQvtVe/NJN9Iwx7Mj4
         otk5lZ5jUW0HghBKRNV1Fq1c8+0zfI4nymB7rQzpDnDGcaZtxGm1BVhVVQDaMdRmDEqy
         waDMl/xfb3/9d7PmMxq/N/Y70zXPXRekziojURHVRByw4nIlBKCtqeXt5qz7QR2uF4WF
         evleS581iJnctmNhHSgU+SMy1h3VUvHwcQ6H/YvSiVZjOCg1dQJB2dRIlJ8pCEsgSmxz
         jjfyp97gNurTQ+/059VSnXcRP4iwceyBZVVC9fifxEVof/x0SG4pjusgD/vMEusEfLjw
         /rDw==
X-Gm-Message-State: AOJu0YzTiZbkdBPlh8wrYJwTWxl6Y3ZEp1I82rJKdh7ye4x/sjoc2/iD
        z6oG8iJYzYam88KirylgfGvnJKqqIxWIZQDK5dgGXw==
X-Google-Smtp-Source: AGHT+IEsQm6TC/PsELFB6VUH2p0OkBlq/WNQwnX7ZXTcfQ9guM+9xx0KlZKskEACCos7j+/6xMMZARnP77vLXSQ/76g=
X-Received: by 2002:a05:690c:18:b0:599:da80:e1e6 with SMTP id
 bc24-20020a05690c001800b00599da80e1e6mr14174785ywb.34.1698153504688; Tue, 24
 Oct 2023 06:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
 <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org> <169815156038.3447619.17571704457000261488.robh@kernel.org>
In-Reply-To: <169815156038.3447619.17571704457000261488.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 15:18:13 +0200
Message-ID: <CACRpkdZMSfKYaXR9NWpvca094=Prc6N8ZfR+QMcfS6VQ-prQRA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
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

On Tue, Oct 24, 2023 at 2:48=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, 24 Oct 2023 11:24:53 +0200, Linus Walleij wrote:
> > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > a DSA switch node need to have a ports or ethernet-ports
> > subnode, and that is actually required, so add requirements
> > using oneOf.
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:5: [warning] wron=
g indentation: expected 6 but found 4 (indentation)
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:5: [warning] wron=
g indentation: expected 6 but found 4 (indentation)

Oh yeah Krzysztof actually explained to me why these have to have
two spaces extra.

Oh well I just keep hitting the robot for testing this.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21D7CDAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjJRLk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjJRLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:40:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52CD55
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:39:57 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7af52ee31so81518217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629196; x=1698233996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seUdplTAMb/zRp5FDRW3ieCXWuBCH/+x0BQ3MBVM2m0=;
        b=nGv8WXFGFB/xUG42snGADeTohgk11NlPAXED8Xn1vzcosZuH65oLc0DMOYJP1FnQMm
         h5j2zwTGZsQdafrdca9b9Lrw16d0hn22Al3FH+XL3T7ALzFOOaoQZ7w/dFgddVz34AYk
         AxZ335FLmBojzFhs6kh3pIcjbKHRLSNHReH0Nh76NHIrKOexVddJe68pzvOLBHXs+uo1
         r6ttOJIhNeBJKCpSYHlK96femSM35QMOjwMn3vPy7fcSlX+BdiS2Ka+MPPqgEZt9WjVx
         N4r+c6ykcQVr3TAxfuhXMkJJzKVlvFZS8wTibWs2YFGQPP8IuDszo6wukzHJOSWl9yAE
         H/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629196; x=1698233996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seUdplTAMb/zRp5FDRW3ieCXWuBCH/+x0BQ3MBVM2m0=;
        b=Sfh7NeTy+BfDoKts8+Lkybl+hIjoaSpwk9vTYmcC5nC9NLH1sFCCGQ3ad6j39cBCz3
         IGHdZlvUjSDsFXTI8bV+mpVIYSWHkGUFzOagplm748hqFXI+7hM4dQtdVR2a98D9L+oa
         YWpBN53r07vmrJkOoFAVDvLwYonterCWvcSAIhJvSdNYr2ANceOaAilLdPpJAXNgqGTm
         3jvrIr0PyK92Nvy+kK09Zfbycg4vK5Y92ZcDAnZ3vVM0SNXLOPbqzwLlPacAvCdYdmFH
         8rafOpDG9BTwI4dmnmtp7LCq8i8GyLeBmlYP7scDAViQ44RIYeEqd44imMijef8D6lK2
         F5yQ==
X-Gm-Message-State: AOJu0Ywm04uAWvAol4jPcFDQYmPNqNSgYbvePNbhM2QhKtLBmf6FfKd3
        y837uyVqDDESOA4VKT6PyAOJVZEnCCo8YxCSAjPHQg==
X-Google-Smtp-Source: AGHT+IGd6pMmcUmYhIP19DAntAI7kjrqy+WPuQL4RuNHhD2KtYzr3w/qLLHu6U4w6Mo5RaObRLXBuuHLDdyNrlBBvQI=
X-Received: by 2002:a0d:e8c2:0:b0:5a4:db86:4ea8 with SMTP id
 r185-20020a0de8c2000000b005a4db864ea8mr4887814ywe.31.1697629196493; Wed, 18
 Oct 2023 04:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org> <169762516805.391872.4190043734592153628.robh@kernel.org>
In-Reply-To: <169762516805.391872.4190043734592153628.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 13:39:45 +0200
Message-ID: <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To:     Rob Herring <robh@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>
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

On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a requir=
ed property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required =
property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a requir=
ed property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required =
property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#

Fixed in patch 2/7?

Yours,
Linus Walleij

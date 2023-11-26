Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6B7F953F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjKZURQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:17:14 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98ACE5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:17:20 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cd81e76164so28266047b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701029840; x=1701634640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGQxMQ+7TPzoJGNme16X7jOyAmsWmKBeIpeI/o460JY=;
        b=Jbk6UNHtgzHaulz5zHeqtXbdbLFh0LGyvo3x85bWBXizAERXSbGPUi96KpHepJpLfR
         dv4iPcjvcWPmdE/87HloCuBf2W2uc7EkLB12PNgO2J3B0spoQ3koUCMKKWqIvj5ZNOBb
         14dpk8Nn2fg14QhMVyU3l+dXm3wGo5zqlZj96tcYa1zmlVz6qGXrzsKM2dBM6o4NrCtU
         KJXLszDKAZY7uGtexeH/BQQ2s7dWqsU3EaoBlG6SSUrFQlec716hyXs2rlOaDbvUMvYl
         nl8sL/vqMQQ+sz1XuV9noEE7FruytItH+MulfertHRViU0D30KWwwSLOIT4imC7qyWkQ
         jBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029840; x=1701634640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGQxMQ+7TPzoJGNme16X7jOyAmsWmKBeIpeI/o460JY=;
        b=U3mZVvwY179M3//yWkZ3XO9V8z+1HPBopgLXeIXbLb4JMIGY9hMgG2OFBiRUcqFcZI
         PA1S1fwZRWhRhlugvATfPVUDG5g8w+qMBrq+bYqZ16hQYSQF+Id0osxPOdcRiaWY83O8
         2J13Cq0gzTGRZZyOqS90fD/YoObMJsIq6T/+GdDm4j81X659gF5n20ZTLyizBY2d3o9r
         2slJ2KPNNK4tjD4JvPqGuxaoBfG9NhRvLxJCmrCa3aygVkYsCgTEjtykePGvkO2+bNM/
         /lK30V/3r8Y5vmB6Efs/t98wHE5qWBXZG7Rr+ZYIqzZz4vq4UbCRIBg8FXpUz5FjbSOm
         c4sg==
X-Gm-Message-State: AOJu0YwJtDB5fQm8sN/ryp5qWv67ekaC97cqXiLV0zhNfvbnpuTJhnQW
        Zef/374N7sowXWbvugiGhV2zp77XWuEb30lvtJy4Iw==
X-Google-Smtp-Source: AGHT+IHWzWgY6G+ZpHJvXD08LVNLOaSle54xXRVOSyGrJ8hGvRW+fV/RwdUxWsfmEXDi6UpYj0b1xGi7vi7sbiQg7wY=
X-Received: by 2002:a05:690c:c09:b0:5ce:7ac9:d10c with SMTP id
 cl9-20020a05690c0c0900b005ce7ac9d10cmr8206213ywb.32.1701029840087; Sun, 26
 Nov 2023 12:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch> <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
In-Reply-To: <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Nov 2023 21:17:08 +0100
Message-ID: <CACRpkdZvMRXHKktM-HPZZRCrV0JgErqDOHmkyKAcB36ObwOX7A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
To:     Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:50=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Tue, Nov 14, 2023 at 10:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
>
> > So i have one open question. How do we merge this?
> >
> > Can we just take it all through the DT tree?
>
> If we don't expect the affected DTS files to have orthogonal
> modifications we certainly could, if the respective subarch
> mainatiners are OK with it and can ACK that approach.
>
> For Marvell that's you I guess :)
>
> For NXP VF that's Shawn Guo, Shawn are you OK with
> these changes going through the net tree?

Shawn is busy I guess, but looking at the activity in arch/arm/boot/dts/nxp
iIt seems pretty risk-free to apply.

An alternative is to simply apply all but patch 4/9 (the NXP patch), becaus=
e
the rest is Andrew territory.

Yours,
Linus Walleij

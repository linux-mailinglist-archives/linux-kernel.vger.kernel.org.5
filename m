Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F17BDDE4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376830AbjJINOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376960AbjJINNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:13:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB4FF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:13:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8164e661abso4681709276.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696857216; x=1697462016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKZKnrRJ3sYtky/2h2Hus8kthq+g2qZ6Wg41eu1H8Lg=;
        b=bm00HPNOX1W0TXsn3nZTubMYOd4U2VYtG5z5sgnF3NZ3jNgl7keFI1QaIujZxL+Ul/
         ULXUqfU/kXpd2NTSTjDQ7WNBx9AwRAxNy/OAWm6hqyKweQY8mwNpso13k6ZMtiyjep+E
         y7TTA/n5PoAG4gGyquc4uJqn0Y3xF2wFzB1KiHMlkaO9Z0OoGCg4ccJ2gM67EsqEXW7q
         9ZaEdmO/KI4ElXiMgsOIUSeC0lJRqaN9Hw7Xlg+f+0KvyLOH9Bx9o/LcVXUs2vkvm5X+
         iFy7xmDb8h2x06/yh/zaB+7rdLwYjpkSCZt6oip+uFKX2gBSGV3GeofttNg3b6teJJLZ
         OM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857216; x=1697462016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKZKnrRJ3sYtky/2h2Hus8kthq+g2qZ6Wg41eu1H8Lg=;
        b=VTG1PsJ5LZqBsIjjRF3brAqeBb9bKGtfQK9o52YNXajx5UqO+5IR6EYcCI0KnK0rZR
         uj8SnPxQTmo6LuFLvAswbXlPtu76pfXv2SmvEyRBqtSPyXVF/HbDBUl4DkKShF2KrkzP
         zV+FURvegNNY1T3zfF4Q6eZB1gMh0xaQfL/Jd6HHPTC2TjqvV6hg5xJBuwrDuBTgTE6Y
         vts/TMiz9C6ieyD54aC0W5QsTVzuC3PNlYjGQtuDausxY2HvGFZdXjXjInwPy2XVZJ4e
         AKv10RtPFHfbvnL+z2/n/BTZfR5U9d9f3w2UTpVJrCRNt7Mie4Gncl2Psd4fBv6bxbMi
         D7yA==
X-Gm-Message-State: AOJu0Yzyt+NphUWwBnrZi7oU3/xaVYwEMFygRepzNVP6hUj81Ng8Maxi
        O5gvMr8FZ3/HdfKynAq6MJ3Zx+6y3+muyOPVoj6Lzg==
X-Google-Smtp-Source: AGHT+IGt4o+K7vRBblvmGc6ypN/viBqCTAHECrQcma5UGrocmzfjWytyeGJeKtv1Oy5/0dhqamzM1xbB19zZG60qbYE=
X-Received: by 2002:a25:768d:0:b0:d7a:e0f6:54cc with SMTP id
 r135-20020a25768d000000b00d7ae0f654ccmr14186498ybc.26.1696857216181; Mon, 09
 Oct 2023 06:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com> <ZSPDILYZkxvTnQia@e120937-lin>
In-Reply-To: <ZSPDILYZkxvTnQia@e120937-lin>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Oct 2023 15:13:24 +0200
Message-ID: <CACRpkdY=eza0TuBRDb_cWk9LM2qNQg76rZSgWa-RP4TYLL=Ppw@mail.gmail.com>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        sudeep.holla@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:08=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:

> > > +    gpio0: gpio@0 {
> > > +        compatible =3D "pin-control-gpio";
> > > +        gpio-controller;
> > > +        #gpio-cells =3D <2>;
> > > +        gpio-ranges =3D <&scmi_pinctrl 0 10 5>,
> > > +                      <&scmi_pinctrl 5 0 0>;
> > > +        gpio-ranges-group-names =3D "",
> > > +                                  "pinmux_gpio";
> > > +    };
> >
>
> Assuming the above &scmi_pinctrl refers to the protocol node as we
> usually do,

No it does not, it is a three-layer cake.

scmi <-> scmi_pinctrl <-> scmi_gpio

it refers to the scmi_pinctrl node.

There is no SCMI GPIO protocol, instead SCMI is using the
operations already available in the pin controller to exercise
GPIO. Generic pin control has operations to drive lines for
example, and Takahiro is adding the ability for a generic pin
controller to also read a line.

Yours,
Linus Walleij

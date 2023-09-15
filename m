Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A47A2569
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjIOSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjIOSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:14:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6601FF5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:14:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d8181087dc9so2249185276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694801675; x=1695406475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbloVE8nmpRklzhuAiR112rqAdagyUfXz/yXE+ALMUw=;
        b=pD9LDM/jSQsevy3WblHMaCVcpilmziyEba7tYSSaaFOrvpVuWkruqHyckseN4DitTJ
         wd6Y/m0hHoBdFcKMdsEM1CBqXSyMvfOWsBFm1zZw1nenYG1XHA/Ciw43LuVIkZYxLpHx
         YFhrN1+yQpOYuByKY0nI0482YFZzL+VzxEgdrP2wgf9HlYUQfkhmMRW9y1O4Dj6m2Jb5
         WdXQTr12xuDe1Xn8aIHEAKDAI3Z2ei0mo9HJnkhS4Up6Hj2RVlMdVeDelgczXRdp2HMW
         hEf9Ylu6AQVGqWwkUIdA4yhHSR7oRP+rf1FDftaLpG0jZGPK1ZldFHsnbnwPd8kHGTbG
         fLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694801675; x=1695406475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbloVE8nmpRklzhuAiR112rqAdagyUfXz/yXE+ALMUw=;
        b=APCds8fazM79TbOLwzdG/ybBmzTSj42FEtzMEHRnvd3alAm/HXA+23FyPQRjKxJ8Ib
         qXHmUNY6VRfJ+64hUQ/QamEDSXyrtYoJ1RdsXBNZHc2U9OJdHI58XoJaxxb44So/uUou
         +qslqTmnOrnt5oCoOVMLoM9Wk2lfX3QY0c5zSbGwlKZCCcQX0Du5aWmSOYN/cWLIzXeh
         ng3bLMoWrKY+T1ZcY9ubqoYNJmiBMs1e8hFA8d3ycVhOcs5umvK2UcrU8QqOwA63PLA1
         M+S8DzFBvYGwxC+ms0Ukdi//0pyPkbVlHiFXv882jixWNY21PK5J/PfIpnNNuYLQw54H
         ctjQ==
X-Gm-Message-State: AOJu0YwbnzJsN3qAhkSz9Rh+z2iZxGfYArsKQK3bp21mlrObGRVXXoWR
        2Lma8SbOR05Dnt85sPMcf1blqCr3KgMMB13WYwjeCA==
X-Google-Smtp-Source: AGHT+IGhlDPPzTH3Fqdci1fTXm/PKLPUl8DSShnol/oSLFycRyWZpMfwroUjr2RIyQNpxuS8IG60KfH3yNBFW9UaSaI=
X-Received: by 2002:a25:9702:0:b0:d82:9342:8612 with SMTP id
 d2-20020a259702000000b00d8293428612mr97916ybo.12.1694801671461; Fri, 15 Sep
 2023 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda@linaro.org> <20230915141549.GA3658872-robh@kernel.org>
In-Reply-To: <20230915141549.GA3658872-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 20:14:19 +0200
Message-ID: <CACRpkdaG2oGGDjLGWgdi7Y-QS_1Odj7cbbuDiBX8DdNx7agOiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: triggers: gpio: Rewrite to use trigger-sources
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:15=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> > +     /*
> > +      * The generic property "trigger-sources" is followed,
> > +      * and we hope that this is a GPIO.
> > +      */
> > +     gpio_data->gpiod =3D fwnode_gpiod_get_index(dev->fwnode,
> > +                                               "trigger-sources",
> > +                                               0, GPIOD_IN,
> > +                                               "led-trigger");
>
> Isn't this going to look for "trigger-sources-gpio" and
> ""trigger-sources-gpios"?

Indeed. I'll simply code an exception for this into
gpiolib-of.c, it's an OF pecularity after all.

Yours,
Linus Walleij

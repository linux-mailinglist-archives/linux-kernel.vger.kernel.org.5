Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790F7531C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjGNGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjGNGJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:09:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DC2724
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:09:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6f943383eso22586781fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689314965; x=1691906965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orndSSj2UwJllcFmURUAszpsDxToWW+bTCSrpDuMB50=;
        b=rSEucAgbUYeHVSTSXbX4h9GDYS7AeA8YfypaK3t0f6sWPqzBWQ/QvuRZTL8H2O6J1X
         zaZ2wmQb0KGIHIikVtnGAD1g4DfHldSNxbhWr1jKDz1mauD7+5RnWspMa4fLwtvagkMK
         wRPzB99gpXTCYAWWelL1AcWzOUjnPSspm6YWQhRlL9KARAvHdzc3c+bjQxEL7q/L52cq
         EFU9PekimSQVQl5N0LgDJ1Sdsh+D3Yr39lZpEq+etM8KnUCAHoKLdW8QGrTMFcQc13/3
         TO1Mw4QglCtfnsDEfqJ7KGed8AxkbcPl129VsMSxvmn84pht1j7uG9ZJW9Z5Xat/cyoR
         N7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314965; x=1691906965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orndSSj2UwJllcFmURUAszpsDxToWW+bTCSrpDuMB50=;
        b=iW/b8D91ANL1L/NW55SPK/UN34BgRoRMEKMFNB/cIZAbyLw44EzwgwoFlH2HQBN/uv
         JzferSaADB+MUqm4Zm7xF+YzDKiWCfPhEpK5h3CP8vySnLJ6P7v2DycBOdqDNGn+uFKD
         zI7dQWn7wby8LuuXGYFuakZTrDgdrT8cYGznvVeRRsGN+9cGkAWc2eJBDujjO6ZGYwc5
         y/igPABxzQu7cTYntjGf7mxjpjaL0gCFJeU3PSpjq3XxkdWOHu3iarOf3y05dDHTMRAH
         eslTLsG35jaCgBhtB+USo/FjTW6+dLPbkg2pWDvO1kJjolyFD4ektrYUZgUdkWzG1FGK
         H7qA==
X-Gm-Message-State: ABy/qLaI2o41UBDVI1bb1QYB6m9gba8mOMBxPgAbKPPOV/1dQcXzAe1T
        /GjP4VQBV4k1VjsEmcVzv7pyT1Of1bWNcQNLJ5vNTw==
X-Google-Smtp-Source: APBJJlFjLd9SWBhGndhtxU1nyRlXyT203Tkpfb7Enzl8TGvLVxH8C8IUB34raRw1SX1qPqj8h/XE/oW4vWlS8LF/62A=
X-Received: by 2002:a2e:9284:0:b0:2b5:8a21:5627 with SMTP id
 d4-20020a2e9284000000b002b58a215627mr3394159ljh.51.1689314965292; Thu, 13 Jul
 2023 23:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
In-Reply-To: <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 14 Jul 2023 09:09:14 +0300
Message-ID: <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +set_reg:
> > +     mutex_lock(&phydev->lock);
> > +     rc =3D phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> > +                           VSC8531_CLKOUT_CNTL, mask, set);
> > +     mutex_unlock(&phydev->lock);
>
> What is this mutex protecting?

This was inspired by vsc85xx_edge_rate_cntl_set().
Which has the same format.

I'll re-test with this lock removed.
I may be misremembering (or maybe I did something silly at some
point), but there was a weird stack-trace warning before adding this
lock there.
This was with a 5.10.116 kernel version.

>
>      Andrew

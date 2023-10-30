Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FC7DB480
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjJ3Hjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJ3Hjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:39:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE0D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:39:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so3560672276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698651584; x=1699256384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2xzc+4V3pjtNNji+lt7+KZcsYsbe7/AwgknDeXfupc=;
        b=aZp7Ftxp2VsEE7ZvbwEelk8uUN4tbWHeU8PWkmlPO7lFgVyut2VFSjDAE/Mbbl88AV
         kAlWjgCXKPxIunYabPbfpol3vfPSvYhX+Xzo3J50TRZdeQ1HroOtQ32DcECZ5TZgmQ2o
         8/6UJaASQPEB0TCDi7nkRTA1HleITA0pWtV9Ehu1ILIlinERGC8bv+o9pYBrq2VY6GWV
         AbVA6WknWIJ7MQjMVtocg6JIpxWPWNOuSPUMTBFHRGcscbPWvjkno8pxvQhXPKEUW4ow
         pAtiIiZr3RSjfax0vO9hQEGdanbHa/Bfh2HkP19v8l8qj7mQmLGTdTua6rlVT14WA1fl
         0FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651584; x=1699256384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2xzc+4V3pjtNNji+lt7+KZcsYsbe7/AwgknDeXfupc=;
        b=bNKuS+on3wIUICS8Q2/8eOeDkqh1dnWvl+I2ITco4scUDk/oyWlIP9uEtvgZB0v5nR
         lJBPyX28rinSQABLrjZZyyEcymOA1sc0eGClVEsiA6DCOF8ay7r9wlEc6dbYnHRyl41Q
         FgrDp83I1Alek/Ln6Is+j3/6v+y5N9p2ZpNUIv4ZKfnN+bTuT1UHposssBWUzubsB8XT
         kkzcf5ya5/5sMMJ8w4Phn9qNMJwm1TyiRRKw+x/pcj0wcTLDY5+vDzFgSF9HLowWtWhh
         QdWo+yuF3mTZJiE8wn2KddrJfbzsGsGjyY9SQLk0RTL/o5WwPVdMciW9POHGrnce0M3C
         TaOA==
X-Gm-Message-State: AOJu0YxQmE2yFit27n7l6IP8LG15lZq/cuMIA+ubXeaYYCuJ3Jf4Wgjj
        fkh0ZuIln+A/+UApaBbDTn7e42wOAY8kXLqvTjVzWyqUvwBGmq0D
X-Google-Smtp-Source: AGHT+IGzN5VdTFqyOdXnElQpS0BpsQlNE2DuCDvNp8TKt1PyIUJ/oxKGJYobpdPpd4lVLkf5kG9gp2v3udScopsX0Dc=
X-Received: by 2002:a25:4246:0:b0:d9c:28cb:2e54 with SMTP id
 p67-20020a254246000000b00d9c28cb2e54mr17328230yba.18.1698651584308; Mon, 30
 Oct 2023 00:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <20231028220402.gdsynephzfkpvk4m@skbuf> <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
 <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
In-Reply-To: <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Oct 2023 08:39:26 +0100
Message-ID: <CACRpkdZXAqkn0QeX4s2JFmyMOz82uQq7C18408Kow-peN8tCqA@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Mauri Sandberg <sandberg@mailfence.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:00=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> > 1496 is suspiciously much 1500 - DSA tag size. However the
> > MTU of the parent ethernet is bumped nicely to 1504 and the
> > device MTU is set up to accomodate it as well.
> >
> > Modifying the patch to just pad out packets >=3D 1496 bytes
> > solves the problem in a better way, but maybe that is not the
> > last thing we try here...
>
> Have you tried playing with RTL8366RB_SGCR in rtl8366rb_change_mtu()?

Yes I set the MTU to increasingly larger sizes.

Sadly MTU has nothing to do with this, it's really annoying,
I have a v2 patch that is better and working, I'll include some test
text so you see where the problem is.

Yours,
Linus Walleij

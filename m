Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0DB7DAEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjJ2WQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2WQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:16:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728BBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:16:11 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso3075621276.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698617770; x=1699222570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DHjqrde8ErThPTqoMnEMyFAJvtH9637SxQ0kWsDcbc=;
        b=cnu9R1Hunif6hkx5vZzhlV3YK2KmVCIWJOkI6CzrPQpSHK7PCPBYIe81RwPFeYsSuE
         dUHZIW8IzlV4y2Eu4tNQwxek4iXGTHEXhKRcFW+VCBBu6LMJoOGrPmmoN9C3kZHVCELD
         g60CmbAJgPyZapM3aO5+8lkW+4vYnY3Rpvy0QeDoucK3wov24x9ppE5Ue2pP88Oklk4N
         66YGRp7I6Vd1wPWJ1h93sM0ll4IKajJ/GrRrD7K2fbwh4tLGf4V1ISqID79ntZRyfCRU
         WMq8x6T0XnIjaiNaSH0V5kRcS5bfKS3sjK+nz2aA6NOeeVpr4UibOAa/nSsQ/OkgUj1F
         ZH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698617770; x=1699222570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DHjqrde8ErThPTqoMnEMyFAJvtH9637SxQ0kWsDcbc=;
        b=MJxXCBxcKkNXZbrE/cXBHYK3AEg5aDHAu56QFIZANCXbZUSDY/mDr68aTNoSD4JjMs
         HyFnNR3Q+j9rkkbffWDqYHiUs/bWERgPYrKGIuMf9FD9+e707KhhR1aRkKSxkTdCImj2
         XOYDqcyzDeoyZ8vYSWvY457Lnua2olDuMFZNsebLG+cTT+Cy57w7/FOCjs3h4ND+8jfH
         NmXy7PBXFzrNeY0mw8l5XAYYYH7MU8HpxF/x7OKDAwa0R6ABEXfhpzkjb9/PYqi2nM6j
         oOnpyNLVrNEfAsxhJOANj5xdJ0a7i8Wc6hJrpYGD3ez8vhNZwFJSF8ylJj4i2Y3yc8PO
         EgcA==
X-Gm-Message-State: AOJu0YwRDzaUrt9WC1bGgLaA/jzWloTndcsPFoyhB7o5jANCz87c9/Ow
        ccmc6m9mV/POnOUqm+BYmjHFgdrCgzRmJvW8t3/pug==
X-Google-Smtp-Source: AGHT+IH/StsWnId+Cl/46lJYj7GmjzV1lpbpqKYC2PXIsJJCbV0u0G6JHkFtvVTBSMTpOiMlJ+iZzujaEVJfuab+ppg=
X-Received: by 2002:a25:ab32:0:b0:d9b:4a2c:7a73 with SMTP id
 u47-20020a25ab32000000b00d9b4a2c7a73mr7311315ybi.61.1698617770419; Sun, 29
 Oct 2023 15:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org> <20231028220402.gdsynephzfkpvk4m@skbuf>
In-Reply-To: <20231028220402.gdsynephzfkpvk4m@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Oct 2023 23:15:58 +0100
Message-ID: <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     DENG Qingfang <dqfext@gmail.com>,
        Mauri Sandberg <sandberg@mailfence.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

first: THANKS, because you ALWAYS ask the *right* questions,
and I quickly get closer to the real solution!

On Sun, Oct 29, 2023 at 12:04=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Fri, Oct 27, 2023 at 10:21:39PM +0200, Linus Walleij wrote:

> > It was reported that the "LuCI" web UI was not working properly
> > with a device using the RTL8366RB switch. Disabling the egress
> > port tagging code made the switch work again, but this is not
> > a good solution as we want to be able to direct traffic to a
> > certain port.
> >
> > It turns out that sometimes, but not always, small packets are
> > dropped by the switch for no reason.
>
> "For no reason" is a technical statement which means "an unspecific/incon=
clusive
> drop reason in the ethtool -S output on the conduit interface (which also
> shows the hardware counters of the CPU port", or is it just a figure of
> speech? If just a figure of speech, could you please determine which
> counter gets incremented when the switch drops packets?

I ran ethtool -S on the switch port before and after trying to access the w=
eb
UI (LuCI) on the router with the chip, i.e. putting http://192.168.1.1 into
the address bar of a browser and hitting enter three times.

Then I ran diff -ur on the two outputs (before and after) and get this
disturbing and symmetric stat:

-     Dot1dTpPortInDiscards: 0
+     Dot1dTpPortInDiscards: 3

(Counters defined in drivers/net/dsa/realtek/rtl8366rb.c)

> What user port is being targeted when the switch drops packets? Any user
> port, or just specific ones?

I tried on lan0, lan1, lan2 and lan3 (DSA ports 0,1,2,3): same result.
On each of the ports, the same Dot1dTpPortInDiscards counter
goes up.

> What protocol headers do those packets that are dropped have?

HTTP

> Is it size
> that they have in common, I wonder (given that you say that small
> packets are not always dropped), or is it something else?

I got it wrong, it's big packets getting dropped, not small ones... :(

Some tcpdump:ing gives at hand that the problem is that the
httpd is sending 1500 byte packages. Anything over 1496 fails
in ping tests.

1496 is suspiciously much 1500 - DSA tag size. However the
MTU of the parent ethernet is bumped nicely to 1504 and the
device MTU is set up to accomodate it as well.

Modifying the patch to just pad out packets >=3D 1496 bytes
solves the problem in a better way, but maybe that is not the
last thing we try here...

I'll resend the patch with more elaborate commit log and test
description in the commit.

> > Fixes: 0e90dfa7a8d8 ("net: dsa: tag_rtl4_a: Fix egress tags")
>
> Have you actually checked out this sha1sum and confirmed that the packet
> drop can be reproduced there? Ideally you could also go back to a bit
> earlier, to commit 9eb8bc593a5e ("net: dsa: tag_rtl4_a: fix egress tags")
> (this is a different commit from Qingfang with the same description) and
> test on user port 0 only?

Yes it should be an earlier commit indeed. I'll fix!

Yours,
Linus Walleij

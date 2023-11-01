Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9FC7DE70B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbjKAU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjKAU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:27:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AEF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:27:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da2b9234a9fso170900276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698870421; x=1699475221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od7geAUO03xnUMzUzl75DCFJAJ0NbP3Lvnn4+QKHjsU=;
        b=fFxX+nmjf8auP6ELv8OU+J7F/2kaXNgndRo7QT3fxgez8gbPJp5hH1iJArQ6TKdCdR
         zh6VPgLjVOz73GtcDryexoYD8QHZxn8wRkyR3pz7NWI0CsGFsurlUmU1582zuUKO82RG
         k2z0U3o0oziyrmw7F+CaQO1xFbSMvkDtg0aaCycBMfaLIdLETmCU5PV/65RJciVPr3Ud
         5fQUAldGRCP9Py0rzLFRynEc6BiWSuri/F21X9wpqF/VNJSNld+yPQmJhGqPwtu+K3QF
         DQXvjmzgRs/uUMAAL48tcemFt48d7BBWCjPXvFdBpMZsVOZfeK8xv/NzR78hLup8l63S
         ZWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698870421; x=1699475221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od7geAUO03xnUMzUzl75DCFJAJ0NbP3Lvnn4+QKHjsU=;
        b=qOo+MwF8V2j3CPAAsQQVv3CHoc4ohj6km+4Y1c25vdjy9W+yIZcdJ1zK+z5X2vfeuK
         Bl8+I9IuHs1PF/OhcGZ30qJos69teUtGimitlvTxmLX8NNvSJ9zl2AXsrYMBVW6IY07j
         CoZJxFVDW04obLFWfCVGdLINx7dTTQcYYhLv4BDXP+BCuGbUo3uQfqUoX37rg87uPIR9
         Sga3A7nAXhaEPeg9Y3THPyk8iP4qs1x6xdEAMHFFNyiuF6XyaONrzbM3FFhO6mzq3EgD
         8jrnQHpd9qZUAQEJlIVZrUC8RzFp/M39vS0wfVRmz4PLQloJ5riFBvQtKnaEuw7ZC/nD
         xphw==
X-Gm-Message-State: AOJu0YyjNcyewr1q9VlHDxgCNcBnOf6mCBCJuPxArVTmbJlBqe7qFDLA
        sxUFdg9KuVuCfPpfAy5DLAkiNBNx7TiuCw6HxDY7bA==
X-Google-Smtp-Source: AGHT+IERUS9wZpG0G9tTSAI7ntlLEE1Up8/dHJ77FkgP7CXWZVBWN2fratkaV2J3fGu67QsCNqw7x/nnpRe4KxM4H2w=
X-Received: by 2002:a25:40c7:0:b0:d9b:9aeb:8c26 with SMTP id
 n190-20020a2540c7000000b00d9b9aeb8c26mr14111496yba.40.1698870421285; Wed, 01
 Nov 2023 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com> <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
In-Reply-To: <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Nov 2023 21:26:50 +0100
Message-ID: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 1:35=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Sorry but I noticed no issues:

Don't be sorry about that, it's good news because now I know
where to look, i.e. in the ethernet controller.

> My device is using
> https://github.com/luizluca/openwrt/tree/ath79_dsa_prep%2Bdevices . In
> summary, kernel 6.1 with openwrt generic patches and the
> reset-controller patch I sent net-next recently.

Looking good to me.

> [    3.888540] realtek-smi switch: found an RTL8366RB switch
> [    3.952366] realtek-smi switch: RTL5937 ver 3 chip found

Same version as mine too.

> [    3.967086] realtek-smi switch: set MAC: 42:E4:F5:XX:XX:XX

Unrelated: I have seen other DSA switches "inherit" the MAC of the
conduit interface (BRCM). I wonder if we could do that too instead
of this random MAC number. Usually the conduit interface has a
properly configured MAC.

> [    3.976779] realtek-smi switch: missing child interrupt-controller nod=
e
> [    3.983455] realtek-smi switch: no interrupt support
> [    4.158891] realtek-smi switch: no LED for port 5

Are the LEDs working? My device has no LEDs so I have never
tested it, despite I coded it. (Also these days we can actually
support each LED individually configured from device tree using
the LED API, but that would be quite a bit of code, so only some
fun for the aspiring developer...)

> Maybe the ag71xx driver is doing something differently.

I'll look at it!

Thanks a lot Luiz,
Linus Walleij

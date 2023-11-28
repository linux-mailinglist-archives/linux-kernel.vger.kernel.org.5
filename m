Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66797FC143
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbjK1O1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbjK1O1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:27:03 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15D1BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:27:07 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cdc0b3526eso36299277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701181627; x=1701786427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX51WsgBh7fAZJnYdm3LGG3k8tSGHp+BwBoxwyn46fI=;
        b=bqueN1YIDON7farcbH3pY/uOo8nElYT8922irYe/P/SMSr8jEPhsrcpeZcYE2AIf+p
         W1NfvHjYc47AVe2UkDCBK1ljfTFT1bl9K0Xw6wP3gfpGv349bCKopXl2zaPMMK3cXGmZ
         IWQedcqyskXO8UfFjp6FUh3ILuzredIYqDznlG8IXZWD5e4xMe5xji4wW+4wAjpRE5Q2
         rl6uPqiXCSo8paqaDAtjt5xXFG+pZl+Ok9c1/mifDcDQHv7tGErPGxGZtp2x8gvji8dr
         6Bbovn1kcesMqdfyHwKrLC6ngobcHL/G6dYG26emGJY9hxPB8GYNlx/kHW4sddssGpRz
         Kr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181627; x=1701786427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX51WsgBh7fAZJnYdm3LGG3k8tSGHp+BwBoxwyn46fI=;
        b=uEcFCYY75COPQmTUF8U1/Rg0xVoAsJS8eSROZyeDNDJGdsSXY6LHuKvh5XoznJ1KAQ
         CHqoGRYq7aKGhabefQQSP8k7w9q59zTlWq2Fj74A7HhMcL2Y2G+33XhTaB3+4D8O+NYZ
         0HwTb4vbdHG1z1xUZ+XjiqAWx25uY1srdPei9RXRgdcqFsmOk4fKYFGps25LBp/npRm8
         j5kHScE3F6f7DVqjTCoqGOsrlMfICuk9Zxyte3HKmDdCF9k8RG6SSXS2cBXouaAUZMTn
         MQ5UkmJB1p4RJ+2HU2n1W43r3tN+LaSooooWu4b2dSdD33hGihEA8xT0fSWnIyQxtZlt
         z27g==
X-Gm-Message-State: AOJu0YyhL2ynO55C/6yAeWNFMuDPl6kU19k7rqwyn2t1JgTsZCTugyyY
        QT3j0wsEoFLhP8Dn1YLlLKyiEgTCxvIPUlAHClm5fw==
X-Google-Smtp-Source: AGHT+IHxRwisBihnXdRMmCLGshGiUARUDlL2k1HSR24biOIrpIFvzinty4ukiQWuah55vT3Ag1bodB2brjgsCrPY6wY=
X-Received: by 2002:a05:690c:2b0b:b0:5ce:2148:d4bd with SMTP id
 em11-20020a05690c2b0b00b005ce2148d4bdmr10093638ywb.4.1701181627190; Tue, 28
 Nov 2023 06:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20231128132534.258459-1-herve.codina@bootlin.com> <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
In-Reply-To: <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 15:26:56 +0100
Message-ID: <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256 framer
To:     Mark Brown <broonie@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 3:03=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Tue, Nov 28, 2023 at 02:25:29PM +0100, Herve Codina wrote:
> > Hi,
> >
> > This series introduces the framer infrastructure and adds the PEF2256
> > framer provider.
> >
> > Patches were previously sent as part of a full feature series and were
> > previously reviewed in that context:
> > "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1=
]
> >
> > In order to ease the merge, the full feature series has been split and
> > this series contains patches related to the framer part (infrastructure
> > and provider).
> >  - Introduce framer infrastructure (patch 1)
> >  - Add PEF2256 framer provider (patches 2, 3, 4, 5)
>
> If this gets applied it'd be good to get a signed tag based off Linus'
> tree so things that depend on it can be pulled into other trees (eg, the
> ASoC mapping for the framer).

Do you mean my pin control tree or the big penguins tree? :D
(I'm guessing mine.)

I thought this thing would be merged primarily into the networking
tree, and I don't know if they do signed tags, I usually create an
immutable branch but that should work just as fine I guess.

If people wants this from the pinctrl tree (and patches are ACKed by
everyone involved etc) I can certainly do that if the netdev
people are happy to pull an immutable branch from me.

Yours,
Linus Walleij

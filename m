Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663257FC1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbjK1OvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjK1OvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:51:08 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB0D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:51:13 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cc642e4c69so55890597b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183073; x=1701787873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtKmT2DzohXXoeUBiHE1NcptmxFv6Dlq3tIhE5fHNKY=;
        b=pGA1AxnEi0vbxlKeQTOZmHBhbdAZg/XT8T/uVzs6SlTOCS/gE09/1JHaHENUP8BHvw
         916kqWzTq4du3rRsYUDSkMsQBjPh9uy/YkqA80Fsq80SFqKtgx997MrvEtxQpPjkogt9
         lx445AtC7C9M2jnZgQhmpS+C9s3lXBsqldeMwOBu3RodutPKgzlCx+OkI8cz1389e63P
         S/11yo5yDQTzAnMDfqxW2Rgn3ScLkTvFa3bhIuQdJug0OGgY5l3WjTNVG6P9E1s8ZwI5
         L3RF42wP0Z9nsIDoU3/Rh53QEhjdPSYHuYloEHQQMHH/hrPNiaARB/DA2sVjxbDEauUu
         YxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183073; x=1701787873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtKmT2DzohXXoeUBiHE1NcptmxFv6Dlq3tIhE5fHNKY=;
        b=DeVlemBCyyUCEoTv75CgxJGiFbjQbCICYha+ALbaq9c77HLTVyGmCAzxdiuuFM4JlB
         bdO8ilRbPVWD3278HDFzcbYOkUet/tcyGfPHV2LYMfjKfKGSUG5atRvApt43iFCOkrMw
         m/lmq6sdbQ9wCMK3UNfqHtG2MuWxi8vIKxrpcOTNyN9E8TcJsm+tX39rF1GmwKMTiJZR
         9f498Lqp7wbXTDq9PxgOOIZjEf34b2uLuI7fGriySMHPNteWk3LXuIQa+OKLIv/KXz2u
         xgzCkTq0ZwT3g3pywKCxfYqZLZ7++yDzU28LoKUy1CopY1HXj0VPUtzwFDLLtRZSZcNg
         FnbA==
X-Gm-Message-State: AOJu0Yy6+87cxVJp1lM1IExqYdMn5GWE52t8Ap8zYjqGfBzwgog9YC8x
        UQodvDJ+x9CgOze/VX7Fe0Pf46DBhnvo2NNeS1hIEw==
X-Google-Smtp-Source: AGHT+IFicSzJpbzDad6aZAB4TqQT3PWofoExEOGqMaEEhn64uKOyh66vKgcpu9+rbTZ3JgFvV5lGar3bJdV2yzjDIas=
X-Received: by 2002:a05:690c:2d87:b0:5ce:98c8:df07 with SMTP id
 er7-20020a05690c2d8700b005ce98c8df07mr11919406ywb.26.1701183073137; Tue, 28
 Nov 2023 06:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20231128132534.258459-1-herve.codina@bootlin.com>
 <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk> <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
 <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
In-Reply-To: <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 15:51:01 +0100
Message-ID: <CACRpkdYmN4318b1wXwUOeFjPN0S2w8M9FpXHOs3LtFa+XoTxVw@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 3:41=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Tue, Nov 28, 2023 at 03:26:56PM +0100, Linus Walleij wrote:
> > On Tue, Nov 28, 2023 at 3:03=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > If this gets applied it'd be good to get a signed tag based off Linus=
'
> > > tree so things that depend on it can be pulled into other trees (eg, =
the
> > > ASoC mapping for the framer).
>
> > Do you mean my pin control tree or the big penguins tree? :D
> > (I'm guessing mine.)
>
> I actually meant mainline there.

Ah based off, not residing in. My bad.

> > I thought this thing would be merged primarily into the networking
> > tree, and I don't know if they do signed tags, I usually create an
> > immutable branch but that should work just as fine I guess.
>
> Right, I'd expect a signed tag on the immutable branch - it's generally
> helpful to avoid confusion about the branch actually being immutable.

Makes sense, best to create that in the netdev tree if possible
I guess.

Yours,
Linus Walleij

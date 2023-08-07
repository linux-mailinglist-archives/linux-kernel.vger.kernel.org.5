Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA71771CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHGJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:01:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC8E74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:01:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so3257926276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691398865; x=1692003665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmPeF2Yo4yjKKsdpscDMoUm9x/eDwRXj5nItZhzfM78=;
        b=xwjGnQ22TOvfWV9zTt168I4LV00sZqTUcBeX/cs7f9wHCm3yhi9zZk4HkInarayqdL
         hbFoARgGD3zyplYs2CQrzVSqenn1thDeAegEpu+5IzplQyIWIB2OkX8tBF7MVkC8TORu
         iT6ZOf6xxUr6x7TuJgla6W06am+pbwPo3ldOfNSJxr819tbF8oa17l3ZMA3uInqUfwCy
         Y6UTMaQ3OjzXlnqhp8Z/S8aCGSax4oQ2T5uUt9LzppuyXmMmegnntrPF6ADX/4CG2RAq
         P1dGrHIy9Ta9y3StKmvvWDFGYo8CfDm36rlsXMzL1P67db/om0PR4TmCtAEJmY0L/XnW
         OS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398865; x=1692003665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmPeF2Yo4yjKKsdpscDMoUm9x/eDwRXj5nItZhzfM78=;
        b=AIitf/LF/CGuLnSxQhplGOcTHjkJmoKTfdNnKGWTcWOCa40ie2jbw6LEVihwYmVhBT
         6UBnIr3poittg6lJO12EDNhLbdinEMvNEc7NghnS86N05COoWxD5CrEuykeRjdG0HS45
         Z2t4ZNGrWW64x1T90O5gFq9tflRnTVKlusWHZ/NR+TYtQt3Dghp4kcvA0v6Wy9WPYbjZ
         A11DrDPWd3mpnyUtlsxcB4oHaeaIzDDgk8akrfnJ/cazr2UJoFOgm041TKZEALZs6Bqu
         /LS8ShGELFnjPZqNSmbZ6Am8udMdYE72hu8Xa0sS13J23ww8BYWfQPosbMKk3NuwBqb5
         Gt2Q==
X-Gm-Message-State: AOJu0YxWsXzWhfH7L1ANlUFqtIlgu+AJQpK/R7MdVT8TSYX1Hk5he1Qp
        vY+FMeV7xS10a4A/vNhFCdK4IUepGrZwkNKui8M4DmU3iDZrq5rSgps=
X-Google-Smtp-Source: AGHT+IGNz3qMrODq1LB5wqlhtqjoComq5pxU82VLl/izKto2p2jjd4gCjQ6Fb7pJkQbUsvyv5AUjgJJy55C7aN4ZuV4=
X-Received: by 2002:a5b:a8f:0:b0:d06:7e60:251a with SMTP id
 h15-20020a5b0a8f000000b00d067e60251amr8530675ybq.49.1691398865306; Mon, 07
 Aug 2023 02:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <20230712022250.2319557-2-colin.foster@in-advantage.com> <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
 <ZLmSvkizdykGGpv6@MSI.localdomain> <20230724065957.a72yejua7us5e2s3@soft-dev3-1>
 <ZL7JJ2nLA27Z/VnR@colin-ia-desktop>
In-Reply-To: <ZL7JJ2nLA27Z/VnR@colin-ia-desktop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 11:00:54 +0200
Message-ID: <CACRpkdZBzEqAiztAjfQw7wymb6sjpx2Wwgn_RP4ZuO6EdDLMzQ@mail.gmail.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add
 activity and blink functionality
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
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

On Mon, Jul 24, 2023 at 8:55=E2=80=AFPM Colin Foster
<colin.foster@in-advantage.com> wrote:

> Is there a tree I should test these patches against? I don't have any
> active development going on so I've been hopping along the latest RCs
> instead of keeping up with net-next, gpio-next, or otherwise...

Use the "devel" branch in the pinctrl tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

If you resend based on this branch I'll apply the patch, I think Horatiu's
reply counts as an Acked-by so record it as such.

Yours,
Linus Walleij

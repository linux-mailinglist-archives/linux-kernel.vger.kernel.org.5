Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B887C7784
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442588AbjJLT7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbjJLT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:59:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D12B7;
        Thu, 12 Oct 2023 12:59:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42606C43397;
        Thu, 12 Oct 2023 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140784;
        bh=xtxzdksc5dl0r8+k5pleTaspKNJ+Zn9WfG06u94llFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dg/IWe59hkWjSTXCX7pxouQ7rtqEu1pELE8X2UFbPeE5AU/mCMjFEuJcH23nUcTPq
         ZKqFLBrWgAQkAxNSjtThu6s6HAP8z+qQ9YRUgp8+nqFujzMPo/+lbDlohGCuotgl2m
         BTbysQuVG1uqdjjLh0w1qXKktOid333JKvkR3F9zHpMQK8ZNLivzoMaL+dZvekCCGD
         jGHCvPp8NCXzd72b0s13kmM4os9zqXQnPkx6SGPEe4Aj63iJRFQC/XuIpAQuaSFwBL
         6LfR//Y9cElvJrVPHdChprisBhxuLsDXYNi3tjo7ygxqHwqJKsqJpSrOnv24TOT5af
         r3AFygNiZPWIg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c5056059e0so1313851fa.3;
        Thu, 12 Oct 2023 12:59:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YzQJ0D882gj0CTt7IviEo3AykUDbf/yLfA6UJ5U7Y5l77g/q/xb
        ATcqOHy7UZ7dNGQycIviqQyiWTiTxrMOP25Odw==
X-Google-Smtp-Source: AGHT+IG5Giia/8iFXS++Hrtrgo9gbNcDu1M68Jz8U/9hXSm+ZWLSfwFKE5D3t4OBA10dstNAPnw63Gfl6mY1QeId0T4=
X-Received: by 2002:a2e:b893:0:b0:2c5:634:b45e with SMTP id
 r19-20020a2eb893000000b002c50634b45emr87993ljp.36.1697140782413; Thu, 12 Oct
 2023 12:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
 <20231010-pxa1908-lkml-v6-2-b2fe09240cf8@skole.hr> <20231012195337.GA1579632-robh@kernel.org>
In-Reply-To: <20231012195337.GA1579632-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Oct 2023 14:59:30 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cFeo4eoXfi66otrHnHvJ44Oj42=AxmZmqqdxQ53k1FA@mail.gmail.com>
Message-ID: <CAL_Jsq+cFeo4eoXfi66otrHnHvJ44Oj42=AxmZmqqdxQ53k1FA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 2:53=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Oct 10, 2023 at 07:27:19PM +0200, Duje Mihanovi=C4=87 wrote:
> > Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
> > separate pinctrl driver later.
> >
> > Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.y=
aml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > index 45a307d3ce16..0f7e16a28990 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> > @@ -32,6 +32,10 @@ properties:
> >                - ti,omap4-padconf
> >                - ti,omap5-padconf
> >            - const: pinctrl-single
> > +      - items:
> > +          - enum:
> > +              - marvell,pxa1908-padconf
>
> Just add this to the existing enum above.

NM, I see it's pinconf-single, not pinctrl-single.

Reviewed-by: Rob Herring <robh@kernel.org>

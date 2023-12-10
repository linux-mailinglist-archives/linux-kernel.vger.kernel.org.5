Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78480B950
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjLJGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:36:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D3118
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:36:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D70C433CA;
        Sun, 10 Dec 2023 06:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702190178;
        bh=M/6wLn8z1v9OB3jE3O+3Xw9Y4HHJzGOqFn+iYKs91HA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKiYYxXrm6vPl1EQLzPrXmKc0/zgzkZ+G3tf+mhbB4QXRQ5nxcdh8dGyjs8Gave0C
         F13e1vLXumCfh6WVCNCVX2TpJK3i+2ZqpC1ozk0xlYR89vsUvjyKHJ9udBvYbeBUfS
         2UDmDmjT/bGGjk2B953DCqdZtmZ+fmV00fNYwKFrTuwfwpAxN8NK7flqJw+iFyZDNO
         SLMesqIOb1r5r8zOdvt9x8iUNi+vv/zj8YBg18Gh5sZgqM2ETuik89c1msNCQK3iSg
         xHmRk4HVnadQDIE8xn9oR0gS+C3ycGB5+A8XvPgMh/B+YFAwPSskTjXdpJatuDbbCB
         O94jXj8BwLJkQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so2419516fac.2;
        Sat, 09 Dec 2023 22:36:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxMz3B7XPLIzZBWl4b1XmCECutrCAQfVGDR7TnGERpUMOLpOakt
        ZFYDX2BCGNWBgf2j+/6d86xLpZju4+MPk70PK4A=
X-Google-Smtp-Source: AGHT+IFQVJUQFeEFHsTwAZp7ZhGHssvbi/i98rUeBk2zW/8DwIEsjKJtvHV8cUWi9hmXG7QpO369Mg+JsytoM+93b/0=
X-Received: by 2002:a05:6870:4201:b0:1fb:20ca:95df with SMTP id
 u1-20020a056870420100b001fb20ca95dfmr3248841oac.39.1702190178238; Sat, 09 Dec
 2023 22:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20231203101418.1910661-1-masahiroy@kernel.org> <20231203191947.GA147536@ravnborg.org>
In-Reply-To: <20231203191947.GA147536@ravnborg.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Dec 2023 15:35:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5E2T0oitxniLhCAjf4e7QRPfyVpV8SU5P60_j1oF=uA@mail.gmail.com>
Message-ID: <CAK7LNAQ5E2T0oitxniLhCAjf4e7QRPfyVpV8SU5P60_j1oF=uA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparc: vdso: clean up build artifacts in arch/sparc/vdso/
To:     sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 4:21=E2=80=AFAM Sam Ravnborg <sam@ravnborg.org> wrot=
e:
>
> Hi Masahiro.
>
> On Sun, Dec 03, 2023 at 07:14:16PM +0900, Masahiro Yamada wrote:
> > Currently, vdso-image-*.c, vdso*.so, vdso*.so.dbg are not cleaned
> > because 'make clean' does not include include/config/auto.conf,
> > resulting in $(vdso_img-y) being empty.
> >
> > Add the build artifacts to 'targets' unconditionally.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Nice small fix/clean-ups.
>
> This and the following two patches are:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> > ---
> >


Series, applied to linux-kbuild.


--=20
Best Regards
Masahiro Yamada

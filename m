Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86327783D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjHVJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjHVJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:39:40 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF28CC9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:39:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79dbd1fb749so2626693241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692697177; x=1693301977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbReyeg+ZX9yYJxLZOuHPKL9n0rFDx2OMW9LIdDIrIU=;
        b=eDHu99p7Wa5XYAartbNh+kyJ5qv1towtr0dZa9O7FtmvqWAWw2vc3UvRsMCTXW+9v6
         nQXCy90TXbssB+oD3Gl62CjySoGa530jYVqlWy268Bmv/yLvfrTcsC/KpZdK1AxQh+QG
         fUI5K/hnHrgEyE1vLpDKcLMgEiO+8oqD7ctiXflZUZOOw5mO+xvQEpUf4bKpk4X8d+09
         Rmuh8wCa8o+uJQq8cincmrvVLlEJRMafgEILWrlq6UuTlfEgxPwCVz5taqKYgFkORCX6
         sGJSA9oFFNO1bg8TJGKo2flxVflgnFGZ01HOh1AmVtWbG3HxLRThN3nLm27PM+toTp3z
         9fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697177; x=1693301977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbReyeg+ZX9yYJxLZOuHPKL9n0rFDx2OMW9LIdDIrIU=;
        b=CjLBwQnUGJuynogCdmoJHK2h3UtpBFohXimcu1xrJNUY7/zEVh2UVEJ2fuw6hPDaQ3
         YB3/+4jZ2Urt4HZJRcghSLM5nJ0vw6UZbXRb6GhAT3wxKzDN7l5FaI+c5K8etlBde0K6
         d7L0R7ZlxWTpqRDehl44ZDzrKxbgvDhO/Os8kPwtAEYpbM8VX2BQ3NyXElgSMexL+0BM
         rx/PBrjbFx4iurUvhLj2hGPG8EbNOwO4PFJT/kTOf0d7QXSzIH10BRG1JpsztGlLAprG
         4fopESgje1igV8sV3M0stnmreGq5/F0aVdxEuyhekNzvTYEWHfWcIdR3BJaL0R1YKbOC
         +4bw==
X-Gm-Message-State: AOJu0YygP+bj6N0wUiQo3mUxY+OLVeBp1Sdnz9IncTT09Cnmxdv7Ki4M
        ZB+J2/C2d/V7zkOYKV8u8ViIdRxnTzeUYVxY2xxlww==
X-Google-Smtp-Source: AGHT+IE9xITkl3PGWa/uCLI3UJwTL59sU+T83Svd9B65LBc2WZeKczcaDWBZ+MMlwmZPX8YRTFJeqwyl7ZAVxjH6VH4=
X-Received: by 2002:a67:bb0a:0:b0:44d:3687:32e4 with SMTP id
 m10-20020a67bb0a000000b0044d368732e4mr5555746vsn.13.1692697177587; Tue, 22
 Aug 2023 02:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230506085928.933737-1-haibo.chen@nxp.com> <CACRpkdZDTxxNn2CDSBu5yKnw0qVuWH-a+dPYXdHndLZbxmyFAw@mail.gmail.com>
 <DB7PR04MB40104DABC8B1C5D9CC0CB0A4901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB40104DABC8B1C5D9CC0CB0A4901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Aug 2023 11:39:26 +0200
Message-ID: <CAMRc=MfgDSyPr_Wtjzae_1sSHr4eC_Afb4xarfSyi4aEzRZjgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: vf610: switch to dynamic allocat GPIO base
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 4:47=E2=80=AFAM Bough Chen <haibo.chen@nxp.com> wro=
te:
>
> > -----Original Message-----
> > From: Linus Walleij <linus.walleij@linaro.org>
> > Sent: 2023=E5=B9=B45=E6=9C=886=E6=97=A5 21:05
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: brgl@bgdev.pl; linux-gpio@vger.kernel.org; linux-kernel@vger.kernel=
.org;
> > dl-linux-imx <linux-imx@nxp.com>; christophe.leroy@csgroup.eu
> > Subject: Re: [PATCH 1/2] gpio: vf610: switch to dynamic allocat GPIO ba=
se
> >
> > On Sat, May 6, 2023 at 10:56=E2=80=AFAM <haibo.chen@nxp.com> wrote:
> >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > gpiolib want to get completely rid of static gpiobase allocation, so
> > > switch to dynamic allocat GPIO base, also can avoid warning
> > > message:
> > >
> > > [    1.529974] gpio gpiochip0: Static allocation of GPIO base
> > > is deprecated, use dynamic allocation.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hi Linus and Bartosz,
>
> For this patch, still not in the main trunk (Linux 6.5-rc7) and linux-nex=
t(next-20230818).
> Can you help apply or any comment?
>

I think I didn't apply it because the first patch in this series was
controversial with known user-space breakages. Now applied.

Bart

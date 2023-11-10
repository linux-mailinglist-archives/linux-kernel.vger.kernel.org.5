Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479CB7E76DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjKJBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:53:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89C44BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:53:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso1365711a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699581220; x=1700186020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnaT0Z5B52WFIm5oJG7or3ermouAvuswFcl8mKgJ3CY=;
        b=olpycT7mQN47h0ShOHE/rUMv8r+EnZWGZL0dS1L3fOc6dLknBhWFfcJPjHQOZoAj7V
         GENzIDKqu6Wl5G7KoFrfBY7HkL5g4vkbPQFH68aVlX73+ckmXv3g4ldirNBNAytTWeWt
         cLpCyjngvIHIzq8eWNl1SlnvdWDDiqQ9qN4pqFG5j64An7acOjtOQBTs7107FoD5Y5+l
         9I68yaWqS/IyfHYoPHHf8KDW6Eaj5f2SEXD43Xjaddzx/fZ9bq9YRzKXxfO3QdO61X1W
         hQVJcNRaULHutGejeWcj7BQx1rQQhnh2m74U/zHrysA3CyvSXtGnp5Udx6mgtDvVvX0e
         wMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699581220; x=1700186020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnaT0Z5B52WFIm5oJG7or3ermouAvuswFcl8mKgJ3CY=;
        b=Bhh4E4VRWfD+vt+kNVQo7WkR2bmepNInXmIjFkGTA+IDNBaYJdXpF3UOZzZZijbB49
         JvKWwNFsOMqNbdgVf8rNwARGMdaF20UHIqXPtRAfRERBMo/qqQ+4FVOPfz1Xmd2O2CLj
         trpTZ9sQLn+yODCPDq2nSwprtu27leh70G0YQdFRen6+ublO/2PmW5AKD145hQfvDAkf
         pQuDD4olNytXiAizhKYXF/T5+KodLH/gxEI2jPweN2vm9IXfKjkaYpqiU9JSpwodpVKX
         nVHKslLaVYYClvuFIER8vre8sDVtzwEA1mQHaZpiXsLsACG6eD1d0SonSHUdk6VXmCBS
         QZtw==
X-Gm-Message-State: AOJu0Yw1EvKUWYQtKBjwrzDq3APPSpnDfpbPN1VHzVw/pWE5XpWPkQzu
        8h/ucAxtPVlA2PM+sRPn5MQwLqEQ1q6obEYA/cAspA==
X-Google-Smtp-Source: AGHT+IF2CvB03hHPzpzbnXtgNai0HmCRBWMpJ5mKjo/l3DAboCyMcV2DzhG5H1Z8kNHGm3PqfcnZOixlZXvdL1XjSbI=
X-Received: by 2002:a17:90b:1a91:b0:27d:114e:d4a3 with SMTP id
 ng17-20020a17090b1a9100b0027d114ed4a3mr3203127pjb.14.1699581220612; Thu, 09
 Nov 2023 17:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20231109190925.2066-1-semen.protsenko@linaro.org> <3024abdf-e7e1-4063-a0ba-ed415317c200@infradead.org>
In-Reply-To: <3024abdf-e7e1-4063-a0ba-ed415317c200@infradead.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 9 Nov 2023 19:53:28 -0600
Message-ID: <CAPLW+4nKG3D2WmQxWJ=v3_J8y6vz26gLWC2NSSfu5gukgr2RGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: samsung: Fix kernel-doc comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 4:42=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 11/9/23 11:09, Sam Protsenko wrote:
> > Fix some issues found in kernel-doc comments in Samsung CCF framework.
> > It makes scripts/kernel-doc happy, which can be checked with:
> >
> >     $ find drivers/clk/samsung/ -name '*.[ch]' -exec \
> >       scripts/kernel-doc -v -none {} \;
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Fixes: ddeac8d968d4 ("clk: samsung: add infrastructure to register cpu =
clocks")
> > Fixes: 721c42a351b1 ("clk: samsung: add common clock framework helper f=
unctions for Samsung platforms")
> > Fixes: 3ff6e0d8d64d ("clk: samsung: Add support to register rate_table =
for samsung plls")
> > ---
> >  drivers/clk/samsung/clk-cpu.h | 2 +-
> >  drivers/clk/samsung/clk.h     | 9 ++++++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cp=
u.h
> > index fc9f67a3b22e..103f64193e42 100644
> > --- a/drivers/clk/samsung/clk-cpu.h
> > +++ b/drivers/clk/samsung/clk-cpu.h
> > @@ -11,7 +11,7 @@
> >  #include "clk.h"
> >
> >  /**
> > - * struct exynos_cpuclk_data: config data to setup cpu clocks.
> > + * struct exynos_cpuclk_cfg_data: config data to setup cpu clocks.
>
> Hm, OK, the ':' separator works. '-' is the documented separator here,
> but it's not worth updating the patch for that.
>

Thanks for reviewing, Randy! As you probably already noticed, I
updated ':' bits in patch #2. Just wanted to keep this one as minimal
as possible.

> >   * @prate: frequency of the primary parent clock (in KHz).
> >   * @div0: value to be programmed in the div_cpu0 register.
> >   * @div1: value to be programmed in the div_cpu1 register.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> thanks.
>
> --
> ~Randy

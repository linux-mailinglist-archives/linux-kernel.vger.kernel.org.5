Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4975380EDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbjLLNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346569AbjLLNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:42:54 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2783
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:43:00 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cece20f006so57291907b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702388580; x=1702993380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAQFb+6ron76LUgdpTUJdx32df8simBAK0E2prt6OcE=;
        b=aHPFE7nESu5i/mqtkdu6aRJrm0wAys7lpXwZq/CMQOHv1PPG8h+aGOFRxI6xlKSZtP
         FwMceeo6+RouBRWmT4KwrtfudYLJGAwEOKyJzdNHY4WrRAcFTVzvt2IzEuD8ZROTA8Wq
         Od0MUAtn0q3va7CJIcUkggMLioHzGG0lVP+Ii3/VMOnYAfi9p2cL/B9pEyVx/jySdSfV
         Dn3u47GZPYwf4HEReeIh/gwjengXjXSY04kB9BQ1V1/zGIDuGAYu3IXpCsBY7giVxA7B
         ETy52oblViDI82IKzS3gOdvLu43jzzXNs0WiH3SHednniVbM2hsulJ1x4MT59xsWcrTo
         Wl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388580; x=1702993380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAQFb+6ron76LUgdpTUJdx32df8simBAK0E2prt6OcE=;
        b=SOaMnRZj3P97S9EOx/37b1s4pbtpjEVhi94w9Na0B5jmSdbS+tNC5XGYrf+T/7wsrl
         QyCUiqRlt4ZBr+SdUIZeiQ2SOGruUKmdGvaZdahShEWR48kkefibOQXwj2gGaXMrJhd1
         vYKteTVmOCuqgoGZ0GM82+3HlZfMCo2tuQ+t6+k9MSQVCL+xegP0x7KCmDR6vuMTeSnS
         ofbAai2aPpvKqfCUFULj1wmKNUOTm7dCbqs6590XV/ilFsxy4Ozu08Hv1J4OlAbm1K95
         SvqGqcOlz+tl9oamQKpgkLzU1oJTHmxIFQCsdCYdglN1b/KXcCxk4Q3A0ciG4OWHzpWu
         pBag==
X-Gm-Message-State: AOJu0YwX3CwR/o4lel21d5ftZjrdujFseuMSNebwsD9tz6TeyG3tkXCV
        GvkUf/obxiFHRbBThI61mTtkxE/e1Oo/SaoWYWzWKw==
X-Google-Smtp-Source: AGHT+IGXI8MTlNXqp44K40z930LaIgojX2yvlOPjKoe0EJGLkACdmwfiHtJzUo62FGKni7DyMbfQiKk9Ir0r32fZwYk=
X-Received: by 2002:a05:690c:318d:b0:5df:2830:967b with SMTP id
 fd13-20020a05690c318d00b005df2830967bmr3728505ywb.54.1702388579889; Tue, 12
 Dec 2023 05:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
 <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
 <CAPDyKFpJ6_+nF8q3L4Tg1E9St3stgJ06se0t=FLHkx4_36OJNA@mail.gmail.com> <CAJZ5v0jxMjb-bUbJiHgehe5xJ6cwspvsRp5P_2N6FyvRFshJQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxMjb-bUbJiHgehe5xJ6cwspvsRp5P_2N6FyvRFshJQA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Dec 2023 14:42:23 +0100
Message-ID: <CAPDyKFobQ7dYb6SBD5tmxcK-u0w1mdQxBhY10GVNVgHj3aYNGA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 12:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 11:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Mon, 11 Dec 2023 at 21:44, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Mon, Nov 27, 2023 at 4:19=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate =
<->
> > > > level dance"), there is no longer any users of the
> > > > pm_genpd_opp_to_performance_state() API. Let's therefore drop it an=
d its
> > > > corresponding ->opp_to_performance_state() callback, which also no =
longer
> > > > has any users.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > I can take this in principle, but I'm wondering if you'd prefer to
> > > apply patches modifying domain.c yourself?  They are definitely
> > > related to the pmdomain tree.
> >
> > Yes, it makes sense for me to pick the genpd core patches through the
> > pmdomain tree. In some cases there may be overlapping patches that are
> > more generic and not only limited to genpd, but I guess we can decide
> > on a case by case basis for those ones.
> >
> > I can add the pmdomain tree to the GENERIC PM DOMAINS section in the
> > MAINTAINERS file to reflect this, if you think this is a good idea?
>
> Yes, please.
>
> What about moving drivers/base/power/domain.c to drivers/pmdomain/ ?

Yes, it seems reasonable to do that too. I will send a patch for you
to have a look at shortly.

Kind regards
Uffe

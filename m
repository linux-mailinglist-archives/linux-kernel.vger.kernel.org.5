Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1527A10E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjINWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:25:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FED26A4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:25:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8020510203so1494637276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694730331; x=1695335131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/gNWuIhIe1Nc6SpDgsggj11DNK8yHVCHmKR3bQcSxc=;
        b=t8dRqyGlIzWDJKeBTSMgUj+xE+OdHD451mg/uPRPwOWX4sxswaKSGcoJT+cM/y6cpu
         OscobweGsTDzN5itOxOSGBUx9VJVx/yXerIs35EVas+HbanI/zIX3JD09kcbCs3uLjfW
         J3Ke8Xpl2BoQRruVGc2sqgYVLpnk84jNmp2PxpyzQUJC/gNHMpkOWlt7XeuhNzQfg/8K
         kF6K7e/Y6QZ4Kg0Q785u3bJ3svjdjYloyEnXJpAyhJ2gj/3qu2M3nYqLfe0Du7odfkbo
         5xopgMwg2P+QMfja8xwqLtfIv6k3qjGI/J6QkJ9VQviVuKIAyQSuUDki7UNkaun88SNH
         fQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730331; x=1695335131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/gNWuIhIe1Nc6SpDgsggj11DNK8yHVCHmKR3bQcSxc=;
        b=hO5yeHaQkVpDypcfa62VhHeVJl85dYvh8pGh0MeaF6ARdhJfPRrom4y1TKIF1S+oEq
         H1IAQnZy8K24qwtBJG64V6KDlETfXpWBv1+UGkb5qN+ylB6YFbkmlSjmXCDloqQ4bERM
         1Pf40bRkdECrap6eUe1MyBHfDLP2K9F+Cs1p+nhVE6LWqf8nEzORE3Wff+KPvEULU6hv
         BpD+uIRRK3pmqo7eruT+f+a5pn52hK1PRdUqUsWlZT2zdWE50Ag3TghBRlpal4C3FyQb
         szelvnJYKUIRpb4fGCmXesSRlxyYFPINa5Z8vYHuV+QLnAfJ83E2AE6RH0wdmNOXmwFw
         djuA==
X-Gm-Message-State: AOJu0YwR2hjM/rByWJB9J9wZOxTLFjZYimbd4SSMklOVYZtxRaxNBe3G
        CHVQiDVo3WUazjDUg7BtVnQB+FggaLfzchwCj+2/nA==
X-Google-Smtp-Source: AGHT+IH2codyRkWyVyVK/7SIYoQivLfpdJiAKhzyG0W2FjTTDh6N6MWejeSYjyILLMgaz7vbjGcQAOjqT+nZWgrMEko=
X-Received: by 2002:a25:f41:0:b0:d80:cf06:288b with SMTP id
 62-20020a250f41000000b00d80cf06288bmr5522219ybp.65.1694730331255; Thu, 14 Sep
 2023 15:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111904.586744-1-ulf.hansson@linaro.org> <20230914-delegator-dimple-51b9414caa28@wendy>
In-Reply-To: <20230914-delegator-dimple-51b9414caa28@wendy>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 00:24:55 +0200
Message-ID: <CAPDyKFrn=poSJA2ocAYUZUBdJpPFeNBZhzOubnkPXjnJWbcPeA@mail.gmail.com>
Subject: Re: [PATCH 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 14:00, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Hey,
>
>
> On Thu, Sep 14, 2023 at 01:19:04PM +0200, Ulf Hansson wrote:
> > The Kconfig belongs closer to the corresponding implementation, hence let's
> > move it from the soc subsystem to the pmdomain subsystem.
> >
> > Cc: Walker Chen <walker.chen@starfivetech.com>
> > Cc: Conor Dooley <conor@kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for doing this, saved me having to!
> The series appears to have broken threading though, which can be seen
> pretty easily on lore:
> https://lore.kernel.org/all/20230914111904.586744-1-ulf.hansson@linaro.org/
> Dunno if something is borked with your process while sending patches to
> only a subset of the total recipient list.

Yes, I screwed up when sending. Anyway, it looks like it works for
people to review it anyway.

>
> > ---
> >  MAINTAINERS                                | 2 +-
> >  drivers/pmdomain/Kconfig                   | 1 +
> >  drivers/{soc => pmdomain}/starfive/Kconfig | 0
> >  drivers/soc/Kconfig                        | 1 -
> >  4 files changed, 2 insertions(+), 2 deletions(-)
> >  rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6b491ebcf790..b8eae18f0fb1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20523,7 +20523,7 @@ M:    Conor Dooley <conor@kernel.org>
> >  S:   Maintained
> >  T:   git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> >  F:   Documentation/devicetree/bindings/soc/starfive/
> > -F:   drivers/soc/starfive/
> > +F:   drivers/pmdomain/starfive/
>
> This isn't the correct change, just remove the drivers/soc/starfive
> bit entirely from this entry.
> I've just been doing some review & sending PRs to Arnd for this stuff
> (or failing to send the PRs as you saw), I don't have particular
> interest in this driver other than helping out the starfive people with
> actually getting the code merged.
> Instead I think you should generalise the existing entry for the driver
> to cover the whole directory, so that it includes the Kconfig bits too:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa7487b7729b..22c1a5e5b130 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20564,7 +20564,7 @@ M:      Walker Chen <walker.chen@starfivetech.com>
>  M:     Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/starfive*
> -F:     drivers/pmdomain/starfive/jh71xx-pmu.c
> +F:     drivers/pmdomain/starfive/
>  F:     include/dt-bindings/power/starfive,jh7110-pmu.h

Thanks for clarifying this. I will update (either amending when
applying or when re-submitting).

>
>  STARFIVE SOC DRIVERS
>
> Thanks,
> Conor.

I guess I consider this as an ack, assuming the above gets changed?

[...]

Kind regards
Uffe

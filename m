Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BA7A110F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjINWf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjINWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:35:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB82100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:35:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d776e1f181bso1478751276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694730949; x=1695335749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOfdC8wV94SdkfFI9yJK6AfQ92EIW46yyM5znknoWWA=;
        b=iWH+Zes1PAabuUYOOF7KN3cIeAJDVESbkX+fLMH1TTVRQCBquV7+C0LnCruNis8flt
         Hx1i/+thRTd7ipBzxh8YO7aa/n4L5QdsB/kQu22agkujyxigaAexpB1RWG+o37v0W7Oc
         JObHLyCrwB29Vwnb0FyrFskfIdLmlQ6GXBGAFdWkG7BS+JfYIvtW87yyLLdcgZhA26tp
         SNRaaOWdX1uvcP2SUUKZprjvncEuQ3b0MfRkYZZLi4EW6fz9RPZewWoBcW8XSUT3TgBE
         C9F8qVq8mGTQ0mnFjXR1Mvd5yhwUiwk4gVMGJcCe9WYNHJDhE0UPGyGcu9Qmzzik6s8m
         a+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730949; x=1695335749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOfdC8wV94SdkfFI9yJK6AfQ92EIW46yyM5znknoWWA=;
        b=NlJveJTYDNRZmPZZnWI+vaM/JkbXK/wAOjr7CmTKPvjSsta5CaVPiQO6SdNTvdECm7
         hDnNZeUxzFVru808Z2OE1MqETNrE01XrFjsIU6Xyj/9sa1Q+mRh32RXjMrh6ZaF3Nd+t
         3FfkgPYnem1lhbaTUXqdW2gHHn6GJpHXaXlU0QuV4qpzHZam9OUC7Zl+TlpNPw3r9pVH
         zmSWMCzkF1diJatODj4oeaxbggyD0y2xIvjngGihFS7bH5fsti3BR1bA5iyzRAfJpcA+
         /S4bCOO9bo9sAh94bEtOMjMFZ2CKlATLVSwHrNGHHRya2QqnkIJ/eZklvpL2unryq37s
         BpWw==
X-Gm-Message-State: AOJu0YyJ3RVtKDegcxV8k866VyAhV95VCwshIM5aoTheJr3C5JBOBr94
        gX2OX/6TR65gVRn12Y0+CJiBzFVpdMcWghy7ONxyew==
X-Google-Smtp-Source: AGHT+IFYYORUkay7OZUUV8hpvmKd3CBWn2xqwSr3h1Kz//lCK1gQvRLf0XfrZGWylaGKptPcvtoPFQRDMQ/QIjwaU9w=
X-Received: by 2002:a25:4293:0:b0:d7e:8175:4fa9 with SMTP id
 p141-20020a254293000000b00d7e81754fa9mr6560203yba.4.1694730949424; Thu, 14
 Sep 2023 15:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111554.586438-1-ulf.hansson@linaro.org> <CAMuHMdU-0i34XiQTkjkzJrG7kFX8kdSQjG57WS+sW+OLTLH4eg@mail.gmail.com>
In-Reply-To: <CAMuHMdU-0i34XiQTkjkzJrG7kFX8kdSQjG57WS+sW+OLTLH4eg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 00:35:13 +0200
Message-ID: <CAPDyKFoRYn0G0W2g4HhiVE3osmGuZHox=79J8o9bOfUe0Aq_oA@mail.gmail.com>
Subject: Re: [PATCH 01/17] pmdomain: Prepare to move Kconfig files into the
 pmdomain subsystem
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 13:59, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Thu, Sep 14, 2023 at 1:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > Rather than having the various Kconfig files for the genpd providers
> > sprinkled across subsystems, let's prepare to move them into the pmdoma=
in
> > subsystem along with the implementations.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your patch!
>
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -175,6 +175,8 @@ source "drivers/soundwire/Kconfig"
> >
> >  source "drivers/soc/Kconfig"
> >
> > +source "drivers/genpd/Kconfig"
>
> drivers/pmdomain/Kconfig

Ohh, thanks for spotting this! I certainly failed in my internal re-base. :=
-(

>
> > +
> >  source "drivers/devfreq/Kconfig"
> >
> >  source "drivers/extcon/Kconfig"
> > diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> > new file mode 100644
> > index 000000000000..c32a76b51840
> > --- /dev/null
> > +++ b/drivers/pmdomain/Kconfig
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menu "Power Domains Support"
>
> PM Domains

Yep, that is better as it has a wider meaning (it can incorporate
clock-domains and performance-domains, for example). Let me change
that, thanks!

I will follow this pattern for each of the submenus too.

>
> > +
> > +endmenu
>
> "b4 am" cannot download the full series at once.
> It looks like you didn't send it as a series, but as individual patches?

I screwed up when sending. Sorry. I will submit a new version!

Thanks for reviewing!

Kind regards
Uffe

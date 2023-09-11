Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759379A511
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjIKHxH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjIKHwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:52:50 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17CCA;
        Mon, 11 Sep 2023 00:52:45 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-49032a0ff13so1366618e0c.0;
        Mon, 11 Sep 2023 00:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418764; x=1695023564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PXs1GyVYmXtrD+FjszOVfgr8/0imMmquv9X/owM18E=;
        b=gHkAsnQmst2FEwIcMYZ2yUrp50AEYj012p5BlKuP1KNBOH65YG1uFU//rBouUKAzhx
         pQF5pHSs50/M5MFX7IKqrg7NEQm06Yobzxg2CUanNsRctISCU6fZsB8FIV9SW0Ioz4I9
         iwsFl29dgoCIWOKNfYZa8pOrrS20R9kKa3kRK4c6fW/0vqhuTcxY9vKwV0Tuq806YM9v
         E2achvO/0pCVOAaPAVpnv2/kJBstq4o3i01EM/YBwWmlNxUltv0VxG2cnGsxs58ASdrt
         8o5dTBenSB/pb0F9DxDDW5ctVacWg0LrLx8NlN0Kr+TjDa7ccwNYatsI/WqktZ9qLe9m
         8AQQ==
X-Gm-Message-State: AOJu0YzjJgsQbbEu07E0OZ1A9SfkRmi5K1ew1vawmDN+eM06WikjIAsa
        1BlMZ/URihwLax1xhrULhcv9k7lMFwzhhg==
X-Google-Smtp-Source: AGHT+IF69ZiVX2vore5hd3Ds/sTi23jlUmQh9pYmLxAifSHFlChMiURo/ZmzG9WjGjXkdk2tuQwJDw==
X-Received: by 2002:a1f:c742:0:b0:48d:d09:abb6 with SMTP id x63-20020a1fc742000000b0048d0d09abb6mr5915236vkf.6.1694418764487;
        Mon, 11 Sep 2023 00:52:44 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id f4-20020ac5c5a4000000b0048d2293695csm1378248vkl.38.2023.09.11.00.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:52:43 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-45088c95591so1923883137.3;
        Mon, 11 Sep 2023 00:52:42 -0700 (PDT)
X-Received: by 2002:a67:fdd9:0:b0:44d:40b1:926e with SMTP id
 l25-20020a67fdd9000000b0044d40b1926emr7493009vsq.18.1694418762613; Mon, 11
 Sep 2023 00:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com> <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
In-Reply-To: <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Sep 2023 09:52:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
Message-ID: <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Aug 31, 2023 at 1:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > If I may suggest something, I would call this "pmdomain" instead of
> > "genpd".  I don't think that /drivers/power/ is a particularly
> > suitable location for it, because it doesn't really have much to do
> > with power supplies and more to do with device PM.
>
> "pmdomain" is probably giving a reasonable good hint of what goes on
> in this subsystem. This works fine for me, thanks!

Sounds nice!
All of this lives in <linux/pm_domain.h> (with underscore?) anyway,
and "PM Domains" is the usual naming, as it covers both Power and
Clock Domains.

However, although I am quite familiar with genpd, I am still wondering
what is the meaning of the "generic" part in the name? And what is a
non-generic PM Domain?

> > Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
> > (and rename it to something like core.c), because it would be a better
> > location for that fiile IMO.
>
> We could certainly do that, let's discuss it a bit more.
>
> Although, at this point I want to focus on the genpd providers, as to
> release some of the burden from arm-soc maintainers.
>
> > I can also handle future pull requests for this if that's fine with everyone.
>
> Thanks a lot for your offer! However, if a re-route is preferred (I
> think not?), this is probably better suited via arm-soc, as most
> changes are going to be arm platform specific.

Which brings me to the final question: what is the upstream path
for changes to drivers/genpd/*/ (or whatever it's gonna be called)?
Before, we sent PRs to (arm-)soc.  Do you expect us to send them to
you? There's usually quite some interaction between drivers/soc/reneas/
and drivers/genpd/renesas (and there are DT binding definitions),
but not more than with e.g. drivers/clk/renesas/.

And I just realized you moved the code and Makefiles to drivers/genpd/,
but not the Kconfig symbols and logic, which still lives under
drivers/soc/.  So resolving that (and the name) is something that
should be resolved sooner rather than later...

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

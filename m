Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA19780877
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359188AbjHRJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359214AbjHRJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:30:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A93A82
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:30:48 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-589d7755213so6766717b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692351048; x=1692955848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nfu0vwx7f/9l0HHnpViH4UDqM1Qa6x/HNMicAd3ClA=;
        b=sduuefOUnGWJmHuMiQQ7wvhPfUEkMG2OTI6sXK2qHptLS4MiuOIpBc1x9//Qwpora0
         7+hJetzLL+SLu3+iSRk+gPeku0jU0eIqb0LMjuxH6WiB7HnBAYMdoT/9SeRtHChNfXjd
         5b3yKF/HT3aM2j01CO5hcaZ4Y5J7M6jBuun4KVd2ie9wrKps2ASSUdbawLXzFrvqOh1h
         DHFv7mt88fqbeXu8L2mJbAUTxJ1RcDPICI+4Y16sxZOOivQSWKT24sygQPAdN1vugS2J
         q543Wqvk6Yej2ogJ+O4HDla+qpeLt7svBpSfP95AnbUBu8a+u6BuD2/7xXIt4cB2KG13
         j1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351048; x=1692955848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nfu0vwx7f/9l0HHnpViH4UDqM1Qa6x/HNMicAd3ClA=;
        b=Aa0AlUmJKjMQ00YQk2N3XjBgj3odD/oW7M8WbNVKd35XHMyAet3RNOSsfIgb5+mbHV
         8vtWGklhHZEGeBRtmMxl9N9kthx8U5+UWbs2/gHPRr8miM4Rk7XBj3N19zM4teuiaGyn
         R+1g7BrY/MUmzeLOsY8YDH1DwVm2eqQ14oEbhNLW2KS4MZU2aB3mI1cUIS+9AlVYV+xH
         MBp6XANmrAtjKRQyM4rd+PBkwm0OiI0XH2Ik20uK3UYT58E7lrZVilU7iGoMYutQHjfo
         3+KG2SXgtgJ25dX80zEQvczbUl6zAnvTX6iZeHH30ihADjrxVbjw7YsAw3Nesoi120V3
         kelA==
X-Gm-Message-State: AOJu0YzfQZxvTENLY7BBu1Pq6SAswVFrirnTwHflCH4MTlGHW2KgO6Gs
        lUR6HiRsjoNoNTmaDyrV1Cd+mtCAMKGNtDxLya+qoA==
X-Google-Smtp-Source: AGHT+IHyH3oHZGMD78ShKoGEvqsbptaeMs7p8PNji12kOvEZbTJvEZoXUx3OLjttLtBUawBBB0ppT0fHaa1PiyA3fGg=
X-Received: by 2002:a0d:d5d4:0:b0:586:cf7:2207 with SMTP id
 x203-20020a0dd5d4000000b005860cf72207mr2115993ywd.14.1692351047867; Fri, 18
 Aug 2023 02:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
 <CAPDyKForXMxANUrvOUfEtiRsXYPJ8MbfPBdJB6zu49QfeJfS8A@mail.gmail.com>
 <630d9eff-c6b5-a019-ba27-5c18824f7b89@benettiengineering.com>
 <CAPDyKFq9VpSDuD1itDPZ0cYdRJuHvYcK=+Si-u1YkDqQhBAcQQ@mail.gmail.com> <116308f2-2133-5953-802d-6da562c81af1@benettiengineering.com>
In-Reply-To: <116308f2-2133-5953-802d-6da562c81af1@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Aug 2023 11:30:11 +0200
Message-ID: <CAPDyKFp3cEoqVc+9bvgXCHzp2nVzZ2+uFW06maLZErK9OF8CQA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 18:44, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Hello Ulf,
>
> On 16/08/23 23:36, Ulf Hansson wrote:
> > On Wed, 16 Aug 2023 at 19:14, Giulio Benetti
> > <giulio.benetti@benettiengineering.com> wrote:
> >>
> >> Hello Ulf, and All,
> >>
> >> +Cc Andrew Lunn,
> >>
> >> On 16/08/23 11:52, Ulf Hansson wrote:
> >>> On Fri, 11 Aug 2023 at 23:49, Giulio Benetti
> >>> <giulio.benetti@benettiengineering.com> wrote:
> >>>>
> >>>> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
> >>>> supplied by 3v3 the errata can be ignored. So let's check for if quirk
> >>>> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
> >>>>
> >>>> Sponsored by: Tekvox Inc.
> >>>
> >>> Didn't know we have this kind of tag. Can you point me to the
> >>> documentation of it?
> >>
> >> I've been pointed by Andew Lunn almost the same question here:
> >> https://lore.kernel.org/lkml/859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com/t/
> >>
> >> and also asked to update:
> >> Documentation/process/submitting-patches.rst
> >>
> >> I've taken inspiration by this commit:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363
> >>
> >> where there is "Sponsored by:" and not "Sponsored-by:" otherwise
> >> checkpatch.pl script complains about it.
> >>
> >> Other commits already have that sort of tag.
> >
> > Yes, but that seems silly to me.
> >
> > We should not be using tags in this way. First there needs to be an
> > agreement of what kind of tags we should allow in the commit messages,
> > before we start using them.
> >
> >>
> >> I could add Sponsored-by tag documentation and in checkpatch.pl script
> >> as well as other possible scripts where required as pointed by Andrew.
> >>
> >> I think this is a good way to give credits to companies that sponsor
> >> patches and it could be more interesting for companies in general to
> >> pay someone to upstream patches because they have their name on it.
> >> Otherwise it's not an everyday task to add a driver from scratch
> >> and write in the top comment that is sponsored by some company.
> >> Also now there is SPDX so that part would be dropped too.
> >>
> >> What do you All think about this? Do I go for a RFC patchset to add
> >> the Sponsored-by: tag?
> >
> > My opinion is just one voice here, so at this point it doesn't really
> > matter what I think.
> >
> > If *you* think this is a good idea, I encourage you to submit an RFC
> > to the kernel docs for this. In this way we can collect the comments
> > and see if people think this is a good idea.
>
> Ok, I will go with a RFC soon,
>
> > That said, do you want me to apply $subject patch without the tag or
> > would you rather proceed with submitting an RFC first?
>
> It would be great if you can apply the patch without the tag please.

Patch applied for next, thanks!

Kind regards
Uffe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1F77EBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbjHPVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjHPVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:37:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86435271D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:37:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so5429959276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692221840; x=1692826640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ejxqzA0nYjrZRnMKwnhLcgXrQ2P2LYweIT/bMyk60lY=;
        b=RrNiMXlD1Xu3g5PS6FJYi8VPQl/VyhrX9axybtGz0VMrpLdNfNj+6ruSGV2icqHgX/
         br6FCHcHZ/vmiTXaKqjdvfds90xPuC64roG3fwkPu3n0wR50fkPtJ0+oxU9j0MkI4opd
         4HCoxnxi5YKRFo4JBgX254Q+nxvLAAH3111AnEGP64T7PVC0pPONRj9ywx+KKDpUwsfI
         /cuSyBHleUTaSscQa6rBaXVkQs0fmG58lNQXz+QifxI7/4UYAl9S+RK6NEtpliLwjev/
         PGI7YKy0TALCWjLvG1DkR8h4JGObL/xLbAzmjPYbOk8soCbsyPR2FUQbN2AjJl0blI0u
         uLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221841; x=1692826641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejxqzA0nYjrZRnMKwnhLcgXrQ2P2LYweIT/bMyk60lY=;
        b=Dh2KosGmh1PoDat1exLfqbC99OXyXBUfyToJB2/k3Gm8E/h8q+5zCkholPGLyQQOfz
         QynUaK7Z41XU9r2m2xKDzIhhcADXNPX0dQjvQ9sOG3f930amq3F7s/MSlwHfBLQVLe7Z
         TBx6r1y3l2jEAA4bYgGCZUaunzwmel1/Wjrmac8/wbboh5HGUSHMFy4J3qme0Z2GBD+4
         Z3TKZmPHUOsgAjLzCpnCveD24Q+YvX9HNW+29sOscdH0J8yw5dWs0ecPfHa52XGu1B8Y
         NFuxB8yh+6F2FCynNAopWPijourJP3ywlHaa7aTBLIH3QPIvWtYGraZi48Ge9RkHdnjU
         Rm+A==
X-Gm-Message-State: AOJu0Yw1bCcFmUFqFGjCiMsOhAcebq39LQrHyp6g/ivFcSGnpKxXICnd
        zjX456hTBCi8iG66eT4qhcYZRbkYF3Ub3LvnlBBkoQ==
X-Google-Smtp-Source: AGHT+IEXIYL+AcHEeM++Dwh/la7lz/ucVonzMbgPxkaPzqH2S+PheP9EI3e24nTjFn9mp0NLcNvWyDOIKSTdWMhqmrs=
X-Received: by 2002:a25:7703:0:b0:d0d:8359:c159 with SMTP id
 s3-20020a257703000000b00d0d8359c159mr2922931ybc.45.1692221840779; Wed, 16 Aug
 2023 14:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
 <CAPDyKForXMxANUrvOUfEtiRsXYPJ8MbfPBdJB6zu49QfeJfS8A@mail.gmail.com> <630d9eff-c6b5-a019-ba27-5c18824f7b89@benettiengineering.com>
In-Reply-To: <630d9eff-c6b5-a019-ba27-5c18824f7b89@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Aug 2023 23:36:43 +0200
Message-ID: <CAPDyKFq9VpSDuD1itDPZ0cYdRJuHvYcK=+Si-u1YkDqQhBAcQQ@mail.gmail.com>
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

On Wed, 16 Aug 2023 at 19:14, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Hello Ulf, and All,
>
> +Cc Andrew Lunn,
>
> On 16/08/23 11:52, Ulf Hansson wrote:
> > On Fri, 11 Aug 2023 at 23:49, Giulio Benetti
> > <giulio.benetti@benettiengineering.com> wrote:
> >>
> >> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
> >> supplied by 3v3 the errata can be ignored. So let's check for if quirk
> >> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
> >>
> >> Sponsored by: Tekvox Inc.
> >
> > Didn't know we have this kind of tag. Can you point me to the
> > documentation of it?
>
> I've been pointed by Andew Lunn almost the same question here:
> https://lore.kernel.org/lkml/859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com/t/
>
> and also asked to update:
> Documentation/process/submitting-patches.rst
>
> I've taken inspiration by this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363
>
> where there is "Sponsored by:" and not "Sponsored-by:" otherwise
> checkpatch.pl script complains about it.
>
> Other commits already have that sort of tag.

Yes, but that seems silly to me.

We should not be using tags in this way. First there needs to be an
agreement of what kind of tags we should allow in the commit messages,
before we start using them.

>
> I could add Sponsored-by tag documentation and in checkpatch.pl script
> as well as other possible scripts where required as pointed by Andrew.
>
> I think this is a good way to give credits to companies that sponsor
> patches and it could be more interesting for companies in general to
> pay someone to upstream patches because they have their name on it.
> Otherwise it's not an everyday task to add a driver from scratch
> and write in the top comment that is sponsored by some company.
> Also now there is SPDX so that part would be dropped too.
>
> What do you All think about this? Do I go for a RFC patchset to add
> the Sponsored-by: tag?

My opinion is just one voice here, so at this point it doesn't really
matter what I think.

If *you* think this is a good idea, I encourage you to submit an RFC
to the kernel docs for this. In this way we can collect the comments
and see if people think this is a good idea.

That said, do you want me to apply $subject patch without the tag or
would you rather proceed with submitting an RFC first?

[...]

Kind regards
Uffe

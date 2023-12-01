Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E2800D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379215AbjLAOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379192AbjLAOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:43:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30610FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:43:07 -0800 (PST)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0717A40185
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701441786;
        bh=MeHPQXItxGwzbv6QpJekpb1ikFSiPcGnYtdVUGLJIS4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ix7sSaRT9L+/y6c+yakgKlxv/4xUpYPjYzUPiTEc7kQAh3h7I6lsjfF2e9DpV4mT1
         sYjXZ1i50R9rwvPvj9xaLTRl1p2XsiABNy4o1Gx0xA5doP4uhVjez3+Jp+h2D8EB2y
         hJKrGs2NbECoJISynsqunJbScqz3RiWOmqTCXEaNXFSxufatYtUjAiV4RKSdA3fmZ2
         1rqRd85SpYS6xp/dGjfVF+TR7Yz5CGzU8GfUss0HVwt6KLylUGwdkkWz+1HBZYfHWn
         R1G4z/F1p4JlJ+mLWsaIvAaOR64TWjfMZLUGF6/95aSnK4M5IgG0/D1xNcQc1Nv+Vj
         4oiDiqOzkdLfA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-423a3c5e4a3so32191551cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441785; x=1702046585;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeHPQXItxGwzbv6QpJekpb1ikFSiPcGnYtdVUGLJIS4=;
        b=EjEPmfHG3TxxjKADT9eEmG5ObH4Y7s0a0PIVEr11OzxFQnHn4Om0cglDIBKBg9qPIK
         Sjhyw6Ib0uyP8jFbSHcbrHTnqDuWceF+V7cD9CT2z8W6RVbeQli9uk9nP3EUu/qc5l6y
         cFK4qFZvbJ8LmHihSXhKpuLSgD783uGf6ltxT3iXLdD2jNGsN817d4U13HuGOOyJwpjb
         AOaHHd7dy6y96CcnC0mIGMNrToF2CyJzmH6NUB1w0VgKO0pk3FS0NLI30kCm2vDXVI3P
         vW+wKsNN08D6VVRLLO11E5DoulpUCW+REp/9+MELbDB6FMbY8ijA35yjaTJW4S822iHv
         AVpQ==
X-Gm-Message-State: AOJu0YxHUViaBdBjNJgB00U8yBJSYI0cHySr8B2oa+PiAJb6FKbTmO1P
        DLNLKa/SPJlfkUv9d4n7R8MmE/vqZiiyFLvkssRwNyqkNgsLWWaVG+MIdag2bxtHl0V3Vd84Hrf
        wKG2FDLOptJqt7D4WT4E6EmQvt9VxKrMFOTssuyAhn49/TuTmRUXrVq+Cmw==
X-Received: by 2002:a05:622a:4a0d:b0:423:9642:7824 with SMTP id fv13-20020a05622a4a0d00b0042396427824mr31391116qtb.49.1701441785054;
        Fri, 01 Dec 2023 06:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFXRhPjw2kpYgo1hB5NXDs8hUhXGv76AJm+E/K/ggJTd9UIG1Ccz103gQcgr7OxXJxSY+Iolj7RoJIV/czA/w=
X-Received: by 2002:a05:622a:4a0d:b0:423:9642:7824 with SMTP id
 fv13-20020a05622a4a0d00b0042396427824mr31391103qtb.49.1701441784835; Fri, 01
 Dec 2023 06:43:04 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 15:43:04 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
 <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
Mime-Version: 1.0
Date:   Fri, 1 Dec 2023 15:43:04 +0100
Message-ID: <CAJM55Z-yam5RnsztYFSKVGoshLFaUau=rOmArsDsZnLYm3jE+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Nam Cao <namcao@linutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Renner Berthing wrote:
> Nam Cao wrote:
> > The driver always registers pin configurations in device tree. This can
> > cause some inconvenience to users, as pin configurations in the base
> > device tree cannot be disabled in the device tree overlay, even when the
> > relevant devices are not used.
> >
> > Ignore disabled pin configuration nodes in device tree.
> >
> > Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> >  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > index 530fe340a9a1..561fd0c6b9b0 100644
> > --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > @@ -492,7 +492,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
> >
> >  	nmaps = 0;
> >  	ngroups = 0;
> > -	for_each_child_of_node(np, child) {
> > +	for_each_available_child_of_node(np, child) {
>
> Hi Nam,
>
> Is this safe to do? I mean will the children considered "available" not change
> as drivers are loaded during boot so this is racy?

I just noticed the Allwinner D1 device trees use /omit-if-no-ref/ in front of
the pin group nodes. I think all current pin group nodes (for the JH7100 at
least) are used by some peripheral, so if you're removing peripherals from the
device tree you should be removing the reference too and this scheme should
work for you.

/Emil

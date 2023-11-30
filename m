Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15847FFC80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376675AbjK3Uah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjK3Uae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:30:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A11708
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a18ebac19efso150412766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701376239; x=1701981039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ze3g+KbzqGj36cXK4KXcn2SJ1PO+nJAvkG+kKo7vKI=;
        b=jC6H/6so6qOVA6bgYqPjfJLzj+Aim0sr8Y5sFupXQetgmB2t8qhLKb0l3KtiKZ1w+H
         86COOvOmOGG8tT1IyEcl7GBcfxVNH/4YJVW6neK4m8BPuF6bGegrpAtGv0b1SD4gbea2
         sdn+aazvx3Hgm3AVZlwBYFTeyCVoigJS2XIDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376239; x=1701981039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ze3g+KbzqGj36cXK4KXcn2SJ1PO+nJAvkG+kKo7vKI=;
        b=ottzmyYwZcLdGN4nF444Jhh5uYfolmBHjhttbWoAE9fhhv5mCJXo7a7pdgPzJMTjSx
         ye9zfbAygp1pblsjyn3wLdxYWIGkuiSG9FZC29hVE/5vEqtYyd31psJZmf25q7B+zM5o
         4JSrWrM9CiTkkzhSBQeUl4+IlYSZ6rZVTl/B0vaHtXEQBYjlI9TLnWfUOYtwVFcw5JS5
         weNc0D+5Imj9Rnb2iIa9EIUAfGnPw15fKJqAiBLhkOYi3kxhk9raS54hB3JAnhoF+aa0
         5aFVaMZ0pwW5iWJhXWHKPOQ4J1lHtBGXzJd0GvJ7f1ifD4EJXOpVoLU8QqngskINMdP8
         TA3A==
X-Gm-Message-State: AOJu0Yz6UETAgsYmsGaZxPbypuQgLOJ2y5ar8A+L15lJL7sgHT9/8X6C
        HkM8YXXDPojUgBopQc6f8tqep/ZrIAeSS2SyyXLCNg==
X-Google-Smtp-Source: AGHT+IF7hBJgyxS2nGwZC6cEyBKE+/ypnjV3+LlsjScXh8z5XtFWXqn22t4Iova8UzN/R3amZDfO6UlKdgPktSBI1UI=
X-Received: by 2002:a17:906:20d7:b0:a19:a409:37e3 with SMTP id
 c23-20020a17090620d700b00a19a40937e3mr151524ejc.60.1701376238996; Thu, 30 Nov
 2023 12:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de> <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de> <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de> <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
In-Reply-To: <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 30 Nov 2023 13:30:21 -0700
Message-ID: <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 20:44, Simon Glass wrote:
> > Hi Ahmad,
> >
> > On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> On 29.11.23 20:27, Simon Glass wrote:
> >>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> On 29.11.23 20:02, Simon Glass wrote:
> >>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>>> The specification says that this is the root U-Boot compatible,
> >>>>>> which I presume to mean the top-level compatible, which makes sense to me.
> >>>>>>
> >>>>>> The code here though adds all compatible strings from the device tree though,
> >>>>>> is this intended?
> >>>>>
> >>>>> Yes, since it saves needing to read in each DT just to get the
> >>>>> compatible stringlist.
> >>>>
> >>>> The spec reads as if only one string (root) is supposed to be in the list.
> >>>> The script adds all compatibles though. This is not really useful as a bootloader
> >>>> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> >>>> with that SoC, which is most likely to be wrong. It would be better to just
> >>>> specify the top-level compatible, so the bootloader fails instead of taking
> >>>> the first DT it finds.
> >>>
> >>> We do need to have a list, since we have to support different board revs, etc.
> >>
> >> Can you give me an example? The way I see it, a bootloader with
> >> compatible "vendor,board" and a FIT with configuration with compatibles:
> >>
> >>   "vendor,board-rev-a", "vendor,board"
> >>   "vendor,board-rev-b", "vendor,board"
> >>
> >> would just result in the bootloader booting the first configuration, even if
> >> the device is actually rev-b.
> >
> > You need to find the best match, not just any match. This is
> > documented in the function comment for fit_conf_find_compat().
>
> In my above example, both configuration are equally good.
> Can you give me an example where it makes sense to have multiple
> compatibles automatically extracted from the device tree compatible?
>
> The way I see it having more than one compatible here just has
> downsides.

I don't have an example to hand, but this is the required mechanism of
FIT. This feature has been in place for many years and is used by
ChromeOS, at least.

>
> >> The configuration already has a compatible entry. What extra use is the compatible
> >> entry in the FDT node?
> >
> > It allows seeing the compatible stringlist without having to read the
> > FDT itself. I don't believe it is necessary though, so long as we are
> > scanning the configurations and not the FDT nodes.
>
> I think it's better to drop this if it has no use.

OK. I cannot think of a use for it.

Regards,
Simon

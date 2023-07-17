Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02997756B12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQR4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGQR4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E221A8;
        Mon, 17 Jul 2023 10:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0675A611C0;
        Mon, 17 Jul 2023 17:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CFAC433C9;
        Mon, 17 Jul 2023 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616600;
        bh=fzHrMGh0Yj/kJuw8RUaoA1HCHINcccP3u06P2gi9rYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ahKLL5xxLcLUhSf23OSvavdp6Z5MnYbgsu6bn/wm9LvNsVs/y0VURNIkKZeBhRoAy
         hbxRrfuK6cAsNlS0kRAzd52Pa30Pz+U43eBBk6lqHY/rUJIHDAYccBiQS4svTItxwg
         V7W8nw4ur8EmOBe29oyjAwTzPO5DbpCIcOltiPtr9zEqoMkgIj4xoZq7OL8JMOh6XV
         y4aQU/8BBFn4zGkqshRQM/f7HnG6eYWk/J2zh2SvVoHC4eAjP5IU4+HnMzYRicQQxm
         WH6AtVK7oM0+N8XWURmSpRfueogNHUtebHN6Rh7jXmXC1NDpxvOGm3hftpjSG7s1GS
         2ItQtTTN40JJg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so73505961fa.2;
        Mon, 17 Jul 2023 10:56:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLb6ZabbSvy0rql5kOVSZQz+t1RRnUh9jor1s7R72xRWYV1DTnX8
        KZQvrjgKj9tBNxCvpnaVueJGBFyDhMT9zBIx8w==
X-Google-Smtp-Source: APBJJlFzgmAiojRLT2v8l5rv7LxOyvEahELMjlKTtgtIjqiS3x3HFdu11OMXyuHQsLkCFUs8zvCwvwgi7smdnN7qfJI=
X-Received: by 2002:a05:651c:112:b0:2b9:43a7:376e with SMTP id
 a18-20020a05651c011200b002b943a7376emr1864800ljb.29.1689616598431; Mon, 17
 Jul 2023 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174021.4039807-1-robh@kernel.org> <20230717090601.GA7868@willie-the-truck>
In-Reply-To: <20230717090601.GA7868@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 11:56:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLgS_xv6N++2dVot5shWAw0Cv9StLW0OdZr_yUhAf29sQ@mail.gmail.com>
Message-ID: <CAL_JsqLgS_xv6N++2dVot5shWAw0Cv9StLW0OdZr_yUhAf29sQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Explicitly include correct DT includes
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:06=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Jul 14, 2023 at 11:40:20AM -0600, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm64/kernel/cpuidle.c | 2 --
> >  arch/arm64/kernel/pci.c     | 2 --
> >  2 files changed, 4 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> > index d1f68599c29f..f372295207fb 100644
> > --- a/arch/arm64/kernel/cpuidle.c
> > +++ b/arch/arm64/kernel/cpuidle.c
> > @@ -9,8 +9,6 @@
> >  #include <linux/acpi.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/cpu_pm.h>
> > -#include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/psci.h>
>
> I don't grok how dropping 'linux/of.h' follows from the commit message.
> Is it simply not needed by this file?

The motivation is to disentangle of_device.h includes. The fix is
making sure the explicit DT includes match what is used. The result
varies and here none of the DT headers are needed.

Rob

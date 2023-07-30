Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8694E76878A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjG3Tlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3Tlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:41:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F610CE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:41:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522462d8416so5351206a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690746094; x=1691350894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJYbyaefc/2i9vxMYh4LV8u/phkvsoN38kGEgw8r95o=;
        b=AFZwbx56sJ+a6yG9O2+3i/BtGXdUMIQCcLca48UvA9nmO+UYRzJu7cukzOJpodtxBd
         zphVbgVcbNsg3MD/PPfG5BzGlcbg9NPkXjy8JJOuyOAu9KeYjL/jXYOIpVuxQ9izWaM2
         y/YZY+exFmADoBiM577c1L6IX6jfT2Hp8oaww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746094; x=1691350894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJYbyaefc/2i9vxMYh4LV8u/phkvsoN38kGEgw8r95o=;
        b=jRC5Rb6dOouCG+Z4IhkZJ9gXbjNL0CRBe3BIrjBPkRXu2nQqs71+OfB2nyltOkHEve
         MLqDJT6OEcPaWWWXJrNmMsBeMSJptVGeVRz++rgGB2Yjh5Qg/WRPTWd5OddpOFVYruzj
         8Mc1+RgY6XJ4Jm4sAfsu3axHYPqGng4PsAV8axkVA8y2OXLaZI9ftx+5IYoF7lpGDfgQ
         Yi+26X+eS5jbB7VqdadaI6DQxdPvnmCFaXReCFF2EMEiUeasghGYqfVB6gs12lhpGY5I
         dgN4KWrpmijssMOEKrNnQ2uxj6RJtnpvD7blU8MldojkKk4n9pDs1hDr/e25i1V76u7h
         6Rhw==
X-Gm-Message-State: ABy/qLZorN9tvy6bxexV7yMIeXFsjzNk7+Su9Ie1TN4ZpezJtA/+vtjB
        9pCSdIDReZ8f+NExNT6QpC3WkuxNZat1bDddhx/8gA==
X-Google-Smtp-Source: APBJJlFqpWjzAKtpeFXYw2ZL6CzMoUFkJOPK43RW1A7yfZ3ejKc8gvCEcN7qKEjJfeWz0Hq+dmPBpg==
X-Received: by 2002:a17:906:114:b0:973:ff8d:2a46 with SMTP id 20-20020a170906011400b00973ff8d2a46mr4899448eje.3.1690746094397;
        Sun, 30 Jul 2023 12:41:34 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b009934855d8f1sm5015160ejr.34.2023.07.30.12.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 12:41:33 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so5370060a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:41:33 -0700 (PDT)
X-Received: by 2002:aa7:c795:0:b0:522:28fa:3009 with SMTP id
 n21-20020aa7c795000000b0052228fa3009mr6411013eds.13.1690746093501; Sun, 30
 Jul 2023 12:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <169073747103.4140879.6035275932676410922@leemhuis.info>
In-Reply-To: <169073747103.4140879.6035275932676410922@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Jul 2023 12:41:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2+Mcvdr3PPvUvchhZRCtLdjSFbK7S5R3N2DrEUCz6jw@mail.gmail.com>
Message-ID: <CAHk-=wj2+Mcvdr3PPvUvchhZRCtLdjSFbK7S5R3N2DrEUCz6jw@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-07-30]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 at 10:20, Regzbot (on behalf of Thorsten Leemhuis)
<regressions@leemhuis.info> wrote:
>
> One thing you might be interested in: seems the Ryzen keyboard problems
> that a9c4a912b7d ("ACPI: resource: Remove "Zen" specific match and
> quirks") [v6.5-rc1] was supposed to fix once and for all kinda came
> back, as the new approach apparently still doesn't work on all machines:

Gaah.

We must be doing something fundamentally wrong in the irq overrides,
this is ridiculous. One step forwards, two steps back.

Right now all our entries in that override table say "don't override".

In fact, right now they all seem to be about the legacy keyboard irq.
I get the feeling that we are just doing something horribly horribly
wrong wrt the override thing, and that all these quirks come from
that.

I get the feeling that maybe we simply should strive to use the values
the BIOS has _programmed_, not the DSDT or MADT values at all? After
all, the BIOS has presumably set things up so that the keyboard works,
so us taking values from the BIOS tables (which are clearly
unreliable) is a bit suspect.

IOW, maybe we should simply never touch the irq setup for irq 1?

Does anybody have any idea what MS does?

             Linus

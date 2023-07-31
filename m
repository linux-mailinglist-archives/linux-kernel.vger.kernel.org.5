Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB58768F32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGaHuv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 03:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGaHut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:50:49 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0E130
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:50:48 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bc9353be9bso225742a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789848; x=1691394648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySla+zh7bXS0zJ6BSwtEo7bdPw6DFhOQygjTzRggs40=;
        b=cMTFSIfJ6keKrMY9D0g43ZmBRZuTXTTh6mGhJAyAsV2DqoAUcC+VlOFablhvfbZtY4
         aQ0gTeCPtOtVFSoK6AsqlhCEKkDfQC45YdU17jRIcbSaD7ppfSHKiKQFr/dxY4wzq5nR
         5iSSOcnpHR3z3rGjBAicA6HLNNKZiKaWdqs7cTC/la9ewxJYXV64BbNp6+mxBbsmNvB3
         Sa9E0YY+RgtyoL3zwd9d+mv6JIGZIZB3v7Zm4FQkM2HLt4QZdbjaXBa5wT3/y+VMwmpS
         4uJcPU4A3N42WiHoAfyM/IvfcNK9uOw8VUPxc+a9migfkF3xaiWMlrKgQlP7CqKz5eda
         x9hA==
X-Gm-Message-State: ABy/qLbYHlncsIYKXnieEYsdYkwhW586j2xSvi+++9ki2OSR046fsS1R
        NU48HTX1xrIzkhtexVNbB/hSmYEDkr9FHtHA2J8=
X-Google-Smtp-Source: APBJJlE4RlR9kO3u1/JKVXVYALa3WgiPCHVyTOtSlIeq7joQCyK76VuSXgvDaDrkO9owaBUmSm3qWJoFtAvy6yhnVgE=
X-Received: by 2002:a05:6830:6b04:b0:6b8:b83c:a23c with SMTP id
 db4-20020a0568306b0400b006b8b83ca23cmr6286487otb.3.1690789847941; Mon, 31 Jul
 2023 00:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <169073747103.4140879.6035275932676410922@leemhuis.info> <CAHk-=wj2+Mcvdr3PPvUvchhZRCtLdjSFbK7S5R3N2DrEUCz6jw@mail.gmail.com>
In-Reply-To: <CAHk-=wj2+Mcvdr3PPvUvchhZRCtLdjSFbK7S5R3N2DrEUCz6jw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 09:50:32 +0200
Message-ID: <CAJZ5v0jZ0YHfnxJ7BTEFAZHb+0NO9YAoQ9hypZ66cqpcJsmXYQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-07-30]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 9:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 30 Jul 2023 at 10:20, Regzbot (on behalf of Thorsten Leemhuis)
> <regressions@leemhuis.info> wrote:
> >
> > One thing you might be interested in: seems the Ryzen keyboard problems
> > that a9c4a912b7d ("ACPI: resource: Remove "Zen" specific match and
> > quirks") [v6.5-rc1] was supposed to fix once and for all kinda came
> > back, as the new approach apparently still doesn't work on all machines:
>
> Gaah.
>
> We must be doing something fundamentally wrong in the irq overrides,
> this is ridiculous. One step forwards, two steps back.
>
> Right now all our entries in that override table say "don't override".
>
> In fact, right now they all seem to be about the legacy keyboard irq.
> I get the feeling that we are just doing something horribly horribly
> wrong wrt the override thing, and that all these quirks come from
> that.
>
> I get the feeling that maybe we simply should strive to use the values
> the BIOS has _programmed_, not the DSDT or MADT values at all?

I'm not sure why we don't do that, it all has started way in the past.

> After all, the BIOS has presumably set things up so that the keyboard works,
> so us taking values from the BIOS tables (which are clearly
> unreliable) is a bit suspect.

Yeah, fair enough.

> IOW, maybe we should simply never touch the irq setup for irq 1?
>
> Does anybody have any idea what MS does?

I've never got a coherent answer to this question TBH.  Let me ask
around and see what I can find.

Cheers,
Rafael

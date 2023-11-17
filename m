Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC877EFC35
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbjKQXne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKQXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:43:33 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9AFD7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:43:29 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso870957241.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700264609; x=1700869409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1NsfHVE0Rs4ohooYR+8BLZuke8eixnzhlqm2hdvcxE=;
        b=2JGkE38tL9tv2Ry3f1VtdhShOqff8xHwSkFZ8ZUfKrUZHtyNkAbZNghK0BADOrz8Hj
         vtWGlw+AtRprl/3fpJ4vHGQoYajHuw9/mTmV/4nULkEjuf3Oda5fbfhK9v9K0T9UsRqD
         mnyVu1d/1S32suIZFt3R/CIbOCZYSiQM1yAui5Zxf4SbM+Q71Mn0TxvbwzN44CTwsG8U
         WCoHjHVaNmmuLldEmSs/jCPazPqYOZfOiTvPXeYdqIxcPkhhmzhBCuRQYfglXt8+Hr6p
         rnuubfRzW7+GbKzO22Q+prdi44N28gCyPudJxqCRuhdQpejaQZ0vJ2euy88bdwIYqXUA
         aL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700264609; x=1700869409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1NsfHVE0Rs4ohooYR+8BLZuke8eixnzhlqm2hdvcxE=;
        b=PMkHJsRjn+j5joNKaq2mlpVks+gBsdAeneefDyaJoQoSOewLskSHKbJhc8qpLxjnez
         PigdpFsPIdcqlTZRohzwqB1xrRlIIPdACOA66sxqDQeBaQq6RErwXoYzxfm2PG3Fxnjc
         XcKX+tjn+29vaYuLr7hyRNOIAuARnmt59sSYDR1T3VPR4cbqpdusd6qkEQUdhzqMkGbZ
         Kg84MGtbQojYvUCbLJapiQpFd6+pgYeGhVZheEXJEKgZi3KU2SUm9mOoOVP247+rl9ct
         SUGczqN8AtcEfcL/cMPlMNWNVk6WCSge+5bcPe+WSoxSexDsOa8IrJdZMpUbkqFQLjis
         T3Jw==
X-Gm-Message-State: AOJu0YxikMWOesSZSIxAtgj3vDLGQTuzC+xJdS3pjk5efd3FCWxkuILi
        kaVFNaC33xsULy7pHUEHcWD72sfhQGfAr2SHKOnbmBzOd7NHEATAAwsW7A==
X-Google-Smtp-Source: AGHT+IGsqH+g23NOuftKZQaJNB6FfaihsCTnH4slf6umspoonCke6N4LfYHlgOLJNv+d2Gp+Ls+hxPht5cpbCXm4f4Y=
X-Received: by 2002:a05:6102:34e2:b0:457:cc6c:9491 with SMTP id
 bi2-20020a05610234e200b00457cc6c9491mr961954vsb.17.1700264608786; Fri, 17 Nov
 2023 15:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com> <20231113223819fb469198@mail.local>
 <ZVM4nFaDTwrKMr8K@duo.ucw.cz> <2023111422283827b2a3f2@mail.local>
 <5029e355-6fe8-4d48-9bc3-20256adfbdb7@amd.com> <2023111722570552652970@mail.local>
In-Reply-To: <2023111722570552652970@mail.local>
From:   Raul Rangel <rrangel@google.com>
Date:   Fri, 17 Nov 2023 16:43:15 -0700
Message-ID: <CAHQZ30AkayKxQkLajaY6gcFbGMWb=wu3Nqxzed5yFjLo8bX4hQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Mark Hasemeyer <markhas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 3:57=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 14/11/2023 18:15:02-0600, Mario Limonciello wrote:
> > On 11/14/2023 16:28, Alexandre Belloni wrote:
> > > On 14/11/2023 10:06:36+0100, Pavel Machek wrote:
> > > > On Mon 2023-11-13 23:38:19, Alexandre Belloni wrote:
> > > > > On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
> > > > > > Now that the merge window is over, can this be picked up?
> > > > > >
> > > > >
> > > > > I'd be happy to invoice AMD so they get a quick response time.
> > > >
> > > > That is a really bad joke.
> > >
> > > Why would it be a joke?
> > >
> > >  From what I get this is an issue since 2021, I don't get how this is=
 so
> > > urgent that I get a ping less than 24h after the end of the merge
> > > window.
> >
> > It's possibly longer; but I don't have a large enough sample to say tha=
t
> > it's safe that far back.
>
> Would this help this one:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D68331


Honestly, the HPET_EMULATE_RTC code is what drove me to switch the AMD
chromebooks over to using the ACPI timer:
https://chromium-review.googlesource.com/c/chromiumos/overlays/board-overla=
ys/+/2355073.

Ideally if the HPET was configured with proper IRQs by the firmware,
the kernel wouldn't enable the HPET legacy emulation bit. The HPET
spec defines that when the legacy replacement option bit is set, the
HPET takes control of the RTC (#8) and timer (#2) interrupts. Why it
takes over the RTC interrupt I've never understood. The HPET is not an
RTC, so it results in software having to emulate it which results in
extra complexity. If the kernel didn't set the HPET legacy emulation
bit when the HPET declared proper IRQs, then the RTC wake interrupt
would keep working as expected. I guess there's not much benefit to
fixing this anymore, now that this ACPI timer patch has landed. If a
platform were to release new firmware to define proper HPET IRQs, the
date would bump, and it would fall into the ACPI path.

>
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

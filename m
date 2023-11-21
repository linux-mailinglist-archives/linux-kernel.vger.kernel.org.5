Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117147F330C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjKUQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjKUQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:01:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001A19A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:01:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce5e76912aso35845825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1700582508; x=1701187308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94uiKCc8mVHzfD5hMHo+ipsMG0R6MKAPs1S03wUwkTY=;
        b=F3kLBalVg0ZTxwyzHv2jZBM3n0dBSB+bkjtFCFupnk+2GBG8uvUvZV38H+Z0lbA9P4
         VW04jdNhDTtd2P8J9U87vB8841OxMNv+PUYed2oOfItJqQ2yUWZWmH3yLyY984YvsUZ4
         rCdzFc/4CoI6ZdhUjJBQPoVJWtJb2JRcog57MhdSUgAeiK+dsXUUWju7cG/F/1uXUz6s
         d7CKHHjb+fCbBDmcAqnK/uy/d/rYNGKDhLzzvD+davd/PiJC27rzAbnT2NwRzWR94i6h
         /v6lUOscYWVzWG5HYYNcgNlAB/6nEKcWSP5NVnf0pwa8U48Op3AsYJPdyal+F+GNSphm
         CLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582508; x=1701187308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94uiKCc8mVHzfD5hMHo+ipsMG0R6MKAPs1S03wUwkTY=;
        b=CoGbJSZTuWfuqngFtzQkeoJ4X7CYg9few2+1SorHsOq8EvYsKvoFJ4ZKMmg5TwvQ7e
         avEI4zGKa5oyegtE2slphm9U2NLU+es5CviRAhstpoqQgoH2XWtiFvgiqfVhFpKqyCLQ
         SmYNPO4Ucg6PSL8XzzlRKIrqcd85WkEbRldLKi8mwXn3MPwJDumN8P8QXqa27pr6IeR3
         B5S+MtSWaM/QLCJNBqK2WwE4gIwy7dZTNPBFjzVl/G3a4EfRygAoslVtGoFxo+nv4eii
         CxRgWeFh8sk2X6N0wDbyWKa3bq7rXiu+dpomPyjOUUc3gf/ooL69/CEhdN7lKB+FLKHC
         MgJw==
X-Gm-Message-State: AOJu0YwbHMijh7hx+hry7tdKqN3+NJB/POlXJk8/x9E2Ew+JGxZnVqLK
        Cx9IMdC98cpShJmJ3Q/XU2YKKQAEErQSTvd17iWifQ==
X-Google-Smtp-Source: AGHT+IFr6SofnB98KDklqVgcIdirU+mIhOxh+1ZfP/9TavcPxVQ3b7d+I75tL/HOikpoDFRayVr+Lz2I1ZPSTX8a/Bs=
X-Received: by 2002:a17:902:e5ca:b0:1cf:6373:b8a5 with SMTP id
 u10-20020a170902e5ca00b001cf6373b8a5mr6074879plf.25.1700582508194; Tue, 21
 Nov 2023 08:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com> <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com> <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
 <20231117121531.GC137434@google.com> <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
 <20231121153302.GD173820@google.com>
In-Reply-To: <20231121153302.GD173820@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 21 Nov 2023 21:31:37 +0530
Message-ID: <CABqG17hufcNS5-wLEEpZniSE2MAfEeN9Ljhs5MPGeu-2xZP+HQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for your insights. I appreciate your guidance on the matter.
Yes will rewrite the change as below:

        regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
        if (!regmap)
                return -ENODEV;

I believe this modification aligns with your suggestion. Please let me
know if this meets the requirements or if you have any further
suggestions or adjustments

Regards,
Naresh


On Tue, 21 Nov 2023 at 21:03, Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 20 Nov 2023, Naresh Solanki wrote:
>
> > Hi
> >
> > On Fri, 17 Nov 2023 at 17:45, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Thu, 09 Nov 2023, Naresh Solanki wrote:
> > >
> > > > Hey Lee,
> > > >
> > > > Is there anything specific you'd suggest changing in the current
> > > > patchset, or are we good to proceed?
> > >
> > > What do you mean by proceed?
> > >
> > > You are good to make changes and submit a subsequent version.
> > >
> > > Not entirely sure what you're asking.
> >
> > As a follow up on previous discussion regarding use of DEFER on probe
> > if regmap isn't initialized, the implementation was based on other simi=
lar
> > drivers & hence it was retained although its not needed due to dependen=
cies.
> >
> > I'm not entirely sure to keep the regmap check or make another
> > patch revision with regmap check removed ?
>
> You tell me.
>
> You should understand the device you're attempting to support along with
> the code you're authoring and its subsequent implications.  If you don't
> know what a section of code does or whether/why it's required, why did
> you write it?
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

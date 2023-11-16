Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92BC7EDF03
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjKPK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbjKPK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:57:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550809A;
        Thu, 16 Nov 2023 02:57:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso993003a12.2;
        Thu, 16 Nov 2023 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700132264; x=1700737064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Alq2NnZvkG1wKEvu5ji7SOJ948PkV/pj0sqQJJs20=;
        b=Mw/Q2zkHij8kdGaZk3qSktYRUVW5vQRFGN374N1BPCnhXQ6e3OEVZuM6uRFoImVITY
         lIwYCVxhY63ITOgUq4JT4SOXxHmvXXfOpcTA0sjzMN30PuC+WhSEzHBADFmYR5aGhkGJ
         4jslfVvbroBEEHyOXzUsBB1WkPEJfONHWx4eHND8B6xQg1Q3hdOQYZnxNSuP/W9Z1dpj
         PJihOrhY22qptFV8Y3Ru8TW2H9BoPQiN++W1wn8xDuJnji1d0hz4A8gQHShorJv9n0+K
         K02j3At5ys03GBL/Y0IqAv6Ur9LOQtaZiQjUcdutXfylarJgXYrx4NFgp2RVHWJKIZtR
         09hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132264; x=1700737064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0Alq2NnZvkG1wKEvu5ji7SOJ948PkV/pj0sqQJJs20=;
        b=NiA8kSMk0QGWkYeISFwkf7vHQSlfPvzlr32m95DML6sq199wUBwRmBxeLe3H0fvcOO
         F5ZKCLP9yO9Kq3HAQtvE3Xr4+xlOnxiexZMgIldmKQ9YP3vNFoZFuorLxnnqMX07/hVj
         5d+zsrtGZMS9lMtUd4XkRzV1cie3NnayM0kD7Sf2GAxW2m22ZU4c5xUzH+V2bKe5i7of
         yz3KzKB51HrkZnWUT39lKPJTeqmH5jw82uB9+n738OCMm7+wIWZduCry0G4vuk60JXu5
         VeD4SDhQDC0V9RE05kP04ZEjE/fyd+gXnM5vboW3evqy7j+FMPyoTb38IH6Y9PrxruLd
         y8Hg==
X-Gm-Message-State: AOJu0YwfgArfP0YCsURxB4X0XS2GU8qfIH0Gr8IcTVopy0vwB7h9IsXt
        PodwnjaSXGFyj8fHu7ObinDcRs0uh217gBows98=
X-Google-Smtp-Source: AGHT+IEMyccX384cGXsYncIxNvNPWdps8uNibi1oGYh6tKgDwE4EswQCIBmJhnNXhS3SZ/wXaYBunJmToyOvaJ1n0O4=
X-Received: by 2002:aa7:dd56:0:b0:53e:7781:2279 with SMTP id
 o22-20020aa7dd56000000b0053e77812279mr11735675edw.36.1700132264420; Thu, 16
 Nov 2023 02:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231115195947.GD29486@pendragon.ideasonboard.com> <58fe01b9-5fb6-451c-a759-c6a5afd695e3@gmx.net>
 <20231116005030.GA21041@pendragon.ideasonboard.com> <45c0e7bbb2ed91ec559cdbf2d19ad80e@suse.de>
In-Reply-To: <45c0e7bbb2ed91ec559cdbf2d19ad80e@suse.de>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Thu, 16 Nov 2023 10:57:32 +0000
Message-ID: <CALeDE9PuquwZs3ou_RksH41LCYgVtMmQt6KbK7CnBq5S8_yp6g@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] staging: vc04_services: bcm2835-isp support
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Guillaume GARDET <guillaume.gardet@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> > On Thu, Nov 09, 2023 at 04:02:52PM -0500, Umang Jain wrote:
> >> >> This series aims to upport bcm2835-isp from the RPi kernel.
> >> >> It is developed on top of staging-next which comprises many
> >> >> VC04 changes for it's de-staging. Hence, the merge of this
> >> >> driver is targeted when VC04 is de-staged completely (which I
> >> >> have been pushing), but it can be helped getting reviewed meanwhile.
> >> >> Hence, the reason for posting the series.
> >> >
> >> > Related question, what do people think about dropping the legacy
> >> > firmware-based bcm2385-camera driver once this gets merged ?
> >> > firmware-based camera operation is deprecated by Raspberry Pi, and
> >> > doesn't work on the Pi 5
> >>
> >> i don't remember exactly, but wasn't the bcm2835-camera required for
> >> Pi
> >> Camera V1.3?
> >
> > If I'm not mistaken (Dave can correct me), the legacy camera stack
> > works
> > only with the Raspberry Pi official camera v1, v2 and HQ modules.
> > Raspberry Pi has switched to a new camera stack based on libcamera,
> > which works on the Pi Zero 2, Pi 3, Pi 4 and Pi 5. This new stack
> > supports the same camera modules as the legacy stack, and many more.
> > The
> > legacy stack doesn't work on Pi 5 at all.
> >
> >> At the end cannot speak for the users. AFAIK OpenSuSE and Fedora use
> >> the
> >> driver.
>
> Guillaume (in CC) is more authoritative about this topic, but as long we
> have
> smooth migration plan I am more than happy to switch to proper camera
> driver.

From a Fedora PoV I am more than happy to move to the new libcamera
based stack for the RPi camera, IMO sooner the better :)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7566E80515E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345058AbjLEK5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLEK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:56:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1B129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:57:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d04d286bc0so23036545ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701773825; x=1702378625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOCSh/LCoaA8lYJyJFRuUh0JrG5S2z7mjuSffy1Xhtw=;
        b=al540q0fIwVn2IEeHC5J4rKUhmXqsBoDe/K2/DXzqgcm1oPkE23io97OtkJ4bxza0C
         2bZdzsn36ibRyHeubEY1j980San8jbMtrRPWB1bw5MMD6eIXtvsm16Th60TywKUucMEO
         FeuZp1IJsxWtoQ9lpFnJqWMKfps8eQHq0E7m6INCTF4EEEGP+jE2ihzQhWLpJsGMw2yc
         YVmvMpqE+u/FXuZ5tUOIXBwr72ApVJBnVOVUXLv0X2l3D6iGf7ncEm32Z7M8z9oMhSXQ
         S4JNERcDNsvo5sMzcuNMMgwFIcryxU4MK8+Pus+wdCpsW/UdvIsJx/JEVjwvHo/HTtnS
         vmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773825; x=1702378625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOCSh/LCoaA8lYJyJFRuUh0JrG5S2z7mjuSffy1Xhtw=;
        b=nS/t15wZBR7YwdDkx1hXWKAqa9gc8QGrNiBDnCNw67GipAk1D28Rb6d4iqKqQEvTNR
         AE0OUdOC/490Sm0JNKMlfw8Y5eEpHnxmF1pnrJyulE+p19iL8UXKB4j7J1orI84Q8xGo
         gQME/fNSSUN5cToGa+MIuvRQOKsXTJiFaY0XcyoFttJjNIjn6BDeUs3jx+5L2r8jV1Nu
         G+kF3EFmI/kh6+TmkeP4b88dxhPCRkGcJ1P6qByBs3yPy6hFJo7KjzVWF1HUppbOntCS
         OYcNvrWbz4p4Dl1fqUi4EQ4yW1VAGVKiEktC6Kw2mxCBsh0PG0oz8cSHf6nj4hKHHnw3
         mGxA==
X-Gm-Message-State: AOJu0YylzenaBY9SDIfLn1p1+fN1qKHGClRmENZGFo6UrQjixmcPgZhp
        ePgAgafYqjN1UdnqC3LpWRCqPr6NhiQDDYDTfo6DAQ==
X-Google-Smtp-Source: AGHT+IESzb/DsM6HNEwQey6SQLJA6wiJHSlxS0+SQRXNXTRtW/iWthIYPjgjzra5dEcx06ncMTr8kjYgjM4GYhFPKgM=
X-Received: by 2002:a17:90a:fb50:b0:285:80d5:6e51 with SMTP id
 iq16-20020a17090afb5000b0028580d56e51mr771522pjb.21.1701773825023; Tue, 05
 Dec 2023 02:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20231128140718.3866978-1-naresh.solanki@9elements.com> <e0953578-1c61-4461-af07-8cf1e3d1837e@sirena.org.uk>
In-Reply-To: <e0953578-1c61-4461-af07-8cf1e3d1837e@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 5 Dec 2023 16:26:55 +0530
Message-ID: <CABqG17j8bA1edpr8nzceqis=XjctmhCh+M9qWFXr-H59QK0emg@mail.gmail.com>
Subject: Re: [PATCH v3] regulator: event: Add regulator netlink event support
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 5 Dec 2023 at 04:54, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 28, 2023 at 02:07:16PM +0000, Naresh Solanki wrote:
> > This commit introduces netlink event support to the regulator subsystem.
> >
> > Changes:
> > - Introduce event.c and regnl.h for netlink event handling.
> > - Implement reg_generate_netlink_event to broadcast regulator events.
> > - Update Makefile to include the new event.c file.
>
> This looks good however it breaks an allmodconfig build:
>
>    ERROR: modpost: missing MODULE_LICENSE() in drivers/regulator/event.o
>
> > +config REGULATOR_NETLINK_EVENTS
> > +     tristate "Enable support for receiving regulator events via netlink"
> > +     depends on NET
>
> I think this needs to be a bool (NET is a bool so there's no dependency
> issues there hopefully).
Thanks for pointing this out. I missed testing build with allmodconfig.
As suggested, after updating Kconfig from tristate to bool this
issue got resolved.

Will push v4  with the fix.

Regards,
Naresh

>
> Thanks for pushing this forwards.

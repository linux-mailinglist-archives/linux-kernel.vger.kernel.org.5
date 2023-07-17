Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6957563CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQNF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGQNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:05:57 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187694
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:05:56 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b73261babdso12602751fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689599155; x=1692191155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEdgyMnesLi7/1zcrDsJDIaGTrPN9cLI4ZevYO3fOfo=;
        b=Mvir+Wd+uX9pNt/FYuWJ2tTybIkHCOgEVYjfCnDMGWeeCEDIVCW8aKjfKhH00hPf0x
         VMltkhVgktc/+lICQQeOa7bVcKK3ynF3lYqCW1TnNZ7AMjFEprtgXg6Z0/Zw7IpYeZO2
         jMefbAIFcub1pBpfhXC0LcAovdO2dDg72YP7kMvn7ox7sPICum1pYY8xa23H6HLMXTV/
         mEQh0a4jmJfARCvHISNxeOB412ascvUzuJ2X+iL2hXUp3XDu3FVyEs47tPu6OIv3pZrm
         pha2lqGapWYDsTLdktwblVaVBc4IFW8t/rH7ZTjykZ2gdIGS8Pnqr3Psl62FUUd9psda
         jlMg==
X-Gm-Message-State: ABy/qLbru6VjmCp1om+x8YOFqoglZXmAvTVLDYsc5zDKtI1/9y9nWsn5
        4llrUljBPDCmkG5RTTylYLBVEGhDgzO9F7opOZ0=
X-Google-Smtp-Source: APBJJlGl8p21d/I23gKed4Ktb8dSbN9Wu8ZEFXfW60DR8tVoVVxdAHa9IakOAuEfF+ocP+jp64OWv7L2zCJNs52eC5U=
X-Received: by 2002:a2e:a98c:0:b0:2b7:3f71:b98d with SMTP id
 x12-20020a2ea98c000000b002b73f71b98dmr4264830ljq.0.1689599154819; Mon, 17 Jul
 2023 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230418064200.24303-1-jirislaby@kernel.org> <0debbf68-ef69-2d1b-42d1-376c05186cbe@kernel.org>
In-Reply-To: <0debbf68-ef69-2d1b-42d1-376c05186cbe@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jul 2023 15:05:39 +0200
Message-ID: <CAJZ5v0g0Vso0JMCtPBTmka_z3aRH=HocambkV6_XKnKAWueucQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Add backlight=native DMI quirk for Lenovo
 Ideapad Z470
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:20 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> this has been likely lost.

Yes, it has, sorry about that.

It's better to CC ACPI-related patches to linux-acpi@vger.kernel.org,
so they are included in my normal flow, to avoid such events.

> Should I resend?

No need, I've just applied it as 6.6 material.

Thanks!
